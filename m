Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4392FFDE3;
	Fri, 10 Apr 2026 07:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806634; cv=none; b=IZAasSqDsyd/4t69B4JkNCocXFNORo/WecxtPL+qYdLqD+/aqrNp6Zet+HVGjzBOOeLoK28h8NFvdZ1JsCdloZlm0T1YzLW+vqPIS5mIbVeEaqKuhlqzRdUBfkZ9LBNmsw1eYEVmwWXFMoPBHuskQ+hwnSfooTJrC2uriZIoDLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806634; c=relaxed/simple;
	bh=L+afuylxddCzC0qlWKdr8ONiPG74QuiVnL53Ek0mUU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/WL8dhTx+v/gnqpXZ6EXxNdLdDF8yAKds6/2nt/aYOgFMQW1bsO3TTTT8+xKo9GBdxDcuGSm+dopxUBUyYtVY3a9z60erMP9Gu8gO9G1a2DLYN/QltR3PlZr9wgwXfn7E1KWVejNzcU5ge5kOhPRZ1PZ7w8+c2gni354+F4xfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W58v/jDC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W58v/jDC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94982C2BCB1;
	Fri, 10 Apr 2026 07:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775806634;
	bh=L+afuylxddCzC0qlWKdr8ONiPG74QuiVnL53Ek0mUU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W58v/jDCVmzbiO8lRxEyIcpgoP32tZO4PNUn8ztkh4iNldj9YSNYz8goQA43ylEzb
	 uyiFmdjODWRke/cKBQq97+3gWycaGn5vHV/NoQrJmfLMxo8EoG8fU+YBGfwr0CQh/M
	 VZMwFopLcpUnpwb03e6Al+mZhXauWjqugObkCK/k3cSneie+QMU6302lQ2kJcm/2r+
	 I0K+2fZK0zymB4xPUCB6o8U5+/6LC3fDjoPA8EU9JwYGv66H0wNwKFlEKF3D5lR/Rv
	 cAFMC6oUyt6yLJVmKTNYOJB+6sRtN9DrMYsrHofbLKVg1w3sRDlZ9rASGdk7KDSlnq
	 kvJv2lIL0Q58A==
Date: Fri, 10 Apr 2026 09:37:11 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, Xuegang Lu <xuegang.lu@airoha.com>
Subject: Re: [PATCH net-next v3 00/12] net: airoha: Support multiple
 net_devices connected to the same GDM port
Message-ID: <adiop-9Mo4ADfvfw@lore-desk>
References: <20260406-airoha-eth-multi-serdes-v3-0-ab6ea49d59ff@kernel.org>
 <20260409195950.74e4bc97@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NmDR2XRCUQIi1brc"
Content-Disposition: inline
In-Reply-To: <20260409195950.74e4bc97@kernel.org>


--NmDR2XRCUQIi1brc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 06 Apr 2026 12:34:05 +0200 Lorenzo Bianconi wrote:
> > EN7581 or AN7583 SoCs support connecting multiple external SerDes (e.g.
> > Ethernet or USB SerDes) to GDM3 or GDM4 ports via a hw arbiter that
> > manages the traffic in a TDM manner. As a result multiple net_devices c=
an
> > connect to the same GDM{3,4} port and there is a theoretical "1:n"
> > relation between GDM ports and net_devices.
>=20
> Looks like this driver uses page pool.
> If you're sharing the same page pool across multiple netdevs
> it must not be linked to a netdev.

are you referring to slow.netdev pointer? If so, this is not set in airoha_=
eth
driver.

Regards,
Lorenzo

--NmDR2XRCUQIi1brc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCadiopwAKCRA6cBh0uS2t
rCpsAQCwzG/SFe7EZ5FhdmGC1hKji7gkM+WgbUWiUJzcKeYNpwD/UHwDushvGmqd
Qs42s/tZtg4WFpVh0jcCdmdhzxv23gI=
=dEFl
-----END PGP SIGNATURE-----

--NmDR2XRCUQIi1brc--
