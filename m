Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793982051;
	b=5CZ37QJK0W2SK3yL+s6osplbQG3XMvYEqC3FiqdZqSlhVfgvxLQzNFskdPhKrVl/FoQJ
	 lP7TAv6c2bxxT7ZAUfkLE/TOTJFVE/7IN9kRTUErqVhQGkg8PBi7ZMQuT0j4UgDlSpefX
	 vZXv/96ututNfwhz+0K4GNc5rOaQax/X/eYdDulapk/NmVVqMbbEwcpO0wXrfBEd2uACM
	 oAJ0mnIxmhSjSoctFzuamEkC09voX3azaDtpatqaXpTL/1syuC407puFNXpPGfLV5C6rm
	 4ZwSh/ktC+brFW+QQ6ThQ+C3+ziOOT88WoHOyQIeT3rf1N3+1/45xR8s8qm84nqC4wg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982051;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FOMXNC8nD2xemKf6gqby6O9Pz76l+PDCgCO/ntvf+XI=;
	b=HGL/B+OjC1599G1noGj387u1mPpwA3GrD/9XEzxL7TAFVuSKf9DsT1iyw87AqJYgC2uL
	 1DCMk9Wj8ICl5yNFtN+K5LVhw5/KGiAJGUKjjNNBsB950C6FIiromKi/ZdiCaDMBEIQmn
	 B3tuF4jqSN3gEwOff4R1RQR3lhM5mwdRbUcycLZeSxBPC0Pp8NMg+ZCOvScEMKo4R0gqh
	 jKuD52rHdbDRskmUIF5Pf3m09uG+oxNxAGgtivZAfghnBc6GisK1PTxI/gzJSV+AAZXW0
	 n4tcmOV4U6NHQqOxVzOgRbEqpwqI4Nk5VKn/l+l+VLdJjm/kHt3bVqTzL465FtdB3HA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GUl8lkLb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F769606D808
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 16:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F769606D808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GUl8lkLb
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a089dfee18so1122074b3a.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 08:20:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793982051; cv=none;
        d=google.com; s=arc-20260327;
        b=HqWWsnefyts9krgZmUVQVxnLP1hZBAS2WWdRVSp3RBWRLcSOYI4FrN+1pcq2JdtGke
         1zRF5q1gG9TBxdMPyyolVuImsak4kkqAC/yHXLQiNkHj1oTKtbxvcF8Xmnt/Qvomr+NE
         qN8mNCZiQQZ1J/GdWca7ffQJKfsU0bTBe5m+31hrhDNoShJzf2J3hWw4POoIT4xOTVnN
         oHvdFCk3PeAZih14TsTl5w3wf132kY+YUhb1Uy7Dp27CtQD8C2/Y9y1bAGrNJZLOGvP0
         ZhB/JSFfHSv9gDGJvh8u0/HaMYZA+NPnodHwlQwFjLs0Kc5GFI8iJGc8LJi4J3bMNkYB
         LJmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FOMXNC8nD2xemKf6gqby6O9Pz76l+PDCgCO/ntvf+XI=;
        fh=co/tpFjdRrRHf56RrKg5VONlPtqjfpG2Kj5rLCaZp+o=;
        b=N4XXP5CDWOD7irJ61ElfP4HY8e5gG3JmBDdLkWsuHWFUpw1nZz8IoIs4Jf5svmo78o
         WDGmu/85AgUIXx29dGDPx5JT41R9HKcIUg2Kf4OfnV3Zfy7OLJGxNxSN9F0GcdHtEi6a
         ugQiSVrte3qAci973MEH6U+/ewiUousiBdtLiiexdPTzgQWGUqG6JcRWA2StaDyaHkTy
         rfnPDRzD+ZDix7RJr/Ks5uxuoqoAzzOI848OS7z2gan17pTRPTxBZa0pisxYAWdIVL5e
         jqrQMdReZzl+7ciYPwTsNFBsx3jOTZtFM8sgRQFTcPXZfz8RN7vCU8jUCvBEei8nPrfq
         juMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793982051; x=1794586851; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FOMXNC8nD2xemKf6gqby6O9Pz76l+PDCgCO/ntvf+XI=;
        b=GUl8lkLb9T+Pzb6MJ5gKOvfhdiPR1h6u7MFhhijOYQa6vFZ6s0fsM2d+8RM7szLX2r
         0x4646A3e5ANNqMVuQzxEUTniFemQg/ocKuw2XIqXfnxgaIjEuhIvVtzcIhL+LDQrFWU
         EWxUKI1gqiWDdlUfCOEYo3iFwzv/ixM8ZkBFYlNRT9OU9EuBt1Vt5ZD7fXGd8WDt6neh
         AqaBwkbzurgr9pn2UACr+JYfqnp2MUEJo9rttrLpXrZqKwKKsi4EC/lXQMYNV/Xci99W
         8VW+9/QPlccNLgltM/dCTp0G3LKn6oOhukd2POX2WhyNKM33VGgEgKSyML0SstgqVgd/
         zIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793982051; x=1794586851;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FOMXNC8nD2xemKf6gqby6O9Pz76l+PDCgCO/ntvf+XI=;
        b=AggD6VDkKYG0BnMDrCyBoYG344fC8PjBLR2rvnK3eZXQ3PlRMBvxkWrpKGoTJOUhD1
         H34RRVuJ4z1gHOgIJuFdDW5zV16qTrxZ73oApCxhje6mzVOH/mbR2os01uhnjRLtr+EY
         P7CHOULJCm0Tfa24czQl6+/9TxQGFkueXs6VxN6e8iDiBYb/YsG53iUivtFkej8Ayg4A
         6c8J9bi/0WiHjj/fBUUCwgXYtAr+Pi4rqC8iZ8jrmJjmRWVbP2lj6X2sEMKAyGZ1xjVx
         thjVetLTMcFPZeIGrjriM+vQT0hIdOZIWR9+/BjHaufO8QPAJK6lcAb+rJsO50GrciNa
         6mvA==
