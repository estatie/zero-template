syntax = "v1"

info(
  title: "record" 			    // todo replace with your service name
  desc: "Record service" 		// todo replace with your service description
  author: "estatie" 			// todo replace with your company name
  email: "reg@xcono.com" 		// todo replace with your company email
)

type (

  IDReq {
    ID uint64 `path:"id"`
  }

  {{.handler}} {
    ID uint64 `json:"id"`
    OrgID uint64 `json:"orgID"`
    Name string `json:"status"`
    Created string `json:"created"`
  }

  {{.handler}}s {
    {{.handler}}s []{{.handler}} `json:"items"`
  }

  {{.handler}}Create {
    OrgID uint64 `json:"orgID"`
    Name string `json:"status"`
  }

  {{.handler}}Update {
    ID uint64 `json:"id"`
    Name string `json:"status"`
  }
)

@server (
  group: {{.name}} // todo replace with your service group
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
  @doc "Delete {{.handler}} by {{.handler}}.ID and returns deleted {{.handler}}"
  @handler Delete
  delete /{{.name}}s/:id (IDReq) returns ({{.handler}})
}