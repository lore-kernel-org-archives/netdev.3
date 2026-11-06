Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793952657;
	b=Clx0QsMTshFgOJBZm6nLpxOOEROt9BeK+v7/VIZfNUCX6dHSTi1lhEZyPPwkGVTx/FQ/
	 vdLlQvn1FbKdRklJP7rnbHBVG8J8O4/spQGHbdPDaZbT2xPvd4MqK8NHX7DVI18UMHJbA
	 bBxUm4QpwrgTy0SjS0QG9IHauPoqcmaPSy2ZSIvvuvORsteYcGDpt+x9XlaNVPnJ7RgOu
	 rmzVEKuYpyfSG1w7xD5poyaPGD/KE6l2oUj85VLRi1/nNdYsEst2ATX90qPu5XyryHrFj
	 1zNvsDKPtsUAN5nZ5ISB/t3Oj8E0aqrnQ1rzJfG5TeUY/HVaNwbGIonjTfuERe7M9jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793952657;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=S9xvJ1NaU4Zk/xPNNDyUuI5WsSyAExyNgvNFDuRo824=;
	b=O1kqS0YBwNimD9h4oC6plHIrl9tSCcFy/9dlLPxYeVmFssoYp6P/4XRwebwMlXO50pAb
	 GUl1C5+sq4tquvp+uVoHGfgLRV598VMuOMJXozSHPswRuYVhIf2EpFbq8bQpW7xKC6dV9
	 jSMVGt0+guETYkvtTe15vAy17+kolT+CoZAJwIJRs3IZ7exHQXUlyJZ2io/eAhmIwEbDK
	 9RQ5PoYrJ//63TTB4IphWOvzLsD2MbufYQ+LHqV7hQf6GS+M3qQ6++8Av3JoekvRke7ap
	 7krZIpMaQ7y94KLvxuMn8yroo3+cwDW/zqNg7DUGM77PaiyGrDzEcAvCLXKEw0eJhYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JsDAj3eR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03A6606A328
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 08:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JsDAj3eR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41EBF1F008A2
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 08:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793952656;
	bh=S9xvJ1NaU4Zk/xPNNDyUuI5WsSyAExyNgvNFDuRo824=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JsDAj3eRpYVeftt8/G/kKkhbqtHjQlogL301UIb8+aa6p0erq+yx5Xapul/cxzsPZ
	 Rtyo9AXSVS4eXqCOXVDN8Pm+Dw3mNpBYFeXovFb8/63HMKF9LLCVNf4hXzuc9ydN0k
	 F7o4IRJ2Og0tBZMBFnzvn+io1wRvZJ+id0MxLia7LSvimuhyHUoVPq9nM7LeGZ53r1
	 fnndZKwqjmfCQdMqYVUBHcledZ9NyDWFyCCBYeLTJP2/k7c2o0sKm+2cyt2lePVCRL
	 hZm607N2ssnrSjo7MEv6ww3MYY+ApUT93OZFaKSF1mdvdfahHULgPQZjcl0BTeeMKD
	 xrOm5Q1I+X64g==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-8451a619da7so270910a34.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 00:10:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxh3VaByl4HXXstpoSM00lDKY63m0mG/HAdD2nXJ6TvwP8k4y/M5VppNyQeKbqiozKSj1aoQfE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+z9j7UqcfSKFIeQ+ZX8rHrGyZw7sV2jdxRZiE9jlqpEGgj8sTg
	oJvQJemWzkh2W0ljzI2hMTVIVtJDRYmOQ+gjbblQsKopX3f/iCCfXj8/UkzHo/SqF2H7R/zy4TS
	OVCSokDUdl+6EKZARkwg6who+rnfvTcw=
X-Received: by 2002:a05:6830:310b:b0:829:10c4:2c11 with SMTP id
 46e09a7af769-85f1cb65e44mr2173404a34.0.1793952655401; Fri, 06 Nov 2026
 00:10:55 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105164830.1682714-1-edumazet@kernel.org> <af79b34f-a941-4d0d-adbf-fe30a09c20d7@linux.dev>
