Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F9A314B6E
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 02:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792378589; cv=pass; b=Bp2CTODQVWVuL86US82UgMhPFMZ56myc88PqnqgpsEeuijch4dg+qxh4drjYw6d/6YEn6lNdM/pv9LNRjXk3tXm9NOUTKD0DNwxTO7AIwnnKc2f0VBz8ViU3VQr9dmdpeem0vKimVZXvgZETM/9POPFelSaM9qWqp21T6nNahYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792378589; c=relaxed/simple;
	bh=wmwesieYaCZI6NCjdc4MwaVWmLw8Jr+Ky7zd0yIE7u8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+AmTVZMd3sbJpXn3MipaccqhxeuQWayCnEgdUrAGBjNqBEStw0OdUyHs/j8CZfLbXgj5YV2Aq453Wk0lInt3opYLRya/4DePPb9TorXcmSITQ0OWe7Vsm85L2+nQbK/v/xh8ezYt1Efk//QuIaWgZ3sIzlrGQ7TlIcCJ7H7sBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmXGxhqC; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmXGxhqC"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3ab46699a09so757021fa.0
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 19:56:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792378585; cv=none;
        d=google.com; s=arc-20260327;
        b=PVhg7kydsUCyIRVZhAhRihFE6DwkJLmwMfu1/IIQ/kiNGzyc+M4Gp5EZdtMa79wRQM
         G7qZPz/uQ5adgezb+N+gdG7FF2RTXKLR8bCawa3dykmRfnBJicg9C4mfx7UC4Pei0f+1
         cvAUwxKS7YdHpJRGPs9sOycMj+nDVGbaiXwzJQrjZZuQ9gpOt+kITIjh36ysfgTiaodL
         vo2goVBtQ6ygcrlJH8jIEmn+/JqipmPW93Ja6mHjoxpKRxobMH2fsaQXlpUiK99Ax90G
         8RHBMCr0B9vZUukbaV15adHqENcwpJm2Oh0dAIGVU6+cZo59fj0OlSze/sSczpOluGiF
         VYIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8dOkczWcfq1jceZZSINYmfjZD9nSuKoBsaFZX6g5gMI=;
        fh=YyQs6mhgc+a998f2ycCbOR4imWU8kxOZFAu2SBZ1dGs=;
        b=Zxu7qhmNO6jT9YvOnYfur8ZOD0I+NuxQZS2UjaVoWn+XliqygTghu69nFbemMJ/bCk
         wW9LqxySHjrK/zRZxlQfJ3Z1kc3QheL4XXIkNsDcpD/yynWhaIcFFpwJcsba2Tmo7ESx
         wavUrdvjFB7yZkF3Rk8m5ml7sBXBsWS/UvEJWuFzsGENPgddnoGkSsbDDR9fkf0a9m5g
         wz3yTJQcuyWyrfwpmgc3sZeYCXvCYLLOKcDdV9cYAG7WxXc62/g/1e0OmQnxrDyl66Rf
         acBaBghi0Dw03dInEOPHYlLgr8RnJkP2YDX3sr0528Si4gVOkj68qo+71me4WznfHApn
         BT9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792378585; x=1792983385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8dOkczWcfq1jceZZSINYmfjZD9nSuKoBsaFZX6g5gMI=;
        b=lmXGxhqCKxSCptmLfQW5Yz7LGU56YMCKoM5fL5cRbO9xW+GE4NUM1T+UBhDdcP6WrG
         +aYO3NKGUMqIHvX9xGtrrH157KQ+KXoW4NplAF3ijf9Vo/MGV3pj7qdjlSONRGET4G7t
         mmoTz8qqUNXXNhAriNtz0xGsNQzmoD/Iuf/Hw2ImShuGMXIAvdyOmwP11ql2UhGyCMXd
         GESB32idXwHvrIspG3BrKkwi0tA1ALCpjD7oXSIs7a3he9A35Q54SZHCYqWP7RBBI2LA
         oxhtSc18PFSbzwhANVvWwv0hbqwUebyOvuDAnRalbQtjDHeX/UCSm1oUWbrWLOVPGwIa
         a5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792378585; x=1792983385;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8dOkczWcfq1jceZZSINYmfjZD9nSuKoBsaFZX6g5gMI=;
        b=X4hMzxxPVxjs03AKgL+SyM7x+vaogcvuCWPoJTLwhbnB3tkcwJXupokG1AZ4dYhXK9
         lSp+VDKmJROKGVTfXSrpcY0mJHnXZbJ46q3iprwyCPgI9CUm/Rx9izARuFAJBHp8hE5c
         HHUzpjLS4BrD5eStVHbT2Ev9ZEPT2Da6mwTyGvumFQGHPGK3ZFO13Drt5dYgru4+ALMH
         OXzUxxD11ffodpyAwn41TKAn0Pk6m5hyjQlP6M+Y+MooVdbifwcn69TDQSzzT9xs9BHp
         d1byTDVc5VpucHdHTf06pajOxhRs8fx8uBYfJG9Dx0YO+IXNc2Yj/l4TFx/K27GRubFp
         eq/Q==
