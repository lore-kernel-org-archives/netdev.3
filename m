Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C72D5158B7
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 21:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790026579; cv=pass; b=b7Y+yoUZiBiMmpJY4aWGXPPIHfXMT9+aI0cv+WhZ3wGPjSYwt1+dqKK8IsTjeVAxl6gIB45/w27wLreQrv52URws74OJ6eZ0lWIstJ23e0ZbhVsrlPVtGq8Z7uVBnv++5135CaJcu0UEPkymQzsEtAQDuIa9b7hbxNP197HUNtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790026579; c=relaxed/simple;
	bh=0xRxgq2j53JlZwoPQFcrgqq0FbNHb3eRgpC1bShN5I0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KoQb39GsfniTSRy9sBQNsZSI15HYaZlsXjyxZ37mPv0c2T767okqPgZ0Xg8qbvBR9WUg0QeY17aAwA+4fD+aH4fLF7zDYHnxW8/1NlY9mXASK/wx+ml67mwjxvgaN35KO3dLcCOU48PC4eRugxNCiiLxv/Y9bbrWTW2UVm/YoS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RDoIlXaw; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RDoIlXaw"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4bfd1so2370852a12.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 14:36:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790026578; cv=none;
        d=google.com; s=arc-20260327;
        b=pHF21iO6eq/ZAAEkjco9Py0HdN4l/77j1QkpvF7rz//QXmuki8Ajsdb0lnYgRK+PoS
         o3bH/7k9EFvd9hfq6cNyuXjFPZsS7mJGou7R6R2Yei2j4Kk6V7cnpw4Kd9F6AMf8gJOU
         DRgVatdGEGY30NAQOCdncAzkHcn3jOPkYEo47OV5LKTh6fDIHVz/L8T0HqYyWMuR4L+I
         HporCmfMw7ic7/21eGUM+Donh1NC9MecM3uyT4piUVH+KXbhy5DW6ceUieeG3Gm9kfN0
         4b4Y7iiRcfQvOwLcEESerzDSyMcJSddsziLgkIA4KohimFogROFaoeTRpxcoh7gNCElx
         0ODg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9S4UN1V9mLtIU5XAJ4Mj87c5tZOTpom4ugNvERFaqpw=;
        fh=/eRw9WjU/KNuqcQfxdijkShZhZwegcbgtzKH4UJepdg=;
        b=apNWJPHLGM3RrM0UNQnC1KjXWWrUIaoj4LgDxjMhe50zeodTuEpkJkgOJ+WMLh6mFS
         KIQpXw+JgzPi+RVLVJc2PtenTkP9K5W/fDbaxItqq9+B8uneNvcY5D2tnfc4RYyc4e/T
         p381ebxkAXJogV6CVUdy6iXNjvBGOTGN8sZ0AVv1SeBoCqIPCm5tCcj2Lp4crxZ2xwr1
         bqq/aXgWcsN8D9eY7dXjktebzi1tjXk5ixvYXywOyHeJVJY0SKJDfugjhoJU2tayTO5v
         2ZPtlsVUr83nw/UKi2F0ndd4NQVfGyP4wIs2ZT4L0+oohr9ZHPeozwDniklzUGlTPbla
         321g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790026577; x=1790631377; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9S4UN1V9mLtIU5XAJ4Mj87c5tZOTpom4ugNvERFaqpw=;
        b=RDoIlXawWkmcpBXKoytTplVKVsqrPDuz1ayCVa8Y2IHilZdz4yvdL0S/IGv3bniQnH
         9n7wCXPVgU7ZlJe9P7nzIcfaPtV8BnWSEXboRXwzOPga/WQZGzU10Ea3RRdS8YaNpeKd
         A0aThIUe0bhT1o5MAAT7OhjKT9L73iO6Sj31V8A/KCNzMS7vQiRQcHHtwJFEgtUPH93P
         lK33volhbLoRM4QiyQg7e8M/QJaaZAHKZCfDSgBq/+kYhCsyzUPjarsBy2hkE9Pb3PKH
         uPsuorU6A32aJGN/xujqM96GdwasbPKsgDTqVg+yAXS+pvdZs3PqdxeRXA8lX8zmToRa
         yN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790026578; x=1790631378;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9S4UN1V9mLtIU5XAJ4Mj87c5tZOTpom4ugNvERFaqpw=;
        b=piN3dYCwR4TQyKxeZlYFfmTNItptEzJAgDectG552H3hukXH99xJ+Ee25Nj6clnSJq
         XcXKSE03CjnhlXPYE6L4StHXqfcm4LQClW3ONxvt1SiE+QIrwcDUaadOjnTqqBDslkkj
         coQ6NAvcYAkDIhdcwV1VpYxlFW8AE84lmYRK8dscbIN4qkEZV+kNCHst10hsQLPKydsw
         o+HBymrQIeDElnsvAUCR2sFxBm6JJsq+bQFHWxOz6neawu/cCHIib2fcI/FiBj0BeepS
         V+O8caFwo8qsuqaeX2NDzAxvsaqxt1GTLo80GdGN3f6eVAqAhPzqcSr0eOK3mNfCH5Dn
         q5kQ==
X-Forwarded-Encrypted: i=1; AKwUvBwRJ838+64YUFQuQ0kdVQutSiu7mLBa2qhSZyKKVRVPUjmH7Ldgqh/fD0jqrAgWe49/W3ADxgA=@vger.kernel.org
X-Gm-Message-State: AFuF++ncnvriNlYIOMoQabhMhpS/OeDAcTksFRf4Ke09YNPUyzHCTFx8
	A+LtXUocvc3aqFD/vD7MIZ8T/VTtaRyHlQkWwOOk1WlxQ36N/Mh5J3rQRyeIlO9Vkhm1w7/d3Fq
	mEz8NuwA+67kAHElAb7yJxRZAQkXliJvVeI7/sbdt
