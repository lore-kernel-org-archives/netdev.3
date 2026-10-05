Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED933EDE57
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 21:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791235447; cv=pass; b=bNBFDC3nOsqUuimpSGCNBHJV4eUqofubxuqlJrk8A00JgTddO7f6+fVWncdONG24oqevHD5BCLyW4Jmb4Qjl9axgAiXGhwiEJ51bmKWXULdvJ8q6Szp2xNPzo7KYc1QObgbX09Z8HAtLPlFLb7tRdQ8kS+R/60YCkI94EUJc+Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791235447; c=relaxed/simple;
	bh=g2YhWs2wnEbVyHvXtNkclGjux0hLDRKsWdK5g2avxgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lWpKZcyj6rwcRZrNR02kGFE8BZz2rjv/YuBVbnn7Vgj/X+sD2iXbYnD2BmOmi4qgu+aEzyBoXKak0FXlOLXxf3mH9MB+nLE9lh/Sa6o34XXqICQfmUXThvweCdl27+2WyH64YecPblacrUE7CEZxpqyCaBIljwtWovRKQfDmOLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pnq9864v; arc=pass smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pnq9864v"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd04f7f2so2067720c88.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 14:24:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791235444; cv=none;
        d=google.com; s=arc-20260327;
        b=EGINu/hX22p7ZtF3UPkPcv6RrE+18Z3J+qdKfLKHOZDgC5KbON9VdVscORNqN55tV0
         IqMAscIksslJZBwT7NUnT80ig1q4lFnYErDGItB8OE42pvZfkRjKNbHZ+4y9IqlAa8Hq
         RplmKmSaANlrPhR3f6omI4T+LSUkUKD1edvOhiBXu3U+TSbSUgzvynI4sMKUoG6OzO/n
         Xg6PeeP/TRo0r2dtrz2+o6rM7/dPq1xN7tLlobOkvKeXpWyAICoGsK8ODxzOADJ4qlDT
         Q0igO7HpckpGzM2AkF6uggQGWyHjFluIyer2rx+5y2IRBpzJ8WfjH1Ogq5clPAzqN/VW
         mbkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q9Phq3E4EjHS1k5cgJ6CHsGFU2VgiKXbFac8f/T1nUY=;
        fh=w/kjnSvamuWl9pCCED9MgXuD7N/YkVX16JRo+QYXCg4=;
        b=OAw3Po3HpB81vGVTVusNCjKMeSam2lS8l+Q+I5G1rOEOx7GYL2r58bxumES9Oeqz00
         s3mp5Y750CJIhw2yuxHwC8xy+kIdJAS4Ts+vh5WmTTjVsrozinu+bbok2jhOZBV5ToSY
         bN+bnt0Fp0Nwt4sdu6M2TASnQUfWBAHRCqQ9RJjxNrESPIHnHcHsuR1S6QoEYMJxgrE4
         R1jsesM190DhBWF2DxDZSt8qF3biKbj7RBaiTWaflcID4ilM0Kazr1odOIfRCWx/QucH
         y2FZnWxpu+mVRgaGWzbloY35lVTg4V0LfqnsDl887ovCOp1sB9QVPH6tyHocl1YtQ8lh
         unFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791235444; x=1791840244; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q9Phq3E4EjHS1k5cgJ6CHsGFU2VgiKXbFac8f/T1nUY=;
        b=pnq9864vS4hPS6gHuSbgNckCnycyuP3hmaD2AcnPRzmIGZlZicsfne2qtErbdcUk1W
         itfki5+ZILC+wiMC0RViK3JCGOglYX3Ljs/37jFU1VVuW3fJ7g7a5UgCdoM4DwXdKMa6
         05EqQfndpi9uvW0igAQFvxQlm/hcQKm/GXJROhNT6Zcuk7f2qtiPO1Zds2Y6TFLrM8C9
         KNAVUMLVrN2eStZaLxBWR+mkR7gHTPW123lxy7tezTYFr8fIkEQDOjRgwHUO3Bpujnw/
         Gi/aaDRakIKqW9ZTyk1sxXxyHz3oB3/poGeLbyTzYln11Go75qLfXBGahXuAVXBNk1Cl
         BWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791235444; x=1791840244;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q9Phq3E4EjHS1k5cgJ6CHsGFU2VgiKXbFac8f/T1nUY=;
        b=rF8hqSY0AdTkZ5geINx4Vh1sloIe6LbgOYTlbBDIzrOPLasYyloe+wEhzLQavWvRwM
         p1D2kraOpZb6E4qsytA5TlLExjfqtidzzodmEzCnecVnHJuOewWpTkQEAQe4ztCwv7QS
         D3RDMWDASJd9ZLm2xsZV4vp2WhEOmorX1Eu016Ego1p9/OvrS+rY2HYxC+6I9mua3rUR
         84MjFhwonTxl+yquwTti/gpO4ogOjPQHgOLBAfddSxVXj32ssl9sw2xOQ/yI4IrdNMe8
         x+WxHftpvZhmnTZum6VWrJsNcB833BJQZuF52PKjY7wg0RVLiSe+2HS/qf85obnPJo+F
         XyRQ==
