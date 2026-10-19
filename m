Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083FA4FB9C6;
	Mon, 19 Oct 2026 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416793; cv=none; b=L3oT2Elkb1RDcuejGoHo23w9KaAFyNzUu7j43lo76DA8u1ArLJRKzW77db+FbB9Nu7XRqbTI81GRWaBtcY9YSpfYiidhme94JYHPV9WdbTuycaPWDcPkimJIzOtELgRLTP36O6wXWR4kUEbo4//w2oXIcckxcl3b/ZX42JnSTWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416793; c=relaxed/simple;
	bh=+zP6TA44L4jpSWTZidv4w9cFtke2hiUvk1j0dVYga74=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HtTHEYByCErSZ1/GG9ximD09aVvCWWohTb459io5EPymciJABw3gVwJyJZQbrr23lhngjLaY7kIoRMQ7+2VYG70FZhgaMu5Pbv3qQi8bAovARjPOGNMsmyL8SvJz7qyv2SiJ4eL8GMEDm2o2pFisYofRAsTcFprUfYW8QEGdzQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYQW9uhP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYQW9uhP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9A91F000C5;
	Mon, 19 Oct 2026 13:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792416791;
	bh=G7JWRNEeqE+5UBzszyzseU7WI1OL/lsQgkR2aQDhW4I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dYQW9uhPOZp1RPgN47IzcBClbd/knS4hL0/nP4R0EePTXL0r5mS4pW6LcfHjRHqU4
	 dZ7BhfgSo42MNG4VIDJx9C5exb3vQUdx5aJRTx5Op9VEkgFlLvC3y8igwzP2w8D8u+
	 V5YpQdpDbhlZt3Zec4iFfcyVSIapfCeHsv9UdP01OvErKtMY00q+aGsMLUjcoy1pxA
	 xdGQaSH2LqHHKYA11t95O4BfSieH3HTgy6NqSgGdFJW+YxF/zpQpLJka16h/tPNbxI
	 K7Rknd7o0YjzLUEydbkSllCnxXk2sdEuxnPQ6BDLU2M7GF33V3HCWRO0V3NUfRDT3Y
	 /Jhhbgj7uyQ7Q==
Subject: Re: [PATCH net-next v19 07/10] net: phy: phy_link_topology: Add a
 helper to retrieve ports
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
Date: Mon, 19 Oct 2026 13:33:10 +0000
Message-ID: <179241679003.3135.3860842103029417014@kernel.org>
In-Reply-To: <20261016133107.54054-8-maxime.chevallier@bootlin.com>
References: <20261016133107.54054-8-maxime.chevallier@bootlin.com>
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

Critical: 0 · High: 2 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Most concerning: the RTNL-only lifetime rule that this patch
  sets for phy_link_topo_get_port() is broken by the phylib teardown…
- [High] net: phy: NULL pointer dereference in netdev_need_ops_lock()

--

net: phy: phy_link_topology: Add a helper to retrieve ports

This adds phy_link_topo_get_port() so netlink can look up phy_ports
stored in the link topology. Callers must hold rtnl while they use the
returned port. phy_link_topo_add_port() now also warns and refuses to add
ports on ops-locked devices.

> diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h
> index 296ee514ba463..f2e493c433fff 100644
> --- a/include/linux/phy_link_topology.h
> +++ b/include/linux/phy_link_topology.h

[ ... ]

