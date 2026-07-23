Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB67C345ED5;
	Thu, 23 Jul 2026 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784802011; cv=none; b=IWZuOdzjZ9eL/IjQRWOEezbHvMeqmiITXriVhz+WzF69bUuTCDA9fDCTrDN20GaS8lSl5X5RiahrWhsYP4JZWM8SgOh5L5zVe//m+V6P7iwmjG2tjPJ0OYrwA86TIWLyhn8n0zUr1Fp5GQ72AJszDZJJBSowLu14eiYqkCCnce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784802011; c=relaxed/simple;
	bh=BrmGZCIK+kF3X3ybCEmFW9dXMdQ+k+UD3NmEQRQZD7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYUi1xUtSbi+J6FJQZ6X5lzT3eHBCiVkvZYx0vd1gxfLFY4w9jeRe14b6r6mmoVdQ1FhY63EzLi8npJKaeRpYkIGhFhMSLv8Wf07yfb0obj4s5C31yM4y9P+a3KH9UQO0BSRHqMXSd4KZvq2uajHv6QLfL12cZrdvDeYT+/9r38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 53955201FBB;
	Thu, 23 Jul 2026 12:20:01 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wmqX3-000snM-0l;
	Thu, 23 Jul 2026 12:20:01 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wmqX3-0000000EeJp-0TPB;
	Thu, 23 Jul 2026 12:20:01 +0200
Date: Thu, 23 Jul 2026 12:20:01 +0200
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
Message-ID: <amHq0XuK2y-mcfmD@pengutronix.de>
References: <20260715075530.2491534-1-jelonek.jonas@gmail.com>
 <20260715075530.2491534-2-jelonek.jonas@gmail.com>
 <b3456b41152613ed45bcfde92aff89d0c33fa243.camel@svanheule.net>
 <3f71640b-9f22-4d0b-9c4d-dc64c397d286@gmail.com>
 <amHEgOAWYXYuZwnl@pengutronix.de>
 <beff7c47-ef14-4108-a350-fb07bd56e166@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <beff7c47-ef14-4108-a350-fb07bd56e166@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Thu, Jul 23, 2026 at 11:45:20AM +0200, Jonas Jelonek wrote:
> Hi Oleksij,
> 
> On 23.07.26 09:36, Oleksij Rempel wrote:
> > [...]
> >> Correct me if I'm wrong but from what I see, most of that budgeting machinery
> >> isn't used in dynamic budget evaluation strategy, which is used here because the
> >> MCU does budgeting on it's own.
> > Hm, I guess the wording in header is a bit confusing, I see now the
> > misconception :)
> >
> > dynamic vs static means - haw available budget is calculated, not where.
> > Dynamic can be implemented in the linux core too, but so far no one did.
> > Static can be implement in the MCU firmware as well.
> >
> > In static case - the Powered Device tells us haw much power budget we
> > need to reserve for this device and it will be permanently accounted.
> > Advantage - every device will get what it is requesting.
> > Disadvantage - we do not use full capability of the power supply.
> >
> > In dynamic case - we do not fully trust the Powered Device, first we
> > reserve requested budget and then start measuring the PD consumption.
> > If real consumption is less as requested, the reservation will be
> > reduced.
> > Advantage - more PDs can be attached.
> > Disadvantage - a spike in consumption of one PD, may kick out some low
> > prio PDs.
> >
> > Since the dynamic case need a lot of measurements, it is usually
> > implemented in the firmware. Both strategies have advantages and
> > disadvantages and MCUs may allow to change the strategies, this is why we
> > provide this information.
> >
> > In your case it is not documented, but it can be tested if you have
> > enough PDs where you can influence the load.
> 
> Probably takes a bit of preparation to set up such a test.
> 
> >
> > Not sure if we need an UNKNOWN flag to tell the user - we do not know
> > what to expect, use it on your own risk.
> 
> So dynamic happens to be the suitable case here right now, because the core
> doesn't handle it yet and the MCU does it on it's own without the core
> disturbing that?

