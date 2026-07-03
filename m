Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4763C196B;
	Fri,  3 Jul 2026 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079163; cv=none; b=YZnQ87ERhcWCehaC+fW9+0zuTHaa6R3PE5P1Nm9nmIci+p5hv/aDx1Dyyh9+1j84hoake9PAOAEtK83k3xsOzl6ZY8RjEn00FlAGJ3Eui29VCJUkuvnLcN7BLD8Ss6F3WmB+I7UQ86ZgwLyY+pnOkKXXDh2AW5Q8CMpnfgvkBmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079163; c=relaxed/simple;
	bh=gEVrQTG8upuQoNhIUnhciMY+4+guXFXtc2EsyDm2f+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaZKJ/KigyL+TD5lY4qkDY+fMMssnu0Pr1VfKbGALlpr5sSIPcCOR++Q99spTy6AsMZuA5sMTjecm3yLjM0bK7CBXrgwrX99wSjPU8fBVknZskLmdYA7K+mIMdSIcjFga+gsQfcDyE+dO9qOQbWLa0nHnbkwrIMc3b++P6aGskY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlcYiydC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlcYiydC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB59A1F000E9;
	Fri,  3 Jul 2026 11:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783079162;
	bh=gEVrQTG8upuQoNhIUnhciMY+4+guXFXtc2EsyDm2f+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mlcYiydC4E6A7iTt6MAvvY0ShQqk+CdvUwf4tW65kvoXXy6mA4tJ6+A3ur2GAJLAF
	 iuauzgO4P62XTvx1w5xVOpcUABy5COBjFtwH+S1DguGQj8dq6+eH+SC8Bc3CbsVoPU
	 THqnDLJR6Zh2sIMhajGMMBfXQEm5TlLI2C5YFywaNVi/KywXVVlvvSfkKuWyCujX8y
	 8Jk034+RcaIN+0wQO5SQsva/hycccArkgOGgP6bqE/4SH56BrvBqQ7iTeR3J7mC5qW
	 OWW+Ak+LNAwuXhiKP3p//XeL1OLfdsIW7UcYRx4ZY+GjnjtkhOR3mcXOfUetmZuYqS
	 FbjwNFbEDsc7A==
Date: Fri, 3 Jul 2026 12:45:56 +0100
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Paolo Valerio <pvalerio@redhat.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	=?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v3 11/15] net: macb: change function signatures
 to take contexts
Message-ID: <20260703-facecloth-agreed-5c52a77620e6@spud>
References: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
 <20260701-macb-context-v3-11-00268d5b1502@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ux/iZixQH75Kily/"
Content-Disposition: inline
In-Reply-To: <20260701-macb-context-v3-11-00268d5b1502@bootlin.com>

--Ux/iZixQH75Kily/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Ux/iZixQH75Kily/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakeg9AAKCRB4tDGHoIJi
0q5RAP9zzEXEOvRIfTHfaZeoA+i9SJgziTZlN/AZxJjMubLIAAD7BYk2jO/AHYZR
98KZxbgAkKFJG8hywpW0n8A5pm5PIQQ=
=bcSi
-----END PGP SIGNATURE-----

--Ux/iZixQH75Kily/--
