Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F163195FA;
	Wed, 24 Jun 2026 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782318964; cv=none; b=fgr5Jkq0S2Bub8P0E6p4MTPafBNqvwXVQhma/zA47kN2eJP1LeRHaluaKLzP0FkLVH7JCDEEHzbksSYxpCJBImNKZNKuN7UBe9h7ONKih7Yt5G3xMwNaRVjmcfFJbrhWL80j+bsiWoNMoZ/hUvggf/2Lpkuj8buFSr1/AKAL0GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782318964; c=relaxed/simple;
	bh=p08OngOsIzGr6ZhopN+/dY2mbYDLgnBM/tGzG5KMUsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rtn6vmCw4wqAg4cNnMO6cl6CurV0LAnMbLEsm8ZVcpEIhaImLArsZGGU1qyuq2E9fdjIam+XdeEig/AgmB2jeeCKat6rVhoZKjBmNiUkyyfr/yhVz+8TwBkBxs2NKtHFEiGfFHqbX6MK5jW+5No52W/7DkKb56B91nHueeqeKhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5oRNt7j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5oRNt7j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C5F1F000E9;
	Wed, 24 Jun 2026 16:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782318963;
	bh=p08OngOsIzGr6ZhopN+/dY2mbYDLgnBM/tGzG5KMUsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g5oRNt7jHwV1inO+CWVFbTML0PH7pCY4GZx5EU3nFW5GzHBwDchc0evlBpiLpu3qK
	 l1RBUCs/I2mM9q8yxPZg0bG8TW7v12+/Y/anReySyEL2baAGq5qVRxX648bPu6PYpR
	 zvp9ITsOETD9qlB8FqOPowI7eIuiIZuqedqYfwO+zPVv5EgIZ0F19RVOtPUmgBCVeV
	 HkRRgJ65iK1xZD0vNOZFaZFmikJz4VmI81r5Nj9vXnVVEF3oF649KdC+jPxW1UyaEQ
	 2MVueMq0P8vP51IbSZXnchOlXftFuV1fQdBoNWICA7e/Tc8pTGfVlvHarL5JWalOhg
	 A85BueHHww1yg==
Date: Wed, 24 Jun 2026 17:35:58 +0100
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Sergei Shtylyov <sergei.shtylyov@gmail.com>, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] dt-bindings: net: renesas,ether: Drop example
 "ethernet-phy-ieee802.3-c22" fallback
Message-ID: <20260624-navigator-candle-1c5beb80f86f@spud>
References: <20260624150250.131966-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/bmMDEtLuouUAJqo"
Content-Disposition: inline
In-Reply-To: <20260624150250.131966-2-robh@kernel.org>


--/bmMDEtLuouUAJqo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--/bmMDEtLuouUAJqo
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajwHbQAKCRB4tDGHoIJi
0la/AQCah45Q3RREHspmj82zTCeY0rS8vYHCdVEpQDgxSl8o6gEAlB/SpV9wcc90
zE2XuJetPcft0syPmsVSNmWkDLq+GQI=
=4Rx0
-----END PGP SIGNATURE-----

--/bmMDEtLuouUAJqo--
