Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793818978;
	b=W7unyYpQAV+w1BMqboNVpXnVlt3b4GACB9IdOPioF8TolGPvpJGsoe0QM/kKQVG8j+0d
	 +1+4Cca3gI1Ysp4kfm82D3YvHBs3CR2yDTSv5HTTXozpDHBY7Mm/e4+KfRV4ozry1PQLk
	 LeeGmqXO+c3zVCvds/Q5GJ7Z5w5QLs8QcYb0imY5Qdv8VhKSjzrwpxaOa5Uz5M5IujdAl
	 b+99c5ayDoFzeC2RSpbqKJE+IS21ja3IDiNeDwdtDF7O9PbV3MP/G3F9bf+ksB6lS5sGS
	 hQK6+7mX8k/7I4+8qk/02AlHJcl+2hk5B++fzEfqDUks+604t++j01P2cWgzJQJG0zw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=S/pdIBPYTPZcnYbnsLUgD5MXebWF0gTDUjC4Avi7leQ=;
	b=L8NIVDP3nGKCtEh/KsQVOLPeQtVO+sXBcLJxbMn0TdPyIf6fm7IA0xhpukPbJHxmgo+z
	 px4V5pQLbyyh5PJn0Fa9RnZXm9EwJX6pytjRyLI9n+Zu7bTMekDA52yZ/yPw1o2bsVaEh
	 A5Y7wsAkXmLP+VDuUxDF7NBVwljspoy1gSTZJ62CuNR+xGJB7ocYekg0pvYsE6qc1vXld
	 vCExb6yVg0Xmhovh8IKlK1i+d/kQmGazIKf5h2ZitWfcgdqGxhM0vIh5pmoEPiTOu7Av3
	 wErcWzhiwPa3UATvoJ2VhswE+HJQE3FYZXHIy2nZhIhlGBl92Q/b2z1Q6vscFKKDLLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DphVAvnt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B7B606A334
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 19:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94B7B606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DphVAvnt
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6afa651700eso177371a12.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 11:02:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793818976; cv=none;
        d=google.com; s=arc-20260327;
        b=S+F23q8+d3mKjWBEmXQ7ed5+ottp46/lWmcVz43Kb4gr/SCNz8OF6vWGGBPFouNa+0
         B3NctTXfEIO3YwYz7TXDP8R/a95SxY6lr+ftM4sLUqSUJXw6DXxhJ51buPWuEPgydiNq
         hNC9MBrONcBijTD3gbMuTnBOAMIprmskDzD4EbWm1/V4NqrZ4XRk9vrBgWHx2lb6ow3A
         QDEQOo5YwxfHsg/uJEVtPf8SzF1uaf0Cd6GbKP0VTaPZ3hJfoOgnp+vBHAeZgrDeVUbF
         fgQEKC1eAf57oxe6t5I8B4t+UPKk4GqHWyCW/yD3mlt0S/8aDo91O/uXCljp0qLN/Srk
         JodQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S/pdIBPYTPZcnYbnsLUgD5MXebWF0gTDUjC4Avi7leQ=;
        fh=HpxvHzZt0RrAos3H+/y73stWPdFsXlIFUt+32SOvIPk=;
        b=WlzBbDMKG9sW/GBF+BHxL9Yssb/QFjYchng5z7GYGVVbuc1ykCJ/OqIfBj9nfouwim
         s7MzrWantkXLIDQQ2RsAF0pkfwu/xQZh8nK7iFuXCSKuz+c1Rw1N6C+IPgXiiUmIS2FP
         CrzLo7V3R2ncHHMrDqewLJy/SwoODpbmA4tIiGv/dyPjSzF+3QhvKidJFejiblDaYTh5
         XEBF+2ME9pUCwqR1+PEwXIDjkoclT9DCsRO8OlMPLEAI7Uq+45yCtGnSrpygSuXIbFwn
         A7kd6u1YjkEAWU+V1WkmThlfhUvpZdfykX6h5sV7n46xTG6+4wWHAKuZOTfIBDXE4lNL
         gg5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793818976; x=1794423776; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S/pdIBPYTPZcnYbnsLUgD5MXebWF0gTDUjC4Avi7leQ=;
        b=DphVAvntyXwYYIMBdnONtdTl4a8Rjqfz8s5gT4utYwHj4PW/afKV3IxdoXqIrJtTwr
         OV/pX7neR/ApjZQL5JHQqDi+SkmP6eLTQG0onn4/FsboRgMLX0G9yElGQVyP/+QuhAjB
         x9cGs/Huu1iz9M4divogbhXNEtii4JTh1UH6Gg5LTD7Ht6wnkaMfMSHGkf/NP63uw4nf
         az8m0qNiy7Asnjt3ZP8bUiewNQWCaOlbqNMU13imt8ElnJYXQC05ZIBUgsQUGEeBnKhd
         GHopTNqs8adAkmVSt33Mi4GbTb7KVWWg3697ynyGsgNHBoQHkYN3H2CIoMf2H5NtnilG
         CCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793818976; x=1794423776;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S/pdIBPYTPZcnYbnsLUgD5MXebWF0gTDUjC4Avi7leQ=;
        b=euTLM/XG7NDSdXNQBTyYanrsvGH/NStFajJRfkEUxb3Doq+AmNeAXupUulfYsJ83eS
         SS4CHe0dAwQZ9/HACB6iKr2ZzFFsHBDtvRcUoLvEIKK+/sFIZ0npurjTCZdHgkXqPxdS
         Sh+gD8AtdxpliFWpH7wwx21uEBazCmFec9QDtkUGnDBL35E15Z1M0xVMPqfP/5M8FAp/
         fI1HyOcv+44tBepMeMmgE3Kp+7q+XIzmIQMz8I4XLpLkKLceyuN471lQK6KZ/83iWpHl
         EYOZaeDoIU0r87eIKWIE53KrOTQ9vH3745ndCIKqyj2/t36gLnAu9CejpEhW7PhgRcLm
         IbEw==