X-Forwarded-Encrypted: i=1; AKwUvBzhMCjjoKc40A8aC7emKd4CZeeoMSor/fIRPMBK1yvTENs/pZiqJeYr/zKYeRSGdQrBzvOqeMQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIHwLyHiu964Fuf1C52G4QSqhDbgZvCww0TmWL1FLD5OAnv1H+e
	ltwMZ2u5AOW5fJUg3mdDOJyc3I0LmJ7scja+QxMsQZFVTJGXVEeUrHAOy+kyt4LfxtliXafLdlv
	x3aHHsG6imZ5oemKa89SBsSj1ipUH7gg=
X-Gm-Gg: AYBFou1/9L97MsTcBaJUzxeLC9gq+XIshCZuACuzIAB4PtW2FmJiFbGYEIM7NDlLoV5
	ELudmpvzTw5GbDqNQnWQvVVhPU3Ubjdmn2pdcOQtU7m/aYUt9hs7JRVH/uc6RnF9CXJay8eVDKe
	oesr3SU8X6gjdkf7FSZADHPTiff4eXQAs5ENeekm0lpdrQAiIc/GpmcEI0H0u6z/YQ4BHSjQcdh
	kChOWAJlUwSVfc2PCQYbCv5Td111y4iRsr5haYfq+oRLjPSYuD279ZrhIZQKoujwTHkexKV2Wjy
	aowsOPOfUqEkYoLNwPjVEZCCs25Cenm6+QgLxHMH0jnKKsN//a65P6Pf711oVe4P9BPYnecPo/w
	RIU2f141AbSZe9qsMJjafc6NUZXTdx/9wx3nJXu1/mtPLI8CJx1lEQx8Nh+ivIEJKuZEEHn2hPI
	8hbVVc
X-Received: by 2002:a05:6512:3c89:b0:5b6:183c:5c9e with SMTP id
 2adb3069b0e04-5be50a7f102mr2090016e87.60.1792378585014; Sun, 18 Oct 2026
 19:56:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013155658.2196020-1-cjubran@nvidia.com> <CAL+tcoDJx+suVKWjuHDMVMNThK1SS_a=0t1FkUninHnsAkraGg@mail.gmail.com>
 <49c589b9-054d-4f92-ba80-b095571472bb@nvidia.com>
