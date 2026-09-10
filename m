Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1872BE02C
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 00:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788999451; cv=none; b=aaUIhHDjFnqbACftavy1zOhpq4LZQZj6EDuS4zQoGAW8XZdagyFtkSaXHOtURfNOzEKFoYxxlYcn7J+v9pC66S+UxjbQTWYLPJVRtwbOg2FNy8T2BRCmEuPqn6bWjbc8P+hxiMbxCPqQ3gtxJLYOKNcgoVAHaJGjJWLWEdjXG+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788999451; c=relaxed/simple;
	bh=Y4afUhek7tkQgJjFZqXbF/pQjk3NQIjtgSSFNlOnQkU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jzb+cY+nPhl/oyeRlu7hgFa0EalKd6SC+fyaxcyG7Zf/LuDGD3Tj5Z6yfCMXuQuQyTZ7GF1SeeabpLTdK+JU6u3yEQwgJjryDtOGRCcw+ScangymmAVR8s4wEv3R1HHyLJhBcxJRJCXKaRinFIWDpEp0uPf1eeVtLVIgKXUIuEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPcqsI4Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPcqsI4Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE8D1F000FF;
	Thu, 10 Sep 2026 00:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788999448;
	bh=fVGKTVv+UXkgIx7wPOuv9snt2CYb2ccUV192dw9hiZ0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UPcqsI4QwRcsKPfo5z5Czx572xLtLdxo7AhPFAPvdM6k+JfYCRnpz6J4H924dGxFs
	 kr2993iNJbyXBg2DiVM55F8DXjeqcmymx2jQuGr0CN3WQtLfiXRuYViqSxKBs+vOwi
	 ZpMYWR0qYmGZta60AJwMLv8O4ut93AJ4VbbfhVU6UEzndtfKKBv/5Y/7fBBNFeY2kJ
	 uDSXbzIu5US338G3b0cPgsiIGcpMQfshNJsQNiyH+wFmXManbnWG5JO+gWZbQnDaGE
	 AbijdoLY9MNJWASQV4S51+tc/nuwz0RWFHZlcr2llYSQq6PmyANa7e08X5XcDyqNoN
	 rTZGlnxUoRmQg==
Subject:
 Re: [PATCH net-next v1 4/6] net: dsa: mt7628: add VLAN filtering support
From: netdev-bot+sashiko@kernel.org
To: joey@tinyisr.com
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net, olteanv@gmail.com,
 andrew@lunn.ch
Date: Thu, 10 Sep 2026 00:17:27 +0000
Message-ID: <178899944762.219967.5185318820000025922@kernel.org>
In-Reply-To: <20260906171625.533915-5-joey@tinyisr.com>
References: <20260906171625.533915-5-joey@tinyisr.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider:

Critical: 0 · High: 4 · Medium: 0 · Low: 2

- [High] mt7628_port_vlan_add() rejects with -EBUSY any VID that is
  already recorded in a VLAN-AWARE software block by a user port…
- [High] mt7628_port_vlan_add() accepts VLAN ID 0, but `vlan->vid == 0`
  is simultaneously the driver's 'slot is free' sentinel…
- [High] mt7628_vlan_sync() programs the per-VLAN egress-untag bitmap
  (VUB) with the CPU port bit set whenever a VLAN carries…
- [High] Two standalone ports can be incorrectly allowed to share the
  same VLAN ID, which breaks port isolation if they are later enslaved…
- [Low] Retained for policy combination only; my baseline verdict is
  FALSE POSITIVE.
- [Low] Retained for policy combination only; my baseline verdict is
  FALSE POSITIVE.

--

net: dsa: mt7628: add VLAN filtering support

This adds .port_vlan_filtering, .port_vlan_add and .port_vlan_del to the
MT7628 built-in switch driver.  Membership for tag_8021q and
user-requested VLANs is tracked in software, and only one of the two
VLAN types is programmed into hardware per port depending on that port's
VLAN filtering state.  A few questions below about the new
mt7628_vlan_sync() masking and about the input validation in
mt7628_port_vlan_add().

