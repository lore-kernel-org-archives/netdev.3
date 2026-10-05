Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B54947728A;
	Mon,  5 Oct 2026 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791196802; cv=none; b=QVpwdohWaUrKkeEZsq62x8Ra7QftfSrIgjgz3bjg0iZHYJUD8q6k7d4NRmjsg/5hgwGGD4gmcqIi/tJt6wG3MY/RcbrCE9g+a1abMdw+ELtmri/lvoVgUPPJJ85NHH6oTpCdGuWGlS+t4Z44EjBM4g3waXVU3PNEDg9RaYopUJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791196802; c=relaxed/simple;
	bh=nMK/a6cWnmvDlye2LBu5j5oGE2wSUys+6jVH5716V10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8TgU7GkEQ6iDNjV4raFiBXZkO89FjKKYuF3QzWSoeZflc0q0L6pNGSgkyN9WRrTAWLHPg/Ce4Kex164eRfB6IlA4lq05LA9bUvzjIN/CzDnln8O37rMAIkGc6i2AZsSagd/rDbGt2FdZhCr51nM3UlYj73rfg3b+tARtyvibB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKuSy4G0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKuSy4G0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710861F00893;
	Mon,  5 Oct 2026 10:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791196798;
	bh=nMK/a6cWnmvDlye2LBu5j5oGE2wSUys+6jVH5716V10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gKuSy4G0Mnv9EWI5RFrLWNfQpP55o5UjiR6eXzW0p3HIBnTQA77MkfxfahjlLm+Tw
	 Y30HMkEAMQpbTnDrLrYyE87XglxHbjT7zEGWZsDLDYuzeX23zyadDlR2OumCEvhqkC
	 Bp+U81p5OGw+hK3jlGLdOrQ6frStfbM7zGAA539h0DKLyVEn9UtpMjUJbGDnGfBZMV
	 uPuAermznBjYpKdkzCopmYhX6B1Xt7ryCR+XS+XzJzFL2CSm0/ebe4LEIh4O81v634
	 mHlj6YiA5rRKlRlhfvUQ0iOi2CdY41/fO8qhn9eLS28gNm2XsPYLHnierVaQwM++d3
	 +JYL699chO7ow==
Date: Mon, 5 Oct 2026 11:39:52 +0100
From: Conor Dooley <conor@kernel.org>
To: Lucas Tanure <tanure@linux.com>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
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
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [RFC PATCH 1/6] dt-bindings: net: amlogic,meson-dwmac: spell out
 the compatible combinations
Message-ID: <asN-d_p6RUFfVHdE@squawk>
References: <20261004144046.391444-1-tanure@linux.com>
 <20261004144046.391444-2-tanure@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ATxczT9S6yADiUYP"
Content-Disposition: inline
In-Reply-To: <20261004144046.391444-2-tanure@linux.com>

--ATxczT9S6yADiUYP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--ATxczT9S6yADiUYP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasN+dwAKCRB4tDGHoIJi
0kGKAPkBwMPVmHK5gi5+GGmq50tiKHRI64sQpVCtLBiim0uKvwEA+im/zIRf96O+
sVDm/6scRn1Ei8lICBXZw/R/5hf23A4=
=Ico9
-----END PGP SIGNATURE-----

--ATxczT9S6yADiUYP--
