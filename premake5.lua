workspace "tfc2"
    configurations { "Debug", "Release" }

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
    buildoptions {
        "-pedantic", "-Wno-write-strings",
        "--no-undefined", "-w", "-fpermissive", "-fsigned-char",
    }
    defines {
        "LINUX", "_LINUX", "CLIENT_WEAPONS", "CLIENT_DLL",
        "stricmp=strcasecmp", "_strnicmp=strncasecmp", 
        "strnicmp=strncasecmp", "sincosf=__sincosf",
        "_snprintf=snprintf",
    }
    filter "configurations:Debug"
        defines { "DEBUG" }
        flags { "Symbols" }
    filter "configurations:Release"
        defines { "NDEBUG" }
        optimize "On"

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
    buildoptions {
        "-pedantic", "-Wno-write-strings",
        "--no-undefined", "-w", "-fpermissive", "-fsigned-char",
        "-frtti", "-fno-exceptions"
    }
    defines {
        "LINUX", "_LINUX",
        "stricmp=strcasecmp", "_strnicmp=strncasecmp", 
        "strnicmp=strncasecmp", "sincosf=__sincosf",
        "_snprintf=snprintf",
    }
    filter "configurations:Debug"
        defines { "DEBUG" }
        flags { "Symbols" }
    filter "configurations:Release"
        defines { "NDEBUG" }
        optimize "On"