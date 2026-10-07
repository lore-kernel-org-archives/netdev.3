Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2C443BDA0
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 22:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791412604; cv=pass; b=PXl+081PcGOubnStap8P7w067eAmvSnAwb+vLsYJGqOygyxlPON8AHnVRvrljzxkEkv/Z5KbXh8NM2pFd+J329Hq6NA4OoNtc1aLPMqNVqZZQAbNW01O2/z3C37KmCb7piXYRXcsr/tM+jvGy+sNl1XW/J+NFY12o0p1dTIIjM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791412604; c=relaxed/simple;
	bh=kuwLwNIaS0PjQyg5DDxE7ag7kQm8wcJCAsbzZkLra1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BoHRNV1PEMq91itMICJfohv992khyt2PFFgNqxgLJTFfChdNwCS/BHE+qlei5eXfWqnE/eygD9vQGzG09wljxQNtQQApDqEO2mmQdiI5TyygL67yOh3y9kF9TWGspLyefXSD0m/QFCgBn3tWwjCOaCzBal47Zr+zAPo3Getcu4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5uqPRxr; arc=pass smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5uqPRxr"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4f48d91ba7dso1240056b6e.2
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 15:36:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791412601; cv=none;
        d=google.com; s=arc-20260327;
        b=IRd+s6d7d+nptrsN0IskIW/V7FKso5gXSiD8nPLYUtWu4F5/waaTUvcNb+TAJpxju9
         vRyIm2FwKWvLfzABHvgtXnSm9vU2E/vj5NNrTT0rLz6N3JUOAQ+FJJO/tMoRC86G0vYj
         zW+VgxwHbEGOqfFlAlFlLZcu7yFmK3U0tnWitW4WXc+UXT8/28doibXaAhXpYsV4GW5D
         hr4LjHdtg1qYFc1nWw4KahhtddZm00iOjvgRMq03ws6ackgY0XcPzzX1XA3RY7P+fVq0
         hFRfzwfG3eXQZ7hB34QM9OYetIBx/iKzZ435XnRomZ5RxmMSmTJM5XgkgAjiOn2IHg6d
         VMGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h9ZmRP+/mWYldgCkpzW6OiHxi4sAaJjqTFFMOvBqFLs=;
        fh=eBsZJOlB2TD9Xkv0rX8iQhZ80nJcfv0b02bnao8BQn0=;
        b=dZ0igAOl7TBiTfqf5ZQ/Ff1c0VmOz4fYWuIlGn9MJOwTd5NJofpD3brquu7ZuD6JyT
         iU3BYHi3B13Kh0UAWpODdXUtHM7g5ld03Z+jZb89C4OIDxC7w+YJiEfgPkyokyBJNjFf
         QX8jufE+EONcM9xKZ4YVmfP1xC9mS+7aShNRdn7QtF4jlRcFbAranT6P5/tkLXmlRoY/
         JauP3JvE+mf6y+iLlwSf+8wNRG/RwJuJqf3rhq8YlgwGzCvr99B4JI7vlPj9m+GhoJG1
         OcSImdy5sdgqkhfc/KOqdhkWVi3TneTk5oULepwUlWXVCOHO2dqr3+HLQHeP1onbiXN4
         EU7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791412601; x=1792017401; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h9ZmRP+/mWYldgCkpzW6OiHxi4sAaJjqTFFMOvBqFLs=;
        b=j5uqPRxrEF9MhYkrsYLyVDs5ydia4wZ7S0oruAI68beh/oAmIOndyukk+V0HofNwnC
         UF5xbwDefLNQdRqYEZUV2hjaOUtH3x81ZtgdhQDZcGxviS5WiDqSR27MTflWil0nCbv7
         ASf1P9TAueI6C0uHCcdoBkUlzwqUN4iDrcwg0/rXkXK/QPjhIgmjm7VYo2Yf1GqYSSZx
         l/JHQ0rI2d+zTdAByIqZC56ZRI3KJXOZoMi3xEdZsw9J1ObCKoqSVhyh//7iSTjpYATQ
         z1n1AxOstpCzHOm5LeT22CloX8IUx3wyS20PetJ0MrAIgz8IeHIM0LAkDfWEgHDR90RZ
         zzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791412601; x=1792017401;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h9ZmRP+/mWYldgCkpzW6OiHxi4sAaJjqTFFMOvBqFLs=;
        b=yPRIxz1lyHJJrJ57RR1c30INOQmvdMR24m2zg//MUcfHXJO/yTBKfPAL1IhUBq/tHl
         Mrx+yjLpFRsYqyKJvnAICsL2FWNPC1PiGOIFR8NLgzBuhNy0jB4ahyAYVIX8iAX2SlPn
         RkelC0qNgCyogx/6Kt117nwZZWeR8pfWNDYLi32RmrFraxHU9nZQr4P+FgKuafUalq6o
         GJGtSMgKsoNNqtSEVTt5A4dElD/AEE+wr2ulA5RU9ZcEUC8JGHq21vkn49JQttWUnak1
         tpuoYN+c9nsgOggH+r+t/yEyYmRb+RKP2wTcJhxAQ7kBtW0NkUwcidL6rqLCMemqiuNZ
         bSZQ==
