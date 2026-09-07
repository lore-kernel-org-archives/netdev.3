Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD641385D8A;
	Mon,  7 Sep 2026 17:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788802261; cv=none; b=pTQspUrzo0EUV2+6COLZS5bo97CdKODxbrcKRnvAIQON/pqNllRto2sXfwQ0Jm0Cz2ZAnexoD4xIBv0sHcjlzKW5KggRd3KsgPFSmqHrClWx9yEUy/coMFaanEn2lIP7kQl8MaXjWwed0sjJVXfPNgJltGePmewXVqMuYWho+pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788802261; c=relaxed/simple;
	bh=L8PIowdyG2sfRIiF31YA3MxURGCDxl9fdkFgRZEHZOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEg/9jP8Q+Jh7r0puSLWndWNVgxo35xkIQNAiv1P9yy++AZC3JlfQrynNYuyhRXUs9yodPLeBa9hd+dcb9LIB1mjp/nwfrJzRSEpVLhbBuknfe2wY9geIRxNo1ZTaug0fyIhBSziPv54+iFPCVFGrrPyyHd3f2TKbCGf3z0fRAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4We90Ek; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4We90Ek"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F1D1F00A3A;
	Mon,  7 Sep 2026 17:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788802259;
	bh=L8PIowdyG2sfRIiF31YA3MxURGCDxl9fdkFgRZEHZOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C4We90EkASbZkkF/1kJRczUWx2qAAR2idbVg2mEWXxT86+6IzNcS/Wq3y1PQ+rCVl
	 23YbxgA3T6gakPQlGkpQG98HMTydF837iKSeR/JsKTCZ/09nnvyS7BzPk5KWFvnQXU
	 LSPc+jNju36kpPHHMjqqPa1GrY2RbnGIBZ40mUugIhWaTfwgAv6xx5qtXmx9vD+Q1i
	 5O28zdfIVpVbGOmvSfGHuche2SY2yLEoz+RL65wxns1sPbl9Qrq9EaGAl5DthHN86z
	 CGXOVpcWT2KEiM1Eux00fcCEodRJhtUIAlUsHrW9kB8HFEUXDiRcz4D1IGvgrw1pW3
	 JMULM+zQE2aWA==
Date: Mon, 7 Sep 2026 18:30:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] dt-bindings: net: realtek,rtl9301-mdio:
 Add clock-frequency
Message-ID: <20260907-frighten-shaping-74385c16738a@spud>
References: <20260906081946.3499898-1-markus.stockhausen@gmx.de>
 <20260906081946.3499898-2-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="49IqHlnHI/j+oNQ+"
Content-Disposition: inline
In-Reply-To: <20260906081946.3499898-2-markus.stockhausen@gmx.de>

--49IqHlnHI/j+oNQ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--49IqHlnHI/j+oNQ+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCap70zgAKCRB4tDGHoIJi
0k49AQDAd+UBLp5dZE1o35Zaw4RNypPG7/Dul/2Mfmk8XVWKVAD+KuQghdTASC+Z
a6/rSeMQVqqy5XYesJ//GY6dZCdZ7QI=
=r8u2
-----END PGP SIGNATURE-----

--49IqHlnHI/j+oNQ+--
