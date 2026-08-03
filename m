Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6B740DB5B
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 13:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764044; cv=none; b=rURMaOdCCiSt087GPOZVjhi9ATf4jeBbPlV+UWrLj89nvknAjaWSewexAzMlrNC3bOWlgwIAqSK+YOMjIfrKXETtRkkXr+TQ2TFK8cX+h1ivPSSafRJCHz/DR0AIRDA1FnQKExdUbjXqruX7VHXadusCOSGFCZqO9BFhB8EB5RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764044; c=relaxed/simple;
	bh=kwpEV1HJBwZQxKUJiS7IeuxV6lRUDgWPvf+T/s2rTZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p2rq3S+vWH+hXBT7mRo4AozN4gVLef0fuFi7c3FFmGzbqbov6fumvzyz6jeTk4TEjArHPmU0Brnvduo4jqUriSM0DAxj6NNKePTaUQZAF6WS6FczWg4lu+TlYXdRGAB5ddlnwgf+RGU4soGqMIw9PE1TNaT+1WyFiYoXYsSNwEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CmE3lh72; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kFV7cPBR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CmE3lh72";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kFV7cPBR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785764031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y0vvGsjlClS4W1B13jNfZSYKGzbIOS1qyeG1RNmACL4=;
	b=CmE3lh72omzcPxis2Q9LPVY4hk7I/BCSddqMe/z4AKxcVs1ZexiEVCzfGsPrGjAAfeytrH
	wcm+0a7ruwMd+tCv/is3gGgWSqoCExxierj+ilKmMZfM+iZe11Lzk0kHhG2MjWv8cveKth
	HyjbBkaLpv9l+gpC2uWN4oIzsZE3+8Q=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-05ijbJ4BP5GVY48wS22Rbg-1; Mon, 03 Aug 2026 09:33:48 -0400
X-MC-Unique: 05ijbJ4BP5GVY48wS22Rbg-1
X-Mimecast-MFC-AGG-ID: 05ijbJ4BP5GVY48wS22Rbg_1785764027
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-39f75e02d77so10857371fa.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 06:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785764027; x=1786368827; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y0vvGsjlClS4W1B13jNfZSYKGzbIOS1qyeG1RNmACL4=;
        b=kFV7cPBRJNitihYS5UVZ6KOgL8I8slFZoT1p5OudPa5tSA/xHxR7TrxZA+osp4WuyE
         t+8NHQTBVlUPvESHpTKWVTKoiGA9Kk2VGKkXmQ5z9hUl3NMBL6dBlqpSCsTpzUc58T0Z
         qzFOUXOc9K5Jg3UPmVmc7opkxDrnln+0cVtHqx5ozMygvVPCZ2FL4K8vkoGV4uoLlQdd
         gdEZKc8tG0qlp5BpVqN73p6/JNMCec2TjlTi7Axp1PN+BAbzxqTE4JI/xdF9Aos1N6wd
         jm0xFPfSpPuPadrdudMbqueCjUDpE6fudBiNC24rb1Te2ffRQza/Vm1VIj3m9r0gN+SZ
         RqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785764027; x=1786368827;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y0vvGsjlClS4W1B13jNfZSYKGzbIOS1qyeG1RNmACL4=;
        b=Y2GrizDAcOsNI5giulX5+koH41Mu7ZHYHUGxq8WTd7uCD4D69C8vhlFpsxbPF6Zyvs
         AnURnydRs0w4VU0D/f223NkQxpzwzbV1gsZxbezMSG1y2GeeEGUhkbeprLMlzIna/aP7
         jGIzzL4XKHLGQ3WRO6FjJjGxkv5COb5+JEvtPSZVDbQvaK2RJ9SjQqo/6Xf6sKpoSGS2
         akztq6+OEQWnQxRpQvWrpxZEgJWw02rWoCltpq1ahToppSVgdlR6LiD7W4VP/8nrw9f+
         4j+Y7Ozec+O0t9SorxMEg2jspsdRNvU0NgAUMfwSbgUr1NmhQ20CG40GKxPpm25rS1EW
         PfKA==
