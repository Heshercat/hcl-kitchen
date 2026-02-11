package terraform

import data.common.access.ws_access
import input.tfrun as tfrun


workspace_key := tfrun.workspace.name
user_email    := tfrun.created_by.email
user_groups   := [t.name | some i; t := input.created_by.teams[i]; t.name]

# Helpers (safe, no "_" in negation)
email_in(list, email) if {
  some i
  list[i] == email
}

group_in(list, groups) if {
  some i
  some j
  list[i] == groups[j]
}

deny["User is explicitly denied for this workspace"] if {
  a := ws_access(workspace_key)
  email_in(a.deny_users, user_email)
}

deny["User is in a denied group for this workspace"] if {
  a := ws_access(workspace_key)
  group_in(a.deny_groups, user_groups)
}

deny["User is not allowed for this workspace"] if {
  a := ws_access(workspace_key)

  not email_in(a.allow_users, user_email)
  not group_in(a.allow_groups, user_groups)
}
