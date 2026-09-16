Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8E34FDE6B;
	Wed, 16 Sep 2026 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566336; cv=none; b=oMGWJzZjPgNWth1g9pGKS6tMd3bDKRmRwNbfk5/MCLCHIhUcc6hYKHvGbzkkKlmpHySuBLMoGP/mp/rkdV1x0ebcXtIFMLcrVUuwcJskvoRG9DtIpfY9CJx9yhk3WvuUGQZGrm75lzeLRX89G3rX64Qq7IlYU59hAmANmvC+L1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566336; c=relaxed/simple;
	bh=/LNr26teQFtm4DiMGFdRchReCVIeUUwiVJkiIz5uEIA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqNmUTLCjBGNFenUKuVMvjQfITr3/qQ4kIznem05+wpqLKVka6kk9ORj6Ug/LBaumm7qQQBNHnajqs6MNtcob5GtnP527RXGJPzTV6G5Ohi54nDwdcFLq7BRbWtU+OJdzi6kgMhttLPzNGIN9VVStktuWCEvRXKZERyzKsE90Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airoha.com; spf=pass smtp.mailfrom=airoha.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DlaEo+Lx; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airoha.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airoha.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DlaEo+Lx"
X-UUID: d7e5bad6b1d411f18dc8c9802ae25ab1-20260916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:CC:To:From:Date; bh=Ur21vGZjFEaXGQGVl1ymEBShpak0h6eYuaOGDEy6bqw=;
	b=DlaEo+LxkSG4pI352czj3D2m28avaKZ58wIprEDYkyEH1CGoyxFRH3be+/Pza1T4YwvCNJf7azAg4d4tGtTdNO5IQPwjnB3kSr8wAHIu7Y6AyixhfBv6RJ0Yh6DWOc932KgrfFjcRX7VmQ9kXTNVRuuQ0a5HbmifdqxRb3HiaLE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:a6b7b445-d3dd-457d-a99a-f431774d5348,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:1c3fb217-e22c-471e-b84b-524d9ae72460,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|136|836|865|888|898,TC:-5,Cont
	ent:0|15|50|99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:
	-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d7e5bad6b1d411f18dc8c9802ae25ab1-20260916
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <zhengping.zhang@airoha.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 251038336; Wed, 16 Sep 2026 21:45:13 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 16 Sep 2026 21:45:12 +0800
Received: from mediatek.com (172.18.153.129) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.2562.29 via Frontend
 Transport; Wed, 16 Sep 2026 21:45:12 +0800
Date: Wed, 16 Sep 2026 21:45:12 +0800
From: Zhengping Zhang <zhengping.zhang@airoha.com>
To: Christian Marangi <ansuelsmth@gmail.com>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
	<justinstitt@google.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <llvm@lists.linux.dev>,
	<yalei.zang@airoha.com>, <lei.dong@airoha.com>
Subject: Re: [PATCH net-next v15 12/12] net: airoha: add phylink support
Message-ID: <aqqdaMsN1NndJdSI@mediatek.com>
References: <20260901083001.8044-1-ansuelsmth@gmail.com>
 <20260901083001.8044-13-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260901083001.8044-13-ansuelsmth@gmail.com>
X-MTK: N

Tested-by: Zhengping Zhang <zhengping.zhang@airoha.com>

Tested on an AN7581 board with AN8831 USXGMII PHY at GDM2/4;
the link came up at 10G.