> diff --git a/drivers/net/dsa/mt7628.c b/drivers/net/dsa/mt7628.c
> index 7eabfad3e1144..629dbf968a171 100644
> --- a/drivers/net/dsa/mt7628.c
> +++ b/drivers/net/dsa/mt7628.c

[ ... ]

> @@ -442,10 +443,16 @@ static int mt7628_port_join_vlan_block(struct dsa_switch *ds, int port, u16 vid,
>  		return -ENOSPC;
>  
>  	vlan->members |= BIT(port);
> +
>  	if (flags & BRIDGE_VLAN_INFO_PVID)
> -		esw->tag_8021q_pvid[port] = vid;
> +		esw->pvid[type][port] = vid;
> +	else if (esw->pvid[type][port] == vid)
> +		esw->pvid[type][port] = 0;
> +
>  	if (flags & BRIDGE_VLAN_INFO_UNTAGGED)
>  		vlan->untag |= BIT(port);
> +	else
> +		vlan->untag &= ~BIT(port);
>  	return 0;
>  }

[ ... ]

> @@ -473,18 +480,42 @@ static int mt7628_port_leave_vlan_block(struct dsa_switch *ds, int port,
>  static void mt7628_vlan_sync(struct dsa_switch *ds)
>  {
>  	struct mt7628_esw *esw = ds->priv;
> +	struct dsa_port *dp;
>  	int i;
>  
>  	for (i = 0; i < MT7628_NUM_VLANS; i++) {
>  		struct mt7628_vlan *vlan = &esw->vlans[i];
> +		u8 member_mask;
> +
> +		if (vlan->type == MT7628_VLAN_TYPE_AWARE)
> +			member_mask = esw->vlan_filtering;
> +		else
> +			member_mask = ~esw->vlan_filtering;
> +		member_mask |= MT7628_ESW_PORTS_CPU;

[Severity: High]
Should the CPU bit be forced into the untag mask as well as the member
mask here?

member_mask always has MT7628_ESW_PORTS_CPU OR'ed in, and it is applied
to both values:

	mt7628_esw_set_vmsc(esw, i, vlan->members & member_mask);
	mt7628_esw_set_vub(esw, i, vlan->untag & member_mask);

The CPU port bit can be set in vlan->untag: when a port joins a bridge,
br_switchdev_vlan_replay() replays the bridge master's default_pvid with
BRIDGE_VLAN_INFO_UNTAGGED, and dsa_user_host_vlan_add() only clears
BRIDGE_VLAN_INFO_PVID:

net/dsa/user.c:dsa_user_host_vlan_add() {
	...
	/* Even though drivers often handle CPU membership in special ways,
	 * it doesn't make sense to program a PVID, so clear this flag.
	 */
	vlan.flags &= ~BRIDGE_VLAN_INFO_PVID;
	...
}

so mt7628_port_join_vlan_block() executes vlan->untag |= BIT(cpu), and
MT7628_ESW_VUB_M covers bit 6, so the CPU egress untag really lands in
hardware.

The MT7628 special tag lives in the VLAN tag itself, and the receive path
decodes it unconditionally:

net/dsa/tag_mt7628.c:mt7628_tag_rcv() {
	phdr = dsa_etype_header_pos_rx(skb);
	...
	skb_pull_rcsum(skb, MT7628_TAG_LEN);
	dsa_strip_etype_header(skb, MT7628_TAG_LEN);
}

If frames reach the conduit untagged, does mt7628_tag_rcv() then read the
frame's real EtherType as the source port and eat 4 bytes of payload?
For IPv4 (0x0800) the port field decodes as 0 and 4 bytes of the IP
header are removed; for ARP (0x0806) it decodes as 6 (the CPU port) and
dsa_conduit_find_user() returns NULL.

Before this patch tag_8021q passed flags = 0 for CPU and DSA ports, so
the CPU untag bit could never be set.  Would masking BIT(cpu) out of the
VUB value (keeping the CPU a tagged member of every VLAN) be the right
fix?

> +		/*
> +		 * Put VLAN filtering ports only into VLAN aware VLANs and
> +		 * non VLAN filtering ports into VLAN unaware VLANs.
> +		 *
> +		 * CPU may not be removed from any VLAN, as VLAN filtering
> +		 * applies only to user ports.
> +		 */
>  
> -		mt7628_esw_set_vmsc(esw, i, vlan->members);
>  		mt7628_esw_set_vlan_id(esw, i, vlan->vid);
> -		mt7628_esw_set_vub(esw, i, vlan->untag);
> +		mt7628_esw_set_vmsc(esw, i, vlan->members & member_mask);
> +		mt7628_esw_set_vub(esw, i, vlan->untag & member_mask);

[Severity: Low]
This one looks like it resolves itself later in the series, so it is more
of a note than a bug report.

Masking here removes VLAN-filtering ports from the membership and untag
masks of all UNAWARE (tag_8021q) blocks, while mt7628_port_vlan_add()
refuses dsa_8021q VIDs in AWARE blocks, so at this commit no VLAN entry
permits or untags the VID that mt7628_tag_xmit() inserts for such a port.

The later commit "net: dsa: tag: mt7628: add VLAN awareness support" adds
a VLAN-aware egress path that only rewrites the TPID:

net/dsa/tag_mt7628.c:mt7628_tag_xmit() {
	if (skb->offload_fwd_mark &&
	    br_vlan_enabled(dsa_port_bridge_dev_get(dp))) {
		tag = dsa_etype_header_pos_tx(skb);
		tag[0] = htons(xmit_tpid);
		return skb;
	}
	...
}

so tag_8021q membership is no longer needed for filtering ports.  Frames
injected directly on a bridged user netdev (offload_fwd_mark == 0, e.g.
STP BPDUs) still use the standalone tag_8021q VID though - is that path
expected to work on a filtering port?

> +
>  	}
>  
> -	for (i = 0; i < ds->num_ports; i++)
> -		mt7628_esw_set_pvid(esw, i, esw->tag_8021q_pvid[i]);
> +	dsa_switch_for_each_user_port(dp, ds) {
> +		unsigned int type = BIT(dp->index) & esw->vlan_filtering ?
> +		    MT7628_VLAN_TYPE_AWARE : MT7628_VLAN_TYPE_UNAWARE;
> +		mt7628_esw_set_pvid(esw, dp->index, esw->pvid[type][dp->index]);
> +	}
> +	regmap_update_bits(esw->regmap, MT7628_ESW_REG_SGC2,
> +			   MT7628_ESW_SGC2_DOUBLE_TAG_EN,
> +			   FIELD_PREP(MT7628_ESW_SGC2_DOUBLE_TAG_EN,
> +				      MT7628_ESW_PORTS_NOCPU &
> +				      ~esw->vlan_filtering));

[Severity: Low]
Also not a bug at the end of the series, just a bisectability note.

Clearing MT7628_ESW_SGC2_DOUBLE_TAG_EN for VLAN-filtering ports means the
switch no longer inserts an outer tag, so at this commit mt7628_tag_rcv()
decodes the source port from the wire TPID and strips 4 bytes.  The later
commit "net: dsa: tag: mt7628: add VLAN awareness support" handles that
case:

net/dsa/tag_mt7628.c:mt7628_tag_rcv() {
	...
	if (source_port == 0 && !is_dsa_8021q)
		skb->dev = dsa_find_designated_bridge_port_by_vid(dev, vid);
	else
		skb->dev = dsa_conduit_find_user(dev, 0, source_port);
	...
}

Since the driver change lands before the tagger change, is receive broken
for VLAN-filtering ports at this point in the series?  Would reordering
the two patches help bisection?

>  }
>  
>  static int mt7628_setup(struct dsa_switch *ds)

[ ... ]

> @@ -598,6 +629,78 @@ static int mt7628_dsa_8021q_vlan_del(struct dsa_switch *ds, int port, u16 vid)
>  	return 0;
>  }
>  
> +static int mt7628_port_vlan_filtering(struct dsa_switch *ds, int port,
> +				      bool vlan_filtering,
> +				      struct netlink_ext_ack *extack)
> +{
> +	struct mt7628_esw *esw = ds->priv;
> +
> +	if (vlan_filtering)
> +		esw->vlan_filtering |= BIT(port);
> +	else
> +		esw->vlan_filtering &= ~BIT(port);
> +	mt7628_vlan_sync(ds);
> +	return 0;
> +}
> +
> +static int mt7628_port_vlan_add(struct dsa_switch *ds, int port,
> +				const struct switchdev_obj_port_vlan *vlan,
> +				struct netlink_ext_ack *extack)
> +{
> +	struct mt7628_vlan *vlan_block;
> +	struct dsa_port *other_dp;
> +	struct dsa_port *dp;
> +	int ret;
> +
> +	if (vid_is_dsa_8021q(vlan->vid)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Range 3072-4095 reserved for dsa_8021q operation");
> +		return -EBUSY;
> +	}

[Severity: High]
Does VLAN ID 0 need to be rejected (or ignored) here too?

VID 0 is the driver's "slot is free" sentinel:

drivers/net/dsa/mt7628.c:mt7628_find_vlan_block() {
	for (i = 0; i < MT7628_NUM_VLANS; i++) {
		vlan = &esw->vlans[i];
		if (vlan->vid == vid && vlan->type == type)
			return vlan;
	}
}

drivers/net/dsa/mt7628.c:mt7628_alloc_vlan_block() {
		if (vlan->vid)
			continue;
		if (vlan->type != type)
			continue;
		vlan->vid = vid;
		return vlan;
}

VID 0 arrives on its own for a VLAN-filtering port: dsa_port_vlan_filtering()
sets NETIF_F_HW_VLAN_CTAG_FILTER on the user netdev, and on the next
NETDEV_UP the 8021q core pushes VID 0 down:

net/8021q/vlan.c:vlan_vid0_add() {
	if (!(dev->features & NETIF_F_HW_VLAN_CTAG_FILTER))
		return;

	pr_info("adding VLAN 0 to HW filter on device %s\n", dev->name);

	err = vlan_vid_add(dev, htons(ETH_P_8021Q), 0);
}

which reaches dsa_user_vlan_rx_add_vid() -> dsa_port_vlan_add() ->
ds->ops->port_vlan_add() with vid 0.  So "ip link set swp0 master br0"
(vlan_filtering 1) followed by "ip link set swp0 up" delivers vid 0 here.
mt7530, b53, mv88e6xxx and rtl8365mb all special-case vid 0 in their
.port_vlan_add for this reason.

With vid 0, mt7628_find_vlan_block() matches the first unused AWARE slot,
so mt7628_alloc_vlan_block() never runs and mt7628_port_join_vlan_block()
leaves vlan->vid at 0 while doing:

	vlan->members |= BIT(port);

Can the next real VLAN add then be handed that same still-vid-0 slot by
mt7628_alloc_vlan_block(), inheriting the stale members bitmap?  In that
case the block did not exist before the add, so the cross-bridge check
below is skipped, and mt7628_vlan_sync() would program a port of one
bridge as a hardware member of another bridge's VLAN.

> +
> +	vlan_block =
> +	    mt7628_find_vlan_block(ds, vlan->vid, MT7628_VLAN_TYPE_AWARE);
> +	dp = dsa_to_port(ds, port);
> +	/*
> +	 * CPU port can be added to any VLANs, but user ports need to ensure,
> +	 * that if the VLAN already exists it's not used by a bridge we're not
> +	 * a member of, because VLANs are the only form of forwarding control
> +	 * we have on this switch.
> +	 */
> +	if (vlan_block && !dsa_port_is_cpu(dp)) {
> +		dsa_switch_for_each_user_port(other_dp, ds) {
> +			if (other_dp == dp)
> +				continue;
> +			if (other_dp->bridge == dp->bridge)
> +				continue;
> +			if (!(vlan_block->members & BIT(other_dp->index)))
> +				continue;
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "VLAN ID used on another bridge");
> +			return -EBUSY;
> +		}
> +	}

