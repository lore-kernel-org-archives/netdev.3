Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABB93101A6
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 07:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787470970; cv=pass; b=YyGcqA8fJ/Sps2zXzVO6lZDichosZEbAhpm2TuymPiOYr0RjveZk7mZ17VndYM6YVD+YhN4I0w61rw0moO9ERQjWU8xN/F2O9b8sHGcOs5iMkbmpiloIpc3F+rn3m/FDnrYooPSm5QKst0Kw5RoJod7rSoWg/HCwBQZpYFaymvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787470970; c=relaxed/simple;
	bh=iZLa9HXd4kU1GXbQg9lSu+H7QZyfF+DTXLWBMc6zZ5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tgWyHWzhUylWYSlMfQrEap1J2Pwp8aPCuOXeSztgFPq1wgPgpBNmu0d0UL0D5yYtG0C3+xEa8s8gjqH5cNFU368/8gvduRt/EmONYe4Qb+GcbgR2+lzt1fAqDswDZjyFU5AuEKeBjah8613EpZ/jiF8qLp5h9FyzudoKlUsje/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=nflTc6BD; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="nflTc6BD"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b015b2d792so2437125e87.3
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 00:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787470965; cv=none;
        d=google.com; s=arc-20260327;
        b=ZIa1szjqY15jbLxsS2M2d/6qwMagEfhiDcmlUxZk2j5JL6xPHwUQFKq6DZWq4LD1CB
         FgProOqqg1q5KhZ7IoNG/z/7TKo039IzkOd3rMldlTEvN5kkXr+2/0Ili3oFQgkkD1rf
         DhehTJzFKQfMVe0g14382c8exb0EBDf0q3pw0iDJBOBfojF5O6s0RGId6PeAHlZ+o1PB
         8gvFtNiydBDE8ZUNhZySIcI2LUUm8PLEbF5jbglcIlSfx7HUkXpLG85mHFwWrUmDAzyj
         JSWFrBLzKem3OInAdi6kWUb/B8ebQDMPmGv84dW2gIxPF+j1uXHso8Y/Ma7JnvfSbcza
         vtWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZIXe1/OfraU4vJY9+KRuKmSL65qK+92J/1UICFbNvbM=;
        fh=Hz6BoFgiwLzFJffdOcyS5KPozp6lnXe+3Y7NJNpdd0Y=;
        b=Nuy7DtfEhaARrWuhWeDSp1NvC7UyrXcAUljPNZmEiSuaamOS1ihXFJos8FpayrlM5U
         FV97Mn0ErTQlDsNJ6EzUiA4um6zeCwYO2ksvvVwSCMCqwvCkHv4G0MA4mli19EF2PfZN
         RdVev/cBZ8uMONFneg+/QaURuxEj68ggl8gk9TtdjvHWc23/yX4fDtnEhgVMqerhgki9
         BG7EhEyUAWVqVX/FlqxnpIPvvv3AWuvy/oy7kty9tgJ7XJSY7/oktFEhJiX52h3teHG8
         zol0bMCTSZ991LV6BFroaar9XGZGzsmMiiiSxtSAI1kA22EDymtdP4VwrWjLialhUP9y
         3sSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787470965; x=1788075765; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZIXe1/OfraU4vJY9+KRuKmSL65qK+92J/1UICFbNvbM=;
        b=nflTc6BDliU6TIePcDGxqBpRt7a/9a2uVFl3wb/gl5RcjKTQwOhyRzkdcj3DibWdHt
         SgWiZ+GfRgCAbTaywdPRR4r+SfZSSJ7BGyAXlCkAhVylPIgrt2ziE43pDyZeLtlOBnGJ
         cc982sVksnhAu7UzSxJHjQHNZ/P0NdiJ6oSv3uH5SqV1/PPkAG8BB1H3z8WKoQtr2+mv
         XjrTcgIln1Y1kx19YeFks7FIP+t6LfvyjQAtyACVWt+57LopG7IJhaeX87V9lMqS63er
         ZvXeWXqh7NBmPMfXCfdir/VezM6ENlSJkQw46fJqq94xsXmWZUSf6UsT7D3MT08RYbt5
         6GUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787470965; x=1788075765;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZIXe1/OfraU4vJY9+KRuKmSL65qK+92J/1UICFbNvbM=;
        b=eDKD/2PuMfZAixduIDq9J7Eh6biIpkPs9UdnNaVeLm3ih1ETUcZF16T1r6Vjoi5h8r
         2/QICAELjkUS5tOdrORxkf9UpT1rbSp2/2vQRJasTyAob2Aq4xGdvb/91rlPov0vvqMP
         luABOKvP9JUu/h2ut4juZpnxixd+ygBGxIlhLBbgFz0UV3LiLjxYRrEsvAQzoNZE8Y9N
         Rwo2TFsguJcYnNZP1WXrJtNRQnajitDpvMXnIuZf56qNfSiF+Ag2AuFpVj5t0Ix/4E0M
         MjBCqIvFLUOzuxqbHuPup74717mzpX+dyhfkwQkVi9ELMeZ74B/ySwtNtEy3G1WxWesI
         f9Rw==
