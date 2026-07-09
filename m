Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8CB4DB564;
	Thu,  9 Jul 2026 18:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783620614; cv=none; b=mEMrikuXfir/rxAl4H6G/nojWXNFXJfCv0OWMTLS0/Rrw5Ks0HZxtQYO2qaebUUtNblbS13v/t0hCANxuVg96/dMGTkBOm8KGXYfs3QCsucE8JWrVMGSz+UdduaqDJnzGAEk5LM9tJWYGO+aG5aAYzzyBziEi8bac+maMdWziyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783620614; c=relaxed/simple;
	bh=C6PQf2y5Qv4g44uRJ/wG5ruzypMHaXwLqkCv56hTL6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0uWzYogHY1IoQsMmayxQb1QXepMnslLZAyIbNet9t3knTvUgYMEdaIHYpEZs4euKoEcHd+PZnW/i3n2j07DaaXn/NTfzfBmtVyYXbs1sIzItXHoVNiSFVFHJW49yHNQnupFDHQHaOYIOtH4M038paDfiD2rRFGYjic2lsADPDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i97JtjWI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i97JtjWI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C661F000E9;
	Thu,  9 Jul 2026 18:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783620613;
	bh=C6PQf2y5Qv4g44uRJ/wG5ruzypMHaXwLqkCv56hTL6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i97JtjWIvqzKIgHZoHPIE+VQkT2BBMxw+X6LbOxcJ36VJIONwIT3qpf4oUU6IV1Fi
	 +D9r13STFjclAIxE7Wsy/tAYGDQ4K05Qz0fnFrFjwX4YzqWVTf41HQovzAEOTGxqsS
	 OUHl0cUArPj+0XxXUfBsmHHjT96c8UeKdhrxobyu6TmfWjsWRaUwDaiikHkSkGGTWz
	 WkkSPTtLX3XTnqXgsUREG5dpmU+Hg1IaLpUJatQmTCgimJ5qGANLmzTtikBgDuO2Qe
	 mxH+ElkVpbxG9tpWie9wsziXqbTukFT1q3237Mv4JPOpZzIDauFkrbSP7n6RKcAviC
	 TloJFeELUoa7w==
Date: Thu, 9 Jul 2026 19:10:07 +0100
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
Subject: Re: [PATCH v2 05/18] dt-bindings: clock: mediatek: regroup MT8188
 dt-bindings into MT8186
Message-ID: <20260709-override-rewrite-48251672afdf@spud>
References: <20260709-mt8189-clocks-system-base-v2-0-2926da3db6cf@collabora.com>
 <20260709-mt8189-clocks-system-base-v2-5-2926da3db6cf@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j4vhD4k303por5KI"
Content-Disposition: inline
In-Reply-To: <20260709-mt8189-clocks-system-base-v2-5-2926da3db6cf@collabora.com>

--j4vhD4k303por5KI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--j4vhD4k303por5KI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak/j/wAKCRB4tDGHoIJi
0n2jAP4s8lBU+Exb6BMBsaz65X58KXjVIAJoV2XHfk/fVhoVHAD/dQwM4CgClpDZ
XxoJZdpRcKFPa48HJv89L9ZoDYjdEAk=
=RRLm
-----END PGP SIGNATURE-----

--j4vhD4k303por5KI--
