Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE5943CEF8;
	Wed, 14 Oct 2026 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791979528; cv=none; b=Hy40HUUcj6J+PfFLFbd9jZTnJMPPkjrO1Yd7LYRMyzIVc3eQ/BTnOdwMBUDunIO7pO7bX+cIVkhbQvDc7eeebx7pgXLKWnu8pitHhyHnnHRR/Kso6MG6aLO4T9AyJQ+WeiBFD7Blap9KFrXZKGj7ctbnBTii8W+BeXMFzP8EeuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791979528; c=relaxed/simple;
	bh=NZlN31h/+P5/LOsgK0O0KLDjy+TdbxOi/nBuQ6rHObI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6dc7tilCMXYpU3mWkxptoANKzom87wQ2xuashgkwMz3KEeRAmhQNm8GDu+sG/u2ch1TUil4URf6i4RfPsfivICjfzd03M5N/k6SSwGZyuzrTZXrtNwojccpXOCohsAoAbCx2vBPBlZABT05MyqZk5ImpSltGMGVTtl1KG+se9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2krYKwq8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2krYKwq8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cN0vCH3Rd8wcPVWll8aOa9Voucmcj5s4Ox2vF2HQU10=; b=2krYKwq8VxSSV4Olo35uAMh/4Z
	OPmi/jjNPIonn3HmpKqdgIAINxlRuumNcblTMvCruAFps6W213teiiEBoFNG8x75jkFyCetNuA5HP
	Yc94z2nkLpOn+SXxjdZEooF6hxoGqD/kbE+fTpxVNrgWNRJA0JaVl4DHBevSKsU7STXg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xGxjR-00AiyX-19; Wed, 14 Oct 2026 14:05:17 +0200
Date: Wed, 14 Oct 2026 14:05:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: realtek: restore RTL8211F RGMII delays on
 resume
Message-ID: <f9deecf0-0bb6-4fc9-a8e1-f15c57896195@lunn.ch>
References: <20261014033659.95196-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014033659.95196-1-kmehltretter@gmail.com>

On Wed, Oct 14, 2026 at 05:36:59AM +0200, Karl Mehltretter wrote:
> The RTL8211F-VD loses the RGMII TX and RX delay enable bits across a
> software power-down. rtl8211f_config_init() programs these bits from the
> PHY interface mode, but rtl821x_resume() only clears BMCR_PDOWN and waits
> for the receive clock to stabilize.
> 
> On a BeagleV Ahead configured for rgmii-id, carrier and the negotiated
> speed return after an interface close/open, but the receive path does not
> work. At 100 Mbit/s no frames were received. At 1000 Mbit/s all 11
> observed frames had CRC errors.
> 
> Program the delays again after the existing resume delay. rtl821x_resume()
> handles RTL8211F and RTL8211F-VD, both of which use
> rtl8211f_config_rgmii_delay() during initialization.

This bit is important, so i would of put it earlier. In practice, it
should not matter that the RTL8211F gains the extra RGMII register
rights.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
