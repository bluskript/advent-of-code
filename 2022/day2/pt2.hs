module Main where

import Data.List (isPrefixOf, sort)
import Text.Printf

tuplify2 :: [a] -> (a, a)
tuplify2 [x, y] = (x, y)

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

convertSide :: String -> Integer
convertSide a = case a of
  "A" -> 1
  "B" -> 2
  "C" -> 3

getUserChoice :: Integer -> String -> Integer
getUserChoice x i = case i of
  "Y" -> x
  "X" -> (x + 1) `mod` 3 + 1
  "Z" -> (x `mod` 3) + 1

getMatchScore :: Integer -> Integer -> Integer
getMatchScore a b
  | a == b = 3
  | otherwise = if (a - b) `mod` 3 == 1 then 6 else 0

getTotalScore a b = b + getMatchScore b a

convertEntry :: (String, String) -> (Integer, Integer)
convertEntry (a, b) =
  let x = convertSide a
   in (x, getUserChoice x b)

getAnswer = sum . map (uncurry getTotalScore . convertEntry . tuplify2 . words) . split "\n"

main :: IO ()
main = do
  text <- readFile "./input"
  print $ getAnswer text
