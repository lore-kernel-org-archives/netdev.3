Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C0D364927
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 23:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789773597; cv=none; b=cVyk0szGsJG82AF6Y9PBN4tVtAELtDn8VoB8Pk+LEW6C06EVZOCYf9s54jx6sHiS2aSL32GOnYrktqWJiPhmUJDNgXP2kgcNn7N8q6x4EHJ0z53QrIcDLK9KvXLgOIfRMq6J1zqsGh7QoUILe2zDIHvesdZLbaoadhZXwI277gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789773597; c=relaxed/simple;
	bh=vARS/3knvUsU4b/cVCoW3GXJgodSVt4k2P0YBjWpF00=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BPETEGi6lG7lJtST9WqFQwrY99b/CXNjPoJzjmJHls9oUGsZjHBxj9gfrXd0Vhe3oN9INjvbEVc29uS1yiTHh/kRDwrEAzncyQ7gUnsuz/BT6GZsWPZo9wz53NKXOjujx4aOc+pUlGankLWkTkKKBSWxAAd+kDMvqGCUCVvGB14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I83DaF5P; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I83DaF5P"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39512608fb1so2851670a91.1
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 16:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789773595; x=1790378395; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JM4a7HpwdvvTFXDRMuSLag7m/DY/RJJcKvE8uSAXN+8=;
        b=I83DaF5PGmS3Y4ME9yp1fzMTLDEEgTSc1kp/qVFpa6BjvNjoPN00E7BRoalRNfmG/1
         aooZKeRtyS8IjuCBHXHzg5oFMathaLS4sreRNiXxEUQIHr2JcY4HuJ4fHYoQKIDHPwYy
         4voVSCmHOeGmXx2XatceRF6m7w3cQkSAd3lvHvvR/Mlh8duq7whuYdd/5PkFDflCYaGb
         xnfmHZzGYDrKOlzNdGRyETMmfqxnc2gfx1FCqko5Isobk3iudTGiFR2y1fWuxsGJob5p
         ESBErR/mbvdps2NkyKPEhEKVLUCdcEFlCKGqEdfZ0xFLDyJVF8cNAaRyrnElW13JG9Ec
         OeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789773595; x=1790378395;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JM4a7HpwdvvTFXDRMuSLag7m/DY/RJJcKvE8uSAXN+8=;
        b=Fj0W+5hnpMCSZAExHWXgnR0CDHiq1CqCQTFO+RIeby07Iy4PHMHZbA4kSRFU9rpoUU
         JYzomsJBeHFlBI5B81YAUa8mrDf53StftalPPBrxBCwCgITtORo/PUPqDVg4zIE99AJ6
         OZZOjA/8bj5bLHRjODBuwhfF2V42rGTKrFmq0wTR9jNElqWcdOh2aSr1wmr6EEYaDVle
         nIfBdaYq4fCakJcUZM/7q5J0ZBRaaWftFSk+5uCro8xeJchonjIqFkiBtQ7eGQS6kNaY
         kByhknW2uTTxaYj4W8H+H1DPvO/dE+x688MzRl3A0RAEIpt9L3vSCp/Oc5ET0x3uWgt2
         8l7Q==
X-Forwarded-Encrypted: i=1; AKwUvBz7rqjWZyKrmQLgWfJVIz1myzS7IoJkUmM/oNnS4QgrWdwl9EIqGNeIPALLin1B6SDWnxFGfkg=@vger.kernel.org
X-Gm-Message-State: AFuF++kqoIMa6h3vEcaDi0RBHbTccFdv0Qxf8q66mL9HK+kHYb+b2Q5r
	qy85jLPo29ZvPC28Em5VBb6fonNSbV9S1hKwFpGDN7IqFIoD3EedrvXPurWCyH2Xtkiv6VEszIJ
	772OPbw==
X-Received: from pjsc23.prod.google.com ([2002:a17:90a:bf17:b0:3a0:2168:3570])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:50cb:b0:39b:370e:c807
 with SMTP id 98e67ed59e1d1-39e54ea68e7mr8682668a91.17.1789773594938; Fri, 18
 Sep 2026 16:19:54 -0700 (PDT)
Date: Fri, 18 Sep 2026 23:18:59 +0000
In-Reply-To: <20260914075604.120183-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260914075604.120183-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918231954.4049829-1-kuniyu@google.com>
Subject: Re: [PATCH net] net: neighbour: Serialize proxy timer teardown
From: Kuniyuki Iwashima <kuniyu@google.com>
To: runyu.xiao@seu.edu.cn
Cc: davem@davemloft.net, den@openvz.org, edumazet@google.com, horms@kernel.org, 
	jianhao.xu@seu.edu.cn, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Mon, 14 Sep 2026 15:56:04 +0800
