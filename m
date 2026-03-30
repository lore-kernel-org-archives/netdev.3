Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F92C32ED21;
	Mon, 30 Mar 2026 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882970; cv=none; b=QQxsP6yRJfmaYymthC/Fizfs1T65gqoZSPug2eo0dvKhjaTPYoxbsQ6gU9pUyS1cv+omzr/cpuTHbnGpoDjtkUX3nChA4pNB3PsA90x+BvPne1FA6lGqrCpAJ5o+LqYcihaxW3v7jrO2C01wZGkY5GlI82RyyVcBr7+I31kwmDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882970; c=relaxed/simple;
	bh=0UOIFMhQKOklg3R3612sioG87Ps9KaLdTK71ubPMDZA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=saicw2NICDg9F0VFqM0HeLPpdQ6/EmAHl4AszDuEu2ZdwNHLaPQGr5h5H80u4nqFXsZBnkurgbTZ18hTSqwBzn+cXiWFyYVt9ZpyDDP3TQVt3Am9K4ZyCaCDxX4CTOL7eIllq+1uhvg0HJJs8SYI47Q6ZyvoW+hrBEN8+8r8n/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6ZgIO1L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6ZgIO1L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BFCC4CEF7;
	Mon, 30 Mar 2026 15:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774882970;
	bh=0UOIFMhQKOklg3R3612sioG87Ps9KaLdTK71ubPMDZA=;
	h=Date:From:To:Cc:Subject:From;
	b=G6ZgIO1LADkfURvzlTSBk9OGr4W/m++tm9dAqczimORu63+S/sNABjMPLoBo9ggds
	 I2h2oXVoy9QEYgDT6HQFIVb+EXTUN0gOMoXSwchQunm6JmreqmNzRm5+vsp9rCEUZD
	 Up8pc7mTAWKhCIKlwmpLLVSiIZcn4qRk1KDPFBATBhE4z0fcLQ8wyUW3U2nOne4bsG
	 qelb91X7Q3e7FfR8bQo0A/fhJXsZBw++wx+6XUG7xsAYrGpE2YfHwkpbj/mcOcdnzn
	 wPudwBweCsxOBGuOjdsYzjyChCUxHdmQuCbZ82YPiBgd+Monz6I2UhQVFQ5zo5ejLp
	 w8jqeTKoGW6Tg==
Date: Mon, 30 Mar 2026 16:02:45 +0100
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>,
	Leon Romanovsky <leon@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: linux-next: manual merge of the net-next tree with the rdma tree
Message-ID: <acqQlcV326LWAtyp@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FrMZQnoAwEPKyjGO"
Content-Disposition: inline


--FrMZQnoAwEPKyjGO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/infiniband/sw/rxe/rxe_net.c

between commit:

  d0ee939f7703f ("RDMA/rxe: Support RDMA link creation and destruction per =
net namespace")

=66rom the net-next tree and commit:

  29ae61b2fe7ee ("drivers: net: drop ipv6_stub usage and use direct functio=
n calls")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/infiniband/sw/rxe/rxe_net.c
index 211bd3000acc8,cbc646a300035..0000000000000
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@@ -141,9 -138,9 +141,9 @@@ static struct dst_entry *rxe_find_route
  	memcpy(&fl6.daddr, daddr, sizeof(*daddr));
  	fl6.flowi6_proto =3D IPPROTO_UDP;
 =20
- 	ndst =3D ipv6_stub->ipv6_dst_lookup_flow(net,
- 					       rxe_ns_pernet_sk6(net), &fl6,
- 					       NULL);
 -	ndst =3D ip6_dst_lookup_flow(sock_net(recv_sockets.sk6->sk),
 -				   recv_sockets.sk6->sk, &fl6,
++	ndst =3D ip6_dst_lookup_flow(net, rxe_ns_pernet_sk6(net),
++				   &fl6,
+ 				   NULL);
  	if (IS_ERR(ndst)) {
  		rxe_dbg_qp(qp, "no route to %pI6\n", daddr);
  		return NULL;

--FrMZQnoAwEPKyjGO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnKkJQACgkQJNaLcl1U
h9DQcgf+MXCNcc0mickFgqMmi3/3U81RQa83wuNY5dQK2gPGJX1lcL2YBhypsM/I
py70wScnTRSv5X82JE1OEX3+Ur8YqtwDXH9FALNL01s1cb5ABAJn+YshZGSyajj5
+zoby7uZu+FMGalmhAdMbhUzlWdtPMtGRB1Oyqs/aPno/OaRf6+z3Fx2tV2I4pIa
4Zt+l7yHXV63Eupr/vQgaSNzFiJ93w1MfRCdOxzoY2/KJHW+o0uw6l+DwcKUirMJ
77CO5oP4zcbc2plr2o7GlS/4WSZyJUuJtB9wYZQGUwm1Twng1TF1fEjfzfF6AJK6
KYw9BZIzYIDieGvmMC+8j4ViLgrxHQ==
=MH3J
-----END PGP SIGNATURE-----

--FrMZQnoAwEPKyjGO--
