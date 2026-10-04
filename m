Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166F41FA859
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 07:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791097866; cv=none; b=qoZjAV28CCZS0CS8KdRPCFjGVZ+eMLZA8mZz07aHHzYTA6uYBmWhxDgWVMWQtaq+6Zeqm6xBf22xxwWIJsquUsLEFontf2TE0Sgq3Z/gI7vmr5qrSWI37s6bNkAIaLNppED98rGf6uRuiEB9ojKyOl338kpw11JldRlvTNd63nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791097866; c=relaxed/simple;
	bh=GoZ7T7tLH1T9za16zCSu+08nP/Cu++Q6ZWPHg24DHpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AhKafgFs/KUJTB4fht4uAg3fM/D0j/hVY8WflqJHePpeWBdgKEASa0Nf28l6NSGIAPULkI6sBA0/bhQdWPAKO42JFczqoki2AaiRSRVFn+pCQr4s5I7CKusPYf78AI9p/1sLT8l2wSULgbJAzYFNvSlV9T3iV13hcaf02Ssl6oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2/Hvzwx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2/Hvzwx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9574E1F0089A
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 07:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791097864;
	bh=7T4xZvPQ2ejrFQKPixJnw/LEfm+i70LucUBLJa86Sa0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=U2/HvzwxDBPlt8MMwG5bfx/A/6QMa26UZAL/bT59hDCcpqvtx90Hw/CwD27TPkUf8
	 4bx0lq1NDMxt3/HlB/m7JHzLOfsHxEuxO+Ns9p2jIOULShXT5dsGG6ov7n8S3O8GYs
	 Mx/zDEuO3xVMTG9Bsa5HNWw/kRs18DdoNBc+0Hfj/T3xyAvGQiICwy92mQeJfsGQre
	 gW7iQORSdUXLNhHa/Y7F15TGpB7pKJXw/aknY6sHi/b79ONQ2IGbIePTNwwXFuGbsQ
	 zV3Oc2ynjkwWzmSnhhqg/9shBTagthTZQJBDSdJ7uNWNTvqzFxhKdgOrDwmUXvui6U
	 8PfOZXFLetI3g==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-823b938464fso999945a34.2
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 00:11:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzTuJuAkflcdWb/witONB5RYGg77vcpweBQuq0m6f82n5i9SSME2ZJV2KJQ5m0KsVNvAcrcUZE=@vger.kernel.org
X-Gm-Message-State: AFuF++mv016XrhKTp67uYsTaclloqyvRiLQ2utk+KYABpJ19VDgwXRUL
	A4CJuwdXkmQUPhiClPpwWcGaFSwxkPfYOG52a/wctQLghf4rXu0Ir33WOKO+YMq2BO7Zy3NTuWK
	59fK7N5dP3OvgwcLTZz5hdSPM610m5n0=
X-Received: by 2002:a05:6870:65ab:b0:494:502e:f003 with SMTP id
 586e51a60fabf-49e3a933191mr2865032fac.31.1791097863765; Sun, 04 Oct 2026
 00:11:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119112512.28196-1-fw@strlen.de> <20260119090629.20d202e8@kernel.org>
 <CANn89iJOz_PQ_N4e=FS+toEDfLw-Ei9SwV6LU9Jmsvhtyxb7SQ@mail.gmail.com>
 <aW7FvS8wE2zNDDZ2@strlen.de> <20261003220513.107668-1-littlesmilingcloud@gmail.com>
