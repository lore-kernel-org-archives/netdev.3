Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8234DB577;
	Thu,  9 Jul 2026 18:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783620665; cv=none; b=G0GIKoD5P+fHDSq/o9ciCyt2pK/KS1TIGL+1g2/8kKUyCv7DhXicF8oW8wj3CSMXLdUWtdDKe860GohXmfE9oTMICowE8PI5gSvauceY9hodzao2QPmpMzrIvN5QHTZekFbUALG4k1aLSDOhUTIHBdiwn7LuorML/KqhKndI03A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783620665; c=relaxed/simple;
	bh=vB0GjRE3khfQCo9AeS5CukoIBpeitQMqkEW+W4frlb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nm4OvGgEAN+r1YeIoKFzLWXYbT7msj+4q4ZSELMy2R/qhtYargNofkjpaUmpSdvRuqSWti4ru5ebUoWtdMN0dVnKYo7x5t5WjSXQOuohAQi264FQGf9D4+DgzmnZVUfHSy4ZIC8fLM0kooIh7Gewb0FbaJh0lTZwID54woaz8bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1el/Cqy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1el/Cqy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C148E1F000E9;
	Thu,  9 Jul 2026 18:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783620664;
	bh=vB0GjRE3khfQCo9AeS5CukoIBpeitQMqkEW+W4frlb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L1el/Cqyibv9h7w/wdz/XpKMp+O4cUtBcrtayeWy3yBQtz/yXexEo5WvkUbweKm2i
	 n8CveZ27popz0BfRvIWP75WuNPvkOScndWUWMaXOZqVbyKgVmf0u7ux8oaCObXkiEH
	 jbEI6RKW0GpTSz6EFsryQvZC0dvvt+QvO/k56Xp5alnQmIKOS4Mp6ewKxBWo5c/1vk
	 WxZCUlHDDcShLZlAxtpsVdDD2qEt1bF7grpCHXAodmpSM8INX8HqNmDWGpTYxZeqDS
	 izlDK6V7AYvg9CW/w4RL92+cpjZrYlTZlEZnoUamTs0DR0mVzTQtukZs+dDoaya3M/
	 ixBkyURreK+Xg==
Date: Thu, 9 Jul 2026 19:10:58 +0100
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
Subject: Re: [PATCH v2 07/18] dt-bindings: clock: mediatek: regroup MT8195
 dt-bindings into MT8186
Message-ID: <20260709-unwell-tigress-75bda15cf97f@spud>
References: <20260709-mt8189-clocks-system-base-v2-0-2926da3db6cf@collabora.com>
 <20260709-mt8189-clocks-system-base-v2-7-2926da3db6cf@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YOyYCkfYLtSJJ1sW"
Content-Disposition: inline
In-Reply-To: <20260709-mt8189-clocks-system-base-v2-7-2926da3db6cf@collabora.com>

--YOyYCkfYLtSJJ1sW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--YOyYCkfYLtSJJ1sW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak/kMgAKCRB4tDGHoIJi
0n4RAP4npZum5XLpd0EsHYWmc4hcy2hHK2ABwRM4HAGsi+yHGwEA7LZVZIA1cxgk
OVcQXpO3gCi195JR54o1Z51wMc46Xgw=
=pOIq
-----END PGP SIGNATURE-----

--YOyYCkfYLtSJJ1sW--
