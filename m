Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464CA3B47D2
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514371; cv=pass; b=C3/czftfivSoo7JN5lU7jD+o5BSvix9EV44NOWQeA9+ecfyxp6NUOV8MePkTAkqWbVpmSalP1dVUdCLmLpaCK8X4VFuTW0Wjtpln0bPng2FE3lF2DjhdfhHY0OGtIa+VFHqRJBuRfslwLJdcGbZRmnd/4iliN8TQGG5VBte21Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514371; c=relaxed/simple;
	bh=DUvKeV2pYYS98XZI/yTtVHhkMvupMqQvMCeD1x4mefk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgsPr2DqyCTykC7Bawsm31R2EA+xVDvKMiSqJyRYrj9PdorHtDjcBWXT3d72hqagUAw9p9Ykpo7Kx8Unw1hPdh2EQNey4h2bYqupBQ4pO5MkjIEsoZ+f2fDWCweaznYIHLJfMlQKNuYghztLe1jr4deqoEL5bSAwFEmINRx6Dx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDVt1xjW; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDVt1xjW"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-530256c6031so9233401cf.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 02:32:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788514368; cv=none;
        d=google.com; s=arc-20260327;
        b=FI/CtLmIzqQzPI/T3N15GinGhT3WIa+/GsbbtqNZYp/NKerIm+bMsb9vzMtSpavONe
         HO38+BT5FUHUgrz6rnKD87lz5a5al114it0BDKngPZ0j3QeResizObKC+90qZcP7wy7/
         /EqXd4krICEsuYmpSv5v/agqI45SwLY9apws51+GxDHUmLr2TT5B5mLgk9gYgvXhxiq/
         RlaL4O6CGd789Xn655+zYTmg/6kEcfA05twS+GTNaeQvAVYrsLOwcUSHmprzFbkYbECm
         /d/O4R/1ta0LMDXsvm3V3GV9pVFJlxT3KO9kiYvfCfaB6ydXUcfXAQhKOpgilbfIUME6
         EZdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4kpXCOkiIJd2qFDqOWzg8CKGG2LbCdOC7gWq0if0NCg=;
        fh=byawDMCWgoNDJGj8Js/tZSAlVOfc1rC2Kp56pnEYAeM=;
        b=EAh/BXjelKezrM7ebrjuLYez8uDp/44l0YxSG6t6KpFi0BoXDLlq5fCgpo1I/SItUl
         pilWzCkaepAB58IyoCrQ8jD8h584Lozt+xGGEpCbNOiaQVn8z93ziitslERHlHMl0tfP
         bNa6z0cjGs4jR6bt+Y83V4BSjDvNY+ux6P+7aeBguvtEgXCLYdc0ql7tyhfKm2OVRqAJ
         Oc0plL0gRAL9z0KrDIg0OYNnDmjMqxx8cyxwnrvUrXBxJslkudfpcOv3lZT0+meekXZ9
         LElAmOk79Kf2KYQDvo7munoY5j7h+GY5+dNjAGBBCzfYE6jQ8U83IdgDMih/M7z55pMv
         jb9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788514368; x=1789119168; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4kpXCOkiIJd2qFDqOWzg8CKGG2LbCdOC7gWq0if0NCg=;
        b=ZDVt1xjWOSBiUjk22NFNPzBzoaIyh4txOAVVzHsRHuUwuzaUgdAQSVFyLErkUoUvjm
         sGrALbQAXo6DPWj/+LgEheTSEQ4pg4K4izPW+ZrLgvhId8kpjFsVUrBG1Ln20J5zGZWZ
         mLLqSw1ha8US33WxmcYJ6TljQUsfrlF0oTgrHjwF0J5+kknkLKANE8ymqz4ZL4RyjxMn
         EC0rinYoRqIsU8tNJEr5V6YEJafivC8zpBbejYVIEg8INv1bhalDNFm8Gxcmlcx1tyRP
         ogxqEnKU+WLUOEy9IE6n/GqSe4nOD/sPeCYg3bSwtfZkW3noXZ3jghPeF8hVEf3cAX7O
         nyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788514368; x=1789119168;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4kpXCOkiIJd2qFDqOWzg8CKGG2LbCdOC7gWq0if0NCg=;
        b=TMF+A1JylNco6lC+XECOXoRSv5M75Guy7goYSW3QjWXHfR3Pah061DUnnxIP3HF5ui
         DotKtcLH7sIhEB4yBy9QD/rsDRlYxwDOE1Ck90gt8XJ3YnXu6b0ZQ29XrssGDCdWXmsb
         jHXqT3f/vmTLrYeKm8GB85XvL30tRF7kZ9BVYa4TpGe8qEIDaAGOBAQhIHN3i8ehPDLD
         IfIncgXBt6q7oMcwU1AYM2o7ykJQQStvZjzqLztsynjICyJSH0fbHLxlCB1W409yMOTr
         JHp9rdtcGidwyiLXq9P2Q6jehSM7voF4foDGfUVglbgmI89hF05Ja1UcCdF/s3GLIIlE
         2M8A==
