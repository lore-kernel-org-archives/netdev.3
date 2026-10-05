Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BA94C7525;
	Mon,  5 Oct 2026 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791219202; cv=none; b=FEqJVmivfcYgunJsGl+vxQzIP6WmvjNIDIaP2+5KVP+2gTQVgTgxVoTdfYh37GvMqILXiQ4Kmth3RMVNVTvOFRf9Lrlbb7okN60jku8aTm5IyYPPAcRO8xpbk+xw+JtcdIP3bkrzAkIBFoqfHy9lMoGcsSJeVsRo15zmoKRr5r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791219202; c=relaxed/simple;
	bh=4gDWg8dUF58ySNfYsIfwMfvrdfUzO7+6R2Tot6BrfJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOBQNrBTOpwSYqhCiciGW0lI97Fb38FuvwXQKQAaHPoU2yDZ86Khivk2RKBeuTdzx1kusHEZVnH0nfnOnDsmow7dQz4U357nYa39ltnu4apTsIZs1skDpuv5DYSCTjanzKo92bTRwQGc0ZmZe9FM9+zQXlKDY/zvCE7BZilXEG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2hWoUalA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2hWoUalA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ez30iSKca/HZCh1kV3ntgyzXrM/fSPn6ByobvU9QZUo=; b=2hWoUalAP8E2heDiqHp4YfJvm6
	9hgJp3dKGK0etPTPh1zUNz9Ldr5pVHAyqLGAySEBrv4tEkw/Q1+PoN4A9Y7gD58nHWO7rOBJScgnP
	0kZ+Y6o1iDS1n7Kj6cRR2AlE0RnlQ7d/iLE95NQBwrsYkWnwaEs5d0JZyO9bO3HFdj1Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xDlw7-0095Rq-O3; Mon, 05 Oct 2026 18:53:11 +0200
Date: Mon, 5 Oct 2026 18:53:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	olteanv@gmail.com, Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com, steve.glendinning@shawell.net,
	f.fainelli@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v13 2/4] net: usb: smsc95xx: register the PHY
 interrupt with the MDIO bus
Message-ID: <718b12b3-337b-49b8-8db3-2a0fe69483fe@lunn.ch>
References: <20261001130236.106059-1-f@lex.la>
 <20261001130236.106059-3-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001130236.106059-3-f@lex.la>

On Thu, Oct 01, 2026 at 04:02:34PM +0300, Aleksei Sviridkin wrote:
> The interrupt this driver maps for its PHY is written only into
> phydev->irq, while the bus table mdiobus->irq[] keeps reading PHY_POLL
> for the same address. That table is where phylib records what the bus
> described - phy_device_create() seeds phydev->irq from it - so the
> number lives only as long as nothing else writes that one field.
> 
> Copy the number into the table entry of the PHY this driver found, and
> into no other. With an external PHY phy_mask is 0, so other PHYs on the
> bus keep polling. The address is known only after the scan, so the
> write to phydev->irq stays.
> 
> Found going through the drivers that keep a PHY interrupt outside the
> bus table, so that the restore on detach later in this series has a
> number to hand back here as well.
> 
> Assisted-by: LLM
> Signed-off-by: Aleksei Sviridkin <f@lex.la>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
