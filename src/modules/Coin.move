address 0x2 {
    module Coin {
        struct Coin {
            value: u64,
        }

        public fun mint(value: u64): Coin {
            Coin { value }
        }

        public fun value(coin: &Coin): u64 {
            coin.value
        }

        public fun addCoin(coin: &mut Coin, addedCoin: Coin): u64 {
            let Coin { value } = addedCoin;
            coin.value = coin.value + value;
            coin.value
        }

        public fun splitCoin(coin: &mut Coin, value: u64): Coin {
            coin.value = coin.value - value;
            Coin { value }
        }

        public fun burn(coin: Coin): u64 {
            let Coin {value} = coin;
            value
        }
    }
}