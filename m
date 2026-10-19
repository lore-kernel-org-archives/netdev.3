Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C80F4F96C4;
	Mon, 19 Oct 2026 13:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416791; cv=none; b=R5Z/PBvV6zx7EkS0R8W2N9FsfYlCDVdTg7fO7wQZgXJvRdP47Regw0gPqFAatL5HEpN3UBnNWoSXnOvmpOrENLH3ECyY6kU57EeCuPYXs08MUn7Nksr4/RD3BIIvhZ1XjboNM8i1SqmuCUDDK3MF3loYM7h5yB6eqi5x2FEHGC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416791; c=relaxed/simple;
	bh=vf5tKRdGPX2Q43nVAb+EGmiMDzsBG3LQlv4NOolZ7Jw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k/lTXJr/lTdNC1HW8JO64d1f2MI0aWrH4iwl8wY+o88hZrM91icbC8t3n9TpXR2kvLBrotp/vvC3U7GHlK7TBHiLWxACYFqMynsNi71UjNA16aTwpG6d6MKgdP4mtoXlAuF38BkP1BD5z4WUCefk8nr2sqY7/XPLz6Myi+58Ws8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eg5cOGeY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eg5cOGeY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2D41F000C4;
	Mon, 19 Oct 2026 13:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792416789;
	bh=EEt2iCKL19FHpBWAp8r11YmspX7RFj5GqeiJRciaPfE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Eg5cOGeYcZk46SFV6KqUCcz9SZybWVSi+aBFhngQDQGTIiErH8pIk+VKn2ayxNmV/
	 6v5D5EkAXU1avHuUOMtyPcJnRjvJTONE1EkDkI9/S9n75gCYMUZZm4LaPpDzkOq0K2
	 1+B/BjBqyWcfifS3T5YfkNCB72Bv2+VXYojY2A5yijcHvLnfRBNTr50tfaHjJGN/4V
	 k/tpd4H1WcX6PyAZ/XOAjT6Dn9G5ntk6qVXwe5WZOoPmrp7dw1rxWouCNdrvCO9wk0
	 EFTuSoiTLYbZs5oGxkOmzGCFE1WGQT28bT42/RPSLizY7lQyM9K9zBf1FWCNjk1Cye
	 JJ9ReFNGZpWzw==
Subject: Re: [PATCH net-next v19 06/10] net: phy: phy_port: Store information
 about a port's upstream
From: netdev-bot+sashiko@kernel.org
To: maxime.chevallier@bootlin.com
Cc: davem@davemloft.net, andrew@lunn.ch, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, hkallweit1@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, christophe.leroy@csgroup.eu,
 herve.codina@bootlin.com, f.fainelli@gmail.com, vladimir.oltean@nxp.com,
 kory.maincent@bootlin.com, kabel@kernel.org, o.rempel@pengutronix.de,
 nicveronese@gmail.com, horms@kernel.org, mwojtas@chromium.org,
 romain.gantois@bootlin.com, daniel@makrotopia.org,
 dimitri.fedrau@liebherr.com, frank.wunderlich@linux.dev, p.ameruoso@live.it,
 f@lex.la, chleroy@kernel.org
Date: Mon, 19 Oct 2026 13:33:07 +0000
Message-ID: <179241678791.3135.1638003219102257102@kernel.org>
In-Reply-To: <20261016133107.54054-7-maxime.chevallier@bootlin.com>
References: <20261016133107.54054-7-maxime.chevallier@bootlin.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net: phy: UAF in upstream_port when connect_phy fails
- [Low] Concern: phy_set_upstream_port()
  (drivers/net/phy/phy_device.c:3712-3722) writes phydev->upstream_port…

--

net: phy: phy_port: Store information about a port's upstream

This commit adds an upstream_port pointer to struct phy_port and struct
phy_device. For an MDI port that is fed by an MII port, such as an SFP
module port fed by the SFP cage port, the pointer records that MII port.
A new helper, phy_set_upstream_port(), is called from the SFP
connect_phy/disconnect_phy paths in both phy_device.c and phylink.c.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 13eb1d40badb5..e9da6767faaf4 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c

[ ... ]