X-Forwarded-Encrypted: i=1; AKwUvByTyqqbiKHs7xBdYTsX2/HYuMFAdkztSOc/k6JQD2oZu/kL2bE6XB12JkHakzrdkw2oM/ZkJcg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JaXYt885KB85NrhSFjfqxxp5LoaH9nxoV+RZNJpZyJqh2Hva3
	jaFJaO8WqJMuzfz3YqvzFxiTujM9oNEG1wkJKBs6Pks9XGu0HcRfTaL/aDY5aZEoExnfDPBySiv
	xQ87Zc8w3c25us9GNl4dXV/cVkIKZB98=
X-Gm-Gg: AYBFou2kR8bMqqD6O7gH89W1dqLixRMG2pX0oZzpqxiNltHfCjR0HKKDM739a6bFDXv
	eDFIJ0/0iStlxrH7gCVhK+5JE7GUevmCvz0gZg1waCqCiqZWbluSUbmbZ572zwztsvkJSVfEG3H
	epErvFCDvT91vH2oovEr1EUadgEj7YrVT3PhEbOmfxI2+VuvnqR2xNUsTpymnMGcXlzB06N+L2R
	MA96VH4QCFNhvXUZJg9HDYjzJgLRlmk92Oy+KFz8euD6PV5chCHUpuB89OP07Y6JP91y+AJHEhM
	Rp3qMkW43Awm5b+xX9fo0Pa5Wzc8XV49RYcVq2LLnkHwOhfJs+6TVfF28n8QbxR9joWaR9PRDQb
	61jBw5qETDVuYitwqku5iGTRu8QnxpbuyVQfCSmwoWZ77hlkthB7UB1rk5LYqlcdlRn55NiLCPe
	6gqn8U8boPfYxVKdPC87JtljFcozee0DTSFqc=
X-Received: by 2002:a05:6a00:9298:b0:898:a77f:2833 with SMTP id
 d2e1a72fcca58-8b37bc5f939mr2052745b3a.21.1793982050713; Fri, 06 Nov 2026
 08:20:50 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106091938.112942-1-18983559317@163.com>
