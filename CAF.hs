{-# LANGUAGE ScopedTypeVariables #-}
module Main where

import Control.Exception
import GHC.Stack

{-# NOINLINE caf #-}
caf :: [Int]
caf = [1..500]

{-# NOINLINE caf_exc #-}
caf_exc :: Int
caf_exc = caf !! 1000

{-# NOINLINE foo #-}
foo :: Int -> Int
foo 0 = caf_exc
foo n = foo $ n - 1

{-# NOINLINE bar #-}
bar :: Int -> Int
bar n = bar' n
  where
    bar' 0 = foo n
    bar' m = bar' $ m - 1


main :: IO ()
main = print (bar 10) `catch`
       \(e :: SomeException) -> do stacktrace <- whoCreated e
                                   print stacktrace
