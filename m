Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97507381AE5;
	Tue, 29 Sep 2026 00:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790642328; cv=none; b=SDOPvpK0VdIOamDXHl9ubWdchFW6PP0zDqCtp/plpCDpLHhjY37cpzm3RshNLHIJBnlk9vyI7GyPlkQgJzbqaZieGqi5AkMKzLmkwvgh+gjOllyXg8a/7OPuDLVUIYV2fFBIWMVmatvcZb+A+eLuXDbERqZhengD+aDLo2swJDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790642328; c=relaxed/simple;
	bh=Ux0R/DfuOCd1RKULjS6Dpdmk1n7f8MT6V0z3GhD11w0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JVTPJF6IVIyWhmh13JDscCeTxRjATJ6pthrPdKnNNmMA4vHFk/WR0OFKVd84nMxkOxPvBTlnldp7dTvZfCUZvZdjUigTrLzJRwQ+7s+Rho7saSgsFbaS0xY3KhYI9gx2Y1RVEDQO1C/LZz5talitqbm2oqWG3UO2ZTqN6F/GBqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8CN/sxL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8CN/sxL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1901F00898;
	Tue, 29 Sep 2026 00:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790642321;
	bh=gZgaXiiKUuVXt/R8RoqMsDKkUYB5kf4uWDE2lB6/aYo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=V8CN/sxLAL1HFY2Ju/VSZGEe2fWCWO8tywGDu0HYxCX/mjLS/gfKmGV9PbLeSL/bz
	 udx1hWSJ3CfnXhpWWwRdS5+6QVu/j/rFR3FCgFLRhVb+0+RNIo7eElGN7MK9O0JKsH
	 FSutzLCkI7so1kBMoMzZtLavYdsX1aQCwUOn4034ZZSy/fjzKwy8dbN9gAy/ED61RI
	 iiGq1MjifAg4TvUk16+S0ywAt6Hb+df4iUi5knqe4ltj+G+qKtC0twl8KVEjUGJIA9
	 kGaA0Rm04K7DqkC0/d9idM6Lt0uespIQvFSbeIqt/M6ymyaKcW/K82TA4WORYY8AG8
	 znY7VKTT3fCpw==
Subject: Re: [PATCH net-next v18 06/10] net: phy: phy_port: Store information
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
 f@lex.la
Date: Tue, 29 Sep 2026 00:38:39 +0000
Message-ID: <179064231937.3145.3312920675959413027@kernel.org>
In-Reply-To: <20260927133619.955236-7-maxime.chevallier@bootlin.com>
References: <20260927133619.955236-7-maxime.chevallier@bootlin.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] `phy_set_upstream_port()`
  (drivers/net/phy/phy_device.c:3702-3712) walks `phydev->ports` and…
- [Low] `phy_set_upstream_port()`
  (drivers/net/phy/phy_device.c:3702-3712) sets `phydev->upstream_port`…

--

net: phy: phy_port: Store information about a port's upstream

This commit adds an upstream_port pointer to struct phy_port and struct
phy_device. With it, a SFP module port or a module PHY can record the SFP
cage MII port that feeds it. A new helper, phy_set_upstream_port(), is
called from the SFP connect/disconnect callbacks in phylib and phylink.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index ab9631b161bc4..2bb4abd0d3924 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c

[ ... ]

> @@ -1436,6 +1437,8 @@ static void phy_sfp_disconnect_phy(void *upstream, struct phy_device *phy)
>  
>  	if (dev)
>  		phy_link_topo_del_phy(dev, phy);
> +
> +	phy_set_upstream_port(phy, NULL);
>  }

[Severity: Medium]

Can this walk of phy->ports race with phy_remove() on the module PHY?

phy_set_upstream_port() walks phy->ports and writes through each entry.
Only RTNL is held while it does this.

phy_remove()->phy_cleanup_ports() does list_del() and phy_port_destroy()
on the same entries without RTNL. It holds only the device lock from the
driver core.

For a module PHY, phydev->sfp_bus is NULL, so phy_sfp_release() does not
take RTNL either. PHY drivers do not set suppress_bind_attrs, so root can
unbind the module PHY's driver through sysfs:

CPU0 (rtnl_lock held)
sfp_check_state() / sfp_timeout()
  sfp_sm_event()
    sfp_sm_phy_detach()
      sfp_remove_phy()
        phy_sfp_disconnect_phy() / phylink_sfp_disconnect_phy()
          phy_set_upstream_port(phy, NULL)
            phy_for_each_port(phydev, local_port)
              local_port->upstream_port = port;

CPU1 (device lock only)
sysfs unbind
  device_release_driver()
    phy_remove()
      phy_cleanup_ports()
        phy_del_port()
        phy_port_destroy()

If these overlap, could CPU0 write NULL into a phy_port that CPU1 has
just freed? The same applies to the new call in
phylink_sfp_disconnect_phy().

This disconnect path already had an RTNL-only walk of phy->ports through
phy_link_topo_del_phy(). That walk was added earlier in this series by
"net: phy: phy_link_topology: Track ports in phy_link_topology". This
patch adds a second walker, and this one also writes through the entries.

The underlying gap seems to be that removing entries from phydev->ports
isn't serialized with RTNL.

[ ... ]

> @@ -3687,6 +3693,25 @@ struct phy_port *phy_get_sfp_port(struct phy_device *phydev)
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

This copies the upstream only into the ports that are on phydev->ports
when it is called. What happens to ports added later?

phy_add_port() doesn't copy phydev->upstream_port into the new port:

drivers/net/phy/phy_device.c:phy_add_port() {
    ...
	phy_port_update_supported(port);

	list_add(&port->head, &phydev->ports);

	phydev->n_ports++;
    ...
}

This can happen in two ways.

First, phy_sfp_connect_phy() accepts a module PHY that has no driver
bound. phylink_sfp_connect_phy() rejects this case with its phy->drv
check. If the driver binds later, phy_probe()->phy_setup_ports()->
phy_add_port() creates ports with upstream_port == NULL.

Second, the module PHY's driver can be unbound and rebound through sysfs
while the module stays connected. phy_remove()->phy_cleanup_ports() frees
the ports, and the next probe recreates them without an upstream.

In both cases, phydev->upstream_port points at the SFP cage port while
the phy_port entries have upstream_port == NULL. That doesn't match the
new kernel-doc for phy_port::upstream_port in include/linux/phy_port.h.

At the end of the series this has no visible effect. port_prepare_data()
in net/ethtool/port.c only sees ports in the netdev topology, and these
later ports are never added there. Nothing reads phydev->upstream_port
yet.

Would it make sense for phy_add_port() to inherit phydev->upstream_port
when it adds a port?

> +EXPORT_SYMBOL_GPL(phy_set_upstream_port);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927133619.955236-1-maxime.chevallier%40bootlin.com
