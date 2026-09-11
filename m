Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0902E3F7A83;
	Fri, 11 Sep 2026 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152725; cv=none; b=o7HTwXoUitac8qezx68CBi/DxxbtozT/7fJrNywYcTC2u0VYyO6rsPypl1oN2Dds2oOIMUjlZDM/PeYTb1Cn+KZFkClLCErhShY0fTFkdUhPQpUw1cGOnushk9o5inQ+65bmIpzGFlxmgTPe+t67PT9N3uqjHpcV90Q5MKcbNyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152725; c=relaxed/simple;
	bh=T9UNlQyAKzcxelKAeZ+2AFNy0cjeEH7WumKZFzW3Q9M=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rYYNKPb16W4Gd3viaKZ0dlb07du4pT0u4KA+NziEIWuwktRtsMyvKMxl9O9/YaVECTzEZa3spZWFmt51owBMNyunOaD7IfrpR0mVRKdMnM1xsqydidJy12ePEaHKrkxZJiR4BTyrDwb7ZE4+tvLOxHZQ+Xs3so7SUAoJ59M6tZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULvlE9JZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULvlE9JZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C571F00893;
	Fri, 11 Sep 2026 18:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152723;
	bh=jEJNunHZ8LiizIBxga81kSfRhgcNPsZLWO74X6JhiYg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ULvlE9JZI72fgXYV6iFiA1Yq40dZsw8TDHw2LdIQrWCUPrQc+w7RLhNlzf2wGxv75
	 rEA2DJCCgnGekq0B2IkOhkMlTsGMvQVGZZhguXtW8NjsVPb4x96tvmMpF5tiElbyFY
	 F41ZqEpmZXbqgggNmTfJh6pxw3H2nFHnjIo6Y5+iL/mjeDzrpkcPb5nvvQJhouaheH
	 JQKpkjJ5LOjIbIxAraLYWObTBVr0zayYtpNsaB7DcvmPhfX52bMDq2fcbecDxvCpPw
	 86ce/GPP7hW7v1HzBVM4PMVTf/AJllnGHeYtwGy8JV+jdwglhdJGgxrZdAQVZNcIwS
	 wLh6S0A4Sx0vA==
Subject: Re: [PATCH RESEND net-next v17 02/10] net: phy: phy_link_topology:
 Track ports in phy_link_topology
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
 dimitri.fedrau@liebherr.com, frank.wunderlich@linux.dev, p.ameruoso@live.it
Date: Fri, 11 Sep 2026 18:52:01 +0000
Message-ID: <178915272176.219967.12907817113442931022@kernel.org>
In-Reply-To: <20260910170103.1029108-3-maxime.chevallier@bootlin.com>
References: <20260910170103.1029108-3-maxime.chevallier@bootlin.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 2 · Low: 1 (1)

- [High] `phy_link_topo_del_port()`
  (drivers/net/phy/phy_link_topology.c:84-93) erases `topo->ports` by…
- [High] phy_port objects belonging to an SFP-module PHY are published
  into the netdev's new `topo->ports` xarray by…
- [Medium] Half-wired port registration: `phy_del_port()`
  (drivers/net/phy/phy_device.c:1666) now calls…
- [Medium] The patch exports two new mutators of the per-netdev topology,
  `phy_link_topo_add_port()` / `phy_link_topo_del_port()`…
- [Low] `Documentation/networking/phy-link-topology.rst` and the header-
  level description in include/linux/phy_link_topology.h still describe…

Pre-existing issues:
- [Low] The `struct phy_port` kernel-doc block edited by this patch
  (include/linux/phy_port.h:41) documents '@phy: If the parent is…

--

net: phy: phy_link_topology: Track ports in phy_link_topology

This adds a second xarray to struct phy_link_topology so that the
phy_port objects of a netdev are tracked alongside the PHYs, with a new
per-netdev port id allocated cyclically. Ports are bulk-registered when a
PHY is added to the topology, and removed when the PHY or the port goes
away.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 41d1b20cde2c0..2d0fa3c7f18eb 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1670,6 +1670,9 @@ static void phy_del_port(struct phy_device *phydev, struct phy_port *port)
>  
>  	list_del(&port->head);
>  
> +	if (phydev->attached_dev)
> +		phy_link_topo_del_port(phydev->attached_dev, port);
> +
>  	phydev->n_ports--;
>  }

[Severity: Medium]
This adds the topology removal side in phy_del_port(), but is there a
matching add anywhere?  phy_add_port() is the only place a phy_port gets
linked into phydev->ports, and it does not call phy_link_topo_add_port().
Ports only ever get inserted by the bulk loop in
phy_link_topo_add_phy(), which is a one-shot snapshot taken at attach
time.

Can this be triggered by unbinding and re-binding the PHY driver while the
PHY stays attached to the netdev?  phydev->attached_dev is not cleared by
a driver unbind:

unbind:
  phy_remove() -> phy_cleanup_ports() -> phy_del_port()
      -> phy_link_topo_del_port()   /* old ports erased, fine */

rebind:
  phy_probe() -> phy_setup_ports() -> phy_add_port()
      /* new ports never inserted into dev->link_topo->ports */

