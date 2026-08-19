Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9EC426699
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787132644; cv=pass; b=moGV6Ag2ck1YVAsIHICwy1kDRXnpGAIPA1r8xvawU6rWE4dQL85efnt7r7FNuGZqg7ImYIgPypYjqloOTtlXqZKHHrrQzfaGq1vbSy37NEbi0a3LKVt+9P3wrl84cGNr9BBF2Lb11inbUg+BxZ/yIs0b3E1gC/lCoC7557ob6Nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787132644; c=relaxed/simple;
	bh=IBqOfiZ3jLUgpVgmicU2LGUYs4GkN0rNYwqVg/GkAqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B5iGYirK5Q0YriAaHQMOwsUqDkvHAM9QAvP8NCcBetDuOcrsqa1ySph6+2T8Z8gr5Ynv3cyxSmHQ8UJnfZtjd4s2f25XKKgzwLR1LEuLxFYGO6lt9xnAf+feRa9gu2JGmwHTx6RSLryvDs4p98J33xFuUaQmCQeLgf2Ze01G2V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=iFMAxUf5; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="iFMAxUf5"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84e04df8c46so909141b3a.2
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 02:44:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787132642; cv=none;
        d=google.com; s=arc-20260327;
        b=I3Cou/JpHCRX1YErIDTrcfPJHEk0JZw2KkDHpIeCjWU5vYlpO+L6q6IaejokF2vgCv
         3rMfVdmvXxyP8StJ1GM7jpLrzmchBwN1EENteP4c1sJKW4QHEU2uWkSlKY2fHFr3stf7
         Dz5peqYAXevbXYBmszNyB/rHfSpQyb+jdKCy/u+ZuubbIoiG0rLqMg/xbFZuip69Sebo
         DMPZ+3qiAcPLuve6sBGrmPgxM+zATZ40+uqPUPHRDM0cw6mSeIrO3CLi3Js+0TZT+qbK
         zA0DiJ65pbMOf4EPBhg9vRslyvIP0YwYRSznWOmWtyeUrD2Dk7bFMjkcpUqFRRGOHQ68
         0ifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xXVBUa5CWsVqk1YRNp8DHi5XeenCOLPR6Ijg7K/nYyw=;
        fh=LVfoLhV8HaYjbN5dmFjf69h1oYVUVgTB8YpOI/H/OLk=;
        b=KOloGGkf9V9qFr80MEQ3VPKQbxou1m3wKxpMUaOLJ8KXp1Uzb3QlKNlhhdriqvrVB+
         9LIIXMr1gFAVDRrSk/RmL8ceLif7CG7K6qB+NA+h7ZQYH+clhHH27Ja/lG+Q/ITXnInu
         TVl/myfNB4XFkjQ7rgich/8LmCoxMpcEzsYbfLLyk2SfR55KZDuw81I9B6jN3Ysu5j0X
         CQu3eTZ3ogeZX3i4pSRJMPqjqBT0Su50E0wgI8l3PKs2sGbe5cZZ7wp0iPOitCUBLnff
         N4Kn/92u9cwHLPsiYwjTEHIQcx1AzydrrEPhd9YlhF0K4Dt+/R3lE91yfqvVf5pdni9t
         Yq7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787132642; x=1787737442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xXVBUa5CWsVqk1YRNp8DHi5XeenCOLPR6Ijg7K/nYyw=;
        b=iFMAxUf5plZ7aZQ7ir+VqK9njA/4IyHh4X6Cko8520KTJWkc5Hj+b4YBfy8rhlo50S
         jf1U4MVtIyh8sBxRf4bBrjL5PNZVSYuzsRlQOqEK7dEySVuR41NvWQqLrhAYIDgxzh5v
         lZ+rwaFlgVR89DCvDtDzi3vTGxvsEYDomzUDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787132642; x=1787737442;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xXVBUa5CWsVqk1YRNp8DHi5XeenCOLPR6Ijg7K/nYyw=;
        b=Fd6oGWvUt83KtpNorlAPVwv/EOQFqh+FgjNE+miE1GGt5BHEcg2JFLZlItsMP8Mtkt
         OvyzDvRZ2yswu8/RnasakCY4QWakdGzmdkre0104Y8DgRZw66s4jOR+RQU8d4DclybJy
         aacoSH8Md99iY8xLufGGJjeF4cvTUE2HWcuwMUO9BUrV/1mshCDpyZ+rM8nZrIeUnH5w
         U2xVS0yTMSu6T7/rcA/HEKKoefJKOv5ztaq5z5m4UVd5fCP9ihkriMR46zeJgzaBkVvi
         ZJdVSVN3IJ+6zu719hjKWV/60rO1swzR/7ZzqPD6TdpXyDq0MVEbf4EIIieJo7UmuupT
         m61w==
