Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214623B2FF6
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046137; cv=none; b=PKedCFIsCw1Yaxlts/GRgNdTXe8IPSi6QP0uGPanBc4zR+ByeiZob76y9V/K5WsebPt9fghvqpg+R/q1k8JlAyYqKHHIxfSY4R+7EeIqNPA9us7jZ4CfFJRG5z8lbF0yvR1GkPCEdCnRf7wGepcvhsTu+fjefERSfkGi0BoNao4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046137; c=relaxed/simple;
	bh=kkmFd5j2SrN9y5eoZVrCZOE5zgAjz5TProZMHrKJEaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BpmDJCH9taYuKColHI1C8/LAOEiYh1mvAF3zz5blMU7aqgsaI88Sk0VWJxlmk3i8cSk2JiJolfvrCLu0Jzjk2NgZILjbYh8EmmDu++FscmflvgWibJmU51+GEaVDGBm22gTPz4laHV72touOiR3NwEyW50vyTjEfdiXgqcn7TtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=oOMmTKyF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="oOMmTKyF"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so42329505e9.1
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 02:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787046132; x=1787650932; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A26iULHivlajh+3MA1uO0Cksntrf1DSGsgfSv8mZ+Uo=;
        b=oOMmTKyFW6Mq2yaH6dRb8Bn4Hb6TA0fmqq/YLEhwPyXYDWMLmUHvVxwRQfEhl6YxWV
         eI0rf2GPgRQIS0Tb12HHRUY43XPrJa51V530ZRtiOxxPoAid5y0AY8BmaOE7DZccl2Au
         NXafgr6CLeL2zNE7PUcF3GTQRVpPStMDTPBZLBLZp9kno/o132qxNj/eq8k6fFP770Lo
         mRWJpTOX2q8jLEnVvdWQrM45J15eN6gApgwM8cfKX0faqNs2x1KVD6CdQEAniwjturZR
         e5yxhYHYSsxRiOe30PDjAae7hV3/9AA2In74h96h0Bp808wDcDBnxF5IehbwNIvBNSGQ
         cLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787046132; x=1787650932;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A26iULHivlajh+3MA1uO0Cksntrf1DSGsgfSv8mZ+Uo=;
        b=IwEmAp+ebbqcRC5JyVs1kueonsyWgRZKWz4NvLEHrUBhGMp/se6fjpMvh3lLS9pf/9
         W+CyiFb2Fd8Nw14vnTMAmqNLZDR6vP6Gh03aX8ix2jjMnOCbW9dy8OjnZ5g/NhCqkcSc
         ysFwGf9iVoAUqplMKd8r+KB8ysttEHFvMbSuFjoDhSsv2dKqvCUl4R6JY5H7Y7U3wTQv
         4k5UfUYm0i/kVqwvG7QhSTmFuA6KiGX3hHvRs6DFJ+NKj+ewxhCT/C81e1LsA+D8brrs
         DFmp7A28E3Uw0wi3iIMfNULH14VfdKKc0pgbhJtaiTV9sBqynYVBNFjplAqEHGDmOpT+
         VLcw==
X-Gm-Message-State: AOJu0YwPDmMMcQvDrJri3LCMiiXXhQhoGiZG6EKfoj4/tkqdAObM9eCD
	V2QQNRHYlDkjG7xCnXbGA1UGc66HGsOeWcfUg7E9208wzfT7Nslo2TtsVWsoXJxvLbE=
X-Gm-Gg: AR+sD13FVnMLscCW0stBQreBI8AO6kJiiaXYyvg3sbb52VRcYurUsC6HXAdI6zssZb/
	m+DCenYtyxoXTxvsSB5CbHGRiklsdWIKPQzE7iYaQfepDb+/lhlerCcEriqOBn8DR6EwiBOhAI3
	RmffLE8MKtjVMDELc0tw4pOdojZBXHjqH1/6uDEXXaB/9mOOGpCJHNWZEqsRfzopzWA2jcq7xsM
	9ciHQtLtkJpLyeqsiqdhuLULM90obNjamD9LTzdSOmE2BKeYVMIGimeVv1BrpWww0pQir9qbkDO
	XnLsQG62KDCF5lpZvb3AUll12xJDRMZHcQIuazMawGtskH/URaO3SKUkrOSoTz8SP5I/NWLhGt/
	h7wqlGhY1aLqaBI0H0UZFylq7JHUH1pwfz2bXFVfi29RdaWXR3+gYv4d1+o8vX3DF3u8W6Pgr9n
	iYjAosfTZzcQy0J59h0ddrAvA3F4dQTxOR4lMlLDfaCN1Latq6cxsEkrtaMks4XRrWOUMEMf1jA
	NWWP5bET7qCB2f1vyo=
X-Received: by 2002:a05:600c:3485:b0:499:726a:a017 with SMTP id 5b1f17b1804b1-49987938e19mr523413195e9.1.1787046132061;
        Tue, 18 Aug 2026 02:42:12 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999d10b7f6sm114382215e9.12.2026.08.18.02.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 02:42:11 -0700 (PDT)
Message-ID: <fb48d9f3-f0f8-4532-aa4f-de8fa1a13f6a@blackwall.org>
Date: Tue, 18 Aug 2026 12:42:10 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/2] bonding: convert unbalanced_load to per-cpu
 state
Content-Language: en-US, bg
To: Hangbin Liu <hangbin.liu@linux.dev>, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hangbin Liu <liuhangbin@kylinos.cn>
References: <20260818-bond_overflow-v3-0-e05d4dbc2fd8@kylinos.cn>
 <20260818-bond_overflow-v3-1-e05d4dbc2fd8@kylinos.cn>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260818-bond_overflow-v3-1-e05d4dbc2fd8@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/08/2026 11:47, Hangbin Liu wrote:
