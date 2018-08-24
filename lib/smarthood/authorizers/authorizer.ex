defmodule Smarthood.Plugs.Authorizer do
	use SmarthoodWeb, :controller
  require IEx

  def unauthorized_user(conn) do
    [url] = get_req_header(conn, "referer")
    key = "x-pjax-url"
   # conn = delete_req_header(conn, "x-pjax")
  #  conn = delete_req_header(conn, "x-pjax-container")

    conn = conn
      |> put_resp_header(key, url)
      |> put_flash(:error, "You do not have permission for this request")

      if Enum.count(get_req_header(conn, "x-pjax")) > 0 do
        url_list = String.split(current_url(conn), "?")
        url = hd(url_list)
        conn = put_new_layout(conn, {PageView, "blank.html"})
        conn = put_view(conn, SmarthoodWeb.PageView)
        conn = render(conn, "redirect.html", current_url: url)
      else
        conn = redirect(conn, external: url)
      end
     # |> put_status(403)
     # |> redirect(external: url)
      halt(conn)
      
      #  |> send_resp(403, "You do not have permission for this request")
      #  |> render(SmarthoodWeb.ErrorView, :"403")
      #  |> redirect(to: "/")
          
        # conn
        #   |> put_flash(:error, "You do not have permission for this request")
        #   |> redirect(to: "/organizations")
        #   |> halt()
  #   env = Application.get_env(:smarthood, :env)
  #   host = case env do
  #     :dev -> "http://localhost:4000"
  #     :prod -> "https://smarthood-daily.herokuapp.com"
  #   end
  #   url = String.trim(url, host)
  #       conn
  #         |> put_flash(:error, "You do not have permission for this request")
  #         |> redirect(to: url)
  #         |> halt()
   end

end