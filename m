Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C87C4657F1;
	Thu,  9 Jul 2026 18:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783620588; cv=none; b=ACnYtHX/wtvTcV+1R9t3LfiJNFsm1vCFo3Wh6KiUndTLpT7rJKJteS/8wWHYrlYt5rnBPQw7ofkmR8XEknjJZN7Hur+FdUWs7jyDzscZImYlLNQ3PLYB1KVnTrjgDZ+p1nHCUYI26/z+K6qrqfH0vI9ynMQR+iHx7bG+rs+yQHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783620588; c=relaxed/simple;
	bh=puo2WOGFGpyw9J6olKx24es2WTiZU3XCpw4qMf/hVOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHiB1i4PyMCgkdveyhKUwPF9KcpwHxn7SpnxbbLzSR9Dj2Z5XaxS7yHGGOAmZ6OIjE31t1ZjKYeOsvzO0J2nNlwNlQC2UP9QNP7wOhgMwI7hhLdKhVOrLix8ixgZxsBKZ2aO+g4MlokFCO+MIMSpEk4kdmFzFTEhLCqQkM2/H1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3rT5KC4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3rT5KC4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327941F000E9;
	Thu,  9 Jul 2026 18:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783620586;
	bh=puo2WOGFGpyw9J6olKx24es2WTiZU3XCpw4qMf/hVOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g3rT5KC4/pKsv+zL6v+2NnYTwzlryPMajIcRxphgS2l5V88M9bSyIjC5SLDLCIpMW
	 58cMeFbNxz5uQVEmx/Fq10wBvQPyJCZyoT2THvbJ3SkduWL8QPfvHPvqIEkoRQDEK2
	 LpW6cNCxYzPs9s5BBMGoQZ1INteYUM/nluobeMn5e/cXGq0LK4o6WxUROYelcdHKCD
	 U3CuvqLrSgrheoZeo0pgoPqEAezj0OCrIyJrL4HSjJi78Hp0cfShvwZPxf1GCT7BSS
	 rVnxn60ajOEaC+p19Cgo8UAkmhc5UXljPjySVPocMEYV25t6ICgS6/sPTi1hhpPks7
	 SP4mzcs3k8zdg==
Date: Thu, 9 Jul 2026 19:09:41 +0100
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
Subject: Re: [PATCH v2 04/18] dt-bindings: clock: mediatek: reorder MT8186
 compatibles
Message-ID: <20260709-ankle-motor-0a58b8d2e3de@spud>
References: <20260709-mt8189-clocks-system-base-v2-0-2926da3db6cf@collabora.com>
 <20260709-mt8189-clocks-system-base-v2-4-2926da3db6cf@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c/mtJweQrXU+gOHH"
Content-Disposition: inline
In-Reply-To: <20260709-mt8189-clocks-system-base-v2-4-2926da3db6cf@collabora.com>

--c/mtJweQrXU+gOHH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--c/mtJweQrXU+gOHH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak/j5QAKCRB4tDGHoIJi
0sunAPwP4G5IpcKdB+ivZ5OP/6n1Y9Fv4f2bnedCL1UQiUiEMwEA4I6r62j9MDDN
IHJwkxck/G74FFB8UdU2rapilCCtCwA=
=pKTX
-----END PGP SIGNATURE-----

--c/mtJweQrXU+gOHH--
