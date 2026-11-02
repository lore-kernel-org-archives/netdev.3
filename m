Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793616025;
	b=4p7r6Qgobcjq5EIOV+VqBtqWndToI8fs745ANyMk/kWIdWkcofACulCOk7y6xHtF/YQA
	 fJ2JKyrnT77YwsOV4xVV8tQt698xjmFyUnOvPNVkYxjVk3xERpZgNtBqWEecoxKeMT/XK
	 hGkliZbhL3WJsASQ9Bvca23ajRdpvHPl7eJv0PkOlhbYDKholc0hhcha6FBAsyWsrO8Tw
	 Pa1bpPyq0sRoLxuHEytCtq6xcbYeK1zM4BlXx5TX20Zb7+lC1QHms9YEUI5vc0EpAhir8
	 hPg5zTReDdJ47YcLfeV/met30P5EQYZBcEJQiQBjB0b1ASvJ23txAbC/l9+Hi67KgRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616025;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=JAbovPHeJ2xEig829/5c9siMIYbHSLDFKj1B615zzwE=;
	b=19FciRQ6juL4DB7MkPdw+G7GU/FRmDW64vgvMSNlAF8U/Tl4WwPmKjFDw2LenbU3pk/M
	 KdQN1wZwzSyQJGUSkYgp+CiNpJMsMHln1UFFo2+fBl6BfecOMBPWUyoJ/BHvJNXfFUCMo
	 rhnwDu4GFv/dkN1459uDRwUvNWswCQC+3+C8IrDeVqQfxmlO2C33bz5jVBy+JUc9bcgCW
	 CNSgRJI0fbquqDisfTMCuSYcwVGPJ+5yPV3mWE6PzHcwgpPAYgD0xumNCZs8RgDTwDOB2
	 l16ii3X4YaD19wqUPtErJcXXduky8pHnA+lFNj9rUw94nbCkPzvRko9v2Yw0YlUPABw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xx9oOURe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9C2606A326
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 10:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C9C2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xx9oOURe
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-70b875f6f13so2717711eaf.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 02:40:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793616024; cv=none;
        d=google.com; s=arc-20260327;
        b=jQpTC3loPkm0aChUXUxynM0gcc0pjuSoByd7MKkjVTMmTfIxYHKK6Aw+cFm8Ry0+tD
         lpBWuLNd9XNehZa3C0qpNHWJkj3T04L65xZPMZrJrv2GN047qBXZgsnuAckGocNlAP7x
         STSh/Cl8T3OswL63E8SmcjJhDiGWLipSKjtk4GCM0/RilttK37ZhqfIoAXz1fG+EEtO/
         wVr+xEgYjvFq5BQW/l35ZCgD+/jsY3XtCxzSw5fpCpFpk3CSrN5pFVGVQCcaPWh9KA8g
         Zao3mOUEzltewQNyOKBIoOcMVWreVGYdQWALzYBBqRlvNINHiasg/qYH2YUjCo/Mrt4t
         nQ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JAbovPHeJ2xEig829/5c9siMIYbHSLDFKj1B615zzwE=;
        fh=fVSSuQMVg4vj3l41CrCma91f9u9y8f1wfG5d8DZm9xA=;
        b=ncFgenBxhs3IylGEbd5DbH4iWI+sDDjsWO81lB1BO890dWdGn1Lkq9dYEjXcCUHuKf
         RUZBxoAl4n5hQ7fwShUgCABfX8EoAqX5PRuPd/MN/ZgFdr34JjM7QONLIuy3STAvJkSX
         wRJ1W5yzIR7CUEnFFywepFdlFQBNMOPXogx+luObKULYivCtycw7KTSTPqAKF0k9ovKr
         cKGlMsgqLEtGuyuhVKuvIvjFW3us3kTeve3O06Hr3p/MSDrfnfKNsyhsIovbi4O8GR47
         14X4rvPRUE/fVocFXJe034r+zAmzXSsMp9lrZyNvQ6xKPNeF6KkkLInuqe/p/6EhBXcS
         hSMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793616024; x=1794220824; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JAbovPHeJ2xEig829/5c9siMIYbHSLDFKj1B615zzwE=;
        b=xx9oOURerM80DF8A0CZGSkeZvHpyEelEn488fLPBAj1loWX46fTaA01/QIXRpHiZqV
         Tm5TIpMn2jzpRDHiUgFgBy6ivl8is3DE3lDYNR4wXng00vmGxnB9jb/2mljvTC9Sol7q
         En8homi5f4MpFiIWxdXAQT4GiM5QcgnxdLwPxhX+kFnbTdzO7WaD2OaJ+B1qFy4zEToE
         afV2x5sF6ktQA8FBWMq/MJobYNwgkwxwZbxSovcvVj4YAfOKjco0xbnB6mK9S4LCVw7m
         47WH0qSXWc040uIS2V40EFTojQrMVP4lo6peySU/CKQYmjeGz1dCpVrWSdrgHRu2GB7F
         5GoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793616024; x=1794220824;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JAbovPHeJ2xEig829/5c9siMIYbHSLDFKj1B615zzwE=;
        b=hsgMouHgRZ77JSdQZ8lTZUveIOUSujlKRnkNrqiCar/ab8j3nYKjM5WKJIwCpFwA+j
         rwCE8oRN/FAZzWFglvlOjVyT2U1n/TrOiiDKIu6ZAm/xHZrK9S0nnfOrcjZ7NuIg+kcO
         CTCPbSJ5hQN/R5BgTKkPUYI+GHyiNp9c6pX4V1OKtPIoIEvZBcc1K+nzu3xylupp01Cp
         KPlHXJx00gvoFkVd4LRnG92v6rCEt4lS6I9HftEkKikKLI2lYLotUkX2kelbbZ0pNx8z
         ojIPAVqK1tuFoL+ku1YxrEAf2a/8Wmc5X573CCR/GVsAL7o5Fmm4kI+g39agBJbdPcaW
         GT3g==
