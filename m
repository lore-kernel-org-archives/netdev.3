Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36954489894;
	Wed, 29 Jul 2026 20:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785355560; cv=none; b=KJCQ8IyrzU92x3XpgmcVlaAwYWeivXf+3Z9jBXJm76/00rDUj1tvqQwxNZ1HeQjByobwH8YV8PPwGjVarRMaPqepVrkjITyoiqtpMysXjNA0Gf5d6aVVk0eORo1BR2Yi5E54oP88EHzzF8OAYeYNulpGHBVmlU4+uqKeTM4mAdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785355560; c=relaxed/simple;
	bh=VutXEHDqOoAryf9Q9xVogMMvtw9jjQHcg6AgJGjqGTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzqFvglYlq1FKBJzJNvdp6DRPnh0xdePd8mq+wO0IdxpUxezfDVZrunotaqWbKWSYGxGIbPKu8yfhqUrufe75SLu4vodmNY4ULh4pzjd4F3xGSseSuHxZFqiXkUa90AYw/pcD39tHqaATxvBpqYa1xkdpR3YW0F//Y32ZzHZkCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iQaHFgOm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iQaHFgOm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JFwlVFixiBqlz0i4w0ziil+HIUsQrfPYhT1P9OfuLY4=; b=iQaHFgOmYlR1V6ZLguD93PniG7
	eoKeMyMIuoQr0312EcXpz+RanY+e1L0SW/HnhRyrFhARJmqYsNW3k0KXDCrvsBszQqStY5HgpbUOH
	f5AA7x/4Ags8X0GmuIfaDA+v0kS+bU8ZlCqgjKyl2a+wbAtZgfYvu317ifKmbSwrcN8M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wpAX6-00Eruw-TP; Wed, 29 Jul 2026 22:05:40 +0200
Date: Wed, 29 Jul 2026 22:05:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Martin Kaistra <martin.kaistra@linutronix.de>
Subject: Re: [PATCH 4/4] net: dsa: soce: Add initial driver support for MRS
 switches
Message-ID: <f17d3a62-456f-4580-90bd-c54a30dceddc@lunn.ch>
References: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
 <20260729-devel-vstrassheim-soce-dsa-ml-v1-4-be569dae1b20@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729-devel-vstrassheim-soce-dsa-ml-v1-4-be569dae1b20@linutronix.de>

> +static u8 soce_map_stp_state(u8 state)
> +{
> +	switch (state) {
> +	case BR_STATE_DISABLED:
> +	case BR_STATE_BLOCKING:
> +	case BR_STATE_LISTENING:
> +		return 0;
> +	case BR_STATE_LEARNING:
> +		return 1;
> +	case BR_STATE_FORWARDING:
> +	default:
> +		return 3;

#defines for 0, 1 and 3.

What does 2 mean?

Since you don't implement bridge offload, i'm not sure having STP
states makes any sense.

> +static void soce_fast_age(struct dsa_switch *ds, int port,
> +			  const struct soce_layout *layout)
> +{
> +	struct soce_priv *priv = ds->priv;
> +	struct soce_dsa_local *local;
> +	void __iomem *p_mes_ctrl;
> +	u32 val;

Does aging make any sense without bridge offload?

> +/* Bridge membership is handled by the switch forwarding model directly. */
> +int soce_port_bridge_join(struct dsa_switch *ds, int port,
> +			  struct dsa_bridge bridge, bool *tx_fwd_offload,
> +			  struct netlink_ext_ack *extack)
> +{
> +	return 0;
> +}
> +
> +void soce_port_bridge_leave(struct dsa_switch *ds, int port,
> +			    struct dsa_bridge bridge)
> +{
> +}

If you don't support bridge offload, you should not need these.

> +static void soce_phylink_get_caps(struct dsa_switch *ds, int port,
> +				  struct phylink_config *config)
> +{
> +	if (dsa_is_cpu_port(ds, port)) {
> +		__set_bit(PHY_INTERFACE_MODE_GMII,

Is that really true? What is part of the IP core, and what is to do
with integration of the core into the system as a whole? It seems like
RGMII is also supported, so why cannot i instantiate a RGMII MII blob
for the CPU port as well?

> +			  config->supported_interfaces);
> +		config->mac_capabilities = MAC_10 | MAC_100 | MAC_1000 |
> +					   MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
> +		return;
> +	}
> +
> +	phy_interface_set_rgmii(config->supported_interfaces);

And flipping that around, if the core supports GMII, could i
instantiate a GMII user port?

> +static const struct dsa_switch_ops soce_switch_ops = {
> +	.get_tag_protocol	= soce_get_tag_protocol,
> +	.setup			= soce_setup,
> +	.teardown		= soce_teardown,
> +	.phylink_get_caps	= soce_phylink_get_caps,
> +	.phy_read		= soce_phy_read,
> +	.phy_write		= soce_phy_write,

phy_read and phy_write are legacy. Instantiate a Linux MDIO bus and
don't list anything here.

> +static const struct soce_variant_desc *
> +soce_match_variant(const char *compatible)
> +{
> +	int i;
> +
> +	for (i = 0; soce_variants[i].compatible; i++) {
> +		if (!strcmp(compatible, soce_variants[i].compatible))
> +			return &soce_variants[i];
> +	}
> +
> +	return NULL;

This kind of looks like a reinvention of of_device_get_match_data()

> +static int soce_sw_parse_port_mdio_config(struct soce_dsa_local *local,
> +					  struct device *dev,
> +					  struct device_node *port_node,
> +					  u32 port)
> +{
> +	struct device_node *phy_node;
> +	u32 val;
> +	int ret;
> +
> +	if (of_find_property(port_node, "ethernet", NULL) ||
> +	    of_find_property(port_node, "link", NULL)) {
> +		if (of_find_property(port_node, "phy-handle", NULL)) {
> +			dev_err(dev,
> +				"phy-handle not allowed on CPU/DSA port %u\n",
> +				port);
> +			return -EINVAL;
> +		}
> +
> +		return 0;
> +	}

Why is all of this parsing of DT needed? These should all be standard
properties which the DSA core handles.

This currently has the feel of being a "vendor crap" driver. Please
spend some time to clean this driver up, bring it up to Mainline
standards.

	Andrew
