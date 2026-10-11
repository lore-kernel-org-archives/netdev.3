Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32FB455612;
	Sun, 11 Oct 2026 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791726679; cv=none; b=kNV5g9O8x766OZ3YMQ3zmd0NFQmdWNdevX9FOnp7Gnc5ICn4XrfAdpZZh/GZkvGkO4lPD9twAeakdMlKTAPoL2/O4HawQ8rpIhyU4a38qxO1NE4Q2HyvvhGbo3oUPPG0UVwuFVfT7o6My+z2Ry4J39O+PpmiEl/1TOUcnqdRDHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791726679; c=relaxed/simple;
	bh=n/eKku/HXyb2EcXGi7lgwA3jWDrjTcnj+3b7gqZDiM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScHH8oHExTNmkisNSqH/G5Anva1NKJ1XXLifUeVQYA/DXwHyXp8MhZhS9BLWlCWx0CBncXi7BBFHJJG9oREWQJx3jQSqcqGd2sOFFmmd+0KIkn8O7SPnFItyJckv8mzPAZxVMLdNghxaYvONBBumt+tw5Q4Cj9DcmORoL23ixCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SrqZnvuy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SrqZnvuy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=kePRgEFQ6fN1SssKO5+Z8skr9RxgziDKNM9ANVVAz5k=; b=Sr
	qZnvuycRSL+AzI92lqFvLx04fsbmfxHFC/tpRpc4cC/73dzZWIL4zG56Gv3o+YyyEDOf6qu0+MoW/
	93ebebmXBPYUdv55NlW99E6k/eadv+ql8sCrT09rFFv927q8NFdGPx4nP0GDRdUKadXCTx4qxPMuy
	h25NUmB6G3iE8Xw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xFtx5-00A6U6-W1; Sun, 11 Oct 2026 15:50:59 +0200
Date: Sun, 11 Oct 2026 15:50:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Clark <jjc@jclark.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>, Nicolai Buchwitz <nb@tipi-net.de>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Russell King <linux@armlinux.org.uk>,
	Conor Dooley <conor.dooley@microchip.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Miroslav Lichvar <mlichvar@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/5] net: mdio: add timestamped MDIO writes for
 PHY gettimex64
Message-ID: <804e7c63-e762-4040-9d60-35d21df75531@lunn.ch>
References: <20261009143506.2507607-1-jjc@jclark.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261009143506.2507607-1-jjc@jclark.com>

> For example, using PTP_SYS_OFFSET_EXTENDED on the Raspberry Pi CM5 to
> synchronize the system clock from the BCM54210PE PHY PHC leads to the
> system clock being 32 µs ahead of the PHC. On the CM4, it is about 7 µs.
> (The difference is because the MDIO clock frequency is higher on the
> CM4: 10 MHz as opposed to 2.08 MHz on the CM5.)

IEEE 802.3 says the clock should be 2.5Mhz. Does the CM4 use a
clock-frequency DT property to enable this faster clock?

	Andrew
