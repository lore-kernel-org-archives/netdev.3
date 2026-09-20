Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7793A3469E7
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 01:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789867686; cv=pass; b=dWRy2hWzrkmrheMpZ6gp1FY48W71uHR+uNKb4Bx74vXlcNMbKikfDRYPRWlraswipgswJfmaLn+PzUY2t3SakeusMrgDs88DaPwht1tYzFa0xR3x6+QuqTtBTCglt162//CDMeXJwpF5PsI6mh45ANeE00dXOJbAGHwio78jWoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789867686; c=relaxed/simple;
	bh=58SYG8u0pc/53nUlC52jnU/rC2SgxqQAeHb7MZSbjZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YAd9fbugdgKsr1MM4Fr27F2SvnZHSrCTO33kaiq+5pX2hgCuamtaPQlEjjWh4kIa8hv8qqjAWvmfeyJX4IRwQ4JoaD33n1foA0DrD8n2LFWX+WWmDJITba5akErw/GFiSw0ehLvAbig4Uv1gxlvbR8JJDFlnzMyPcDPLvQFwYU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Oye3jcMX; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Oye3jcMX"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so2224516a12.0
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 18:28:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789867685; cv=none;
        d=google.com; s=arc-20260327;
        b=TZ9KS87Zzj3ERiBRViObskLkBNPct2wygcGbpyg/K4H6av0rRa2Lm2H9Kvo91llFxV
         JQaJm+jN227iuSWgOX/dT2ensYIAsMGUa0tyP4YHGtS5+9teegJkeqAXFg3w7OA44EVH
         LgGQa+nayPYsvXMdcpna6NhZgQeljGKvUP9nez4Ahr45jmMDvEeJfMOQ+LRtVBd91TIB
         5ojEnzjkzniw/++rFMf6yPKJcUAvx4gkW7JmsHhM16pMy16fqT/RsADu8Sb8MzV1MFwQ
         4KxFGSiORRsNLhouXIbXSCEYWdJBJHzENVfemIzsDAmAv769zJYJ8INLPyttHpDAG90L
         cIHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=REeNKeU2w+4sUIJzVcJdRnI84oWXH0Weq6lkeZd2jWQ=;
        fh=V6NqJCk44RwcWLqQSCde5kRQLNE4Lb4g9eDrSTjcLtM=;
        b=UcNIMb/8vVZQXpaiOH89OEJZ2Ebbl4wsCRN/DD2WwWFxiSIDq0Kk3qCtos35GJxZuA
         +4er3XL4b2BkmtUV12iid3EI+nk6yGtAHX4nJMhDBNjAu9IsOEwjMOLGTsmgu+xKcI/j
         OmQtSIFzFIb833lzPXgKR/+jyX4mRI5jmZ4WaMnLbAux40Y6wgr48vfT/9Fe95zfTkPT
         sLLIC3/+DAxFOetcr5s+D3ddFSY3JPBVura6GgQcmyor9OmP2obUv4GPB6hy3L8tadNK
         SNKyZpiKVgVKOLyqbxfnU8nlpvQE50+rV+NyBxeBHbhxXxkeTiJlbOWC7JLOP/eFUYJr
         1W1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789867685; x=1790472485; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=REeNKeU2w+4sUIJzVcJdRnI84oWXH0Weq6lkeZd2jWQ=;
        b=Oye3jcMXOo+JxGG8lg0tyo01cPzFsTzFwSPst9BvLEqGSGa10jiZlNKw79qgxxXa2k
         FI9TdJpfbNUX38lw6WTLltiufg7psbg6ZhkN9+GE+846FFKTSoEId/ybZ2apmxSgMMPy
         LE0W8gEqHSzp0XDoi1x8HsmzbmaaCelra3DFxYhN3neBAb+PEMRuYjgD8zCe057sWJ1B
         Y4GAduW19STxRo5cwliyVd/iDZJejl7gDPX4fsWHXqAF6ldjFQaRevoZCJVuHUz1+k31
         EDUaRNJrocKF7nWOUz6G6BjlQpgPUhvK3h5mSgDAnFPhNCY0opQYbm3BwV19mw19547R
         rO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789867685; x=1790472485;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=REeNKeU2w+4sUIJzVcJdRnI84oWXH0Weq6lkeZd2jWQ=;
        b=udaSdUlkJb4vXUMgSDtKgAJffT9KA6BSsp99nc12wqzUO89IK9lwdwXnI+aaY4gsUW
         Zwn1mNt6jrRm7MgV41RmBegEshCCt0whCbeW9aR9Ja3jrNGuyl4tnMQvNmnc9oraimIo
         5SZ31fhjl/VPO/noxtrd7LVJCv0qd8FO9kqvvxxt6IVE/Y5Ap4CvthDEsnnivj6P1orU
         JsE6bB4m1jRiwGDvfuGsdvWW3hmn4HMAIW96XWZx6sAOR4heLSHmiwHRzcu+uRWh5ssS
         YxRfqUrU5eH51r7CeKLz6HgzMr9eI3Z9GEiUquSHR0PmmbejswQjrv5hBSdqI3lSi3vu
         v2zw==
