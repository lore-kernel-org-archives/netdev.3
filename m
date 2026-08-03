Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B343161A1;
	Mon,  3 Aug 2026 16:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785774215; cv=none; b=CwBr5tKfMKIKxE9sou+bMKvPPEulTberLRuw3APH2Hb1ldikmSMfdiTM84j7uAcJZYrjsmf/fkc6O71Id1DNWMW1froCOOirLgSA/asaovq+SJgJsbaUYJDQHWsM7Y0VlGWpTZz3nBA3wZ5kW2+HdNDNiK3rN3TyG3LmoTCSaOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785774215; c=relaxed/simple;
	bh=U4bgqk2SbU2hMLu2vQzXMdHlguP9PmemA8O5dwa57Fw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D3GbggPkcpfz+hv3oi4LyLhyysXALH8rzJ7pi0fVZ2iOPS9gZgppB3VRvduj/MH9RH5QLzTyFAu03DNRCuwpIN0G8XlutEW2h00lP+KyrsghPZmYjrbvqYUQxMdiBGWJh/Y1KwG1c1cO6vChszvRLcbAh+a4+PRnF9asmmg62RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vd5/xvfG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IENqR0O8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vd5/xvfG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IENqR0O8"
Message-ID: <ef6c7f16f041fc05098e9c2dc75f5d8f99a4c515.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785774212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9+2z4K7Z6oHtge3Jfpr6Mn1+pAcz55kshcDPQONNlU=;
	b=Vd5/xvfGMvkcCXgTKm3GQW+4B7knN/mO4YMJ12gFZvAcDJkZ7chkmljU8EQWlb4ntTGX2J
	qYCVjJCgY5pMWnOIMUVoASrB6xkz+L//bbOI+l5MnAFTMvcJM7JaMpBhArCV9iLluGbKnX
	OkOxb9gDvzYiw3ehzUwIkZUZUdijzH++vX4NXnQ35LpQdMN+YRox84BTuqyNjC+gqOVraQ
	TG6N0LU4SylksFG41AJ1TlgYgE0Zka1devnojYG9Zw3D2vXgyCG9uGJvoqEWJTepwG/T1W
	+gvo3RqlRhAIA3SY3RPhTeRagFc4/HuDsoSlCNcUc+CHsRc1kSvJvdVifLbDMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785774212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9+2z4K7Z6oHtge3Jfpr6Mn1+pAcz55kshcDPQONNlU=;
	b=IENqR0O8ypceurrik6cY1k/5Ucfx5kttALeRygpOt3PkS1VErzNWui6+TA5FG5l7so1zpr
	ry/to/7mdoK0EgBg==
Subject: Re: [PATCH 4/4] net: dsa: soce: Add initial driver support for MRS
 switches
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Vladimir
 Oltean <olteanv@gmail.com>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,  Martin Kaistra
 <martin.kaistra@linutronix.de>
Date: Mon, 03 Aug 2026 18:23:31 +0200
In-Reply-To: <20260730-prophetic-ordinary-crane-0ebedf@quoll>
References: 
	<20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
	 <20260729-devel-vstrassheim-soce-dsa-ml-v1-4-be569dae1b20@linutronix.de>
	 <20260730-prophetic-ordinary-crane-0ebedf@quoll>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-30 at 11:01 +0200, Krzysztof Kozlowski wrote:
