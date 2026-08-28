Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EEE361962;
	Fri, 28 Aug 2026 23:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787958217; cv=none; b=YS5471yt252MKYwkcV2TfQMipKSiuAvJLXG4t9OtU8nxI3joPvL6XGQCTZKDYieBPt8FKdiQojboHHmfTieXh85qqcF8M/2DWDUPC/pI286NeuzF/z9f7DFj6zteAxEszp2mV2NjDkReud3WkQQQUEfZhBGsvMXkHr6Uc3qV790=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787958217; c=relaxed/simple;
	bh=v+YS89f+4+q3haE3/qPSX8eNMFz3cbl7+YS7N5iDv/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHPmfk6IvleS3QZprryokJtdhyXssJfn4i236nczk3Lan4i/fuGbJ2TSGN5LLrpUb3o+VQSagulejmmikT+QqYi5d3AuUsNnyNziYn4hYIv9e/T4wXrKsGLMEj1shv/jD5VLRpu2Re8KC3UNpwO5hk9WZskc48LbMat3xzzLM/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpYn2gUr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpYn2gUr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF0E1F000E9;
	Fri, 28 Aug 2026 23:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787958216;
	bh=++Hst0ybRiGHOJVItpc1fL2NKTR/TtLfP1QrYAeQQiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dpYn2gUrtW6+zz6sF2cFAN9Hdk0B4DW0R1PqTZibZQpslEhoTu0XRm39IApQ18KFP
	 BM6IzWeLSmUEW6kyL8z9xIhO+dcT0/6n288UMPpf+DPEzMwStwqwkNoc8lonb6YFN2
	 Vbelp6Oq0CUHENKuk+xGjGzWiNsjuWQyZPFNJneF5wwJ7l2ePBhIH15mOd3dPD96o2
	 IH5ja4vJftB30hZ74l1yu9GevkXMVEBnq+s/RVsxAKbl9kR2XmGIbxCBXCuHsWAn01
	 xm+F+GaqP909Lam6zPmWw8NWpxEzAG0QzRjPVfD8Bc/CysXAmkWvE+/cC3SKNtyMi2
	 EBIjNa7cbSz8g==
From: Jakub Kicinski <kuba@kernel.org>
To: 4ncienth@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ip: skip IPv4 cmsgs for non-IPv4 packets
Date: Fri, 28 Aug 2026 16:03:34 -0700
Message-ID: <20260828230334.384815-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825221922.85651-1-4ncienth@gmail.com>
References: <20260825221922.85651-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ip: skip IPv4 cmsgs for non-IPv4 packets

This adds an early return to ip_cmsg_recv_offset() when skb->protocol is
not ETH_P_IP, to avoid the IPv4 ancillary-data helpers parsing an
inet6_skb_parm as an inet_skb_parm after IPV6_ADDRFORM converts a socket
with an IPv6 skb still queued.

> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index a55ef327ec932..24cb74c3d6202 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c

[ ... ]

> @@ -171,6 +172,9 @@ void ip_cmsg_recv_offset(struct msghdr *msg, struct sock *sk,
>  {
>  	unsigned long flags = inet_cmsg_flags(inet_sk(sk));
>  
> +	if (unlikely(skb->protocol != htons(ETH_P_IP)))
> +		return;
> +

[Severity: High]
Does this drop IP_PKTINFO on the ipmr cache-report upcalls?

For IGMPMSG_NOCACHE and IGMPMSG_WRONGVIF, ipmr_cache_report() builds a
fresh skb and never runs it through ip_rcv()/eth_type_trans(), so
skb->protocol stays 0:

net/ipv4/ipmr.c:ipmr_cache_report() {
	...
	if (assert == IGMPMSG_WHOLEPKT || assert == IGMPMSG_WRVIFWHOLE)
		skb = skb_realloc_headroom(pkt, sizeof(struct iphdr));
	else
		skb = alloc_skb(128, GFP_ATOMIC);
	...
	} else {
		...
		ipv4_pktinfo_prepare(mroute_sk, pkt, false);
		memcpy(skb->cb, pkt->cb, sizeof(skb->cb));
	...
	/* Deliver to mrouted */
	ret = sock_queue_rcv_skb(mroute_sk, skb);
}

The ipv4_pktinfo_prepare()/memcpy() pair was added by commit bb7403655b3c3e
("ipmr: support IP_PKTINFO on cache report IGMP msg") specifically so that
mrouted/pimd get IP_PKTINFO for these upcalls, and the cb here is a valid
in_pktinfo.  The daemon reads it through raw_recvmsg():

net/ipv4/raw.c:raw_recvmsg() {
	...
	if (inet_cmsg_flags(inet))
		ip_cmsg_recv(msg, skb);
}

With the new guard, ip_cmsg_recv_offset() returns before
ip_cmsg_recv_pktinfo(), so the cmsg is gone for every multicast route miss.

Would this also make the two upcall flavours behave differently?  The
IGMPMSG_WHOLEPKT/IGMPMSG_WRVIFWHOLE variant goes through
skb_realloc_headroom(), which copies the headers group including protocol,
so it keeps ETH_P_IP and still gets its cmsgs, while the alloc_skb() variant
does not.

The second case is the tx-timestamp error queue.  ipv4_datagram_support_cmsg()
decides cmsg support from the cb and the socket tsflags, not from
skb->protocol, and pre-fills the pktinfo that ip_recv_error() then emits:

net/ipv4/ip_sockglue.c:ipv4_datagram_support_cmsg() {
	info = PKTINFO_SKB_CB(skb);
	if (!(READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_CMSG) ||
	    !info->ipi_ifindex)
		return false;

	info->ipi_spec_dst.s_addr = ip_hdr(skb)->saddr;
	return true;
}

net/ipv4/ip_sockglue.c:ip_recv_error() {
	if (ipv4_datagram_support_cmsg(sk, skb, serr->ee.ee_origin)) {
		...
		if (inet_cmsg_flags(inet_sk(sk)))
			ip_cmsg_recv(msg, skb);
	}
}

For an IPv4 socket transmitting over a software-tagged VLAN device,
validate_xmit_skb() -> validate_xmit_vlan() -> __vlan_hwaccel_push_inside()
-> vlan_insert_tag_set_proto() sets skb->protocol = ETH_P_8021Q before the
driver calls skb_tx_timestamp().  The clone queued on the error queue then
has protocol ETH_P_8021Q, ipv4_datagram_support_cmsg() still returns true,
but the guard discards the IP_PKTINFO that SOF_TIMESTAMPING_OPT_CMSG is
meant to deliver for egress-device correlation.  The same holds for any path
that rewrites skb->protocol (for example encapsulation setting ETH_P_IPV6)
before the timestamp clone is taken.  The plain IPv4 tx path is unaffected
since ip_output() sets skb->protocol = htons(ETH_P_IP).

Would a discriminator tied more closely to the actual hazard avoid these
cases, for example rejecting only ETH_P_IPV6, gating only the cmsgs derived
from IPCB/the IPv4 header, or purging the mismatched skbs at IPV6_ADDRFORM
time?

The commit message says the change

    "preserves the queued payload while omitting incompatible ancillary data,
    and also protects callers processing a stale non-IPv4 error-queue skb."

Could this be extended to mention that intentionally supported cmsgs are
also omitted for genuine IPv4 deliveries, given the Cc: stable@vger.kernel.org
tag?
-- 
pw-bot: cr
