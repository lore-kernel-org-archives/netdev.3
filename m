Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EF838DC7C;
	Wed, 16 Sep 2026 01:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522118; cv=none; b=k8PVBr/RdD1MyaOoKqn7v/uDJ91Rhx/RkfUa3lO8e7juHrGD7oSFF/me4htwGdAAHjGOI1EKCX3/tTuUxfEydXRXZaRN/ENdgRZd8wRyYOcu29U5RURnWPNKFFFrczlxG2v5ZeTeCJNW2hE5qP+YX+NbFrTHvNqwOhdngnaLLI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522118; c=relaxed/simple;
	bh=vhTyJzcxyxwHrPyToiscdFj75r94Orx0BJoUBonaDE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4LG2TTFz0H89qbLj7doHqjmg8aP0iKQ9TGfz5SmMJ683YaGKcDyMyEMJAlai0JPdKcKmQ6AbCWXXswyC3LLkXSEGeaq/tHEnyLw8okLAIZ3S1b2El7o91XJ+lMiixaM1Dln/Uki5omx0XIImhZXnpVRAhEXvb/3Gif4fDrOz0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuKVyKER; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuKVyKER"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E0A1F000FF;
	Wed, 16 Sep 2026 01:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789522116;
	bh=IzR71pwCoQbnnBAfVT8uBgtm36scBsexOSyPl8XPR38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IuKVyKERUJzNZziKCVPQje990XkcqqwsMoxQcgN8mNgU9KG4rJj573eWBINzOWKUz
	 j/qseY9IA+9xHvd9f/CpnDQIpcN+ZYUa6iixYg92OoGUpZ5psLu0xiJTiD7ai0miqO
	 EM3yfYyYOBOrP6rKmD2NnSKe+JQ7I8D1lwJWMEBCNDcw5os53q7av3uKu3rXPj6TuN
	 6Hs5alW/0HmRyP+zUAIjYQCtEZCKy4XSq60saLHx0LsvKBudHRagHnoK53MIT0BslN
	 dyXBWgJNcKl7qY0J6njc4C1UG0JPEsU8PVukZkBiYkvB8Fb1K8+pux/fF6FYaZQd9T
	 JaJ0KjpEPPrYw==
From: Jakub Kicinski <kuba@kernel.org>
To: hangbin.liu@linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	jv@jvosburgh.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	daniel@iogearbox.net,
	joamaki@gmail.com,
	razor@blackwall.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuhangbin@kylinos.cn
Subject: Re: [PATCH net v4] bonding: fix slave_cnt leak on XDP error paths
Date: Tue, 15 Sep 2026 18:27:22 -0700
Message-ID: <20260916012721.1653880-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914-bond_slave_cnt-v4-1-d14864a39e60@kylinos.cn>
References: <20260914-bond_slave_cnt-v4-1-d14864a39e60@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clashiko classified the broader issues as independent but I'm not sure.
If there are more problems with pre-publishing the count we need
a different fix? Or am I not reading closely enough?

AI review:
---
bonding: fix slave_cnt leak on XDP error paths

The three XDP failure exits in bond_enslave() used to jump straight to
err_sysfs_del, which skipped the slave_cnt decrement and let the counter
drift upward on every failed enslave. A new err_slave_cnt label is added
ahead of err_sysfs_del to undo the increment.

> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index a9bff7663eeca..577d85c838040 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2305,7 +2305,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>  			SLAVE_NL_ERR(bond_dev, slave_dev, extack,
>  				     "Slave does not support XDP");
>  			res = -EOPNOTSUPP;
> -			goto err_sysfs_del;
> +			goto err_slave_cnt;
>  		}
>  	} else if (bond->xdp_prog) {
>  		struct netdev_bpf xdp = {

[Severity: High]

This is a pre-existing ordering issue that dates back to 9e2ee5c7e7c3 and
is not introduced by this patch, but since the new err_slave_cnt stage sits
right here it seems worth asking about.

By the time bond_enslave() reaches this ndo_bpf / ndo_xdp_xmit test, the
slave has already been published to the lockless transmit path:

	res = bond_master_upper_dev_link(bond, new_slave, extack);
	...
	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1);
	...
	if (bond_uses_primary(bond)) {
		block_netpoll_tx();
		bond_select_active_slave(bond);
		unblock_netpoll_tx();
	}

	if (!slave_dev->netdev_ops->ndo_bpf ||
	    !slave_dev->netdev_ops->ndo_xdp_xmit) {

For the trunk modes the switch default arm already ran
bond_set_active_slave(new_slave) with new_slave->link == BOND_LINK_UP, so
bond_slave_can_tx() is true for it.

Can a concurrent bond_xdp_xmit(), which only takes rcu_read_lock() and does
not hold RTNL, pick that not-yet-validated slave in this window?

bond_xdp_xmit()
  bond_xdp_xmit_roundrobin_slave_get()
    slave_cnt = READ_ONCE(bond->slave_cnt);
    if (likely(slave_cnt)) {
        slave_id = bond_rr_gen_slave_id(bond) % slave_cnt;
        return bond_get_slave_by_id(bond, slave_id);

bond_get_slave_by_id() only checks bond_slave_can_tx(), never XDP
capability, and bond_xdp_xmit() then does:

	err = slave_dev->netdev_ops->ndo_xdp_xmit(slave_dev, 1, frames1, flags);

with no NULL test, so would this be an indirect call through a NULL
ndo_xdp_xmit for a slave that lacks it?

The devmap gate does not appear to help here either: __xdp_enqueue() and
is_valid_dst() only look at the bond device's xdp_features, which still
advertise NETDEV_XDP_ACT_NDO_XMIT during this window because
bond_xdp_set_features() only runs after the XDP block. The same exposure
looks reachable through bond_xmit_activebackup_slave_get() for
bond_uses_primary() modes, where bond_select_active_slave() may publish the
new slave as curr_active_slave before the capability check.

Would it make sense to move the ndo_bpf / ndo_xdp_xmit validation earlier,
before the slave is linked and counted?

[ ... ]

> @@ -2348,6 +2348,9 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>  	return 0;
>  
>  /* Undo stages on error */
> +err_slave_cnt:
> +	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt - 1);
> +
>  err_sysfs_del:
>  	bond_sysfs_slave_del(new_slave);
>  

[Severity: Medium]

These leaks are pre-existing, the three XDP exits already fell into this
same unwind chain before this patch, so they are not introduced here. Since
this patch adds the stage where the symmetric undo would belong, is it worth
handling the rest of the state applied just above the XDP block?

Reaching the XDP checks means this group has already run, with no
intervening label:

	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1);
	netdev_compute_master_upper_features(bond->dev, true);
	bond_set_carrier(bond);

	bond_slave_ns_maddrs_add(bond, new_slave);

err_slave_cnt reverses only the counter and falls through to err_sysfs_del,
so does the bond keep a feature mask recomputed from a device that never
became a slave, and for a first slave with an up link keep reporting
LOWER_UP with zero slaves, since nothing on the unwind path re-runs
netdev_compute_master_upper_features() or bond_set_carrier()?

Does bond_slave_ns_maddrs_add() also leak solicited-node multicast
addresses on the rejected netdev? bond_options.c takes real references:

	void bond_slave_ns_maddrs_add(struct bonding *bond, struct slave *slave)
	{
		if (!bond->params.arp_validate)
			return;
		slave_set_ns_maddrs(bond, slave, true);
	}

and no label between err_slave_cnt and err_undo_flags calls
bond_slave_ns_maddrs_del(). err_detach only re-runs
bond_change_active_slave() / bond_select_active_slave() when the new slave
had become curr_active_slave, so with mode=active-backup plus arp_validate
plus ns_ip6_target and the new slave staying backup, would these accumulate
on each retried enslave?

For round-robin and 802.3ad, which are both XDP-capable and not
bond_uses_primary(), the block above also ran:

	if (bond_dev->flags & IFF_PROMISC) {
		res = dev_set_promiscuity(slave_dev, 1);
	...
	if (bond_dev->flags & IFF_ALLMULTI) {
		res = dev_set_allmulti(slave_dev, 1);
	...
		dev_mc_sync_multiple(slave_dev, bond_dev);
		dev_uc_sync_multiple(slave_dev, bond_dev);
		if (BOND_MODE(bond) == BOND_MODE_8023AD)
			dev_mc_add(slave_dev, lacpdu_mcast_addr);

Does the released device stay in promiscuous and allmulti mode with the
multicast and unicast sync entries still programmed after the XDP failure?

__bond_release_one() performs exactly the mirror operations, which suggests
these are the required undo steps:

	bond_slave_ns_maddrs_del(bond, slave);
	...
	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt - 1);
	...
	netdev_compute_master_upper_features(bond->dev, true);
	...
		if (old_flags & IFF_PROMISC)
			dev_set_promiscuity(slave_dev, -1);
	...
		if (old_flags & IFF_ALLMULTI)
			dev_set_allmulti(slave_dev, -1);
	...
		if (old_flags & IFF_UP)
			bond_hw_addr_flush(bond_dev, slave_dev);

and that path is not reachable here because the enslave failed.
-- 
pw-bot: cr
