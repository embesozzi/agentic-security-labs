// approve_payment, cancel_payment: payments_manager or payments_admin only.
@id("managers-approve-and-cancel")
permit (
  principal,
  action == Payments::Action::"tools/call",
  resource is Payments::tool
)
when {
  resource in [
    Payments::tool::"approve_payment",
    Payments::tool::"cancel_payment"
  ] &&
  (principal in Keycloak::Role::"payments_manager" ||
   principal in Keycloak::Role::"payments_admin")
};
