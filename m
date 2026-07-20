Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B34F388E42;
	Mon, 20 Jul 2026 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784561761; cv=none; b=NO/slYBY973oFzQiLWXlOQUBRDng02voVPXZFXgsKYUEVmBZ5UEzUX9WJtZ4ymQtT8zmk79XxaeHBm+VeDphZZAhGv/5ahBaNr/Dy0dD/eNb/ptv3vWagU37jUHoZ/KqDI4OE768xg0Bo4WLoqvGYKSVoBgNNWFWeN1xR4UGvSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784561761; c=relaxed/simple;
	bh=HzozHSiIqOVgYsoYwuzietJUVM3v7XOEgA5+ryBKhiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5jLivFZ9aShtb84Vzynf0Qnyb+2F4eEYI1bbQd+XfuKcjNfjwSp0iA4mcquTjHBaUEDGwGRcvb9kniwoyPTlbOU+c9dFf/56e7TdpNNtfdPgEOoz+VASvg51CLBvAFWmC7dyyWkAFYhPbE9qXlPDMimX9KUP+e9H1aHPeBNdeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCSPhkym; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCSPhkym"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277F51F000E9;
	Mon, 20 Jul 2026 15:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784561750;
	bh=VB3hSs3IM1kNjFNQVKVjcNLxy/gsZs2wcShzQpskPaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NCSPhkymZIyD1HmeYXvYKO2XxeTKj4zamgwTuj43z1DRAlUnXnm5nuv3j7eKF4EQs
	 +rQDzU8ergDSkSWTw1JY8GUxO/V8aNFK/GDLA6XDtdvaqDsGjtv43O2qoU3DvgVMM6
	 gfDAMcn19SLJhvbK1R0R+H5CXGMgLIPd4hIgZRb+SGd28SxtURQ+HMuYBQ6T4Nt2GT
	 RL0XOQlgyRRfnTykZ/cW9ElFVWIy1u8M3gLU9m6GSo7jWybUrRzER/5W8HkA2uyDBk
	 WAOflpelUFoAAp28Pu9D6uhbYERsVOf3nLAtfffHGLzVyNrd1b/0TzwbiMD4PYI/Ok
	 tCo/UMnBnt9aA==
Date: Mon, 20 Jul 2026 17:35:48 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v9 12/12] net: airoha: add phylink support
Message-ID: <al5AVLxWRhnpGzJ1@lore-desk>
References: <20260717065448.1498335-1-ansuelsmth@gmail.com>
 <20260717065448.1498335-13-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t3fO2M3wqEE3d+IM"
Content-Disposition: inline
In-Reply-To: <20260717065448.1498335-13-ansuelsmth@gmail.com>

--t3fO2M3wqEE3d+IM
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
> ---
>  drivers/net/ethernet/airoha/Kconfig       |   1 +
>  drivers/net/ethernet/airoha/airoha_eth.c  | 194 +++++++++++++++++++++-
>  drivers/net/ethernet/airoha/airoha_eth.h  |   7 +-
>  drivers/net/ethernet/airoha/airoha_regs.h |  12 ++
>  4 files changed, 207 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/Kconfig b/drivers/net/ethernet/a=
iroha/Kconfig
> index 1f6640a15fc9..789906516bf8 100644
> --- a/drivers/net/ethernet/airoha/Kconfig
> +++ b/drivers/net/ethernet/airoha/Kconfig
> @@ -20,6 +20,7 @@ config NET_AIROHA
>  	depends on NET_DSA || !NET_DSA
>  	select NET_AIROHA_NPU
>  	select PAGE_POOL
> +	select PHYLINK
>  	help
>  	  This driver supports the gigabit ethernet MACs in the
>  	  Airoha SoC family.
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 59001fd4b6f7..ed1ac032f337 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -8,6 +8,7 @@
>  #include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/tcp.h>
> +#include <linux/pcs/pcs.h>
>  #include <linux/u64_stats_sync.h>
>  #include <net/dst_metadata.h>
>  #include <net/page_pool/helpers.h>
> @@ -1837,7 +1838,7 @@ static void airoha_update_hw_stats(struct airoha_gd=
m_dev *dev)
>  	struct airoha_gdm_port *port =3D dev->port;
>  	int i;
> =20
> -	spin_lock(&port->stats_lock);
> +	spin_lock(&port->lock);

Hi Christian,

as pointed out in a previous email, I do not like the approach of reusing t=
his
spin_lock for airoha_mac_link_up(). Can we use rtl_lock() (when necessary) =
as
pointed out before?

Regards,
Lorenzo

