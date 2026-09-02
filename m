Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBF539DBD3;
	Wed,  2 Sep 2026 20:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788382396; cv=none; b=g1b5ikFwun0OZjEeLI/4k/1rCFSaR8h4bCDDwx08ApL6zOLF/qzBqt1j4Iwr3CfoI1NPxom6QRRS8d5FX4wVE49er//NuoXdcL7irSoaoF5YNV7zvqKCrbT0lUueuLUEiE9HETq8pq8MYnfAT9T5DHqJt+woaHU807DllCSLSko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788382396; c=relaxed/simple;
	bh=xyvgF3K8W1pU0qEd+TmxZYw6LR0DV282WK4CVFy98i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OndDvGPpGboHKpeHtrN0m5nDXO1PkJ2Yg+ggNdFT+5poxqNzDK37I2ERHh/FEMMGE5Me16DpMjT9RsVl2yUftmgeWuL7YlmZ/ifyMIxC24nZJSsO7HAVPr/w3wHEi8E+8Mc0v0/pYo2QCqFjJ7/WBIIBVzcVIyOr/6lv437bEWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fLk1IEI0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fLk1IEI0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Rgl3Q8Eb+IfuW4zQLDD77AUhEakdol3I04MmfmPRBvQ=; b=fLk1IEI0ThzjXoB7wOwsz6j2z2
	mlFnUJ89I5upr8rL7koXwWvQv5g9CVUiXQCYl7iCCtaT+SoON8MxFlC7YptkALgHfgplzYrUHXKRF
	RwdFIMankI/9LTcY3a/Mx2kIoAEGIf7zfnWPV3O0OIol9kpX8JeY3vzP4rLK7QkgBIlU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1rx7-002aVM-8A; Wed, 02 Sep 2026 22:53:01 +0200
Date: Wed, 2 Sep 2026 22:53:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 2/2] net: phy: restore the interrupt after a
 generic-driver bind cycle
Message-ID: <69f2a065-6855-454a-96cf-1ceb9656369b@lunn.ch>
References: <20260902080511.2211261-1-f@lex.la>
 <20260902080511.2211261-3-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902080511.2211261-3-f@lex.la>

On Wed, Sep 02, 2026 at 08:05:11AM +0000, Aleksei Sviridkin wrote:
> A PHY with no specific driver available at attach time gets the generic
> one, and phy_probe() sets phydev->irq to PHY_POLL because that driver
> has no interrupt callbacks. Neither end of that bind cycle puts the
> value back: phy_detach() releases the generic driver so a real one can
> bind later, and a generic probe that fails never reaches phy_detach()
> at all.
> 
> The specific driver that binds afterwards therefore starts with
> irq == PHY_POLL, and the PHY is polled for the rest of the uptime with
> no warning on that path. A DSA switch that connects its user ports
> before the rootfs holding the PHY driver module is mounted hits this on
> every boot.
> 
> mdiobus_alloc() fills bus->irq[] with PHY_POLL for every address, and
> the bind cycle never writes to that table, so the entry still holds
> whatever the bus registered there. Restore phydev->irq from it on both
> exits, and only where the cycle left PHY_POLL. That guard preserves an
> interrupt mode a MAC installed on the attached PHY after connect, and
> it keeps a restored interrupt number out of the
> phy_connect_direct()/phy_disconnect() asymmetry, where such a MAC would
> have the interrupt requested and never freed.
> 
> Fixes: 00db8189d984 ("This patch adds a PHY Abstraction Layer to the Linux Kernel, enabling ethernet drivers to remain as ignorant as is reasonable of the connected PHY's design and operation details.")
> Signed-off-by: Aleksei Sviridkin <f@lex.la>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