> From: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> A later patch widens the bonding TLB tx counters from u32 to u64. The
> unbalanced_load counter sits in the transmit hot path, and cross-CPU
> synchronization of a u64 would introduce measurable overhead. Convert
> unbalanced_load to a per-cpu counter first so that the subsequent
> widening only touches per-cpu data local to each CPU.
> 
> Introduce struct unbalanced_load_stats to hold the per-cpu counter,
> and move the aggregation into a helper, reset_unbalanced_load(), which
> sums and clears all per-cpu instances.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
> ---
>   drivers/net/bonding/bond_alb.c  | 25 ++++++++++++++++++-------
>   drivers/net/bonding/bond_main.c |  9 +++++++++
>   include/net/bond_alb.h          |  6 +++++-
>   3 files changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
> index 839f7482dc18..d54d834cf72b 100644
> --- a/drivers/net/bonding/bond_alb.c
> +++ b/drivers/net/bonding/bond_alb.c
> @@ -1345,7 +1345,7 @@ static netdev_tx_t bond_do_alb_xmit(struct sk_buff *skb, struct bonding *bond,
>   		/* unbalanced or unassigned, send through primary */
>   		tx_slave = rcu_dereference(bond->curr_active_slave);
>   		if (bond->params.tlb_dynamic_lb)
> -			bond_info->unbalanced_load += skb->len;
> +			this_cpu_add(bond_info->unbalanced_load->tx_bytes, skb->len);
>   	}
>   
>   	if (tx_slave && bond_slave_can_tx(tx_slave)) {
> @@ -1529,6 +1529,21 @@ netdev_tx_t bond_alb_xmit(struct sk_buff *skb, struct net_device *bond_dev)
>   	return bond_do_alb_xmit(skb, bond, tx_slave);
>   }
>   
> +static u32 reset_unbalanced_load(struct alb_bond_info *bond_info)
> +{
> +	struct unbalanced_load_stats *p;
> +	u32 total_bytes = 0;
> +	int i;
> +
> +	for_each_possible_cpu(i) {
> +		p = per_cpu_ptr(bond_info->unbalanced_load, i);
> +		total_bytes += READ_ONCE(p->tx_bytes);
> +		WRITE_ONCE(p->tx_bytes, 0);
> +	}
> +
> +	return total_bytes / BOND_TLB_REBALANCE_INTERVAL;
> +}
> +
>   void bond_alb_monitor(struct work_struct *work)
>   {
>   	struct bonding *bond = container_of(work, struct bonding,
> @@ -1570,12 +1585,8 @@ void bond_alb_monitor(struct work_struct *work)
>   	if (atomic_read(&bond_info->tx_rebalance_counter) >= BOND_TLB_REBALANCE_TICKS) {
>   		bond_for_each_slave_rcu(bond, slave, iter) {
>   			tlb_clear_slave(bond, slave, 1);
> -			if (slave == rcu_access_pointer(bond->curr_active_slave)) {
> -				SLAVE_TLB_INFO(slave).load =
> -					bond_info->unbalanced_load /
> -						BOND_TLB_REBALANCE_INTERVAL;
> -				bond_info->unbalanced_load = 0;
> -			}
> +			if (slave == rcu_access_pointer(bond->curr_active_slave))
> +				SLAVE_TLB_INFO(slave).load = reset_unbalanced_load(bond_info);
>   		}
>   		atomic_set(&bond_info->tx_rebalance_counter, 0);
>   	}
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 522eab060f9e..9fb44e0031c8 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -5995,6 +5995,7 @@ static void bond_destructor(struct net_device *bond_dev)
>   		destroy_workqueue(bond->wq);
>   
>   	free_percpu(bond->rr_tx_counter);
> +	free_percpu(bond->alb_info.unbalanced_load);
>   }
>   
>   void bond_setup(struct net_device *bond_dev)
> @@ -6494,6 +6495,10 @@ static int bond_init(struct net_device *bond_dev)
>   	if (!bond->wq)
>   		return -ENOMEM;
>   
> +	bond->alb_info.unbalanced_load = alloc_percpu(struct unbalanced_load_stats);
> +	if (!bond->alb_info.unbalanced_load)
> +		goto wq_out;
> +

The bond doesn't generally depend on this struct and shouldn't fail to init
if it fails to allocate and the user hasn't chosen alb mode. Also here is too
early to tell, the netlink mode hasn't been applied yet.
Maybe the allocation could be moved to bond_alb_initialize and the freeing to
bond_alb_deinitialize?

>   	bond->notifier_ctx = false;
>   
>   	spin_lock_init(&bond->stats_lock);
> @@ -6511,6 +6516,10 @@ static int bond_init(struct net_device *bond_dev)
>   		eth_hw_addr_random(bond_dev);
>   
>   	return 0;
> +
> +wq_out:
> +	destroy_workqueue(bond->wq);
> +	return -ENOMEM;
>   }
>   
>   unsigned int bond_get_num_tx_queues(void)
> diff --git a/include/net/bond_alb.h b/include/net/bond_alb.h
> index e5945427f38d..3fabf4714dec 100644
> --- a/include/net/bond_alb.h
> +++ b/include/net/bond_alb.h
> @@ -123,9 +123,13 @@ struct tlb_slave_info {
>   			 */
>   };
>   
> +struct unbalanced_load_stats {
> +	u32			tx_bytes;
> +};
> +
>   struct alb_bond_info {
>   	struct tlb_client_info	*tx_hashtbl; /* Dynamically allocated */
> -	u32			unbalanced_load;
> +	struct unbalanced_load_stats __percpu	*unbalanced_load;
>   	atomic_t		tx_rebalance_counter;
>   	int			lp_counter;
>   	/* -------- rlb parameters -------- */
> 

