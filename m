Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE574DDB4B;
	Mon,  5 Oct 2026 20:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791230508; cv=none; b=jQEzfUwzZHJSnybyxu70BKH/lo/DOPtSbmtX5QOKM2ZwTlSxFAknu8NW6A8i72JD1sFFAPRrVHNiDsUNlWkIGcEy013AnRyNz8J0Ni65qdvgLmSJVrfwhCLTlxLqg+VDm9XC0k+DuBkCUt2mzVl70UFryx1FEGYW3pHd75QDMaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791230508; c=relaxed/simple;
	bh=BELa2DDWfS8U8jl+SDkG2uJ4g1bJg+pZUDCMnr17IaA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FcROeNC/LSf5+uyWRfHdKbCC26/UBv7rhgjyc59rkxFs+cqo39ZDQN1fr3ZiTo4jKKKYNeM5tG7O5A4Q4p86tfc9jwu1tHcTJW5kWmF6GPCix02Q4qYuHXlS6tBDyWLggeAk2rEw9YNwX0LcHpoaxSv8qmY0qj9KXIiTyGJErQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zSP9HcJG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+gNEbAke; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zSP9HcJG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+gNEbAke"
Message-ID: <f078112879455b0f59b7278f966b84f2ddea1a0f.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791230495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S+U78JOwbOPXwnC4RFGdnqyGIfBIo2MNgXS2aKLjSCU=;
	b=zSP9HcJGNuewebdEUnlDr1NPl/4iqp4M9vZxBm06NlF1rfRleoUQtJS27Z9u9CAsYBt3o3
	O5Ch+jXTYIbsVgQdYAPC73F5X/ZIXxmjalZSyIaWrozDuxbY55j4yJrUCc2tG06nHwzGlW
	+8A+BwHa2k2rF3Ptp4xlLjSaAbJfaGSfhCmKKg7xCUVTFSUiE/MF7v+oGD2YNufiyWxpjM
	k6nWWpXtNzapkvLD26G24DP4pPZwpRR2rik28nAGtnNnRWLqAyGJhq1bgjG2plfaWtrCpL
	X03ENB9oqwDEW6klSsqI+1Kd2mRr+y0WyqvzUXDB+Qf5WM8DVSKU3O+4VXHDYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791230495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S+U78JOwbOPXwnC4RFGdnqyGIfBIo2MNgXS2aKLjSCU=;
	b=+gNEbAketoxkH6J3Kiub669W1QnkNLa4q6q0rtwDPmpbJgGcIiMY/eGOjo0rTXDiIlmbOU
	XvVNrVDZxw/kbYCg==
Subject: Re: [PATCH net-next v3 2/8] dt-bindings: net: Add SoC-e SWIP MDIO
 controller
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,  Martin Kaistra
 <martin.kaistra@linutronix.de>, Benedikt Spranger <b.spranger@linutronix.de>
Date: Mon, 05 Oct 2026 22:01:32 +0200
In-Reply-To: <6a635aa0-3489-4d2b-b302-06b793326654@lunn.ch>
References: 
	<20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
	 <20260923-devel-vstrassheim-soce-dsa-ml-v3-2-ddebafcb9ba7@linutronix.de>
	 <e5aa5cd8-e805-47d3-a105-07bf1b9eb9b8@lunn.ch>
	 <218d4c1cf5f05cd6cc648c01f8a20ec66b95362c.camel@linutronix.de>
	 <6416b34a-83ce-4aca-8adf-c8894ca7b3c3@lunn.ch>
	 <ad24be6928e33b544f9c8c72ea05f64c2968035f.camel@linutronix.de>
	 <6a635aa0-3489-4d2b-b302-06b793326654@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-30 at 20:24 +0200, Andrew Lunn wrote:
> On Wed, Sep 30, 2026 at 07:13:35PM +0200, Vasilij Strassheim wrote:
> > On Wed, 2026-09-30 at 17:14 +0200, Andrew Lunn wrote:
> > > On Wed, Sep 30, 2026 at 04:00:56PM +0200, Vasilij Strassheim wrote:
> > > > On Sat, 2026-09-26 at 00:55 +0200, Andrew Lunn wrote:
> > > > > > The controller exposes separate register regions for transactio=
n data
> > > > > > and for the shared transaction control and external bus selecto=
r
> > > > > > register.
> > > > >=20
> > > > > > +examples:
> > > > > > +  - |
> > > > > > +    mdio@204 {
> > > > > > +        compatible =3D "soce,swip-mdio-23-02";
> > > > > > +        reg =3D <0x204 0xc>, <0x200 0x4>;
> > > > >=20
> > > > > At least in the example, they are not separate?
> > > >=20
> > > > Not separate regions but registers...
> > > > I'm obviously bad at documenting things.
> > > >=20
> > > > The current information in the commit message is misleading and
> > > > irrelevant. Looking at the bot's feedback, it's at the same time no=
t
> > > > clear enough yet that the mdio controller part is mapped within the
> > > > switch memory and can't be used separately from it.
> > > >=20
> > > > I will update the commit message to something like this:
> > > > Add a binding for the MDIO controller integrated into SoC-e SWIP
> > > > Ethernet switch IP cores.
> > > > The controller shares the memory of the synthesized switch IP core =
and
> > > > cannot be used independently.
> > >=20
> > > I think part of the issue is the compatible. That suggests it is a
> > > separate device, with its own driver. But it is actually driven by th=
e
> > > switch driver.
> >=20
> > I can't avoid the compatible right now. Somehow it is still a separate
> > functionality. I hope the following example doesn't cause unnecessary
> > confusion, but rather helps to understand the system better:
> >=20
> > The relationship between the MDIO controller and the switch core is mor=
e
> > like that of tools in a Swiss Army knife.
> > There are a few standalone tools, such as the knife and the screwdriver=
.
> > These can also be described on their own. But they only make sense when
> > they are attached to the knife as a whole. As soon as one takes it
> > apart, the individual tools can no longer be used effectively. At the
> > same time, no one needs to worry about the screwdriver if they only nee=
d
> > the knife.
>=20
> Maybe consider an MFD.
>=20
> You then do get independent devices.
>=20
> Also, with the current structure, i'm not sure how the mdio-mux is
> getting instantiated. You list it inside the switch node, so i don't
> think i will get turned into a platform device and probed. An MFD
> might helper, maybe.
>=20
> There are other switches which are described as MFD, so it is not
> unknown.

I was initially thinking that an MFD would be too much for a switch, but
after looking at it more closely, it seems to be the right model here.
I will update this again with a bigger change.

I would also update the Kconfig structure. The Ethernet switch child
will be the only user-visible entry point. Selecting it will select the
"SWIP IP Core" MFD parent as well as the required MDIO controller and
mux drivers. The MFD and MDIO controller symbols will have only empty
tristate options.

>=20
>       Andrew
Thanks,
Vasilij