> @@ -3698,6 +3703,25 @@ struct phy_port *phy_get_sfp_port(struct phy_device *phydev)
>  }
>  EXPORT_SYMBOL_GPL(phy_get_sfp_port);
>  
> +/**
> + * phy_set_upstream_port() - Sets the phy_port controlling the MII this PHY is
> + *			     attached to.
> + * @phydev: pointer to the PHY device we set the upstream of.
> + * @port: The phy_port upstream of this PHY, can be NULL.
> + */
> +void phy_set_upstream_port(struct phy_device *phydev, struct phy_port *port)
> +{
> +	struct phy_port *local_port;
> +
> +	ASSERT_RTNL();
> +
> +	phydev->upstream_port = port;
> +
> +	phy_for_each_port(phydev, local_port)
> +		local_port->upstream_port = port;
> +}

[Severity: Low]
Can phydev->upstream_port and port->upstream_port get out of sync here?
This helper only updates the ports that are on phydev->ports when it
runs.

Ports added later through phy_probe()->phy_setup_ports()->phy_add_port()
do not copy phydev->upstream_port:

drivers/net/phy/phy_device.c:phy_add_port() {
    ...
	phy_port_update_supported(port);

	list_add(&port->head, &phydev->ports);

	phydev->n_ports++;
    ...
}

This can happen if the module PHY driver binds after connect. The
phy_sfp_connect_phy() path has no phy->drv check. It can also happen if
the driver is unbound and rebound while the PHY is connected. In both
cases phydev->upstream_port still points at the SFP cage port, but the
new ports have upstream_port == NULL.

Today the mismatch is not visible. Nothing in the series reads
phydev->upstream_port. The only reader of port->upstream_port is
port_prepare_data() in net/ethtool/port.c, and it only sees ports in
the link topology. Ports created later by phy_add_port() are never
added to the topology.

Would it make sense for phy_add_port() to set port->upstream_port from
phydev->upstream_port, so that both fields stay consistent for future
users?

> +EXPORT_SYMBOL_GPL(phy_set_upstream_port);
> +
>  /**
>   * fwnode_mdio_find_device - Given a fwnode, find the mdio_device
>   * @fwnode: pointer to the mdio_device's fwnode

[ ... ]

> @@ -1403,6 +1403,7 @@ static int phy_sfp_connect_phy(void *upstream, struct phy_device *phy)
>  	int ret;
>  
>  	phydev->has_sfp_mod_phy = true;
> +	phy_set_upstream_port(phy, phydev->sfp_cage_port);
>  
>  	/* If we aren't attached to a netdev, we can't add the SFP PHY to its
>  	 * topology.

[Severity: High]
If a later step in the connect path fails, do phy->upstream_port and
the module PHY's port->upstream_port pointers stay pointing at the cage
port?

phy_sfp_connect_phy() calls phy_set_upstream_port() before
phy_link_topo_add_phy(). When phy_link_topo_add_phy() fails, it only
resets phydev->has_sfp_mod_phy before returning the error.

phylink_sfp_connect_phy() follows the same pattern. It sets the
upstream port and then returns whatever phylink_sfp_config_phy()
returns. That call can fail in phylink_validate(),
phylink_sfp_select_interface(), phylink_attach_phy() or
phylink_bringup_phy().

The sfp-bus core does not call ->disconnect_phy() when ->connect_phy()
fails, so the NULL reset added to phy_sfp_disconnect_phy() and
phylink_sfp_disconnect_phy() does not cover this case.

When the module PHY is first probed through sfp_sm_probe_phy(), a
failure destroys the PHY, so the stale pointer goes away with it.
However, if I read sfp_register_bus() correctly, ->connect_phy() is
also reached when the upstream registers on a bus that already has a
module PHY in bus->phydev. The upstream here is a PHY driver via
phy_sfp_probe(), or phylink.

In that case the error goes back to the upstream, which then tears
down and frees its sfp_cage_port. Meanwhile bus->phydev stays alive on
the SFP bus. Its upstream_port, and the upstream_port of each of its
ports, still point at the freed phy_port. Anything that later follows
port->upstream_port, such as the ethtool port code reading
upstream_port->id later in this series, would then hit a
use-after-free.

Could phy_set_upstream_port(phy, NULL) be added to the error paths of
both connect callbacks? Or, if the pointer does not need to be valid
while phy_link_topo_add_phy() and phylink_sfp_config_phy() run, could
the assignment simply move after those calls succeed?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016133107.54054-1-maxime.chevallier%40bootlin.com
