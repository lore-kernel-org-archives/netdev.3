Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D20E43303E;
	Thu, 17 Sep 2026 20:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789678200; cv=none; b=PCtLEF+bqrFb9wmc3XwLgeLjtf5ru9o3YtNX3M14rPYcdlp4Qizn7wzXIjJH0Ev5VpmpiOKCUX2EUs0EMcdFJdDgpirGlXj6bLeBd5AyoOT2x35y5ZI+15bOKW4k7w7TjGpVW4BRBKwDN+oh8oGlOok5HXbTZriraDc8ySeFK+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789678200; c=relaxed/simple;
	bh=ywiZVu/0WObFzkP00b1V2nLvCclo6weqlPBtk3lckhg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jmeEipeVfQCtiyaD7gEnOBqMMOkf6WC1UjueZulFn/H3uzNLZq1z8HH/kmrzy2/6zPrWKd/Ls6SOlTORyx3fz8++IPKiWPAF/ImWZySV5FgYD3Rt1KsTcxjklzYqasx5+BOz4ED81iczV6CBWM4Lf9VIZTlVN39lwc6SqMB/Fkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtnMc2aQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtnMc2aQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3300B1F00899;
	Thu, 17 Sep 2026 20:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789678196;
	bh=6WkkdFEHQa1EDarwZAKyvsKK+34GHbuOJfUCQSJ/NuM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FtnMc2aQ2lPMzsK28zmCNUryBQuhp0cpTMM/0AMzRDgpdflUsK6jQdUY6OkqN9dT0
	 TV5pIr8XU2viY3bsimZODwY522pe4F9ZYHtFup1BFGQj1UaO3t0PxJVW/6WXTRhKdk
	 7IuEhb6IJ8IYzU9c27Ydl6CAUFdngSxoefw1I8/H1t6BkMvw+i9o2/L7jKZczelgKq
	 u4PnVnwwb5jVi33bcyXwqAs0NhM4t1BRkkyv+MazNCfItBsQlj5aYbvu0+i0/cfiiV
	 lwbQjYg4rA4R/0N1s1PgOxmmfx3v4Y7Rdp7VSHyDPBRhcJe+E/uqzpjerfvzh5MFaV
	 xp0TO5jSoZPZw==
Subject: Re: [PATCH v2 net-next 3/7] net: dsa: mediatek: add support for
 passthrough mode
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
Date: Thu, 17 Sep 2026 20:49:54 +0000
Message-ID: <178967819475.22033.4594419098712508282@kernel.org>
In-Reply-To: <20260915174643.253660-4-cjd@cjdns.fr>
References: <20260915174643.253660-4-cjd@cjdns.fr>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 13 potential
issue(s) to consider:

Critical: 0 · High: 5 · Medium: 4 · Low: 4

- [High] mt753x_check_passthrough() counts any available port node that
  has either an "ethernet" (CPU/conduit) or a "link" (DSA) phandle into…
- [High] mt7530_passthrough_switch_ops omits .port_change_mtu,
  .port_max_mtu, .port_vlan_add/del, .port_fdb_add/del,…
- [High] The patch fixes only mt7530_port_enable() to route user ports
  via the *local* upstream port (dsa_switch_upstream_port()); the other…
- [High] The passthrough PVC programming of the upstream/CPU port is dead
  code: mt753x_cpu_port_enable() writes MT7530_PVC_P(port) =…
- [High] net: dsa: passthrough switch unintentionally traps link-local
  frames, breaking transparency
