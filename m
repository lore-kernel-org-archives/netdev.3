Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98AA4B26F6;
	Mon, 19 Oct 2026 10:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792404530; cv=none; b=HPjtYtSUwkQ1iRRj4JaACKXlbjUfIStUcao9zp81Us/OIAFSPHyTl53seMN5K2R5eb2r+fNuPxlSTYRzBrN6jZI645SNxtd7Y0DNb2hQb3UiR8b7wDlATpflMgRbgwZcEKOv6ELZv6I9tSy5QtlNkEVIiNI9EDVeWn2qt0lj+MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792404530; c=relaxed/simple;
	bh=J5CuT262wdhTyv2qJkn7I/Q0mJ3cwAbPeQT1ZH80ZiQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lLSevWjIc20hUnuRYytB+ybLgbR8MrqvYT+BzFTuLPGE449cRuTpGyamAH2RBdB/SetMVPHZ03FF5xMJwgX2Ud5Rn9WANkYJn41fJBJjYVJeSzKy/FJVTv7g3Y+uexnWTQmIBG+rPMx0xROOLZdP0O5jmodp7gkg49cjgaBgy5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/7bvAKy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/7bvAKy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B751F000C4;
	Mon, 19 Oct 2026 10:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792404529;
	bh=jrY7PLvzpG83Z9GcuTQ77hZjYFKfUQp7trMgJxpok1E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=K/7bvAKyoGZj3bL3Uc5JZ6kFW/nb/8Vlv71Hm07HofmE/nmjEOW7i9o/bgktXRrt7
	 /ZYvZznFBQDQlWRzeptKUVLgCJtJJ2WE0LeZBxFVKX6jGGW71t/FQwTdDN3X+n1PXO
	 ckf6Tdu43v+6+a61CLGPElgpNF2KEARNcFKXheUM0/DY/T62UAj7phWF+DzD6+rKC+
	 qk/DB263QKKUcY4FBpmwa8ErrAUjmtPt3tqoTaidx26QcO1jHmSrvDLoOgEz0Sgcyi
	 DUPPCAKvdF8sJ6pdized3EsWr1tfzUes0uFrg1nJzRRUE0ImIRDbVoKs3Ka+xXNYXb
	 bkMP4zWOqPjJw==
Subject: Re: [PATCH net-next v15 5/9] net: dsa: lan9645x: add vlan support
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
Date: Mon, 19 Oct 2026 10:08:47 +0000
Message-ID: <179240452747.3135.18156695969280289846@kernel.org>
In-Reply-To:
 <20261015-dsa_lan9645x_switch_driver_base-v15-5-562f316f78b9@microchip.com>
References:
 <20261015-dsa_lan9645x_switch_driver_base-v15-5-562f316f78b9@microchip.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In lan9645x_vlan.c, no runtime caller of lan9645x_vlan_hw_wr()
  checks its return value.
- [Low] Likely false positive.

--

net: dsa: lan9645x: add vlan support

This commit adds VLAN offload to the lan9645x DSA driver. VID 4095 is
the internal pvid for standalone ports and VID 0 is the internal pvid
for VLAN-unaware bridge ports. The commit adds .port_vlan_filtering,
.port_vlan_add and .port_vlan_del, serializes the VLAN table with
fwd_domain_lock, and offloads only 802.1Q bridges.

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
> index 3a4abedafa2c1..73a91087824a4 100644
> --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h

[ ... ]

> @@ -238,6 +255,19 @@ static inline struct lan9645x_port *lan9645x_to_port(struct lan9645x *lan9645x,
>  	return lan9645x->ports[port];
>  }
>  
> +static inline bool lan9645x_port_is_bridged(struct lan9645x_port *p)
> +{
> +	return p->lan9645x->bridge_mask & BIT(p->chip_port);
> +}

[Severity: Low]
The commit message says:

  Add VLAN support for VLAN-aware and VLAN-unaware bridges.

In this commit, nothing writes lan9645x->bridge_mask, and
lan9645x_switch_ops has no .port_bridge_join. So
lan9645x_port_is_bridged() always returns false.

That means the bridged branches in lan9645x_vlan_port_apply_egress() and
lan9645x_vlan_port_apply_ingress() can't run yet. They become reachable
with the later "net: dsa: lan9645x: add bridge support" patch in the
series, which adds lan9645x_port_bridge_join() and sets bridge_mask
there.

This looks like an intentional way of splitting the series, so it may be
fine as is. Would it help to say in the commit message that the bridged
VLAN paths only become active with the bridge support patch?

[ ... ]

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c
> new file mode 100644
> index 0000000000000..effb0104a6027
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c
> @@ -0,0 +1,402 @@

[ ... ]

> +int lan9645x_vlan_port_add_vlan(struct lan9645x_port *p, u16 vid, bool pvid,
> +				bool untagged, struct netlink_ext_ack *extack)
> +{

[ ... ]

> +	old_vlan = lan9645x->vlans[vid];
> +	old_pvid = p->pvid;
> +
> +	v = lan9645x_vlan_port_modify(p, vid, pvid, untagged);
> +	v->portmask |= BIT(p->chip_port);
> +
> +	lan9645x_vlan_port_get_info(lan9645x, p->chip_port, &info);
> +
> +	if (info.untagged > 1 && info.tagged) {
> +		*v = old_vlan;
> +		p->pvid = old_pvid;

[ ... ]

> +		return -EBUSY;
> +	}
> +
> +	lan9645x_vlan_hw_wr(lan9645x, vid);
> +	lan9645x_vlan_port_apply_ingress(p);
> +	lan9645x_vlan_port_apply_egress(p, &info);
> +
> +	return 0;
> +}

[Severity: Low]
Is it intended that the return value of lan9645x_vlan_hw_wr() is
dropped here?

When this call runs, lan9645x->vlans[vid] and p->pvid already hold the
new values. If the VLAN access engine poll times out, or the regmap read
in the poll fails, lan9645x_vlan_port_apply_ingress() and
lan9645x_vlan_port_apply_egress() still program the port from the new
state. 0 is then returned to DSA through lan9645x_port_vlan_add(), and
the port may classify frames to a pvid it is not a hardware member of.

lan9645x_vlan_port_del_vlan(), lan9645x_vlan_cpu_add(),
lan9645x_vlan_cpu_del() and lan9645x_vlan_set_hostmode() follow the same
pattern.

On a failed delete, the port stays a hardware member of a VLAN the
bridge thinks was removed. The same applies to the CPU port module
through VLAN_PGID_CPU_DIS.

For the CPU port, dsa_port_do_vlan_add() records the VLAN once this
returns success. Later adds only bump the refcount, so the hardware
write is never retried.

The comment in lan9645x_vlan_hw_wr() says "There is no meaningful
recovery at runtime". However, ocelot_vlan_member_add() and
ocelot_vlan_member_del() return the ocelot_vlant_set_mask() error and
only update the software portmask when the write succeeds.

This probably only matters once the register bus is already
misbehaving. Still, could the -EBUSY rollback above
(*v = old_vlan; p->pvid = old_pvid;) be reused here, so the shadow state
is restored and the error is returned to the caller?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015-dsa_lan9645x_switch_driver_base-v15-0-562f316f78b9%40microchip.com
