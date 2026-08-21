Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8837F47141A
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307393; cv=none; b=GDMNVOtzkRw3NrP5t8f0ayIYhxeJcVlC2bmpqoxtUCLK02QMD+BFmMu7mNaDAd15JfbEeFDpjhXn9l0WYh9tuz/9U16XQt0NvwKJ4zVWS2TOLm93QUZxpnaDNHhOfzh1z82GEuxwfxOeva04NTLNV2L78Yj4VtW0eSrrbXf29t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307393; c=relaxed/simple;
	bh=qpEv2CbLEWWEEbqGfcLXEiV4iyycLOyc6vpwT+dLszc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JekFkaai5POdzqhQZw6JBy4rMlxmc3+zR9r9Ypvx0N7shRUbA+RZuKF/Gb6b4BJJ8QzlTSpqScDZUTpUkVuCfvYea8rqq+B8NWjI/j8X/D7iiORQqECYk5E9aEHmXKd+NHIeTOg1YFXT941UqZ76R8t4srWXd1RCZg6Sh5RgZjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=nNso7Ba1; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="nNso7Ba1"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c169ae1cb26so394956766b.1
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 03:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787307383; x=1787912183; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fr4Rq/MsbLffLnIyqSDI+J/Ttxjt1qVwwdLHnLFN45g=;
        b=nNso7Ba1fqyhuAhKLYQHgWcPnoPwXFW5QYa36ZZ3EWK+l7p7F7nWa8WDaEoZ61XFs+
         IjrY25bvc1hOXAUQy8NTe2nOPCCUYzbAY2cEwZPfjUbtoCk1Kti0Ijw7CkvjwjTU5ZBW
         AjxHXkrwhXbERfukMeZtv4IfU7OLhNFSPYlLxaCge41/YrEk9ovfwh/stBlC5uFyVEfV
         ZTgkXR34D59D4zgYGD1j7rlYUOGiiOALeCneikGRhuZuaATeunpJeqmdpEYSO3AgTV/j
         MJeEmkneXTNZp76O4X0eBxWvovKGMu1IsvGqbMl9tLTf3LBpmy5HwM544c1Hbe3HoYHa
         J9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787307383; x=1787912183;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fr4Rq/MsbLffLnIyqSDI+J/Ttxjt1qVwwdLHnLFN45g=;
        b=gZhupjgW8gDWAFfe+jOAFN9SSY6CtUbmAFo4wE4DESOpqME6WLlPIyz+P/fiBScnll
         TGy8gNBrctFgUEbL+8AO6QeUBYCequ9n42OWUJSTHCFyCY01WY/8sPDOJ2FKMBgnfATM
         0z7a0pcnZkeb6h8yzNdFh2J2fsJRi0AFqK9RHMhxA7R9/YE59uoZLXrLS+DPDPekXoe/
         QUi1S28va20k1Mvu2R1UJ2J3TokmMiImm3Qq+iiYuWzlg/in//P6WXydRCeGOUY64tLj
         EHIXuevkZmQ9T2ZBzhf1f9ZpQtn2gMf6IrnJ9hb0/IgMYUqW8YfRkeNtaNDbp6x56fDf
         YKLg==
X-Gm-Message-State: AFuF++ksyj2dGLBYlpaOlsEbHiWjbrkJM5cbITFfdGPw440tdRf/Kaox
	b8XrWs7L0SOY174kw5MSqU8ZK7nTApF26QsqjGX693eZMqrJFj9z8F8zNhjm038uoG8=