X-Forwarded-Encrypted: i=1; AHgh+RqrHtJrqEF/nqmyQ94vna/kpNiGgSGz4s8yJkm4xHCGScwfbRm8pLSGdN5tD1l95/Hp1jLnFAw=@vger.kernel.org
X-Gm-Message-State: AFuF++koUt3Xza2s+QSl3Lt6O9u80GLh4kkeA6f4hU2wz3f/9UbQzX6F
	9TdB6rhv5T8MJkwNlakO4Npo7xTZe+W0NaV6M+vgYmdmhWc+EUB7Xn7W6rq2I9xHNkYuUN60uQA
	L7/5ogNxD0TKN+zCzPvxiuWwVynsi8MyZt/2XNTyUNmc=
X-Gm-Gg: AR+sD12DdBjpvS8SJFE8vB69AEWeAEy2dG+pZldonK2RboLMcoPSeLziaYJwqZqqxAn
	8g5TCkc5lhT1eqQtT1RgbS6a7X7r/olVM2qvk9h1gs7UBK8LB3F2UNaQE9hioP/CvPdzJa5xB1j
	08w+QCPIe8oiKaUpzYoUgu4+IOossSUjWJAX6mqFL/kTncnb7kZUA+qH7AJhYFwfD0QLPoX6mJ0
	8wOlM1kn6Qi7k4n7R6jqnBf3LLXHMzVmV5RfwCYmX+U27CafmclNDuaywa3//T/6yY7EChPaPQA
	ssfKaF/y13ZpfBwxu3jtv25OfFrjJ/oQOWV/nfRtjqg=
X-Received: by 2002:a05:651c:43d1:20b0:3a1:31c3:961d with SMTP id
 38308e7fff4ca-3a1aec64cb2mr30527711fa.10.1787470964768; Sun, 23 Aug 2026
 00:42:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787381531.git.zhilinz@nebusec.ai> <db594f875fdac39aff6f4f44dd1e270b0ce5ad4c.1787381531.git.zhilinz@nebusec.ai>
In-Reply-To: <db594f875fdac39aff6f4f44dd1e270b0ce5ad4c.1787381531.git.zhilinz@nebusec.ai>
From: zhilin zou <zhilinz@nebusec.ai>
Date: Sun, 23 Aug 2026 15:42:31 +0800
X-Gm-Features: AcwNN1Xv2ziO9z1i63XvEZZgv_ZKEjr906MakG-vn61ioIfd5BVbpqtKdnpl-Fk
Message-ID: <CANB6i5wG6_K_J-MvXetoE0-4B893_V3S43OZ+x5uHjkdwxe+jg@mail.gmail.com>
Subject: Re: [PATCH net v3 1/1] xfrm: save input state data before secpath resets
To: steffen.klassert@secunet.com, netdev@vger.kernel.org
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2026 at 3:03=E2=80=AFPM Zhiling Zou <zhilinz@nebusec.ai> wr=
ote:
>
> From: Zhiling Zou <zhilinz@nebusec.ai>
>
> xfrm_input() keeps the current state reference through the skb secpath
> while it performs final transport processing. Some input paths can reset
> the secpath before xfrm_input() is done using data from that state.
>
> Receive callback users such as VTI and XFRM interfaces can scrub packets
> that cross network namespaces by resetting the secpath. The

Hi Sashiko,

Thanks for the review. The finding is correct.

vti_rcv_cb() calls skb_scrub_packet(), which resets the skb extensions
before checking xnet. Therefore, the VTI receive path drops the secpath
regardless of whether the packet crosses network namespaces.

The cross-network-namespace qualifier only applies to the XFRM interface
path, where xfrmi_scrub_packet() calls secpath_reset() only when xnet is
true.

I will update the wording in the next revision to distinguish the two
cases. No code change is needed for this finding.

Thanks,
Zhiling

