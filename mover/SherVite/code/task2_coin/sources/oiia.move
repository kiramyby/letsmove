/*
/// Module: task2_coin
module task2_coin::task2_coin;
*/

// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions



module task2_coin::oiia{
   use sui::coin::{Self, create_currency,TreasuryCap};
   use std::option::{some};
   use sui::transfer::{public_transfer, public_freeze_object};
   use sui::url::{Self, Url};

   public struct OIIA has drop{}
   
   fun init(oiia: OIIA,ctx: &mut TxContext) {
     let url = url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/SherVite/picture/refs/heads/main/oiia.png");
     let oiia_coin = some<Url>(url);
 
     let (treasury, coin_metadata) = create_currency(
       oiia,
       8,
       b"OIIA",
       b"OIIA",
       b"Hello,Mr.Coin!",
       oiia_coin,
       ctx
     );
     public_freeze_object(coin_metadata);
     public_transfer(treasury, ctx.sender());
   }

     // 公共入口函数：铸币并转账（用户可调用）
    public entry fun mint_and_transfer(
        treasury_cap: &mut TreasuryCap<OIIA>, 
        recipient: address,  // 接收者地址
        amount: u64,         // 铸币数量
        ctx: &mut TxContext   // 交易上下文
    ) {
        // 调用框架铸币函数（需确保 OIIA 是合法货币类型）
        let coin = coin::mint(treasury_cap, amount, ctx);  // 铸币
        public_transfer(coin, recipient);  // 转账
    }

}



