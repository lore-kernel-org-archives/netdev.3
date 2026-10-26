Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793017259;
	b=q4sBwc+1pJ3magCXMLKPKxU3kTXtiGOYPVrGgpSJhQuKG1UKB0Y/sUN1W5Ay36a8tSbH
	 dPcPQtNzST0X0J9MTflmjdojbk2mrZrFzOPRM8Ydxi7voCB/xpj+Rn0uiXj/WV5CeNdo1
	 zf7MRnYkeaVuCCUICizjszutU+RDnTnMM74zvbpqFn+dJ+LXvPzF6EhI2aAJ2+0Ihj4k2
	 qfzHeiovfdUv0x/Ou8F32/nrkQ1gZfwvLnfKrVEDi6o5HNcbCX7arpZSzE7OrF7QfDFbI
	 AtAevYqYn/iANqF9Vrdf/OBEPiNjLGy93Cid2Fu0fHHBS8BVinDW9knxeKEWt9PRBDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793017259;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=LcYC0pcqWmk2zKW9GbD/mLvZ8FSSvOFC4LfgOjlwTnA=;
	b=xHg7eoR6OTMtOPopnGNgX4240qrGzLqqdT5tqn98ZQeToEThghsAmhn5yezZY3gc8x42
	 Y7okCWsL5MbUrIu24b8N2IM4gUIjDXZ7En7KD2WHV4XjmIzY+0XJLZc2vFYUGNt5MHUEu
	 Dv7d5VnHirZTf+cXTWyYicXdy2+FKPYtmmzdcvwMLVuxZyzveDcxzkRtK+XmXQ2XEClpN
	 2vApI1wIQal51sYDF7lHgnp95PxExftkq9A3tfF5TH7Of5TanEop/Mav1+n867xyxFLcp
	 11z5W7npmPVJEAW+4snMeSutYSdOFS+IE2x30a1nwTCL6CFYLIdbR9fpmDXlnDZC+gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bhX7m79q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D0B606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 12:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bhX7m79q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6670E1F01828
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 12:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793017258;
	bh=LcYC0pcqWmk2zKW9GbD/mLvZ8FSSvOFC4LfgOjlwTnA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bhX7m79q4A0VANpZHq1k4f+ls9oW2b1KkcxTswPRT7tnz6BZrCUDSxG7W9Z9dkECO
	 nLzEmcSlj+2MRhqYW6skTsTtdoqRsEd1K3J5ZOuUo3yOgMCc9525jGNxRzaxAP5VRO
	 /ra5HE6reUUOScJMqXlu8bpFXMFNTsAEUUI/AF46VQouBG0yhXQ5g8SuKcws8sia0i
	 +W+sU4sfN9wOg4jrsEKspuodrBtpoUDNqfa7cnSoGUjl2se5eUq91SriNb0vJBrgDk
	 badDl/08Jtl31tOS8DhA3lcl3ZevU4uRWAZdOp3E+cIwJVN2FRIQEUdai4Z4ZTlRbR
	 xkMvRcvF4mseA==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7fccba9c675so4704519a34.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 05:20:58 -0700 (PDT)
X-Gm-Message-State: AFq9FYLvmBj7OBnF6ShifPLQaaeADcvYluuXyw8S4JPT37BlQTWnF/cj
	ZFSj/bB3yu9t5Rrn+tGiQb6DCX70D7tL2fg34oaHdwdUTZzsydx+60v0gUkz5kLrvrCr8FvjO8Q
	b+3UtfumdX4XvGytjprMa0qBpvhBEvqc=
X-Received: by 2002:a4a:e90b:0:b0:6f7:3c09:c712 with SMTP id
 006d021491bc7-70ba0e4c7f8mr2956542eaf.18.1793017257699; Mon, 26 Oct 2026
 05:20:57 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <v2-20261026-cover@tencent.com> <98906F734B5D43DA+v2-20261026-p2@tencent.com>
In-Reply-To: <98906F734B5D43DA+v2-20261026-p2@tencent.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 26 Oct 2026 13:20:45 +0100
X-Gmail-Original-Message-ID: <CAL4Wiio2inRipSSWgFKkRjuPA=iLkynvWCXQ7cpe9G5XWi9=7Q@mail.gmail.com>
X-Gm-Features: AclHuK9gsL_KLEmGFhwsSJDJqQvxzS71W5_99m_JQBg-DTh0wFPoAQnbDZncqng
Message-ID: <CAL4Wiio2inRipSSWgFKkRjuPA=iLkynvWCXQ7cpe9G5XWi9=7Q@mail.gmail.com>
Subject: Re: [PATCH net 2/2] net/ipv4: fail append when the moved fraggap
 exceeds the fragment data
