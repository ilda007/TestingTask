using System;
using System.Collections.Generic;
using System.Linq;

namespace TestingTask
{
  internal class Program
  {
    static void Main(string[] args)
    {
      var NumbersArray = new int[] { 3, 2, 1, 4, 5, 0, 0, 5, 3, 1, 4, 5, 6, 15 };
      var OriginalArray = GetOriginalArray(NumbersArray);
      foreach (var item in OriginalArray)
      {
        Console.WriteLine(item.ToString());
      }
    }

    public static int[] GetOriginalArray(int[] numbersArray)
    {
      var localList = new List<int>();

      foreach (var item in numbersArray)
      {
        var i = 0;

        foreach (var element in numbersArray)
        {
          if (item == element)
          {
            ++i;
          }
        }

        if (i == 1)
        {
          localList.Add(item);
        }

      }

      return localList.ToArray();
    }
  }
}