X-Gm-Gg: AYBFou2tzZUh3Nu5GaiWfF92t+Niiob9Bk5ejf2g3TKcD4WXRgi03ttYpnLmvu5pbKW
	IjLRuBfYaqlNhrfW0BVF4FzLub35y4q2kccBfkaAMNBboRDsTFV5aiJgYfAHKxTXLBORRMWaTYI
	Ps+1mCG0SsFd7Y3QQiSEiZW1ppSnpmwypjL2gwgt8AbraIKQhqXK5QGPPcSMR1V+NFIg67Sq4xH
	51+90p69WZKGN47PprestqRZes1w6h5w/yGorJYmKEtDFHv7v8gYdLsp3ZRo/AHzlskd1pN2drn
	frKBDMgUnbr71sY10Nb5k09ZfHKUo0h6pk9xVtzgZ0XyNa/oKyHVzKRtWjh9j3757Q1nKWs17pD
	i9l3ndWFlOZXV616Uc+hZHjHBwfgwQWvSJwyXVo/ocVAG3qiX00fAZFFG1/plakWfGeZyU3pTtb
	AdE0VfN+xT+QqV3sDe6sEcCw==
X-Received: by 2002:a05:6a20:548d:b0:3dd:85a8:cac7 with SMTP id
 adf61e73a8af0-3dd8c44e2famr18712394637.30.1790026577083; Mon, 21 Sep 2026
 14:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920195633.3033620-1-kuniyu@google.com> <20260920195633.3033620-7-kuniyu@google.com>
 <arGYSbQ97ORDvSBl@devvm7509.cco0.facebook.com>
In-Reply-To: <arGYSbQ97ORDvSBl@devvm7509.cco0.facebook.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 21 Sep 2026 14:36:05 -0700
X-Gm-Features: AcwNN1Wmuqzqu6AVItlJJYH99pXCMxSAZwEMncsGSowQkA6OYTAXgvMp6Luf5KY
Message-ID: <CAAVpQUDSU8QbnLm2ajR0NKTRNr75-6yXKaerG-ZcUkOLKz70rw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/7] bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
To: Stanislav Fomichev <sdf.kernel@gmail.com>
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

On Mon, Sep 21, 2026 at 1:50=E2=80=AFPM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> On 09/20, Kuniyuki Iwashima wrote:
> > bpf_tcp_ops.{enqueue,dequeue}_rcvq() were added to parse skb and
> > adjust sk->sk_rcvlowat dynamically to suppress unnecessary wakeups.
> >
> > Let's add a new kfunc to set sk->sk_rcvlowat.
> >
> > Negative values are clamped to INT_MAX, consistent with SO_RCVLOWAT.
> >
> > For enqueue_rcvq(), wakeup is set to false because:
> >
> >   * tcp_data_ready() is always called after the hooks in
> >     tcp_queue_rcv() and tcp_ofo_queue().
> >
> >   * when tcp_fastopen_add_skb() is called for TFO SYN, the socket is
> >     not yet accept()ed, and when called for TFO SYN+ACK, the socket
> >     is woken up by sk->sk_state_change() anyway.
> >
> > For dequeue_rcvq(), wakeup is set to true because tcp_data_ready()
> > is not called in that path.
> >
> > An alternative would be to support bpf_setsockopt() for these
> > hooks.
> >
> > However, that approach involves excessive conditionals and an
> > unnecessary memcpy(), costs we do not want to pay for every skb
> > in the TCP fast path.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  net/ipv4/bpf_tcp_ops.c | 56 +++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 55 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> > index b0e14b54917e..3768b1440eb7 100644
> > --- a/net/ipv4/bpf_tcp_ops.c
> > +++ b/net/ipv4/bpf_tcp_ops.c
> > @@ -359,8 +359,62 @@ static struct bpf_struct_ops bpf_tcp_ops =3D {
> >       .owner =3D THIS_MODULE,
> >  };
> >
> > +__bpf_kfunc_start_defs();
> > +
> > +__bpf_kfunc int bpf_tcp_ops_set_rcvlowat(struct sock *sk, int rcvlowat=
,
> > +                                      const struct bpf_prog_aux *aux)
> > +{
> > +     u32 moff =3D aux->attach_st_ops_member_off;
> > +     bool wakeup =3D false;
> > +
> > +     if (moff =3D=3D offsetof(struct bpf_tcp_ops, dequeue_rcvq))
> > +             wakeup =3D true;
>
> [..]
>
> > +     if (rcvlowat < 0)
> > +             rcvlowat =3D INT_MAX;
>
> nit: the same check exists in setsockopt. Any reason not to move it
> to your new __tcp_set_rcvlowat ?

Maybe we could duplicate it for each protocol, but I feel the logic should
reside in the core part.

$ chgrep -E "\.set_rcvlowat.*?=3D"
net/vmw_vsock/af_vsock.c:2672: .set_rcvlowat =3D vsock_set_rcvlowat,
net/mptcp/protocol.c:4730: .set_rcvlowat   =3D mptcp_set_rcvlowat,
net/ipv6/af_inet6.c:691: .set_rcvlowat   =3D tcp_set_rcvlowat,

>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Thanks !
