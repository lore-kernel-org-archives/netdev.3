Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A99442AA9;
	Sun, 11 Oct 2026 21:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791753241; cv=none; b=WnlanJHe5n5PKd5kXcB9CK3iKUGnWE76mCIOsDtdngwgo5ddXlb4uwzz/dR9dsQYZNQzZKUgLW2Dz1Nrk//2DN0PlLUj16RgcAdnA13qATAkDonptQcCIT43S9ams1vvYo8ytpAYp+1DrO1VTRa18bIpeptg61RvpojeR/8K9Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791753241; c=relaxed/simple;
	bh=SvO4R3vxF4xR1wqicParlaqsB3sS5MVT1lmEeZOcGvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+zEoproq0MR5Cy9I3o3sGHOb8YYOrjHFVCLUBzZdKyV7wXVYMxO9j8vJ5wkDSVNbao//U9ealO32ZCo65lQPN9xJjsZ7rp9HkXq5nwqS9EY96YdCrP2M1Gn+a+C1yE+N8DCtQ1fnNPbYT5dOMwCon8GvUCo7gIRbx6q/hqCWdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9R0nBAp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9R0nBAp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743761F0089B;
	Sun, 11 Oct 2026 21:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791753239;
	bh=cB64+7GIL/QejhQmJX5UmgahZ1S8lTXRVFKShlbGWQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y9R0nBApfEq3cFVA+VsinEcrUSzp6c6bkadfZbfDy1QEQ5rg5OoIhCrczxqxVS8kT
	 2HCmsO3+W/T1abh2B3I65X7x5vUzr6/euVpLz62Vk52UmSYp3MrIvnlOMVrfn8H8DG
	 MpMCa6Zs5ebzHvIYHcvddVChPsaMdWP/v7H2s8fzOx0wSu9M1w5a/ugCmIJ9EgQ/nh
	 UphV13z3PHvIvffykWUVXTGisHUO9e8mRsmH3fY+RSHQKkQCWY35rny4nZbSsQaCUz
	 FQL35cVSIfc3jQjVf9AmhNE73CU/WhMWFD8xNuZHj+izqQ3ViEg18rZ7Q2dL7efhbW
	 GBotapyIPL2RQ==
Date: Sun, 11 Oct 2026 22:13:53 +0100
From: Conor Dooley <conor@kernel.org>
To: Lucas Tanure <tanure@linux.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: net: amlogic,meson-dwmac: list the
 compatible combinations
Message-ID: <20261011-starship-foyer-1105c1b35e31@spud>
References: <20261010105900.247342-1-tanure@linux.com>
 <20261010105900.247342-2-tanure@linux.com>
 <CAFBinCAejxmeeHyDy+vMSg6dBm+9prhEo9qZ7FAsiWNB1W-HXw@mail.gmail.com>
 <CAJX_Q+3JLn6oTt8qTPM-muKsY9JbTEMwqRvbamZ3vqg_Yymsmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Li4Qmgdoe6LbIUh+"
Content-Disposition: inline
In-Reply-To: <CAJX_Q+3JLn6oTt8qTPM-muKsY9JbTEMwqRvbamZ3vqg_Yymsmg@mail.gmail.com>

--Li4Qmgdoe6LbIUh+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 03:16:18PM +0100, Lucas Tanure wrote:
> On Sat, Oct 10, 2026 at 11:04=E2=80=AFPM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> >
> > Hi Lucas and Conor,
> >
> > On Sat, Oct 10, 2026 at 12:59=E2=80=AFPM Lucas Tanure <tanure@linux.com=
> wrote:
> > [...]
> > > +          - enum:
> > > +              - amlogic,meson8b-dwmac
> > > +              - amlogic,meson-gxbb-dwmac
> > > +              - amlogic,meson-axg-dwmac
> > > +              - amlogic,meson-g12a-dwmac
> > > +          - const: snps,dwmac-3.70a
> > > +          - const: snps,dwmac
> > > +      - items:
> > > +          - enum:
> > > +              - amlogic,meson6-dwmac
> > > +              - amlogic,meson8m2-dwmac
> > Meson8m2 dwmac reports: User ID: 0x10, Synopsys ID: 0x37
> > In case it helps I can submit a patch to change the Meson8m2 .dtsi to
> > use "amlogic,meson8m2-dwmac", "snps,dwmac-3.70a", "snps,dwmac" - then
> > we could move it here too.
> > That leaves only Meson6 with a single fallback compatible. I don't
> > have any Meson6 boards, so it'll have to stay that way.
> Hi,
>=20
> Fine by me. But I think it is best to wait for this series to be merged.

In the second sentence, you're referring to the dts patch I assume?
IMO, you should submit a new version of this with the 8m2 moved to the
other enum and Martin can submit the dts patch now, since the current
binding permits using dwmac-3.70a, no need to wait for this to be
merged.

--Li4Qmgdoe6LbIUh+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasv8EQAKCRB4tDGHoIJi
0j98AP4rQ60xf6QZIR+UVdVPmdSR8xm6GMzsKTW5wwCVZq8gLAEAyM8L5JCUZzmE
aBhkxeWELj13jV1WIQV+eunZ4dUaYgU=
=+0qV
-----END PGP SIGNATURE-----

--Li4Qmgdoe6LbIUh+--
