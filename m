Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793239362;
	b=y96GSrQWSglHSSYic6grzyCuZMmCfYhTvsw5C/zlqnIYz7xlSohi+cdeXqHRaLgplvN9
	 hGEYS2MrVsXqv1ZeCaeKEtEIQCxtxbvu/cra1R+GfVDYhurwjHDLbeQMKwxY/VIAJBY6T
	 M1BtjmR/bnxmSwaQea1v28x5MD3MDs0e7Cf47zUP/8wEhgp6Q7s9bVO1m2AaVm1sviaL0
	 2lDBz/xZV4V9Cwof1U0/G1dHHI5GCRf9tfyeuXeWUIa07k5eaVOtfexKUZ98NqREUil4d
	 Mno0APzCM8jMRwriyt8z2bIkvIRqz0q18OHG+tNQALzhuddRLQ6bwUse6U5emns5HFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793239362;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=VBJf2p2b3EPIn54vogBNL6ir9d6wSC1UuwMhnG8hxv0=;
	b=2XpHTk/JL9h55fnAuDRWtVD+RRmTtJ45n1I4xPd/gUiGO7Ae9kWsSw7izzXRht5JZqk9
	 NShpa2pnGVZWTVBEOKexZgnenZ6L3WERTnnX+WKqK/MLGR69/wJwByKKV0ekfdha0cj+2
	 Oa2gpOIr6IyhH/VzVyZ0+VW7j+7Fh2C20TVPwc4WzUttESqKFjcJGophlhJpE/piElUZl
	 X+B94YWspKiDdpYAh84q6oVHHRt2cQ39vRQ+hy6hAPYLikx2OLIVsTZkHLvlmKHXbAx7C
	 E1SohkGV9tWvflG9/mEbp9hOAem/MNMUnvCWOKW1KAEoSsfn7faH4KQJpffIYEWw1vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CWWRF/bW";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D220C606A31D;
	Thu, 29 Oct 2026 02:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CWWRF/bW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D676E1F031E2;
	Thu, 29 Oct 2026 02:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793239361;
	bh=VBJf2p2b3EPIn54vogBNL6ir9d6wSC1UuwMhnG8hxv0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CWWRF/bWQ1GTFpZPcUOIFvxE1YL2K3fl6FOoLPONHv+HCXNRlg2890Acwi48yuMKK
	 YWPuBdI1meiMF0AMva6xN/iVYqNlegq2Sbp8F7wSuqYhqxCF00LxAYEEZxwj1goRTF
	 FSAdVxdH8w1RdtEu4WKdjIb9IccxgNGALV/Xe6V54j0WMm4MW9DbdtKR7Q0ets77wJ
	 6nvEpAxr6epNZ6UhldCsvcwnKfdNU/oS2saCuZ9GiS1RAIq0CykGCW4tFaDCYKV1Y9
	 YXu/rbwZTkpHpCyeEg6iFIhGJHBCM0opJnGMT5oRCNFT2J/I/Ytqc04DeH9xNy/LV1
	 oFShLhjBmxRQw==
Subject:
 Re: [PATCH v3 3/7] net: dsa: mediatek: add support for passthrough mode
From: netdev-bot+sashiko@kernel.org
To: cjd@cjdns.fr
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 chester.a.unal@arinc9.com, daniel@makrotopia.org, linux@armlinux.org.uk,
 arinc.unal@arinc9.com, Landen.Chao@mediatek.com, dqfext@gmail.com,
 sean.wang@mediatek.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, naseefkm@gmail.com, b.larsson@gmx.com
Date: Thu, 29 Oct 2026 02:02:39 +0000
Message-ID: <179323935937.3134.5815660700328148917@kernel.org>
In-Reply-To: <20261028011317.1557238-4-cjd@cjdns.fr>
References: <20261028011317.1557238-4-cjd@cjdns.fr>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 10 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 6 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] mt753x_check_passthrough() uses one counter for every available
  port that has an `ethernet` (CPU) phandle or a `link` (DSA) phandle.
- [High] net: dsa: mt7530: NULL pointer dereference in
  mt7531_mac_config() on DSA port
- [Medium] In passthrough mode, mt753x_cpu_port_enable() calls
  mt7530_port_change_mtu(ds, port, MT7530_MAX_MTU) to raise the global…
