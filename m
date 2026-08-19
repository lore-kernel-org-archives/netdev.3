Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D0721256C;
	Wed, 19 Aug 2026 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787146622; cv=none; b=SnVIxzypC6T8ifQWoPrFOrt07axP3NRWoeFoDohQkGsWP4xk9GIhsDzUFzIlzePWHvi5Z0NtC8NljHRU5p3AdEtoNma5umMeV2BNOtEX4t7IoRZDwMXGvtxWZjn7xGGPM/WRbSLThKFyVFxbnI7+bZBKCIUHNrdW4Zu2tZQlvlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787146622; c=relaxed/simple;
	bh=UmYXmJ+vbxBNJE9143Wph/oo9v6tdzLhxUMRymi/LPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsArcXxEFHXJ1dcv8M2ss48/OhcQ4wuvRhvqd3rPtIGq3HVFSyIzem78XTvndff/VhsWkRObjapT65PAWIbV6s9kJzk/VAXSaX3tLrldYXBFm+43OzuJaOAIcjNoaLtyVC/QJHAZSvvRxI2NDSeWP1pm2a8gWFAkwp8HN4wmsuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lO0gDFtd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lO0gDFtd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jhqfKA3Wmv1Rt0ol6WfpY0prF02il//deb1cZOgsrLo=; b=lO0gDFtdTdpIHjc1SdM03EEC59
	OZtNrJ6+Ppzsxym5Yu7iBII1oeGn/b5itaV34DU3zn6AIfWfF0ohsfgY1k+jcQS+j272rroZ/iX85
	SXvPJdBiPLT/qXQ1L7UGrLwO83HHT4hHn4ICd08dcnHoAGSql03zyKWsQI4BbL4U6TTM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wwgTM-000c4o-5R; Wed, 19 Aug 2026 15:36:52 +0200
Date: Wed, 19 Aug 2026 15:36:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, kuba@kernel.org, maxime.chevallier@bootlin.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, chleroy@kernel.org,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net v3 2/5] net: phy: unregister SFP upstream before port
 cleanup
Message-ID: <75de5cd8-662e-4874-86dc-5f9c5cd6ca5b@lunn.ch>
References: <20260819060236.24665-1-xuanqiang.luo@linux.dev>
 <20260819060236.24665-3-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819060236.24665-3-xuanqiang.luo@linux.dev>

On Wed, Aug 19, 2026 at 02:02:33PM +0800, Xuanqiang Luo wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> Commit 4497f5028675 ("net: phy: Clean the phy_ports after unregistering
> the downstream SFP bus") established that an SFP upstream must be
> unregistered before its phy_ports are destroyed because SFP callbacks
> may access these ports.
> 
> phy_setup_ports() does not follow this order when a later port setup
> step fails after phy_sfp_probe() succeeds. It destroys the SFP phy_port
> and leaves phy_probe() to unregister the upstream later, creating a race
> between port destruction and SFP upstream callbacks.
> 
> The error unwind is also split across three functions. If
> phy_setup_sfp_port() fails, phy_sfp_probe() leaves the upstream
> registered and relies on phy_probe() to remove it after
> phy_setup_ports() returns.
> 
> Make each layer unwind the resources it successfully set up. Unregister
> only the upstream in phy_sfp_probe() when SFP port setup fails, since
> the failed port has already been destroyed. Add phy_sfp_release() for a
> successful SFP probe, and make phy_setup_ports() use it before cleaning
> up the remaining ports. Once phy_setup_ports() has rolled back all port
> setup, make phy_probe() skip this cleanup.
> 
> Fixes: 589e934d2735 ("net: phy: Introduce PHY ports representation")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
