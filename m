Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C97F377ED7;
	Fri,  7 Aug 2026 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786094604; cv=none; b=fmloAyf4jFQgE7XdAcX4dLgDAwb+cXS6oMkZFsmYB1J/oWS2hNxQeg1/Avf8/+2iQl5xKQLSGcvWS5BGqCveYUZ82uzFQRMPVIyqP1f3CV8GqTqz9b4FIkhgCvDO7YYb50jJns2z3qRuEb1wlFPV6Q0ACwTSuMdtGT2BBI52iGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786094604; c=relaxed/simple;
	bh=OKTUlHumXiL4yjEAPiKA7xySXGmD4XZ7MwraHs2v7Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8bFJUNd9vERQD+xyQHsBm2AAHpzzSyBp64UMTfE2WJWrfNBYlLpfgo9w3TYHdWsT9L2fShUN1WKOwpzd3R2QgjY8tIsaPmPJ80Oij6s23fCTg6Kk1cAyUaEajRa3BlVeCLEOmvLxEE9CB4FXjowbyGa+ywED/86iIkFS7mDyNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgegLwUF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgegLwUF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9992D1F00A3A;
	Fri,  7 Aug 2026 09:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786094603;
	bh=YQQIIcoVDl4XGLckZltIX3NSmdGB/0glURatR93oa2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NgegLwUFkoTqxCVOO/B4Nub71rLTKzrgcr6TO3DDEzYVt7r8TYWEHvv0cjcj0BObQ
	 WnHGEh9STRKzTEQ8nrJF+y54OB6Y4+RO1FZzeHfaPeaWUSiffZRhy9LZoha5j7Kqcj
	 Y9/kQsSLAuFGJE0CN5BMdqWJbRwKexB9oiT3Vxxi8RC0P7q0zdaOymDXSuBbHfS3HR
	 CymnSwluqN5ylBVlVL7atPdJuwP1TaCnQkGNJ5TDVTwvYMznYy1idFVdKt0KJgqV/9
	 nWnufbzxd4lrKqVppH7f8zopI4JI3FtMVHUsWLjZiuZYCOTWacfUujEM29aZ5Y2/U+
	 hfrlBkigYTf0A==
Date: Fri, 7 Aug 2026 11:23:20 +0200
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
Subject: Re: [PATCH net-next v10 11/11] net: airoha: add phylink support
Message-ID: <anWkCLIp9NxIJJec@lore-desk>
References: <20260730102444.1967900-1-ansuelsmth@gmail.com>
 <20260730102444.1967900-12-ansuelsmth@gmail.com>
 <ams72wEsCiACYh-k@lore-desk>
 <6a74c0c2.1c04d3ff.d716d.a9f0@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8p7i5PObBPdgE3my"
Content-Disposition: inline
In-Reply-To: <6a74c0c2.1c04d3ff.d716d.a9f0@mx.google.com>

