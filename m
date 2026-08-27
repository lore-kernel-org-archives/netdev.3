Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3650A38C2D1
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787857752; cv=none; b=FiRkNHZaX6/DMgb25+o/H8YJa4IQobsTzv2fGc3i2F9CyVtoum1xqNDCDs5FDbgUeM1hjvogDuP6xiavWR/LfUjeOr9yBaRzWYIWh3dq3UrFCdbX0lydEhd/dDYg1jsqYWdV4OsqyxKS9kcbNIADyQjswJhVlb2MvB95yPvDIus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787857752; c=relaxed/simple;
	bh=i01fEhTlPtxQyoNW7mklqMP5iYwZSxTMRSj6P4yQlJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T3RIVb67hy4NAm7t1J/ThbgOfMQh5UA2TiG2VIh/E4F4nHGmserY712YGy515POexeaPBdGrSqpsfW8lcpWONyJtFH1Prx+KcLaJiNEhZEZGeuxEqDSPcEhBgHiTBO/L5oTCrq2b8mvBAesmmUnZkMT7IMKb9gpfOUpqAhIA9es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=ULOFJe0T; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="ULOFJe0T"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-499840a2575so587285e9.3
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 12:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787857746; x=1788462546; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=djHyE1ruR5RlEBgoR9g1dHL9cBhxtknf2/63Rky3tpc=;
        b=ULOFJe0TLpZVpw9T94yx56zPvVG+d9C+hR77++sT71lwZvpylNDiBKT88wzBVefC24
         9PmZnWCH+Z8wEHG5ZVPYl/561ddkenFEIb637d3710T12bDZw9cpDadCoU1wPG+UZhLh
         RWTrzP9MAd6gKTZ1egc3/aGfhTSsnjBqI1uDBn0zfASRmr6GvJMZkyWWsdtugdjG7iTv
         CV6+Oz43NWAub9+h2q1k2nxJnZ0qhKXX3F8hKnczDj4Xl96Zc7IzUoT1tUyJhQzwS6Xo
         6wnzVGIqRi3ISZV6BVwpAonoVa865ZLtCW4GdoD4F9Nbo2u3pcWijP8govCprl2c+CHb
         0eKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787857746; x=1788462546;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=djHyE1ruR5RlEBgoR9g1dHL9cBhxtknf2/63Rky3tpc=;
        b=Kap12JeKT0EJdOrPzQPryc/0K6PgQWjbMm8y9YVcIu3uHo7Fgkx+8HXGVnE24Zvxd2
         r3BoExrAjFX0dD1UFo/gdr8cZcFH+lyTwV8TD4nzo63UmWg310/B9khIBLj8JTqr6UbZ
         ilabZRQXEUFd3ZcY3xXMfC7MyiLia28Z+KewMEQYJvyaBhP09xBhPuLPxpAJmCTDtBzi
         zHkSGaC1nYyeHntFAYNK7lUaQ71n+HbaLn6TRb0EIPM2Gd7y12o81McD68LOXO2iBMGA
         d1nBldrGBvhanH89WSWYY3tGXsb51MD0zF5G9MeLQbqs97967dIu2JTaWETCNl6vsVG3
         8h9w==
X-Forwarded-Encrypted: i=1; AHgh+RrdWVTIaBOQMp0W2P9hbBi4f09Zr/Ku/WHyXmiEbHmmpKVrpCdYqY+diZ6ARGv0E0F4vSnksfY=@vger.kernel.org
X-Gm-Message-State: AFuF++m+vXRRywar8JielD/btmjwd3O5rjHGlLJnFXWL4Ljc6CMwx/Mb
	vaKLigNVjICWq+8u1G0yimEnixCDwB5eXS0KSwyekf+rlGr9NmVwZ8Em+gmqCMbkPBc=
