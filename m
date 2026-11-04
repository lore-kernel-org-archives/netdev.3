Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817682;
	b=3C8KlUwbgkHAuhhjCAnwXZbQg+N2E7G0ku7i/4q6ypQcvw6ryFHBrynPwADCDxN5colY
	 MmXardZmv+ASl7AI5kRsLtx74w2oq9j+LDCC6eTnh1xI4sfVYexjzwqo5Jj6YbsJv8N2b
	 /R8IVKaFmw4lvYRNWExP24u8n+Ng7sgxdFUKAG1+yPbLJixArKmDxZRH1DDye3YtN/Qcx
	 2OCA/9KFZseqUWZhwmfviMbff1faE6C06opW7o6Rvu2kyDLcHJhdtF7eOFx0qWIRnhcsc
	 ZPQdRDyFWmjuelB+jH+yLxj3SGw3Vk2o/brwTMb9uBzXHAEO3KAEPQYQU84W9a0VzCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817682;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sa/1gvD08fF02eywRKaNHv4Z7BLsMtacImtPELZ1yvg=;
	b=m4j++VYiB+kkCzy77a6bjIsvKJi7Hjq9qthlsXsXayWvJTJX4scfvBQXiIOClJW2rTQD
	 8en23FBxxTTlm5wer/pdwuZHdK7lBHLPEa4yb0eJqOwYWdZpfBu4JkR7xpdVTcNZGVIKt
	 bqwT9Zsl5mSd59/0fOovSC6pznxkEQKnWDeHgAd5nFJ5j+NpF9rN0ifm3zuhpF9xHNLil
	 YKntcFJjiSU4fpVUxWv5gWGvyO9A0C0TzUVn3ZwkvgYy1z0L+XMzATkVWa3EtzfisoDGK
	 jP6U2W2CpLxaEBPeThJMvELv19FQfKDCnkDN8S+pAOJGcHzhc3x22JOOcd1PpBGXxmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CAkQxcG4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B800606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CAkQxcG4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264D81F0093A
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 18:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793817682;
	bh=sa/1gvD08fF02eywRKaNHv4Z7BLsMtacImtPELZ1yvg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CAkQxcG4PGWM2l1d+r1Q9ZLXTrspuGmDmeeYgAL2ZqXviX9c1M8wxQgACW8mxd1o5
	 nxCqaX/HYupKxBGCWRNCpAWl0Kcq0SlpedZlIURywmZpk8UurjFRQGVskFptUOcsPq
	 kwaadngw3UHJvPLH+tRBgge6FJkztmHg7Q53RQIIrV2A2zpH9dyHCk9ghzxgOY1fso
	 NEpYFdA4NzdMvu4lzI1XTn4/ryUKHdAUp1BmtZXxzDMnGp56kAOoeBoD+hVpSYSPam
	 wcsHwkXotxyfs2Icewau5vQ9FTL1JMLjuyqxiZEONR5bta+ki72Xh6H1IkvVN9Sefs
	 yELt+QXZc55hg==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-499f20c7054so621481fac.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 10:41:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBySoZ197mTRbu35GkDiIcrhxpE2ifR1o6CkhHvCgF9lSL6cFs9uC/swr/DU1SXw0zQ4UQWIKv0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6eLO7zOrZc2Fw1gB9vVwDxHhl4/HRhDOIQSQufCCPhrEDTrD9
	co5QFWZWgq3LfWGiabFp0HPEFmWUC+HcHV6cluQWTi3Qr+PfhxKRD7GOG75OlTL6oKSeI1rg0gF
	U9CSlC9YakaWOfmJ6aXrsPZL7VfWZqdw=
X-Received: by 2002:a05:6870:e0b1:b0:475:a1ec:9617 with SMTP id
 586e51a60fabf-4a9076be0a9mr11995239fac.25.1793817681492; Wed, 04 Nov 2026
 10:41:21 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104165025.1026357-1-kuniyu@google.com> <20261104165025.1026357-2-kuniyu@google.com>
In-Reply-To: <20261104165025.1026357-2-kuniyu@google.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 4 Nov 2026 19:41:10 +0100
X-Gmail-Original-Message-ID: <CAL4Wiiqo6phhCB3v0+NtP0mBbbt1WP3XQ8p9qi=bAVSsQ7_ZKQ@mail.gmail.com>
X-Gm-Features: AclHuK_vyzy9hq_pO7rqhmdTHvZqLuYsuXPSrscCmXF2_h_6B7QiwDP47aXyyNM
Message-ID: <CAL4Wiiqo6phhCB3v0+NtP0mBbbt1WP3XQ8p9qi=bAVSsQ7_ZKQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/2] tcp: Don't call tcp_update_recv_tstamps()
 if not needed.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliang@kernel.org>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 4 nov. 2026 =C3=A0 17:50, Kuniyuki Iwashima <kuniyu@google.com> a =
=C3=A9crit :
>
> When RX HWtstamp is enabled on NIC, skb_hwtstamps(skb)->hwtstamp
> is set, which sets TCP_SKB_CB(skb)->has_rxtstamp to true.
>

Note that has_rxtstamp is also set when skb->tstamp is not zero,
which is the case for all incoming packets as soon as one socket
on the host enabled software RX timestamps (netstamp_needed_key),
think tcpdump or a PTP daemon.

So this patch helps more hosts than the changelog suggests,
so it might be worth mentioning it.


