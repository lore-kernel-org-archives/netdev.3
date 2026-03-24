Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2011940759B;
	Tue, 24 Mar 2026 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374221; cv=none; b=oKJCdt7xcYUnRI6cHXJjQpBRIM5KB0ZME0dVadIQM0lJOrjNzz87NrBA5c+bo/x/5pwi2oDOTj51c0spnuXiFMCsUgYbjoVZOJw87dg3u1wUzHnatofjplD4IsMJ11rSQ7zPP4uVeuPO6/tFOfRA98MZKLzwsg+DHYik+e2M2m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374221; c=relaxed/simple;
	bh=x0A2EBPOCbbbBE+krLjw8biQKVDzGTXdjm43j+QGjoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tADWd/X0IHg17UtV1eMFUVH2sbd/VCjxJy7aAW3aPYiWQACH1CDhdl3AnqsOC5gJEdfYkQHONZhBMhNxVXUivN3BU4rko+QpyE6Qx5MgTZ/YBTYShDysqeUGJF0rPbKXXJvlXAvxjvDRLCJmjTn5NoMyLVkOobApFWFhT+IIEZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPGsrbpO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPGsrbpO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738FFC19424;
	Tue, 24 Mar 2026 17:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774374220;
	bh=x0A2EBPOCbbbBE+krLjw8biQKVDzGTXdjm43j+QGjoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gPGsrbpOBQ7mYpAAe2gj2rcJMV9g+o/YGciUJbP3EpOEQTRFiY0TcbegVgFi2Q/iN
	 oy5eZ671x4gFd5bJA/qQhMdBEZLM7tmnWLEgjpjVf4UrHMCxLNrEMWa7vIXXPF5VTe
	 egkzxRLOLpxnpdGLwwCzbAwbUjtozmE6VF9vwGEsn5rwlSay7OuqccAEuB8+vWlyX7
	 yCWOHFIOiHK6QI5L75fSL0PA/Oi1lMGxuzdKTWGnw4J8mBPR/CAli7h5DnosGADiYb
	 iuMaUDU1H2KndHwFxVMLlNbwy31jJbW3Gm5o/jb2vGR0yIR/kHhZzf+/y6OdHOnvjq
	 +6NLylCrjry6Q==
Date: Tue, 24 Mar 2026 17:43:35 +0000
From: Conor Dooley <conor@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH net-next 2/2] dt-bindings: remove unimplemented AXI
 snps,kbbe snps,mb and snps,rb
Message-ID: <20260324-lustiness-contest-8b576dbb24c3@spud>
References: <acJh4z3pRKkeaFbR@shell.armlinux.org.uk>
 <E1w4ydt-0000000Dlph-3WvI@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rQa+yvbosfZFTy1W"
Content-Disposition: inline
In-Reply-To: <E1w4ydt-0000000Dlph-3WvI@rmk-PC.armlinux.org.uk>


--rQa+yvbosfZFTy1W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 10:05:45AM +0000, Russell King (Oracle) wrote:
> Remove the AXI snps,kbbe snps,mb and snps,rb properties as they have
> not been used, and although the driver parses these, the code hasn't
> ever used the parsed result. This parsing has now been removed.
>=20
> These were introduced by commit afea03656add ("stmmac: rework DMA bus
> setting and introduce new platform AXI structure").
>=20
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--rQa+yvbosfZFTy1W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCacLNQQAKCRB4tDGHoIJi
0kc0AQD8Fdqu9e8zpFe52VG7zrmCtL+z47MkS5ZSvp1U2lhQmwEAgx0GK1qbgkQW
5E9TdD4nGRoAcgomDUF8g8DK8XIrnwk=
=486U
-----END PGP SIGNATURE-----

--rQa+yvbosfZFTy1W--