X-Gm-Gg: AR+sD12VR5sOzfKVqk16P6pVKOv+XB93eBtyn1w31L6Fzpwvm+4bPsetH3Tu2h88c7p
	LUiCGuIqdaj60fvGMrT7uCWUC+nYspNIcUnLzhq6A7MpyQCMWV+k7dQh3opkbQM9F8SK7MPNSV8
	8OJECXalpZTxBoVNBmAHl49cbBqd1fph9PNIcp7lfWz9fPjyvAPV6xh4EnV4jGLmKg7e9TLZblP
	ntw6soABHdUvbhUQW9ISVEvkEx2pLJoB0s6M23pFLN+VV/I0zty5m9Ba4H8CQpIXFyLK3HHGunb
	FcKDBt5tAlT+RZ5p2QCwEmO/VYMkS7nrU9PijJ4zcw6CB5M5AZdNYM9rl7bSRz70ZdImsDIBVAR
	Iav08FK0/JijWSXoL6fs4lEtadwNw/WTiN4k0y32IUlE4f7ywwuJ8TtOdp6+WtKa1zvwX2ytnu2
	ePwdXR3X6IQyTEmPmEanroLuZFSdTPjLQ9ACZpfSlx2RJJ+CciEicnWm4OvOcoak3heR02lSmnx
	OnJ1TNpLKFSd0QrHTM=
X-Received: by 2002:a05:600c:1f91:b0:499:bf8c:cfd1 with SMTP id 5b1f17b1804b1-49b91c1c784mr17002155e9.2.1787857746306;
        Thu, 27 Aug 2026 12:09:06 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e28e8499sm11330585f8f.26.2026.08.27.12.09.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 12:09:05 -0700 (PDT)
Message-ID: <9e71daf9-aad4-4c8b-9fc4-7429f62130c7@blackwall.org>
Date: Thu, 27 Aug 2026 22:09:04 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 2/2] bonding: fix u32 overflow in compute_gap()
Content-Language: en-US, bg
To: David Laight <david.laight.linux@gmail.com>,
 Hangbin Liu <hangbin.liu@linux.dev>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
References: <20260825-bond_overflow-v5-0-7a800de133f1@kylinos.cn>
 <20260825-bond_overflow-v5-2-7a800de133f1@kylinos.cn>
 <20260827192048.39ea95e6@pumpkin>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260827192048.39ea95e6@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/08/2026 21:20, David Laight wrote:
> On Tue, 25 Aug 2026 09:01:30 +0800
> Hangbin Liu <hangbin.liu@linux.dev> wrote:
> 
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
>> div_u64() for the 64-bit divisions. The tx_bytes and load_history
>> are protected in spin_lock. Also protect the slave load writing in
>> bond_alb_monitor() with spin_lock in case of tear on 32-bit.
> 
> How about changing the rebalance interval to either 8 or 16 seconds
> to avoid the expensive divide?
> Alternatively multiply the other side of the comparisons by the interval,
> replacing the expensive divide with a cheap multiply.
> 
> David
> 

How is that relevant to these patches?
And how does that help at all if today that is done at about 10 second interval?

