Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0613248A8CD;
	Tue, 15 Sep 2026 10:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789469290; cv=none; b=LtfqbDIaC057O9Y6Cion+3Rj5bTqZK3WAnRJFloGHEWcQPqjrquV8Basel2lex0Sy6tQmuznQFmdRiqeEq4z19TQWP2UFenaHwl5WT7dyiHpCZgSpRrJy/vFEM5oIn7JV7JfvJmRJTNbXoeM5mCyyG+SJ4xRiUYU04Jc9JbZAuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789469290; c=relaxed/simple;
	bh=Vus90CXeLcAYO7udHlHzInT4pR3rvrjiJTN4h0xfGLE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fy0NxwIeq5Xxx8p7YP7F5WhVADa0gCdMfsZwhmqPqGhFvCyR7fvNf43xpiTYIOmCQ4kWEQ0pww+l5bxLL2gYiuMUFeilIRAvPYmMV/aGxiCXA0tD/hQX4fpMg3Zr+Mnrvm8u325D3hy5LLZIDe4sfqTMP4DspDogUTzSRi00rYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3PXlvpaC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i/LJxFaC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3PXlvpaC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i/LJxFaC"
Message-ID: <3007fddf91fb4260538073482f5148ce8ac6a6ba.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789469285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vus90CXeLcAYO7udHlHzInT4pR3rvrjiJTN4h0xfGLE=;
	b=3PXlvpaCzY+PYNuGHv+bI0A/qtR8CpAOJjpoAKLVWn/+7kKUyxIsBAX6VDd/TFRIKplPvI
	Ns/tDrgpMnCZuXLjYQwRRLhgsdA6090jIynN+wAeyagkOWjtpgBkY2uZB85TWW6H/3GrxE
	HFJr5lZP+020NCkmxRjBd5WKHq53mdyw+wIDN/OWfQ1nU1uo7oCPTH6Ovg+HW8+h/Fkd07
	P0C4pJaw/+bsprjfeU8VE8/vPhuUTlVGKBGWRQ4HbQc1QZZvLc574pTG6FwH5nzYUh/rpz
	ukO0dYIecDfOOtPl/x+jwJsHPJG1TAlGGk8LP2bq0ONG/lM4BWVg7EPTWdR4YQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789469285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vus90CXeLcAYO7udHlHzInT4pR3rvrjiJTN4h0xfGLE=;
	b=i/LJxFaCWuZCHZjlL3t6t0cocUgo+ivDH+DptNRnRu50NTZdZS4k3ocmtt9P09G/Sar8Lf
	hvZ2cDvTOSe4tSBQ==
Subject: Re: [PATCH net-next v2 4/4] net: dsa: soce: Add basic support for
 SoC-e switch IP cores
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
Date: Tue, 15 Sep 2026 12:48:03 +0200
In-Reply-To: <b7fdbd43-d069-40e1-aff4-30197371739d@lunn.ch>
References: 
	<20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
	 <20260903-devel-vstrassheim-soce-dsa-ml-v2-4-fb0587cb466b@linutronix.de>
	 <3c2c5b39-6a7d-4cb2-af1c-b5015b6bf1e8@lunn.ch>
	 <db26d5c9262069a11e5cbe00e176b81e40baebeb.camel@linutronix.de>
	 <5c955c96-7883-4e59-97ef-9fc3b63abf58@lunn.ch>
	 <ab7e4eeed1b8296188355413cce1aa2b2aa5c670.camel@linutronix.de>
	 <b7fdbd43-d069-40e1-aff4-30197371739d@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-09-10 at 14:18 +0200, Andrew Lunn wrote:
> > ethernet-switch@xy {
> > =C2=A0=C2=A0=C2=A0=C2=A0/* ... */
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0mdio_parent: mdio@204 {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0compatible =3D "soce,sw=
ip-mdio-23-02";
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reg =3D <0x204 0xc>, <0=
x200 0x4>;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reg-names =3D "data", "=
control";
> > =C2=A0=C2=A0=C2=A0=C2=A0};
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0mdio-mux@200 {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0compatible =3D "mdio-mu=
x-mmioreg", "mdio-mux";
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reg =3D <0x200 0x4>;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mux-mask =3D <0x1f0000>=
;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mdio-parent-bus =3D <&m=
dio_parent>;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#address-cells =3D <1>;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#size-cells =3D <0>;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mdio@0 {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0reg =3D <0>;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0/* PHYs connected to port 0 */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mdio@10000 {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0reg =3D <0x10000>;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0/* PHYs connected to port 1 */
>=20
> These comments are probably wrong, as i suggested in my previous
> reply. There is no reason that port 0 PHY could not be on bus 10000.
>=20

That's right. I will remove the misleading comments.

> I've no idea if it will work, but maybe try:
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reg =3D <0x203 0x1>;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mux-mask =3D <0x1f>;
>=20
> and then you get better bus numbers?

Although mdio-mux-mmioreg might work, I have realized that it is not
suitable here.

According to the switch documentation, the bus selector occupies bits
26:16 of the MDIO control register, while bit 0 is the transaction
start/busy bit. A partial write might trigger an operation before the
other fields have been updated.

Also accessing this register without checking the controller state
could interfere with an active or failed transaction and introduce
races (as noted by Netdev-Sashiko).

I will therefore add a dedicated MDIO mux driver. It will preserve the
other register fields and reject bus changes while the controller is
busy. Based on the current documentation, it will support selector
values representable by bits 26:16. These values identify hardware MDIO
interfaces, not switch ports.

So, in the next version, there will be a total of 3 new small drivers.

>=20
> =C2=A0=C2=A0=C2=A0=C2=A0Andrew

Thanks,
Vasilij

