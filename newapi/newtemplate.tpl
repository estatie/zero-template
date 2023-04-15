syntax = "v1"

info(
  title: "{{.name}}"
  desc: "{{.handler}} service"
  author: "estatie"
  email: "reg@xcono.com"
)

type (

  IDReq {
    ID string `path:"id"`
  }

  {{.handler}} {
    ID string `json:"id"`
    OrgID string `json:"orgID"`
    Name string `json:"status"`
    Created string `json:"created"`
  }

  {{.handler}}s {
    {{.handler}}s []{{.handler}} `json:"items"`
  }

  {{.handler}}Create {
    OrgID string `json:"orgID"`
    Name string `json:"status"`
  }

  {{.handler}}Update {
    ID string `json:"id"`
    Name string `json:"status"`
  }
)

@server(
  jwt: Auth
)

service {{.name}}-api {

  // todo tests, access, logic
  @doc "Load all {{.handler}}s"
  @handler All
  get /{{.name}}s returns ({{.handler}}s)

  // todo tests, access, logic
  @doc "Load {{.handler}} by ID"
  @handler Load
  get /{{.name}}s/:id (IDReq) returns ({{.handler}})

  // todo tests, access, logic
  @doc "Create new {{.handler}}"
  @handler Create
  post /{{.name}}s ({{.handler}}Create) returns ({{.handler}})

  // todo tests, access, logic
  @doc "Update existing {{.name}} by {{.handler}}Update.ID"
  @handler Update
  put /{{.name}}s ({{.handler}}Update) returns ({{.handler}})

  // todo tests, access, logic
  @doc "Delete {{.handler}} by {{.handler}}Update.ID and returns deleted {{.handler}}"
  @handler Delete
  delete /{{.name}}s/:id (IDReq) returns ({{.handler}})
}