X-Gm-Message-State: AOJu0YyAUUCxPXkk8DS4z5d/ZJO6vT4PhgZF2GwHpVYoQ/SQF2WW0DJp
	P/HcgGa/WbuUh4BQLilybUi6GLVR97RguIt5GtYva5r9Cvv963y/UrGCJc0GN38ZOq4/yeqE7RV
	Hoel4JEgFYM9XQ0in2thSXF1rKHg5BuqLzTOMxmhH1SYIOSPwu2VZsn2JWg==
X-Gm-Gg: AR+sD12nABU3NbdKK5Zglp0HMk6tbrsChpK4p8F9Eicl7Ch1ZD+LbWRXML34NSiE5oq
	xA6nGxZzBLKEMuK5UZOW+Cy3e9GAZ9JF4v1Po6GOQSm9iXdLIH1l8ys81IoIPKUwWg2Oz8vQiQG
	H5L/FWX9l1mwEvFNJFUT50B++DchCDLMiZ83rO2tGddAKkwNAH4nBLnYgk3w8AM0EV6v/caTxQk
	PM1iFhQGMLUXexWlEvG9QH2nIOIsW/KcXGUxPfoBLZrecuXHQOKDWxfKRetdw/Fe07zfrJUf0Bj
	kRzy3DmbVnLc8+KJAZux9PFdLwFgbd4KqErMz003FxmpnaILF7QrjIub6FzM0ybkmPrcH5WUZ2o
	D+kPXzT8U/CTmUIZfa0bnbOBU07UIEoO/wyDeftAybpS0EhmRYPxztHG413wG6Oe+fpSdYtW6ew
	U=
X-Received: by 2002:a2e:a985:0:b0:39b:479:47e9 with SMTP id 38308e7fff4ca-39f85bd869dmr18213371fa.17.1785764026829;
        Mon, 03 Aug 2026 06:33:46 -0700 (PDT)
X-Received: by 2002:a2e:a985:0:b0:39b:479:47e9 with SMTP id 38308e7fff4ca-39f85bd869dmr18213261fa.17.1785764026382;
        Mon, 03 Aug 2026 06:33:46 -0700 (PDT)
Received: from [192.168.188.217] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f812aed4asm13062291fa.22.2026.08.03.06.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 06:33:45 -0700 (PDT)
Message-ID: <e6f39bb0-7c32-4429-a1d8-388783eafb5b@redhat.com>
Date: Mon, 3 Aug 2026 15:33:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/5] mptcp: explicitly drop over memory limits
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260731-net-next-mptcp-oooq-pruning-v2-0-24838164fa21@kernel.org>
 <20260731-net-next-mptcp-oooq-pruning-v2-3-24838164fa21@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260731-net-next-mptcp-oooq-pruning-v2-3-24838164fa21@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/31/26 4:24 PM, Matthieu Baerts (NGI0) wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> Currently the enforcement of the rcvbuf constraint is implemented
