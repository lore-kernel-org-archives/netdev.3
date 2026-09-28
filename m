Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4D748A2BF;
	Mon, 28 Sep 2026 09:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588244; cv=none; b=pNYW0C2MzWKKX+mhtkTF8PLpIkjEtAyWStfo4WpQ87fyS4ypGt/bTtKoChay8R4wFSi6Mn7i0eXpvHIaLDF510TeXVpMohfVTIxVqcKfdiyZTHh7d3lu+9SI46AQ2rU3R388q/PZ8BDyDkK3uzrAXsVUrepSVLcSTMwioq0X32s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588244; c=relaxed/simple;
	bh=0zxxJXgHiMwrGA9ksFPsVAGDLB304wHQk+tQR+oiZIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tABgT6OJ8B6izAfGGz44uMUrdaBamTGsQXbNi3/Bjr+b5x5O2R6UfNGrO8Z+d3O24u/VY/79phqTxcFnsR4y+TRXAiQmmxjyh3ZuqaI3Jo8Pa8sVAtDXbOt3CS/aPkxa7dz52VmmURhAw1YFqqiHSnk0zkkmcXe9wRunKCxYKuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJm3oFSa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJm3oFSa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536F31F00893;
	Mon, 28 Sep 2026 09:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790588243;
	bh=a6Q/SFhUyH3UuxfSHwx5X7V/ejAZIBd0MC8uxeRPsUo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lJm3oFSaXDxoVzpViAiobEPUANGf6KUH9xlbt39HpAkHNvvyVWE5bBYV/d+dgrt3I
	 sfRc8Mo781hYRULJYFKOHIs2RqlMrDwdBL9EAP2S+fbYXL1STc+pK2JtxUbKPMSBnU
	 vNFaZ2jaJic3yPNrMUQ8sXNlmtgcuyDXhtsgyoT7Itp1CElK/dH8PtbGTdS/hyxcrT
	 wAH+9lFmySahS1dEpB2qZWQ/DSbu9h0fdjLT7zZ1Efj0hTHtl+dB3ijY/t49K+MOrw
	 OFPPPb6vSXARiA6R24Cg0i7dre11gVcg7pbhcOb3yHNkkECq6tMkpwX/hwi/FKX9JM
	 cF+wlx7OtLaLw==
Message-ID: <8a76a2e1-0256-4418-9a17-28583f821deb@kernel.org>
Date: Mon, 28 Sep 2026 11:37:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 02/10] net: phy: phy_link_topology: Track
 ports in phy_link_topology
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
 Frank Wunderlich <frank.wunderlich@linux.dev>,
 Pietro Ameruoso <p.ameruoso@live.it>, Aleksei Sviridkin <f@lex.la>
References: <20260927133619.955236-1-maxime.chevallier@bootlin.com>
 <20260927133619.955236-3-maxime.chevallier@bootlin.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260927133619.955236-3-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/09/2026 à 15:36, Maxime Chevallier a écrit :
