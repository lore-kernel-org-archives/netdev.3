Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608E74322FC;
	Sun, 27 Sep 2026 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790533776; cv=none; b=eKzaE7QEDtjcgw9ZZK8/C/IWNRJE8xnNmPJYjPX6z6/RN0VTILirEqENjN8Dr1SpJiBlquhV9iDA7EOsJHshs3OdXprZIv53TuXv5iVLrRJYHvXBkzeSrMA53ZC782p/V06Aj/hjq3dcAPvueI/NG38Grs63MntZBNZ6qi0GsMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790533776; c=relaxed/simple;
	bh=8nqFiAjKd+TsUCaD2pgLji+Qwh+m7WZPsw4ajdsjSgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCeHkcHhrq0cTNKFVLoMKH0YMKAYoI5LA1rZpsAoPIEo7u+waJfLbl+3z/PxRFfhN7f+y1gaWTnMe1gO6D6XgtAyQYlXcriieDA8qIKWd0a7PnaJ05rA+047vl/CwccnByvMTvlz1oXWAtWm6R9HEnH+eW/7o+AwTdTfwf+R1tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uo/7MSZS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uo/7MSZS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TjT1SNBufOlfR30tGY84jycsHPoH/MsNq7WON+jg0j0=; b=uo/7MSZSNwZip0mO16XabFEtfV
	b8DdZA3kUb0KndXEDv3QUzdoDPVsrEFB5jQoWTJCVu81lVcYJjDlgNPznW1NkLHifFQ0ZuLRijLQU
	GxsA4wEER4V+tWFSePNHmppnI/N6BEGAiuh1hDrp4pRwUM2s8CHNpBx8XouV31TC0tSs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAtcg-007YHf-Bp; Sun, 27 Sep 2026 20:29:14 +0200
Date: Sun, 27 Sep 2026 20:29:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	olteanv@gmail.com, Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com, steve.glendinning@shawell.net,
	f.fainelli@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v11 1/4] net: usb: lan78xx: register the PHY
 interrupt with the MDIO bus
Message-ID: <9e3c5c70-3fef-4101-99ee-e97ed18bae71@lunn.ch>
References: <20260926235024.705646-1-f@lex.la>
 <20260926235024.705646-2-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926235024.705646-2-f@lex.la>

On Sun, Sep 27, 2026 at 02:50:21AM +0300, Aleksei Sviridkin wrote:
> The interrupt this driver maps for its PHY is written only into
> phydev->irq, while the bus table mdiobus->irq[] keeps reading PHY_POLL
> for the same address. That table is where phylib records what the bus
> described - phy_device_create() seeds phydev->irq from it - so the
> number lives only as long as nothing else writes that one field.
> 
> Put it in the table before the bus is registered, so that the PHY the
> scan creates is born with the number, and drop the write to phydev->irq
> that phylib then makes by itself. Fill the whole table rather than one
> entry: for 7801 the address is not known until the scan, and for the
> other two phy_mask leaves only address 1 readable, so a loop costs less
> than a second switch on the chip id. A devicetree PHY node that
> describes an interrupt now overrides that, where the driver's number
> used to win.
> 
> Found going through the drivers that keep a PHY interrupt outside the
> bus table, so that the restore on detach later in this series has a
> number to hand back here as well.
> 
> Assisted-by: LLM
> Signed-off-by: Aleksei Sviridkin <f@lex.la>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
