Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72B8434E44;
	Mon,  6 Jul 2026 16:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357169; cv=none; b=Wnpgsejvu2w4N95Lo2zC2MxRzgVIyXKwdMgUDkVlmSsLfr9pPfwJWfYTWf1W/I/S0fUJZtzGqZNV8ByEIpzy/RdQ1czYfM3+gWM1f+46HWuZn7iYnGGIVfnhOG00+hvO9wLpJ5EjX1T+IvSEN/JwT35K57bncQm3CBbfDFANt/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357169; c=relaxed/simple;
	bh=Eij9NN45WHadIIGng5xyGjgH3Ez+ECAyMwLT2E7r2vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4OkinEwPeCVtkRIWuQFT7kVwXKtv1Uri0tQZTNKSSHgp4dDb/n4KwNuisZH9uAAwGPtmTakvxk7cm/sRsYNxbdUl4zNdyD0YOZe2ViyogRcaMqrWILJNacwiPb7i2DvZ7yean673nUBvYklle7I/iHRVjno57Zh9D7Sf5SRxN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tthd+//5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tthd+//5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B62F1F000E9;
	Mon,  6 Jul 2026 16:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783357166;
	bh=Eij9NN45WHadIIGng5xyGjgH3Ez+ECAyMwLT2E7r2vI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tthd+//5QgLILAIfB0QHO6lE41MLDOU/r3L8hwfmH0olc6rLxrZWLnodbJtvF+3hL
	 lONKGvsrpCVW3fdUlriEmaNn8iByl6R0iXdB+hj1fU15bvNoyptacRs999/J+HSXah
	 w73yTP5yQgp0NnP5ztPs9VdXKZMtNVqmROruFsOsGT6lwFdsBZl3Ynr3l7rHdOqGxy
	 9AzO3IqKXO/jFN+mvfjrHxq/hpNrzyM3zB5zRCriy5XL66kQVb3WLnMWpghWYF2hWY
	 mUfMXPS6uVqb80iy/ZlLi1V1eKSBWccVAZTUvW+ZL0fPVRYb+WHFJbiIPGwfLetQp8
	 pNdFaNyn/iMtw==
Date: Mon, 6 Jul 2026 17:59:20 +0100
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
	Frank <Frank.Sae@motor-comm.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 2/5] dt-bindings: arm: rockchip: Add Alientek DLRV1126
Message-ID: <20260706-quickness-paradox-2ddd7328fa86@spud>
References: <20260706-rv1126-alientek-dlrv1126-v2-0-ff3176ca362b@gmail.com>
 <20260706-rv1126-alientek-dlrv1126-v2-2-ff3176ca362b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U1flhJ3EtlV9yrdK"
Content-Disposition: inline
In-Reply-To: <20260706-rv1126-alientek-dlrv1126-v2-2-ff3176ca362b@gmail.com>

--U1flhJ3EtlV9yrdK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--U1flhJ3EtlV9yrdK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakve5wAKCRB4tDGHoIJi
0klkAQDRoPqv3BY5GD0PHqXAy86oOarOTHzm12zfsS7VHsKg2gEAwSFbwlMYUfLW
PYYq6cTfP88NVHtb4MWFRQaHkvWc+Qs=
=5jfH
-----END PGP SIGNATURE-----

--U1flhJ3EtlV9yrdK--
