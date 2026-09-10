Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A802609E3
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 00:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788999448; cv=none; b=afoBy8Vwyhg9rOaZKM7t2GnhPVfb64BBKhfUm4l4gP/91Yzpyy/KH0/TjWFeii4ZDvP0G32O9f3lU86R3pwJN/2opWIZ4O9FWe9vbZT/fHpTnbttW/LK+xfEx/yJ2CR3jQspZGoY1ccmg1PaeuDatklmSAGY2MR/hyoakMSuTF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788999448; c=relaxed/simple;
	bh=kAIv88/JZe/WBc/Elj3VzSm4FsR0+bXdlY7u8Bqy0S4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GEKYgji8kz6IEMZ5QVoJj5HK7af76hjeyI50u+OCt+SxVbTkmwaipjvsVJgdJrQfVZ6x3AHTjzfE7Jvmiy4c+CX6GL6iSS0bs8M/98tHpSDA79P52WxtT4RCgOn3q4ByV4PmupjOZUk/ewZhYsEEwXa+1d2oqwLTBAQptVGfUQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqUuXpwR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqUuXpwR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F42181F00893;
	Thu, 10 Sep 2026 00:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788999446;
	bh=RZcEX6jAqjJrFFzqpuMyAKjUQsF9MEC5RSismqfKZH0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DqUuXpwRKmN1J1ZfrK2tUGRRJCOzBFcgaKq6TxNpFKm4ZtuJU/aw+5NCpYXgKi4Le
	 HIyVqJhjHGBWMoLxYGQdtST9WtWfMeVJ2h3ACbxQG+Xfu2PD0hGt+mSext0IyqGx2d
	 mmF5U4bFU2vIHhUdFQjzYPr/RoQRNB7QLqR9ZutAc6vnN0ZzxPPGopGDbFtPV6r4Nu
	 BbOpPOjXLrptPjDTnJ38Rdf8puP3e8tEgEYk73vNVEZyzxNptb+HNFDi5EtqmigT52
	 4KpVOwHUdkH9PE5JmOU8c4ZAyS7n9FD5ZDJprSBZVeD/u/ijBqHnucC7K1upRI17G/
	 GCzcHudEokPkA==
Subject:
 Re: [PATCH net-next v1 2/6] net: dsa: mt7628: add port bridge offload support
From: netdev-bot+sashiko@kernel.org
To: joey@tinyisr.com
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net, olteanv@gmail.com,
 andrew@lunn.ch
Date: Thu, 10 Sep 2026 00:17:25 +0000
Message-ID: <178899944558.219967.8214424150936383852@kernel.org>
In-Reply-To: <20260906171625.533915-3-joey@tinyisr.com>
References: <20260906171625.533915-3-joey@tinyisr.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 2 · Low: 1

- [High] Bridge TX forwarding offload is advertised but the MT7628 tagger
  never performs an imprecise/flooding transmit, so locally-originated…
- [Medium] STP/bridge offload is added without the paired hardware-FDB
  flush: mt7628_switch_ops gains .port_stp_state_set…
- [Medium] Newly reachable non-unwound partial failure of bridge join
  leaves the driver's private VLAN state permanently corrupted.
- [Low] At this commit only, bridged ports transmit with a VID that no
  longer exists in the hardware VLAN table.

--

net: dsa: mt7628: add port bridge offload support

This adds a .port_stp_state_set implementation that drives the POC1
blocking/learning bits, and wires the generic tag_8021q bridge join and
leave helpers into mt7628_switch_ops so bridges can be offloaded.

A few questions about the new hooks below.

> diff --git a/drivers/net/dsa/mt7628.c b/drivers/net/dsa/mt7628.c
> index 990556cc2f655..7eabfad3e1144 100644
> --- a/drivers/net/dsa/mt7628.c
> +++ b/drivers/net/dsa/mt7628.c

[ ... ]

