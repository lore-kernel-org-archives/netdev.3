Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A782AD3F;
	Tue,  8 Sep 2026 00:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788827860; cv=none; b=JPcZpu52hiO0LsWpi6YKNcsdIpaRvkhQl96gbhI3EB1DGPDsr+CbsGy4Z1XAHvzTdaaqbAaBpNW/7JGgBTpz7OAiUsucXx3ENDo8NzWMeqiN+WxiMxQaA/DndzAyi1O4NsSiUjGsQJdlYC7IJBOWmGFMW5Sh8m3CJ3QP+5I6xdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788827860; c=relaxed/simple;
	bh=IKw2ovvy3IOlo6jfnruSh9dsAAEfA1m0YtBMgfwSb4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJ6ElztH3+Ap2u5Y6yEx0AwpVLUTy/1GH21Yt3BrHhK1l8qJgXf2f9HNONK3dpOCJ1zLkeSka7kj31S3DGISdYExayw0WWrP5NF46XBswsF5MbWEDhsAMyk6rtNQ3lWnj21gByBkMMFbMWcCl9r4wGD2HiByV1PFyBz5QqchSLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ybhixKYJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ybhixKYJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xnYcE0Rf/EXE81RhRc6Fe8k5kIH/QdIiqftzkJWaxJo=; b=ybhixKYJe1/gU9Wx6bRVdMGAe4
	osB0suz3FtG3iioMTL2TuySg0oYv1ES2IncBMqsVbc0kkX2ukWRT7IejTgX0MY/wF0qsExZ1tIgTb
	/Qivqr1rgQpg1eixi4pX3bnr9GMP/zkDGHhjZk+dQjFqgBALF0817TcHn1oS81kz0HPk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3jq3-003gOy-Vr; Tue, 08 Sep 2026 02:37:27 +0200
Date: Tue, 8 Sep 2026 02:37:27 +0200
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
Message-ID: <371fe855-e21f-4d53-a13f-4486494c8ae1@lunn.ch>
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

> +#define SOCE_CORE_VERSION_SHIFT			24
> +#define SOCE_CORE_SUBVERSION_SHIFT		16
> +#define SOCE_LICENSED_NUM_PORTS_MASK		GENMASK(31, 27)
> +#define SOCE_IMPLEMENTED_NUM_PORTS_MASK		GENMASK(31, 27)
> +#define SOCE_IMPLEMENTED_DSA			BIT(23)
> +#define SOCE_DSA_REGS_BASE			0x1200
> +#define SOCE_TAG_ALL_FRAMES_CTRL_OFFSET		(SOCE_DSA_REGS_BASE + 0x001c)
> +#define SOCE_TAG_ALL_FRAMES_ENABLE		BIT(0)
> +#define SOCE_CUSTOM_RULES_TAGGING_OFFSET	(SOCE_DSA_REGS_BASE + 0x0020)
> +#define SOCE_CUSTOM_RULES_TAGGING_ENABLE	BIT(0)
> +#define SOCE_MIN_CORE_VERSION			0x24
> +#define SOCE_MIN_CORE_SUBVERSION		0x01

Could you fully describe the feature registers, so we have an idea
what is actually there.

> +struct soce_probe_desc {
> +	u32 core_version_offset;
> +	u32 licensed_features_offset;
> +	u32 implemented_features0_offset;
> +	u32 mdio_master_offset;
> +};
> +
> +static const struct soce_probe_desc soce_probe_desc_swip_00_04_0c_10 = {
> +	.core_version_offset		= 0x0000,
> +	.licensed_features_offset	= 0x0004,
> +	.implemented_features0_offset	= 0x000c,
> +	.mdio_master_offset		= 0x0200,
> +};

How fixed/variable are these? I'm just thinking there may be too much
abstraction here. To some extent, we leave abstractions out until they
are needed. If you know there are other devices out there which have
these at other addresses, then O.K. But if not, i would keep it KISS.

> +static int soce_sw_detect_features(struct soce_dsa_local *local,
> +				   const struct soce_probe_desc *probe_desc,
> +				   u32 *numports)
> +{
> +	u32 implemented_numports;
> +	u32 licensed_numports;
> +	u32 regval;
> +
> +	regval = readl(local->base_addr + probe_desc->licensed_features_offset);
> +	licensed_numports = FIELD_GET(SOCE_LICENSED_NUM_PORTS_MASK, regval);
> +	if (!licensed_numports || licensed_numports > SOCE_MAX_NUM_PORTS)
> +		return -EINVAL;
> +
> +	regval = readl(local->base_addr +
> +		       probe_desc->implemented_features0_offset);
> +	if (!(regval & SOCE_IMPLEMENTED_DSA))
> +		return -ENODEV;

I find it useful to have macros like SOCE_IMPLEMENTED_DSA indicate
they apply to features0. It makes it easier to spot dumb typos when
you apply it to features1, not features0.

I also wounder at the name. Does the data sheet really call it DSA?

> +
> +	implemented_numports = FIELD_GET(SOCE_IMPLEMENTED_NUM_PORTS_MASK,
> +					 regval);
> +	if (!implemented_numports ||
> +	    implemented_numports > licensed_numports)
> +		return -EINVAL;
> +
> +	*numports = implemented_numports;

How is this going to scale when you need to look at more bits in these
registers? It seems like at some point you are going to need to pass a
structure to be filled in.

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

Why the comment. How is it relevant?

> +static int soce_mdio_23_02_read_c22(struct dsa_switch *ds, int mdio_output,
> +				    int phy_addr, int regnum)
> +{
> +	void __iomem *ctrl, *params, *read_reg;
> +	struct soce_priv *priv = ds->priv;
> +	struct soce_dsa_local *local;
> +	u32 regvalue;
> +	int ret;
> +
> +	local = &priv->local;
> +	ctrl = local->mdio_master_addr + SOCE_MDIO_CTRL_OFFSET;
> +	params = local->mdio_master_addr + SOCE_MDIO_23_02_PARAMS_OFFSET;
> +	read_reg = local->mdio_master_addr + SOCE_MDIO_23_02_READ_OFFSET;
> +
> +	regvalue = (regnum << SOCE_MDIO_23_02_CTRL_REGADDRDEVTYPE_OFFSET) +
> +		   (phy_addr << SOCE_MDIO_23_02_CTRL_PHYADDR_OFFSET);
> +	writel(regvalue, params);
> +
> +	regvalue = ((mdio_output << SOCE_MDIO_23_02_CTRL_BUS_OFFSET) +
> +		    (0x3 << SOCE_MDIO_23_02_CTRL_TRANSTYPE_OFFSET) +

0x3 means read?

> +		    (0x0 << SOCE_MDIO_23_02_CTRL_CLAUSE_OFFSET) +

0x0 means C22

> +		    (0x1 << SOCE_MDIO_23_02_CTRL_OPSTATUS_OFFSET));

What does 0x1 mean? Please add some #defines for theses to act as
documentation.

	Andrew
