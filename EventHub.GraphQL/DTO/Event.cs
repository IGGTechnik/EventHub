namespace EventHub.GraphQL.DTO
{
    public class Event
    {
        public Guid? Id { get; set; }
        public string? Title { get; set; }
        public DateTime? Start { get; set; }
        public TimeOnly? End { get; set; }
        public TimeOnly? SeatingTime { get; set; }
        public int? Pax { get; set; }
        public bool? KioskPossible { get; set; }
        public IEnumerable<Inventory>? Inventory { get; set; }
        public IEnumerable<Package>? Packages { get; set; }
    }
}
