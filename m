Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DC23CE480;
	Wed,  4 Mar 2026 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772650386; cv=none; b=NpF8YfBCFTB8wvZtFLzTvnesLhDd4UH1o1uCCr/lk6O8GOEXgNrWU/DiibBHpr1Ca4ljnltQvJS53hVZYR7xNxazYD8CVtj0OJFc7DH+b8NWj538WrnRisK3oI4XOqiHNm61KfPl1TWPK+JFCAnIGHFUbUQ7hhgkZnLVdL3l3gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772650386; c=relaxed/simple;
	bh=TpogHSI6BcOdK+qKwsFW1zNTYQiLpATLKXEGKvxL/xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXopHgpbXb84y3U8dykNfEfs8lBV89CmTX3VOsBIuYeJ/HaYiwX+BeIWD+qmRsg0Ljyb3yl/AIQA+nPlgdWmrdHF2V5NaI8hdWJ15JAk72gqBU+AAIRSILb8CW3pKnbmkvgXzCWuPDJIk+hZrXMfiNGv9dqxp3+E8y1iBAZKRc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZFpD/nr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZFpD/nr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF4CC4CEF7;
	Wed,  4 Mar 2026 18:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772650386;
	bh=TpogHSI6BcOdK+qKwsFW1zNTYQiLpATLKXEGKvxL/xg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cZFpD/nrDZcQASVw6AJGSdVacyhbfwgsxtiC+9WXGN+fceQhzqJzXZwRXUOVZen/6
	 8yZg4u/kkoIQGdPatD02YtopuwEI4DM/1N51yTmXlhRP6g3tKN84hRaZkEi72IkJum
	 0YQPpDI9mHsn26XkErcXt9YJizfd9Gmd7WSyQGnpbaEIgFNH3xj2VnqSVdCN/Q2afa
	 o1M5qzZlaL1thHt2Mkl1AAx2SGRdGkkKIYDDccZBSxGxEo0n6HM917CufdlLEi6p8A
	 rinoUBfTI+/gnJWM8crnt+P+Eu+taYdaohQj29+oPPTmbFbJtoF4VJjBZTm/l9qjqS
	 fqEfpiXwgNy7Q==
Date: Wed, 4 Mar 2026 18:52:58 +0000
From: Conor Dooley <conor@kernel.org>
To: Ryan Wanner <ryan.wanner@microchip.com>
Cc: Jakub Kicinski <kuba@kernel.org>, andrew+netdev@lunn.ch,
	richardcochran@gmail.com, abin.joseph@amd.com, robh@kernel.org,
	edumazet@google.com, netdev@vger.kernel.org,
	theo.lebrun@bootlin.com, pjw@kernel.org,
	Valentina.FernandezAlanis@microchip.com, krzk+dt@kernel.org,
	sean.anderson@linux.dev, aou@eecs.berkeley.edu,
	linux-kernel@vger.kernel.org, alex@ghiti.fr,
	devicetree@vger.kernel.org, palmer@dabbelt.com,
	nicolas.ferre@microchip.com, vineeth.karumanchi@amd.com,
	claudiu.beznea@tuxon.dev, samuel.holland@sifive.com,
	daire.mcnamara@microchip.com, conor+dt@kernel.org,
	dave.stevenson@raspberrypi.com, linux-riscv@lists.infradead.org,
	davem@davemloft.net, conor.dooley@microchip.com,
	narmstrong@baylibre.com, pabeni@redhat.com
Subject: Re: [net-next,v2,2/8] net: macb: rename macb_default_usrio to
 at91_default_usrio as not all platforms have mii mode control in usrio
