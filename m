Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5193ED121;
	Mon, 27 Apr 2026 19:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777316736; cv=none; b=Z2RRfq+g88U8QR5EAM3dhey5bvWY6KoThRjSPAUqHuwKDwtBObp1krZYtdJ7PkqPhwpbsOdc//QDn8RtABnWVvwmpG1DU4da7uB+K0rWeT7Caphns+AcA5Ae6YzXKsD/Pf70coAgxWWXWx4BRMPWN2WDL8toEtqSwQPJGm1duOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777316736; c=relaxed/simple;
	bh=Mhyohh1HXnwBgAR4BR6g6L0ve+gccVeyspOB5HMBrqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aj44NPzZfiJFDECV8OiC5oh9ERsIFsfrudcoE11BXKnrrlkJTQx+O1CUxdO8r0dFrXq7h9dLBbCBY9tz9kUrXPMMCThUC2WiwkyG0+31koilqOXvNoy/OfFELCuWD8EunlEB31Usd9SwN9NTdfVs630y3D8MYj+vN5HYDhm4wLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ff5NIzK1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ff5NIzK1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D481CC19425;
	Mon, 27 Apr 2026 19:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777316736;
	bh=Mhyohh1HXnwBgAR4BR6g6L0ve+gccVeyspOB5HMBrqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ff5NIzK13KiJmVmOM3rZi1ac7+0JpRvDmH5OHP5nlmXfpnhV4Iq4ORa/QLeJlvrHY
	 gkOAFcnYCsoH/hPEmAwwRVcFmLCtpOeP3f4r93F2faU/r+0YOK41sESQt7IIt74eet
	 zn0Dtot5BhoZDnaTwANDDnTAuq5awt5aV41Km0sLJ0K4Q4FgyZKeeR2sDsc8YVkqTN
	 YlOYgYvJdmyoop5+FijncqYibMuXcd4zadOeqymCj8b789e8B5ppCgtgqJS4o8EMFY
	 xCiX42i8UETm724S1c+2ut5F7kdswn1ZsZZd1QY2yKftofnBP+8qQ00Wqb1bP94tjs
	 ijbgbTTV0R2yQ==
Date: Mon, 27 Apr 2026 20:05:28 +0100
From: Conor Dooley <conor@kernel.org>
To: lizhi2@eswincomputing.com
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	maxime.chevallier@bootlin.com, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	pritesh.patel@einfochips.com, weishangjuan@eswincomputing.com,
	horms@kernel.org
Subject: Re: [PATCH net-next v7 3/4] dt-bindings: mfd: syscon: add ESWIN
 EIC7700 compatible
Message-ID: <20260427-skewed-thigh-40baec89fbaf@spud>
References: <20260427072353.1114-1-lizhi2@eswincomputing.com>
 <20260427072541.1174-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="El0eEiK729PJ8197"
Content-Disposition: inline
In-Reply-To: <20260427072541.1174-1-lizhi2@eswincomputing.com>


--El0eEiK729PJ8197
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 03:25:41PM +0800, lizhi2@eswincomputing.com wrote:
> From: Zhi Li <lizhi2@eswincomputing.com>
>=20
> Document ESWIN EIC7700 SoC compatible for syscon registers.
>=20
> Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--El0eEiK729PJ8197
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCae+zeAAKCRB4tDGHoIJi
0mlTAP9T1H4VVCoPrBVkVi5B+2V2Nkk0PL+jONjju6Vk9eFLiQEAtsSo/+ncqagi
Rjbg6nd17U+wXLIrzq8nY1sOlp9TkQk=
=nVjP
-----END PGP SIGNATURE-----

--El0eEiK729PJ8197--
