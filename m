Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220B0437871;
	Mon,  6 Jul 2026 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344093; cv=none; b=I+g+7KMbUckCzw/1vEhzq+qgEi6x0TZ53+bMQD3Rlfp+x+bQuv3uKIthmycNLSz1qaED/YBzIENZc0TRUEwdMButH67wrWAm+vuaNgDPL8ePxd1spAH5FWDFTYbOnFxLCwHRZ0sIRpxc5sN8XHZu4PvIPBCK4j5sulh+OlQ15AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344093; c=relaxed/simple;
	bh=LIBdR4kNPFgAFg6CIvOqngtwtnAfcvSaKkHxpyzx3/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIItU7rujn7BPuqVQy1tCTfQbkKtNEJbKs3vXCFN52Y3cDfkAe00hPot5RbpQAbbPPTRQDkJvVJqtGdk53sM58IpI1KdVpP3+YHNWccEUauGVPNYIiLdnTcIE5NL1Aze9h4fWUrxbDASH7rM/Dh7J9US5vRoEjq8pqhnU8uFYT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzhGtLEI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzhGtLEI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E42B1F00ACF;
	Mon,  6 Jul 2026 13:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783344091;
	bh=LIBdR4kNPFgAFg6CIvOqngtwtnAfcvSaKkHxpyzx3/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hzhGtLEIi1bGKJUC8u0qeW903kcSL3pljP7AzVrtfkZGGdgUDrJReqcoxx+k3wMrP
	 Zz/RnazFls+zmQ8qsn1GMbrnZ7t5QVR0DM1m1vzifytBeK3QFfRGlZgP8DV/8RcrsY
	 W7sc6enVxVr0saHu8cE8jQyiQuo0kLSlFLwWvsK20bBlrZiotMIxEmcS4aYw0USZaf
	 IJqxLzl1Htxaa7FBiJ6AMgwyHg1HnPrY9B6qOdeY6Z3G1BVSzCC0UgnZd9vfe1Dzmw
	 ukFJvYnBBzWJuKp4++gojDAnCDOmKlaQOIaKuk9fbhj1zMZAFXNcF+lFVH6z+eystA
	 D494h+6Eq+sLw==
Date: Mon, 6 Jul 2026 14:21:23 +0100
From: Conor Dooley <conor@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	alexandre.torgue@foss.st.com, mcoquelin.stm32@gmail.com,
	pinkesh.vaghela@einfochips.com, pritesh.patel@einfochips.com,
	maxime.chevallier@bootlin.com, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, pjw@kernel.org,
	weishangjuan@eswincomputing.com, horms@kernel.org, alex@ghiti.fr,
	lee@kernel.org, wens@kernel.org, lizhi2@eswincomputing.com,
	devicetree@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	netdev@vger.kernel.org, rmk+kernel@armlinux.org.uk,
	aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v9 6/6] riscv: dts: eswin:
 eic7700-hifive-premier-p550: enable Ethernet controller
Message-ID: <20260706-confess-dagger-e60b5fad57e8@spud>
References: <20260630063123.1118-1-lizhi2@eswincomputing.com>
 <20260630063445.1226-1-lizhi2@eswincomputing.com>
 <8e5eb97d-dfaf-47a1-8572-b3252a2c7ed3@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ULiKs6VR99TI7WYu"
Content-Disposition: inline
In-Reply-To: <8e5eb97d-dfaf-47a1-8572-b3252a2c7ed3@redhat.com>

--ULiKs6VR99TI7WYu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2026 at 03:09:37PM +0200, Paolo Abeni wrote:
> On 6/30/26 8:34 AM, lizhi2@eswincomputing.com wrote:
> > From: Zhi Li <lizhi2@eswincomputing.com>
> >=20
> > Enable the on-board Gigabit Ethernet controller on the
> > HiFive Premier P550 development board.
> >=20
> > This patch is included only to provide the DTS context for reviewing the
> > binding and driver changes in this series.
> >=20
> > The upstream DTS series will be submitted separately after the binding
> > and driver changes are finalized.
> >=20
> > Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
>=20
> @Rob, Krzysztof, Conor: I see this patch is not listed in the devicetree
> PW, but I think it needs explicit acks from relevant SMEs. Could you
> please have a look?

We do not typical provide tags from dts patches, but that's irrelevant
for you, because this (and effectively all other dts) patch(es) should
not go through the net tree to begin with.
Instead, the platform maintainers should review and/or apply it.

Additionally, it seems the contributor's commit message suggests
that they didn't intend this patch to be applied at all?

Cheers,
Conor.

--ULiKs6VR99TI7WYu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakur0wAKCRB4tDGHoIJi
0lJJAQDyznJ0mXwKfkHnFRg/RjkZfn/slGLhUuYfKnvvJnC3yAEA7uHRCP2yagsd
bJ/ACyG7Ej0e3jeZwhPFEWzspucP9go=
=kICX
-----END PGP SIGNATURE-----

--ULiKs6VR99TI7WYu--
