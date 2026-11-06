Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793993709;
	b=1EkessIizOFuwgvzITUxWLvJXBNwjl2VeSR3mUlZDtnhl6GwANZFxmKCUE8BT+4hcPrF
	 VKtL8myNEn/eLObOj7X77+cAMHKm3MLMwLQU2QRQUCgOQvpbQYX2XrgcrL/WxEXj8w/Za
	 tUpSwJwn9Hv7jSaGchple8K7X6zfT1+roKubDZ1zHIBTj+WX2ne8y4GDeXNF4vZgntFTg
	 RTmMrNHbbDdE3asSsLg5YdXjj8AmamzgWE3XjV9L3wq657/cp0mv3x7oIC87iLlv3whg3
	 kdcnevYG2NDUMQfJNQw+APJsCq7/syKUCaHZSGg8L1oJI+7By2543rCdBq2PqxoLqDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993709;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=q7vyGlLnuMLmDSPrNx6rB+c9l956aiB/10KTU6MI1Js=;
	b=0TdnHPOexnXCtnYHpIbbQd2PLkN+OYXQU7J8e8FGpQhtiMu1KR0+5gM+VhHRFjrDoVRj
	 ziceuQGtNUdf7xLDC4lyfKb2J0ex4M7KN+JqWXTKA/AbGKFX+/zty/a9eJljDh6qGP86p
	 uI02A5uxOvG3stpWqepQV/aMYzcgTQU9yKwFVi965sIp5IhjND08PjlgyceYk0Xt2OtUe
	 WsBaEwBASsHBvCRc+MIQIx4bzwG7yBxRtrfz18VSXw7jP48o75dedNsqhIDFsr7QIUT0y
	 dJ4aTMzoYPbiwHyxLD0rju/VoBmWBxTFm4pTj3d2yWeib4XHYFp4x6cjvn+jdNxGILQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="I/tRShSy";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5FB606A338
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 19:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE5FB606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I/tRShSy
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b579ed8da6so196a12.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 11:35:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793993707; cv=none;
        d=google.com; s=arc-20260327;
        b=R35DAp0mE1UD93g0duTkQi6hojsFY4ieHDJNSwNYlg+jwiDBhTlyAvFg57JRkCD0S5
         xrZj6l/UWRCOLYuYKjs9IoDoaZ6KJp6TWXQ8ZxLe8p2bCY2a19jlkJLXiTNitvHYXavW
         MucxzQZRBlvOOMhMcr1rzz7+2GvsxItmm/OwzdhKm6RiOP96/aOrU2c5aYCnRExUmgBN
         Hdc7FvqRuEa3T0m23DFRIniS6hjCPgbzg5dpSYAYtRsUJkt2b/NFnLZ8urBoOKLWaCK6
         Hl2sEdI7qFKoeiOeHcFUYgf+n5gQV+X1u0pX7uTfaqy+TL+sYcjOveoPGqF63653PRk8
         7nfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q7vyGlLnuMLmDSPrNx6rB+c9l956aiB/10KTU6MI1Js=;
        fh=UN9ojNBOteiiUn9mTJoI+lPp0Fg4VwYDTQ2UMU4xq0g=;
        b=eYkE4eKUKySfO4XjMqCcDvGqT6Z2GqMRJKxoMsVo4jAawMhTVSIat3F000tZxS/laq
         1BGU3kq5meQ5jDcNUGhS/eyrqE8NxabhbQ7kMgP64T44HczePOYF8xMmA43eCRRuFTfr
         ACyDg7VvqcWs5/Okh2RyMeb/A9RYGb6vu9nKTR3kh2BrWu5MDQTshyLMFaWA0URW9Nw5
         rXDEK94/HIFxzit5/zYe2tdq2GTVNU9D8H6CpG53Q1hCbrYu0XOpjcVQWVIKtFA4HfK+
         HS67dvlwXSyykhfAhzschuqdCOMj+2f7kZ311FJgoc6MxVxU4tei3uymA/Ile6lzwgos
         AaqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793993707; x=1794598507; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q7vyGlLnuMLmDSPrNx6rB+c9l956aiB/10KTU6MI1Js=;
        b=I/tRShSyPFMarF8NTFFwcT9jKuVSd5Ix/iO9ZoKiRlGYgaAGtvcTJaqF2+vyUFCnGh
         hjCB26ZqbAliOhn96qnvIFzTzM3aPncPrcyRgkniS2LkVC9Ir6PNTgONm5iB+jgwPWWS
         xZA59D8oSEHJ+dtkqPDbmDHqBcFymceCQKtkBaaFrwP/Ziu24SQU7DzUCm73S91e81R/
         STLOmGu/jXo4W7rTdN0wdOjEoBwJyZBvwaLvhPE/jYWVszePwRJPzmSSxhc1kFDxEpsP
         WavjYGRUKrO//5G0Rzctjs/aQfdS/EBvP06EnzzhimgOa+GIjRFn7D29kwdOr+06+rTR
         U4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793993707; x=1794598507;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q7vyGlLnuMLmDSPrNx6rB+c9l956aiB/10KTU6MI1Js=;
        b=oPUIMGeYw+MFOTQr4WNGiTB977rsQjJSQCWQf3HBlKxFLlCLK7ld7elqbugbjsPUAt
         01pA7m64ZWGDCOnWUQ4rFSg3VPcRhzGJvUm7pxeGlrC4Oan4m5GNQtd3MpolfC7NegvB
         nNL4njQbrx5+LHL+SQcelKpiCLiW2mckq0SMXCKPB9YoM8aYCT8qxBRqVUObAQ7+7FOx
         Iba8JArPjUTZoyhpQfgP8Lf81L9V4lP63VgoiJsgdZE41jmZ2on8/bCPTritSA1qO16t
         KD7fBXym458giFyDvaTPlp2CjZ8PiK/DiiHTIZWmU5Hr07dlLLLVDIvxWt08Wf0YbnHv
         bU4Q==