X-Gm-Message-State: AOJu0Yy6ayc8edVFzhM7MqLNKb8gMnDu6n7CuXtrKBHmwghDeaLzOYwy
	fG9aP1+uGXzP7SpBNdOhMq5mKO967GrIsunxjl6k4mXWkbF3uBFZmrbV4jG8Hql1hjvjXGE0eKa
	CAKo6GWCXziZL4n+j/eJfrdicDUGm8eq5t+toawaJ
X-Gm-Gg: AR+sD13pqkc9kj+x2NxDkVi9FDQL9n9TTcFeBSJ+oKGpJ/dzpzivcFcPAAK2I/ukqbM
	3gLCbI1KvtRpxbDzHqZ+tFaIgxzrL3npZpVItBTEEb2JUvB8vgWCuZ1IEHRKSPR/ym/GqFoIBd+
	Z//3ive/uKGLHTXO3h4KiUCH5xOCQ22UK9O5Hj4Uv1ieDeCh7cBu0aGaLpCWLXrzfkQwLGuiGd2
	oC615qtSS3DbTeOYQXEEHDAqL4R/D9j4kEpFUbGG7Bc2Ws9H1BQrPJPRaAp4oRJHOdeBo2RKg4m
	tWKuh4hT+DKChXJ0lGXagz/mpO36luWHsPzOOf35WEVpaA==
X-Received: by 2002:a05:6a00:1d8f:b0:82f:50cd:e586 with SMTP id
 d2e1a72fcca58-851d39596d8mr5802650b3a.13.1787132641780; Wed, 19 Aug 2026
 02:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818221519.75088-1-meatuni001@gmail.com>
In-Reply-To: <20260818221519.75088-1-meatuni001@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 19 Aug 2026 05:43:50 -0400
X-Gm-Features: AcwNN1UYmATzU7V_c8fMgTpkO2qYWlgH_0hLusIxRjBxAIim51Y7ugm38PEbQRo
Message-ID: <CAM0EoMmz8_Cuk9CirJGN6hqfL=A-ftgtFD1eyz67-i9g3s_61w@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: act_skbmod: Fix headroom COW leading to
 page cache corruption
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 6:15=E2=80=AFPM Muhammad Bilal <meatuni001@gmail.co=
m> wrote:
>
> tcf_skbmod_act() calls skb_ensure_writable(skb, max_edit_len) to ensure
> the modified packet header is writable before rewriting Ethernet addresse=
s
> or setting ECN bits.
>
> However, skb_ensure_writable() only pulls and COWs memory starting from
> skb->data onwards. At ingress or on forwarded packets, the Ethernet
> header (or network header) may reside in the headroom at a negative
> offset (skb_mac_offset(skb) < 0).
>
> Because skb_cow() is omitted for negative offsets, writes via
> ether_addr_copy() or INET_ECN_set_ce() modify shared headroom in-place
> on cloned SKBs (e.g., cloned by tc mirred, bpf_clone_redirect, or
> packet capture sockets). This can result in silent packet corruption
> and page cache corruption.
>
> Fix this by ensuring that if the target header starts at a negative
> offset in the headroom, skb_cow(skb, -offset) is called to unshare the
> headroom before ensuring writability across the header span.
>

