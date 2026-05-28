Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15063E833F;
	Thu, 28 May 2026 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779972014; cv=none; b=akQ2FKgffUeUKMdCHksleV7ULtjFVMmNPu1zgU5oI1PSUz3ICSJK3NU2ZcWS7U1gPOZ9Citt39JsuK6xeFQibK+lprmWj+L+/kFpBdUubFHhx0qaymnQbQG9QI5SiFRGfuQkr52DYLQuT4NyvrUyKZL3JYKNtrQL9sbYngRLK2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779972014; c=relaxed/simple;
	bh=TUaKSSYzOh+tCNAPuYkd6Rh0mn5Q5LNmZrKQiU/rzoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uX53zMTqsxDWD4VJFk144U5ZI4X3kasPBNn/nAtA/BEPQtaXzf698ste6NthpnG71zuqTH2M2Z7EtRkFEQQ8TNSsJLsb19xBBfr34gt6KnzGznZvn4q3WNVtfeUKAOiPoBUuZiX9R8l10ViRBw79i2pnARwDUfNBTv9gbS+w8a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vTNG3HfA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vTNG3HfA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Tl4dkmOXE83LrtwSDbBI8r2aOtU+kjp1aSTVhNG/37g=; b=vTNG3HfANGUqSlk7KcL7wn/vZR
	AGN++yyagZVgLgPDbgQYVOWj1lAkSdsRdTexm+dvkkMDXtLuP0q1BhTSrBHJGDR2DRraqeHXBQerM
	+YTn+Bv786tMkdPq2xeOO8pkCDrjyfOTY8gVy73/6JIHNp2Nq5Kz62J/v3DFjLVFkPyM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSa1l-004tuZ-9z; Thu, 28 May 2026 14:39:57 +0200
Date: Thu, 28 May 2026 14:39:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	freddy_gu@realsil.com.cn, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel@makrotopia.org,
	vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v1 1/2] net: phy: realtek: add support for
 RTL8261
Message-ID: <a9f0800b-7aa6-41e9-bab2-bdd1f4dd9534@lunn.ch>
References: <20260528075226.1054-1-javen_xu@realsil.com.cn>
 <20260528075226.1054-2-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528075226.1054-2-javen_xu@realsil.com.cn>

> +static int rtl8261x_soft_reset(struct phy_device *phydev)
> +{
> +	int ret, val;
> +
> +	ret = phy_set_bits_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_CTRL1, MDIO_CTRL1_RESET);
> +	if (ret < 0)
> +		return ret;
> +
> +	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_PMAPMD,
> +					 MDIO_CTRL1, val,
> +					 !(val & MDIO_CTRL1_RESET),
> +					 5000, 100000, true);

We have a few copies of this function in various PHY drivers. Please
add a genphy_c45_soft_reset() helper.

> +}
> +
> +static int rtl8261x_probe(struct phy_device *phydev)
> +{
> +	struct device *dev = &phydev->mdio.dev;
> +	struct rtl8261x_priv *priv;
> +	int sub_phy_id, ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, RTL8261X_EXT_ADDR_REG,
> +			    RTL_8261X_SUB_PHY_ID_ADDR);
> +	if (ret < 0)
> +		return ret;

blank line

> +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL8261X_EXT_DATA_REG);
> +	if (ret < 0)
> +		return ret;
> +
> +	sub_phy_id = (ret >> 8) & 0xff;
> +	priv->sub_phy_id = sub_phy_id;
> +	priv->is_generic = false;
> +
> +	switch (sub_phy_id) {
> +	case RTL8261C_CE_MODEL:
> +		priv->model = RTL8261_MODEL_C_CE;
> +		phydev_info(phydev, "RTL8261C/CE detected (sub_id 0x%02x)\n", sub_phy_id);
> +		break;
> +
> +	case RTL8261D_MODEL:
> +		priv->model = RTL8261_MODEL_D;
> +		phydev_info(phydev, "RTL8261D detected (sub_id 0x%02x)\n", sub_phy_id);
> +		break;
> +
> +	default:
> +		priv->model = RTL8261_MODEL_GENERIC;
> +		priv->is_generic = true;
> +		phydev_warn(phydev, "Unknown sub_id 0x%02x! Using GENERIC mode. Update driver for full support.\n",
> +			    sub_phy_id);
> +		break;

This will get ignored. It is better to return -ENODEV so the probe
fails.

	Andrew