> __neigh_ifdown() purges device-specific entries and then checks
> whether the shared proxy queue is empty before deleting proxy_timer. A
> concurrent ARP or NDISC request can enqueue a delayed proxy response
> between the check and timer_delete_sync(). The timer deletion can then
> leave the new skb queued without a timer to process it.
> 
> Serialize proxy queue insertion and timer rearming with the purge, empty
> check, and timer deletion. The timer callback does not take the new lock,
> so timer_delete_sync() can still wait for an in-flight callback. Keep
> timer_delete_sync() rather than timer_shutdown_sync(), since the timer is
> reused after per-device and carrier teardown.
> 
> A controlled QEMU test with explicit 5 ms schedule injection reproduced

Could you provide the repro ?


> the orphaned queue state on the unfixed kernel and did not reproduce it
> with this change. Natural-load runs reached both paths but did not
> trigger the narrow race.
> 
> Fixes: 66ba215cb513 ("neigh: fix possible DoS due to net iface start/stop loop")
> Assisted-by: LLM Codex
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  include/net/neighbour.h | 2 ++
>  net/core/neighbour.c    | 6 ++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/include/net/neighbour.h b/include/net/neighbour.h
> index 8860cc2175fc1..15107c00b4df4 100644
> --- a/include/net/neighbour.h
> +++ b/include/net/neighbour.h
> @@ -239,6 +239,8 @@ struct neigh_table {
>  	struct list_head	gc_list;
>  	struct list_head	managed_list;
>  	spinlock_t		lock;
> +	/* Serializes proxy timer rearming with teardown. */
> +	spinlock_t		proxy_timer_lock;
>  	unsigned long		last_rand;
>  	struct neigh_statistics	__percpu *stats;
>  	struct neigh_hash_table __rcu *nht;
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 1349c0eedb642..1ea794a541efb 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -471,10 +471,13 @@ static int __neigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
>  	spin_unlock_bh(&tbl->lock);
>  
>  	pneigh_ifdown(tbl, dev, skip_perm);
> +	/* The callback does not take this lock, so sync deletion can wait for it. */
> +	spin_lock_bh(&tbl->proxy_timer_lock);
>  	pneigh_queue_purge(&tbl->proxy_queue, dev ? dev_net(dev) : NULL,
>  			   tbl->family);
>  	if (skb_queue_empty_lockless(&tbl->proxy_queue))
>  		timer_delete_sync(&tbl->proxy_timer);
> +	spin_unlock_bh(&tbl->proxy_timer_lock);
>  	return 0;
>  }
>  
> @@ -1729,6 +1732,7 @@ void pneigh_enqueue(struct neigh_table *tbl, struct neigh_parms *p,
>  	NEIGH_CB(skb)->sched_next = sched_next;
>  	NEIGH_CB(skb)->flags |= LOCALLY_ENQUEUED;
>  
> +	spin_lock_bh(&tbl->proxy_timer_lock);
>  	spin_lock(&tbl->proxy_queue.lock);

Isn't is resolved by simply checking if dev is down here ?



>  	if (timer_delete(&tbl->proxy_timer)) {
>  		if (time_before(tbl->proxy_timer.expires, sched_next))
> @@ -1740,6 +1744,7 @@ void pneigh_enqueue(struct neigh_table *tbl, struct neigh_parms *p,
>  	p->qlen++;
>  	mod_timer(&tbl->proxy_timer, sched_next);
>  	spin_unlock(&tbl->proxy_queue.lock);
> +	spin_unlock_bh(&tbl->proxy_timer_lock);
>  }
>  EXPORT_SYMBOL(pneigh_enqueue);
>  
> @@ -1858,6 +1863,7 @@ void neigh_table_init(int index, struct neigh_table *tbl)
>  		WARN_ON(tbl->entry_size % NEIGH_PRIV_ALIGN);
>  
>  	spin_lock_init(&tbl->lock);
> +	spin_lock_init(&tbl->proxy_timer_lock);
>  	mutex_init(&tbl->phash_lock);
>  
>  	INIT_DEFERRABLE_WORK(&tbl->gc_work, neigh_periodic_work);
> -- 
> 2.34.1