X-Forwarded-Encrypted: i=1; AL+hErF5i/JQeEHZq4Xt7+/bA/PoZ5vXoOzFeGo7lq1w76h4BqN58wRlsvN/PXGgKJPmptZDORgvO48=@vger.kernel.org
X-Gm-Message-State: APuU4Z8gyU67kgtP7j9dQrr6XRHtrMZXhZ1nS0z6V7dzJC/eFDRRUQIM
	CjqSX/71QwmNk9sUKSviDqBuOxXL3xVwUvLI0kzhNg8ODozXaYfqbvVQb2QPYs1rcy/yzHND0Rp
	ckXe59OaG/Q8KRpkGBr1XUhdhfC9+/5HkIuWAqVti
X-Gm-Gg: AYBFou2Cq9OG522urCkutSv2t6QsnVLXm9ngFEaU9XqxVWfDTnXmVtedPtCeXZmHqoU
	ON+Ntca3wG0RKZLqZXSs29tbjOtDyjhhh0bVmLiByGAI9u1wvFMWBKroQD0j4gpWH/Sh2CAMBxy
	Ffo9Zy+nkXkj9xFGpSCipTXsJZUBXa63rEuEZF+12SgL39QwUt2dzV92weTuqCtWmE9CIi6JaIu
	JSMwGSSm260UpxMLaA8wGCzJbpBHT+HSNd8gl+yQwJA0dpUy9z6A1zHF/us8x9QWr8CAlkBk3H+
	iWJIyxATTEc87o4w9Sn0gjvkLtUXJ9iDi/pad5pr0Ot7GFs3AAHbabuoo1d2dZVAMHXcm1eo3LX
	rjr0UGPEI7pRAZftPEGk4/OntfWpKF2hPiTRdJVWjK3KrCv8qrkaKWiAumgxn/9hwa8o=
X-Received: by 2002:a05:6402:46cd:b0:6ac:84a2:bdc7 with SMTP id
 4fb4d7f45d1cf-6b6f841f217mr14162a12.15.1793993706782; Fri, 06 Nov 2026
 11:35:06 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104042521.3979880-1-almasrymina@google.com>
 <20261104042521.3979880-3-almasrymina@google.com> <auy0aaY0-g32aYi9@devvm16445.scu0.facebook.com>
