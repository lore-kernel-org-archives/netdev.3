Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411B43E0255;
	Thu, 23 Jul 2026 07:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784792205; cv=none; b=joQ1gyiq8AIu+p1lNSuDS1oPPq8BATDd0/T1toqQ5E9MBQ2qGrXv5biKobSIULaCyxW6EGfO8i/jcwWLHVgtjo9l2L4cNttK+vmPEhiN2mLJMV1X8DDmqDXPKWmpilRrP7eXOEjnvqs/TV5LfH1XMJ+ImG02dfFpuTh1vZNjAds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784792205; c=relaxed/simple;
	bh=peN5snx9+EybKzxAPqEgXnx7bGQZuE05wWcM/8O3528=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrWruDodku49GqVFrBLGHbCaRxUSif5to7Wo+dU2TGmt0fB/CecsYuJ3nnM87fcmcNRhaXPYzfAvcW/60D6zq/lLYE/wTLV8llcAav1V7ywpikVSoQRT0sQSR3bBLvGJqr6n4URX01LI1n6Gk2um6WuG4PZR4QFtlNGSjPNQD/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B317C202459;
	Thu, 23 Jul 2026 09:36:32 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wmnyq-000ra7-25;
	Thu, 23 Jul 2026 09:36:32 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wmnyq-0000000EcbG-2AOx;
	Thu, 23 Jul 2026 09:36:32 +0200
Date: Thu, 23 Jul 2026 09:36:32 +0200
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
Message-ID: <amHEgOAWYXYuZwnl@pengutronix.de>
References: <20260715075530.2491534-1-jelonek.jonas@gmail.com>
 <20260715075530.2491534-2-jelonek.jonas@gmail.com>
 <b3456b41152613ed45bcfde92aff89d0c33fa243.camel@svanheule.net>
 <3f71640b-9f22-4d0b-9c4d-dc64c397d286@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f71640b-9f22-4d0b-9c4d-dc64c397d286@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

Hi Jonas,

On Wed, Jul 22, 2026 at 09:49:24PM +0200, Jonas Jelonek wrote:
> Hi,
> 
> On 22.07.26 19:49, Sander Vanheule wrote:
> > [...]
> >
> >> +  power-supply:
> >> +    description: Regulator supplying the PoE power rail.
> > As I reported to Jonas earlier [1], I used this property to define a power
> > supply for the 54V rail. While everything was working nicely, I still got this
> > warning for the missing vpwr-supply property on the PSE-PI nodes:
> >
> > regulator regulator.2: supply vpwr not found, using dummy regulator
> > Of course I don't like seeing warnings when everything is seemingly working
> > fine, but I was also wondering if this duplicated way of providing the PoE power
> > rail is a good way to go forward and if the generic pse-pi@n/vpwr-supply
> > shouldn't just be used instead. The latter is admittedly more verbose, with a
> > property on every node, but going forward offers a few advantages IMHO:
> >  * Being able to reserve "power-supply" on the main node for the MCU's actual
> >    3.3V regulator (not needed anywhere at the moment AFAIK)
> 
> I would probably rename this, mirroring the PD692x0 naming. "power" is actually
> too blurry, leaving too much room for interpretation. Still keeping its purpose
> to reference the supply that serves the PoE rail for this MCU with its downstream
> PSE. Reasoning below.
> 
> >  * Being able to take advantage of the generic pse-pi framework evolving to take
> >    into account more properties of the parent regulator, such as requesting more
> >    power, or ensuring the parent supply is not overdrawn by the combined PSE-PI
> >    outputs.
> 
> Correct me if I'm wrong but from what I see, most of that budgeting machinery
> isn't used in dynamic budget evaluation strategy, which is used here because the
> MCU does budgeting on it's own.

Hm, I guess the wording in header is a bit confusing, I see now the
misconception :)

dynamic vs static means - haw available budget is calculated, not where.
Dynamic can be implemented in the linux core too, but so far no one did.
Static can be implement in the MCU firmware as well.

In static case - the Powered Device tells us haw much power budget we
need to reserve for this device and it will be permanently accounted.
Advantage - every device will get what it is requesting.
Disadvantage - we do not use full capability of the power supply.

In dynamic case - we do not fully trust the Powered Device, first we
reserve requested budget and then start measuring the PD consumption.
If real consumption is less as requested, the reservation will be
reduced.
Advantage - more PDs can be attached.
Disadvantage - a spike in consumption of one PD, may kick out some low
prio PDs.

Since the dynamic case need a lot of measurements, it is usually
implemented in the firmware. Both strategies have advantages and
disadvantages and MCUs may allow to change the strategies, this is why we
provide this information.

In your case it is not documented, but it can be tested if you have
enough PDs where you can influence the load.

Not sure if we need an UNKNOWN flag to tell the user - we do not know
what to expect, use it on your own risk.

> Using vpwr-supply on each PI still buys that the
> supply is enabled and ref-counted by PSE-PD core, and keeps potential for what
> might come. But no requesting, allocation or deallocation of power.

Ack, in many cases it is for diagnostic. Please note, a "manger" is in
the practice a multi channel current limiter/regulator. It has maximal
load per chip and different max load per port. This can be properly
reflected with the regulators. 

For example, RTL8238B-VB datasheet do not document maximal rating per
chip, only per port. Calculating 8 ports, with 36W max, would result in
288W. It feels like a lot of heat. Can it actually handle it?
May be the MCU firmware has integrated maximal power limit do avoid HW
damage. A proper information in the regulator tree would help user to
understand why not all ports will get requested power.

> Given that, I had a closer look at PD692x0 and it seems, this has a similar setup.
> The difference here being just that there's no multi-manager concept. There is
> also a manager-level supply reference "vmain-supply" which the driver reads
> and applies to the hardware, which does budgeting also in hardware.

According to RTL8238B documentation, it has same multi-manager concept.
Since one manager RTL8238B supports max 8 ports, a switch with more PoE
capable ports would need more chips.

Since we already talk about power budgeting - all of this make sense if
we have port priorities. For example PD692x0 firmware has default prios
bound to port numbers. Is it the same with this firmware?

pw-bot: changes-requested
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
