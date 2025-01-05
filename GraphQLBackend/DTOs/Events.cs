using graphQLBackend.Schema.Queries;

namespace graphQLBackend.DTOs
{
    public class Events
    {
        public Guid Id { get; set; }
        public required string Title { get; set; }
        public DateTime Start { get; set; }
        public TimeSpan End { get; set; }
        public TimeSpan SeatingTime { get; set; }
        public bool KioskPossible { get; set; }
        public int Pax { get; set; }
        public IEnumerable<Packages>? Packages { get; set; }
        public IEnumerable<Inventory>? Inventory { get; set; }
    }
}
