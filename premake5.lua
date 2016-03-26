workspace "tfc2"
    configurations { "dbg", "rel" }
    platforms { "win", "linux", "osx" }
    filter "configurations:dbg"
        defines { "DEBUG" }
        flags { "Symbols" }
    filter "configurations:rel"
        defines { "NDEBUG" }
        buildoptions { "-O2" }
        premake.tools.gcc.ldflags.flags._Symbols = nil -- premake5 strip bug hack
    filter "platforms:win"
        system "windows"
    filter "platforms:linux"
        system "linux"
    filter "platforms:osx"
        system "macosx"

project "client"
    kind "SharedLib"
    language "C++"
    targetdir "bin/%{cfg.buildcfg}"
    files { -- local & pm
        "cl_dll/**.cpp",
        "pm_shared/**.c",
    }
    files { -- weapons
        "dlls/crossbow.cpp", "dlls/crowbar.cpp", "dlls/egon.cpp", "dlls/gauss.cpp",
        "dlls/handgrenade.cpp", "dlls/hornetgun.cpp", "dlls/mp5.cpp", "dlls/python.cpp",
        "dlls/rpg.cpp", "dlls/satchel.cpp", "dlls/satchel.cpp", "dlls/shotgun.cpp",
        "dlls/squeakgrenade.cpp", "dlls/tripmine.cpp", "dlls/glock.cpp"
    }
    removefiles {
        "cl_dll/inputw32.cpp",
        "cl_dll/hud_servers.cpp",
        "cl_dll/GameStudioModelRenderer_Sample.cpp",
        "cl_dll/soundsystem.cpp",
        "dlls/Wxdebug.cpp",
        "game_shared/voice_banmgr.cpp",
        "game_shared/voice_status.cpp",
    }
    includedirs {
        "common/", "game_shared/", "pm_shared/",
        "engine/", "dlls/"
    }
    defines {
        "CLIENT_WEAPONS", "CLIENT_DLL", "CLIENT_DLL=1",
    }
    defines {
        "stricmp=strcasecmp", "_strnicmp=strncasecmp", 
        "strnicmp=strncasecmp", "sincosf=__sincosf",
        "_snprintf=snprintf",
    }
    buildoptions {
        "-pedantic", "-Wno-write-strings",
        "--no-undefined", "-w",
    }
    filter "platforms:linux"
        defines { "LINUX", "_LINUX", }
    filter "platforms:osx"
        defines { "LINUX", "_LINUX", } -- sorry bsdfags


project "server"
    kind "SharedLib"
    language "C++"
    targetdir "bin/%{cfg.buildcfg}"
    files { -- local & pm & game_shared
        "dlls/**.cpp", 
        "pm_shared/**.c", 
        "game_shared/voice_gamemgr.cpp"
    }
    includedirs {
        "common/", "game_shared/", "pm_shared/",
        "engine/", "engine/common/", "dlls/", "public/"
    }
    removefiles {
        "dlls/Wxdebug.cpp",
        "dlls/AI_BaseNPC_Schedule.cpp",
        "dlls/mpstubb.cpp",
        "dlls/playermonster.cpp",
        "dlls/prop.cpp",
    }
    defines {
        "CLIENT_WEAPONS"
    }
    defines {
        "stricmp=strcasecmp", "_strnicmp=strncasecmp", 
        "strnicmp=strncasecmp", "sincosf=__sincosf",
        "_snprintf=snprintf",
    }
    buildoptions {
        "-pedantic", "-Wno-write-strings",
        "--no-undefined", "-w",
    }
    filter "platforms:linux"
        defines { "LINUX", "_LINUX", }
    filter "platforms:osx"
        defines { "LINUX", "_LINUX", } -- really sorry bsdfags