import "reflect-metadata";
import { resolvers } from "../prisma/generated/type-graphql";
import { buildSchema } from "type-graphql";

const schema = buildSchema({
  resolvers,
  validate: false,
});

export default schema;