- [Medium] The MTK DSA tag carries no switch identifier and mtk_tag_rcv()
  resolves the source port with a hardcoded switch index of 0 (`skb->dev…
- [Medium] mt7530_port_enable() now derives the CPU/upstream port from
  the switch-global helper dsa_switch_upstream_port(ds) instead of the…
- [Medium] MT7530_LOOP_DET_DISABLE (BIT(14) of MT753X_MTRAP, 0x7804) is
  set unconditionally in the shared mt753x_cpu_port_enable() passthrough…
- [Medium] In the new DSA-link branch of mt7530_port_enable(), the
  upstream port's forwarding matrix is programmed with a blind full-…
- [Low] The patch silently deletes the `if (!dn) { dev_err(ds->dev,
  "parent OF node of DSA conduit not found"); return -EINVAL; }` check…
- [Low] Concern as filed ("passthrough mode is undocumented; no update to
  Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml; no…
- [Low] mt7530_port_change_mtu() still carries the comment "Because the
  switch only has a global RX length register, only allowing CPU port…
- [Low] Style defects in the newly added mt753x_check_passthrough(): a
  multi-line comment whose first line is empty (`/*` alone), which…

--

net: dsa: mediatek: add support for passthrough mode

This adds a "passthrough" mode to the mt7530 driver where an upstream
MT7530 forwards all traffic between its CPU port and a port connected to
a second, downstream MT7530 without altering the MediaTek DSA tag.  The
mode is detected from the device tree topology, and a reduced
dsa_switch_ops table is used for the passthrough switch.

> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 54d931002bc14..b2344808457cb 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -1286,13 +1286,41 @@ mt753x_trap_frames(struct mt7530_priv *priv)
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

[Severity: High]
While mt753x_cpu_port_enable() is being taught to leave the tag
alone in passthrough mode, the rest of mt7530_setup() /
mt7531_setup_common() is unchanged, and both still call
mt753x_trap_frames(priv) unconditionally.  That helper programs
MT753X_BPC, MT753X_RGAC1 and MT753X_RGAC2 so that 802.1X PAE frames,
BPDUs and the 01:80:c2:00:00:0{1,2,3,e} group DAs are forwarded with
TO_CPU_FW_CPU_ONLY, i.e. redirected to the CPU port by the ARL
independently of the port matrix.

On a switch whose only job is to be a transparent pipe between its
CPU port and the downstream switch, is that what we want?  Two
concerns:

- Link-local frames arriving on the downstream DSA link are diverted
  to the CPU port by the trap rules rather than following
  priv->ports[].pm, so a frame that the downstream switch tagged for
  a specific user port can reach the conduit through a path this
  patch does not configure; and link-local frames the CPU sends
  toward the downstream switch can be matched by the same rules and
  bounced back to the CPU instead of egressing on the link port.

- The trap rules also force the egress tag state
  (PAE_EG_TAG(MT7530_VLAN_EG_UNTAGGED) / BPDU_EG_TAG(...)), which
  directly contradicts the VLAN_ATTR(MT7530_VLAN_TRANSPARENT) |
  PVC_EG_TAG(MT7530_VLAN_EG_DISABLED) configuration this hunk
  installs on the upstream port, so for exactly the frames that STP
  and 802.1X depend on, the passthrough switch is no longer
  transparent.

Since the passthrough switch has no user ports and no
.port_stp_state_set in mt7530_passthrough_switch_ops, nothing in this
driver consumes those trapped frames locally either.

Should mt753x_trap_frames() be skipped entirely when
priv->is_passthrough, or should the forwarding be changed so the
frames still follow the port matrix?  If the current behaviour is
intentional and harmless on the EN751221 topology, could the commit
message explain why global link-local trapping is safe on a switch
that is supposed to pass all traffic through untouched?

[Severity: High]
Does this PVC_EG_TAG value survive?  Both callers of
mt753x_cpu_port_enable() are inside the per-port setup loop, and in the same
iteration, right after the call, the loop unconditionally rewrites the same
field:

drivers/net/dsa/mt7530.c:mt7530_setup() {
    ...
        if (dsa_is_upstream_port(ds, i)) {
                mt753x_cpu_port_enable(ds, i);
        } else {
                mt7530_port_disable(ds, i);
                ...
        }

        /* Enable consistent egress tag */
        regmap_update_bits(priv->regmap, MT7530_PVC_P(i),
                           PVC_EG_TAG_MASK,
                           PVC_EG_TAG(MT7530_VLAN_EG_CONSISTENT));
    ...
}

