Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8359C2ED16D;
	Thu,  6 Aug 2026 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030517; cv=none; b=KHokbPNDCb6d1AY5GcLX7KLzQIcBhx+fY8H6P59fpvysbN3TCWohPxf8l0hnKNaVjnlgYztS+vqz8QA8qWvEnCbaBE1r5BrPAg1CoVSqDqI0w/30gCm01laju2PaM0pvxjHnzBWakhrUNQXuNXFljtPrn74UBpNBzCGOcvtrLUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030517; c=relaxed/simple;
	bh=f3zoXMAS9RW/51VlO+vmE3g3gPvyQ282BzGpTGSOBFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ya/fuY6JFNDJRMT8gkUQ1ozG9Z3ZxGJKIKjfEVOeaZrs3knCbG6Ju8jlAM10zzMZC24JTtgRbcZYGWuzJ4TJAx7XCcvu27ZN9Yq+rUoGK3qUO2SG6NHpKi1YQV2+zSZR6eOh/fNbC36rVk4FzpjKPmAm2j+SNxVNRpkClgcFG48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vdans2AT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vdans2AT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Um4uJwo+61l9GQN7tUL4p/zVg0Gt+NRXDv5tuKIKmEQ=; b=vdans2ATBx1kHlHX57PnR7H1qP
	l8PCQORhQNtfePVFE5UZim+QOhx2Yf/4keMRCfwOirKo8X66sDIuvK0fhrTU3xKYm5BswFwkF6O0v
	mAOHtYcpKlOPfNJ/xUeSEFtZRQdh/EHpay1t23tUX1Q+DjSWZ54ty7/3Uz33WqBhzP+A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ws07Y-00GOuS-5E; Thu, 06 Aug 2026 17:35:00 +0200
Date: Thu, 6 Aug 2026 17:35:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
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
Message-ID: <f2260b02-621f-4b92-aade-85c403a8839d@lunn.ch>
References: <20260806140239.3518906-1-o.rempel@pengutronix.de>
 <20260806140239.3518906-3-o.rempel@pengutronix.de>
 <9181f24b-cd5e-46c8-8e57-cbf309ac1a98@lunn.ch>
 <anSj34TOZxYiG_ai@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anSj34TOZxYiG_ai@pengutronix.de>

On Thu, Aug 06, 2026 at 05:10:23PM +0200, Oleksij Rempel wrote:
> On Thu, Aug 06, 2026 at 04:12:44PM +0200, Andrew Lunn wrote:
> > > +static const char *const rtl8365mb_supplies[] = {
> > > +	"avddh", "avddl", "dvddio", "dvddio1", "dvddl", "pllvddl", NULL,
> > > +};
> > > +
> > 
> > > +static int rtl83xx_enable_supplies(struct device *dev,
> > > +				   const char *const *supplies)
> > > +{
> > > +	int i, ret, count = 0;
> > > +
> > > +	for (i = 0; supplies && supplies[i]; i++) {
> > > +		ret = devm_regulator_get_enable_optional(dev, supplies[i]);
> > > +		if (ret == -ENODEV)
> > > +			continue;
> > > +		if (ret)
> > > +			return dev_err_probe(dev, ret, "failed to enable %s supply\n",
> > > +					     supplies[i]);
> > > +		count++;
> > > +	}
> > > +
> > 
> > I've never used it, i've no idea if it is applicable, but there does
> > appear to be _bulk_ calls in the regulator API, maybe which is similar
> > to the clk _bulk_ API?
> 
> Ack, in the first iteration of this patch we was using
> devm_regulator_bulk_get_enable(). But it would print warnings on
> existing boards without regulators in devicetree. Currently there are no
> bulk helpers with _optional regulators, so I reworked it to hand made
> optional bulk support.

static inline int __must_check clk_bulk_get_optional(struct device *dev,
static inline int __must_check devm_clk_bulk_get_optional(struct device *dev,
static inline int __must_check devm_clk_bulk_get_optional_enable(struct device *dev,

If clk has them, maybe regulators should as well?

   Andrew
