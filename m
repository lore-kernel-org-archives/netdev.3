Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98033FD15C;
	Thu, 30 Jul 2026 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785402087; cv=none; b=bRDy4sZc9nRN02VGbSaGMYn7Sqe7O/t62zrLPIEKqKUqfcj4mOWbVm/vPzrm8O3sERi5AhxxYtcbmfSYTeToXXTAVW/C6+G6p+ZyTeg/V07iupDVhRpBVwySRUAJRTbkp2Lmc0lyh5U25penKY0aWAttD855chTR2GL0UuDJpDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785402087; c=relaxed/simple;
	bh=FQGG9EdXeLCFKlw3fTa4ZgWVnxwsqR8KzTnyuDGnBrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRh3RKTwtiPQUAhn91tZSKwIZMJGOks2dqzHKjAxl3/RS4/7DpIcsGKkP8+Ep/8XGzDdB2K1Vp5To3yOTlR+NwfMDtjHGhuXPnygTjMc18TFQfs/dkNcfWFLLfsDvB+Xv3wFngdvp0J5vheWCzJwLfaz+Q3okUjHK4BD1ymVjNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6lFwRzf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6lFwRzf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4142A1F000E9;
	Thu, 30 Jul 2026 09:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785402085;
	bh=3/rECwPkwxTy3VN5aPaQh8oM39tG4Fhfd5VEsxGT1ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N6lFwRzfs7oqvi96anrfXWwiJPNPBeE0+AwYFKPGoAGugX9ZYT0dNlJ09zoVEV/mI
	 42/YM33pc0BDmzFLzhdBt2kJv94tpcZw0vQwxiHC8+Kewowu0uN3woTswmK9+xZl8X
	 g93TDY6NOs9dZ/stITEtZVTalUNdF8U9AnXJHQ2D+HI5ayrO0boXcqeom2NcSm2DuK
	 C3WSRzOvZnznI4mWLiK1HQs29cUOb/ZW/tGOltHWzIVm0eENbl89Txba38cVuaGjKz
	 ZuAJsowhW3qMEULdOYGzF45D5yWlCafkQuHbNlY1GT+QXnYUyL/7J5V8tsuXQ6jv7Q
	 vMpUzOKSiyC9g==
Date: Thu, 30 Jul 2026 11:01:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>
Subject: Re: [PATCH 4/4] net: dsa: soce: Add initial driver support for MRS
 switches
Message-ID: <20260730-prophetic-ordinary-crane-0ebedf@quoll>
References: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
 <20260729-devel-vstrassheim-soce-dsa-ml-v1-4-be569dae1b20@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260729-devel-vstrassheim-soce-dsa-ml-v1-4-be569dae1b20@linutronix.de>

