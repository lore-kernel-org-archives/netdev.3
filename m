Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330193;
	b=Y+1/nJde87rh0NKCOEVUcmtWCa4DahB7FZDa+45EJU0pLDtKjPqfr7hLhV4XN86sYpbg
	 7CoRuTGcNidSQF8dFIqhHfffwLxyk/FPdZUrNtNpo7kU/1J5/MPzofdx/eJNltzfvXL6F
	 Fdm5bX9duoQOHFSrABjXH+dWH1vxM1y1IGj/Wh8H0/t60UPoG6FKJo1PnYNwpXoofQ7cK
	 Jc7pFxA6DU5inAMdXrhVftU9NM4DtCp2uZ6NV5mbQLO31ZoYple8i/R7dzlZuZ8CJdZ3u
	 DGFAk+3Kx0X6+Sf8NO199EXdblnJ4N80t5bSvpeqTGvXb9eUu4jzEm0+PN/aKq5ZrTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330193;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=zanXqdxJzKB/M0HVLRr5b03mkT180rjVmbT5V/v416U=;
	b=Fx/fO5T5USRTmCSC7qCsqKFpQLRBVTLTtvDYWkPUONR6ZmCZz9LrbTdoBEeei5N5A6u6
	 LtK62rcZrbMpU1re+P6ZIqyeMh3f7+NgbxNXy64Vi/2LFJ1AAq0cgEgWZnohTnpC+NhfH
	 MVfvCzLk53bYT5j44z+r6cU/As61d2Wh2DyZ21EC2EvVMqfTxwItXRfvqLeI6WYqm7wMY
	 OKdfsrIfF9j71ST5rInp7u4uSOTeHpINb14A4JmRjq+AyKyOV6dvFp6cmNAx8qWL0xwvL
	 W3VCHJpJyTg4l0aanRrzxyV19UMwA67Ypei91sam7re6LDOj4J00KJV8UFBUS+4wuFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M4zV4Whg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68006606A33E;
	Tue, 10 Nov 2026 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M4zV4Whg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2002A1F0089F;
	Tue, 10 Nov 2026 17:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794330193;
	bh=zanXqdxJzKB/M0HVLRr5b03mkT180rjVmbT5V/v416U=;
	h=Date:From:To:Cc:Subject;
	b=M4zV4WhgwO74JSS7JsHnAvkNS2Y9ckeY8hsFvWO/soozmyeV0fsmi3NDGgxk9TAdX
	 1zqsqUUkoEwiLLHyU16kBZ+iVY73u1NnxKfqnGgmtmJSVUvBvkpV8E2qaTO/joHBpg
	 wYcI7fRV45C74uhl2clgFjkdS/K1JhRZBmRuWOSd9L2HuDkFwsuO+idElIIGBlt2gY
	 TTsr69Z93jr7bUVR9zgDhk3Xp127UehRp+5i3eywaqtG3xbT2oPvLyq1vTSpnVB3r9
	 junxMIUtt0G4INupZdFEzqfXtFEdTBEB1ZW5vreow9iiJULNGzOu1ep5SJq6hNtT4P
	 cTW/tXif7tm1w==
Date: Tue, 10 Nov 2026 17:03:08 +0000
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Kees Cook <kees@kernel.org>, Kees Cook <kees+treewide@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: linux-next: manual merge of the net-next tree with the origin tree
Message-ID: <avNOTKD-WJpbu14j@sirena.org.uk>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I8kBAMTTqksYRfUd"
Content-Disposition: inline


--I8kBAMTTqksYRfUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/hisilicon/hisi_femac.c

between commit:

  4dd10fbbeb9c3 ("treewide: Convert devm_kmalloc() family to the devm_kmall=
oc_obj() family")

=66rom the origin tree and commit:

  10830cb24e915 ("net: hisilicon: Remove orphan femac driver")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

Deleted the file.  Kees, *please* don't do these changes at -rc2,
there's a reason they're normally done at -rc1.

--I8kBAMTTqksYRfUd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrzTksACgkQJNaLcl1U
h9DMEwf/UplQS0TFzzD+rKkjvGpvtTxp7HSa0gv55Vtu1mqp8SC8/sODkYLyFH05
900f2JZHtAy3tkHnonEGJaJ0LEPFKCfwtVpftEJIRHlg0MK4p8VA5oniUYTD7Sg/
+sMbhOVQI4+NkIy5QnOWFrYQ2PwWzxxzn/cWBhJqRsWWLKx5sHX7MaUqP10Yajev
rtlAJ62HbE9i1b3T/FxFmySe8uX2QGJKicjR5nxW0v2VrcVFUnd3xKT2r6NvX/D8
B4NmQULwJmaFQd6rQ8Vuo46IwC5fn+JWimtevfFe4gnNXNDaEz4mvYxQX/CCBv3o
TeV99bV3gfV+6+Vhr92l4Tno5lpqNw==
=ertP
-----END PGP SIGNATURE-----

--I8kBAMTTqksYRfUd--
