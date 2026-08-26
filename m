Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C6A54774;
	Wed, 26 Aug 2026 00:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787702461; cv=none; b=tpP/K5pDqEdD5OZ8JzeHCjCvRCSIiiyzOyS//maBZo5/aYi/0t71O6hcChWy5xVyVLk3Be1WadekXEoAENwUkYsKGi8rkbMrnQ59zRDoQWGZuaBLvvLZ36KZSsWoCVdebI8VthdqnIBR2K31/WZNy7M6lhWfHksouFASv/s7eNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787702461; c=relaxed/simple;
	bh=WKHsVoHAncOAGjrrZgCOBfzYf+uVafryhuj2yc2N+0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOm9YVgzlhCU7OQm5JmwNUhwMDff3p6WKHLxydKBiTz8yZjAUXHBK3PUW+YdNCoI1m8ZdH30BUEAiFitqa9kynubqUz+wg477O7+4yc5/USD5YxDILfqAfGY2d2xhxi78uoadgZj2v0Pq1tgiOFz83+d0gd8nsvPhdCPaozllB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=B4x+Onjx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="B4x+Onjx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BT+cecgcNjbVR7I2Q6p5AdYr9Ocl1W16ZvyXVTG3eqE=; b=B4x+OnjxkiaofaZ3y8mFKXvSGh
	NBGAyEMoto4kBMslvsYJp/DWC7I5tMCpdB3KYWgR792J+1QPIrbpGDJgSgZWH6xbnxI7zrnkOZkF7
	uTuFNivYuT8spgqkFWdmP9bemtffuaco90nUzQHE5cZp8G1384+bHClkByE+Hf522CAo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wz140-001RNK-DQ; Wed, 26 Aug 2026 02:00:20 +0200
Date: Wed, 26 Aug 2026 02:00:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: netdev@vger.kernel.org, ansuelsmth@gmail.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, daniel@makrotopia.org,
	dqfext@gmail.com, SkyLake.Huang@mediatek.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 3/3] net: phy: mediatek: support EcoNet EN751221
 gbit SoC PHY
Message-ID: <d7d86078-8a29-4e7f-a62e-91f6b266bea1@lunn.ch>
References: <20260825193456.1823985-1-cjd@cjdns.fr>
 <20260825193456.1823985-4-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825193456.1823985-4-cjd@cjdns.fr>

> +static int en751221_tx_amp_compensation_tbl[2][TRANSFORMER_TYPE_MAX][MDI_TYPE_MAX][CALIB_CONST_TYPE_MAX][4] = {

const?

> +static u8 en751221_zcal_to_r50ohm[64] = {

const?

> +	125, 125, 125, 125, 125, 125, 124, 121, 118, 115, 112, 110, 108, 105, 103, 101,
> +	 99,  97,  95,  77,  75,  73,  72,  70,  68,  67,  65,  64,  63,  45,  44,  43,
> +	 41,  40,  39,  38,  37,  36,  35,  34,  32,  32,  31,  30,  13,  12,  11,  10,
> +	  9,   8,   8,   7,   6,   5,   5,   4,   3,   2,   2,   1,   0,   0,   0,   0
> +};

> +/* EN751221 also mirrors RG_BG_RASEL into CHIP SCU register 0x16c. */
> +static void en751221_gphy_mirror_rext(struct phy_device *phydev, u8 zcal)
> +{
> +	struct regmap *chip_scu;
> +
> +	chip_scu = syscon_regmap_lookup_by_compatible("econet,en751221-chip-scu");

Does this need a change to the binding document?

> +static int en751221_gphy_config_init(struct phy_device *phydev)
> +{
> +	phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV, 0);

Why is the EEE register being cleared?

> +
> +	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
> +	__mtk_tr_write(phydev, 0x1, 0xf, 0x00, 0x00002b);
> +	__mtk_tr_write(phydev, 0x1, 0xf, 0x03, 0x082422);
> +	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
> +
> +	ret = phy_write(phydev, MII_CTRL1000,
> +			ADVERTISE_1000FULL | CTL1000_PREFER_MASTER |
> +			CTL1000_AS_MASTER | CTL1000_ENABLE_MASTER);

What does this default to?

> +
> +	phy_set_bits(phydev, MII_BMCR, BMCR_ANRESTART | BMCR_ANENABLE);

Why? config_aneg() will do this, if needed.

     Andrew
