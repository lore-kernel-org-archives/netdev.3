Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5621537E5F3;
	Tue, 29 Sep 2026 00:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790642317; cv=none; b=EXONGi+FwoIkiuDK18qsQ5aha5/ICOZtXNJDTAyVmIKFrUxHBe+jEOxXZMCOP83RJgKa2gjxi2uuoDOEnkuMOCV8gpI3fswk0EbFh8lZKqmkcac6Ka2BMI+3ll2XhpWBH7P1TiGpbVwzihIQiJHjUfD1EvDWLl97mcWBacJeecg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790642317; c=relaxed/simple;
	bh=firi5a6EzmNQVqBwD1pM5V/xdVirrEQ0dLKGrMR9HCM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IVAI8etILuLhiyhAQ2DWkmfPBjIeWa9wn1usXi/4bCVA5ap9OI2CNjxCFEU5SXyqFxbZH46su7WcIwyjsJFmeXvO8BB6r0Spuww+/wxU6w5Ru6nj5gtl3zUKEAkVLGEVRyzHQiDgvXbxPI54PH1yzvrGy+QeLn1N8NDWCr+1Ypc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQ2EI4LG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQ2EI4LG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15CC1F00898;
	Tue, 29 Sep 2026 00:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790642313;
	bh=dvwmNLhwWrbxkGOKSYCHC5k9VcrB6bqYAHgAcrFsVIA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CQ2EI4LG8vlezqOTN4nXqPlGf9VfrZF4YSahg+SdCUcm5yFrzZWOwtoWsyLO7G7sv
	 KmkoBMay6dXR07nnRFyJvrJ31E+Lxy8/n/3Ju84VnAQVWQHBzQbRABml2xtft4UZFD
	 JDfaPmJD4KuufFQ+QOJpEqIC0Jv3/Lx/bPL8Vn8U4Z6OZLlRC58b9Vec6QG/XTBD7L
	 n99bDvGOkeI/2P9Bksx9WKQu716ETO3PIqV2QKtDbMbnU6wrDvKOMzxX60zMyBbTED
	 CsNAj8WwfAMuKr27B6vSspZ71sS4FcFwefhPE5rIXBDHlnP7lt/JKD156kMHCS30sr
	 ZakzQGaAPsX8A==
Subject: Re: [PATCH net-next v18 02/10] net: phy: phy_link_topology: Track
 ports in phy_link_topology
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
Date: Tue, 29 Sep 2026 00:38:31 +0000
Message-ID: <179064231143.3145.13494941094645193325@kernel.org>
In-Reply-To: <20260927133619.955236-3-maxime.chevallier@bootlin.com>
References: <20260927133619.955236-3-maxime.chevallier@bootlin.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Ports of SFP module PHYs that are connected via PHY_UPSTREAM_PHY
  can be freed while they are still in dev->link_topo->ports, leaving…
- [Medium] phy_link_topo_del_port() erases topo->ports[port->id] without
  checking that the stored entry is this port, and port->id is…
- [Medium] The patch makes two paths touch the same data under locks that
  never overlap.
- [Low] Adding and removing ports in the topology is asymmetric.

--

net: phy: phy_link_topology: Track ports in phy_link_topology

This commit adds a ports xarray to struct phy_link_topology and an id
field to struct phy_port. PHY-driven ports are added to the netdev
topology when phy_link_topo_add_phy() runs. They are removed from it in
phy_link_topo_del_phy() and phy_del_port().

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 5b13a74e2fa92..c4d2c03b8282b 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1580,6 +1580,9 @@ static void phy_del_port(struct phy_device *phydev, struct phy_port *port)
>  
>  	list_del(&port->head);
>  
> +	if (phydev->attached_dev)
> +		phy_link_topo_del_port(phydev->attached_dev, port);
> +

[Severity: High]

Can this leave freed ports in dev->link_topo->ports for SFP module PHYs?

phy_sfp_connect_phy() adds the module PHY with PHY_UPSTREAM_PHY:

    struct net_device *dev = phydev->attached_dev;

    if (dev)
        return phy_link_topo_add_phy(dev, phy, PHY_UPSTREAM_PHY, phydev);

The new loop in phy_link_topo_add_phy() then inserts all of the module
PHY's ports into the upstream netdev's topology. The module PHY never
goes through phy_attach_direct(), so its attached_dev stays NULL. Because
of that, the check above never calls phy_link_topo_del_port() for it.

One path is an unbind of the module PHY's driver:

phy_remove(M)
  phy_cleanup_ports(M)
    phy_del_port()      <- M->attached_dev is NULL, no xa_erase()
    phy_port_destroy()  <- kfree(port)

Later, phy_sfp_disconnect_phy() -> phy_link_topo_del_phy(dev, M) walks
M->ports. That list is empty by then, so the entry is never erased.

A second path involves MAC drivers that connect the PHY in ndo_open and
disconnect it in ndo_stop (for example mvpp2 or mvneta via phylink). With
a module PHY present, taking the link down runs phy_detach_internal(P) ->
phy_link_topo_del_phy(dev, P), which removes only P's own ports.

When the module is then unplugged, sfp_sm_phy_detach() -> sfp_remove_phy()
-> phy_sfp_disconnect_phy() sees P->attached_dev == NULL and skips
phy_link_topo_del_phy(dev, M). phy_device_remove(M) -> phy_remove() ->
phy_cleanup_ports() then frees M's ports without erasing them.