--8p7i5PObBPdgE3my
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Jul 30, 2026 at 01:56:11PM +0200, Lorenzo Bianconi wrote:
> > > Add phylink support for each GDM port. For GDM1 add the internal inte=
rface
> > > mode as the only supported mode. For GDM2/3/4 add the required
> > > configuration of the PCS to make the external PHY or attached SFP cage
> > > work.
> > >=20
> > > These needs to be defined in the GDM port node using the pcs-handle
> > > property.
> > >=20
> > > Update and provide a .get/set_link_ksettings function that use phylink
> > > for ethtool OPs now that we fully support phylink.
> > >=20
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> >=20
> > Hi Christian,
> >=20
> > just some nits inline. Fixing them:
> >=20
> > Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >=20
> > Regards,
> > Lorenzo
> >=20
> > > ---
> > >  drivers/net/ethernet/airoha/Kconfig       |   1 +
> > >  drivers/net/ethernet/airoha/airoha_eth.c  | 189 ++++++++++++++++++++=
+-
> > >  drivers/net/ethernet/airoha/airoha_eth.h  |   5 +
> > >  drivers/net/ethernet/airoha/airoha_regs.h |  12 ++
> > >  4 files changed, 205 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/net/ethernet/airoha/Kconfig b/drivers/net/ethern=
et/airoha/Kconfig
> > > index 1f6640a15fc9..789906516bf8 100644
> > > --- a/drivers/net/ethernet/airoha/Kconfig
> > > +++ b/drivers/net/ethernet/airoha/Kconfig
> > > @@ -20,6 +20,7 @@ config NET_AIROHA
> > >  	depends on NET_DSA || !NET_DSA
> > >  	select NET_AIROHA_NPU
> > >  	select PAGE_POOL
> > > +	select PHYLINK
> > >  	help
> > >  	  This driver supports the gigabit ethernet MACs in the
> > >  	  Airoha SoC family.
> > > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/e=
thernet/airoha/airoha_eth.c
> > > index dba7c52c0896..5065d6583b9f 100644
> > > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > > @@ -8,6 +8,7 @@
> > >  #include <linux/of_reserved_mem.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/tcp.h>
> > > +#include <linux/pcs/pcs.h>
> >=20
> > nit: alphabetic order.
> >=20
> > >  #include <linux/u64_stats_sync.h>
> > >  #include <net/dst_metadata.h>
> > >  #include <net/page_pool/helpers.h>
> > > @@ -1915,6 +1916,14 @@ static int airoha_dev_open(struct net_device *=
netdev)
> > >  	struct airoha_qdma *qdma;
> > >  	int err;
> > > =20
> > > +	err =3D phylink_of_phy_connect(dev->phylink, netdev->dev.of_node, 0=
);
> > > +	if (err) {
> > > +		netdev_err(netdev, "could not attach PHY: %d\n", err);
> > > +		return err;
> > > +	}
> > > +
> > > +	phylink_start(dev->phylink);
> >=20
> > Should it be last operation in airoha_dev_open()?
> >
>=20
> I checked also other ethernet driver for this pattern and it seems
> phylink_start is always called before any netif_start_queues.
>=20
> I'm addressing all the other suggestion and adding the Ack if you are ok
> with keeping this as is.

sure, I am fine with that.

Regards,
Lorenzo

