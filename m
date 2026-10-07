Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3348D3AAF4C
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 02:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791341305; cv=pass; b=XSsoGqeKmXucfgD7Yj3ZvJ4FJlR+KMftFTjZeb1PTRtqrUz/jRrddSsIFzlahunOVrmov3vFAELDtF65lU+/x5M7wQMmgyyzRB+v36BdzyCD3tPRUD+MthqM8Qgw9cHMtwT1J0KKVaXl/uz/OPttQksi0fS9Q5ppYc9xAiFILgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791341305; c=relaxed/simple;
	bh=Pol2x2aR+ztfSV8OAuK2uGHcpqU+lgY9bEO0kITZYg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R01bAMxOimtgcF8y6lA+YNt8blNvYDGQLrgwitcfNK43XGbIi9kbLfvaQ4W3fJwK1tkrP4i2LzhJKd28hmAEkDbXj3L3sI5mfnIjp4XhxKv9PcTRJzFV3rCUJyXCacdiuTga4WjUb2njYrKSEj3KrJpdovPWxmZt5B9LPfBVXmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GVPlaxs+; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GVPlaxs+"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-35154cb9de2so1410574eec.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 19:48:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791341302; cv=none;
        d=google.com; s=arc-20260327;
        b=UwIkUHdP4FZc/Bz1hLLMc7BNL3nhcsS3FikmhtAHMV14P+ZrT4be2xvzW7R5KR16I0
         DyrGl30JhBP+e2um5MLeRM1g05WH0qOMAbwCdm+lLUw2ScURnDARUdl8NExguujVwGZT
         1Eb2i3vLasobFSrdM37JOA9nBI8r6gjQHu0+bTgsFPq9/o5yUKobKK/q1KTXcUUVzA52
         To+fNSHCIdxcctG/sBOPTBjDzPjRZckLWywcoNJ9Ef1Le1Zkp1b6bMFCwLql2ZzzPVRX
         6OXja7jrVBjU2qqKXT2wx7ZCNPfYhjLw7oW1qzyV87w2oVTi0K3yn4OLXeF5ILsOdQjh
         p+CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sHy1JYFdoI2r/bttA4e6UY6RBQWw0EiOqXBwtjtNkw8=;
        fh=WHE78e7xdq56Nt6w7Es/uG4wXZD3NTPSSzkEWt34SjU=;
        b=ZtkvjQyub9tnO3RloW4vxj1GIsrMxmta9JLiDR/pznVd3ed0cNxvlAoOWS82xzrig4
         nSs6/y+7/92aCrir/1PIz+NvvgoG9LKyksI1EJ0ztU+QsdrNwJmbqF9xpW5/VSARFWvi
         GzfiMtcI2+a4+cecLWPCKSlJq8U8XCHgmnxkBHYktncOdsSQhy10WJlcflXTB4h7CJt4
         UBUi0D/oqb9RDSokxpiA1AWxCYSyvqNMuaIywgqj/GSb3YjrqRYQFlJDUVhS46PvLhqZ
         +BGE+7ZLJWhlk6H93q4KGdIpStgQahVT9VJe3dAG5TlaAzTZ5dJHL0ckB6fssRz20ok/
         uQQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791341302; x=1791946102; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sHy1JYFdoI2r/bttA4e6UY6RBQWw0EiOqXBwtjtNkw8=;
        b=GVPlaxs+DS/sNjcL9tnKt90ejYEEgqLfP0MWOvpHM8KxljKtYLLw9hVvuORoGD24XN
         xMUiKfFRMZ4qZw48CkK2OUrOmvstzWYUGNSHdEswMTIrL/XvqXML9a7lN28Vz6/HoOAT
         UzvUjkLLI/6rqqdGrLFvHnniVBu10H/Y68vb+FmEJQrleC3/NU+SEy0EkaJTQlymUr44
         nzsjToE2WmJrCVOO20gp46GWQEAiQHMnJQyRHRy+/o36tQ5TLFedL6ziNun3DHekZ1nw
         giubKcYm8z5rVzI2IFSUJA3GoI594T3daEg+rPqogrjUrl2oGnVGxREGwHaHlNOT7QSd
         I8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791341302; x=1791946102;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sHy1JYFdoI2r/bttA4e6UY6RBQWw0EiOqXBwtjtNkw8=;
        b=DMV2ZZtvjXmUc9mMB6qx8ISFpnMlCp5B5uQ9IgtPnJdZOjvp7OA0hkgkPxom+WSBUq
         hyEVfFxjHcEvYqUuhpkMLQ0ZpoDpXts+HzOInlkcrsXm6k1l/eIfbkY9VG5shvMshCFy
         XngjbdOg+s3EF4FExPcU+HeuiBNvGCHHAuzMKnKX44sOrFm+OP2b3JDICIpSMCbjABKC
         o5NMPVEn8dJTuCA89tCMo259r70M+w6+dVbNsczpLXmagTBUyCLfQInBvJ2W3yeHf8Nx
         +fdgzcxNbgegeNK1S2AsyKnS89vUeyP749hMuFYoWWVSlnlHy3XSZdSpGNaMOAMxvzFT
         K2tw==
