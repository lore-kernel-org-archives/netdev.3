Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F3F3A7D6F;
	Fri, 24 Jul 2026 07:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784879067; cv=none; b=GVzpthZd+FdFh6qUUIy1GgfSRP1cERfn3jVSIakzCjNPwTV7SQ733p056Jr7HOptrexvCiEynf55JuvhgbZlw6pGXtXLGggQ/quzXqgP1nqWeiyDR0SU/6z5lHeRzafL1btxmjvhTOOKJ5XMX3L95MaA6TnAapiWx5hCwEimj+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784879067; c=relaxed/simple;
	bh=LDvMaaSmzaSgGhbmd1K4s8X4A9d5quPXu1ojSw/HVgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZ7zBloLzT6S3xkEU2+3DhENGwPe9WjAWUjoJxojnCDcJlGbzljqvXAecMtaAilALHgKBi5v1PJEiQxVlG8j9QDiUEoG8mgHTAciHyaOkz9DyV+GaouTxfEsaskfkPDXib2S/S9kp2Jf4+LYLc0ayeIOaCaaMQU/ctFawCs3s10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C18662004F0;
	Fri, 24 Jul 2026 09:44:15 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wnAZr-0011ly-2F;
	Fri, 24 Jul 2026 09:44:15 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wnAZr-0000000H9x9-2PLD;
	Fri, 24 Jul 2026 09:44:15 +0200
Date: Fri, 24 Jul 2026 09:44:15 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Sander Vanheule <sander@svanheule.net>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Golle <daniel@makrotopia.org>,
	=?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH net-next v8 1/4] dt-bindings: net: pse-pd: add bindings
 for Realtek PSE MCU
Message-ID: <amMXz_KbLyiwB0wz@pengutronix.de>
References: <20260715075530.2491534-1-jelonek.jonas@gmail.com>
 <20260715075530.2491534-2-jelonek.jonas@gmail.com>
 <b3456b41152613ed45bcfde92aff89d0c33fa243.camel@svanheule.net>
 <3f71640b-9f22-4d0b-9c4d-dc64c397d286@gmail.com>
 <amHEgOAWYXYuZwnl@pengutronix.de>
 <beff7c47-ef14-4108-a350-fb07bd56e166@gmail.com>
 <amHq0XuK2y-mcfmD@pengutronix.de>
 <e7f50ff9-b5e3-4247-bef3-c0cc3581a50b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7f50ff9-b5e3-4247-bef3-c0cc3581a50b@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Fri, Jul 24, 2026 at 09:18:45AM +0200, Jonas Jelonek wrote:
> Hi Oleksij,
> 
> On 23.07.26 12:20, Oleksij Rempel wrote:
> > On Thu, Jul 23, 2026 at 11:45:20AM +0200, Jonas Jelonek wrote:
> >>> Since we already talk about power budgeting - all of this make sense if
> >>> we have port priorities. For example PD692x0 firmware has default prios
> >>> bound to port numbers. Is it the same with this firmware?
> >> Looking at several switches, by default all ports have a priority of 0 assigned.
> >> Thus, no pre-defined prioritisation, it's up to the user to set this.
> > Do this switches have PSU covering all port at max load or it is over
> > provisioning by design. 
> 
> In most cases it's overprovisioned by design, the PSU budget is usually lower
> than what would be needed for all ports at max load. Even one of my switches,
> having a PoE budget of 400W, has 8 ports with 32W and 16 ports with 60 W,
> managed by 5 managers. Usually a manager is not overprovisioned but the
> system PSU is.
> 
> > Haw it behave in reality If we attach more
> > consumer then it is able to handle - all ports go off, or only some of
> > them?
> 
> That's a good question ^^. Unfortunately, I do not have enough PoE-powered
> devices here to test this scenario, or at least it takes a bit of time to get
> enough devices.
> 
> >
> > PD692x0 firmware has user configurable prios - but if many ports share
> > same prios it has internal prios based on port number.
> >
> 
> At least I'm not aware of that but since the firmware on the MCU is a
> blackbox, in the end this could be the case too. But it's not an obvious
> feature.

It would be nice to have both of this answers, but they are not blocker
for this patch set.

> I'd like to slightly adjust the bindings, given the confusion about the naming
> that came up with Sander.

Ack.

> Is there anything else that should be changed? Or is everything else in
> terms of supply, budgeting, etc. fine for follow-ups?

Ack, can be done in follow-ups.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
