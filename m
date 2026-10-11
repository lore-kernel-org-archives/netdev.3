Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D33E305660;
	Sun, 11 Oct 2026 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791753066; cv=none; b=VcRkfdt95o8l0z4vRdb4sojK3pec8+QORUuj2yQ+ciW36OE+qDWb074QaWAubp0cpM3fi0DaskS7cD3+bZWSJcolUltwtbbPj7I4Pq4HUykSPPePsdw27jdgMQwL7qvH81zHuD9IvZBjgGUcoUFDZj3pOPib89FqgIBEaxKIQvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791753066; c=relaxed/simple;
	bh=4yyfpQb1Lb/ngzoEFFI2DA+n4z26ZUH9URDMiUauJco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mu7kl/8WegfUcwWjFpdM7Dk71sgfMy60HXylRXsa19+VGfW6+oQdj5RBrsEe8e8W3Ir03ci7E9jaVbEjqY9RG/OT1DoIR7Y0iS0S+qbr/tYt8fIxL71iW6OW5dd89ydooFSunMv0uwpzz+uS0T1wTlRe3GO8tm51PlzNtwHtYQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3GReNuwo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3GReNuwo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=oLPXrTETwXIgCqbMdypfomsb/ybLwCg++xPL7zgFDGM=; b=3G
	ReNuwoJDRjI4rZICKl4/qMwBbhbuUuLrm43jQolz01wttc+Nl6mlFoXuqa7A9ZKtVTkBhpxi4PoYj
	J1ZzywYp7hz+KrMoDeCuUMjj07TzKxrtfInAlgWCFWu8DlfoG+pS8PSZEq33WXQskRvSCslQmhGKJ
	AsHIqcXF2wNamjg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xG0og-00AASP-MW; Sun, 11 Oct 2026 23:10:46 +0200
Date: Sun, 11 Oct 2026 23:10:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: James Clark <jjc@jclark.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>, Nicolai Buchwitz <nb@tipi-net.de>,
	Russell King <linux@armlinux.org.uk>,
	Conor Dooley <conor.dooley@microchip.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Miroslav Lichvar <mlichvar@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 4/5] net: macb: implement timestamped MDIO writes
Message-ID: <c136b0ad-6d7e-4695-b988-55eb37550d01@lunn.ch>
References: <20261009143506.2507607-1-jjc@jclark.com>
 <20261009143506.2507607-5-jjc@jclark.com>
 <DM1WEUIF8V8V.2OZWRB5G232T4@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM1WEUIF8V8V.2OZWRB5G232T4@bootlin.com>

On Sun, Oct 11, 2026 at 11:23:54AM +0200, Théo Lebrun wrote:
> Hello James,
> 
> On Fri Oct 9, 2026 at 4:35 PM CEST, James Clark wrote:
> > Implement write_sts to provide system timestamp bounds for completion
> > of an MDIO write. This enables tighter system timestamp bounds in PHY
> > implementations of gettimex64.
> >
> > Take system timestamps around the command register write, then add
> > the time from the command write until the MDC edge that clocks the
> > last data bit, calculated from the peripheral clock rate and the
> > configured MDC divider.
> >
> > On RP1 that edge comes 63.5 MDC periods after the command write. This
> > was measured on a Raspberry Pi CM5 with its BCM54210PE PHY. The PHY's
> > PHC was read with PTP_SYS_OFFSET_EXTENDED while the MDC divisor was
> > switched between 48 and 128 through /dev/mem. Any error in the number
> > of periods would make the PHC offset jump at each switch. After
> > compensating for drift, the jump with 63.5 periods was under 2 ns.
> > The MDC divider does not appear to run freely: the spread of the PHC
> > offsets did not change with the divisor.
> >
> > Signed-off-by: James Clark <jjc@jclark.com>
> > Assisted-by: LLM
> > ---
> > The 63.5-period delay has been measured only on RP1, but the code
> > assumes it holds for all MACB and GEM variants. I am not sure whether
> > that is a reasonable assumption; if not, write_sts could be enabled
> > only for RP1.
> 
> I'm invoking my colleague @Maxime to get his opinion. What impacts the
> MDIO write_c22 duration and how likely is it that this duration varies
> (1) on the same MAC+PHY combo, (2) with a different PHY or (3) with a
> different MACB revision?

Putting the bits onto the bus should be a fixed time. It is just a big
shift register, which is clocked at bus speed. There is no clock
stretching, no ACK from the PHY, etc.

What will introduce jitter is everything before the write hits the
register. There are mutex which can be contended, because of other
users on the bus, etc.

> Sashiko makes an interesting point with PCLK that might change over
> time, giving an example (which I've not checked) where it would be
> derived from the CPU clk which might change with cpufreq.

Care would have to be taken here. IEEE 802.3 specifies the maximum bus
speed is 2.5Mhz. I hope cpufreq can only make the clock slower, not
faster, otherwise the MDIO bus is breaking the standard.

> I'm wondering if we could do better than a hardcoded delay? For example
> we could busy-wait for NSR.IDLE inside the prets/postts region, but
> that implies at least 25µs with IRQs disabled. Or we could do a few
> measurements at init to sample our platform delay?

> It doesn't solve the PCLK changing issue, but it solves the hardcoded
> 63.5 value.

Each C22 MDIO bus transaction is 64 bits. It is defined in the
standard. So hard coding this value is fine. But it should be made
generic, it should be the same for all implementations, all that
changes is the bus speed.

	Andrew
