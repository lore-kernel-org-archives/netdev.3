Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792445058;
	b=gsRkFarLHqzVt4J+gbaAMzwWTVCdizUOQk0PSdpMY7ecs9ai5XjbWdE51G0ss/QQE9HC
	 DidBuPUDyEVSUysEuSUGSeefq+SjuO9NMtaiGZ8bOh0yg6LPA31oPf55pey/i/qrxPkKp
	 2+qupLmFph230C0Gen6vuT9FMl0smYR95YTfWL+7xHWeDPAyFxB4oMosiz6Top88/Nxhi
	 vFqmUs3Tyc2Hke6fF27/brFMzWosGtmSdyVxZS7YiVPl1xSYwoMQxAtJ5g+86BtiIC0kQ
	 TlpOwOkEOxF2OtmfyS5RcTcCmsd/lJ3C3LPcMRGXA/N0pciJ8uhCgY96jsZHgjtqU5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792445058;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=1YXs6rrJZv6Usz6XsrtQKINxbiM6rWZ3xRR58cYtHN0=;
	b=ew7oYesFWySryqopaEXzoZ/rRtj6BFuJ2hbraNpRHEmpZdd3HDpHtET0yL376EVM5tVn
	 54c9l1lqGs5LLiRpgsLuZSzU1evtLNxem50PtL8lUOKZ40BAneqiyw/WfSBNWvI18YSDL
	 hJ515tp6+vRH1q+S0xXNFkh7ywKKqUeDzd+emmQaGfc7dkl/FLJjgcOuxnPxDdq+6fiBz
	 ElJCcbJeAuXW5XgFHqywLsCBCAgGBHPXD8ycq5ChHYzCJs41WXYisLI1NJ9czwIuFTzb9
	 Hy07bhaQXOO7xVdP0WLkMNgwsxScVbm3JWou4Uz/pzKx0Eab/CBT6mGLinUbfjxMm1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=SDLR9a8l;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43AC606A319;
	Mon, 19 Oct 2026 21:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C43AC606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=SDLR9a8l
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1YXs6rrJZv6Usz6XsrtQKINxbiM6rWZ3xRR58cYtHN0=; b=SDLR9a8lBKfpRccuCc5ld0BsJn
	9uCmTFKQYrlloKxuSKSPg7w00B7M64mutjTo45+3XNOMC8ikGdM7PCqSsm/QeCwQ/KR+AZBYOrE41
	Bm6VyUqlckHXiM3bV53xvhs+EsMsMcQ6Qy1ksIIk0Zqi/qcg0iZA/mFY1tSS5LxlUlOg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xIuq6-00Bi8x-7G; Mon, 19 Oct 2026 23:24:14 +0200
Date: Mon, 19 Oct 2026 23:24:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Prashant Sengar <prashantsengar25031@gmail.com>
Cc: netdev@vger.kernel.org, Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net v2] net: usb: lan78xx: avoid NULL PHY dereference in
 WoL setup
Message-ID: <d9177176-75c2-4273-b5ba-d0c6afdad6c5@lunn.ch>
References: <20261019193148.1381545-1-prashantsengar25031@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019193148.1381545-1-prashantsengar25031@gmail.com>

> @@ -1805,7 +1805,9 @@ static int lan78xx_set_wol(struct net_device *netdev,
>  	if (ret < 0)
>  		goto exit_pm_put;
>  
> -	ret = phy_ethtool_set_wol(netdev->phydev, wol);
> +	if (phylink_expects_phy(dev->phylink))

Is phylink_expects_phy() actually needed?

> +		ret = phylink_ethtool_set_wol(dev->phylink, wol);

We try to keep the phylink API simple, and put all the complexity
within phylink. Hence it would be better if you could just call
phylink_ethtool_set_wol() and at the MAC level not have to care about
fixed link. phylink knows if there is a PHY, it should decide what to
do.

	Andrew
