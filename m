Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792452028;
	b=eyfRixr2pGc78CwC8+LkwPPiPTSw8FrtRKNSwnYiTK/eooIv66qShq+7/Vm88/UCEn/d
	 gmmpN07RWsDjc+ZBKRdWJvICSUnXgjr+4XSuXpVQ0yZ//4jbi6Uqe20ExzfbQ9CnUaaKk
	 khby1PgBo769qx3CjSEZvT9C7JMbjX0F5Ouw9iMfmL73aGveY2yvtpXONjAZtv+o+EkZy
	 X35GpU6tsGqqGrVebKZw+O961hO5MOjdHrNyjRb5AVq1BX698oRml7HbHrjVaKvk/17qW
	 eyAeclH65z7rrCNWDmOp+2mHR2nE9FP21hJt9PiCzVIL7QPA3MFqNcHrVtNBW2SNM7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792452028;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=dXkUXwQG+10POwpnoEARoMLh2opBDrQrGq9cD0ZkTdk=;
	b=KA5SkqUF4bdO16LGGlARUFdvWs6qPJ2XH/yZ7SYyDlR+WwbSi2/MpeVQVHKbW54bd8Sz
	 NOA0lvUEe1+LC1akY7Ksv6bUMh7RWR0c6jmOn0BzHlNfq6mMTDLWBFlHpSRTZY3IQIR52
	 IJh0IqUy6ALzCbayu9PMhf1mBIEN3ZkOhs+Q8ISyBQWGZOsCLHvVXyJuhdpUU6lpVoyqE
	 ht27V+a6ybTM/yFj+1dgMr1YPzkD1F/NY+v6PDcQeEqlM1aHSZzCR4Grh83MsL03eJ9fO
	 Hlq8rguZ3zgE9YC2287J9ZdOo9WX3DxxBPUO9qEaRnwk0kJsMxgZrDQcXlH9U/KbySg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bnzQBHwC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD11D606A323;
	Mon, 19 Oct 2026 23:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bnzQBHwC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAFE1F000C8;
	Mon, 19 Oct 2026 23:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792452027;
	bh=dXkUXwQG+10POwpnoEARoMLh2opBDrQrGq9cD0ZkTdk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bnzQBHwC06rY1eNXq0YdNC3lvvUBT8VavXzWoxG980plAwQX4UEZkVM355E0A2M7q
	 nJDNm/sgLyh7C+iEbuxQngIsBspFQS8R1vUmFT6/sAC/R/n/9TG0RbLkUUb2JVZroA
	 GO9FWtvlobjenmLJFuRV2vS21aqSnbY8C5M//VpqpqcyCEnzwyYuP33vl4ZoBr4s4K
	 PhvQM77wCLKyqOYPlhTAKAHuAcPMbJ0PReEK/XvLDjLNrxCdIv00gxqv/pczWHXXCR
	 4MnoumcC6d44smYPVO74FNrCuD/DwbFNTe72omQd/IOLHd+1IJYWWUixJVACNbnNpI
	 f2ZgFqVHqEtQw==
Subject: Re: [PATCH net-next v2] amt: make the per-tunnel group and source
 limits configurable
From: netdev-bot+sashiko@kernel.org
To: omar@blockcast.net
Cc: ap420073@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org
Date: Mon, 19 Oct 2026 23:20:26 +0000
Message-ID: <179245202637.3135.11251208496046654130@kernel.org>
In-Reply-To: <20261015231825.2852054-1-omar@blockcast.net>
References: <20261015231825.2852054-1-omar@blockcast.net>
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

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new AMT_MAX_SOURCE_LIMIT ceiling (4096) multiplies the
  per-packet softirq CPU cost of an existing O(N×M) loop by up to 32x.

