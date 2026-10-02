Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8BD1A682C
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 02:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790906636; cv=none; b=lQm3ff/VZYQj7gIVUqsUhyPpFx/Sid4RhOv+RtssBrXowNy6kjVtSJIUbGk3/3msE6tCViBwH5wsrzj8bhxaw3w97RmVq1AORjZrdkiRREHUnPPPB9ATRiUOWlVmW4wYneswcBgB2RUZiuNSYOxz3l4BOdaTLUuOv6iO/PD8w0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790906636; c=relaxed/simple;
	bh=GdQuWsyP/nXYtOcQaarvVJQbuo95P2OcYJsl3xfYJ90=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=piGAaYODFhILfpMRYpCmwmq+I0249AJfoTGSxJHVESkxMQCim4qR3WreqvqIfZ6x4cFy1l6nUw6Eyba1Y3pbyDm5IxwIsB4HzdLmm9akNy2JgzNSfzBHUJaffvhzhm2pAjEo2frJ+XYSTL9D++6l4zFxioCfUgkVMhPFJvLJAkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBoYOjLu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBoYOjLu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFCF1F000FF;
	Fri,  2 Oct 2026 02:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790906634;
	bh=pQyv7XMIMlhn632FBowD4PhHd6PFsUIONCH1xvCwTmA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dBoYOjLuVF2kEkdds0645w900iSNNNQO5gqUAa0ovVYSlE3DHPmmGyzGjc/+A7kEX
	 i9Xd74hvNv9kIKj26jnUJracvLjxqxQC46+pxwveHANQS6ideukzvMUhOrDLCO3Mvc
	 hAUqHODJSS5t6tNaxQh1yvqze8kIEeuPLa9XRnuePd31HQKuWDGbbmSSnWfPqzsGFT
	 mPiDzsv55G3otxa23W3UJL5M+AAx/KedHJOQiUDEyEYiQjpbiyrd0ua+hnxnjd3rkM
	 4UvjhqXbDS6+ESSDuso/EI+IIbp6a95LgYeh6MtXPaCh7RN5behcCFdJOFaCMGE+x1
	 n7W76YmZzVUoA==
Subject:
 Re: [PATCH v1 net-next 6/8] ipv6: Use ipv6_neigh_lookup() and friends.
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 enachman@marvell.com, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 mbloch@nvidia.com, borisp@nvidia.com, petrm@nvidia.com, jiri@resnulli.us,
 ecree.xilinx@gmail.com, razor@blackwall.org
Date: Fri, 02 Oct 2026 02:03:53 +0000
Message-ID: <179090663305.434549.17214258093385242325@kernel.org>
In-Reply-To: <20260930200326.718459-7-kuniyu@google.com>
References: <20260930200326.718459-7-kuniyu@google.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch's bug class is still reachable through sch_teql.
- [Medium] ipv6_neigh_lookup(), ipv6_neigh_create() and
  ipv6_neigh_create_noref() choose the table with an unsynchronized…
- [Low] In mlxsw_sp_router_neigh_ent_ipv6_process() the dev comes from
  mlxsw_sp_rif_dev(rifs[rif]) and is passed to ipv6_neigh_lookup(dev,…

--

ipv6: Use ipv6_neigh_lookup() and friends.

This commit replaces neigh_lookup(), neigh_create() and __neigh_lookup()
callers that pass nd_table(net) with IPv6 helpers. The helpers take the
neighbour table from dev_net(dev). It fixes a syzbot lockdep splat in
neigh_mark_dead(): ip6_finish_output2() used the caller's net (for example
under xfrm), so a neighbour was inserted into another netns's table.

Closes: https://lore.kernel.org/netdev/6abd69a9.80e1c6cc.22483f.0005.GAE@google.com/

> This only happens when a neigh_table accidentally has a
> neighbour from a different netns.

[ ... ]

> It is error-prone to require callers to fetch netns and
> neigh_table and pass it with dev to neigh_lookup(), etc.

[Severity: High]
Can a neighbour from a different netns still end up in a table through
sch_teql? This patch does not touch net/sched/sch_teql.c, and
__teql_resolve() still pairs the master's table with the slave device:

