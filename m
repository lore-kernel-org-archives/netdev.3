Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2E242DA3D;
	Sun, 27 Sep 2026 18:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790533801; cv=none; b=Nz4x1TaZIraamJWayR9WmO4DMBTeRQ7Gic2IpUIyAALIc7FWuSWpPBYvJf700dTY9+wVwk8mGCI4/81G+xFttiqTbNwMzZR8p6GI9AeP3Qa4NTBnsKLnLPXDgsZ+y+aE3DV8S35NxE9PpcOmJsuuNo6wLjxvSD4tC8H2F8keuoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790533801; c=relaxed/simple;
	bh=4JgL+u1j63COffjPH1SHWapTdRagUiiXEatiid42OGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhbF9ImAFNw7IobkzRRhLGJQdaHtZ88UkE1xw9mEf73sEANvmU9ynz1MuP2fpPnFi64LqF1HctAoWQqAEewn/IqSyBxuRc5kaxgmspzCrKcbQ+2Rc712sUSZm0MFYXuTkFFr8zwxIYhBtNTDda/gNG/GDEC1kTb21jLPTtwpsJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=q3KBMLs9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="q3KBMLs9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=h4Wn2lgtX7WaN2b2S4lHGroqaBqu7CJ/C7ilaM5xfzY=; b=q3KBMLs9K9rmwdPORmM1SoH84U
	5IL8Z9PTI8QBtFW8w7iUSKyr1HsNuhV7uYuB1iX9/+BRQmJH7mqQtvswJOlMYfexnZNESDtKHUbPZ
	EKiB+b8zPUn1u7AJDo/fNk/Fu35adXLbpypJiuxVC2JAIo+B6PDv8Ek5vlkFpJVBNpBs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAtdF-007YIV-7V; Sun, 27 Sep 2026 20:29:49 +0200
Date: Sun, 27 Sep 2026 20:29:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	olteanv@gmail.com, Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com, steve.glendinning@shawell.net,
	f.fainelli@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v11 2/4] net: usb: smsc95xx: register the PHY
 interrupt with the MDIO bus
Message-ID: <c86b317d-8bf7-4921-90f6-6538a682a521@lunn.ch>
References: <20260926235024.705646-1-f@lex.la>
 <20260926235024.705646-3-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926235024.705646-3-f@lex.la>

On Sun, Sep 27, 2026 at 02:50:22AM +0300, Aleksei Sviridkin wrote:
> The interrupt this driver maps for its PHY is written only into
> phydev->irq, while the bus table mdiobus->irq[] keeps reading PHY_POLL
> for the same address. That table is where phylib records what the bus
> described - phy_device_create() seeds phydev->irq from it - so the
> number lives only as long as nothing else writes that one field.
> 
> The bus is the one this function is about to register, so put the number
> in its table first and let the scan seed the PHY from there. The whole
> table gets it: with an external PHY the address is not known until the
> scan, and with the internal one phy_mask has already left a single
> reachable entry, so a loop costs less than a branch on which case this
> is.
> 
> Found going through the drivers that keep a PHY interrupt outside the
> bus table, so that the restore on detach later in this series has a
> number to hand back here as well.
> 
> Assisted-by: LLM
> Signed-off-by: Aleksei Sviridkin <f@lex.la>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
