Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8905E43079C
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562211; cv=none; b=tiolLWI4O4Sl3vq6y5WfLnTBmUbgTR5LLP9TxUgShzgv4KiA7VciiapmU5AROAcjmeOQDcE6T8TveylVAgWgv1sthoMT9Bz/kYFpnJHvOVbk1DhWVYd+Hc8Yrta18alut6VDuWkxi1xa6cZiytBQqVcza0VYjOxaI4SxEiZsZNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562211; c=relaxed/simple;
	bh=j5SVGyCyRPpRSfX1vzsX5v1NdyNBTtAUNMm2v/AsdJ0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGNxXc4oNX+jf4l5M9PgqImvk5H6OjTRUjlVzgaOMh8tZ3YXldnfl1idCcsPpL0bX47/YE1CU+982n4XR7vlTVJJfOF5Xz3gfA2vX+JH4oFSQ3Xy/AD99BH39mkVGklfgZ69q7moIdJmdfB1zTdXlmRckQkC1Nr9YpVH5IvMLIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJEhdWd2; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJEhdWd2"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-472326ca506so7945082f8f.2
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 08:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784562207; x=1785167007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=96sBccLuhfAamB65walQaZAlGWaFt0kDQVQYJZnpI9s=;
        b=kJEhdWd21dkQrX4JG86nnCzzUBk6Q/QCcF8ZdUJ+nQrWSAVI6g4IEcOBc11Tp5DjZy
         FPgatRe/T6va7qJyKOAB1q4IOEhUvZSW/NQlN83yEl5ns/nTV+kk7GGa4h129OwywH/7
         ICiL+Z7GjqwB/y+TIcs0fwLomzeNxJEkoBJYzmr1ZmUz/zBP9ObZcCQkvYF31mbAos2X
         sCaEthC4aCea50st3POjkT7hoOuKKlhry1LcPN5/GDLnIr8/HnTYQ+bj8msfMW/+F8t8
         1wKyPGYJnZExiEDhXovxGhnrtlODF9+IM8QE9OztqLGzW90JwXvVy5oDsj0i29TEyCOP
         VyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784562207; x=1785167007;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=96sBccLuhfAamB65walQaZAlGWaFt0kDQVQYJZnpI9s=;
        b=XodJPQLXBnpseP+eoX2LSkG/6xxKIvSKdh8GvucgcQUFOmFG4pMrDQZf/RdW4t/4lk
         cbA70pvSiIn8VY2ghjBRVojBsqpS3fE4uvamQOUluJ5uoXUepDV3ps1PtABZmnNOzofd
         oyLrlKbWVdlLcTKF/B22CjsjvQqq4hhHp0wIanFCYR0a/eGAdN1qDZaHrYC3EybB0NG3
         ZC8x5DCVhyWkNl3njuqbLFjoNYmsJqo8WDYo60fA6jWhsARvr4sAugqEW0fkEiY4uyoM
         DUaXbzHqm1TdcAwHy2XuspqCEK1JHLnoUn3xJeSaZnq+PsFqHxaOTC65XZCdd9OR8Ac6
         aNbg==
X-Forwarded-Encrypted: i=1; AHgh+Rq2gTFEEZyJD1B4cX7A0rDwTRuMT4wThQ0pTWDKK+p/pts3gi49RJB9GFwuLBMPx+zPnNnIYJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwPyxpizbjHZ4++eiJGgfn16MwbPwqzUJOfaMQyykVbiFr9lYY
	IeCHf9AKSYxxQzEtmK256o+NqN4y/YUqa8yCz9ZEufjVr42m7Qx6buKi
X-Gm-Gg: AR+sD10DimlSuJOWRf5R22djsYDchiq8sS9lHxK3PRYpzhdLY2RUNOKN+TG5pXPUeDh
	MUOp2ebtOdU5TN2LM+9/i9Sx767szONFfVbGiOhQeEvQN5jHLfSf9Wd8N54D0JV5S+8RnL+8RiY
	SKrQc1zcNUdgjMvOe69aqVVRiRnZ+rcKvyWhEb5JsxAVQO88IthW+L/PaavbwlPxOB61zsn7mpw
	+0RsC707eS5+P0sJvcUuO9y1MneplNaKrepxFNp399rwoqiYcfMn6YZt1RFogj0wLGCDz94JcYc
	oaoOPOKPyl8I8ItxabtPONapfDDYVWJvv4/UJNJ8krMtR7lv0tu1fOG89+9xHAkuQaZJbEnDz9+
	WezL52VKds3/ZFpu1YPAYcn6k/Yu5RDVwQ8897skUeRgaq+6nophopUhQ5y1/O4iwPPgRxv7/kr
	I/GRyIdI735ajWqc8aSc56NkFwqsQljDdjO+tmo7LZ+41nkyWPuw==