> =20
>  	for (i =3D 0; i < ARRAY_SIZE(port->devs); i++) {
>  		if (port->devs[i])
> @@ -1848,7 +1849,7 @@ static void airoha_update_hw_stats(struct airoha_gd=
m_dev *dev)
>  	airoha_fe_set(dev->eth, REG_FE_GDM_MIB_CLEAR(port->id),
>  		      FE_GDM_MIB_RX_CLEAR_MASK | FE_GDM_MIB_TX_CLEAR_MASK);
> =20
> -	spin_unlock(&port->stats_lock);
> +	spin_unlock(&port->lock);
>  }
> =20
>  static void airoha_dev_set_xmit_frame_size(struct net_device *netdev)
> @@ -1870,6 +1871,14 @@ static int airoha_dev_open(struct net_device *netd=
ev)
>  	u32 pse_port =3D FE_PSE_PORT_PPE1;
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
> @@ -1909,6 +1918,10 @@ static int airoha_dev_stop(struct net_device *netd=
ev)
>  		airoha_set_gdm_port_fwd_cfg(qdma->eth,
>  					    REG_GDM_FWD_CFG(port->id),
>  					    FE_PSE_PORT_DROP);
> +
> +	phylink_stop(dev->phylink);
> +	phylink_disconnect_phy(dev->phylink);
> +
>  	return 0;
>  }
> =20
> @@ -2389,6 +2402,24 @@ airoha_ethtool_get_rmon_stats(struct net_device *n=
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
> @@ -3120,7 +3151,8 @@ static const struct ethtool_ops airoha_ethtool_ops =
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
> @@ -3176,6 +3208,155 @@ bool airoha_is_valid_gdm_dev(struct airoha_eth *e=
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
> +	u32 mask, val;
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
> +	}
> +
> +	spin_lock(&port->lock);
> +
> +	/* Configure TX/RX frag based on speed */
> +	if (dev->nbq =3D=3D 1) {
> +		mask =3D GDM4_SGMII1_TX_FRAG_SIZE_MASK;
> +		val =3D FIELD_PREP(GDM4_SGMII1_TX_FRAG_SIZE_MASK,
> +				 frag_size_tx);
> +	}  else {
> +		mask =3D GDM4_SGMII0_TX_FRAG_SIZE_MASK;
> +		val =3D FIELD_PREP(GDM4_SGMII0_TX_FRAG_SIZE_MASK,
> +				 frag_size_tx);
> +	}
> +	airoha_fe_rmw(eth, REG_FE_GDM4_TMBI_FRAG, mask, val);
> +
> +	if (dev->nbq =3D=3D 1) {
> +		mask =3D GDM4_SGMII1_RX_FRAG_SIZE_MASK;
> +		val =3D FIELD_PREP(GDM4_SGMII1_RX_FRAG_SIZE_MASK,
> +				 frag_size_rx);
> +	} else {
> +		mask =3D GDM4_SGMII0_RX_FRAG_SIZE_MASK;
> +		val =3D FIELD_PREP(GDM4_SGMII0_RX_FRAG_SIZE_MASK,
> +				 frag_size_rx);
> +	}
> +	airoha_fe_rmw(eth, REG_FE_GDM4_RMBI_FRAG, mask, val);
> +
> +	spin_unlock(&port->lock);
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
> @@ -3239,7 +3420,7 @@ static int airoha_alloc_gdm_device(struct airoha_et=
h *eth,
>  	dev->nbq =3D nbq;
>  	port->devs[index] =3D dev;
> =20
> -	return 0;
> +	return airoha_setup_phylink(netdev);
>  }
> =20
>  static int airoha_alloc_gdm_port(struct airoha_eth *eth,
> @@ -3274,7 +3455,7 @@ static int airoha_alloc_gdm_port(struct airoha_eth =
*eth,
>  		return -ENOMEM;
> =20
>  	port->id =3D id;
> -	spin_lock_init(&port->stats_lock);
> +	spin_lock_init(&port->lock);
>  	eth->ports[p] =3D port;
> =20
>  	err =3D airoha_metadata_dst_alloc(port);
> @@ -3471,6 +3652,8 @@ static int airoha_probe(struct platform_device *pde=
v)
>  			netdev =3D netdev_from_priv(dev);
>  			if (netdev->reg_state =3D=3D NETREG_REGISTERED)
>  				unregister_netdev(netdev);
> +			if (dev->phylink)
> +				phylink_destroy(dev->phylink);
>  			of_node_put(netdev->dev.of_node);
>  		}
>  		airoha_metadata_dst_free(port);
> @@ -3509,6 +3692,7 @@ static void airoha_remove(struct platform_device *p=
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
> index f6d01a8e8da1..b49fc5304b3a 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -561,6 +561,9 @@ struct airoha_gdm_dev {
>  	int nbq;
> =20
>  	struct airoha_hw_stats stats;
> +
> +	struct phylink *phylink;
> +	struct phylink_config phylink_config;
>  };
> =20
>  struct airoha_gdm_port {
> @@ -568,8 +571,8 @@ struct airoha_gdm_port {
>  	int id;
>  	int users;
> =20
> -	/* protect concurrent hw_stats accesses */
> -	spinlock_t stats_lock;
> +	/* protect concurrent hw_stats and frag register accesses */
> +	spinlock_t lock;
> =20
>  	struct metadata_dst *dsa_meta[AIROHA_MAX_DSA_PORTS];
>  };
> diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethe=
rnet/airoha/airoha_regs.h
> index 6fed63d013b4..8df02f51211c 100644
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

--t3fO2M3wqEE3d+IM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCal5AVAAKCRA6cBh0uS2t
rHsqAP9ESZRRfa+r2Y1vfJpHdUqnA90AdRiYIarQTTJtea9AqgEA/i7Yzvlpb9RO
FuH3PVWNhM7fi/J6pbVJwpuXH93BaQk=
=f+O+
-----END PGP SIGNATURE-----

--t3fO2M3wqEE3d+IM--
