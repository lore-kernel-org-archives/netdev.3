Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810564;
	b=S+nmrrKb+mo/4/ZfdOqBy1QWcZ8+oyu8duVuLjkF07JuCwTXI8Sq7nriH7pEmSjiByWZ
	 oGOBxwwguKVDyVtohYR5dhns7SOrAyt65oliP+ST0F2qxpc8XBjS0bbMrVrSQZz9pf2Pm
	 QNPYY0jb0RVoTT3kUHpM/3SrYfHB9f4LsdmPabaelvEcnIiNhxlFGQMqteB2iVeDNDzrm
	 3dDuzX4WJejVbIoJE1C/e0d9AWKjb1KX5R5c13PTY/lHViHcn27lSaEwXuwISq7rG9/AD
	 1vdquxkdk8vT33c4pltDFCvEARGWeZAlw+jKoE8f+oQ/UcbvcaqU/SacFLSDqzEH5DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=c7OMuhEmxcvJT9wqjETUbrxK1nwfNMV6htSFGTLN/QY=;
	b=b0SLBA+2HBEO2/B1s5bUEM8A3r7RYlfb7SEoLAEkfPPsnBELHtQsXoeD7b3sgBSsINSq
	 1unBRSDgvMrYsjmjOpozhfa6WGEWELKUHKe6T11gwmMrNrwZLKEkAcDv8U6nu6wQBkXdT
	 vAGJt/T7aLvHaRg13dYnsXoc8UBCL9HPGCvpx2iEexOkQ23p1s8yO5lYfpk6fVcxz2dQH
	 Cqq+jyElAcKDJ+5v57YYYLIUMJWUmXjPta3TZ0GlkzXZVPrGkxLhxYjtI1Mb+CthVE9ZB
	 yFJxV79xEjjpGM4O7fhUSHIYFWD4JBiOuaArkdEaVf41XBZdUAoPmMFgiyjl9BYe+mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yuRK4eVF;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36C5606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 16:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A36C5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yuRK4eVF
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91c75267b0fso10042566d6.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 08:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793810563; x=1794415363; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c7OMuhEmxcvJT9wqjETUbrxK1nwfNMV6htSFGTLN/QY=;
        b=yuRK4eVFFHvGeSfGpuT2oAyAnci9C1QVfq99WLjpeiK18Qe/SoncpvQeTFYND2jvjp
         8MUOfmm2GHt6qadP7AMENObqTtw72UqH9DtiQcHKJIo8CjlVH1QWs7e03n4G/LO+8jBK
         hXxvCg1qxfKxdz4ydB/w0Ri5vzeIxTfUGp8Qk0/zN4HB2TPvduDo83vnro7vS8dzGDFg
         lJPLRx7HPSQ8BKzQbMdvPJEPMbXOEuADO9kv7j/V2UMATen2qiBOTXrwMraVND2QmXCn
         EDdspFtz/b/n5sHrGluTYYpv+8IYzZ/8tgYzniqm1cNA2zFn6NESjm/goBa2yWfz8uKh
         uu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793810563; x=1794415363;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c7OMuhEmxcvJT9wqjETUbrxK1nwfNMV6htSFGTLN/QY=;
        b=EhqMe8TRqNzWvPR9EC+hQNaRmJNeYoeE3v9SgtFnmFUC31qDvtqoaUKDYJkEJoxmhI
         Vr6RmfvBEESvu71xkJT1BD6NP8rPavrqHP2Ma1LGAoFSeyi0i5g7ihkswDFeuODjED7j
         Q4RFb8YJK1rZbTaEaUHWEEuUMMVFDHX0b8PEfqQMGGhULwY+ZiahGI/xizrWqDvila6w
         Vv60KKmN0bs5iO2Ht+fPzC4Gbv1Pw+Ax5k/eFMm3ISrkDwaR3oVRLC41rGXPaHmH7Ez6
         N5VBwOMqMDRJ3iZufUftp+BQrwJMmvKWSUmSOkY8zPW1MGlpgfaOBUh/ZfBHzirajt1P
         H7Ig==
X-Forwarded-Encrypted: i=1; AKwUvBwchyUKdx8nv3eBfA9ZlVyXWv0S2Qnxfkrp7et2e98Aglx2YS3EST12IFS+SzTKGBU7wnQfpMQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9H10bHxFJ0O9O0rn6Dpc/J9xlfZNpHELVn8FuYCE01+UUwFzaM
	jwTiFlVZt3YK6mvaZeqPK2q+QLJCJr6TGcCCGXDvOGcozIC+tVWFfL3v
