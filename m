Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3BB3CAE7F;
	Tue, 25 Aug 2026 19:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787686859; cv=none; b=TAoyP9PzeTGlMf25DE85zB1c9VahPk10BMcEwArBM5BrIRnQC/TZAKdebGAdHYCj5BFoEZ4cfeKfQavA7xM9THuaKV8BUaY+94m0sxLJWjx9ORRJl5BDUOZ/zlkxd1j3IdE4IUteuyCycDPP8et3XISpUsFshmlAOz5A77C2KJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787686859; c=relaxed/simple;
	bh=xR96xWT/b+p92BftGWjl4t/jA1nWiEqmFLOzNlErCNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUQew6RSvXdIZpBZjKRtF6dAMdw5uMtAeej9/eLUp2FKRsOByNk9bkJZwMwVG5Lx9EEDRpGXCJqvFOTNkjm56e32mgTwTYi8bHsnl7Oe2zD7wtRArBaFVFCMTNDrCXUMlRadgwtr/bAXfgGsKjl+mcC/i2XzmmGPU6r4EQFgZY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BRTed0I4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BRTed0I4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ywl9rM+RyCaxh1imXNV0yvvFlJD6cSPcxQEJ3SAkPxc=; b=BRTed0I46j4vwIEyN5+5QfhmW8
	aPx8l00iMijXWRqy60MR/o/dIcsaVQQ07VFWJtNrZiTVmm78i5bY9QtRHX3zHcf/jyL2PJD1XdS/2
	448B4e45kudXTLjxrBuABsPyf3Ifxg94WFZc3OJ2bdLB0PIGOQof94qtOYGrQOxdWN3Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wyx0c-001QCU-M3; Tue, 25 Aug 2026 21:40:34 +0200
Date: Tue, 25 Aug 2026 21:40:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, daniel@makrotopia.org,
	naseefkm@gmail.com, joey@tinyisr.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] net: phy: mediatek: add driver for EcoNet Fast
 Ethernet SoC PHYs
Message-ID: <177dc347-4cf9-48ca-97fe-b0f3cd46d8e3@lunn.ch>
References: <20260825180421.1804729-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825180421.1804729-1-cjd@cjdns.fr>

> Also provide support for the older EN7512 Fast Ethernet SoC PHYs found
> in EN751221 chips with do not have the MCM switch. That is chips which
> do not have a "G" in the name. As these PHYs bear the ID 03a2.9412
> which collides with MTK_GPHY_ID_MT7530 gigabit PHY, do not match them
> and instead rely on the user to override the PHY ID in the device tree
> if they wish to use this driver.

Is there a way to tell them apart using other registers?

> +static int en751221_fephy_r50(struct phy_device *phydev)
> +{
> +	struct econet_socphy_shared *shared = phy_package_get_priv(phydev);
> +	struct compensation ctab = get_ctab(phydev);
> +	int zcal_sz = ARRAY_SIZE(zcal_to_r50ohm);
> +	u8 rg_zcal_ctrl = ECONET_R50_ZCAL_DEFAULT;

Please swap these two lines.

> +	for (;;) {

It is unusual to do loops like this. Can it be turned into a do while
loop? And without looking deep into it, it is not clear if this is
endless if the hardware stops responding.

> +static int en751221_fephy_tx_offset(struct phy_device *phydev)
> +{
> +	struct econet_socphy_shared *shared = phy_package_get_priv(phydev);
> +	struct compensation ctab = get_ctab(phydev);
> +	int initial_comp_out;
> +	int polarity = 0;
> +	int offset = ECONET_TXOS_DEFAULT;
> +	u16 offset_bin;
> +	int comp_out;
> +	int ret = 0;

Another reverse christmas tree issue. Please check all your functions.

> +static int en751221_fephy_config_init(struct phy_device *phydev)
> +{
> +	struct econet_socphy_shared *shared = phy_package_get_priv(phydev);
> +	u16 l0r26_temp;
> +	int ret;
> +	int i;
> +
> +	if (!shared->phydev_p0) {
> +		phydev_err(phydev, "Port zero must be configured\n");
> +		return -EOPNOTSUPP;
> +	}

What is the issue here? Why must port 0 be first?

> +
> +	for (i = 0; i < 5; i++) {
> +		ret = en751221_fephy_r50(phydev);
> +		if (!ret)
> +			break;
> +	}
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < 5; i++) {
> +		ret = en751221_fephy_tx_offset(phydev);
> +		if (!ret)
> +			break;
> +	}
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < 5; i++) {
> +		ret = en751221_fephy_tx_amp(phydev);
> +		if (!ret)
> +			break;
> +	}

Why 5 ?


    Andrew

---
pw-bot: cr
