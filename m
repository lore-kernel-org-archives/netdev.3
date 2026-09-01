Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344C938F934
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 14:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272052; cv=none; b=ADzqXRYBU0a4NjWxxW+hCBBl82TBjizRJDe3pzjaRlI2zq49Ef/LjFZTOWC8ABVIzrVCAhMEGCVhe6Kf6IRJ0SSJQwIHidN83+i0OM2pXZj46gN0WXdHY0bXeLee01pUmFS6u4ROoxsejSUKEiBttVZClnfG7yA5gLLJXyyo0mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272052; c=relaxed/simple;
	bh=4LjQov3iMFs5MwQjLcBzkBmVt+Tu2p3TyDb/R80uP4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQMV2vB05xs9tOWjvoWz3BXSdeRJTzuZ4Hr5xtaR6jYh3AW08ua8XNdxWnJJLjiwnxDx9/7P8a73jXuyzj73s1iCIYqn1uBmGPnHpOucFznXWZtY7QXuSL1Ao3Lnaec3KlT3I0g8oIgOX/r157uTWdWU0GvVrsai/BJ54eNpcqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PSaW7LiE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PSaW7LiE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788272050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NyZIW+cdOyr/iLTSmQsLRne0/B7msaLaZuuH+7l9WdE=;
	b=PSaW7LiEIdbQXItkWaV2ByhroewN//0SLdTlZQMprV1kDS77YlQVMkTR4ezCfW4L8XC+Ou
	yqg3mXDNh4rQhSLyRzDaqVBGDm4VKnLtqHgo7xKd5bq4KKrOo4rNikN4pr3GWcmP1Ey1Lj
	wMFZ/bgvnBE++LL/XNIzVamg3a1wLrw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-nowusdcvOtWoGnuW4z0NXQ-1; Tue,
 01 Sept 2026 10:14:03 -0400
X-MC-Unique: nowusdcvOtWoGnuW4z0NXQ-1
X-Mimecast-MFC-AGG-ID: nowusdcvOtWoGnuW4z0NXQ_1788272041
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC18819775A9;
	Tue,  1 Sep 2026 14:14:01 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.14])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 99DDF30001A2;
	Tue,  1 Sep 2026 14:13:58 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: 4ncienth@gmail.com
Cc: netdev@vger.kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] ip: skip IPv4 cmsgs for non-IPv4 packets
Date: Tue,  1 Sep 2026 16:13:52 +0200
Message-ID: <20260901141352.236286-1-pabeni@redhat.com>
In-Reply-To: <20260829144847.1738294-1-4ncienth@gmail.com>
References: <20260829144847.1738294-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
ip: skip IPv4 cmsgs for non-IPv4 packets

The patch adds an early return to ip_cmsg_recv_offset() when the network
header version nibble is not 4, so that SOL_IP ancillary data is not
generated from a non-IPv4 header.  The stated motivation is an
IPV6_ADDRFORM converted UDP socket that still has native IPv6 skbs queued,
where IP_RETOPTS reads inet6_skb_parm as inet_skb_parm.

No Link: tags are present in the commit header.

> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index a55ef327ec93..01d264e8f34e 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -174,6 +174,9 @@ void ip_cmsg_recv_offset(struct msghdr *msg, struct sock *sk,
>  	if (!flags)
>  		return;
>  
> +	if (unlikely(ip_hdr(skb)->version != IPVERSION))
> +		return;
> +

[Severity: Medium]
Is the guard in the right place for the IPV6_ADDRFORM scenario described in
the changelog?

The root cause named in the commit message is in
do_ipv6_setsockopt()/IPV6_ADDRFORM, which switches sk_prot to &udp_prot,
sk_socket->ops to &inet_dgram_ops and sk_family to PF_INET, clears
np->rxopt.all and calls inet6_cleanup_sock(), but never purges
sk_receive_queue or sk_error_queue:

net/ipv6/ipv6_sockglue.c:do_ipv6_setsockopt() {
	...
	/* Disable all options not to allocate memory anymore,
	 * but there is still a race.  See the lockless path
	 * in udpv6_sendmsg() and ipv6_local_rxpmtu().
	 */
	np->rxopt.all = 0;

	inet6_cleanup_sock(sk);
	...
}

So the already queued native IPv6 skbs are still dequeued by udp_recvmsg(),
which is unchanged by this patch:

net/ipv4/udp.c:udp_recvmsg() {
	...
		sin->sin_family = AF_INET;
		sin->sin_port = udp_hdr(skb)->source;
		sin->sin_addr.s_addr = ip_hdr(skb)->saddr;
	...
}

Does that mean userspace still gets bytes 12..15 of the ipv6hdr (the middle
of the IPv6 source address) reported as an IPv4 peer address, and a source
port read from the wrong offset when extension headers are present, with no
error indication?

The error queue looks similar.  ip_recv_error() computes

	sin->sin_addr.s_addr = *(__be32 *)(skb_network_header(skb) +
					   serr->addr_offset);

with an addr_offset produced by the IPv6 code against an ipv6hdr, and
ipv4_datagram_support_cmsg() fills ipi_spec_dst from ip_hdr(skb)->saddr and
returns true to request cmsgs which the newly guarded callee then silently
drops.  Is it intended that the caller keeps interpreting the header as
IPv4 while the callee now refuses to?

Related to that, ipv6_recv_error() in net/ipv6/datagram.c discriminates on
skb->protocol before calling ip_cmsg_recv(), while this patch chooses the
header version nibble.  Should the two sides use the same test, given the
commit message explicitly argues skb->protocol is not a reliable
discriminator?

The reads above all stay inside the 40-byte IPv6 header, so this is wrong
data rather than corruption.  Could the changelog say that the remaining
family confusion is knowingly left in place?  As written, "the original
trigger returned its payload without a control message" reads as though the
ADDRFORM confusion is handled, which matters for stable backports.

[Severity: Medium]
The early return is placed ahead of every SOL_IP handler, including the
ones that never dereference the IP header.  Is that intended?

ip_cmsg_recv_checksum() reads only skb->csum and skb_transport_offset():

net/ipv4/ip_sockglue.c:ip_cmsg_recv_checksum() {
	__wsum csum = skb->csum;

	if (skb->ip_summed != CHECKSUM_COMPLETE)
		return;
	...
}

ip_cmsg_recv_fragsize() reads only the control block:

net/ipv4/ip_sockglue.c:ip_cmsg_recv_fragsize() {
	if (IPCB(skb)->frag_max_size == 0)
		return;
	...
}

and ip_cmsg_recv_security() gets its data from the LSM:

net/ipv4/ip_sockglue.c:ip_cmsg_recv_security() {
	err = security_socket_getpeersec_dgram(NULL, skb, &secid);
	...
}

Does gating those on the network header version drop IP_CHECKSUM,
IP_RECVFRAGSIZE and SCM_SECURITY for skbs where they were previously
delivered?

One concrete case where IP_PKTINFO also disappears: an AF_INET UDP socket
with SO_TIMESTAMPING(SOF_TIMESTAMPING_TX_SOFTWARE |
SOF_TIMESTAMPING_OPT_CMSG) and IP_PKTINFO, whose traffic egresses through a
tunnel with a non-IPv4 outer header (ip4ip6, or vxlan/geneve over IPv6).
The software TX timestamp clone is taken in the physical driver's
skb_tx_timestamp() -> skb_tstamp_tx() after encapsulation, so
skb->network_header points at the outer ipv6hdr while skb->sk survives
(skb_scrub_packet() does not orphan the skb), and
__skb_complete_tx_timestamp() sets serr->header.h4.iif = skb->dev->ifindex.
ipv4_datagram_support_cmsg() then commits to emitting cmsgs:

net/ipv4/ip_sockglue.c:ipv4_datagram_support_cmsg() {
	...
	info->ipi_spec_dst.s_addr = ip_hdr(skb)->saddr;
	return true;
}

after which ip_recv_error() calls ip_cmsg_recv() and the new guard drops
everything, including the valid egress ipi_ifindex that userspace received
before this change.

Would applying the version test only to the handlers that actually
dereference the IPv4 header (PKTINFO/TTL/TOS/RECVOPTS/RETOPTS/ORIGDSTADDR)
avoid that?

For the record, the retransmit-queue timestamp clones on TCP are not
affected here: those skbs have skb->dev == NULL, so h4.iif == 0 and
ipv4_datagram_support_cmsg() returns false before ip_cmsg_recv() runs.

[Severity: High]
This isn't a bug introduced by this patch, but does the version check
establish the invariant the underlying write actually needs?

__ip_options_echo() takes every copy length from packet bytes with no bound
against its destination:

net/ipv4/ip_options.c:__ip_options_echo() {
	...
		optlen  = sptr[sopt->rr+1];
		soffset = sptr[sopt->rr+2];
		dopt->rr = dopt->optlen + sizeof(struct iphdr);
		memcpy(dptr, sptr+sopt->rr, optlen);
	...
}

and the same pattern is used for ts, srr and cipso, while the destination
is a 40-byte stack buffer:

net/ipv4/ip_sockglue.c:ip_cmsg_recv_retopts() {
	unsigned char optbuf[sizeof(struct ip_options) + 40];
	struct ip_options *opt = (struct ip_options *)optbuf;

	if (IPCB(skb)->opt.optlen == 0)
		return;
	...
}

Safety depends on IPCB(skb)->opt having been compiled by
ip_options_compile() against the header skb_network_header(skb) currently
points at, since the offsets are stored as opt->rr = optptr - iph.  Checking
ip_hdr(skb)->version does not say anything about that, so does a
metadata/header offset mismatch with a version nibble of 4 still reach the
memcpy above?

ipmr_cache_report() looks like such a case for IGMPMSG_WHOLEPKT and
IGMPMSG_WRVIFWHOLE.  The report is built from
skb_realloc_headroom(pkt, sizeof(struct iphdr)), and both pskb_copy() and
skb_clone() copy skb->cb verbatim, so the forwarded packet's IPCB->opt is
inherited.  Then:

net/ipv4/ipmr.c:ipmr_cache_report() {
	...
	skb_push(skb, sizeof(struct iphdr));
	skb_reset_network_header(skb);
	skb_reset_transport_header(skb);
	msg = (struct igmpmsg *)skb_network_header(skb);
	memcpy(msg, skb_network_header(pkt), sizeof(struct iphdr));
	...
}

The network header is re-based 20 bytes lower than the header those offsets
were compiled against, and IPCB(skb)->opt is not reset.  Delivery is via
sock_queue_rcv_skb() to the mroute raw socket, so raw_rcv() and
ipv4_pktinfo_prepare() are bypassed and the inherited opt fields stay
intact, and raw_recvmsg() then does:

net/ipv4/raw.c:raw_recvmsg() {
	...
	if (inet_cmsg_flags(inet))
		ip_cmsg_recv(msg, skb);
	...
}

With IP_RETOPTS set on the mroute socket and a forwarded multicast packet
carrying a well-formed Record-Route option (opt.optlen != 0, opt.rr == 20),
does sptr[opt.rr+1] resolve to byte 1 of the original iphdr, that is the
remotely controlled TOS byte, and copy up to roughly 212 bytes of packet
data past optbuf on the kernel stack?  Note SRR is rejected for multicast
but RR is not, and the entry point is ipmr_prepare_xmit() calling
ipmr_cache_report(mrt, skb, vifi, IGMPMSG_WHOLEPKT) for VIFF_REGISTER vifs,
so this needs CONFIG_IP_PIMSM_V2 and a PIM register vif plus IP_RETOPTS on
the mroute socket.

Would clamping optlen and dopt->optlen against the destination size inside
__ip_options_echo() cover the whole class rather than one trigger?
-- 
This is an AI-generated review.

