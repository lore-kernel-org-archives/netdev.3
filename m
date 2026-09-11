Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495873FB05A;
	Fri, 11 Sep 2026 18:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152732; cv=none; b=ZMBYtCeNq7fMrMAnKaMhEZsJLSgMRKeuFAf4Nf9xjXoRiqPOP7r9Gpbu7FIv64La8ero7FTXcrTxVQa4FwJaFstNSJc3lK25UtpOLaQhf1xha38LPUXHVkZ9joToALqAj9nuPqnu0oMoFx4TDB/lxh/x7uF3nSWBJnm71DYO2MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152732; c=relaxed/simple;
	bh=9Huzq8M2+09FRqtWfB+IUeG9XO9Zcqv8eW8fGF3KC/M=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jPlUHFA2asDIyovjOLgadp3Bh2DjfvO+pa6R2j6wkX8gPO88Z2g++BOcMUBR2Ls2O6j+ARzPsoMcLnidKL+9x7k4mwDSk2ORLsLK9XMFpUer9Wm9BwqzQ58Y6pHPQqqQTiwJaAD34riQKbAVfaYmLvCaiiQXKPZ8Yckvr4XuF1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCnjftY6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCnjftY6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF1C1F000FF;
	Fri, 11 Sep 2026 18:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152729;
	bh=Yo7yRsSPgH9fp6rWbrvzGiLjFsvTI26AJbX7GyjJFx8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RCnjftY6FoQgojpl0WgXUmhXclIn93TKDImZfhxTkMIb1v3SRhFy/n3emZDoy35EG
	 9rXfNe8pR4PTc5xionnV+NwX6RrBCsjm8c/2crNGmDQ9vYz00Plgxpd5ZRVGwQfTHu
	 gH1LC9MZMtDCtgrTSNCXtVsFKJLJxRYrOWz4ni79pk2OA6GNb9HHgeIN+hGBZ09OPB
	 XHDx5XWDg8SFba1uaQBNVkgcZMxZ97Ply/yXZsrlm8ktz6N7twmqKj6I3iKQpBrCwO
	 TaDe5ZOqOopK1IGVd7278NqjKUbB08HLw8bJtKl+JgfrzB+lmOx5CUfbQ9q7foz1Wi
	 NMzykz+qp+bKA==
Subject: Re: [PATCH RESEND net-next v17 06/10] net: phy: phy_port: Store
 information about a port's upstream
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
Date: Fri, 11 Sep 2026 18:52:07 +0000
Message-ID: <178915272783.219967.7690619054974247239@kernel.org>
In-Reply-To: <20260910170103.1029108-7-maxime.chevallier@bootlin.com>
References: <20260910170103.1029108-7-maxime.chevallier@bootlin.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 (1) · Low: 3

- [Low] The commit message states the change keeps track of "the port id
  of the MII port backing it", but phy_set_upstream_port()…
- [Low] The kernel-doc of the newly exported phy_set_upstream_port()
  (drivers/net/phy/phy_device.c:3786-3791) documents only that it "Sets…
