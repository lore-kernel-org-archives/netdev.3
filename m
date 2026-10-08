Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE593A5431
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 02:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791425415; cv=pass; b=qgwoJe/u3OZ8joaVzOg0qiGoHbcQHQCRsLnguIaxhOHPw8/JdhWs1tai332jrHhxzMYEjhRWAtj/wGUnF0saA96HeyVXY4TQASi+x2i7lx96OJu3mUbt82x3evnPcw7xweQB0qo+zehzGHRNrauNe2RvDkGMQ3dLZg1UxnXbyPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791425415; c=relaxed/simple;
	bh=ZOVaJwmVYAzFkFw1CPFhggqT+fTktUCLy+BYC7fgQX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHuEM5bigXKsVNjirETSCsJvPK59vm3c2fbHEueOyOp31zBxliqfjn/MxZ9w8GBA5O+tRKfw4truqCZm3E/nGcbgjrjXgd6U6vZu502pPsNkxBCqxyXgXj/yOYK4knLYtChwkiBDI20xTfUrgxHEVVEbRo0dHOy+PMvtC7sAXOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dpirUKNr; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dpirUKNr"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-15dd124bbe7so2786070c88.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 19:10:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791425413; cv=none;
        d=google.com; s=arc-20260327;
        b=Gslbnuh8AFsqjVTH4q048TRR8NYH1aONklmJN37AVuhFD54asjUpX+ZVRZWQ6oyQpC
         m6PcgUbtOi2sHkZGtK9lKMjQv0hSM6dHWvuuQPz2YmR6xYO+v7xOx1iMPHneDWn5Axf/
         lkl/MnRKSyPKypCu4FvYO4dmlwDZ9Kx1CHACNQFbbuS3C9TGPR2W76i4jEu86X9kZE+H
         TzbxZkkNZZYb5E+FJhCI9+z2IBftVpWns7e0NggYXcUSzJwuxB18/e/zYhZ+Q3v9t3iG
         MsZAK2jT7hJHK/HbeUd+D5mX2HatTNu3VgJr3w6j/yuymmpF5Lq7f0ts053bztJ77kmw
         Xpmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DFZP461PmZ8EPveXILwgmKH/qLivHDnih8QZEqAhY6Y=;
        fh=qPfCw0LN3YFYtm/cABTJG1thnGSN6BjJLh+mCuvf5D4=;
        b=VFWWVr0EYMUeCiq5h4YNhjWDUAtpUOxnVMYB0iqwpvQxLl72UZKOqp3CczEQXwUIV+
         b6kXA8fzR4nhGG7hj6wVAGoOSrPYdk/HylwSoKg7IWGJI67jHdtQfpHY9oAU+HupYPCM
         i+xu9szDzkzz8NxOKDa+wJG3HTX99TW1w2LOchqlL1S29H8zWiRUaZrlfVeYMAjPs4EO
         oo+cn0oHm/HOrvKpd5owVz8aS8Y3ECnoob2XAuShos1AVPuPyb5IJoopsGUVfymlnGKM
         92XIenDcdWv7aAHz929mYrwLb9O9R875D7vAXl/9JteYuYl+ldRNJ7IAKqpxNr9Ztcj+
         ROeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791425413; x=1792030213; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DFZP461PmZ8EPveXILwgmKH/qLivHDnih8QZEqAhY6Y=;
        b=dpirUKNrDGrXQMLLlBjlCBHH9w2eN6FVWnbCACPQpp+4CB42/hI1lquJ/DCnzqecNu
         va6/U0aF3o5W+J5UVnmbuZrhAj+vKleNE8JFjBLw+/jwW+h0Dm82c9p5dAFTeT+k+gsw
         kqQdO0Zd2SCtLj48LfB8BatXapFL0VGL1vDUxg3AudocJWqOTSuYu40em5sp/riCYSQX
         YxbTkcZ0oOkh8iOKkv2HTNIynn3BMZU6x0V39K5k5B02WZNbGaQTKd2M3fzB2ocugYn5
         zLG6CfDFqbAQqsAPN2g3pZwFJ/52ZeW5jn5T7t7bwpBAyjHuvZ5W4N/hr5GP4ixeEiMf
         jzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791425413; x=1792030213;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DFZP461PmZ8EPveXILwgmKH/qLivHDnih8QZEqAhY6Y=;
        b=UdrF3iGTk7nEp0vR3jF6x4h4mTNEwktevtJn4SJKXSTkHYVWBxM7LKfJ5iojhGeLA8
         XtWjHs0lLcfX4J/E2RvPU+YYp3d58yuC54ksZ28Ag9a8CB1aizCb+YjD7Uh1RvsiQ/Vu
         uO6lRhXELGouLSIYwvIqLtmbrD7BP7Y+BsHMOR0gZ3X45lpytRDjRCNJV7uK5xhYXKfz
         HnJ1f+GLg82mB1cndLuTkoJQr77fvLEmKCaTXKswUehuKBD70yiC2Uhz6o4yvqHSuqpX
         i5BS1j5qQxoSvnmVvrr0zSMLRUZlsB9bET6b01b0uAMBcIjD0XbBd/dXSvrm4uJzEgI5
         vciA==
