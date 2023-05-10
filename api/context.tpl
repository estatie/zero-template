package svc

import {{.authImport}}

type ServiceContext struct {
	Config config.Config
	Deps Deps
	{{.middleware}}
}

func NewServiceContext(c config.Config, d Deps) *ServiceContext {
	return &ServiceContext{
		Config: c,
		Deps: d,
		{{.middlewareAssignment}}
	}
}