In-Reply-To: <20261106091938.112942-1-18983559317@163.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 6 Nov 2026 11:20:38 -0500
X-Gm-Features: AclHuK-yIHMUp58UeoDDDdnzrU0Ccta1sECn_2m1xLJeYcw_aDI-1ekYnwksz88
Message-ID: <CADvbK_c2A18x7H6jgFqdQjFO8h7OS=WFYCtoFN715LJXLtmB6g@mail.gmail.com>
Subject: Re: [PATCH v1] sctp: fix race between addr_wq timer handler and
 backlog draining
To: Binbin Deng <18983559317@163.com>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 4:20=E2=80=AFAM Binbin Deng <18983559317@163.com> wr=
ote:
>
> sctp_addr_wq_timeout_handler() walks net->sctp.auto_asconf_splist and,
> holding only bh_lock_sock(), calls sctp_asconf_mgmt() on every
> auto-asconf socket. Unlike every other asynchronous SCTP entry point
> (sctp_rcv() queuing packets to the backlog, and the timer handlers in
> sctp_sm_side_effect()), it does not check sock_owned_by_user() to defer
> its work while a user context owns the socket.
>
> While a user thread owns the socket (e.g. recvmsg() blocked in a copy
> to user, or release_sock() draining the backlog), sk_lock.owned is set
> but the socket spinlock has been dropped, so bh_lock_sock() succeeds
> and the timer enters
>
>     sctp_asconf_mgmt() -> sctp_send_asconf_add/del_ip() -> sctp_do_sm()
>
> concurrently with the backlog drain path
>
>     release_sock() -> __release_sock() -> sk_backlog_rcv()
>       -> sctp_assoc_bh_rcv() -> sctp_do_sm()
>
> Two state machines then run on the same association with no common
> serialization and mutate shared state concurrently: the outqueue
> control chunk list, transport->packet.chunk_list and packet->auth, and
> the transport/dst lifetime.
>
> The bug was found by code review of this timer entry point against the
> sock_owned_by_user() avoidance used by all other SCTP asynchronous
> entries, and confirmed with a reproducer that races an RTM_DELADDR
> address event against a user-owned auto-asconf socket. It triggers the
> following, observed with KASAN and refcount debugging:
>
>   - rcuref "imbalanced put()" from dst_release() in
>     sctp_transport_route() racing the timer's transport routing,
>   - a GPF in sctp_packet_transmit() dereferencing a chunk pointer
>     corrupted by concurrent packet/chunk list use, and
>   - associations dying silently (ETIMEDOUT, GET_PEER_ADDRS failure).
>
> Defer the work like the other entries do: if the socket is owned by
> the user, drop both locks, leave the addr_waitq entry queued and
> re-arm addr_wq_timer to retry after SCTP_ADDRESS_TICK_DELAY. Sockets
> processed earlier for the same address event will see a duplicate
> ASCONF on retry; the peer reports that in an ASCONF-ACK error
> indication, which the association tolerates.
>
> Fixes: 9f7d653b67ae ("sctp: Add Auto-ASCONF support (core).")
> Signed-off-by: Binbin Deng <18983559317@163.com>
> ---
>  net/sctp/protocol.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
> index 27c26e12f95d..7528a40a87f5 100644
> --- a/net/sctp/protocol.c
> +++ b/net/sctp/protocol.c
> @@ -645,6 +645,14 @@ static void sctp_addr_wq_timeout_handler(struct time=
r_list *t)
>                         if (!sctp_is_ep_boundall(sk))
>                                 continue;
>                         bh_lock_sock(sk);
> +                       if (sock_owned_by_user(sk)) {
> +                               bh_unlock_sock(sk);
> +                               spin_unlock_bh(&net->sctp.addr_wq_lock);
> +                               /* Try again later. */
> +                               mod_timer(&net->sctp.addr_wq_timer,
> +                                       jiffies + msecs_to_jiffies(SCTP_A=
DDRESS_TICK_DELAY));
> +                               return;
> +                       }

Can you merge these two mod_timer(), and move it out of the loops? like:

...
+
+       if (retry)
+               mod_timer(&net->sctp.addr_wq_timer,
+                         jiffies + msecs_to_jiffies(SCTP_ADDRESS_TICK_DELA=
Y));
+
        spin_unlock_bh(&net->sctp.addr_wq_lock);

Thanks.