X-Received: by 2002:a05:6000:40c5:b0:476:8a:5 with SMTP id ffacd0b85a97d-47f62326dbamr18346314f8f.34.1784562206551;
        Mon, 20 Jul 2026 08:43:26 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-246-252-39.retail.telecomitalia.it. [95.246.252.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ed1911sm32898027f8f.22.2026.07.20.08.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 08:43:25 -0700 (PDT)
Message-ID: <6a5e421d.9099b29d.2f0302.1cf4@mx.google.com>
X-Google-Original-Message-ID: <al5CFxJ4UFPENmBB@Ansuel-XPS.>
Date: Mon, 20 Jul 2026 17:43:19 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
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
References: <20260717065448.1498335-1-ansuelsmth@gmail.com>
 <20260717065448.1498335-13-ansuelsmth@gmail.com>
 <al5AVLxWRhnpGzJ1@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al5AVLxWRhnpGzJ1@lore-desk>

On Mon, Jul 20, 2026 at 05:35:48PM +0200, Lorenzo Bianconi wrote:
> > Add phylink support for each GDM port. For GDM1 add the internal interface
> > mode as the only supported mode. For GDM2/3/4 add the required
> > configuration of the PCS to make the external PHY or attached SFP cage
> > work.
> > 
> > These needs to be defined in the GDM port node using the pcs-handle
> > property.
> > 
> > Update and provide a .get/set_link_ksettings function that use phylink
> > for ethtool OPs now that we fully support phylink.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/net/ethernet/airoha/Kconfig       |   1 +
> >  drivers/net/ethernet/airoha/airoha_eth.c  | 194 +++++++++++++++++++++-
> >  drivers/net/ethernet/airoha/airoha_eth.h  |   7 +-
> >  drivers/net/ethernet/airoha/airoha_regs.h |  12 ++
> >  4 files changed, 207 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/airoha/Kconfig b/drivers/net/ethernet/airoha/Kconfig
> > index 1f6640a15fc9..789906516bf8 100644
> > --- a/drivers/net/ethernet/airoha/Kconfig
> > +++ b/drivers/net/ethernet/airoha/Kconfig
> > @@ -20,6 +20,7 @@ config NET_AIROHA
> >  	depends on NET_DSA || !NET_DSA
> >  	select NET_AIROHA_NPU
> >  	select PAGE_POOL
> > +	select PHYLINK
> >  	help
> >  	  This driver supports the gigabit ethernet MACs in the
> >  	  Airoha SoC family.
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> > index 59001fd4b6f7..ed1ac032f337 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/of_reserved_mem.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/tcp.h>
> > +#include <linux/pcs/pcs.h>
> >  #include <linux/u64_stats_sync.h>
> >  #include <net/dst_metadata.h>
> >  #include <net/page_pool/helpers.h>
> > @@ -1837,7 +1838,7 @@ static void airoha_update_hw_stats(struct airoha_gdm_dev *dev)
> >  	struct airoha_gdm_port *port = dev->port;
> >  	int i;
> >  
> > -	spin_lock(&port->stats_lock);
> > +	spin_lock(&port->lock);
> 
> Hi Christian,
> 
> as pointed out in a previous email, I do not like the approach of reusing this
> spin_lock for airoha_mac_link_up(). Can we use rtl_lock() (when necessary) as
> pointed out before?
> 

For context, quoting from the previous series, the suggestion is to use
rtnl_is_locked() and then lock accordingly but I didn't find other usage of
that in other driver (aside from core net) and I don't like the use of
is_locked. I can already see the BOT saying that in the timeframe of
is_locked and writing the register another interface goes up causing a
race.

Guess I will add a simple mutex for this case and the other.

> >  
> >  	for (i = 0; i < ARRAY_SIZE(port->devs); i++) {
> >  		if (port->devs[i])
> > @@ -1848,7 +1849,7 @@ static void airoha_update_hw_stats(struct airoha_gdm_dev *dev)
> >  	airoha_fe_set(dev->eth, REG_FE_GDM_MIB_CLEAR(port->id),
> >  		      FE_GDM_MIB_RX_CLEAR_MASK | FE_GDM_MIB_TX_CLEAR_MASK);
> >  
> > -	spin_unlock(&port->stats_lock);
> > +	spin_unlock(&port->lock);
> >  }
> >  
> >  static void airoha_dev_set_xmit_frame_size(struct net_device *netdev)
> > @@ -1870,6 +1871,14 @@ static int airoha_dev_open(struct net_device *netdev)
> >  	u32 pse_port = FE_PSE_PORT_PPE1;
> >  	int err;
> >  
> > +	err = phylink_of_phy_connect(dev->phylink, netdev->dev.of_node, 0);
> > +	if (err) {
> > +		netdev_err(netdev, "could not attach PHY: %d\n", err);
> > +		return err;
> > +	}
> > +
> > +	phylink_start(dev->phylink);
> > +
> >  	netif_tx_start_all_queues(netdev);
> >  	err = airoha_set_vip_for_gdm_port(dev, true);
> >  	if (err)
> > @@ -1909,6 +1918,10 @@ static int airoha_dev_stop(struct net_device *netdev)
> >  		airoha_set_gdm_port_fwd_cfg(qdma->eth,
> >  					    REG_GDM_FWD_CFG(port->id),
> >  					    FE_PSE_PORT_DROP);
> > +
> > +	phylink_stop(dev->phylink);
> > +	phylink_disconnect_phy(dev->phylink);
> > +
> >  	return 0;
> >  }
> >  
> > @@ -2389,6 +2402,24 @@ airoha_ethtool_get_rmon_stats(struct net_device *netdev,
> >  	} while (u64_stats_fetch_retry(&dev->stats.syncp, start));
> >  }
> >  
> > +static int
> > +airoha_ethtool_get_link_ksettings(struct net_device *netdev,
> > +				  struct ethtool_link_ksettings *cmd)
> > +{
> > +	struct airoha_gdm_dev *dev = netdev_priv(netdev);
> > +
> > +	return phylink_ethtool_ksettings_get(dev->phylink, cmd);
> > +}
> > +
> > +static int
> > +airoha_ethtool_set_link_ksettings(struct net_device *netdev,
> > +				  const struct ethtool_link_ksettings *cmd)
> > +{
> > +	struct airoha_gdm_dev *dev = netdev_priv(netdev);
> > +
> > +	return phylink_ethtool_ksettings_set(dev->phylink, cmd);
> > +}
> > +
> >  static int airoha_qdma_set_chan_tx_sched(struct net_device *netdev,
> >  					 int channel, enum tx_sched_mode mode,
> >  					 const u16 *weights, u8 n_weights)
> > @@ -3120,7 +3151,8 @@ static const struct ethtool_ops airoha_ethtool_ops = {
> >  	.get_drvinfo		= airoha_ethtool_get_drvinfo,
> >  	.get_eth_mac_stats      = airoha_ethtool_get_mac_stats,
> >  	.get_rmon_stats		= airoha_ethtool_get_rmon_stats,
> > -	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
> > +	.get_link_ksettings	= airoha_ethtool_get_link_ksettings,
> > +	.set_link_ksettings	= airoha_ethtool_set_link_ksettings,
> >  	.get_link		= ethtool_op_get_link,
> >  };
> >  
> > @@ -3176,6 +3208,155 @@ bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
> >  	return false;
> >  }
> >  
> > +/* Nothing to do in MAC, everything is handled in PCS */
> > +static void airoha_mac_config(struct phylink_config *config, unsigned int mode,
> > +			      const struct phylink_link_state *state)
> > +{
> > +}
> > +
> > +static void airoha_mac_link_up(struct phylink_config *config, struct phy_device *phy,
> > +			       unsigned int mode, phy_interface_t interface,
> > +			       int speed, int duplex, bool tx_pause, bool rx_pause)
> > +{
> > +	struct airoha_gdm_dev *dev = container_of(config, struct airoha_gdm_dev,
> > +						  phylink_config);
> > +	struct airoha_gdm_port *port = dev->port;
> > +	struct airoha_eth *eth = dev->eth;
> > +	u32 frag_size_tx, frag_size_rx;
> > +	u32 mask, val;
> > +
> > +	/* TX/RX frag is configured only for GDM4 */
> > +	if (port->id != AIROHA_GDM4_IDX)
> > +		return;
> > +
> > +	switch (speed) {
> > +	case SPEED_10000:
> > +	case SPEED_5000:
> > +		frag_size_tx = 8;
> > +		frag_size_rx = 8;
> > +		break;
> > +	case SPEED_2500:
> > +		frag_size_tx = 2;
> > +		frag_size_rx = 1;
> > +		break;
> > +	default:
> > +		frag_size_tx = 1;
> > +		frag_size_rx = 0;
> > +	}
> > +
> > +	spin_lock(&port->lock);
> > +
> > +	/* Configure TX/RX frag based on speed */
> > +	if (dev->nbq == 1) {
> > +		mask = GDM4_SGMII1_TX_FRAG_SIZE_MASK;
> > +		val = FIELD_PREP(GDM4_SGMII1_TX_FRAG_SIZE_MASK,
> > +				 frag_size_tx);
> > +	}  else {
> > +		mask = GDM4_SGMII0_TX_FRAG_SIZE_MASK;
> > +		val = FIELD_PREP(GDM4_SGMII0_TX_FRAG_SIZE_MASK,
> > +				 frag_size_tx);
> > +	}
> > +	airoha_fe_rmw(eth, REG_FE_GDM4_TMBI_FRAG, mask, val);
> > +
> > +	if (dev->nbq == 1) {
> > +		mask = GDM4_SGMII1_RX_FRAG_SIZE_MASK;
> > +		val = FIELD_PREP(GDM4_SGMII1_RX_FRAG_SIZE_MASK,
> > +				 frag_size_rx);
> > +	} else {
> > +		mask = GDM4_SGMII0_RX_FRAG_SIZE_MASK;
> > +		val = FIELD_PREP(GDM4_SGMII0_RX_FRAG_SIZE_MASK,
> > +				 frag_size_rx);
> > +	}
> > +	airoha_fe_rmw(eth, REG_FE_GDM4_RMBI_FRAG, mask, val);
> > +
> > +	spin_unlock(&port->lock);
> > +}
> > +
> > +/* Nothing to do in MAC, everything is handled in PCS */
> > +static void airoha_mac_link_down(struct phylink_config *config, unsigned int mode,
> > +				 phy_interface_t interface)
> > +{
> > +}
> > +
> > +static const struct phylink_mac_ops airoha_phylink_ops = {
> > +	.mac_config = airoha_mac_config,
> > +	.mac_link_up = airoha_mac_link_up,
> > +	.mac_link_down = airoha_mac_link_down,
> > +};
> > +
> > +static int airoha_fill_available_pcs(struct phylink_config *config,
> > +				     struct phylink_pcs **available_pcs,
> > +				     unsigned int num_possible_pcs)
> > +{
> > +	struct device *dev = config->dev;
> > +
> > +	return fwnode_phylink_pcs_parse(dev_fwnode(dev), available_pcs,
> > +					num_possible_pcs);
> > +}
> > +
> > +static int airoha_setup_phylink(struct net_device *netdev)
> > +{
> > +	struct airoha_gdm_dev *dev = netdev_priv(netdev);
> > +	struct device_node *np = netdev->dev.of_node;
> > +	struct airoha_gdm_port *port = dev->port;
> > +	struct phylink_config *config;
> > +	phy_interface_t phy_mode;
> > +	struct phylink *phylink;
> > +	int err;
> > +
> > +	err = of_get_phy_mode(np, &phy_mode);
> > +	if (err) {
> > +		dev_err(&netdev->dev, "incorrect phy-mode\n");
> > +		return err;
> > +	}
> > +
> > +	config = &dev->phylink_config;
> > +	config->dev = &netdev->dev;
> > +	config->type = PHYLINK_NETDEV;
> > +
> > +	/*
> > +	 * GDM1 only supports internal for Embedded Switch
> > +	 * and doesn't require a PCS.
> > +	 */
> > +	if (port->id == AIROHA_GDM1_IDX) {
> > +		config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> > +					   MAC_10000FD;
> > +
> > +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> > +			  config->supported_interfaces);
> > +	} else {
> > +		config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> > +					   MAC_10 | MAC_100 | MAC_1000 |
> > +					   MAC_2500FD | MAC_5000FD | MAC_10000FD;
> > +
> > +		config->num_possible_pcs = fwnode_phylink_pcs_count(dev_fwnode(config->dev));
> > +		config->fill_available_pcs = airoha_fill_available_pcs;
> > +
> > +		__set_bit(PHY_INTERFACE_MODE_SGMII,
> > +			  config->supported_interfaces);
> > +		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> > +			  config->supported_interfaces);
> > +		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> > +			  config->supported_interfaces);
> > +		__set_bit(PHY_INTERFACE_MODE_10GBASER,
> > +			  config->supported_interfaces);
> > +		__set_bit(PHY_INTERFACE_MODE_USXGMII,
> > +			  config->supported_interfaces);
> > +
> > +		phy_interface_copy(config->pcs_interfaces,
> > +				   config->supported_interfaces);
> > +	}
> > +
> > +	phylink = phylink_create(config, of_fwnode_handle(np),
> > +				 phy_mode, &airoha_phylink_ops);
> > +	if (IS_ERR(phylink))
> > +		return PTR_ERR(phylink);
> > +
> > +	dev->phylink = phylink;
> > +
> > +	return 0;
> > +}
> > +
> >  static int airoha_alloc_gdm_device(struct airoha_eth *eth,
> >  				   struct airoha_gdm_port *port,
> >  				   int nbq, struct device_node *np)
> > @@ -3239,7 +3420,7 @@ static int airoha_alloc_gdm_device(struct airoha_eth *eth,
> >  	dev->nbq = nbq;
> >  	port->devs[index] = dev;
> >  
> > -	return 0;
> > +	return airoha_setup_phylink(netdev);
> >  }
> >  
> >  static int airoha_alloc_gdm_port(struct airoha_eth *eth,
> > @@ -3274,7 +3455,7 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
> >  		return -ENOMEM;
> >  
> >  	port->id = id;
> > -	spin_lock_init(&port->stats_lock);
> > +	spin_lock_init(&port->lock);
> >  	eth->ports[p] = port;
> >  
> >  	err = airoha_metadata_dst_alloc(port);
> > @@ -3471,6 +3652,8 @@ static int airoha_probe(struct platform_device *pdev)
> >  			netdev = netdev_from_priv(dev);
> >  			if (netdev->reg_state == NETREG_REGISTERED)
> >  				unregister_netdev(netdev);
> > +			if (dev->phylink)
> > +				phylink_destroy(dev->phylink);
> >  			of_node_put(netdev->dev.of_node);
> >  		}
> >  		airoha_metadata_dst_free(port);
> > @@ -3509,6 +3692,7 @@ static void airoha_remove(struct platform_device *pdev)
> >  
> >  			netdev = netdev_from_priv(dev);
> >  			unregister_netdev(netdev);
> > +			phylink_destroy(dev->phylink);
> >  			of_node_put(netdev->dev.of_node);
> >  		}
> >  		airoha_metadata_dst_free(port);
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
> > index f6d01a8e8da1..b49fc5304b3a 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.h
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> > @@ -561,6 +561,9 @@ struct airoha_gdm_dev {
> >  	int nbq;
> >  
> >  	struct airoha_hw_stats stats;
> > +
> > +	struct phylink *phylink;
> > +	struct phylink_config phylink_config;
> >  };
> >  
> >  struct airoha_gdm_port {
> > @@ -568,8 +571,8 @@ struct airoha_gdm_port {
> >  	int id;
> >  	int users;
> >  
> > -	/* protect concurrent hw_stats accesses */
> > -	spinlock_t stats_lock;
> > +	/* protect concurrent hw_stats and frag register accesses */
> > +	spinlock_t lock;
> >  
> >  	struct metadata_dst *dsa_meta[AIROHA_MAX_DSA_PORTS];
> >  };
> > diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
> > index 6fed63d013b4..8df02f51211c 100644
> > --- a/drivers/net/ethernet/airoha/airoha_regs.h
> > +++ b/drivers/net/ethernet/airoha/airoha_regs.h
> > @@ -357,6 +357,18 @@
> >  #define IP_FRAGMENT_PORT_MASK		GENMASK(8, 5)
> >  #define IP_FRAGMENT_NBQ_MASK		GENMASK(4, 0)
> >  
> > +#define REG_FE_GDM4_TMBI_FRAG		0x2028
> > +#define GDM4_SGMII1_TX_WEIGHT_MASK	GENMASK(31, 26)
> > +#define GDM4_SGMII1_TX_FRAG_SIZE_MASK	GENMASK(25, 16)
> > +#define GDM4_SGMII0_TX_WEIGHT_MASK	GENMASK(15, 10)
> > +#define GDM4_SGMII0_TX_FRAG_SIZE_MASK	GENMASK(9, 0)
> > +
> > +#define REG_FE_GDM4_RMBI_FRAG		0x202c
> > +#define GDM4_SGMII1_RX_WEIGHT_MASK	GENMASK(31, 26)
> > +#define GDM4_SGMII1_RX_FRAG_SIZE_MASK	GENMASK(25, 16)
> > +#define GDM4_SGMII0_RX_WEIGHT_MASK	GENMASK(15, 10)
> > +#define GDM4_SGMII0_RX_FRAG_SIZE_MASK	GENMASK(9, 0)
> > +
> >  #define REG_MC_VLAN_EN			0x2100
> >  #define MC_VLAN_EN_MASK			BIT(0)
> >  
> > -- 
> > 2.53.0
> > 



-- 
	Ansuel
