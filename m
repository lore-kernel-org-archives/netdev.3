Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E0623EA99;
	Mon,  2 Feb 2026 11:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770030166; cv=none; b=SNlzZ6rPrhqEiQjdxetKdsI3TkqALhrGsucNXEyAlWjDxlTIejO1LH+yaKn+8ABH/1ZuhaXMGRTPw3wqDrH0xl8Hw/7RTsiQBy4JdPvxpV+l+3fYGMZ0nJHkapydCFB8Dven9ILB7CUOS+l80ClaTiF6iuOoxmqWmfxkdi3aBQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770030166; c=relaxed/simple;
	bh=hZ26fDidiQHdeKBfaZdypSRdmQ/WD1YSdkZPa9SDtxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTlUSGWfBJaoI1kGjvzLXiz28SCGn/ZUq/3v+uNCgqXa0m5wy+pVv0ygrKpEyfM2W9ST3DUabkVVag7dzekG7TyK4iof/ee2aAjf6M+7oHQ6kjG9NLZvbR7z4dQDtpm//GTSl3cBPXl8arqpT+j5CFgLSJMuRRIeMmNUIs7F/fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=e1C5v3m7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="e1C5v3m7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IOYz2TuhVp85h0jhI1HUwXLqYbeA4OKb+Y19Cz43y/E=; b=e1C5v3m71HQEFE+NdXuiJSWjVf
	WB+g3NMiak3HrbVsDD1ryKPCC/bZC6BdPzGClmo5S5UttzXBG3gtgYBlL2T23POoudKMZQU57QxQQ
	0P6JTwiarTXfajkZT2ws3UtV83W+PQGrORIYUun5jvxSSxPm72VlBJSL5ROI9mbazCwfIBFPuH55w
	cPQMfKqLwmMzWo+G/J/aXjyywDBils1KDt/M5s5v64mrSO7c3izOuCto1chym22gCymLRlXoCR4yt
	1ZpFfRXB5paLK4lkQOiiUFePEiU/dWnSCTRYEYpgQeDTGyBqq005UNEcMcTp5VftEsC4Y6S8caen1
	RLgaCQVQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44854)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vmrhO-000000003tp-1v8X;
	Mon, 02 Feb 2026 11:02:30 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vmrhL-000000003L4-3UCM;
	Mon, 02 Feb 2026 11:02:27 +0000
Date: Mon, 2 Feb 2026 11:02:27 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next v4 3/4] net: mdio: add unlocked mdiodev C45
 bus accessors
Message-ID: <aYCEQ1fAzc2OWcPP@shell.armlinux.org.uk>
References: <cover.1767718090.git.daniel@makrotopia.org>
 <36fbca0aaa0ca86450c565190931d987931ab958.1767718090.git.daniel@makrotopia.org>
 <aV1MGQirTHyFdv7Q@shell.armlinux.org.uk>
 <aV2OWT4g0jwfS548@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV2OWT4g0jwfS548@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 06, 2026 at 10:36:09PM +0000, Daniel Golle wrote:
> On Tue, Jan 06, 2026 at 05:53:29PM +0000, Russell King (Oracle) wrote:
> > On Tue, Jan 06, 2026 at 05:14:57PM +0000, Daniel Golle wrote:
> > > +static inline int __mdiodev_c45_write(struct mdio_device *mdiodev, u32 devad,
> > > +				      u16 regnum, u16 val)
> > > +{
> > > +	return __mdiobus_c45_write(mdiodev->bus, mdiodev->addr, devad, regnum,
> > > +				 val);
> > 
> > Something doesn't look right here - missing a couple of spaces to
> > correctly align? I suspect checkpatch would spot it?
> 
> Somehow those two spaces got dropped somewhere on the way. Strangely
> neither checkpatch.pl locally nor on patchwork[1] caught that -- maybe
> because 'return' statements are somehow treated differently?
> 
> Anyway, fixed in my local tree now and going to be fixed in v5.
> 
> Are you otherwise fine with adding those unlocked mdiodev c45 helpers?

Yes.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
