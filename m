Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873B242F561;
	Tue,  3 Mar 2026 19:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772565194; cv=none; b=Ua1AOJJ7S8IYlYH3d7QqLftKaCmHspbnGDQyMIS01DFea33acLGeT8GUvxdOY34RNwpxdPoNiCinVVGH/4xt6Yhy/URuWfzluNwDVLA/Ohy+syRagK2L2r4D/clEpX75UkDmW0qGrtxtS03Wv1vpXUcMavydzVyXnTdWK3sYagE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772565194; c=relaxed/simple;
	bh=cR7ZEZR1ts1oh+Qn+17y+H61HqM51AguxcfSw/UYuj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/jlnBEiUFMZWyT4VKKo16UkKyqsPPutDzW4I9ZIdSZhfPAYbIueG585pOF763QQjjq+dtDkJ6LPb5RDT5SplBwkgnXIZaSFCWJI8uukY1jrLhAj5D1zLyXdzTMeJm78sfPbMiQkdp8tvHBDXZrctyfgAgfgIUsI+sFpIhwQXlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h94fw9cq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h94fw9cq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFD0C116C6;
	Tue,  3 Mar 2026 19:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772565194;
	bh=cR7ZEZR1ts1oh+Qn+17y+H61HqM51AguxcfSw/UYuj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h94fw9cqynOlX2gCieVr6ETgd/Z8Ghx6E+xRSm1Cep5hCmz515ypnLTJD4CisWoiz
	 r0PVPW+ed3N0gIkJ/UuXTdptKsZVCZOnhhTPceO9Tiz8GrmZTuld+5bk1rwhoZnDAR
	 SiOOwyn9GuVWENOtK75Xvu6u2eKVeaMnRYzv+HCgX/pHNiHBjdAPM1eqIsUj8GZq5O
	 EwuHcYcGUk7See4dIJFMjpjeZfS5Y3yKEXv0BjMj/zBbpBWo0qAxQWsFrNKfx6wOdY
	 2lVqD/XZnphFqg0clZyfl+1QBmWVcZr8l6Iax33cBeljNA2ZzFgQ9BbUfOw9PTwur7
	 R9cvT6ONxzmEw==
Date: Tue, 3 Mar 2026 19:13:09 +0000
From: Conor Dooley <conor@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: dsa: maxlinear,mxl862xx:
 remove port label
Message-ID: <20260303-reason-eardrum-d8302e526ad1@spud>
References: <61579de297eb636ec5f1e6c97d453e26abb0625d.1772507210.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GzJ25F81MaS8SRm/"
Content-Disposition: inline
In-Reply-To: <61579de297eb636ec5f1e6c97d453e26abb0625d.1772507210.git.daniel@makrotopia.org>


--GzJ25F81MaS8SRm/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--GzJ25F81MaS8SRm/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaacyxQAKCRB4tDGHoIJi
0qZQAQDanFw4f1nC65AUVvYQ2mfqAfdpih42V0yx4h9VnBn2dwD/Tr9ZaFNY8fjT
bIp9kjZlsuNjYP6ceFdnZj9rVOTOjwU=
=Hs3d
-----END PGP SIGNATURE-----

--GzJ25F81MaS8SRm/--
