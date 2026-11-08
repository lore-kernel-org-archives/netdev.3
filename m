Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794107853;
	b=rM51Rf/0CJdmOMZC62JOAKOKlU1uYJ4bATqcSUDcVkr3mJasGucg2GWykIKmQNECUK6l
	 3rBi4OT0Q85O9hVy8F5PXVarh6B20NJ+vZ3fkeYhmjLWhQQ+vOwJuTQeCs3RrwnSp2e62
	 PnKh5PE0R/QjKEjN93Lnc5u52TsfCoJ3SU8tWjy02hDUH2Cd9f0ouiUic6Bkpf0bSTsQ8
	 376XZfjS6HVFY+OK0Sp/Q5CKpCC/vm/XMa04hvv2yAcwjVmHYPvlXBqpt+F+nOORMVV3y
	 7l7stGCd2a6kX17VzofvrBkfRxfXC7+GZr/8WxHj1qqmfCRIdCw/W//Tdk2NJYMwDOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794107853;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2I+093n0UIY5U+GFcKHbH0n1dxSizOMfEkvs86TkO6k=;
	b=TjyDDK79OxwSlyHiHIQDvRMt0GyppHt+fktoEIe73H8c8VcceAz3ixbClAb21ewgS2Pb
	 AEvVw9o0yN0rP/2MitmzHom9TIYPxn3Ar6NdDSGNcWAWV1xYJjRsBNxIJ0PqdgeUhvSpV
	 FwXA+XiMKgPX46Yc6YCcgLVUZlrNjKhENzf+9al36Th2+Pu3zi5dkYucW190eT59NS595
	 +GlyVTDBsEbB773jb/+y/jNOUjgH19iIe/wujWSTobWJ/2Ig558+zgvXRBEQ6rTWv4YfQ
	 Nmt7L3yTHMCPRvdO71OKr8xuqa2NBxV1ddRfx8vI87Q2VZ9DZBGBt3rUpgHjcO8yBaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="IAvay/DA";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60921606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 03:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60921606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IAvay/DA
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-535f598d126so1441cf.1
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 19:17:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794107851; cv=none;
        d=google.com; s=arc-20260327;
        b=CYLGfPx0djR3fo2+51o7lkGUzXCtdrrUgeAHb6qmDtpnrIrvKgP1I0LCuytJUnopiB
         YWhGpmTkVNW5UefYInOg888g6DDsCiNIwvPZNHfkY/KtHz9sNP5ZbXZmyQKoIeEzh9eq
         wdA5xvhQlyltWMUi+CIjdq82l7dVSAI5J6NcQwHGe1c0VDQ75mGeV6oiQlkcQIvRb6mG
         U7KJV/DfDJ9nkb/qJ3eG256eLlth73xNUm5hP1IPy/71ZkZKeYosUbDQ1jy8wDhH96Pg
         xyFgj9QGPc1UZX2UYjDNyEf8X8IvsP7f++bxjdRdKbOrdr1g7N2891pPmG41sYga9/3E
         aR5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2I+093n0UIY5U+GFcKHbH0n1dxSizOMfEkvs86TkO6k=;
        fh=E/dKvxvl+SCho44UP1ZCCnvlwrIhUfNiEiho38Mzu/Y=;
        b=BvE2xitnz0s6TADLABRWuHlITri97WupHwjwdpNWcdv8XDHca4ucJg95tqb9MqxYRw
         h3BjZZqV9RetkZYzb9UjKPAM4GuvFVQn7XUP8EvS9Xj30x8vq71q7KYTIfi714rPCqpc
         HFNM2DdQbKgCWtJzlKU76l9Enf/FjGZmKTmqi2z/YfiwlvwRj0I/cVl3rmKFlmsKUeB8
         +EBd47KVp/oY8cR2nLWSKnK4/2IdLkqW/1Bah2D2sLh0LtYT7fMrY/3s2xxdhlo0aGIB
         sowkRsL8qY392X9AbzrbO2lFN/A3uo9L38RgPAqBUelvWSfljFMJ/RqK69cEE9CEXzxZ
         guMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794107851; x=1794712651; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2I+093n0UIY5U+GFcKHbH0n1dxSizOMfEkvs86TkO6k=;
        b=IAvay/DAoBXnCYRsuvPIfgM1EqwkTz4a4tmBKkexani6vdcOk6tvyJW1llJbr50Ant
         rtpnr3ZKB2H6NfViDuTZ9Kne5WzwAplnbA3ercPCvpo2hhET+pgv59Pp/1mYx7n20FCQ
         FZvGdx1l2QpDSu6koxOSTM4tXoVg75xD1Q1MEZCaIhirg1MvP2YrApQ8T/nQOlyLojrZ
         gQ3gAQK7OFQIVyCgdPW7XP2k898mmgu181MvyNqN4nWzyf6NYJpkK/9ghQ+t+ZpE9ysA
         1hTZPZmYjb0cD1vy5p6JUSoA9TrXJqZ89eWBXClmcJytcdrNv9PgJR6TpWDkB1VNmwZ0
         USrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794107851; x=1794712651;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2I+093n0UIY5U+GFcKHbH0n1dxSizOMfEkvs86TkO6k=;
        b=FggMJhmAVdpgrce9a8eh+kY+EDSdd8tt+D0grwNJM71I+wZcw3RUHCF5kWVpROCtvj
         EP2zoO5+pukF24VImZ/ARWpuUktvTbuJkuvJQj8gUXUb+XF7NzVv4yjSkahGroGIaNIo
         tBYvd+KSy61xHoWlsY2Oa77ivh1elJXChhb5WFEuZvoj7ZiB8nS7jbrSd1SLzmYf+gl5
         m4tg7SX+Y3M01ECPZKhuKCo/2M2c8irc3YCbI1ToraLRMxxgDHbIXl80sQMxivzRMMcm
         ik6H9t023tMRWfqhfhghz89g/Wj8ld6J3z/Csix14o/NMjyg9kzAcEao9KnxATF95IgY
         6L5Q==
