Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793654513;
	b=nAmKbL3SBVeSNV2HPC8oCQSk8sgBtNTToe24U5qWOXpEidG5ZwCCM9Jc45N5iSmac5S7
	 YDXX6V5AtA0aLTgCUMPu0vlwFgZF7daZubyUOi6ECPmYgjHvZaTREriLoxRerCM6az7hb
	 pmkrn7og9XTtXXzm3UibTD8FmOssZWYTUXnI10/+Wod4PzhHlB/LrLci0yLSMNZ6Ludf6
	 kpvc8OGWllhxT4tud9JsvTsdU3ejKJoWXfytWGYflImeX20jVclLB930Hz69gimu+b/62
	 IG7qYFfIsiqgblLaaeXT8dIMtwSmp3ASXJv594KRAWRbOZaPSN0Fnyb5paxWDZKylng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654513;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=VAbq9svnWCK4DRMfT8aPGrr8RGfp3IRq1MIe8Xy239E=;
	b=XwhDRYrKc64clWFcHmbqjxVih/9Pklj0ZkAg54bjats23z5aMXu/8t+FP8ulz5R14SbD
	 rKIrlzqPx7JRHtncDJ75sbxYww+hlsjMi0cODBrDerJ02DxjSCm65BhkVOctlf+tS8k8Z
	 WkZf+7JBTyymFlVuaD8wry2OZtL+cDA2gc3vMkEXo8A/RaIQUVYx1MEoyqW8lKD5oQpbi
	 dKFDoSSXH5040DXe2jhN80tm8Xeb4cF/595W4DUfsRI6Pk6VFyI4V5M+XixPCnm5S0lKe
	 Z5I1Uf5C5jRhb2WdYGyfeSwmGzmvz4E1Ercb21xPKTLc+24rLE2CAzyNpZH1HxBgr5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rax1RgUY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0192C606A324;
	Mon,  2 Nov 2026 21:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rax1RgUY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1880A1F00A16;
	Mon,  2 Nov 2026 21:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793654512;
	bh=VAbq9svnWCK4DRMfT8aPGrr8RGfp3IRq1MIe8Xy239E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Rax1RgUY/sAIsHi4bGWzMELIxVYybxlMasUo8bTGvboPgooJfKoNPRNA1oieNQYFp
	 A7kjAjtdQlmf8tHvwqOO5k0uSfBJRiPkEgXwCS1Ds76BlBpPG0aES6avlOcnwG3jG9
	 UEj5UQ3IuFiqd0ei4OtJAbuL+UozV+zzQkYtKbvSyH95fvabzr3IhHabq636p2KUmU
	 BKHOhTpfjVp7lZbH0ypr4x4DGFcs1Sjz5ljyB+POGKDcbR3qAqIw6kkCrKp0ePzcuc
	 yczD852b9+sdLatBsmaon0VoXey3rFzmgKKFRFNrDhD/IP55O5oO6gjL+enOq389hm
	 zIWwquv6tDbwg==
Subject:
 Re: [PATCH net v7] net: stop defer_count outliving the deferred-free list
From: netdev-bot+sashiko@kernel.org
To: jkain@nuro.ai
Cc: edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, netdev@vger.kernel.org, horms@kernel.org,
 kuniyu@google.com, sdf.kernel@gmail.com, kerneljasonxing@gmail.com,
 willemb@google.com, almasrymina@google.com, mkarsten@uwaterloo.ca,
 jiayuan.chen@linux.dev, linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 21:21:51 +0000
Message-ID: <179365451164.3131.3767942488983292@kernel.org>
In-Reply-To: <20261029211101.2089535-1-jkain@nuro.ai>
References: <20261029211101.2089535-1-jkain@nuro.ai>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] __skb_defer_free_flush() (net/core/dev.c) now holds the whole
  drained batch's reservation on sdn->defer_count until every detached…

Pre-existing issues:
- [Medium] A runtime change to net.core.skb_defer_max can leave a
  per-(cpu, node) defer queue at or above the new limit with no purge…
- [Low] Documentation/admin-guide/sysctl/net.rst (lines 362-368)
  describes skb_defer_max as the "Max size (in skbs) of the per-cpu list…

--

net: stop defer_count outliving the deferred-free list