> phy_port is aimed at representing the various physical interfaces of a
> net_device. They can be controlled by various components in the link,
> such as the Ethernet PHY, the Ethernet MAC, and SFP module, etc.
> 
> Let's therefore make so we keep track of all the ports connected to a
> netdev in phy_link_topology. The only ports added for now are phy-driven
> ports.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Aleksei Sviridkin <f@lex.la>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   drivers/net/phy/phy_device.c        |  3 ++
>   drivers/net/phy/phy_link_topology.c | 53 +++++++++++++++++++++++++++++
>   include/linux/phy_link_topology.h   | 18 ++++++++++
>   include/linux/phy_port.h            |  2 ++
>   net/core/dev.c                      |  1 +
>   5 files changed, 77 insertions(+)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 5b13a74e2fa9..c4d2c03b8282 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1580,6 +1580,9 @@ static void phy_del_port(struct phy_device *phydev, struct phy_port *port)
>   
>   	list_del(&port->head);
>   
> +	if (phydev->attached_dev)
> +		phy_link_topo_del_port(phydev->attached_dev, port);
> +
>   	phydev->n_ports--;
>   }
>   
> diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
> index 0462283c8020..28c5bf3a8849 100644
> --- a/drivers/net/phy/phy_link_topology.c
> +++ b/drivers/net/phy/phy_link_topology.c
> @@ -7,6 +7,7 @@
>    */
>   
>   #include <linux/phy_link_topology.h>
> +#include <linux/phy_port.h>
>   #include <linux/phy.h>
>   #include <linux/rtnetlink.h>
>   #include <linux/xarray.h>
> @@ -23,6 +24,9 @@ static int netdev_alloc_phy_link_topology(struct net_device *dev)
>   	xa_init_flags(&topo->phys, XA_FLAGS_ALLOC1);
>   	topo->next_phy_index = 1;
>   
> +	xa_init_flags(&topo->ports, XA_FLAGS_ALLOC1);
> +	topo->next_port_index = 1;
> +
>   	dev->link_topo = topo;
>   
>   	return 0;
> @@ -56,12 +60,45 @@ static struct phy_link_topology *phy_link_topo_get_or_alloc(struct net_device *d
>   	return dev->link_topo;
>   }
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
> +
>   int phy_link_topo_add_phy(struct net_device *dev,
>   			  struct phy_device *phy,
>   			  enum phy_upstream upt, void *upstream)
>   {
>   	struct phy_link_topology *topo;
>   	struct phy_device_node *pdn;
> +	struct phy_port *port;
>   	int ret;
>   
>   	/* ethtool ops may run without rtnl_lock, and rtnl_lock is what
> @@ -110,8 +147,20 @@ int phy_link_topo_add_phy(struct net_device *dev,
>   	if (ret < 0)
>   		goto err;
>   
> +	/* Add all the PHY's ports to the topology */
> +	list_for_each_entry(port, &phy->ports, head) {
> +		ret = phy_link_topo_add_port(dev, port);
> +		if (ret)
> +			goto del_ports;
> +	}
> +
>   	return 0;
>   
> +del_ports:
> +	list_for_each_entry_continue_reverse(port, &phy->ports, head)
> +		phy_link_topo_del_port(dev, port);
> +
> +	xa_erase(&topo->phys, phy->phyindex);
>   err:
>   	kfree(pdn);
>   	return ret;
> @@ -123,10 +172,14 @@ void phy_link_topo_del_phy(struct net_device *dev,
>   {
>   	struct phy_link_topology *topo = dev->link_topo;
>   	struct phy_device_node *pdn;
> +	struct phy_port *port;
>   
>   	if (!topo)
>   		return;
>   
> +	list_for_each_entry(port, &phy->ports, head)
> +		phy_link_topo_del_port(dev, port);
> +
>   	pdn = xa_erase(&topo->phys, phy->phyindex);
>   
>   	/* We delete the PHY from the topology, however we don't re-set the
> diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h
> index 95575f68d5bc..296ee514ba46 100644
> --- a/include/linux/phy_link_topology.h
> +++ b/include/linux/phy_link_topology.h
> @@ -16,11 +16,15 @@
>   
>   struct xarray;
>   struct phy_device;
> +struct phy_port;
>   struct sfp_bus;
>   
>   struct phy_link_topology {
>   	struct xarray phys;
>   	u32 next_phy_index;
> +
> +	struct xarray ports;
> +	u32 next_port_index;
>   };
>   
>   struct phy_device_node {
> @@ -48,6 +52,9 @@ int phy_link_topo_add_phy(struct net_device *dev,
>   
>   void phy_link_topo_del_phy(struct net_device *dev, struct phy_device *phy);
>   
> +int phy_link_topo_add_port(struct net_device *dev, struct phy_port *port);
> +void phy_link_topo_del_port(struct net_device *dev, struct phy_port *port);
> +
>   static inline struct phy_device *
>   phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
>   {
> @@ -77,6 +84,17 @@ static inline void phy_link_topo_del_phy(struct net_device *dev,
>   {
>   }
>   
> +static inline int phy_link_topo_add_port(struct net_device *dev,
> +					 struct phy_port *port)
> +{
> +	return 0;
> +}
> +
> +static inline void phy_link_topo_del_port(struct net_device *dev,
> +					  struct phy_port *port)
> +{
> +}
> +
>   static inline struct phy_device *
>   phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
>   {
> diff --git a/include/linux/phy_port.h b/include/linux/phy_port.h
> index 0ef0f5ce4709..4e2a3fdd2f2e 100644
> --- a/include/linux/phy_port.h
> +++ b/include/linux/phy_port.h
> @@ -36,6 +36,7 @@ struct phy_port_ops {
>   /**
>    * struct phy_port - A representation of a network device physical interface
>    *
> + * @id: Unique identifier for the port within the topology
>    * @head: Used by the port's parent to list ports
>    * @parent_type: The type of device this port is directly connected to
>    * @phy: If the parent is PHY_PORT_PHYDEV, the PHY controlling that port
> @@ -52,6 +53,7 @@ struct phy_port_ops {
>    * @is_sfp: Indicates if this port drives an SFP cage.
>    */
>   struct phy_port {
> +	u32 id;
>   	struct list_head head;
>   	enum phy_port_parent parent_type;
>   	union {
> diff --git a/net/core/dev.c b/net/core/dev.c
> index f660fccfc0db..97caa6846333 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -11378,6 +11378,7 @@ static void netdev_free_phy_link_topology(struct net_device *dev)
>   
>   	if (IS_ENABLED(CONFIG_PHYLIB) && topo) {
>   		xa_destroy(&topo->phys);
> +		xa_destroy(&topo->ports);
>   		kfree(topo);
>   		dev->link_topo = NULL;
>   	}

