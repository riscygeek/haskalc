{-
 -  Copyright (C) 2021 Benjamin Stürz
 -  
 -  This program is free software: you can redistribute it and/or modify
 -  it under the terms of the GNU General Public License as published by
 -  the Free Software Foundation, either version 3 of the License, or
 -  (at your option) any later version.
 -  
 -  This program is distributed in the hope that it will be useful,
 -  but WITHOUT ANY WARRANTY; without even the implied warranty of
 -  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 -  GNU General Public License for more details.
 -  
 -  You should have received a copy of the GNU General Public License
 -  along with this program.  If not, see <https://www.gnu.org/licenses/>.
 -}

module Number where

type INumber = Integer
type FNumber = Double

data Number = IVal INumber | FVal FNumber

instance Num Number where
   (+) (IVal x) (IVal y)      = IVal $ x + y
   (+) (IVal x) (FVal y)      = FVal $ (realToFrac x) + y
   (+) (FVal x) (IVal y)      = FVal $ x + (realToFrac y)
   (+) (FVal x) (FVal y)      = FVal $ x + y

   (*) (IVal x) (IVal y)      = IVal $ x * y
   (*) (IVal x) (FVal y)      = FVal $ (realToFrac x) * y
   (*) (FVal x) (IVal y)      = FVal $ x * (realToFrac y)
   (*) (FVal x) (FVal y)      = FVal $ x * y

   abs (IVal x)               = IVal $ abs x
   abs (FVal x)               = FVal $ abs x

   signum (IVal x)            = IVal $ signum x
   signum (FVal x)            = FVal $ signum x

   negate (IVal x)            = IVal $ -x
   negate (FVal x)            = FVal $ -x

   fromInteger x              = IVal x

instance Real Number where
   toRational (IVal x)        = toRational x
   toRational (FVal x)        = toRational x

instance Enum Number where
   toEnum x                   = IVal $ toInteger x

   fromEnum (IVal x)          = fromEnum x
   fromEnum (FVal x)          = fromEnum x

instance Integral Number where
   quotRem (IVal x) (IVal y)  = (IVal a, IVal b)
                              where
                                 a = fst $ quotRem x y
                                 b = snd $ quotRem x y
   toInteger (IVal x)         = x
   toInteger (FVal x)         = floor x

instance Fractional Number where
   fromRational x             = FVal $ fromRational x
   (/) (IVal a) (IVal b)      = FVal $ (realToFrac a) / (realToFrac b)
   (/) (IVal a) (FVal b)      = FVal $ (realToFrac a) / b
   (/) (FVal a) (IVal b)      = FVal $ a / (realToFrac b)
   (/) (FVal a) (FVal b)      = FVal $ a / b

instance Floating Number where
   pi                         = FVal pi

   exp (FVal x)               = FVal $ exp x
   exp (IVal x)               = FVal $ exp $ realToFrac x

   log (FVal x)               = FVal $ log x
   log (IVal x)               = FVal $ log $ realToFrac x

   sin (FVal x)               = FVal $ sin x
   sin (IVal x)               = FVal $ sin $ realToFrac x

   cos (FVal x)               = FVal $ cos x
   cos (IVal x)               = FVal $ cos $ realToFrac x

   asin (FVal x)              = FVal $ asin x
   asin (IVal x)              = FVal $ asin $ realToFrac x

   acos (FVal x)              = FVal $ acos x
   acos (IVal x)              = FVal $ acos $ realToFrac x

   atan (FVal x)              = FVal $ atan x
   atan (IVal x)              = FVal $ atan $ realToFrac x

   sinh (FVal x)              = FVal $ sinh x
   sinh (IVal x)              = FVal $ sinh $ realToFrac x

   cosh (FVal x)              = FVal $ cosh x
   cosh (IVal x)              = FVal $ cosh $ realToFrac x

   asinh (FVal x)             = FVal $ asinh x
   asinh (IVal x)             = FVal $ asinh $ realToFrac x

   acosh (FVal x)             = FVal $ acosh x
   acosh (IVal x)             = FVal $ acosh $ realToFrac x

   atanh (FVal x)             = FVal $ atanh x
   atanh (IVal x)             = FVal $ atanh $ realToFrac x

   (**) (IVal x) (IVal y)     | y >= 0    = IVal $ x ^ y
                              | otherwise = FVal $ (realToFrac x) ** (realToFrac y)

   (**) (IVal x) (FVal y)                 = FVal $ (realToFrac x) ** y
   (**) (FVal x) (IVal y)                 = FVal $ x ** (realToFrac y)
   (**) (FVal x) (FVal y)                 = FVal $ x ** y


instance Eq Number where
   (==) (IVal x) (IVal y)     = x == y
   (==) (IVal x) (FVal y)     = (realToFrac x) == y
   (==) (FVal x) (IVal y)     = x == (realToFrac y)
   (==) (FVal x) (FVal y)     = x == y

instance Ord Number where
   (<=) (IVal x) (IVal y)     = x <= y
   (<=) (IVal x) (FVal y)     = (realToFrac x) <= y
   (<=) (FVal x) (IVal y)     = x <= (realToFrac y)
   (<=) (FVal x) (FVal y)     = x <= y
   

instance Show Number where
   show (IVal x)              = show x
   show (FVal x)              = show x

pow10 :: Integer -> Number
pow10 e  | e >= 0    = IVal $ 10 ^ e
         | otherwise = FVal $ 10.0 ** (realToFrac e)