- [Low] Claimed missing error-path rollback: both new connect_phy
  implementations (phy_sfp_connect_phy() at…

Pre-existing issues:
- [Medium] phy_set_upstream_port()
  (drivers/net/phy/phy_device.c:3792-3803) traverses phydev->ports with…

--

net: phy: phy_port: Store information about a port's upstream

This adds an upstream_port pointer to struct phy_port and struct phy_device,
along with a new exported helper phy_set_upstream_port(), so that an MDI port
backed by an MII port (for example an SFP module port backed by the SFP cage
port) records the port feeding it. The SFP connect/disconnect callbacks in
both phy_device.c and phylink.c are updated to set and clear it.

A few questions below.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 26634ef274f33..561d19edf331c 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1493,6 +1493,7 @@ static int phy_sfp_connect_phy(void *upstream, struct phy_device *phy)
>  	int ret;
>  
>  	phydev->has_sfp_mod_phy = true;
> +	phy_set_upstream_port(phy, phydev->sfp_cage_port);
>  
>  	/* If we aren't attached to a netdev, we can't add the SFP PHY to its
>  	 * topology.

[Severity: Low]
Here and in phylink_sfp_connect_phy(), the cage port pointer is published
into the module PHY before a fallible step (phy_link_topo_add_phy() here,
phylink_sfp_config_phy() there) and is not cleared if that step fails.
sfp_register_bus() also returns a connect_phy() error without calling
disconnect_phy().

Is a rollback needed on those paths, or is it intentionally left out?

Tracing it through suggests no dangling pointer is reachable today:

  sfp_sm_probe_phy()
      err = sfp_add_phy(sfp->sfp_bus, phy);
      if (err) {
              phy_device_remove(phy);
              phy_device_free(phy);

so the module phy_device and its ports are destroyed on that failure, and
the cage port is still alive at that point. The two paths that free the
cage port (phy_sfp_probe() out_port below, and phylink_register_sfp() ->
phylink_destroy_sfp_cage_port()) only run when sfp_register_bus() fails,
which requires bus->phydev to be non-NULL:

  sfp_register_bus()
      if (ops->connect_phy && bus->phydev) {
              ret = ops->connect_phy(bus->upstream, bus->phydev);

and the state machine detaches the module PHY (sfp_sm_phy_detach() ->
sfp_remove_phy(), which clears bus->phydev and invokes disconnect_phy())
before any upstream can register again. Would it still be worth making
the failure path symmetric so this does not depend on that ordering?

> @@ -1526,6 +1527,8 @@ static void phy_sfp_disconnect_phy(void *upstream, struct phy_device *phy)
>  
>  	if (dev)
>  		phy_link_topo_del_phy(dev, phy);
> +
> +	phy_set_upstream_port(phy, NULL);
>  }
>  
>  /**

[ ... ]

> @@ -1816,6 +1821,8 @@ static int phy_sfp_probe(struct phy_device *phydev)
>  		}
>  	}
>  
> +	phydev->sfp_cage_port = port;
> +
>  	ret = sfp_bus_add_upstream(bus, phydev, &sfp_phydev_ops);
>  	if (ret)
>  		goto out_port;
> @@ -1825,14 +1832,13 @@ static int phy_sfp_probe(struct phy_device *phydev)
>  	 */
>  	sfp_bus_put(bus);
>  
> -	phydev->sfp_cage_port = port;
> -
>  	return ret;
>  
>  out_port:
>  	if (port) {
>  		phy_del_port(phydev, port);
>  		phy_port_destroy(port);
> +		phydev->sfp_cage_port = NULL;
>  	}
>  out_sfp:
>  	sfp_bus_put(bus);

[ ... ]

> @@ -3777,6 +3783,25 @@ struct phy_port *phy_get_sfp_port(struct phy_device *phydev)
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

[Severity: Low]
The kernel-doc for phy_set_upstream_port() describes only that it sets the
phy_port controlling the MII, but the body does two more things that callers
need to know about: it hard-asserts RTNL, and it overwrites upstream_port on
every entry of phydev->ports.

Since this is EXPORT_SYMBOL_GPL() and the prototype in include/linux/phy.h
carries no locking annotation either, a caller following only the documented
contract will trip the WARN_ONCE() in ASSERT_RTNL(). Could the kernel-doc
state that RTNL must be held and that the value is propagated to all of the
PHY's ports?

> +
> +	phydev->upstream_port = port;
> +
> +	phy_for_each_port(phydev, local_port)
> +		local_port->upstream_port = port;
> +}
> +EXPORT_SYMBOL_GPL(phy_set_upstream_port);

[Severity: Medium]
This isn't a bug introduced by this patch, but the phy_for_each_port()
traversal here relies solely on ASSERT_RTNL(), while the list entries are
unlinked and freed from the driver-core unbind path, which does not take
RTNL:

  phy_remove()
      phy_sfp_release() / phy_cleanup_ports()
          list_for_each_entry_safe(port, tmp, &phydev->ports, head) {
                  phy_del_port(phydev, port);
                  phy_port_destroy(port);
          }

