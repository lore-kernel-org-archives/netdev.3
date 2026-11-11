Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420040;
	b=oRcbooKhqoad3Y/1E6sT9k3gw3BpxFn4rFFE4iABkvyP5F4XZHgcTB1RA88y7QQGMflv
	 w4/kyhYPD/nVmird0FyXWFqhfD7aGIIbIUEGDipwgVGjvLhEG2b9n4Q69lLV2CrO4s1X7
	 i5TJSDy0AEOApdz/NJaLV7OH5BX8JjLLkgRJLizUzeTLcKoavoUhNCcrtrByuQ61snqCQ
	 ht4aI2gdGo3comsx11DAbatsuW3e9VKE/0D0zXasZPAOuHTcqB6sciYM8xxU29GTUbSv8
	 tGdXB1KWuVKuxPJ9s8H6aIWoZnL0Vg/GdtnUv8U+uo9whwLlMpOSTk6nFfHO+tVHarw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420040;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IfqxjrYK+5b6SwLDSCdGV5c3D1FWDwIXDLxmgwwKJjk=;
	b=dwoDVp7JDNYEUzs91/QjxmRTzpruFC01BTLYM8+3Oh41YVfzn8FgvUuq1oDoBuSQVl/6
	 PosVugbc/BLKWx0v9NJ6xBMHst51XEzED2XplawhBYhzg6JIGdR9AYY0WzLPuM8LWCBCD
	 U+KxxExzP1ihvscHXN59Vcbo5rMLDJS7QCduixu8MKbULD3+B3B3RsVsFM9L0ow7dJAOg
	 qCYdilNJNaHfXx9QkD9vlApEbpD6/fx3Uw44i0tEkIpxFiK+LYusoCZ8L62ZBtQ9rITA1
	 fmKEovCKAywgfqgRA3GhB2pn6CJViGtRjn0RIUJ3KWSlmAyM9B2E2eYA6Cuach/baPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="DY/bh9cF";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3EA606A88F;
	Wed, 11 Nov 2026 18:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DY/bh9cF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9B71F00A05;
	Wed, 11 Nov 2026 18:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794420039;
	bh=IfqxjrYK+5b6SwLDSCdGV5c3D1FWDwIXDLxmgwwKJjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DY/bh9cF3vhr8ka1oYjorFAP23L5hOTFCFuWyMSBy0jJ7Z3rTfHuQR477/xfLz05k
	 7eGMM4/cO6H71FNh+yjBGPD0oEU6n4v4jVUvbZdD4iRsy7eXCf4wmq5hcapskZbJqy
	 AlvGXeeQ8NT2/0U7lVOuiwQU9RbDs7JobTOmYh37LiXH8QnrPbUIg2Bp2iBdcyG0JE
	 cdbsdXPLqri3hXiQBkNYrSnW5RBDObLSNSlmU7KGQQwpMY+X0joCLlw3OyG7hXMb63
	 dEgTrqgkzVh7048xeWcHoTNaLMI78cJalP4lv3kwnWQX1OmMtp/0Z9NKM4wExOKWJt
	 zoZ1VnC72ntzQ==
Date: Wed, 11 Nov 2026 18:00:33 +0000
From: Conor Dooley <conor@kernel.org>
To: 1579567540@qq.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	David Wu <david.wu@rock-chips.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: rockchip-dwmac: Add
 RK3572
Message-ID: <20261111-sprinkled-kinswoman-9dae5d8040c6@spud>
References: <20261111-add-board-ok3572-c-net-v2-0-304466394970@qq.com>
 <20261111-add-board-ok3572-c-net-v2-1-304466394970@qq.com>
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
	protocol="application/pgp-signature"; boundary="2kouTlog9XyxYE8J"
Content-Disposition: inline
In-Reply-To: <20261111-add-board-ok3572-c-net-v2-1-304466394970@qq.com>

--2kouTlog9XyxYE8J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--2kouTlog9XyxYE8J
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavStQQAKCRB4tDGHoIJi
0sWOAQCtxEQyPEIYrZQIMO9/45cDtSBZcJdG7Pcx0xqdgKv9bQD7Bk7YHrFee3MG
+kKbj7wQGVXcJV+Re8bAYp//6kEvzgI=
=+Ani
-----END PGP SIGNATURE-----

--2kouTlog9XyxYE8J--
