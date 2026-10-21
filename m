Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601316;
	b=Sq5DXw/fHCrvhxuk6ROUikb9uB16pv75FHv4n5yYi/qV86VdagqsLS6+AzehEUvcAl8O
	 hlwbsECqaKCY6XRb0Ft8YmYd075WHnedJVuMY6IG8CD/GU9K7fYhJj76Eu4IitltK6nwn
	 zuba3Xjs1heW0bQCDTFKVMtfWJvFj2hxRWYbAW48id+rK6JJYRU6Tdd4aqFz9zjS2BlnZ
	 lqemERSIL6h/btgmZbsEgc2DQUHqZFqtZHNN5gaAROhwdQpdHFkcNE6D+knGjdy0OpN8U
	 dNH/M6xaVvf9mOOCGwvvFdush9Xy/QTjOJvRJp3hr37GtO9w520C0R9u5U3kgiDADbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601316;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9Ut8c+AZuSz932GtggMAvxx5Mv2G1n5Wb+a4bDunPnY=;
	b=aih+fUPiuoJ2xTFix4rjfIZlVjpnOyYne9b4VWSqce+CPDR4AZMgeALO8Wsf9fPI89sj
	 KGoFsBTC77rp3Jhu97pnSpQUoaOZvPVQhB4yWYTEODXr7933hIoFwk0AB9UjCzLGqZ+kK
	 47GXO3lAdnqBPrKNz1MIX6iI5dk5uaEpXPtUA1y20awiiYciWbBmpiCm7GEx5+fFZ5mnB
	 XXQqqfeywqTPlLgHrPeTxHrlRg+FytwY5GBX6sE/xFZH2VsbbwEdrXxJv4DbjxXuDAv/R
	 p1iViTRujCgl51NhOqKokxzcoYTK8wRpNwl0Ih1/StxJttOQzakSsvQJxRLz1gLsXag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H7jASWXJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B19C606A319;
	Wed, 21 Oct 2026 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H7jASWXJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9651F000C1;
	Wed, 21 Oct 2026 16:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792601315;
	bh=9Ut8c+AZuSz932GtggMAvxx5Mv2G1n5Wb+a4bDunPnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H7jASWXJYxQ4hb4kaSVYl1bH/F8jjVE/z66upPmBE9mhvahtR0JcieefGCapbvyFY
	 7CLdjFtkc2a8Yz+7llAD8Hi/Z/G71yo07YRiry/spOeXALQnOU6okOnhrtSYHLQFT/
	 NF+6sn+09NKKaj9aXGVWtf7sJA8b+05sqV5o5QeTbs94HaxEkS1FUS9nQxbjdg5wC/
	 Nua7eacxO792+7UsjysfULdn0Qgme+4zhhali8ZkxBRp0UoM7VcgG2GoUORhtJeeZI
	 ESN+kcfKTeAh92Ap79KCrk6EEIOI00z1+RuTaDMGTW9Ks7/K328EMnURLnisocBLlT
	 N5xMwOCPugFPw==
Date: Wed, 21 Oct 2026 17:48:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Jacky Chou <jacky_chou@aspeedtech.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/7] dt-bindings: net: ftgmac100: Make Aspeed
 compatibles standalone
Message-ID: <20261021-hedge-fiscally-9d2988325ed0@spud>
References: <20261020-support_ast2700-v4-0-4d36b40939b3@aspeedtech.com>
 <20261020-support_ast2700-v4-1-4d36b40939b3@aspeedtech.com>
 <20261020181441.GA510274-robh@kernel.org>
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
	protocol="application/pgp-signature"; boundary="yHehAASBh68+XO8o"
Content-Disposition: inline
In-Reply-To: <20261020181441.GA510274-robh@kernel.org>

--yHehAASBh68+XO8o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 01:14:41PM -0500, Rob Herring wrote:
> On Tue, Oct 20, 2026 at 07:34:12PM +0800, Jacky Chou wrote:
> > The aspeed,ast2400-mac, aspeed,ast2500-mac, and aspeed,ast2600-mac
> > compatibles are currently only valid when paired with the generic
> > "faraday,ftgmac100" fallback: if a node ever bound through the
> > generic entry alone, ftgmac100_probe() would set
> > rxdes0_edorr_mask/txdes0_edotr_mask to BIT(15) instead of the Aspeed
> > BIT(30), skip Aspeed clock setup, and leave the DMA mask too narrow.
> >=20
> > Make each of them a standalone compatible instead, so none of the
> > Aspeed compatibles require the generic fallback alongside them.
> >=20
> > Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> >=20
> > ---
> > ftgmac100_of_match[] has had dedicated entries for AST2400, AST2500,
> > and AST2600 since commit 03a2aba50b2c ("net: ftgmac100: List all
> > compatibles"), so there is no known kernel + devicetree combination
> > where a node has actually bound through the generic entry and gotten
> > the wrong EDORR bit. This part is a binding correctness fix, not a fix
> > for an observed failure.
> >=20
> > Note that arch/arm/boot/dts/aspeed/aspeed-g4.dtsi, aspeed-g5.dtsi, and
> > aspeed-g6.dtsi still declare their MAC nodes with the two-string
> > "aspeed,astXXXX-mac", "faraday,ftgmac100" compatible, so this will make
> > dtbs_check warn against those files until the redundant fallback
> > compatible is dropped there as well. That .dtsi change will be sent as
> > a separate series through the Aspeed/arm-soc tree, since dt-bindings
> > changes don't go through that tree.
>=20
> No. This just creates unnecessary warnings even if only temporary.
>=20
> What a driver uses doesn't matter. That can evolve over time, but that=20
> doesn't mean we change the DT schema.

The reason I suggested changing this is because the device used as a
fallback compatible is apparently not actually compatible at all and
were it to be used the device would malfunction.
The original code (from 2016) only worked because it checked the machine
compatible and slightly later on matched on the ftgmac compatible but
then explicitly checked for "ast2400-mac" etc using
of_device_is_compatible().

If you don't want the current stuff deleted, then at the very least it
should be marked deprecated and the standalone aspeed compatible stuff
added alongside it.

--yHehAASBh68+XO8o
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCatjs3wAKCRB4tDGHoIJi
0iQVAP0d7Qt2pc38bsMe7twK7g/vPpMDjTATJMUxmCwKoQ8g7gEA4M6fAgsHYsgt
qzMyDs7hUcuLTRYcZT17iHeP2I8w9AU=
=v2Uv
-----END PGP SIGNATURE-----

--yHehAASBh68+XO8o--
