Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8453A9014;
	Wed,  4 Feb 2026 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770228099; cv=none; b=rtmoMpAMU+tSPS6EyJ1DfUGWM/DfwYqFTDsq3gT2pN8d5nv58zgTybsMcwCSAt3IW1JDJCx+cdcb/r0DbnyLBS4gdAyJO+eDBcCrM52AGB7NLKDN1EdBsaRiBLC/YldSvm7wvBV16KTwAuUkjK2qUKDCULZuqd6akGbVdr/FeS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770228099; c=relaxed/simple;
	bh=FpvnuqSxLUf1evy8jLZA18ReZo8eTAElpTcRgazV1/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9gpXp5+eBl+Lp1zUzSsPbAdNzJxRJCvuFzVYkZ3bqmcU7jgzFBx7oVxzZ380SeB3hZ24DENYPdLxZiLhax2nldUCpTP1/eAF1TSGkkBAgWEblb/HKIu45se0frSdRLZ9NpbbCsKvMclYoNuDG4uGojZq45siq0aHZOgXCvBoqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjVchR9n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjVchR9n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01338C4CEF7;
	Wed,  4 Feb 2026 18:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770228099;
	bh=FpvnuqSxLUf1evy8jLZA18ReZo8eTAElpTcRgazV1/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jjVchR9nmsAOa3YGEvxoDmFN/fWrako2moa2rh6fQaB9IVukv4ZPZSLvLzwlIyIFN
	 DkjpiymtZDJ3uAhrPhR1rzTyB0JtAisYdqL2IlUY+e6lvQ3yBSGejmNtwK3UshOwkH
	 pllghlUaYQq3EGIdiaW798mmmRElXRM0HCIZc7R6cmmHCK8qVups51pqDn2STylNIS
	 T4ax2HNxKZ463fTLFzWKCF4JtT/rKLP9GLX4BCsNhCCbTvolrwJKuFQv+a2riAcE6t
	 ODfGD8cxDX1fgaqja8xTFL+uvLDLntY69a8h+3OdAW3awztm2JIS0dy5rl7B3E6DtW
	 SqPW7o0no0QPw==
Date: Wed, 4 Feb 2026 18:01:33 +0000
From: Conor Dooley <conor@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: renesas,rzv2h-gbeth: Document
 Renesas RZ/G3L RMII{tx,rx} clocks
Message-ID: <20260204-unroasted-obscurity-c3f5cde43036@spud>
References: <20260203104541.264759-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R84RhPBbHLhcO4T1"
Content-Disposition: inline
In-Reply-To: <20260203104541.264759-1-biju.das.jz@bp.renesas.com>


--R84RhPBbHLhcO4T1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

pw-bot: not-applicable

--R84RhPBbHLhcO4T1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaYOJfQAKCRB4tDGHoIJi
0n+xAP0Ynk+IZCwkCIDgJ4vDUtyzhOWXgd9iXUdDHos2vH66pQEAuB/EUCY5pkwI
xsVl3dE7jS12BWSVHazECvqrX2PF5QU=
=A/lR
-----END PGP SIGNATURE-----

--R84RhPBbHLhcO4T1--
