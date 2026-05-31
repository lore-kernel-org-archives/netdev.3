Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AD83002AB;
	Sun, 31 May 2026 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780241697; cv=none; b=jZLMBwXlAKCBd8CbyL4cHIGCD7Q8xOyVld01rsmV9KzAC6cL2PFY1tnrykyfUa9G331b22s9hRm6qFA3h2MGoO5F+Cjl5qb+fgX2drianzHI7XVYPu58sHDw6y4UiPVSS1QT9ZbKbJfubZxlCPzNU09A0mG3/hwwFXPqhGC43jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780241697; c=relaxed/simple;
	bh=CnjYxTujUwqmWeP1pnZD3DQRbBwuGdBRB80Qyh0vafY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7mg/HBY7gb6utgOyOL0wtdcnbL92ZeImBQ1LrKjXyaOEF/iEexqMkEQT8BR8rjcvr1MGzx3QpgTy8FxhorilWzlIdDSLke230bbJLLOY3ycWCabImLOkXifq7nkxZNVO9HM/lwxAnl/J8JW/3M1utgkxGZ2h2vwYAUmuhBa/jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YtRaLfO8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YtRaLfO8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PvG6MV5RPuHQIar4jhjtR9HbiwHnHpHaN6lD0W9eufY=; b=YtRaLfO8CkIXWYRtkbO1GOOKP6
	SbLKjCN40XDXuDkrixJWQH27drF6XWwdVj0N+0xb3j0ax6eOJtHthyuochZG9REuMoUM6zh3YVZhN
	MaFK1HBsW4LAgjp581zWFkZlp3yCIiC0bTIK4SlXmhnVz6iosI5gziPrS/oEBKO/g73w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wTiBb-005NCq-JK; Sun, 31 May 2026 17:34:47 +0200
Date: Sun, 31 May 2026 17:34:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 11/14] net: phy: ncn26000: Support for
 loopback support
Message-ID: <22496ce0-6d50-4059-bbd4-980513ad2612@lunn.ch>
References: <CY8PR02MB9249BCB1ABC4D1923CE3CAAE83162@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB9249BCB1ABC4D1923CE3CAAE83162@CY8PR02MB9249.namprd02.prod.outlook.com>

> +static int ncn26000_loopback(struct phy_device *phydev, bool enable,
> +			     int speed)
> +{
> +	u16 mask = BMCR_LOOPBACK;
> +	u16 ctl = 0;
> +
> +	if (enable)
> +		ctl = BMCR_LOOPBACK;
> +	return phy_modify(phydev, MII_BMCR, mask, ctl);
> +}

dp83867_loopback().

There is already genphy_loopback(), so it will need a name to indicate
the speed does not matter, because only one speed is supported etc.

    Andrew
