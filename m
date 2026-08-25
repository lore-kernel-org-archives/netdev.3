Received: from mta1.migadu.com (out-192.mta1.migadu.com [95.215.58.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C12D7081E
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787651030; cv=none; b=cWCA/PxhSJoq3mSnlSKj7koXlCRc4qazWaPrYkQj/5gIMu+yULpoBnFnxCQL+MB4OfAFmCKkxgqG0Sj8iaoedkDSVa3xryPTwX8ntsPWfgkzt77qeMymVcjNvEgjLz6xcOP1wrwG7T4TvA500FRIluGQzuHcn9OzmFUe1sDB0QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787651030; c=relaxed/simple;
	bh=tOduI5m0XYvjsOv5gu7CE0vH57AnbRPPiTSW1tt7EGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q62glyWuPVcVKbbnYe/prDE2niod3TXosOw3aaaJQPW+F6ypiWIMqyalqW0mHtxSCC6aDowYNpv33IkajqAmT7KaWBWj1qYOASvPddjmuaeqWdyNJQMl3A92beKdEnPZ3PsnAl/Du09n3nggvWmhgP/97x6RqY4fcZ3vlFZTEBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o8foiC8L; arc=none smtp.client-ip=95.215.58.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o8foiC8L"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=tOduI5m0XYvjsOv5gu7CE0vH57AnbRPPiTSW1tt7EGA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787651025; v=1; x=1788255825;
 b=o8foiC8LnatKofW0ayEPxHMg3DqrzOjv6bn3ucLC8miksY00MRxt4IiWUcOIdDxFMmRcXEvP
 hIeXQaVs26rDcjHUdXxFoWINqYPlF8H+59Vlhhe27AvRhIwOv5jdA6gc8cihnvN/npBT9nHJMdH
 5Dl1dDlZKKali8YzuSK/MkS4=
X-Envelope-To: netdev@vger.kernel.org
Received: from [10.54.25.56] (210.22.144.162)
	by smtp.migadu.com with ESMTPS id 4c83b0a24358c265;
	Tue, 25 Aug 2026 09:43:35 +0000
X-Mizu-Trace-ID: 4c83b0a24358c265
X-Migadu-Flow: FLOW_OUT
Message-ID: <d1bc4d0b-c831-4fd0-9bac-2e502bb874ad@linux.dev>
Date: Tue, 25 Aug 2026 17:43:23 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: icmp: avoid invalid transport header access in
 icmp_send tracepoint
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com,
 syzbot+6d2762674103618994b0@syzkaller.appspotmail.com,
 Peilin He <he.peilin@zte.com.cn>, xu xin <xu.xin16@zte.com.cn>,
 Steven Rostedt <rostedt@goodmis.org>
References: <20260825084551.1562967-1-edumazet@google.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260825084551.1562967-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/25/26 4:45 PM, Eric Dumazet wrote:
> syzbot reported a WARNING triggered by DEBUG_NET_WARN_ON_ONCE():
>
>   WARNING: at skb_transport_header include/linux/skbuff.h:3087 [inline]
>   WARNING: at udp_hdr include/linux/udp.h:23 [inline]
>   WARNING: at do_trace_event_raw_event_icmp_send include/trace/events/icmp.h:30 [inline]
>   WARNING: at trace_event_raw_event_icmp_send+0x48c/0x6ec include/trace/events/icmp.h:11
>   Call trace:
>    skb_transport_header include/linux/skbuff.h:3087 [inline]
>    udp_hdr include/linux/udp.h:23 [inline]
>    do_trace_event_raw_event_icmp_send include/trace/events/icmp.h:30 [inline]
>    trace_event_raw_event_icmp_send+0x48c/0x6ec include/trace/events/icmp.h:11
>    __traceiter_icmp_send include/trace/events/icmp.h:11 [inline]
>    __do_trace_icmp_send include/trace/events/icmp.h:11 [inline]
>    trace_icmp_send+0x320/0x49c include/trace/events/icmp.h:11
>    __icmp_send+0xcfc/0x11d8 net/ipv4/icmp.c:1013
>    ipv4_send_dest_unreach net/ipv4/route.c:1280 [inline]
>    ipv4_link_failure+0x57c/0x8dc net/ipv4/route.c:1287
>    dst_link_failure include/net/dst.h:438 [inline]
>    vti_tunnel_xmit+0xe40/0x17a4 net/ipv4/ip_vti.c:307
>
> TP_fast_assign() unconditionally calls udp_hdr(skb) before checking
> whether the packet is UDP. Furthermore, __icmp_send() can be invoked
> from paths (e.g., link failures, ARP errors, forwarding, AF_PACKET)
> where skb->transport_header was never initialized (~0U).
>
> Under CONFIG_DEBUG_NET=y, calling skb_transport_header(skb) triggers
> DEBUG_NET_WARN_ON_ONCE(!skb_transport_header_was_set(skb)).
>
> Fix this by:
> 1. Only parsing transport info when iph->protocol == IPPROTO_UDP.
> 2. Using skb_header_pointer() at skb_network_offset(skb) + (iph->ihl << 2)
>     to safely fetch the UDP header without assuming transport_header is set.
>
> Fixes: db3efdcf70c7 ("net/ipv4: add tracepoint for icmp_send")
> Reported-by: syzbot+6d2762674103618994b0@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a8d5538.91706f20.ef82.0009.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Peilin He <he.peilin@zte.com.cn>
> Cc: xu xin <xu.xin16@zte.com.cn>
> Cc: Steven Rostedt <rostedt@goodmis.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
>   include/trace/events/icmp.h | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/include/trace/events/icmp.h b/include/trace/events/icmp.h
> index 09ae115099dfe25616b6c74d5b92be1af4acff55..6937b778ae54dbf4442b127957a017da3551aaff 100644
> --- a/include/trace/events/icmp.h
> +++ b/include/trace/events/icmp.h
> @@ -27,17 +27,20 @@ TRACE_EVENT(icmp_send,
>   
>   		TP_fast_assign(
>   			struct iphdr *iph = ip_hdr(skb);
> -			struct udphdr *uh = udp_hdr(skb);
> -			int proto_4 = iph->protocol;
> +			struct udphdr _uh, *uh = NULL;
>   			__be32 *p32;
>   
>   			__entry->skbaddr = skb;
>   			__entry->type = type;
>   			__entry->code = code;
>   
> -			if (proto_4 != IPPROTO_UDP || (u8 *)uh < skb->head ||
> -				(u8 *)uh + sizeof(struct udphdr)
> -				> skb_tail_pointer(skb)) {
> +			if (iph->protocol == IPPROTO_UDP)
> +				uh = skb_header_pointer(skb,
> +							skb_network_offset(skb) +
> +							(iph->ihl << 2),
> +							sizeof(_uh), &_uh);
> +
> +			if (!uh) {
>   				__entry->sport = 0;
>   				__entry->dport = 0;
>   				__entry->ulen = 0;