> @@ -71,6 +72,24 @@ phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
>  	return NULL;
>  }
>  
> +static inline struct phy_port *
> +phy_link_topo_get_port(struct net_device *dev, u32 port_id)
> +{
> +	struct phy_link_topology *topo = dev->link_topo;
> +
> +	if (!topo)
> +		return NULL;
> +
> +	/* ports in the topo are RTNL protected, but may be accessed under
> +	 * netdev_lock for ops-locked devices. For now keep them under rtnl
> +	 * protection, as no ops-locked devices have phy_port capabilities
> +	 * yet.
> +	 */
> +	ASSERT_RTNL();
> +
> +	return xa_load(&topo->ports, port_id);

[Severity: High]
Is RTNL really enough to keep the returned port alive?

This helper takes no reference on the port. It relies on every writer
holding RTNL when it erases and frees ports from topo->ports. The phylib
teardown path does not seem to do that.

phy_remove() is the driver-core remove callback and runs without RTNL:

drivers/net/phy/phy_device.c:phy_remove() {
    ...
	phy_sfp_release(phydev);
	phy_cleanup_ports(phydev);
    ...
}

Both of these go through phy_del_port() and then free the port:

drivers/net/phy/phy_device.c:phy_cleanup_ports() {
	list_for_each_entry_safe(port, tmp, &phydev->ports, head) {
		phy_del_port(phydev, port);
		phy_port_destroy(port);
	}
}

drivers/net/phy/phy_device.c:phy_del_port() {
    ...
	if (phydev->attached_dev)
		phy_link_topo_del_port(phydev->attached_dev, port);
    ...
}

phy_link_topo_del_port() does the xa_erase(), and phy_port_destroy() does
the kfree(). phy_sfp_release() takes and drops RTNL inside
sfp_bus_del_upstream(). Its later erase and free therefore also run
without RTNL.

phy_remove() can run while attached_dev is still set. One case is a sysfs
unbind of the PHY driver: try_module_get() in phy_attach_direct() only
blocks rmmod. The other is removal of the PHY device itself: the
device_link created in phy_attach_direct() is DL_FLAG_STATELESS, so it
does not force the MAC to unbind first.

Later in the series, port_prepare_data() in net/ethtool/port.c holds RTNL
and uses this helper:

	port = phy_link_topo_get_port(req_info->dev, request->port_id);
	if (!port)
		return -ENODEV;

	linkmode_copy(reply->supported, port->supported);

It then reads port->interfaces, port->id, port->is_mii, port->is_sfp and
port->upstream_port->id.

Could a PORT_GET doit or dump run concurrently with phy_remove() and
read the struct phy_port after phy_port_destroy() has freed it?

The phylink side already follows the intended rule:

drivers/net/phy/phylink.c:phylink_destroy_sfp_cage_port() {
    ...
		/* The port may still be accessed under RTNL */
		rtnl_lock();
		phy_link_topo_del_port(pl->netdev, pl->sfp_cage_port);
		rtnl_unlock();
    ...
}

The phy_device.c delete paths do not follow it. That includes the
mod_port removal in phy_detach_internal().

Should phy_del_port() and its callers take RTNL, or at least assert it,
around the topology removal and the free? This also appears to be
unchanged at the end of the series.

> +}
> +

[ ... ]

> diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
> --- a/drivers/net/phy/phy_link_topology.c
> +++ b/drivers/net/phy/phy_link_topology.c
> @@ -65,6 +65,14 @@ int phy_link_topo_add_port(struct net_device *dev, struct phy_port *port)
>  	struct phy_link_topology *topo;
>  	int ret;
>  
> +	/* Ports can now be queried without rtnl for ops-locked devices, which
> +	 * we don't support now as port retrieval is done under rtnl.
> +	 * We don't have phy_port enabled devices yet, let's make sure
> +	 * we are loudly warned about that when it happens.
> +	 */
> +	if (WARN_ON_ONCE(dev->netdev_ops && netdev_need_ops_lock(dev)))
> +		return -EOPNOTSUPP;
> +
>  	topo = phy_link_topo_get_or_alloc(dev);
>  	if (IS_ERR(topo))
>  		return PTR_ERR(topo);

[Severity: High]
The dev->netdev_ops test here is needed because netdev_need_ops_lock()
dereferences dev->netdev_ops->net_shaper_ops when CONFIG_NET_SHAPER is
enabled. Doesn't phy_link_topo_add_phy() in the same file need the same
guard?

As far as I can see it does this, with no check on dev->netdev_ops:

	if (WARN_ON_ONCE(netdev_need_ops_lock(dev)))
		return -EOPNOTSUPP;

phy_attach_direct() calls phy_link_topo_add_phy() for whatever
net_device the PHY is attached to. Some in-tree users attach a PHY to
a net_device that never gets netdev_ops. For example, gbe_probe() in
drivers/net/ethernet/ti/netcp_ethss.c passes gbe_dev->dummy_ndev to
of_phy_connect(). With CONFIG_NET_SHAPER=y that is a NULL pointer
dereference during probe.

Should phy_link_topo_add_phy() use the same
dev->netdev_ops && netdev_need_ops_lock(dev) test as
phy_link_topo_add_port()? Alternatively, netdev_need_ops_lock() could
tolerate a NULL netdev_ops itself, so callers don't each have to
remember the check. Which do you prefer?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016133107.54054-1-maxime.chevallier%40bootlin.com