On Wed, Jul 29, 2026 at 06:36:57PM +0200, Vasilij Strassheim wrote:
> +static const struct soce_variant_desc soce_variants[] = {
> +	{
> +		.compatible		= "soce,mrs-21-01",
> +		.mdio_master_offset	= SOCE_MRS_21_01_MDIO_MASTER_OFFSET,
> +		.layout			= &soce_mrs_21_01_layout,
> +		.mdio_ops		= &soce_mdio_ops_20_03,
> +	},
> +	{
> +		.compatible		= "soce,mrs-23-02",
> +		.mdio_master_offset	= SOCE_MRS_21_01_MDIO_MASTER_OFFSET,
> +		.layout			= &soce_mrs_24_01_layout,
> +		.mdio_ops		= &soce_mdio_ops_c22_c45,
> +	},
> +	{
> +		.compatible		= "soce,mrs-24-01",
> +		.mdio_master_offset	= SOCE_MRS_21_01_MDIO_MASTER_OFFSET,
> +		.layout			= &soce_mrs_24_01_layout,
> +		.mdio_ops		= &soce_mdio_ops_c22_c45,
> +	},
> +	{ /* sentinel */ },
> +};
> +
> +static const struct soce_variant_desc *
> +soce_match_variant(const char *compatible)
> +{
> +	int i;
> +
> +	for (i = 0; soce_variants[i].compatible; i++) {
> +		if (!strcmp(compatible, soce_variants[i].compatible))
> +			return &soce_variants[i];

Do not re-invent OF matching. This is supposed to be of_device_id table.

> +	}
> +
> +	return NULL;
> +}
> +
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
> +
> +	phy_node = of_parse_phandle(port_node, "phy-handle", 0);
> +	if (!phy_node) {
> +		if (of_phy_is_fixed_link(port_node))
> +			return 0;
> +
> +		dev_err(dev, "user port %u requires phy-handle or fixed-link\n",
> +			port);
> +		return -EINVAL;
> +	}
> +
> +	ret = of_property_read_u32(phy_node, "soce,mdio-output", &val);
> +	if (ret) {
> +		dev_err(dev,
> +			"missing soce,mdio-output in %pOF referenced by port %u\n",
> +			phy_node, port);
> +		goto out_put_phy;
> +	}
> +	local->mdio_info[port].mdio_output = val;
> +
> +	ret = of_property_read_u32(phy_node, "soce,phy-addr", &val);
> +	if (ret) {
> +		dev_err(dev,
> +			"missing soce,phy-addr in %pOF referenced by port %u\n",
> +			phy_node, port);
> +		goto out_put_phy;
> +	}
> +	local->mdio_info[port].phy_addr = val;
> +
> +out_put_phy:
> +	of_node_put(phy_node);
> +	return ret;
> +}
> +
> +static int soce_sw_parse_port_mdio(struct soce_priv *priv, struct device *dev,
> +				   u32 numports)
> +{
> +	struct soce_dsa_local *local = &priv->local;
> +	struct device_node *ports_node;
> +	struct device_node *port_node;
> +	u32 port;
> +	int ret;
> +
> +	ports_node = of_get_child_by_name(dev->of_node, "ports");
> +	if (!ports_node) {
> +		dev_err(dev, "missing ports node\n");
> +		return -EINVAL;
> +	}
> +
> +	for_each_available_child_of_node(ports_node, port_node) {

Why not scoped?

> +		if (of_property_read_u32(port_node, "reg", &port))
> +			continue;
> +
> +		if (port >= numports || port >= SOCE_MAX_NUM_PORTS) {
> +			dev_warn(dev,
> +				 "ignoring invalid port index %u in %pOF\n",
> +				 port, port_node);
> +			continue;
> +		}
> +
> +		ret = soce_sw_parse_port_mdio_config(local, dev, port_node,
> +						     port);
> +		if (ret) {
> +			of_node_put(port_node);
> +			of_node_put(ports_node);
> +			return ret;
> +		}
> +	}
> +
> +	of_node_put(ports_node);
> +	return 0;
> +}
> +
> +static int soce_sw_probe(struct mdio_device *mdiodev)
> +{
> +	const struct soce_variant_desc *variant;
> +	struct device *dev = &mdiodev->dev;
> +	struct device_node *switch_node;
> +	struct soce_dsa_local *local;
> +	const char *soce_compatible;
> +	struct soce_priv *priv;
> +	u32 numports;
> +	int ret;
> +
> +	priv = devm_kzalloc(&mdiodev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->ds = devm_kzalloc(&mdiodev->dev, sizeof(*priv->ds), GFP_KERNEL);
> +	if (!priv->ds)
> +		return -ENOMEM;
> +
> +	priv->ds->dev = dev;
> +	priv->ds->priv = priv;
> +	local = &priv->local;
> +
> +	switch_node = of_parse_phandle(dev->of_node, "soce,switch-ip", 0);
> +	if (!switch_node) {
> +		dev_err(dev, "missing or invalid switch IP reference\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = of_property_read_string(switch_node, "compatible",
> +				      &soce_compatible);
> +	if (ret) {
> +		dev_err(dev, "missing compatible property in %pOF\n",
> +			switch_node);
> +		of_node_put(switch_node);
> +		return -EINVAL;
> +	}
> +
> +	variant = soce_match_variant(soce_compatible);
> +	if (!variant) {
> +		dev_err(dev, "unsupported compatible '%s' in %pOF\n",
> +			soce_compatible, switch_node);
> +		of_node_put(switch_node);

Use proper error handling exit paths with goto.

> +		return -ENODEV;
> +	}
> +
> +	ret = of_property_read_u32(switch_node, "soce,num-ports", &numports);
> +	if (ret) {
> +		dev_err(dev, "missing soce,num-ports in %pOF\n", switch_node);
> +		of_node_put(switch_node);
> +		return -EINVAL;
> +	}
> +	if (numports == 0 || numports > SOCE_MAX_NUM_PORTS) {
> +		dev_err(dev, "invalid soce,num-ports %u (max %d)\n", numports,
> +			SOCE_MAX_NUM_PORTS);
> +		of_node_put(switch_node);
> +		return -EINVAL;
> +	}
> +
> +	local->base_addr = devm_of_iomap(dev, switch_node, 0, NULL);
> +	if (IS_ERR(local->base_addr)) {
> +		dev_err(dev, "failed to map switch register space for %pOF\n",
> +			switch_node);
> +		of_node_put(switch_node);
> +		return PTR_ERR(local->base_addr);
> +	}
> +
> +	priv->ds->ops = &soce_switch_ops;
> +	local->mdio_ops = variant->mdio_ops;
> +	local->mdio_master_addr =
> +		local->base_addr + variant->mdio_master_offset;
> +	local->layout = variant->layout;
> +	of_node_put(switch_node);
> +
> +	priv->ds->num_ports = numports;
> +	ret = soce_sw_parse_port_mdio(priv, dev, numports);
> +	if (ret)
> +		return ret;
> +
> +	dev_set_drvdata(&mdiodev->dev, priv);
> +
> +	dev_info(dev, "soce %s SDSA driver probed.\n", soce_compatible);

Drop, driver should be silent on success.

> +
> +	return dsa_register_switch(priv->ds);
> +}
> +
> +static void soce_sw_remove(struct mdio_device *mdiodev)
> +{
> +	struct soce_priv *priv = dev_get_drvdata(&mdiodev->dev);
> +
> +	dsa_unregister_switch(priv->ds);
> +}
> +
> +static const struct of_device_id soce_of_match[] = {
> +	{ .compatible = "soce,switch-dsa" },
> +	{ /* sentinel */ },
> +};
> +
> +static struct mdio_driver soce_mdio_driver = {
> +	.mdiodrv.driver = {
> +		.name = "soce-switch-dsa",
> +		.of_match_table = soce_of_match,
> +	},
> +	.probe  = soce_sw_probe,
> +	.remove = soce_sw_remove,
> +};

Best regards,
Krzysztof