X-Forwarded-Encrypted: i=1; AKwUvBx4L3VetGAf+IetOjdjOsbughHt5+ETaVxIkm4ErwxzmP9USB+yIXnrVQnBIJobkKzTLLfOXVA=@vger.kernel.org
X-Gm-Message-State: AFuF++my+Yp4wS7FkRuUsektCzU/6Rs3kZ4v8y0SqTdJh6yZGCQrkQAk
	dDkuWWcAicoKvHa6Mkf/70x9Ckd5f2byeb2CHBY41YHReXd+wHCEFwJkDg29JIrJHFekeM8USpa
	agVsD03dAnZp1OutafvWboQBCGzo+hqQ=
X-Gm-Gg: AYBFou1unCH/ycJSqmeasetZoFKGaq5phNK3yJmsmhglEeB1qToA0zvPxMEOSILRTfc
	FbeJILcicXY2DTOhhJFrJYTCeJNY4JeMmQAJ3CLGrzLGOUG7A/nv2G+PC8VzYYOCHrb6aJizdxn
	rcqDq95toGcfAsQIX4JsL637x57J7KAUUGVxtdGFEdgijMR8gsBvniEMEJ0GuMZh51a1FajjFWC
	nr4UGnpr2+iDA6ygbtUt1eYWlA4B3uG10XYzP8mjYPndxWEjUysmT5y9xxoe5GlMHvpG6rFjgf6
	WXQanr82QoYWwZsPt7hjib7JLGWHIDYsoZxCIDgAhEYF+i67qmTFkqQ=
X-Received: by 2002:a05:6808:228b:b0:4e7:8f9b:1191 with SMTP id
 5614622812f47-4fc473ae762mr3907604b6e.52.1791412601453; Wed, 07 Oct 2026
 15:36:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com> <20261006192601.1875100-5-kuniyu@google.com>
 <CAMB2axM8+eW=jiDgV4EHgCxXpzZDdj3PVZc-8hZ9_3bMWMMDYg@mail.gmail.com> <CAAVpQUD5eBzZJ3+1y+HbPhDf0q9juZc9g8v5J_ghHssEg2wXwg@mail.gmail.com>
In-Reply-To: <CAAVpQUD5eBzZJ3+1y+HbPhDf0q9juZc9g8v5J_ghHssEg2wXwg@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 7 Oct 2026 15:36:30 -0700
X-Gm-Features: AclHuK-X967fdbhZ58Ih9UEarwnuA6UR8PfbZ78119IQkH91wzNvZrk0ge0spWo
Message-ID: <CAMB2axPVrw-OGz_35yKw=QzHfcqRvtuhiLVs-_h5B1FUpN84mA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 04/10] bpf: tcp: Guard fast-path
 bpf_tcp_ops_call() under per-socket flag.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 7:48=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> On Tue, Oct 6, 2026 at 4:25=E2=80=AFPM Amery Hung <ameryhung@gmail.com> w=