> XFRM_MAX_DEPTH error path can also reset the secpath before the final dro=
p
> callback reports the current state's protocol. If that drops the last
> state reference and the state is concurrently deleted, xfrm_input() can
> still dereference the freed state.
>
> Save the state protocol on the stack while the state is still valid, and
> use the already saved address family for transport_finish(). A larval
> XFRM_STATE_ACQ state has no type, so retain nexthdr as its protocol. This
> preserves the existing drop-path fallback while avoiding the post-reset
> state dereferences without adding an extra state reference to every
> received packet.
>
> Fixes: df3893c176e9 ("vti: Update the ipv4 side to use it's own receive h=
ook.")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---
> changes in v3:
> - Retain nexthdr for larval XFRM_STATE_ACQ entries, whose x->type is NULL=
.
> - Avoid dereferencing x->type before the existing state validity checks.
> - v2 Link: https://lore.kernel.org/all/e59b617d27acb3a38a3523649d52b90f02=
2fa28d.1785288865.git.zhilinz@nebusec.ai/
>
> changes in v2:
> - Avoid per-packet xfrm_state refcounting by saving state data on the sta=
ck.
> - Use the saved protocol and family after secpath resets instead of
>   dereferencing x.
> - v1 Link: https://lore.kernel.org/all/89be67de93958a00193c8c4bd668733c97=
6e2aa9.1785135576.git.zhilinz@nebusec.ai/
>
>  net/xfrm/xfrm_input.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index eecab337bd0a7..77b9f4d4568d6 100644
> --- a/net/xfrm/xfrm_input.c
> +++ b/net/xfrm/xfrm_input.c
> @@ -474,6 +474,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be=
32 spi, int encap_type)
>         struct xfrm_state *x =3D NULL;
>         xfrm_address_t *daddr;
>         u32 mark =3D skb->mark;
> +       u8 xfrm_proto =3D nexthdr;
>         unsigned int family =3D AF_UNSPEC;
>         int decaps =3D 0;
>         int async =3D 0;
> @@ -485,6 +486,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be=
32 spi, int encap_type)
>         if (encap_type < 0 || (xo && (xo->flags & XFRM_GRO || encap_type =
=3D=3D 0 ||
>                                       encap_type =3D=3D UDP_ENCAP_ESPINUD=
P))) {
>                 x =3D xfrm_input_state(skb);
> +               xfrm_proto =3D x->type ? x->type->proto : nexthdr;
>
>                 if (unlikely(x->km.state !=3D XFRM_STATE_VALID)) {
>                         if (x->km.state =3D=3D XFRM_STATE_ACQ)
> @@ -592,11 +594,13 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __=
be32 spi, int encap_type)
>
>                 x =3D xfrm_input_state_lookup(net, mark, daddr, spi, next=
hdr, family);
>                 if (x =3D=3D NULL) {
> +                       xfrm_proto =3D nexthdr;
>                         secpath_reset(skb);
>                         XFRM_INC_STATS(net, LINUX_MIB_XFRMINNOSTATES);
>                         xfrm_audit_state_notfound(skb, family, spi, seq);
>                         goto drop;
>                 }
> +               xfrm_proto =3D x->type ? x->type->proto : nexthdr;
>
>                 if (unlikely(x->dir && x->dir !=3D XFRM_SA_DIR_IN)) {
>                         secpath_reset(skb);
> @@ -604,6 +608,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be=
32 spi, int encap_type)
>                         xfrm_audit_state_notfound(skb, family, spi, seq);
>                         xfrm_state_put(x);
>                         x =3D NULL;
> +                       xfrm_proto =3D nexthdr;
>                         goto drop;
>                 }
>
> @@ -728,7 +733,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be=
32 spi, int encap_type)
>         } while (!err);
>
>         rcu_read_lock();
> -       err =3D xfrm_rcv_cb(skb, family, x->type->proto, 0);
> +       err =3D xfrm_rcv_cb(skb, family, xfrm_proto, 0);
>         if (err) {
>                 rcu_read_unlock();
>                 goto drop;
> @@ -753,7 +758,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be=
32 spi, int encap_type)
>                         xfrm_gro =3D xo->flags & XFRM_GRO;
>
>                 err =3D -EAFNOSUPPORT;
> -               afinfo =3D xfrm_state_afinfo_get_rcu(x->props.family);
> +               afinfo =3D xfrm_state_afinfo_get_rcu(family);
>                 if (likely(afinfo))
>                         err =3D afinfo->transport_finish(skb, xfrm_gro ||=
 async);
>                 if (xfrm_gro) {
> @@ -776,7 +781,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be=
32 spi, int encap_type)
>  drop:
>         if (async)
>                 dev_put(dev);
> -       xfrm_rcv_cb(skb, family, x && x->type ? x->type->proto : nexthdr,=
 -1);
> +       xfrm_rcv_cb(skb, family, xfrm_proto, -1);
>         kfree_skb(skb);
>         return 0;
>  }
> --
> 2.43.0
