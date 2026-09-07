Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0631B4FB9B8;
	Mon,  7 Sep 2026 19:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788809315; cv=none; b=OudM94bMluFQ4bjUCsqCwSJFdfpQ/Pj8LoIaG75RISeKMUcKyS1+DKW0M/XISle/+plXR9Thx+STwGtIDcFUKoWJPS7FIOoBOzmiyMEUpqRiehse0Q/K/IOO1TLOWM44mDwmyWFxN87RBtzMH2uHV6eZrNf9CxQcpQww6ezNuWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788809315; c=relaxed/simple;
	bh=GpWLUF/cOPE67N4nLaEEaqtCZZY+HHLd/s1QQGJTUOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hW3ualTHRdzSjJ/oC9ocjw5/NnxyVLyXBGjy/lxAREYLD0848HGXN/jeHZCiBS5/94mzBejCn7IIRf3urVBcr6TxqAp+k0TpmkUJpuoaW9zUcpDojTsv9HH4VzigdorDtNwrb6BxKI0TpZVgGVQFGnSDKW2jECPZD2DB7PmxqQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zdvEHIJp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zdvEHIJp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5C+dVUlcvBaOxX6mLwUe0cyuABYSMsgJjYxwPsJA6HE=; b=zdvEHIJpRpL8Fmdz2c3E0u68PW
	vanlygKR4MnHvIpljfzPbGesX8X+WwZsV9P6leelwe36m1eVEWriS+eHwvAptw7n5ZQlLFiEHtMjL
	P8GsX6Fkf9VSb+bWI73ZoSsah0IdfD/5Jnn6X7BeRDPFbtV2bmu0H6nbJL1Qy9hGhYm4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3f0z-003c2Q-AP; Mon, 07 Sep 2026 21:28:25 +0200
Date: Mon, 7 Sep 2026 21:28:25 +0200
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
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH net-next v2 4/4] net: dsa: soce: Add basic support for
 SoC-e switch IP cores
Message-ID: <3c2c5b39-6a7d-4cb2-af1c-b5015b6bf1e8@lunn.ch>
References: <20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
 <20260903-devel-vstrassheim-soce-dsa-ml-v2-4-fb0587cb466b@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903-devel-vstrassheim-soce-dsa-ml-v2-4-fb0587cb466b@linutronix.de>

> +#define SOCE_MAX_NUM_PORTS 31
> +#define SOCE_MAX_MDIO_ADDR 32

Given what the binding says, that looks odd.

