Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC27411A07
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 04:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790223052; cv=pass; b=oCCnLXuP6+a4rVscQxKMe47xXBscslTkLbWbaZR4lUL3+CsdzM2SQMl+CHJ3GV/AvoUNTUf9xEAPIvDb/denVByW3ri4HBQ8SVNC65wTTGE4ar2H4Af7fhGNNHjHqXWMhVX0LWmhVGUN1GIM+iizhxO9FnTeMekoWaDJRFqZ+C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790223052; c=relaxed/simple;
	bh=OY16eW825/0zzI0jWgFlw8UIWOwP4TT9m8DqFhegVQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acbVI8m+viUWwwpqoRHTa2KsVb4LcEMqEWZL+nbpqQEOhiEWyGnzFsYuNAm9qnQArsIb/qG/DG4VgP2nxysjdOnPikWeDb7RZsv5q+LjzkBBYVubJxRBo6O/fMwpuPBy6EuIdOkqOL4+4kKF1ld2v4f5vZEB2tOIA9McCz13Wv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z811ider; arc=pass smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z811ider"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-1450541ab18so247274c88.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 21:10:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790223049; cv=none;
        d=google.com; s=arc-20260327;
        b=DPAUGXjgIFyccw40fxWVr8x4Y7Zyi9Ck06Rw43w2UgC22kTWxwMXZsbB471znwun2l
         1FRGDL/zq+Dd7aes9SdxXk62L06mwLr2/Bp7cMXvPVAF1ajn2iaBMjaQ97ZOHChIceUP
         OKpm4gr6tjG7nfbBucJ7f4pqlZ92b0IkR7jUj9AihxHBguiHpGqMY6ZjNeStuhjC5ySX
         nPvW52l1e+z/YfNpImSP+c1DZexJ2pRitm/T41XQ4z35pUBI52ixRBFxcJS2jEXpk8Sf
         guyr8F++QUKQduLRuPi2q9DX/8CFZw4E1sTFxycpdP7obUFaefoPN7JJbeRB3YSYq8fs
         8g0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GS5obY1p7B2nbQlfsPiLBUctJugKJ38DpZDAW2iqf7U=;
        fh=LUQX690fCrw5kA3DKhpeuRculYkTRXXGWAly2HROZXg=;
        b=mt0AYwcTBIUvti1tpeaLKBega85WKqvL47mhbBRC5Vwd8isBkS1x6p2JzofR8U8hOo
         36jvzKkR/TVQy25ydmSPwVdfCMFYrkP8XJW8xcwAFtfhw8EsLZTQKFkpbyrXnVmlfFLo
         gQ67SMXLNBWol247eVFRSKF0eHEU7QqnacL67uf7Fmqan8kz94dbYaRfdMNzmgK3ILP4
         94p4lrAUNGEBWjOPf3NKqdlauiAJuets012zJeb4toi4kEunmbuKxuNThXexhcE8BnJp
         tbtFNmxARRH5yRPrE6FBPr8vafWqhDLnaf5ThORCNTtJw63WAWQgUrFsiS7WlynXYEt8
         /93g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790223049; x=1790827849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GS5obY1p7B2nbQlfsPiLBUctJugKJ38DpZDAW2iqf7U=;
        b=Z811iderKhZQwyx5uVDJOn4e9BytOCI6kwJPWNF2tBdMIX/kjgwi3p82GhaxlHCHUx
         enf+HS42pSxG1YG18GAvgBR3L7xbHNQHgUbZTWQ7lpi5LDonwi+uY4HsV6VbPBh9Zy3F
         w+YTQGfcHB1j8qWqzKJjjhA4tSikQgVLLJOUPWNDqF/ygQMS9s6lZqdM2jeOCvosjh9l
         63wvkL2Jy+0Dct3+jtsWquGTJf+nIUbSxj0NSPXQqDZtP/tKP5GguRJkcKv5QD72+/u5
         n5/mq1nP25DtxcE8JXsab6Aq3ItLjtfVHiAmaL76qTYVKujWy0gbKN87dEJ97Flpq+OL
         heCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790223049; x=1790827849;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GS5obY1p7B2nbQlfsPiLBUctJugKJ38DpZDAW2iqf7U=;
        b=BpIVhBBsZTeujGza7991ImWcN97wilzis0zh+ZWMqCpkHaqCtEBUTX59djIf8WUzfU
         E32AkKLxZcqbr5iK83LJJ/b7A/MVMYnsXozxuh89nttCK+S0twIQpyFEJUUv13nzu60Y
         jeCuIQpCoxIX/l4KzvLtMEWoDZ54jgbydzn1oxKJukJa4O85V0Fyyu6FLZEs6Kw1id8k
         YnAewtf2jXDdjFNpntQ6EtR50W2H3oOWgg+qOudymt8irZtKCOKr1fi54Yfi4rDGy/jY
         ozf35kCaxANviO+7aYSTFOVGLqa2dMvidgfU3Hhu5NR2lRfbhfSDpV5mVCR1ASglkC0G
         FWMw==