[Severity: High]
Should this comparison require that the two ports are actually
bridged, rather than just having equal dp->bridge pointers?

For two standalone user ports both dp->bridge and other_dp->bridge are
NULL, so the test above evaluates NULL == NULL and skips the conflict
check - the two ports are treated as if they were members of the same
forwarding domain.  Standalone ports do reach .port_vlan_add: adding an
8021q upper ("ip link add link swp0 name swp0.10 type vlan id 10")
goes through dsa_user_vlan_rx_add_vid() -> dsa_port_vlan_add() ->
mt7628_port_vlan_add(), so doing that on swp0 and swp1 leaves the AWARE
block for VID 10 with members = BIT(swp0) | BIT(swp1).

Nothing re-validates that state later.  The membership only becomes
visible in hardware once esw->vlan_filtering gains the port bits, and
mt7628_port_vlan_filtering() just sets/clears the bit and calls
mt7628_vlan_sync(), which programs vlan->members & esw->vlan_filtering
into the VMSC entry.  So if the two ports are subsequently enslaved to
different VLAN-aware bridges, is the shared VID 10 block programmed with
both ports as members, giving exactly the cross-bridge forwarding this
check was written to prevent?

Treating a NULL bridge as its own isolation domain (i.e. only skipping
when both ports are bridged into the same dsa_bridge) would catch the
add-then-enslave order too, but it would also refuse the very common
case of the same VLAN ID on two independent standalone ports, which
works fine as long as neither is bridged.  Would it be better to keep
the permissive behaviour at add time and instead re-run the conflict
check from .port_bridge_join / .port_vlan_filtering, where the actual
isolation domains are known?

