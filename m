Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A4A33A6EB;
	Mon, 19 Oct 2026 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416783; cv=none; b=G1bb17FzidDSi2ThXMuEjcBDpYXt2PKP4GnKcrLPAFMmPV3v2goXwPobJka1h7/R9qp8bFC3M4nOuEdgIbvx4OcCT4AEUb3sXrjd0I8YBdyxhQENeeeftgG70pZRVWpUCzk+A9ZT8ozB4cTMXgKc62oG0JQP+tRu+QPcj7BW2zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416783; c=relaxed/simple;
	bh=A1dkNPE0a6d4Phc4KTntpaNkwZmBppJ27P38CaKTWbU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hRTRcyMfCqmEz0rPovxwD3WPQnXcGWSQoj2G0KP2GZorTXLYCpONK70bbWFRst/pfBZySVfaai3GI1oeT1PfZWxbseR/V9PZ0Z6DC9SVwDS4vNRXIeORoyXBVQhmY8D4jmGLfvIx/l1pXIqcHP1sL2LsNZt4nfyMiW2R431oTBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1Z6aq1P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1Z6aq1P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B2D1F000C4;
	Mon, 19 Oct 2026 13:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792416781;
	bh=ZIO/VMkBt+d5MiPDzDjp/GwCPGfETDlsJB+TtA3U7SY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=f1Z6aq1PEN2rfokAN5SM/CLXhWXjA3Ch3jcvMA5vss1ylYREC2e05zIqojAgV2BnJ
	 +SMo8IGzc5BxqfSeutzKFrvOAaTaA+5O1cPsAm/ngq7HCkGWNShYCHJR3FS+sLfQwA
	 4ka3XGZt5VXl/OsUraL07A0avmQirE6ZNiMDkSQ3En4F1jWLCCJWG4ffiCS5CW5Tj/
	 EVSrId8QCyAZeXDY/Xmq6wElXdce7I2UrXjhzl3LKe2P4khzUZzsE5s941rodczHzF
	 AcfcrrYqHXrQZ4x6hJifWYJyGQF4SjMJrnD//JhrcSz5K9wbSDF7oExC5Z8SLcaAKU
	 nHF+B+EqXTh6A==
Subject: Re: [PATCH net-next v19 02/10] net: phy: phy_link_topology: Track
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
 f@lex.la, chleroy@kernel.org
Date: Mon, 19 Oct 2026 13:32:59 +0000
Message-ID: <179241677980.3135.11020287617266861252@kernel.org>
In-Reply-To: <20261016133107.54054-3-maxime.chevallier@bootlin.com>
References: <20261016133107.54054-3-maxime.chevallier@bootlin.com>
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

Critical: 0 · High: 1 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] topo->ports can keep pointers to freed phy_port objects
  belonging to an SFP-module PHY that sits behind a media-converter PHY.
- [Medium] phy_link_topo_del_port() (phy_link_topology.c:84-93) runs
  xa_erase(&topo->ports, port->id) without checking that the slot…
- [Medium] phy_add_port() and phy_del_port() no longer match.
- [Medium] The patch ties two pieces of state together that are protected
  by different locks.

--

net: phy: phy_link_topology: Track ports in phy_link_topology

This commit adds a ports xarray to struct phy_link_topology and gives each
tracked phy_port an id that is unique within the topology. A PHY's ports
are added when the PHY joins the topology in phy_link_topo_add_phy(). They
are removed in phy_link_topo_del_phy() and phy_del_port().

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index bfce8b893644f..ab1aa8981c00c 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1580,6 +1580,9 @@ static void phy_del_port(struct phy_device *phydev, struct phy_port *port)
>  
>  	list_del(&port->head);
>  
> +	if (phydev->attached_dev)
> +		phy_link_topo_del_port(phydev->attached_dev, port);
> +
>  	phydev->n_ports--;
>  }

[Severity: Medium]
phy_del_port() now removes the port from the attached netdev's topology.
phy_add_port() has no matching phy_link_topo_add_port() call, though. It
only does list_add() and n_ports++. Ports reach topo->ports only through
the loop in phy_link_topo_add_phy(), and that loop runs at attach time.

What happens if the PHY driver is unbound and rebound through sysfs while
the PHY is attached?

phy_remove()
  phy_cleanup_ports()
    phy_del_port()
      phy_link_topo_del_port(phydev->attached_dev, port)

phy_remove() does not detach the PHY, so attached_dev stays set. On
rebind, phy_probe()->phy_setup_ports()->phy_add_port() creates new ports
with id 0, and nothing adds them to topo->ports.

Won't the topology be missing this PHY's ports until the PHY is detached
and attached again? When those ports are removed later, the call is
xa_erase(&topo->ports, 0), which does nothing.

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

