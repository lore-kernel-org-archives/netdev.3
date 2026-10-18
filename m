Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB133D5227;
	Sun, 18 Oct 2026 19:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792352584; cv=none; b=IBY7CDg9ahST1EY59PYTg3dshyfgeI2RkZ7q8JW1MpK3uy67HiF0NWEJjaauVWjY4kTwpoHAizevR5yyr+rg8+egryczUwLs3XT6sv3/filWczoE5EHgs3n1km+6J4CLTo3VRwFxf39io32NbzYAHobsxyBjjmkfWy5i/Y+hGSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792352584; c=relaxed/simple;
	bh=K8OTffWF8ukjcWaybjMzefKafbzxl6mVnAd2P1r2qSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SE6eCUeW6MoqKNJf03+cOR6YvCK3fod8FFRu//tfC3MFtLdFDTA/hGPvWghOOSvfng7btBVkfc3hPHPOarqv2A5PW6oM+RmW19LTTNQ8c1mY5k2zzYEoktsAJHXFC/sCfphgR/vU42mzaVVeDCzeG8n+iAZEG6A3QsUlWTUIExk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzAjqaAM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzAjqaAM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7981F000C4;
	Sun, 18 Oct 2026 19:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792352583;
	bh=K8OTffWF8ukjcWaybjMzefKafbzxl6mVnAd2P1r2qSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hzAjqaAMeLVPzFPOoLoqvaFVyKVJzlDlMFVJDfGEeGwh/wjvubLhZKELRQinDAxLH
	 DpnKU/pjJD9DCNX/38GD11YaVhbjGYGz4n1j+SHAo0o3aLIH9GsUH0ef6q5r7bjfgb
	 GOpl2lBnU+BLjEB99/p0N+FvLJW1Fb9o6NIrnuRVXKs9+8CRWX4H9PmTh3SsSflaJe
	 NzAAvBbfFa7PAUmuoDxok7IOl9LCsV+v/jDT9L9TMLap6n4bIdyQbAr4PpekXhEyWH
	 VliMLSK/0EwlDFepHJT6rK3GzYzjdK7Q0EAqz4wC+acnMpMFsN3UrB1eAfuuPF7Sqp
	 mv6cBfmzbZcYQ==
Date: Sun, 18 Oct 2026 20:42:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Marek Vasut <marex@nabladev.com>
Cc: netdev@vger.kernel.org,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [net-next,PATCH 1/2] dt-bindings: net: enetc-mdio: Document
 optional MDC clock
Message-ID: <20261018-hug-disgrace-9554d903c8cd@spud>
References: <20261016193344.115518-1-marex@nabladev.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/BUjjasNvBLCNQUr"
Content-Disposition: inline
In-Reply-To: <20261016193344.115518-1-marex@nabladev.com>

--/BUjjasNvBLCNQUr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--/BUjjasNvBLCNQUr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCatUhPgAKCRB4tDGHoIJi
0mYUAP0cgpOV4cp2J5EY7SC64vT+TyNBYGE2nv1GcnKlTteVsgEAqwc0rEwEbpR7
1gHzLECDwo8gwL49yELw1MAfSVG5OA0=
=A5Rp
-----END PGP SIGNATURE-----

--/BUjjasNvBLCNQUr--
