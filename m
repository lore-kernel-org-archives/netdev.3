Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793820013;
	b=XxMYZO+PO8A5wcqLaTDN4IGKtp3n3DV/33vKwW6qg6FFRu1iRyopWx9eauTehi09JRju
	 XCz7XNC8VyEEYqjDImK4OUraEfaBFlLXlIKDkMn8IuPnXuUjJlgGZ24CNnQZflLA12Yih
	 dCpQ0x+VMFJA7tjDQolg9+nB5TMPLkVDQcoWaKFylgVlvyCw4DDQX09fGOdTyYqKxo3Cb
	 iRSNJ2ciPK0JszVSUhWgQKUqzqBQnpZX2d8XgLKAhHMD4yOeWYb2av3+DEv/m6n1IQc49
	 jg6KiMvL17hMTDanQnQ6E1pUxVaoQBJFUHhxtXPXdh7ZvOtzwWKWROCAvMrFEyu6b1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820013;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3pchkY95SlYVMfXzEW7d1/IDKmFrvcEI7YIYQHnUSg4=;
	b=tQDNWi+UtWcppUpkzAnUCXgRN554/eRA8kQAAjwWxnc8ildoygvsWoxJXKFrr/TlMGmW
	 bDBahjKcdfB9NrRjbA3ZDgNsDSC/l1cQknrd4j0dqz1LFOXQ3ktywG26M6ehIW7Wa/Nxt
	 4/2Xufa9HUZRGGbyxbZlxmy6vGmuRoVAeojYhntajXcxQP0SzvpIcspyjNyC2GBVRQLy/
	 tHpCfhR9Rh/eOoPDsuWTZkH5LKrkwUdCy3n2fMqjnptpDY+ZWKV+yojvXUYkb0b2aX3g2
	 ELWydX2mPZaD1QfZYK1KrQsIiPCSrZYG02xk6xRv/7NIMiWipWLnleXAukEvHZ9SrNg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kgh5CBpU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2A460A5BDF
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 19:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C2A460A5BDF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kgh5CBpU
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-716c0217635so814368eaf.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 11:20:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793820007; cv=none;
        d=google.com; s=arc-20260327;
        b=lCXWH2Nm9HcWs3Cb/6sndla09wb9wFqxUFhxN2vj+qB4Z4HZXp250DMyp9MN6sdz+2
         S+yorZiUnjE46DFUWAzEUXakvOx3Hj57UDGw5fnL/h8zZ6bY2MzTjpOAHyeMwtQZhqcc
         RQ1pVfXH1G/Ze3/h5D6LAz79Z3EOUsKuaN8QWmugFvk6sRYmSFZCFaApSu6Szp0KLsNy
         J1LJd+SQfMnE0vqwNaYHzbfXtTPsG2OIWwgNIpKlzwWTqV/Id+3uEq24m5743cyT9DpV
         tBESDr45Bi1RNyGCX5qEcxvvCMlby35uKc/ZaoUNJrloARpjmMI9M3N9Lc5FdbDTQ8ha
         33jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3pchkY95SlYVMfXzEW7d1/IDKmFrvcEI7YIYQHnUSg4=;
        fh=GQEbwKHfq7tDwfewrfYudt9zaqlWpsekaRf5s3L7eXY=;
        b=ZnEOTaSte+EO2yRUDHF24t5DXoCnlBSyt2+/FkFjMWtUt9XSThFvi3tQIr/xQQ3dSd
         R+8klEZhHbNOTDBpHgkPGaDHu3y20B2LVDhQxzO7+S+nsGawUAAdrsLggyqp/chuFWyY
         3WwqRb6HOUY0SASmQvEnWt3ocJkaShSVzWFw+xVa6E6wN4NifdtzrWQYK4mRJqF0fw2J
         ksJnufvkDK53275HBNQTpjkEc0d40y7rXVVAbtUT30o/A/LSvofUXyk7cHlN6C9GtBfX
         hsHb0gkad9IS1I+nclnB+hUVyAxLOzLESiwa5CJJ4uSYtbaIWV7yvOOswwvJ3+h5kUp9
         Y/vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793820007; x=1794424807; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3pchkY95SlYVMfXzEW7d1/IDKmFrvcEI7YIYQHnUSg4=;
        b=kgh5CBpUCbeg25Kx0eJ4+ldfnPlPvQVd9i6/p/3oEe6WuYQu8JySwggJCB1BuiKlNh
         BVWjdcQvCskG0oFFHuy1rJN/ZD+mDg9irkjJ8EF1dfoQPk+FhsAE1PlItaadBjPmGfVp
         KCN7kAMdsqLuk+ndYVnvaTbM2Q3XgEQ3HhdEYSs7bpwgU6fk9ptElcjH6bfTG7HqYB8/
         VJMILPaGdvAH5MIF4ZjR378gn0p+8YDLH8XFgXpQdSjtiHPWj7a5c2DuFc3nK3tKqv/+
         hAED4unduDBzG5FDXENKuAxPpI0f7DXP7DdL1lrLyHb2+UM7PAE4XlnddFb0SiMnwwN3
         /7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793820007; x=1794424807;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3pchkY95SlYVMfXzEW7d1/IDKmFrvcEI7YIYQHnUSg4=;
        b=kH+iqROg1T2ElPJQ6HOlHylr22hXc+TI2e6VMV4ey1EmthKDj5vLeDMqRj0RfmMsCf
         bQkQrCk3aTSJLkEbdiyf/Syn4fKIVGXewpTWoT859pMJ6cIz/v/39MELmcl38kHOZOKl
         WbAln2jtNwbntTu8jJwHjsMp3dYkEKb3/E81SuNtjwxjPYV0d8prAFYIIsyF7qB6QjcA
         WceUzExplkYZVJO2mAHIobcVjGtUpTplZMTRtBuCKJcduqWBAnzWEPFrgdOTEvD7jaIJ
         3S2RlXSSUAnX99qdFp6A65edqaeH2kJRmYBWvWQc/Gcp+xUN9EJClFeXcsszOxa2jGEQ
         4skA==