X-Forwarded-Encrypted: i=1; AKwUvBwbl+F/CfamhOQ3oWQtI+b+u9+zbEn4yGRYQle3m4MHOKXUso37VIXm8SPZZ2JGmVmD7wJa6fE=@vger.kernel.org
X-Gm-Message-State: AFuF++k+AO2fgBiL+zrZOm51TR7XOaAifncM0udHJCp6MocQ2FIa+OZE
	FLoUrQix4qLafU40KrsQkoCy9iA4fmfBUjfOZQyRwP6+DZu+JcHTaRrWwpeP2rDycf7mp0uodad
	GIkxEb1GuFJO/IzS8kToCDlMvEpT9ja8=
X-Gm-Gg: AYBFou1Mvh6uGxGS62rJ/e4J87Sqi6cA1lnvjYWNbfGaTt26TFcLeWXR1GLc6a+axX0
	tRL0hVPOOktie6HB5OwjpUs5Yf12ult+Ms8IJ5heyccm0tJGCn+krRCL6IGNK7jti53v03ZQxgQ
	GDxQosPPaD5UZQR2IYTlrCJV13yu/n8SG1brDHUQYAvT+oNihUPIVxRlZjnbdF8paXEO6idXK7D
	jg0LRIVQffU6DZYEWKjKCmt/ghOUabXhAl6z7o7P3M4Ekdt+1to3VFxIMiX6bAgLMgxbfDFilWr
	sHcyx8oQLcdbUtykW7pTBZ96dvh87LtpkKi1R7xhGfcfsg==
X-Received: by 2002:ac8:59d5:0:b0:530:430b:cce5 with SMTP id
 d75a77b69052e-53054a3a641mr46885291cf.47.1788514367989; Fri, 04 Sep 2026
 02:32:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788202924.git.caoruide123@gmail.com> <12d0c7f938729d16fcdd5b46a6a0e912fb1cd2f8.1788202924.git.caoruide123@gmail.com>
 <99e76bbc2679c6c288f5ddf63d25dda03ce97379.camel@kernel.org>
In-Reply-To: <99e76bbc2679c6c288f5ddf63d25dda03ce97379.camel@kernel.org>
From: Ruide Cao <caoruide123@gmail.com>
Date: Fri, 4 Sep 2026 17:32:36 +0800
X-Gm-Features: AcwNN1XNq_rDKvHSYk92RP2jEOs6D5JwaMlKaPT2137-ERyf_Q7wwA86AzJZ3t0
Message-ID: <CACveakTqvGjdkJ60po91jzUf5QTTPvQqtATtXrQNuqn+5Htszw@mail.gmail.com>
Subject: Re: [PATCH net v5 1/2] mptcp: hold MP_JOIN msk ref when cloning reqsk
To: Geliang Tang <geliang@kernel.org>
Cc: Ren Wei <weir@nebusec.ai>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	matttbe@kernel.org, martineau@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	ncardwell@google.com, kuniyu@google.com, daniel@iogearbox.net, kafai@fb.com, 
	kylebot@openai.com, david.lee@trailofbits.com, vega@nebusec.ai, 
	sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

