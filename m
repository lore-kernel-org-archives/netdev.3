Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADEF370AC6;
	Thu, 24 Sep 2026 12:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253376; cv=none; b=t+9dkkJyaoW37L9iO1X+RPLXxQ8GRDqu6d3TYFbBPieaFR8cgVAriNQMg2N1gr6AE+AX6NJBjpSS9VvKS4ObQW/crTogM8wgpLmAAlBtx12hKf+piiUzJ6peS8sORVkY+iypJY2LldIYzq0WS/8MxfM/FpNu+catjkwsIZ1Qg1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253376; c=relaxed/simple;
	bh=COh/s0MhCw6q9gZFPt0+d5Ait0kNaAI0eCly5ris4qU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q5XQON+VdlH5TgBTzCsH3adX30a/5i/4H+jqxzzE9rb5dbxieZcyNJzuE18ortPSWsWyp80N8yutw7bvFgFyamFQn4X9sGkyAVe7y9oSNyIB2qlYgfJWVEcjJ427JT4XDsvfJGj6xDnE9u5VZnJXnA+GiQjtl7zB5+eWf7Yffn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWkvHcNy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWkvHcNy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3DF1F00893;
	Thu, 24 Sep 2026 12:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790253375;
	bh=6YTnpGK9kadbIsp6G3bDjZBPalAx1Io81EWgcvamcwo=;
	h=Date:From:To:Cc:Subject;
	b=MWkvHcNyhl/xexzFpCk7ocGNZ4lTqnc1GEdIR3zN7cYbDNp1AxvzwOesREYlHd1ZM
	 tfX4dMG9CiWjpq+UvP/JjoKp2xhSXfk73hSurLUJs16ySH0x3kIs9zEOXg4GER1z/c
	 F+mbHUioPrtJRTn4vvsfwWzc2TfwypHk4zjCBdxT9rUEii6Ns8zQ2NMDc9r2ZextsT
	 fLSAUbiabWIpCwHL4SK9br6u5sQZntdWFhaOeP3CYLLtv0/Ulyz3kwDt81ELfHXyfg
	 DBzVSK/rCOp7QI6C0lGk9aEJylzn0Mly10yL69OtZGxr2vgMNHpbYpjqSogY8JLOgI
	 dZSeMn2lVYaUQ==
Date: Thu, 24 Sep 2026 13:36:10 +0100
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Jonas Jelonek <jonas@jonasjelonek.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <arUZOqy73bE2pp0w@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fW4johO6qRt3p7Cw"
Content-Disposition: inline


--fW4johO6qRt3p7Cw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/mdio/mdio-realtek-rtl9300.c

between commit:

  89a8a1eef2d44 ("net: mdio: realtek-rtl9300: fix RTL931x C22 extended page=
 selection")

=66rom the net tree and commit:

  cc3cb8db1eef9 ("net: mdio: realtek-rtl9300: Add page tracking")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/net/mdio/mdio-realtek-rtl9300.c
index 9ce2b78075320,11d078ef941cd..0000000000000
--- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@@ -326,9 -567,7 +569,9 @@@ static int otto_emdio_9310_read_c22(str
  	struct otto_emdio_cmd_regs cmd_data =3D {
  		.broadcast	=3D FIELD_PREP(RTL9310_BC_PORT_ID, port),
  		.c22_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_REG_ADDR, regnum) |
- 				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+ 				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 +		.ext_page	=3D FIELD_PREP(RTL9310_SMI_INDRT_EXT_PAGE,
 +					     RTL9310_SMI_INDRT_EXT_PAGE_NO_CHANGE),
  	};
 =20
  	return otto_emdio_read_cmd(bus, RTL9310_PHY_CTRL_TYPE_C22, &cmd_data,
@@@ -340,9 -579,7 +583,9 @@@ static int otto_emdio_9310_write_c22(st
  	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
  	struct otto_emdio_cmd_regs cmd_data =3D {
  		.c22_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_REG_ADDR, regnum) |
- 				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+ 				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 +		.ext_page	=3D FIELD_PREP(RTL9310_SMI_INDRT_EXT_PAGE,
 +					     RTL9310_SMI_INDRT_EXT_PAGE_NO_CHANGE),
  		.io_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_INDATA, value),
  		.port_mask_high	=3D (u32)(BIT_ULL(port) >> 32),
  		.port_mask_low	=3D (u32)(BIT_ULL(port)),

--fW4johO6qRt3p7Cw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq1GToACgkQJNaLcl1U
h9D0VAf/RVzKeehC88CzrLoYxtznwFaWZwNCeuE1Scou1wXml8NJQs17pR7uwOnr
ZSJemvMGjxVVadK3184ny26pBeR2pmk7MSF51O6CpuXaPZJ5dThUC0HlRAHvi27Z
sHobzZZShGwRDENaMDukXMQhff4cwqU4gEmiv3ubsSHB0qYWYcbqzH6agN/JxYfY
c5MmfewOqS1LR14wj4zdjepgLRCd+/NCLxJejJt4h7qvRCMpIMaUgslU1y4aKd+2
U1DgJQV7Wf9E2eAYEYPczqtnzo1x9VUPtG0uXlqBtpxJqbnc9aLT9Yd3QSjmtt7A
zXta5kLZxgML2e3kzYbaK+FO/xGQpQ==
=72c9
-----END PGP SIGNATURE-----

--fW4johO6qRt3p7Cw--
