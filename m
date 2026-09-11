Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2873C40E8C5;
	Fri, 11 Sep 2026 18:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152734; cv=none; b=ajsMJPJYH4kkG+1RNDSasEBscQxVF0e4tHFpsQ/aTrGCw9bsXo2CaHgfGbxOPZYnhRel9VbHMGXskFhWjsUoQU8YDT7/KnzHis4jNFDDDlvSM0LzUyn88LHfZnHppQtAZLlSeU1md7ozPazL3fM+YX+rvMF/wVCxlboUEas/7Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152734; c=relaxed/simple;
	bh=bj79E99oig6qlCh4KkOiwmhKNqZRLPsBi3CK6RfBMB8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SmRFxIo8yNGA62yaBnE01VOb3ccCE29oPHbYR7zAkE+px4nzJnED9r6MapIjadLTgucNp4Ws0+Ez+uoKMJqSczNo+74Yn2Af2kIVT6cuJb9uWaOFGSaZOgfc03tskacDbTuSa94Bp1Od4hiqPKV61p1sh+BOuIKtjcuIafVPa1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3CcZjLQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3CcZjLQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FCF91F00893;
	Fri, 11 Sep 2026 18:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152731;
	bh=xyJ+gcPTi2KHDABFSW2UO4GWib7OLEERzfpo6bOkIEk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j3CcZjLQ95JHlAlS6xmGE+K4jJ9SBhTzI9fqr5NLbLCTqRjnHp46sikvdK6WYjEod
	 gZijAnkOxvj2vsJp9KyKPRsGeUwUsff24bI8mXLcrR9L0jcMgNB+rFKmRguGN3NHtj
	 ukvStSrus3gnr0BPej7iMIeodrDBl1iLB0L9bbhKR4QkTRAM9EyrttakgtOw9KDMoP
	 am9SGhXZmoKvX+COxxj2SjxPDze/x1zwKyISx9QZi7mZga5/bvFKq2UYWN5RFYPaFX
	 2Wid5zSaj3r8wGdLo4QjJ2jeRgvAEOvaJ+e9LYH6LIqFRJtZjM3MTHgB4xLMl2RzNm
	 2zUIUxieznsVw==
Subject: Re: [PATCH RESEND net-next v17 07/10] net: phy: phy_link_topology:
 Add a helper to retrieve ports
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
Date: Fri, 11 Sep 2026 18:52:09 +0000
Message-ID: <178915272984.219967.7179871656200305196@kernel.org>
In-Reply-To: <20260910170103.1029108-8-maxime.chevallier@bootlin.com>
References: <20260910170103.1029108-8-maxime.chevallier@bootlin.com>
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

Critical: 0 · High: 2 · Medium: 2 (1) · Low: 1

