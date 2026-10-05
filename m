Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC1147988B;
	Mon,  5 Oct 2026 10:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791197807; cv=none; b=Jn/FQLOUeAgmp+WEsOFJRsY1XNzd2berJ8b38IKS5+vNJ+HFHIOgVBYfGpEscfanJdw8ladijB0q+EzQU6VH5MkAwkDQP+UaA6UgZcoXIhaN+9NLZwQMmi/uFDFqQJKNWrmymc2qVaZJ6w1eATwS7YidaNQp6GRelUgwHoXk24U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791197807; c=relaxed/simple;
	bh=jlcunSRQuDUQowPZfMLV5EMkuRNkZTtKEeH1hBFCOiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7xGWIOrnQcanvwB9Zw+Hgf1UFBseRWFxcX0tzqjrb5hdoUChG69u6k4LQD1fVAmXQpm+IsgIwpQsRtGBJIxz0nzAVfRc50y6jaS1wvAhm8eLkLxQTZjs7F8jP8zo4+wJZvZmqgPC/EHb0lno6OgqieCiBJ1c4iAkdeUcpyLn/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+E9k1V3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+E9k1V3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661791F00893;
	Mon,  5 Oct 2026 10:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791197802;
	bh=jlcunSRQuDUQowPZfMLV5EMkuRNkZTtKEeH1hBFCOiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d+E9k1V36bZCKMj3RZbR4iklsfWfpjSGb6Cf+pkS56cr8jYMcmuHwoSLwrkRRCqL1
	 rn9oiI/tRj8dbz1VAi8Why922bjHrt9WbN3ls5UkWFwlyDIzBe6R2mWl1adbiyCIoc
	 6reBf24vGeumMqvRgRoW6MHdLidFhT/OQvjjy3wWkfPvSRXFhe39ldwFcduW3D2+UM
	 tqcWT7fcuUniyVvxl8SOGlOkqn91jBpjjsQf2MZtRa7IDnf10vTxF1WvGpXOZCPp8H
	 a93GTqY+7ezMVAaj9mnUHlmEbiJ0l8Z/o17lyTq5RvfUcORqZR0Kd7Zu91E90rKlmq
	 sX14vdcucLl9w==
Date: Mon, 5 Oct 2026 11:56:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/5] dt-bindings: net: realtek,rtl9301-mdio:
 restrict MDIO buses by family
Message-ID: <asOCZI1KbnJuTZPQ@squawk>
References: <20261005074908.1273383-1-markus.stockhausen@gmx.de>
 <20261005074908.1273383-2-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r2KZbg701LWHCM1G"
Content-Disposition: inline
In-Reply-To: <20261005074908.1273383-2-markus.stockhausen@gmx.de>

--r2KZbg701LWHCM1G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--r2KZbg701LWHCM1G
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasOCZAAKCRB4tDGHoIJi
0sG2AQD7rw3VvQYfphRyM2QveO418KAeHkadKu7x7tVlaTVSbwD/Q7DB5Dn2FQaR
lJhjVFYuU08VsGgyVQ2RxnUDcU9RpQg=
=NUgj
-----END PGP SIGNATURE-----

--r2KZbg701LWHCM1G--