X-Forwarded-Encrypted: i=1; AKwUvBy0RcPowIxaudQ4U5FVFBKLuMFmaKTsB7z+CGvUTMzaWm/OSt2MK0MZxya9QOTP+Z3jkVrpHHc=@vger.kernel.org
X-Gm-Message-State: AFuF++kFgxdbrnke38uQJqe/2K4YQPsw88oMxkUnB3YPP272tIwi9bPv
	108gtGcyV3KgURrRPVsQzJt3KS8O/fmbBsSdRGunIheqsje+BT+42DhV9TNFSM7Pv9VyVDmxDaG
	hAf3P6JHWWeT6wNJI8PIfSr8WDJ7cJs+0oyGFT1tY
X-Gm-Gg: AYBFou0/D9oPRdUI0LOhisHDG6OzugN3YQ967Jvfa0lfq8j1vbSxjztX2Xm5oUBjvtt
	/SPOXYK8O0ALwJAj4byRAJ8aRmbuqPBi1UKikWa3g9kM0T3cSEa30WTgma2l3DOHsOUELJgThQk
	N1kBIp4hd3MOFHvtuVz+NpX1P2O6ClMlOIHCrWxypiwmDRFx5XL6/Y9gWRymzUwq/WBEE30lz+F
	8dWHo8qLZlgSQcR7KJyfiyhSU69F8cyS8ekcGUcNID/uL/fkU7tMMZNu27/2YMtRB+MvHQOA1Fh
	FQj6gLRd3nzcCh6XP2OaDmywHjTetC46vyGGgtmUkqSwUjwg/Q1U1eyWEed/TxnVKBmpfzuSH9q
	MHDDD6BYdXlNxubg+r8d36DeBPW1RpiXf7WpAr+fr4JeoeCDdUzpgNyvZjVBnHcAduJfCnrS9GJ
	2GgyOetsTGaEjWYwXpHnZdDQ==
X-Received: by 2002:a05:701b:2084:10b0:144:c128:4c4b with SMTP id
 a92af1059eb24-14f5cad9ffcmr14593177c88.36.1791235443545; Mon, 05 Oct 2026
 14:24:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005154533.4147685-1-kuniyu@google.com> <20261005154533.4147685-3-kuniyu@google.com>
 <CAMB2axNHoWyJYJ5QX9Gs0nmpwxs62t7y84729HRDq_+-cdjM9g@mail.gmail.com>
In-Reply-To: <CAMB2axNHoWyJYJ5QX9Gs0nmpwxs62t7y84729HRDq_+-cdjM9g@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 5 Oct 2026 14:23:50 -0700
X-Gm-Features: AclHuK_aNSdKZM2b1C_tGQWqG8oedihzbXV33WQgRccjRZW8ShVZvUXmWxlkRz0
Message-ID: <CAAVpQUDKTq5_1J0X=6PwBpWd1VO2A4=Kqhgj8j_n+DtdzS4xvw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/9] bpf: tcp: Add a new per-socket flag and
 kfunc for bpf_tcp_ops.
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

