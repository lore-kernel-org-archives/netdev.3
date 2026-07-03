Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFCF3161A4;
	Fri,  3 Jul 2026 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078792; cv=none; b=NW4i+74gv9Yc1aT2rhBN0YMThY0oCrDy+JiqGuJy9xb5s26XN57RTayULEiali7fezDw2oBoTCYi5t5E7mfA55f3fKQLPnQTY7Vs5zx3qAfeaHhMZ9yNwIyr573no1XidmpwrMuNFXqGpwZxzJvNyhtW28BwZegXVf42esuLReM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078792; c=relaxed/simple;
	bh=S1It7wXISZWNqATHabTkAXedhal9JKLCbcizLpjvrwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZvW68jnl3NX/i/2J+eUl/X6lShpwSEDkv8qAx78VRprgYIdwCJ4f/+ztyDyzoMXKU0lSzrV019jFBHvJaecSUhJB5hpATAPOPvXpNb60J+xRF1Dp1t2GsWXwrsluA5sqcLYc8SaXhi/mP9We34WMsZMANODClIbZnQq1RaJ0aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6L9MwKP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6L9MwKP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7031F000E9;
	Fri,  3 Jul 2026 11:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783078791;
	bh=S1It7wXISZWNqATHabTkAXedhal9JKLCbcizLpjvrwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m6L9MwKPZGyGk4U2Vo6XXl3Dmz+pa7iur4GmBtpL7WHRCKvh61H/b1izOgUt6Jq5w
	 7budTF1jQQyt6v6+uVb9+LsK/rRdZlDd8YiJobmqg/SBVuyPhdwHw85/drZkDHOPKe
	 V5dg0W524bkmWtIFrGeB/nvr24jjJGskaH0UiH57qQowqn4qDvglDoiZVcXrkt5fLg
	 5F7NpIJem7yrXaMSh9sLUhnGG+xWsUVaCP2JxMZOZrh1L491mLD7PSH5/FOD4mI59t
	 z53k3txY7xIZ0u/r/jhEErE48XIQgI6PETxGIPaIEo/PSxjvIJ0J6BHo1HMXfVnF74
	 Xz/M8tqvaaeeg==
Date: Fri, 3 Jul 2026 12:39:46 +0100
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
Subject: Re: [PATCH net-next v3 07/15] net: macb: introduce macb_context
 struct for buffer management
Message-ID: <20260703-graves-lining-0f70eb19b5b2@spud>
References: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
 <20260701-macb-context-v3-7-00268d5b1502@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GomScrFh91EL25F5"
Content-Disposition: inline
In-Reply-To: <20260701-macb-context-v3-7-00268d5b1502@bootlin.com>

--GomScrFh91EL25F5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--GomScrFh91EL25F5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakefgQAKCRB4tDGHoIJi
0jxhAQCEnysqyCo8iNgbzq5T8LUSA1A8RVaS/aD0AhR64Cyh7AEAwmPfkz3tonbz
hthzlEr88AePE80OsRtGAkxEnWacQgQ=
=vzF/
-----END PGP SIGNATURE-----

--GomScrFh91EL25F5--