In-Reply-To: <49c589b9-054d-4f92-ba80-b095571472bb@nvidia.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 19 Oct 2026 10:55:46 +0800
X-Gm-Features: AclHuK_549AqAMI3SZmkXmwocZZjKmDUpYBEfYnPTtZ4BzW9xLahC1qKY4A-xWI
Message-ID: <CAL+tcoAUbJt7xv0Bx7onkKiq=r9zeEcW8KjsSUvLD_wp_kxJHQ@mail.gmail.com>
Subject: Re: [PATCH v2 net] net: skbuff: don't copy alloc_cpu in skb header copies
To: Carolina Jubran <cjubran@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dragos Tatulea <dtatulea@nvidia.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 11:58=E2=80=AFPM Carolina Jubran <cjubran@nvidia.co=
m> wrote:
>
>
> On 16/10/2026 11:11, Jason Xing wrote:
> > On Tue, Oct 13, 2026 at 11:59=E2=80=AFPM Carolina Jubran <cjubran@nvidi=
a.com> wrote:
> >> Commit 68822bdf76f1 ("net: generalize skb freeing deferral to
> >> per-cpu lists") added alloc_cpu to struct sk_buff and placed it in the
> >> headers group copied by __copy_skb_header().
> >>
> >> This is wrong for newly allocated skbs. For example, skb_segment()
> >> allocates a new skb and records the current CPU in alloc_cpu, but
> >> __copy_skb_header() overwrites it with the value from the original skb=
.
> >>
> >> If the original skb was allocated on another CPU, the segment may late=
r
> >> be treated as remotely allocated and unnecessarily deferred there when
> >> it is freed.
> >>
> >> Move alloc_cpu out of the headers group so it is preserved across
> >> header copies. Initialize it explicitly in skb_clone(), which allocate=
s
> > nit: s/Initialize/Copying
> >
> >> the skb object directly instead of going through __alloc_skb().
> >>
> >> This was discovered while investigating a throughput regression with
> >> software IPsec. The load used 512 IPsec tunnels carrying traffic over
> >> VXLAN, with 512 parallel iperf3 flows and an MTU of 4500.
> >>
> >> Before the fix:
> >>
> >>    16.09%  queued_spin_lock_slowpath
> >>               |
> >>               --15.90%--_raw_spin_lock_irqsave
> >>                         |
> >>                         --9.37%--__slab_free
> >>                                   kfree
> >>                                   skb_release_data
> >>                                   napi_consume_skb
> >>                                   mlx5e_poll_tx_cq
> >>
> >> After the fix:
> >>
> >>     6.84%  queued_spin_lock_slowpath
> >>               |
> >>               --6.57%--_raw_spin_lock_irqsave
> >>                        |
> >>                        --5.00%--__slab_free
> >>                                  kfree
> >>                                  skb_release_data
> >>                                  napi_consume_skb
> >>                                  mlx5e_poll_tx_cq
> >>
> >> Fixes: 68822bdf76f1 ("net: generalize skb freeing deferral to per-cpu =
lists")
> >> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> >> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> >> Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> > Thanks. Overall it looks good to me:
> > Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> Thanks for the review!
> >> ---
> >>   include/linux/skbuff.h | 2 +-
> >>   net/core/skbuff.c      | 2 +-
> >>   2 files changed, 2 insertions(+), 2 deletions(-)
> >> ---
> >> V2 log:
> >> - Move alloc_cpu after the headers group and fix the indentation. (Eri=
c Dumazet)
> >> ---
> >> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> >> index a3ff380d43f01..b3272d379409e 100644
> >> --- a/include/linux/skbuff.h
> >> +++ b/include/linux/skbuff.h
> >> @@ -1036,7 +1036,6 @@ struct sk_buff {
> >>          __u16                   tc_index;       /* traffic control in=
dex */
> >>   #endif
> >>
> >> -       u16                     alloc_cpu;
> >>
> > nit: no blank line here after you remove it
>
>
> Yeah, I will drop one line. Thanks
>
> >
> >>          union {
> >>                  __wsum          csum;
> >> @@ -1088,6 +1087,7 @@ struct sk_buff {
> >>
> >>          ); /* end headers group */
> >>
> >> +       u16                     alloc_cpu;
> >>          /* These elements must be at the end, see alloc_skb() for det=
ails.  */
> >>          sk_buff_data_t          tail;
> >>          sk_buff_data_t          end;
> >> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> >> index 41beaf625421a..3d82eb87f4582 100644
> >> --- a/net/core/skbuff.c
> >> +++ b/net/core/skbuff.c
> >> @@ -1593,7 +1593,6 @@ static void __copy_skb_header(struct sk_buff *ne=
w, const struct sk_buff *old)
> >>   #ifdef CONFIG_NET_RX_BUSY_POLL
> >>          CHECK_SKB_FIELD(napi_id);
> >>   #endif
> >> -       CHECK_SKB_FIELD(alloc_cpu);
> >>   #ifdef CONFIG_XPS
> >>          CHECK_SKB_FIELD(sender_cpu);
> >>   #endif
> >> @@ -1618,6 +1617,7 @@ static struct sk_buff *__skb_clone(struct sk_buf=
f *n, struct sk_buff *skb)
> >>          C(len);
> >>          C(data_len);
> >>          C(mac_len);
> >> +       C(alloc_cpu);
> > One minor question: does it affect the following two cases:
> > 1) skb_morph()
> > 2) else branch in skb_clone()
> >
> > Looking at the above logic, I think as to #2 point it seems the impact
> > doesn't matter...
>
> For skb_morph() this patch does not change the existing behavior.
> skb_morph() reuses an existing destination skb and turns it into a clone =
of
> src by calling __skb_clone(dst, src).
> Before this patch, alloc_cpu was part of the headers group, so
> __copy_skb_header() inside __skb_clone() copied src->alloc_cpu to
> dst->alloc_cpu implicitly.
> After moving alloc_cpu out of the headers group, the explicit
> C(alloc_cpu);
> in __skb_clone() preserves exactly the same behavior.

Makes sense.

>
>
> >
> > And I'm a bit confused reading the allocation process because there
> > are two possible split allocations for the skb structure itself and
> > the head/data area. They might run on different cpus, which means it's
> > hard for 'alloc_cpu" to choose appropriate one to free under this
> > condition.
>
> Good point. The current documentation describes alloc_cpu as the CPU
> that allocated the skb, while skb_attempt_defer_free() refers to the
> CPU that allocated the skb/pages.
> So it seems that alloc_cpu is best effort for deferred freeing?

I suppose so.

Thanks,
Jason
