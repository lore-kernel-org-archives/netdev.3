Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A0C4DB55C;
	Thu,  9 Jul 2026 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783620546; cv=none; b=pJcBEp2ptUC5OgVNFlX+W1x/vM+05nYNevL7rtm5IOgp6bo3A+gzxfor9bCf8LCFa7Fdnd5JdlyBaqY5YZ6Xb04+CsFF6HshwRztQpEfxA781X9BUGUccsHAdWy1mnmPlPagA61XZNFWWRPUXjt7/LGAHkyZdo9PViKxXQzF9kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783620546; c=relaxed/simple;
	bh=RC4dFXUpiK7zo3TrhWTdwBiKShgDT9biBtzPE0SQoS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZF+ZNaBS1hhEySWChy0oGSgce59WctcRo9MbMdseMtclb6HR9jOUDxcOA4rxzkjf5W6kM6X+v3xH4drEduQajf9OVod5Ufoar9jOT041DLZMJzUJSuKNkq1HQENli6odvPOnFdB7pTIyRmbtsKPbILlDMuBMqlrayb8iDmdfRA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1ctp/7u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1ctp/7u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080291F000E9;
	Thu,  9 Jul 2026 18:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783620544;
	bh=RC4dFXUpiK7zo3TrhWTdwBiKShgDT9biBtzPE0SQoS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D1ctp/7uUgVHK4GnPdbF3/RieOXaOo1Zr1igsC3U6kzQmvjKIKE2UnyVfmvxp10+H
	 SneULOk8gyZSZWiRixeVCLjxHEWD9zV/fxW2OAvRlORrnOYVaybPS9BIWNqpfpH4kS
	 R++6auaejUqPx5rgnb4oTf70S76Qc+pcEfi4EZ3+oTJkV9fA1qEJtM1P5QPLSB9pHn
	 BcCOSBm1zp7tPgr5Psmi4K/C0bqAQTy4NDGOKo1oLuh3eGPr1n70w5iZyHqxNzvndQ
	 KjuaAcHpvP8LAb8OP2LrIIxGDsWInBpjTT8aGMcFkb4LXjvqkCqtnla3nJ6QxDRxMq
	 DXBH+/EISyGuA==
Date: Thu, 9 Jul 2026 19:08:59 +0100
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Chun-Jie Chen <chun-jie.chen@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Edward-JW Yang <edward-jw.yang@mediatek.com>,
	Richard Cochran <richardcochran@gmail.com>, kernel@collabora.com,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 02/18] dt-bindings: clock: mediatek: Make
 '#clock-cells' required for MT8192
Message-ID: <20260709-shredding-grazing-4e1d286bf757@spud>
References: <20260709-mt8189-clocks-system-base-v2-0-2926da3db6cf@collabora.com>
 <20260709-mt8189-clocks-system-base-v2-2-2926da3db6cf@collabora.com>
 <ff0f6f05-8445-459e-9c21-13f3dd57c4c4@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="139Ku04gQspMY2P7"
Content-Disposition: inline
In-Reply-To: <ff0f6f05-8445-459e-9c21-13f3dd57c4c4@collabora.com>

--139Ku04gQspMY2P7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--139Ku04gQspMY2P7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak/jugAKCRB4tDGHoIJi
0qVEAQD57WGPBqOiosO7weHjwHkaqI0Dl9kkt3RNV2IFULp7uwEApE1cVKg3j75f
LEWZkuD49qkWJDZD71eq8F2VvSLPVg4=
=hKj3
-----END PGP SIGNATURE-----

--139Ku04gQspMY2P7--