In-Reply-To: <20261003220513.107668-1-littlesmilingcloud@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Sun, 4 Oct 2026 09:10:52 +0200
X-Gmail-Original-Message-ID: <CAL4WiioJWH+AycYbE-BAh_yPQqfyotvYm9bvhMRnYqbfY8=kfQ@mail.gmail.com>
X-Gm-Features: AclHuK-K_-ERWb8IdC64JLa2PpxUJOqhFDZxLhWGYmsK_VlO4Y38jnHfVjaaihw
Message-ID: <CAL4WiioJWH+AycYbE-BAh_yPQqfyotvYm9bvhMRnYqbfY8=kfQ@mail.gmail.com>
Subject: Re: [PATCH net v3] ip6_gre: use skb_vlan_inet_prepare() instead of pskb_inet_may_pull()
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: Florian Westphal <fw@strlen.de>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Mazin Al Haddad <mazin@getstate.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le dim. 4 oct. 2026 =C3=A0 00:05, Anton Danilov
<littlesmilingcloud@gmail.com> a =C3=A9crit :
>
> On Tue, Jan 20, 2026 at 01:01:01AM +0100, Florian Westphal wrote:
>
> > It has to be either true or false depending on test case 8-/
> >
> > gre_gso.sh needs this to be set to true, skbs don't have a mac
> > header: with "false": skb nhoff gets munged from 0 to 14.
> >
> > But in mirror_gre.sh test case, skbs do have a mac header:
> > "true" munges nh offset from 14 to 0 and test fails.
>
> Sorry for reviving an old thread: the syzbot report is still open and
> net still has pskb_inet_may_pull() in both functions.
>

Do not be sorry, thanks a lot for working on this.

Please send a V4 (and take full ownership of this patch now you made
significant progress)

Thanks again!

