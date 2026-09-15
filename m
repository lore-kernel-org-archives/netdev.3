Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114B947CC64;
	Tue, 15 Sep 2026 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467827; cv=none; b=jeWC7bGEiQanidIKd4Tkyuj2ZaihCZRA+jXu4+OyFmc/EyDFl6ufbvKLsJlizh2QBGl8L+IW/g55LwItAJMMKEmoo5uRMw9AGjMZkrqRlMUwcSKuNtMlc1++pNAONls8yYGGmBTxHcGmqmJIhW+7bGMnBXUp2e/PgsBRw+6tovU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467827; c=relaxed/simple;
	bh=3pLi3V1qd1YAxSnUO0lLmMEMsdFDpIWHiyAyNy85cDQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=InktyDj15O8AmQu/e2hSMsn2fVeEWWICQgi9R9ugtbvVEiUTwZgiUg8IgfYmGPc13qbag8GXxllVjZ++/CdW4YU0SKr6CTJezN3f+0rkqxTD7dfWqYS0I29Kr+NGWARTEdNcGSe4pRT6UlZL/4ZlKqKn4K/KMlsHlKK05DQd/fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3hJaPInM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m9x1Jvbp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3hJaPInM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m9x1Jvbp"
Message-ID: <3c16a2c3a05761b06d51cd0375ba9f87eef277ea.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789467823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3pLi3V1qd1YAxSnUO0lLmMEMsdFDpIWHiyAyNy85cDQ=;
	b=3hJaPInMnJRj6e7OlPAOBdmBOrINAnM4rVPGdAaUdJ8uZJXsa0jz5jtzWdkd43lwt0OL6u
	cHtKROAxUpkobXX7G2OSbBP3cdZ17OqquV8W8jkjc9caQzgxcmG2XgaTd/R8i3JqxRWdFL
	jQPUr4KLlfvPw0chJktvGybukw0r24f80SgPnczhzR6ebJ8Y4pJHJ1xX/5NQWaNQ448d1P
	VNe1VDSxSIvzBlQkSDOnEwJso0t5a1O33R0KqGBkcfHlx1/C3H+6unzR9UDJG11+tDmA+P
	X0PpDuSLdWDUiU0DiahWg2x+xmWnoXrDVmxpkwE92Ode6AFIYCJomTmmWrSygA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789467823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3pLi3V1qd1YAxSnUO0lLmMEMsdFDpIWHiyAyNy85cDQ=;
	b=m9x1JvbpriS+z1IKekZ02Pz1MmoHzaWQInMe2kNXY8SlGxbR2q3+05P6Xvb0+/rJw5Hx4w
	o1pJ5OEDh+h2swBQ==
Subject: Re: [PATCH net-next v2 2/4] dt-bindings: net: dsa: Add SoC-e SWIP
 switch
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,  Martin Kaistra
 <martin.kaistra@linutronix.de>, Benedikt Spranger <b.spranger@linutronix.de>
Date: Tue, 15 Sep 2026 12:23:42 +0200
In-Reply-To: <ee045b16-978e-4208-b447-bb422a45dbf5@lunn.ch>
References: 
	<20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
	 <20260903-devel-vstrassheim-soce-dsa-ml-v2-2-fb0587cb466b@linutronix.de>
	 <28f8ec21-162a-4c2c-8e01-6586f39f06f8@lunn.ch>
	 <041e2884bc1aa1725a86efd413e2e3301b54d91d.camel@linutronix.de>
	 <df6dc527-8b4a-4775-828a-2633369277cd@lunn.ch>
	 <20612d5a45783ed49927fb1075c7ea1f3293f514.camel@linutronix.de>
	 <ee045b16-978e-4208-b447-bb422a45dbf5@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-09-10 at 14:12 +0200, Andrew Lunn wrote:
> > > Since this is an FPGA, i assume there are no internal PHYs. Mixed mod=
e
> > > is not something FPGAs do. There are sometime "interesting"
> > > relationships between port number and address on the MDIO bus. But
> > > without internal PHYs you don't need to worry about this.
> > >=20
> >=20
> > Correct, the FPGA IP has no internal PHYs. Each port is associated with
> > a dedicated external MDIO bus.
>=20
> How is a port and the MDIO bus associated?

I had to clarify a few details.
In the particular bitstream and board design I am using, MDIO is enabled
for every external switch port. Each external port therefore has its own
MDIO interface. This is what I meant by "associated". However, it's a
property of this FPGA configuration, not a general Linux requirement or
an inherent mapping for every instance of the IP core.

>=20
> Linux, in general, does not care. You have a collection of MDIO
> busses, and on those busses you have a collection of PHYs. The MACs
> use a phandle, or some other means to point to the PHY it should use.
>=20
> Given this is a 31 port switch, why would you dedicate 62 pins to
> MDIO, two per port, when you can put 32 PHYs on one MDIO bus?
>=20
> So i doubt there is a strong association between port and MDIO bus.
>=20
> What i could image is the one real MDIO bus controller is in global
> scope within the RTL design. And then the logic to provide a port with
> its multiplexor on that shared bus is in the per port RTL design
> scope. I've not done much FPGA design, but i assume if you don't
> connect the per port MDIO lines to anything, while place and route is
> performed, they get optimised out?


Yes, MDIO can be enabled per port when generating the bitstream. If it
is disabled for a port, the corresponding physical interface is not
generated, so your assumption about unused interfaces being omitted is
correct.
Linux will still model the topology in the usual way: the generated
interfaces are exposed as MDIO buses, and each switch port refers to its
PHY through a phy-handle. The bus selector identifies a generated MDIO
interface and should not generally be interpreted as a switch port
number.

>=20
> > > So in theory, a 0 port switch is possible!
> >=20
> > In theory, yes, but I prefer to treat it as invalid until it can be
> > tested.
>=20
> Yes, i would treat 0, 1 and probably 2 as invalid. 2 ports would
> technically work in the DSA setup, but is pretty much pointless. It
> only gets interesting with 3 ports or more.

I will add an additional check and reject configurations with fewer than
3 ports.

>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Andrew

Thanks,
Vasilij

