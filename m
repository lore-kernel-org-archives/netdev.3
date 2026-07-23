Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBB0378814;
	Thu, 23 Jul 2026 12:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784811293; cv=none; b=dtoLxwUxWE7hPfJGBeyMrnc3v5Rw/jf1CrvGujOn2Wt2TrUnaGM00+0Jbc3ls3zDTV+wyOn8K9TtFOKY5rF6xN261cwPDM0XaV2ByJMwieQBe9YWqvZ6UK5OStAx/1xCroTwQFzsn1HyhWvwcRPUHD18dG+oW+gu8qwZHcfi5uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784811293; c=relaxed/simple;
	bh=1vWzpOrWZi4WpPRkzF28E9OEQ5ofdhKnGANZI7Pj6ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4ySheZuYUry7/mIT3xq31Gx+gTPnC2SRpEZd+yQHtWKirrWIa70UUbV3vD1UTE2aWpoN4IxFeI1DKxGLK9XPiOA9psm3I4OKcHb1HgL1Q0y8jlPgKXTUErNPG8hU9tkS4ut3XnWcQoT5Q3S+UT2kCUYfAqhzX0ccmlAqx+TRYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Xfn82e+8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Xfn82e+8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JIdBUlLg6u2utQkKES9YdEQR6eSKfNdmf6JsFo/vprQ=; b=Xfn82e+8XUu7hNCZ64kqjPsWSc
	IUipn3MdB67HJnkLdZxGapXm1zZPsesh06NN74Qur7EmkVxOAXJTJlHyRGf7DX1NLNUvGcCgdJOEm
	rf01rCF83CdFQvtF8XI5wDvIwNs+59/69J37Uu/fTOQhzA/SVMf6ZM+hKD9ULb/3068w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wmswj-00Dof9-GP; Thu, 23 Jul 2026 14:54:41 +0200
Date: Thu, 23 Jul 2026 14:54:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Javen <javen_xu@realsil.com.cn>
Cc: "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"nic_swsd@realtek.com" <nic_swsd@realtek.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"enelsonmoore@gmail.com" <enelsonmoore@gmail.com>,
	"daniel@thingy.jp" <daniel@thingy.jp>
Subject: Re: [PATCH net-next v7 4/7] r8169: add support for RTL8116af
Message-ID: <b01e69e8-3c8a-4af5-9de2-19d73713cff3@lunn.ch>
References: <20260722022906.271-1-javen_xu@realsil.com.cn>
 <20260722022906.271-5-javen_xu@realsil.com.cn>
 <ff90f295-31df-490b-aad3-1bba6ef0ab5d@lunn.ch>
 <90aea677b62e44f3a705caa900b3af95@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90aea677b62e44f3a705caa900b3af95@realsil.com.cn>

On Thu, Jul 23, 2026 at 03:21:26AM +0000, Javen wrote:
> >
> >>  static void rtl8169_init_phy(struct rtl8169_private *tp)  {
> >> +     phy_init_hw(tp->phydev);
> >> +     phy_resume(tp->phydev);
> >>       r8169_hw_phy_config(tp, tp->phydev, tp->mac_version);
> >>
> >>       if (tp->mac_version <= RTL_GIGA_MAC_VER_06) { @@ -2562,7 +2607,7
> >> @@ static void rtl8169_init_phy(struct rtl8169_private *tp)
> >>           tp->pci_dev->subsystem_device == 0xe000)
> >>               phy_write_paged(tp->phydev, 0x0001, 0x10, 0xf01b);
> >>
> >> -     if (tp->sfp_mode)
> >> +     if (tp->sfp_mode == RTL_SFP_8127_ATF)
> >>               rtl_sfp_init(tp);
> >
> >This could be diff getting me confused....
> >
> >You unconditionally call phy_init_hw() and phy_resume(). And then if this
> >device should have an SFP you do something else. How can a device with an
> >SFP also have a PHY?
> 
> I totally agree that the SFP initialization logic does not belong in a function meant for PHYs. But rtl_sfp_init() call was already located inside rtl8169_init_phy() before my series. And it works well. This mainly because the patch which add support for RTL8127atf(commit id: fef0f545511f72223) assume that RTL8127atf has a dummy phy. So tp->phydev will not be NULL.

[Goes and looks at what rtl_sfp_init() actually does]

So it does not touch phydev making this function at least safe.

> And in patch 5/7 of this series which add phylink support for RTL8127atf, I remove it.

Yes, i did notice the dummy PHY getting deleted. I will look at that
patch in more detail.

      Thanks
	Andrew