[Severity: High]
Does this check prevent a second bridge from ever being created on this
switch?

DSA sets ds->configure_vlan_while_not_filtering = true before ops->setup(),
so bridge VLANs are handed to the driver regardless of the bridge's
vlan_filtering state.  br_add_if() then unconditionally installs
br->default_pvid (1, with PVID|UNTAGGED|BRENTRY) and aborts the
enslavement on error:

net/bridge/br_if.c:br_add_if() {
	err = nbp_vlan_init(p, extack);
	if (err) {
		netdev_err(dev, "failed to initialize vlan filtering on this port\n");
		goto err6;
	}
}

__vlan_vid_add() propagates any switchdev error other than -EOPNOTSUPP,
so the -EBUSY above is fatal.  After "ip link set swp0 master br0" the
AWARE block for VID 1 has members = BIT(swp0); "ip link set swp1 master
br1" then finds that block, sees a different dp->bridge pointer, and
returns -EBUSY.  Before this patch .port_vlan_add was absent, so
dsa_switch_vlan_add() returned -EOPNOTSUPP and the join succeeded, which
makes the max_num_bridges = DSA_TAG_8021Q_MAX_NUM_BRIDGES support added
earlier in the series unreachable without first changing
vlan_default_pvid on every bridge.

Would it make sense to skip the rejection when the conflicting membership
is not actually programmed?  mt7628_vlan_sync() masks AWARE members with
esw->vlan_filtering:

	if (vlan->type == MT7628_VLAN_TYPE_AWARE)
		member_mask = esw->vlan_filtering;

so a non-filtering port is never written into an AWARE VMSC entry and no
cross-bridge forwarding could result from it.

> +	ret =
> +	    mt7628_port_join_vlan_block(ds, port, vlan->vid,
> +					MT7628_VLAN_TYPE_AWARE, vlan->flags);
> +	if (ret)
> +		return ret;
> +
> +	mt7628_vlan_sync(ds);
> +	return 0;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906171625.533915-1-joey%40tinyisr.com