> +#define SOCE_MAX_MDIO_OUTPUTS SOCE_MAX_NUM_PORTS
> +
> +struct dsa_switch;
> +
> +struct soce_mdio_ops {
> +	int (*phy_read)(struct dsa_switch *ds, int mdio_output, int phy_addr,
> +			int regnum);
> +	int (*phy_write)(struct dsa_switch *ds, int mdio_output, int phy_addr,
> +			 int regnum, u16 val);
> +	int (*phy_read_c45)(struct dsa_switch *ds, int mdio_output, int phy_addr,
> +			    int devad, int regnum);
> +	int (*phy_write_c45)(struct dsa_switch *ds, int mdio_output, int phy_addr,
> +			     int devad, int regnum, u16 val);
> +};
> +
> +struct soce_dsa_local {
> +	void __iomem *base_addr;
> +	void __iomem *mdio_master_addr;
> +	/* Serializes all logical buses sharing the MDIO master. */
> +	struct mutex mdio_lock;

What is the MDIO master?

> +static const struct soce_mdio_ops soce_mdio_ops_c22_c45 = {
> +	.phy_read	= soce_mdio_23_02_read,
> +	.phy_write	= soce_mdio_23_02_write,
> +	.phy_read_c45	= soce_mdio_23_02_read_c45,
> +	.phy_write_c45	= soce_mdio_23_02_write_c45,
> +};

It seems like this is the only struct soce_mdio_ops. Does the IP
support different MDIO buses? Is this level of abstraction actually
needed?

> +static inline bool soce_mdio_output_valid(int mdio_output)
> +{
> +	return mdio_output >= 0 && mdio_output < SOCE_MAX_MDIO_OUTPUTS;
> +}

No inline functions in .c files. Let the compile decide.

> +static inline bool soce_mdio_addr_valid(int phy_addr)
> +{
> +	return phy_addr >= 0 && phy_addr < SOCE_MAX_MDIO_ADDR;
> +}
> +
> +static inline bool soce_mdio_c22_reg_valid(int regnum)
> +{
> +	return regnum >= 0 && regnum <= SOCE_MDIO_C22_REG_MAX;
> +}
> +
> +static inline bool soce_mdio_c45_params_valid(int devad, int regnum)
> +{
> +	return devad >= 0 && devad <= SOCE_MDIO_C45_DEVAD_MAX &&
> +	       regnum >= 0 && regnum <= SOCE_MDIO_C45_REG_MAX;
> +}

Do you see any other MDIO driver doing this sort of checking?

> +static int soce_mdio_read(struct mii_bus *bus, int addr, int reg)
> +{
> +	struct soce_mdio_bus *state = bus->priv;
> +	struct soce_dsa_local *local;
> +	struct soce_priv *priv;
> +	int ret;
> +
> +	priv = state->ds->priv;
> +	local = &priv->local;
> +
> +	if (!local->mdio_ops || !local->mdio_ops->phy_read)
> +		return -EOPNOTSUPP;
> +
> +	if (!soce_mdio_addr_valid(addr))
> +		return -EINVAL;
> +
> +	mutex_lock(&local->mdio_lock);
> +	ret = local->mdio_ops->phy_read(state->ds, state->mdio_output, addr,
> +					reg);
> +	mutex_unlock(&local->mdio_lock);

What is the lock protecting?

> +static int soce_register_mdio_bus(struct soce_priv *priv, struct device *dev,
> +				  struct device_node *mdio_np,
> +				  u32 mdio_output)
> +{
> +	struct soce_mdio_bus *state;
> +	struct mii_bus *bus;
> +
> +	bus = devm_mdiobus_alloc(dev);
> +	if (!bus)
> +		return -ENOMEM;
> +
> +	state = devm_kzalloc(dev, sizeof(*state), GFP_KERNEL);
> +	if (!state)
> +		return -ENOMEM;
> +
> +	state->ds = priv->ds;
> +	state->mdio_output = mdio_output;

Can you think of a better name than mdio_output. It seems to be the
bus number?

> +
> +	bus->priv = state;
> +	bus->name = "soce mdio";
> +	bus->read = soce_mdio_read;
> +	bus->write = soce_mdio_write;
> +	bus->read_c45 = soce_mdio_read_c45;
> +	bus->write_c45 = soce_mdio_write_c45;
> +	/* ds->dst can be NULL during probe, before dsa_register_switch() */
> +	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-mdio-%u", dev_name(dev),
> +		 mdio_output);
> +	bus->parent = dev;
> +
> +	return devm_of_mdiobus_register(dev, bus, mdio_np);
> +}
> +int soce_mdio_23_02_read_c45(struct dsa_switch *ds, int mdio_output,
> +			     int phy_addr, int devad, int regnum)
> +{
> +	void __iomem *ctrl, *params, *read_reg, *write_reg;
> +	struct soce_priv *priv = ds->priv;
> +	struct soce_dsa_local *local;
> +	u32 regvalue;
> +	int ret;
> +
> +	if (!soce_mdio_output_valid(mdio_output) ||
> +	    !soce_mdio_addr_valid(phy_addr) ||
> +	    !soce_mdio_c45_params_valid(devad, regnum))
> +		return -EINVAL;

Hasn't this already been checked once?

	Andrew
