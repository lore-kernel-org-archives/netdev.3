Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659D333D6D2;
	Fri, 24 Jul 2026 16:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784910717; cv=none; b=J62JIxi4fQqkAOl7enmg2fG6UQCMD8HKG7K196oykk3TwIy8KldLrQ/agR2sWnb0xtW1JNNeupLRzHRDvmSOhM6SqZODXrSXTodFB+6kR8vo1Gw/bl4Mv679WoBVkTEjXRffaROPraLdc2DwaCuysNWx9Co4wB/Q/mkYbCbSELU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784910717; c=relaxed/simple;
	bh=jk33xT7wlwXgJLimeEaNvcyCsviHO/XwcycAveVusuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWQlBprfGoVCHuyg8tbCgFxO3i9UvFTkBAx2x0LTsdnjZ6kX9EYLdspCH1DnPfnJdg62dmbmh6NeO8OK9O+WSZwtWU2/olHUSNJkt9z6Idlh5MlvGYsToeLBVUPkb9ED0CYaaNaclRU78YiFsdKUwag1R6iTUq6kWYKw+pTg9Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=m8NkzfGd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="m8NkzfGd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=adI1lfponWj228dlhevQu/68vXO2ZyMhbjWwlpBp1U4=; b=m8NkzfGdI+jiIrAXvsQ1FnLCXW
	Jd0vN6u7KoS4l3EgewDmAAtriEkuOX6DtZoLRFkveclJMaQ9iQIweKfIexY4gjW4Wv4xGSG7lvN4u
	rSuNN1vldc7fqKWYaw2J2qR4NSzo+AuXN5M1pea3M2qlfeyLfrbYTBZYGT5forgIq9dc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wnIoN-00E1dl-U8; Fri, 24 Jul 2026 18:31:47 +0200
Date: Fri, 24 Jul 2026 18:31:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 06/13] ax88179_178a: EEE setup for
 AX88179A-based chips
Message-ID: <11397c47-a654-4c22-8af5-96cadc4797fc@lunn.ch>
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
 <20260724-ax88179a-v3-6-bdde4f905883@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724-ax88179a-v3-6-bdde4f905883@birger-koblitz.de>

> +	if (ax179_data->phylink) {
> +		ret = phylink_ethtool_get_eee(ax179_data->phylink, data);
> +		/* AX88279 MAC does not support 2500Mbit EEE */
> +		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, mask);
> +		linkmode_andnot(data->supported, data->supported, mask);

When you tell phylink the MACs EEE capabilities, this will go away.

> +		return ret;
> +	}
>  
>  	/* Get Supported EEE */
>  	val = ax_read_mmd(dev, MDIO_MMD_PCS, MDIO_PCS_EEE_ABLE);
> @@ -1025,9 +1035,14 @@ ax88179_ethtool_get_eee(struct usbnet *dev, struct ethtool_keee *data)
>  static int
>  ax88179_ethtool_set_eee(struct usbnet *dev, struct ethtool_keee *data)
>  {
> -	u16 tmp16 = linkmode_to_mii_eee_cap1_t(data->advertised);
> +	struct ax88179_data *priv = dev->driver_priv;
> +	u16 tmp16;
>  
> -	return ax_write_mmd(dev, MDIO_MMD_AN, MDIO_AN_EEE_ADV, tmp16);
> +	if (priv->phylink)
> +		return phylink_ethtool_set_eee(priv->phylink, data);
> +
> +	tmp16 = linkmode_to_mii_eee_cap2_t(data->advertised);
> +	return ax_write_mmd(dev, MDIO_MMD_AN, MDIO_AN_EEE_ADV2, tmp16);

The phylib should do this. All the MAC driver needs is enable/disable
the LPI timer. Nothing more.

We have had lots of broken EEE implementations in MAC drivers. We
tried to solve this by moving as much as possible to core code. The
MAC drivers should now be KISS and much less likely to be broken.

	Andrew
