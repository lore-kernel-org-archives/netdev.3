Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A314457A3
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046256; cv=none; b=tw8BuG+yk4VS6hShWFd8mSzZHfE1dmhwYp8kXvJsWKczgkoPyHz1PSj89fkewd6NpVPYeIZzFRFA6SaujgCMuTPmfhqTTyL4uxnGdkGLOM/1pnxy9oqtmAfwVHAtfYMDV0AfFky3vcHRCPnJrHLsk7NNYHKvKKVaaeNCaw6YKjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046256; c=relaxed/simple;
	bh=3cd45OFNfXfJkI0VZJd+o59+9U32aPuAuSRU1gtN/Cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DKK6fGJKQM9DJotHeSBAqAOS3+IG+MnNLFck5wFRRrLstXHkCAKXH0tlpo6Xb4h6X5/TJwkEBzs2G1ba9dp8JVhUIe6o6kHyeutp714VdTlxIYI0wU3V2mJ6122bX42QGsPJZIMpFPXElPhKkzBw2pLzlnNev56jK6K5GnjLg6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=hA/lpNQS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="hA/lpNQS"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49800c6a846so51631475e9.3
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 02:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787046253; x=1787651053; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cf+NX4DOn3hFmTpqv5tZVPBkp5TK++qd0YXkdQ8iVHA=;
        b=hA/lpNQSZ8sU/jkim9fIux9V/OfatvpNfRA3S8BcIzJRY3Sj/rBqlI3p2mz1ArENPJ
         o4tR6r160b8Dy/pZclMcGwqLSmf4FmTk2GUR7f88QPn9d2hJvKRPIBa97QFsv3Ibbdku
         98THGluz2xIpEcYjxFdf27s6hPetlwoIj9ZSUNReXzdVqC1Qd7dA8Irwy0LnI9KTjksI
         nDsY0QZe6r08OFFiinDEeSMHShNdNCvkiyy+In6quj736UJL3/2ETboJcl0ciPjsTw6a
         Bu1F7waP4em9KzPRbqDWY9DqwL+Vcsppi5JPLh663mm6c/L/DcNBtNmk53/xZbdSKzEF
         4z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787046253; x=1787651053;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cf+NX4DOn3hFmTpqv5tZVPBkp5TK++qd0YXkdQ8iVHA=;
        b=bsVfaiIiy2d66HTWO7AOvBYVPhbWMGweaMPc3AmNzusXmPmOqhYpDHOv2d1bD5dWIc
         UxebEiprzktgB2XY/4BSFS6WEuXlt2ZCE5D3i/vH9m5N3Mg+qDMyBYKnYKfG8WrY9C4C
         sP5/vR/7IsOjHIqqygjwX40hndO+rzIWlnlP6m0CCHbtIOOEJx1iiL1OnqxSB1FZIEcH
         IcPO7soguJPZekP4bq13VNzKcdqmOqhgGRe+I1vhjiaGbXSS1bgDBII4pE9hqkfjIiub
         fFNnuxUSMlsRebsxH1NUHI9ijxER/+5Dy/EdSULWaaYTnUcKtTFBzNoSJtDZqk73cuaD
         BrJg==
X-Gm-Message-State: AOJu0YzzqmNKcMuWRA4eNm2G4PoKIN0LsMnUBuM52pZ/27Q1pxwylF6T
	eIL7f24myJgkhhsOZWtXDAAbcuVam08imFzeGb7aTxcPZqRQ/zlQis0kWWsXihLRC9Y=
X-Gm-Gg: AR+sD11Vop43gJ0ZrP1QxNl0jxwGNtp/nocsv+QuiBk6AUyaLnbLd/8tERP7nFujjMJ
	w4cxva9Sk+Ib9+XqcscIeKHoPeCr/dPze01aM2bTBbu1wnN1AH9IkbBTX+57SbbxzXGdTFFjNlI
	0QhlI1eGKWE9OJ6OgeEpoyiPgZ6HCUppI78WdTPdzU6avep+PLv3AoEgvXBIHFJWrep9rMnw69U
	hyJnMlUCpHQus9GUccpAHUeMt6E/spOdDbSBgWNDGlPAWA1z2kIc/fDMc/JlFMtertdOv9AWH7i
	bHomoSZGcJwD8yS7DWzDuXdzRbyg3zFtzICRB59I9RPiPsHtDkH6dUMM/fQgcZQCfPY+VYb6SMa
	Gbwx5uOOt7nyS9ZcTH8baqRmZx2JcMr0hvNpUEt21hQ9UZS0B/jLtq6+O1naUiosDkRa0igZKuz
	TyT4c5Fnih4LsdkaJJvnylBDifjnRXBeifVN1BsiNImW6a+/YKCnFM0djLIkF5IL647SJ7B4jth
	A7ES+9E8nRm2HwCZfU=
X-Received: by 2002:a05:600c:17d1:b0:495:7a04:b006 with SMTP id 5b1f17b1804b1-49987948adamr320919055e9.8.1787046252368;
        Tue, 18 Aug 2026 02:44:12 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999610ecf4sm184961095e9.7.2026.08.18.02.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 02:44:11 -0700 (PDT)