Yes, dynamic happens to work with current core implementation for
software point of view. And provide correct or incorrect information to
user space. The PSE behavior expectations for user perspective will be
different depending on this information. 

> I'd like to avoid dealing with that in this series as this seems at least to me
> like another deep rabbit hole. The MCU comes always in kind of a
> pre-configured state, having several limits set so it should behave safe
> and mostly as expected without the driver changing anything.

Ack, reverse engineering has own limitations. I do not expect we will be
able to find all needed information.

> >> Using vpwr-supply on each PI still buys that the
> >> supply is enabled and ref-counted by PSE-PD core, and keeps potential for what
> >> might come. But no requesting, allocation or deallocation of power.
> > Ack, in many cases it is for diagnostic. Please note, a "manger" is in
> > the practice a multi channel current limiter/regulator. It has maximal
> > load per chip and different max load per port. This can be properly
> > reflected with the regulators. 
> >
> > For example, RTL8238B-VB datasheet do not document maximal rating per
> > chip, only per port. Calculating 8 ports, with 36W max, would result in
> > 288W. It feels like a lot of heat. Can it actually handle it?
> 
> I can't tell, but I would guess so. Several switches I have use a single PSE
> chip for 8 ports. Given the advertisment of 30W per port and staying within
> the overall budget, I might expect to be able to use it. Or the vendor hides
> some information.
> 
> > May be the MCU firmware has integrated maximal power limit do avoid HW
> > damage. A proper information in the regulator tree would help user to
> > understand why not all ports will get requested power.
> >
> >> Given that, I had a closer look at PD692x0 and it seems, this has a similar setup.
> >> The difference here being just that there's no multi-manager concept. There is
> >> also a manager-level supply reference "vmain-supply" which the driver reads
> >> and applies to the hardware, which does budgeting also in hardware.
> > According to RTL8238B documentation, it has same multi-manager concept.
> > Since one manager RTL8238B supports max 8 ports, a switch with more PoE
> > capable ports would need more chips.
> 
> I see. I mixed up the terms and thought this "manager" is separate level in
> between. If "manager" == RTL823x PSE chip, then it's the same setup.
> 
> What do you suggest? I would like to avoid doing any half-grounded claims
> or assumptions here while not fully overviewing the whole picture. At the same
> time, I have the feeling the datasheet and host command guide from Realtek
> are genuinely trying to fool me.
> 
> The setup seems to be very similar to PD692x0, we have multiple managers,
> managed by a controller (the MCU). The MCU mostly does runtime discovery
> of the downstream managers, so right now there is no apparent need to
> have the same manager + port definitions in DT as PD692x0.
> 
> In reality I haven't seen a board which has different power rails for different
> managers. So there's usually a single wire from the PSU going to the PoE
> daughterboard where everything lands on a single supply PCB trace. The MCU
> has a multi-bank concept, however it's usage right now is rather confusing.
> Managers seem to have strapping pins which tell which bank they use, and on
> the MCU side one can set power limit for each bank.

Current PSE framework already has a concept of power domain. Depending
on implementation, the "manger" can be the weakest point in the chain.
For example: one manager has 8 ports and can handle 200W, we have
devices with 2 managers each 200W max and PSU providing 500W. If we
attach 3 devices 100W each to ports 1, 2, 3 - will not work for the last
one. If we attache them to ports 1, 2 + 9, will work just fine. Because
it is attached to different power domain/manger.

Even if this information is hidden in the MCU. It is usable for admins,
to understand what combination of ports should be used for optimal power
delivery.

> > Since we already talk about power budgeting - all of this make sense if
> > we have port priorities. For example PD692x0 firmware has default prios
> > bound to port numbers. Is it the same with this firmware?
> 
> Looking at several switches, by default all ports have a priority of 0 assigned.
> Thus, no pre-defined prioritisation, it's up to the user to set this.

Do this switches have PSU covering all port at max load or it is over
provisioning by design. Haw it behave in reality If we attach more
consumer then it is able to handle - all ports go off, or only some of
them?

PD692x0 firmware has user configurable prios - but if many ports share
same prios it has internal prios based on port number.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
