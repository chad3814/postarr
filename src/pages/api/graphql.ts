// pages/api/graphql.ts

import { createYoga } from 'graphql-yoga'
import type { NextApiRequest, NextApiResponse } from 'next'
import schema from '../../../graphql/schema'
import db from '../../lib/db';

export default createYoga<{
  req: NextApiRequest
  res: NextApiResponse
}>({
  schema: await schema,
  context: {
    prisma: db
  },
  graphqlEndpoint: '/api/graphql'
})

export const config = {
  api: {
    bodyParser: false
  }
}