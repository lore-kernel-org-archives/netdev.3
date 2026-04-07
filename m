Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD9B3C5DDC;
	Tue,  7 Apr 2026 15:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775577457; cv=none; b=thpGKMElCJNDhn5EJOdxAAk6tVynlbEJz3wWFe/+Ct/9WoeDd/3OK4jfi/s6G458OWxo+7Ybo2o5zIeUSeegAPnFZjj/EtEcL1SMpriiOWMEeCgV4kNfNj12fD2ouYXu8aS0/BKjsDS4xAfe5AY6VbgJ0QTQFig2ZlW21qEpGOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775577457; c=relaxed/simple;
	bh=Q6jkeV68gBj+bbwCQqz6W5xhDqLRfBYMRwoZJl4MTbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyvuLk2POM3PK2FovRFh5g5JVM6GPlRkBPTkRLJzCqeCLVrpsDH6hReJ+vu2jQeXPGxT0xGpAr4ho1zwg+/6oZi9dHEieNa/66IHA1JRwz6NksMybvs1EPog7PQVOzJVgNyV7ByzhfRi1623hUmCazgrZySea4FCL0tnTKDMnIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dyq9clb7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dyq9clb7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CD3C116C6;
	Tue,  7 Apr 2026 15:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775577456;
	bh=Q6jkeV68gBj+bbwCQqz6W5xhDqLRfBYMRwoZJl4MTbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dyq9clb74n7+rIb0YOcq0xI10TIpvmDb7Q7LS6x5S+W4d5PaNCUo9w2ZzZA8BzoRF
	 RvmABQ9iBs3JPb3R5MVro+cM3RZwR8x7Slu//1eKkSx8lqK9JqF+cUV1TuHZB5aLR+
	 FIYUP2Uuv6oltQaFxobPCwOZZI2qFmXGKUnfN+NaHO0OV7d+E+WPqx8pfTUBgcU8iG
	 FY/AJV8SvONI5dmiJyDCtpTIdy1l/dqpTG51exS+7IWXrQPxkY105o5T89aZI6gqtB
	 BF0YJK3qDWMF3La5jP9BiEC5t65fOKC0EIjjDICOlsp0SkAFS0qBu7YZmyvVE+DuKY
	 wBp+hsb5bUi9A==
Date: Tue, 7 Apr 2026 16:57:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: document Microchip
 PIC64-HPSC/HX MDIO controller
Message-ID: <20260407-ascend-lumpiness-bc665c0999b3@spud>
References: <20260331123858.1912449-1-charles.perry@microchip.com>
 <20260331123858.1912449-2-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Xi2f5YHnsDWPd1XD"
Content-Disposition: inline
In-Reply-To: <20260331123858.1912449-2-charles.perry@microchip.com>


--Xi2f5YHnsDWPd1XD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Xi2f5YHnsDWPd1XD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCadUpbAAKCRB4tDGHoIJi
0hyzAP9aT3+pQ/d4NI88rqiyuvoiRY1mt9X6CKEf3xKUm1VTygD+NnxkgYaeGnSJ
OgI4oG1FJz0Obonp66T/efUrQ448Rgk=
=fUJj
-----END PGP SIGNATURE-----

--Xi2f5YHnsDWPd1XD--