X-Forwarded-Encrypted: i=1; AKwUvBybrzYlXy9SqBlsvpiYegabHTq/SMCC2xg/JmdGaqfWHdHnSzl3oKQA+mw0dXtUkTUiNXupKEo=@vger.kernel.org
X-Gm-Message-State: AFuF++kW3DkhM27cyNuZsnXAPVUWug8i3GojZSK1GYM2kYOtxDx6x4M8
	+OrL2oLdThG/dHCqvmb8kil0cZnQGEXfq0ZFUV10tW0Gdj+qgJtGWK9C16jQ4aKed9nTVCZR/zn
	yoz7+sPZJMF/Et7hSytR4C64ITWRzBQyRdezBS/li
X-Gm-Gg: AYBFou1VvdsujW4iAgLnfDl8I9LvZdc9TlCCBHA60dw0HZEzoqoXUh0a445o5cogY2b
	mWEv7Jk3m4L0Jcq//+pdyMBUtlwDJK+3bS9f+7r4WAlVhyfcls4VUJ8Bdn4BZLWW4gBwBT+sjtk
	inKJrd6zQ7nyHTt6GkQcme7mP6ufmDkyiPY9cY/zjuubrjlBfg1A+qICrCs3Go0+rnHVhiq1Gf4
	SHUwLRzn5jJ6Ufod9gmDmF+a20ndBsCyPe/Is6hY7r95XHUynNxb4a4FqsUrKQpwKRLBs06lWsY
	w0FBWHssiXd/kmKGCt7HwN3ebb1bGljIM8B634ky69WUmdTGAYqvMeGYtVtX6fWVA1astJSArvP
	tZPXZ1kqgcmg=
X-Received: by 2002:a05:6a21:6b18:b0:3da:e57d:4a79 with SMTP id
 adf61e73a8af0-3dd7263a307mr14783301637.13.1789867684717; Sat, 19 Sep 2026
 18:28:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919210621.3029744-1-benquike@gmail.com>
In-Reply-To: <20260919210621.3029744-1-benquike@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 19 Sep 2026 21:27:51 -0400
X-Gm-Features: AcwNN1VaFHIGGaQ5NtAlsPyN6fZLotOP8OtOjiPI2lLmpI72SuzrZttUCiuI84A
Message-ID: <CAHC9VhT426aweDqPhBWz+16b9zWGj5GsEdn3Jv9dJUnaz5wdyw@mail.gmail.com>
Subject: Re: [PATCH] ipv6: calipso: fix 8-bit hdrlen overflow and missing
 pskb_may_pull() in hop-by-hop options
