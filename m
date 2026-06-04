Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674053AFCE8;
	Thu,  4 Jun 2026 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780591179; cv=none; b=dSc5KYMUIld31SCGxcKWBwMPXaKmKJxAM9H6oDfQ2JSJW9MRLhap5q00lvul5vjH6ihGCOGIt/XdCJ2U81bZrVbktJAF3imIkl3YtoknrK+2hFY8P3bOS0BXl+1hIS9SMcv/XJHiesDv9v///vPr2mMc4c3Lu1THY/KInqZPZYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780591179; c=relaxed/simple;
	bh=c37l7/my8PeBcqolj2D0YxpepY2LnMLvvONRHTXMPyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GB0hkgex74G9EjFSw1IOMH6AYLGDWDsSxe3Okr6kUHr6ukW9qJ5bQwR8HlRTlZ5XAziMS/8ya6f0FV2KjVsi6P5LY/TXtOIZKnC0/S/2ZDNpqgeg2R9y1UY7KCwNRgFw63DAy67FmtTwzIGqv5SHXIRhGPN4sb/kpFMuXA8YZgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OA9vIs9p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OA9vIs9p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9201F00898;
	Thu,  4 Jun 2026 16:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780591178;
	bh=4KZsy5obdlZxh/b5c8a6JTkwwxyP0LH4cSc0OEXfIcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OA9vIs9pIPYZ7nlFvWVaT0sGcqXPSIgkM2xGgElld8VamNpZ9SWpPbOaiIvTUw//C
	 mOEePXq14cPfzDO6knZ2uIzRGROV2bLUhxff5SbEiGjCgmU3C/Cha/QcCxXp7P52j7
	 yeRTrRKXS8H4izNPyd/Pfd2ORkg2+lERfq2atgAhmlpT3ChXBeMLwbv3JAjraMAhqH
	 ahDErjcLn/98KqHLtxsavHeK5T3qOr0TlEOQYEtQ8eMX53VLYqellTqyRokNwPYy+x
	 TklmwBAiXsabTvpzBc9OhuW2hwEWbz62Mn8CCGFQS/o9e45aGjCIir8lKFtpDyOgc/
	 R4bW96XyA3Ghw==
Date: Thu, 4 Jun 2026 17:39:32 +0100
From: Conor Dooley <conor@kernel.org>
To: ciprian.regus@analog.com
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 01/13] dt-bindings: net: Add ADIN1140
Message-ID: <20260604-devoutly-registry-6564d8cd3ed8@spud>
References: <20260604-adin1140-driver-v3-0-5debdb3173c4@analog.com>
 <20260604-adin1140-driver-v3-1-5debdb3173c4@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wPqzZuWB6wYVv20r"
Content-Disposition: inline
In-Reply-To: <20260604-adin1140-driver-v3-1-5debdb3173c4@analog.com>


--wPqzZuWB6wYVv20r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2026 at 07:32:46PM +0300, Ciprian Regus via B4 Relay wrote:
> From: Ciprian Regus <ciprian.regus@analog.com>
>=20
> The ADIN1140 is a single port 10BASE-T1S Ethernet controller that
> includes both the MAC and a PHY in the same package.
>=20
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
>=20
> ---
> v3 changelog:
>  - set adi,ad3306 as a fallback compatible.
> v2 changelog:
>  - Reorder the compatible entries in the dt schema (ad3306, adin1140).
>  - Removed "dt-bindings" from the commit title and message.
>  - Updated the DT example to use IRQ_TYPE_LEVEL_LOW instead of
>    IRQ_TYPE_EDGE_FALLING for the interrupt trigger condition.
>  - "implements" -> "tries to implement" in the description.
>  - Removed the MAINTAINERS entry, as it will be added in a later patch
>    in the series.
>  - Reordered as the first patch of the series
> ---
>  .../devicetree/bindings/net/adi,adin1140.yaml      | 71 ++++++++++++++++=
++++++

File should probably be named after the fallback compatible, but
otherwise this looks okay.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--wPqzZuWB6wYVv20r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiGqRAAKCRB4tDGHoIJi
0hSnAP40G5o4GiXBt3J2g0xEBk1CvhYU08hklJOuK6koHHrslgD/Y+cm6b3gd+wh
ER0xd3SqY21oFM3je23FnyAEqrFgrQE=
=sJ8C
-----END PGP SIGNATURE-----

--wPqzZuWB6wYVv20r--
