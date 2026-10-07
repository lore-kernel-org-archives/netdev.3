Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C1A491589;
	Wed,  7 Oct 2026 10:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791369141; cv=none; b=nciYDTBcH5g/Z1zgvy1oMrix24wbqrkSODh/zA4SEESRrwkV+Z2uPH86Zrpw/f4bhp1qFMCMuvjOYWXwBw0u6KjOvmrTFABwcExcwCEKtNYwqLMqEmNSkk14qSveBRPZKiZTgkOIYuFdec1vJDtlCRTmJQR2qUqOf+VfvjkAJTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791369141; c=relaxed/simple;
	bh=JBNarp1fX4AnWfPIHZCfKK5sI3oeynq4+aVpACd4RLA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mptMqJIIkFlYEVQiSY68foL9ou6zX52BWZW+mYvSIiQhKSat4PZikRYqD9kHLDCnEe4i208g9Q1+yLCEMc/rxsdXIvGhJgWW1TVLZz0rikEVfC6etwRY0yXdWdZn4J1K3gk7zOgPXA48SKHFyXckVFkWTdwieIOPwdfxMahFSWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHtfLyBe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHtfLyBe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FEA1F0089D;
	Wed,  7 Oct 2026 10:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791369114;
	bh=4OVbBUcHKkE/cb1pS6KJ+RZ20nzUixVZbErNfYREsNg=;
	h=Date:From:To:Cc:Subject;
	b=nHtfLyBenkOtWBQ6l+IKx6VSjsDqIImck4/XCw4hIVp4RTUgQ6AVtGJI2EjxzvPx9
	 dNtQ71MzvS6bHVCKbj4yiAcJce5Q5QhiV+tre1PQdp0GhzCo7NAGmay6RVYpLqceDJ
	 eHCn/QLAvCevGRX9grEDbLAdK30U4Fn5l4ldaN8rU5qq/ZBtpgwVmR/xl/LkPHGHlV
	 ocBHieRmer4toXf4Jpne0SUR+P2KHdPYFgYHq01EE/XuKoiGfM2L19rsHb2mXaz8kd
	 mw1DQM7OTm1wjeCoIaY+mvB0EMPvoMl9V2D+8ko7ZbNd8WtqZAyP3P5dshRgF9iHuR
	 PgHirTweyGM5g==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 1D2B01AC57CE; Wed, 07 Oct 2026 11:31:52 +0100 (BST)
Date: Wed, 7 Oct 2026 12:31:52 +0200
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <asYfmLsfy-SCxXjr@sirena.co.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9BPwwMjJqDQVsekm"
Content-Disposition: inline


--9BPwwMjJqDQVsekm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  include/net/strparser.h

between commit:

  0984ebc631792 ("strparser: make sure __strp_recv isn't running before tea=
ring down the parser")

=66rom the net tree and commit:

  02fd0a2111374 ("net: strparser: removed the aborted bit and aborts counte=
r")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc include/net/strparser.h
index 881b7ae344986,3c9c8ca088282..0000000000000
--- a/include/net/strparser.h
+++ b/include/net/strparser.h
@@@ -91,11 -87,10 +87,10 @@@ static inline struct strp_msg *strp_msg
  struct strparser {
  	struct sock *sk;
 =20
 -	u32 stopped : 1;
 -	u32 paused : 1;
 -	u32 interrupted : 1;
 -	u32 unrecov_intr : 1;
 +	u8 stopped;
 +	u8 paused;
- 	u8 aborted;
 +	u8 interrupted;
 +	u8 unrecov_intr;
 =20
  	struct sk_buff **skb_nextp;
  	struct sk_buff *skb_head;

--9BPwwMjJqDQVsekm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCasYflwAKCRAv73Ows9A4
ifVkAQDrjw3qw4QTF5DYA5vUu30DYEVDUNn8TUZs2AzcFq8XugEA9tRNNWF9li8t
deV9hiIdt/zkL9gjMdW7+Sn3Ou3EyAQ=
=Nljl
-----END PGP SIGNATURE-----

--9BPwwMjJqDQVsekm--
