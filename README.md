### PHPStorm Xdebug Setup
#### Docker setup
1. File > Settings > Build, Execution, Deployment > Docker.
2. Create new connection with Unix socket. The message "Connection successful" must be displayed.
3. File > Settings > PHP.

#### CLI Interpreter
1. Set language level and CLI interpreter, open the `...` option.
2. Create new interpreter with server Docker and the image name of your php image.
3. PHP executable will be loaded and the Debugger version must be displayed below.

#### Server connection
1. File > Settings > PHP > Servers.
2. Create new connection with the name and host of your application url.
3. Check the path mapping option.
4. In right of File/Directory, insert the absolut path of your application (by default /var/www/html).