Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889773D16E9;
	Tue, 18 Aug 2026 12:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787055755; cv=none; b=twmCtO1aR9VQ/Pxuo2Zktug+uLshUcn/cmfRggMh/FrCAvyoY+VMiQGkn8lMQ/jGKKuTBQskhQYwfL5w3bBlnoKBx5u71TIxOFZIb08RwJcYqno9XqG7FakGdki8ns48I1i9pqcxXRV0mKnfnewI2ahZATz+kMY040Yo8tVBzCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787055755; c=relaxed/simple;
	bh=AuFFOFHJ79Rx5+AWG8Q/Sfr35FiGJ96aFEFKZKLqIwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NESvNTDzV16mEjEYwwBRiWC6+wpkR+q+S1V5oamuIkAOW1euD1ooS7OcBInGOGaDeDbzMfwUO450hW9ZZXORJ7R4H1v3k42/EtNCyYTP6qmI/wY4uajmnV2tgjRCwkpjHm5wt8f4VhQW3TjqD0i2vOjlxhaudu74hX0aruZ7y2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 421AF201021;
	Tue, 18 Aug 2026 14:22:30 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wwIpq-0027qR-0G;
	Tue, 18 Aug 2026 14:22:30 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wwIpp-0000000CV2l-3zus;
	Tue, 18 Aug 2026 14:22:29 +0200
Date: Tue, 18 Aug 2026 14:22:29 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 2/2] net: dsa: realtek: rtl8365mb: add EEE
 support
Message-ID: <aoROhXF2XJabMMM8@pengutronix.de>
References: <20260817134758.4182833-1-o.rempel@pengutronix.de>
 <20260817134758.4182833-3-o.rempel@pengutronix.de>
 <8be5a31d-55af-47ba-bd7b-4e581c3950bd@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8be5a31d-55af-47ba-bd7b-4e581c3950bd@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Mon, Aug 17, 2026 at 04:53:52PM +0200, Andrew Lunn wrote:
> > +static int rtl8365mb_phylink_mac_enable_tx_lpi(struct phylink_config *config,
> > +					       u32 timer, bool tx_clock_stop)
> > +{
> > +	/* The hardware manages LPI itself; there is no MAC-level LPI control.
> > +	 * This callback only signals LPI awareness to phylink.
> > +	 */
> > +	return 0;
> > +}
> > +
> > +static void rtl8365mb_phylink_mac_disable_tx_lpi(struct phylink_config *config)
> > +{
> > +}
> > +
> 
> So what happens when i do:
> 
> ethtool --set-eee eth42 off
> 
> or
> 
> ethtool --set-eee eth42 tx-lpi on

In current implementation, with "tx-lpi off", the driver will return
-EINVAL, "tx-lpi on" will be passed. It is aligned with KSZ driver.
rtl8365mb_set_mac_eee() is used as filter.

> I don't now what phylib does with advertise in these cases, but maybe
> you need to go behind phylink/phylib back and set advertise to 0, so
> that the MAC does the right thing?

If I see it correctly, We wont be able to emulate "eee on tx-lpi off"
case on this HW. On proper HW, this configuration will be link speed
dependent:

- 100 Mbit/s - TX line will be active, RX can be idle if link partner is
  in LPI.

- 1000 Mbit/s - this configuration will make EEE/LPI non functional, almost
  equal to "eee off" (EEE is advertised but not activated)

I decided not to emulate "tx-lpi off" by disabling EEE advertisement.

> Or you need to return -EOPNOTSUPP for these?

Currently it is -EINVAL as in KSZ driver. If we will go with -EOPNOTSUPP
then probably both drivers should follow it.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
