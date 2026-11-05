Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793850748;
	b=yX4UiJ8OlJZ+zH+XRzWKrbuue6dwfTwV7wC9sFQfhJDdhxIvCuBdL6NjpQSGek1EMsXg
	 nzljwp/g6wAryv1QDzmEremz84k3tkwkONZREXDzkeYxd7MdVrd3M6WNylXaQa7QZ64ht
	 FIwhUUzwnTZuIjaMOZgL4F3vrqpYcYDQfhGIOwYIua5EdaoKM/pia5jjkpf18v1mU88sG
	 DIhRyk7q0NsWcBUF6pPRXgZaOZDLkVEdJW6/XmhpxkIcfKF2Ptt6qgRYgWjydiPGlsfA3
	 HX/wcLurznPuwy92hpyiU61wRnERC9tRReRDPkXVLRJ/UIC6ZJaZfLhDPmXgNmSRumw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793850748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=U1zK/j3nQe//jLT6fU+HYeKZW9OkzfFh9k5JA3v3KL4=;
	b=Zoa6W6HRnAeBvjbAOfsrQtBfx5BNI4pZ6kWPsUPdLYeBPHXU2kOwy+gS3wWktLhxKH3m
	 QnKPHqctaH5F7c1LSMOMw+Y9+nDMPQukjzqFnMsXoDl4/kvHGueCIK3UQV8+VKe5XWpt+
	 GhAsIYOkfriLxLNewjUbbgY4QeqMEVCSiH5eVYjTRTAt+JwPhJQjwxKai3CbIL579kijX
	 3EwUqZHl/9EhKeG99POM0YSjxIa0uTcXfBS+ZjAeyjytdPM0wWLxvM4Yfw4dSHz/sUIE4
	 MXiUN3tXA0ssvVEna9uE3LWKpQG0Pa3Yu1wGEBMsx1dZxPUkZL458nNC/3x8riZ5svA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dQv0o1YH;
	arc=none smtp.remote-ip=209.85.222.45
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC15606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 03:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FC15606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dQv0o1YH
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-99ac154431bso5006241.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 19:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793850747; x=1794455547; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U1zK/j3nQe//jLT6fU+HYeKZW9OkzfFh9k5JA3v3KL4=;
        b=dQv0o1YHW8Aiy5C/OY6EMRooPaI4ZMNf8wUcgz0lYexi2mdSCVIQKSsULoTSSbT81b
         GQlLce/QNMOzvO1GNoJiqGvPxIjX2HrBv026FxInqe5v9L+c/3SAqXX0Pnf6pzKMKssa
         1sTFVU5rHekpzAw2asIwbA74M+4rHf1l4s10V4sGkv2UlumA4XrqOXbKdOSpjXPWEpxP
         EBEtZIOp/y4e7A24e/Go5TIYIZA2bBAgnCLCfaofDZEVDv1Z5jo49LTogafdOSm+ECP4
         QKgD3xM9ROyoq/gilv9BJZylDnAfl1IbF0p9Io8Ul5fTuQz2Yunyad0bK3kUlTjdNXX9
         HMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793850747; x=1794455547;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U1zK/j3nQe//jLT6fU+HYeKZW9OkzfFh9k5JA3v3KL4=;
        b=1BGoPCQW2Bzuz/iJ0xWj9KaBtifHhZ6L9s9PaKRj/OvDAqoR0DYLvzGhllD2qRTWnq
         88sCh7+MzgFjtU8y6nl/wnOxo4U2JINR8oyt7waA08R5SrMuNAGFQaz/o9HMeW/gT3er
         8ro8xCzUkWb0YPaIPelipE7C+WRk5UWEH5oW+278UoZWMb3Qoy9xPonaK9MR8+rUxnLl
         sJEEksH/bTKG+hs1ktDS4m1PjVJUjpUTTanBeBiqdzuVy7xTyQYDnla2/zQ2Mc4bgQ62
         hNv5+rsyyF6LBIoQejauIR8LtoYVxBanO0WH0IqnqtioHfTVifF/hM0w4AkShcqByQ3M
         dP8A==
X-Forwarded-Encrypted: i=1; AKwUvBxrpcQUdZ3XdDOkYmykNLKjzzaIfXjdp2pCOFcgdvvprgxwAZGzbiPAwqp/vYSRacviMYPGFEI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/y060PY5IGzX8ylgALg5stGDC84JtC14UTsLV3Vdp6Gpi0aZzR
	e2zQYID54G5ilJk0uwcYAREixox+Gqo2IVLoy2XdVxuF0liAl5yGhhbiKpL+dg==
X-Gm-Gg: AYBFou2MlDmoVocnpuIodPD/9ca2AcP1AOXeBuzh5rje9WrdRXTY6P4ZDiGLX1vF49w
	l2XoI5BXynlyM7jsZBY4rpAzQnQIQA3ONKOdCQOA3FpmeCottjESVV5iXg1U02cFjCEVYG7cGuJ
	Dly/tSdxOpIsPoKv9bYcI86E/l2uZ7bLH9W0puE+tzWwjijQK1ph3K6qHVkYaqn6q/6nlH9LsS0
	jEyQ+Z/U+73hAkNOywqY3tQI24kQEhtbX6g4OSHxKGz4DDFvRqeVYT0kMCD/+TPY4JM3IQqoVD1
	i3Y5U4YOgwfh1d4S4emrQJv+sU1nNJ1C61TftyrgIdiFsErS7cvLKXEe41JQf9A/zuDe7J+NPUg
	xLnb0xS/MSpgyYsoVYDV62m1nCPdf6KIf11f9ac3hsvNrasGql9flSYv7qbDVyldC+fwAHiC0Xr
	rG5eGSK6rnwAeQXHVOzb9OZ5AA9DLY9rsIU77NCbqegTtb0zxJ6Uci6S/M1z71tgYcJhQGr+ddq
	fvn2b3DQNgKW6LzVpYc/WWXdb5CL9PUihx5OX2gNM2L2kNlHk+hziBMDNQ/EI/0cLFrK5Bqt/rx
	NpqERhNlVEbJR9CLMt13gHANhijtPFBxkqFELBG8KRn+wQrmkb3ZouuNqlCpTg9T1JEMHzwMyaZ
	Ef9VyOVnGJ0CLNFls39G9I32Z0ShpV5K0H3MmE2GDkv7oMGwSIRU30iQoMXEIFeCWtNwyry8=