X-Forwarded-Encrypted: i=1; AKwUvBylu/ln+SqmjKSLTWgesGVO/DRJ8iKh6bwzP9jzFk6NBTNmXknTatClTi/nwiqEj4IHz68uUUs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Q8hbjMye6akICklBfLRkvWIf3FLUxdzJhu37WpXKPhsxiIkK6
	YylaBp74TB64lPVBsBT4mlN8YnvEr/moj9TE19FqUpYhEPI8WjFV2JrYojj7d3SFglEY88jvfxw
	SfbxsJDE+jFaqpw2aQOYcDCb1iE6IK8U=
X-Gm-Gg: AYBFou1Wbt8Kvsrt9Dtq4F0Wf0FXPzYp5fNcDaZnpxD6Wo3xygNz9xSGpmIaH8fQWCF
	uYVPTLR28txxbHjaU9eV+BTgDFK3Y1Jzba+G+Q22XVjPsofky17YMyrYjuQK0wEbzthHJFOHhwr
	nvSc9Ml9kZIK9cNjSSKH4o3bjnCoqTn4+z4xDrC275ndezwdTZJVTel2lKpINs8lxXx8RHswDIQ
	6NzvQkZLp9qAtvjYzXpHuAkr6HbzjODM+1WYy1AFQjwUh9Dm+3gon07mUB4oVbpus1enzabRDZC
	NpqrR4u2672q8UydgI1fBf6Lho4sEUBUZG+cDg46/3WmDmsXxUimzjsFQiCuSP3eJLrvNUaN6iZ
	ds07Y1Fj076DHVL2vo8PwToBjyz+HZrDvG+VT6s2tZ/lk0qTFrwHV7Kb2zbZR
