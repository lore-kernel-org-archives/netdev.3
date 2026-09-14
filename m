Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62F6446060;
	Mon, 14 Sep 2026 11:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789385518; cv=none; b=IjcpeHPAQhMk9xgv4jOo299OdAxn5igPvyNildc2JNvcX+FEuOwn5uueSTPInCZkKpTMrNqM0pI/a9ORVtGoIIVVFNoM+7wDzu5UyRolKIDr6gioizd8hmTevE67puaAHouDkDy5cfqgzDTv0GeohOjNbPvoLCbSz8+yj62YfUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789385518; c=relaxed/simple;
	bh=WCeXWoPlM4vZU6s2Omxb43PHXiFQWmayJUh0FU2sqJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iJciGbcNRDo+i8bqYOMkWUoBHfwONeBkHV13jyzSc+TZZqHF8U5ZAHf/x/wrymBpAw3s3r/e+pEagq+Y0FAXrKJMyFWDJQcyAGd0r5rfqaZ9ZVEzePKBlhJQmhyOD+fbjIpIAvkfh0U2lwLVu0rXlmAiO/SwfMO0NCvPnEr91tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DD/P8f6f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DD/P8f6f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D511F000FF;
	Mon, 14 Sep 2026 11:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789385513;
	bh=/KlzLDGfJ+Zqi6G0Fo0uQRk4vXf9sj8wbTUggnxqUUw=;
	h=Date:From:To:Cc:Subject;
	b=DD/P8f6f10Yeqd0OnFKKzglnH+RXO/De91QvHEU1Ef/HGDgs7o5PKziOgYgqTYwkE
	 qcwXchmMELhAxgyL6wazIx9OdrsyEjvugdex+4NoluE7j16t43/xbajWl+p845PQkd
	 30kCuYXRJQCcgsVWfhoM8XqM9xXnMXTCYzENMUxSuP/d5RTRMV79iMcqk8McHPZ342
	 RStTCKebalQK2ub5P81PNSHDjTIFpCi62ZNAEXHqTBRehBZsXM8bhZfNONQvicIuMC
	 NbMYSyD07ltp7Ce5jIEn5Y84Q3ym/TYA5J3elGYr5qMKMbG+S5+eIZzBE9blQh6vrm
	 XPNQDbxOqTf+A==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id BF96B1AC52F1; Mon, 14 Sep 2026 12:31:50 +0100 (BST)
Date: Mon, 14 Sep 2026 12:31:50 +0100
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <aqfbJi7nAX4IbmnR@sirena.co.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FacRHkUZIHHyRHbg"
Content-Disposition: inline


--FacRHkUZIHHyRHbg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/core/neighbour.c

between commits:

  979aabdad8dd0 ("neighbour: Skip default parms when resumed in neightbl_du=
mp_info().")
  7b430fcfc972f ("neighbour: Don't render blackhole_netdev via RTM_GETNEIGH=
TBL.")

=66rom the net tree and commit:

  fae1c59810b86 ("neighbour: Remove unnecessary net_eq().")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc net/core/neighbour.c
index 7448320f7ad52,27602bcbeb691..0000000000000
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@@ -2620,15 -2659,9 +2669,12 @@@ static int neightbl_dump_info(struct sk
  				       NLM_F_MULTI) < 0)
  			break;
 =20
 -		nidx =3D 0;
 -		p =3D list_next_entry(&tbl->parms, list);
 -		list_for_each_entry_from_rcu(p, &tbl->parms_list, list) {
 +		default_skip =3D 1;
 +
 +		list_for_each_entry_rcu(p, &tbl->parms_list, list) {
- 			if (!net_eq(neigh_parms_net(p), net))
- 				continue;
-=20
 +			if (!p->dev || p->dev =3D=3D blackhole_netdev)
 +				continue;
 +
  			if (nidx < neigh_skip)
  				goto next;
 =20

--FacRHkUZIHHyRHbg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqn2yUACgkQJNaLcl1U
h9D39gf9ExBLdarnOaGM0dKuOFkgkeFKexT6DggV7i8EMQHkRhCz2YEM776JRwwG
zfNtCYi+ISosLKHZ+RTV/AYrwiNL8SUW+dcxOyUvYgFs2x/TDmZZ3C4J99Ef7/LV
BbSB+Z8OEoPdSKSYTg+Ikg9kgHJloza41eK8ZrEYzG+aKbvxQLsrMUG8Faso/Mwj
xuzJk/8n2AXv+fBus9KzaIdpcJDwxgVhGrvAxkbrWNYWD1+KDpkkMM72kTgidbHs
0J5gMO5eA52o9Qihb7JhUmKVUVyrCqHSt+p/DKnXeI3F4dO6mH1tlwSf/HvISq8P
h0zaIwmWXYNPBERZUrTBXGLGpLJy1A==
=YI+P
-----END PGP SIGNATURE-----

--FacRHkUZIHHyRHbg--