X-Forwarded-Encrypted: i=1; AKwUvBwsmAHYtwhjePTxuIu92AwGMtZaRDsOJ406Wo2ue3MFKsYLuZhSe2cUs0sx2HmSr0VdvsAUitY=@vger.kernel.org
X-Gm-Message-State: AFuF++kevn4oEBrCzK1445AbgFz156m3Ce0mdQlLILQg2yoRbY/oiq8m
	NeRDhXTFDZOlQp0cxPxk798ioaUUW9Jo9El4aaWkoI35ixjwtV+K/NrTW5cdwaBL1U1Gsz+Cj5k
	bmRG0QoWNVHohRRGl6BFfho6CgLzBJDI0eQnjdVYt
X-Gm-Gg: AYBFou0rnZZ7zps8LyfdPVgB6nmpB+tvLM+FYr0GneCd1Y6xq+eKDQiiwGBS7AlYCAs
	WjB73mQvZE3hr8GKR+SP3nJnpRo3NwmLBUuOheDhvUqHQjKn9ZnC6QWm1tvJKsBDqMOfCqKhoTM
	bYiVGo8kqywfvaOplpT6ticOTfa0rHDXIyxkGWAbwOAYtz9D0jYw4fUDATQQWasrrPCFmWw3ppH
	odd91yThyipp7ZViwlwTRnE3FpA6uSo9kLhO2HaoY1C59RrmQzjCnzZDj7vmz3b9+JkY/9e8JWI
	fYFfAQrVl0MSVYzD6xbSSfUdCekj2DmyzF6Z49YD/vQfS6jq8j5RXVPi05ap4b5Uf4cFkwBpHy3
	0m90E+j3NkEd11IZYRsTKML7/wFZrCTY0J4U0oIv8H1bZrsTISqFehsDDfEUX96nvc60SKq5FiM
	eO8vvF7pn5NGWLLjSSdBtybMVMXJmurO9h/w==
X-Received: by 2002:a05:7022:f50c:b0:13d:974:a2c6 with SMTP id
 a92af1059eb24-162041de438mr586698c88.7.1791341301323; Tue, 06 Oct 2026
 19:48:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com> <20261006192601.1875100-5-kuniyu@google.com>
 <CAMB2axM8+eW=jiDgV4EHgCxXpzZDdj3PVZc-8hZ9_3bMWMMDYg@mail.gmail.com>
In-Reply-To: <CAMB2axM8+eW=jiDgV4EHgCxXpzZDdj3PVZc-8hZ9_3bMWMMDYg@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 6 Oct 2026 19:48:09 -0700
X-Gm-Features: AclHuK-b4xtcvLSySTGi8doGUlPhLvVZt8LyR1rIaCDcdYBbjAPE6iawj02D-e0
Message-ID: <CAAVpQUD5eBzZJ3+1y+HbPhDf0q9juZc9g8v5J_ghHssEg2wXwg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 04/10] bpf: tcp: Guard fast-path
 bpf_tcp_ops_call() under per-socket flag.