> The two tests use different devices behind the same
> ip6gre_tunnel_xmit(): ip6gre (no MAC header) in gre_gso.sh and
> ip6gretap (ARPHRD_ETHER) in mirror_gre.sh. So the argument can
> follow the device type, as vxlan does with no_eth_encap:
>
>         skb_vlan_inet_prepare(skb, dev->type !=3D ARPHRD_ETHER)
>
> ip6erspan is always ARPHRD_ETHER, so false there, as Eric had it.
>
> Tested on net (6e0022b5ae3d), changing only ip6_gre.c:
>
>   ip6gre, ip6erspan     gre_gso.sh          mirror_gre.sh
>   --------------------------------------------------------------
>   unpatched             pass                pass
>   false, false (v2)     2 GSO tests fail    pass
>   true,  true (v3)      pass                2 ip6gretap tests fail
>   true,  false          pass                2 ip6gretap tests fail
>   diff below            pass                pass
>
> The selftests only check that normal traffic still goes. They don't
> send short tagged frames, so they do not hit this bug. The bug needs
> such a frame: a 20 byte tagged frame on ip6gretap and a 10 byte frame
> on ip6erspan are sent out on net, and dropped with the diff. An untagged
> frame that is too short for its IP header is already dropped by
> pskb_inet_may_pull(); the diff only applies the same rule to tagged
> frames.
>
> The diff also fixes two problems I found while testing:
>
> 1. On transmit, skb->mac_len is still that of the receiving device,
>    and the VLAN walk starts from it. A packet that came in on an NBMA
>    ipgre device (mac_len 24) and is routed to a VLAN on ip6gretap has
>    its walk start inside the inner IPv4 header. On net the tag is
>    then missed and nothing is inherited; with skb_vlan_inet_prepare()
>    alone, a crafted packet also gets its traffic class from the wrong
>    byte. The diff clears skb->mac_len for Ethernet devices.
>
> 2. ip6gre without a remote has header_ops, so skb->data points at the
>    pseudo header from ip6gre_header(). With true, the network header
>    lands on it, and an ICMPv6 error then quotes its unwritten bytes
>    (KMSAN in icmpv6_push_pending_frames()). The diff keeps
>    pskb_inet_may_pull() there, as in net.
>
> With the diff, gre_gso, l2_tos_ttl_inherit and
> mirror_gre{,_vlan,_bridge_1q,_changes} pass. KMSAN, run with my
> other GRE fixes on top, shows nothing on these paths.
>
> About Fixes: v3 blames d8a6213d70ac ("geneve: fix header validation
> in geneve[6]_xmit_skb"). That commit only added
> skb_vlan_inet_prepare(); the bug in ip6_gre is older.
>
> The length check, pskb_inet_may_pull(), looks at skb->protocol. For
> a tagged frame that is ETH_P_8021Q, so the inner IP header is not
> checked at all. This used to be fine: the code after the check also
> used skb->protocol, so tagged frames went to ip6gre_xmit_other(),
> which does not read the inner header.
>
> Two later commits made the code look through the tags, but did not
> change the check:
>
>  - 3f8a8447fd0b ("ip6_gre: use actual protocol to select xmit") made
>    ip6gre_tunnel_xmit() switch on skb_protocol(skb, true). Tagged
>    IPv4 and IPv6 frames now go to ip6gre_xmit_ipv4() and
>    ip6gre_xmit_ipv6(), which read the inner header.
>
>  - b09ab9c92e50 ("ip6_tunnel: allow to inherit from VLAN encapsulated
>    IP") did the same in ip6_tnl_xmit(), which reads the inner header
>    to inherit the hop limit. ip6erspan goes through this path too.
>
> Since then a short tagged frame passes the check, and its inner
> header is read from bytes that were never pulled into the linear
> data. That is the uninit-value syzbot reports.
>
> skb_vlan_inet_prepare() walks the tags the same way as
> skb_protocol(skb, true), pulls the inner IP header and points the
> network header at it. So the check now covers what the code reads
> later. That is why I would point Fixes at the two commits above:
>
> Fixes: 3f8a8447fd0b ("ip6_gre: use actual protocol to select xmit")
> Fixes: b09ab9c92e50 ("ip6_tunnel: allow to inherit from VLAN encapsulated=
 IP")
>
> The IPv4 side has the same problems: gre_tap_xmit(), erspan_xmit()
> and ip_tunnel_rcv(). ip6_tnl_xmit() has one more: it walks the tags
> after the GRE header is pushed. I will send these fixes separately;
> the ip6_tnl_xmit() one depends on this patch.
>
> Eric, would you like to respin with this, or should I send it as v4?
>
> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index e61cb10b50dc..f48141820fb5 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -883,8 +883,22 @@ static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff=
 *skb,
>         __be16 payload_protocol;
>         int ret;
>
> -       if (!pskb_inet_may_pull(skb))
> -               goto tx_err;
> +       if (dev->type !=3D ARPHRD_ETHER && dev->header_ops) {
> +               /* ip6gre_header() has pushed a pseudo header in front of
> +                * the packet, so skb->data is not where the packet start=
s.
> +                */
> +               if (!pskb_inet_may_pull(skb))
> +                       goto tx_err;
> +       } else {
> +               /* The VLAN tag walks below start at skb->mac_len - VLAN_=
HLEN,
> +                * or at ETH_HLEN if it is 0, and a forwarded skb still h=
as
> +                * the mac_len of the device it was received on.
> +                */
> +               if (dev->type =3D=3D ARPHRD_ETHER)
> +                       skb->mac_len =3D 0;
> +               if (skb_vlan_inet_prepare(skb, dev->type !=3D ARPHRD_ETHE=
R))
> +                       goto tx_err;
> +       }
>
>         if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
>                 goto tx_err;
> @@ -934,7 +948,12 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_b=
uff *skb,
>         __u32 mtu;
>         int nhoff;
>
> -       if (!pskb_inet_may_pull(skb))
> +       /* The VLAN tag walks below start at skb->mac_len - VLAN_HLEN, or=
 at
> +        * ETH_HLEN if it is 0, and a forwarded skb still has the mac_len=
 of
> +        * the device it was received on.
> +        */
> +       skb->mac_len =3D 0;
> +       if (skb_vlan_inet_prepare(skb, false))
>                 goto tx_err;
>
>         if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
>
> --
> Anton Danilov
>
