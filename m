Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9266857F747;
	Tue,  8 Sep 2026 18:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788893101; cv=none; b=Os/vdpzy6/ZdEFkq2xCH8Q61QzT31IUj5KKpl4YJwjuk0gxL82+bCYSBQw0V8JtWuwBf7BnwtO1zGlmnDBejB4aEiDLSJo5aCbzKIRTsoingywqHoF/GJwV2xJ0xpHOXHqFFJcMEUsLnsBi+AsioBkUJKAxSH85xzxKtAFY6DtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788893101; c=relaxed/simple;
	bh=N5co+aE8e2LydOe+1tYMAvS47BmQhi/QQTky/RR2Jxc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F7qf/k2wXf+HYxrjNmSjyMqdcuvEZeJjPfNNvW0EJ4tFXD9YMEJ/Dr/tAwzUcRQquQbfIyM0734fh1UAfg2MmuWwMZ8FvgmWgOCuUHDjvKYUJYDP/qkxDNauyLY4rblLIb0Mxc+VIWhUSKFBA5RQtl6vx91otAZs6XHTsjo3Ffc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NEzzRmrw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mX7e79/D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NEzzRmrw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mX7e79/D"
Message-ID: <db26d5c9262069a11e5cbe00e176b81e40baebeb.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788893094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kvq7ebmlb9noJ+zywPDpf0+rQyqEU+rhaZi6VKfJDDs=;
	b=NEzzRmrwtLrq0ba5Q4a+ggYdKtJ1gBZXuNws6d1zU2RennDIktYlM9k5hAyWGEI6kmFWyE
	cAPgIMKgUgSv1X4DSlJUjfmngYLqR1yc5Z2bax1/J4Xn+BetRmj90qKpLMPOPSpl/7x8fY
	NA6bjRTDDvxVkDFq1uRrz0RrkR2DUyTwa5F7xU/MSRGIf8N9uquO6Phg9Wn2H5I7yEZ8LB
	OhRy5BJxnQVuktWoyRbZaFim7Y3MuJaax4+/AfIo82wAAEDSqoRcWYGEBuOPS6+kUyVMB6
	wGKxU8KZA8UGmQaScis3r0DPHOEi2xQA/bQf+4db1JPSRbPHvhkeNOE8nhckJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788893094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kvq7ebmlb9noJ+zywPDpf0+rQyqEU+rhaZi6VKfJDDs=;
	b=mX7e79/Diyb1yoBxFcfBImw2V/tV+D8nzcoHG9A+7D3A6OTWx+pC9C9nWAz4s0SlQi1esp
	ZsQ+gknTtUsSrbBw==
Subject: Re: [PATCH net-next v2 4/4] net: dsa: soce: Add basic support for
 SoC-e switch IP cores
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,  Martin Kaistra
 <martin.kaistra@linutronix.de>, Benedikt Spranger <b.spranger@linutronix.de>
Date: Tue, 08 Sep 2026 20:44:53 +0200
In-Reply-To: <3c2c5b39-6a7d-4cb2-af1c-b5015b6bf1e8@lunn.ch>
References: 
	<20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
	 <20260903-devel-vstrassheim-soce-dsa-ml-v2-4-fb0587cb466b@linutronix.de>
	 <3c2c5b39-6a7d-4cb2-af1c-b5015b6bf1e8@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-07 at 21:28 +0200, Andrew Lunn wrote:
> > +#define SOCE_MAX_NUM_PORTS 31
> > +#define SOCE_MAX_MDIO_ADDR 32
>=20
> Given what the binding says, that looks odd.
>=20

The checks using these constants are unnecessary. I will remove them and
clarify the 31-port hardware limit.

