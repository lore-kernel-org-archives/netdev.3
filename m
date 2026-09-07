Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001432C11CF
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 06:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788761485; cv=none; b=WrNjy//h9kueuSac5AS4E56w2lWXvbvZfUCsZchlqHBlFZvmrNBRymBTJk197e433QTWaR1KAd3XuX3cl98Yumr/6MES4OA8DPQ/huoT8nZZ9det/MASvdlmcmEIawytMIAUxUDP1pgEppg6RaVOuhDZYI5dN6OvNQQP/SQti54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788761485; c=relaxed/simple;
	bh=u8EysDF/KRWdmbaw082Tq4uXjUk3ZuawljgwgEdYOPU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R93zjLVjsGE5oIns9y9KiKfEss0ciC9jGmirgu8y/ngwAWCRxap60l4xfWyJtqrvkTCIB2RTIQfcXSX0IpC73MeNEAIPvTmJnzru+yLeMp3A9XBiEpRG7Wwf4BNDgQza4HmUnwpShAkvrZcalBlT/k6A26R7Ej4kiLcHnzLQKZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kou/72Yq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kou/72Yq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594B31F00A3E;
	Mon,  7 Sep 2026 06:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788761483;
	bh=Yhr12QDNk/8K81uVyuN0RClyRo0KEJmuiQkIcOOygFE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kou/72YqYCk3FfoIZP94BffXQDm6qLeklJDdz91kRW0UzubOZMBdPqzd4aM7UziXs
	 qg/QNLqER9c6IGmN0+T6kSV+tTsojGEv8bnf2beioDBIFS//lHJGYs4D9KEaQ5Gt4n
	 UJbs2J3sIdTDKLkLdtCfVAX5I57HoqL9HSrjMBwYCSMQTrmA3fxIPZn7/VA6ua2iEX
	 3/iRj4WtF8OTzpqdq29Q6+a6Kl6tSOQaZkbR/TloSZ0ZS5fZlKGxoTKPUxNqoQWd1W
	 ZDr59Oj1HVlNOVan3MmprwBueIux3YCdwZZWAFyavdq8274Ese/EdvzOHAzv3SyzjS
	 qwo70tawTaUvA==
Subject: Re: [PATCH net-next 3/9] vxlan: vnifilter: use
 list_for_each_entry_rcu() in vxlan_vnifilter_dump_dev()
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, idosch@nvidia.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Mon, 07 Sep 2026 06:11:22 +0000
Message-ID: <178876148292.219967.15613510375993426198@kernel.org>
In-Reply-To: <20260903120840.1024153-4-edumazet@google.com>
References: <20260903120840.1024153-4-edumazet@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 0 (1)

- [Medium] Commit message misstates the locking context that justifies
  change 1.
- [Medium] The fix is incomplete: the exact symptom the commit message
  claims to close — a non-zero cb->args[1] being applied to a device it…

Pre-existing issues:
- [Low] Claimed unsynchronized read of multi-word state (vg->num_vnis and
  vxlan_vni_node::remote_ip) by the RCU-only dump path while RTNL-only…

--

vxlan: vnifilter: use list_for_each_entry_rcu() in vxlan_vnifilter_dump_dev()

This converts the vg->vni_list traversal in vxlan_vnifilter_dump_dev() from
list_for_each_entry_safe() to list_for_each_entry_rcu(), and clears
cb->args[1] on the two early returns (no VXLAN_F_VNIFILTER, and no VNIs in
the group) so a paginated dump does not carry a stale index to the next
device.

A couple of questions about the changelog and about the completeness of the
cb->args[1] fix.

>     vxlan_vnifilter_dump_dev() runs under rcu_read_lock() without RTNL when
>     dumping VNI filter entries via RTM_GETTUNNEL.
>
>     1) Currently it traverses vg->vni_list using list_for_each_entry_safe(),
>        which performs raw pointer accesses without RCU dereference barriers.
>        Since concurrent RTNL writers modify vg->vni_list using list_add_rcu()
>        and list_del_rcu(), use list_for_each_entry_rcu() instead.

[Severity: Medium]
Is the "without RTNL" premise accurate for this dump at this revision?

The PF_BRIDGE/RTM_GETTUNNEL handler is registered with a zero flags field,
i.e. without RTNL_FLAG_DUMP_UNLOCKED:

drivers/net/vxlan/vxlan_vnifilter.c:
static const struct rtnl_msg_handler vxlan_vnifilter_rtnl_msg_handlers[] = {
	{THIS_MODULE, PF_BRIDGE, RTM_GETTUNNEL, NULL, vxlan_vnifilter_dump, 0},

so rtnetlink_dump_start() installs rtnl_dumpit() as the dump callback:

net/core/rtnetlink.c:rtnl_dumpit() {
	const bool needs_lock = !(cb->flags & RTNL_FLAG_DUMP_UNLOCKED);
	...
	if (needs_lock)
		rtnl_lock();
	err = dumpit(skb, cb);
	...
}

All writers of vg->vni_list (__vxlan_vni_add_list()/__vxlan_vni_del_list(),
vxlan_vs_add_vnigrp()/vxlan_vs_del_vnigrp(), vxlan_vnigroup_uninit()) run
under RTNL with rtnl_dereference()/ASSERT_RTNL(). With RTNL held around
vxlan_vnifilter_dump() the traversal cannot observe a concurrent
list_add_rcu()/list_del_rcu(), which would make part 1 an annotation
improvement rather than a fix for a reachable race. I also checked the end
of the series and the handler flags are still 0 there.

Would it make sense to describe part 1 as an annotation/lockdep improvement
(and preparation for an RCU-only dump), and keep the Fixes: tag tied to the
cb->args[1] problem in part 2?

> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
> index ddfa24ad16f9..53213542fa3e 100644
> --- a/drivers/net/vxlan/vxlan_vnifilter.c
> +++ b/drivers/net/vxlan/vxlan_vnifilter.c

[ ... ]

> @@ -342,13 +342,17 @@ static int vxlan_vnifilter_dump_dev(const struct net_device *dev,
>  	bool dump_stats;
>  	int err = 0;
>  
> -	if (!(vxlan->cfg.flags & VXLAN_F_VNIFILTER))
> +	if (!(vxlan->cfg.flags & VXLAN_F_VNIFILTER)) {
> +		cb->args[1] = 0;
>  		return -EINVAL;
> +	}
>  
>  	/* RCU needed because of the vni locking rules (rcu || rtnl) */
>  	vg = rcu_dereference(vxlan->vnigrp);
> -	if (!vg || !vg->num_vnis)
> +	if (!vg || !vg->num_vnis)  {
> +		cb->args[1] = 0;
>  		return 0;
> +	}

[Severity: Medium]
Do these two clears cover the symptom described in the changelog?

vxlan_vnifilter_dump() resumes the multi-device walk by ordinal position,
and both RTNL and RCU are dropped between netlink_dump() invocations:

drivers/net/vxlan/vxlan_vnifilter.c:vxlan_vnifilter_dump() {
		for_each_netdev_rcu(net, dev) {
			if (!netif_is_vxlan(dev))
				continue;
			if (idx < s_idx)
				goto skip;
			err = vxlan_vnifilter_dump_dev(dev, skb, cb);
			if (err == -EMSGSIZE)
				break;
skip:
			idx++;
		}
	}
	cb->args[0] = idx;
	rcu_read_unlock();

If a vxlan device positioned before the paused one is unregistered in that
gap, the device now sitting at idx == s_idx is a different device. That
device has VXLAN_F_VNIFILTER set and a non-empty group, so neither new
cb->args[1] = 0 path is taken, and vxlan_vnifilter_dump_dev() consumes the
stale index:

	int idx = 0, s_idx = cb->args[1];
	...
	list_for_each_entry_rcu(v, &vg->vni_list, vlist) {
		if (idx < s_idx) {
			idx++;
			continue;
		}

which skips that device's first N VNIs — the exact case the changelog says
is being fixed. A device inserted at the head produces the mirror case, a
device re-dumped from a bogus VNI offset. The same positional resume inside
one device's vni_list can skip or repeat entries when VNIs are added or
removed via __vxlan_vni_add_list()/__vxlan_vni_del_list() between
invocations.

Would resetting cb->args[1] in vxlan_vnifilter_dump() whenever it moves on
to a device other than the paused one (or resuming by ifindex and VNI value
instead of by position) close the remaining cases? And since the iteration
can still skip or repeat objects, should the dump record a generation
counter in cb->seq so NLM_F_DUMP_INTR is reported to user space?

>  
>  	tmsg = nlmsg_data(cb->nlh);
>  	dump_stats = !!(tmsg->flags & TUNNEL_MSG_FLAG_STATS);

[ ... ]

> @@ -362,7 +366,7 @@ static int vxlan_vnifilter_dump_dev(const struct net_device *dev,
>  	new_tmsg->family = PF_BRIDGE;
>  	new_tmsg->ifindex = dev->ifindex;
>  
> -	list_for_each_entry_safe(v, tmp, &vg->vni_list, vlist) {
> +	list_for_each_entry_rcu(v, &vg->vni_list, vlist) {
>  		if (idx < s_idx) {
>  			idx++;
>  			continue;

[Severity: Low]
This isn't a bug introduced by this patch, but if the dump is later made
RTNL-less, are the per-node fields read in this loop safe for an RCU-only
reader?

The loop and vxlan_fill_vni_filter_entry() read the multi-word
vxlan_vni_node::remote_ip union, and the early return above reads
vg->num_vnis, while the writers update them in place under RTNL only:

drivers/net/vxlan/vxlan_vnifilter.c:vxlan_vni_update_group() {
	if (group)
		memcpy(&vninode->remote_ip, group, sizeof(vninode->remote_ip));
}

and vg->num_vnis++/-- in __vxlan_vni_add_list()/__vxlan_vni_del_list().

Today this is serialized because rtnl_dumpit() holds RTNL for this handler,
so there is no torn read. If the plan is to drop RTNL from this dump, would
these fields need their own publish/read discipline as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903120840.1024153-1-edumazet%40google.com
