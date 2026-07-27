Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C51C3C3C09;
	Mon, 27 Jul 2026 19:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785181599; cv=none; b=gYY+YKILxev+kODt3qYS27SbXWW1B4MXsbCAZIELOlY5xePEnL3heYVj2WDDs8ul2Myji18JTP2MLAIJpg0D+KLHjhDLR3WeGc9ICw/QU7lr2Tt+5BtlY32A9Dots7wkj2ayhfwrnOjMYTpeP5SW+Cykw89I3VYdaL5uxJ5B3MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785181599; c=relaxed/simple;
	bh=fQ4wk83CrCNpETdhskw6nrbThiTVEOnTawInohdalxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoKhE7gdtm//q+qCi6WZ17a3SmTvMIFEYm2Qs/vN100V81uLjTSEM9iXJUGb8uIhmb9o+LaLOZkHQrfUFTBaFuE49wuY0R+mba6rBf3L4fOUaJbVJHQjsj4ETfG0e/1f+YGF2TbHFDLx2rMnQtJb9Y5V3WN1/IbjKFen3DFmifI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=p6rVgD+c; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="p6rVgD+c"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=prLTqXdtwS6Vp+/x1a38rz7nfNGj+D9MXfvAyt2XwH4=; b=p6rVgD+cxm/uWiP2AhveEPbU0O
	LisE0LjlqzHs1PR1RPT52p+Gxdkwk54Xr/cNJSNZ0c2S1BQBLKTh+sjl2m28k6cai8Qbz/QmIQZgS
	bLxzzVaBrpnMHNx/HtSdWMRu/nIomBQ2V8P7QiA+yT9BThxBK/McsjBbwfoZmLEzKMck=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1woRHE-00EUk5-7n; Mon, 27 Jul 2026 21:46:16 +0200
Date: Mon, 27 Jul 2026 21:46:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Zxyan Zhu <zxyan0222@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, linux@armlinux.org.uk,
	hkallweit1@gmail.com, rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	bjorn@kernel.org
Subject: Re: [PATCH net-next v2] net: phylink: add phylink_pcs_loopback()
 method for PCS loopback support
Message-ID: <73726b44-42d8-4539-b910-eeeb1650f180@lunn.ch>
References: <20260724085224.3321663-1-zxyan0222@gmail.com>
 <20260727093835.1708262-1-zxyan0222@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727093835.1708262-1-zxyan0222@gmail.com>

>  static int stmmac_test_phy_loopback(struct stmmac_priv *priv)
>  {
>  	struct stmmac_packet_attrs attr = { };
> +	struct phylink_pcs *pcs;
>  	int ret;
>  
> -	if (!priv->dev->phydev)
> -		return -EOPNOTSUPP;
> +	if (priv->dev->phydev) {
> +		ret = phy_loopback(priv->dev->phydev, true, 0);
> +		if (ret)
> +			return ret;
>  
> -	ret = phy_loopback(priv->dev->phydev, true, 0);
> -	if (ret)
> +		attr.dst = priv->dev->dev_addr;
> +		ret = __stmmac_test_loopback(priv, &attr);
> +
> +		phy_loopback(priv->dev->phydev, false, 0);
>  		return ret;
> +	}
>  
> -	attr.dst = priv->dev->dev_addr;
> -	ret = __stmmac_test_loopback(priv, &attr);
> +	/* Use PCS loopback for interfaces without an external PHY. */

It should not be an either/or. You can have a PCS and an external PHY.
You might actually want to test both.

So i think you want stmmac_test_phy_loopback() and
stmmac_test_pcs_loopback() with the shared code in a helper.

    Andrew

---
pw-bot: cr
