Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970A61EFFB7;
	Thu,  6 Aug 2026 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786029032; cv=none; b=nxtfrqifNJAbi6YBSlWzn3i6h7/pJeingVV7gmUVUNRot5Z5P+zIraTjtqTJ5ETtNyPFETSKPNPBayNj7gkGY5FJS91trMsRkdIqeup5eBCOBEJbKOpqB9nXQybKA/IvMnw/hpn0gW2yG1/u2sup2ovtJQ0zbpXs7SdgoWan3bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786029032; c=relaxed/simple;
	bh=B063e6v+aYj73BAHYqQupIaLxCNisgxVYNeVE/oX0cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4Rn2XVBMSOncH44JGlOjXe9irLmdCmTNi6MrhYP54e/R4xr+Kdih85ISQKFTwWV6XKgZpmDMT1CmkCy8Jcto1NeoWyi1MXWGEorDfdzHcc1c0sBRuBLJ+wrLWAxTEKYqpXcRHYZiWXssG3Jz4jWRv33kZk6o0Jb2uEiZzGrsrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 752F020127A;
	Thu, 06 Aug 2026 17:10:23 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wrzjj-0006xx-1F;
	Thu, 06 Aug 2026 17:10:23 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wrzjj-0000000Fu3X-0zU1;
	Thu, 06 Aug 2026 17:10:23 +0200
Date: Thu, 6 Aug 2026 17:10:23 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v1 2/2] net: dsa: realtek: rtl83xx: add support
 for enabling supplies
Message-ID: <anSj34TOZxYiG_ai@pengutronix.de>
References: <20260806140239.3518906-1-o.rempel@pengutronix.de>
 <20260806140239.3518906-3-o.rempel@pengutronix.de>
 <9181f24b-cd5e-46c8-8e57-cbf309ac1a98@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9181f24b-cd5e-46c8-8e57-cbf309ac1a98@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Thu, Aug 06, 2026 at 04:12:44PM +0200, Andrew Lunn wrote:
> > +static const char *const rtl8365mb_supplies[] = {
> > +	"avddh", "avddl", "dvddio", "dvddio1", "dvddl", "pllvddl", NULL,
> > +};
> > +
> 
> > +static int rtl83xx_enable_supplies(struct device *dev,
> > +				   const char *const *supplies)
> > +{
> > +	int i, ret, count = 0;
> > +
> > +	for (i = 0; supplies && supplies[i]; i++) {
> > +		ret = devm_regulator_get_enable_optional(dev, supplies[i]);
> > +		if (ret == -ENODEV)
> > +			continue;
> > +		if (ret)
> > +			return dev_err_probe(dev, ret, "failed to enable %s supply\n",
> > +					     supplies[i]);
> > +		count++;
> > +	}
> > +
> 
> I've never used it, i've no idea if it is applicable, but there does
> appear to be _bulk_ calls in the regulator API, maybe which is similar
> to the clk _bulk_ API?

Ack, in the first iteration of this patch we was using
devm_regulator_bulk_get_enable(). But it would print warnings on
existing boards without regulators in devicetree. Currently there are no
bulk helpers with _optional regulators, so I reworked it to hand made
optional bulk support.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
