{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_projects (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/arekpasek/dev/haskell/university-haskell/projects/.stack-work/install/x86_64-osx/e968933f631858c24b32f4fe2e90d2c892bc46e2c4853c15c3e921184ce5f144/8.8.3/bin"
libdir     = "/Users/arekpasek/dev/haskell/university-haskell/projects/.stack-work/install/x86_64-osx/e968933f631858c24b32f4fe2e90d2c892bc46e2c4853c15c3e921184ce5f144/8.8.3/lib/x86_64-osx-ghc-8.8.3/projects-0.1.0.0-LjlWjZwNUoSErGSTroTAFn-projects"
dynlibdir  = "/Users/arekpasek/dev/haskell/university-haskell/projects/.stack-work/install/x86_64-osx/e968933f631858c24b32f4fe2e90d2c892bc46e2c4853c15c3e921184ce5f144/8.8.3/lib/x86_64-osx-ghc-8.8.3"
datadir    = "/Users/arekpasek/dev/haskell/university-haskell/projects/.stack-work/install/x86_64-osx/e968933f631858c24b32f4fe2e90d2c892bc46e2c4853c15c3e921184ce5f144/8.8.3/share/x86_64-osx-ghc-8.8.3/projects-0.1.0.0"
libexecdir = "/Users/arekpasek/dev/haskell/university-haskell/projects/.stack-work/install/x86_64-osx/e968933f631858c24b32f4fe2e90d2c892bc46e2c4853c15c3e921184ce5f144/8.8.3/libexec/x86_64-osx-ghc-8.8.3/projects-0.1.0.0"
sysconfdir = "/Users/arekpasek/dev/haskell/university-haskell/projects/.stack-work/install/x86_64-osx/e968933f631858c24b32f4fe2e90d2c892bc46e2c4853c15c3e921184ce5f144/8.8.3/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "projects_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "projects_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "projects_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "projects_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "projects_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "projects_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
