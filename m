Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792772506;
	b=wD9jdVSAc7B64/2NNNfVzHOxXCJhWViJdn4JXxawT7kCB8nphS6H4AJT3thPO4V7Xi+K
	 3VzxIsAR/31uRLif5SLVtmslPO54Tv3+QzjwYAXCBrkzRR20GC9Vf6AyQvIkvi8Z0gjZr
	 alt96+9cWrVEwcf5+b3sXNgIBOU/lTc2BBTzoRa5h+8gwStBZR4tVUF3Hroh3JtH5iUUO
	 IXxQFb/mwgzTI2LjcxZUPbhLLoofJ6btfc4ts0YyTZ9JkYkcAAvkwsa3MvFDOV5AgZYSq
	 iQjk6FprdwWuE03KOcMBdLsRU3gQtX3bGxtFFVufPQbVkkwd09nikCD75w/OhmA0r3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792772506;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Tf5fTI11AZRTr+M5HKlJWhT3pOd4N99OrUGmhNOVbAY=;
	b=fd1aih2vz67RZHZNytfpaRZEngaBje0lJ4626jPMY5SZCbRx759TVZpUmMJXxQ3LLjFw
	 2tmK9Aj2RAy9LrWlxYDWHgbY3gi8cPOA5ABOps28ceM+oVxVS1YV0f40XbA8yf/SMbpeI
	 8ijB75nl9TDwPVQHXuo+SYx11Yv6QNZnLf9Whkh+QjALobbPFJ5KWNXMRnMjQ4UhGtVDu
	 DgNG2mCGvxo2aur0wiNS6+qpIvEHbPxJ7ISGquIQz59XD5G5GqsNGudfmobrNDRIoHK/J
	 TSbl+H31jGGLR7Z8EEi/KkfPA9Wbly8QA8M9DLjcVU+DUh8pwcGMcHr8Xz+YA3zsk5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DUcydec6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DC2606A332
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DUcydec6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463AA1F01829
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 16:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792772505;
	bh=Tf5fTI11AZRTr+M5HKlJWhT3pOd4N99OrUGmhNOVbAY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DUcydec62e9Z3jYUjIG4gFSufzUGRWqeEbIBnl2OBWtlHo4cE25QZRLSrghtxwbUq
	 ROri1zrQJJLSuqyshoaW/qaXbVwFsuwVnWgPDo2kJBEnv6FQ4O0+VEq5miAbhWWVlF
	 a0rYju/WX5RpPu/qRA6CmEfJ+GRIjYGCygm3KLTEb4Mq7V2yung9VbrJ03Jn4TEns9
	 UHWJ0h61b3520cv9t82YjXbHHbnL5AcJ9mmf/mFvSnDPuBCH170sxdN4lBhFBqLs4X
	 1qqIRK0jYVDl85ttFrwjDScLAGOniple+HaFhRpvluFXPri/gfbtD1vs0KdhhBzGV1
	 YchQMHbNBTuMw==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-486f013db83so482583fac.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 09:21:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzvAdEk6aBbarwSNbeSNg4giWe8Xn/uHCtMxgm1XfxCd7/4P8ailsvP1PqjO9YqB5yN8B1QZgk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUyaSk+Q0DAuAy3ibulEpabjOG7Wlk9guaP5FdAq0ibLR161qM
	0uu6K2koa8wrX4rAVi2f6FnZJ0xt5rblrAbBoGnpbyReIEx+LG/UdJaaCEnrnop7dTf9skv7Jk6
	wru5Q3gLjNTTtl5JHT7LRcSPYcksQR+8=
X-Received: by 2002:a05:6871:79d:b0:48f:e24e:6b6a with SMTP id
 586e51a60fabf-4a8224ea80fmr1602443fac.61.1792772504596; Fri, 23 Oct 2026
 09:21:44 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023074515.2347924-2-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20261023074515.2347924-2-Jeremy.Jean@oss.cyber.gouv.fr>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 23 Oct 2026 18:21:33 +0200
