Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EEB61FCE
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 01:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785893492; cv=none; b=ceh/5cKN0pWb/RtJOrXpoNyLzqBrTK9od+M33w/NBTQDJzgTlhwB9/JbHMTqqY2JHOwJDVhUOvLZTqWgPnxIi9HTe19+YvscMeEyz+nO2UOAbIH7Yw5QGChh6m22J8cF7df9Ae7QPtLX+jI1OIK3o9MezT94ZjVjmekM02CrNqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785893492; c=relaxed/simple;
	bh=MF9jxqpHcqu4KwRd9RYGPLdMFc507GrO957iYaXGlKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eya5wRral+2RtJDJOOsgNtM/4+Np5sMh1QPzsV41hCa0O8X/b8otGaPolzug/EiKEFWlX9lwjhA9LKfLe1+6TUu+Ax5RHaY0qe8XV8T4hoYNwAGIFHUjj7Xi5gDwITZG8lE7elLXpFvL+KoWW8/E6y5LPJQknMewmeDBJ4y8jqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbigA+59; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbigA+59"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8741F000E9;
	Wed,  5 Aug 2026 01:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785893490;
	bh=PvaKaBa7jb4kW9lvUuPJfUIZcVoSWlrycG6BSF1628Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nbigA+59BRgGYDC2sNCIdjgIiLSsT8e6HXsv72MzaihkV6QQ5OQZg443IQWPwQFr7
	 NJDa1vUpur7CZ1MActKCQXcwJkbsaS7RpcwHwwRz+qnCSZ7YruLeL6+uf50KmcMeQn
	 VFrvKwRKZJXkvcL5LnT2X7dAIwPvlAY0ribdoVB+1gj+ihhgW0CjbIGNKub1Ht/cve
	 nq7W0s2bNg2+bug0I1YyQMTDZz86mczpJUX4HGvntHkjDbC/foZvcCLNd7gVHm83JX
	 jZOmTXnzjiy1qKeJtLekV34BsJWEL0FJ5sDYPJ6E4IKf4/FsNsvbYDR/woAZ3RaQqv
	 VS13uTr7tI7LA==
From: Jakub Kicinski <kuba@kernel.org>
To: zhilinz@nebusec.ai
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	idosch@nvidia.com,
	dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	leone4fernando@gmail.com,
	vega@nebusec.ai
Subject: Re: [PATCH net v3 1/1] ipmr: only copy pktinfo to cache reports
Date: Tue,  4 Aug 2026 18:31:26 -0700
Message-ID: <20260805013126.4161847-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <e93d0d2fa5725ddd06b20e3e4223ab68b93b48d1.1785719031.git.zhilinz@nebusec.ai>
References: <e93d0d2fa5725ddd06b20e3e4223ab68b93b48d1.1785719031.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email says "Looks legit, let's fix both in one patch?"
---
ipmr: only copy pktinfo to cache reports

The patch stops ipmr_cache_report() from copying the whole 48-byte skb
control block from the original packet into the short IGMP cache report,
and instead copies only the two pktinfo fields prepared by
ipv4_pktinfo_prepare().  This keeps IP_PKTINFO working while preventing
non-IPCB cb bytes (for example NETLINK_CB of a synthetic RTM_GETROUTE
query) from being reinterpreted as IPCB() by the mrouted raw socket.

Link: https://lore.kernel.org/all/1b809975e5bd9c0a1dd6fdd1db534e701fe5a4b6.1785379072.git.zhilinz@nebusec.ai/
Link: https://lore.kernel.org/all/5bc7cd71c2d671b305f25497d88ae8a0aa663c08.1784894076.git.zhilinz@nebusec.ai/

> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index 1d9a4ac14fce..56dfa43406c2 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c

[ ... ]

