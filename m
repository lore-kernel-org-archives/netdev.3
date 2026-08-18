Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FED43FD2D
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 11:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051208; cv=none; b=Om3QNGCveuUclt3jxUmzvkk9eSS62MG3JHUAoYrBNEkQV2dK/eDRzc8dcTOcmRT1xl5ZQFGVsiVJMqU6a7q/whS29xocovKldo5PPcoHIJE2naeDP/5vGfTxv8OYuvhzijy7EQ2NeQ+WbM/zON9ZYP8rkR1DiDuD34XZt6Xlpvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051208; c=relaxed/simple;
	bh=KT+WgK+WAaVEOYJ89qJBMx5F8ryY4tyc9uUt/pWitkQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ij/Yc6mmd2kjbkOFGDHH+M8vVNY/7rIW0ggeXsP19HFKDDuHIBXm7lOH0RVT+JHFUYDBK6KIJB7ayO5u+IQUsYaa9O7uvmlvPCF2+Ml0qxTsr/MzHi35YqbDQj0+u/iePz8dsO3/7w5MdzoPtBB2Jb827o+XSQQytHLSev/GrZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=WdnVzjvW; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="WdnVzjvW"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so38554845e9.1
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 04:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787051205; x=1787656005; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=de5WuvT/qntfy/becZEfGEn1k6iEkRXmNAaQdoP3Lgg=;
        b=WdnVzjvWORoMkp4SBVkRS1dgGUJnXQ71NZtYBTaZgYgquqX4f2hX4/YgiSGMZGOUvz
         DqQKJNlUohO83GZ1hgkjTw8qqY52KHIkRdQd12RTbmlPUxrY4IIAAkFC4LjConwvkVQ6
         VO9abPLJtSJL+jKYVrMyuI/1NbumpkvwTKQMtRXlx6/wVIZrSERHa9cqUQWTUEK9I8li
         XfMLg836WeBuokZv1ol9rVxTO/BE06S2PKIAiP4TwyKXE98NL9AZcOz18g2HKxX0oZI6
         BtjFMYGbnxEf707tbRK6+0HWbmN+5laExPkn9Us6cHz1I5IFxWkCOFcNA7j7lm6Fdhde
         utIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787051205; x=1787656005;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=de5WuvT/qntfy/becZEfGEn1k6iEkRXmNAaQdoP3Lgg=;
        b=szG90P0b7IXvPw/BUMuahPOG0AqhaXCvqTCWkpRCql44OLaxJ1aFmLjMo56t9IDgsS
         Mk/i11YkJqiDkLDkACGgR9Rlvms0dFhHtdxmChHzbndwwL4SNwrp5j6C7cMsErCfLBGi
         lBWb365GUgQuyLEADcLFYPI1NUGkYJHGouXFyWT+gfSs1I4ciLI7uBw9JM50gJUBKqgp
         ZEYrDdoV3VwgZ+77bW/hTiAMPS1NAt9clPE3mUpQrodjlubvHfw6mTj/bCIti2yjHZv4
         q4qsX/tzhHVOr7mhyRSKRVBwFM6Rrwbhjo1q7pGQuEhlIA9F/DL9XMmj2VkFdoo2TMtK
         nZVg==
X-Gm-Message-State: AOJu0YzPHl7BwjnsnItGoNrvjvtq9nm4XBtBGbmj0RubfabMjAxOUPnO
	uSTBDkws5fMZhGwFjVxyd1mJIlKARY/j8RNj1spNa5E7W/PT8u2JQQh/D6xgJP4UaTk=
X-Gm-Gg: AR+sD10C+miTBny+NFJjLVtD57J1qPH+XfnFIjwZH4bQmNJ5+1uxZ70t0fn6Px1cDr0
	acnVkjxa2cxQKPv7O/X2VdSIlu3Df0Gbr3LJFmY4msxzSKLRop4DP1xlux1UylRsiTjLKGiferU
	lNDpY0Ax9NSRDU4DU4f65cHu/kJq5bIIvaYr198AJinNE05nOdgvJSR5RTCbxoBNFfwo0x2BfOI
	ba+uC4q5J5RL3NxSHCv7P4W1W9PDTl3XH8syVKmK7nZVzNrRunuZ1WE0B4c/0jyuq8lsE4SvaWn
	RbfCscBpWMYc3kNnpvTlypinEpVWm1Yps4xX2f4qlguaV22fdQPYda/t+5SS62nXQ+7p+gY0vVk
	nGwkVTFFDLegTXaZP09k3ZkgaUUiaJPASJ18TzZktjee2fg1jVX5fKE+6+6qvcYsHGkxBMLc9m7
	3XQRB+/dTEhVhlVixo3SMmN0pPIWgjyK5pVBGT8C+DJO8WDcdVOM24HXIDuBLO2qb2683a9WbX2
	LyuujYIqxGhTS8Spzs=
X-Received: by 2002:a05:600c:8107:b0:499:60bf:c6f7 with SMTP id 5b1f17b1804b1-499879665ffmr549789545e9.13.1787051204919;
        Tue, 18 Aug 2026 04:06:44 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999d061637sm113065145e9.1.2026.08.18.04.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 04:06:44 -0700 (PDT)
