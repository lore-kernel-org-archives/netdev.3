Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D5D33D4F0
	for <netdev@vger.kernel.org>; Sun,  8 Feb 2026 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770593457; cv=none; b=BorBcwmta6kFoyIBIYGkf/YRSl/JKSdESuT2+zewcrt+BGs7OQhTRkWuUGijmfPOLdpSmGDNr5wjsf+sDVPUtyjlv7vubCuL0bQjvMrwYmB2yg21S2PKqvu7rSrLuhHTmbX2lwIWEodN6yO7qFPmO7Yhm9gC7QR+IkF2B72Bzz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770593457; c=relaxed/simple;
	bh=BqBwXlW1DYlKifkNzuD8EgN86/kfJHvciyDW4WXpDPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWznp4jtlS7nye931k1CXRXSqZPu1r/VwYXufcMQkugsFotTFNwcXzcG4DS55plMmYIIS5EtJTOGKud8MxTWBcafoTMfbCXeD6XnlEd5D2YKlVnByWdxAWtwzZ3PDpuDzB8ZibQhHIvUYEPqZKuN4x3o8tK0bAYq6XYt1l7h0Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=a/R3LPSp; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="a/R3LPSp"
Received: from killaraus.ideasonboard.com (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 4B5B582A;
	Mon,  9 Feb 2026 00:30:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1770593410;
	bh=BqBwXlW1DYlKifkNzuD8EgN86/kfJHvciyDW4WXpDPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a/R3LPSpkb93wFdSWlOX+/jeCfLOWluI9DhYaiJ+yJSYViQVHcpq2vU/8sQbNM8KW
	 OzgvhCQDj4C29gAhRIz/QUtDJkAZwZ1B0An2C4xXoRtexqrXdGpW4BkrBAeKi/GBLD
	 X7uukJHcWOKAMAPGF88XW8kAiir3KJ3mnbQTR9/M=
Date: Mon, 9 Feb 2026 01:30:54 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Ovidiu Panait <ovidiu.panait.oss@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	"David S. Miller" <davem@davemloft.net>,
	Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Stefan Klug <stefan.klug@ideasonboard.com>,
	Wei Fang <wei.fang@nxp.com>
Subject: Re: [PATCH RFC net-next] net: stmmac: provide flag to disable EEE
Message-ID: <20260208233054.GA1987960@killaraus.ideasonboard.com>
References: <E1vNUjC-0000000FhjR-0h6P@rmk-PC.armlinux.org.uk>
 <f95f73b9-d024-4697-bca1-02fb8bc044af@gmail.com>
 <aYEj8VM5AfvcDHrl@shell.armlinux.org.uk>
 <aYE-gvuZdv7ezm7X@shell.armlinux.org.uk>
 <20260203231832.GB133801@killaraus>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260203231832.GB133801@killaraus>

On Wed, Feb 04, 2026 at 01:18:33AM +0200, Laurent Pinchart wrote:
> On Tue, Feb 03, 2026 at 12:17:06AM +0000, Russell King (Oracle) wrote:
> > On Mon, Feb 02, 2026 at 10:23:45PM +0000, Russell King (Oracle) wrote:
> > > On Mon, Feb 02, 2026 at 08:54:52PM +0200, Ovidiu Panait wrote:
> > > > If not, maybe this patch could be merged to add the flag that disables
> > > > EEE and I will just send a patch to disable EEE on our platforms as well.
> > > 
> > > We still need the flag to disable EEE for platforms where lpi_intr_o is
> > > logically OR'd with the other interrupts, so there's no way to ignore
> > > its persistent assertion.
> > 
> > I'll also state that we need both patches, but there's no point pushing
> > my original patch (to allow EEE to be disabled) unless Laurent is going
> > to also submit a patch to make use of the flag - the EEE disable and
> > Laurent's patch needs to be part of a series. We don't merge stuff that
> > adds facilities that have no users, because that's been proven time and
> > time again to be a recipe for accumulating cruft.
> 
> Sorry for having dropped the ball on this. Your patch arrived just when
> I travelled to Japan for a month, and then it got burried in my inbox.
> Now that it has resurfaced, and that an issue that prevented i.MX8MP
> from booting with v6.19-rc has been fixed, I'll rebase my kernel and
> finally fix that problem.

Done. https://lore.kernel.org/r/20260208232931.2272237-1-laurent.pinchart@ideasonboard.com

> Once again, thank you for all your help with this issue, you have been
> extremely helpful and I'm very grateful.
> 
> > So, at the moment, "net: stmmac: provide flag to disable EEE" ain't
> > going anywhere until there's a patch that makes use of the new flag.

-- 
Regards,

Laurent Pinchart
