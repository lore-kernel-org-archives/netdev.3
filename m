Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC86288C0;
	Sat, 19 Sep 2026 00:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777295; cv=none; b=nfUe/n6NGAp9oZ08mdLbKL2pXT7jxwOHCZlCecg+H5vfLktvyT4O6cPL9o6b70Lcr11ZCYp6kOjx4kcbLcMALlUuHG6V0EoFfOnnvPSXE0sUo92x2vjFSkLRTsmjxMGeZYJqWdkhMZycDqGSoUquHO4ATE4lxntTn1N3/Ul/Qvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777295; c=relaxed/simple;
	bh=dLcg8FMRNBbFqtwTxYoZJx0LlIxo+EPgppryzxDb5MU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QqJBe92HsL57NqvqLQvbs4J2/qTIjeMOYoWLnpq28xSxtiZaHiEd/kLwMlwUx58QlVdeGk2Rdl0aPLWGeSTARZlIHFAIJpWRonDCMq2lUjGdTEz5AS6w1zuJQGvJbbtAhfNlgiYHJcsVkw3L8KIa+fXsR4jaVrI2PMlRb5IPCOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4H330Pn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4H330Pn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CB51F00899;
	Sat, 19 Sep 2026 00:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777293;
	bh=xgH3biHy5t7OBbuIo8qVWpHv4CzRfPKd4gz8cj7F4V8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=H4H330PnERbOmRxpKdHjtkzGtgv+oUpB89jwsQy5+ELP0vfCSTEmUvjpfkyWecRPY
	 y8S1MJj1Q7njCc0emoXyBetjm2xwoR4sgRlrbKrosaV7ugY4R61Y7nIgNi1euEVh05
	 0fpCjl3HFH8I5sAqQi9BFFfHTyGffxgvbd4Izw9leVoyg3AWE2Hr6EvthJN9Xtr0vl
	 FOYx8GkoDEE73ZfC+5f0SCvrT5IyOuIYB1AE2f9rqpsxDwMzz4zHFK2YkcJgKZFdft
	 hdbDf8MdtIiVN7Ty27k+mm+MqnRPKCK8jm4HnHZVIl0WXU+K3L/FZS8L0rLHZzFkw/
	 0LDTP/Uq0kUbA==
Subject:
 Re: [PATCH net-next v2 3/5] net: account per-CPU netdev stats to memcg
From: netdev-bot+sashiko@kernel.org
To: alishmery18@gmail.com
Cc: netdev@vger.kernel.org, idosch@nvidia.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, razor@blackwall.org,
 roopa@nvidia.com, linux-kernel@vger.kernel.org
Date: Sat, 19 Sep 2026 00:21:32 +0000
Message-ID: <178977729260.22033.10416984208482997217@kernel.org>
In-Reply-To: <20260916193449.2552039-4-alishmery18@gmail.com>
References: <20260916193449.2552039-4-alishmery18@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)

- [Medium] The accounting change only covers the plain
  `netdev_alloc_pcpu_stats()` form, so per-CPU stats belonging to one…

Pre-existing issues:
- [Low] Concern that the change is a memcg-isolation bug fix and
  therefore lacks a required `Fixes:` tag identifying the commit that…

--

net: account per-CPU netdev stats to memcg

This changes the plain netdev_alloc_pcpu_stats() macro to allocate with
GFP_KERNEL_ACCOUNT instead of GFP_KERNEL, so the per-CPU stats block is
charged to the memcg of the task that created the object.  The devm_ and
explicit-gfp variants of the macro are unchanged.

v1: https://lore.kernel.org/netdev/20260909092645.3105263-1-alishmery18@gmail.com/

> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 1f0710eef185b..7c659012355dd 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3171,7 +3171,7 @@ static inline void dev_dstats_tx_dropped(struct net_device *dev)
>  })
>  
>  #define netdev_alloc_pcpu_stats(type)					\
> -	__netdev_alloc_pcpu_stats(type, GFP_KERNEL)
> +	__netdev_alloc_pcpu_stats(type, GFP_KERNEL_ACCOUNT)

[Severity: Medium]
Does this move the accounting asymmetry rather than remove it?  Several
callers allocate more than one per-CPU stats block for the same object,
and only the ones going through this macro become charged.

net/sched/sch_generic.c:qdisc_alloc() does:

	sch->cpu_bstats =
		netdev_alloc_pcpu_stats(struct gnet_stats_basic_sync);
	if (!sch->cpu_bstats)
		goto errout1;

	sch->cpu_qstats = alloc_percpu(struct gnet_stats_queue);

so cpu_bstats is now charged while cpu_qstats stays uncharged for the same
qdisc created by tc qdisc add.

net/sched/act_api.c:tcf_idr_create() has the same split:

	p->cpu_bstats_hw = netdev_alloc_pcpu_stats(struct gnet_stats_basic_sync);
	if (!p->cpu_bstats_hw)
		goto err2;
	p->cpu_qstats = alloc_percpu(struct gnet_stats_queue);

Two of the three per-CPU blocks of one tc action get charged, the third
does not.

The commit message says:

    The devm_ and explicit-gfp forms of the macro are left alone.

but it does not mention these adjacent alloc_percpu() companions inside the
same functions.  Were they deliberately left out, or just missed?

Related, the same net_device field ends up charged or not depending on which
macro a driver picks: dev->tstats is charged when it comes from
netdev_do_alloc_pcpu_stats() in net/core/dev.c, and uncharged when a driver
uses devm_netdev_alloc_pcpu_stats(), as in liteeth_probe()
(drivers/net/ethernet/litex/litex_liteeth.c), stmmac_dvr_probe()
(drivers/net/ethernet/stmicro/stmmac/stmmac_main.c) and
ax88796c_probe() (drivers/net/ethernet/asix/ax88796c_main.c).

And the user-triggered netlink path in net/ipv6/seg6_local.c still builds
per-CPU SRv6 counters with plain GFP_KERNEL:

	#define seg6_local_alloc_pcpu_counters(__gfp)			\
		__netdev_alloc_pcpu_stats(struct pcpu_seg6_local_counters,	\
					  ((__gfp) | __GFP_ZERO))

	...
	pcounters = seg6_local_alloc_pcpu_counters(GFP_KERNEL);

reached from parse_nla_counters() during route parsing.  Should that wrapper
add __GFP_ACCOUNT too, or is leaving it out intentional?

[Severity: Low]
This isn't a bug introduced by this patch, but the missing accounting in
netdev_alloc_pcpu_stats() is a pre-existing condition, and one review pass
asked whether a Fixes: tag pointing at 3c7be18ac9a0 ("mm: memcg/percpu:
account percpu memory to memory cgroups") is needed here.

Checking the closest precedent argues against it: commit c948f51c1654
("memcg: enable accounting for net_device and Tx/Rx queues"), which
introduced the GFP_KERNEL_ACCOUNT usage in alloc_netdev_mqs() and
netif_alloc_rx_queues() that this patch cites as its parity target, carries
no Fixes: tag and went in through net-next as an enhancement.  3c7be18ac9a0
also never claimed to charge allocations that omit __GFP_ACCOUNT, so it does
not look like a valid Fixes: target.

Is treating this as an enhancement without a Fixes: tag the intent?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916193449.2552039-1-alishmery18%40gmail.com
