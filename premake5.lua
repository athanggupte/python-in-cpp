workspace "ApexAI"
    architecture "x64"
    configurations { "Debug", "Release" }
    
targetDir = "build/%{cfg.buildcfg}"
    
-- Modules
project "DecisionTree"
    location "DecisionTree"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    
    targetdir "%{targetDir}/lib/%{prj.name}"
    objdir "%{targetDir}/obj/%{prj.name}"
    
    files {
        "%{prj.name}/src/cpp/**.h",
        "%{prj.name}/src/cpp/**.cpp"
    }
    
    filter "system:linux"
        includedirs {
            "%{prj.name}/src/cpp",
            "/usr/include/python3.9"
        }
    
        links {
            "crypt",
            "pthread",
            "dl",
            "util",
            "m",
            "python3.9"
        }
    
    filter "configurations:Debug"
        defines { "DEBUG" }
        runtime "Debug"
        symbols "On"
        
    filter "configurations:Release"
        defines { "NDEBUG" }
        runtime "Release"
        optimize "Full"
        
        postbuildcommands { "{MKDIR} ../build/include/%{prj.name}", "cd src/cpp/ && find . -type f -name \\*.h -exec cp --parents {} ../../../build/include/%{prj.name}/ \\;" }
        postbuildmessage "Copying includes..."

-- Driver code
project "examples"
    location "examples"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++17"
    
    targetdir "%{targetDir}/bin/%{prj.name}"
    objdir "%{targetDir}/obj/%{prj.name}"
    
    files {
        "%{prj.name}/**.h",
        "%{prj.name}/**.cpp"
    }
    
    filter "system:linux"    
        includedirs {
            "%{prj.name}/",
            "DecisionTree/src/cpp"
        }
    
        links {
            "DecisionTree",
            "crypt",
            "pthread",
            "dl",
            "util",
            "m",
            "python3.9"
        }
        
    filter "configurations:Debug"
        defines { "DEBUG" }
        runtime "Debug"
        symbols "On"
        
    filter "configurations:Release"
        defines { "NDEBUG" }
        runtime "Release"
        optimize "Full"
        
        
-- End
