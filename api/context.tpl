package svc

type ServiceContext struct {
	Config Config
	{{.middleware}}
}

func NewServiceContext(c Config) *ServiceContext {
	return &ServiceContext{
		Config: c,
		{{.middlewareAssignment}}
	}
}