> @@ -1113,7 +1114,9 @@ static int ipmr_cache_report(const struct mr_table *mrt,
>  		msg->im_vif = vifi;
>  		msg->im_vif_hi = vifi >> 8;
>  		ipv4_pktinfo_prepare(mroute_sk, pkt, false);
> -		memcpy(skb->cb, pkt->cb, sizeof(skb->cb));
> +		info = PKTINFO_SKB_CB(skb);
> +		info->ipi_ifindex = PKTINFO_SKB_CB(pkt)->ipi_ifindex;
> +		info->ipi_spec_dst = PKTINFO_SKB_CB(pkt)->ipi_spec_dst;

[Severity: High]

This isn't a bug introduced by this patch, but does the same cb-versus-IPCB
mismatch remain on the other report branch of ipmr_cache_report()?

The branch fixed here is the alloc_skb(128) one, where the rest of the
control block stays zero.  The IGMPMSG_WHOLEPKT / IGMPMSG_WRVIFWHOLE branch
builds its report differently:

net/ipv4/ipmr.c:ipmr_cache_report() {
	if (assert == IGMPMSG_WHOLEPKT || assert == IGMPMSG_WRVIFWHOLE)
		skb = skb_realloc_headroom(pkt, sizeof(struct iphdr));
	...
		skb_push(skb, sizeof(struct iphdr));
		skb_reset_network_header(skb);
	...
		ip_hdr(skb)->ihl = sizeof(struct iphdr) >> 2;
}

skb_realloc_headroom() -> pskb_copy()/skb_clone() -> __copy_skb_header()
does:

net/core/skbuff.c:__copy_skb_header() {
	memcpy(new->cb, old->cb, sizeof(old->cb));
}

so the report inherits IPCB(pkt)->opt in full, including opt.optlen and the
option offsets opt.rr/ts/srr that ip_options_compile() stored as offsets
from the network header.  Both branches then end at the same
sock_queue_rcv_skb(mroute_sk, skb), and raw_recvmsg() -> ip_cmsg_recv()
reads that cb back as IPCB().

Since the branch pushes 20 bytes and rewrites ihl to 5, aren't those
inherited offsets now 20 bytes stale, pointing into the duplicated outer
header rather than at any options?

With IP_RETOPTS set on the mroute socket, can this smash the caller's stack
buffer?

net/ipv4/ip_sockglue.c:ip_cmsg_recv_retopts() {
	unsigned char optbuf[sizeof(struct ip_options) + 40];
	struct ip_options *opt = (struct ip_options *)optbuf;

	if (IPCB(skb)->opt.optlen == 0)
		return;

	if (ip_options_echo(net, opt, skb)) {
}

net/ipv4/ip_options.c:__ip_options_echo() {
		optlen  = sptr[sopt->rr+1];
		soffset = sptr[sopt->rr+2];
		dopt->rr = dopt->optlen + sizeof(struct iphdr);
		memcpy(dptr, sptr+sopt->rr, optlen);
}

The per-option length is re-read from the packet bytes at the stale offset
with no upper bound.  For sopt->rr == 24 (four IPOPT_NOOPs ahead of the RR
option) the length byte read is sptr[25], which after the push is byte 5 of
the original IP header, i.e. the low byte of the remote sender's IP ID.
Would that let up to 255 bytes be memcpy'd into the 40-byte option area of
optbuf[], with put_cmsg(..., opt->optlen, opt->__data) then handing the
result to user space?

The path looks reachable from a received multicast packet with ihl > 5:

ip_rcv_finish_core()      /* ip_rcv_options() fills IPCB(skb)->opt */
  dst_input()
    ip_mr_input()
      ip_mr_forward()
        ipmr_cache_report(mrt, skb, true_vifi, IGMPMSG_WRVIFWHOLE)

and via ipmr_prepare_xmit()/reg_vif_xmit() for IGMPMSG_WHOLEPKT.

For IP_RECVOPTS, ip_cmsg_recv_opts() copies IPCB(skb)->opt.optlen bytes
from ip_hdr(skb) + 1, which on this branch is the inner original header
instead of its options - are those cmsg contents also wrong here?

The changelog says:

    Commit bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP
    msg") added IP_PKTINFO support by calling ipv4_pktinfo_prepare() on the
    original packet and then copying the entire 48-byte skb control block to
    the report skb.

and

    This changes the accidental IP_RECVOPTS/IP_RETOPTS behavior for these
    short cache reports, but that behavior was only a side effect of
    copying the entire control block and was never intended to work.

Given that the WHOLEPKT/WRVIFWHOLE branch has inherited the full cb via
skb_realloc_headroom() since well before bb7403655b3c, could the changelog
say that the second report path is deliberately left alone?  v2 covered
both branches, and v3 notes only "go back to the v1 scope and stop changing
the common path" without stating why the other branch is safe.

One smaller inconsistency: the WHOLEPKT/WRVIFWHOLE branch never calls
ipv4_pktinfo_prepare(), so for those reports PKTINFO_SKB_CB(skb)->ipi_ifindex
and ipi_spec_dst are really the inherited IPCB(pkt)->iif and
IPCB(pkt)->opt.faddr.  Is it intended that the two peer branches produce the
socket-visible IP_PKTINFO values by two different means?

>  		/* Add our header.
>  		 * Note that code, csum and group fields are cleared.
>  		 */
-- 
pw-bot: cr
