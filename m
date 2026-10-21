Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792580505;
	b=fSiPIW9JH3xZsRv+Jp3vMPiV4+Jyk+etDlrQc1KZJOHBEefJ/bRvddwcjkFi2ONKIeqk
	 rg+iTEbIdi/Knk9jrxzbDBA1elKGahAzH6QFQHYnmnnuRK44q65bijuk+kO8OIJVN0hId
	 KDwdUVRkFfgO1Jv9G80ySa6yTMj9MHKxuGA/QsAI6s6ynqso1bKqEouL5LUnSK1uuPnpr
	 tsPla5R3fRyIli+gutStHj4xaq8lSnzOGwztnFh8yrro1E+eObErWd9pQcr9rdn02c0OC
	 wxTA0gI6ZrUhGrOdbAaPVqNc/ghCz4CBRwdfeRnRSlhwKN0Hhi/3/kc4XG1n41YyWMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580505;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=VmaBTlAVXrUWG3CybTdC1pn7PMWqfrWGtrcJnPvOMP8=;
	b=GpBvZKupsjd46fhr6ggfs47oDFzVbNwIW9AZWcXr36LJc/5gYtpn5fRtgSPUL9J3KUMR
	 n8aC+Cv4GB96MDRULWdNQJk8coY/dVEQhYyKLgYacsQHorCLEi32HoVV1EPGLBE2bhxZK
	 fAwvh55POZ5+kEAqlUn2v5uJbtPGTHB7IbA2MNhEYDCU3/bgjx2VON+EGOg5wRQb3XcdO
	 L4WqiUz9btTUkY+Ri+phWU0kD+6qL+Y3caPqKXlm4a+U68t2IiExJfP6fnSmXwPj22uGP
	 YUN1FvlOKRXqmNiq5Vh006e+OeUO8Ga6JkQnUQssf5Nmd9OJEaG+m5HXime7IUxeuow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TgYe0rUB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3D2606A319;
	Wed, 21 Oct 2026 11:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TgYe0rUB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A921F000C9;
	Wed, 21 Oct 2026 11:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792580504;
	bh=VmaBTlAVXrUWG3CybTdC1pn7PMWqfrWGtrcJnPvOMP8=;
	h=Date:From:To:Cc:Subject;
	b=TgYe0rUB+sZPkRpH5DO2oF9vyKfNi8a1u4eSrqYwfflYi8IcnPr4/imm6+FyVOTiy
	 Zu8eNMHJmAGaMqrhiByQxXxevLehUM10LlmAY3wYntmGJ5FT/as0adyrkdmqWiVUpX
	 OnX6vNWI9G3cR92zxNkFFNUlS7ZUJ5N0U7go/gFHUXRXUUfdGZUWX5iUQv++A86crg
	 uo8QJ+Ogc/D4lpvdwzDNRwvzZKnmIgvQ6ARFZOl4DTmC+wCoDo0EyF7TtF5QmWmXBv
	 M6IrLbUyPsbdSOzGLm2ZoUicEFyCTN3Flcvuc/dBjyWD8+75/xWouOXoq/idsjAXpI
	 gTDMLQSt9U+uw==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 613731AC5994; Wed, 21 Oct 2026 12:01:41 +0100 (BST)
Date: Wed, 21 Oct 2026 12:01:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Liu Chao <liuc63@xiaopeng.com>, Networking <netdev@vger.kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Paolo Abeni <pabeni@redhat.com>, Piotr Kubik <piotr@kubik.pl>
Subject: linux-next: manual merge of the bluetooth-fixes tree with the net
 tree
Message-ID: <atiblfL12VddJgjU@sirena.co.uk>
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
	protocol="application/pgp-signature"; boundary="XCIY6wM65E3kzjR3"
Content-Disposition: inline


--XCIY6wM65E3kzjR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bluetooth-fixes tree got a conflict in:

  net/netfilter/nf_conntrack_netlink.c