X-Forwarded-Encrypted: i=1; AKwUvBx9r+4PajS+rbmWglJp7W9G0LcBCUQhRq6PeGK8UKE3jwQf2FXrcRUsa7dOU03SyejasCeObRs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/eG7cHv/diuNbxCE44vKwI+PGpB+aKaIh64phL3Eu1JO7pYZGb
	PTGVIvF0114B/D28T+S2g3k/uBxp1emQEJOd2dBKzAcT/ImpwIZo7H6FNno1c6EB4x3xf3yoinO
	xWxDWYFB2VWfRZMUAbcY5IfOCGSc4fESluiHiRBS8
X-Gm-Gg: AYBFou3zy7opTjN1drmTVUapQRMvlX6voGRZMpAXy/XRnNPXo5eJcXez9STEMQNlg0c
	4KOh3+NNlKD3DewJOaBe/V3NrqC4AixmsDN5JhCmit0FERBVc7yb+W/BWPynIDcImCzXc8WKlOj
	kQiNHbhoxIBsk4wRdtFW2ydsBFMARoV0tr+mw7SnLtwBJjYpkHlqd1cW9LgBaVKCjcQlF/q5gbB
	EjQM8mOZ7h7/vD41lFAhkS42qwWaWXe//bpUZ5U8MnXTlVw3OcDjIED/lKMqAKHXirF35b8Wj7z
	chie21XYXxKLtxiOAbUD2YeDy93uNetWEYx0xL5hUR5dcA6Gh4sOnhOB1BIlPfttRCT/LaKgEs9
	hOwSN5VfbNa0SMiY7TC+vr017XfZfC7cjwqzm6tcSAEMaveqCmBorW2YzmEXjAaZNAvAheaTlvO
	mkycFFd9JYoJywWe6AdZLgDbRimCkP1gzgEVzKR8V/88WfV/sdSgev1/Ow5XhT3onnxfSnYH8Rh
	CtqSN/CdQ==
