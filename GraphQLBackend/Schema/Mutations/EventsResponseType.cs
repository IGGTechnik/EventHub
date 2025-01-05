using graphQLBackend.Schema.Queries;

namespace graphQLBackend.Schema.Mutations
{
    public class EventsResponseType
    {
        public required string Title { get; set; }
        public required string Start { get; set; }
        public required string End { get; set; }
        [GraphQLDescription("Time after which cleaning is no longer possible because the chairs were set up")]
        public string? SeatingTime { get; set; }
        public bool KioskPossible { get; set; }
        public required int Pax { get; set; }
        public IEnumerable<PackageType>? Packages { get; set; }
    }
}
