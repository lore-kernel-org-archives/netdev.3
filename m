Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590640;
	b=H5q9I7ZaQDMyZVlGg4uDBts0HzFZUxEiEzfkBglx8Q2NolkSdJhaHEyfZEkCcZLiKsSk
	 Ro3BI3rV6lFdQ7py0faA7Y6sdBPhFPWntC3CXF+QeJRYktsZ1UBbZRUH6fJI6LxaBtXDy
	 LNKBrXFHexADP0RYkDoS/gerxryx/QuT/M0dC0eey0u94R6jA5rrYRjMWIYDpMFw8qwB6
	 dwzwkgHcdH1Rhh7+2aqfQ3zd0htnWmiLEn/ydmdqipuEmiRSWUOHOAZPhmIWnXjNs3CDu
	 s+tJYcpmZtpqleYVMQnbERIIvYdqWHLB5Hlx6nwLe9eSYooI6LuxbRYIQCGHNzI9oHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590640;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=adh14FNJnxyZlCwx/5qZKrQt9MD7OCgMuw3pQDZOl98=;
	b=2szx5bohfHZB/H1ujmd4lyZNI4cNtvLKXMipa5MQWguCb5q210Xmkvq2A/bKb03VpbJK
	 svlZ7cVCfAJsMJC+mxIpqPL+t3W8DsElD+amjvqgpYJTL/uUwAOumMldX44ADo/kDGDTA
	 NrgL+AOojhost+T643bqu92wStkD5Rb9leW7QSz+ryIIjjl1p75OCt9patFL4amTC/3fq
	 eNCi8OEBkY54a7hK2Oi/SdYuJ/7k0MnMagENQkFOmYDf7Mtk/COW2eeE1WaYWWdYSRNjW
	 nQ/cnwbpj/LjSdlb53wG9/Z925PXhAwxrKRRWY9eDQ8S2eNG02bpDA9/BM7UMyKt9MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kvVyrwhh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851C96076FB0;
	Fri, 13 Nov 2026 17:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kvVyrwhh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F191F000C5;
	Fri, 13 Nov 2026 17:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794590640;
	bh=adh14FNJnxyZlCwx/5qZKrQt9MD7OCgMuw3pQDZOl98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kvVyrwhhjHN++G2USFnXxwmIWpWKpBMkU9F+YZWySwVF5+y2MtOmrDQf64twFdN07
	 IqMN/xPkP93sxdu97bjN6eIlvybfWfyYrc8hrcywBJMR6t+HLz5B2T4h34ObYoMEmQ
	 1Y+ZixOzoksmaRjimU6M+2DtgeQhx8Xf0Vg03wdWBDDACXdJfw2+JPRjoNHo37CxOS
	 TVvSqp/z/z709Dk7w4UGkRUuhKjUoDPXK6AwhCQ3Mul9jMH6FitiJcpXx5yNDxCuMO
	 BitRRGblA/1l66ypYfNenxn+aHY2+HNLqwZCizRfayE2ksoE1jfU/gi1PNIMpORv6e
	 gwqPMKDwe34wQ==
Date: Fri, 13 Nov 2026 17:23:54 +0000
From: Conor Dooley <conor@kernel.org>
To: John Crispin <john@phrozen.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	devicetree@vger.kernel.org, lei.dong@airoha.com,
	Linqi.zhang@airoha.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Rajeev.kumar@airoha.com,
	upstream@airoha.com, Weifeng.xu@airoha.com,
	zhengping.zhang@airoha.com
Subject: Re: [PATCH net-next] dt-bindings: net: airoha: add AN7589 MDIO
 controller
Message-ID: <20261113-snowman-mosaic-429425fe9bf3@spud>
References: <20261112190928.1318743-1-john@phrozen.org>
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
	protocol="application/pgp-signature"; boundary="LaveC2wcX/zNZ4tD"
Content-Disposition: inline
In-Reply-To: <20261112190928.1318743-1-john@phrozen.org>

--LaveC2wcX/zNZ4tD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--LaveC2wcX/zNZ4tD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavdHqgAKCRB4tDGHoIJi
0tpnAP9yAFlYqwDm7yxaqDfyZRlXlw8+nCFPcF/jQZgD5ClffwD7BlqYknPKbQYr
80C9yL0KANz2RmKCiSuqoeHdwPhjyw0=
=QahQ
-----END PGP SIGNATURE-----

--LaveC2wcX/zNZ4tD--
