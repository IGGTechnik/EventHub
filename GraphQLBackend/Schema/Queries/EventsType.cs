namespace graphQLBackend.Schema.Queries
{
    public class EventsType
    {
        public Guid Id { get; set; }
        public required string Title { get; set; }
        public required DateTime Start { get; set; }
        public required TimeSpan End { get; set; }
        [GraphQLDescription("Time after which cleaning is no longer possible because the chairs were set up")]
        public TimeSpan SeatingTime { get; set; }
        public bool KioskPossible { get; set; }
        public required int Pax { get; set; }
        public List<string>? PackageIds { get; set; }
    }
}
