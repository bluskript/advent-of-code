module Main where

import Data.List (isPrefixOf, sort)
import Text.Printf

split :: Eq a => [a] -> [a] -> [[a]]
split _ [] = []
split delim contents =
  if take (length delim) contents == delim
    then [] : split delim (drop (length delim) contents)
    else
      let (x : xs) = contents
       in case split delim xs of
            (y : ys) -> (x : y) : ys
            [] -> [[x]]

getAnswer :: String -> Integer
getAnswer = sum . take 3 . reverse . sort . map (sum . (map read . split "\n")) . split "\n\n"

main :: IO ()
main = do
  text <- readFile "./input"
  print $ getAnswer text