> > +#define SOCE_MAX_MDIO_OUTPUTS SOCE_MAX_NUM_PORTS
> > +
> > +struct dsa_switch;
> > +
> > +struct soce_mdio_ops {
> > +	int (*phy_read)(struct dsa_switch *ds, int mdio_output, int phy_addr,
> > +			int regnum);
> > +	int (*phy_write)(struct dsa_switch *ds, int mdio_output, int phy_addr=
,
> > +			 int regnum, u16 val);
> > +	int (*phy_read_c45)(struct dsa_switch *ds, int mdio_output, int phy_a=
ddr,
> > +			    int devad, int regnum);
> > +	int (*phy_write_c45)(struct dsa_switch *ds, int mdio_output, int phy_=
addr,
> > +			     int devad, int regnum, u16 val);
> > +};
> > +
> > +struct soce_dsa_local {
> > +	void __iomem *base_addr;
> > +	void __iomem *mdio_master_addr;
> > +	/* Serializes all logical buses sharing the MDIO master. */
> > +	struct mutex mdio_lock;
>=20
> What is the MDIO master?

It refers to the switch-integrated MDIO controller: one shared set of
MMIO transaction registers serving multiple selectable MDIO buses. The
switch documentation calls it an MDIO bridge. I will rename "master" to
"controller".

>=20
> > +static const struct soce_mdio_ops soce_mdio_ops_c22_c45 =3D {
> > +	.phy_read	=3D soce_mdio_23_02_read,
> > +	.phy_write	=3D soce_mdio_23_02_write,
> > +	.phy_read_c45	=3D soce_mdio_23_02_read_c45,
> > +	.phy_write_c45	=3D soce_mdio_23_02_write_c45,
> > +};
>=20
> It seems like this is the only struct soce_mdio_ops. Does the IP
> support different MDIO buses? Is this level of abstraction actually
> needed?
>=20

Older IP versions used a different register layout. Since this driver
currently supports only one variant, I will remove the abstraction. It
can be added back when another variant is supported.

> > +static inline bool soce_mdio_output_valid(int mdio_output)
> > +{
> > +	return mdio_output >=3D 0 && mdio_output < SOCE_MAX_MDIO_OUTPUTS;
> > +}
>=20
> No inline functions in .c files. Let the compile decide.

Yes, I will fix this along with some other issues reported by the
patchwork checks.

>=20
> > +static inline bool soce_mdio_addr_valid(int phy_addr)
> > +{
> > +	return phy_addr >=3D 0 && phy_addr < SOCE_MAX_MDIO_ADDR;
> > +}
> > +
> > +static inline bool soce_mdio_c22_reg_valid(int regnum)
> > +{
> > +	return regnum >=3D 0 && regnum <=3D SOCE_MDIO_C22_REG_MAX;
> > +}
> > +
> > +static inline bool soce_mdio_c45_params_valid(int devad, int regnum)
> > +{
> > +	return devad >=3D 0 && devad <=3D SOCE_MDIO_C45_DEVAD_MAX &&
> > +	       regnum >=3D 0 && regnum <=3D SOCE_MDIO_C45_REG_MAX;
> > +}
>=20
> Do you see any other MDIO driver doing this sort of checking?

No. I will remove all redundant checks.=20

>=20
> > +static int soce_mdio_read(struct mii_bus *bus, int addr, int reg)
> > +{
> > +	struct soce_mdio_bus *state =3D bus->priv;
> > +	struct soce_dsa_local *local;
> > +	struct soce_priv *priv;
> > +	int ret;
> > +
> > +	priv =3D state->ds->priv;
> > +	local =3D &priv->local;
> > +
> > +	if (!local->mdio_ops || !local->mdio_ops->phy_read)
> > +		return -EOPNOTSUPP;
> > +
> > +	if (!soce_mdio_addr_valid(addr))
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&local->mdio_lock);
> > +	ret =3D local->mdio_ops->phy_read(state->ds, state->mdio_output, addr=
,
> > +					reg);
> > +	mutex_unlock(&local->mdio_lock);
>=20
> What is the lock protecting?

It serializes accesses to the shared MDIO controller transaction
registers across all MDIO buses.

>=20
> > +static int soce_register_mdio_bus(struct soce_priv *priv, struct devic=
e *dev,
> > +				  struct device_node *mdio_np,
> > +				  u32 mdio_output)
> > +{
> > +	struct soce_mdio_bus *state;
> > +	struct mii_bus *bus;
> > +
> > +	bus =3D devm_mdiobus_alloc(dev);
> > +	if (!bus)
> > +		return -ENOMEM;
> > +
> > +	state =3D devm_kzalloc(dev, sizeof(*state), GFP_KERNEL);
> > +	if (!state)
> > +		return -ENOMEM;
> > +
> > +	state->ds =3D priv->ds;
> > +	state->mdio_output =3D mdio_output;
>=20
> Can you think of a better name than mdio_output. It seems to be the
> bus number?
>=20

Yes, it is the bus selector. I will rename it to mdio_bus_id.

> > +
> > +	bus->priv =3D state;
> > +	bus->name =3D "soce mdio";
> > +	bus->read =3D soce_mdio_read;
> > +	bus->write =3D soce_mdio_write;
> > +	bus->read_c45 =3D soce_mdio_read_c45;
> > +	bus->write_c45 =3D soce_mdio_write_c45;
> > +	/* ds->dst can be NULL during probe, before dsa_register_switch() */
> > +	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-mdio-%u", dev_name(dev),
> > +		 mdio_output);
> > +	bus->parent =3D dev;
> > +
> > +	return devm_of_mdiobus_register(dev, bus, mdio_np);
> > +}
> > +int soce_mdio_23_02_read_c45(struct dsa_switch *ds, int mdio_output,
> > +			     int phy_addr, int devad, int regnum)
> > +{
> > +	void __iomem *ctrl, *params, *read_reg, *write_reg;
> > +	struct soce_priv *priv =3D ds->priv;
> > +	struct soce_dsa_local *local;
> > +	u32 regvalue;
> > +	int ret;
> > +
> > +	if (!soce_mdio_output_valid(mdio_output) ||
> > +	    !soce_mdio_addr_valid(phy_addr) ||
> > +	    !soce_mdio_c45_params_valid(devad, regnum))
> > +		return -EINVAL;
>=20
> Hasn't this already been checked once?

Yes, I will remove this and other redundant checks.=20

>=20
> 	Andrew

Thanks,
Vasilij

