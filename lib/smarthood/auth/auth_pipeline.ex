defmodule Smarthood.Guardian.AuthPipeline.Browser do
  use Guardian.Plug.Pipeline, otp_app: :smarthood,
                              module: Smarthood.Guardian,
                              error_handler: Smarthood.Auth.ErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.LoadResource, ensure: true, allow_blank: true
end

defmodule Smarthood.Guardian.AuthPipeline.JSON do
  use Guardian.Plug.Pipeline, otp_app: :smarthood,
                              module: Smarthood.Guardian,
                              error_handler: Smarthood.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.LoadResource, allow_blank: true
end

defmodule Smarthood.Guardian.AuthPipeline.Authenticate do
  use Guardian.Plug.Pipeline, otp_app: :smarthood,
                              module: Smarthood.Guardian,
                              error_handler: Smarthood.Auth.ErrorHandler

  plug Guardian.Plug.EnsureAuthenticated
end



# defmodule Smarthood.Guardian.AuthPipeline do
#   @claims %{typ: "access"}

#   use Guardian.Plug.Pipeline, otp_app: :my_app,
#                               module: Smarthood.Guardian,
#                               error_handler: Smarthood.Guardian.AuthErrorHandler

#   plug Guardian.Plug.VerifySession, claims: @claims
#   plug Guardian.Plug.VerifyHeader, claims: @claims, realm: "Bearer"
#   plug Guardian.Plug.EnsureAuthenticated
#   plug Guardian.Plug.LoadResource, ensure: true
# end