- [High] NULL pointer dereference newly introduced in
  phy_link_topo_add_port(): the added `if…
- [High] phy_link_topo_get_port() hands out a raw, unreferenced `struct
  phy_port *` and documents RTNL as the sole lifetime guarantee ("Caller…
- [Medium] The ops-locked guard added to phy_link_topo_add_port() is
  sampled too early to establish the invariant it exists for.
- [Medium] The commit message ("net: phy: phy_link_topology: Add a helper
  to retrieve ports") describes only the addition of the read helper,…
- [Low] Reported for completeness, assessed as not currently a bug:
  phy_link_topo_add_port() turns the ops-locked case into a hard failure…

Pre-existing issues:
- [Medium] Reported for completeness, assessed as a pre-existing pattern
  with unproven reachability: phy_link_topo_get_port() loads…

--

net: phy: phy_link_topology: Add a helper to retrieve ports

This adds phy_link_topo_get_port(), an inline helper that looks up a
phy_port in a netdev's link topology xarray under rtnl, and adds an
ops-locked guard to phy_link_topo_add_port().

> In order to allow netlink access to phy_ports, let's add a helper to
> retrieve them. When handling a port coming from phy_link_topology, the
> caller must hold rtnl until it's done with it.

[Severity: Medium]
The message describes only the new read helper, but the patch also changes
the behaviour of the existing exported write path.  Should the message
mention that phy_link_topo_add_port() now refuses registration with
-EOPNOTSUPP (plus a WARN splat) for ops-locked devices?

All callers turn that into a hard failure:

  phylink_create_sfp_cage_port() -> phylink_register_sfp() -> phylink_create()
  phylink_add_sfp_mod_port()   (SFP module insertion)
  phy_add_sfp_mod_port() / phy_attach_direct()  (PHY attach)

The new getter has no callers in this patch, so the add_port() hunk is the
only behaviour-affecting change here, which makes it easy to misread the
patch as an inert helper addition.

> diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
> index 28c5bf3a8849a..22885bf2e0455 100644
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
> +	if (WARN_ON_ONCE(netdev_need_ops_lock(dev)))
> +		return -EOPNOTSUPP;
> +

[Severity: High]
Can this dereference a NULL dev->netdev_ops during probe?  With
CONFIG_NET_SHAPER=y, netdev_need_ops_lock() in include/net/netdev_lock.h
does:

	bool ret = dev->request_ops_lock || !!dev->queue_mgmt_ops;

  #if IS_ENABLED(CONFIG_NET_SHAPER)
	ret |= !!dev->netdev_ops->net_shaper_ops;
  #endif

phy_link_topo_add_port() is reachable from probe via

  phylink_create() -> phylink_register_sfp() -> phylink_create_sfp_cage_port()
  -> phy_link_topo_add_port()

and some drivers call phylink_create() before installing netdev_ops.  In
mtk_add_mac() the phylink_create() call comes first and
"eth->netdev[id]->netdev_ops = &mtk_netdev_ops;" is only executed further
down; the netdev comes from alloc_etherdev_mqs() and net/core does not
install a default netdev_ops, so dev->netdev_ops is still NULL at the time
of the new check.  MediaTek boards with "sfp = <&sfpN>" on the eth-mac node
exist in tree (mt7986a-bananapi-bpi-r3.dts, mt7988a-bananapi-bpi-r4.dts),
so pl->sfp_bus is non-NULL and the cage port path is taken.

Note the identical pre-existing check in phy_link_topo_add_phy() is only
reached from phy_attach_direct(), i.e. after netdev_ops is set, so this is
new exposure for the port path.

[Severity: Medium]
Related to the above ordering: is this guard sampled early enough to be
meaningful for the SFP cage port?

For the cage port the check runs inside phylink_create(), before drivers
populate the very fields netdev_need_ops_lock() inspects
(dev->request_ops_lock, dev->queue_mgmt_ops,
dev->netdev_ops->net_shaper_ops).  mtk_add_mac() again shows the ordering:
phylink_create() first, netdev_ops assignment afterwards, with the netdev
freshly zeroed by alloc_etherdev_mqs().

A driver that becomes ops-locked after phylink_create() would therefore
register ports with no warning at all, which leaves exactly the
rtnl-versus-netdev_lock combination that the new
phy_link_topo_get_port() ASSERT_RTNL() assumes has been excluded.  Would
checking at a later point, or asserting in phy_link_topo_get_port()'s
caller path, catch that case?

[Severity: Low]
This isn't a bug today, but is the hard -EOPNOTSUPP the intended
granularity?  Every caller propagates it as fatal (probe failure via
phylink_create(), or a failed SFP module insertion / PHY attach), whereas
simply declining to register the port (return 0, leave it out of the
xarray) would be enough for an rtnl-only getter.

For what it is worth, no in-tree ops-locked driver hits this yet: among the
drivers with queue_mgmt_ops / request_ops_lock / net_shaper_ops only fbnic
uses phylink, and fbnic_phylink_create() passes fwnode == NULL, so
phylink_register_sfp() returns early and the cage port is never created.

>  	topo = phy_link_topo_get_or_alloc(dev);
>  	if (IS_ERR(topo))
>  		return PTR_ERR(topo);
> diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h
> index 296ee514ba463..9585282cae3fc 100644
> --- a/include/linux/phy_link_topology.h
> +++ b/include/linux/phy_link_topology.h

[ ... ]

> @@ -71,6 +72,25 @@ phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
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

[Severity: Medium]
This is a pre-existing pattern rather than something introduced here
(phy_link_topo_get_phy() reads dev->link_topo the same way, and
netdev_alloc_phy_link_topology() is untouched), but the plain load of
dev->link_topo happens before ASSERT_RTNL(), and the NULL path skips the
assertion entirely.

The publishing side has no release semantics either:

  drivers/net/phy/phy_link_topology.c:netdev_alloc_phy_link_topology() {
	xa_init_flags(&topo->ports, XA_FLAGS_ALLOC1);
	topo->next_port_index = 1;

	dev->link_topo = topo;
  }

and phy_link_topo_get_or_alloc() documents that this can run "from
.probe() : No rtnl, no netdev_lock".  In practice register_netdevice()
takes rtnl after the probe-time allocation, which appears to order the
xarray init against any rtnl-holding reader, so I could not construct a
reachable interleaving.  Would publishing dev->link_topo with release
semantics and asserting rtnl before touching it be worth doing anyway?

> +	/* ports in the topo are RTNL protected, but may be accessed under
> +	 * netdev_lock for ops-locked devices. For now keep them under rtnl
> +	 * protection, as no ops-locked devices have phy_port capabilities
> +	 * yet.
> +	 */
> +	ASSERT_RTNL();
> +
> +	/* Caller must hold RTNL while handling the phy_port */
> +	return xa_load(&topo->ports, port_id);
> +}

[Severity: High]
Is rtnl really sufficient to keep the returned phy_port alive?  The helper
hands out a raw pointer with no reference taken, but the write side of
topo->ports neither takes nor asserts rtnl, and phy_port_destroy() is a
bare kfree() with no kref and no RCU deferral:

  drivers/net/phy/phy_port.c:phy_port_destroy() {
	kfree(port);
  }

phy_link_topo_del_port() has no lock assertion either:

  drivers/net/phy/phy_link_topology.c:phy_link_topo_del_port() {
	struct phy_link_topology *topo = dev->link_topo;

	if (!topo)
		return;

	xa_erase(&topo->ports, port->id);
  }

Two free paths appear to run without rtnl.  On PHY driver unbind:

  phy_remove() -> phy_cleanup_ports() {
	list_for_each_entry_safe(port, tmp, &phydev->ports, head) {
		phy_del_port(phydev, port);
		phy_port_destroy(port);
	}
  }

and phylink teardown, whose kerneldoc states the opposite of the getter's
contract:

  drivers/net/phy/phylink.c
   * Note: the rtnl lock must not be held when calling this function.
   */
  void phylink_destroy(struct phylink *pl)

  phylink_destroy_sfp_cage_port() {
	if (pl->netdev && pl->sfp_cage_port)
		phy_link_topo_del_port(pl->netdev, pl->sfp_cage_port);

	if (pl->sfp_cage_port)
		phy_port_destroy(pl->sfp_cage_port);
  }

xa_erase() stops new lookups but gives no grace period, so a reader that
already obtained the pointer under rtnl can dereference freed memory.
Later in this series net/ethtool/port.c does exactly that:

	port = phy_link_topo_get_port(req_info->dev, request->port_id);
	if (!port)
		return -ENODEV;

	linkmode_copy(reply->supported, port->supported);

Would a kref on phy_port (or kfree_rcu, or taking and asserting the same
lock on every add/del/destroy path) close this?  For reference, the SFP
state machine paths do look safe here: drivers/net/phy/sfp.c takes
rtnl_lock() around sfp_sm_event(), so the module-port add/del are
serialized; it is the probe/unbind/destroy paths above that are not.

> +
>  #else
>  static inline int phy_link_topo_add_phy(struct net_device *dev,
>  					struct phy_device *phy,

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260910170103.1029108-1-maxime.chevallier%40bootlin.com
