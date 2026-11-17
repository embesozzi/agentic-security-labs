// list_accounts, get_account, create_payment: any payments role.
@id("payments-roles-read-and-create")
permit (
  principal,
  action == Payments::Action::"tools/call",
  resource is Payments::tool
)
when {
  resource in [
    Payments::tool::"list_accounts",
    Payments::tool::"get_account",
    Payments::tool::"create_payment"
  ] &&
  (principal in Keycloak::Role::"payments_user" ||
   principal in Keycloak::Role::"payments_manager" ||
   principal in Keycloak::Role::"payments_admin")
};
