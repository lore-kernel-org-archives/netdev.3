Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A2A438017;
	Tue,  4 Aug 2026 08:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785831067; cv=none; b=ixtQFLdcmVsx1HmoXf/vxjkLwhsbjNACYfCjfgNQKnIZnQbLRlcbHJg/38LkjrtPmiHYpcRWFW5yzt1qBWxITuEjpoRPEesU/G9WbN8zYwB7yL9nqUU+p3kWbJ7J1MJzDALN9iIWk4bhBf9q2hfTxV1ytHwL/pBlIB8LhnY27TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785831067; c=relaxed/simple;
	bh=h2BdVjEM2ugGrNvHGQwG74GfzBWovc3XNMMhwMFNdGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SW7KEX7cB1geZA0wDEHz+LGnqOluSuxrDKbTyQRqCvzofrwKJVWWOStvCviRUj3dYZioiIb7/sfrUoEvpOerQBGu3bVzXUKCgVRTVl2W5M5UPa2E4prwj7zR40A3DCXdBcjN7WNbQPI91BqjuLyqCTuTE50yntnVG0ZN3h2UcKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=BQ5VEob/; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="BQ5VEob/"
Received: from localhost (82-69-49-219.dsl.in-addr.zen.co.uk [82.69.49.219])
	(Authenticated sender: tom)
	by mail.katalix.com (Postfix) with ESMTPSA id 84C6A7DA17;
	Tue,  4 Aug 2026 09:03:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1785830615; bh=h2BdVjEM2ugGrNvHGQwG74GfzBWovc3XNMMhwMFNdGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Disposition:In-Reply-To:From;
	z=Date:=20Tue,=204=20Aug=202026=2009:03:35=20+0100|From:=20Tom=20Pa
	 rkin=20<tparkin@katalix.com>|To:=20David=20Bauer=20<mail@david-bau
	 er.net>|Cc:=20"David=20S.=20Miller"=20<davem@davemloft.net>,=0D=0A
	 =09Eric=20Dumazet=20<edumazet@google.com>,=0D=0A=09Jakub=20Kicinsk
	 i=20<kuba@kernel.org>,=20Paolo=20Abeni=20<pabeni@redhat.com>,=0D=0
	 A=09Simon=20Horman=20<horms@kernel.org>,=20netdev@vger.kernel.org,
	 =0D=0A=09linux-kernel@vger.kernel.org|Subject:=20Re:=20[PATCH=20ne
	 t-next=20v3=201/2]=20l2tp:=20account=20for=20IP=20version=20in=20S
	 KB=0D=0A=20headroom|Message-ID:=20<anGc1075Aw1EB7PG@katalix.com>|R
	 eferences:=20<20260730002107.447471-1-mail@david-bauer.net>|MIME-V
	 ersion:=201.0|Content-Disposition:=20inline|In-Reply-To:=20<202607
	 30002107.447471-1-mail@david-bauer.net>;
	b=BQ5VEob/+CEPQn/xD4QummtGOf50Pg8+Sy+bCqs2c6H/YaYCWLT84IHgPrepgheab
	 OWxpTxX/OWFv2YwccISy00m58U4CRKzlfCWuQD2HoK06hguxJ4f+S2L/qiDAD7K0zk
	 HHS+lqH6P/XyHQtH53JEpr5PM+EJhJ23aFMLdeMWbWjKA2IKIgHahlIauvhXOgbwEU
	 Dr+G+MuSUp5/Gts8CotIdf1X1o0DzdtoVpFJG29RBpUwotqtyOyX0EIzX47Dp7a1Yg
	 APZq5ftacQqsPFK2RbkSSsohkP0kB3ifD4PAZbj++Eech5Gj24Oyu+PpyRdSbGBqh8
	 jAECVogX8evCw==
Date: Tue, 4 Aug 2026 09:03:35 +0100
From: Tom Parkin <tparkin@katalix.com>
To: David Bauer <mail@david-bauer.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] l2tp: account for IP version in SKB
 headroom
Message-ID: <anGc1075Aw1EB7PG@katalix.com>
References: <20260730002107.447471-1-mail@david-bauer.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gMbjqxlPp9CFpvop"
Content-Disposition: inline
In-Reply-To: <20260730002107.447471-1-mail@david-bauer.net>


