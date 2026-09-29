Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F0337F323
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 06:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790661892; cv=none; b=QFHlklx6pIWFHXvQewI0j+j/R6ooKhBV4FQCXYhNaiwNn70+v+kljKLBDvnmHx/fLpnpD9Ih6zZqiDr+89UqIo+J6lkPVH6Vw1/as/9JfUVlfQCq2bMNRDwxr7e0K/3y9hKvsRm5vQPWgGpOPMfMzTp3VUWFzcylkbWhnM2igto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790661892; c=relaxed/simple;
	bh=a4Kw0/+7x9IW9EMICVZHdLINZ3mYtw/nqjRwyV3ufBE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pt7n07Sy5K/8xT4ONa8njs/p3070QOYub1zUJM5w2scaSmWlXsVItpK2y3f4WRNi0wtrezJuHB/SP6bbyHFf6N2T0SivZ6ev0vpZx1My1ukvHkxYeLl5cPND4U8w9tIr3eHhiN4BXHZ/fDGIlR25QtZS5ufWTXvKlyrxiSBP8hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=roFgokrf; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="roFgokrf"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48449f62b93so1310456f8f.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 23:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790661888; x=1791266688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z0TZEPIVidw3xLm+2nRYFt1HaNZNBSK8y9IPaB77MDo=;
        b=roFgokrftoEMCPFcmgnQByHUmYf58p4TT7+pKkCFrhvkYKtJOexweECRJ9/RQeM5XM
         srSCD9U27eZqEhW0kbiOQNZNru8jIp8hnL9MnuvXGSfokKUdJ7ASFNewtXtgRdDbIoCb
         jUAElwbaV4XJ+RYXQx+gSilEJ+REmqyHube9HKFPMctfcOO2CDcKIMW7KcpLaKoZcWIp
         9jbsU2zVS1wtEL6EVmpW9aQ8BKuv/6EG6x5a9pOMZe741ydBgxzI+rsQQlZcapIjgWvS
         CPLJsvWI4segTHDZCXkHkjsovp1DLi93usTeNhrjlnFNoRGI5Xi2W4P3PEKZ55v+nW38
         U0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790661888; x=1791266688;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z0TZEPIVidw3xLm+2nRYFt1HaNZNBSK8y9IPaB77MDo=;
        b=wJ4zXk5jocpya7oNA/X991RYdKIcoZ7kQ9nrvuCJF6d1PZM6cQyTU5HMRjO/toui9m
         r0as3dmXJHoLJy5YmdaI/RfT1xYAXWZmPT6n86DCu+GqHZdVTiM/F8SPLY+crSKJWOT6
         +ZMBxi4phMtxBCNP8NkrxzCqwfZ/uvsbSYsUBdhY/SD7VJ/14UB/XhgPSEZCbQSoVaZ7
         i7aZXI7bgghJSZdVPfmoaxRZJGO1XV1xpmHe/MtLXasGvncZu+fYvP5ZlP5sQ1Ssy2EF
         vHySmMTKXoKcx/bQXl2zaN4zQ/BOIVlPhgC+AFAM4d6xcsFZyn1NSy7sOIGo4YB+NbQ3
         z0Tg==
X-Gm-Message-State: AFq9FYJoaH+tbC9sZmv2PLD/PWwoOz+89eKZMwCsnpchtMT/70iDwq9M
	u7JD2tT0bHNU+n90IXGTe5gjmCC3JgArdQh6NLLBTkk3n7iwXchZLDpY
X-Gm-Gg: AYBFou0AA7MDumqfGod/CPOWHKONcJPrL6lDcV1WsSYMK9VUN5O46VMIhQ+Gn5tog4h
	5oORFSA1WoAgozWZouOxoY7OOh8bgNTv4fEWeXtjMP5mneLv3hi43QrpjI0VUf9C4Lw53yczdgj
	gwLg2kr0SghQIE7aS+EOfPANdevDgj3Jdram4eOIXdmfV8+ea44ScLBh6j27Ic/Fg69oQxb4RoO
	NbDEGD5qWyZNeEi35pT/O33VGrdT2/NSi8xnDFMiQsWPHAr+2IgkIt9g7HwsYlaeu5U7uqDCnbg
	mqXzlir3pux+8kxve7InxrL5dsJSuo0OMuGldR6ij5vDMUZPkaoGBeloFzsOAlfCZvMly9V0RC5
	j2SekEdX7Hp+OB40x45T5C37/xbZfNzCv+U3W1cszpMn+uomIMOQXV4xA/O2g90w5YNyCic4Zc3
	A/D9jbi5oiYAgLWqQWJ85oCDwwRgbgrIhpmV2e4Nd1i38FAS0W5xmiG3t5cCm3yqOkF3t2/FKdq
	5uz+AzZkMTekkDJ2bMnWnSqjb+BGxqga5averYt85eINw==
