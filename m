Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBB241D657;
	Sun, 27 Sep 2026 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790530198; cv=none; b=GhwD8UU9Py8pRJXLGWuD5ydOcFO31PMRjRAu1L6cKTZSh7SSKFeLGZc901Nyhthc20GVKqT69A0DKfb0LfMWIrW1cx9Td3DFDlTLvLRWz1p4uEkxwav04lqhF9tWJaLzGYCgcDO/GXCjEwKExQVCdlo3u1L31P+01LfhcDkkfhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790530198; c=relaxed/simple;
	bh=SRHg4zsmJJQo6lKwteidddHAzK0QYe9+rvv+8BondyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDbD7MYwg5rtBW7Fz8tdwkOF3Tw/eCz+4Ept3m5w1uvmDjOxr4IqxoT3igJP+FRv8JFpxTlIdG3z8PxXpLrgQdgeufJlvSAArriCDchwnfcUVp5+Aa3IX2f1r1uE2InrjMk3KlESKM9bC9/Y6X2JYO4H9DzlYQvgIQOh5kdtyyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gRUK1akE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gRUK1akE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lE3RNr5/Rs+CI3bvQqbiqFGMEuhpnn7flupaU84PVaU=; b=gRUK1akEHjqHsOFb8t5dZte90S
	CNqkkLxtp4KZhxAEl76hS+G5DK1YHgCe6cM48GWfLjgXX766BZc+0v4K+Rq53OZ9uU1JPhR4Lcs/O
	otRHS/KBzBKLsObNd4HpXr7AHa9jjPemadwf3ugBMX1ALHCGf17VGtuxZZTUnGgA+Q8w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAsh6-007XtF-9C; Sun, 27 Sep 2026 19:29:44 +0200
Date: Sun, 27 Sep 2026 19:29:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Junhui Liu <junhui.liu@pigmoral.tech>,
	Liu Changjie <liucj1228@outlook.com>,
	Per Larsson <per@palvencia.se>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/5] net: phy: maxio: parse and enable PHY
 clock from generic DT binding
Message-ID: <8f492255-cc8b-4daa-80d8-016e14a35f1d@lunn.ch>
References: <20260926225625.25969-1-andre.przywara@arm.com>
 <20260926225625.25969-5-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926225625.25969-5-andre.przywara@arm.com>

>  struct maxio_priv {
> +	struct clk *clk;
>  	bool clk_out_125m;
>  };
>  
> @@ -57,6 +59,11 @@ static int maxio_mae0621a_probe(struct phy_device *phydev)
>  		priv->clk_out_125m = true;
>  	}
>  
> +	/* PHY clock from the generic PHY binding */
> +	priv->clk = devm_clk_get_optional_enabled(&phydev->mdio.dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return PTR_ERR(priv->clk);

Since clk is not referenced anywhere after this, there is no need to
save it in priv.

     Andrew