X-Gm-Gg: AYBFou00CKZ9SIdr7tQZtU0CSZsAmMgq2H9+/H1q2jBHIHu3IQYhVounkjbbUsTIVLL
	xVRfz+WgBYb9SoY0Rtg8/qezHtlibMLrUZ2YL0uPLn5Cc7q7urY0/5zhUdqdg3vuLPPV/ZVv9lk
	mak3c3geAI3T4obDKGz0xAhV0hSxgDZhxhIKVYP7lgFymZGT16WZZbWzjG66fXGSYR5stnqXKzS
	tuGhmIF6VXdy9cQt0ic7xPACjlK4k3haSL8ZdhdBZbyevmak3t8oKqTCnc08WBtHok4a/rYl8o5
	J7e+kr5pubG8gsrhl5mo75gc32Ntb2Yw4BKlwCXAEbf2m33npmLw39O6WXCaZAAYAplcQtrvVc2
	nVl7q7F7kP84DTw96rI3VxZubNtDTTLBgpHBiTHacZ2UhnZ3vBLoFiZnX51m5yOW3t/tTxNN/JS
	kTfSd/pQbIunTiS+Eq+1zNW6C9Da/S/rSqcIVm4myIsTRS/uUIFQHcsDMkZdVCLfKCxXwjZIABf
	NSAtNnmtyNpZgcZGGILxFk1LWfX3O8EvvEdqgW14IEjrNsf3g1GyBIwTG6xngsnxncI0a5Ery6E
	4iTqgQ+XOS2s1/bc
X-Received: by 2002:a05:6214:448e:b0:91c:8f2d:4025 with SMTP id 6a1803df08f44-91ca4ae89c9mr259102566d6.17.1793810562410;
        Wed, 04 Nov 2026 08:42:42 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::5:7adf])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7e013a5dsm23275976d6.27.2026.11.04.08.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 08:42:41 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 11:42:40 -0500
Message-Id: <DMMKRVD73MEB.XP1KMYHPAZBV@gmail.com>
Cc: "David Ahern" <dsahern@kernel.org>, "Ido Schimmel" <idosch@nvidia.com>,
 "Simon Horman" <horms@kernel.org>, "Thaison Phan" <thaisonphan@google.com>,
 "Kuniyuki Iwashima" <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 2/2] tcp: Subtract psp_sk_overhead() in
 __tcp_mtu_to_mss() and tcp_mss_to_mtu().
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Kuniyuki Iwashima" <kuniyu@google.com>, "Eric Dumazet"
 <edumazet@kernel.org>, "Neal Cardwell" <ncardwell@google.com>, "Daniel
 Zahka" <daniel.zahka@gmail.com>, "Willem de Bruijn"
 <willemdebruijn.kernel@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261103000712.658501-1-kuniyu@google.com>
 <20261103000712.658501-3-kuniyu@google.com>
In-Reply-To: <20261103000712.658501-3-kuniyu@google.com>

On Mon Nov 2, 2026 at 7:06 PM EST, Kuniyuki Iwashima wrote:
> Currently, psp_sk_overhead() is added to icsk->icsk_ext_hdr_len.
>
> __tcp_mtu_to_mss() subtracts icsk->icsk_ext_hdr_len from mss
> after clamping to tp->rx_opt.mss_clamp, which comes from the
> peer's MSS option configured via advmss.
>
> Since PSP is upgraded after TCP_ESTABLISHED, PSP and non-PSP
> flows share the same route mtu and advmss.
>
> This makes it impossible to configure a route so that both PSP
> and non-PSP flows achieve 4K MSS for TCP_ZEROCOPY_RECEIVE.
>
> With mtu 4220 and advmss 4108 (4096 + 12 TS), non-PSP flows
> get 4K MSS, but PSP flows are clamped to 4108 first and then
> reduced by 40 bytes to 4056, breaking TCP_ZEROCOPY_RECEIVE.
>
> With mtu 4220 and advmss 4148 to compensate for PSP, PSP flows
> get 4K MSS, but non-PSP flows get 4136 bytes, spilling over
> 4K page and also breaking TCP_ZEROCOPY_RECEIVE.
>
> Let's subtract psp_sk_overhead(sk) before clamping in
> __tcp_mtu_to_mss() and add it in tcp_mss_to_mtu() and
> to icsk->icsk_mtup.search_high.
>
> Note that tp->rx_opt.mss_clamp now bounds only the inner TCP
> segment rather than the outer PSP packet, which is consistent
> with xfrm and assumes that the peer's MTU is at least as large
> as the local route MTU or that PMTUD is enabled.
>
> Also, in psp_sock_set_tx_key(), icsk->icsk_mtup.search_high is
> simply incremented by psp_sk_overhead(sk) because PSP is upgraded
> right after TCP_ESTABLISHED before any MTU probe fails in practice.
>
> Reported-by: Thaison Phan <thaisonphan@google.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/ipv4/tcp_output.c    | 14 +++++++++-----
>  net/ipv6/ipv6_sockglue.c |  2 --
>  net/psp/psp_sock.c       |  2 +-
>  3 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index cf3ddc055d48..08d0d4a639fe 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -2060,6 +2060,8 @@ static inline int __tcp_mtu_to_mss(struct sock *sk,=
 int pmtu)