Thanks for catching, agreed.

Since no functional change, would it be OK to fix it up while
applying? Otherwise, I can respin.

Best,
Ruide

Geliang Tang <geliang@kernel.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=883=E6=97=
=A5=E5=91=A8=E5=9B=9B 10:07=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Ren,
>
> On Tue, 2026-09-01 at 18:33 +0800, Ren Wei wrote:
> > From: Ruide Cao <caoruide123@gmail.com>
> >
> > TCP request migration clones pending request sockets with
> > inet_reqsk_clone().  For MPTCP MP_JOIN requests this byte-copies
> > subflow_req->msk, but the clone does not own a reference.
> >
> > The original and cloned requests can consequently drop the same msk
> > reference, leaving one request with a dangling pointer.  This
> > manifests
> > as a KASAN slab-use-after-free in subflow_req_destructor().
> >
> > A non-NULL subflow_req->msk means that the request owns one
> > reference.
> > The third ACK can concurrently transfer the original request
> > reference
> > to the child and release it, so taking an unconditional hold on the
> > copied pointer is unsafe.
> >
> > MPTCP sockets use SLAB_TYPESAFE_BY_RCU and all current
> > inet_reqsk_clone() callers run in an RCU read-side critical section.
> > Read the pointer from the original request, acquire a reference only
> > if
> > it is still live, then re-read the original request to verify that it
> > still owns the same msk.  If either check fails, clear the clone
> > pointer;
> > otherwise its normal destructor balances the new reference.  Mark the
> > ownership-transfer store with WRITE_ONCE() to match the lockless
> > reads.
> >
> > Patch 2/2 completes the clone fixup for MP_CAPABLE token ownership.
> > Both
> > patches carry the same Fixes tag and are required for stable
> > backports.
> >
> > Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at
> > retransmitting SYN+ACKs.")
> > Cc: stable@vger.kernel.org
> > Reported-by: Kyle Zeng <kylebot@openai.com>
> > Reported-by: David Lee <david.lee@trailofbits.com>
> > Closes:
> > https://lore.kernel.org/all/20260804095051.715355-1-david.lee@trailofbi=
ts.com/
> > Reported-by: Vega <vega@nebusec.ai>
> > Assisted-by: Codex:gpt-5.4
> > Signed-off-by: Ruide Cao <caoruide123@gmail.com>
> > Signed-off-by: Ren Wei <weir@nebusec.ai>
> > ---
> >  include/net/mptcp.h             |  7 +++++++
> >  net/ipv4/inet_connection_sock.c |  4 ++++
> >  net/mptcp/subflow.c             | 33
> > ++++++++++++++++++++++++++++++++-
> >  3 files changed, 43 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> > index 71b9fc5a5796..0a02ac1ed22d 100644
> > --- a/include/net/mptcp.h
> > +++ b/include/net/mptcp.h
> > @@ -223,6 +223,8 @@ int mptcp_subflow_init_cookie_req(struct
> > request_sock *req,
> >  struct request_sock *mptcp_subflow_reqsk_alloc(const struct
> > request_sock_ops *ops,
> >                                              struct sock
> > *sk_listener,
> >                                              bool
> > attach_listener);
> > +void mptcp_subflow_reqsk_clone(struct request_sock *req,
> > +                            struct request_sock *new_req);
> >
> >  __be32 mptcp_get_reset_option(const struct sk_buff *skb);
> >
> > @@ -309,6 +311,11 @@ static inline struct request_sock
> > *mptcp_subflow_reqsk_alloc(const struct reques
> >       return NULL;
> >  }
> >
> > +static inline void mptcp_subflow_reqsk_clone(struct request_sock
> > *req,
> > +                                          struct request_sock
> > *new_req)
> > +{
> > +}
> > +
> >  static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
> > { return htonl(0u); }
> >
> >  static inline void mptcp_active_detect_blackhole(struct sock *sk,
> > bool expired) { }
> > diff --git a/net/ipv4/inet_connection_sock.c
> > b/net/ipv4/inet_connection_sock.c
> > index 6257459bcee2..896f472dcba2 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -21,6 +21,7 @@
> >  #include <net/xfrm.h>
> >  #include <net/tcp.h>
> >  #include <net/tcp_ecn.h>
> > +#include <net/mptcp.h>
> >  #include <net/sock_reuseport.h>
> >  #include <net/addrconf.h>
> >
> > @@ -961,6 +962,9 @@ static struct request_sock
> > *inet_reqsk_clone(struct request_sock *req,
> >               rcu_assign_pointer(tcp_sk(nreq->sk)->fastopen_rsk,
> > nreq);
> >       }
> >
> > +     if (rsk_is_mptcp(req))
> > +             mptcp_subflow_reqsk_clone(req, nreq);
> > +
> >       return nreq;
> >  }
> >
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index 8e386899ceb9..e08d1036ad78 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -47,6 +47,37 @@ static void subflow_req_destructor(struct
> > request_sock *req)
> >       mptcp_token_destroy_request(req);
> >  }
> >
> > +void mptcp_subflow_reqsk_clone(struct request_sock *req,
> > +                            struct request_sock *new_req)
> > +{
> > +     struct mptcp_subflow_request_sock *subflow_req =3D
> > mptcp_subflow_rsk(req);
> > +     struct mptcp_subflow_request_sock *new_subflow_req;
> > +     struct mptcp_sock *msk;
> > +
> > +     new_subflow_req =3D mptcp_subflow_rsk(new_req);
> > +
> > +     /* A non-NULL ->msk means the request owns one reference.
> > The clone
> > +      * copied only the pointer, while the original request can
> > concurrently
> > +      * transfer its reference to the child.  Acquire a reference
> > for the
> > +      * clone, then verify that the original request still owns
> > the same msk.
> > +      * MPTCP sockets use SLAB_TYPESAFE_BY_RCU and all clone
> > callers run in
> > +      * an RCU read-side critical section, keeping the memory
> > stable here.
> > +      */
> > +     msk =3D READ_ONCE(subflow_req->msk);
> > +     if (msk) {
> > +             struct sock *msk_sk =3D (struct sock *)msk;
>
> Here we usually name this variable "sk", and correspondingly, the
> socket for the subflow is generally named "ssk".
>
> Thanks,
> -Geliang
>
> > +
> > +             if (!refcount_inc_not_zero(&msk_sk->sk_refcnt)) {
> > +                     msk =3D NULL;
> > +             } else if (READ_ONCE(subflow_req->msk) !=3D msk) {
> > +                     sock_put(msk_sk);
> > +                     msk =3D NULL;
> > +             }
> > +     }
> > +
> > +     new_subflow_req->msk =3D msk;
> > +}
> > +
> >  static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1,
> > u32 nonce2,
> >                                 void *hmac)
> >  {
> > @@ -919,7 +950,7 @@ static struct sock *subflow_syn_recv_sock(const
> > struct sock *sk,
> >                       }
> >
> >                       /* move the msk reference ownership to the
> > subflow */
> > -                     subflow_req->msk =3D NULL;
> > +                     WRITE_ONCE(subflow_req->msk, NULL);
> >                       ctx->conn =3D (struct sock *)owner;
> >
> >                       if (subflow_use_different_sport(owner, sk))
> > {