> On Wed, Jul 29, 2026 at 06:36:57PM +0200, Vasilij Strassheim wrote:
> > +static const struct soce_variant_desc soce_variants[] =3D {
> > +	{
> > +		.compatible		=3D "soce,mrs-21-01",
> > +		.mdio_master_offset	=3D SOCE_MRS_21_01_MDIO_MASTER_OFFSET,
> > +		.layout			=3D &soce_mrs_21_01_layout,
> > +		.mdio_ops		=3D &soce_mdio_ops_20_03,
> > +	},
> > +	{
> > +		.compatible		=3D "soce,mrs-23-02",
> > +		.mdio_master_offset	=3D SOCE_MRS_21_01_MDIO_MASTER_OFFSET,
> > +		.layout			=3D &soce_mrs_24_01_layout,
> > +		.mdio_ops		=3D &soce_mdio_ops_c22_c45,
> > +	},
> > +	{
> > +		.compatible		=3D "soce,mrs-24-01",
> > +		.mdio_master_offset	=3D SOCE_MRS_21_01_MDIO_MASTER_OFFSET,
> > +		.layout			=3D &soce_mrs_24_01_layout,
> > +		.mdio_ops		=3D &soce_mdio_ops_c22_c45,
> > +	},
> > +	{ /* sentinel */ },
> > +};
> > +
> > +static const struct soce_variant_desc *
> > +soce_match_variant(const char *compatible)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; soce_variants[i].compatible; i++) {
> > +		if (!strcmp(compatible, soce_variants[i].compatible))
> > +			return &soce_variants[i];
>=20
> Do not re-invent OF matching. This is supposed to be of_device_id table.

I will change that.

>=20
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +static int soce_sw_parse_port_mdio_config(struct soce_dsa_local *local=
,
> > +					  struct device *dev,
> > +					  struct device_node *port_node,
> > +					  u32 port)
> > +{
> > +	struct device_node *phy_node;
> > +	u32 val;
> > +	int ret;
> > +
> > +	if (of_find_property(port_node, "ethernet", NULL) ||
> > +	    of_find_property(port_node, "link", NULL)) {
> > +		if (of_find_property(port_node, "phy-handle", NULL)) {
> > +			dev_err(dev,
> > +				"phy-handle not allowed on CPU/DSA port %u\n",
> > +				port);
> > +			return -EINVAL;
> > +		}
> > +
> > +		return 0;
> > +	}
> > +
> > +	phy_node =3D of_parse_phandle(port_node, "phy-handle", 0);
> > +	if (!phy_node) {
> > +		if (of_phy_is_fixed_link(port_node))
> > +			return 0;
> > +
> > +		dev_err(dev, "user port %u requires phy-handle or fixed-link\n",
> > +			port);
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret =3D of_property_read_u32(phy_node, "soce,mdio-output", &val);
> > +	if (ret) {
> > +		dev_err(dev,
> > +			"missing soce,mdio-output in %pOF referenced by port %u\n",
> > +			phy_node, port);
> > +		goto out_put_phy;
> > +	}
> > +	local->mdio_info[port].mdio_output =3D val;
> > +
> > +	ret =3D of_property_read_u32(phy_node, "soce,phy-addr", &val);
> > +	if (ret) {
> > +		dev_err(dev,
> > +			"missing soce,phy-addr in %pOF referenced by port %u\n",
> > +			phy_node, port);
> > +		goto out_put_phy;
> > +	}
> > +	local->mdio_info[port].phy_addr =3D val;
> > +
> > +out_put_phy:
> > +	of_node_put(phy_node);
> > +	return ret;
> > +}
> > +
> > +static int soce_sw_parse_port_mdio(struct soce_priv *priv, struct devi=
ce *dev,
> > +				   u32 numports)
> > +{
> > +	struct soce_dsa_local *local =3D &priv->local;
> > +	struct device_node *ports_node;
> > +	struct device_node *port_node;
> > +	u32 port;
> > +	int ret;
> > +
> > +	ports_node =3D of_get_child_by_name(dev->of_node, "ports");
> > +	if (!ports_node) {
> > +		dev_err(dev, "missing ports node\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	for_each_available_child_of_node(ports_node, port_node) {
>=20
> Why not scoped?

I will change it to scoped.

>=20
> > +		if (of_property_read_u32(port_node, "reg", &port))
> > +			continue;
> > +
> > +		if (port >=3D numports || port >=3D SOCE_MAX_NUM_PORTS) {
> > +			dev_warn(dev,
> > +				 "ignoring invalid port index %u in %pOF\n",
> > +				 port, port_node);
> > +			continue;
> > +		}
> > +
> > +		ret =3D soce_sw_parse_port_mdio_config(local, dev, port_node,
> > +						     port);
> > +		if (ret) {
> > +			of_node_put(port_node);
> > +			of_node_put(ports_node);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	of_node_put(ports_node);
> > +	return 0;
> > +}
> > +
> > +static int soce_sw_probe(struct mdio_device *mdiodev)
> > +{
> > +	const struct soce_variant_desc *variant;
> > +	struct device *dev =3D &mdiodev->dev;
> > +	struct device_node *switch_node;
> > +	struct soce_dsa_local *local;
> > +	const char *soce_compatible;
> > +	struct soce_priv *priv;
> > +	u32 numports;
> > +	int ret;
> > +
> > +	priv =3D devm_kzalloc(&mdiodev->dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->ds =3D devm_kzalloc(&mdiodev->dev, sizeof(*priv->ds), GFP_KERNE=
L);
> > +	if (!priv->ds)
> > +		return -ENOMEM;
> > +
> > +	priv->ds->dev =3D dev;
> > +	priv->ds->priv =3D priv;
> > +	local =3D &priv->local;
> > +
> > +	switch_node =3D of_parse_phandle(dev->of_node, "soce,switch-ip", 0);
> > +	if (!switch_node) {
> > +		dev_err(dev, "missing or invalid switch IP reference\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret =3D of_property_read_string(switch_node, "compatible",
> > +				      &soce_compatible);
> > +	if (ret) {
> > +		dev_err(dev, "missing compatible property in %pOF\n",
> > +			switch_node);
> > +		of_node_put(switch_node);
> > +		return -EINVAL;
> > +	}
> > +
> > +	variant =3D soce_match_variant(soce_compatible);
> > +	if (!variant) {
> > +		dev_err(dev, "unsupported compatible '%s' in %pOF\n",
> > +			soce_compatible, switch_node);
> > +		of_node_put(switch_node);
>=20
> Use proper error handling exit paths with goto.

I will do it.

>=20
> > +		return -ENODEV;
> > +	}
> > +
> > +	ret =3D of_property_read_u32(switch_node, "soce,num-ports", &numports=
);
> > +	if (ret) {
> > +		dev_err(dev, "missing soce,num-ports in %pOF\n", switch_node);
> > +		of_node_put(switch_node);
> > +		return -EINVAL;
> > +	}
> > +	if (numports =3D=3D 0 || numports > SOCE_MAX_NUM_PORTS) {
> > +		dev_err(dev, "invalid soce,num-ports %u (max %d)\n", numports,
> > +			SOCE_MAX_NUM_PORTS);
> > +		of_node_put(switch_node);
> > +		return -EINVAL;
> > +	}
> > +
> > +	local->base_addr =3D devm_of_iomap(dev, switch_node, 0, NULL);
> > +	if (IS_ERR(local->base_addr)) {
> > +		dev_err(dev, "failed to map switch register space for %pOF\n",
> > +			switch_node);
> > +		of_node_put(switch_node);
> > +		return PTR_ERR(local->base_addr);
> > +	}
> > +
> > +	priv->ds->ops =3D &soce_switch_ops;
> > +	local->mdio_ops =3D variant->mdio_ops;
> > +	local->mdio_master_addr =3D
> > +		local->base_addr + variant->mdio_master_offset;
> > +	local->layout =3D variant->layout;
> > +	of_node_put(switch_node);
> > +
> > +	priv->ds->num_ports =3D numports;
> > +	ret =3D soce_sw_parse_port_mdio(priv, dev, numports);
> > +	if (ret)
> > +		return ret;
> > +
> > +	dev_set_drvdata(&mdiodev->dev, priv);
> > +
> > +	dev_info(dev, "soce %s SDSA driver probed.\n", soce_compatible);
>=20
> Drop, driver should be silent on success.

Does this really apply to DSA drivers? I see some corresponding dev_info()
entries in mainlined drivers. See for example mv88e6060_probe(),
gswip_probe_common() and sja1105_probe().
And there are others as well, especially if you consider the _detect()
functions that are called from _probe().
I also find it very helpful for troubleshooting, so I'd like to keep it alo=
ng
with some additional information about the hardware, just like other driver=
s.

>=20
> > +
> > +	return dsa_register_switch(priv->ds);
> > +}
> > +
> > +static void soce_sw_remove(struct mdio_device *mdiodev)
> > +{
> > +	struct soce_priv *priv =3D dev_get_drvdata(&mdiodev->dev);
> > +
> > +	dsa_unregister_switch(priv->ds);
> > +}
> > +
> > +static const struct of_device_id soce_of_match[] =3D {
> > +	{ .compatible =3D "soce,switch-dsa" },
> > +	{ /* sentinel */ },
> > +};
> > +
> > +static struct mdio_driver soce_mdio_driver =3D {
> > +	.mdiodrv.driver =3D {
> > +		.name =3D "soce-switch-dsa",
> > +		.of_match_table =3D soce_of_match,
> > +	},
> > +	.probe  =3D soce_sw_probe,
> > +	.remove =3D soce_sw_remove,
> > +};
>=20
> Best regards,
> Krzysztof
>=20

Thanks,
Vasilij