X-Received: by 2002:a05:6402:2042:b0:6b1:82e4:b2df with SMTP id
 4fb4d7f45d1cf-6b4d4d6f5demr8859553a12.29.1793818975469; Wed, 04 Nov 2026
 11:02:55 -0800 (PST)
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
 <CAL4Wiiqo6phhCB3v0+NtP0mBbbt1WP3XQ8p9qi=bAVSsQ7_ZKQ@mail.gmail.com>
In-Reply-To: <CAL4Wiiqo6phhCB3v0+NtP0mBbbt1WP3XQ8p9qi=bAVSsQ7_ZKQ@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 4 Nov 2026 11:02:41 -0800
X-Gm-Features: AclHuK-9c-17gaZWuHiLFF0ehLCDRFgwN1uCAhV9DjP2hVzuC1TUhlmFcnVTvC4
Message-ID: <CAAVpQUBd16SJ1wU4075HSw9w3dz3jtwQ5M6dD56OHVtEeSPgxQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/2] tcp: Don't call tcp_update_recv_tstamps()
 if not needed.
To: Eric Dumazet <edumazet@kernel.org>
Cc: Neal Cardwell <ncardwell@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliang@kernel.org>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 10:41=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> =
wrote:
>
> Le mer. 4 nov. 2026 =C3=A0 17:50, Kuniyuki Iwashima <kuniyu@google.com> a=
 =C3=A9crit :
> >
> > When RX HWtstamp is enabled on NIC, skb_hwtstamps(skb)->hwtstamp
> > is set, which sets TCP_SKB_CB(skb)->has_rxtstamp to true.
> >
>
> Note that has_rxtstamp is also set when skb->tstamp is not zero,
> which is the case for all incoming packets as soon as one socket
> on the host enabled software RX timestamps (netstamp_needed_key),
> think tcpdump or a PTP daemon.
>
> So this patch helps more hosts than the changelog suggests,
> so it might be worth mentioning it.

Indeed, will meioned the case.

>
>
> > Then, tcp_recvmsg_locked() always calls tcp_update_recv_tstamps()
> > and sets TCP_CMSG_TS to cmsg_flags so that later tcp_recvmsg()
> > calls tcp_recv_timestamp() after release_sock().
> >
> > If a socket does not have SOCK_RCVTSTAMP in sk->sk_flags or any
> > flags set in sk->sk_tsflags, tcp_recv_timestamp() does nothing.
> >
> > However, it is not free because sk->sk_tsflags shares the same
> > cacheline with sk->sk_forward_alloc, which is always modified
> > under lock_sock()/bh_lock_sock(), causing cacheline bouncing.
> >
> >    0.31 =E2=94=82 403:   test   %al,%al
> >    0.02 =E2=94=82      =E2=86=93 je     4a0
> >   12.40 =E2=94=82        test   $0x2,%bpl        ; if (cmsg_flags & TCP=
_CMSG_TS)
> >         =E2=94=82      =E2=86=93 je     48f
> >   11.59 =E2=94=82        mov    0x60(%r14),%r15  ; sock_flag(sk, SOCK_T=
STAMP_NEW)
> >   12.25 =E2=94=82        mov    0x170(%r14),%ebx ; READ_ONCE(sk->sk_tsf=
lags)
> >   20.70 =E2=94=82        mov    0xd0(%rsp),%rdi  ; if (tss->ts[0]) {
> >    0.39 =E2=94=82        test   %rdi,%rdi
> >         =E2=94=82      =E2=86=93 je     44c
> >
> > Also, sk->sk_flags is on the cold cacheline in tcp_recvmsg().
> >
> > Commit f0e70409b7eb ("net: avoid unconditionally touching
> > sk_tsflags on RX") introduced SOCK_TIMESTAMPING_ANY to avoid
> > such false sharing.
> >
> > Let's check SOCK_RCVTSTAMP and SOCK_TIMESTAMPING_ANY under
> > lock_sock().
> >
> > We still need to touch sk->sk_flags, but with this change,
> > tcp_rr -T 128 -F 10000 gains ~3% more throughput on AMD EPYC
> > 7B12 Zen 2 Rome (2 sockets, 256 vCPUs).
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  include/net/sock.h |  7 +++++++
> >  net/ipv4/tcp.c     | 12 +++++++++---
> >  2 files changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 173b37b2b8bb..ba310182e6cc 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -1063,6 +1063,13 @@ static inline bool sock_flag(const struct sock *=
sk, enum sock_flags flag)
> >         return test_bit(flag, &sk->sk_flags);
> >  }
> >
> > +static inline bool sk_want_rx_tstamps(const struct sock *sk)
> > +{
> > +       return READ_ONCE(sk->sk_flags) &
> > +               ((1UL << SOCK_RCVTSTAMP) |
> > +                (1UL << SOCK_TIMESTAMPING_ANY));
> > +}
> > +
>
>
> I agree with Naman, this name is too generic for sock.h.
>
> This only mirrors the conditions used in tcp_recv_timestamp()
> to decide if a cmsg is needed, and is only used by TCP and MPTCP.
>
> What about moving it to include/net/tcp.h, with a name like
> tcp_want_rx_tstamp_cmsg() ?

Sounds good.

>
> > +static bool tcp_want_rx_tstamps(struct sock *sk, struct sk_buff *skb)
>
> Otherwise the logic looks good to me.
>
> Thanks.
>
> >  #ifdef CONFIG_NET
> >  DECLARE_STATIC_KEY_FALSE(memalloc_socks_key);
> >  static inline int sk_memalloc_socks(void)
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index b9de7c302ba8..4166be09b826 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -1878,6 +1878,12 @@ void tcp_set_rcvbuf(struct sock *sk, int val)
> >         tcp_set_window_clamp(sk, tcp_win_from_space(sk, val));
> >  }
> >
> > +static bool tcp_want_rx_tstamps(struct sock *sk, struct sk_buff *skb)
>
> nit: const struct sock *sk, const struct sk_buff *skb

