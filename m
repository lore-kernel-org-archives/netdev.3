Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469DC374A0B;
	Mon, 12 Oct 2026 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811107; cv=none; b=ekas9nq0/10ngVssNf9RHkFaFhbUsPr6NKk6cA65UgliXkmx/drBVJsPzJveiAJD3/XnsqmifHOaCCT5kr9uIMElKi+glnO+2uRCYpgKSA5Y9q8xLtcYy3sdKCHrRYsjGgEQ5mJf4KlpYNiuFb4Fv0UPb6QDjjESQ3gRKDIs7Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811107; c=relaxed/simple;
	bh=AzjuoH0vknrDz4e3haaF13WLjGpDY0yTb/N/9QPV9qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLdLtWATuEYrchUgBg84JzpYDbpH15G+VZJoV+UHmLLIjSDyqJG20cFz/SBPmdEVnqe4Vej9Q7ahQmNzfL2GbE6YNGHhwBC27iHDJ6+ygHIgpgn0K6L5iePckB/4cQGlsIiozAk8MmLBBR3g+83EJD5+J5PgrRiKB0Y4J8d1qxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5FRHr7lv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5FRHr7lv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=s6P2PLaoKfqE5tTicRYyiqRKnLpbtn3os9hoyNl9VUA=; b=5F
	RHr7lvu58c3UpyMIhbyKOyYeeBVwV76JqvoZoDUmUuBgavwobHJPrDwqAehoDLGN22jCKOiP3a6uB
	YJOs/TfCX9nJxJQcPCOM56h6q1qFAOnwFygem++CsJJUVEGb9abtVvsVFQhSV0+igy9ieNZEC3rpI
	Opm4O7Jf4vnbUtA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xGFuu-00AKP8-2g; Mon, 12 Oct 2026 15:18:12 +0200
Date: Mon, 12 Oct 2026 15:18:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: James Clark <jjc@jclark.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Russell King <linux@armlinux.org.uk>,
	Conor Dooley <conor.dooley@microchip.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Miroslav Lichvar <mlichvar@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/5] net: mdio: add timestamped MDIO writes for
 PHY gettimex64
Message-ID: <23454c46-95cf-4e46-9621-149bf9350199@lunn.ch>
References: <20261009143506.2507607-1-jjc@jclark.com>
 <804e7c63-e762-4040-9d60-35d21df75531@lunn.ch>
 <db3a0f73c1883645f51294ca46cffe05@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db3a0f73c1883645f51294ca46cffe05@tipi-net.de>

On Sun, Oct 11, 2026 at 08:07:13PM +0200, Nicolai Buchwitz wrote:
> Hi Andrew
> 
> On 11.10.2026 15:50, Andrew Lunn wrote:
> > > For example, using PTP_SYS_OFFSET_EXTENDED on the Raspberry Pi CM5 to
> > > synchronize the system clock from the BCM54210PE PHY PHC leads to the
> > > system clock being 32 µs ahead of the PHC. On the CM4, it is about 7
> > > µs.
> > > (The difference is because the MDIO clock frequency is higher on the
> > > CM4: 10 MHz as opposed to 2.08 MHz on the CM5.)
> > 
> > IEEE 802.3 says the clock should be 2.5Mhz. Does the CM4 use a
> > clock-frequency DT property to enable this faster clock?
> > 
> > 	Andrew
> 
> The Pi 400 is the only BCM2711 board with clock-frequency in DT
> (1950000, from a downstream "Limit MDIO clock speed" commit with no
> further explanation). There the driver's assumed 250 MHz reference
> gives divider 63, which with the real 200 MHz (see my comments on
> patch 5) is about 1.56 MHz.
> 
> Pi 4 and CM4 (the one with the PTP PHY) have no clock-frequency, so
> the driver keeps the firmware's divider 9, and 200 MHz / 20 is the
> 10 MHz James mentions.

For CM4, i think the PHY is on the board? Does the MDIO bus get
exported via a connector? If it is a closed system, then running the
bus faster by default is O.K, since it is impossible to connect a
device which is only standards compliant. But if the bus does get
connected to the carrier board, it would be better to stick to 2.5MHz.

	  Andrew
