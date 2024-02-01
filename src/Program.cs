using System;
using System.Runtime.InteropServices;

namespace Test
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine($"OSDescription = {RuntimeInformation.OSDescription}");
            Console.WriteLine($"OSArchitecture = {RuntimeInformation.OSArchitecture}");
            Console.WriteLine($"ProcessArchitecture = {RuntimeInformation.ProcessArchitecture}");
        }
    }
}
