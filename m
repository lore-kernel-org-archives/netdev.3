Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA3F2F5A36;
	Fri,  7 Aug 2026 07:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786086622; cv=none; b=ANfthgdKpyJZNDqDieiroKVM9qXhfmDycoIGIO4G9ghKKRSGX/X4UJLBHxAK0cqrdrGLLKKCB0h/kxkCwAlZdsVuGg7aGcq8cxaHDCPNMROEPj6Ch7qKYw3rvgcaz6pJRVwkn1ba1omya3ERxRJ5mFZUcuaCzY+HV+orLtZlvkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786086622; c=relaxed/simple;
	bh=dpRKrf5/c/UrAyd7GX9AFayLjbeS+srrO3fK9U4KlYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQDd5hg15hNl7u2n2BZYc6+xx6Okv/CwWJHGTARQhaODqz+ogi+6m4J4/r8T6DIEGJZ6eMHHxM36YYbT90yavMkMTk0oP0IjSAYSqwOIEjmpMwl7AuABP12JtzWlNSzyZGJpFPRQ2nhIiFx7x3r9Ay5xsULz5AB50wANQEt/dBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C270D2018B6;
	Fri, 07 Aug 2026 09:10:16 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wsEie-000Dao-2D;
	Fri, 07 Aug 2026 09:10:16 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wsEie-00000000p4J-2IOg;
	Fri, 07 Aug 2026 09:10:16 +0200
Date: Fri, 7 Aug 2026 09:10:16 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Linus Walleij <linusw@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Rob Herring <robh@kernel.org>, netdev@vger.kernel.org,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Eric Dumazet <edumazet@google.com>, kernel@pengutronix.de,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v1 2/2] net: dsa: realtek: rtl83xx: add support
 for enabling supplies
Message-ID: <anWE2HD_Mrv9XlYV@pengutronix.de>
References: <20260806140239.3518906-1-o.rempel@pengutronix.de>
 <20260806140239.3518906-3-o.rempel@pengutronix.de>
 <9181f24b-cd5e-46c8-8e57-cbf309ac1a98@lunn.ch>
 <anSj34TOZxYiG_ai@pengutronix.de>
 <f2260b02-621f-4b92-aade-85c403a8839d@lunn.ch>
 <02a51eff-3782-4012-8475-1047a9be4dd3@pengutronix.de>
 <CAD++jLk-5-_2x2scn2hNQ-aWBx=EKGYzvcaUwv5fS7k5Bq=KGA@mail.gmail.com>
 <anVedv6aV1hguF5x@pengutronix.de>
 <CAD++jLkkwuRYrW7aF4BrxoH=qVfNfbzsW8A+URig79dVMxgZ-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLkkwuRYrW7aF4BrxoH=qVfNfbzsW8A+URig79dVMxgZ-g@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Fri, Aug 07, 2026 at 08:51:53AM +0200, Linus Walleij wrote:
> On Fri, Aug 7, 2026 at 6:26 AM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > On Thu, Aug 06, 2026 at 07:40:29PM +0200, Linus Walleij wrote:
> > > On Thu, Aug 6, 2026 at 5:56 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> > >
> > > [Andrew says]
> > > > > static inline int __must_check clk_bulk_get_optional(struct device *dev,
> > > > > static inline int __must_check devm_clk_bulk_get_optional(struct device *dev,
> > > > > static inline int __must_check devm_clk_bulk_get_optional_enable(struct device *dev,
> > > > >
> > > > > If clk has them, maybe regulators should as well?
> > > >
> > > > clk and regulator have different interpretations of _optional
> > > > when encountering a non-existent resource:
> > > >
> > > > clk_get                 return error
> > > > clk_get_optional        return NULL
> > > > regulator_get           return handle dummy regulator
> > > > regulator_get_optional  return error code
> > > >
> > > > So devm_regulator_bulk_get() is already the "optional" variant, but it causes
> > > > all existing users to get dummy supply warnings.
> > >
> > > So is this a big problem? Does it cause any other issues than
> > > dmesg noise?
> >
> > As tested with local sashiko setup, new warnings for existing system
> > without good reason will be reported as regression, so it will be
> > blocker for net-next inclusion.
> 
> Strong reverse centaur (*) warning on this one.
> 
> I'm not sure this is how Mark want such "regressions" to be treated.
> 
> I think a few dummy supplies is just fine and it's rather that Sashiko
> need to be taught not to treat that as bugs/regressions.
> 
> Yours,
> Linus Walleij
> 
> (*) Reverse centaur = humans touted to please AI, as opposed
> to AI helping humans, sarcastic term coined by author Cory Doctorow.

Without context, I would fully agree with this statement. But as some
one who need to adders new warnings on every kernel update for our
customers, I see the point of sashiko - new unnecessary warning
is extra unnecessary work for some one else == regression.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
