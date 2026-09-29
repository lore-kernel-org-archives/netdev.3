Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39AB22F767;
	Tue, 29 Sep 2026 00:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790642319; cv=none; b=YLqMLAbXBtZmOkD712owtV/BWWzutZrJ54V5BcUzQOka2jcylBG/VKiwhIU02zcGR/MdxkR3pRdQ/bt5x0yUA6yzIlj8Fh7dZN/2M02wukXeKvYOXCm5zJmu+XDI8tbJsxeAbSy/SYA6JMhdp/m+iXqborQ133+G7ngmI8pFYSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790642319; c=relaxed/simple;
	bh=xUV6f1bvzEznlgjCogh7ZcvER2dBGYcOewQ6TcZRPDA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TmLg/eEZNrYQmqhsVCJIprOBRFUzu2vClCHZHuBdobfA5pbvY6kvTo8aqYsEmf/Ema4Ympj+UFbcBYSffdX1y1+yfTuU2GDDjKfFvrzytMU1L0QrABBCvdN+aKaXKHDKqnJzkVHmxPWank2xo94mbW2oyn+mwZ6x8XoseysuRgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDJUZRu2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDJUZRu2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C23921F00899;
	Tue, 29 Sep 2026 00:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790642315;
	bh=17dMlqOyECTGvLdCsfaw4dQdmSvdzkKlibyFeU8G58c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RDJUZRu2obt2VFVNk4PqcCI7Txkgr1s+6pKMHTiNAL8Q1fQCWJnSWzR6XrJV9m8WD
	 ixs3tU3f/z6T5eL7mWRcpPYxJjx8q82hqFx3e2zibYxJynILhwhbSidaPSmoyzR0Ot
	 LE/rsODszRCn0DSEJHs0T0pKHs7RX8dCy2WRQyJKi7EMIbwa7msxvA+WfpSZOTJ76b
	 B4s6qX/LlBbY0vz1d16fvA3U9Nps8DtuG5sazxaHoTUkrHTzipBetn6svWBpCZOjkj
	 9nasAnJ8DZXZzC4gkbKoMg1GCrwQVzJyzqGJT4gy6jcXaPQMEvgwnC6wsM61HmEvNN
	 dhuiMfQjNrDGA==
Subject: Re: [PATCH net-next v18 03/10] net: phylink: Register a phy_port for
 MAC-driven SFP cages
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
Date: Tue, 29 Sep 2026 00:38:33 +0000
Message-ID: <179064231334.3145.4250740133245274216@kernel.org>
In-Reply-To: <20260927133619.955236-4-maxime.chevallier@bootlin.com>
References: <20260927133619.955236-4-maxime.chevallier@bootlin.com>
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

- [Medium] phylink_create_sfp_cage_port() calls phy_link_topo_add_port()
  without RTNL.
- [Low] phylink_create_sfp_cage_port() publishes a phy_port into the
  netdev's link topology without setting parent_type.

--

net: phylink: Register a phy_port for MAC-driven SFP cages

This commit registers a phy_port for SFP cages that the MAC drives
directly through phylink, and attaches it to the netdev's link
topology. The port is only created for phylink instances that have a
netdev. It is created in phylink_register_sfp() and removed in
phylink_destroy().

> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index a7d086cdc9b25..19090916af75f 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c

[ ... ]

> @@ -1767,6 +1770,50 @@ static void phylink_fixed_poll(struct timer_list *t)
>  
>  static const struct sfp_upstream_ops sfp_phylink_ops;
>  
> +static int phylink_create_sfp_cage_port(struct phylink *pl)
> +{
> +	struct phy_port *port;
> +	int ret = 0;
> +
> +	if (!pl->netdev || !pl->sfp_bus)
> +		return 0;
> +
> +	port = phy_port_alloc();
> +	if (!port)
> +		return -ENOMEM;
> +
> +	port->is_sfp = true;
> +	port->is_mii = true;
> +	port->active = true;

[Severity: Low]
parent_type is never set here. Should it be?

phy_port_alloc() uses kzalloc, so this port ends up with
parent_type == PHY_PORT_PHY and port->phy == NULL. The only parent
type defined in include/linux/phy_port.h is:

enum phy_port_parent {
	PHY_PORT_PHY,
};

and its kernel-doc says "Indicates that the port is driven by a PHY
device". This looks like the first phy_port that is driven by the MAC
or phylink instead of a PHY.

The other initializers in phy_device.c, such as phy_setup_sfp_port(),
always set the two fields together:

	port->parent_type = PHY_PORT_PHY;
	port->phy = phydev;

Nothing reads parent_type today, so this does not cause a NULL
dereference right now. Would it make sense to add a phylink/MAC
parent type to enum phy_port_parent and set it here? That way the
published port would not claim a PHY parent it lacks.

The same applies to phylink_add_sfp_mod_port() later in the series.

> +
> +	phy_interface_and(port->interfaces, pl->config->supported_interfaces,
> +			  phylink_sfp_interfaces);
> +	phy_port_update_supported(port);
> +
> +	ret = phy_link_topo_add_port(pl->netdev, port);

[Severity: Medium]
This runs from phylink_create(), which is documented as "the rtnl lock
must not be held when calling this function". Can this race with
ethtool readers of dev->link_topo?

If the netdev has no topology yet, phy_link_topo_add_port() allocates
and publishes it with a plain store:

drivers/net/phy/phy_link_topology.c:netdev_alloc_phy_link_topology() {
    ...
	xa_init_flags(&topo->ports, XA_FLAGS_ALLOC1);
	topo->next_port_index = 1;

	dev->link_topo = topo;
    ...
}

This store has no RTNL, WRITE_ONCE() or release barrier.

phylink_create() can be called on a netdev that is already registered.
For example, dpaa2 handles a runtime endpoint change like this:

dpni_irq0_handler_thread()
  dpaa2_eth_connect_mac()
    dpaa2_mac_connect()
      phylink_create()               <- no RTNL held
        phylink_register_sfp()
          phylink_create_sfp_cage_port()
            phy_link_topo_add_port()
              netdev_alloc_phy_link_topology()

Only the later phylink_fwnode_phy_connect() call in dpaa2_mac_connect()
is inside rtnl_lock(). Before this patch, that later call was the one
that first allocated the topology, through
phy_attach_direct()->phy_link_topo_add_phy().

The ethtool netlink readers read dev->link_topo and dereference it
while holding RTNL, not via RCU. For example,
ethnl_tsinfo_dump_one_net_topo() does:

	if (!dev->link_topo) {
	...
	xa_for_each_start(&dev->link_topo->phys, ctx->pos_phyindex, pdn,

phy_link_topo_get_phy(), ethnl_req_get_phydev() and the PHY dump in
net/ethtool/netlink.c follow the same pattern.

On arm64, can such a reader see the new pointer before the
kzalloc/xa_init_flags() stores are visible?

The comment in phy_link_topo_get_or_alloc() explains the ordering
between writers, but it does not seem to cover RTNL-holding readers.
Also, phylink_destroy_sfp_cage_port() takes rtnl_lock() around
phy_link_topo_del_port() with the comment "The port may still be
accessed under RTNL". Should the insertion side use the same locking?

> +	if (ret)
> +		phy_port_destroy(port);
> +	else
> +		pl->sfp_cage_port = port;
> +
> +	return ret;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927133619.955236-1-maxime.chevallier%40bootlin.com
