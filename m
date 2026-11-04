Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793816772;
	b=0PipDoDl7aZf46sA7hZfE09cy+/KN3Z3ayz3EYOVXafH5CyJt3iCdjZI5qLSUcVJJlh3
	 yVeUqAJ26dr1f3P+UpOsjkhuXc09pZCwIJY2VIQo1nt9FSmPwYXmuLYrNugkuhR3WgT8J
	 PPvzwSHeFRIjf0Au/0XEIm35XDjHvF5ELG7CQ0uIJZfGtTirHhYbFnIyaEEniaMx/pTJH
	 3sQoflqwY1x5Lu6zwP2T5nwFPeoewSqAf8OTveLw+ofoMx762Bf2CnwVkjtI/S8cRWHz0
	 y2ZlFIFPpPpxtwL6PuBpd8S4FbYpcp0AQ4IA/RNiZPWakpCamApS0KdohtB1I6oHU3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816772;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PQHXcCdxoxsS7ejousgAUdoPQ2UFDoYPmcf+Vpaig8k=;
	b=s38qi9/o/5203sKrrjNrW2KW6d48U7mSV5ZBMxe7Qm5OPvDmDrEMnMsPqYTYAhhJ4Vdn
	 G6MKndeAfTpHqMb9XzQ5TKMKP3ferlyRXwxejnAP2mCXxt/nwP2L1pgUt3RqJRZRGdXad
	 GyXmK4VffLmhxhRp/V2VX+MKDiYZ3lwqgpSo5ItFqW+dXrDfW1JO8CHkngHKdnnSWY4A7
	 xnzVN2dWx9ofPsPPORpFfrqSIhHgTqImPeDAWdGn0o66177zuhbfjy/j6V8FSNU6Rcqar
	 jFcprBNIkGiTIYagDTEVaH+03maOAmmm1PKElYaBaQcc+Sgj4Dpa/ZMGMq43SvGWJgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mY3Vf4ZB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5C1606A334
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 18:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D5C1606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mY3Vf4ZB
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a20d7a8984so2015e9.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 10:26:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793816770; cv=none;
        d=google.com; s=arc-20260327;
        b=Tg3dZdIwrZahEtCwfEBgDtnBsxPV+OQYpnq6tCoCFhx5Jw7Kkip5BHjPqNtzrVsswq
         W46mZmsHjmAs3/U45V5IiW045/gHIsxJjb0MNao+K6vIwFywz+kXzPdr1f0DkB2W7zKz
         bAx67jTYfTfUc2/7qWND9Wb3zv4NFJp72Ifb4hkDeKr/aQDqODtq5Ksrb8JbVjrDZfZK
         pAHe23JPa7xhRqG1SV5nw9Mn8jYyrY21pjY3fI2Pu6c9zI7EHtJz/XHeQdSa98Fi45TW
         WDZJlJDzrNE8azY5rxqHpw6sHUk83cwF7V4KX0yNtx/E6jEre+SF5ty3/0sRrhfucc0D
         d2Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PQHXcCdxoxsS7ejousgAUdoPQ2UFDoYPmcf+Vpaig8k=;
        fh=NirIwi2u+0aoZyBJ+HdYLicMn2dPWEvdtpytMWnuGFE=;
        b=XO3F5HyiZiJ+PD8h3wlC5Dwpjuq0h05ZZTPUEYaP1mP5X6io8iJBaFdyATc0Kh24Qz
         rXAtlHbYrpWLljevuSPz3Q+zs0Z7eKOapXLe27Pic3lEwE8LOWP+5wkfP4EY4+IVjtx7
         GcmrDv/JipRoGFE4tm1brVlUAfuoNNWcn7/3S74wiAJc1hAGxil0WF0f0+nJQqlhHHn1
         jukpm9oUb+YRaZPrAihGGZ1SlVhhvIUMxzOnDGfr7nl4VUwnTUlRWdFJXdmHPSNtCIg/
         Y9KTw5Ciq1MyOoMHLTb5nNwj5IUGp5mNdNtMjm54QZGGLmoB+mHHBDXmZyHijG4KByNM
         REsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793816770; x=1794421570; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PQHXcCdxoxsS7ejousgAUdoPQ2UFDoYPmcf+Vpaig8k=;
        b=mY3Vf4ZBEFuIl7HWMeyNe9k9725zdUPoXU9vUBRckXHBUsm0hmUgQY+Lk+R1wZ9288
         aNRvgFBjAorxdOVZcaeMtYqDMYN1G4/jRuo0BnsA4+zRYi4wdC17LKvkk62u2XYEbbl3
         wkp+47rWSAhSdarieYimwZvjO/ozqXs+WoMundy5mDQLvVl5TzTNm7XdKL2m/S+oTHV9
         x18ZKKW41fEphu9xN4S66GgSZI7NmvP5hRT1nxHzq6xzIkws/f3Akk65CBVrgK/qJ+/r
         wuRuylSI1jcy7AtJ8a/QCmAFgrXkSiJ/f6coKBOJGk8jtuTT3eDG4vMOGW/+mDuwFTqr
         2+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793816770; x=1794421570;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PQHXcCdxoxsS7ejousgAUdoPQ2UFDoYPmcf+Vpaig8k=;
        b=kyi8ftW6TqTWmd2m2W6xd1in3Nh9zhbQGuBASDwgfQCJcx997yFRoX3vdIYmdleR6y
         wNoX81bSvF2PLKGBUTL+TuPWbBVyO6QVJNcz3cgS6XVOIV2tOG1iE2LoxlpyjsMliE63
         eOr09Q8BTNAr5PX22QUza5zSV8t1jEaCqU6VjM30e3STw6wGBJFqLluhzMc0cWvzYd80
         xX6QDO8/zd7owBt4XcWVa8QAV5QH1IYNf36SZrIie2PhQJA18oh4PK5/RemR2f75HzbF
         yOFI6xnoyUOH66Q/82TBFsMsomuJDvgcjh2OSszbNgNudALOuRDbRZo0gp6V+5u0ut/O
         ndxA==