X-Received: by 2002:a05:6102:50a5:b0:7c3:9b8d:5124 with SMTP id ada2fe7eead31-7d072c2da67mr6339184137.18.1793850746779;
        Wed, 04 Nov 2026 19:52:26 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d8afc268sm3608356241.4.2026.11.04.19.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 19:52:26 -0800 (PST)
Date: Wed, 04 Nov 2026 22:52:25 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Daniel Zahka <daniel.zahka@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, 
 Simon Horman <horms@kernel.org>, 
 Thaison Phan <thaisonphan@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.36bf497dccb17@gmail.com>
In-Reply-To: <20261103000712.658501-3-kuniyu@google.com>
References: <20261103000712.658501-1-kuniyu@google.com>
 <20261103000712.658501-3-kuniyu@google.com>
Subject: Re: [PATCH v1 net-next 2/2] tcp: Subtract psp_sk_overhead() in
 __tcp_mtu_to_mss() and tcp_mss_to_mtu().
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
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

Reviewed-by: Willem de Bruijn <willemb@google.com>

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
> @@ -2060,6 +2060,8 @@ static inline int __tcp_mtu_to_mss(struct sock *sk, int pmtu)
>  	 */
>  	mss_now = pmtu - icsk->icsk_af_ops->net_header_len - sizeof(struct tcphdr);
>  
> +	mss_now -= psp_sk_overhead(sk);
> +
>  	/* Clamp it (mss_clamp does not include tcp options) */
>  	if (mss_now > tp->rx_opt.mss_clamp)
>  		mss_now = tp->rx_opt.mss_clamp;
> @@ -2088,9 +2090,10 @@ int tcp_mss_to_mtu(struct sock *sk, int mss)
>  	const struct inet_connection_sock *icsk = inet_csk(sk);
>  
>  	return mss +
> -	      tp->tcp_header_len +
> -	      icsk->icsk_ext_hdr_len +
> -	      icsk->icsk_af_ops->net_header_len;
> +		tp->tcp_header_len +
> +		psp_sk_overhead(sk) +
> +		icsk->icsk_ext_hdr_len +
> +		icsk->icsk_af_ops->net_header_len;

nit: some unnecessary indentation changes.

>  }
>  EXPORT_SYMBOL(tcp_mss_to_mtu);
>  
> @@ -2103,7 +2106,7 @@ void tcp_mtup_init(struct sock *sk)
>  
>  	icsk->icsk_mtup.enabled = READ_ONCE(net->ipv4.sysctl_tcp_mtu_probing) > 1;
>  	icsk->icsk_mtup.search_high = tp->rx_opt.mss_clamp + sizeof(struct tcphdr) +
> -			       icsk->icsk_af_ops->net_header_len;
> +		psp_sk_overhead(sk) + icsk->icsk_af_ops->net_header_len;

same

>  	icsk->icsk_mtup.search_low = tcp_mss_to_mtu(sk, READ_ONCE(net->ipv4.sysctl_tcp_base_mss));
>  	icsk->icsk_mtup.probe_size = 0;
>  	if (icsk->icsk_mtup.enabled)
> @@ -2643,7 +2646,8 @@ static inline void tcp_mtu_check_reprobe(struct sock *sk)
>  		icsk->icsk_mtup.probe_size = 0;
>  		icsk->icsk_mtup.search_high = tp->rx_opt.mss_clamp +
>  			sizeof(struct tcphdr) +
> -			icsk->icsk_af_ops->net_header_len;
> +			icsk->icsk_af_ops->net_header_len +
> +			psp_sk_overhead(sk);
>  		icsk->icsk_mtup.search_low = tcp_mss_to_mtu(sk, mss);
>  
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
>  
>  #include <linux/uaccess.h>
>  
> @@ -109,7 +108,6 @@ struct ipv6_txoptions *ipv6_update_options(struct sock *sk,
>  			struct inet_connection_sock *icsk = inet_csk(sk);
>  
>  			icsk->icsk_ext_hdr_len =
> -				psp_sk_overhead(sk) +
>  				opt->opt_flen + opt->opt_nflen;
>  			icsk->icsk_sync_mss(sk, icsk->icsk_pmtu_cookie);
>  		}
> diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
> index a6b1c42dd626..f2cba3fa3a23 100644
> --- a/net/psp/psp_sock.c
> +++ b/net/psp/psp_sock.c
> @@ -243,7 +243,7 @@ psp_sock_set_tx_key(struct sock *sk, struct psp_dev *psd, struct psp_assoc *pas,
>  	pas->upgrade_seq = tcp_sk(sk)->rcv_nxt;
>  
>  	icsk = inet_csk(sk);
> -	icsk->icsk_ext_hdr_len += psp_sk_overhead(sk);
> +	icsk->icsk_mtup.search_high += psp_sk_overhead(sk);
>  	icsk->icsk_sync_mss(sk, icsk->icsk_pmtu_cookie);
>  
>  	return err;
> -- 
> 2.56.0.385.gac671c819a-goog
> 