>  	 */
>  	mss_now =3D pmtu - icsk->icsk_af_ops->net_header_len - sizeof(struct tc=
phdr);
> =20
> +	mss_now -=3D psp_sk_overhead(sk);
> +
>  	/* Clamp it (mss_clamp does not include tcp options) */
>  	if (mss_now > tp->rx_opt.mss_clamp)
>  		mss_now =3D tp->rx_opt.mss_clamp;
> @@ -2088,9 +2090,10 @@ int tcp_mss_to_mtu(struct sock *sk, int mss)
>  	const struct inet_connection_sock *icsk =3D inet_csk(sk);
> =20
>  	return mss +
> -	      tp->tcp_header_len +
> -	      icsk->icsk_ext_hdr_len +
> -	      icsk->icsk_af_ops->net_header_len;
> +		tp->tcp_header_len +
> +		psp_sk_overhead(sk) +
> +		icsk->icsk_ext_hdr_len +
> +		icsk->icsk_af_ops->net_header_len;
>  }
>  EXPORT_SYMBOL(tcp_mss_to_mtu);
> =20
> @@ -2103,7 +2106,7 @@ void tcp_mtup_init(struct sock *sk)
> =20
>  	icsk->icsk_mtup.enabled =3D READ_ONCE(net->ipv4.sysctl_tcp_mtu_probing)=
 > 1;
>  	icsk->icsk_mtup.search_high =3D tp->rx_opt.mss_clamp + sizeof(struct tc=
phdr) +
> -			       icsk->icsk_af_ops->net_header_len;
> +		psp_sk_overhead(sk) + icsk->icsk_af_ops->net_header_len;
>  	icsk->icsk_mtup.search_low =3D tcp_mss_to_mtu(sk, READ_ONCE(net->ipv4.s=
ysctl_tcp_base_mss));
>  	icsk->icsk_mtup.probe_size =3D 0;
>  	if (icsk->icsk_mtup.enabled)
> @@ -2643,7 +2646,8 @@ static inline void tcp_mtu_check_reprobe(struct soc=
k *sk)
>  		icsk->icsk_mtup.probe_size =3D 0;
>  		icsk->icsk_mtup.search_high =3D tp->rx_opt.mss_clamp +
>  			sizeof(struct tcphdr) +
> -			icsk->icsk_af_ops->net_header_len;
> +			icsk->icsk_af_ops->net_header_len +
> +			psp_sk_overhead(sk);
>  		icsk->icsk_mtup.search_low =3D tcp_mss_to_mtu(sk, mss);
> =20
>  		/* Update probe time stamp */
> diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
> index 4b3536571c98..ea03fcffd147 100644
> --- a/net/ipv6/ipv6_sockglue.c
> +++ b/net/ipv6/ipv6_sockglue.c
> @@ -48,7 +48,6 @@
>  #include <net/xfrm.h>
>  #include <net/compat.h>
>  #include <net/seg6.h>
> -#include <net/psp.h>
> =20
>  #include <linux/uaccess.h>
> =20
> @@ -109,7 +108,6 @@ struct ipv6_txoptions *ipv6_update_options(struct soc=
k *sk,
>  			struct inet_connection_sock *icsk =3D inet_csk(sk);
> =20
>  			icsk->icsk_ext_hdr_len =3D
> -				psp_sk_overhead(sk) +
>  				opt->opt_flen + opt->opt_nflen;
>  			icsk->icsk_sync_mss(sk, icsk->icsk_pmtu_cookie);
>  		}
> diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
> index a6b1c42dd626..f2cba3fa3a23 100644
> --- a/net/psp/psp_sock.c
> +++ b/net/psp/psp_sock.c
> @@ -243,7 +243,7 @@ psp_sock_set_tx_key(struct sock *sk, struct psp_dev *=
psd, struct psp_assoc *pas,
>  	pas->upgrade_seq =3D tcp_sk(sk)->rcv_nxt;
> =20
>  	icsk =3D inet_csk(sk);
> -	icsk->icsk_ext_hdr_len +=3D psp_sk_overhead(sk);
> +	icsk->icsk_mtup.search_high +=3D psp_sk_overhead(sk);
>  	icsk->icsk_sync_mss(sk, icsk->icsk_pmtu_cookie);
> =20
>  	return err;

Thanks. I agree with premise. I'd say this is an improvement over the
way we have it now.=20

Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