> @@ -599,6 +605,40 @@ static void mt7628_teardown(struct dsa_switch *ds)
>  	rtnl_unlock();
>  }
>  
> +static void mt7628_stp_state_set(struct dsa_switch *ds, int port, u8 state)
> +{
> +	struct mt7628_esw *esw = ds->priv;
> +	bool forward_disable;
> +	bool learn_disable;
> +
> +	switch (state) {
> +	case BR_STATE_DISABLED:
> +	case BR_STATE_BLOCKING:
> +	case BR_STATE_LISTENING:
> +		forward_disable = true;
> +		learn_disable = true;
> +		break;

[Severity: Medium]
Should this series also add a .port_fast_age implementation to go with
the new STP hook?

dsa_port_set_state() in net/dsa/port.c calls the driver's
port_stp_state_set() and then asks for fast ageing on every transition
out of LEARNING/FORWARDING:

net/dsa/port.c:dsa_port_set_state() {
	...
	if (!dsa_port_can_configure_learning(dp) ||
	    (do_fast_age && dp->learning)) {
		...
		dsa_port_fast_age(dp);
	}
}

mt7628_switch_ops has no .port_bridge_flags, so
dsa_port_can_configure_learning() returns false and the branch is always
taken. dsa_port_fast_age() then does nothing at all, including skipping
the SWITCHDEV_FDB_FLUSH_TO_BRIDGE notification:

net/dsa/port.c:dsa_port_fast_age() {
	...
	if (!ds->ops->port_fast_age)
		return;
	...
}

Since mt7628_stp_state_set() only sets MT7628_ESW_POC1_PORT_BLOCKING_STATE,
do the addresses the ASIC learned while the port was forwarding stay in
the L2 table after a topology change, a link down, or an
"ip link set swp0 nomaster"?  If so, does the hardware keep resolving
those MACs to the now blocked/standalone port and drop the frames until
the aging interval that mt7628_switch_init() programs (the comment there
documents it as 300 s) expires?

mt7530.c pairs the same offload with mt7530_port_fast_age() for this
case.

> +	case BR_STATE_LEARNING:
> +		forward_disable = true;
> +		learn_disable = false;
> +		break;
> +	case BR_STATE_FORWARDING:
> +		forward_disable = false;
> +		learn_disable = false;
> +		break;
> +	default:
> +		dev_err(ds->dev, "invalid STP state: %d\n", state);
> +		return;
> +	}
> +
> +	regmap_assign_bits(esw->regmap, MT7628_ESW_REG_POC1,
> +			   FIELD_PREP(MT7628_ESW_POC1_PORT_DIS_LEARNING,
> +				      BIT(port)), learn_disable);
> +	regmap_assign_bits(esw->regmap, MT7628_ESW_REG_POC1,
> +			   FIELD_PREP(MT7628_ESW_POC1_PORT_BLOCKING_STATE,
> +				      BIT(port)), forward_disable);
> +}
> +
>  static const struct dsa_switch_ops mt7628_switch_ops = {
>  	.get_tag_protocol = mt7628_get_tag_proto,
>  	.setup = mt7628_setup,
> @@ -608,6 +648,9 @@ static const struct dsa_switch_ops mt7628_switch_ops = {
>  	.phylink_get_caps = mt7628_phylink_get_caps,
>  	.tag_8021q_vlan_add = mt7628_dsa_8021q_vlan_add,
>  	.tag_8021q_vlan_del = mt7628_dsa_8021q_vlan_del,
> +	.port_bridge_join = dsa_tag_8021q_bridge_join,
> +	.port_bridge_leave = dsa_tag_8021q_bridge_leave,

[Severity: High]
Does using dsa_tag_8021q_bridge_join() here promise more than the
mt7628 tagger delivers?

dsa_tag_8021q_bridge_join() sets tx_fwd_offload unconditionally:

net/dsa/tag_8021q.c:dsa_tag_8021q_bridge_join() {
	...
	*tx_fwd_offload = true;
	...
}

dsa_port_bridge_join() stores that in dp->bridge->tx_fwd_offload and
passes it to switchdev_bridge_port_offload(), so the bridge sets
BR_TX_FWD_OFFLOAD_BIT.  On egress the bridge then hands the driver only
one copy per hwdom:

net/bridge/br_switchdev.c:nbp_switchdev_allowed_egress() {
	return !test_bit(p->hwdom, &cb->fwd_hwdoms) &&
	       (!skb->offload_fwd_mark || cb->src_hwdom != p->hwdom);
}

But mt7628_tag_xmit() in net/dsa/tag_mt7628.c always builds a precise
single-port mask:

	xmit_tpid = ETH_P_8021Q |
		FIELD_PREP(MT7628_TAG_TX_PORT, dsa_xmit_port_mask(skb, dev));

and dsa_xmit_port_mask() in net/dsa/tag.h starts from
"unsigned long mask = BIT(dp->index);" and only ever adds HSR peers, so
the mask is never widened to the bridge members.

With two ports in one bridge, do flooded frames (ARP, DHCP, IPv6 ND,
mDNS, unknown unicast) originating from the host or from another hwdom
reach only one of the members, with the bridge suppressing the remaining
copies?  tag_sja1105.c has sja1105_imprecise_xmit() for this; is an
equivalent flooding transmit path needed in tag_mt7628.c?  The final
state of the series still selects only the bridge VID on
skb->offload_fwd_mark and leaves the destination port mask untouched.

[Severity: Low]
At this commit alone, does a bridged port transmit with a VID that is no
longer present in the hardware VLAN table?

dsa_tag_8021q_bridge_join() adds the bridge VID and then removes the
standalone one:

net/dsa/tag_8021q.c:dsa_tag_8021q_bridge_join() {
	...
	dsa_port_tag_8021q_vlan_del(dp, standalone_vid, false);
	...
}

That reaches mt7628_dsa_8021q_vlan_del() -> mt7628_port_leave_vlan_block(),
which clears the members and untag bits and, for the last member, the VID
itself:

	vlan->members &= ~BIT(port);
	vlan->untag &= ~BIT(port);
	if (!vlan->members)
		vlan->vid = 0;

and mt7628_vlan_sync() commits that to hardware.  The tagger at this
commit still does:

net/dsa/tag_mt7628.c:mt7628_tag_xmit() {
	...
	xmit_vlan = dsa_tag_8021q_standalone_vid(dp);
	...
}

The following patch in the series ("net: dsa: tag: mt7628: add bridge
support", 4ed08042206018344b61ac96d48a0c9a44800b8f) changes this to pick
dsa_tag_8021q_bridge_vid() when skb->offload_fwd_mark is set, so the end
of the series is fine.  Would it be worth merging the two so that
bisecting does not land on a commit where bridged ports do not pass CPU
traffic?

[Severity: Medium]
Can a failed bridge join leave the driver's private VLAN slots
permanently occupied?

dsa_tag_8021q_bridge_join() first programs the bridge VID on all ports.
dsa_switch_tag_8021q_vlan_add() walks the ports in index order, so the
user port is programmed first and mt7628_port_join_vlan_block() claims a
slot and records the PVID:

	vlan->members |= BIT(port);
	if (flags & BRIDGE_VLAN_INFO_PVID)
		esw->pvid[type][port] = vid;

The CPU port is handled afterwards and can fail before the driver op
runs:

net/dsa/tag_8021q.c:dsa_port_do_tag_8021q_vlan_add() {
	...
	v = kzalloc_obj(*v);
	if (!v)
		return -ENOMEM;
	...
}

net/dsa/tag_8021q.c:dsa_switch_tag_8021q_vlan_add() {
	...
			err = dsa_port_do_tag_8021q_vlan_add(dp, info->vid, flags);
			if (err)
				return err;
	...
}

The error propagates to dsa_port_bridge_join(), which takes the
out_rollback path calling only dsa_port_bridge_destroy() and never
broadcasting DSA_NOTIFIER_BRIDGE_LEAVE, so mt7628_port_leave_vlan_block()
is not called for the bridge VID.

Does that leave one of the MT7628_ESW_NUM_USER_PORTS + 1 reserved slots
with vlan->vid != 0 and members = BIT(port) forever, so
mt7628_alloc_vlan_block() can never reuse it and later joins can hit
-ENOSPC?  And with the port's hardware PVID pointing at a VLAN that has
no CPU member, does that port lose CPU connectivity with no path that
restores it?  The non-unwinding part is in the DSA core and shared with
other tag_8021q users, but this patch makes it reachable for mt7628;
would restoring the standalone VID on join failure be feasible here?
This is still the case at the end of the series.

> +	.port_stp_state_set = mt7628_stp_state_set,
>  };
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906171625.533915-1-joey%40tinyisr.com
