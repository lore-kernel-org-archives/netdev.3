Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792994642;
	b=l5FwD0mU7Ph0+iAzaKESK3dzVOnAlh8YeCxXLRU3FFtRg9SNkI/9SmrObr3zbpcl756b
	 BvcwOU12QGvYcx+Pu/bR8O8V3yYRVq9mJj9hAysyZEMdXlTWpS5/KgSs/y0LvA8nDxDX0
	 afH/YTnObUKNXDujFOxgvVY1ri4kruLjNE8K6ltZkLK9i4thfANTdKWaWYv0/xUM795Yh
	 esHqpoSioOugCggH4zpc04wRcZnoXAp3XikMn8Sw/1bRlaRM5Z9qSyvhdi918zcLTpa00
	 kaNRuAUtDtOXFFBBoTKVEOjPUSaigYMkY/Z8y9jGqf4n9dsE73YsFbUANh+kXL6FIbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792994642;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aq4qj7X3uDNOylbWVnw2ebWrrf7qEzSnn935WLDjk4U=;
	b=vth1gMNvlpXlCKVszf83sHrsLtVqlIlC7owhtv/nFSnpUJgfdwshP7j4jFXNNxDH8Laa
	 v0tTqKzWrK24TWHsXLHr+JwEhCqpKFc5vKY5PBEB9LDDRnU7cApzilZiIwJostRH/TkeM
	 FVuay9iO/MxVVayI7h83t47LNjTHUDVI4GG11xoUKlUsOi8WOjiP2uGeuyyeRXM2pZKEw
	 fmWyiHvbRmKpMXGkmV7gN3Kp1Eno7bb0pAKqy/gxEAeDEMQkyzBfiRaYEEmOGT5v6u9Vm
	 y5+1M+nN5ly2y7ukG1wl77O80yssd9Wu/pS4J0Inys1GdbF+DIjExEkXmCeYmKuM77Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tnifBwe8;
	arc=none smtp.remote-ip=91.218.175.239
Received: from mta0.migadu.com (out-239.mta0.migadu.com [91.218.175.239])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3D0606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 06:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D3D0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tnifBwe8
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+KjbAb4mqjjuavznN3uK91S0a1pVusJuB7EYj/7xIlE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792994639; v=1; x=1793599439;
 b=tnifBwe836y9jaDpsh7zJes8l8NFAVJ3ySJJryueRo4OAvH9eIL15XVleOz0s6lLUujFQbgz
 9HktWj7NHAqXcPsjwb/uuSYnExBmXkVCWZeLieoVHLbkj7EyJWdZYNpwFDv3Y9OzZzW17RYlEyZ
 jgSI93exoP1LBkkcyALbv1GE=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 73b3493711b79e15;
	Mon, 26 Oct 2026 06:03:59 +0000
X-Mizu-Trace-ID: 73b3493711b79e15
X-Migadu-Flow: FLOW_OUT
Date: Mon, 26 Oct 2026 14:03:53 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net] ipmr: clear skb->cb[] in reg_vif_xmit()
Message-ID: <at7tSfe2w0Wfn4ns@fedora>
References: <20261025111337.142787-1-edumazet@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261025111337.142787-1-edumazet@kernel.org>

On Sun, Oct 25, 2026 at 12:13:37PM +0100, Eric Dumazet wrote:
> reg_vif_xmit() hands the skb to ipmr_cache_report() as an
> IGMPMSG_WHOLEPKT report. When the mroute socket has IP_PKTINFO
> enabled, ipmr_cache_report() calls ipv4_pktinfo_prepare() on the
> original skb, which reads skb->cb[] as IPCB.
> 
> By the time the pimreg device transmits the packet, skb->cb[] is not
> IPCB anymore: qdisc_pkt_len_init() overwrites IPCB(skb)->iif with
> qdisc_skb_cb(skb)->pkt_len, and any qdisc installed on the device or a
> tc BPF program writing skb->cb[] fills the area holding the IP options
> and IPCB(skb)->flags.
> 
> For locally generated packets routed out pimreg (they carry an rtable
> dst), the mroute socket can therefore receive a bogus ipi_ifindex
> (the packet length), and the l3mdev slave test in
> ipv4_pktinfo_prepare() is driven by stale qdisc data.
> 
> Clear IPCB before building the report, as done for IPv6 in
> commit 238164201431 ("ip6mr: clear skb->cb[] in reg_vif_xmit()").
> The skb is freed right after, so nothing else depends on its control
> block.
> 
> Fixes: bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP msg")
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---
> Issue has been discovered while reviewing Ido's series:
>  https://lore.kernel.org/netdev/CAL4WiiovWOOQ9PBPbnPk2=rK+V5WgMpOFh814-D6_A-k5ope_A@mail.gmail.com/
> No repro, but this is mirroring the fix we did in 238164201431 ("ip6mr: clear skb->cb[] in reg_vif_xmit()").
> 
>  net/ipv4/ipmr.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index acacaae05cc49dc15910f23f7539865432518587..8b84142fd7754d95aa1f2facf68ac554916efd27 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -550,6 +550,11 @@ static netdev_tx_t reg_vif_xmit(struct sk_buff *skb, struct net_device *dev)
>  	DEV_STATS_ADD(dev, tx_bytes, skb->len);
>  	DEV_STATS_INC(dev, tx_packets);
>  
> +	/* skb->cb[] holds qdisc/tc state at this point, not IPCB.
> +	 * ipmr_cache_report() reads it as IPCB to build IP_PKTINFO.
> +	 */
> +	memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
> +
>  	/* Pairs with WRITE_ONCE() in vif_add() and vif_delete() */
>  	ipmr_cache_report(mrt, skb, READ_ONCE(mrt->mroute_reg_vif_num),
>  			  IGMPMSG_WHOLEPKT);
> -- 
> 2.53.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
