Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9729B3B19C0;
	Tue,  7 Apr 2026 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775581156; cv=none; b=YWJGtzmq7g8elbMy7bplqQTf+ZPgRCVd1n87vdMEMz9Aw2wtZUfbFIYChVF6mrGlgM+lm8OuBgr3frIHtMbbiO66PaOMy4+PLY/tRiDAZATCafHEP64dHSmJWJLgKs8hVHIxDD9F25UUEZruLJ6Iq/dr/8zWPDezqebPjF3RGpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775581156; c=relaxed/simple;
	bh=D99V5nKqCKDuklXKWscye3tWeyumOXb4r5u4cGBl2IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwiEO5/meTFo9FHfni1dRWrFq4SSvjLF+uEeuij28Y3UXFhbl3JVg3itEElkDPb1M7glXu7EFyJ8nO0sCTW+Er8pKV7V3nllUSgdYcYpt8E5GsP6C2sIa8wSecif2QoOPxxXaWE/GZ9r3EozEkuRYJxz97ttCd/TY2fgWdiFCmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=q2yhPC+V; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="q2yhPC+V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3ILa0bksr+OwfJin0YRdxhcze28jwJY1Ha+jOQOReF4=; b=q2yhPC+Vfb1m31Ntl1f+ity/cU
	BUs+rD95as3Jxp7UXVNMF4eEHcFxmfp6f04tTZe7mEorYgiqvYTJsH+gt8AwxK5AMcXg+KVk8qapS
	TONgQRdZgvV/u89wlDkj8FixYbeu6R5kv3UsSE6T1YegNzLb0be/DI6QlHev08R7PqQE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wA9lU-00FA0c-IB; Tue, 07 Apr 2026 18:59:00 +0200
Date: Tue, 7 Apr 2026 18:59:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Charles Perry <charles.perry@microchip.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/3] net: phy: add a PHY write barrier when
 disabling interrupts
Message-ID: <b63c401b-bea9-4a2d-a43e-cd20c3013f53@lunn.ch>
References: <20260402131229.319599-1-charles.perry@microchip.com>
 <20260402131229.319599-4-charles.perry@microchip.com>
 <6bb3aec4-1635-4287-b7ce-f15b693563ea@lunn.ch>
 <ac6vfhsW2ThF8i2_@shell.armlinux.org.uk>
 <b40dfafe-7e8f-4686-a743-31b097c84954@lunn.ch>
 <adUupYuD6tM3ahaR@bby-cbu-swbuild03.eng.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adUupYuD6tM3ahaR@bby-cbu-swbuild03.eng.microchip.com>

> static void phy_write_barrier(struct phy_device *phydev)
> {
>        int err;
>  
>        err = mdiobus_read(phydev->mdio.bus, phydev->mdio.addr, MII_PHYSID1);
>        if (err == -EOPNOTSUPP)
>                mdiobus_c45_read(phydev->mdio.bus, phydev->mdio.addr,
>                                 __ffs(phydev->c45_ids.mmds_present),
>                                 MII_PHYSID1);
> }

Using __ffs() is maybe more complex than needed.

All you are trying to do is ensure the last write happened, by doing a
read. Any read should work, even if the device does not respond. We
just need to be careful not to read a register which might clear on
read, such as an interrupt status register, or the link status, which
latches. MII_PHYID1 is safe. Since we throw away the value, we don't
care if the MMD is not present, the read will still flush the previous
write. So i would replace the _ffs() with a hard coded value. KISS.

> Do you think there's any way I can test this on my VSC8574 or VSC8541? It
> supports some C45 registers for EEE but not the device discovery part.

It is not so easy to do. You need to hack the C22 read so that is
returns EOPNOTSUPP, but you also need the first few reads to return a
valid value otherwise the probe will fail.

I think this is one of the cases that if the reviewers thinks its
looks O.K, we can accept it without extensive testing.

      Andrew