X-Gm-Gg: AR+sD11JDoDbZ9cPeURZ2xeYU5XunDnm4FAfg6q08y/Mt/MYgHIk89qwN0rasCeNzWA
	wJGkZQM5zD6WZBa/QooDVmbY2duHUJQrdp9eW3iS+kNlic7oLThkDpZQMQ43K7EbctR/Ty3XxKw
	2xpPWRy4dLmfBilw3kRkstL/qZL0kY0/Sh4fjt7Ia44w8DgjButnDVDYLoelfcBKQdRR8DQvSVF
	WwSdq/klXwMPyTd1/+m3YPO7Kw+3Fw6ROJWTTwjZ+TdzjX64JQJALnBglwC5eJkg9WZdtvtgs72
	y4zVeck6Vje5t/DMcd/RjoVPPsf+GW8uigQ1NG9h+4Dy7KBQhD+hVlzwBJFJ3qflQCfygRtmPNY
	GwjNI2lvezNYaTqo+fwJEO3B9AYMTBANjd2mMpJBmKNHRc882HXMsWvH+YlePorSCRCkX2mEm5K
	duN0FzyLRqRIehrt0Feu/43ohJe+qEzb6f2+rIE/kXRHnKiZesCPt6Yhig9nQjFECwA2t6N+zH4
	hTmHyf+vg2tj6X9AJE=
X-Received: by 2002:a17:907:ea8a:b0:c21:3c4e:cb9d with SMTP id a640c23a62f3a-c244d7e3862mr883959166b.14.1787307382541;
        Fri, 21 Aug 2026 03:16:22 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2458b096d9sm467937066b.20.2026.08.21.03.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 03:16:22 -0700 (PDT)
Message-ID: <b63cb237-8bc0-4c95-820f-d004433f5577@blackwall.org>
Date: Fri, 21 Aug 2026 13:16:20 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 2/2] bonding: fix u32 overflow in compute_gap()
Content-Language: en-US, bg
To: Hangbin Liu <hangbin.liu@linux.dev>, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hangbin Liu <liuhangbin@kylinos.cn>
References: <20260820-bond_overflow-v4-0-805ba0d3efb6@kylinos.cn>
 <20260820-bond_overflow-v4-2-805ba0d3efb6@kylinos.cn>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260820-bond_overflow-v4-2-805ba0d3efb6@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/08/2026 08:55, Hangbin Liu wrote:
