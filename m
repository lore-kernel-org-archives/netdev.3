Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1AC4071D3;
	Sat,  6 Jun 2026 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780740464; cv=none; b=UYOnKiE2lkpqaamtSNbqCJtXammQVvYauS82SxSdUm0cGI2c7TNHyB9hgkvnU/jtEGle1TdQ6F3dfs7VArtRHc98VL6vzvSCuwNcjM750yr4yRrJm6z6MDtaE71PdwbbDcS+iCasriUz/74vUiGQAjtRHZA/q8d1COPZZuPeyV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780740464; c=relaxed/simple;
	bh=4BslzL+ARXEPnTid1DJytVgMQc0Nu0Vs4d3xFGiGk9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNCtvpiOJRWTUOKyraFXT1fJDLOxSmDsDBe5D5BDRJGClGuqlQbavLIXXgyGHtnI9gkUqEZS+nloobFyihOIcajLL3bZd0LDf9uybPPKqBrfhmR+zxJHw4xtWr0arxisHLVgx3g2hEOXMTn+uWABjYNmMPVau/X4RJgPxIMb4yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OyNjaYho; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OyNjaYho"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0CwNNUWWPls6tt9UyUu7rLKZZqNM5VpF/yAu79dPnRY=; b=OyNjaYhoSYdv4/Qa5BdAYbb7cT
	ysl4hzI0F7Kcqr0pGlXeAzl6i+CdFoMYTwtGaIQUBQS8YihKaNWAwvc71TsYKC+mIPI8w08clFY1/
	+0e2e8m/gaFwS7yV3JZH+iJTQ26gjXb6zbKrolHQ2ajXObc2E6MSAWh3CbN+fBGrzUIc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wVnwD-006MLw-Br; Sat, 06 Jun 2026 12:07:33 +0200
Date: Sat, 6 Jun 2026 12:07:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1 2/6] r8169: add support for phylink
Message-ID: <2ec29d2b-51f3-4b36-951d-f04f2759ae03@lunn.ch>
References: <20260605103906.1445-1-javen_xu@realsil.com.cn>
 <20260605103906.1445-3-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605103906.1445-3-javen_xu@realsil.com.cn>

> +static void rtl_mac_link_up(struct phylink_config *config, struct phy_device *phydev,
> +			    unsigned int mode, phy_interface_t interface,
> +			    int speed, int duplex, bool tx_pause, bool rx_pause)
> +{
> +	struct rtl8169_private *tp = container_of(config, struct rtl8169_private, phylink_config);
> +
> +	struct device *d = tp_to_dev(tp);
> +
> +	tp->current_speed = speed;
> +	rtl_link_chg_patch(tp, speed);
> +
> +	if (phydev)
> +		rtl_enable_tx_lpi(tp, phydev->enable_tx_lpi);

This is not correct. You should implement .mac_disable_tx_lpi and
.mac_enable_tx_lpi in phylink_mac_ops.

	Andrew
