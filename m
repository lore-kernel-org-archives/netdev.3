Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848F5448BB5;
	Mon, 12 Oct 2026 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791804285; cv=none; b=MIZlApEqWpf3IKCaMz6DFI8P52sF/IcH9/fcyFDDRz/+qQCz1TiLFCQ9mMp8tgPf4nn+4l0DeruM9+dHWzJ1t5mHfTUCHpto1YrlhAOnzvznTzpJ3GeknOqn9tqS1R4wUEOXJ8Ccc/mTAXu4LoEKfeehXOyk1UYKP/o4HfR1OhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791804285; c=relaxed/simple;
	bh=EF9JmhHwiG2ez0FSctO1R+zclH/QQBomg4fUPKmklas=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VW5vi+t5wnaEa5NGQksEcgNP6iqGNWUIY9fzZXjyjNlPT/InOquR8m2HhRFlnQyzhyU+L5hAHBTBVgqNoWONN5UszsNW+ktNsQgcJwq/YMTzHBLhgI1GwH5E9B2za+fW7MrFu3Wm7HVN1aF5wt4tS1iEV7X5dr+htzGGdA4SAq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Edo0rW14; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Edo0rW14"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8F31F0089C;
	Mon, 12 Oct 2026 11:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791804284;
	bh=9GMzKpIODMM/9myLeb21YX/1xD+YcroTEP1Vj2+gWPc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Edo0rW14h07ZjkipRFlED3V3uz8DJfyf+WD/moWw8nyaY/9KdfkdhsK3pcygeC0Yq
	 sigjnaGqQye7EXiYTWWhNwp2dkkGsMDLz8kxspX4Tp5EFAdRcV9nxR24pby5YBztg8
	 szG5NuCxB3KAEyVaJ2RsOQ9glSbD1yOFGdGoVjuu9rogirHxTywUCytzkaD6MmsO0i
	 gwOLPZXvFAoqiflVSZS4WzTlxhcqw6ximJOmOZ/YZIxEA9SS3m5N97lfFBzsARhr2e
	 hq5WqOPYPpWTOXNgzhwMILBJ7k97UFOzLXQvJS1nX1iZugqPoU4CPWuSfpzYn1nvF9
	 59lyViXkOam6Q==
Subject: Re: [PATCH net-next v14 5/9] net: dsa: lan9645x: add vlan support
From: netdev-bot+sashiko@kernel.org
To: jensemil.schulzostergaard@microchip.com
Cc: UNGLinuxDriver@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 woojung.huh@microchip.com, linux@armlinux.org.uk,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 geert+renesas@glider.be, magnus.damm@gmail.com, edumazet@kernel.org,
 richardcochran@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Date: Mon, 12 Oct 2026 11:24:42 +0000
Message-ID: <179180428266.434549.5526720693163836060@kernel.org>
In-Reply-To:
 <20261008-dsa_lan9645x_switch_driver_base-v14-5-3d2a72661213@microchip.com>
References:
 <20261008-dsa_lan9645x_switch_driver_base-v14-5-3d2a72661213@microchip.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says "DSA does not pass
  SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL to drivers, so an 802.1ad…
- [Low] Concern: the commit message promises VLAN support for VLAN-aware
  and VLAN-unaware bridges, but at this commit no .port_bridge_join…
- [Low] Concern: runtime VLAN table writes ignore lan9645x_vlan_hw_wr()
  failures.

--

net: dsa: lan9645x: add vlan support

This patch adds VLAN support to the lan9645x DSA driver. HOST_PVID (4095)
is the port VLAN for standalone ports and UNAWARE_PVID (0) is the port VLAN
for VLAN-unaware bridge ports. The VLAN table and the per-port VLAN state
are serialized with fwd_domain_lock.

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> index c7de3836e6967..6818b91f4bed2 100644
> --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c

[ ... ]

> @@ -296,6 +307,59 @@ static void lan9645x_port_phylink_get_caps(struct dsa_switch *ds, int port,
>  	lan9645x_phylink_get_caps(ds->priv, port, config);
>  }
>  
> +static int lan9645x_port_vlan_filtering(struct dsa_switch *ds, int port,
> +					bool enabled,
> +					struct netlink_ext_ack *extack)
> +{
> +	struct lan9645x *lan9645x = ds->priv;
> +	struct lan9645x_port *p;
> +
> +	/* DSA core does not call this for the CPU port */
> +	p = lan9645x_to_port(lan9645x, port);
> +	mutex_lock(&lan9645x->fwd_domain_lock);
> +	p->vlan_aware = enabled;
> +	lan9645x_vlan_port_apply(p);
> +	mutex_unlock(&lan9645x->fwd_domain_lock);
> +
> +	return 0;
> +}

[Severity: Medium]
The commit message says:

  "Only bridge vlan_protocol 802.1Q is offloaded. DSA does not pass
  SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL to drivers, so an 802.1ad bridge
  cannot be refused, and the classifier does not honour it."