X-Gm-Message-State: AFq9FYK4gE94MWt/XyDlWOT7yt8KPyd2yei2OxLquct/X0otrJQzTOmU
	/0GVxMIp4PGglRNSOz0obNeAphVY4Fc1U6TRN8DHTzNBfy5j9I3CreGIzBNqDTOC/nWZPe9OLwM
	ELYFdxxUmNYp+E9+PtCzONqCHe+L7cIg=
X-Gm-Gg: AYBFou3uctnQN//rdoUakVsY6o2SyNr5i49vJlrbgPZpLrlS8RFot9C7wD5bwFeJprX
	DXsyaXxFfB/vhrzHnKVPhdGSka+jJV8hnR6NWRpIqFW0LPFAmkNQVdaBg1xoyscIQ3JaRx9ck4h
	jnIu0R2mQYTaTo7iqX7dLaXgueaZNxCNHjq3ga2c02I5XYU8JkWiY53TTvDqLo7hCNX6GdoN+2G
	sYxZFkBumvTtqHZQLw+5405dJyTFvIRl8lnSiuwELGOWHBoMu8DFQY+TNxBHBP/hzbT4GGNag2K
	Op6ShSGUBQWxTAZgUFBdOgp0mwzMqB2w/Vx4fSaFnzleXszswwm3hb09ysURY3lbJqMcKzCgLUw
	moLsD7TNR+88sQ9hHbYOGPMW3IGRwMpgCRsVErEz8B/r2880MXwFqsxRENouNKQe7F1o7
X-Received: by 2002:a05:6820:a742:10b0:715:1fca:76b with SMTP id
 006d021491bc7-7151fca0ae4mr870077eaf.49.1793616024030; Mon, 02 Nov 2026
 02:40:24 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031173449.2439047-1-amaan.cheval@gmail.com> <179355715214.3131.12199411268855919850@kernel.org>