> Then, tcp_recvmsg_locked() always calls tcp_update_recv_tstamps()
> and sets TCP_CMSG_TS to cmsg_flags so that later tcp_recvmsg()
> calls tcp_recv_timestamp() after release_sock().
>
> If a socket does not have SOCK_RCVTSTAMP in sk->sk_flags or any
> flags set in sk->sk_tsflags, tcp_recv_timestamp() does nothing.
>
> However, it is not free because sk->sk_tsflags shares the same
> cacheline with sk->sk_forward_alloc, which is always modified
> under lock_sock()/bh_lock_sock(), causing cacheline bouncing.
>
>    0.31 =E2=94=82 403:   test   %al,%al
>    0.02 =E2=94=82      =E2=86=93 je     4a0
>   12.40 =E2=94=82        test   $0x2,%bpl        ; if (cmsg_flags & TCP_C=
MSG_TS)
>         =E2=94=82      =E2=86=93 je     48f
>   11.59 =E2=94=82        mov    0x60(%r14),%r15  ; sock_flag(sk, SOCK_TST=
AMP_NEW)
>   12.25 =E2=94=82        mov    0x170(%r14),%ebx ; READ_ONCE(sk->sk_tsfla=
gs)
>   20.70 =E2=94=82        mov    0xd0(%rsp),%rdi  ; if (tss->ts[0]) {
>    0.39 =E2=94=82        test   %rdi,%rdi
>         =E2=94=82      =E2=86=93 je     44c
>
> Also, sk->sk_flags is on the cold cacheline in tcp_recvmsg().
>
> Commit f0e70409b7eb ("net: avoid unconditionally touching
> sk_tsflags on RX") introduced SOCK_TIMESTAMPING_ANY to avoid
> such false sharing.
>
> Let's check SOCK_RCVTSTAMP and SOCK_TIMESTAMPING_ANY under
> lock_sock().
>
> We still need to touch sk->sk_flags, but with this change,
> tcp_rr -T 128 -F 10000 gains ~3% more throughput on AMD EPYC
> 7B12 Zen 2 Rome (2 sockets, 256 vCPUs).
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  include/net/sock.h |  7 +++++++
>  net/ipv4/tcp.c     | 12 +++++++++---
>  2 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 173b37b2b8bb..ba310182e6cc 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1063,6 +1063,13 @@ static inline bool sock_flag(const struct sock *sk=
, enum sock_flags flag)
>         return test_bit(flag, &sk->sk_flags);
>  }
>
> +static inline bool sk_want_rx_tstamps(const struct sock *sk)
> +{
> +       return READ_ONCE(sk->sk_flags) &
> +               ((1UL << SOCK_RCVTSTAMP) |
> +                (1UL << SOCK_TIMESTAMPING_ANY));
> +}
> +


I agree with Naman, this name is too generic for sock.h.

This only mirrors the conditions used in tcp_recv_timestamp()
to decide if a cmsg is needed, and is only used by TCP and MPTCP.

What about moving it to include/net/tcp.h, with a name like
tcp_want_rx_tstamp_cmsg() ?

> +static bool tcp_want_rx_tstamps(struct sock *sk, struct sk_buff *skb)

Otherwise the logic looks good to me.

Thanks.

>  #ifdef CONFIG_NET
>  DECLARE_STATIC_KEY_FALSE(memalloc_socks_key);
>  static inline int sk_memalloc_socks(void)
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index b9de7c302ba8..4166be09b826 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1878,6 +1878,12 @@ void tcp_set_rcvbuf(struct sock *sk, int val)
>         tcp_set_window_clamp(sk, tcp_win_from_space(sk, val));
>  }
>
> +static bool tcp_want_rx_tstamps(struct sock *sk, struct sk_buff *skb)

nit: const struct sock *sk, const struct sk_buff *skb

> +{
> +       return TCP_SKB_CB(skb)->has_rxtstamp &&
> +               sk_want_rx_tstamps(sk);
> +}
> +
>  #ifdef CONFIG_MMU
>  static const struct vm_operations_struct tcp_vm_ops =3D {
>  };
> @@ -2069,7 +2075,7 @@ static int tcp_zc_handle_leftover(struct tcp_zeroco=
py_receive *zc,
>                 offset =3D *seq - TCP_SKB_CB(skb)->seq;
>         } else {
>                 skb =3D tcp_recv_skb(sk, *seq, &offset);
> -               if (TCP_SKB_CB(skb)->has_rxtstamp) {
> +               if (tcp_want_rx_tstamps(sk, skb)) {
>                         tcp_update_recv_tstamps(skb, tss);
>                         zc->msg_flags |=3D TCP_CMSG_TS;
>                 }
> @@ -2280,7 +2286,7 @@ static int tcp_zerocopy_receive(struct sock *sk,
>                         if (!skb_frags_readable(skb))
>                                 break;
>
> -                       if (TCP_SKB_CB(skb)->has_rxtstamp) {
> +                       if (tcp_want_rx_tstamps(sk, skb)) {
>                                 tcp_update_recv_tstamps(skb, tss);
>                                 zc->msg_flags |=3D TCP_CMSG_TS;
>                         }
> @@ -2893,7 +2899,7 @@ static int tcp_recvmsg_locked(struct sock *sk, stru=
ct msghdr *msg, size_t len,
>                         tcp_fast_path_check(sk);
>                 }
>
> -               if (TCP_SKB_CB(skb)->has_rxtstamp) {
> +               if (tcp_want_rx_tstamps(sk, skb)) {
>                         tcp_update_recv_tstamps(skb, tss);
>                         *cmsg_flags |=3D TCP_CMSG_TS;
>                 }
> --
> 2.56.0.385.gac671c819a-goog
>