1. You must provide a reproducer. We test everything. Make sure you
have the correct logs for what you reproduced.
If the reproducer is security-sensitive, send it off-list. A standard
tdc test (if possible) is the prefered option.

2. These bugs follow the same exact pattern; no need for 3 patches.
Fold them into 1. Create a helper they all use.

In case wasnt clear: You need a v2.

cheers,
jamal

> Fixes: 86da71b57383 ("net_sched: Introduce skbmod action")
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  net/sched/act_skbmod.c | 37 ++++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 13 deletions(-)
>
> diff --git a/net/sched/act_skbmod.c b/net/sched/act_skbmod.c
> index a8e2b83ebae5..cd2a6e974e6f 100644
> --- a/net/sched/act_skbmod.c
> +++ b/net/sched/act_skbmod.c
> @@ -22,13 +22,24 @@
>
>  static struct tc_action_ops act_skbmod_ops;
>
> +static int skbmod_ensure_writable(struct sk_buff *skb, int offset, int l=
en)
> +{
> +       if (offset < 0) {
> +               if (skb_cow(skb, -offset))
> +                       return -ENOMEM;
> +               if (offset + len > 0)
> +                       return skb_ensure_writable(skb, offset + len);
> +               return 0;
> +       }
> +       return skb_ensure_writable(skb, offset + len);
> +}
> +
>  TC_INDIRECT_SCOPE int tcf_skbmod_act(struct sk_buff *skb,
>                                      const struct tc_action *a,
>                                      struct tcf_result *res)
>  {
>         struct tcf_skbmod *d =3D to_skbmod(a);
>         struct tcf_skbmod_params *p;
> -       int max_edit_len, err;
>         u64 flags;
>
>         tcf_lastuse_update(&d->tcf_tm);
> @@ -38,7 +49,6 @@ TC_INDIRECT_SCOPE int tcf_skbmod_act(struct sk_buff *sk=
b,
>         if (unlikely(p->action =3D=3D TC_ACT_SHOT))
>                 goto drop;
>
> -       max_edit_len =3D skb_mac_header_len(skb);
>         flags =3D p->flags;
>
>         /* tcf_skbmod_init() guarantees "flags" to be one of the followin=
g:
> @@ -52,19 +62,20 @@ TC_INDIRECT_SCOPE int tcf_skbmod_act(struct sk_buff *=
skb,
>                 switch (skb_protocol(skb, true)) {
>                 case cpu_to_be16(ETH_P_IP):
>                 case cpu_to_be16(ETH_P_IPV6):
> -                       max_edit_len +=3D skb_network_header_len(skb);
> +                       if (skbmod_ensure_writable(skb, skb_network_offse=
t(skb),
> +                                                  skb_network_header_len=
(skb)))
> +                               goto drop;
>                         break;
>                 default:
>                         goto out;
>                 }
> -       } else if (!skb->dev || skb->dev->type !=3D ARPHRD_ETHER) {
> -               goto out;
> -       }
> -
> -       err =3D skb_ensure_writable(skb, max_edit_len);
> -       if (unlikely(err)) /* best policy is to drop on the floor */
> -               goto drop;
> +       } else {
> +               if (!skb->dev || skb->dev->type !=3D ARPHRD_ETHER)
> +                       goto out;
>
> +               if (skbmod_ensure_writable(skb, skb_mac_offset(skb), ETH_=
HLEN))
> +                       goto drop;
> +       }
>         if (flags & SKBMOD_F_DMAC)
>                 ether_addr_copy(eth_hdr(skb)->h_dest, p->eth_dst);
>         if (flags & SKBMOD_F_SMAC)
> --
> 2.43.0