Message-ID: <20260304-stardust-blade-c9ed766b041a@spud>
References: <20260226-enjoyer-shock-e17f9dc7cbdb@spud>
 <20260228232600.4187398-1-kuba@kernel.org>
 <20260228-shopping-april-a8c4d2481cbe@spud>
 <a1e36563-0e74-48b2-ae02-813cb28fc931@microchip.com>
 <20260303-stardust-shaky-c8a757ec149d@spud>
 <1d35173d-b364-4c4a-a083-388d3bd27ce5@microchip.com>
 <20260303-speech-reversing-b3fdf4817798@spud>
 <cb782e55-29f9-46c5-8213-397202b326ec@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9f74gDXlIrnBN4fp"
Content-Disposition: inline
In-Reply-To: <cb782e55-29f9-46c5-8213-397202b326ec@microchip.com>


--9f74gDXlIrnBN4fp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2026 at 09:13:39AM -0700, Ryan Wanner wrote:
> > No, I don't think this is what I am suggesting. I am suggesting adding
> > USRIO_HAS_CLKEN to the gem configs, and then modifying the usrio struct
> > to have a member called something like "refclk_default_enable" and sett=
ing
> > it to true for emacs and false for gems. Then in init code somewhere, we
> > would do:
> >=20
> > 	if (property_present(refclk-source))
> > 		if (property_read_string(refclk-source) =3D=3D "external"
> > 			refclk_enable =3D true
> > 		else
> > 			refclk_enable =3D false
> > 	else if (property_present(refclk-ext))
> > 		refclk_enable =3D true
> > 	else
> > 		refclk_enable =3D usrio.refclk_default_enable
> >=20
> > Then later on in init, when configuring the caps, we would do:
> >=20
> > 	if (!(bp->caps & MACB_CAPS_USRIO_DISABLED)) {
> >=20
> > 		if (bp->caps & MACB_CAPS_USRIO_HAS_CLKEN)
> > 			val |=3D refclk_enable;
> >=20
> > 		macb_or_gem_writel(bp, USRIO, val);
> > 	}
> >=20
> > Or maybe we just roll all that up together inside the !USRIO_DISABLED
> > code.=20
> >=20
> > The code currently in macb_configure_caps() about refclks would be
> > deleted.
> >=20
> > This would produce one property that works for both emacs and gems, not
> > change any defaults for existing devices and retain support for whatever
> > devicetrees made it into the wild with your property.
> >=20
> > Does that make sense?
>=20
> If we are set to have an external and internal clock dt property than I
> think we should just keep those if statements inside the !USRIO_DISABLED
> code block just to keep it more organized and clean and keeping the
> current HAS_CLKEN if statement be the fallback default case to set the
> register bit value. Some thing like this:
>=20
> if (!(bp->caps & MACB_CAPS_USRIO_DISABLED)) {
> 		if (property_present(refclk-source)) {
> 			if (property_read_string =3D=3D "external")
> 				val |=3D true;
> 			else
> 				val |=3D false;
> 		}
> 		else if (bp->caps & MACB_CAPS_USRIO_HAS_CLKEN)
> 			val |=3D bp->usrio->refclk;
>=20
> 		macb_or_gem_writel(bp, USRIO, val);
> }
>=20
> Would this be a good middle ground?

I explicitly would like to make HAS_CLKEN represent the USRIO having the
bit, and not ascribe behaviour to it, so that it is actually a
capability. This is why I want to make the default a member of the usrio
struct in match data.
Also, the bit position depends on the usrio struct, which we both
omitted from our pseudo code, which means that even knowing how to
modify val depends on having HAS_CLKEN/usrio.refclk being set, so your
fallback doesn't sit right with me - I am trying to avoid things writing
to USRIO without specifically being told what it is writing to is valid.

--9f74gDXlIrnBN4fp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaah/igAKCRB4tDGHoIJi
0u9rAQCBHamX+ZXo+ry/A8L1d4Wrf/HBb6wst95AlTZw5drewAEAk+Vt8RuqH3cj
W3p74jc+/pi4WgO9M0TeCoSpNnl1Kgs=
=JNVT
-----END PGP SIGNATURE-----

--9f74gDXlIrnBN4fp--