X-Forwarded-Encrypted: i=1; AKwUvByqfvipZC0fcZ9pVBnyHkvCDsWQe118s5HJcfno5gLTAEyO13tFgHu1uZ61PqEn7iIpPLoP4HA=@vger.kernel.org
X-Gm-Message-State: AFuF++lE9+V/LeYwaQUtyCeAUmB0P2NnGP2ZJQPcn+gYxpsM3cJ2urQW
	w62xcE4k4mq8ToV6YzcbZzhgKHuI44TPz+RltRi3V9ZKaJVdwA6QOSoBKgFQ363YI6wkrVWawRR
	rPLNK9V5zG2tu7IEEbIhCd548U9LZrsp0EHqp6fvd
X-Gm-Gg: AYBFou1m72kpYBx9ktKB/pQVjNfILDfdDcZ6tOfh03FRWRk8SdMx9kFwEtbleD9PBvR
	cNqHWNG+wuarVaDgh9yRo9JB2aNN15ZbdwOysuFVntJ+dcVocc0li6OJnAkL8tlPPwkGtiI5Tgn
	2tK22vF+hD9fUJQiLLV+FytbIs0Llc97aVBBhKun6o6nZHj5WWOhW5UpDW0Z2MV5bV3icfPUZwZ
	UbkDVjRZ3a7pU9rY7QyL7THLXPtDgD7rzmyEKU9+pH6UnmvcVxsC30RICuvFwEaVQi/XaUxFm8N
	IK0r57E+Dl8Tzi8mgtxaQ6aHbbGUX5X3XrjdttHe3Cor5E/miSzo2FZ1uLk/uyKoOkbR7IRZKhZ
	6BHHsSNW/ytvJRYt/MoUZz+hWEafahXcEXA4ySP6IwozvynKRtxrUf1uvFpw0T5HLgJICg/jiih
	2aZ+4cfkdeV+h/pyS/WjEfvVc8
X-Received: by 2002:a05:701b:42c2:20b0:145:4d:5abc with SMTP id
 a92af1059eb24-14503f84ff3mr920212c88.10.1790223047852; Wed, 23 Sep 2026
 21:10:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923213719.224838-1-kuniyu@google.com> <20260923213719.224838-7-kuniyu@google.com>
 <DLN8MMAY53A6.31EWYOHJ1YWLV@etsalapatis.com>
