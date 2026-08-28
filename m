Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D82B38E8D8
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 09:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787908793; cv=none; b=NdOXzPeaN+PY8gRCjoeyAoLuaTQdcxhSi6xxhm/dnxECt6CkebZDyXBQbz77jXWBTGDBQw+2gXJ31FvMznDFhWKO/TTEvt3p7ndEESyROr61OAzgjAxco24lnqHlFX31ykbP3/Tvvv6FGikIx/QHcaBXYEoC3Tik0sacWJ1zVAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787908793; c=relaxed/simple;
	bh=8AMl0DgOuVCoESQEhgGy0vASFdrlJODbc9as/yA7w1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pv2WReVuCwcfE0gwtTbuANfRwP7Eu6sUB9z7SnT8FdQzQkNDlOBKVvOsfBihOGV0q7qQg19eETTegPLpSonjdHskPWm6CKunTrNsRBsFoxvP59H6ITmwSRDLdPG5YKOPmShqtFb6mZW90o/7RnewlVAoFOHSUu0Y4ZdM1vgZzVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=KoeKyOnI; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="KoeKyOnI"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-482e1bfcc63so518593f8f.1
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 02:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787908790; x=1788513590; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GgbYgvU6FsFCVrXLrldDtmmXU/Ton6lhdOtQfDXoVc4=;
        b=KoeKyOnIMkVapAJuJ8n/9Ge3aizouKPsfrklSZB3i7UP/sisYRM7AFzi3KWY07w4jI
         4LwjkyXslf7AyeQnhwkXj0xKJb7kOTNz9788MfJLLaYHt4wkbqRfNq71OhHIXR4UO6GD
         uAXatDlltdXXNmRKoAe7HiOOKASycuRUTxFutyIhgFSIQY/kTm5MMv0KJEyktmmrYJLW
         C5RIXZbzNv/o7vxhCEYH3Ued97R+bqyP5Z0fytEEE5cixHVcmCdS1G1FYuayUJnTkb3O
         yOG79Nu8WBY4hrX1QcdYsc3y+lv4T3VqtNTV+q6sdpsvgXmGe5fu63vrDplqj65JTrJY
         vpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787908790; x=1788513590;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GgbYgvU6FsFCVrXLrldDtmmXU/Ton6lhdOtQfDXoVc4=;
        b=qsbhYWK4mf8LKN9PqE0UGG3XIR38hQg/I1hEqDbm/ikyU5igUV6lVJZtb0wjIv0h/G
         e6GOlw1Tp7+zGPXsEiQ66KZmvwQNlKAusmM7RzLSZnE5hjaLhI39xO4jiFY4RWf82X6b
         pew6UGexAS1MXP0CAQW1mGK0N/K/LPVeWj60qWnAPIIQTu4u0A/S1f5knVE35qZHVTOC
         rNDPm29kfx4Opn0B/NAiDD5ZewZhheeWX5DOlD203r+X9DR9apOI16TyZyusBeFJF8BI
         HrKjF3zr4HGPrRL9qnF+RB5JM/zOgt5XQab6W7V0mQkc+HAA/C3SFbT68VTHxZ3GwTvq
         FO0w==
X-Forwarded-Encrypted: i=1; AHgh+RoW4bNcaGilPjKs81CIbq6eUijPl0cyf7+N0+V1goBJPQhF+/m+90ys4p4ZIFrXlWAl7CaLzek=@vger.kernel.org
X-Gm-Message-State: AFuF++kEx4JAqrfS9QwHguwDg1mjH0Vd+WIYNOtojYx0imD/yGne4BBz
	mA7uW1I7LKw2UxDDQPguAsCQXaBNMB+oGf2DemOpP2Q8ceTkR/gbvcPBIHJxyjodxjBz8T6TWTo
	kRfGoBms=
X-Gm-Gg: AR+sD11eTQCv9pIqlqdabVpvFXsLw46O/3SVXawj4XZbm4+eJdEe9KCGP1VBtvwoy1l
	s/pfEUPsF3LuupA2hDB5gFtYZx69NFrDOS1iJqKYcIPRHO05xceZ1THH40lU20a9ceD5J8QRJSj
	nApNC+igTszzG1zFc7jkFXOCUc2CSbRStFeQAgxOW6KevPK47MMGriRJxdAvlL0hbvLyj4ab+z4
	cnG0Lco2TfFk32J3gyxeJuqxerQ8CjnpZaXyP/SRZO2mzq+Mlb1Vl+Wobgjpi21/ao/BlZNxCBl
	Ux3f91ynsXpjusX24cz3Q+4JZmIve43V4q4M1IS4vTnfrfh7m0RSEunO7JaGRlZPhkwmWjK7wSo
	v/LMFzEctcDNPG3VaFYbf2IkUrsQMdaEsZjwJb7XKlIRJoovLmZBfqcot/kmuKCXBlX9ViDCMOz
	CaaGuSzqYfev5VkR8ElV4iWa6spwCYcDtcEK6pea6JduNgwiKxRS1kFVA/6Ld733ZPRJaV5Nhao
	t2rrLEbwYwxMtOXG9E=
