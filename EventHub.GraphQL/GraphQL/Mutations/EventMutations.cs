using EventHub.GraphQL.DTO;
using Microsoft.EntityFrameworkCore;

namespace EventHub.GraphQL.GraphQL.Mutations
{
    public class EventMutations
    {
        public Event AddEvent(EventHub_DbContext dbContext, Event newEvent)
        {
            dbContext.Events.Add(newEvent);
            dbContext.SaveChanges();
            return newEvent;
        }

        

        public bool DeleteEvent(EventHub_DbContext dbContext, Guid id)
        {
            try
            {
                Event Event = new Event { Id = id };
                dbContext.Events.Remove(Event);
                dbContext.SaveChanges();
            }
            catch (DbUpdateConcurrencyException e)
            {
                return false;
            }
            return true; 
        }
    }
}
