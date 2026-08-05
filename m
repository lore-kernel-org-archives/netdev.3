Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510D9352017;
	Wed,  5 Aug 2026 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785933490; cv=none; b=GeEn9R0VO65LZriN2QMuffJJNxiXrUw5Y7+qpxSsZQWMyDWrS8tlE7f2fkcK3HMcEzjh6hxRoFv6LafkEKTHgCo3YBuEJ405sQ5VvzVWFjq2jBf4+nOi97hqneWsJW3F5tgfDgVQw1NPE2O2vKXovJ3CXalS2GJy5HfXQLd5fsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785933490; c=relaxed/simple;
	bh=P55yvfhriPt+xKh9vMo96RXHACUKtN5f9/r6mkc8X4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjJLTARNPDvHGRa6/ZgaBt11WPyk3WSxnaudPKPTR3RNT63py7qSdQFmMugcaqcBU0MQ9quTnJxGZh8x7lvTUVCxSWCT4op8z1Ebihkp17oVdOk1Srvdhh2QMyyvPsP5D+4sQmxFPdcC1G3HFzKxDp4EbS7eLvA+/0uZxT+Vwbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dYIAdTdW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dYIAdTdW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MIMQJmkPDn3nvMi1GhZGX+SdavJhQT13XOPhF8HYz0c=; b=dYIAdTdWn8at/e23MJphOglQxR
	Kaf+LEAJsIG6pOqiS75PLVNwqDFgUsd37/X2bssbkk/nAfGOax3+pLUKc+aMYew6ncwYZPWNrcXOR
	5MSyce9+rMW3ZQOweIsjJ2TNvhUi7NscaybzmC44+mpHVzMZarvt5t8RmmiT0uTeeKwg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wrash-00GAPS-HF; Wed, 05 Aug 2026 14:37:59 +0200
Date: Wed, 5 Aug 2026 14:37:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiko Stuebner <heiko@sntech.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mfd@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH net-next v2 8/8] net: phy: add X-Powers AC200/AC300 EPHY
 driver
Message-ID: <30bab755-3356-4d4a-a939-8488aa487874@lunn.ch>
References: <20260804-submit-acx00-of-dynamic-v1-v2-0-3eef49ff1d8c@gmail.com>
 <20260804-submit-acx00-of-dynamic-v1-v2-8-3eef49ff1d8c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804-submit-acx00-of-dynamic-v1-v2-8-3eef49ff1d8c@gmail.com>

> +static int acx00_ephy_disable_eee(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = phy_modify_paged(phydev, ACX00_PAGE_1,
> +			       ACX00_PAGE1_INTELLIGENT_EEE_CONTROL_REG,
> +			       ACX00_PAGE1_INTELLIGENT_EEE_ENABLE, 0);
> +	if (ret)
> +		return ret;
> +
> +	return phy_clear_bits_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV,
> +				  MDIO_EEE_100TX);
> +}


> +
> +	/* Set the hardware default before phylib reads its EEE advertisement. */
> +	ret = acx00_ephy_disable_eee(phydev);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to disable EEE\n");

If the PHY is capable of doing MAC based EEE, that should be the
default.

Why clear MDIO_AN_EEE_ADV? This does not stop the user from
re-enabling EEE for this link mode. phy_disable_eee_mode().

	Andrew