X-Gmail-Original-Message-ID: <CAL4WiioOu48M55PUHNJY3B-e_PJVqc0BZYWmgpkDpFj=bz_5_Q@mail.gmail.com>
X-Gm-Features: AclHuK9JCAxJ-YMpRHctjjSF-nP7EZBfB7migQ3rYOkVPPQdYDjvEVAI0GVA6K0
Message-ID: <CAL4WiioOu48M55PUHNJY3B-e_PJVqc0BZYWmgpkDpFj=bz_5_Q@mail.gmail.com>
Subject: Re: [PATCH net] inet: frags: prevent acceptance of partially
 authenticated reassembly
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 23 oct. 2026 =C3=A0 09:45, J=C3=A9r=C3=A9my Jean
<Jeremy.Jean@oss.cyber.gouv.fr> a =C3=A9crit :
>
> A reassembled skb retains the secpath from its first fragment, which
> makes it possible for the final policy check to accept bytes that were
> not covered by the transform recorded on the skb. This can affect IPsec
> tunnel traffic, including AH and ESP, and allow a packet to be accepted
> even though only part of its payload was authenticated.
>
> Reject a fragment when its secpath differs from the fragments already
> in the queue, and keep overlap statistics limited to actual overlaps.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
>  include/net/inet_frag.h  |  1 +
>  include/net/xfrm.h       | 17 +++++++++++++++++
>  net/ipv4/inet_fragment.c |  5 +++++
>  net/ipv4/ip_fragment.c   |  3 ++-
>  net/ipv6/reassembly.c    |  3 ++-
>  5 files changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/inet_frag.h b/include/net/inet_frag.h
> index 365925c9d2628..b02d2472b003e 100644
> --- a/include/net/inet_frag.h
> +++ b/include/net/inet_frag.h
> @@ -171,6 +171,7 @@ extern const u8 ip_frag_ecn_table[16];
>  #define IPFRAG_OK      0
>  #define IPFRAG_DUP     1
>  #define IPFRAG_OVERLAP 2
> +#define IPFRAG_MIXED_SECPATH   3
>  int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *sk=
b,
>                            int offset, int end);
>  void *inet_frag_reasm_prepare(struct inet_frag_queue *q, struct sk_buff =
*skb,
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index a6d69aaa6cd2d..493faac0faa45 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -1201,6 +1201,23 @@ secpath_reset(struct sk_buff *skb)
>  #endif
>  }
>
> +static inline bool
> +secpath_equal(const struct sk_buff *skb1, const struct sk_buff *skb2)
> +{
> +       const struct sec_path *sp1 =3D skb_sec_path(skb1);
> +       const struct sec_path *sp2 =3D skb_sec_path(skb2);
> +       int i;
> +
> +       if (!sp1 || !sp2)
> +               return sp1 =3D=3D sp2;
> +       if (sp1->len !=3D sp2->len || sp1->verified_cnt !=3D sp2->verifie=
d_cnt)
> +               return false;

verified_cnt is policy check bookkeeping (written by
__xfrm_policy_check()), it says nothing about which states
authenticated the payload. I would only compare len and xvec[].

With the verified_cnt part removed:

Reviewed-by: Eric Dumazet <edumazet@kernel.org>



> +       for (i =3D 0; i < sp1->len; i++)
> +               if (sp1->xvec[i] !=3D sp2->xvec[i])
> +                       return false;
> +       return true;
> +}
> +
>  static inline int
>  xfrm_addr_any(const xfrm_address_t *addr, unsigned short family)
>  {
> diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
> index b286ee429da8f..c18da91c1f031 100644
> --- a/net/ipv4/inet_fragment.c
> +++ b/net/ipv4/inet_fragment.c
> @@ -23,6 +23,7 @@
>  #include <net/inet_ecn.h>
>  #include <net/ip.h>
>  #include <net/ipv6.h>
> +#include <net/xfrm.h>
>
>  /* Use skb->cb to track consecutive/adjacent fragments coming at
>   * the end of the queue. Nodes in the rb-tree queue will
> @@ -441,6 +442,10 @@ int inet_frag_queue_insert(struct inet_frag_queue *q=
, struct sk_buff *skb,
>  {
>         struct sk_buff *last =3D q->fragments_tail;
>
> +       /* The reassembled skb keeps the first fragment's secpath. */
> +       if (last && !secpath_equal(last, skb))
> +               return IPFRAG_MIXED_SECPATH;
> +
>         /* An IP fragment is never a GSO packet, but an untrusted source
>          * (virtio_net_hdr) may have attached GSO metadata to it. Do not =
let
>          * that reach the reassembled skb, whose head keeps the first
> diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
> index c790d2f494870..36105dd192823 100644
> --- a/net/ipv4/ip_fragment.c
> +++ b/net/ipv4/ip_fragment.c
> @@ -378,8 +378,9 @@ static int ip_frag_queue(struct ipq *qp, struct sk_bu=
ff *skb, int *refs)
>                 err =3D -EINVAL;
>                 goto err;
>         }
> +       if (err =3D=3D IPFRAG_OVERLAP)
> +               __IP_INC_STATS(net, IPSTATS_MIB_REASM_OVERLAPS);
>         err =3D -EINVAL;
> -       __IP_INC_STATS(net, IPSTATS_MIB_REASM_OVERLAPS);
>  discard_qp:
>         inet_frag_kill(&qp->q, refs);
>         __IP_INC_STATS(net, IPSTATS_MIB_REASMFAILS);
> diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
> index 05c51f669754a..53a685f5c6b7f 100644
> --- a/net/ipv6/reassembly.c
> +++ b/net/ipv6/reassembly.c
> @@ -240,8 +240,9 @@ static int ip6_frag_queue(struct net *net,
>                 err =3D -EINVAL;
>                 goto err;
>         }
> +       if (err =3D=3D IPFRAG_OVERLAP)
> +               __IP6_INC_STATS(net, idev, IPSTATS_MIB_REASM_OVERLAPS);
>         err =3D -EINVAL;
> -       __IP6_INC_STATS(net, idev, IPSTATS_MIB_REASM_OVERLAPS);
>  discard_fq:
>         inet_frag_kill(&fq->q, refs);
>         __IP6_INC_STATS(net, idev, IPSTATS_MIB_REASMFAILS);
> --
> 2.47.3
>
