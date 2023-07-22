package svc

import (
    "context"
    "github.com/estatie/id/pkg/auth/jwt"
    "github.com/zeromicro/go-zero/rest"
)

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

// Scheduler returns the scheduler instance for the service-as-worker mode, see zero.ModeConf.
func (s *ServiceContext) Scheduler(_ context.Context) *gocron.Scheduler {
return s.Iam.Scheduler
}

// Shutdown gracefully shuts down the service.
func (s *ServiceContext) Shutdown(ctx context.Context) error {

sch := s.Scheduler(ctx)
if sch != nil {
sch.Stop()
fmt.Println("Scheduler stopped.")
}

fmt.Println("Service stopped.")

return nil
}