After that the PHY's ports are absent from the netdev topology, and the
later phy_detach() runs the new loop in phy_link_topo_del_phy() with
port->id == 0, so xa_erase(&topo->ports, 0) is called on an
XA_FLAGS_ALLOC1 array.

[Severity: Medium]
What is the locking contract for the new call here?  It is gated only on a
plain read of phydev->attached_dev, with no ASSERT_RTNL(), while
phy_link_topo_del_port() reads dev->link_topo with a plain load and then
takes topo->ports.xa_lock via xa_erase().

phy_link_topo_add_phy() at least has:

	if (WARN_ON_ONCE(netdev_need_ops_lock(dev)))
		return -EOPNOTSUPP;

but the two new port helpers have no equivalent, and they enter
phy_link_topo_get_or_alloc(), whose own comment says it can be called
"from .probe() : No rtnl, no netdev_lock" and from the "SFP state machine
: rtnl held or not".  Since netdev_alloc_phy_link_topology() does:

	xa_init_flags(&topo->ports, XA_FLAGS_ALLOC1);
	topo->next_port_index = 1;

	dev->link_topo = topo;

can two concurrent first-adders both kzalloc, leaking one topology and
splitting phys/ports across two objects?  And can a reader observe the
plain store to dev->link_topo before the xa_init_flags() above, so that
xa_erase() takes a not-yet-initialized spinlock?

Later in the series phylink_destroy_sfp_cage_port() calls
phy_link_topo_del_port() from phylink_destroy(), which is documented as
"the rtnl lock must not be held when calling this function", immediately
followed by phy_port_destroy() (kfree), while the reader side added later
(phy_link_topo_get_port()) contains ASSERT_RTNL().  Are those two
contracts compatible?

Note the ops-lock part is addressed later in the series by
"net: phylink: Register a phy_port for MAC-driven SFP cages", which adds
WARN_ON_ONCE(netdev_need_ops_lock(dev)) to phy_link_topo_add_port(); the
allocation race, the missing publication barrier and the unlocked
del_port remain at the end of the series.

[Severity: High]
For an SFP-module PHY, is there any path that removes its ports from the
topology?  The module PHY's own attached_dev is always NULL (PHY-upstream
SFP never calls phy_attach_direct() for it), so this new hook is skipped,
yet its ports were inserted using the host PHY's netdev through
phy_sfp_connect_phy() -> phy_link_topo_add_phy().

The sequence looks like:

  ip link set eth0 up
      host PHY attach, module PHY connect
      -> module ports inserted into dev->link_topo->ports

  ip link set eth0 down
      phy_disconnect() -> phy_detach_internal():
          phydev->attached_dev = NULL;
          phy_link_topo_del_phy(dev, phydev);   /* host PHY only */

  unplug SFP module
      sfp_sm_phy_detach() -> sfp_remove_phy() -> phy_sfp_disconnect_phy():
          struct net_device *dev = phydev->attached_dev;

          if (dev)
                  phy_link_topo_del_phy(dev, phy);   /* dev == NULL, skipped */

      then phy_device_remove()/phy_device_free() -> phy_remove()
          -> phy_cleanup_ports() -> phy_del_port()  /* attached_dev NULL, skip */
          -> phy_port_destroy() kfree()s the ports

Does the live netdev's topo->ports then hold freed phy_port pointers
until the netdev itself is freed?  xa_destroy() only frees the nodes, not
the entries.

At the end of the series "net: ethtool: Introduce ethtool command to list
ports" walks these entries from an unprivileged dump:

	xa_for_each_start(&dev->link_topo->ports, ctx->pos_portid, port, ctx->pos_portid)
	...
	linkmode_copy(reply->supported, port->supported);
	reply->upstream_port = port->upstream_port ? port->upstream_port->id : 0;

Even at this commit the stale slots are observable, since the id re-use
path in phy_link_topo_add_port() does xa_insert() on the stale index and
fails a later add with -EBUSY.

> diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
> index 0462283c80202..28c5bf3a8849a 100644
> --- a/drivers/net/phy/phy_link_topology.c
> +++ b/drivers/net/phy/phy_link_topology.c

[ ... ]

> @@ -56,12 +60,45 @@ static struct phy_link_topology *phy_link_topo_get_or_alloc(struct net_device *d
>  	return dev->link_topo;
>  }
>  
> +int phy_link_topo_add_port(struct net_device *dev, struct phy_port *port)
> +{
> +	struct phy_link_topology *topo;
> +	int ret;
> +
> +	topo = phy_link_topo_get_or_alloc(dev);
> +	if (IS_ERR(topo))
> +		return PTR_ERR(topo);
> +
> +	/* Attempt to re-use a previously allocated port_id */
> +	if (port->id)
> +		ret = xa_insert(&topo->ports, port->id, port, GFP_KERNEL);
> +	else
> +		ret = xa_alloc_cyclic(&topo->ports, &port->id, port,
> +				      xa_limit_32b, &topo->next_port_index,
> +				      GFP_KERNEL);
> +
> +	return ret < 0 ? ret : 0;
> +}
> +EXPORT_SYMBOL_GPL(phy_link_topo_add_port);
> +
> +void phy_link_topo_del_port(struct net_device *dev, struct phy_port *port)
> +{
> +	struct phy_link_topology *topo = dev->link_topo;
> +
> +	if (!topo)
> +		return;
> +
> +	xa_erase(&topo->ports, port->id);
> +}
> +EXPORT_SYMBOL_GPL(phy_link_topo_del_port);

