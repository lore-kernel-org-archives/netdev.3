Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04FF3264C7;
	Fri, 18 Sep 2026 02:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789697097; cv=none; b=OV3sHORAGeVkrSaIU7STMY3dP/uuJJd7JalXu2k35GiUWwzItIxjl4/8yIUucSGhtnq40qvFNXXZUzc2QZeNfUjoVn21vd5gQRuCd1+rGnkJIbtVDc1mDFdmd9+qhHReSgtnddL0oA6EON0ads3r6wx79E+Y77bfACqy2hdm1EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789697097; c=relaxed/simple;
	bh=b8J32IclhFRZKEhYc2Ax/YbbycCEXO/fQlcEXh8IGRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaP/hQju8GHNSV1xU0pTgIVvVpNt/U8IkT5KPWxlLxrxh/eAVFlB2tt24j8M1TgwXnuCjb4eA1oBZ1IZD4yYMJd0MsKp1K5AA3w+EoBylIP0ZnX/QLnkQWoVxXXz4wmjAHG0L7g8c9C1rsAtMb6LVPBqaA2tHFZMETrKJCberK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YWRDsWHL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YWRDsWHL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LHUx2/wvX7FJ+93KxwZ/dGo27LKl6yUoLqN/CHdjTUo=; b=YWRDsWHLXXdbG5cdBbrcrFLUGu
	rIK5D1Qbxs1H1C/9BHoMa01sA58ve6+Fbid2IP0rwPQfr8aVN8jrfQQmxbsW1ry8U2A+SYujnc/Ag
	ugTmU+iiiNDZ7K1UyGiDTquAADcho+EfxG12pWG8mF898sljXws73c+uGax7D9KTRzno=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x7Nxw-005meW-Lp; Fri, 18 Sep 2026 04:04:40 +0200
Date: Fri, 18 Sep 2026 04:04:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	olteanv@gmail.com, Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com, steve.glendinning@shawell.net,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v8 1/4] net: usb: lan78xx: register the PHY interrupt
 with the MDIO bus
Message-ID: <df5d4af1-a86a-4820-9aeb-b1449a60f37e@lunn.ch>
References: <20260918015029.2518425-1-f@lex.la>
 <20260918015029.2518425-2-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918015029.2518425-2-f@lex.la>

> -	/* if phyirq is not set, use polling mode in phylib */
>  	if (dev->domain_data.phyirq > 0)
> -		phydev->irq = dev->domain_data.phyirq;
> -	else
> -		phydev->irq = PHY_POLL;
> +		dev->mdiobus->irq[phydev->mdio.addr] = dev->domain_data.phyirq;
> +
> +	phydev->irq = dev->mdiobus->irq[phydev->mdio.addr];

This line is redundant, given how phylib works.

>  	netdev_dbg(dev->net, "phydev->irq = %d\n", phydev->irq);

So maybe change this line?

	Andrew
