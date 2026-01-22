Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7895A481235;
	Thu, 22 Jan 2026 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769084002; cv=none; b=pKCkd7Ptz9eOrrgLxshx2bSGHHVl5jSYyYz1IvT6OaKroeN7U9yipiscjEyAHN0C3sjbnfJ8aeWhbyIlWGGNJjCknwpb7Gu7aEfTjqal8XVt1yTxZzngABJaDOdbjt4454zOq/1/8+XKGQvgmaHpf0ODikdH2che+IRevIT0ZgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769084002; c=relaxed/simple;
	bh=iFGImodtGg26v12KZnlfUBCIK6r1uqgX8glwyh8adKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHzyUIMJ+AqkW7b9fwVKSx51QbsIAr2qdRS2aglNwgN6wqhh6AI9EgSTdYTRHb0O2CBasNuDQ8/ol4iVDpIY+3pb4ldRDmRq1ilBahN/9cyHkPYJO1acVLADBbXONYenDHBF5tB8WHy/MMLuXyewn8BdFx2N9OyYANneIPBEQmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=iyD8MTpB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="iyD8MTpB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=99WeiO5u+l3PtnXWsgEb1Ggl01P6ZHYFWERHUSgNsgI=; b=iyD8MTpBQ4AJ8EUuEnND0jx9k8
	tsG6pbPaRaORNoZBNHSVbFHVoJYD2c3zOuR1xwZJpuuir+y/nMifRqKAFGb6EebfoWcDqFy/E3iWo
	483US66ALS+CQtAu36tdq29upmjLkNeRgZ4t1SV3fgHqVelgbg/sJa0Kq8nt9zuUM12sFjo76OQEP
	XVSssTnrgQZ2mQ0AeX2zrkL5aEzwzAkl1WxpEhnHDXPrV0ZINtPPwZj4jIE7nHiLp731Qtud22sU1
	HyrBZVcYHPb6iDXfWigJ9+2o+xlwW9949IWohqC1eqmPcx7N5zB9WYbGP0uxlrCJEj4CE9P0inQMD
	HTG2wdyQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51682)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vitYi-000000000LC-0kvR;
	Thu, 22 Jan 2026 12:13:08 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vitYf-000000000zX-1d0f;
	Thu, 22 Jan 2026 12:13:05 +0000
Date: Thu, 22 Jan 2026 12:13:05 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Stefan Eichenberger <eichest@gmail.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, hkallweit1@gmail.com,
	linux-stm32@st-md-mailman.stormreply.com,
	maxime.chevallier@bootlin.com, francesco.dolcini@toradex.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH net-next v3 1/3] net: phy: add a new phy_device flag to
 keep preamble before sfd
Message-ID: <aXIUUStYnRt2Ad0x@shell.armlinux.org.uk>
References: <20260120203905.23805-1-eichest@gmail.com>
 <20260120203905.23805-2-eichest@gmail.com>
 <86b8feca-8e82-465e-a17a-b751758306ce@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86b8feca-8e82-465e-a17a-b751758306ce@redhat.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jan 22, 2026 at 12:37:17PM +0100, Paolo Abeni wrote:
> On 1/20/26 9:30 PM, Stefan Eichenberger wrote:
> > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > 
> > Add a new flag, PHY_F_KEEP_PREAMBLE_BEFORE_SFD, to indicate that the PHY
> > shall not remove the preamble before the SFD if it supports it. MACs
> > that do not support receiving frames without a preamble can set this
> > flag.
> > 
> > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> I understand this has been suggested by Russell, and LGTM, but still it
> would be nice explicit ack from the phy lib crew to ensure it matches
> expectations.

Since I suggested it, I feel it would only be right for Andrew to ack
it to show his agreement with my suggestion.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
