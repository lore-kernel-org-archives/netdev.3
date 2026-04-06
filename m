Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380632D9ED1;
	Mon,  6 Apr 2026 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775482746; cv=none; b=LxMFhS5LDraVrxHsMNlma/8Wiy4sVzEETt2v2Tg9W4nRHBnvoe/43UmXWCFCXj9/1s9TQc+9aZBfsBLVqXEFdMaI2yPIK0Lfcb6l85cJ3eNTZfNjFknGYDKhjwuzb8KhKpsE8LB2TYkglMd2uG7c5P2XRIeMZHNrJTIKegk9zzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775482746; c=relaxed/simple;
	bh=APQPUocm4GOFYU4BpDaucIHnYV/RnH6hj1Z27G2TWGM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CV1HAPDCZAANwi0BOcDru+YWo78VfMGV69q2c6rbvipQD4xCCDhFnufmd/dkSr4/RDgQx2Dk0LMxvLHBGsqKd96+x+kmS8luji3f45kZ4FX7djjh9nX9x3nXOOlBewYZrvpLW3ChtA63bawMf98am+qkx4XF6E+juHjCEhx5Uss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6Z733oI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6Z733oI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14056C4CEF7;
	Mon,  6 Apr 2026 13:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775482745;
	bh=APQPUocm4GOFYU4BpDaucIHnYV/RnH6hj1Z27G2TWGM=;
	h=Date:From:To:Cc:Subject:From;
	b=Q6Z733oIthKhu+okUuFyVuoVBwsg+nNyHlHlWEO6O599x1tdnLHioen/4GcrI+7M7
	 1h0hUyQivsBs5IKfZSnDHU7tXqFISxs1m7fvgzaM5JsbTY++9B1fVTCGIdQIGh9V8d
	 FFZ5OdoDxw2fWmQX1BO+BUWXDnFiyWgX49bNC4avNd1ImrfjvrRQJ/Gd0PyfkAa+TA
	 gw88i1e1LIyy53G7wVzhZJJQ1JzllDsBWEnAvL0BenptxDqHNUHebkFdLFL5kWFwPe
	 yAFtY6CwJzk/4OHm+KbNprTAIeEQRjXj86I7g65B+JokhFC5CrNWY1VhruWxKg6ALg
	 psiHBuF52mBmQ==
Date: Mon, 6 Apr 2026 14:39:01 +0100
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Yiqi Sun <sunyiqixm@gmail.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <adO3dccqnr6j-BL9@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ft3vr1zCtKzX0w0Y"
Content-Disposition: inline


--ft3vr1zCtKzX0w0Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/ipv4/icmp.c

between commit:

  fde29fd934932 ("ipv4: icmp: fix null-ptr-deref in icmp_build_probe()")

=66rom the net tree and commit:

  d98adfbdd5c01 ("ipv4: drop ipv6_stub usage and use direct function calls")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc net/ipv4/icmp.c
index 4e2a6c70dcd84,2f4fac22d1aba..0000000000000
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@@ -1345,14 -1342,7 +1342,15 @@@ bool icmp_build_probe(struct sk_buff *s
  		case ICMP_AFI_IP6:
  			if (iio->ident.addr.ctype3_hdr.addrlen !=3D sizeof(struct in6_addr))
  				goto send_mal_query;
- 			dev =3D ipv6_stub->ipv6_dev_find(net, &iio->ident.addr.ip_addr.ipv6_ad=
dr, dev);
+ 			dev =3D ipv6_dev_find(net, &iio->ident.addr.ip_addr.ipv6_addr, dev);
++
 +			/*
 +			 * If IPv6 identifier lookup is unavailable, silently
 +			 * discard the request instead of misreporting NO_IF.
 +			 */
 +			if (IS_ERR(dev))
 +				return false;
 +
  			dev_hold(dev);
  			break;
  #endif

--ft3vr1zCtKzX0w0Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnTt3QACgkQJNaLcl1U
h9A+5gf+NZWtn776BVXSDfhPQlejdbBeDV/j+yAQJoo0HMACAD3MYjCTid1I9BY/
TNiqypn+U3AyrnlEx22gmtheSmPl/EscwmIRc09sG7auO5UDdtTp9lqTokJEuyej
QhJUVA9/m/iZXXpATz0CdMIuWU1NB3kudgeeE5opwGySZU4CnG/qVXUmTnLOQ11W
6L5oVnSeCfe/R5uh4W+oswcoQqWal5ELPSGYyY3bHTTT8TXiMjwTiTKCVaorqi/3
Yu0sULjt80PVh9i+mphf0xqSdnbbME6CSTJyiJKg1ragTDCdL4m6aJpE4N371AWC
FxOZJBlcpJ0uVkWfDAj6vq6WHIvSqQ==
=0bbW
-----END PGP SIGNATURE-----

--ft3vr1zCtKzX0w0Y--
