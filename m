Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590101;
	b=re+2zk9T5iiAAXrQ/mJBwJAvIDzuuBr+sToMOb8v761somU/muKu3Qdq+mhYBJYX2hMB
	 6bqH2NqRcvaauWjV0aCNplh7Y7wq66f/YNWAtDrg191Pto1MsEi2d1tbDvc8ls7wsOjie
	 rliZSnWqrJBRWG2V16gEPwy1Zjja8UD+aUFA3LM4ntA8sN2ePias8AcQMZDublWydlYYA
	 a+idkI25R22ysLz8cXmk5wTI7xcOeEH788L4zC+jsld9FGYwi1k0OXvf7RNTXodcTevYq
	 Bd8s6IG+5EPksWecuXE1C8a+nksDjD6gXpiKLnmDiMOjYR8gf1TabDnrhZswjnOoz8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590101;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1suJMfr4F2t+hvLEf/eqvweGBr12R4RYJ9ohUXZMmLQ=;
	b=3w34QZIEpVMHaxD2aLScvSisLV0p36uwNs7SbY4b9HhOA7Kzy/l9OZLiU9v3KOX0rtLv
	 4l4Uro+BL+uWm4IxCw2vanpuJNjO7+TxFzX+oaEdMCJcg06P5mvhsKx5ZvNLYfwxM4mWl
	 xK2f4QVfnDi7rJUq1GeWrdrUrCSY9BFDhOTE8mV6pxHI328sCow2JmFLWr/HOopE12Stz
	 T/0kAW6dM0+yodapiZr46bI6xf64IUPKNdcaY5pe1RTaF6Y3rfu3zD0NsuWEVMhOj7qr5
	 uZukeice7vCFObVu5LWVYj42AIO1X7THspz2U4OyJhLcXFXe6V8btzWYzTPo/d+Z9Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K+G53xRS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B0460A2635;
	Fri, 13 Nov 2026 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K+G53xRS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE6D1F000C4;
	Fri, 13 Nov 2026 17:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794590101;
	bh=1suJMfr4F2t+hvLEf/eqvweGBr12R4RYJ9ohUXZMmLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K+G53xRSt8vDf6/x/l3LPjRGhF5omdp/pkv805gZbqnCe+Upy/fEqej9LIoLRdbPJ
	 /nOLeWFABGHPoNdRgJwqooL/MmPecQBEz+bMZ7V++L2Tne5kYqrIxTANG0vKtVwv6P
	 wNTGd7Rp4FC4jYxpC0Tgd/GwGTsHDEqnwV44JgLiu1zEz0QZZeHT1WcxRRavSYFxS3
	 EdCKfUgokXaR0RjcDOSkrzUMRr39pcOoGI/UkkG+H1mNo8al9Fp7ahMRbfUSqaFW34
	 YVYkUHXsjcbamC8vAlS84fx1DwCL0+U5WrxxPNeewpO79OQR1hFo8W4qV+XtJed9tY
	 LOunxBwh6Py/A==
Date: Fri, 13 Nov 2026 17:14:55 +0000
From: Conor Dooley <conor@kernel.org>
To: Lucas Tanure <tanure@linux.com>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/7] dt-bindings: net: add amlogic,t7-dwmac
Message-ID: <20261113-headband-resistant-354bae47c2b2@spud>
References: <20261113121852.334604-1-tanure@linux.com>
 <20261113121852.334604-3-tanure@linux.com>
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
	protocol="application/pgp-signature"; boundary="LpKzrxi3dFo/IMea"
Content-Disposition: inline
In-Reply-To: <20261113121852.334604-3-tanure@linux.com>

--LpKzrxi3dFo/IMea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--LpKzrxi3dFo/IMea
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavdFjwAKCRB4tDGHoIJi
0iKAAQD8cRe2UwvrgIAurM7gqjc5GRJvmH08nxT23alr7Ij1fgD/XhJ/l3gmDO8e
WxfYr9fWD1PaIuMhdEbBltsE/3a4gAo=
=4R2d
-----END PGP SIGNATURE-----

--LpKzrxi3dFo/IMea--