X-Forwarded-Encrypted: i=1; AKwUvBwvys/DZua1hkryFFvWfBpTprruQ10tY89rS35T/CQTODE3b/Pnk1N51Xwr8yKE/Y531QIzFxA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9lJCTjXT3Zv1OhMOA+lUlTPeVL386Qdsud8IpeW87q/ZmdO+lq
	Ji88JDCDW56C36GZvrOXpyiH2LXbkhY02UQYAlljP04bsCgd36irRa6G06dSjMMv3XzuRxupsbf
	2VtKJvAuqEQ5J47JS7Rc0PCWF2z5ftd80HXy53KKy
X-Gm-Gg: AYBFou32u4D4Goybo9KEu0sTeEkaEigBY1COUQRgKGL7uCfPj/zhJ015WKWXw7qH8B8
	sosOd/yV4VGmEMaS2H10JyZG2vuBw6myHLWU+Yqcmem1Wv/LOxC3f5i4ndrJ0Vcq4hhfLACanqz
	REEqzqRU7lGpkayY/Lmz7VefyTIflDQbWUjL/p/+C9gj1onou/iXF0qOHZ0aNFwVMTEn7Q/DbI5
	vWCDl1vo/NQ83rBYPhAeLVS2aRBPmY7cnjC4/bpDm6zs+BKB5/1pnLLvwNrkcKVfphdxBJ8+cJk
	isFSZQbLLP3hE6As2unzJca9mFI1F3wyxGBKnJETsNt/NsKXEwJCafryI6grqQYqTE2fdkbMDcY
	DxG+Nhfpd8HKzpplWinx4GoPjBBka9WqmbjeEUTil+4ZnySYDDDvyxgDG8pNzPa3OAyph
X-Received: by 2002:a05:600d:644e:10b0:4aa:7270:60f with SMTP id
 5b1f17b1804b1-4b5725fbbd9mr35195e9.1.1793816770096; Wed, 04 Nov 2026 10:26:10
 -0800 (PST)
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
From: Naman Gulati <namangulati@google.com>
Date: Wed, 4 Nov 2026 10:25:57 -0800
X-Gm-Features: AclHuK9GcHIiEVJFWtyFyOBv4rznsmUVRwzqpj0sIUIFzIVv7vRLKxuZzlDM1ZQ
Message-ID: <CAMP57yW=wuNY4c2C_HC5zPvdsWsj0fQ28wmLOHeb+g4NVDo0Fw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/2] tcp: Don't call tcp_update_recv_tstamps()
 if not needed.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Geliang Tang <geliang@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 9:14=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> When RX HWtstamp is enabled on NIC, skb_hwtstamps(skb)->hwtstamp
> is set, which sets TCP_SKB_CB(skb)->has_rxtstamp to true.
>
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

Small suggestion for safety: SOCK_RCVTSTAMP/SOCK_RCVTSTAMP_ANY are set
by SO_TIMESTAMP{ING} sockopts. Datagram/raw sockets also support
ioctl(SIOCGSTAMP{NS}) which don't return the RX timestamp over cmsg
but trigger updates to sk->sk_stamp, future improper reuse of this
function may miss those paths. Maybe rename to something like
sk_want_cmsg_rx_tstamp (or add a comment describing the scope of this
check).

> +static inline bool sk_want_rx_tstamps(const struct sock *sk)
> +{
> +       return READ_ONCE(sk->sk_flags) &
> +               ((1UL << SOCK_RCVTSTAMP) |
> +                (1UL << SOCK_TIMESTAMPING_ANY));
> +}
> +
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
>