> From: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> The TLB load-tracking fields tx_bytes, load_history, load, and
> unbalanced_load are all u32. At sustained throughput above ~3.2 Gbit/s
> over the 10-second rebalance interval the byte counters wrap, causing
> compute_gap() to produce incorrect gap values and mis-select slaves.
> Such speeds are common on modern NICs under heavy traffic.
> 
> Widen these fields to u64. Use u64_stats_sync to protect the per-cpu
> unbalanced_load_stats against tearing on 32-bit architectures, and
> div_u64() for the 64-bit divisions. The tx_bytes and load_history
> are protected in spin_lock. Also protect the slave load writing in
> bond_alb_monitor() with spin_lock in case of tear on 32-bit.
> 
> Rework compute_gap() to use u64 arithmetic throughout. Return 0 when the
> speed is unknown or the slave is already overloaded.
> 
> Detected by AI code review.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
> ---
>   drivers/net/bonding/bond_alb.c | 65 ++++++++++++++++++++++++++++++------------
>   include/net/bond_alb.h         | 11 +++----
>   2 files changed, 53 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
> index 0afed2c39231..372db54803d3 100644
> --- a/drivers/net/bonding/bond_alb.c
> +++ b/drivers/net/bonding/bond_alb.c
> @@ -6,6 +6,7 @@
>   #include <linux/skbuff.h>
>   #include <linux/netdevice.h>
>   #include <linux/etherdevice.h>
> +#include <linux/ethtool.h>
>   #include <linux/pkt_sched.h>
>   #include <linux/spinlock.h>
>   #include <linux/slab.h>
> @@ -74,8 +75,8 @@ static inline u8 _simple_hash(const u8 *hash_start, int hash_size)
>   static inline void tlb_init_table_entry(struct tlb_client_info *entry, int save_load)
>   {
>   	if (save_load) {
> -		entry->load_history = 1 + entry->tx_bytes /
> -				      BOND_TLB_REBALANCE_INTERVAL;
> +		entry->load_history = 1 + div_u64(entry->tx_bytes,
> +				      BOND_TLB_REBALANCE_INTERVAL);
>   		entry->tx_bytes = 0;
>   	}
>   
> @@ -133,7 +134,7 @@ static int tlb_initialize(struct bonding *bond)
>   	if (!new_hashtbl)
>   		return -ENOMEM;
>   
> -	bond_info->unbalanced_load = alloc_percpu(struct unbalanced_load_stats);
> +	bond_info->unbalanced_load = netdev_alloc_pcpu_stats(struct unbalanced_load_stats);
>   	if (!bond_info->unbalanced_load)
>   		goto out;
>   
> @@ -168,27 +169,38 @@ static void tlb_deinitialize(struct bonding *bond)
>   	spin_unlock_bh(&bond->mode_lock);
>   }
>   
> -static long long compute_gap(struct slave *slave)
> +static u64 compute_gap(struct slave *slave)
>   {
> -	return (s64) (slave->speed << 20) - /* Convert to Megabit per sec */
> -	       (s64) (SLAVE_TLB_INFO(slave).load << 3); /* Bytes to bits */
> +	u64 slave_load = SLAVE_TLB_INFO(slave).load << 3; /* Bytes to bits */
> +	u32 raw_speed = READ_ONCE(slave->speed);
> +	u64 speed = (u64)raw_speed << 20; /* Convert to bits per sec */
> +
> +	/* It's meaningless to compare gap on unknown speed NIC */
> +	if (raw_speed == (u32)SPEED_UNKNOWN)
> +		return 0;
> +
> +	/* Skip slave which is over loaded */
> +	if (speed <= slave_load)
> +		return 0;
> +
> +	return speed - slave_load;
>   }
>   
>   static struct slave *tlb_get_least_loaded_slave(struct bonding *bond)
>   {
>   	struct slave *slave, *least_loaded;
>   	struct list_head *iter;
> -	long long max_gap;
> +	u64 max_gap = 0;
>   
>   	least_loaded = NULL;
> -	max_gap = LLONG_MIN;
>   
>   	/* Find the slave with the largest gap */
>   	bond_for_each_slave_rcu(bond, slave, iter) {
>   		if (bond_slave_can_tx(slave)) {
> -			long long gap = compute_gap(slave);
> +			u64 gap = compute_gap(slave);
>   
> -			if (max_gap < gap) {
> +			/* Make sure we have one available slave */
> +			if (max_gap <= gap) {
>   				least_loaded = slave;
>   				max_gap = gap;

I think Sashiko's review has a point here:
"Does clamping the gap to 0 completely break load balancing when all interfaces
are overloaded?
When all slaves are overloaded, compute_gap() returns 0 for all of them. Since
max_gap is initialized to 0, max_gap <= gap will evaluate to 0 <= 0, which is
true.
This means tlb_get_least_loaded_slave() will continually update least_loaded to
the current slave, ultimately routing all traffic to the last slave in the list
instead of distributing it across the least overloaded interfaces."

That is, compute_gap makes multiple different scenarios look the same:
  if speed is unknown           = 0
  if exactly equal capacity     = 0
  if overloaded by *any* amount = 0

So Sashiko's comment seems correct, it doesn't matter if a slave is overloaded
with 1 gbps or 100, they will look the same.

>   			}
> @@ -1354,8 +1366,14 @@ static netdev_tx_t bond_do_alb_xmit(struct sk_buff *skb, struct bonding *bond,
>   	if (!tx_slave) {
>   		/* unbalanced or unassigned, send through primary */
>   		tx_slave = rcu_dereference(bond->curr_active_slave);
> -		if (bond->params.tlb_dynamic_lb)
> -			this_cpu_add(bond_info->unbalanced_load->tx_bytes, skb->len);
> +		if (bond->params.tlb_dynamic_lb) {
> +			struct unbalanced_load_stats *pcpu_load;
> +
> +			pcpu_load = this_cpu_ptr(bond_info->unbalanced_load);
> +			u64_stats_update_begin(&pcpu_load->syncp);
> +			u64_stats_add(&pcpu_load->tx_bytes, skb->len);
> +			u64_stats_update_end(&pcpu_load->syncp);
> +		}
>   	}
>   
>   	if (tx_slave && bond_slave_can_tx(tx_slave)) {
> @@ -1539,21 +1557,27 @@ netdev_tx_t bond_alb_xmit(struct sk_buff *skb, struct net_device *bond_dev)
>   	return bond_do_alb_xmit(skb, bond, tx_slave);
>   }
>   
> -static u32 reset_unbalanced_load(struct alb_bond_info *bond_info)
> +static u64 reset_unbalanced_load(struct alb_bond_info *bond_info)
>   {
> +	u64 delta, tx_bytes, total_bytes = 0;
>   	struct unbalanced_load_stats *p;
> -	u32 delta, total_bytes = 0;
> +	unsigned int start;
>   	int i;
>   
>   	for_each_possible_cpu(i) {
>   		p = per_cpu_ptr(bond_info->unbalanced_load, i);
> -		total_bytes += READ_ONCE(p->tx_bytes);
> +		do {
> +			start = u64_stats_fetch_begin(&p->syncp);
> +			tx_bytes = u64_stats_read(&p->tx_bytes);
> +		} while (u64_stats_fetch_retry(&p->syncp, start));
> +
> +		total_bytes += tx_bytes;
>   	}
>   
>   	delta = total_bytes - bond_info->prev_total_unbalanced;
>   	bond_info->prev_total_unbalanced = total_bytes;
>   
> -	return delta / BOND_TLB_REBALANCE_INTERVAL;
> +	return div_u64(delta, BOND_TLB_REBALANCE_INTERVAL);
>   }
>   
>   void bond_alb_monitor(struct work_struct *work)
> @@ -1597,8 +1621,13 @@ void bond_alb_monitor(struct work_struct *work)
>   	if (atomic_read(&bond_info->tx_rebalance_counter) >= BOND_TLB_REBALANCE_TICKS) {
>   		bond_for_each_slave_rcu(bond, slave, iter) {
>   			tlb_clear_slave(bond, slave, 1);
> -			if (slave == rcu_access_pointer(bond->curr_active_slave))
> -				SLAVE_TLB_INFO(slave).load = reset_unbalanced_load(bond_info);
> +			if (slave == rcu_access_pointer(bond->curr_active_slave)) {
> +				u64 new_load = reset_unbalanced_load(bond_info);
> +
> +				spin_lock_bh(&bond->mode_lock);
> +				SLAVE_TLB_INFO(slave).load = new_load;
> +				spin_unlock_bh(&bond->mode_lock);
> +			}
>   		}
>   		atomic_set(&bond_info->tx_rebalance_counter, 0);
>   	}
> diff --git a/include/net/bond_alb.h b/include/net/bond_alb.h
> index 6fb09b4fc7e2..32f1981033e4 100644
> --- a/include/net/bond_alb.h
> +++ b/include/net/bond_alb.h
> @@ -57,12 +57,12 @@ struct tlb_client_info {
>   				 * packets to a Client that the Hash function
>   				 * gave this entry index.
>   				 */
> -	u32 tx_bytes;		/* Each Client accumulates the BytesTx that
> +	u64 tx_bytes;		/* Each Client accumulates the BytesTx that
>   				 * were transmitted to it, and after each
>   				 * CallBack the LoadHistory is divided
>   				 * by the balance interval
>   				 */
> -	u32 load_history;	/* This field contains the amount of Bytes
> +	u64 load_history;	/* This field contains the amount of Bytes
>   				 * that were transmitted to this client by
>   				 * the server on the previous balance
>   				 * interval in Bps.
> @@ -118,19 +118,20 @@ struct tlb_slave_info {
>   			 * are the entries that were assigned to use this
>   			 * slave for transmit.
>   			 */
> -	u32 load;	/* Each slave sums the loadHistory of all clients
> +	u64 load;	/* Each slave sums the loadHistory of all clients
>   			 * assigned to it
>   			 */
>   };
>   
>   struct unbalanced_load_stats {
> -	u32			tx_bytes;
> +	u64_stats_t		tx_bytes;
> +	struct u64_stats_sync	syncp;
>   };
>   
>   struct alb_bond_info {
>   	struct tlb_client_info	*tx_hashtbl; /* Dynamically allocated */
>   	struct unbalanced_load_stats __percpu	*unbalanced_load;
> -	u32			prev_total_unbalanced;
> +	u64			prev_total_unbalanced;
>   	atomic_t		tx_rebalance_counter;
>   	int			lp_counter;
>   	/* -------- rlb parameters -------- */
> 

