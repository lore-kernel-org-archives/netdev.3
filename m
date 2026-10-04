Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE94448BA7;
	Sun,  4 Oct 2026 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791124962; cv=none; b=Se/Y6pi/rN2MMISA3B3k8Xxm9eTVKEcWDw20conXF50aW7YevWya6s5JegPOuwVr5yO/Xtl/vsxdGPdE3wzCZfNMLzUHCzzLF/d4vjon/pbJgZPt8zrjUWBO+9lN9VHz2cua7vnpg9tIlYYsign8/mKp23TRGMKTlUJg/BxqED4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791124962; c=relaxed/simple;
	bh=CiAL7j+GnO5IVVEXLMsiKwUbLpPLh0uZufdnRm+rpDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qT0QTSectobDAX/B5MYV1zBx2ZgDjQuE4zU9UBSONpvPQFB/tVtgsdgVlGxeUW33TgRcTcWxPGCyLkcH/MvCnX1faWPCZX+mW8J1LqCX/tn0elTvdiFzYlM+5Coca3WgfyHK+McI8VJVxXtiD5C0gJFHBnZlJGrHvoQDXgCJz5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=f2QeQoVY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f2QeQoVY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OtkrZHCYh634bsPXp86aUt7BoCCL4fNy1CBQWy26XoI=; b=f2QeQoVYoZYssnv0z94lLf+Ys/
	bZ5CZF3ZnSee/n7uE0qBKLTdLNFLX4Y1MuBy88u7Hj3GV5rn4rteiTV+aJj3sQMN1urLNurcnxI4Y
	An2Uf8riFj11ceGXCGfRzUAUko3PoYIyVpT3iAk6WzlecpkKJv0EJjFWiItVyAfLYMxE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xDNPz-008tTh-BJ; Sun, 04 Oct 2026 16:42:23 +0200
Date: Sun, 4 Oct 2026 16:42:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Igor Velkov <iav@iav.lv>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: stmmac: mask the MAC interrupt while
 resume resets the MAC
Message-ID: <17175b15-877c-4cbe-aca8-7c8d44eb667e@lunn.ch>
References: <20260930-stmmac-irq-shut-v1-1-104d1a1dcb28@iav.lv>
 <47a5be82-c09f-486b-a7e3-35e6edb89ad6@lunn.ch>
 <20261002043623.1304143-1-iav@iav.lv>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002043623.1304143-1-iav@iav.lv>

On Fri, Oct 02, 2026 at 07:36:23AM +0300, Igor Velkov wrote:
> On Thu, Oct 01, 2026 at 02:40:46PM +0200, Andrew Lunn wrote:
> > For my understanding, it is the hardware reset which clears the mask,
> > not software?
> >
> > If it is hardware, that is an odd hardware design.
> 
> Yes, the hardware: dwmac_dma_reset() sets SWR in DMA_BUS_MODE and the
> MAC returns its registers to their reset values. On dwmac1000
> GMAC_INT_MASK is a mask register, so its reset value 0 unmasks
> everything; dwmac4 has an enable register (GMAC_INT_EN) instead.

So the hardware design dictates that you must be ready to receive
interrupts when you reset the device, or at least, have them blocked
at a higher level in the interrupt tree.

Is probe written this way? Does the needed code already exists, its
just not used on resume when it should be?

   Andrew