In-Reply-To: <179355715214.3131.12199411268855919850@kernel.org>
From: Amaan Cheval <amaan.cheval@gmail.com>
Date: Mon, 2 Nov 2026 16:10:11 +0530
X-Gm-Features: AclHuK9E_dLI3t7Q3TmxOXhPQBGw8ryAVJYotEpJZVmIJnYTketAypvfaqKGYzM
Message-ID: <CAG+wEg16qAUfHga8hJ9jZ+iVC7vj33N+K+99JTXKoFH2YELw0Q@mail.gmail.com>
Subject: Re: [PATCH net] gve: leave refcount headroom in the RX page bias
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, joshwash@google.com, hramamurthy@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, zhilinz@nebusec.ai, 
	jiayuan.chen@linux.dev, kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 11:49=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 1 =C2=B7 High: 0 =C2=B7 Medium: 0 (1) =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Critical] This patch moves gve's RX page bias from INT_MAX to
>   USHRT_MAX, but keeps the old refill rule in gve_dec_pagecnt_bias()=E2=
=80=A6
>
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but in
>   gve_rx_copy_to_pool() (drivers/net/ethernet/google/gve/gve_rx.c) the=E2=
=80=A6
>
> --
>
> gve: leave refcount headroom in the RX page bias
>
> This patch changes the GQI and DQO-QPL RX page bias from INT_MAX to
> USHRT_MAX and stores pagecnt_bias in a u16. A get_page() from the stack
> therefore no longer wraps the page refcount negative.
> gve_dec_pagecnt_bias() now adds a fixed batch of GVE_PAGECNT_BIAS
> references when the bias reaches zero.
>
> Link: https://github.com/amaanc/kernel-bias
>
> > diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/eth=
ernet/google/gve/gve_rx.c
> > index 81ea800e66e94..6533fff061555 100644
> > --- a/drivers/net/ethernet/google/gve/gve_rx.c
> > +++ b/drivers/net/ethernet/google/gve/gve_rx.c
> > @@ -152,8 +152,8 @@ static void gve_setup_rx_buffer(struct gve_rx_ring =
*rx,
> >       page_info->buf_size =3D rx->packet_buffer_size;
> >       *slot_addr =3D cpu_to_be64(addr);
> >       /* The page already has 1 ref */
> > -     page_ref_add(page, INT_MAX - 1);
> > -     page_info->pagecnt_bias =3D INT_MAX;
> > +     page_ref_add(page, GVE_PAGECNT_BIAS - 1);
> > +     page_info->pagecnt_bias =3D GVE_PAGECNT_BIAS;
> >  }
>
> [Severity: Medium]
> This is a pre-existing issue and was not introduced by this patch. While
> looking at the GQI-QPL copy pool, does gve_rx_copy_to_pool() leak the
> fallback page?
>
> drivers/net/ethernet/google/gve/gve_rx.c:gve_rx_copy_to_pool() {
>     ...
>                 page =3D alloc_page(GFP_ATOMIC);
>                 if (!page)
>                         return NULL;
>
>                 alloc_page_info.page =3D page;
>     ...
>                 skb =3D gve_rx_add_frags(napi, &alloc_page_info,
>                                        PAGE_SIZE,
>                                        len, ctx);
>     ...
>                 return skb;
>     ...
> }
>
> gve_rx_add_frags() can return NULL before skb_add_rx_frag() attaches
> the page:
>
>                 skb =3D napi_get_frags(napi);
>                 if (unlikely(!skb))
>                         return NULL;
>     ...
>                         skb =3D napi_alloc_skb(napi, 0);
>                         if (!skb)
>                                 return NULL;
>
> In that case the only pointer to the page is in the stack-local
> alloc_page_info. gve_rx_copy_to_pool() then returns NULL without calling
> put_page(page).
>

I can investigate this separately and prepare another patch later.

