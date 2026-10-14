Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A884DD3B7;
	Wed, 14 Oct 2026 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980034; cv=none; b=G/ph8AaeseGptnvqVWCCPQ5OTngZdH8rzRMKYf7zr40gYt7VI1D0f086X5OAVYMQW7Ht6s2wrY9+8g6S25b20xSPUVzzbyniP7Z6fhjB82VMkUILDC8BrF2aG6Far4cVTwoPB1W12LmvusDNVJAlnaU4gOet2pM0Fol9JYGp7t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980034; c=relaxed/simple;
	bh=bsWV7edgf5H4LUUOJnwQrzqP7wVigR4RnBUZe3p3Z1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIJdPS1US3AC0bQ50bZnCV3kHz7xAhLbNtU9yMOy6fiMVzPxbkihT+oAKtjz+L5Gy+rWtLF85VQdUWAfL6XQ4N/Epiy2EvwbLLEIk5MB9aP8UMbjxM+TWGb7/xpc2xIbb3jnIJ6zf9iA3ClNQFLW+/TrmBlE3sIGISDnJNIlKWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3RNTW6C3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3RNTW6C3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kBvZwMjkY3SFTfW54L+/3JW1YEsME5Dm5IClIbBeKQk=; b=3RNTW6C3qq+Yy9VbhkvL85MEfl
	g+n8Vt2sBTZsNZ8N8u0Pi6SXJWtM5OjdMWSR9bikHwDTn2VtzwCCgW7VTpmD7PeQ3HMU7B/n/ZrgK
	25nwCzFwMHi2wa4eYssYtUCalSBjjBT4Nkh6Kcy4IrkPqzCeokZSh2QsqK+N8M5GqvEw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xGxrX-00Aj27-0o; Wed, 14 Oct 2026 14:13:39 +0200
Date: Wed, 14 Oct 2026 14:13:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Navid Ghahremani <ghahramani.navid@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
	stefandoesinger@gmail.com, krzk@kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 15/24] net: mdio: Add ZTE ZX279128S MDIO controller
Message-ID: <595371a9-6b7b-4ad9-985e-66f0e659f4a1@lunn.ch>
References: <20261014072109.1759502-1-ghahramani.navid@gmail.com>
 <20261014072109.1759502-16-ghahramani.navid@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014072109.1759502-16-ghahramani.navid@gmail.com>

> +static int zx279128s_mdio_xfer(struct mii_bus *bus, u32 op, int addr,
> +			       int regnum, u16 data)
> +{
> +	struct zx279128s_mdio *priv = bus->priv;
> +	void __iomem *base = priv->base;
> +	u32 cmd, val;
> +	int ret;
> +
> +	/* Clear the previous command and its status */
> +	writel(readl(base + ZX_MDIO_CMD) & ~ZX_MDIO_CMD_START,
> +	       base + ZX_MDIO_CMD);
> +	writel(0, base + ZX_MDIO_STATUS);
> +
> +	cmd = readl(base + ZX_MDIO_CMD);
> +	cmd &= ~(ZX_MDIO_CMD_WR | ZX_MDIO_CMD_RD | ZX_MDIO_CMD_ADDR |
> +		 ZX_MDIO_CMD_REG);
> +	cmd |= op | FIELD_PREP(ZX_MDIO_CMD_ADDR, addr) |
> +	       FIELD_PREP(ZX_MDIO_CMD_REG, regnum);
> +
> +	if (op == ZX_MDIO_CMD_WR)
> +		writel(data, base + ZX_MDIO_DATA_WR);
> +	writel(cmd | ZX_MDIO_CMD_START, base + ZX_MDIO_CMD);
> +
> +	ret = readl_poll_timeout(base + ZX_MDIO_STATUS, val,
> +				 val & ZX_MDIO_STATUS_DONE, ZX_MDIO_POLL_US,
> +				 ZX_MDIO_TIMEOUT_US);
> +	if (ret) {
> +		dev_err_ratelimited(&bus->dev, "timeout (addr %d, reg %d)\n",
> +				    addr, regnum);
> +		return ret;
> +	}
> +
> +	writel(0, base + ZX_MDIO_STATUS);
> +	writel(readl(base + ZX_MDIO_CMD) & ~ZX_MDIO_CMD_START,
> +	       base + ZX_MDIO_CMD);

This is the same as what you did at the beginning, but in the opposite
order. Is it actually needed, and can the same order be used?

> +static int zx279128s_mdio_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct zx279128s_mdio *priv;
> +	struct mii_bus *bus;
> +	struct clk *clk;
> +	u32 val;
> +
> +	bus = devm_mdiobus_alloc_size(dev, sizeof(*priv));
> +	if (!bus)
> +		return -ENOMEM;
> +
> +	priv = bus->priv;
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	clk = devm_clk_get_enabled(dev, "pclk");
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk),
> +				     "failed to get the register clock\n");
> +	clk = devm_clk_get_enabled(dev, "wclk");
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk),
> +				     "failed to get the work clock\n");
> +

Is this the bus clock? Does it need setting to 2.5Mhz?

> +static const struct of_device_id zx279128s_mdio_of_match[] = {
> +	{ .compatible = "zte,zx279128s-mdio" },
> +	{ }

It needs a device tree binding. But that is mostly boilerplate.

   Andrew
