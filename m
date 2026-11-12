Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491920;
	b=Ukv6Ij9ahGorctlWpJqWXQW7wpdvG8XLv1J8bbdJ8Wr2uigSzkv3xMh4Ba/mfYrinMsS
	 BgAPLQp2SvRrz+7sRtXzbhQBw3OVYdxI6PH9t52C5ij2eqsAgA8kPJxEQYWr3CuhqLik8
	 Wbo2fGrpT4U4iKnvUzAxcy4WNBZhDZG5H3gncKu23xmaezHpAHTchAtzHI4W6PGxxkRHb
	 XxwA8pF6bL4RULnB50Q0IPRn1IwkngP6krFNlptOEHZg3WMRuatqQ43HhrHwZ4PEnfa8V
	 LNj/UACdJ2GJkO9xW53nW7QuVnNVcPAfMlMVa+O9J1Naj7fqYXjjJGTFxspBawZDGBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491920;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=y6MFHGvPcbYar4CwyKNbKRP//yyNLcZhu080l4QiH6c=;
	b=bZPoLIhAz2p2b4hvVpONIrTIxQmc/AKAe5ynSt3J47dtO4DFlyDGn0BqCF8Z7Fk7Sm4Z
	 Q1KJ0jvLdJT+LVp34vamFfg+uyge1RFcOu004+EpE/pv9FaqIlZBEeYpKIB5Xns1stkbx
	 lBd54rwnyAu/I1yxo4XMbGIMhh1AQXY2DmADZSR3jQ68IRPHWvUTjcAC/phfAp9lsLEEW
	 qVp6bHl8zAge7Hy4XHF4pdns4zDYI8Rgv+SKcIEmkBpkpt6QJ1rWexJRdgdWJOI4biLVK
	 nVVVKSxjuAIlbWaPqEA/hRcsP+6UfM6D4jchobOyJJPKjtS9gcbOwAJUZ2iUCdAxG2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kXRrt1P7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8BF606A88E;
	Thu, 12 Nov 2026 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kXRrt1P7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE29A1F00A0C;
	Thu, 12 Nov 2026 13:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794491920;
	bh=y6MFHGvPcbYar4CwyKNbKRP//yyNLcZhu080l4QiH6c=;
	h=Date:From:To:Cc:Subject;
	b=kXRrt1P7mr3R2cKLdzTIUoucgIeMj0wAbVIdqyQtR1BmT21hJvOTYrfNNkgI8nuQU
	 8X6OPTasyQJuo4kBCDSkZa6kFeDvN7VPLZAphwqJ2cpSScqcAcCmzTSR3aVf86S+Rx
	 E54IEzIeEz4JQeTICT3mDEPzGmZVm+TrGs4VVkvhy3P0NYbYigPxr7KxOs6qWE5aXh
	 o17N6r3smgZqZvtW3ssC30oXo2UoVacNTmGg4iHPyEhW7zfy1lxwNhOlf0yowVIJbC
	 6jeTrBMk9i+RxEReL+gt6H4gmF7zjOPltw5cBwAz+5QvPsBwiWm0+cg+0dnBsmEm6c
	 oj77VLcyuYKZA==
Date: Thu, 12 Nov 2026 13:58:36 +0000
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Matt Vollrath <tactii@gmail.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <avXGDHChG4mIw6Tl@sirena.org.uk>
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
	protocol="application/pgp-signature"; boundary="hbsTRJFSQTG8UKuQ"
Content-Disposition: inline


--hbsTRJFSQTG8UKuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/core/dev.c

between commit:

  fdca4b030c78f ("net: Segment CHECKSUM_UNNECESSARY GSO skbs other than fra=
glist")

=66rom the net tree and commit:

  f4564d298418c ("net: reset transport_header for ndo_features_check")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc net/core/dev.c
index 3c58db732761a,3eb28c0099605..0000000000000
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@@ -4207,18 -4215,15 +4215,27 @@@ static struct sk_buff *validate_xmit_sk
  	if (unlikely(!skb))
  		goto out_null;
 =20
 +	/* Only fraglist GSO, whose segments already carry valid checksums,
 +	 * can be handed to a device as CHECKSUM_UNNECESSARY. Any other GSO
 +	 * skb has no csum_start for the device to segment from. NONE means
 +	 * the same on transmit, but makes netif_needs_gso() send it to the
 +	 * GSO code, which turns TCP into CHECKSUM_PARTIAL for TSO and
 +	 * segments anything the device cannot offload in software.
 +	 */
 +	if (unlikely(skb->ip_summed =3D=3D CHECKSUM_UNNECESSARY &&
 +		     skb_is_gso(skb) &&
 +		     !(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST)))
 +		skb->ip_summed =3D CHECKSUM_NONE;
 +
+ 	if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
+ 		if (skb->encapsulation)
+ 			skb_set_inner_transport_header(skb,
+ 						       skb_checksum_start_offset(skb));
+ 		else
+ 			skb_set_transport_header(skb,
+ 						 skb_checksum_start_offset(skb));
+ 	}
+=20
  	features =3D netif_skb_features(skb);
  	skb =3D validate_xmit_vlan(skb, features);
  	if (unlikely(!skb))

--hbsTRJFSQTG8UKuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmr1xgsACgkQJNaLcl1U
h9BjmQf9E6mOoRUCou116MG7nL3fkAZc56BcCIGX2v5bIdXtjubmMpcmf7Glq+ZN
EwYop32PxDepzQ4Dua7yHHg4JjL0QqzVXu5OyNxfycJhaV15qvTeo0g+2Jviv7TX
szUO73MD49Z64hoZ70FrC+PEuxAdRKgUKwzEVxzleg9Pot4PufoB45ZVExB3neye
HcjG+NFwBwgyH4Vh+yVTwraxTRIuwpQpVTkncAYYGTaEBM77m7dRMOyRc2T4OZ9h
njXfSBxObbuPWw2fj6Cff5OWb7uEYgyNguVy/03kGUqsNmSRrGmc8Y4O55y9+ROE
b4F25nAdY1lVhui2LxTolGfzBxx8qg==
=achw
-----END PGP SIGNATURE-----

--hbsTRJFSQTG8UKuQ--