mt7531_setup_common() has the identical sequence.  PVC_EG_TAG_MASK is
GENMASK(10, 8) and MT7530_VLAN_EG_DISABLED is 0, so the field that was just
cleared is set back to EG_CONSISTENT on the upstream port.  VLAN_ATTR lives
in GENMASK(7, 6) and survives, which makes this silent.

The downstream DSA link keeps EG_DISABLED because it is programmed later from
mt7530_port_enable(), so the two ends of the passthrough path end up
asymmetric, unlike the commit message description:

  "the main switch has its CPU port, and the port to the second switch, both
  configured as MT7530_VLAN_EG_DISABLED and MT7530_VLAN_TRANSPARENT"

Should the EG_CONSISTENT update skip upstream ports in passthrough mode?

> +
> +		/* The port is not configured to parse DSA tags, so they are
> +		 * liable to be confused for length fields, so length check is
> +		 * disabled.
> +		 */
> +		regmap_clear_bits(priv->regmap, MT753X_AGC, AGC_L2LEN_CHK);
> +
> +		/* In passthrough mode, MTU is only enforced downstream */
> +		mt7530_port_change_mtu(ds, port, MT7530_MAX_MTU);
> +
> +		/* Loop detection has no value in passthrough mode */
> +		regmap_set_bits(priv->regmap, MT753X_MTRAP,
> +				MT7530_LOOP_DET_DISABLE);

[Severity: Medium]
Is this MTRAP write safe on the MT7531 generation?  mt753x_cpu_port_enable()
is also called from mt7531_setup_common() (MT7531/MT7988/EN7581/AN7583/
EN7528), and priv->is_passthrough comes purely from the DT topology, so there
is no priv->id guard here.

Every other MT7530_*-prefixed access to this register in the driver is gated,
for example in mt7530_port_enable()/mt7530_port_disable():

	if (priv->id == ID_MT7530 || priv->id == ID_MT7621)
		regmap_clear_bits(priv->regmap, MT753X_MTRAP, ...);

and the bit definitions for 0x7804 collide across generations:

  #define  MT7530_P6_DIS			BIT(8)
  #define  MT7531_CHG_STRAP		BIT(8)

Should MT7530_LOOP_DET_DISABLE only be set when priv->id is ID_MT7530 or
ID_MT7621?