To: =?UTF-8?B?dGVuY2VudG9zX3NlY3VyZShUZW5jZW50T1PlronlhajlhazlhbHpgq7nrrEp?= <tencentos_secure@tencent.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Steffen Klassert <klassert@kernel.org>, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 26 oct. 2026 =C3=A0 12:23, tencentos_secure(TencentOS=E5=AE=89=E5=
=85=A8=E5=85=AC=E5=85=B1=E9=82=AE=E7=AE=B1)
<tencentos_secure@tencent.com> a =C3=A9crit :
>
> When the first fragment of a cork is already at maxfraglen, the next
> __ip_append_data() iteration relays the previous fragment's tail,
> fraggap =3D skb_prev->len - maxfraglen, into the new skb. The moved
> fraggap is charged against datalen by computing
>
>         copy =3D datalen - transhdrlen - fraggap - pagedlen;
>
> but once datalen is capped at maxfraglen - fragheaderlen it can become
> smaller than transhdrlen + fraggap. Then copy goes negative: no payload
> is copied and the iteration makes no progress. Worse, in the paged
> branch (MSG_SPLICE_PAGES / MSG_ZEROCOPY / GSO) pagedlen =3D datalen -
> transhdrlen - fraggap additionally wraps unsigned, breaking the
> alloclen + pagedlen =3D=3D fraglen invariant that commit eca856950f7c
> ("ipv4: account for fraggap on the paged allocation path") relies
> on; the loop then either queues skbs with garbage tail accounting
> (silent packet corruption) or, when maxfraglen =3D=3D fragheaderlen,
> never makes progress and grinds on until -ENOBUFS.
>
> Reject such an append before any allocation: if the moved tail
> (transhdrlen + fraggap) cannot fit in the fragment's datalen, the
> iteration cannot make progress, so fail with -EINVAL. This covers all
> three alloclen branches, including the paged one. With the preceding
> fix fraggap is bounded by the alignment slop, but the condition stays
> reachable with extreme geometries (e.g. an effective mtu too small for
> fragheaderlen + transhdrlen), so pin the geometry explicitly, as
> __ip6_append_data() has done since commit 232cd35d0804 ("ipv6: fix
> out of bound writes in __ip6_append_data()").
>

I do not think this is reachable once patch 1 is applied.

ip_setup_cork() rejects cork->fragsize < 68 (inetdev_valid_mtu()), and
fragheaderlen is at most 60, so a capped datalen is at least 8, and
maxfraglen =3D=3D fragheaderlen cannot happen.

transhdrlen is non zero only on the first iteration with an empty
queue, where fraggap is 0, and current callers pass at most 8 bytes
(UDP, ICMP, ping). On later iterations transhdrlen is 0 and, with
patch 1, fraggap <=3D mtu - maxfraglen <=3D 7.

So transhdrlen + fraggap > datalen can not be true.

Please give a concrete setup that reaches this check after patch 1,
or present the check as defense in depth matching
__ip6_append_data() and drop the Fixes: and Cc: stable tags.

> This cannot reject a send that would otherwise succeed: the guard only
> fires when transhdrlen + fraggap > datalen, which is exactly when copy
> would come out negative, or, on the paged branch, when pagedlen would
> wrap.  No send can get past an iteration with a negative copy -- no
> payload is copied, so the loop makes no progress.  All callers flush
> the cork on append error, and returning -EINVAL in mid-cork state
> already happens in this function (MSG_ZEROCOPY ubuf mismatch).
>
> Fixes: 353e5c9abd90 ("ipv4: Fix IPsec slowpath fragmentation problem")
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Anakin Zhang <tencentos_secure@tencent.com>
> ---
>  net/ipv4/ip_output.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index b84d56c..5db8b06 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -1105,6 +1105,11 @@ alloc_new_skb:
>                         fraglen =3D datalen + fragheaderlen;
>                         pagedlen =3D 0;
>
> +                       if (unlikely(transhdrlen + fraggap > datalen)) {
> +                               err =3D -EINVAL;
> +                               goto error;
> +                       }
> +
>                         alloc_extra =3D hh_len + 15;
>                         alloc_extra +=3D exthdrlen;
>
> --
> 2.55.0
>