In-Reply-To: <DLN8MMAY53A6.31EWYOHJ1YWLV@etsalapatis.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 23 Sep 2026 21:10:35 -0700
X-Gm-Features: AclHuK_rQysdfujvjch6jsLzKg2dWxuawnvJ_0QiW0wm-klcapEkEeN4nBG-uN0
Message-ID: <CAAVpQUAwHL6NJS-kA0aE_Fcn1wcp7qRjZoTaTqbmMbTED6RFFg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 6/8] bpf: mptcp: Don't support BPF_SOCK_OPS_RCVQ_CB_FLAG.
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 8:48=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> On Wed Sep 23, 2026 at 9:35 PM UTC, Kuniyuki Iwashima wrote:
> > The next patch exposes a new kfunc calling __tcp_set_rcvlowat()
> > to bpf_tcp_ops.
> >
> > MPTCP has its own sock->ops->set_rcvlowat() / mptcp_set_rcvlowat(),
> > so we should not allow calling __tcp_set_rcvlowat() on MPTCP
> > subflows.
> >
> > Let's disable BPF_SOCK_OPS_RCVQ_CB_FLAG for MPTCP for now.
> >
> > If needed in the future, bpf_tcp_ops_set_rcvlowat() could be
> > extended to properly support MPTCP.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  include/net/tcp.h      | 15 +++++++++++++++
> >  net/core/filter.c      | 10 ++++++----
> >  net/ipv4/bpf_tcp_ops.c |  5 ++++-
> >  3 files changed, 25 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 07426e8641b7..d3cf655da9ec 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -2932,6 +2932,16 @@ static inline int tcp_call_bpf_3arg(struct sock =
*sk, int op, u32 arg1, u32 arg2,
> >       return tcp_call_bpf(sk, op, 3, args);
> >  }
> >
> > +static inline int tcp_set_sock_ops_cb_flags(struct sock *sk, int val)
> > +{
> > +     if (sk_is_mptcp(sk) &&
> > +         (val & BPF_SOCK_OPS_RCVQ_CB_FLAG))
> > +             return -EOPNOTSUPP;
> > +
> > +     tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
> > +     return 0;
> > +}
> > +
> >  static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
> >  {
> >       tcp_sk(sk)->bpf_sock_ops_cb_flags =3D 0;
> > @@ -2954,6 +2964,11 @@ static inline int tcp_call_bpf_3arg(struct sock =
*sk, int op, u32 arg1, u32 arg2,
> >       return -EPERM;
> >  }
> >
> > +static inline int tcp_set_sock_ops_cb_flags(struct sock *sk, int val)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> > +
> >  static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
> >  {
> >  }
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 5feb99884682..f29c061bb066 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -5588,8 +5588,7 @@ static int bpf_sol_tcp_setsockopt(struct sock *sk=
, int optname,
> >       case TCP_BPF_SOCK_OPS_CB_FLAGS:
> >               if (val & ~(BPF_SOCK_OPS_ALL_CB_FLAGS))
> >                       return -EINVAL;
> > -             tp->bpf_sock_ops_cb_flags =3D val;
> > -             break;
> > +             return tcp_set_sock_ops_cb_flags(sk, val);
> >       default:
> >               return -EINVAL;
> >       }
> > @@ -6178,8 +6177,9 @@ static const struct bpf_func_proto bpf_sock_ops_g=
etsockopt_proto =3D {
> >  BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_sock_ops_kern *, bpf_=
sock,
> >          int, argval)
> >  {
> > -     struct sock *sk =3D bpf_sock->sk;
> >       int val =3D argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
> > +     struct sock *sk =3D bpf_sock->sk;
> > +     int err;
> >
> >       if (!is_locked_tcp_sock_ops(bpf_sock))
> >               return -EOPNOTSUPP;
> > @@ -6187,7 +6187,9 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_=
sock_ops_kern *, bpf_sock,
> >       if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk))
> >               return -EINVAL;
> >
> > -     tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
> > +     err =3D tcp_set_sock_ops_cb_flags(sk, val);
> > +     if (err)
> > +             return err;
>
> Afaict the tcp_set_sock_ops_cb_flags is inconsistent with the previous re=
turn values,

tcp_set_sock_ops_cb_flags() already returns error when
something goes wrong, and this is just a new validation.

The intention here is just to ensure, in the slow path, that no one
blindly uses such an unsupported combination and to avoid
unnecessary validation in kfunc called from the fast path.

Note that enabling BPF_SOCK_OPS_ALL_CB_FLAGS in the
program is clearly wrong, or it must accept that it could break
when a new (opt-in) hook is added.

So no one should stumble on the new error in practice.


> in that it returns an errno instead of the flags it couldn't set (it also=
 doesn't
> set the flags that we can set for MPTCP when BPF_SOCK_OPS_RCVQ_CB_FLAG is=
 set, which
> is the convention of its callers). Would changing the error path to
>
>         tp->bpf_sock_ops_cb_flags =3D val & BPF_SOCK_OPS_RCVQ_CB_FLAG;
>         return (val & (~(BPF_SOCK_OPS_ALL_CB_FLAGS ^ BPF_SOCK_OPS_RCVQ_CB=
_FLAG);
>
> work?

Regarding the consistency, this is rather inconsistent because
previously any flag in BPF_SOCK_OPS_RCVQ_CB_FLAG cannot
be returned.


>
>
> >
> >       return argval & (~BPF_SOCK_OPS_ALL_CB_FLAGS);
> >  }
> > diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> > index 4b48711d92a2..b0cade34cce6 100644
> > --- a/net/ipv4/bpf_tcp_ops.c
> > +++ b/net/ipv4/bpf_tcp_ops.c
> > @@ -223,8 +223,11 @@ const struct bpf_func_proto bpf_tcp_ops_get_retval=
_proto =3D {
> >  BPF_CALL_2(bpf_tcp_ops_cb_flags_set, struct sock *, sk, int, argval)
> >  {
> >       int val =3D argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
> > +     int err;
> >
> > -     tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
> > +     err =3D tcp_set_sock_ops_cb_flags(sk, val);
> > +     if (err)
> > +             return err;
> >
> >       return argval & ~BPF_SOCK_OPS_ALL_CB_FLAGS;
> >  }
>
