Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB53F430CCA
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 11:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791458604; cv=none; b=iDdFHBuOV3oroPym+ScJSqE2AcdtfTKnt6u28hQ3hACy/LSHnOjKRK3bSu7MBbIxJC2c+mCaUn+0d7Vi6ifxwqikvgXEatoZVc9d7fLgiS6PIO5tGuXVgv+GG+kLC+uCsEzk0BJ1WLb2+p+9Y6Lzgn1oEbApYf/fmK106Lnj11g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791458604; c=relaxed/simple;
	bh=F0oOjT3HrxqylxCawx0wdKuMFBs3XCL4/G/XIcES1Rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zurtu2VV0V5MI9Z35UbiSBt8nUR0BGoYRgqWp5vwfCXW/qwdjYBnVsEYGNJJ4omhB7Ny3v5aeErX4GpzgXCtfA8NL6zONWkTTUNrE/0BbDQTBG9KVU4iTTRfwidIux8M4YEhG+AaSTfE2JuMZqGvY7HlC9K9uYBEuOBdh878GIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBYw0z0U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBYw0z0U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0011F0089A
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 11:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791458603;
	bh=OCn78hP9ueLLGhxW6pW6RbrRspOn6L8aUvAyzG5R1q8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SBYw0z0Up8qwR7mXJrBupwsvyFMM4+TUdsnDihUT+Lr0FrO7SGm6w+4Qa//QWrpBm
	 rYLRSEObw4rb8EKCR4zfcSJEe8W4a7Oo/l5Jb8Aekbxzc2Bd+dEXKgQ3snoo24m6W/
	 tQA4JXM0lFlTUDUVBhTy4M5pWGZ0GcNTaYjAZBbrGZ9pB58bueQgin9Rw8evVMSsTZ
	 RAZyodv3/O0kHgxDGAyluqCGG0AwdALFQcEmx6GcFLhhlq+A7EQSf8OofrqXGPGgUm
	 vt+m+z05MVP0mk8cmdfzCV6QwXufhtOPZcP2hHTiu2qGlMt3SZSRI3KZimQknC/9pi
	 /NYcUHo1Lww9A==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-483c607ccb4so2758883fac.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 04:23:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxdV7YBd3YLyqA+BOq0I+ZtubP0Ood0+1pIJpzahvNs3VCBofkFcvGJlJT6gwo/iAoHb2Tss1c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJAVJbrXTTp8Ock7cwVv2caFFoMNQ4xPoMdgcwHNul+M9V0G7Vv
	+tKFadI8/7OCYfNnUzUFQEDHwM86Ey0HUaAtcxmXjpTPqXztWlgdpAFFJpc85X6SnPcJdSZISIL
	XSWt4RUFEp2i8rwrw7Hsn2H+0GyDyGaw=
X-Received: by 2002:a05:6870:a0a5:b0:475:e2e9:4f54 with SMTP id
 586e51a60fabf-4a25961fcfdmr4553863fac.34.1791458602726; Thu, 08 Oct 2026
 04:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008100423.1256884-1-theodorlarionov@gmail.com>
In-Reply-To: <20261008100423.1256884-1-theodorlarionov@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 8 Oct 2026 13:23:11 +0200
X-Gmail-Original-Message-ID: <CAL4WiiqDffWyo7+gbffB2PYuKAbjboK7D=JJD+z=5J5MX=9Y3Q@mail.gmail.com>
X-Gm-Features: AclHuK_YZkLCz2adbKpdT7afflmfkP7cSHP82EUw7c7epSmBMrFz5ew4Q5U9llE
Message-ID: <CAL4WiiqDffWyo7+gbffB2PYuKAbjboK7D=JJD+z=5J5MX=9Y3Q@mail.gmail.com>
Subject: Re: [PATCH net] net: use the full socket in sk_mc_loop()
To: Theodor Arsenij Larionov Trichkine <theodorlarionov@gmail.com>, Ido Schimmel <idosch@nvidia.com>
Cc: kuniyu@google.com, pabeni@redhat.com, willemb@google.com, 
	davem@davemloft.net, kuba@kernel.org, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 8 oct. 2026 =C3=A0 12:04, Theodor Arsenij Larionov Trichkine
<theodorlarionov@gmail.com> a =C3=A9crit :
>
> tcp_make_synack() sets skb->sk of a SYN-ACK to the request socket.
> If the SYN-ACK destination is multicast, ip_mc_output() calls
> sk_mc_loop() on it, and inet_test_bit(MC_LOOP, sk) reads inet_flags,
> which is past the end of the smaller request_sock object.
>
> KASAN reports a slab-out-of-bounds (or slab-use-after-free) read in
> sk_mc_loop() from tcp_v4_send_synack() when a SYN with a multicast
> source address reaches a listener.
>

How does such a SYN reach a listener ?

ip_route_input_slow() rejects a multicast saddr as a martian source,
so this can not come from the wire.

I guess this needs a local sender : raw socket with IP_HDRINCL, and
the packet going through loopback, where the dst is kept
(skb_dst_force() in loopback_xmit()), so that ip_rcv_finish_core()
skips ip_route_input_noref().

Also the SYNACK route only uses ip_mc_output() if RTCF_LOCAL is set
and the output device is not loopback, so the SYN must target an
address of a non loopback device, and the source must be a group
joined on this device.

Please describe this in the changelog, and include the (trimmed)
KASAN splat, and a repro if you have one.

(Was it a public syzbot report ?)

> Map the socket to the full socket before reading its flags.
>
> Fixes: ca6fb0651883 ("tcp: attach SYNACK messages to request sockets inst=
ead of listener")
> Signed-off-by: Theodor Arsenij Larionov Trichkine <theodorlarionov@gmail.=
com>
> ---
>  net/core/sock.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/core/sock.c b/net/core/sock.c
> index e8551df8330f..1302c1e848b2 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -769,6 +769,7 @@ bool sk_mc_loop(const struct sock *sk)
>  {
>         if (dev_recursion_level())
>                 return false;
> +       sk =3D sk_const_to_full_sk(sk);
>         if (!sk)
>                 return true;
>         /* IPV6_ADDRFORM can change sk->sk_family under us. */
>

This only addresses the out-of-bounds read, masking the root cause.

We still answer a SYN with a multicast source. With this patch the
SYNACK is looped back depending on the listener MC_LOOP setting,
and syncookie SYNACK (skb->sk =3D=3D NULL) were already sent.

tcp_v4_conn_request() only looks at the input route flags, ie the
destination of the SYN. tcp_v4_connect() refuses RTCF_MULTICAST and
RTCF_BROADCAST routes, I think we want the same check on the route
used for the SYNACK.

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_soc=
k.c
index 6a30f11384547e6adaeff13a005c7ce1d316a602..aa928015cd143234d3d0c72e2b6=
07d8347f73269
100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -779,6 +779,9 @@ struct dst_entry *inet_csk_route_req(const struct sock =
*sk,
                goto no_route;
        if (opt && opt->opt.is_strictroute && rt->rt_uses_gateway)
                goto route_err;
+       /* Never send a SYNACK to a broadcast or multicast destination. */
+       if (rt->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
+               goto route_err;
        rcu_read_unlock();
        return &rt->dst;

pw-bot: cr
