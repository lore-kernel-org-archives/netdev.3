Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D196131716E;
	Wed, 24 Jun 2026 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782319061; cv=none; b=rlnT/IspMzwrt0tXlWs7rFAlIsmEwSJm1IZncse21wYP3Z7ABoOZCdmdACiZop7DeaM5JQ0VUsODeFmJnG7YAxs/wxMJUcOxmJEOahuR5j2/tnetuXbS6h1JngmUYqYEvABUUMFvxRSbbSqypOv3e8UfdUPgwsUCTq4tUrZPxL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782319061; c=relaxed/simple;
	bh=SyfHu/I2XIYsJdezOUmVizfnPBrz+gMGazU/SwA/7p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZV6g9FBwGmrIjlD9XAyjfrQiPASoEBeOZik8CibFeKVxvoceS6UTbf+3p3faHf4VXjcGfWjjHhgyI/2mwTyRXj9cJbBLDNTDMexs+OEo3Oh8cDH2vtsRoEoL2RwWR5xyaSvIFQ7ZR5pbhhxaZN72bTX/TC5GHdWD0bSoMdMsGw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozhULR+v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozhULR+v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519681F00A3A;
	Wed, 24 Jun 2026 16:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782319060;
	bh=SyfHu/I2XIYsJdezOUmVizfnPBrz+gMGazU/SwA/7p0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ozhULR+v+tD/EkyTxdaXnoHIxjSg2eEDAx2Fb3JzrUPKQSUCuaLW9ryVA1/TT4YRL
	 t3oAm1wuAaYkPl083ZmrCaNNycX6mrrEJsfKI6XkgQ+MLCXcVKTKDNZRHxvmh/Y5CG
	 UDTdmjmN6k26engKIkk5nWYK4uqYLBrYODRhRliIgknc7F7mFPHfyKHtnC9Q+v1nHK
	 e61/0PUA6BL4edyh7IsFB5pjbj6jEeZQnCLSkwAn2fZUTkSW2wcISKoK0iPlFtboB0
	 A71iuN6NTG7RnI62xhptpGQ5zGbxYrmGmsr7AB5emgy0pRqYHunZIRxgNY3B1D25ma
	 YybFPgObmMnpA==
Date: Wed, 24 Jun 2026 17:37:35 +0100
From: Conor Dooley <conor@kernel.org>
To: Yanan He <grumpycat921013@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wu <david.wu@rock-chips.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 2/7] dt-bindings: arm: rockchip: Add Alientek DLRV1126
Message-ID: <20260624-catering-hacksaw-5f5bbe02dec5@spud>
References: <20260624-rv1126-alientek-dlrv1126-v1-0-5aef608a3f64@gmail.com>
 <20260624-rv1126-alientek-dlrv1126-v1-2-5aef608a3f64@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7R3iGmzIl153QvNt"
Content-Disposition: inline
In-Reply-To: <20260624-rv1126-alientek-dlrv1126-v1-2-5aef608a3f64@gmail.com>


--7R3iGmzIl153QvNt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--7R3iGmzIl153QvNt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajwHzwAKCRB4tDGHoIJi
0hN+AP4pHYjmTYkx8NmigTz4jNMzRk/K1+zEkTRcxRZH3NYuzgEAvcdfNlPvw9o/
FbZgTWC2paNK/w1CV6+u3VrqW6MGuws=
=IXtP
-----END PGP SIGNATURE-----

--7R3iGmzIl153QvNt--
