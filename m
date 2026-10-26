Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792999909;
	b=s6DypAVx5dCWx+a/VySB9ulGysoykR1Y4G+Noy0sqEXP19Fz7GJwFQoj8kI0s/FzQktl
	 nsJ5snxDrh3vN1Xc02JtETYycdlsDsV8l1De6z4wSB+uViqhH/kCiLQSahSfK6xTTEayW
	 y5jTfs8ov19E2SR3XKE/TGe2C1o6e6kSHaPGUtKiQFx3xuTZQKeB7+Bs/rDuV5unuQ1nK
	 O9WKawjLt1dgeFdmK1+7k1N2bIapPgJgpKpYKu/hDBstdvhegqv+ZSLric5Ae25PinJHG
	 ctSazjgJBfoxt97RGUFMCCrq2QZDxzhONQW5IrWrbak6UqebgZ3hYjQ7ALCKdLy6iKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999909;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZkqQpyyWgiCT7yM+GqqzrqW+e2YFFZpIluFHk3eQPZ0=;
	b=pebzMGwvxnr5mjpJNuiKH1cW3Mpg42oyOwaScV5IsSSVhZ6QKGXyy+/WWFs5kRMgb6lc
	 SmSqQcoeuxJK6eOXNOMQJ2DAJVuJgCtLM5n1WQS44Qxiwdto+piozzuvLGp8xFszSK/4Q
	 uB1ZDKDdczQtAVJah03yUXL+ACAdKYTAPtCH+zsmvKB29MAnEtyotsM8EgpYEuUqcGmOw
	 QlnRr7Dy9p2Hot9380UTMaRsjGMra5FXWg9PWkejcCigq7AnRkmkiUgE7jTnmovbsoXuS
	 uBrJha6eetu5Xieq6gngKUnT6fWpzC+3ATc4S09c4jH4FwN/KQ+ygfP6WSifn5Evk8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oa3hquin;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC13606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oa3hquin
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113131F01825;
	Mon, 26 Oct 2026 07:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792999908;
	bh=ZkqQpyyWgiCT7yM+GqqzrqW+e2YFFZpIluFHk3eQPZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Oa3hquin0ij2801hUnrC4cTmvA9l9ed8+ue1o6FW8TVNFEZNB2fhyNrg5b51Z3Chh
	 KHfQmmRPKGu3k1CY7BDtpuY7sA/sbsTZ0hmICskKuEGYvBrGph1KCcjYE/KICJda8x
	 kzKcRFLtDR1jx+ssq3F1hphltCWLg3oM0rrXk9e21PqaEKkfPJZ//VRM/Yd7hfdYiO
	 3GaA53yb7rdej0YSohAPs6AtUWmsWgHXto82dme/LkO37dO0W8/c1aciS+SHL9+Izr
	 p/cxYAcpoK7P7uc7jF+qtbkgG1bTfPtJHzGatBKHmqwWgb8nDKVERSOW8zaPQ9lW/I
	 PTDj7ZS2ZYGqQ==
Date: Mon, 26 Oct 2026 08:31:46 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Chad Monroe <chad@monroe.io>, SAYANTAN NANDY <sayantann11@gmail.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v4] net: airoha: keep PPE offload when NPU refuses
 flow stats
Message-ID: <at8B4YDW0-dL22QY@lore-desk>
References: <20261021100423.9159-1-sayantann11@gmail.com>
 <05adf618-f608-4c8e-a862-4c1d0779567c@lunn.ch>
 <J3XqO9fJOEvpsUH9m_DyrV8wgQzdtZdfhE8KZHv9ejvVty51zjizvG-0nmYn8ZhTGRJnLq0OcEbX7l3DvpqFp8dFEYuWYVpV5ZRKnGXmGKc=@monroe.io>
 <54711f8d-d71a-43f6-876c-d32f4c562b8d@lunn.ch>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0/0oVR3u5epgDrzE"
Content-Disposition: inline
In-Reply-To: <54711f8d-d71a-43f6-876c-d32f4c562b8d@lunn.ch>

--0/0oVR3u5epgDrzE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, Oct 25, 2026 at 03:25:28PM +0000, Chad Monroe wrote:
> > On Wednesday, October 21st, 2026 at 5:49 AM, Andrew Lunn <andrew@lunn.c=
h> wrote:
> >=20
> > > On Wed, Oct 21, 2026 at 03:34:23PM +0530, SAYANTAN NANDY wrote:
> > > > From: Chad Monroe <chad@monroe.io>
> > > >
> > > > With flow stats enabled, PPE offload setup requests flow statistics
> > > > from the NPU. If the running NPU firmware does not support flow
> > > > counters, the request fails and the current setup path aborts PPE
> > > > offload.
> > >=20
> > > Since this never worked, it is not a regression fix.
> > >=20
> > > Why not keep it KISS and report the firmware is too old and suggest
> > > the firmware is updated?
> > >=20
> > > Can the driver do the firmware upgrade?
> > >=20
> > >     Andrew
> > >=20
> >=20
> > Hi Andrew,
> >=20
> > The NPU firmware bin is downloaded at each boot and is present in
> > linux-firmware so no issue with keeping it up to date.
> >=20
> > The main reason for this change is to behave better when flags mismatch.
> > Previously, loading a driver compiled with flow stats support enabled
> > would silently fail to offload if the firmware didn't have support.
>=20
> Sayantan suggested this is a regression. It used to work, but does not
> now?
>=20
> We should avoid regressions.

I do not think this is a regression. In this case, the default behaviour is
just fall-back to sw flowtable acceleration.

@sayantan: can you please confirm?

Regards,
Lorenzo

>=20
>    Andrew

--0/0oVR3u5epgDrzE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCat8B4QAKCRA6cBh0uS2t
rHTpAP40CYiwB34cqilOMLaCbBIJ6v5uA2+axkwRM5T2R7mtRQEApnIIVLJYmOrt
ZebAaxUcBB1eKe39QGeFpe/hykg8Vgk=
=kHBZ
-----END PGP SIGNATURE-----

--0/0oVR3u5epgDrzE--
