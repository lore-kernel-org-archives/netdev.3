Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9622830E85D;
	Mon,  6 Apr 2026 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775493994; cv=none; b=NzryRRn7gEpjuU8LQyzEwNiP5HRDS2unie8Hi2oebjaHz+bvpS8r+OX4u8Uz4GEHObLlOKsuHYR4PMnD8oMmZ2wV/Hq4R5pLhSWeRJtVEduDKwRllTgl6BOcS26E2iPAbUy6JUgTCHsGsUXZziqxI5x0Vv/fUpGj5xy4LZW+jEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775493994; c=relaxed/simple;
	bh=kia4I7pVBEY0QWJO1+YPca3w2iF2S8Rkb/y6Tr3i1hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNINGON+inWzEKlCpdVV5D1lJDpTNowAvIb1TAs/pJIp+ezx8xlM05sfEcAv5JBphHd8a/dCmWfj2yDD7tDAtZ4nhmO0scO2wGzDd1qgHJaTdtb6mqoGPaX3mG0gpMY4cgEX1uKAZqPtd1YI3nxGO0LO5eWkbnJ17bg2iXDdPA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=SiVGeKcC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SiVGeKcC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JmUEiDUzB/d9b/qanJMLIiDxDt0VTx0SbrbgQo9fEow=; b=SiVGeKcCZ4Ko1Gig+ppZMpDo1/
	KG4HxlpvM+wMoozcXKVM/PzJQQhqCmRTI+Ok/vgi9GnfuRsnKENdjnXEiFoG9PdbdcR4/P9KprbnU
	6OcVQ2kbtBpRsBAurTC2Yob1IgCjKVFf4i8/LSbmzGiAkmj1wJZFwdrBZp6m701PL+bhcmX8OK4Li
	F2eIoGst+Uu0AM2g0QxCaFmfGyIGAG+H2v5sTX6hzW2cm+dXOq0WYcyaA6N5rO1+yRXgvew8QU/im
	WozeUgmbg6BymjPjShU9YrkRevLbNkFWBN6NwEiDCQUhIlr7Iha8xTJ2clM/zr4Siq44GSChY7C1a
	4oZ2rj4w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38218)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w9n5j-000000008Ja-1kAT;
	Mon, 06 Apr 2026 17:46:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w9n5g-000000001Re-2IJt;
	Mon, 06 Apr 2026 17:46:20 +0100
Date: Mon, 6 Apr 2026 17:46:20 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Julian Braha <julianbraha@gmail.com>, davem@davemloft.net,
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
	mcoquelin.stm32@gmail.com, kuba@kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] stmmac: cleanup dead dependencies on STMMAC_PLATFORM
 and STMMAC_ETH in Kconfig
Message-ID: <adPjXKz-UNgyLzAl@shell.armlinux.org.uk>
References: <20260402145858.240231-1-julianbraha@gmail.com>
 <CAMuHMdUfzVSQpadJYpEqPJ_UOBAgswnGzD_bp_U3U6jt2dy0dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUfzVSQpadJYpEqPJ_UOBAgswnGzD_bp_U3U6jt2dy0dg@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Apr 06, 2026 at 10:23:46AM +0200, Geert Uytterhoeven wrote:
> Hi Julian,
> 
> On Thu, 2 Apr 2026 at 17:07, Julian Braha <julianbraha@gmail.com> wrote:
> > There are already 'if STMMAC_ETH' and 'STMMAC_PLATFORM'
> > conditions wrapping these config options, making the
> > 'depends on' statements duplicate dependencies (dead code).
> >
> > I propose leaving the outer 'if STMMAC_PLATFORM...endif' and
> > 'if STMMAC_ETH...endif' conditions, and removing the
> > individual 'depends on' statements.
> >
> > This dead code was found by kconfirm, a static analysis tool for Kconfig.
> >
> > Signed-off-by: Julian Braha <julianbraha@gmail.com>
> > Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> > v2: add back default STMMAC_PLATFORM for DWMAC_GENERIC
> > Link to v1: https://lore.kernel.org/all/20260331125817.117091-1-julianbraha@gmail.com/
> 
> Thanks for your patch, which is now commit e2f152c822cf5d37 ("stmmac:
> cleanup dead dependencies on STMMAC_PLATFORM and STMMAC_ETH in
> Kconfig") in net-next.
> 
> > --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > @@ -20,7 +20,6 @@ if STMMAC_ETH
> >  config STMMAC_SELFTESTS
> >         bool "Support for STMMAC Selftests"
> >         depends on INET
> > -       depends on STMMAC_ETH
> >         default n
> >         help
> >           This adds support for STMMAC Selftests using ethtool. Enable this
> > @@ -29,7 +28,6 @@ config STMMAC_SELFTESTS
> >
> >  config STMMAC_PLATFORM
> >         tristate "STMMAC Platform bus support"
> > -       depends on STMMAC_ETH
> >         select MFD_SYSCON
> >         default y
> 
> This now lets us have STMMAC_PLATFORM=y and STMMAC_ETH=m.
> Does that actually link?

Really?

Let's try forcing it:

CONFIG_STMMAC_ETH=m
CONFIG_STMMAC_SELFTESTS=y
CONFIG_STMMAC_PLATFORM=y

and make oldconfig...

    STMicroelectronics Multi-Gigabit Ethernet driver (STMMAC_ETH) [M/n/y/?] m
      Support for STMMAC Selftests (STMMAC_SELFTESTS) [Y/n/?] y
      STMMAC Platform bus support (STMMAC_PLATFORM) [M/n/?] m

CONFIG_STMMAC_PLATFORM is forced to 'm'. 'y' is not permitted.

I think you're mistaken.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
