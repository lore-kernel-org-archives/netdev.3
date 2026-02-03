Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DD37E792
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 23:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770160718; cv=none; b=KufQeT5N0T5MFbiIdLivBp2YbbUsdNKFAO5CXVeGCKeSHTS4LZhd4tMS/upMZ2YDLp/WfAvJ364J03crgDAI2z+1+i7uZaFBeHjuWd7nEeJSDvWt/mIV3rEt2yOD5NBUGPMWaMpeDhUVo009hC8115ysogr3AtcpZjequyAr0fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770160718; c=relaxed/simple;
	bh=JLvdn8c+w8EK175ZjsQD8328a8YMf7HlLS6KIMPD2J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIkighoU8bsmtKS7Cli26xohmvoAViH5D+HC1PqlX+RqkmKRVTx9tppSqLZISNkRuzNWpL+R2TiIpDJRjQzTV/Lulx0rCWBjI7DiY152UZI2uUHv5JJntCq2i4EYC3lxHVo3zYJfW+xytdEk9RQ0BazB/Z3gQYSpAY+vvPjgWNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ASL6uVy+; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ASL6uVy+"
Received: from killaraus.ideasonboard.com (2001-14ba-703d-e500--ff4.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::ff4])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 27D023A4;
	Wed,  4 Feb 2026 00:17:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1770160672;
	bh=JLvdn8c+w8EK175ZjsQD8328a8YMf7HlLS6KIMPD2J4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ASL6uVy+l61WXBOcb/BAGP2WpnImm1KBztFatWHrjlPrp5EkvorBDCbcku7zqjwop
	 AS5akvYHIoKc3VE5nO19wH3wf1tj+HSNhtWvqe6bYM5YFz2B25I6JDCCCHR/dV+0at
	 eULHhmqTSHDuz/Eg2ZidnMrO34VtKMJpevIqWB7I=
Date: Wed, 4 Feb 2026 01:18:32 +0200
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
Message-ID: <20260203231832.GB133801@killaraus>
References: <E1vNUjC-0000000FhjR-0h6P@rmk-PC.armlinux.org.uk>
 <f95f73b9-d024-4697-bca1-02fb8bc044af@gmail.com>
 <aYEj8VM5AfvcDHrl@shell.armlinux.org.uk>
 <aYE-gvuZdv7ezm7X@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aYE-gvuZdv7ezm7X@shell.armlinux.org.uk>

Hi Russell,

On Tue, Feb 03, 2026 at 12:17:06AM +0000, Russell King (Oracle) wrote:
> On Mon, Feb 02, 2026 at 10:23:45PM +0000, Russell King (Oracle) wrote:
> > On Mon, Feb 02, 2026 at 08:54:52PM +0200, Ovidiu Panait wrote:
> > > If not, maybe this patch could be merged to add the flag that disables
> > > EEE and I will just send a patch to disable EEE on our platforms as well.
> > 
> > We still need the flag to disable EEE for platforms where lpi_intr_o is
> > logically OR'd with the other interrupts, so there's no way to ignore
> > its persistent assertion.
> 
> I'll also state that we need both patches, but there's no point pushing
> my original patch (to allow EEE to be disabled) unless Laurent is going
> to also submit a patch to make use of the flag - the EEE disable and
> Laurent's patch needs to be part of a series. We don't merge stuff that
> adds facilities that have no users, because that's been proven time and
> time again to be a recipe for accumulating cruft.

Sorry for having dropped the ball on this. Your patch arrived just when
I travelled to Japan for a month, and then it got burried in my inbox.
Now that it has resurfaced, and that an issue that prevented i.MX8MP
from booting with v6.19-rc has been fixed, I'll rebase my kernel and
finally fix that problem.

Once again, thank you for all your help with this issue, you have been
extremely helpful and I'm very grateful.

> So, at the moment, "net: stmmac: provide flag to disable EEE" ain't
> going anywhere until there's a patch that makes use of the new flag.

-- 
Regards,

Laurent Pinchart