On Tue, Sep 01, 2026 at 10:29:27AM +0200, Christian Marangi wrote:
> Add phylink support for each GDM port. For GDM1 add the internal interface
> mode as the only supported mode. For GDM2/3/4 add the required
> configuration of the PCS to make the external PHY or attached SFP cage
> work.
> 
> These needs to be defined in the GDM port node using the pcs-handle
> property.
> 
> Update and provide a .get/set_link_ksettings function that use phylink
> for ethtool OPs now that we fully support phylink.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/ethernet/airoha/Kconfig       |   2 +
>  drivers/net/ethernet/airoha/airoha_eth.c  | 199 +++++++++++++++++++++-
>  drivers/net/ethernet/airoha/airoha_eth.h  |   5 +
>  drivers/net/ethernet/airoha/airoha_regs.h |  12 ++
>  4 files changed, 215 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/airoha/Kconfig b/drivers/net/ethernet/airoha/Kconfig
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
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
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
> @@ -1915,10 +1916,18 @@ static int airoha_dev_open(struct net_device *netdev)
>  	struct airoha_qdma *qdma;
>  	int err;
>  
> +	err = phylink_of_phy_connect(dev->phylink, netdev->dev.of_node, 0);
> +	if (err) {
> +		netdev_err(netdev, "could not attach PHY: %d\n", err);
> +		return err;
> +	}
> +
> +	phylink_start(dev->phylink);
> +
>  	netif_tx_start_all_queues(netdev);
>  	err = airoha_set_vip_for_gdm_port(dev, true);
>  	if (err)
> -		return err;
> +		goto err_phy_stop;
>  
>  	qdma = airoha_qdma_deref(dev);
>  	if (netdev_uses_dsa(netdev))
> @@ -1938,6 +1947,13 @@ static int airoha_dev_open(struct net_device *netdev)
>  				    pse_port);
>  
>  	return 0;
> +
> +err_phy_stop:
> +	netif_tx_stop_all_queues(netdev);
> +	phylink_stop(dev->phylink);
> +	phylink_disconnect_phy(dev->phylink);
> +
> +	return err;
>  }
>  
>  static int airoha_dev_stop(struct net_device *netdev)
> @@ -1945,6 +1961,8 @@ static int airoha_dev_stop(struct net_device *netdev)
>  	struct airoha_gdm_dev *dev = netdev_priv(netdev);
>  	struct airoha_gdm_port *port = dev->port;
>  
> +	phylink_stop(dev->phylink);
> +
>  	netif_tx_disable(netdev);
>  	airoha_set_vip_for_gdm_port(dev, false);
>  
> @@ -1954,6 +1972,9 @@ static int airoha_dev_stop(struct net_device *netdev)
>  		airoha_set_gdm_port_fwd_cfg(dev->eth,
>  					    REG_GDM_FWD_CFG(port->id),
>  					    FE_PSE_PORT_DROP);
> +
> +	phylink_disconnect_phy(dev->phylink);
> +
>  	return 0;
>  }
>  
> @@ -2509,6 +2530,24 @@ airoha_ethtool_get_rmon_stats(struct net_device *netdev,
>  	} while (u64_stats_fetch_retry(&dev->stats.syncp, start));
>  }
>  
> +static int
> +airoha_ethtool_get_link_ksettings(struct net_device *netdev,
> +				  struct ethtool_link_ksettings *cmd)
> +{
> +	struct airoha_gdm_dev *dev = netdev_priv(netdev);
> +
> +	return phylink_ethtool_ksettings_get(dev->phylink, cmd);
> +}
> +
> +static int
> +airoha_ethtool_set_link_ksettings(struct net_device *netdev,
> +				  const struct ethtool_link_ksettings *cmd)
> +{
> +	struct airoha_gdm_dev *dev = netdev_priv(netdev);
> +
> +	return phylink_ethtool_ksettings_set(dev->phylink, cmd);
> +}
> +
>  static int airoha_qdma_set_chan_tx_sched(struct net_device *netdev,
>  					 int channel, enum tx_sched_mode mode,
>  					 const u16 *weights, u8 n_weights)
> @@ -3353,7 +3392,8 @@ static const struct ethtool_ops airoha_ethtool_ops = {
>  	.get_drvinfo		= airoha_ethtool_get_drvinfo,
>  	.get_eth_mac_stats      = airoha_ethtool_get_mac_stats,
>  	.get_rmon_stats		= airoha_ethtool_get_rmon_stats,
> -	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
> +	.get_link_ksettings	= airoha_ethtool_get_link_ksettings,
> +	.set_link_ksettings	= airoha_ethtool_set_link_ksettings,
>  	.get_link		= ethtool_op_get_link,
>  };
>  
> @@ -3409,6 +3449,155 @@ bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
>  	return false;
>  }
>  
> +/* Nothing to do in MAC, everything is handled in PCS */
> +static void airoha_mac_config(struct phylink_config *config, unsigned int mode,
> +			      const struct phylink_link_state *state)
> +{
> +}
> +
> +static void airoha_mac_link_up(struct phylink_config *config, struct phy_device *phy,
> +			       unsigned int mode, phy_interface_t interface,
> +			       int speed, int duplex, bool tx_pause, bool rx_pause)
> +{
> +	struct airoha_gdm_dev *dev = container_of(config, struct airoha_gdm_dev,
> +						  phylink_config);
> +	struct airoha_gdm_port *port = dev->port;
> +	struct airoha_eth *eth = dev->eth;
> +	u32 frag_size_tx, frag_size_rx;
> +
> +	/* TX/RX frag is configured only for GDM4 */
> +	if (port->id != AIROHA_GDM4_IDX)
> +		return;
> +
> +	switch (speed) {
> +	case SPEED_10000:
> +	case SPEED_5000:
> +		frag_size_tx = 8;
> +		frag_size_rx = 8;
> +		break;
> +	case SPEED_2500:
> +		frag_size_tx = 2;
> +		frag_size_rx = 1;
> +		break;
> +	default:
> +		frag_size_tx = 1;
> +		frag_size_rx = 0;
> +		break;
> +	}
> +
> +	mutex_lock(&port->link_lock);
> +
> +	/* Configure TX/RX frag based on speed */
> +	if (dev->nbq == 1) {
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
> +static void airoha_mac_link_down(struct phylink_config *config, unsigned int mode,
> +				 phy_interface_t interface)
> +{
> +}
> +
> +static const struct phylink_mac_ops airoha_phylink_ops = {
> +	.mac_config = airoha_mac_config,
> +	.mac_link_up = airoha_mac_link_up,
> +	.mac_link_down = airoha_mac_link_down,
> +};
> +
> +static int airoha_fill_available_pcs(struct phylink_config *config,
> +				     struct phylink_pcs **available_pcs,
> +				     unsigned int num_possible_pcs)
> +{
> +	struct device *dev = config->dev;
> +
> +	return fwnode_phylink_pcs_parse(dev_fwnode(dev), available_pcs,
> +					num_possible_pcs);
> +}
> +
> +static int airoha_setup_phylink(struct net_device *netdev)
> +{
> +	struct airoha_gdm_dev *dev = netdev_priv(netdev);
> +	struct device_node *np = netdev->dev.of_node;
> +	struct airoha_gdm_port *port = dev->port;
> +	struct phylink_config *config;
> +	phy_interface_t phy_mode;
> +	struct phylink *phylink;
> +	int err;
> +
> +	err = of_get_phy_mode(np, &phy_mode);
> +	if (err) {
> +		dev_err(&netdev->dev, "incorrect phy-mode\n");
> +		return err;
> +	}
> +
> +	config = &dev->phylink_config;
> +	config->dev = &netdev->dev;
> +	config->type = PHYLINK_NETDEV;
> +
> +	/*
> +	 * GDM1 only supports internal for Embedded Switch
> +	 * and doesn't require a PCS.
> +	 */
> +	if (port->id == AIROHA_GDM1_IDX) {
> +		config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +					   MAC_10000FD;
> +
> +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +			  config->supported_interfaces);
> +	} else {
> +		config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +					   MAC_10 | MAC_100 | MAC_1000 |
> +					   MAC_2500FD | MAC_5000FD | MAC_10000FD;
> +
> +		config->num_possible_pcs = fwnode_phylink_pcs_count(dev_fwnode(config->dev));
> +		config->fill_available_pcs = airoha_fill_available_pcs;
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
> +	phylink = phylink_create(config, of_fwnode_handle(np),
> +				 phy_mode, &airoha_phylink_ops);
> +	if (IS_ERR(phylink))
> +		return PTR_ERR(phylink);
> +
> +	dev->phylink = phylink;
> +
> +	return 0;
> +}
> +
>  static int airoha_alloc_gdm_device(struct airoha_eth *eth,
>  				   struct airoha_gdm_port *port,
>  				   int nbq, struct device_node *np)
> @@ -3474,7 +3663,7 @@ static int airoha_alloc_gdm_device(struct airoha_eth *eth,
>  	dev->nbq = nbq;
>  	port->devs[index] = dev;
>  
> -	return 0;
> +	return airoha_setup_phylink(netdev);
>  }
>  
>  static int airoha_alloc_gdm_port(struct airoha_eth *eth,
> @@ -3510,6 +3699,7 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
>  
>  	port->id = id;
>  	spin_lock_init(&port->stats_lock);
> +	mutex_init(&port->link_lock);
>  	eth->ports[p] = port;
>  
>  	err = airoha_metadata_dst_alloc(port);
> @@ -3706,6 +3896,8 @@ static int airoha_probe(struct platform_device *pdev)
>  			netdev = netdev_from_priv(dev);
>  			if (netdev->reg_state == NETREG_REGISTERED)
>  				unregister_netdev(netdev);
> +			if (dev->phylink)
> +				phylink_destroy(dev->phylink);
>  			of_node_put(netdev->dev.of_node);
>  		}
>  		airoha_metadata_dst_free(port);
> @@ -3744,6 +3936,7 @@ static void airoha_remove(struct platform_device *pdev)
>  
>  			netdev = netdev_from_priv(dev);
>  			unregister_netdev(netdev);
> +			phylink_destroy(dev->phylink);
>  			of_node_put(netdev->dev.of_node);
>  		}
>  		airoha_metadata_dst_free(port);
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
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
>  
>  struct airoha_gdm_port {
> @@ -604,6 +607,8 @@ struct airoha_gdm_port {
>  
>  	/* protect concurrent hw_stats accesses */
>  	spinlock_t stats_lock;
> +	/* protect concurrent GDM4 register access */
> +	struct mutex link_lock;
>  
>  	struct metadata_dst *dsa_meta[AIROHA_MAX_DSA_PORTS];
>  };
> diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
> index 442b48c9b991..4ea89057b560 100644
> --- a/drivers/net/ethernet/airoha/airoha_regs.h
> +++ b/drivers/net/ethernet/airoha/airoha_regs.h
> @@ -357,6 +357,18 @@
>  #define IP_FRAGMENT_PORT_MASK		GENMASK(8, 5)
>  #define IP_FRAGMENT_NBQ_MASK		GENMASK(4, 0)
>  
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
>  
> -- 
> 2.53.0
> 
