# 2415225178811784
{
    inputs = { } ;
    outputs =
        { self } :
            {
                lib =
                    { input ? x : x , output ? x : x } :
                        let
                            implementation =
                                { lib , pkgs , ... } @module :
                                    let
                                        exploded = ./node_modules.exploded ;
                                        identified = input module ;
                                        in
                                            with identified ;
                                                {
                                                    config.environment.sessionVariables.TEMPORARY = config.nodejs.fetchers.bcrypt ;
                                                    options.nodejs =
                                                        {
                                                            fetchers.bcrypt =
                                                                lib.mkOption
                                                                    {
                                                                        default = config.nodejs.fetch { name = "db-migrate-pg" ; nodejs = pkgs.nodejs_22 ; version-spec = "^1.5.2" ; } ;
                                                                        type = lib.types.package ;
                                                                    } ;
                                                            packages.bcrypt =
                                                                lib.mkOption
                                                                    {
                                                                        default = config.nodejs.package { exploded = ./node_modules.exploded ; } ;
                                                                        type = lib.types.package ;
                                                                    } ;
                                                        } ;
                                                } ;
                            in
                                {
                                    check = null ;
                                    checks = [ ] ;
                                    implementation = output implementation ;
                                    imports = [ ] ;
                                } ;
            } ;
}
