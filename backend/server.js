import express from 'express';
import cors from 'cors';
import { graphqlHTTP } from 'express-graphql';
import { makeExecutableSchema } from "@graphql-tools/schema";

const app = express();
const port = 4000;

const data = {
    events: [
        { id: '001', title: "Konzert"},
        { id: '002', title: "Lesung"}
    ]
}

const typeDefs = `
    type Event {
        id: ID!
        title: String!
    }
    
    type Query {
        events: [Event]
    }
`

const resolvers = {
    Query: {
        events: (obj, args, context) => context.events,
    }
}

const executableSchema = makeExecutableSchema({
    typeDefs,
    resolvers,
});

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(
    '/graphql',
    graphqlHTTP({
        schema: executableSchema,
        context: data,
        graphiql: true,
    })
)

/*app.get('/', (req, res) => {
  res.send('Hello World!');
});*/

app.listen(port, () => {
    console.log(`Running a server at http://localhost:${port}`);
});
