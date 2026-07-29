Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A7737C109;
	Wed, 29 Jul 2026 17:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785346307; cv=none; b=PvzFkWUX2fUMIrZQZ3NWTFkTvnzD3uBWevdGBoL2owLPtofN7qA/ZM30EfnPOExB71hUrJrWhUoAePaL+wPmBvxVCcHmzZuIbWDxHfUGk8wkRnw9UjI9KsnAd5hOogtsS4Pd7Ck0bPvUOBL8S1j5nbgg/H5527Gv9v26FhMLy9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785346307; c=relaxed/simple;
	bh=G79NbSvwKI++wZpGYi+45JJW6Wpsaiw6AEejdKZ/wmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRWlsKdEsJUMYDzPxo9ROuHNkOFQ/4TRkw9I2RzkftNNXLxThXShuTbalXkQEWpzyZqTrqremApEz73kKs81gSDdNec7uYuL5M4Hc1xkiK31RTBwETPHHC4dmia+RB0fVmVUoiKnqO4M1s6xBeAM8/61wbPzIe3gRE2J8o/rx5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tL3ldWex; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tL3ldWex"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=m6jv1w2l5pSZTcWzDdhssO8hH6rvY6jkG7tNNwArU5g=; b=tL3ldWexjTh537HWxjnSmN0xK3
	GCpPSrlATuOcZFawODjIGY05kEtdeImCOJg05ErgeKYg36+cdC0hxyt+aimoUF/bhRIhfIONA4Zma
	xgY+IqU4zt22AXrdYGOu7mu/ov3QuKIZX+yTB/a6xYDDRwRjk0pB5+eBRbC48H/+IxKg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wp880-00Er08-MC; Wed, 29 Jul 2026 19:31:36 +0200
Date: Wed, 29 Jul 2026 19:31:36 +0200
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
Message-ID: <b45edf4e-3312-4e73-8967-39b9b1e0701b@lunn.ch>
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
> +
> +	return dsa_register_switch(priv->ds);
> +}

Looking at this struct mdio_device *mdiodev is not used, other than
for ->dev. Is this device actually on an MDIO bus?

	Andrew
