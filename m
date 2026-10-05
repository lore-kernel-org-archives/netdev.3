Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E103793BA
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 23:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791243109; cv=pass; b=BKvsOkXEz8kX6+ktP49KvYmx2atUGtesHQZSXo2HUscfcxMscT6xm5hNIX4PDshR2TgJZE2Kl1GkU+Run+dNMVqhfS1i++acJhLE40j4+SCU0cXEKIJt1b+d/vcTgJKYg44LphW8zStRntRS2Iv1CIz1WRl7UQSUvreu/lKOQBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791243109; c=relaxed/simple;
	bh=EPt9LuZ9qVQrMM09Nsd4ywaNTJZQ/eUK4nucMvxxi10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cIQ75AurocpfehZN9coLeTV/SVEK/CPhNQj5c+vVXia0hrLnWGKlLvVd1NX4cmQQJ6Ir0sDGL51V4MymJcjNDcz083TzO/AQWURGSaHivsIO+OUd2IRxCxs0lngzs/sBZGXSJenQgYf3K5PkvLssEIhEI5En8tNtIDwDhVrMf5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QKnuc27W; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QKnuc27W"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6aa5d092211so3719724a12.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 16:31:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791243106; cv=none;
        d=google.com; s=arc-20260327;
        b=SxdV8U9k6Ph2SpXOakohGlnKrnccuNdqKXygfOlPIT0ss/KzA1ke8Ss5zdTvaEEpp1
         PLYTTgJjl6bDfl8HC9mzuIG+dOaSRBkUnrI7iKMQXHawbrM1qdvSpg1VZXEIe6dGQMGQ
         CPRcnGOJTHx3fMP0TF7hpbz2gVRBgkwGRw4cmoLhv+r35uQoiE35UDoVqH7Mof8A/gOM
         OwbzHos17DIV7fyaEVNir0E5kU+lmG7vU3JxUX4PWJn5TpC4F6ZVveiPZZsfO5m5d5CW
         O0sDnCUoSAotXcQH139+PIGc3d1wySpcLOgY/n1Sf9c2w3LJsqPPUomOXRdbW74po5bm
         W81g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6+7GZCkLAfheU9S6/IuOIdPZQfSTJkrUG2B1eguZOAM=;
        fh=DCrdPsaiBMhHKYUa/RVHPenx7CnBmeft+tkH2m5RJWo=;
        b=GROClW1MdCLXeJRZ8qURa5cr4lgBKGZyEAmhhDshaUq7w+JiK/0rQg+sf9y5y6ByUH
         FNyYH0pUOngAcpHEuoZuk2+8xVBJTr+YlhpDkaUKHpxzPUacRyyoenbiAjL7owLdt6n1
         z9ARyvfnchdtuPAlyozNS5wLecb+0PY80F0+KNUVm/ATPEFRO4GF9mtYW4KQRK4CRfnI
         pj2g8nvNQZBIp6p+jEILGphT1inxVJlIF27QoDzQAE6ggLVyC0dD+bmZUge0EFIKDhEg
         RK8YMGe+mWbCqjlHBaJxk1I32tpy4PBnj/sPV8dFT7S/xaxJpwAmed6WDAtzCRa9fysl
         f98g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791243106; x=1791847906; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6+7GZCkLAfheU9S6/IuOIdPZQfSTJkrUG2B1eguZOAM=;
        b=QKnuc27WA9MN6VbsG3Rw4T/5FpFZVibTXBqi/h5vM1hXkeKJ9TGlTZARa+w7vVUYxQ
         e62Nh9u8l6agT1LCgtRVrK6L2tfOdBDdM1FepDiFrFhyM0akTSpwTtHKAhZyssZjKsYk
         wL69tzw5uMzlIKXqu+qJhH1FRds60PhkbcTsFbXeYEQjCT8etFVmqZl5ejIn9t2Xu4rJ
         MtBtB87E5zr3Ig1sHPMCiNOVQbWQXBox+RVT9CeE8nRC0Y+g2JUX1Bs9dAC2Cjc8gU7t
         ntrPT6VpBcjBY6OK8vTrObo6UC7lv9MU8/sMr0KdecgT3/AycRiCqCav23BSafqx0I8s
         UFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791243106; x=1791847906;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6+7GZCkLAfheU9S6/IuOIdPZQfSTJkrUG2B1eguZOAM=;
        b=nRk2gnxTFUbSXAxVeMlAJJDv08fiYkhh3z5tdrk6uJEUUIroIitDGXM2nXSXD+RK69
         Ox591Cljg15eLU0ZVO3tz2s7gWvhNAD9sLOUkstPqRxP/M3WjYY+0IuFXmVakhBt6l9j
         2GM63pPZy3zr7tx82sYiYVvG0VAUHXC7m3nE4pHw6+pBnym25Ijf/VEv2n/8Pj/BU0Yw
         xcy65i6A93G7Rya0e58BNcPeo0e4GJJthRmisO4V4sRqp/d1LeJbgwWrFWG5PmNVq1Ba
         IzyYosq6SHv7ELAwPHosELJGoDTA5OP4dFog6tE8D+LCDZZIjlS6zisvtLtd9SfrMsHm
         XK9w==