between commit:

  cd37ab22a74e0 ("netfilter: nf_conntrack_netlink: fix inverted IPv6 tuple =
filter")

=66rom the net tree and commit:

  1ae2d094b0200 ("netfilter: ctnetlink: fix inverted IPv6 address match in =
dump filter")

=66rom the bluetooth-fixes tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined net/netfilter/nf_conntrack_netlink.c
index cc8695d5356d2,4b6abe36028e3..0000000000000
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@@ -911,6 -911,7 +911,7 @@@ struct ctnetlink_filter=20
  static const struct nla_policy cta_filter_nla_policy[CTA_FILTER_MAX + 1] =
=3D {
  	[CTA_FILTER_ORIG_FLAGS]		=3D NLA_POLICY_MASK(NLA_U32, CTA_FILTER_F_ALL),
  	[CTA_FILTER_REPLY_FLAGS]	=3D NLA_POLICY_MASK(NLA_U32, CTA_FILTER_F_ALL),
+ 	[CTA_FILTER_ZONE]		=3D { .type =3D NLA_FLAG },
  };
 =20
  static int ctnetlink_parse_filter(const struct nlattr *attr,
@@@ -930,6 -931,9 +931,9 @@@
  	if (tb[CTA_FILTER_REPLY_FLAGS])
  		filter->reply_flags =3D nla_get_u32(tb[CTA_FILTER_REPLY_FLAGS]);
 =20
+ 	if (tb[CTA_FILTER_ZONE])
+ 		filter->zone_filter =3D true;
+=20
  	return 0;
  }
 =20
@@@ -1006,6 -1010,7 +1010,7 @@@ ctnetlink_alloc_filter(const struct nla
  	if (err)
  		goto err_filter;
 =20
+ 	/* CTA_ZONE is allowed without CTA_FILTER_ZONE. */
  	if (cda[CTA_ZONE]) {
  		err =3D ctnetlink_parse_zone(cda[CTA_ZONE], &filter->zone);
  		if (err < 0)
@@@ -1020,6 -1025,12 +1025,12 @@@
  	if (err < 0)
  		goto err_filter;
 =20
+ 	/* CTA_FILTER_ZONE cannot be set without CTA_ZONE. */
+ 	if (filter->zone_filter && !cda[CTA_ZONE]) {
+ 		err =3D -EINVAL;
+ 		goto err_filter;
+ 	}
+=20
  	if (filter->orig_flags) {
  		if (!cda[CTA_TUPLE_ORIG]) {
  			err =3D -EINVAL;
@@@ -1098,13 -1109,13 +1109,13 @@@ static int ctnetlink_filter_match_tuple
  		break;
  	case NFPROTO_IPV6:
  		if ((flags & CTA_FILTER_FLAG(CTA_IP_SRC)) &&
- 		    ipv6_addr_cmp(&filter_tuple->src.u3.in6,
- 				  &ct_tuple->src.u3.in6))
+ 		    !ipv6_addr_equal(&filter_tuple->src.u3.in6,
+ 				     &ct_tuple->src.u3.in6))
  			return 0;
 =20
  		if ((flags & CTA_FILTER_FLAG(CTA_IP_DST)) &&
- 		    ipv6_addr_cmp(&filter_tuple->dst.u3.in6,
- 				  &ct_tuple->dst.u3.in6))
+ 		    !ipv6_addr_equal(&filter_tuple->dst.u3.in6,
+ 				     &ct_tuple->dst.u3.in6))
  			return 0;
  		break;
  	}

--XCIY6wM65E3kzjR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCatiblQAKCRAv73Ows9A4
iWYPAP4hqZJlVRBmkMEb2Zej8RMOTQBlC9MMj8DN8jbdCErrHQD+K+rBbt9LDQAy
Xxd72KLVtP0gjYAuvYz63m+80c8SQAk=
=mWKj
-----END PGP SIGNATURE-----

--XCIY6wM65E3kzjR3--