> [ ... ]
>
> > diff --git a/drivers/net/ethernet/google/gve/gve_utils.c b/drivers/net/=
ethernet/google/gve/gve_utils.c
> > index caed38cd5f2b3..cb6fba3122d5b 100644
> > --- a/drivers/net/ethernet/google/gve/gve_utils.c
> > +++ b/drivers/net/ethernet/google/gve/gve_utils.c
> > @@ -93,15 +93,9 @@ void gve_dec_pagecnt_bias(struct gve_rx_slot_page_in=
fo *page_info)
> >  {
> >       page_info->pagecnt_bias--;
> >       if (page_info->pagecnt_bias =3D=3D 0) {
> > -             int pagecount =3D page_count(page_info->page);
> > -
> > -             /* If we have run out of bias - set it back up to INT_MAX
> > -              * minus the existing refs.
> > -              */
> > -             page_info->pagecnt_bias =3D INT_MAX - pagecount;
> > -
> > -             /* Set pagecount back up to max. */
> > -             page_ref_add(page_info->page, INT_MAX - pagecount);
> > +             /* Out of bias: take another batch of references. */
> > +             page_info->pagecnt_bias =3D GVE_PAGECNT_BIAS;
> > +             page_ref_add(page_info->page, GVE_PAGECNT_BIAS);
> >       }
> >  }
>
> [Severity: Critical]
> Can this page_ref_add() run on a QPL page that has already been freed?
>
> The top-up only happens once the bias has reached zero, which is after
> the last driver-held reference was handed off. igb, one of the drivers
> the commit message cites, refills while the bias is still 1, before the
> handoff:
>
> drivers/net/ethernet/intel/igb/igb_main.c:igb_can_reuse_rx_page() {
>     ...
>         if (unlikely(pagecnt_bias =3D=3D 1)) {
>                 page_ref_add(page, USHRT_MAX - 1);
>                 rx_buffer->pagecnt_bias =3D USHRT_MAX;
>         }
>     ...
> }
>
> On DQO-QPL, gve_xdp_done_dqo() calls xdp_do_redirect() first and only
> then drops the bias:
>
>         case XDP_REDIRECT:
>                 err =3D xdp_do_redirect(priv->dev, xdp, xprog);
>                 if (unlikely(err))
>                         goto err;
>                 gve_reuse_buffer(rx, buf_state);
>
> gve_reg_xdp_info() registers MEM_TYPE_PAGE_SHARED for QPL queues. With
> an AF_XDP socket in copy mode, the redirect target returns the buffer
> before xdp_do_redirect() comes back to the driver:
>
> gve_xdp_done_dqo()
>   xdp_do_redirect()
>     __xsk_map_redirect()
>       xsk_rcv()
>         xdp_return_buff()        /* MEM_TYPE_PAGE_SHARED */
>           page_frag_free()
>             put_page_testzero() -> free_frozen_pages()
>   gve_reuse_buffer()
>     gve_dec_pagecnt_bias()
>       page_ref_add()             /* page already freed */
>
> Each redirect lowers page_count and pagecnt_bias by one together. After
> 65534 redirects from one QPL page, both are 1, and the remaining
> reference is the QPL's own base reference. The next redirect frees the
> page in page_frag_free(), even though the page is still registered with
> the NIC and still listed in qpl->pages[].
>
> gve_dec_pagecnt_bias() then sets the bias to 65535 and adds references
> to the freed page. The device keeps DMA-ing received packets into it,
> and the driver keeps handing it to XDP and to skbs.
>
> Nothing appears to block this setup. gve_verify_xdp_configuration() does
> not reject DQO-QPL, and dev_xdp_attach() does not check xdp_features.
>
> The same ordering problem existed with INT_MAX, but then it took about
> 2^31 handoffs per page. With USHRT_MAX it takes 65535, which sustained
> traffic can reach quickly.
>
> Should the refill happen at pagecnt_bias =3D=3D 1, before the buffer is
> handed off, as igb does?

pw-bot: cr
Good catch, bot, thank you! I'll address this and prepare a v2 patch.
I don't have access to DQO-QPL hardware, so I'll need someone to
test the v2 PATCH on hardware, please.

>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261031173449.2439047-1-amaan.cheval%40gmail.com
