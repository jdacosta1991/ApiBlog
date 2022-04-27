module Secured
  def authenticate_user!
    # Bearer xxxxxxxxxxx
    token_regex = /Bearer (\w+)/
    # Leer HEADER de autenticacion
    headers = request.headers  
    # verificar que se valido
    if headers['Authorization'].present? && headers['Authorization'].match(token_regex)
      token = headers['Authorization'].match(token_regex)[1]
      if(Current.user = User.find_by_auth_token(token))
        return
      end  
    end  
    # verificar que el token extraido corresponda a un usuario
  
    render json: {error:'Unauthorized'}, status: :unauthorized
  end
end