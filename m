Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C5431F9B1
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538382; cv=none; b=DnTmcW/we8O7vPR6AAGHxmZguewOHJN0+vn2u9Aw06YMIQOtv9HmYvMRcTdi9HAyF+1g1aRWDHbte0BJKdeQbBnRspFdfF1XhmFrlJEGfz0o3e96xhF9jmHVIKMD2Og5t3Nesn10w/vRF4It+jf2JXbIElrm2Cynf3sis3gYbd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538382; c=relaxed/simple;
	bh=riShO0B+XJvgymHRo4pobwzGA26gP3YuwHdHwRXiKEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uO0co0n2dPqhXB7URDgBZXXNAM+vKNN2Y2gO83+GUHKT/WnyMXZhw9GkMhBg8muiHsGRkshpZSgkEq5xn+AuNhNZOZ1iU2X7X++/esJLjf/So56YDu8j8GUri0qzQFgbfFdRBxQyGj/67t3pEN2tK1frverGNM6olpUF/BOIFnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=z4WZ0+Pc; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="z4WZ0+Pc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HTBHsV6WBbwTbUCCq7Wss7dUMGmY3e7LYLqUZajKUxA=; b=z4WZ0+PcJ2izrmpkC0B1uY5Snm
	V+kfxwXZDcErRzjzOr8Bstd42BvRhj7jHgIjXK/7ln9ikf6c8HDcUbVqhhmYxbZYReGm+9y3IXoUQ
	eoj4JUzsHfBBoch/ow39E+r2MWW3fRbZAjGz0Lmq/Mt6ozG5RqHxiY8IPXKZFbWyHk14+k85JU04Z
	POrtv0oy/GPS08VCyCDtAMbJ9t8lfz8HEHbW03KqAnboyQqWEWAi22PhQGaYbsll8lEsgwv/Owjlt
	MLR1HOj78d8fTF9lfUgqudPABNHNkcu5e4U7iWdra1R96FKcXKQrfIxOkNyS4284lrYoFyC0CuNhv
	PWtOTlOQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37094)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w5mUk-000000004wo-1piI;
	Thu, 26 Mar 2026 15:19:38 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w5mUi-00000000783-3yNo;
	Thu, 26 Mar 2026 15:19:36 +0000
Date: Thu, 26 Mar 2026 15:19:36 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net] net: sfp: Fix Ubiquiti U-Fiber Instant SFP module on
 mvneta
Message-ID: <acVOiGTN2uPTJXRV@shell.armlinux.org.uk>
References: <20260326122038.2489589-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260326122038.2489589-1-kabel@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Mar 26, 2026 at 01:20:38PM +0100, Marek Behún wrote:
> In commit 8110633db49d7de2 ("net: sfp-bus: allow SFP quirks to override
> Autoneg and pause bits") we moved the setting of Autoneg and pause bits
> before the call to SFP quirk when parsing SFP module support.
> 
> Since the quirk for Ubiquiti U-Fiber Instant SFP module zeroes the
> support bits and sets 1000baseX_Full only, the above mentioned commit
> changed the overall computed support from
>   1000baseX_Full, Autoneg, Pause, Asym_Pause
> to just
>   1000baseX_Full.
> 
> This broke the SFP module for mvneta, which requires Autoneg for
> 1000baseX since commit c762b7fac1b249a9 ("net: mvneta: deny disabling
> autoneg for 802.3z modes").
> 
> Fix this by setting back the Autoneg, Pause and Asym_Pause bits in the
> quirk.
> 
> Fixes: 8110633db49d7de2 ("net: sfp-bus: allow SFP quirks to override Autoneg and pause bits")
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
