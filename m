Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1C73BB48
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253047; cv=none; b=smHpGx1lOf7O26MaPNZZr57Sc5D4HDjpwAzaYqtlKm/fiMAf/+sbupcFZRq73cFO67hPTOuzF2TKk1FhKk4IL6QIv5LogvI6PNw3pdF6+Bqjwh2QmC3lSXgNgAo1FALdliT2pMJe7k4A1zBPg87uoknHFXIKBfp7TqubiPA8ogY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253047; c=relaxed/simple;
	bh=HJt9vJhzYPF2Nk2HFHekvHC6+3mW4q//N65RSPmMe4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCoCoxakZ6QPPvizeiLNwDKHbAmBdjFmklRbMY0N1PzcfkcaI4BKABK/VJoqsxs4GoYWZPcPW1TnGBmR7IDJpgUvgt6UegSDR4ArHjvS4LHmFpiGG0o+bJgaGgdSm2OnVbMlVbC1ElspkCtt1rJp5mo5kLonaTthvC+2ODDnhaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hpeJ43Lx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hpeJ43Lx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=r6lQfqbNu4HQYdPGG/OwlPyXE5GLsLwaBAOZXcTBTro=; b=hpeJ43LxAW/WUcqjg1hSxrZMEG
	y/6wfBlVxlqf9woWiku6gjcpW+3rAja60iz09tmtCMOGrclBxk5M68BGejSLcvqJTtPm8N9Gv6Ueb
	pakWI3pK3+CamgSbEfJKsYfKiihMis3CG+RmJoEsiBLKMCfeNHTXnCO/D7BXIF5fYDEc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9iax-006zOq-Vf; Thu, 24 Sep 2026 14:30:35 +0200
Date: Thu, 24 Sep 2026 14:30:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yongzhao Chen <yongzhao.derek@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, Ziyang Huang <hzyitc@outlook.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [RFC PATCH net-next v2 5/5] net: phy: qca83xx: disable
 SmartSpeed before resetting CPU PHYs
Message-ID: <c09a810b-79a9-4a4a-b484-c26e1b4acb52@lunn.ch>
References: <20260922202653.1153-6-yongzhao.derek@gmail.com>
 <c50f5ffd-a67d-4adf-a38e-048acf7bd61d@lunn.ch>
 <20260923215735.234-1-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923215735.234-1-yongzhao.derek@gmail.com>

On Wed, Sep 23, 2026 at 11:57:35PM +0200, Yongzhao Chen wrote:
> Hi Andrew,
> 
> Yes. In the RA74 trace, generic config_aneg() returned successfully with
> CTRL1000 at 0x0600. A later read found 0x0400, so 1000BASE-T full-duplex
> advertisement had been cleared by then. I did not capture when it
> changed. The instrumented Clause 22 BMCR/CTRL1000 path showed no
> intervening write; other paths were not ruled out.
> 
> SmartSpeed is the downshift feature. I have no evidence of a broken pair
> or a successful fallback to 100 Mb/s. The 0x0400 value describes
> advertised capability, not the negotiated speed. Clearing SmartSpeed
> before the initial reset kept the internal link at 1 Gb/s during the
> tested RA74 boot sequence. The trigger remains unknown.

It is operating different to most devices implementing downshift.

All the other PHYs don't change the contents of the standard
registers, LPA still indicates the link partner can do 1G, BMSR
indicate the link is running at 1G because that is what the
negotiation resolved to, but a vendor register indicates the link is
actually running at 100Mbps.

Now, downshift is not part of 802.3, so vendors are free to implement
it however they want.

But back to this patchset. We have to consider, is downshift in
general broken? If so, we can just disable it in the PHY driver, and
add a comment it is broken. The flag is not needed. We could also
implement the tuning API, but have it disabled by default. Again the
flag is not needed.

I would prefer not to add the flag, but we can if we must. I suggest
you reach out to the vendor and see if there is any errata.

    Andrew
