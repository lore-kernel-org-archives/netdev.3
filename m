Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2633E5561;
	Mon,  8 Jun 2026 18:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780944047; cv=none; b=P+s424wuIwoyjcgH8kOQ+uXxKtXAFH6vRerW30vHKW59FGug5mFZKXpm/mtuuVxx8s/8OC8WL84eloiPKtLb6S/rcWJt1IBpngmknaoRuLNPRX4Q2UdykRI6lqSlNXHvFWD5pJnec+i0nlkTKCAA5sEx969LBgAV9KbIbo4PrOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780944047; c=relaxed/simple;
	bh=2k8xmV15Hu+Aztbpw8GSLMJ4R+bML0xlElHkN7do8+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7lSeC9WA3GAfBYWdJhHFl4FIrnWLmPuO0sOPs5FD+mC7TUXYJUrUfjUmg3VLHgJVvaE6IDm+HLWFIjR2PwwtjECC3S14k54gEbIZkZWtQ0YoRRXxbuOMNc/+nzbn+WztcKcj1PovuzXQlVpWHpU+0bVu/67byXRbFyXRvs3z5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SvwTXcEs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SvwTXcEs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uHelTIok94J1fWkDDBNEFXmfABjBKzCothRWbKqYUo0=; b=SvwTXcEsqvEPmbXo1T+ubU7UMU
	/ozavXCSZ4hRPP8NqvC2T2SLpOViqMF06p6LZaY6qI4n9kxOUieJk5navJYHKtTjAr9bxGUt9/Yyv
	a6znGYeuKzE9M0FV5E8V4fnKv8uMEeccBJi7AwpezWj+fyeBAPEn3VVZJ6GzQWhZs5IA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wWetf-006g7d-ER; Mon, 08 Jun 2026 20:40:27 +0200
Date: Mon, 8 Jun 2026 20:40:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Javen <javen_xu@realsil.com.cn>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"nic_swsd@realtek.com" <nic_swsd@realtek.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v1 2/6] r8169: add support for phylink
Message-ID: <b47ce7e8-1f29-4819-be91-d17b098c30cb@lunn.ch>
References: <20260605103906.1445-1-javen_xu@realsil.com.cn>
 <20260605103906.1445-3-javen_xu@realsil.com.cn>
 <75cee79b-78d5-4a64-bbfe-8ba89f4cfb7d@bootlin.com>
 <e8ff0b30c02e4bc996380c4bb93225fa@realsil.com.cn>
 <d2aec499-071c-471d-b6ba-005f6e77d273@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2aec499-071c-471d-b6ba-005f6e77d273@bootlin.com>

> > Hi Maxime,
> > 
> > I have one question about the existing link-change interrupt model.
> > 
> > For most r8169 chips, the PHY exists and the current driver uses the MAC LinkChg interrupt to notify phylib:
> >         if (status & LinkChg)
> >                 phy_mac_interrupt(tp->phydev);
> 
> This is the first time there's an attempt to port a driver that
> typically deals with an embedded PHY to phylink, so we need to
> sort this out.

Well, mv88e6xxx has something similar, for its embedded PHYs. For
that, we export the interrupt controller as a linux interrupt
controller. We then allow two different things:

1) The PHY has a phandle to the interrupt. That causes phylib to
request the interrupt.

2) The interrupt controller code fills mdiobus->irq[addr] with the
interrupt number, so that phylib will request the interrupt.

	  Andrew
