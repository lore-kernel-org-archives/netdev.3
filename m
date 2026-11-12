Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509009;
	b=4hzurxkjYONbmgsRhAvejajHDQ1l3DxXNkr98swZstY6POTw2pP+Cep0FccaGiGA5C6M
	 u0HeKR1Gp4beGOHE3McVPSsmu9oeI7Kn/zBPznKTN5wbRHHvVfxv8p6UBj/4Vd88xpbjV
	 Y7Y727AOf9NRUqpCViuPKbYnWVSBJjE7w+HP9oOmI/bD+iTXAwA046Mt/GQoXRzRu1Mbh
	 cvG2NvLtuQOq5oKjgUDesOhnFrLn/52Ab6TDBg07Iz25lxjf6z9d7VN+bmAiLOQ/pr1qZ
	 wlIGt0dHYFsKzJS6wYccmQ/KaEtv/4YUkEy2oCaJ3IYq2PXLs4eJbkKh//B1ZVoyqYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509009;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=K3jINJbXagm7pk5poQR4eaIKdthChjYFUssmD4XyBs4=;
	b=exuQdH/cxD56qB4Jypd3BBW2t0JqnaCK6OiKK+MBm+xvDEJRsTSTa1IHYQKzI1/8ZB4J
	 QxO0KxFb0zNNiNR1MC27/y9/6qBq12S4Nta5gwlMxqORdpuK6z+/1tW8iiqtGfv2OJtiP
	 sQd4OcODfD5wM8j/NEehvTgs8MyvpI9M9i773g2SWhp8EYUXiMF3yTNHw9yVNu9t15Bnt
	 oVILmVQJJ8WK/T0skpMHzUcXNzCrQEShY9EAFWVQOut60ig1vpV9a5sY08FNpc5QCHu43
	 8AsApQbNClwkMp6HjZ9POlF+DgBU9pzyTqRsKI6oCBokZBzgbIfv30WgbdReAyuPpuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cz4sZ8ac;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB9B606A323;
	Thu, 12 Nov 2026 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cz4sZ8ac
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D19F1F000C4;
	Thu, 12 Nov 2026 18:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794509008;
	bh=K3jINJbXagm7pk5poQR4eaIKdthChjYFUssmD4XyBs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cz4sZ8acG5s/A1CazMR23RMRxGOUZ2tVK5tGirt4BeYiTWjcuHtpuHUnl3m1Hehpl
	 Xvf1URIeYwbi5KTMsNNwBY9/TDeZ518NBg92fOwRze+FOc85P8Jim7uks+PF2m3Ea7
	 ymTnblkQ378IWDDJmX6VRG5E0eyhMrlVj/YnADXV5RakPZR6jVMICki3NDA4OtZdMP
	 v6wuABMcbUt53xwALsiFfi2xeYpB5jGUkqFLFglDMHs/3QXI7ODakI7sYM+SxMwksW
	 2hpMXF5ha6EIzrMKS+cWwvTUCAG4pcMMyPEtmbKOQp0vtfsWnAi+C2ow3Apq6QhFp3
	 8jtoKGKUwSrOg==
Date: Thu, 12 Nov 2026 18:43:24 +0000
From: Conor Dooley <conor@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 1/7] dt-bindings: net: ftgmac100: Make Aspeed
 compatibles standalone
Message-ID: <20261112-facecloth-ripcord-d13122ddccc5@spud>
References: <20261112-support_ast2700-v6-0-238020bf46cf@aspeedtech.com>
 <20261112-support_ast2700-v6-1-238020bf46cf@aspeedtech.com>
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
	protocol="application/pgp-signature"; boundary="jVuB0edZYjw/CuNy"
Content-Disposition: inline
In-Reply-To: <20261112-support_ast2700-v6-1-238020bf46cf@aspeedtech.com>

--jVuB0edZYjw/CuNy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--jVuB0edZYjw/CuNy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavYIywAKCRB4tDGHoIJi
0tSuAP4lu0a5v7IG06eX+Y/5l3XZ6nxwkC6LWLvY7ub+PusogQEAkz/c4ZWIvEGg
ywPNF4CAXlWup3wK2n38UnoNwoj8GQ8=
=SQ/g
-----END PGP SIGNATURE-----

--jVuB0edZYjw/CuNy--