X-Forwarded-Encrypted: i=1; AKwUvBzz5aabv5t8sDKX6hw9ywna583kXFwgxEkVV5lBsAazmEuicv0zncys66XDDujCzF/ksbhXPyI=@vger.kernel.org
X-Gm-Message-State: AFuF++mKVGTlEiItqqJBo89QlHWqGQbCJr1bsZ0PMrhNnoJkBTnEO36d
	xVM+nc+b2Pbz2Xsstj3Y6EDkz4jUuW5A32SVsZVnVDuTxc1Jla3AQ6GxiCzjJAMjvgw/GAgXhfa
	Mmls90wlyqrsmGTITPxTPuPCJViF7bMPAww7p+kDr
X-Gm-Gg: AYBFou3BiRk4HBxhUZiI7giQge688YdhiHp/fDFWjkRVlzoyMyUeqJHeyu0dEAYnOto
	W4va4ns0oZGuoday6R1bs6QohVsZuXXwXaqvhDMIxLEqEz6Ii5h8hAAYpaSQpbfK7Z203fGyG7U
	YBRYKLOQR0A+5wsBBai9atH6IeZ4/ZnM3AsXfXBInaVj9H3YEgsdfg8EsFiCuXyehlfnJMv15wn
	742/LeNMv2xrCXZ1HozvU46xViRCffp2bUsyi5RvYbKetxOMfilWlzf+ZL039idGjBfOFaA5DsY
	1qq/Q1lkwIxqZaNg/YYi8HPIQna+A0EBaMrPkmm1wkpfFXkf5yAlAb4ilZVWV5EJ3bgWHi2aqdL
	wK1Avu8tlqBU9v/dl8RClJ3u4GVi75rw04BbYlxvs9BaWq47/+DVT0p/eJP4DYi4xKLNvDRx/MM
	9gde9h0ui2nzs2hJbt6+EPog/0
X-Received: by 2002:a05:7023:903:b0:164:475f:1a07 with SMTP id
 a92af1059eb24-164476e5caemr3086317c88.1.1791425411194; Wed, 07 Oct 2026
 19:10:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com> <20261006192601.1875100-5-kuniyu@google.com>
 <CAMB2axM8+eW=jiDgV4EHgCxXpzZDdj3PVZc-8hZ9_3bMWMMDYg@mail.gmail.com>
 <CAAVpQUD5eBzZJ3+1y+HbPhDf0q9juZc9g8v5J_ghHssEg2wXwg@mail.gmail.com> <CAMB2axPVrw-OGz_35yKw=QzHfcqRvtuhiLVs-_h5B1FUpN84mA@mail.gmail.com>
In-Reply-To: <CAMB2axPVrw-OGz_35yKw=QzHfcqRvtuhiLVs-_h5B1FUpN84mA@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 7 Oct 2026 19:10:00 -0700
X-Gm-Features: AclHuK-XZFetzrUoSNSyi7ByTn6WwEK8QHUZG2LiUx-VNosyEMhEXX5eGB7K85Q
Message-ID: <CAAVpQUCmMNUNnNfBMVNpv84T3+7mKM7qtbN2Xke=V4RgyUp9dA@mail.gmail.com>
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

On Wed, Oct 7, 2026 at 3:36=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> On Tue, Oct 6, 2026 at 7:48=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
> >
> > On Tue, Oct 6, 2026 at 4:25=E2=80=AFPM Amery Hung <ameryhung@gmail.com>=
 wrote:
