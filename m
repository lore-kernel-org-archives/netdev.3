Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B40F4DB577;
	Thu,  9 Jul 2026 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783620637; cv=none; b=LIUNo4sT86NWPtBCpxxRT6ACjDnrzjv4/O8bblIRJh/rtKN19fsPz6wKs4Dz9ThlXFsne4HiTWdRpb3gfQ7nbEXTFvmI3RaJWUMy4mSj083WFfaEaI+Ko48z5+T/4e4jPmMfIV2bMygf565DH18thcYHpwCcBU2iSL8wMBmq1Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783620637; c=relaxed/simple;
	bh=FrWbBDEoc866g3+8SUlo3dSt6RO2AeOgmBwijfYXZOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKpz/e3m2rrVJVVmixX0I0XIrTAGPKdBzdeZchLxz/muyBPavNLYZzCcScRMOXvdXQyCK8KWTcGC5zXNTehR7AP6qP9vN97PqlXY4k9j/zofpA+ZRnSH2xA3t3mBLaHKfQqw8U32+AnMTBkGGtV34WZgd9pW1Yt19rz6Yao0NmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwO7UAch; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwO7UAch"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED531F000E9;
	Thu,  9 Jul 2026 18:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783620635;
	bh=FrWbBDEoc866g3+8SUlo3dSt6RO2AeOgmBwijfYXZOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EwO7UAchh32VZo0y/l3KlmYkXl/BWw0kqFJzBwTZ8LuFLLxt9kQRlYy35zOu3j7Hc
	 90rMnP3MGKE+J5kXdFwJ8KXLcpe2pXZ8qQUjXeNvrZj1DSosrS4OnkbYcyqoSRZ3me
	 XsDii6AUvUWPFqwvhRx30ykA/slsXulB6QM5SHrGO2brU1ao5Xx1oqpRJqcuBQs+Ph
	 p0BkrZMbIIED5JAkn3jWj2Uryg4cvXNWfveya0WH+raIw5tPFmcPx0lQiWsxuOSYt4
	 3NjqseaBirOsXaj/d1Cle2TUOtaqEYiR4P8vrfczDQNWbI3VVNIyn6uMTX5e6K1daS
	 F3ZfwZ6iwU0rA==
Date: Thu, 9 Jul 2026 19:10:30 +0100
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
Subject: Re: [PATCH v2 06/18] dt-bindings: clock: mediatek: regroup MT8192
 dt-bindings into MT8186
Message-ID: <20260709-blog-spinal-97568987c6f7@spud>
References: <20260709-mt8189-clocks-system-base-v2-0-2926da3db6cf@collabora.com>
 <20260709-mt8189-clocks-system-base-v2-6-2926da3db6cf@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3KYFvTnjrsXTUUOw"
Content-Disposition: inline
In-Reply-To: <20260709-mt8189-clocks-system-base-v2-6-2926da3db6cf@collabora.com>

--3KYFvTnjrsXTUUOw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--3KYFvTnjrsXTUUOw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak/kFgAKCRB4tDGHoIJi
0qFKAP9A7FGdY/AeVCQME9FhWqYEIfTunaqJh3K5MW3DTRZFPAEA2VVw4IEkf6VB
bzUQ+A0RABfo6wyTiMTwJKdKWqTVyQk=
=JsA9
-----END PGP SIGNATURE-----

--3KYFvTnjrsXTUUOw--