X-Forwarded-Encrypted: i=1; AKwUvBw7PqhaCBelKKsYAf1ozzZTmfHNbrisZRy3isTXoMHZXWHJlHVFc2KQ619ILjylaKyYxwTFwy4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJ280zgjxfXc2svRYRn/czfJplYHWmxeXH3mTFYwoliA8wSw90
	Ko+gJTDgZDmmvONFY/NUMay+7ka35S5dciIIwDpUVvyL19ZiiT6gYl6i2dCYLNHwk+KsgTgkWPh
	g/ZjK64ENX9JQyqmNrjYzcIPLol19Dk2j/gHq9Xhz
X-Gm-Gg: AYBFou1drbw9GGSnb5AUo4AGorVpnbAQ0NFgEM2bC+uSDY9+CGdNPvOEEQeuCYa37Cu
	sIHUHjRKBklsiQhr8u9t82FoEBNPsuQholRLEwfL3agF1WWsJAoiCyzHsQBlnwMghi2HuPrNVGT
	ZblY/fNM4Oh5paLo58F0LfGFf0aaNnSetwLOThc5k7SlZ3SvfjlVXdv5YYZRBM8XNNRuh3wz9vo
	g85Qv7M2CiZfWPCe3CC9OtpMzcYzhA7gikirV6vXQqxgNqdFQrgZoARWc2HCUe+5eN9cnqAkTeQ
	DzS+IX3W9OemfB0rmsczPnzkr/Jinhh0NeHVKg+AboT8syv9Nsaf5k7RJLAAZ+1T2Ub0oEUTsR7
	5acEFEQIQfe2i6goI8tJJelIXD5HUaAOSOotoSESPQAFbDpud8d5ujjNONq5h7+nV1J5xN52C3v
	T2ZCdMSXpYeRW0x60lBYtVxg==
X-Received: by 2002:a05:6402:13ca:b0:6ab:1e8:8b7e with SMTP id
 4fb4d7f45d1cf-6afada11773mr8988048a12.32.1791243105287; Mon, 05 Oct 2026
 16:31:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005154533.4147685-1-kuniyu@google.com> <20261005154533.4147685-3-kuniyu@google.com>
 <asPsATnTIr0Fxa_b@devvm7509.cco0.facebook.com> <CAAVpQUBikn+8Zb_01T5aebhRyhKpHpWFbWHwk-vV=N9S0LCQXA@mail.gmail.com>
 <asQoUeoXFa2-ofPu@devvm7509.cco0.facebook.com>
