Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEDB3CA4B5;
	Fri,  7 Aug 2026 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786105224; cv=none; b=rp2ahm4yAZ85UuoQeCukc3MZMY97Y6eLjVYcWCgCU9AIQPZT+dgREcQSdDhDCKrJG5bGk0WQgjPaESrRRZ5QUyZXdzJtwyBZt55xqP+q1KeqRMLtmDXAtCijGJ2iHi4Nr1xHj7k/ZWitJQgR9i8ksDicXonT/FiaNqoL1GXni/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786105224; c=relaxed/simple;
	bh=WD+nEcjDO5um4xpJtv44pYjLPuUJc9MrPc6HVcQDL+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQkK4WnbCkd1hgKsWym5NGPpvpdGqq3JRueHrs7yzVzlUv09KcnmSOMuZ1sMNwv6CsIoYekt80l8QHFCnDIT1M6feW916vAM4K8h4ECUq4kabvmiDKgm0hH4BQRTLRgTXW/YT9tCS60Pe9TF7fNQg9epMOHbNyOgFpwic6EJqzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aD8Nb/aV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aD8Nb/aV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDB71F000E9;
	Fri,  7 Aug 2026 12:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786105201;
	bh=MranplvP6uytyzOxQO7gd7wFKcMAlqoBI3aSsGQmDAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aD8Nb/aV2utlrgAnHb2IDJSb4bRBfhVOvtCXGq8HnD6N3AgSDA1XMJJZ6ZgxiWqg0
	 pRdViEWmJlkffH0dLm3fze1f1hIp3JfJe81MBdgBJUMcucYavVP8lFRHvtUn7+ZSAl
	 ImcTCUT6F7oUlJlwwJxYnqv7x2ABzJWvcMR5gt29lgoYKF0n8gmGws9xc2GIxfbikp
	 W2PAriCvfIBnhoSnklAhJO/h2VL8C8xU+hBPvjf49klWYa7QJYHN/pmX6xVG3nfP1l
	 y68RBIWedFFt3qFxgxvXMw+4ZVSE07/Xy+1MKf/xv8EiOKPejUkPsoljps7vIMIesd
	 Gaj9lKjRokRGg==
Date: Fri, 7 Aug 2026 13:19:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Linus Walleij <linusw@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	netdev@vger.kernel.org,
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
Message-ID: <113c8afb-0266-470e-a985-f60a7cdf6852@sirena.org.uk>
Mail-Followup-To: Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	netdev@vger.kernel.org,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Eric Dumazet <edumazet@google.com>, kernel@pengutronix.de,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org
References: <anSj34TOZxYiG_ai@pengutronix.de>
 <f2260b02-621f-4b92-aade-85c403a8839d@lunn.ch>
 <02a51eff-3782-4012-8475-1047a9be4dd3@pengutronix.de>
 <CAD++jLk-5-_2x2scn2hNQ-aWBx=EKGYzvcaUwv5fS7k5Bq=KGA@mail.gmail.com>
 <anVedv6aV1hguF5x@pengutronix.de>
 <CAD++jLkkwuRYrW7aF4BrxoH=qVfNfbzsW8A+URig79dVMxgZ-g@mail.gmail.com>
 <anWE2HD_Mrv9XlYV@pengutronix.de>
 <c9e3a4fb-40a1-40f6-b0e4-bf957195f1b8@pengutronix.de>
 <CAD++jLmJCwALGLJt98BBhYAy_5UfUsJp6J7ah2+Pu51CMJeMPw@mail.gmail.com>
 <89763f3f-f21a-4240-aeee-b75b8f19aece@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gY8e4S5W6npUh5G9"
Content-Disposition: inline
In-Reply-To: <89763f3f-f21a-4240-aeee-b75b8f19aece@pengutronix.de>
X-Cookie: 1 + 1 = 3, for large values of 1.


--gY8e4S5W6npUh5G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 07, 2026 at 10:27:31AM +0200, Ahmad Fatoum wrote:

> Anyways, circling back to the patch: Any objections to leave it as-is
> and suppress the warnings in this particular driver?

Yes, that is a buggy use of regulator_get_optional() so you should not
do that.  Unless the supply may be physically absent it should not be
used.  If you have ideas for how to safely improve the implementation of
the normal regulator_get() then it'd be better to do that, bearing in
mind that it's an API where getting things wrong can easily result in
physical damange to the system.

--gY8e4S5W6npUh5G9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp1zWoACgkQJNaLcl1U
h9B+JAf/QGGxvyiBcW5kulXya+ewiFmKk+tHUnDIGuEgOPsinCZwmjTPrF5ZzdjH
+EyrE8Y9uCG0ZgYpfDjwjZFnCBzbU45zBueQFmati0v/5GFdn9IrMyizA3Wepuo4
OIN+GDdoAZwgl/pTLfGM4ZrVy4WnAr8I52joyYgHCFV7AmJJsxS/0lPlFPuU/DHR
L3PUDb8QUgPv1ZmzcjgJL5OMep/FvrYyYslpLG2e0Uh2Mkkk01l6tb0F7zzzg+QU
B6cfiQmVPwzep+nKIA66qHmG/lyB6zhe7rn41fb/ZjAoHlqs55X0hkgYhmpH6+Ib
4fqOo6m1FZJ9dyiPL7iC/D4p5hbPwg==
=rERM
-----END PGP SIGNATURE-----

--gY8e4S5W6npUh5G9--
