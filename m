Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2AB1DDC33;
	Mon,  3 Aug 2026 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785771618; cv=none; b=WUqIIKsnJ9BsfsD4pjhU1t1HGRE3SUEeZNg/zzKsIJn6glchY8JV5lCiXWUqlZyYv/AE6lMznEppV9O80G+ydqul0GRhhzISg3doFyiijY9uSTz98v6CdT/0z9Le9IAQ9POenuviOHFLaYjollBxtOz7zAujRwlPKvW08i5Ob+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785771618; c=relaxed/simple;
	bh=+JEMFlA0tZQQJiqkQ2wp+tZYaDpytJsDY9c0Ncz26b8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PAeA7A2cNaNFEiwmEfssCXqSD2p70Fsr+SXT7eoTq5Y6D5zO+kFVD50cZNm9kubsXWkqDSUEXlMcMNqkeYnnYloNHWmm4hJ4/kjft4hYOZYW/otupMonHszTximdmuV7OHPSzq+mUPn56D4uIu+dOhwlZ4OB8lVOSO2PLd6wcq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OugSSp3w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=smouIGlk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OugSSp3w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="smouIGlk"
Message-ID: <a07a7b214990ff4229b4d7ef35897e4270d980f4.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785771614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fNZSVXzoyv+dWhCXq9CjgS7x5AqjRILFFWKkNCGIa2k=;
	b=OugSSp3wclAiDcKtohk3A9e2Ks9W0PHLS8MVeg+xT1p1NM4Bu0Af5i6LleSsgNRyLxTU/C
	1nwY7xZS0++64MztevJuZ8++BZUoHVyyyfTb1IN+ONdsyiujBJvkzzoq6pMvFLgAmOqIXp
	uu63ceYKsRy2mMcKssl/1p/nDayXp6GzKL9VZoUkj1PbTU+EJqve8XEC6TFCOfoUxgYahh
	OOOhcCQb55xarhjiNeB77e/4JMptLpWM0z/K3K5raOt0STGrRaip4rilpist30mDvRLm8T
	cShUUDv2k8xS5lQ4hSXF3TfjIG2KsKySFMTuAC+KXeNexAZSs5k6N3DUN/1r0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785771614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fNZSVXzoyv+dWhCXq9CjgS7x5AqjRILFFWKkNCGIa2k=;
	b=smouIGlkLCvRwUJ/RI+bG1qHDUeUMyBjskIHbeooz2fvTiqbpMmYzEVzYj80ejFP6Fg8Kt
	h6JU0OYYYcmSjFAQ==
Subject: Re: [PATCH 4/4] net: dsa: soce: Add initial driver support for MRS
 switches
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,  Martin Kaistra
 <martin.kaistra@linutronix.de>
Date: Mon, 03 Aug 2026 17:40:13 +0200
In-Reply-To: <b45edf4e-3312-4e73-8967-39b9b1e0701b@lunn.ch>
References: 
	<20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
	 <20260729-devel-vstrassheim-soce-dsa-ml-v1-4-be569dae1b20@linutronix.de>
	 <b45edf4e-3312-4e73-8967-39b9b1e0701b@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-29 at 19:31 +0200, Andrew Lunn wrote:
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
> > +
> > +	return dsa_register_switch(priv->ds);
> > +}
>=20
> Looking at this struct mdio_device *mdiodev is not used, other than
> for ->dev. Is this device actually on an MDIO bus?

I only have a memory-mapped version to test. I will remove this *mdiodev in
the next version.

>=20
> 	Andrew

Thanks,
Vasilij

