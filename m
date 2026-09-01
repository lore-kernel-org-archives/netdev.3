Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523E44756C6;
	Tue,  1 Sep 2026 09:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788253506; cv=none; b=V11SXM3lUBgu04QsGpBEQhErWn3GqAxajiKto0vV43zIxqlMVK6CZWP7cFx9VJbt5RqLUC5glOwwISY7daoNK4anHpc7LEkr3F2LCqC7Ho8pD2uqoh7TMPeJL9tAQj/BhHTqISFytdN8dHt49BGGiMND5LF+dcyu0emE8FrFETg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788253506; c=relaxed/simple;
	bh=1apKicgNeJwBbNYxwCIxIgOZ0YrTss/jXfuo/icvPgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2UNoRUGdaF0XJMg8v6tQN3plMExl+Yyg0teX7k2YQTiMaELKvNu63W7SF0Bw1yX9tUQYOezOmQ7z3O9gATsxJ2AQtdbvMumgbzbRLFxOzy2at4tOLY2hPm5ylEnkXoMN//cWE7UZef2NXepMBelj4tAKnYx24Fkwp3HgMNfyuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzGXZv8j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzGXZv8j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B78C1F000E9;
	Tue,  1 Sep 2026 09:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788253504;
	bh=/XMj8SB7gF2EzcHa4UQlSJcjIjR+l9jYO95LCw91uhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FzGXZv8j3P4BqKRQXZ37BjqGQosZ4OaRTqzEC5znSXt7EUYIUgAOLCof/73jdGGA6
	 kVC98QGDcYMKPvFV9y8pF3/HggS12Bo9AgkUhbpEoxKY5c6hDaqoI+MakeQkgPNHdn
	 wOGSXlTyndyheuL3UOKbzXVjo7c/86ZBwYJ0A7wMCgtFcQzc8UvwpXyCFSyONY6CNz
	 xfXkC6gSgrObCP0g+CXcrg9jqeG5ozqIfWwXTLaX+Xgi12C1oZ+u/mTL9pH6v1NiUd
	 s5avXjsgaQ4949w+D2mJjuyE5yAPLzQtatODAEg6bJw9BBpZyJxkhUalepi2R5GhhE
	 X7jZkxY/PAuLg==
Date: Tue, 1 Sep 2026 11:05:02 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH net-next v15 12/12] net: airoha: add phylink support
Message-ID: <apaVPm0HtTMQoB_o@lore-desk>
References: <20260901083001.8044-1-ansuelsmth@gmail.com>
 <20260901083001.8044-13-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i6rpTGEmhUZoEfIr"
Content-Disposition: inline
In-Reply-To: <20260901083001.8044-13-ansuelsmth@gmail.com>

--i6rpTGEmhUZoEfIr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Add phylink support for each GDM port. For GDM1 add the internal interface
> mode as the only supported mode. For GDM2/3/4 add the required
> configuration of the PCS to make the external PHY or attached SFP cage
> work.
>=20
> These needs to be defined in the GDM port node using the pcs-handle
> property.
>=20
> Update and provide a .get/set_link_ksettings function that use phylink
> for ethtool OPs now that we fully support phylink.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Just a nit inline. Anyway:
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/ethernet/airoha/Kconfig       |   2 +
>  drivers/net/ethernet/airoha/airoha_eth.c  | 199 +++++++++++++++++++++-
>  drivers/net/ethernet/airoha/airoha_eth.h  |   5 +
>  drivers/net/ethernet/airoha/airoha_regs.h |  12 ++
>  4 files changed, 215 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/Kconfig b/drivers/net/ethernet/a=
iroha/Kconfig
> index 1f6640a15fc9..5c54a07d2a76 100644
> --- a/drivers/net/ethernet/airoha/Kconfig
> +++ b/drivers/net/ethernet/airoha/Kconfig
> @@ -20,6 +20,8 @@ config NET_AIROHA
>  	depends on NET_DSA || !NET_DSA
>  	select NET_AIROHA_NPU
>  	select PAGE_POOL
> +	select PCS_AIROHA
> +	select PHYLINK
>  	help
>  	  This driver supports the gigabit ethernet MACs in the
>  	  Airoha SoC family.
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 64619e9a704d..c3827bf9791b 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -6,6 +6,7 @@
>  #include <linux/of.h>
>  #include <linux/of_net.h>
>  #include <linux/of_reserved_mem.h>
> +#include <linux/pcs/pcs.h>
>  #include <linux/platform_device.h>
>  #include <linux/tcp.h>
>  #include <linux/u64_stats_sync.h>
> @@ -1915,10 +1916,18 @@ static int airoha_dev_open(struct net_device *net=
dev)
>  	struct airoha_qdma *qdma;
>  	int err;
> =20
> +	err =3D phylink_of_phy_connect(dev->phylink, netdev->dev.of_node, 0);
> +	if (err) {
> +		netdev_err(netdev, "could not attach PHY: %d\n", err);
> +		return err;
> +	}
> +
> +	phylink_start(dev->phylink);
> +
>  	netif_tx_start_all_queues(netdev);
>  	err =3D airoha_set_vip_for_gdm_port(dev, true);
>  	if (err)
> -		return err;
> +		goto err_phy_stop;
> =20
>  	qdma =3D airoha_qdma_deref(dev);
>  	if (netdev_uses_dsa(netdev))
> @@ -1938,6 +1947,13 @@ static int airoha_dev_open(struct net_device *netd=
ev)
>  				    pse_port);
> =20
>  	return 0;
> +
> +err_phy_stop:
> +	netif_tx_stop_all_queues(netdev);