Message-ID: <80d704a8-aca6-44f8-8933-eb0cf14ecf3b@blackwall.org>
Date: Tue, 18 Aug 2026 14:06:43 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/2] bonding: fix u32 overflow in compute_gap()
Content-Language: en-US, bg
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Hangbin Liu <hangbin.liu@linux.dev>, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hangbin Liu <liuhangbin@kylinos.cn>
References: <20260818-bond_overflow-v3-0-e05d4dbc2fd8@kylinos.cn>
 <20260818-bond_overflow-v3-2-e05d4dbc2fd8@kylinos.cn>
 <d75e0db1-e129-4a9f-a103-889827948de1@blackwall.org>
In-Reply-To: <d75e0db1-e129-4a9f-a103-889827948de1@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/08/2026 12:44, Nikolay Aleksandrov wrote:
> On 18/08/2026 11:47, Hangbin Liu wrote:
>> From: Hangbin Liu <liuhangbin@kylinos.cn>
>>
>> The TLB load-tracking fields tx_bytes, load_history, load, and
>> unbalanced_load are all u32. At sustained throughput above ~3.2 Gbit/s
>> over the 10-second rebalance interval the byte counters wrap, causing
>> compute_gap() to produce incorrect gap values and mis-select slaves.
>> Such speeds are common on modern NICs under heavy traffic.
>>
>> Widen these fields to u64. Use u64_stats_sync to protect the per-cpu
>> unbalanced_load_stats against tearing on 32-bit architectures, and
>> div_u64() for the 64-bit divisions. The tx_bytes, load, and load_history
>> are protected in spin_lock.
>>
>> Rework compute_gap() to use u64 arithmetic throughout. Return 0 when the
>> speed is unknown or the slave is already overloaded.
>>
>> Detected by AI code review.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
>> ---
>>   drivers/net/bonding/bond_alb.c  | 56 ++++++++++++++++++++++++++++++-----------
>>   drivers/net/bonding/bond_main.c |  2 +-
>>   include/net/bond_alb.h          |  9 ++++---
>>   3 files changed, 47 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
>> index d54d834cf72b..659a77323444 100644
>> --- a/drivers/net/bonding/bond_alb.c
>> +++ b/drivers/net/bonding/bond_alb.c
>> @@ -6,6 +6,7 @@
>>   #include <linux/skbuff.h>
>>   #include <linux/netdevice.h>
>>   #include <linux/etherdevice.h>
>> +#include <linux/ethtool.h>
>>   #include <linux/pkt_sched.h>
>>   #include <linux/spinlock.h>
>>   #include <linux/slab.h>
>> @@ -74,8 +75,8 @@ static inline u8 _simple_hash(const u8 *hash_start, int hash_size)
>>   static inline void tlb_init_table_entry(struct tlb_client_info *entry, int save_load)
>>   {
>>       if (save_load) {
>> -        entry->load_history = 1 + entry->tx_bytes /
>> -                      BOND_TLB_REBALANCE_INTERVAL;
>> +        entry->load_history = 1 + div_u64(entry->tx_bytes,
>> +                      BOND_TLB_REBALANCE_INTERVAL);
>>           entry->tx_bytes = 0;
>>       }
>> @@ -158,25 +159,35 @@ static void tlb_deinitialize(struct bonding *bond)
>>       spin_unlock_bh(&bond->mode_lock);
>>   }
>> -static long long compute_gap(struct slave *slave)
>> +static u64 compute_gap(struct slave *slave)
>>   {
>> -    return (s64) (slave->speed << 20) - /* Convert to Megabit per sec */
>> -           (s64) (SLAVE_TLB_INFO(slave).load << 3); /* Bytes to bits */
>> +    u32 raw_speed = READ_ONCE(slave->speed);
>> +    u64 speed = (u64)raw_speed;
>> +
>> +    /* It's meaningless to compare gap on unknown speed NIC */
>> +    if (raw_speed == (u32)SPEED_UNKNOWN)
>> +        return 0;
>> +
>> +    /* skip slave which is over loaded */
>> +    if ((speed << 20) <= (SLAVE_TLB_INFO(slave).load << 3))
>> +        return 0;
>> +
>> +    return (speed << 20) - /* Convert to Megabit per sec */
>> +           (SLAVE_TLB_INFO(slave).load << 3); /* Bytes to bits */
>>   }
>>   static struct slave *tlb_get_least_loaded_slave(struct bonding *bond)
>>   {
>>       struct slave *slave, *least_loaded;
>>       struct list_head *iter;
>> -    long long max_gap;
>> +    u64 max_gap = 0;
>>       least_loaded = NULL;
>> -    max_gap = LLONG_MIN;
>>       /* Find the slave with the largest gap */
>>       bond_for_each_slave_rcu(bond, slave, iter) {
>>           if (bond_slave_can_tx(slave)) {
>> -            long long gap = compute_gap(slave);
>> +            u64 gap = compute_gap(slave);
>>               if (max_gap < gap) {
>>                   least_loaded = slave;
>> @@ -1344,8 +1355,14 @@ static netdev_tx_t bond_do_alb_xmit(struct sk_buff *skb, struct bonding *bond,
>>       if (!tx_slave) {
>>           /* unbalanced or unassigned, send through primary */
>>           tx_slave = rcu_dereference(bond->curr_active_slave);
>> -        if (bond->params.tlb_dynamic_lb)
>> -            this_cpu_add(bond_info->unbalanced_load->tx_bytes, skb->len);
>> +        if (bond->params.tlb_dynamic_lb) {
>> +            struct unbalanced_load_stats *pcpu_load;
>> +
>> +            pcpu_load = this_cpu_ptr(bond_info->unbalanced_load);
>> +            u64_stats_update_begin(&pcpu_load->syncp);
>> +            u64_stats_add(&pcpu_load->tx_bytes, skb->len);
>> +            u64_stats_update_end(&pcpu_load->syncp);
> 
> this still races with...
> 
>> +        }
>>       }
>>       if (tx_slave && bond_slave_can_tx(tx_slave)) {
>> @@ -1529,19 +1546,28 @@ netdev_tx_t bond_alb_xmit(struct sk_buff *skb, struct net_device *bond_dev)
>>       return bond_do_alb_xmit(skb, bond, tx_slave);
>>   }
>> -static u32 reset_unbalanced_load(struct alb_bond_info *bond_info)
>> +static u64 reset_unbalanced_load(struct alb_bond_info *bond_info)
>>   {
>>       struct unbalanced_load_stats *p;
>> -    u32 total_bytes = 0;
>> +    u64 tx_bytes, total_bytes = 0;
>> +    unsigned int start;
>>       int i;
>>       for_each_possible_cpu(i) {
>>           p = per_cpu_ptr(bond_info->unbalanced_load, i);
>> -        total_bytes += READ_ONCE(p->tx_bytes);
>> -        WRITE_ONCE(p->tx_bytes, 0);
>> +        do {
>> +            start = u64_stats_fetch_begin(&p->syncp);
>> +            tx_bytes = u64_stats_read(&p->tx_bytes);
>> +        } while (u64_stats_fetch_retry(&p->syncp, start));
>> +
>> +        u64_stats_update_begin(&p->syncp);
>> +        u64_stats_set(&p->tx_bytes, 0);
>> +        u64_stats_update_end(&p->syncp);
> 
> ... this here, as u64_stats_update_begin doesn't provide exclusive access, so writers
> must do that themselves, so you can't be sure what value will end up, the zeroing
> might not work at all and can get overwritten
> 

I meant - it doesn't improve on the current situation where it can also happen. :)

>> +
>> +        total_bytes += tx_bytes;
>>       }
>> -    return total_bytes / BOND_TLB_REBALANCE_INTERVAL;
>> +    return div_u64(total_bytes, BOND_TLB_REBALANCE_INTERVAL);
>>   }
>>   void bond_alb_monitor(struct work_struct *work)
>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>> index 9fb44e0031c8..4c4d9bf71e0c 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -6495,7 +6495,7 @@ static int bond_init(struct net_device *bond_dev)
>>       if (!bond->wq)
>>           return -ENOMEM;
>> -    bond->alb_info.unbalanced_load = alloc_percpu(struct unbalanced_load_stats);
>> +    bond->alb_info.unbalanced_load = netdev_alloc_pcpu_stats(struct unbalanced_load_stats);
>>       if (!bond->alb_info.unbalanced_load)
>>           goto wq_out;
>> diff --git a/include/net/bond_alb.h b/include/net/bond_alb.h
>> index 3fabf4714dec..51c083c76115 100644
>> --- a/include/net/bond_alb.h
>> +++ b/include/net/bond_alb.h
>> @@ -57,12 +57,12 @@ struct tlb_client_info {
>>                    * packets to a Client that the Hash function
>>                    * gave this entry index.
>>                    */
>> -    u32 tx_bytes;        /* Each Client accumulates the BytesTx that
>> +    u64 tx_bytes;        /* Each Client accumulates the BytesTx that
>>                    * were transmitted to it, and after each
>>                    * CallBack the LoadHistory is divided
>>                    * by the balance interval
>>                    */
>> -    u32 load_history;    /* This field contains the amount of Bytes
>> +    u64 load_history;    /* This field contains the amount of Bytes
>>                    * that were transmitted to this client by
>>                    * the server on the previous balance
>>                    * interval in Bps.
>> @@ -118,13 +118,14 @@ struct tlb_slave_info {
>>                * are the entries that were assigned to use this
>>                * slave for transmit.
>>                */
>> -    u32 load;    /* Each slave sums the loadHistory of all clients
>> +    u64 load;    /* Each slave sums the loadHistory of all clients
>>                * assigned to it
>>                */
>>   };
>>   struct unbalanced_load_stats {
>> -    u32            tx_bytes;
>> +    u64_stats_t        tx_bytes;
>> +    struct u64_stats_sync    syncp;
>>   };
>>   struct alb_bond_info {
>>
> 

