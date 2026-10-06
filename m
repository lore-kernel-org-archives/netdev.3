Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0F837E5C7;
	Tue,  6 Oct 2026 07:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791270860; cv=none; b=bovGbQx88ZVUXffSWUBoHb4Bfcl5MIO1dDMOA6eDjc53FdyL4juCcla08S6eqs7yJhfRVHFEsjmoEmziWq3D0lWtfF3gSzjd2PNXIm7aoDZ+tDqG/oZygCiLKF6cx30dUOvKuITzk4UZuC8481uD8gasE8KBOlcbqy38RdBfWss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791270860; c=relaxed/simple;
	bh=4zc6tPWf2CmluvVopXlLil2riJGt+YGHE5eilr063QI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ku93Z2zJtXk48Y4DNHrJnmuhkzysywn7ULRnW2G0+t8kXPCX5Ldjsxulhj8s92dtvoD1nkCpXPEqM4kixemYCTP5h3hjX1nh6chyFTRmi4AtpK9FAwUSaGHCU9RHkl0O3y4EHxwOxrAZstW02mgotcsjiMAxtMZ2sS/LnSD3k5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N37O92az; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L5HM//22; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N37O92az";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L5HM//22"
Message-ID: <0c59e35928a6e82ebb0151dc64800b543a71a04d.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791270844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bh87HsnKO/vqAOoOO1PbWh+Dn1+5ssDhnvsF+w73yPQ=;
	b=N37O92azyBSIjcL1ZLNBfMOEIPyT7zGhCoErXYeiJ4LfA5Kb5KNIBVNSwLoKoriorJHn/2
	oHKj3mKVSiWPEaCgGPmDJ8j+KCF2f0gsToyR3nCRYxI8AZ7PFqJJn4dPylFmgz+ApN+4+8
	4gWmeeiez6TRoi4nLYcV0Yi5sSZf4koDYN+yOuPedeP/S6MD5IkIe3Q12orvjp3wHDNjGx
	hY+AKE89/5DDDVUt8blXXER/2qnoP/3XRUFzmTPR5pqzIeQhHvhDIr3bGtZAvpxH5g0QK7
	F/uUFTS+VZ1BSxazwQuWv1kj925N3OR6+2ODNs5Z2k0vREDHCNo7cxz3mhzPrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791270844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bh87HsnKO/vqAOoOO1PbWh+Dn1+5ssDhnvsF+w73yPQ=;
	b=L5HM//225V9+0UrFDTDjAhgfO92WL3i59p/xiBesP//HDxq5AOpGau6vzE5K3hxBbnuTuB
	jhHT2lP1A8ybS4Cg==
Subject: Re: [PATCH net-next v3 5/8] net: mdio: Add SoC-e SWIP MDIO
 controller driver
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,  Martin Kaistra
 <martin.kaistra@linutronix.de>, Benedikt Spranger <b.spranger@linutronix.de>
Date: Tue, 06 Oct 2026 09:14:02 +0200
In-Reply-To: <20260924104004.773F61F00899@smtp.kernel.org>
References: 
	<20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
	 <20260923-devel-vstrassheim-soce-dsa-ml-v3-5-ddebafcb9ba7@linutronix.de>
	 <20260924104004.773F61F00899@smtp.kernel.org>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-09-24 at 10:40 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] mdio: null pointer dereference on devm_ioremap failure
> --
>=20
> commit b20b4c686880ab360f1cde6275ae5af3a5306146
> Author: Vasilij Strassheim <v.strassheim@linutronix.de>
>=20
> net: mdio: Add SoC-e SWIP MDIO controller driver
>    =20
> This commit adds a driver for the MDIO controller integrated into SoC-e
> Ethernet switch IP cores. It supports Clause 22 and 45 transactions while
> managing shared transaction control registers.
>=20
> > diff --git a/drivers/net/mdio/mdio-soce.c b/drivers/net/mdio/mdio-soce.=
c
> > new file mode 100644
> > index 0000000000000..59c0b3da483eb
> > --- /dev/null
> > +++ b/drivers/net/mdio/mdio-soce.c
> [ ... ]
> > +static void __iomem *soce_mdio_iomap(struct device *dev, int index)
> > +{
> > +	struct resource res;
> > +	int ret;
> > +
> > +	ret =3D of_address_to_resource(dev->of_node, index, &res);
> > +	if (ret)
> > +		return IOMEM_ERR_PTR(ret);
> > +
> > +	return devm_ioremap(dev, res.start, resource_size(&res));
> > +}
> [ ... ]
> > +static int soce_mdio_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct soce_mdio *priv;
> > +	struct mii_bus *bus;
> > +
> > +	bus =3D devm_mdiobus_alloc_size(dev, sizeof(*priv));
> > +	if (!bus)
> > +		return -ENOMEM;
> > +
> > +	priv =3D bus->priv;
> > +	priv->data =3D soce_mdio_iomap(dev, SOCE_MDIO_DATA_IOMAP_IDX);
> > +	if (IS_ERR(priv->data))
> > +		return PTR_ERR(priv->data);
> > +
> > +	priv->ctrl =3D soce_mdio_iomap(dev, SOCE_MDIO_CTRL_IOMAP_IDX);
> > +	if (IS_ERR(priv->ctrl))
> > +		return PTR_ERR(priv->ctrl);
>=20
> [Severity: High]
> If devm_ioremap() fails in soce_mdio_iomap(), it returns NULL. Because
> IS_ERR(NULL) evaluates to false, will this bypass the error check and all=
ow
> the driver to proceed with priv->data and priv->ctrl set to NULL?
>=20
> If the driver proceeds with NULL pointers, will subsequent PHY accesses=
=20
> through soce_mdio_read() and soce_mdio_write() pass those NULL pointers t=
o=20
> readl() and writel(), leading to a kernel panic?

That's true, I mixed up the APIs. That will be corrected with the
redesign to MFD.