> =20
> > > +
> > >  	netif_tx_start_all_queues(netdev);
> > >  	err =3D airoha_set_vip_for_gdm_port(dev, true);
> > >  	if (err)
> > > @@ -1954,6 +1963,10 @@ static int airoha_dev_stop(struct net_device *=
netdev)
> > >  		airoha_set_gdm_port_fwd_cfg(dev->eth,
> > >  					    REG_GDM_FWD_CFG(port->id),
> > >  					    FE_PSE_PORT_DROP);
> > > +
> > > +	phylink_stop(dev->phylink);
> >=20
> > Should it be the first one? (reverse order of airoha_dev_open()).
> >=20
> > > +	phylink_disconnect_phy(dev->phylink);
> > > +
> > >  	return 0;
> > >  }
> > > =20
> > > @@ -2509,6 +2522,24 @@ airoha_ethtool_get_rmon_stats(struct net_devic=
e *netdev,
> > >  	} while (u64_stats_fetch_retry(&dev->stats.syncp, start));
> > >  }
> > > =20
> > > +static int
> > > +airoha_ethtool_get_link_ksettings(struct net_device *netdev,
> > > +				  struct ethtool_link_ksettings *cmd)
> > > +{
> > > +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> > > +
> > > +	return phylink_ethtool_ksettings_get(dev->phylink, cmd);
> > > +}
> > > +
> > > +static int
> > > +airoha_ethtool_set_link_ksettings(struct net_device *netdev,
> > > +				  const struct ethtool_link_ksettings *cmd)
> > > +{
> > > +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> > > +
> > > +	return phylink_ethtool_ksettings_set(dev->phylink, cmd);
> > > +}
> > > +
> > >  static int airoha_qdma_set_chan_tx_sched(struct net_device *netdev,
> > >  					 int channel, enum tx_sched_mode mode,
> > >  					 const u16 *weights, u8 n_weights)
> > > @@ -3353,7 +3384,8 @@ static const struct ethtool_ops airoha_ethtool_=
ops =3D {
> > >  	.get_drvinfo		=3D airoha_ethtool_get_drvinfo,
> > >  	.get_eth_mac_stats      =3D airoha_ethtool_get_mac_stats,
> > >  	.get_rmon_stats		=3D airoha_ethtool_get_rmon_stats,
> > > -	.get_link_ksettings	=3D phy_ethtool_get_link_ksettings,
> > > +	.get_link_ksettings	=3D airoha_ethtool_get_link_ksettings,
> > > +	.set_link_ksettings	=3D airoha_ethtool_set_link_ksettings,
> > >  	.get_link		=3D ethtool_op_get_link,
> > >  };
> > > =20
> > > @@ -3409,6 +3441,155 @@ bool airoha_is_valid_gdm_dev(struct airoha_et=
h *eth,
> > >  	return false;
> > >  }
> > > =20
> > > +/* Nothing to do in MAC, everything is handled in PCS */
> > > +static void airoha_mac_config(struct phylink_config *config, unsigne=
d int mode,
> > > +			      const struct phylink_link_state *state)
> > > +{
> > > +}
> > > +
> > > +static void airoha_mac_link_up(struct phylink_config *config, struct=
 phy_device *phy,
> > > +			       unsigned int mode, phy_interface_t interface,
> > > +			       int speed, int duplex, bool tx_pause, bool rx_pause)
> > > +{
> > > +	struct airoha_gdm_dev *dev =3D container_of(config, struct airoha_g=
dm_dev,
> > > +						  phylink_config);
> > > +	struct airoha_gdm_port *port =3D dev->port;
> > > +	struct airoha_eth *eth =3D dev->eth;
> > > +	u32 frag_size_tx, frag_size_rx;
> > > +	u32 mask, val;
> > > +
> > > +	/* TX/RX frag is configured only for GDM4 */
> > > +	if (port->id !=3D AIROHA_GDM4_IDX)
> > > +		return;
> > > +
> > > +	switch (speed) {
> > > +	case SPEED_10000:
> > > +	case SPEED_5000:
> > > +		frag_size_tx =3D 8;
> > > +		frag_size_rx =3D 8;
> > > +		break;
> > > +	case SPEED_2500:
> > > +		frag_size_tx =3D 2;
> > > +		frag_size_rx =3D 1;
> > > +		break;
> > > +	default:
> > > +		frag_size_tx =3D 1;
> > > +		frag_size_rx =3D 0;
> >=20
> > Missing break here.
> >=20
> > > +	}
> > > +
> > > +	mutex_lock(&port->reg_lock);
> > > +
> > > +	/* Configure TX/RX frag based on speed */
> > > +	if (dev->nbq =3D=3D 1) {
> > > +		mask =3D GDM4_SGMII1_TX_FRAG_SIZE_MASK;
> > > +		val =3D FIELD_PREP(GDM4_SGMII1_TX_FRAG_SIZE_MASK,
> > > +				 frag_size_tx);
> > > +	}  else {
> > > +		mask =3D GDM4_SGMII0_TX_FRAG_SIZE_MASK;
> > > +		val =3D FIELD_PREP(GDM4_SGMII0_TX_FRAG_SIZE_MASK,
> > > +				 frag_size_tx);
> > > +	}
> > > +	airoha_fe_rmw(eth, REG_FE_GDM4_TMBI_FRAG, mask, val);
> > > +
> > > +	if (dev->nbq =3D=3D 1) {
> > > +		mask =3D GDM4_SGMII1_RX_FRAG_SIZE_MASK;
> > > +		val =3D FIELD_PREP(GDM4_SGMII1_RX_FRAG_SIZE_MASK,
> > > +				 frag_size_rx);
> > > +	} else {
> > > +		mask =3D GDM4_SGMII0_RX_FRAG_SIZE_MASK;
> > > +		val =3D FIELD_PREP(GDM4_SGMII0_RX_FRAG_SIZE_MASK,
> > > +				 frag_size_rx);
> > > +	}
> > > +	airoha_fe_rmw(eth, REG_FE_GDM4_RMBI_FRAG, mask, val);
> >=20
> > nit: I guess you can have just one if/else block here running airoha_fe=
_rmw()
> > inside the block and getting rid of val/mask.
> >=20
> > > +
> > > +	mutex_unlock(&port->reg_lock);
> > > +}
> > > +
> > > +/* Nothing to do in MAC, everything is handled in PCS */
> > > +static void airoha_mac_link_down(struct phylink_config *config, unsi=
gned int mode,
> > > +				 phy_interface_t interface)
> > > +{
> > > +}
> > > +
> > > +static const struct phylink_mac_ops airoha_phylink_ops =3D {
> > > +	.mac_config =3D airoha_mac_config,
> > > +	.mac_link_up =3D airoha_mac_link_up,
> > > +	.mac_link_down =3D airoha_mac_link_down,
> > > +};
> > > +
> > > +static int airoha_fill_available_pcs(struct phylink_config *config,
> > > +				     struct phylink_pcs **available_pcs,
> > > +				     unsigned int num_possible_pcs)
> > > +{
> > > +	struct device *dev =3D config->dev;
> > > +
> > > +	return fwnode_phylink_pcs_parse(dev_fwnode(dev), available_pcs,
> > > +					num_possible_pcs);
> > > +}
> > > +
> > > +static int airoha_setup_phylink(struct net_device *netdev)
> > > +{
> > > +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> > > +	struct device_node *np =3D netdev->dev.of_node;
> > > +	struct airoha_gdm_port *port =3D dev->port;
> > > +	struct phylink_config *config;
> > > +	phy_interface_t phy_mode;
> > > +	struct phylink *phylink;
> > > +	int err;
> > > +
> > > +	err =3D of_get_phy_mode(np, &phy_mode);
> > > +	if (err) {
> > > +		dev_err(&netdev->dev, "incorrect phy-mode\n");
> > > +		return err;
> > > +	}
> > > +
> > > +	config =3D &dev->phylink_config;
> > > +	config->dev =3D &netdev->dev;
> > > +	config->type =3D PHYLINK_NETDEV;
> > > +
> > > +	/*
> > > +	 * GDM1 only supports internal for Embedded Switch
> > > +	 * and doesn't require a PCS.
> > > +	 */
> > > +	if (port->id =3D=3D AIROHA_GDM1_IDX) {
> > > +		config->mac_capabilities =3D MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> > > +					   MAC_10000FD;
> > > +
> > > +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> > > +			  config->supported_interfaces);
> > > +	} else {
> > > +		config->mac_capabilities =3D MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> > > +					   MAC_10 | MAC_100 | MAC_1000 |
> > > +					   MAC_2500FD | MAC_5000FD | MAC_10000FD;
> > > +
> > > +		config->num_possible_pcs =3D fwnode_phylink_pcs_count(dev_fwnode(c=
onfig->dev));
> > > +		config->fill_available_pcs =3D airoha_fill_available_pcs;
> > > +
> > > +		__set_bit(PHY_INTERFACE_MODE_SGMII,
> > > +			  config->supported_interfaces);
> > > +		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> > > +			  config->supported_interfaces);
> > > +		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> > > +			  config->supported_interfaces);
> > > +		__set_bit(PHY_INTERFACE_MODE_10GBASER,
> > > +			  config->supported_interfaces);
> > > +		__set_bit(PHY_INTERFACE_MODE_USXGMII,
> > > +			  config->supported_interfaces);
> > > +
> > > +		phy_interface_copy(config->pcs_interfaces,
> > > +				   config->supported_interfaces);
> > > +	}
> > > +
> > > +	phylink =3D phylink_create(config, of_fwnode_handle(np),
> > > +				 phy_mode, &airoha_phylink_ops);
> > > +	if (IS_ERR(phylink))
> > > +		return PTR_ERR(phylink);
> > > +
> > > +	dev->phylink =3D phylink;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static int airoha_alloc_gdm_device(struct airoha_eth *eth,
> > >  				   struct airoha_gdm_port *port,
> > >  				   int nbq, struct device_node *np)
> > > @@ -3474,7 +3655,7 @@ static int airoha_alloc_gdm_device(struct airoh=
a_eth *eth,
> > >  	dev->nbq =3D nbq;
> > >  	port->devs[index] =3D dev;
> > > =20
> > > -	return 0;
> > > +	return airoha_setup_phylink(netdev);
> > >  }
> > > =20
> > >  static int airoha_alloc_gdm_port(struct airoha_eth *eth,
> > > @@ -3510,6 +3691,7 @@ static int airoha_alloc_gdm_port(struct airoha_=
eth *eth,
> > > =20
> > >  	port->id =3D id;
> > >  	spin_lock_init(&port->stats_lock);
> > > +	mutex_init(&port->reg_lock);
> > >  	eth->ports[p] =3D port;
> > > =20
> > >  	err =3D airoha_metadata_dst_alloc(port);
> > > @@ -3706,6 +3888,8 @@ static int airoha_probe(struct platform_device =
*pdev)
> > >  			netdev =3D netdev_from_priv(dev);
> > >  			if (netdev->reg_state =3D=3D NETREG_REGISTERED)
> > >  				unregister_netdev(netdev);
> > > +			if (dev->phylink)
> > > +				phylink_destroy(dev->phylink);
> > >  			of_node_put(netdev->dev.of_node);
> > >  		}
> > >  		airoha_metadata_dst_free(port);
> > > @@ -3744,6 +3928,7 @@ static void airoha_remove(struct platform_devic=
e *pdev)
> > > =20
> > >  			netdev =3D netdev_from_priv(dev);
> > >  			unregister_netdev(netdev);
> > > +			phylink_destroy(dev->phylink);
> > >  			of_node_put(netdev->dev.of_node);
> > >  		}
> > >  		airoha_metadata_dst_free(port);
> > > diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/e=
thernet/airoha/airoha_eth.h
> > > index fa9a8edce22f..6396a5aec384 100644
> > > --- a/drivers/net/ethernet/airoha/airoha_eth.h
> > > +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> > > @@ -595,6 +595,9 @@ struct airoha_gdm_dev {
> > >  	 * QDMA migration.
> > >  	 */
> > >  	spinlock_t txq_lock[AIROHA_NUM_NETDEV_TX_RINGS];
> > > +
> > > +	struct phylink *phylink;
> > > +	struct phylink_config phylink_config;
> > >  };
> > > =20
> > >  struct airoha_gdm_port {
> > > @@ -604,6 +607,8 @@ struct airoha_gdm_port {
> > > =20
> > >  	/* protect concurrent hw_stats accesses */
> > >  	spinlock_t stats_lock;
> > > +	/* protect concurrent GDM4 register access */
> > > +	struct mutex reg_lock;
> >=20
> > nit: naming is always hard, maybe link_lock?
> >=20
> > > =20
> > >  	struct metadata_dst *dsa_meta[AIROHA_MAX_DSA_PORTS];
> > >  };
> > > diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/=
ethernet/airoha/airoha_regs.h
> > > index 442b48c9b991..4ea89057b560 100644
> > > --- a/drivers/net/ethernet/airoha/airoha_regs.h
> > > +++ b/drivers/net/ethernet/airoha/airoha_regs.h
> > > @@ -357,6 +357,18 @@
> > >  #define IP_FRAGMENT_PORT_MASK		GENMASK(8, 5)
> > >  #define IP_FRAGMENT_NBQ_MASK		GENMASK(4, 0)
> > > =20
> > > +#define REG_FE_GDM4_TMBI_FRAG		0x2028
> > > +#define GDM4_SGMII1_TX_WEIGHT_MASK	GENMASK(31, 26)
> > > +#define GDM4_SGMII1_TX_FRAG_SIZE_MASK	GENMASK(25, 16)
> > > +#define GDM4_SGMII0_TX_WEIGHT_MASK	GENMASK(15, 10)
> > > +#define GDM4_SGMII0_TX_FRAG_SIZE_MASK	GENMASK(9, 0)
> > > +
> > > +#define REG_FE_GDM4_RMBI_FRAG		0x202c
> > > +#define GDM4_SGMII1_RX_WEIGHT_MASK	GENMASK(31, 26)
> > > +#define GDM4_SGMII1_RX_FRAG_SIZE_MASK	GENMASK(25, 16)
> > > +#define GDM4_SGMII0_RX_WEIGHT_MASK	GENMASK(15, 10)
> > > +#define GDM4_SGMII0_RX_FRAG_SIZE_MASK	GENMASK(9, 0)
> > > +
> > >  #define REG_MC_VLAN_EN			0x2100
> > >  #define MC_VLAN_EN_MASK			BIT(0)
> > > =20
> > > --=20
> > > 2.53.0
> > >=20
>=20
>=20
>=20
> --=20
> 	Ansuel

--8p7i5PObBPdgE3my
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCanWkCAAKCRA6cBh0uS2t
rAhhAP9ChrPJx+1KRMSesbgkCVk3ak6QiDvF6BcAQyS3S0qaowD8CZUfTR7MH4LZ
JV7nKPw+7/veEL5G2Dz2LvFxWGJ+yAg=
=SJXp
-----END PGP SIGNATURE-----

--8p7i5PObBPdgE3my--
