namespace graphQLBackend.Schema.Queries
{
    public class PackageType
    {
        public Guid Id { get; set; }
        public required string Name { get; set; }
        public string? Description { get; set; }
    }
}