rote:
> >
> > > +++ b/net/ipv4/tcp_input.c
> > > @@ -210,6 +210,11 @@ static void bpf_skops_established(struct sock *s=
k, int bpf_op,
> > >
> > >  static void bpf_tcp_ops_parse_hdr(struct sock *sk, struct sk_buff *s=
kb)
> > >  {
> > > +       const struct tcp_sock *tp;
> > > +
> > > +       if (!cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS))
> > > +               return;
> > > +
> > >         switch (sk->sk_state) {
> > >         case TCP_SYN_RECV:
> > >         case TCP_SYN_SENT:
> > > @@ -217,7 +222,12 @@ static void bpf_tcp_ops_parse_hdr(struct sock *s=
k, struct sk_buff *skb)
> > >                 return;
> > >         }
> > >
> > > -       bpf_tcp_ops_call(parse_hdr, sk, skb);
> > > +       tp =3D tcp_sk(sk);
> > > +
> > > +       if ((tp->rx_opt.saw_unknown &&
> > > +            BPF_TCP_OPS_TEST_FLAG(tp, PARSE_HDR_OPT_UNKNOWN)) ||
> > > +           BPF_TCP_OPS_TEST_FLAG(tp, PARSE_HDR_OPT_ALL))
> >
> > nit:        ^ missing a space
>
> this indentation is correct.

Sorry. False alarm.

>
> >
> > > +               __bpf_tcp_ops_call(parse_hdr, sk, skb);
> > >  }
> > >
> > >  static __cold void tcp_gro_dev_warn(const struct sock *sk, const str=
uct sk_buff *skb,
> > > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > > index 3ac465513bf5..8770f3084efe 100644
> > > --- a/net/ipv4/tcp_output.c
> > > +++ b/net/ipv4/tcp_output.c
> > > @@ -581,8 +581,8 @@ static void bpf_skops_write_hdr_opt(struct sock *=
sk, struct sk_buff *skb,
> > >          * writer's bytes). The writer finds the append point by scan=
ning from
> > >          * first_opt_off + nr_written to the first NOP.
> > >          */
> > > -       bpf_tcp_ops_call(write_hdr_opt, sk, skb, req, syn_skb, synack=
_type,
> > > -                        first_opt_off + nr_written);
> > > +       bpf_tcp_ops_call_flag(write_hdr_opt, WRITE_HDR_OPT, sk, skb, =
req,
> > > +                             syn_skb, synack_type, first_opt_off + n=
r_written);
> > >  }
> > >  #else
> > >  static u32 bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *sk=
b,
> > > @@ -613,11 +613,13 @@ static u32 bpf_tcp_ops_hdr_opt_len(struct sock =
*sk, struct sk_buff *skb,
> > >  {
> > >         unsigned int remaining_out =3D remaining, reserved;
> > >
> > > -       if (!remaining)
> > > -               return 0;
> > > +       if (!cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS) ||
> > > +           !BPF_TCP_OPS_TEST_FLAG(tcp_sk(sk), WRITE_HDR_OPT)||
> >
> > nit: missing a space before ||
>
> oops, due to last minute edit :/
>
> >
> > > +           !remaining)
> > > +               return remaining;
> > >
> > >         /* bpf_tcp_ops_reserve_hdr_opt() reserves space via remaining=
_out */
> > > -       bpf_tcp_ops_call(hdr_opt_len, sk, skb, req, syn_skb, synack_t=
ype, &remaining_out);
> > > +       __bpf_tcp_ops_call(hdr_opt_len, sk, skb, req, syn_skb, synack=
_type, &remaining_out);
> > >
> > >         reserved =3D remaining - remaining_out;
> > >         if (!reserved)
> > > @@ -1193,8 +1195,9 @@ static unsigned int tcp_established_options(str=
uct sock *sk, struct sk_buff *skb
> > >                                         struct tcp_key *key)
> > >  {
> > >         struct tcp_sock *tp =3D tcp_sk(sk);
> > > -       unsigned int size =3D 0;
> > >         unsigned int eff_sacks;
> > > +       unsigned int remaining;
> > > +       unsigned int size =3D 0;
> > >
> > >         opts->options =3D 0;
> > >         opts->bpf_opt_len =3D 0;
> > > @@ -1224,10 +1227,10 @@ static unsigned int tcp_established_options(s=
truct sock *sk, struct sk_buff *skb
> > >          * left.
> > >          */
> > >         if (sk_is_mptcp(sk)) {
> > > -               unsigned int remaining =3D MAX_TCP_OPTION_SPACE - siz=
e;
> > >                 bool has_ts =3D opts->options & OPTION_TS;
> > >                 int opt_size;
> > >
> > > +               remaining =3D MAX_TCP_OPTION_SPACE - size;
> > >                 opts->mptcp.drop_ts =3D 0;
> > >
> > >                 opt_size =3D mptcp_established_options(sk, skb, remai=
ning, has_ts,
> > > @@ -1244,7 +1247,8 @@ static unsigned int tcp_established_options(str=
uct sock *sk, struct sk_buff *skb
> > >
> > >         eff_sacks =3D tp->rx_opt.num_sacks + tp->rx_opt.dsack;
> > >         if (unlikely(eff_sacks)) {
> > > -               const unsigned int remaining =3D MAX_TCP_OPTION_SPACE=
 - size;
> > > +               remaining =3D MAX_TCP_OPTION_SPACE - size;
> > > +
> > >                 if (likely(remaining >=3D TCPOLEN_SACK_BASE_ALIGNED +
> > >                                         TCPOLEN_SACK_PERBLOCK)) {
> > >                         opts->num_sack_blocks =3D
> > > @@ -1277,22 +1281,18 @@ static unsigned int tcp_established_options(s=
truct sock *sk, struct sk_buff *skb
> > >
> > >         if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
> > >                                             BPF_SOCK_OPS_WRITE_HDR_OP=
T_CB_FLAG))) {
> > > -               unsigned int remaining =3D MAX_TCP_OPTION_SPACE - siz=
e;
> > > -
> > > +               remaining =3D MAX_TCP_OPTION_SPACE - size;
> > >                 remaining =3D bpf_skops_hdr_opt_len(sk, skb, NULL, NU=
LL, 0, opts,
> > >                                                   remaining);
> > >
> > >                 size =3D MAX_TCP_OPTION_SPACE - remaining;
> > >         }
> > >
> > > -       if (cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS)) {
> > > -               unsigned int remaining =3D MAX_TCP_OPTION_SPACE - siz=
e;
> > > -
> > > -               remaining =3D bpf_tcp_ops_hdr_opt_len(sk, skb, NULL, =
NULL, 0, opts,
> > > -                                                   remaining);
> > > +       remaining =3D MAX_TCP_OPTION_SPACE - size;
> > > +       remaining =3D bpf_tcp_ops_hdr_opt_len(sk, skb, NULL, NULL, 0,=
 opts,
> > > +                                           remaining);
> > >
> > > -               size =3D MAX_TCP_OPTION_SPACE - remaining;
> > > -       }
> > > +       size =3D MAX_TCP_OPTION_SPACE - remaining;
> >
> > This static-key check is not redundant unless
> > bpf_tcp_ops_hdr_opt_len() is inlined. In my build,
> > tcp_established_options() unconditionally calls the out-of-line
> > helper, so sockets pay the call/prologue cost even when no bpf_tcp_ops
> > is attached.
>
> Interesting, I guess you don't use FDO ?

Thanks for explaining. Yes. I did not use FDO for my local build.

>
> On my FDO build, even tcp_established_options() is inlined
> to __tcp_transmit_skb() and both bpf_tcp_ops_hdr_opt_len()
> and bpf_tcp_ops_hdr_opt_len() are NOPs as expected.
>
>     ffffffff8224a511: 41 bc 28 00 00 00     movl    $0x28, %r12d
>    # remaining =3D MAX_TCP_OPTION_SPACE (40)
>     ffffffff8224a517: 45 29 ec              subl    %r13d, %r12d
>    # remaining -=3D size
>     ffffffff8224a51a: 0f 1f 44 00 00        nopl    (%rax,%rax)
>    # bpf_skops_hdr_opt_len()
>     ffffffff8224a51f: 44 89 64 24 78        movl    %r12d, 0x78(%rsp)
>    # remaining_out =3D remaining
>     ffffffff8224a524: 0f 1f 44 00 00        nopl    (%rax,%rax)
>    # bpf_tcp_ops_hdr_opt_len()
>
> I will add a static inline function and move both
> cgroup_bpf_enabled() there and reuse it in 3 places.
> (same for bpf_tcp_ops_parse_hdr())
>
> Then, the unnecessary movl will also disappear.
