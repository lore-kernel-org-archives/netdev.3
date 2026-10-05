Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1217947DD54;
	Mon,  5 Oct 2026 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791219191; cv=none; b=Om3o8GfJHkEeAtmTeCP1LgLcQHclXwxh2PEay0Ogovj7Sb/jk8oJ/Lg3fZmhp1s749g5xhM0+iel+ALzNwN6t3qpEYglT/unXntIfKUsyK8nW50blyghvc/qtYli1LWJuidjPz7qsl8pgicRmuv6ieINaVFBffnRLY2rJfvfHqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791219191; c=relaxed/simple;
	bh=ZScTMGsg8L/dy2CUftgGUoPbR/cYCOxkaMnxU/RkMZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5IDOY1pRXAAGbI4MM5rE5uYbxT3Vt5iv2IPkSnNOQplMGOpQ6NMM3EOxwRP5wzYpG0L2z0fvjqs61ywz3SUl+eFtKu31tiKQTC6W7hVkwIUwG3vWpEfAU/njXMqvEmiVFXi6ENnm5HZtsBFsrSz7/2lazJIZFgFYT2anhhldsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KH48miIu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KH48miIu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FMyIUG0JmRm/QKRb18kNbfZQhg+wf1FaOcGqSvloYhA=; b=KH48miIuJuCPPSMES+LtgZu9KI
	tZu/3oFaneHVBlnBNVnBtV8+Lr/Z0OfElb6PPa/FBpmt08p2kA0YWnkQx6TI3toSrnLetV/3J7kby
	+t1vEHyfpMHKX6bYat7HlgQu4hh7FM6uyKcGLJbiLnsflRRKsQB7ePjDkk1x5P8gIzmU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xDlvt-0095RA-Hj; Mon, 05 Oct 2026 18:52:57 +0200
Date: Mon, 5 Oct 2026 18:52:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	olteanv@gmail.com, Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com, steve.glendinning@shawell.net,
	f.fainelli@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v13 1/4] net: usb: lan78xx: register the PHY
 interrupt with the MDIO bus
Message-ID: <4648a2cb-56c4-44cc-bac1-e88cad6b375b@lunn.ch>
References: <20261001130236.106059-1-f@lex.la>
 <20261001130236.106059-2-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001130236.106059-2-f@lex.la>

On Thu, Oct 01, 2026 at 04:02:33PM +0300, Aleksei Sviridkin wrote:
> The interrupt this driver maps for its PHY is written only into
> phydev->irq, while the bus table mdiobus->irq[] keeps reading PHY_POLL
> for the same address. That table is where phylib records what the bus
> described - phy_device_create() seeds phydev->irq from it - so the
> number lives only as long as nothing else writes that one field.
> 
> Copy the number into the table entry of the PHY this driver attaches,
> and into no other. The chip has one PHY interrupt, and on 7801
> phy_mask is 0, so other PHYs on the bus keep what the bus gave them.
> The address is known only after the scan, so the write to phydev->irq
> stays.
> 
> Found going through the drivers that keep a PHY interrupt outside the
> bus table, so that the restore on detach later in this series has a
> number to hand back here as well.
> 
> Assisted-by: LLM
> Signed-off-by: Aleksei Sviridkin <f@lex.la>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