Pre-existing issues:
- [High] Teardown race between source-timer work and group/tunnel
  deletion causes double-destroy and use-after-free (this problem wasn't…

--

amt: make the per-tunnel group and source limits configurable

This patch adds IFLA_AMT_MAX_GROUPS and IFLA_AMT_MAX_SOURCES, so a relay
operator can raise the per-tunnel group and source record limits when the
link is created. The netlink policy caps them at 1024 groups and 4096
sources, and amt_fill_info() reports both values.

> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index 81d26ef82cf5c..30cff8de4830f 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c

[ ... ]

> @@ -3170,6 +3171,8 @@ static const struct nla_policy amt_policy[IFLA_AMT_MAX + 1] = {
>  	[IFLA_AMT_REMOTE_IP]	= { .len = sizeof_field(struct iphdr, daddr) },
>  	[IFLA_AMT_DISCOVERY_IP]	= { .len = sizeof_field(struct iphdr, daddr) },
>  	[IFLA_AMT_MAX_TUNNELS]	= { .type = NLA_U32 },
> +	[IFLA_AMT_MAX_GROUPS]	= NLA_POLICY_MAX(NLA_U32, AMT_MAX_GROUP_LIMIT),
> +	[IFLA_AMT_MAX_SOURCES]	= NLA_POLICY_MAX(NLA_U32, AMT_MAX_SOURCE_LIMIT),

[Severity: Medium]
The 4096 ceiling is justified by memory cost. The include/net/amt.h
comment says "Gateways drive these allocations, so keep one tunnel's worst
case to a few MiB". Could this ceiling also raise the per-packet softirq
cost of amt_lookup_act_srcs() by up to 32x?

amt_add_srcs() only checks the tunnel-wide count:

	for (i = 0; i < nsrcs; i++) {
		if (tunnel->nr_sources >= amt->max_sources)
			return;

So all max_sources records can sit in a single group. The AMT_OPS_SUB
branch of amt_lookup_act_srcs() then walks every source in that group and
compares each one against every source in the incoming record:

	case AMT_OPS_SUB:
		/* A-B */
		for (i = 0; i < amt->hash_buckets; i++) {
			hlist_for_each_entry_safe(snode, t, &gnode->sources[i],
						  node) {
				if (!amt_status_filter(snode, filter))
					continue;
				for (j = 0; j < nsrcs; j++) {

This loop runs from amt_update_handler()->amt_mcast_is_in_handler() and
from the EXCLUDE-mode handler. It runs in softirq with
spin_lock_bh(&tunnel->lock) held.

In amt_igmpv3_report_handler(), only ip_mc_may_pull() bounds nsrcs. A
reassembled datagram can therefore carry about 16K IPv4 sources in one
record. That is about 2M address compares per record at 128 sources, and
about 67M at 4096, all with BHs disabled.

Can a remote gateway that has completed the request/query exchange use
this to cause soft lockups or RCU stalls on a relay that raised
IFLA_AMT_MAX_SOURCES?

One step is not confirmed: whether a gateway can keep thousands of one
group's sources in D_FWD/OLD state, so that they pass
amt_status_filter().

>  };
>  
>  static int amt_validate(struct nlattr *tb[], struct nlattr *data[],
> @@ -3235,8 +3238,10 @@ static int amt_newlink(struct net_device *dev,
>  		amt->max_tunnels = AMT_MAX_TUNNELS;
>  
>  	spin_lock_init(&amt->lock);
> -	amt->max_groups = AMT_MAX_GROUP;
> -	amt->max_sources = AMT_MAX_SOURCE;
> +	amt->max_groups = nla_get_u32_default(data[IFLA_AMT_MAX_GROUPS], 0) ?:
> +			  AMT_MAX_GROUP;
> +	amt->max_sources = nla_get_u32_default(data[IFLA_AMT_MAX_SOURCES], 0) ?:
> +			   AMT_MAX_SOURCE;

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. This
patch lets a tunnel hold more groups and sources, though. Is source timer
teardown in amt_destroy_source() safe against an amt_source_work() that is
already running?

amt_destroy_source() uses the non-synchronous cancel:

	cancel_delayed_work(&snode->source_timer);
	hlist_del_init_rcu(&snode->node);
	tunnel->nr_sources--;
	gnode->nr_sources--;
	spin_lock_bh(&source_gc_lock);
	hlist_add_head_rcu(&snode->node, &source_gc_list);
	spin_unlock_bh(&source_gc_lock);

amt_source_work() reads snode->gnode and gnode->tunnel_list before it
takes any lock or rcu_read_lock(). It also never checks whether snode has
already been unhashed:

	struct amt_group_node *gnode = snode->gnode;
	...
	tunnel = gnode->tunnel_list;
	spin_lock_bh(&tunnel->lock);
	rcu_read_lock();
	if (gnode->filter_mode == MCAST_INCLUDE) {
		amt_destroy_source(snode);

amt_wq is WQ_UNBOUND. Consider amt_source_work() spinning on tunnel->lock
on one CPU while another CPU handles an IGMPv2 leave from the gateway:

CPU B (softirq, tunnel->lock held)
amt_update_handler()
  amt_igmpv2_leave_handler()
    amt_del_group()
      amt_destroy_source(snode)    /* cancel returns false */
      kfree_rcu(gnode, rcu)

CPU A
amt_source_work()
  spin_lock_bh(&tunnel->lock)     /* acquired after CPU B */
  amt_destroy_source(snode)       /* second time */

The second amt_destroy_source() call then does three things:

- It calls hlist_del_init_rcu() on a node that is now on source_gc_list,
  without holding source_gc_lock.
- It decrements the u32 tunnel->nr_sources and gnode->nr_sources again.
  They wrap, and amt_add_srcs() then refuses every further source for
  that tunnel.
- It adds snode to source_gc_list again, so __amt_source_gc_work() can
  kfree_rcu() it twice.

With CONFIG_PREEMPT, the worker can also be preempted after it reads
gnode and tunnel but before spin_lock_bh(). The group, or the whole tunnel
through amt_tunnel_expire()->amt_clear_groups()->kfree_rcu(tunnel, rcu),
can be freed after a grace period. When the worker resumes, it takes
tunnel->lock and reads gnode->filter_mode from freed memory.

The MLDv1 done handler, amt_group_work() and amt_tunnel_expire() reach the
same deletion paths.

>  	amt->hash_buckets = AMT_HSIZE;
>  	amt->nr_tunnels = 0;
>  	get_random_bytes(&amt->hash_seed, sizeof(amt->hash_seed));

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015231825.2852054-1-omar%40blockcast.net