[Severity: High]
Two things about the id handling here.

The add path treats port->id == 0 as "not registered yet", but the del
path erases unconditionally, with no id != 0 guard and no check that the
slot actually holds this port.  port->id is also never cleared on
removal.

If the new port loop in phy_link_topo_add_phy() fails (xa_alloc_cyclic
-ENOMEM), the del_ports rollback leaves the failing port with id 0, then
phy_attach_direct() does "goto error" -> phy_detach_internal() ->
phy_link_topo_del_phy(), whose new loop calls del_port for every port in
the list.  Can that end up doing xa_erase(&topo->ports, 0) and dropping
the XA_ZERO_ENTRY reservation of the XA_FLAGS_ALLOC1 array?

The second case is the cross-netdev one.  port->id is a per-netdev index,
but it survives on the phy_port, so re-using it in a *different*
topology can collide:

	if (port->id)
		ret = xa_insert(&topo->ports, port->id, port, GFP_KERNEL);

If netdev B already has a live port at that id, xa_insert() returns
-EBUSY, phy_link_topo_add_phy() and therefore phy_attach_direct() fail so
the interface cannot come up, and the subsequent
phy_detach_internal() -> phy_link_topo_del_phy() loop erases that id from
B's xarray, removing the other, still-live port's entry.

At the end of the series this is reachable, since
phylink_create_sfp_cage_port() registers the MAC-driven cage port at
phylink/sfp attach time and it takes id 1 in the fresh topology, so a
phy_device persisting on an independent MDIO bus with ports carrying id 1
from a previous netdev collides on xa_insert(1).

Would an ownership check (xa_cmpxchg() or an xa_load() compare), an
id != 0 guard, plus clearing port->id in del_port, and falling back to
fresh allocation when xa_insert() returns -EBUSY, address both cases?
None of these were added through the end of the series.

>  int phy_link_topo_add_phy(struct net_device *dev,
>  			  struct phy_device *phy,
>  			  enum phy_upstream upt, void *upstream)
>  {
>  	struct phy_link_topology *topo;
>  	struct phy_device_node *pdn;
> +	struct phy_port *port;
>  	int ret;
>  
>  	/* ethtool ops may run without rtnl_lock, and rtnl_lock is what
> @@ -110,8 +147,20 @@ int phy_link_topo_add_phy(struct net_device *dev,
>  	if (ret < 0)
>  		goto err;
>  
> +	/* Add all the PHY's ports to the topology */
> +	list_for_each_entry(port, &phy->ports, head) {
> +		ret = phy_link_topo_add_port(dev, port);
> +		if (ret)
> +			goto del_ports;
> +	}
> +
>  	return 0;
>  
> +del_ports:
> +	list_for_each_entry_continue_reverse(port, &phy->ports, head)
> +		phy_link_topo_del_port(dev, port);
> +
> +	xa_erase(&topo->phys, phy->phyindex);
>  err:
>  	kfree(pdn);
>  	return ret;

[Severity: Low]
Documentation/networking/phy-link-topology.rst still describes the
topology as tracking PHY devices only, and its API section documents just
phy_link_topo_add_phy() / phy_link_topo_del_phy() and the phyindex
allocation rules.  Should it be extended for the new ports xarray,
next_port_index and the exported phy_link_topo_add_port() /
phy_link_topo_del_port()?

The same applies to the id semantics: the RST states "The value 0 is
reserved to indicate the PHY doesn't belong to any topology yet", which
now also applies to port ids but is documented only for PHYs.  At the end
of the series the documentation commit only touches phy-port.rst, so
phy-link-topology.rst stays inconsistent with the implementation.

> diff --git a/include/linux/phy_port.h b/include/linux/phy_port.h
> index 0ef0f5ce47092..4e2a3fdd2f2e4 100644
> --- a/include/linux/phy_port.h
> +++ b/include/linux/phy_port.h
> @@ -36,6 +36,7 @@ struct phy_port_ops {
>  /**
>   * struct phy_port - A representation of a network device physical interface
>   *
> + * @id: Unique identifier for the port within the topology
>   * @head: Used by the port's parent to list ports
>   * @parent_type: The type of device this port is directly connected to
>   * @phy: If the parent is PHY_PORT_PHYDEV, the PHY controlling that port

[Severity: Low]
This isn't a bug introduced by this patch, but while the kernel-doc block
is being touched: the @phy line refers to PHY_PORT_PHYDEV, and the enum
in the same header only defines PHY_PORT_PHY:

	enum phy_port_parent {
		PHY_PORT_PHY,
	};

There is no PHY_PORT_PHYDEV in the tree.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260910170103.1029108-1-maxime.chevallier%40bootlin.com