X-Received: by 2002:a05:6000:4553:b0:482:fbb6:1b29 with SMTP id ffacd0b85a97d-482fbb61da0mr2773932f8f.10.1787908789752;
        Fri, 28 Aug 2026 02:19:49 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbac8e61sm2666752f8f.13.2026.08.28.02.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 02:19:49 -0700 (PDT)
Message-ID: <31228099-41a8-4976-acc3-9b320a5012ea@blackwall.org>
Date: Fri, 28 Aug 2026 12:19:47 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 2/2] bonding: fix u32 overflow in compute_gap()
Content-Language: en-US, bg
To: David Laight <david.laight.linux@gmail.com>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
References: <20260825-bond_overflow-v5-0-7a800de133f1@kylinos.cn>
 <20260825-bond_overflow-v5-2-7a800de133f1@kylinos.cn>
 <20260827192048.39ea95e6@pumpkin>
 <9e71daf9-aad4-4c8b-9fc4-7429f62130c7@blackwall.org>
 <20260827215611.1cb9f252@pumpkin>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260827215611.1cb9f252@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/08/2026 23:56, David Laight wrote:
> On Thu, 27 Aug 2026 22:09:04 +0300
> Nikolay Aleksandrov <razor@blackwall.org> wrote:
> 
>> On 27/08/2026 21:20, David Laight wrote:
>>> On Tue, 25 Aug 2026 09:01:30 +0800
>>> Hangbin Liu <hangbin.liu@linux.dev> wrote:
>>>    
>>>> From: Hangbin Liu <liuhangbin@kylinos.cn>
>>>>
>>>> The TLB load-tracking fields tx_bytes, load_history, load, and
>>>> unbalanced_load are all u32. At sustained throughput above ~3.2 Gbit/s
>>>> over the 10-second rebalance interval the byte counters wrap, causing
>>>> compute_gap() to produce incorrect gap values and mis-select slaves.
>>>> Such speeds are common on modern NICs under heavy traffic.
>>>>
>>>> Widen these fields to u64. Use u64_stats_sync to protect the per-cpu
>>>> unbalanced_load_stats against tearing on 32-bit architectures, and
>>>> div_u64() for the 64-bit divisions. The tx_bytes and load_history
>>>> are protected in spin_lock. Also protect the slave load writing in
>>>> bond_alb_monitor() with spin_lock in case of tear on 32-bit.
>>>
>>> How about changing the rebalance interval to either 8 or 16 seconds
>>> to avoid the expensive divide?
>>> Alternatively multiply the other side of the comparisons by the interval,
>>> replacing the expensive divide with a cheap multiply.
>>>
>>> David
>>>    
>>
>> How is that relevant to these patches?
>> And how does that help at all if today that is done at about 10 second interval?
> 
> The 10 seconds is almost certainly completely arbitrary.
> It is relevant because the 64bit divide is significantly expensive on 32bit.
> 
> David
> 

Yeah, that is clear. But currently that recalculation is done once every 10
seconds, such optimizations will be noise. Regardless of that, these changes
are unrelated to the problem he is fixing with the set.

