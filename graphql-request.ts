import { GraphQLClient } from 'graphql-request'

export const staticGraphqlRequest = async (query: string) => {
  const graphQLClient = new GraphQLClient(process.env.API_ENDPOINT, {
    headers: { authorization: `Bearer ${process.env.BUILD_JWT}` },
  })

  return graphQLClient.request(query)
}

export const serverGraphqlRequest = async (query: string) => {
  const graphQLClient = new GraphQLClient(process.env.API_ENDPOINT, {
    headers: { authorization: `Bearer ${process.env.SERVER_JWT}` },
  })

  return graphQLClient.request(query)
}