net/sched/sch_teql.c:__teql_resolve() {
    ...
	n = dst_neigh_lookup_skb(dst, skb);
	if (!n)
		return -ENOENT;

	if (dst->dev != dev) {
		struct neighbour *mn;

		mn = __neigh_lookup_errno(n->tbl, n->primary_key, dev);
    ...
}

dst->dev is the teql master, so n->tbl is the table of the master's netns,
while dev is the slave.

Nothing seems to require the two to share a netns. teql_qdisc_init()
checks only hard_header_len, m->dev == dev and TC_H_ROOT. The teql Qdisc_ops
are registered globally. teql_master_setup() also does not make the master
netns-immutable.

With the master and slave in different netns, ___neigh_create() links the
new neighbour into the master-netns table's hash. It also adds it to the
slave's dev->neighbours[] through neigh_get_dev_table(). For IPv6,
ndisc_constructor() takes n->parms from the slave's in6_dev, so the
parms->dead check passes.

When the slave later goes down in its own netns, this path runs:

neigh_ifdown(nd_table(dev_net(slave)), slave)
  neigh_flush_dev()
    neigh_flush_one()
      hlist_del_rcu(&n->hash)
      neigh_mark_dead()
        lockdep_assert_held(&n->tbl->lock)

Only the slave-netns tbl->lock is held there. Would that give the same
splat as the syzbot report, along with unlocked changes to the other
netns's hash and gc lists?

The later commit "neighbour: Remove __neigh_lookup() and
__neigh_lookup_errno()." in this series appears to keep
neigh_lookup(n->tbl, ..., dev) and neigh_create(n->tbl, ..., dev) here.

Three possible directions:

  - resolve the table from dev_net(dev) by family
  - reject cross-netns slaves in teql_qdisc_init() with
    net_eq(dev_net(dev), dev_net(m->dev)) and make the master
    netns-immutable
  - reject n->parms->tbl != tbl under tbl->lock in ___neigh_create()

> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
> index ba8a7a44ce9ed..1f4753213b9cb 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c

[ ... ]

> @@ -2464,9 +2462,8 @@ static void mlxsw_sp_router_neigh_ent_ipv6_process(struct mlxsw_sp *mlxsw_sp,
>  		return;
>  	}
>  
> -	tbl = nd_table(net);
>  	dev = mlxsw_sp_rif_dev(mlxsw_sp->router->rifs[rif]);
> -	n = neigh_lookup(tbl, &dip, dev);
> +	n = ipv6_neigh_lookup(dev, &dip);

[Severity: Low]
Is dev guaranteed to be non-NULL here? mlxsw_sp_rif_dev() can return NULL:

	if (!rif->crif)
		return NULL;
	return rif->crif->key.dev;

The loopback RIF's crif is allocated with mlxsw_sp_crif_alloc(NULL), so its
key.dev is NULL.

Before this change, neigh_lookup(tbl, &dip, NULL) only hashed and compared
the dev pointer. ipv6_neigh_lookup() evaluates nd_table(dev_net(dev)), so a
NULL dev would now be dereferenced.

In practice, host entries are only programmed on RIFs found by
mlxsw_sp_rif_find_by_dev() from n->dev. __mlxsw_sp_router_neighs_update_rauhtd()
also holds router->lock for the whole dump. So this looks reachable only if
firmware returns a record the driver never programmed.

Would a NULL check on dev before the lookup be worth adding for robustness?
The IPv4 counterpart in "ipv4: Use ipv4_neigh_lookup() and friends." appears
to follow the same pattern.

>  	if (!n)
>  		return;
>  

[ ... ]

> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 8baac4d852518..ea9f0a4c34f97 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -218,7 +218,7 @@ struct neighbour *__ip6_dst_neigh_lookup(const struct in6_addr *gw,
>  	if (n)
>  		return n;
>  
> -	n = neigh_create(nd_table(dev_net(dev)), daddr, dev);
> +	n = ipv6_neigh_create(dev, daddr);

[Severity: Medium]
Can the table chosen inside ipv6_neigh_create() go stale before the
neighbour is inserted? The helper reads dev_net(dev) without
synchronization:

	struct neigh_table *tbl = nd_table(dev_net(dev));

	return neigh_create(tbl, pkey, dev);

Under tbl->lock, ___neigh_create() only checks the following. It does not
check that dev is still in tbl's netns or that n->parms belongs to tbl:

	if (n->parms->dead) {
		rc = ERR_PTR(-EINVAL);
		goto out_tbl_unlock;
	}

Consider a preemptible process-context creator, such as a dst_neigh_lookup()
caller that reaches __ip6_dst_neigh_lookup() outside RCU:

creator
  ipv6_neigh_create(dev, ...)
    tbl = nd_table(dev_net(dev))   <- old netns
    <preempted>

__dev_change_net_namespace()
  NETDEV_UNREGISTER
  rcu_barrier()
  dev_net_set(dev, new_net)
  NETDEV_REGISTER                  <- new in6_dev

creator resumes
  neigh_create(old_tbl, ...)
    ndisc_constructor()
      in6_dev_get(dev)             <- new in6_dev, live parms

The new parms are live, so the dead check passes. The neighbour is then
linked into the old netns's table and onto dev->neighbours[]. A later
neigh_ifdown(new_tbl, dev) would change old_tbl's hash and gc lists without
old_tbl->lock. That is the same state described in the commit message.

The rcu_barrier() in __dev_change_net_namespace() does not exclude a
non-RCU process-context reader like this. The window is narrow and there is
no reproducer.

Would a check under tbl->lock in ___neigh_create(), for example rejecting
n->parms->tbl != tbl with -EINVAL, close this window? It would also cover
the sch_teql case above.

>  	return IS_ERR(n) ? NULL : n;
>  }
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930200326.718459-1-kuniyu%40google.com