X-Received: by 2002:a05:6000:41cb:b0:48a:f4b7:25c4 with SMTP id ffacd0b85a97d-48af4b727b1mr1097369f8f.1.1790661888208;
        Mon, 28 Sep 2026 23:04:48 -0700 (PDT)
Received: from Ansuel-XPS. (host-82-57-191-234.retail.telecomitalia.it. [82.57.191.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af507f33fsm1275291f8f.24.2026.09.28.23.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 23:04:47 -0700 (PDT)
Message-ID: <6abb54ff.332d3c56.21546b.7fef@mx.google.com>
X-Google-Original-Message-ID: <artU_MVOnnHuo-a1@Ansuel-XPS.>
Date: Tue, 29 Sep 2026 08:04:44 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Yongzhao Chen <yongzhao.derek@gmail.com>
Cc: netdev@vger.kernel.org, Ziyang Huang <hzyitc@outlook.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/3] net: dsa: qca8k: support QCA8337
 internal PHY CPU links
References: <20260928220811.1880-1-yongzhao.derek@gmail.com>
 <20260928220811.1880-4-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928220811.1880-4-yongzhao.derek@gmail.com>

On Tue, Sep 29, 2026 at 12:08:11AM +0200, Yongzhao Chen wrote:
> From: Ziyang Huang <hzyitc@outlook.com>
> 
> A PHY-to-PHY CPU link connects the SoC PHY directly to an internal
> switch PHY. The QCA8337 supports header mode on these ports, and
> existing phylink callbacks already handle their internal interfaces.
> 
> Allow QCA8337 CPU port selection to fall back to ports 1 through 5 after
> checking the dedicated MAC-only ports. Preserve the preference for CPU
> ports 0 and 6 across all switch models, limiting the internal-port
> fallback to QCA8337. Support for QCA8327 internal CPU links has not
> been established and is not enabled. Include internal CPU PHYs when
> selecting the PHY access method, without altering the handling of
> MAC-only or external user ports.
> 
> This enables a single internal CPU PHY configured with an explicit
> phy-handle and phy-mode = "internal". The conduit interface uses its own
> PHY on the opposite side of the MDI connection. Existing single-CPU DSA
> forwarding uses the selected port for default flooding and membership
> without extra routing changes.
> 
> Adapted from the OpenWrt PHY-to-PHY CPU link patch, narrowing the MDIO
> filter adjustments to preserve handling for external user ports.
>

Can you put an example DT for this? Also no additional register are needed
to this special mode?
 
> [yongzhao: preserve external user-port handling on port 6 and limit
>  internal CPU PHY support to QCA8337]
> 
> Assisted-by: LLM
> Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
> Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>
> ---
>  drivers/net/dsa/qca/qca8k-8xxx.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> index 7bd9d9abcef..cd36efd1c4f 100644
> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> @@ -1026,7 +1026,8 @@ qca8k_setup_mdio_bus(struct qca8k_priv *priv)
>  			return ret;
>  		}
>  
> -		if (!dsa_is_user_port(priv->ds, reg))
> +		if (!dsa_is_user_port(priv->ds, reg) &&
> +		    !(reg > 0 && reg < 6 && dsa_is_cpu_port(priv->ds, reg)))
>  			continue;
>  
>  		of_get_phy_mode(port, &mode);
> @@ -1102,16 +1103,23 @@ qca8k_setup_mac_pwr_sel(struct qca8k_priv *priv)
>  static int qca8k_find_cpu_port(struct dsa_switch *ds)
>  {
>  	struct qca8k_priv *priv = ds->priv;
> +	int port;
>  
> -	/* Find the connected cpu port. Valid port are 0 or 6 */
>  	if (dsa_is_cpu_port(ds, 0))
>  		return 0;
>  
> -	dev_dbg(priv->dev, "port 0 is not the CPU port. Checking port 6");
> -
>  	if (dsa_is_cpu_port(ds, 6))
>  		return 6;
>  
> +	/* Internal PHY CPU port selection is currently enabled for QCA8337. */
> +	if (priv->switch_id != QCA8K_ID_QCA8337)
> +		return -EINVAL;
> +
> +	/* An internal PHY can provide a PHY-to-PHY CPU link. */
> +	for (port = 1; port < 6; port++)
> +		if (dsa_is_cpu_port(ds, port))
> +			return port;
> +
>  	return -EINVAL;
>  }
>  
> @@ -1863,7 +1871,7 @@ qca8k_setup(struct dsa_switch *ds)
>  
>  	cpu_port = qca8k_find_cpu_port(ds);
>  	if (cpu_port < 0) {
> -		dev_err(priv->dev, "No cpu port configured in both cpu port0 and port6");
> +		dev_err(priv->dev, "No CPU port configured");
>  		return cpu_port;
>  	}
>  
> -- 
> 2.43.0
> 

-- 
	Ansuel
