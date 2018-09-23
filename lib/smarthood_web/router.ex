defmodule SmarthoodWeb.Router do
  use SmarthoodWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(Pjax.Plugs.Pjax)
  end

  # pipeline :browser_auth do
  #   plug Guardian.Plug.VerifySession
  #   plug Guardian.Plug.EnsureAuthenticated, handler: Smarthood.AuthErrorHandler
  #   plug Guardian.Plug.LoadResource, allow_blank: true
  #   plug Smarthood.CurrentUser
  # end

  # pipeline :api do
  #   plug :accepts, ["json"]
  # end
  pipeline :browser_session do
    plug(Smarthood.Guardian.AuthPipeline.Browser)
    plug(Smarthood.Auth.CurrentUser)
  end

  pipeline :login_required do
    plug(Smarthood.Guardian.AuthPipeline.Authenticate)
  end

  # pipeline :authorize_admin do
  #   plug Smarthood.Guardian.AuthPipeline.Authenticate
  #   plug Smarthood.Auth.Authorize, :admin
  # end

  pipeline :api do
    plug(:accepts, ["json"])
    plug(Smarthood.Guardian.AuthPipeline.JSON)
  end

  scope "/auth", SmarthoodWeb do
    pipe_through([:browser, :browser_session])

    get("/:provider", AuthController, :new)
    get("/:provider/callback", AuthController, :callback)
    post("/identity/callback", AuthController, :identity_callback)
    delete("/delete", AuthController, :delete)
  end

  scope "/", SmarthoodWeb do
    pipe_through([:browser, :browser_session])

    resources("/users", UserController, only: [:new, :create])
  end

  scope "/", SmarthoodWeb do
    # Use the default browser stack
    pipe_through([:browser, :browser_session, :login_required])

    get("/", PageController, :index)
    resources("/users", UserController, except: [:new, :create])
    resources("/roles", RoleController)

    # resources "/organizations", OrganizationController do
    resources "/organizations", OrganizationController do
      resources("/domains", DomainController)
      resources("/work_status_types", WorkStatusTypeController)
      resources("/spreadsheets", SpreadsheetController)
      resources("/to_dos", ToDoController)
    end
    
    resources "/communities", CommunityController do
      resources("/users", UserController, only: [:join]) do
        get("/join", UserController, :add_user_to_community, as: :join)
        get("/unjoin", UserController, :remove_user_from_community, as: :unjoin)
      end
    end
    resources "/sites", SiteController do
      resources "/houses", HouseController
    end
    
    resources "/houses", HouseController

    resources "/to_dos", ToDoController, only: [], as: :to_do do
      resources("/to_do_users", ToDoUserController, as: :users)
    end

    resources "/teams", TeamController do
      get("/add_users", TeamController, :add_users, as: :add_users)
      get("/remove_users", TeamController, :remove_users, as: :remove_users)
      get("/set_as_moderator", TeamController, :set_as_moderator, as: :set_as_moderator)
      get("/set_as_member", TeamController, :set_as_member, as: :set_as_member)
    end

    post("/photos/upload", PhotoController, :upload)

    resources "/work_statuses", WorkStatusController do
      resources("/key_result_areas", KeyResultAreaController)
      resources("/comments", CommentController)
    end

    get("/team_work_statuses", WorkStatusController, :team_work_statuses, as: :team_work_statuses)
    resources("/tasks", TaskController)

    get(
      "/export_to_do_to_tasks",
      TaskController,
      :export_to_do_to_tasks,
      as: :export_to_do_to_tasks
    )

    get("/team_to_dos", ToDoController, :team_to_dos, as: :team_to_dos)
  end

  # Other scopes may use custom stacks.
  # scope "/api", SmarthoodWeb do
  #   pipe_through :api
  # end
end
