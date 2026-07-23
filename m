Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7F041D235;
	Thu, 23 Jul 2026 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814123; cv=none; b=bNR5Y/35FOGQkrO4vkknjOQI33VOEnHLUc9QAmfmpiwqbwGMQSnaYdOv+5F7D+cOkF04ULBI3HRlNVGLCfOGwjYzLi0s4Qao+ZDfxHGm6XUK94uRC63y8dHlJLQ99pt7iD/YZm+5BRilWsGQ1fLc1hkD9POLG+GKX3PdAcHPEHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814123; c=relaxed/simple;
	bh=D1zNXuVKFoStwMsgX3CzaYPxEnN5E/Bnhfh21ctJvqw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H5km2XlplMbtlHP8bJW4N7NoLixXPTNaw+299kOT3DhnHL4fmGM+aVeppGztp6C6Senj+h8M4xkdf/dRS74F1AP5bQqS/rQ6xrvoQv/SU1YocWlw+r9F1+cZZmgT3JAIed79Yg9WGECdSYG3Xp+i2ckdFzJZ05wyjkDISYkaTys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=br23MCtP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="br23MCtP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD651F000E9;
	Thu, 23 Jul 2026 13:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784814122;
	bh=wvEfXSI+WIjqZ4jD9cQjj73lJhIlrS7EEJRNb4YI9kc=;
	h=Date:From:To:Cc:Subject;
	b=br23MCtPw8anKE1Ls919L1Yq2+jrsYAq/4W9nNofKg13fkWEJ7yHaLVqEqP+1HOiP
	 mc3i23VFLBOHc/XEvUKSytwbfyAWtUN8Hw1mH1AihgVZ4v1GFK5zn4RuQAEX8ZaoQh
	 ZaG8uqlfREayb9/3yWPPdvwXGiQQqE/g4nCnIhkE9y9jX8G04jSC6WOPdhLdBpLMF4
	 qY89spjA4ucLWwXgjAGiHV0t5WyPHMvfAhBigcZy/p5hsw3/bo5svoKuI7gdT+Xq9K
	 E4GLGccQj8fHiYS7xDqUOdoXPe7C/fD0i9K1QNBDAnOOd6WoZ9mfDsR/UdtDb6MyX/
	 OYGXQV+wmYYdQ==
Date: Thu, 23 Jul 2026 14:41:58 +0100
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <amIaJr3aOQNS_Fvl@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5aTCXO4+mubg62Eq"
Content-Disposition: inline


--5aTCXO4+mubg62Eq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/amt.c

between commit:

  3656a79f94c47 ("amt: re-read skb header pointers after every pull")

=66rom the net tree and commit:

  586c4dcf28eb6 ("amt: no longer rely on RTNL in amt_fill_info()")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/net/amt.c
index b733309b866ff,f8169c5512a59..0000000000000
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@@ -2811,7 -2775,8 +2814,8 @@@ drop
  static int amt_rcv(struct sock *sk, struct sk_buff *skb)
  {
  	struct amt_dev *amt;
 -	struct iphdr *iph;
 +	__be32 saddr;
+ 	__be32 remote_ip;
  	int type;
  	bool err;
 =20
@@@ -2822,9 -2787,10 +2826,10 @@@
  		kfree_skb(skb);
  		goto out;
  	}
+ 	remote_ip =3D READ_ONCE(amt->remote_ip);
 =20
  	skb->dev =3D amt->dev;
 -	iph =3D ip_hdr(skb);
 +	saddr =3D ip_hdr(skb)->saddr;
  	type =3D amt_parse_type(skb);
  	if (type =3D=3D -1) {
  		err =3D true;
@@@ -2846,7 -2812,7 +2851,7 @@@
  			}
  			goto out;
  		case AMT_MSG_MULTICAST_DATA:
- 			if (saddr !=3D amt->remote_ip) {
 -			if (iph->saddr !=3D remote_ip) {
++			if (saddr !=3D remote_ip) {
  				netdev_dbg(amt->dev, "Invalid Relay IP\n");
  				err =3D true;
  				goto drop;
@@@ -2857,7 -2823,7 +2862,7 @@@
  			else
  				goto out;
  		case AMT_MSG_MEMBERSHIP_QUERY:
- 			if (saddr !=3D amt->remote_ip) {
 -			if (iph->saddr !=3D remote_ip) {
++			if (saddr !=3D remote_ip) {
  				netdev_dbg(amt->dev, "Invalid Relay IP\n");
  				err =3D true;
  				goto drop;

--5aTCXO4+mubg62Eq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpiGiUACgkQJNaLcl1U
h9BLbAf/SqHisUAIA7qIJ3EZiVr419If5j1WGDnJBt9WXnNJRFKgvL1DBJ9ocpeo
Xc3Kh7BI1IdgqNxXW2sjZVnGobReu8qVMAdlgiipQ1QYKJ2eRozJW3/POgZAGTo+
8tnAtendPaYQMU2MFf/DzDz58hIbOvxcjSNFIxwai/xR6bVg6GzsflilLeWcUuDi
ZNAIvMhv9WW8Xo6UZcl2Ja4hQwgEfdHBEX5vniUgZ+MIV8+ag78TZPueTztlf6yy
SMAPJw6imZXxhDDa0qKhCIlFdbGR+bfYP523SwRAJdv0Pn4QyJXPnehOguJqeEiR
T3wvDGqbdOYb18S/Os2yOCwc4txpRw==
=yTQ5
-----END PGP SIGNATURE-----

--5aTCXO4+mubg62Eq--