xa_destroy() doesn't dereference the entries, so this commit alone won't
crash. However, a later patch in this series, "net: ethtool: Introduce
ethtool command to list ports", adds an ETHTOOL_MSG_PORT_GET dump with no
admin permission flag. That dump walks xa_for_each(&dev->link_topo->ports).
Its port_prepare_data() copies port->supported and port->interfaces and
dereferences port->upstream_port.

Wouldn't that dump read freed memory? phy_del_port(),
phy_sfp_disconnect_phy() and phy_link_topo_del_phy() are unchanged at the
end of the series.

>  	phydev->n_ports--;
>  }
>  
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

[ ... ]

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

[Severity: Medium]

Can this erase an entry that belongs to a different port?

port->id is deliberately kept across detach and attach. When the id is
reused, phy_link_topo_add_port() calls xa_insert(). That returns -EBUSY if
another port in the target topology already owns the index, and there is
no fallback to a fresh allocation.

In that case phy_link_topo_add_phy() rolls back the ports it inserted and
returns the error. phy_attach_direct() then does:

    err = phy_link_topo_add_phy(dev, phydev, PHY_UPSTREAM_MAC, dev);
    if (err)
        goto error;

The error path calls phy_detach_internal() while attached_dev is still
set:

phy_detach_internal()
  phy_link_topo_del_phy(dev, phydev)
    list_for_each_entry(port, &phy->ports, head)
      phy_link_topo_del_port(dev, port)
        xa_erase(&topo->ports, port->id)

This walks every port in phy->ports, including the port that failed and
any ports that were never inserted. The failing port's id belongs to
another live port.

Wouldn't that live port be removed from the topology while its owner
still exists? Would checking the stored entry, for example with
xa_cmpxchg(&topo->ports, port->id, port, NULL, 0), avoid this?

The same full teardown runs when phy_link_topo_add_phy() fails earlier,
either on pdn allocation -ENOMEM or on a phyindex collision.

On -ENOMEM from xa_alloc_cyclic(), __xa_alloc() may already have written
an index into port->id that was never stored. The port could then carry an
id it doesn't own.

The PHY attach also fails with -EBUSY in the collision case. The code is
unchanged at the end of the series. Later patches add more pre-registered
ports, such as the phylink SFP cage port allocated at phylink_create()
time, and these could collide with kept ids.

> +}
> +EXPORT_SYMBOL_GPL(phy_link_topo_del_port);

[ ... ]

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

[Severity: Low]

Should phy_add_port() also add the port to the topology?

phy_del_port() now calls phy_link_topo_del_port() whenever
phydev->attached_dev is set, but phy_add_port() only does:

    list_add(&port->head, &phydev->ports);

    phydev->n_ports++;

Ports reach topo->ports only through this loop, at attach or connect time.

Consider an attached PHY whose driver is unbound and rebound through
sysfs. phy_remove() leaves attached_dev and the PHY's topology entry in
place, and phy_cleanup_ports() -> phy_del_port() removes the original
ports from the topology.

The rebind then runs phy_probe() -> phy_setup_ports() -> phy_add_port().
That rebuilds phydev->ports but doesn't add the new ports to the topology.
No phy_attach_direct() runs, so the netdev's topology is missing all of
the PHY's ports until the next detach and attach.

The same gap applies to a module PHY whose driver binds after
phy_sfp_connect_phy() has already walked an empty port list.

The comment in phy_link_topo_get_or_alloc() also says:

 *  - If we have a PHY, phy_link_topo_add_phy() will always run first
 *    and trigger the alloc. Only then the ports can be added through
 *    phylib or sfp.

However, there doesn't seem to be a per-port add path in phylib.
phy_add_port() is unchanged at the end of the series.

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
> @@ -123,10 +172,14 @@ void phy_link_topo_del_phy(struct net_device *dev,
>  {
>  	struct phy_link_topology *topo = dev->link_topo;
>  	struct phy_device_node *pdn;
> +	struct phy_port *port;
>  
>  	if (!topo)
>  		return;
>  
> +	list_for_each_entry(port, &phy->ports, head)
> +		phy_link_topo_del_port(dev, port);
> +

[Severity: Medium]

Is it safe to walk phy->ports here with only RTNL held?

phy_link_topo_add_phy() and phy_link_topo_del_phy() now walk
phydev->ports under RTNL, from phy_attach_direct() and
phy_detach_internal(). The driver unbind path changes the same list under
device_lock only, without RTNL:

phy_remove()
  phy_cleanup_ports()
    phy_del_port()
      list_del(&port->head)
      phy_link_topo_del_port()   <- xa_erase() on dev->link_topo->ports
    phy_port_destroy()           <- kfree(port)

Suppose an attached PHY is unbound through sysfs while "ip link set down"
runs phy_disconnect() -> phy_detach_internal() -> phy_link_topo_del_phy().
Could this walk then follow a port that phy_cleanup_ports() has just
unlinked and freed?

phy_del_port() also reads phydev->attached_dev with no RTNL and no
READ_ONCE(), then uses it to reach dev->link_topo. Can
phy_detach_internal() clear attached_dev between that check and the use?

A later patch in this series, "net: phy: phy_link_topology: Add a helper
to retrieve ports", says that "the caller must hold rtnl until it's done
with it", and phy_link_topo_get_port() does ASSERT_RTNL(). The xa_erase()
and kfree() in phy_remove() run without RTNL.

Could an ethtool port dump that holds RTNL xa_load() a port that is then
freed underneath it?

>  	pdn = xa_erase(&topo->phys, phy->phyindex);
>  
>  	/* We delete the PHY from the topology, however we don't re-set the

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927133619.955236-1-maxime.chevallier%40bootlin.com
