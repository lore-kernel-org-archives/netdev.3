Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.16.241.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915680;
	b=lPSFSkMVHtqIYtrK24R6n4Df2ILWeQygjhxxeuuFiMRMj9IC4BBqTEVhWC9jtum1fZcV
	 Kot8ZkmLmrW0/BAWLfDsgTniOGj6JInwD+WOjdwsDrV00y0+pJA4WSSOnjEq5e5ZvkSdx
	 RYqR/76FQVKsAiL0XBl2HJYi4h2Ha9KWmGFUrOyTq6bBJNZ0ds+Xp7QunVb1OxWqqMlNn
	 OPXhW4go4VjpJUdabpDtmbibjUcVdQ8pK6VSfCbW0voFTKf6DB3kNBsy+prRZ5dbGtj3m
	 w69a1SJQE9/556O2C8IewnAXZuj4AKl2qzDQGP7hDAD8pG5IYLnq8KeHA/4trFFFkJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915680;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=UDf0ZD2mFU/9VOS9NrkMQ2SrgMQ/8BOQ9ZjvvF58EJ8=;
	b=KeDmLDGhl8rZ+iqQ/Zz+ztCTTBg3Tl+tNjeC4LV/D3f0kej3kWaQoZVjmXma91JEx2hu
	 2wGs4AB78kYDtMtaxpYpUoTeSvvfuuRF4bGSGU/kGxfy8XpPajuq/lktn77B0vOmSlMZe
	 WscE/I6nH09LA831DbjbYac0mTUuEILkBZIAJhrJJeGGqpIFHrV9p0KfqkhtKLtevGTQ+
	 agJoXFhID+AJhj6otrPRJStiKScD9vTLKL4Xs3FsNMAogxpnKm/zavdg7utv89y/k6j4G
	 4PaBqvMXgc7PB9jQL8vFX0JG+XQbsl/WG2q8Zbint+B8icE4uPTSKl4h7DkBY+3qd1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=svanheule.net;
	spf=pass smtp.mailfrom=svanheule.net;
	dkim=pass header.d=svanheule.net header.i=@svanheule.net header.a=rsa-sha256 header.s=mail1707 header.b=A5nstH6R;
	arc=none smtp.remote-ip=84.16.241.116
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A0E606A32D
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 21:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24A0E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=svanheule.net header.i=@svanheule.net header.a=rsa-sha256 header.s=mail1707 header.b=A5nstH6R
Received: from [IPv6:2a02:1812:1620:5d00:3b08:a3e3:d87d:2eff] (2a02-1812-1620-5d00-3b08-a3e3-d87d-2eff.ip6.access.telenet.be [IPv6:2a02:1812:1620:5d00:3b08:a3e3:d87d:2eff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id D253A9D45BC;
	Thu,  5 Nov 2026 22:54:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1793915678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UDf0ZD2mFU/9VOS9NrkMQ2SrgMQ/8BOQ9ZjvvF58EJ8=;
	b=A5nstH6R9AxornaFbk3UsYO8XlNim0DtyFZTX/wxXmLmqw5kxDYxl7Vp1rT0WkaJSalDkN
	8EYZOO/vi/cpjE0hBzJ96TYeqXzs8Ugn3RENiq7oJYog9vadAQSEt6FsXRQOATBUKP9ePu
	D8uzYyET6KCOMHBrt+wxN2kajv97L405LbjngitAtGlDrOQvIcl6zS8WxPO54XaVmtFeFx
	4sN83+r0t3FTosgK1OJO8HcA/9zN/BLVaaPS4K3IqMM2dPxWvtW986GWyB8B9tAOGqs3EM
	9M647qxE3EFF/0r1yYln20FbmsxUcUAaw80FRoNAp0LXZ/fhJD39DrscfnAaDg==
Message-ID: <86b137d440c29b92ea56a69fa6ad27970090f126.camel@svanheule.net>
Subject: Re: [PATCH net-next 3/4] net: pse-pd: realtek-pse-mcu: configure
 global power budget
From: Sander Vanheule <sander@svanheule.net>
To: Kory Maincent <kory.maincent@bootlin.com>, Jonas Jelonek	
 <jonas@jonasjelonek.de>, Oleksij Rempel <o.rempel@pengutronix.de>, Andrew
 Lunn	 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet	 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni	 <pabeni@redhat.com>, netdev@vger.kernel.org, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Russell Senior
	 <russell@personaltelco.net>
Date: Thu, 05 Nov 2026 22:54:37 +0100
In-Reply-To: <357f6311-7f00-42c3-8eec-e0fd0c35749e@bootlin.com>
References: <20261103220312.860629-1-jonas@jonasjelonek.de>
	 <20261103220312.860629-4-jonas@jonasjelonek.de>
	 <5e00fd7f-40f9-4041-8dfa-fff222b57b92@bootlin.com>
	 <e0910567-999c-4c96-9b20-2e34434bec3d@jonasjelonek.de>
	 <357f6311-7f00-42c3-8eec-e0fd0c35749e@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Kory,

On Wed, 2026-11-04 at 13:36 +0100, Kory Maincent wrote:
>=20
>=20
> On 11/4/26 13:20, Jonas Jelonek wrote:
> > Hi Kory,
> >=20
> > On 04.11.26 12:32, Kory Maincent wrote:
> > >=20
> > >=20
> > > On 11/3/26 23:03, Jonas Jelonek wrote:
> > > > Use the optional VMAIN regulator power budget to configure the MCU'=
s
> > > > aggregate PoE power limit during probe. Quantize the available budg=
et to
> > > > the protocol's 100 mW units and reserve exactly that amount through=
 the
> > > > regulator core.
> > > >=20
> > > > The regulator budget represents the usable PoE allowance. Program z=
ero
> > > > reserved power so the previous firmware guard band does not further
> > > > reduce
> > > > that allowance.
> > > >=20
> > > > Require a finite budget of at least one protocol unit when vmain-su=
pply
> > > > is
> > > > provided. Program the budget before selecting dynamic power managem=
ent
> > > > and
> > > > ungating the ports, so enforcement starts with the regulator-derive=
d
> > > > limit.
> > > >=20
> > > > Enable VMAIN before hardware initialization and register one manage=
d
> > > > cleanup
> > > > action to free any reserved budget and release the enable reference=
 on
> > > > probe
> > > > failure and driver removal. Record each successful reservation
> > > > immediately
> > > > so subsequent initialization failures are covered by this action.
> > > >=20
> > > > Read the current budget index before programming the MCU. Retain th=
e
> > > > programmed MCU limit on probe failure and driver removal, as reduci=
ng
> > > > that
> > > > limit to zero would interrupt ongoing power delivery.
> > > >=20
> > > > Boards without vmain-supply retain their existing firmware-managed
> > > > budget.
> > > >=20
> > > > Signed-off-by: Jonas Jelonek <jonas@jonasjelonek.de>
> > > > ---
> > >=20
> > > ...
> > >=20
> > > > =C2=A0=C2=A0 +static void rtpse_mcu_cleanup_vmain(void *data)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0 struct rtpse_mcu_ctrl *pse =3D data;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0 if (pse->requested_budget_mW)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator_free_power_bu=
dget(pse->vmain, pse-
> > > > >requested_budget_mW);
> > > > +=C2=A0=C2=A0=C2=A0 regulator_disable(pse->vmain);
> > > > +}
> > >=20
> > > Following patch 4 logic, you might not want to disable the PSE contro=
ller
> > > power supply,
> >=20
> > I added it because of the requirement that regulator_enable() calls mus=
t be
> > balanced with regulator_disable() calls. Accepting that this may power =
off
> > the
> > rail in theory, something outside of the driver would need to keep the
> > supply
> > enabled. Concretely, I'm thinking of "regulator-always-on". And all boa=
rds
> > I've seen so far which can use this driver do not provide a provide to
> > really
> > power off the PoE rail. Sure this is no finite guarantee.
> >=20
> > What is the correct way? I see either droping the enable call too, just
> > relying on
> > that it is correctly handled outside of this driver, or I keep enable +
> > disable and
> > the continued delivery is ensured with "regulator-always-on".
>=20
> Indeed if you use "regulator-always-on" it does not turn off the power=
=20
> supply when we call regulator_disable().
> https://elixir.bootlin.com/linux/v7.3/source/drivers/regulator/core.c#L32=
69
>=20
> Does the PSE controller needs this supply to start, or is it only=20
> required to power the PSE PIs?
>=20
> If it is the first you will need to enable it in the driver.
> If it's the latter, you could describe it as the PI's regulator parent=
=20
> supply. An enable of any PI will enable this vmain regulator.

I'm not sure if you've seen a diagram before, but allow me to add one to sh=
ow
what the binding currently models (for a UART controlled MCU):

              =E2=96=B2Vdd     =E2=96=B2Vpwr                         =20
        =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=90           =20
        =E2=94=82     =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=90   =
  =E2=94=82           =20
        =E2=94=82  =E2=94=8C=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=90   =E2=94=82       =E2=94=82=E2=94=8C=E2=94=80=
=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=90 =E2=94=82           =
=20
      =E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=96=BA=E2=94=A4RX  SDA=E2=94=
=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=AC=E2=94=80=E2=94=80=E2=94=BC=E2=94=A4      =E2=94=9C=E2=94=80=E2=94=
=BC=E2=94=80=E2=94=80=E2=94=80=E2=96=BA PSE-PI0
      =E2=97=84=E2=94=80=E2=94=BC-=E2=94=80=E2=94=A4TX  SCL=E2=94=9C=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=BC=
=E2=94=80=E2=94=80=E2=94=BC=E2=94=A4      =E2=94=9C=E2=94=80=E2=94=BC=E2=94=
=80=E2=94=80=E2=94=80=E2=96=BA PSE-PI1
        =E2=94=82  =E2=94=82       =E2=94=82   =E2=94=82   =E2=94=82=E2=94=
=82  =E2=94=82=E2=94=82      =E2=94=9C=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=
=E2=94=80=E2=96=BA PSE-PI2
        =E2=94=82  =E2=94=82MCU    =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80=
=E2=94=80=E2=94=BC=E2=94=BC=E2=94=80=E2=94=80=E2=94=BC=E2=94=A4PSE-0 =E2=94=
=9C=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=96=BA PSE-PI3
        =E2=94=82  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=98   =E2=94=82   =E2=94=82=E2=94=82  =E2=94=82=E2=
=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98 =E2=
=94=82           =20
        =E2=94=82              =E2=94=82   =E2=94=82=E2=94=82  =E2=94=94=E2=
=94=80=E2=94=80=E2=94=80=E2=94=90     =E2=94=82           =20
        =E2=94=82              =E2=94=82   =E2=94=82=E2=94=82   =E2=94=8C=
=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=90 =E2=94=82  =
         =20
        =E2=94=82              =E2=94=82   =E2=94=82=E2=94=94=E2=94=80=E2=
=94=80=E2=94=80=E2=94=A4      =E2=94=9C=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=
=E2=94=80=E2=96=BA PSE-PI4
        =E2=94=82              =E2=94=82   =E2=94=94=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=A4      =E2=94=9C=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=
=E2=94=80=E2=96=BA PSE-PI5
        =E2=94=82              =E2=94=82        =E2=94=82      =E2=94=9C=E2=
=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=96=BA PSE-PI6
        =E2=94=82              =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4PSE-1 =E2=94=9C=E2=94=80=E2=
=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=96=BA PSE-PI7
        =E2=94=82realtek,pse-mcu-gen1   =E2=94=94=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98 =E2=94=82           =20
        =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=98           =20


The outer box is what is modeled by the binding, but really consists of at =
least
two chips on the board. The "vpwr-supply" (Vpwr) of the PSE PIs is controll=
ed by
the PSE-n ICs. The MCU doesn't use Vpwr and doesn't control it directly, bu=
t has
to do this via the PSE controllers. This is similar to a PD69200 setup.

Like Jonas said, Vpwr is usually (always) an always-on power supply, which
matches well with "regulator-always-on". Vdd is the supply that actually po=
wers
the logic, but that is normally also not a switchable supply and hence not
modeled by the devicetrees describing these PoE switches.

This proposal adds Vpwr as "vmain-supply" on the main DT node, but I suppos=
e
that also means it should not be used for "vpwr-supply" on the PI subnodes?

Would it make sense to model realtek,pse-mcu as a regulator as well and hav=
e
"vpwr-supply" PI properties point there (instead of the fixed regulator)?
AFAICT that's similar to the approach taken by the microchip,pd692x0 bindin=
g,
where the PI nodes point to a manager. But I also don't know if that offers=
 any
advantages here.

Best,
Sander