> > >
> > > > +++ b/net/ipv4/tcp_input.c
> > > > @@ -210,6 +210,11 @@ static void bpf_skops_established(struct sock =
*sk, int bpf_op,
> > > >
> > > >  static void bpf_tcp_ops_parse_hdr(struct sock *sk, struct sk_buff =
*skb)
> > > >  {
> > > > +       const struct tcp_sock *tp;
> > > > +
> > > > +       if (!cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS))
> > > > +               return;
> > > > +
> > > >         switch (sk->sk_state) {
> > > >         case TCP_SYN_RECV:
> > > >         case TCP_SYN_SENT:
> > > > @@ -217,7 +222,12 @@ static void bpf_tcp_ops_parse_hdr(struct sock =
*sk, struct sk_buff *skb)
> > > >                 return;
> > > >         }
> > > >
> > > > -       bpf_tcp_ops_call(parse_hdr, sk, skb);
> > > > +       tp =3D tcp_sk(sk);
> > > > +
> > > > +       if ((tp->rx_opt.saw_unknown &&
> > > > +            BPF_TCP_OPS_TEST_FLAG(tp, PARSE_HDR_OPT_UNKNOWN)) ||
> > > > +           BPF_TCP_OPS_TEST_FLAG(tp, PARSE_HDR_OPT_ALL))
> > >
> > > nit:        ^ missing a space
> >
> > this indentation is correct.
>
> Sorry. False alarm.
>
> >
> > >
> > > > +               __bpf_tcp_ops_call(parse_hdr, sk, skb);
> > > >  }
> > > >
> > > >  static __cold void tcp_gro_dev_warn(const struct sock *sk, const s=
truct sk_buff *skb,
> > > > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > > > index 3ac465513bf5..8770f3084efe 100644
> > > > --- a/net/ipv4/tcp_output.c
> > > > +++ b/net/ipv4/tcp_output.c
> > > > @@ -581,8 +581,8 @@ static void bpf_skops_write_hdr_opt(struct sock=
 *sk, struct sk_buff *skb,
> > > >          * writer's bytes). The writer finds the append point by sc=
anning from
> > > >          * first_opt_off + nr_written to the first NOP.
> > > >          */
> > > > -       bpf_tcp_ops_call(write_hdr_opt, sk, skb, req, syn_skb, syna=
ck_type,
> > > > -                        first_opt_off + nr_written);
> > > > +       bpf_tcp_ops_call_flag(write_hdr_opt, WRITE_HDR_OPT, sk, skb=
, req,
> > > > +                             syn_skb, synack_type, first_opt_off +=
 nr_written);
> > > >  }
> > > >  #else
> > > >  static u32 bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *=
skb,
> > > > @@ -613,11 +613,13 @@ static u32 bpf_tcp_ops_hdr_opt_len(struct soc=
k *sk, struct sk_buff *skb,
> > > >  {
> > > >         unsigned int remaining_out =3D remaining, reserved;
> > > >
> > > > -       if (!remaining)
> > > > -               return 0;
> > > > +       if (!cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS) ||
> > > > +           !BPF_TCP_OPS_TEST_FLAG(tcp_sk(sk), WRITE_HDR_OPT)||
> > >
> > > nit: missing a space before ||
> >
> > oops, due to last minute edit :/
> >
> > >
> > > > +           !remaining)
> > > > +               return remaining;
> > > >
> > > >         /* bpf_tcp_ops_reserve_hdr_opt() reserves space via remaini=
ng_out */
> > > > -       bpf_tcp_ops_call(hdr_opt_len, sk, skb, req, syn_skb, synack=
_type, &remaining_out);
> > > > +       __bpf_tcp_ops_call(hdr_opt_len, sk, skb, req, syn_skb, syna=
ck_type, &remaining_out);
> > > >
> > > >         reserved =3D remaining - remaining_out;
> > > >         if (!reserved)
> > > > @@ -1193,8 +1195,9 @@ static unsigned int tcp_established_options(s=
truct sock *sk, struct sk_buff *skb
> > > >                                         struct tcp_key *key)
> > > >  {
> > > >         struct tcp_sock *tp =3D tcp_sk(sk);
> > > > -       unsigned int size =3D 0;
> > > >         unsigned int eff_sacks;
> > > > +       unsigned int remaining;
> > > > +       unsigned int size =3D 0;
> > > >
> > > >         opts->options =3D 0;
> > > >         opts->bpf_opt_len =3D 0;
> > > > @@ -1224,10 +1227,10 @@ static unsigned int tcp_established_options=
(struct sock *sk, struct sk_buff *skb
> > > >          * left.
> > > >          */
> > > >         if (sk_is_mptcp(sk)) {
> > > > -               unsigned int remaining =3D MAX_TCP_OPTION_SPACE - s=
ize;
> > > >                 bool has_ts =3D opts->options & OPTION_TS;
> > > >                 int opt_size;
> > > >
> > > > +               remaining =3D MAX_TCP_OPTION_SPACE - size;
> > > >                 opts->mptcp.drop_ts =3D 0;
> > > >
> > > >                 opt_size =3D mptcp_established_options(sk, skb, rem=
aining, has_ts,
> > > > @@ -1244,7 +1247,8 @@ static unsigned int tcp_established_options(s=
truct sock *sk, struct sk_buff *skb
> > > >
> > > >         eff_sacks =3D tp->rx_opt.num_sacks + tp->rx_opt.dsack;
> > > >         if (unlikely(eff_sacks)) {
> > > > -               const unsigned int remaining =3D MAX_TCP_OPTION_SPA=
CE - size;
> > > > +               remaining =3D MAX_TCP_OPTION_SPACE - size;
> > > > +
> > > >                 if (likely(remaining >=3D TCPOLEN_SACK_BASE_ALIGNED=
 +
> > > >                                         TCPOLEN_SACK_PERBLOCK)) {
> > > >                         opts->num_sack_blocks =3D
> > > > @@ -1277,22 +1281,18 @@ static unsigned int tcp_established_options=
(struct sock *sk, struct sk_buff *skb
> > > >
> > > >         if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
> > > >                                             BPF_SOCK_OPS_WRITE_HDR_=
OPT_CB_FLAG))) {
> > > > -               unsigned int remaining =3D MAX_TCP_OPTION_SPACE - s=
ize;
> > > > -
> > > > +               remaining =3D MAX_TCP_OPTION_SPACE - size;
> > > >                 remaining =3D bpf_skops_hdr_opt_len(sk, skb, NULL, =
NULL, 0, opts,
> > > >                                                   remaining);
> > > >
> > > >                 size =3D MAX_TCP_OPTION_SPACE - remaining;
> > > >         }
> > > >
> > > > -       if (cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS)) {
> > > > -               unsigned int remaining =3D MAX_TCP_OPTION_SPACE - s=
ize;
> > > > -
> > > > -               remaining =3D bpf_tcp_ops_hdr_opt_len(sk, skb, NULL=
, NULL, 0, opts,
> > > > -                                                   remaining);
> > > > +       remaining =3D MAX_TCP_OPTION_SPACE - size;
> > > > +       remaining =3D bpf_tcp_ops_hdr_opt_len(sk, skb, NULL, NULL, =
0, opts,
> > > > +                                           remaining);
> > > >
> > > > -               size =3D MAX_TCP_OPTION_SPACE - remaining;
> > > > -       }
> > > > +       size =3D MAX_TCP_OPTION_SPACE - remaining;
> > >
> > > This static-key check is not redundant unless
> > > bpf_tcp_ops_hdr_opt_len() is inlined. In my build,
> > > tcp_established_options() unconditionally calls the out-of-line
> > > helper, so sockets pay the call/prologue cost even when no bpf_tcp_op=
s
> > > is attached.
> >
> > Interesting, I guess you don't use FDO ?
>
> Thanks for explaining. Yes. I did not use FDO for my local build.

I updated patch 4&5 and now I don't see callq for
bpf_tcp_ops_hdr_opt_len() even without FDO.

I still see callq for bpf_skops_write_hdr_opt() but it can be
follow-up if needed.

I'll post v5 shortly.

Thanks !

>
> >
> > On my FDO build, even tcp_established_options() is inlined
> > to __tcp_transmit_skb() and both bpf_tcp_ops_hdr_opt_len()
> > and bpf_tcp_ops_hdr_opt_len() are NOPs as expected.
> >
> >     ffffffff8224a511: 41 bc 28 00 00 00     movl    $0x28, %r12d
> >    # remaining =3D MAX_TCP_OPTION_SPACE (40)
> >     ffffffff8224a517: 45 29 ec              subl    %r13d, %r12d
> >    # remaining -=3D size
> >     ffffffff8224a51a: 0f 1f 44 00 00        nopl    (%rax,%rax)
> >    # bpf_skops_hdr_opt_len()
> >     ffffffff8224a51f: 44 89 64 24 78        movl    %r12d, 0x78(%rsp)
> >    # remaining_out =3D remaining
> >     ffffffff8224a524: 0f 1f 44 00 00        nopl    (%rax,%rax)
> >    # bpf_tcp_ops_hdr_opt_len()
> >
> > I will add a static inline function and move both
> > cgroup_bpf_enabled() there and reuse it in 3 places.
> > (same for bpf_tcp_ops_parse_hdr())
> >
> > Then, the unnecessary movl will also disappear.