Is "cannot be refused" accurate? dsa_port_vlan_filtering() in
net/dsa/port.c passes the driver's error back to the bridge:

    err = ds->ops->port_vlan_filtering(ds, dp->index, vlan_filtering,
                                       extack);
    if (err)
        return err;

Could lan9645x_port_vlan_filtering() call br_vlan_get_proto() on the
port's bridge and refuse with an extack when the result is not
ETH_P_8021Q?

That would cover two cases: turning on vlan_filtering on an 802.1ad
bridge, and joining an 802.1ad bridge that already filters, because the
join path syncs vlan_filtering through the same callback. Only a
vlan_protocol change on a bridge that is already filtering would still
get through.

As written, an 802.1ad VLAN-aware bridge is offloaded silently with
802.1Q semantics. lan9645x_vlan_port_apply_ingress() always marks
untagged frames as C-tag:

    val = ANA_VLAN_CFG_VLAN_VID_SET(pvid) |
          ANA_VLAN_CFG_VLAN_TAG_TYPE_SET(0);

With TAG_TPID_CFG=3, those frames would egress tagged with 0x8100, not
0x88a8. C-tagged frames would be classified by their C-VID, not by the
pvid.

The tagger already reads br_vlan_get_proto() in
lan9645x_xmit_get_vlan_info() in net/dsa/tag_lan9645x.c:

    *tag_type = (proto != ETH_P_8021Q) ? LAN9645X_IFH_TAG_TYPE_S :
                                         LAN9645X_IFH_TAG_TYPE_C;

So on such a bridge, would the CPU injection path and the switch
datapath disagree? The later "net: dsa: lan9645x: add bridge support"
patch also leaves lan9645x_port_vlan_filtering() unchanged.

[ ... ]

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
> index 3a4abedafa2c1..c61efd115aaa4 100644
> --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h

[ ... ]

> @@ -238,6 +255,11 @@ static inline struct lan9645x_port *lan9645x_to_port(struct lan9645x *lan9645x,
>  	return lan9645x->ports[port];
>  }
>  
> +static inline bool lan9645x_port_is_bridged(struct lan9645x_port *p)
> +{
> +	return p->lan9645x->bridge_mask & BIT(p->chip_port);
> +}

[Severity: Low]
This isn't a bug, but at this commit nothing writes bridge_mask and there
is no .port_bridge_join, so lan9645x_port_is_bridged() always returns
false. The bridged branches in lan9645x_vlan_port_get_pvid() and
lan9645x_vlan_port_apply_egress() can't be reached until the later "net:
dsa: lan9645x: add bridge support" patch adds lan9645x_port_bridge_join().

Standalone ports look fine in the meantime. HOST_PVID contains all ports
and the CPU, so enabling ANA_VLANMASK drops nothing.

Could the commit message line "Add VLAN support for VLAN-aware and
VLAN-unaware bridges." say that the bridged paths only become active
with the bridge support patch?

[ ... ]

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c
> new file mode 100644
> index 0000000000000..751da53375368
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c
> @@ -0,0 +1,402 @@

[ ... ]

> +int lan9645x_vlan_port_add_vlan(struct lan9645x_port *p, u16 vid, bool pvid,
> +				bool untagged, struct netlink_ext_ack *extack)
> +{

[ ... ]

> +	if (p->chip_port == lan9645x->npi)
> +		return lan9645x_vlan_cpu_add(p, vid);
> +
> +	old_vlan = lan9645x->vlans[vid];
> +	old_pvid = p->pvid;
> +
> +	v = lan9645x_vlan_port_modify(p, vid, pvid, untagged);
> +	v->portmask |= BIT(p->chip_port);

[ ... ]

> +	lan9645x_vlan_hw_wr(lan9645x, vid);
> +	lan9645x_vlan_port_apply_ingress(p);
> +	lan9645x_vlan_port_apply_egress(p, &info);
> +
> +	return 0;
> +}

[Severity: Low]
The return value of lan9645x_vlan_hw_wr() is dropped here. The same
happens in lan9645x_vlan_cpu_add(), lan9645x_vlan_cpu_del(),
lan9645x_vlan_port_del_vlan() and lan9645x_vlan_set_hostmode(). In each
case vlans[vid] is updated and 0 is returned even if the table write
timed out.

The comment in lan9645x_vlan_hw_wr() says this is intentional: a timeout
most likely means the register bus is dead. Also, the next write for the
same VID rewrites the whole entry from the shadow portmask.

If the parent regmap bus can have transient errors, though, would it be
better to return the error and restore the old shadow state, as
ocelot_vlan_member_add() does? That would keep DSA's refcounted CPU port
VLAN state in sync with the hardware.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008-dsa_lan9645x_switch_driver_base-v14-0-3d2a72661213%40microchip.com