Will add const.

Thank you both !

>
> > +{
> > +       return TCP_SKB_CB(skb)->has_rxtstamp &&
> > +               sk_want_rx_tstamps(sk);
> > +}
> > +
> >  #ifdef CONFIG_MMU
> >  static const struct vm_operations_struct tcp_vm_ops =3D {
> >  };
> > @@ -2069,7 +2075,7 @@ static int tcp_zc_handle_leftover(struct tcp_zero=
copy_receive *zc,
> >                 offset =3D *seq - TCP_SKB_CB(skb)->seq;
> >         } else {
> >                 skb =3D tcp_recv_skb(sk, *seq, &offset);
> > -               if (TCP_SKB_CB(skb)->has_rxtstamp) {
> > +               if (tcp_want_rx_tstamps(sk, skb)) {
> >                         tcp_update_recv_tstamps(skb, tss);
> >                         zc->msg_flags |=3D TCP_CMSG_TS;
> >                 }
> > @@ -2280,7 +2286,7 @@ static int tcp_zerocopy_receive(struct sock *sk,
> >                         if (!skb_frags_readable(skb))
> >                                 break;
> >
> > -                       if (TCP_SKB_CB(skb)->has_rxtstamp) {
> > +                       if (tcp_want_rx_tstamps(sk, skb)) {
> >                                 tcp_update_recv_tstamps(skb, tss);
> >                                 zc->msg_flags |=3D TCP_CMSG_TS;
> >                         }
> > @@ -2893,7 +2899,7 @@ static int tcp_recvmsg_locked(struct sock *sk, st=
ruct msghdr *msg, size_t len,
> >                         tcp_fast_path_check(sk);
> >                 }
> >
> > -               if (TCP_SKB_CB(skb)->has_rxtstamp) {
> > +               if (tcp_want_rx_tstamps(sk, skb)) {
> >                         tcp_update_recv_tstamps(skb, tss);
> >                         *cmsg_flags |=3D TCP_CMSG_TS;
> >                 }
> > --
> > 2.56.0.385.gac671c819a-goog
> >