X-Received: by 2002:a05:6820:60a:b0:716:c870:7eb9 with SMTP id
 006d021491bc7-716d1ed0d87mr313916eaf.17.1793820007417; Wed, 04 Nov 2026
 11:20:07 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103103633.2707416-1-zhiyuzhang999@gmail.com> <CAL4Wiip0RPZkfrwHeuNp6ntVWarpkL=wJ-wW6sUvNzYWS68s3Q@mail.gmail.com>
In-Reply-To: <CAL4Wiip0RPZkfrwHeuNp6ntVWarpkL=wJ-wW6sUvNzYWS68s3Q@mail.gmail.com>
From: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Date: Thu, 5 Nov 2026 03:19:55 +0800
X-Gm-Features: AclHuK_BR4-6TIohRJS_zawjA7_IVa0Ao4YBLhd308J7rBy_Y8iFzOZsQJyitaI
Message-ID: <CALf2hKvGy9_wFYcmhdegEHW3OrDovJQ_t7_B98ZwE8erwyykWg@mail.gmail.com>
Subject: Re: [PATCH net v3] tcp: prevent cross-family skb processing after disconnect
To: Eric Dumazet <edumazet@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Tong Liu <lyutoon@gmail.com>, Qi Tang <tpluszz77@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@kernel.org> =E4=BA=8E2026=E5=B9=B411=E6=9C=883=E6=97=
=A5=E5=91=A8=E4=BA=8C 19:03=E5=86=99=E9=81=93=EF=BC=9A
>
> We do not want to add yet another check in TCP IPv4 fast path,
> for a problem that only exists for IPv6 sockets.
>
> tcp_v6_do_rcv() already dispatches IPv4 skbs to tcp_v4_do_rcv().
>
> Simply stop changing sk->sk_backlog_rcv for v4-mapped sockets
> (tcp_v6_connect() and tcp_v6_mapped_child_init()),
> so that skbs found in the backlog are always handled by the correct path.
>
> tcp_v6_disconnect() can then test
> inet_csk(sk)->icsk_af_ops->net_header_len =3D=3D sizeof(struct iphdr)
> (this also covers subflow_v6m_specific).
>
> Thanks.
>
> Untested patch:

Hi Eric,

Thanks. I applied your untested patch as-is on top of 5838f10563d5.

I agree that keeping tcp_v6_do_rcv() as the backlog handler for
AF_INET6 sockets is cleaner than adding another check to the IPv4 fast
path.

The patch fixes the reported bug in my tests. In the native IPv6 to
v4-mapped race, the stale IPv6 skb no longer reaches
tcp_v4_send_reset(). The disconnect/reconnect tests also pass for both
TCP and MPTCP.

I also checked the two races reported by Sashiko. On one v3 run with
400 reconnects in each direction, both races were hit four times.

For a native IPv6 to v4-mapped reconnect, I observed:

  tcp_v6_rcv()
    tcp_v6_do_rcv()
      tcp_rcv_established()
        inet_sk_rx_dst_set()          /* IPv6 skb */

For the reverse reconnect, I observed:

  tcp_v4_rcv()
    tcp_v4_do_rcv()
      tcp_rcv_established()
        inet6_sk_rx_dst_set()         /* IPv4 skb */

I added probes after the rcu_assign_pointer(sk->sk_rx_dst, dst)
instructions and confirmed that the mismatched dst was actually stored.
Both cases can also be reproduced with your patch.

So the receive paths and the cross-family dst assignments are real.
However, I have not reproduced the Critical outcome suggested by the
review. I saw no warning, oops or panic, and did not observe an IPv6
skb reaching ip_local_deliver() or an IPv4 skb reaching ip6_input().
For the local IPv4 input route in this test, the bytes overlapping
rt6_info::sernum are non-zero due to rtable::rt_type/rt_is_input, so
the invalid rt->from dereference did not occur.

Given that, I think your patch is still the right fix for the reported
header.h6/header.h4 bug. I would post it as v4 with that scope, and
handle the stale skb/sk_rx_dst race separately instead of adding the
IPv4 fast-path check back.

Does that sound like the right split, or do you think the sk_rx_dst
race should be addressed before v4 or should not even take care?

Thanks,
Zhiyu