>>
>>>>
>>>> Rework compute_gap() to use s64 arithmetic throughout. Return LLONG_MIN
>>>> when the speed is unknown.
>>>>
>>>> Detected by AI code review.
>>>>
>>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>>> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
>>>> ---
>>>>    drivers/net/bonding/bond_alb.c | 52 ++++++++++++++++++++++++++++++------------
>>>>    include/net/bond_alb.h         | 11 +++++----
>>>>    2 files changed, 44 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
>>>> index 0afed2c39231..9a43a1f47893 100644
>>>> --- a/drivers/net/bonding/bond_alb.c
>>>> +++ b/drivers/net/bonding/bond_alb.c
>>>> @@ -6,6 +6,7 @@
>>>>    #include <linux/skbuff.h>
>>>>    #include <linux/netdevice.h>
>>>>    #include <linux/etherdevice.h>
>>>> +#include <linux/ethtool.h>
>>>>    #include <linux/pkt_sched.h>
>>>>    #include <linux/spinlock.h>
>>>>    #include <linux/slab.h>
>>>> @@ -74,8 +75,8 @@ static inline u8 _simple_hash(const u8 *hash_start, int hash_size)
>>>>    static inline void tlb_init_table_entry(struct tlb_client_info *entry, int save_load)
>>>>    {
>>>>    	if (save_load) {
>>>> -		entry->load_history = 1 + entry->tx_bytes /
>>>> -				      BOND_TLB_REBALANCE_INTERVAL;
>>>> +		entry->load_history = 1 + div_u64(entry->tx_bytes,
>>>> +				      BOND_TLB_REBALANCE_INTERVAL);
>>>>    		entry->tx_bytes = 0;
>>>>    	}
>>>>    
>>>> @@ -133,7 +134,7 @@ static int tlb_initialize(struct bonding *bond)
>>>>    	if (!new_hashtbl)
>>>>    		return -ENOMEM;
>>>>    
>>>> -	bond_info->unbalanced_load = alloc_percpu(struct unbalanced_load_stats);
>>>> +	bond_info->unbalanced_load = netdev_alloc_pcpu_stats(struct unbalanced_load_stats);
>>>>    	if (!bond_info->unbalanced_load)
>>>>    		goto out;
>>>>    
>>>> @@ -170,8 +171,14 @@ static void tlb_deinitialize(struct bonding *bond)
>>>>    
>>>>    static long long compute_gap(struct slave *slave)
>>>>    {
>>>> -	return (s64) (slave->speed << 20) - /* Convert to Megabit per sec */
>>>> -	       (s64) (SLAVE_TLB_INFO(slave).load << 3); /* Bytes to bits */
>>>> +	u32 raw_speed = READ_ONCE(slave->speed);
>>>> +
>>>> +	/* It's meaningless to compare gap on unknown speed NIC */
>>>> +	if (raw_speed == (u32)SPEED_UNKNOWN)
>>>> +		return LLONG_MIN;
>>>> +
>>>> +	return ((s64)raw_speed << 20) - /* Convert to bits per sec */
>>>> +	       ((s64)SLAVE_TLB_INFO(slave).load << 3); /* Bytes to bits */
>>>>    }
>>>>    
>>>>    static struct slave *tlb_get_least_loaded_slave(struct bonding *bond)
>>>> @@ -188,7 +195,7 @@ static struct slave *tlb_get_least_loaded_slave(struct bonding *bond)
>>>>    		if (bond_slave_can_tx(slave)) {
>>>>    			long long gap = compute_gap(slave);
>>>>    
>>>> -			if (max_gap < gap) {
>>>> +			if (!least_loaded || max_gap < gap) {
>>>>    				least_loaded = slave;
>>>>    				max_gap = gap;
>>>>    			}
>>>> @@ -1354,8 +1361,14 @@ static netdev_tx_t bond_do_alb_xmit(struct sk_buff *skb, struct bonding *bond,
>>>>    	if (!tx_slave) {
>>>>    		/* unbalanced or unassigned, send through primary */
>>>>    		tx_slave = rcu_dereference(bond->curr_active_slave);
>>>> -		if (bond->params.tlb_dynamic_lb)
>>>> -			this_cpu_add(bond_info->unbalanced_load->tx_bytes, skb->len);
>>>> +		if (bond->params.tlb_dynamic_lb) {
>>>> +			struct unbalanced_load_stats *pcpu_load;
>>>> +
>>>> +			pcpu_load = this_cpu_ptr(bond_info->unbalanced_load);
>>>> +			u64_stats_update_begin(&pcpu_load->syncp);
>>>> +			u64_stats_add(&pcpu_load->tx_bytes, skb->len);
>>>> +			u64_stats_update_end(&pcpu_load->syncp);
>>>> +		}
>>>>    	}
>>>>    
>>>>    	if (tx_slave && bond_slave_can_tx(tx_slave)) {
>>>> @@ -1539,21 +1552,27 @@ netdev_tx_t bond_alb_xmit(struct sk_buff *skb, struct net_device *bond_dev)
>>>>    	return bond_do_alb_xmit(skb, bond, tx_slave);
>>>>    }
>>>>    
>>>> -static u32 reset_unbalanced_load(struct alb_bond_info *bond_info)
>>>> +static u64 reset_unbalanced_load(struct alb_bond_info *bond_info)
>>>>    {
>>>> +	u64 delta, tx_bytes, total_bytes = 0;
>>>>    	struct unbalanced_load_stats *p;
>>>> -	u32 delta, total_bytes = 0;
>>>> +	unsigned int start;
>>>>    	int i;
>>>>    
>>>>    	for_each_possible_cpu(i) {
>>>>    		p = per_cpu_ptr(bond_info->unbalanced_load, i);
>>>> -		total_bytes += READ_ONCE(p->tx_bytes);
>>>> +		do {
>>>> +			start = u64_stats_fetch_begin(&p->syncp);
>>>> +			tx_bytes = u64_stats_read(&p->tx_bytes);
>>>> +		} while (u64_stats_fetch_retry(&p->syncp, start));
>>>> +
>>>> +		total_bytes += tx_bytes;
>>>>    	}
>>>>    
>>>>    	delta = total_bytes - bond_info->prev_total_unbalanced;
>>>>    	bond_info->prev_total_unbalanced = total_bytes;
>>>>    
>>>> -	return delta / BOND_TLB_REBALANCE_INTERVAL;
>>>> +	return div_u64(delta, BOND_TLB_REBALANCE_INTERVAL);
>>>>    }
>>>>    
>>>>    void bond_alb_monitor(struct work_struct *work)
>>>> @@ -1597,8 +1616,13 @@ void bond_alb_monitor(struct work_struct *work)
>>>>    	if (atomic_read(&bond_info->tx_rebalance_counter) >= BOND_TLB_REBALANCE_TICKS) {
>>>>    		bond_for_each_slave_rcu(bond, slave, iter) {
>>>>    			tlb_clear_slave(bond, slave, 1);
>>>> -			if (slave == rcu_access_pointer(bond->curr_active_slave))
>>>> -				SLAVE_TLB_INFO(slave).load = reset_unbalanced_load(bond_info);
>>>> +			if (slave == rcu_access_pointer(bond->curr_active_slave)) {
>>>> +				u64 new_load = reset_unbalanced_load(bond_info);
>>>> +
>>>> +				spin_lock_bh(&bond->mode_lock);
>>>> +				SLAVE_TLB_INFO(slave).load = new_load;
>>>> +				spin_unlock_bh(&bond->mode_lock);
>>>> +			}
>>>>    		}
>>>>    		atomic_set(&bond_info->tx_rebalance_counter, 0);
>>>>    	}
>>>> diff --git a/include/net/bond_alb.h b/include/net/bond_alb.h
>>>> index 6fb09b4fc7e2..32f1981033e4 100644
>>>> --- a/include/net/bond_alb.h
>>>> +++ b/include/net/bond_alb.h
>>>> @@ -57,12 +57,12 @@ struct tlb_client_info {
>>>>    				 * packets to a Client that the Hash function
>>>>    				 * gave this entry index.
>>>>    				 */
>>>> -	u32 tx_bytes;		/* Each Client accumulates the BytesTx that
>>>> +	u64 tx_bytes;		/* Each Client accumulates the BytesTx that
>>>>    				 * were transmitted to it, and after each
>>>>    				 * CallBack the LoadHistory is divided
>>>>    				 * by the balance interval
>>>>    				 */
>>>> -	u32 load_history;	/* This field contains the amount of Bytes
>>>> +	u64 load_history;	/* This field contains the amount of Bytes
>>>>    				 * that were transmitted to this client by
>>>>    				 * the server on the previous balance
>>>>    				 * interval in Bps.
>>>> @@ -118,19 +118,20 @@ struct tlb_slave_info {
>>>>    			 * are the entries that were assigned to use this
>>>>    			 * slave for transmit.
>>>>    			 */
>>>> -	u32 load;	/* Each slave sums the loadHistory of all clients
>>>> +	u64 load;	/* Each slave sums the loadHistory of all clients
>>>>    			 * assigned to it
>>>>    			 */
>>>>    };
>>>>    
>>>>    struct unbalanced_load_stats {
>>>> -	u32			tx_bytes;
>>>> +	u64_stats_t		tx_bytes;
>>>> +	struct u64_stats_sync	syncp;
>>>>    };
>>>>    
>>>>    struct alb_bond_info {
>>>>    	struct tlb_client_info	*tx_hashtbl; /* Dynamically allocated */
>>>>    	struct unbalanced_load_stats __percpu	*unbalanced_load;
>>>> -	u32			prev_total_unbalanced;
>>>> +	u64			prev_total_unbalanced;
>>>>    	atomic_t		tx_rebalance_counter;
>>>>    	int			lp_counter;
>>>>    	/* -------- rlb parameters -------- */
>>>>   
>>>    
>>
> 