To: Hui Peng <benquike@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 5:06=E2=80=AFPM Hui Peng <benquike@gmail.com> wrote=
:
>
> Two bugs exist in the CALIPSO hop-by-hop option handling in
> net/ipv6/calipso.c:
>
> 1. When inserting a CALIPSO option into an existing Hop-by-Hop extension
>    header in calipso_opt_insert() or calipso_skbuff_setattr(), the
>    resulting header length `buf_len` (or `ipv6_optlen(hop) + len_delta`)
>    can exceed the maximum size representable by the 8-bit `hdrlen` field
>    (256 * 8 =3D 2048 bytes). When `buf_len > 2048`, `new->hdrlen =3D buf_=
len
>    / 8 - 1` (or `hop->hdrlen =3D ...`) truncates modulo 256, causing
>    `ipv6_optlen()` to under-report the allocated header size and
>    mismatch `opt->opt_nflen` or `skb->len`.
> 2. In calipso_skbuff_setattr(), when `ip6_hdr->nexthdr =3D=3D NEXTHDR_HOP=
`,
>    `hop` is dereferenced at `(struct ipv6_opt_hdr *)(ip6_hdr + 1)` and
>    scanned by `calipso_opt_find(hop, &start, &end)` without ensuring
>    that the Hop-by-Hop header resides in the linear data area of `skb`
>    via `pskb_may_pull()`, risking an out-of-bounds read past `skb->tail`
>    on non-linear skbs.
>
> Reject Hop-by-Hop headers that would exceed `8 * 256` bytes with
> `-ENOSPC`, and ensure `pskb_may_pull()` linearizes `hop` before
> inspecting it in calipso_skbuff_setattr().
>
> Fixes: ceba1832b1b2 ("calipso: Set the calipso socket label to match the =
secattr.")
> Fixes: 2917f57b6bc1 ("calipso: Allow the lsm to label the skbuff directly=
.")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
>
> ---
>  net/ipv6/calipso.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Similar to my comment on your other patch, since you are fixing two
potential issues in this patch, please break this up into two patches
and resubmit.

Thank you.

> diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
> index c6a34334e657..b8b7451a16ed 100644
> --- a/net/ipv6/calipso.c
> +++ b/net/ipv6/calipso.c
> @@ -944,6 +944,10 @@ calipso_opt_insert(struct ipv6_opt_hdr *hop,
>                 memcpy((char *)new + buf_len, (char *)hop + end, hop_len =
- end);
>                 buf_len +=3D hop_len - end;
>         }
> +       if (buf_len > 8 * 256) {
> +               kfree(new);
> +               return ERR_PTR(-ENOSPC);
> +       }
>         new->nexthdr =3D 0;
>         new->hdrlen =3D buf_len / 8 - 1;
>
> @@ -1323,6 +1327,13 @@ static int calipso_skbuff_setattr(struct sk_buff *=
skb,
>
>         ip6_hdr =3D ipv6_hdr(skb);
>         if (ip6_hdr->nexthdr =3D=3D NEXTHDR_HOP) {
> +               if (!pskb_may_pull(skb, sizeof(*ip6_hdr) + sizeof(*hop)))
> +                       return -EINVAL;
> +               ip6_hdr =3D ipv6_hdr(skb);
> +               hop =3D (struct ipv6_opt_hdr *)(ip6_hdr + 1);
> +               if (!pskb_may_pull(skb, sizeof(*ip6_hdr) + ipv6_optlen(ho=
p)))
> +                       return -EINVAL;
> +               ip6_hdr =3D ipv6_hdr(skb);
>                 hop =3D (struct ipv6_opt_hdr *)(ip6_hdr + 1);
>                 ret_val =3D calipso_opt_find(hop, &start, &end);
>                 if (ret_val && ret_val !=3D -ENOENT)
> @@ -1341,6 +1352,8 @@ static int calipso_skbuff_setattr(struct sk_buff *s=
kb,
>         /* At this point new_end aligns to 4n, so (new_end & 4) pads to 8=
n */
>         pad =3D ((new_end & 4) + (end & 7)) & 7;
>         len_delta =3D new_end - (int)end + pad;
> +       if (start && (int)ipv6_optlen(hop) + len_delta > 8 * 256)
> +               return -ENOSPC;
>         ret_val =3D skb_cow(skb,
>                           skb_headroom(skb) + (len_delta > 0 ? len_delta =
: 0));
>         if (ret_val < 0)
> --
> 2.55.0.1082.g2b9226bbc0-goog
>


--=20
paul-moore.com