In-Reply-To: <auy0aaY0-g32aYi9@devvm16445.scu0.facebook.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 6 Nov 2026 11:34:55 -0800
X-Gm-Features: AclHuK-YimmJxq_bYeOqoiBBY5YBRIbp3NSf1WfsmyuyA1JhOh5RN6kl5UkSXgw
Message-ID: <CAHS8izNrM+iaT6OOJVoZdVp00TkNRhFe9ucCVrwaUWL0oQS7Ow@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] net: prevent mixing frags from different
 memory providers or bindings
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Eric Dumazet <edumazet@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 8:59=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmail=
.com> wrote:
> > +static inline void *skb_net_iov_provider(const struct sk_buff *skb)
> > +{
> > +     struct net_iov *niov;
> > +
>
> [..]
>
> > +     if (!skb_has_net_iovs(skb) || !skb_shinfo(skb)->nr_frags)
> > +             return NULL;
>
> (a few nits/questions)
>
> Why !skb_has_net_iovs is not enough? (and if !nr_frags is required,
> maybe fold it into skb_has_net_iovs?)
>

Well skb_has_net_iovs only checks skb->unreadable, which is not
actually enough. The skb doesn't necessarily have net_iovs if it's
unreadable, it technically could be that it has no frags, right?

Technically we should never have the edge case where
skb->unreadable=3D=3Dtrue && skb_shinfo->nr_frags=3D=3D0, but I don't think
the code is careful about that today, and I don't know that I want to
do a global refactor everywhere we remove frags, which skb-> flags
need to be updated.

but you're right that it can be folded.

> > +
> > +     niov =3D skb_frag_net_iov(&skb_shinfo(skb)->frags[0]);
> > +     if (!niov)
> > +             return NULL;
> > +
> > +     if (net_is_devmem_iov(niov))
> > +             return net_iov_owner(niov);
> > +
> > +     return niov->desc.pp;
> > +}
> > +
> > +/* Return true if the memory providers of @skb1 and @skb2 are compatib=
le
> > + * for coalescing. For any struct page-backed provider (the buddy allo=
cator
> > + * or a future provider handing out struct pages), coalescing is assum=
ed
> > + * feasible. For net_iov-backed providers, the provider instance point=
er
> > + * must match.
> > + */
> > +static inline bool skb_mem_provider_compat(const struct sk_buff *skb1,
> > +                                        const struct sk_buff *skb2)
> > +{
> > +     void *prov1, *prov2;
> > +
>
> [..]
>
> > +     if ((!skb1->len && !skb_shinfo(skb1)->nr_frags &&
> > +          !skb_has_net_iovs(skb1)) ||
> > +         (!skb2->len && !skb_shinfo(skb2)->nr_frags &&
> > +          !skb_has_net_iovs(skb2)))
> > +             return true;
>
> This deserves an explanation or a comment?
>

This... doesn't make sense. It guards against coalescing empty skbs.
Too defensive. I'll remove it. Thanks for catching!

> > +
> > +     if (skb_has_net_iovs(skb1) !=3D skb_has_net_iovs(skb2))
> > +             return false;
> > +
>
> [..]
>
> > +     if (!skb_has_net_iovs(skb1))
> > +             return true;
>
> This also seems extra? The bottom prov1 =3D=3D prov2 covers this?
>

This is a ninja optimization to reduce the number of cachelines being
loaded.  getting prov2 requires loading
skb_shinfo(skb2)->frags[0]->blablah, which is not loaded yet. So we
check whether skb1 has a mem-provider that we want to check against
first. I'll add a comment and/or see if I can make this prettier.


> > +static inline struct net_devmem_dmabuf_binding *
> > +net_devmem_skb_binding(const struct sk_buff *skb)
> > +{
> > +     struct net_iov *niov;
> > +
>
> [..]
>
> > +     if (!skb_has_net_iovs(skb) || !skb_shinfo(skb)->nr_frags)
> > +             return NULL;
>
> Same question here about 'why !nr_frags' is needed. Can we simplify
> (or cover this in !skb_has_net_iovs)

Yep, I think so. Thanks for the review!

--=20
Thanks,
Mina
