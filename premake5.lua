workspace "opencl_starter_project"
	architecture "x64"
	startproject "opencl_starter_project"

	configurations
	{
		"Debug",
		"Release"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- include directories relative to root folder (solution directory)

IncludeDir = {}
--IncludeDir["OpenCL_HPP"] = "opencl_starter_project/vendor/OpenCL/include/CL_HPP"
--IncludeDir["OpenCL_H"] = "opencl_starter_project/vendor/OpenCL/include/OpenCL_Headers"


project "opencl_starter_project"
	location "opencl_starter_project"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"
	

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")	

	-- pchheader "sapch.h"
	-- pchsource "opencl_starter_project/src/sapch.cpp"

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"		
	}

	includedirs
	{
		"%{prj.name}/src",					
		"%{prj.name}/vendor/OpenCL/include/CL-HPP",					
		"%{prj.name}/vendor/OpenCL/include/OpenCL-Headers",					
		--"%{IncludeDir.OpenCL_H}",
		--"%{IncludeDir.OpenCL_HPP}"		

	}

		libdirs
	{ 
		"%{prj.name}/vendor/OpenCL/lib/x64"
    }

	links
	{
		"OpenCL.lib",
		"cfgmgr32.lib",
		"runtimeobject.lib",
		"kernel32.lib",
		"user32.lib",
		"gdi32.lib",
		"winspool.lib",
		"shell32.lib",
		"ole32.lib",
		"oleaut32.lib",
		"uuid.lib",
		"comdlg32.lib",
		"advapi32.lib"
	}

	filter "system:windows"
		systemversion "latest"

		defines
		{			
			"WIN32",
			"_WINDOWS",
			"CL_HPP_ENABLE_EXCEPTIONS",
			"CL_TARGET_OPENCL_VERSION=120",
			"CL_HPP_TARGET_OPENCL_VERSION=120",
			"CL_HPP_MINIMUM_OPENCL_VERSION=120",
			"_CRT_SECURE_NO_WARNINGS",
			"_MBCS"
		}

	filter "configurations:Debug"			
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "on"
