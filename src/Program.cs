using System;
using System.Collections.Generic;
using System.IO;
using System.Runtime.InteropServices;
using Joveler.Compression.XZ;

namespace Test
{
    class Program
    {
        static void InitializeXZ()
        {
            string arch = RuntimeInformation.OSArchitecture.ToString().ToLower();
            string foundLibPath = string.Empty;
            string libPath;
            string rid;
            string libName;

            // Determine Platform (needed for proper Runtime ID)
            if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
            {
                rid = $"win-{arch}";
                libName = "liblzma.dll";
            }
            else
            if (RuntimeInformation.IsOSPlatform(OSPlatform.Linux))
            {
                rid = $"linux-{arch}";
                libName = "liblzma.so";
            }
            else
            if (RuntimeInformation.IsOSPlatform(OSPlatform.OSX))
            {
                rid = $"osx-{arch}";
                libName = "liblzma.dylib";
            }
            else
            {
                // Unknown platform
                throw new PlatformNotSupportedException("Unknown runtime platform!");
            }

            // Try to search for the lib in the working directory and the application binary directory
            foreach (var relPath in new List<string> { ".", AppDomain.CurrentDomain.BaseDirectory })
            {
                // Try first the lib name directly
                libPath = Path.Combine(relPath, libName);
                if (System.IO.File.Exists(libPath))
                {
                    foundLibPath = libPath;
                    break;
                }

                // Try the runtimes/RID/native location
                // This is the default location for netstandard native libs
                libPath = Path.Combine(relPath, "runtimes", rid, "native", libName);
                if (System.IO.File.Exists(libPath))
                {
                    foundLibPath = libPath;
                    break;
                }
            }

            // Try the OS search path if nothing is found yet
            if (string.IsNullOrEmpty(foundLibPath))
            {
                var values = Environment.GetEnvironmentVariable("PATH");
                if (!string.IsNullOrEmpty(values))
                {
                    foreach (string path in values.Split(Path.PathSeparator))
                    {
                        libPath = Path.Combine(path, libName);
                        if (System.IO.File.Exists(libPath))
                        {
                            foundLibPath = libPath;
                            break;
                        }
                    }
                }
            }

            if (string.IsNullOrEmpty(foundLibPath))
                throw new PlatformNotSupportedException($"Unable to find {libName}");

            // Initialize XZ library
            XZInit.GlobalInit(foundLibPath);
        }

        static void Main(string[] args)
        {
            InitializeXZ();

            Console.WriteLine("Hello World!");
        }
    }
}
