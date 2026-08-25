Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0F4E54B
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787669331; cv=none; b=YtuiHV16RuCN9C5v/ecZPVAjEY5iTuOzyk/93sT3XGr942uzAjG6GmUbSC93h/zr+nwE9MFsaa/TxpzFglE/fCVw6GD4qm+0/CrQK2H+TQch2R8L0s1VFi5Nt4ZIZTaqf4XsKxKhLsTLuR4decrxAZCdMZLtzCVhZKGqJzrJMP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787669331; c=relaxed/simple;
	bh=AZdnbIyEu2IC4JF0pKLZQwVJ98XVyOKKquhdHOuBn3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IoF4XMlzmXqYu25B2ml77+nhzb7U+IN5dVY9pK4PkYu7FDGRHfpUffTQngOcBidNBV30D39jOhNL89f7EJBnCwPMomoHyhW8Fcde01DRbd0IfaoEAl2p5VhJO09NrJPIc9JQGkrJBs0pcvs6co2jPE2nEhJvMflFfXWyMIKvemc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxedDnzz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxedDnzz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902FB1F000E9;
	Tue, 25 Aug 2026 14:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787669330;
	bh=gACorzydiaHvYYu0KIvseChJOeHthtp8vi3ojgPVOeY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gxedDnzztuG/7Qq66c/20dZezV3Yx7xAgw0svuBJtglofcf21/F43H+clc3O4mfm9
	 CIXgVV7Rly9SqP6y47Vg549kGw+6joy/R4qUltVZjaCXnkuQZztUr/Fvzd8k2rqXha
	 soAVjprAzCVbH+tFiXWmTwpUit9XOFq21XilVgh58Bygje5kWl8nPR40tPXVLH3uz7
	 ft5E6JBSiPsr3QmlCrEfrFiNjGQI/tNzQ1BwGrHj+C0xjoQvUCQUVQXf9fBaVwK5Ny
	 edr4N4rkWbDhsj1b7UFr86+s8VhRzXsvVQL3fMMPn94iTdD84D7zpZk0F2OTNRuvCU
	 lrDPSKZN+PzJw==
Message-ID: <0d562eeb-7292-4edc-b499-5e32fbb6ee3d@kernel.org>
Date: Tue, 25 Aug 2026 08:48:48 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: icmp: avoid invalid transport header access in
 icmp_send tracepoint
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+6d2762674103618994b0@syzkaller.appspotmail.com,
 Peilin He <he.peilin@zte.com.cn>, xu xin <xu.xin16@zte.com.cn>,
 Steven Rostedt <rostedt@goodmis.org>
References: <20260825084551.1562967-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260825084551.1562967-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/26 2:45 AM, Eric Dumazet wrote:
> syzbot reported a WARNING triggered by DEBUG_NET_WARN_ON_ONCE():
> 
>  WARNING: at skb_transport_header include/linux/skbuff.h:3087 [inline]
>  WARNING: at udp_hdr include/linux/udp.h:23 [inline]
>  WARNING: at do_trace_event_raw_event_icmp_send include/trace/events/icmp.h:30 [inline]
>  WARNING: at trace_event_raw_event_icmp_send+0x48c/0x6ec include/trace/events/icmp.h:11
>  Call trace:
>   skb_transport_header include/linux/skbuff.h:3087 [inline]
>   udp_hdr include/linux/udp.h:23 [inline]
>   do_trace_event_raw_event_icmp_send include/trace/events/icmp.h:30 [inline]
>   trace_event_raw_event_icmp_send+0x48c/0x6ec include/trace/events/icmp.h:11
>   __traceiter_icmp_send include/trace/events/icmp.h:11 [inline]
>   __do_trace_icmp_send include/trace/events/icmp.h:11 [inline]
>   trace_icmp_send+0x320/0x49c include/trace/events/icmp.h:11
>   __icmp_send+0xcfc/0x11d8 net/ipv4/icmp.c:1013
>   ipv4_send_dest_unreach net/ipv4/route.c:1280 [inline]
>   ipv4_link_failure+0x57c/0x8dc net/ipv4/route.c:1287
>   dst_link_failure include/net/dst.h:438 [inline]
>   vti_tunnel_xmit+0xe40/0x17a4 net/ipv4/ip_vti.c:307
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
>    to safely fetch the UDP header without assuming transport_header is set.
> 
> Fixes: db3efdcf70c7 ("net/ipv4: add tracepoint for icmp_send")
> Reported-by: syzbot+6d2762674103618994b0@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a8d5538.91706f20.ef82.0009.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Peilin He <he.peilin@zte.com.cn>
> Cc: xu xin <xu.xin16@zte.com.cn>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> ---
>  include/trace/events/icmp.h | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/include/trace/events/icmp.h b/include/trace/events/icmp.h
> index 09ae115099dfe25616b6c74d5b92be1af4acff55..6937b778ae54dbf4442b127957a017da3551aaff 100644
> --- a/include/trace/events/icmp.h
> +++ b/include/trace/events/icmp.h
> @@ -27,17 +27,20 @@ TRACE_EVENT(icmp_send,
>  
>  		TP_fast_assign(
>  			struct iphdr *iph = ip_hdr(skb);
> -			struct udphdr *uh = udp_hdr(skb);
> -			int proto_4 = iph->protocol;
> +			struct udphdr _uh, *uh = NULL;
>  			__be32 *p32;
>  
>  			__entry->skbaddr = skb;
>  			__entry->type = type;
>  			__entry->code = code;
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
>  				__entry->sport = 0;
>  				__entry->dport = 0;
>  				__entry->ulen = 0;

This code change looks fine, so:
Reviewed-by: David Ahern <dsahern@kernel.org>


But really, why not drop the tracepoint entirely and have the author of
the original patch send a new version that acknowledges icmp's are sent
for other transport protocols?