To: Amery Hung <ameryhung@gmail.com>
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

On Tue, Oct 6, 2026 at 4:25=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> > +++ b/net/ipv4/tcp_input.c
> > @@ -210,6 +210,11 @@ static void bpf_skops_established(struct sock *sk,=
 int bpf_op,
> >
> >  static void bpf_tcp_ops_parse_hdr(struct sock *sk, struct sk_buff *skb=
)
> >  {
> > +       const struct tcp_sock *tp;
> > +
> > +       if (!cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS))
> > +               return;
> > +
> >         switch (sk->sk_state) {
> >         case TCP_SYN_RECV:
> >         case TCP_SYN_SENT:
> > @@ -217,7 +222,12 @@ static void bpf_tcp_ops_parse_hdr(struct sock *sk,=
 struct sk_buff *skb)
> >                 return;
> >         }
> >
> > -       bpf_tcp_ops_call(parse_hdr, sk, skb);
> > +       tp =3D tcp_sk(sk);
> > +
> > +       if ((tp->rx_opt.saw_unknown &&
> > +            BPF_TCP_OPS_TEST_FLAG(tp, PARSE_HDR_OPT_UNKNOWN)) ||
> > +           BPF_TCP_OPS_TEST_FLAG(tp, PARSE_HDR_OPT_ALL))
>
> nit:        ^ missing a space

this indentation is correct.

>
> > +               __bpf_tcp_ops_call(parse_hdr, sk, skb);
> >  }
> >
> >  static __cold void tcp_gro_dev_warn(const struct sock *sk, const struc=
t sk_buff *skb,
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index 3ac465513bf5..8770f3084efe 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -581,8 +581,8 @@ static void bpf_skops_write_hdr_opt(struct sock *sk=
, struct sk_buff *skb,
> >          * writer's bytes). The writer finds the append point by scanni=
ng from
> >          * first_opt_off + nr_written to the first NOP.
> >          */
> > -       bpf_tcp_ops_call(write_hdr_opt, sk, skb, req, syn_skb, synack_t=
ype,
> > -                        first_opt_off + nr_written);
> > +       bpf_tcp_ops_call_flag(write_hdr_opt, WRITE_HDR_OPT, sk, skb, re=
q,
> > +                             syn_skb, synack_type, first_opt_off + nr_=
written);
> >  }
> >  #else
> >  static u32 bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
> > @@ -613,11 +613,13 @@ static u32 bpf_tcp_ops_hdr_opt_len(struct sock *s=
k, struct sk_buff *skb,
> >  {
> >         unsigned int remaining_out =3D remaining, reserved;
> >
> > -       if (!remaining)
> > -               return 0;
> > +       if (!cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS) ||
> > +           !BPF_TCP_OPS_TEST_FLAG(tcp_sk(sk), WRITE_HDR_OPT)||
>
> nit: missing a space before ||

oops, due to last minute edit :/

>
> > +           !remaining)
> > +               return remaining;
> >
> >         /* bpf_tcp_ops_reserve_hdr_opt() reserves space via remaining_o=
ut */
> > -       bpf_tcp_ops_call(hdr_opt_len, sk, skb, req, syn_skb, synack_typ=
e, &remaining_out);
> > +       __bpf_tcp_ops_call(hdr_opt_len, sk, skb, req, syn_skb, synack_t=
ype, &remaining_out);
> >
> >         reserved =3D remaining - remaining_out;
> >         if (!reserved)
> > @@ -1193,8 +1195,9 @@ static unsigned int tcp_established_options(struc=
t sock *sk, struct sk_buff *skb
> >                                         struct tcp_key *key)
> >  {
> >         struct tcp_sock *tp =3D tcp_sk(sk);
> > -       unsigned int size =3D 0;
> >         unsigned int eff_sacks;
> > +       unsigned int remaining;
> > +       unsigned int size =3D 0;
> >
> >         opts->options =3D 0;
> >         opts->bpf_opt_len =3D 0;
> > @@ -1224,10 +1227,10 @@ static unsigned int tcp_established_options(str=
uct sock *sk, struct sk_buff *skb
> >          * left.
> >          */
> >         if (sk_is_mptcp(sk)) {
> > -               unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
> >                 bool has_ts =3D opts->options & OPTION_TS;
> >                 int opt_size;
> >
> > +               remaining =3D MAX_TCP_OPTION_SPACE - size;
> >                 opts->mptcp.drop_ts =3D 0;
> >
> >                 opt_size =3D mptcp_established_options(sk, skb, remaini=
ng, has_ts,
> > @@ -1244,7 +1247,8 @@ static unsigned int tcp_established_options(struc=
t sock *sk, struct sk_buff *skb
> >
> >         eff_sacks =3D tp->rx_opt.num_sacks + tp->rx_opt.dsack;
> >         if (unlikely(eff_sacks)) {
> > -               const unsigned int remaining =3D MAX_TCP_OPTION_SPACE -=
 size;
> > +               remaining =3D MAX_TCP_OPTION_SPACE - size;
> > +
> >                 if (likely(remaining >=3D TCPOLEN_SACK_BASE_ALIGNED +
> >                                         TCPOLEN_SACK_PERBLOCK)) {
> >                         opts->num_sack_blocks =3D
> > @@ -1277,22 +1281,18 @@ static unsigned int tcp_established_options(str=
uct sock *sk, struct sk_buff *skb
> >
> >         if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
> >                                             BPF_SOCK_OPS_WRITE_HDR_OPT_=
CB_FLAG))) {
> > -               unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
> > -
> > +               remaining =3D MAX_TCP_OPTION_SPACE - size;
> >                 remaining =3D bpf_skops_hdr_opt_len(sk, skb, NULL, NULL=
, 0, opts,
> >                                                   remaining);
> >
> >                 size =3D MAX_TCP_OPTION_SPACE - remaining;
> >         }
> >
> > -       if (cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS)) {
> > -               unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
> > -
> > -               remaining =3D bpf_tcp_ops_hdr_opt_len(sk, skb, NULL, NU=
LL, 0, opts,
> > -                                                   remaining);
> > +       remaining =3D MAX_TCP_OPTION_SPACE - size;
> > +       remaining =3D bpf_tcp_ops_hdr_opt_len(sk, skb, NULL, NULL, 0, o=
pts,
> > +                                           remaining);
> >
> > -               size =3D MAX_TCP_OPTION_SPACE - remaining;
> > -       }
> > +       size =3D MAX_TCP_OPTION_SPACE - remaining;
>
> This static-key check is not redundant unless
> bpf_tcp_ops_hdr_opt_len() is inlined. In my build,
> tcp_established_options() unconditionally calls the out-of-line
> helper, so sockets pay the call/prologue cost even when no bpf_tcp_ops
> is attached.

Interesting, I guess you don't use FDO ?

On my FDO build, even tcp_established_options() is inlined
to __tcp_transmit_skb() and both bpf_tcp_ops_hdr_opt_len()
and bpf_tcp_ops_hdr_opt_len() are NOPs as expected.

    ffffffff8224a511: 41 bc 28 00 00 00     movl    $0x28, %r12d
   # remaining =3D MAX_TCP_OPTION_SPACE (40)
    ffffffff8224a517: 45 29 ec              subl    %r13d, %r12d
   # remaining -=3D size
    ffffffff8224a51a: 0f 1f 44 00 00        nopl    (%rax,%rax)
   # bpf_skops_hdr_opt_len()
    ffffffff8224a51f: 44 89 64 24 78        movl    %r12d, 0x78(%rsp)
   # remaining_out =3D remaining
    ffffffff8224a524: 0f 1f 44 00 00        nopl    (%rax,%rax)
   # bpf_tcp_ops_hdr_opt_len()

I will add a static inline function and move both
cgroup_bpf_enabled() there and reuse it in 3 places.
(same for bpf_tcp_ops_parse_hdr())

Then, the unnecessary movl will also disappear.
