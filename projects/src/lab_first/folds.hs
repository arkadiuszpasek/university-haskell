module Folds where

sum list = foldr (+) 0 list

product list = foldr (*) 1 list

-- reverse list = foldl (flip (:)) [] list
reverse list = foldl (\xs x -> x:xs) [] list

and list = foldr (&&) True list

or list = foldr (||) False list

head list = foldr (\x _ -> x) 0 list

last list = foldl (\_ x -> x) 0 list