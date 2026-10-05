Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88F44ACC7A;
	Mon,  5 Oct 2026 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791219350; cv=none; b=Wrfqzjl6nNqhJCd6gExNWw/4xLOMJPdcx1+MCtet/OzRQIrFwuPd7gxhl7oOSoRk0WqRlRxQUGvXQ22IiPtT6lMK56x7tRPIrP33X3aq9I1dAKkhDPO3iJ9k1eH8Jb9xPabyC8ZYp6GlXTrQIE/wq+j5h0YQOLaXy+JyCXxa8+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791219350; c=relaxed/simple;
	bh=tH4kt4KKzkl8e/5IwFOkVlSjdwTMP0CegCI52k5oMLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Opql9bwPDYw2z/uqeX3IiFmHEUS4busNgDBqGIRy3DBM92QQqjKZ15UKbP0fcLPVbszrRqtd+I2NuYYg2W1MDdTr6mSs1bb0UP59zCUxgUWfmxVg7JKM5f/Voq0zYCF5/7+Hld1nn+ChrhtcUc5psuuI/91rNCtmPnNxfcMzHGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3cMOjZsH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3cMOjZsH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nEpuGRktx/E9kEVloTN+f3kgD/f2s5E0WF96GrA2Ut8=; b=3cMOjZsHa+j+Jew+xMbWJ0VeVW
	EJfgoMkN2afJgVcmykjn+wPKbxUyCDvMOcXt7/oMpGlL7hH98gmY6Ul0u6epw0cevzM7uKPLBeuy3
	0f3zEiQCSnBrXRP3P3r7aFxzLRu9sVCnPuvimjUSEBo/0CB1M5nh7pXfjf5ABc+FWqoc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xDlyV-0095UL-MO; Mon, 05 Oct 2026 18:55:39 +0200
Date: Mon, 5 Oct 2026 18:55:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	olteanv@gmail.com, Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com, steve.glendinning@shawell.net,
	f.fainelli@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v13 3/4] net: phy: take the interrupt back from the
 bus on detach
Message-ID: <15cfe73f-9547-4cbd-9c70-52d39766d85d@lunn.ch>
References: <20261001130236.106059-1-f@lex.la>
 <20261001130236.106059-4-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001130236.106059-4-f@lex.la>

On Thu, Oct 01, 2026 at 04:02:35PM +0300, Aleksei Sviridkin wrote:
> When a PHY's driver is a module that is not loaded yet when the MAC
> connects, the PHY gets the generic driver first. phy_probe() then
> replaces phydev->irq with PHY_POLL, because genphy has no interrupt
> support. Nothing puts the number back, so after the real driver binds
> the PHY is polled for the rest of the uptime.
> 
> Seen on a Keenetic KN-1012: the Airoha EN8811H behind an MT7531 port
> has its driver on the root filesystem. Its devicetree interrupt maps to
> irq 15, and after the real driver binds phydev->irq reads -1.
> 
> Restore the number when the PHY detaches. It comes from the bus table,
> mdiobus->irq[], where the bus or the MAC driver recorded it. Do it only
> when phy_attach_direct() bound the generic driver, since that is the
> substitution being undone; otherwise the field belongs to whoever wrote
> it. Do it before device_release_driver(), because after the release a
> probing driver can write the same field.
> 
> The store is ordered before the release rather than locked against it:
> device_release_driver() takes the device lock itself. A MAC that sets
> phydev->irq before phy_start(), as phy.rst describes, is not affected,
> since the restore runs on detach, between connections.
> 
> Tested on the KN-1012 with a 6.18 distribution kernel: phydev->irq
> reads 15 after the real driver binds, and -1 without this patch.
> 
> Fixes: 00db8189d984 ("This patch adds a PHY Abstraction Layer to the Linux Kernel, enabling ethernet drivers to remain as ignorant as is reasonable of the connected PHY's design and operation details.")
> Assisted-by: LLM
> Signed-off-by: Aleksei Sviridkin <f@lex.la>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
