Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFE43876B3;
	Thu,  9 Jul 2026 18:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783620566; cv=none; b=hFkMJ72uKCZo+2KG/xgvlDIK9+FJM6l6ksZydDNVxBfkW+rV3ilgBioWh3RaWR0OugLjUyDKV1bMkzv6Y0RJ1WATkmnF8M9vj2rAtFsQqmDPFdB4tf3FMxooFhbxgOYu42bXV4/HHAwKEuD1mgKy5e5fZV8hNDA8oPtKxY+liTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783620566; c=relaxed/simple;
	bh=Ze/dU7lIxz0YbuvYACCPCGptl+b5eVnohGNYV4Zx84c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fawq1OHtTeB5VbwXFLSRM+g3Rx8mfE0SNO8fB2FVXPc0XYLZJkvsAMeMmZvAULXaoWbfvGiRqp3ykpvdzu92CIZBP7SdKs6FMdNn5YGhlpw7Je1itO8+Oy+rLBktBVOg9IOlI1bQYeJPjbeNq7CTyLob3nLCzV9AvU7h+gPoWrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byQZpKWO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byQZpKWO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F4D1F000E9;
	Thu,  9 Jul 2026 18:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783620565;
	bh=Ze/dU7lIxz0YbuvYACCPCGptl+b5eVnohGNYV4Zx84c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=byQZpKWOWOXC8jsXvs/Rd5wbQFaFMDFee1Iq7Xc+RR25iEI7kneuRCVyGLiOVusAj
	 R7L09Axv42/DtIrZTS59wFbDL5TPYQqYFte9j3sdCcPu4qIXfOvQGVXhnTUEGNOd1d
	 2JTs87t47eLybWbRhNRV6zd9pqtAflFRVkc0AbsZKBlZivrH9vj7eOJTHpwzvD2F13
	 wdpIIDUpWqc5T0/zc8ZiN4pKZYHE8ae/hYST/FcBMGSnvsRsRTW2q6DIKs0U0ocfJA
	 l9rTxAIrSVINGIhANBG+Ox88u7n8qZoclhyCpokJruMQaWZesze2neuXUMAXlQ4pXJ
	 5WnGIZ/6hqtRw==
Date: Thu, 9 Jul 2026 19:09:20 +0100
From: Conor Dooley <conor@kernel.org>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chun-Jie Chen <chun-jie.chen@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Edward-JW Yang <edward-jw.yang@mediatek.com>,
	Richard Cochran <richardcochran@gmail.com>, kernel@collabora.com,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 03/18] dt-bindings: clock: mediatek: Make
 '#clock-cells' required for MT8195
Message-ID: <20260709-familiar-distant-38af3e72f7f8@spud>
References: <20260709-mt8189-clocks-system-base-v2-0-2926da3db6cf@collabora.com>
 <20260709-mt8189-clocks-system-base-v2-3-2926da3db6cf@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rhzPqCATrtdnBBrk"
Content-Disposition: inline
In-Reply-To: <20260709-mt8189-clocks-system-base-v2-3-2926da3db6cf@collabora.com>

--rhzPqCATrtdnBBrk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--rhzPqCATrtdnBBrk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak/jzwAKCRB4tDGHoIJi
0s08AQCKHuySJ3hIGlX3rdoD3nEJOe9Txe83YsBNGh/SsC+U4gEAuiXFAYt+//TG
2C8nsmJS/6EsGEcPD+ob+FeI6gHXnQQ=
=RPVg
-----END PGP SIGNATURE-----

--rhzPqCATrtdnBBrk--
