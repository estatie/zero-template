package main

import (
	"flag"
	"fmt"

	// @start.api.middlewares: import default middlewares
	"zero/zoo/web/middle"
	// @end.api.middlewares: import default middlewares

	{{.importPackages}}
)

var configFile = flag.String("f", "etc/{{.serviceName}}.yaml", "the config file")

func main() {
	flag.Parse()

	var c config.Config
	conf.MustLoad(*configFile, &c)

	server := rest.MustNewServer(c.RestConf)
	defer server.Stop()

	// @start.api.middlewares: inject default middlewares
	for _, mw := range middle.NewDefault(c.RestConf) {
		server.Use(mw)
	}
	// @end.api.middlewares: inject default middlewares

	ctx := svc.NewServiceContext(c)
	handler.RegisterHandlers(server, ctx)

	fmt.Printf("Starting server at %s:%d...\n", c.Host, c.Port)
	server.Start()
}
