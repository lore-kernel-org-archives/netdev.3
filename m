Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332B340A94E;
	Mon,  6 Jul 2026 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342678; cv=none; b=c3sLlOxFTdkcPZry0p6eHgfw5aAV4HY4I8EYTQA92g4O9UM0Gd3ZUoc6yk6CbGx3VWAFvPdjtP94QabZvY1X+fdXDqBsOho5rnJWqt6piSMIcMztxP7Kh5DDJj5fD3O8pDwrDkgzldQuzwh6qLaXNE6OwfQ/tHBsgy/1DAvkNpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342678; c=relaxed/simple;
	bh=xvlhHq9Xaw8oN+qWcl8AbGEDz9shk/hPYwHRRTg6qcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtYTw4cWkW22nRoqDFRAKfGgW7RYE/donekmbaTpTLxyey8HAL7Zvw8ZqyDJg2AwXTILC23oudO4wYHTVvZnkY4/A/uBnVYqLEbObvWGMnP8K4DOZmKPJvHe/iWhgvdFKRkq0cvfX+WwA5ismU9eREgJhsXejr7i412jE+fKHqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nnSQY/1u; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nnSQY/1u"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ipqaw6QWMXaol456rza2b+rftqo+IddMLlR5NF8o6vg=; b=nnSQY/1uZ2xQIyW/ZWU4sc2Hcu
	LUnBf2YQxT81eCwD/grPPodjjXFF9ZAfm2cHUXbFKDjyMGGIienX205Sc8ffK5D+rWebqN2dWL3fT
	u0yWwmZ43Xfh6/fppmW5pDmGcc8c/gkDrLowIKjcFm9itUBPlYEyeUx5BnKFsFzt6GGc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wgitB-00AzPt-QR; Mon, 06 Jul 2026 14:57:33 +0200
Date: Mon, 6 Jul 2026 14:57:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Javen <javen_xu@realsil.com.cn>
Cc: "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"nic_swsd@realtek.com" <nic_swsd@realtek.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 2/6] r8169: add support for phylink
Message-ID: <0950251b-bfa8-4ad8-bdc9-a63ea9f14e0f@lunn.ch>
References: <20260703092459.1124-1-javen_xu@realsil.com.cn>
 <20260703092459.1124-3-javen_xu@realsil.com.cn>
 <e9cadf1a-94f3-45e8-9b59-22082ee5c2da@lunn.ch>
 <1f09de5536004055ba63862ca7088eeb@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f09de5536004055ba63862ca7088eeb@realsil.com.cn>

> >> +     if (tp->sfp_mode) {
> >> +             phy_mode = PHY_INTERFACE_MODE_INTERNAL;
> >> +             tp->phylink_config.mac_capabilities |= MAC_10000FD;
> >
> >Only 10G? Is it not possible to slow down to 1G for a 1G SFP?
> 
> It can support 1G SFP as well.
> 
> I only added MAC_10000FD here because the original code path only added
> the 10G capability, and I was trying to keep the behavior unchanged in
> this conversion patch.

That is a good reason to keep it the same. But since the hardware can
do 1G, please add a follow up patch adding 1G support.

   Andrew