In-Reply-To: <af79b34f-a941-4d0d-adbf-fe30a09c20d7@linux.dev>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 6 Nov 2026 09:10:44 +0100
X-Gmail-Original-Message-ID: <CAL4WiiqxeZSZWSKkK6qcA=U1haTCoCakEKYatYf0i7mB-CdXTA@mail.gmail.com>
X-Gm-Features: AclHuK_dki4Pgn8VVhk8z1fjYLjsARhKpZyckE54dKfXi3IEUlCv_TH1XfBb3J0
Message-ID: <CAL4WiiqxeZSZWSKkK6qcA=U1haTCoCakEKYatYf0i7mB-CdXTA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: do not resurrect a former listener with SO_ATTACH_REUSEPORT_[CE]BPF
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Kyle Zeng <kylebot@openai.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 6 nov. 2026 =C3=A0 07:44, Jiayuan Chen <jiayuan.chen@linux.dev> a =
=C3=A9crit :
>
>
> On 11/6/26 12:48 AM, Eric Dumazet wrote:
> > After listen() + shutdown(), a TCP socket is moved to the closed
> > section of its reuseport group, while TCP_NEW_SYN_RECV requests
> > can still reference it as rsk_listener.
> >
> > If SO_ATTACH_REUSEPORT_[CE]BPF is then used on this socket,
> > reuseport_attach_prog() calls reuseport_alloc(), which resurrects
> > it into the listening section of a new group, even though the
> > socket is still in TCP_CLOSE.
> >
> > After close(), the socket stays in that group and the pending
> > requests keep it allocated. When the final ACK arrives,
> > reuseport_migrate_sock() can select this dead socket and
> > inet_csk_clone_lock() clones it. With a ULP like espintcp installed
> > while in TCP_CLOSE, the child inherits icsk_ulp_data and sk_destruct
> > after tcp_cleanup_ulp() cleared icsk_ulp_ops, leading to a
> > use-after-free in espintcp_destruct().
> >
> > As done in commit 8cc3aef0cb19 ("tcp: Do not allow buggy transitions
> > between ehash and lhash2."), deny this transition instead of adding
> > checks to the fast path.
> >
> > Only an unhashed former listener is affected. Applications can still
> > attach a reuseport prog to a socket that never listened, or to a
> > listener (including one that called listen() again after shutdown()).
> >
> > Fixes: 333bb73f620e ("tcp: Keep TCP_CLOSE sockets in the reuseport grou=
p.")
> > Reported-by: Kyle Zeng <kylebot@openai.com>
> > Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> > ---
> >  net/core/sock_reuseport.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
> > index fccbdd0430b05984e82c19b17b6b723b0a3a03a1..41a25be1bfff6aa486f33ed=
563a093a264c49344 100644
> > --- a/net/core/sock_reuseport.c
> > +++ b/net/core/sock_reuseport.c
> > @@ -6,6 +6,7 @@
> >   * selecting the socket index from the array of available sockets.
> >   */
> >
> > +#include <net/inet_connection_sock.h>
> >  #include <net/ip.h>
> >  #include <net/sock_reuseport.h>
> >  #include <linux/bpf.h>
> > @@ -692,6 +693,14 @@ int reuseport_attach_prog(struct sock *sk, struct =
bpf_prog *prog)
> >               if (!sk->sk_reuseport)
> >                       return -EINVAL;
> >
> > +             /* Do not put a shutdown()ed TCP listener back into the
> > +              * listening section of a reuseport group while it is in
> > +              * TCP_CLOSE: requests can still migrate to it.
> > +              */
> > +             if (sk->sk_protocol =3D=3D IPPROTO_TCP &&
> > +                 inet_csk(sk)->unhashed_state =3D=3D TCP_LISTEN)
> > +                     return -EINVAL;
> > +
>
>
> I think sk_is_tcp() is better. raw socket still can reach here and inet_c=
sk(sk) is invalid.

Yes sashiko reported that. And had the same 'suggestion'.

https://sashiko.dev/#/patchset/20261105164830.1682714-1-edumazet%40kernel.o=
rg

SO_ATTACH_REUSEPORT_[CE]BPF does not make any sense for anything other
than TCP or UDP.

I can switch to sk_is_tcp() for net tree, and perform the real fix in net-n=
ext.
