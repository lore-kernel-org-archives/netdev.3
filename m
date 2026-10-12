Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28F73438A0;
	Mon, 12 Oct 2026 11:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805916; cv=none; b=cievcEQQ7mc3brTWOXDlltgOjmU8voMvt9jnvOurUosfpODHGgFEUhDgn887MLoX8tt4z5J1uxAoMipzSn5y/F3MA1skIZqYWDIEcUwuuYHlAPSmYZ8sS6+R8m7KgpO7VOz2+s2oDOrncHvcn0/fjrpBOEhgTrnpJTSsq7KPLqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805916; c=relaxed/simple;
	bh=RJtJANzAk6DHDx/mlpc2S7FJYP+FwI/6QcnRA5HKNdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXFq9kPAZyfnTa8aOUil7Y27X/s68yGDakW3Pl6PR9xRb1/KOxQw5qagk5JLssrZucr2KOa7d/Z8PrbwzXb3OYGAzFZ+QN6XG+zuDlozFwO6oZ4SOBwLekZrbkxwIE1nWw5z+Rzt0Y1BkbTnqsqKlPcuwFfSRXod6TLWS6SSwh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BskqUePM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BskqUePM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=4mYreJU3/9ctvW9f76EbuNSnfvvRh98Nwxnm3uacts0=; b=Bs
	kqUePMTC7jcHUtnJucA9TnYpbUhUKv1Uctr6KxiXAtZL0wQ/GCI1fL5cTpFII4G2tgbIQaJTXL/zw
	8QqUvkJR2NggrKSgQ/uT04a08g9tnOxLIRG9h/SaOjiV8CGf5Nws2txlq3SHTc2/eS/rIXjLDrUzW
	i/H9MLWPECre39w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xGEZ6-00AJcu-Et; Mon, 12 Oct 2026 13:51:36 +0200
Date: Mon, 12 Oct 2026 13:51:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: James Clark <jjc@jclark.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Doug Berger <opendmb@gmail.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Russell King <linux@armlinux.org.uk>,
	Conor Dooley <conor.dooley@microchip.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Miroslav Lichvar <mlichvar@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] net: mdio: bcm-unimac: implement
 timestamped MDIO writes
Message-ID: <68eeee64-7f62-459c-b53d-61ec04b4d8e3@lunn.ch>
References: <20261009143506.2507607-1-jjc@jclark.com>
 <20261009143506.2507607-6-jjc@jclark.com>
 <3b1a2994-5251-4800-8c61-b63d7a435b21@broadcom.com>
 <60accbd89cfaf0d4be1da5ec2fafd975@tipi-net.de>
 <CANz3_EYfcBopo=HgRioXkhoT6P+4WWpfFT7UeWkXd5eM_RNpSA@mail.gmail.com>
 <41c32f5a6f38ec9df8a79ce896912fb9@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41c32f5a6f38ec9df8a79ce896912fb9@tipi-net.de>

On Sun, Oct 11, 2026 at 03:22:04PM +0200, Nicolai Buchwitz wrote:
> Hi James
> 
> On 11.10.2026 09:20, James Clark wrote:
> > On Sat, Oct 10, 2026 at 10:18 PM Nicolai Buchwitz <nb@tipi-net.de>
> > wrote:
> > > I dug a bit deeper on a CM4: AFAIU the MDC runs off the GISB clock,
> > > which the firmware sets to 200 MHz (CPRMAN 0x1d8, PLLD_PER 750 MHz /
> > > 3.75). Bumping that divider to 4.0 at runtime moves the MDIO busy time
> > > by exactly the same ratio, so that's the one. The 250 MHz you have in
> > > mind is genet250 / genet125, the RGMII side, a different generator.
> > > 
> > > So instead of a fixed clock or a compatible match this could just be
> > > BCM2711_CLOCK_GISB in clk-bcm2835 (critical, firmware owns it) and
> > > clocks = <&clocks BCM2711_CLOCK_GISB> on the mdio node. I can send
> > > that
> > > if it helps.
> 
> I've put together 3 patches, which do the clock plumbing:
> https://github.com/nbuchwitz/linux/commits/devel/bcm2711-gisb-clk/

It would be nice to extend this and set the divider based on this to
give 2.5Mhz, as required by 802.3, as the default. Allow boards to
override this using the clock-frequency property.

	Andrew