> when moving the skbs into the msk receive or OoO queue, keeping the
> incoming skbs in the subflow queue when over limits.
> 
> Under significant memory pressure the above can cause permanent data
> transfer stalls, as the skb needed to make forward progress can be
> stuck in a subflow queue.
> 
> Over memory limits, drop the incoming skb, relying on MPTCP-level
> retransmissions.
> 
> Note that fallback socket must perform the limit before the skb reaches
> the subflow-level queue, as dropping an in-sequence already acked skb
> would break the stream.
> 
> This is not a complete fix for the stall issue, as the drop strategy
> needs refinements that will come in the next patches.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> [ Fix typo, comment, and bump LINUX_MIB_TCPRCVQDROP ]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> v2:
>  - mib: typo: "constrains" -> "constraints".
>  - mptcp_over_limit: more than 0-win: retrans, dup or old acks.
>  - mptcp_over_limit: bump LINUX_MIB_TCPRCVQDROP.
>  - Note: Sashiko might point to a possible forward-allocated memory
>    leak: this is a temp leak, and releasing additionally allocated fwd
>    memory in the error path will be fix in a patch for -net.
> ---
>  net/mptcp/mib.c      |  2 ++
>  net/mptcp/mib.h      |  2 ++
>  net/mptcp/options.c  | 32 +++++++++++++++++++++++++++++---
>  net/mptcp/protocol.c | 31 +++++++++++++++++++++++--------
>  4 files changed, 56 insertions(+), 11 deletions(-)
> 
> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> index f23fda0c55a7..ef65e2df709f 100644
> --- a/net/mptcp/mib.c
> +++ b/net/mptcp/mib.c
> @@ -85,6 +85,8 @@ static const struct snmp_mib mptcp_snmp_list[] = {
>  	SNMP_MIB_ITEM("SimultConnectFallback", MPTCP_MIB_SIMULTCONNFALLBACK),
>  	SNMP_MIB_ITEM("FallbackFailed", MPTCP_MIB_FALLBACKFAILED),
>  	SNMP_MIB_ITEM("WinProbe", MPTCP_MIB_WINPROBE),
> +	SNMP_MIB_ITEM("BacklogDrop", MPTCP_MIB_BACKLOGDROP),
> +	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
>  };
>  
>  /* mptcp_mib_alloc - allocate percpu mib counters
> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> index 812218b5ed2b..9271205f682e 100644
> --- a/net/mptcp/mib.h
> +++ b/net/mptcp/mib.h
> @@ -88,6 +88,8 @@ enum linux_mptcp_mib_field {
>  	MPTCP_MIB_SIMULTCONNFALLBACK,	/* Simultaneous connect */
>  	MPTCP_MIB_FALLBACKFAILED,	/* Can't fallback due to msk status */
>  	MPTCP_MIB_WINPROBE,		/* MPTCP-level zero window probe */
> +	MPTCP_MIB_BACKLOGDROP,		/* Backlog over memory limit */
> +	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory constraints */
>  	__MPTCP_MIB_MAX
>  };
>  
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index c664023d37ba..5642277c8b3d 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1127,8 +1127,34 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
>  	return hmac == mp_opt->ahmac;
>  }
>  
> -/* Return false in case of error (or subflow has been reset),
> - * else return true.
> +static bool mptcp_over_limit(struct sock *sk, struct sock *ssk,
> +			     const struct sk_buff *skb)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	u64 mem = sk_rmem_alloc_get(sk);
> +
> +	mem += READ_ONCE(msk->backlog_len);
> +	if (likely(mem <= READ_ONCE(sk->sk_rcvbuf)))
> +		return false;

Clashiko noted this is a bit pessimistic/too strict. I *think* it can be
relaxed a bit, but I'm not sure if such option would be actually better.
Unfortunately this is inherently race. I will give a shot.

> +	/* Avoid silently dropping pure acks, fin or already-acked segments. */
> +	if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq ||
> +	    TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN ||
> +	    !after(TCP_SKB_CB(skb)->end_seq, tcp_sk(ssk)->rcv_nxt))
> +		return false;
> +
> +	/* Dropped due to memory constraints, schedule an ack. */
> +	inet_csk(ssk)->icsk_ack.pending |= ICSK_ACK_NOMEM | ICSK_ACK_NOW;
> +	inet_csk_schedule_ack(ssk);
> +
> +	/* Plain TCP (fallback) and skb is dropped before the TCP recv queue. */
> +	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP);

Clashiko note this account is not correct in case of RST packet with
payload; this could be a follow-up, but given the other feedback I'll
give it a shot.

I took the liberty to ignore minor feedback WRT comment accuracy.

/P