Message-ID: <d75e0db1-e129-4a9f-a103-889827948de1@blackwall.org>
Date: Tue, 18 Aug 2026 12:44:10 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/2] bonding: fix u32 overflow in compute_gap()
Content-Language: en-US, bg
To: Hangbin Liu <hangbin.liu@linux.dev>, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hangbin Liu <liuhangbin@kylinos.cn>
References: <20260818-bond_overflow-v3-0-e05d4dbc2fd8@kylinos.cn>
 <20260818-bond_overflow-v3-2-e05d4dbc2fd8@kylinos.cn>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260818-bond_overflow-v3-2-e05d4dbc2fd8@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/08/2026 11:47, Hangbin Liu wrote:
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
> div_u64() for the 64-bit divisions. The tx_bytes, load, and load_history
> are protected in spin_lock.
> 
> Rework compute_gap() to use u64 arithmetic throughout. Return 0 when the
> speed is unknown or the slave is already overloaded.
> 
> Detected by AI code review.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
> ---
>   drivers/net/bonding/bond_alb.c  | 56 ++++++++++++++++++++++++++++++-----------
>   drivers/net/bonding/bond_main.c |  2 +-
>   include/net/bond_alb.h          |  9 ++++---
>   3 files changed, 47 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
> index d54d834cf72b..659a77323444 100644
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
> @@ -158,25 +159,35 @@ static void tlb_deinitialize(struct bonding *bond)
>   	spin_unlock_bh(&bond->mode_lock);
>   }
>   
> -static long long compute_gap(struct slave *slave)
> +static u64 compute_gap(struct slave *slave)
>   {
> -	return (s64) (slave->speed << 20) - /* Convert to Megabit per sec */
> -	       (s64) (SLAVE_TLB_INFO(slave).load << 3); /* Bytes to bits */
> +	u32 raw_speed = READ_ONCE(slave->speed);
> +	u64 speed = (u64)raw_speed;
> +
> +	/* It's meaningless to compare gap on unknown speed NIC */
> +	if (raw_speed == (u32)SPEED_UNKNOWN)
> +		return 0;
> +
> +	/* skip slave which is over loaded */
> +	if ((speed << 20) <= (SLAVE_TLB_INFO(slave).load << 3))
> +		return 0;
> +
> +	return (speed << 20) - /* Convert to Megabit per sec */
> +	       (SLAVE_TLB_INFO(slave).load << 3); /* Bytes to bits */
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
>   			if (max_gap < gap) {
>   				least_loaded = slave;
> @@ -1344,8 +1355,14 @@ static netdev_tx_t bond_do_alb_xmit(struct sk_buff *skb, struct bonding *bond,
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

this still races with...

> +		}
>   	}
>   
>   	if (tx_slave && bond_slave_can_tx(tx_slave)) {
> @@ -1529,19 +1546,28 @@ netdev_tx_t bond_alb_xmit(struct sk_buff *skb, struct net_device *bond_dev)
>   	return bond_do_alb_xmit(skb, bond, tx_slave);
>   }
>   
> -static u32 reset_unbalanced_load(struct alb_bond_info *bond_info)
> +static u64 reset_unbalanced_load(struct alb_bond_info *bond_info)
>   {
>   	struct unbalanced_load_stats *p;
> -	u32 total_bytes = 0;
> +	u64 tx_bytes, total_bytes = 0;
> +	unsigned int start;
>   	int i;
>   
>   	for_each_possible_cpu(i) {
>   		p = per_cpu_ptr(bond_info->unbalanced_load, i);
> -		total_bytes += READ_ONCE(p->tx_bytes);
> -		WRITE_ONCE(p->tx_bytes, 0);
> +		do {
> +			start = u64_stats_fetch_begin(&p->syncp);
> +			tx_bytes = u64_stats_read(&p->tx_bytes);
> +		} while (u64_stats_fetch_retry(&p->syncp, start));
> +
> +		u64_stats_update_begin(&p->syncp);
> +		u64_stats_set(&p->tx_bytes, 0);
> +		u64_stats_update_end(&p->syncp);

... this here, as u64_stats_update_begin doesn't provide exclusive access, so writers
must do that themselves, so you can't be sure what value will end up, the zeroing
might not work at all and can get overwritten

> +
> +		total_bytes += tx_bytes;
>   	}
>   
> -	return total_bytes / BOND_TLB_REBALANCE_INTERVAL;
> +	return div_u64(total_bytes, BOND_TLB_REBALANCE_INTERVAL);
>   }
>   
>   void bond_alb_monitor(struct work_struct *work)
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 9fb44e0031c8..4c4d9bf71e0c 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -6495,7 +6495,7 @@ static int bond_init(struct net_device *bond_dev)
>   	if (!bond->wq)
>   		return -ENOMEM;
>   
> -	bond->alb_info.unbalanced_load = alloc_percpu(struct unbalanced_load_stats);
> +	bond->alb_info.unbalanced_load = netdev_alloc_pcpu_stats(struct unbalanced_load_stats);
>   	if (!bond->alb_info.unbalanced_load)
>   		goto wq_out;
>   
> diff --git a/include/net/bond_alb.h b/include/net/bond_alb.h
> index 3fabf4714dec..51c083c76115 100644
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
> @@ -118,13 +118,14 @@ struct tlb_slave_info {
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
> 