--gMbjqxlPp9CFpvop
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On  Thu, Jul 30, 2026 at 02:21:04 +0200, David Bauer wrote:
> Account for the IP version of the tunnel when accounting skb headroom on
> xmit. This avoids having to potentially copy the skb a second time down
> the stack due to allocating not enough space for IPv6 headers in case
> the tunnel uses IPv6.
>=20
> Signed-off-by: David Bauer <mail@david-bauer.net>
> ---
>  net/l2tp/l2tp_core.c | 3 ++-
>  net/l2tp/l2tp_core.h | 1 +
>  net/l2tp/l2tp_eth.c  | 9 ++-------
>  3 files changed, 5 insertions(+), 8 deletions(-)
>=20
> diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
> index 4712cc41881a3..d6fa0f7436629 100644
> --- a/net/l2tp/l2tp_core.c
> +++ b/net/l2tp/l2tp_core.c
> @@ -1237,7 +1237,7 @@ static int l2tp_xmit_core(struct l2tp_session *sess=
ion, struct sk_buff *skb, uns
>  	 * make room. Adjust truesize.
>  	 */
>  	uhlen =3D (tunnel->encap =3D=3D L2TP_ENCAPTYPE_UDP) ? sizeof(*uh) : 0;
> -	headroom =3D NET_SKB_PAD + sizeof(struct iphdr) + uhlen + session->hdr_=
len;
> +	headroom =3D NET_SKB_PAD + tunnel->l3_overhead + uhlen + session->hdr_l=
en;
>  	if (skb_cow_head(skb, headroom)) {
>  		kfree_skb(skb);
>  		return NET_XMIT_DROP;
> @@ -1688,6 +1688,7 @@ int l2tp_tunnel_register(struct l2tp_tunnel *tunnel=
, struct net *net,
>  	}
> =20
>  	sk->sk_allocation =3D GFP_ATOMIC;
> +	tunnel->l3_overhead =3D kernel_sock_ip_overhead(sk);
>  	release_sock(sk);
> =20
>  	sock_hold(sk);
> diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
> index ffd8ced3a51ff..aab574376d95f 100644
> --- a/net/l2tp/l2tp_core.h
> +++ b/net/l2tp/l2tp_core.h
> @@ -167,6 +167,7 @@ struct l2tp_tunnel {
>  	u32			tunnel_id;
>  	u32			peer_tunnel_id;
>  	int			version;	/* 2=3D>L2TPv2, 3=3D>L2TPv3 */
> +	int			l3_overhead;	/* IP header overhead */
> =20
>  	char			name[L2TP_TUNNEL_NAME_MAX]; /* for logging */
>  	enum l2tp_encap_type	encap;
> diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
> index a4956ef9574cc..9e5f9deac08cf 100644
> --- a/net/l2tp/l2tp_eth.c
> +++ b/net/l2tp/l2tp_eth.c
> @@ -188,7 +188,6 @@ static void l2tp_eth_adjust_mtu(struct l2tp_tunnel *t=
unnel,
>  				struct net_device *dev)
>  {
>  	unsigned int overhead =3D 0;
> -	u32 l3_overhead =3D 0;
>  	u32 mtu;
> =20
>  	/* if the encap is UDP, account for UDP header size */
> @@ -197,11 +196,7 @@ static void l2tp_eth_adjust_mtu(struct l2tp_tunnel *=
tunnel,
>  		dev->needed_headroom +=3D sizeof(struct udphdr);
>  	}
> =20
> -	lock_sock(tunnel->sock);
> -	l3_overhead =3D kernel_sock_ip_overhead(tunnel->sock);
> -	release_sock(tunnel->sock);
> -
> -	if (l3_overhead =3D=3D 0) {
> +	if (tunnel->l3_overhead =3D=3D 0) {
>  		/* L3 Overhead couldn't be identified, this could be
>  		 * because tunnel->sock was NULL or the socket's
>  		 * address family was not IPv4 or IPv6,

Minor nit: now that kernel_sock_ip_overhead() is called by
l2tp_tunnel_register() at a point where sk cannot be NULL, this
comment becomes misleading.

It'd be worth rewording to be accurate in the context of this
patch IMO.

> @@ -212,7 +207,7 @@ static void l2tp_eth_adjust_mtu(struct l2tp_tunnel *t=
unnel,
>  	/* Adjust MTU, factor overhead - underlay L3, overlay L2 hdr
>  	 * UDP overhead, if any, was already factored in above.
>  	 */
> -	overhead +=3D session->hdr_len + ETH_HLEN + l3_overhead;
> +	overhead +=3D session->hdr_len + ETH_HLEN + tunnel->l3_overhead;
> =20
>  	mtu =3D l2tp_tunnel_dst_mtu(tunnel) - overhead;
>  	if (mtu < dev->min_mtu || mtu > dev->max_mtu)
> --=20
> 2.53.0
>=20
>=20

--=20
Tom Parkin
Katalix Systems Ltd
https://katalix.com
Catalysts for your Embedded Linux software development

--gMbjqxlPp9CFpvop
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEsUkgyDzMwrj81nq0lIwGZQq6i9AFAmpxnNEACgkQlIwGZQq6
i9CL8Af/X1ODwav7TlEPchULqL0srjMpELEyXklyb6l+D5dkOYru/WbOr8SZUrPr
EyReRQFcmdjJpKm+Ui4PUrpQLxJG/iufuySHn59dos/j4zFNJtoXMC2r/BrvZz6D
e6X8tfDvmVD5YJXcsOsiO+JBinWmlnrkUux2nz35zh1bhz3e4YvnDfy+JHFLvzum
loq76L9qiauwu7iwCyHbZxb8yLBb09NZ5rt8mahiH/20d9k+Dw5dzdqGNtiisyfE
mBVv6+Mg+km6YqTiSTqqeW277cfOLXIlbOJJYpqfpLn2b8cgOCm+mV5ZklD02vi4
oWzrKN8LvfgcjKrAMbQ2zXXxrTtu9A==
=bDrI
-----END PGP SIGNATURE-----

--gMbjqxlPp9CFpvop--