[Severity: Medium]
phy_link_topo_del_port() erases whatever is stored at port->id and does
not check that the entry is this port.

port->id is also never cleared when a port leaves a topology.
phy_link_topo_add_port() re-inserts any nonzero id with xa_insert(), no
matter which topology handed that id out. The kernel-doc for @id says
"Unique identifier for the port within the topology".

Suppose a port keeps a stale id, and that id has since been given to
another port in the target topology. xa_insert() then returns -EBUSY,
phy_link_topo_add_phy() fails, and phy_attach_direct() fails. The commit
message doesn't mention this new way for attach to fail.

The error path also appears to clean up twice. phy_link_topo_add_phy()
has already rolled back through del_ports. phy_attach_direct() then does:

	err = phy_link_topo_add_phy(dev, phydev, PHY_UPSTREAM_MAC, dev);
	if (err)
		goto error;

This reaches phy_detach_internal() with attached_dev still set. Its
phy_link_topo_del_phy() call then runs xa_erase() for every port in
phy->ports, including the port that got -EBUSY and any later ports that
were never inserted.

Can this remove the other, still-live port's entry from topo->ports?

The same applies if phy_link_topo_add_phy() fails earlier (pdn
allocation, the ops-lock check, a phyindex collision) while ports still
carry stale ids. Would an xa_cmpxchg() or xa_load() check in
phy_link_topo_del_port() work better here?

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

[Severity: High]
Can this leave pointers to freed phy_port objects in topo->ports when an
SFP module PHY sits behind a media-converter PHY?

phy_sfp_connect_phy() adds the module PHY to the upstream PHY's netdev:

	if (dev)
		return phy_link_topo_add_phy(dev, phy, PHY_UPSTREAM_PHY, phydev);

With this loop, all of the module PHY's ports go into
dev->link_topo->ports. The module PHY is never attached itself, so its
attached_dev stays NULL.

Say the upstream PHY detaches first. For example, mvpp2 and mvneta call
phylink_disconnect_phy() in ndo_stop. Then
phy_detach_internal()->phy_link_topo_del_phy(dev, upstream) removes only
the upstream PHY's own ports. When the module is unplugged later:

sfp_sm_phy_detach()
  sfp_remove_phy()
    phy_sfp_disconnect_phy()   <- upstream attached_dev is NULL, no-op
  phy_device_remove()
    phy_remove()
      phy_cleanup_ports()
        phy_del_port()         <- module PHY attached_dev NULL, skipped
        phy_port_destroy()     <- port freed, still in topo->ports

Unbinding the module PHY's driver while the module is connected hits the
same check in phy_del_port(). The later phy_link_topo_del_phy() then
walks an empty phy->ports list.

Nothing reads these entries yet in this patch. Later in the series,
though, port_dump_one_dev() and port_prepare_data() in net/ethtool/port.c
iterate dev->link_topo->ports. They dereference port->supported,
port->interfaces and port->upstream_port->id.

ETHTOOL_MSG_PORT_GET does not require admin rights. Wouldn't that make
this a use-after-free that unprivileged users can reach? phy_del_port()
and phy_sfp_disconnect_phy() are still unchanged at the end of the
series.

The module PHY's entry in topo->phys already has the same gap. The stale
port entries are new with this patch.

> +
>  	return 0;

[ ... ]

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
phy_link_topo_add_phy() and phy_link_topo_del_phy() now walk phy->ports
under rtnl.

phy->ports is changed and freed in phy_remove()->phy_cleanup_ports() and
in the phy_probe() error paths. Those paths hold only the PHY's
device_lock. They are reached through sysfs unbind, or through
mdiobus_unregister() on a shared MDIO bus while another MAC's PHY is
still attached.

Can this list_for_each_entry() follow a port that phy_cleanup_ports() on
another CPU has just list_del()'d and freed with phy_port_destroy()?

phy_del_port() also reads phydev->attached_dev with no lock held, then
modifies dev->link_topo->ports without rtnl. The comment in
phy_link_topo_add_phy() says that rtnl_lock is what protects the PHY
topology.

Ports are freed right after they are erased from the xarray, with no
rtnl or RCU in between. Later in the series, port_prepare_data() in
net/ethtool/port.c looks up ports under rtnl, and its comment says "RTNL
must be held while holding a ref to the phy_port".
phylink_destroy_sfp_cage_port() takes rtnl around phy_link_topo_del_port()
for this reason.

Does phy_del_port() need the same protection? The attached_dev it reads
can also go stale if phy_detach() and free_netdev() run at the same
time.

Neither exported helper has an ASSERT_RTNL() or lockdep annotation.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016133107.54054-1-maxime.chevallier%40bootlin.com
