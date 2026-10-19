# Agentic Security Labs

Hands-on labs for securing AI agents and the tools they call, using open
identity and authorization standards.

Built by Martin Besozzi, IAM and AI Security Architect, CTO. These labs build on my experience in identity and access management, security architecture, and emerging agentic AI security patterns, with a focus on applying established standards rather than reinventing the wheel.

As agents start acting on behalf of users, calling MCP tools, APIs, and other agents, the same questions from traditional IAM take on new urgency:

- **Who is calling?** The user, the agent, or both?
- **What can they do?** Which tools, on which resources, under which conditions?
- **Where is authorization enforced?** At each tool, at a gateway, or across multiple enforcement points?

Each lab is a small, self-contained Docker Compose environment that demonstrates a concrete security pattern, combining an identity provider, policy enforcement points (PEPs) in front of agent tools, and a policy decision point (PDP) that evaluates authorization policies.

### Building blocks

| Component | Role in the labs |
|-----------|------------------|
| [Keycloak](https://www.keycloak.org/) | OpenID Provider and AuthZEN PDP |
| [Agent Gateway](https://agentgateway.dev/) | MCP gateway acting as the Policy Enforcement Point |
| [OpenID AuthZEN](https://openid.net/specs/openid-authzen-authorization-api-1_0-ID1.html) | Standard API between the PEP and the PDP |
| [MCP](https://modelcontextprotocol.io/) | Protocol the agents use to call tools |

### Prerequisites

- Docker with Docker Compose
- `curl` and `jq`

### Labs

| # | Lab | What you'll learn | Post |
|---|-----|-------------------|------|
| 1 | [MCP Tool Authorization with OpenID AuthZEN](mcp-authzen/README.md) | Externalize per-tool authorization for an MCP server to a standards-based PDP, enforced by Agent Gateway | [Implementing OpenID AuthZEN in Agent Gateway](https://embesozzi.github.io/posts/martin-besozzi/implementing-openid-authzen-in-agentgateway/) |