X-Forwarded-Encrypted: i=1; AKwUvBxFKkJ7xt0yAtO8Iwr6g/Jc+iYSX8ZPRy9W/H9WjSORHdsu9aMSt7gqS93dBMaDZVhn2zwj2F8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CBZXCBBpT9JFTFweUmQE0mzoYZWF8aVUC8LYXKumtSrqbS8ih
	VWZXmB4eu2o8zrWBCcMyQgeZa6apl3EVEr6EEaNvnWI7pNAf0VNpDC/tfXMdRNIqff+qt1BSt2I
	17BAdwGZX5mPXAbYw9yvQiRXfjCBfByWymryaHMyj
X-Gm-Gg: AYBFou2tTB6GuKn5Eop/08Wx2ipof5I6dzvu83VjRNW65SNi+nrTIMNiKGxelxWrWQ3
	8uPR4g67zsbWYV+4KXrPNmA5gyLkrPnom+K3hlffk/MAWob9fuycg7q0d5WD3POffbPhgKZuumE
	ZKuP7k7pABJEVAuZqoZs8hkXftX5eJz9aJH/OWsc0g/TlCpBfTq7H9D1fYyB6EIQiLd1pzQnGOA
	ZD4MTgnWZR3WUkKeD7t2lkBbhr8eGRHAf+oL+1uKiv2gL8TYFPcH0H74q8Usu1FpN1bQpTl58jU
	Fv/Zz+4rlpJB2FGAdF3OEku0Si0yskSo+hzwD5G9LPRBf5AFXXZdl5RaqN73OM5SFniC8V6+aNE
	Pv8oALAoVky1lzTd4MadQawszuVu7GBAxnL9JYp94P9oaZsj/LMFfNxfc/GOhOty9wLGesK3vPG
	xjdZXKSfRq02xe+yxaqPCnOcU6lqM=
X-Received: by 2002:a05:622a:5985:b0:535:bb33:6351 with SMTP id
 d75a77b69052e-54f9f0c1cbcmr18824881cf.1.1794107850713; Sat, 07 Nov 2026
 19:17:30 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103-mtu-probing-series-v1-0-a2809e725aaa@gmail.com>
 <20261103-mtu-probing-series-v1-1-a2809e725aaa@gmail.com> <CADVnQy=AHpy6UoiAFopRUmHLNv6Arw07PysXVijiR=qERuzeww@mail.gmail.com>
 <au9zxblIQx7OF_gx@google.com>
In-Reply-To: <au9zxblIQx7OF_gx@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Sat, 7 Nov 2026 22:17:11 -0500
X-Gm-Features: AclHuK_hiKxuy2XPBtNnUtx6z7qgzENFTmDz_HcsklNHSgevwIjrhp-FGceyzzc
Message-ID: <CADVnQy=6mDzR6XQxnasHECbq7=9f54AH8cjny+rAdR_yR_ZsTw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] tcp: sync MSS after enabling MTU probing on
 passive connections
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: echoowall@gmail.com, horms@kernel.org, edumazet@kernel.org, 
	kuba@kernel.org, shuah@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	netdev@vger.kernel.org, panweiping3@gmail.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 2:15=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> On Sat, 07 Nov 2026 12:53:36 -0500, Neal Cardwell wrote:
> > On Tue, Nov 3, 2026 at 2:09=E2=80=AFAM Yongjian Wang via B4 Relay
> > <devnull+echoowall.gmail.com@kernel.org> wrote:
> > >
> > > From: Yongjian Wang <echoowall@gmail.com>
> > >
> > > tcp_v4_syn_recv_sock() and tcp_v6_syn_recv_sock() call tcp_sync_mss()
> > > before MTU probing is enabled, and tcp_init_transfer() enables it lat=
er
> > > without syncing the MSS again.
> > >
> > > With net.ipv4.tcp_mtu_probing=3D2, a passive connection therefore sta=
rts
> > > at the full MSS instead of tcp_base_mss as documented, while an activ=
e
> > > connection starts at tcp_base_mss. This has two visible effects, show=
n
> > > here with tcp_base_mss=3D1024:
> > >
> > >  - The MSS drops when the first probe is acknowledged, from 1460 to 1=
242,
> > >    although that probe has just shown the path can carry more.
> > >
> > >  - On a black hole path the MSS never tries tcp_base_mss. It goes fro=
m
> > >    1460 straight to 512, since MTU probing is already enabled when bl=
ack
> > >    hole detection triggers.
> > >
> > > Sync the MSS right after tcp_mtup_init(). tcp_sync_mss() only applies
> > > search_low when MTU probing is enabled, so the other tcp_mtu_probing
> > > values keep their behaviour.
> > >
> > > The Fixes commit kept tcp_mtup_init() in a single place on purpose, s=
o
> > > sync the MSS next to it instead of moving it back into the
> > > syn_recv_sock() handlers.
> > >
> > > Fixes: 4d83e1773031 ("tcp: delete redundant calls of tcp_mtup_init()"=
)
> > > Signed-off-by: Yongjian Wang <echoowall@gmail.com>
> > > ---
> > >  net/ipv4/tcp_input.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > > index e1f2d9765..c13f005b2 100644
> > > --- a/net/ipv4/tcp_input.c
> > > +++ b/net/ipv4/tcp_input.c
> > > @@ -6760,6 +6760,7 @@ void tcp_init_transfer(struct sock *sk, int bpf=
_op, struct sk_buff *skb)
> > >         struct tcp_sock *tp =3D tcp_sk(sk);
> > >
> > >         tcp_mtup_init(sk);
> > > +       tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
> > >         icsk->icsk_af_ops->rebuild_header(sk);
> > >         tcp_init_metrics(sk);
> > >
> > >
> > > --
> >
> > Functionally this seems correct. But I'm wondering about the
> > performance impact, and whether there is a way to achieve this without
> > adding this call to the code path for every connection establishment?
> >
> > Eric and Kuniyuki, WDYT?
>
> Looking at history, initially it seems we properly called
> tcp_mtup_init() right before tcp_sync_mss() in ->syn_recv_sock(),
> but 4d83e1773031 removed them.
>
> The dup tcp_mtup_init() mentioned in the commit is the one in
> tcp_init_transfer() today.
>
> Then, 27204aaa9dc6 moved only tcp_mtup_init() to tcp_init_transfer()
> without tcp_sync_mss().
>
> The dup exists in tcp_rcv_state_process() from day 0 (5d424d5a674f),
> and 168a8f58059a copy-and-pasted the unnecessary tcp_mtup_init().
>
> So, 4d83e1773031 removed the correct one.
>
> Instead of restoring the 2nd set of calls, I think we should
> revert 4d83e1773031 and remove tcp_mtup_init() in tcp_init_transfer().
>
> ---8<---
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index e1f2d9765f81..8d009c0d9359 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -6759,7 +6759,6 @@ void tcp_init_transfer(struct sock *sk, int bpf_op,=
 struct sk_buff *skb)
>         struct inet_connection_sock *icsk =3D inet_csk(sk);
>         struct tcp_sock *tp =3D tcp_sk(sk);
>
> -       tcp_mtup_init(sk);
>         icsk->icsk_af_ops->rebuild_header(sk);
>         tcp_init_metrics(sk);
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index a7f9242f1e42..579a88472abf 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1740,6 +1740,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock=
 *sk, struct sk_buff *skb,
>
>         tcp_ca_openreq_child(newsk, dst);
>
> +       tcp_mtup_init(newsk);
>         tcp_sync_mss(newsk, dst4_mtu(dst));
>         newtp->advmss =3D tcp_mss_clamp(tcp_sk(sk), tcp_dst_advmss(dst));
>
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index e006a30360ea..c465fd97baec 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1489,6 +1489,7 @@ static struct sock *tcp_v6_syn_recv_sock(const stru=
ct sock *sk, struct sk_buff *
>
>         tcp_ca_openreq_child(newsk, dst);
>
> +       tcp_mtup_init(newsk);
>         tcp_sync_mss(newsk, dst6_mtu(dst));
>         newtp->advmss =3D tcp_mss_clamp(tcp_sk(sk), tcp_dst_advmss(dst));
>
> ---8<---

Thanks, Kuniyuki. I agree that seems like a good approach. Though
since 27204aaa9dc6 also moved the tcp_mtup_init() out of
tcp_rcv_synsent_state_process(), I think with your nice approach we'd
also want to place a call to tcp_mtup_init(sk) right before the
tcp_sync_mss() call on the active connect code path as well, something
like:

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7015,6 +7015,7 @@ static int tcp_rcv_synsent_state_process(struct
sock *sk, struct sk_buff *skb,
                  tp->tcp_header_len =3D sizeof(struct tcphdr);
          }

+        tcp_mtup_init(sk);
          tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
          tcp_initialize_rcv_mss(sk);

WDYT?

neal
