package terraform

import data.common.access.ws_access
import input.tfrun as tfrun


workspace_key := tfrun.workspace.name
created_by := object.get(tfrun, "created_by", object.get(input, "created_by", {}))
user_email := object.get(created_by, "email", "")
teams      := object.get(created_by, "teams", [])
user_groups := { team.name | some i; team := teams[i]; team.name }

# Helpers (safe, no "_" in negation)
email_in(list, email) if {
  some i
  list[i] == email
}

group_match(list, groups_set) if {
  some i
  groups_set[list[i]]
}

deny["User is explicitly denied for this workspace"] if {
  a := ws_access(workspace_key)
  email_in(a.deny_users, user_email)
}

deny["User is in a denied group for this workspace"] if {
deny["User is in a denied group for this workspace"] if {
  a := ws_access(workspace_key)
  group_match(a.deny_groups, user_groups)
}

deny["User is not allowed for this workspace"] if {
  a := ws_access(workspace_key)

  not email_in(a.allow_users, user_email)
  not group_match(a.allow_groups, user_groups)
}