phy_get_sfp_port() and phy_link_topo_del_phy() already walk the same list
under the same RTNL-only convention, so the pattern predates this change,
and all in-tree callers of the new helper run from the SFP state machine
with RTNL held (sfp.c takes rtnl_lock() around sfp_sm_event()). The only
concurrent mutator found is a root-initiated sysfs unbind of the module PHY
driver.

Would it make sense to either take phydev->lock around the traversal, or
write down the rule that phydev->ports is immutable while the PHY is
registered?

Also, phy_add_sfp_mod_port() and phylink_add_sfp_mod_port() assign
port->upstream_port directly, and this helper later rewrites every port of
the PHY. Which of the two is meant to be authoritative?

>  
>  /**
>   * fwnode_mdio_find_device - Given a fwnode, find the mdio_device
>   * @fwnode: pointer to the mdio_device's fwnode

[ ... ]

> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index c8f57d78f96eb..320c8c2dd206a 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -4132,6 +4134,8 @@ static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
>  	phy_interface_and(phy->host_interfaces, phylink_sfp_interfaces,
>  			  pl->config->supported_interfaces);
>  
> +	phy_set_upstream_port(phy, pl->sfp_cage_port);
> +
>  	/* Do the initial configuration */
>  	return phylink_sfp_config_phy(pl, phy);
>  }
> @@ -4140,6 +4144,7 @@ static void phylink_sfp_disconnect_phy(void *upstream,
>  				       struct phy_device *phydev)
>  {
>  	phylink_disconnect_phy(upstream);
> +	phy_set_upstream_port(phydev, NULL);
>  }
>  
>  static const struct sfp_upstream_ops sfp_phylink_ops = {

> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index cb579b8a5b5f7..335821eb22171 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -615,6 +615,7 @@ struct phy_oatc14_sqi_capability {
>   * @sfp_bus: SFP bus attached to this PHY's fiber port
>   * @sfp_cage_port: The phy_port connected to the downstream SFP cage
>   * @mod_port: phy_port representing the SFP module, if it is phy-less
> + * @upstream_port: phy_port this PHY's MII attaches to, if any
>   * @attached_dev: The attached enet driver's device instance ptr
>   * @adjust_link: Callback for the enet controller to respond to changes: in the
>   *               link state.
> @@ -809,6 +810,7 @@ struct phy_device {
>  	struct sfp_bus *sfp_bus;
>  	struct phy_port *sfp_cage_port;
>  	struct phy_port *mod_port;
> +	struct phy_port *upstream_port;

[Severity: Low]
Is this new phy_device member read anywhere? phy_set_upstream_port() assigns
it, but grepping for upstream_port through the end of the series shows the
only reader is in net/ethtool/port.c:

  reply->upstream_port = port->upstream_port ? port->upstream_port->id : 0;

which uses the phy_port field, not the phy_device one. Could
phy_device::upstream_port be dropped, or is there a planned consumer?

Related to that, the commit message says:

  "let's keep track of the port id of the MII port backing it"

but what is stored is a raw struct phy_port pointer, not an id, and the new
phy_device field is not mentioned at all. Could the wording be adjusted to
match what the code stores?

>  	struct phylink *phylink;
>  	struct net_device *attached_dev;
>  	struct mii_timestamper *mii_ts;
> @@ -2493,6 +2495,8 @@ int __phy_hwtstamp_set(struct phy_device *phydev,
>  
>  struct phy_port *phy_get_sfp_port(struct phy_device *phydev);
>  
> +void phy_set_upstream_port(struct phy_device *phydev, struct phy_port *port);
> +
>  /**
>   * phy_module_driver() - Helper macro for registering PHY drivers
>   * @__phy_drivers: array of PHY drivers to register

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260910170103.1029108-1-maxime.chevallier%40bootlin.com