nit: we do not need netif_tx_stop_all_queues() since if ndo_open() fails,
     the stack will clear __LINK_STATE_START. Please fix it just if you nee=
d to
     repost.

Regards,
Lorenzo

> +	phylink_stop(dev->phylink);
> +	phylink_disconnect_phy(dev->phylink);
> +
> +	return err;
>  }
> =20
>  static int airoha_dev_stop(struct net_device *netdev)
> @@ -1945,6 +1961,8 @@ static int airoha_dev_stop(struct net_device *netde=
v)
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
>  	struct airoha_gdm_port *port =3D dev->port;
> =20
> +	phylink_stop(dev->phylink);
> +
>  	netif_tx_disable(netdev);
>  	airoha_set_vip_for_gdm_port(dev, false);
> =20
> @@ -1954,6 +1972,9 @@ static int airoha_dev_stop(struct net_device *netde=
v)
>  		airoha_set_gdm_port_fwd_cfg(dev->eth,
>  					    REG_GDM_FWD_CFG(port->id),
>  					    FE_PSE_PORT_DROP);
> +
> +	phylink_disconnect_phy(dev->phylink);
> +
>  	return 0;
>  }
> =20
> @@ -2509,6 +2530,24 @@ airoha_ethtool_get_rmon_stats(struct net_device *n=
etdev,
>  	} while (u64_stats_fetch_retry(&dev->stats.syncp, start));
>  }
> =20
> +static int
> +airoha_ethtool_get_link_ksettings(struct net_device *netdev,
> +				  struct ethtool_link_ksettings *cmd)
> +{
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +
> +	return phylink_ethtool_ksettings_get(dev->phylink, cmd);
> +}
> +
> +static int
> +airoha_ethtool_set_link_ksettings(struct net_device *netdev,
> +				  const struct ethtool_link_ksettings *cmd)
> +{
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +
> +	return phylink_ethtool_ksettings_set(dev->phylink, cmd);
> +}
> +
>  static int airoha_qdma_set_chan_tx_sched(struct net_device *netdev,
>  					 int channel, enum tx_sched_mode mode,
>  					 const u16 *weights, u8 n_weights)
> @@ -3353,7 +3392,8 @@ static const struct ethtool_ops airoha_ethtool_ops =
=3D {
>  	.get_drvinfo		=3D airoha_ethtool_get_drvinfo,
>  	.get_eth_mac_stats      =3D airoha_ethtool_get_mac_stats,
>  	.get_rmon_stats		=3D airoha_ethtool_get_rmon_stats,
> -	.get_link_ksettings	=3D phy_ethtool_get_link_ksettings,
> +	.get_link_ksettings	=3D airoha_ethtool_get_link_ksettings,
> +	.set_link_ksettings	=3D airoha_ethtool_set_link_ksettings,
>  	.get_link		=3D ethtool_op_get_link,
>  };
> =20
> @@ -3409,6 +3449,155 @@ bool airoha_is_valid_gdm_dev(struct airoha_eth *e=
th,
>  	return false;
>  }
> =20
> +/* Nothing to do in MAC, everything is handled in PCS */
> +static void airoha_mac_config(struct phylink_config *config, unsigned in=
t mode,
> +			      const struct phylink_link_state *state)
> +{
> +}
> +
> +static void airoha_mac_link_up(struct phylink_config *config, struct phy=
_device *phy,
> +			       unsigned int mode, phy_interface_t interface,
> +			       int speed, int duplex, bool tx_pause, bool rx_pause)
> +{
> +	struct airoha_gdm_dev *dev =3D container_of(config, struct airoha_gdm_d=
ev,
> +						  phylink_config);
> +	struct airoha_gdm_port *port =3D dev->port;
> +	struct airoha_eth *eth =3D dev->eth;
> +	u32 frag_size_tx, frag_size_rx;
> +
> +	/* TX/RX frag is configured only for GDM4 */
> +	if (port->id !=3D AIROHA_GDM4_IDX)
> +		return;
> +
> +	switch (speed) {
> +	case SPEED_10000:
> +	case SPEED_5000:
> +		frag_size_tx =3D 8;
> +		frag_size_rx =3D 8;
> +		break;
> +	case SPEED_2500:
> +		frag_size_tx =3D 2;
> +		frag_size_rx =3D 1;
> +		break;
> +	default:
> +		frag_size_tx =3D 1;
> +		frag_size_rx =3D 0;
> +		break;
> +	}
> +
> +	mutex_lock(&port->link_lock);
> +
> +	/* Configure TX/RX frag based on speed */
> +	if (dev->nbq =3D=3D 1) {
> +		airoha_fe_rmw(eth, REG_FE_GDM4_TMBI_FRAG,
> +			      GDM4_SGMII1_TX_FRAG_SIZE_MASK,
> +			      FIELD_PREP(GDM4_SGMII1_TX_FRAG_SIZE_MASK,
> +					 frag_size_tx));
> +
> +		airoha_fe_rmw(eth, REG_FE_GDM4_RMBI_FRAG,
> +			      GDM4_SGMII1_RX_FRAG_SIZE_MASK,
> +			      FIELD_PREP(GDM4_SGMII1_RX_FRAG_SIZE_MASK,
> +					 frag_size_rx));
> +	} else {
> +		airoha_fe_rmw(eth, REG_FE_GDM4_TMBI_FRAG,
> +			      GDM4_SGMII0_TX_FRAG_SIZE_MASK,
> +			      FIELD_PREP(GDM4_SGMII0_TX_FRAG_SIZE_MASK,
> +					 frag_size_tx));
> +
> +		airoha_fe_rmw(eth, REG_FE_GDM4_RMBI_FRAG,
> +			      GDM4_SGMII0_RX_FRAG_SIZE_MASK,
> +			      FIELD_PREP(GDM4_SGMII0_RX_FRAG_SIZE_MASK,
> +					 frag_size_rx));
> +	}
> +
> +	mutex_unlock(&port->link_lock);
> +}
> +
> +/* Nothing to do in MAC, everything is handled in PCS */
> +static void airoha_mac_link_down(struct phylink_config *config, unsigned=
 int mode,
> +				 phy_interface_t interface)
> +{
> +}
> +
> +static const struct phylink_mac_ops airoha_phylink_ops =3D {
> +	.mac_config =3D airoha_mac_config,
> +	.mac_link_up =3D airoha_mac_link_up,
> +	.mac_link_down =3D airoha_mac_link_down,
> +};
> +
> +static int airoha_fill_available_pcs(struct phylink_config *config,
> +				     struct phylink_pcs **available_pcs,
> +				     unsigned int num_possible_pcs)
> +{
> +	struct device *dev =3D config->dev;
> +
> +	return fwnode_phylink_pcs_parse(dev_fwnode(dev), available_pcs,
> +					num_possible_pcs);
> +}
> +
> +static int airoha_setup_phylink(struct net_device *netdev)
> +{
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct device_node *np =3D netdev->dev.of_node;
> +	struct airoha_gdm_port *port =3D dev->port;
> +	struct phylink_config *config;
> +	phy_interface_t phy_mode;
> +	struct phylink *phylink;
> +	int err;
> +
> +	err =3D of_get_phy_mode(np, &phy_mode);
> +	if (err) {
> +		dev_err(&netdev->dev, "incorrect phy-mode\n");
> +		return err;
> +	}
> +
> +	config =3D &dev->phylink_config;
> +	config->dev =3D &netdev->dev;
> +	config->type =3D PHYLINK_NETDEV;
> +
> +	/*
> +	 * GDM1 only supports internal for Embedded Switch
> +	 * and doesn't require a PCS.
> +	 */
> +	if (port->id =3D=3D AIROHA_GDM1_IDX) {
> +		config->mac_capabilities =3D MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +					   MAC_10000FD;
> +
> +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +			  config->supported_interfaces);
> +	} else {
> +		config->mac_capabilities =3D MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +					   MAC_10 | MAC_100 | MAC_1000 |
> +					   MAC_2500FD | MAC_5000FD | MAC_10000FD;
> +
> +		config->num_possible_pcs =3D fwnode_phylink_pcs_count(dev_fwnode(confi=
g->dev));
> +		config->fill_available_pcs =3D airoha_fill_available_pcs;
> +
> +		__set_bit(PHY_INTERFACE_MODE_SGMII,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_10GBASER,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_USXGMII,
> +			  config->supported_interfaces);
> +
> +		phy_interface_copy(config->pcs_interfaces,
> +				   config->supported_interfaces);
> +	}
> +
> +	phylink =3D phylink_create(config, of_fwnode_handle(np),
> +				 phy_mode, &airoha_phylink_ops);
> +	if (IS_ERR(phylink))
> +		return PTR_ERR(phylink);
> +
> +	dev->phylink =3D phylink;
> +
> +	return 0;
> +}
> +
>  static int airoha_alloc_gdm_device(struct airoha_eth *eth,
>  				   struct airoha_gdm_port *port,
>  				   int nbq, struct device_node *np)
> @@ -3474,7 +3663,7 @@ static int airoha_alloc_gdm_device(struct airoha_et=
h *eth,
>  	dev->nbq =3D nbq;
>  	port->devs[index] =3D dev;
> =20
> -	return 0;
> +	return airoha_setup_phylink(netdev);
>  }
> =20
>  static int airoha_alloc_gdm_port(struct airoha_eth *eth,
> @@ -3510,6 +3699,7 @@ static int airoha_alloc_gdm_port(struct airoha_eth =
*eth,
> =20
>  	port->id =3D id;
>  	spin_lock_init(&port->stats_lock);
> +	mutex_init(&port->link_lock);
>  	eth->ports[p] =3D port;
> =20
>  	err =3D airoha_metadata_dst_alloc(port);
> @@ -3706,6 +3896,8 @@ static int airoha_probe(struct platform_device *pde=
v)
>  			netdev =3D netdev_from_priv(dev);
>  			if (netdev->reg_state =3D=3D NETREG_REGISTERED)
>  				unregister_netdev(netdev);
> +			if (dev->phylink)
> +				phylink_destroy(dev->phylink);
>  			of_node_put(netdev->dev.of_node);
>  		}
>  		airoha_metadata_dst_free(port);
> @@ -3744,6 +3936,7 @@ static void airoha_remove(struct platform_device *p=
dev)
> =20
>  			netdev =3D netdev_from_priv(dev);
>  			unregister_netdev(netdev);
> +			phylink_destroy(dev->phylink);
>  			of_node_put(netdev->dev.of_node);
>  		}
>  		airoha_metadata_dst_free(port);
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index fa9a8edce22f..83daec003257 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -595,6 +595,9 @@ struct airoha_gdm_dev {
>  	 * QDMA migration.
>  	 */
>  	spinlock_t txq_lock[AIROHA_NUM_NETDEV_TX_RINGS];
> +
> +	struct phylink *phylink;
> +	struct phylink_config phylink_config;
>  };
> =20
>  struct airoha_gdm_port {
> @@ -604,6 +607,8 @@ struct airoha_gdm_port {
> =20
>  	/* protect concurrent hw_stats accesses */
>  	spinlock_t stats_lock;
> +	/* protect concurrent GDM4 register access */
> +	struct mutex link_lock;
> =20
>  	struct metadata_dst *dsa_meta[AIROHA_MAX_DSA_PORTS];
>  };
> diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethe=
rnet/airoha/airoha_regs.h
> index 442b48c9b991..4ea89057b560 100644
> --- a/drivers/net/ethernet/airoha/airoha_regs.h
> +++ b/drivers/net/ethernet/airoha/airoha_regs.h
> @@ -357,6 +357,18 @@
>  #define IP_FRAGMENT_PORT_MASK		GENMASK(8, 5)
>  #define IP_FRAGMENT_NBQ_MASK		GENMASK(4, 0)
> =20
> +#define REG_FE_GDM4_TMBI_FRAG		0x2028
> +#define GDM4_SGMII1_TX_WEIGHT_MASK	GENMASK(31, 26)
> +#define GDM4_SGMII1_TX_FRAG_SIZE_MASK	GENMASK(25, 16)
> +#define GDM4_SGMII0_TX_WEIGHT_MASK	GENMASK(15, 10)
> +#define GDM4_SGMII0_TX_FRAG_SIZE_MASK	GENMASK(9, 0)
> +
> +#define REG_FE_GDM4_RMBI_FRAG		0x202c
> +#define GDM4_SGMII1_RX_WEIGHT_MASK	GENMASK(31, 26)
> +#define GDM4_SGMII1_RX_FRAG_SIZE_MASK	GENMASK(25, 16)
> +#define GDM4_SGMII0_RX_WEIGHT_MASK	GENMASK(15, 10)
> +#define GDM4_SGMII0_RX_FRAG_SIZE_MASK	GENMASK(9, 0)
> +
>  #define REG_MC_VLAN_EN			0x2100
>  #define MC_VLAN_EN_MASK			BIT(0)
> =20
> --=20
> 2.53.0
>=20

--i6rpTGEmhUZoEfIr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCapaVPgAKCRA6cBh0uS2t
rBVQAQCmjTLkJUdTbYTkUnn1MmLnK6T/b/g0Oc0cPGNFOJfepwEAgsyqen1FSjft
sznuegT+i6FACzC7OAMI680COfjUBgg=
=YjnW
-----END PGP SIGNATURE-----

--i6rpTGEmhUZoEfIr--