This commit changes the deferred skb free accounting. A rejected free now
undoes its own defer_count increment, and __skb_defer_free_flush()
subtracts the number of drained skbs instead of resetting the counter to
zero. It also allows admission up to defer_max and adds a remote kick when
the reserved count reaches defer_max.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 3ac700d37e596..f5ed0ecf534ac 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -7073,16 +7073,22 @@ static void __skb_defer_free_flush(struct skb_defer_node *sdn, int budget)
>  {
>  	struct llist_node *free_list;
>  	struct sk_buff *skb, *next;
> +	long n = 0;
>  
>  	if (llist_empty(&sdn->defer_list))
>  		return;
> -	atomic_long_set(&sdn->defer_count, 0);
>  	free_list = llist_del_all(&sdn->defer_list);
>  
>  	llist_for_each_entry_safe(skb, next, free_list, ll_node) {
>  		prefetch(next);
>  		napi_consume_skb(skb, budget);
> +		n++;
>  	}
> +	/* Subtract exactly what was drained. Never store an absolute value:
> +	 * mixing one with the relative updates in skb_attempt_defer_free()
> +	 * lets the counter go negative, and it is read as unsigned there.
> +	 */
> +	atomic_long_sub(n, &sdn->defer_count);

[Severity: Medium]

With the subtraction moved after the napi_consume_skb() loop, does
deferral stay disabled for the whole drain?

The list is empty after llist_del_all(), but sdn->defer_count still
counts every detached skb until atomic_long_sub() runs. Suppose a full
queue (defer_max skbs, default 128) is flushed through
net_rx_action()->skb_defer_free_flush()->__skb_defer_free_flush(). The
counter then stays at about defer_max for the entire free loop.

A producer that calls skb_attempt_defer_free() for the same (alloc cpu,
node) pair during that window would hit:

	defer_count = atomic_long_inc_return(&sdn->defer_count);

	if (defer_count > defer_max) {
		atomic_long_dec(&sdn->defer_count);
		goto nodefer;
	}

It would then fall back to kfree_skb_napi_cache(), which is the
cross-CPU free that deferral is meant to avoid.

The earlier versions both released the budget before freeing. The
spinlock version did atomic_set(&sd->defer_count, 0) under defer_lock
before the free loop. Commit 844c9db7f7f5 did atomic_long_set() before
llist_del_all().

The detached skbs are no longer on the list. Could n be computed first
and subtracted before the free loop? A counting pass over free_list would
do it, and would also warm the cache lines that napi_consume_skb()
touches. Neither the commit message nor the new comment mentions this
change to the admission window.

>  }
>  
>  void skb_defer_node_flush(struct skb_defer_node *sdn)
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 48f6764117243..68192e477ff1f 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -7499,8 +7499,14 @@ nodefer:	kfree_skb_napi_cache(skb);
>  	defer_max = READ_ONCE(net_hotdata.sysctl_skb_defer_max);
>  	defer_count = atomic_long_inc_return(&sdn->defer_count);
>  
> -	if (defer_count >= defer_max)
> +	if (defer_count > defer_max) {
> +		/* Undo the reservation. An llist_add() does not release one --
> +		 * the skb stays charged until a flush subtracts the batch that
> +		 * contains it -- so a rejected free must undo its own.
> +		 */
> +		atomic_long_dec(&sdn->defer_count);
>  		goto nodefer;
> +	}

[Severity: Low]

This isn't a bug introduced by this patch, but
Documentation/admin-guide/sysctl/net.rst still describes skb_defer_max
as:

    Max size (in skbs) of the per-cpu list of skbs being freed
    by the cpu which allocated them.

The limit is actually applied separately to each (allocating cpu,
freeing node) list:

	sdn = per_cpu_ptr(net_hotdata.skb_defer_nodes, cpu) + cpu_to_node(my_cpu);

net_dev_init() allocates nr_node_ids of these lists per CPU. One
allocating CPU can therefore have up to defer_max * nr_node_ids skbs
pending.

The documentation also doesn't say that writing 0 disables deferral
entirely, which proc_do_skb_defer_max() does through
skb_defer_disable_key.

The switch from >= to > makes the per-list bound match "Max size". The
per-node scope and the meaning of 0 still differ from the text. Should
net.rst be updated to describe them?

>  
>  	llist_add(&skb->ll_node, &sdn->defer_list);
>  
> @@ -7509,8 +7515,13 @@ nodefer:	kfree_skb_napi_cache(skb);
>  		return;
>  	}
>  
> -	/* Send an IPI every time queue reaches half capacity. */
> -	kick = (defer_count - 1) == (defer_max >> 1);
> +	/* Half capacity, plus the skb that fills the queue. Equality alone can
> +	 * be consumed early -- if the producer holding the kick value publishes
> +	 * first, its purge drains only that skb and the reservations published
> +	 * after it match nothing -- which would leave a full queue with nothing
> +	 * pending.
> +	 */
> +	kick = (defer_count - 1) == (defer_max >> 1) || defer_count == defer_max;

[Severity: Medium]

This is a pre-existing issue, but can a runtime change to
net.core.skb_defer_max still leave a per-(cpu, node) queue at or above
the new limit with no purge pending?

Both kick conditions are equality tests against the defer_max that was
read earlier with READ_ONCE(). The rejection branch above returns
without kicking.

proc_do_skb_defer_max() only toggles skb_defer_disable_key when the value
changes to or from 0. It doesn't drain or kick the existing lists:

	if (nval != oval) {
		if (nval)
			static_branch_enable(&skb_defer_disable_key);
		else
			static_branch_disable(&skb_defer_disable_key);
	}

Take a limit of 128 with 31 skbs queued, which is below the
half-capacity kick, so nothing is pending. If the limit is lowered to 16,
every later producer gets 32 > 16, undoes its reservation and returns.
The count never passes through 9 or 16, so neither kick fires.

In another case, a producer reads 128, the limit is lowered to 32, and
that producer then reserves 32. Both of its checks (31 == 64 and
32 == 128) fail. Later producers get 33 > 32 and are rejected.

In both cases deferral for that pair stays off. The queued skbs stay
pinned until the allocating CPU runs net_rx_action() or
napi_threaded_poll_loop() for some unrelated reason. On a CPU that only
allocates TX skbs, that may never happen.

The new full-capacity kick only guarantees a pending purge for a full
queue while the limit stays constant. Should the rejection path also
kick, or should the sysctl handler flush the existing lists?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029211101.2089535-1-jkain%40nuro.ai
