Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ECC37FF7F;
	Tue, 29 Sep 2026 00:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790642330; cv=none; b=XZfu7vZLoQQwUCN+579sGc3H+y78P1wpGMRY1dTQppgeSSMxjj+tL7nh1CDEb5oFekVSXgm0YzwTl1Owk2Do9NchzChXWKWY4K8p2tzbVwGmnnW0Z3FW3dexgVuhKGEe6o3i23R0r8R38B4pWtrjdGe/QEbZXLK/b5UklbnoA24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790642330; c=relaxed/simple;
	bh=vvE372ilJ1o4wUjKP0ospzX+HeOetuwQw9PyZ0TqrUU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nhqclnAHbm70Pu0MiAa+upouIhiDSOHQ3+TeDod8btF613cZUk1QX9rO2OaYLFnDH4r7abgxb5ijXsVfeMhu4Fn3o4UgLWV9DzqVnAAmHIYHpLBgNAlGBRprOWc6EYFaNmBWjC2W/GPn3mthBTf3V2xBG3QX75QWpqzmQiRu8NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8QCV6zu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8QCV6zu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F8E1F00899;
	Tue, 29 Sep 2026 00:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790642323;
	bh=td8GAY+O6eCIq5j2eXXHPAAy2Cz5ly1wUEM1kJbNMv0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=E8QCV6zugeyf7dTajBtGrqYQimPfe/UnMXWQZe34oKCfOjPxSdYsZt96E0UUyp49q
	 EYswmZ77se8gzn6Dsl0fl1jukZFXhNkPKE1EL6juD+q8RSN78L9k/RPJyXSTYPJVQ0
	 tMHHHPtNEI8vY4nJnGgeWmqTWfFYgZ/lGvBPU4vyvjrZG7BqchjMuBJORswMjQ5LXV
	 TasSErow0xN84JKgLv2EWl45WK5xS/9qFdQQlN1A883FycdmwDWh2iyzXfqwGN5FdN
	 X62JkRhYsSB/GQXyjSlBBKudDVBx839bOiCwsM52hoNIFi4/yku6oroxEAuo9pD/85
	 SC38l2AOuDK2Q==
Subject: Re: [PATCH net-next v18 07/10] net: phy: phy_link_topology: Add a
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
 f@lex.la
Date: Tue, 29 Sep 2026 00:38:41 +0000
Message-ID: <179064232141.3145.9140453636997333793@kernel.org>
In-Reply-To: <20260927133619.955236-8-maxime.chevallier@bootlin.com>
References: <20260927133619.955236-8-maxime.chevallier@bootlin.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] phy_link_topo_get_port() (include/linux/phy_link_topology.h)
  returns a raw, unreferenced struct phy_port pointer from topo->ports.

--

net: phy: phy_link_topology: Add a helper to retrieve ports

This adds phy_link_topo_get_port(), which returns a phy_port from the
netdev's link topology xarray. Callers must hold RTNL. The commit also
makes phy_link_topo_add_port() warn and return -EOPNOTSUPP for ops-locked
devices.

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
> +}

[Severity: High]
No reference is taken on the returned port. The only thing keeping it
alive is RTNL, and ASSERT_RTNL() only warns. The commit message states the
rule as "the caller must hold rtnl until it's done with it".

Do all the paths that erase and free ports hold RTNL?

phy_remove() is the phy_driver .remove callback. It runs from sysfs driver
unbind or MDIO bus device removal, and it does not hold RTNL:

phy_remove()
  phy_sfp_release() / phy_cleanup_ports()
    phy_del_port()
      if (phydev->attached_dev)
          phy_link_topo_del_port(phydev->attached_dev, port);  <- xa_erase()
    phy_port_destroy(port);                                    <- kfree()

This path holds no RTNL and waits for no RCU grace period.

In contrast, phylink_destroy_sfp_cage_port() does wrap its delete in RTNL:

	/* The port may still be accessed under RTNL */
	rtnl_lock();
	phy_link_topo_del_port(pl->netdev, pl->sfp_cage_port);
	rtnl_unlock();

The teardown paths in phy_device.c do not do the same.

Later in the series, port_prepare_data() in net/ethtool/port.c adds a
reader. It holds RTNL, calls phy_link_topo_get_port(), and then reads
port->supported, port->interfaces, port->id, port->is_mii and port->is_sfp.
It also follows port->upstream_port->id.

The device_link created in phy_attach_direct() is DL_FLAG_STATELESS, so the
MAC is not unbound first and attached_dev stays set. Could an
ETHTOOL_MSG_PORT_GET that races with a PHY driver unbind then read a freed
struct phy_port?

This still looks present at the end of the series. Would it be possible to
take RTNL around the del and destroy steps in phy_sfp_release() and
phy_cleanup_ports()? Another option would be kfree_rcu() or refcounting for
the port.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927133619.955236-1-maxime.chevallier%40bootlin.com