> +	} else {
> +		/* Not passthrough, enable DSA tag handling on CPU port. */
> +		regmap_write(priv->regmap, MT7530_PVC_P(port), PORT_SPEC_TAG);
> +	}
>  
>  	/* Enable flooding on the CPU port */
>  	regmap_set_bits(priv->regmap, MT753X_MFC,
> @@ -1322,6 +1350,7 @@ static int
>  mt7530_port_enable(struct dsa_switch *ds, int port,
>  		   struct phy_device *phy)
>  {
> +	int upstream_pt = dsa_switch_upstream_port(ds);
>  	struct dsa_port *dp = dsa_to_port(ds, port);
>  	struct mt7530_priv *priv = ds->priv;
>  
> @@ -1332,13 +1361,38 @@ mt7530_port_enable(struct dsa_switch *ds, int port,
>  	 * bridge.
>  	 */
>  	if (dsa_port_is_user(dp)) {
> -		struct dsa_port *cpu_dp = dp->cpu_dp;
> +		priv->ports[port].pm |= PCR_MATRIX(BIT(upstream_pt));
> +

[Severity: Medium]
Can switching from dp->cpu_dp->index to dsa_switch_upstream_port(ds) lose
per-port conduit affinity?  The helper answers for the switch, not for this
port:

include/net/dsa.h:dsa_switch_upstream_port() {
	dsa_switch_for_each_available_port(dp, ds) {
		return dsa_upstream_port(ds, dp->index);
	}
	return ds->num_ports;
}

On MT7531 this driver supports per-port conduits via
mt753x_port_change_conduit(), which only clears the old per-port bit:

	priv->ports[port].pm &= ~PCR_MATRIX(BIT(dp->cpu_dp->index));
	priv->ports[port].pm |= PCR_MATRIX(BIT(new_cpu_dp->index));

So after "ip link set swp0 type dsa conduit eth1" and then bringing swp1 up,
does swp1 get the bit of swp0's new conduit ORed in permanently, leaving two
CPU-port bits in priv->ports[swp1].pm?  Would dsa_upstream_port(ds, port)
work for passthrough while keeping the per-port affinity?

> +	} else if (dsa_port_is_dsa(dp) && dp->index != upstream_pt) {
> +		priv->ports[port].pm |= PCR_MATRIX(BIT(upstream_pt));
> +
> +		/* Should not happen */
> +		WARN_ON_ONCE(!priv->is_passthrough);
> +
> +		/* We are passing through to a downstream switch so we set both
> +		 * CPU and downstream link to pass traffic untouched so that
> +		 * the STAG from the downstream switch will pass to the upstream.
> +		 */
> +		regmap_write(priv->regmap, MT7530_PVC_P(port),
> +			     VLAN_ATTR(MT7530_VLAN_TRANSPARENT) |
> +			     PVC_EG_TAG(MT7530_VLAN_EG_DISABLED));
> +
> +		/* We let the downstream switch flood */
> +		regmap_set_bits(priv->regmap, MT753X_MFC, BC_FFP(BIT(port)) |
> +				UNM_FFP(BIT(port)) | UNU_FFP(BIT(port)));
>  
> -		priv->ports[port].pm |= PCR_MATRIX(BIT(cpu_dp->index));
> +		/* Make the upstream port able to connect to the DSA port.
> +		 * This must be explicit because PORT_SPEC_TAG is unset.
> +		 */
> +		regmap_write(priv->regmap, MT7530_PCR_P(upstream_pt),
> +			     PCR_MATRIX(BIT(port)));

[Severity: Medium]
Does this full-register write clobber the upstream port's VLAN mode?
mt753x_cpu_port_enable() programmed the same register a moment earlier:

	regmap_update_bits(priv->regmap, MT7530_PCR_P(port),
			   PCR_PORT_VLAN_MASK, MT7530_PORT_FALLBACK_MODE);

A regmap_write() of PCR_P(upstream_pt) with only PCR_MATRIX() set zeroes
PCR_PORT_VLAN_MASK (and PORT_PRI/mirror bits) on that port.

It also bypasses priv->ports[upstream_pt].pm, which every other matrix
writer in this driver treats as the authoritative shadow
(mt7530_port_enable, mt7530_port_disable, mt7530_update_port_member,
mt753x_port_change_conduit).

Would regmap_update_bits(..., PCR_MATRIX_MASK, ...) plus updating
priv->ports[upstream_pt].pm keep the shadow and hardware in sync here?

>  	}
>  	priv->ports[port].enable = true;
> -	regmap_update_bits(priv->regmap, MT7530_PCR_P(port), PCR_MATRIX_MASK,
> -			   priv->ports[port].pm);
> +
> +	/* In passthrough mode, CPU port mask is set above. */
> +	if (!(priv->is_passthrough && dp->index == upstream_pt))
> +		regmap_update_bits(priv->regmap, MT7530_PCR_P(port),
> +				   PCR_MATRIX_MASK, priv->ports[port].pm);

[Severity: Medium]
This is the same shadow concern as above: with this branch suppressed, is
there any remaining path that pushes priv->ports[upstream_pt].pm to
hardware?  mt7530_port_disable() is still in
mt7530_passthrough_switch_ops and does:

	regmap_update_bits(priv->regmap, MT7530_PCR_P(port), PCR_MATRIX_MASK,
			   PCR_MATRIX_CLR);

so once the upstream port's matrix is cleared, can it be restored from a
shadow that was never updated?

[Severity: High]
Only mt7530_port_enable() is converted to the local upstream port; do the
other consumers still treat a remote CPU port index as a local port number?

mt7530_update_port_member() runs on every bridge join/leave and is part of
the full ops table used by the downstream switch:

drivers/net/dsa/mt7530.c:mt7530_update_port_member() {
	struct dsa_port *cpu_dp = dp->cpu_dp;
	u32 port_bitmap = BIT(cpu_dp->index);
	...
	p->pm = PCR_MATRIX(port_bitmap);
}

That is an assignment, not an OR, so does "ip link set swpN master br0" on a
downstream user port replace the local upstream-link bit installed here with
the bit of the upstream switch's CPU port number?

mt753x_conduit_state_change() has the same shape, programming the local
MT753X_MFC CPU-port selector from a foreign index:

	mask = BIT(cpu_dp->index);
	...
	val = MT7530_CPU_EN | MT7530_CPU_PORT(__ffs(priv->active_cpu_ports));

The two indices happen to coincide on the EN751221 topology added later in
the series, but the commit message says "also support being the downstream
switch" generally.  Should these sites use dsa_upstream_port() too?

>  
>  	mutex_unlock(&priv->reg_mutex);
>  
> @@ -1390,7 +1444,7 @@ mt7530_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
>  	 * largest MTU of the user ports. Because the switch only has a global
>  	 * RX length register, only allowing CPU port here is enough.
>  	 */
> -	if (!dsa_is_cpu_port(ds, port))
> +	if (!dsa_is_upstream_port(ds, port))
>  		return 0;

[Severity: Low]
The comment just above still says "only allowing CPU port here is enough",
but dsa_is_upstream_port() also matches a DSA link:

include/net/dsa.h:
	/* Return true if this is the local port used to reach the CPU port */
	static inline bool dsa_is_upstream_port(struct dsa_switch *ds, int port)

Should the comment be updated to mention the upstream DSA port case?

>  
>  	regmap_read(priv->regmap, MT7530_GMACCR, &val);
> @@ -2411,11 +2465,6 @@ mt7530_setup(struct dsa_switch *ds)
>  		break;
>  	}
>  
> -	if (!dn) {
> -		dev_err(ds->dev, "parent OF node of DSA conduit not found");
> -		return -EINVAL;
> -	}
> -

[Severity: Low]
The commit message does not mention removing this diagnostic.  With the
check gone, a malformed conduit OF hierarchy (conduit device node without a
parent) is now accepted silently, and the port-5 PHY-mux scan is skipped via
the new "if (dn && ...)" guard below.

Could the commit message describe this change, or could the error be kept
for the case where a CPU port exists but its conduit OF node has no parent?

>  	ds->assisted_learning_on_cpu_port = true;
>  	ds->untag_vlan_aware_bridge_pvid = true;
>  	ds->mtu_enforcement_ingress = true;
> @@ -2517,7 +2566,7 @@ mt7530_setup(struct dsa_switch *ds)
>  		/* Disable learning by default on all ports */
>  		regmap_set_bits(priv->regmap, MT7530_PSC_P(i), SA_DIS);
>  
> -		if (dsa_is_cpu_port(ds, i)) {
> +		if (dsa_is_upstream_port(ds, i)) {
>  			mt753x_cpu_port_enable(ds, i);
>  		} else {
>  			mt7530_port_disable(ds, i);

[ ... ]

> @@ -3310,7 +3359,7 @@ mt753x_conduit_state_change(struct dsa_switch *ds,
>  
>  	/* Set the CPU port to trap frames to for MT7530. Trapped frames will be
>  	 * forwarded to the numerically smallest CPU port whose conduit
> -	 * interface is up.
> +	 * interface is up. NOTE: "CPU port" can also mean an upstream DSA link.
>  	 */

[Severity: Medium]
Related to the tagger side of this: the MTK tag carries no switch id and
mtk_tag_rcv() resolves the source port with a hardcoded switch index 0:

net/dsa/tag_mtk.c:mtk_tag_rcv() {
	skb->dev = dsa_conduit_find_user(dev, 0, port);
	if (!skb->dev) {
		kfree_skb(skb);
		return NULL;
	}
}

net/dsa/tag.h:dsa_conduit_find_user() {
	if (dp->ds->index == device && dp->index == port &&
	    dp->type == DSA_PORT_TYPE_USER)
		return dp->user;
}

The passthrough switch has no user ports, so if the DT numbers the
CPU-attached passthrough switch as dsa,member index 0 and the downstream
switch as 1, does every received frame get silently freed here?

Would it be worth enforcing or documenting that the downstream switch must
be index 0?

>  	if (priv->id != ID_MT7530 && priv->id != ID_MT7621 &&
>  	    priv->id != ID_EN7528)
> @@ -3405,6 +3454,76 @@ static int mt7988_setup(struct dsa_switch *ds)
>  	return mt7531_setup_common(ds);
>  }
>  
> +/* 1 if passthrough, negative if error. */
> +static int mt753x_check_passthrough(struct device *dev)
> +{

[Severity: Low]
This isn't a bug, but the banner comment omits the 0 (non-passthrough)
return, which is the case mt7530_probe_common() actually branches on.

> +	struct device_node *ports, *port;
> +	int passthrough_ports = 0;
> +	int enabled_ports = 0;
> +
> +	ports = of_get_child_by_name(dev->of_node, "ports");
> +	if (!ports)
> +		ports = of_get_child_by_name(dev->of_node, "ethernet-ports");
> +
> +	if (!ports) {
> +		dev_err(dev, "no ports child node found\n");
> +		return -EINVAL;
> +	}
> +
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
> +
> +	return passthrough_ports == 2;
> +}

[Severity: High]
Can this heuristic break existing in-tree device trees that declare two CPU
ports?  "ethernet" and "link" phandles share one counter, so a second CPU
port looks the same as a downstream DSA link.

arch/arm/boot/dts/mediatek/mt7623n-bananapi-bpi-r2.dts has 5 enabled user
ports plus:

	port@5 { reg = <5>; label = "cpu"; ethernet = <&gmac1>; ... };
	port@6 { reg = <6>; label = "cpu"; ethernet = <&gmac0>; ... };

That gives passthrough_ports == 2 and enabled_ports == 7, so this returns
-EINVAL and mt7530_probe_common() aborts probe, leaving the board without a
switch.

arch/arm/boot/dts/mediatek/mt7623a.dtsi is the mirror case: ports 0..4 are
status = "disabled" and only the two CPU ports remain, so
passthrough_ports == 2 and enabled_ports == 2, this returns 1, and an
ordinary dual-CPU-port MT7530 is programmed as a passthrough bridge
(reduced ops table, both CPU ports set to VLAN_TRANSPARENT/EG_DISABLED,
global L2 length check and loop detection off, MTU forced to
MT7530_MAX_MTU).

The driver supports multiple CPU ports elsewhere
(mt753x_preferred_default_local_cpu_port(), mt753x_port_change_conduit()).
Could the detection distinguish "link" phandles (DSA links) from "ethernet"
phandles (CPU ports) instead of counting them together?

[Severity: Low]
This isn't a bug: the preceding series patch "dt-bindings: net: dsa:
mediatek,mt7530: add passthrough mode" does document the mode in
Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml, including
"In passthrough mode the upstream switch is restricted, with no other ports
or switch configuration allowed."

One observation remains: since the mode is inferred from topology rather
than an explicit property, dt_binding_check/dtbs_check cannot validate the
"exactly two available ports" rule that this function turns into -EINVAL,
and mt7530_probe_common() applies the heuristic to every mt753x variant
while the binding prose describes MT7530/MT7531.  Would an explicit DT
property be preferable?

[Severity: Low]
This isn't a bug, but two style points in the new code: the multi-line
comment starts with an empty "/*" line, which netdev style disallows, and
the "if" condition's closing ")" sits alone on its own line.

> +
> +/* No manipulation of forwarding rules allowed in passthrough mode */
> +static const struct dsa_switch_ops mt7530_passthrough_switch_ops = {
> +	.get_tag_protocol	= mtk_get_tag_protocol,
> +	.setup			= mt753x_setup,
> +	.teardown		= mt753x_teardown,
> +	.preferred_default_local_cpu_port = mt753x_preferred_default_local_cpu_port,
> +	.get_strings		= mt7530_get_strings,
> +	.get_ethtool_stats	= mt7530_get_ethtool_stats,
> +	.get_sset_count		= mt7530_get_sset_count,
> +	.get_eth_mac_stats	= mt7530_get_eth_mac_stats,
> +	.get_rmon_stats		= mt7530_get_rmon_stats,
> +	.get_eth_ctrl_stats	= mt7530_get_eth_ctrl_stats,
> +	.get_stats64		= mt7530_get_stats64,
> +	.port_enable		= mt7530_port_enable,
> +	.port_disable		= mt7530_port_disable,
> +	.phylink_get_caps	= mt753x_phylink_get_caps,
> +	.support_eee		= dsa_supports_eee,
> +	.set_mac_eee		= mt753x_set_mac_eee,
> +	.conduit_state_change	= mt753x_conduit_state_change,
> +};

[Severity: High]
Do the omitted ops break operations that originate on the downstream
switch?  DSA notifiers are broadcast to every switch in the tree and abort
on the first error, and the handlers start with an unconditional test:

net/dsa/switch.c:dsa_switch_mtu() {
	if (!ds->ops->port_change_mtu)
		return -EOPNOTSUPP;
}

net/dsa/user.c:dsa_user_change_mtu() {
	err = dsa_port_mtu_change(cpu_dp, cpu_mtu);
	if (err)
		goto out_cpu_failed;
}

So does "ip link set <downstream user port> mtu N" now fail and roll back,
because this table has no .port_change_mtu?

The same shape applies to .port_vlan_add/del, .port_fdb_add/del and
.port_mdb_add/del:

net/dsa/switch.c:
	if (!ds->ops->port_fdb_add)
		return -EOPNOTSUPP;
	...
	if (!ds->ops->port_vlan_add)
		return -EOPNOTSUPP;

Does that break VLAN uppers on downstream ports, and defeat
ds->assisted_learning_on_cpu_port which mt7530_setup() still sets for the
passthrough switch?

Also, with no .port_stp_state_set, are the passthrough switch's ports ever
programmed into FID_PST forwarding state, given dsa_port_set_state_now()
swallows -EOPNOTSUPP?

> +
>  static const struct dsa_switch_ops mt7530_switch_ops = {
>  	.get_tag_protocol	= mtk_get_tag_protocol,
>  	.setup			= mt753x_setup,
> @@ -3537,8 +3656,12 @@ EXPORT_SYMBOL_GPL(mt753x_table);
>  int
>  mt7530_probe_common(struct mt7530_priv *priv)
>  {
> +	int passthrough = mt753x_check_passthrough(priv->dev);
>  	struct device *dev = priv->dev;
>  
> +	if (passthrough < 0)
> +		return passthrough;
> +

[Severity: High]
This is where the heuristic's -EINVAL becomes fatal: probe returns before
anything is set up, so on mt7623n-bananapi-bpi-r2 the switch is never
registered and the board comes up with no network interfaces.

>  	priv->ds = devm_kzalloc(dev, sizeof(*priv->ds), GFP_KERNEL);
>  	if (!priv->ds)
>  		return -ENOMEM;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915174643.253660-1-cjd%40cjdns.fr
