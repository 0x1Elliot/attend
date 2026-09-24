# Attend Frontend / Schema Integration

Schema source commit:

8bb7357cae5a49ef0bb519ae764e4b50ef50dca0

Schema source:

docs/schema.md

## Current Contract

The frontend currently represents the domain concepts defined by the Attend schema foundation.

| Schema concept | Frontend representation |
| --- | --- |
| Profile | Host workspace and profile UI |
| Event Type | Event cards and event configuration UI |
| Availability Rule | Weekly availability UI |
| Attention Rule | Attention / scheduling rules UI |
| Booking | Upcoming booking and guest booking UI |

## Integration Boundary

The frontend currently represents these concepts visually with static data.

The schema foundation defines the shared domain vocabulary.

This commit does not yet provide:

- database tables
- Supabase migrations
- row-level-security policies
- authentication
- database queries
- API endpoints
- live persistence

When backend implementation is added, frontend integration should happen through a service/data-access layer rather than embedding database calls throughout React components.

Recommended flow:

React component
-> frontend service
-> Supabase/client API
-> canonical database schema

## Schema Version

Integrated schema foundation:

8bb7357cae5a49ef0bb519ae764e4b50ef50dca0

Integration branch:

integration/schema-foundation
