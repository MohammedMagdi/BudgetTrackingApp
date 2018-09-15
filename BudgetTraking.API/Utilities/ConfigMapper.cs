using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BudgetTraking.API.Utilities
{
    public class ConfigMapper
    {
        public static R Map<T, R>(T data)
        {
            MapperConfiguration config = new MapperConfiguration(cfg =>
            {
                cfg.CreateMap<T, R>();
            });
            IMapper mapper = config.CreateMapper();

            return mapper.Map<T, R>(data);
        }

        
        public static List<R> MapList<T, R>(List<T> data)
        {
            MapperConfiguration config = new MapperConfiguration(cfg =>
            {
                cfg.CreateMap<T, R>();
            });

            IMapper mapper = config.CreateMapper();

            return mapper.Map<List<T>, List<R>>(data);
        }
    }
}