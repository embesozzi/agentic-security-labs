# Agentic Security Labs

Hands-on labs for securing AI agents and the tools they call, using open
identity and authorization standards.

Built by Martin Besozzi, IAM and AI Security Architect, CTO. These labs build on my experience in identity and access management, security architecture, and emerging agentic AI security patterns, with a focus on applying established standards rather than reinventing the wheel.

As agents start acting on behalf of users, calling MCP tools, APIs, and other agents, the same questions from traditional IAM take on new urgency:

- **Who is calling?** The user, the agent, or both?
- **What can they do?** Which tools, on which resources, under which conditions?
- **Where is authorization enforced?** At each tool, at a gateway, or across multiple enforcement points?

Each lab runs as a small Docker Compose environment that demonstrates a concrete security pattern, combining an identity provider, policy enforcement points (PEPs) in front of agent tools, and a policy decision point (PDP) that evaluates authorization policies.

### Building blocks

| Component | Role in the labs |
|-----------|------------------|
| [Keycloak](https://www.keycloak.org/) | OpenID Provider and AuthZEN PDP |
| [Agent Gateway](https://agentgateway.dev/) | MCP gateway acting as the Policy Enforcement Point |
| [OpenID AuthZEN](https://openid.net/specs/openid-authzen-authorization-api-1_0-ID1.html) | Standard API between the PEP and the PDP |
| [Cedar](https://www.cedarpolicy.com/) | Policy language and evaluation engine behind the PDP's decisions, added to Keycloak by the [Cedar policy provider](https://github.com/embesozzi/keycloak-cedar-authorization) |
| [MCP](https://modelcontextprotocol.io/) | Protocol the agents use to call tools |

### Prerequisites

- Docker with Docker Compose
- `curl`, `jq` and `make`

### Labs

Both labs run from the same folder, [`mcp-authzen`](mcp-authzen/README.md): Agent Gateway enforces per-tool authorization for an MCP server, and Keycloak decides through AuthZEN. They differ only in the policy engine Keycloak uses.

| Lab | What you'll learn | Post |
|-----|-------------------|------|
| [MCP Tool Authorization with OpenID AuthZEN](mcp-authzen/README.md) | Externalize per-tool authorization for an MCP server to a standards-based PDP, with Keycloak default policies | [Implementing OpenID AuthZEN in Agent Gateway](https://embesozzi.github.io/posts/martin-besozzi/implementing-openid-authzen-in-agentgateway/) |
| [MCP Tool Authorization with Cedar](mcp-authzen/README.md#policy-engines-keycloak-default-policies-or-cedar-policies) | The same authorization written as Cedar policies, with the Keycloak Cedar provider | [Keycloak Cedar Authorization with AuthZEN](https://embesozzi.github.io/posts/martin-besozzi/keycloak-cedar-authorization-authzen/) |

To run a lab, see [Running the example](mcp-authzen/README.md#running-the-example).

### Versions

| Version | Changes |
|---------|---------|
| [v1.1.0](https://github.com/embesozzi/agentic-security-labs/releases/tag/v1.1.0) | Adds Cedar policies with the Keycloak Cedar provider |
| [v1.0.0](https://github.com/embesozzi/agentic-security-labs/releases/tag/v1.0.0) | MCP tool authorization with AuthZEN: Keycloak as the PDP, Agent Gateway as the PEP |