>>
>> Rework compute_gap() to use s64 arithmetic throughout. Return LLONG_MIN
>> when the speed is unknown.
>>
>> Detected by AI code review.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
>> ---
>>   drivers/net/bonding/bond_alb.c | 52 ++++++++++++++++++++++++++++++------------
>>   include/net/bond_alb.h         | 11 +++++----
>>   2 files changed, 44 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
>> index 0afed2c39231..9a43a1f47893 100644
>> --- a/drivers/net/bonding/bond_alb.c
>> +++ b/drivers/net/bonding/bond_alb.c
>> @@ -6,6 +6,7 @@
>>   #include <linux/skbuff.h>
>>   #include <linux/netdevice.h>
>>   #include <linux/etherdevice.h>
>> +#include <linux/ethtool.h>
>>   #include <linux/pkt_sched.h>
>>   #include <linux/spinlock.h>
>>   #include <linux/slab.h>
>> @@ -74,8 +75,8 @@ static inline u8 _simple_hash(const u8 *hash_start, int hash_size)
>>   static inline void tlb_init_table_entry(struct tlb_client_info *entry, int save_load)
>>   {
>>   	if (save_load) {
>> -		entry->load_history = 1 + entry->tx_bytes /
>> -				      BOND_TLB_REBALANCE_INTERVAL;
>> +		entry->load_history = 1 + div_u64(entry->tx_bytes,
>> +				      BOND_TLB_REBALANCE_INTERVAL);
>>   		entry->tx_bytes = 0;
>>   	}
>>   
>> @@ -133,7 +134,7 @@ static int tlb_initialize(struct bonding *bond)
>>   	if (!new_hashtbl)
>>   		return -ENOMEM;
>>   
>> -	bond_info->unbalanced_load = alloc_percpu(struct unbalanced_load_stats);
>> +	bond_info->unbalanced_load = netdev_alloc_pcpu_stats(struct unbalanced_load_stats);
>>   	if (!bond_info->unbalanced_load)
>>   		goto out;
>>   
>> @@ -170,8 +171,14 @@ static void tlb_deinitialize(struct bonding *bond)
>>   
>>   static long long compute_gap(struct slave *slave)
>>   {
>> -	return (s64) (slave->speed << 20) - /* Convert to Megabit per sec */
>> -	       (s64) (SLAVE_TLB_INFO(slave).load << 3); /* Bytes to bits */
>> +	u32 raw_speed = READ_ONCE(slave->speed);
>> +
>> +	/* It's meaningless to compare gap on unknown speed NIC */
>> +	if (raw_speed == (u32)SPEED_UNKNOWN)
>> +		return LLONG_MIN;
>> +
>> +	return ((s64)raw_speed << 20) - /* Convert to bits per sec */
>> +	       ((s64)SLAVE_TLB_INFO(slave).load << 3); /* Bytes to bits */
>>   }
>>   
>>   static struct slave *tlb_get_least_loaded_slave(struct bonding *bond)
>> @@ -188,7 +195,7 @@ static struct slave *tlb_get_least_loaded_slave(struct bonding *bond)
>>   		if (bond_slave_can_tx(slave)) {
>>   			long long gap = compute_gap(slave);
>>   
>> -			if (max_gap < gap) {
>> +			if (!least_loaded || max_gap < gap) {
>>   				least_loaded = slave;
>>   				max_gap = gap;
>>   			}
>> @@ -1354,8 +1361,14 @@ static netdev_tx_t bond_do_alb_xmit(struct sk_buff *skb, struct bonding *bond,
>>   	if (!tx_slave) {
>>   		/* unbalanced or unassigned, send through primary */
>>   		tx_slave = rcu_dereference(bond->curr_active_slave);
>> -		if (bond->params.tlb_dynamic_lb)
>> -			this_cpu_add(bond_info->unbalanced_load->tx_bytes, skb->len);
>> +		if (bond->params.tlb_dynamic_lb) {
>> +			struct unbalanced_load_stats *pcpu_load;
>> +
>> +			pcpu_load = this_cpu_ptr(bond_info->unbalanced_load);
>> +			u64_stats_update_begin(&pcpu_load->syncp);
>> +			u64_stats_add(&pcpu_load->tx_bytes, skb->len);
>> +			u64_stats_update_end(&pcpu_load->syncp);
>> +		}
>>   	}
>>   
>>   	if (tx_slave && bond_slave_can_tx(tx_slave)) {
>> @@ -1539,21 +1552,27 @@ netdev_tx_t bond_alb_xmit(struct sk_buff *skb, struct net_device *bond_dev)
>>   	return bond_do_alb_xmit(skb, bond, tx_slave);
>>   }
>>   
>> -static u32 reset_unbalanced_load(struct alb_bond_info *bond_info)
>> +static u64 reset_unbalanced_load(struct alb_bond_info *bond_info)
>>   {
>> +	u64 delta, tx_bytes, total_bytes = 0;
>>   	struct unbalanced_load_stats *p;
>> -	u32 delta, total_bytes = 0;
>> +	unsigned int start;
>>   	int i;
>>   
>>   	for_each_possible_cpu(i) {
>>   		p = per_cpu_ptr(bond_info->unbalanced_load, i);
>> -		total_bytes += READ_ONCE(p->tx_bytes);
>> +		do {
>> +			start = u64_stats_fetch_begin(&p->syncp);
>> +			tx_bytes = u64_stats_read(&p->tx_bytes);
>> +		} while (u64_stats_fetch_retry(&p->syncp, start));
>> +
>> +		total_bytes += tx_bytes;
>>   	}
>>   
>>   	delta = total_bytes - bond_info->prev_total_unbalanced;
>>   	bond_info->prev_total_unbalanced = total_bytes;
>>   
>> -	return delta / BOND_TLB_REBALANCE_INTERVAL;
>> +	return div_u64(delta, BOND_TLB_REBALANCE_INTERVAL);
>>   }
>>   
>>   void bond_alb_monitor(struct work_struct *work)
>> @@ -1597,8 +1616,13 @@ void bond_alb_monitor(struct work_struct *work)
>>   	if (atomic_read(&bond_info->tx_rebalance_counter) >= BOND_TLB_REBALANCE_TICKS) {
>>   		bond_for_each_slave_rcu(bond, slave, iter) {
>>   			tlb_clear_slave(bond, slave, 1);
>> -			if (slave == rcu_access_pointer(bond->curr_active_slave))
>> -				SLAVE_TLB_INFO(slave).load = reset_unbalanced_load(bond_info);
>> +			if (slave == rcu_access_pointer(bond->curr_active_slave)) {
>> +				u64 new_load = reset_unbalanced_load(bond_info);
>> +
>> +				spin_lock_bh(&bond->mode_lock);
>> +				SLAVE_TLB_INFO(slave).load = new_load;
>> +				spin_unlock_bh(&bond->mode_lock);
>> +			}
>>   		}
>>   		atomic_set(&bond_info->tx_rebalance_counter, 0);
>>   	}
>> diff --git a/include/net/bond_alb.h b/include/net/bond_alb.h
>> index 6fb09b4fc7e2..32f1981033e4 100644
>> --- a/include/net/bond_alb.h
>> +++ b/include/net/bond_alb.h
>> @@ -57,12 +57,12 @@ struct tlb_client_info {
>>   				 * packets to a Client that the Hash function
>>   				 * gave this entry index.
>>   				 */
>> -	u32 tx_bytes;		/* Each Client accumulates the BytesTx that
>> +	u64 tx_bytes;		/* Each Client accumulates the BytesTx that
>>   				 * were transmitted to it, and after each
>>   				 * CallBack the LoadHistory is divided
>>   				 * by the balance interval
>>   				 */
>> -	u32 load_history;	/* This field contains the amount of Bytes
>> +	u64 load_history;	/* This field contains the amount of Bytes
>>   				 * that were transmitted to this client by
>>   				 * the server on the previous balance
>>   				 * interval in Bps.
>> @@ -118,19 +118,20 @@ struct tlb_slave_info {
>>   			 * are the entries that were assigned to use this
>>   			 * slave for transmit.
>>   			 */
>> -	u32 load;	/* Each slave sums the loadHistory of all clients
>> +	u64 load;	/* Each slave sums the loadHistory of all clients
>>   			 * assigned to it
>>   			 */
>>   };
>>   
>>   struct unbalanced_load_stats {
>> -	u32			tx_bytes;
>> +	u64_stats_t		tx_bytes;
>> +	struct u64_stats_sync	syncp;
>>   };
>>   
>>   struct alb_bond_info {
>>   	struct tlb_client_info	*tx_hashtbl; /* Dynamically allocated */
>>   	struct unbalanced_load_stats __percpu	*unbalanced_load;
>> -	u32			prev_total_unbalanced;
>> +	u64			prev_total_unbalanced;
>>   	atomic_t		tx_rebalance_counter;
>>   	int			lp_counter;
>>   	/* -------- rlb parameters -------- */
>>
> 

