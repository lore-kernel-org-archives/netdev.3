Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509045;
	b=mrMDzcefhCoOjUQcdXmbfy4UemazK/RYO1fS/VQfR+E8VciWm48lAQDcwALG1wwkNTlz
	 cs1MVGqRizHoELeJwrVXYVt5zVLEo6U7CLTJw9LlnZUu1N4Wg3NEMYBNM+aM1ZCcsP0Sd
	 m2lbzwxH6jRbYtgNFEgURX4J8f8cuGwSAKqbwnHIxEu2d8G1W9BbDMf+QVDxABe0/NI3U
	 iN3fNaTS0A84DAzDBZeKL7+7hC47Mt6SHYh8WFYL1oXzdBSWsykGYmlkzUDS9rUsK3JVJ
	 oK59xVXgPLgNxYPZypcjY6ER7xPJStN2Kkht66EoT5/jKlm8VmDlX22t4+19aKE7QjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509045;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=owFPJjDiBOIr0EZRPXWh0VOet08LKtJmKvKcAOdrVq8=;
	b=5E4c5MXue+ZnThDY498qH8rBNpA5H57gziPiUNMzmqWKYJ/u2s5828ieSPYx23OZNGvN
	 H7X8MutN9ti8VS4/NQyPa22HHKb594f0o3kP7I/F1fPu22gMrNvQIuSD9pcW8W2AsvyUk
	 qm6R9HLpyYVaH+InU0QZNTF+0lKGrocWu/w+SEPTWeOX87Nd+brUFxbtJ7CxH35Ji5ps2
	 LSKtpmgI9ANpJNLBLhsucC3PplyPSe9WhFxQrAWMYgLKiwpOGUv7tTAbD+LnF1qTxqeK8
	 81pTCPn+8vqVnMSB26E+fCFrm7qXhJp4OeMCGlCXyJwWNAqVZlg3AKcEDt15a/54I6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vb5KGS4B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA76606A31C;
	Thu, 12 Nov 2026 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vb5KGS4B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746F31F000C4;
	Thu, 12 Nov 2026 18:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794509045;
	bh=owFPJjDiBOIr0EZRPXWh0VOet08LKtJmKvKcAOdrVq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vb5KGS4BtFjLBJL2R2zVH9oK1yzWuk1JGKIRWQd3OkWozMQNQOYyBYb9mKvwD5USj
	 ZDPCEqPkgM+x39Z4PGnktEurWdAze8yelvPJuUfVmBhesoatmyDrwp62unaJNFRqK6
	 xpwwKPnFLYiRVWpn06apQ/GYQISpzErrjkQz+v2CdaKT2XgUcM2Bnipb26VvIAQepw
	 H9K6YyHS1KcflI99rCdFmuzBRviuFq0F/bAjsHExAofSYdsyVq5EXe/szT2TbTN63V
	 QYjyz2jhr5+kw+10IQOhRbaQN5KWHS562N7whPgImiANvRUNz3WJkL/Hh/JC2wnf+7
	 DPtwgxk8WRBYQ==
Date: Thu, 12 Nov 2026 18:44:00 +0000
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
Subject: Re: [PATCH net-next v6 2/7] dt-bindings: net: ftgmac100: Add AST2700
 compatible
Message-ID: <20261112-arrogant-antiquely-77c013508b29@spud>
References: <20261112-support_ast2700-v6-0-238020bf46cf@aspeedtech.com>
 <20261112-support_ast2700-v6-2-238020bf46cf@aspeedtech.com>
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
	protocol="application/pgp-signature"; boundary="qpPGlio1JxtLAtZO"
Content-Disposition: inline
In-Reply-To: <20261112-support_ast2700-v6-2-238020bf46cf@aspeedtech.com>

--qpPGlio1JxtLAtZO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>


--qpPGlio1JxtLAtZO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavYI8AAKCRB4tDGHoIJi
0vr2AP4sOtTorC+jwEeyyigVpLcM6dPRSsk2YeQme1HB5AdjlgEAwoUKft2WKvE+
0e5MpqDiqglY7bToRZEbSgFOh8sovgc=
=nttl
-----END PGP SIGNATURE-----

--qpPGlio1JxtLAtZO--