On Mon, Oct 5, 2026 at 2:19=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> On Mon, Oct 5, 2026 at 8:45=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
> >
> > The legacy SOCK_OPS guards some hooks with a per-socket flag,
> > tp->bpf_sock_ops_cb_flags.
> >
> > In contrast, bpf_tcp_ops was initially designed without per-socket
> > flags so that users can simply define only the callbacks they need.
> >
> > However, it turned out that even attaching a bpf_tcp_ops with a NULL
> > callback incurs measurable overhead in the fast path. [0]
> >
> > We could reuse tp->bpf_sock_ops_cb_flags, but it is u8 and has only
> > 1 bit left for a new opt-in callback, while not all of the 7 existing
> > opt-in hooks are in the fast path and really need a flag guard.
> >
> > Moreover, tp->bpf_sock_ops_cb_flags has two bpf helper functions to
> > update it, both of which require sock_owned_by_me(sk):
> >
> >   * bpf_sock_ops_cb_flags_set()
> >   * bpf_setsockopt(TCP_BPF_SOCK_OPS_CB_FLAGS)
> >
> > Both helpers only overwrite the field, which leads to reading and
> > modifying the flags in the BPF prog and then writing them back
> > via the helper.  This prevents future use from tc or cgroup_skb
> > hooks where bh_lock_sock() alone cannot prevent races with process
> > context.
> >
> > Let's add a new u32 field, tp->bpf_tcp_ops_flags, at the end of the
> > tcp_sock_read_txrx cacheline group, along with a new kfunc,
> > bpf_tcp_ops_set_flags().
> >
> > bpf_tcp_ops_set_flags() takes bitmasks of flags to enable and
> > disable and updates tp->bpf_tcp_ops_flags atomically via
> > try_cmpxchg() without relying on lock_sock().
> >
> > The kfunc is exposed to bpf_tcp_ops and BPF_PROG_TYPE_CGROUP_SOCKOPT.
> > The first argument is struct tcp_sock * so that bpf_tcp_sock() is
> > required for BPF_PROG_TYPE_CGROUP_SOCKOPT, but not for bpf_tcp_ops
> > where struct sock * is promoted to struct tcp_sock * automatically.
> >
> > The fast-path callbacks will be guarded by the new flags in a later
> > patch after updating the existing selftest to avoid breaking bisection.
> >
> > Link: https://lore.kernel.org/netdev/CAMB2axMwBuz3X4Uwn5uzZUqm91EbiMnbQ=
X832wUFOQ44fOwDnQ@mail.gmail.com/ #[0]
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  include/linux/tcp.h            |  7 +++++
> >  include/net/tcp.h              |  1 +
> >  include/uapi/linux/bpf.h       |  8 +++++
> >  net/ipv4/bpf_tcp_ops.c         | 56 +++++++++++++++++++++++++++++++++-
> >  net/ipv4/tcp.c                 |  3 ++
> >  tools/include/uapi/linux/bpf.h |  8 +++++
> >  6 files changed, 82 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> > index 6a8c77719322..24bb751cc65a 100644
> > --- a/include/linux/tcp.h
> > +++ b/include/linux/tcp.h
> > @@ -233,6 +233,13 @@ struct tcp_sock {
> >                 is_sack_reneg:1,    /* in recovery from loss with SACK =
reneg? */
> >                 is_cwnd_limited:1,/* forward progress limited by snd_cw=
nd? */
> >                 recvmsg_inq : 1;/* Indicate # of bytes in queue upon re=
cvmsg */
> > +#ifdef CONFIG_BPF
> > +       u32     bpf_tcp_ops_flags;
> > +#define BPF_TCP_OPS_TEST_FLAG(TP, ARG) \
> > +       (READ_ONCE((TP)->bpf_tcp_ops_flags) & BPF_TCP_OPS_FLAG_ ## ARG)
> > +#else
> > +#define BPF_TCP_OPS_TEST_FLAG(TP, ARG) (0)
> > +#endif
> >         __cacheline_group_end(tcp_sock_read_txrx);
> >
> >         /* RX read-mostly hotpath cache lines */
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index d61ee00052e3..f69091f5e01f 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -2934,6 +2934,7 @@ static inline int tcp_call_bpf_3arg(struct sock *=
sk, int op, u32 arg1, u32 arg2,
> >  static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
> >  {
> >         tcp_sk(sk)->bpf_sock_ops_cb_flags =3D 0;
> > +       WRITE_ONCE(tcp_sk(sk)->bpf_tcp_ops_flags, 0);
> >  }
> >
> >  #else
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 4687c3310996..6ff90b73dd38 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -7334,6 +7334,14 @@ enum {
> >                                          */
> >  };
> >
> > +enum {
> > +       BPF_TCP_OPS_FLAG_RTT                    =3D (1 << 0),
> > +       BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_ALL      =3D (1 << 1),
> > +       BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_UNKNOWN  =3D (1 << 2),
> > +       BPF_TCP_OPS_FLAG_WRITE_HDR_OPT          =3D (1 << 3),
> > +       BPF_TCP_OPS_FLAG_ALL                    =3D (1 << 4) - 1,
> > +};
> > +
>
> This series changes several existing bpf_tcp_ops callbacks from
> enabled-by-presence to disabled by default. Since this needs a respin,
> could you also document the opt-in semantics and update the comments
> for the affected members of bpf_tcp_ops to name their gating flags?
>
> It would also be useful to document that the mask is per-socket and
> shared by all effective bpf_tcp_ops programs.

Sure, will add doc for the enum and bpf_tcp_ops members.