In-Reply-To: <asQoUeoXFa2-ofPu@devvm7509.cco0.facebook.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 5 Oct 2026 16:31:32 -0700
X-Gm-Features: AclHuK-8Su9DEAvI3XKt0bmz1f1g6Ytm354zn1oY1x6GDFiYp25APciWy7eN5Qg
Message-ID: <CAAVpQUBupGDrjFD=AvCN_iz6TGkGt3kR7mWvVgqDL-Uir3Jg2w@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/9] bpf: tcp: Add a new per-socket flag and
 kfunc for bpf_tcp_ops.
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 3:47=E2=80=AFPM Stanislav Fomichev <sdf.kernel@gmail=
.com> wrote:
>
> On 10/05, Kuniyuki Iwashima wrote:
> > On Mon, Oct 5, 2026 at 11:30=E2=80=AFAM Stanislav Fomichev <sdf.kernel@=
gmail.com> wrote:
> > >
> > > On 10/05, Kuniyuki Iwashima wrote:
> > > > The legacy SOCK_OPS guards some hooks with a per-socket flag,
> > > > tp->bpf_sock_ops_cb_flags.
> > > >
> > > > In contrast, bpf_tcp_ops was initially designed without per-socket
> > > > flags so that users can simply define only the callbacks they need.
> > > >
> > > > However, it turned out that even attaching a bpf_tcp_ops with a NUL=
L
> > > > callback incurs measurable overhead in the fast path. [0]
> > > >
> > > > We could reuse tp->bpf_sock_ops_cb_flags, but it is u8 and has only
> > > > 1 bit left for a new opt-in callback, while not all of the 7 existi=
ng
> > > > opt-in hooks are in the fast path and really need a flag guard.
> > > >
> > > > Moreover, tp->bpf_sock_ops_cb_flags has two bpf helper functions to
> > > > update it, both of which require sock_owned_by_me(sk):
> > > >
> > > >   * bpf_sock_ops_cb_flags_set()
> > > >   * bpf_setsockopt(TCP_BPF_SOCK_OPS_CB_FLAGS)
> > >
> > > Can we return -EINVAL from these when used with sock_ops?
> >
> > bpf_sock_ops_cb_flags_set() is not allowed for bpf_tcp_ops,
> > so we could add a check in bpf_setsockopt() for bpf_tcp_ops
> > to disallow TCP_BPF_SOCK_OPS_CB_FLAGS.
> >
> > But not all of bpf_tcp_ops hooks are opt-in, so we cannot prevent
> > attaching bpf_tcp_ops to SOCK_OPS-enabled sockets.
> >
> >
> > > If we keep one flag we can presumably put both tcp_call_bpf_Xarg and
> > > bpf_tcp_ops_call under the same if conditional?
>
> [..]
>
> > I assuemd we will use the new flag only for bpf_tcp_ops and will no
> > longer add a new bit to the sock_ops flag and fainlly we can deprecate
> > it under a Kconfig like CONFIG_BPF_LEGACY_SOCK_OPS.
>
> Don't think CONFIG_LEGACY is happening :-D I might be overthinking it..

Ah, sorry, I realized I misread the code and thought bpf_tcp_ops shared the
same static key with the legacy one, but they actually use separate keys.

> Realistically, maybe something like bubbling up cgroup_bpf_enabled(sock_o=
ps)
> is an option as well?

So yes, this should be enough,


> So these (old) runtime checks are happening only when
> we have sock_ops attached (and/or separate mechanism for struct_ops?).

and this is already done by the separate static keys, except that some
sock_ops call sites check the flags before the static key.


> But if you don't see anything wrong in your benchmark, let's not overcomp=
licate.

I thought SOCK_OPS also contributed to the regression by enabling it via
the same static key, but the delta was purely from bpf_tcp_ops. So
I think the current form + Amery's suggestion (moving the flag check
after the static key) would be fine.  While at it, I can apply the same cha=
nge
to SOCK_OPS too.
