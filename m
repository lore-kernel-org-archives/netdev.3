Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3D33BD64A;
	Wed,  7 Oct 2026 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791377970; cv=none; b=swQbe3ezpgjAmaF8kHjEiShh625JHuwdkumylGi8HBXLHLXBLZ+MdSludZRK6gdN7B0TqBTNLj4BFhwg1JZHXua7fxAHfTQxBKu1kw8awBe0eloKprprpShxMfUZXlsjzTDsndAgpwe2GoIeKbgDFu5sJnYr8SZxXDTBPR4cP/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791377970; c=relaxed/simple;
	bh=dwR3gHAwZrUlbJdpWYscVbEmULgrTOfq08+7cc5P/XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ups1lwlSld16GqMOS7M2iVpRJs3XiNz/qdPswbWgFcTiU74RyGfVuLGJTJSRUgjY8ZDxlF36wBWIBwlTbEOfoysuGHgRfYLGTtDup9lX7P/kY7Po131hNcMpQVL96dSe7AHqamMqxND09s2yDjSeUjjPZiq2/x7m3WSWhRSR+jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZgvNs+7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZgvNs+7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0F51F0089B;
	Wed,  7 Oct 2026 12:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791377959;
	bh=dwR3gHAwZrUlbJdpWYscVbEmULgrTOfq08+7cc5P/XM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EZgvNs+7KV/3y0yBb6ZoBJJqh7YzO3nfMCDqmPeXmK6DaiouIQDadghSTjRcACi/2
	 HULuc2RxEc57Jmnn1ubL3ISW1lJuwmn57sn7FBi+jTg+O7todNEnVPgrNxrx88jiDd
	 qtRzaDSQ4TaYVExYFgs292X5lRCcIKyyUa+WuXBEn/1yL2s9gdUdRQ2ASfVZKQ5w0D
	 zVnTuBh+7A0Jft/lWl2gRN9v5KT6E0uzKmqcGjcqWiDb0Qa6Fa7ac5dwFDbNOBFaR/
	 Ab5fXSFarOAzb/0/W6y4mzhhILxd5DFaBruQV47oogqVwU+K65XMH80aq+UD5LzvHW
	 ljFjw3fnmLC/w==
Date: Wed, 7 Oct 2026 13:59:11 +0100
From: Conor Dooley <conor@kernel.org>
To: Lucas Tanure <tanure@linux.com>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/7] dt-bindings: net: amlogic,meson-dwmac: add
 amlogic,t7-dwmac
Message-ID: <20261007-634979008f45ea7ff444d41b@squawk>
References: <20261007082627.63807-1-tanure@linux.com>
 <20261007082627.63807-4-tanure@linux.com>
 <asYWEwjFO8g50o1i@squawk>
 <CAJX_Q+3nHRH--pJHxv6PqwpVYTdFAqG1bQdB5=DT6jgLsFKO=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Zbkq0YzkpeyE441M"
Content-Disposition: inline
In-Reply-To: <CAJX_Q+3nHRH--pJHxv6PqwpVYTdFAqG1bQdB5=DT6jgLsFKO=Q@mail.gmail.com>

--Zbkq0YzkpeyE441M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 07, 2026 at 11:34:54AM +0100, Lucas Tanure wrote:
> On Wed, Oct 7, 2026 at 10:51=E2=80=AFAM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Wed, Oct 07, 2026 at 09:26:23AM +0100, Lucas Tanure wrote:
> > > The T7 has the same ethernet glue as the G12A, but the controller
> > > reaches memory through a pipeline stage that this SoC inserts in the
> > > bus path. That stage has a gate of its own, which no other member of
> > > the family has, and nothing else in Linux claims it. It is therefore
> > > switched off as unused, and the port can then no longer finish a
> > > transfer.
> > >
> > > Describing it needs a fourth clock, and the fourth clock of the
> > > existing list drives the timing adjustment logic, which the T7 never
> > > uses. So the T7 gets a list of its own with the gate in that place,
> > > under the name the SD and eMMC controllers already use.
> > >
> > > Assisted-by: LLM
> > > Signed-off-by: Lucas Tanure <tanure@linux.com>
> >
> > Didn't I ack the previous version?
> Sorry, I didn't receive one.

Hmm, thought I had sent one.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--Zbkq0YzkpeyE441M
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasZCCgAKCRB4tDGHoIJi
0o/uAQDH6PB4FUDRgOVLQKFmYjwcQt2CXCVjVxTNOzUqkxslCQEAyqjDGZUbFb3t
Rx4Z3kIt/JfIveShRWhBuUi6Iqkvrgc=
=rJrd
-----END PGP SIGNATURE-----

--Zbkq0YzkpeyE441M--