- [Medium] The patch adds support for this switch being the downstream
  switch, with a DSA port as its upstream link.
- [Medium] Passthrough receive works only if the downstream switch is DSA
  switch index 0.
- [Medium] In the user-port branch, mt7530_port_enable() replaces the
  per-port `dp->cpu_dp->index` with the switch-wide…
- [Medium] In passthrough mode, mt753x_cpu_port_enable() writes
  MT7530_PVC_P(port) = VLAN_ATTR(MT7530_VLAN_TRANSPARENT) |…
- [Medium] In passthrough mode the upstream switch's CPU port no longer
  has PORT_SPEC_TAG; mt753x_cpu_port_enable() writes…
- [Low] In passthrough mode, mt753x_cpu_port_enable() unconditionally
  sets MT7530_LOOP_DET_DISABLE (BIT(14)) in MT753X_MTRAP (0x7804) with a…
- [Low] When the downstream DSA link port is enabled,
  mt7530_port_enable() does a full `regmap_write(priv->regmap,…

--

net: dsa: mediatek: add support for passthrough mode

This adds a passthrough mode to the mt7530 driver. In this mode a switch
forwards all traffic between its CPU port and a link to a second,
downstream MT7530 without changing the MediaTek tag, and most switchdev
ops become no-ops. Passthrough is detected at probe time from the device
tree, and the switch can also act as the downstream switch, with a DSA
link as its upstream port.

> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index d10194488bdee..3eb2e11d69856 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c

[ ... ]

> @@ -1286,13 +1292,41 @@ mt753x_trap_frames(struct mt7530_priv *priv)
>  				   TO_CPU_FW_CPU_ONLY);
>  }
>  
> +static int
> +mt7530_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu);
> +
> +/* If this switch is downstream of another switch that is in passthrough mode,
> + * the "CPU" port is actually a DSA port.
> + */
>  static void
>  mt753x_cpu_port_enable(struct dsa_switch *ds, int port)
>  {
>  	struct mt7530_priv *priv = ds->priv;
>  
> -	/* Enable Mediatek header mode on the cpu port */
> -	regmap_write(priv->regmap, MT7530_PVC_P(port), PORT_SPEC_TAG);
> +	if (priv->is_passthrough) {
> +		/* Disable parsing of the DSA tag, it will be forwarded blindly
> +		 * to the downstream switch.
> +		 */
> +		regmap_write(priv->regmap, MT7530_PVC_P(port),
> +			     VLAN_ATTR(MT7530_VLAN_TRANSPARENT) |
> +			     PVC_EG_TAG(MT7530_VLAN_EG_DISABLED));

[Severity: Medium]
Does this EG_DISABLED setting survive setup? As soon as
mt753x_cpu_port_enable() returns, the same loop iteration in mt7530_setup()
runs this:

	if (dsa_is_upstream_port(ds, i)) {
		mt753x_cpu_port_enable(ds, i);
	} else {
		...
	}
	/* Enable consistent egress tag */
	regmap_update_bits(priv->regmap, MT7530_PVC_P(i),
			   PVC_EG_TAG_MASK,
			   PVC_EG_TAG(MT7530_VLAN_EG_CONSISTENT));

mt7531_setup_common() does the same update. So the upstream port ends up
with EG_TAG set to consistent. The downstream DSA port is programmed later
from mt7530_port_enable() and keeps EG_DISABLED.

That doesn't match the commit message, which says both ports are
"configured as MT7530_VLAN_EG_DISABLED and MT7530_VLAN_TRANSPARENT".

Should the egress tag update be skipped for the upstream port in
passthrough mode?

[Severity: Medium]
Without PORT_SPEC_TAG on the CPU port, frames from the host go through the
normal ARL and trap logic. mt753x_trap_frames() still installs the BPC,
RGAC1 and RGAC2 rules unconditionally. Those rules use TO_CPU_FW_CPU_ONLY
for PAE, BPDU and 01:80:C2:00:00:01/02/03/0E.

Say the host sends an STP BPDU, LACPDU, EAPOL or LLDP frame on a downstream
user port. The real DA is still at the front of the frame, because the MTK
tag sits after the SA.

Would that frame match the trap rules and be sent to the CPU port? That is
its own ingress port, so the frame would never reach the downstream switch.

Control frames from the downstream switch to the host would still work, so
the failure would be one-way. This depends on the switch applying trap
rules to untagged frames that enter the CPU port, which I could not confirm
without the datasheet.

> +
> +		/* The port is not configured to parse DSA tags, so they are
> +		 * liable to be confused for length fields, so length check is
> +		 * disabled.
> +		 */
> +		regmap_clear_bits(priv->regmap, MT753X_AGC, AGC_L2LEN_CHK);
> +
> +		/* In passthrough mode, MTU is only enforced downstream */
> +		mt7530_port_change_mtu(ds, port, MT7530_MAX_MTU);

[Severity: Medium]
Does this call do anything? This branch runs only when priv->is_passthrough
is true. This patch also adds the following as the first check in
mt7530_port_change_mtu():

	if (priv->is_passthrough)
		return 0;

So MT7530_GMACCR is never written, and MAX_RX_PKT_LEN on the passthrough
switch keeps its reset default. Later DSA .port_change_mtu calls for this
switch return early in the same way.

The upstream switch no longer parses the MTK tag, so it counts those 4
bytes as payload. Meanwhile .port_max_mtu still reports MT7530_MAX_MTU and
.port_change_mtu reports success.

Can the downstream switch and the DSA core then accept MTUs whose frames
the upstream switch drops? Clearing AGC_L2LEN_CHK turns off the length field
check, but it does not change the MAC's maximum frame length.

> +
> +		/* Loop detection has no value in passthrough mode */
> +		regmap_set_bits(priv->regmap, MT753X_MTRAP,
> +				MT7530_LOOP_DET_DISABLE);

[Severity: Low]
Is BIT(14) of MT753X_MTRAP valid on every chip that can reach this code?
mt753x_cpu_port_enable() is also called from mt7531_setup_common(), which
covers MT7531, MT7988, EN7581 and AN7583.

The MTRAP layout differs between chip families. For example, BIT(8) is
MT7530_P6_DIS on MT7530 but MT7531_CHG_STRAP on MT7531. Every other MTRAP
access in the driver is limited to MT7530-family code paths.

On those other chips, could this set an undocumented strap bit instead of
disabling loop detection? Should the write depend on priv->id?

> +	} else {
> +		/* Not passthrough, enable DSA tag handling on CPU port. */
> +		regmap_write(priv->regmap, MT7530_PVC_P(port), PORT_SPEC_TAG);
> +	}

[ ... ]

> @@ -1322,6 +1356,7 @@ static int
>  mt7530_port_enable(struct dsa_switch *ds, int port,
>  		   struct phy_device *phy)
>  {
> +	int upstream_pt = dsa_switch_upstream_port(ds);
>  	struct dsa_port *dp = dsa_to_port(ds, port);
>  	struct mt7530_priv *priv = ds->priv;
>  
> @@ -1332,13 +1367,38 @@ mt7530_port_enable(struct dsa_switch *ds, int port,
>  	 * bridge.
>  	 */
>  	if (dsa_port_is_user(dp)) {
> -		struct dsa_port *cpu_dp = dp->cpu_dp;
> +		priv->ports[port].pm |= PCR_MATRIX(BIT(upstream_pt));
>  
> -		priv->ports[port].pm |= PCR_MATRIX(BIT(cpu_dp->index));

[Severity: Medium]
Does this change behaviour on switches with more than one CPU port?
dsa_switch_upstream_port() returns the upstream port of the first available
port on the switch, not of the port being enabled:

include/net/dsa.h:dsa_switch_upstream_port() {
	dsa_switch_for_each_available_port(dp, ds) {
		return dsa_upstream_port(ds, dp->index);
	}
	...
}

mt753x_port_change_conduit() and mt7530_update_port_member() still base
priv->ports[port].pm on the port's own dp->cpu_dp.

Take an MT7531 with CPU ports 5 and 6. lan0, the first available port, is
moved to CPU port 6 with .port_change_conduit, and lan1 stays on CPU
port 5. If lan1 is then taken down and up, this code ORs BIT(6) into lan1's
pm, which already has BIT(5). mt753x_port_change_conduit() clears only the
old cpu_dp bit, so the extra bit is never removed.

Would lan1 then forward to both CPU ports?

Right now this is hidden, because the new probe check rejects dual-CPU
device trees that have user ports (see below). It becomes reachable once
that check is fixed.

> +	} else if (dsa_port_is_dsa(dp) && dp->index != upstream_pt) {
> +		priv->ports[port].pm |= PCR_MATRIX(BIT(upstream_pt));
> +
> +		/* Should not happen */
> +		WARN_ON_ONCE(!priv->is_passthrough);
> +

[Severity: High]
Can a DSA link port now reach mt7531_mac_config() and oops there?

This patch makes DSA links a supported setup on MT7531 as well. That
happens through this branch, where the passthrough switch programs its
downstream link, and through the dsa_is_upstream_port() change in
mt7531_setup_common(), where a downstream switch has a DSA link as its
upstream port.

However, mt7531_mac_config() still assumes that every RGMII port has a
user netdev:

	if (phy_interface_mode_is_rgmii(interface)) {
		dp = dsa_to_port(ds, port);
		phydev = dp->user->phydev;
		mt7531_rgmii_setup(priv, interface, phydev);
	}

In struct dsa_port, user and conduit share a union. CPU ports set
conduit and user ports set user. DSA ports set neither, so dp->user is
NULL for them.

Take an MT7531BE without SGMII on port 5 (!priv->p5_sgmii), where port
5 is a DSA link with an RGMII phy-mode. This can be the downstream link
of a passthrough MT7531BE or the uplink of a downstream one. The call
chain is dsa_port_setup() -> dsa_port_enable_rt() -> phylink_start() ->
phylink_major_config() -> mt753x_phylink_mac_config() ->
mt7531_mac_config(). Would that dereference NULL during switch setup?

Should mt7531_mac_config() look up the phydev only for user ports and
pass NULL otherwise? mt7531_rgmii_setup() already handles !phydev by
applying the delays implied by the phy-mode, which seems to be what a
DSA link needs.

[ ... ]

> +		/* Make the upstream port able to connect to the DSA port.
> +		 * This must be explicit because PORT_SPEC_TAG is unset.
> +		 */
> +		regmap_write(priv->regmap, MT7530_PCR_P(upstream_pt),
> +			     PCR_MATRIX(BIT(port)));

[Severity: Low]
Is a full register write intended here? It clears every other field in the
upstream port's PCR. That includes the fallback mode that
mt753x_cpu_port_enable() set just before:

	regmap_update_bits(priv->regmap, MT7530_PCR_P(port),
			   PCR_PORT_VLAN_MASK, MT7530_PORT_FALLBACK_MODE);

It also clears PORT_PRI, the PCR EG_TAG field and the mirror bits.

The write also bypasses priv->ports[upstream_pt].pm, which stays 0. Every
other PCR writer uses regmap_update_bits(..., PCR_MATRIX_MASK, pm). As a
result, the forwarding bit is protected only by the is_passthrough early
returns and the check below.

mt7530_port_disable() also has nothing to undo this PCR write or the MFC
flood bits set for the DSA port.

Would regmap_update_bits() with PCR_MATRIX_MASK, plus an update of the pm
cache, be safer?

>  	}
>  	priv->ports[port].enable = true;
> -	regmap_update_bits(priv->regmap, MT7530_PCR_P(port), PCR_MATRIX_MASK,
> -			   priv->ports[port].pm);
> +
> +	/* In passthrough mode, CPU port mask is set above. */
> +	if (!(priv->is_passthrough && dp->index == upstream_pt))
> +		regmap_update_bits(priv->regmap, MT7530_PCR_P(port),
> +				   PCR_MATRIX_MASK, priv->ports[port].pm);

[ ... ]

> @@ -1862,6 +1949,10 @@ mt7530_port_vlan_filtering(struct dsa_switch *ds, int port, bool vlan_filtering,
>  {
>  	struct dsa_port *dp = dsa_to_port(ds, port);
>  	struct dsa_port *cpu_dp = dp->cpu_dp;
> +	struct mt7530_priv *priv = ds->priv;
> +
> +	if (priv->is_passthrough)
> +		return 0;

[Severity: Medium]
When this switch is the downstream one, is cpu_dp->index still a local port
number? dsa_tree_setup_default_cpu() sets dp->cpu_dp for the downstream
switch's ports to the CPU port on the upstream switch, so the index belongs
to another switch. is_passthrough is false on the downstream switch, so the
new early returns don't apply.

The patch moves mt7530_port_enable(), the setup loops and
mt7530_port_change_mtu() to the local upstream port. Three places still
treat cpu_dp->index as a local port:

mt7530_port_vlan_filtering():
		mt7530_port_set_vlan_aware(ds, port);
		mt7530_port_set_vlan_aware(ds, cpu_dp->index);

mt7530_update_port_member():
	struct dsa_port *cpu_dp = dp->cpu_dp;
	u32 port_bitmap = BIT(cpu_dp->index);

mt753x_conduit_state_change():
	mask = BIT(cpu_dp->index);

Suppose the downstream uplink port number differs from the upstream CPU
port number. Would a bridge join, a bridge leave or a BR_ISOLATED change
then overwrite p->pm and drop the uplink bit that mt7530_port_enable() set?
If that index happens to be a local user port, frames could also be
forwarded to it without the isolation check.

In the same setup, would VLAN filtering make an unrelated local port
VLAN-aware instead of the uplink? Would trapped frames go to the wrong
local CPU_PORT in MT753X_MFC? The patch only updates the comment in
mt753x_conduit_state_change().

The EN751221 hardware in this series seems to work only because both
indices are 6.

[ ... ]

> @@ -3399,6 +3505,55 @@ static int mt7988_setup(struct dsa_switch *ds)
>  	return mt7531_setup_common(ds);
>  }
>  
> +/* 1 if passthrough, negative if error. */
> +static int mt753x_check_passthrough(struct device *dev)
> +{

[ ... ]

> +	for_each_available_child_of_node(ports, port) {
> +		struct device_node *link;
> +
> +		enabled_ports++;
> +
> +		link = of_parse_phandle(port, "ethernet", 0);
> +		if (!link)
> +			link = of_parse_phandle(port, "link", 0);
> +
> +		if (!link)
> +			continue;
> +
> +		of_node_put(link);
> +
> +		passthrough_ports++;
> +	}
> +
> +	of_node_put(ports);
> +
> +	/*
> +	 * A switch is considered passthrough if exactly two available
> +	 * ports have an "ethernet" or "link" phandle.
> +	 */
> +	if (passthrough_ports > 2 ||
> +	    (passthrough_ports == 2 && enabled_ports != 2)
> +	) {
> +		dev_err(dev, "Only two ports allowed in passthrough mode\n");
> +		return -EINVAL;
> +	}

[Severity: High]
Will this break probe on existing boards that have two CPU ports? CPU ports
(ethernet) and DSA links (link) share one counter. Two of them plus any
user port returns -EINVAL, and mt7530_probe_common() then fails the whole
probe.

Several in-tree device trees have user ports plus port@5 with
ethernet = <&gmac1> and port@6 with ethernet = <&gmac0>. Examples are
mt7622-bananapi-bpi-r64.dts, mt7623n-bananapi-bpi-r2.dts, mt7986a/b-rfb.dts
and the MT7621 boards based on mt7621.dtsi.

On BPI-R64 this gives passthrough_ports == 2 and enabled_ports == 7, since
of_parse_phandle() returns the gmac node whatever its status. Would all of
these boards lose switch networking with "Only two ports allowed in
passthrough mode"?

The check is also wrong in the other direction. mt7621.dtsi with swp0-4
disabled has two CPU ports and nothing else, so it would be treated as
passthrough without any DSA link. A normal cascade with a CPU port, a DSA
link and user ports would also be rejected.

Later patches in the series don't seem to change this function.

Should the check require exactly one ethernet port and one link port, and
leave other layouts to the existing code paths?

[Severity: Medium]
Does passthrough receive work only if the downstream switch has DSA switch
index 0? The MTK tag has no switch ID, and mtk_tag_rcv() hardcodes
index 0:

net/dsa/tag_mtk.c:mtk_tag_rcv() {
	...
	skb->dev = dsa_conduit_find_user(dev, 0, port);
	if (!skb->dev) {
		kfree_skb(skb);
		return NULL;
	}
	...
}

dsa_conduit_find_user() requires an exact match on dp->ds->index. The
natural numbering gives the CPU-attached upstream switch
dsa,member = <0 0>. With that numbering, every frame from the downstream
switch is looked up on the upstream switch, finds no user port, and is
freed without any message.

Could this requirement be checked here, or at least documented in the
binding?

> +
> +	return passthrough_ports == 2;
> +}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028011317.1557238-1-cjd%40cjdns.fr
