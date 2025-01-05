namespace graphQLBackend.Schema.Mutations
{
    public class PackagesResponseType
    {
        public required string Name { get; set; }
        public string? Description { get; set; }
    }
}
