Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A8837B400
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787839676; cv=none; b=o2ioVpWNwgqWMziRW4DFyhWLWJqecK0k85kqd8VqH6gjoeAf7DEutBERU+pNnmyaKW9NsV/APK/6wcEYQy6tQDN4RCAxCXyYJNq7qElRudoCG6AwV+3h4TQ3VKRMpst2Jfx/WoL+cEoFY7jGOYan8YXrgwawPR4S+w0nfI7CLD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787839676; c=relaxed/simple;
	bh=+ciPl3/mLFgpvo1njgY75oEIlCiA/sU3D3DllCFwnm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=saJ+vpaJTHFtTDHIEyrKmk1gp83FSdt6n8d2BfVZkMesRzzli/kr4qXYoMX0gb2KIJv8hM0IFNvMnjv+5I8W5+JNVjb2asyUr5gpntcRZH4TLEvdbKyF4+iOQZp9MSABvrDf+bx4iEmFAEPJlPwlKWlBb+yzTxpEQq/r1ip2bY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ciUbor1J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ciUbor1J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787839664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CzR6A+BIiEoqvwSCIdFJiW75M7DsswKBnPGYvG71oTM=;
	b=ciUbor1Jju/UNh0r/nhyj5BuRuhLTxzlNLgsYqot480ZyvoIZQElfx3RMs1Lio3B0uHX5w
	/VHvrqHtjNzhbh33V+uM8NCSH906AASdkSzwxlPqacjS/hrKESXTMUa3Yga2g9IhJsubFq
	/6/3qy9pC0mIG8wtNoojWPTlPkhh1hE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-e4GPXzNpOva9frK6c6qP9g-1; Thu,
 27 Aug 2026 10:07:40 -0400
X-MC-Unique: e4GPXzNpOva9frK6c6qP9g-1
X-Mimecast-MFC-AGG-ID: e4GPXzNpOva9frK6c6qP9g_1787839658
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3528D1933E8F;
	Thu, 27 Aug 2026 14:07:38 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.49])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EC9BA1955F71;
	Thu, 27 Aug 2026 14:07:34 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH net] inet: frags: strip GSO state from fragments before reassembly
Date: Thu, 27 Aug 2026 16:07:07 +0200
Message-ID: <937926e509f2acd8e0e66520dc2b30fd6b4d1687.1787839506.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Xinyang Ge <xinyang@anthropic.com>

A virtio_net_hdr (tun/tap, or AF_PACKET with PACKET_VNET_HDR) can mark
an IPv4 or IPv6 fragment as GSO; nothing relates gso_type to frag_off.
inet_frag_reasm_prepare()/inet_frag_reasm_finish() keep the first
fragment's skb as the head of the reassembled datagram, including its
shinfo->gso_size/gso_type/gso_segs, and chain the remaining fragments
on frag_list with whatever linear/paged layout they arrived with.

After ip_defrag() (ip_local_deliver(), nf_defrag_ipv4, ...) the
reassembled skb therefore still claims to be GSO (SKB_GSO_DODGY), and
the next software segmentation point - udp_rcv_segment() on local
delivery, validate_xmit_skb(), or the ip_finish_output_gso() slow
path - hands it to skb_segment(). skb_segment()'s frag_list walk
assumes GRO-shaped input and hits one of its BUG_ON()s. Two writes to
a tap by an unprivileged user in its own userns are enough:

  kernel BUG at net/core/skbuff.c:4899!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  CPU: 0 UID: 1000 PID: 82 Comm: poc Not tainted 7.2.0-pentest+ #2
  RIP: 0010:skb_segment+0x20ca/0x48b0
  Call Trace:
   <TASK>
   __udp_gso_segment+0x29a/0x27d0
   udp4_ufo_fragment+0x458/0x6c0
   inet_gso_segment+0x429/0x1340
   skb_mac_gso_segment+0x233/0x4f0
   __skb_gso_segment+0x308/0x660
   udp_queue_rcv_skb+0x440/0xad0
   udp_unicast_rcv_skb+0xc7/0x2c0
   udp_rcv+0x16ce/0x2260
   ip_protocol_deliver_rcu+0x197/0x2d0
   ip_local_deliver+0x430/0x690
   ip_rcv+0x16f/0x1f0
   __netif_receive_skb_one_core+0x15e/0x1c0
   __netif_receive_skb+0x1e/0x110
   netif_receive_skb+0xf6/0x5c0
   tun_rx_batched.isra.0+0x3ab/0x790
   tun_get_user+0x17c3/0x3550
   tun_chr_write_iter+0xba/0x1b0
   vfs_write+0x646/0x1130
   </TASK>
  Kernel panic - not syncing: Fatal exception in interrupt

This runs with BH disabled, so it is a panic rather than an oops. The
same is reachable with CAP_NET_RAW in a netns where a defrag point
precedes a GSO point, and from a guest whose VMM forwards
virtio_net_hdr to a tap. The SKB_GSO_DODGY frag_list checks added by
commit 3dcbdb134f32 ("net: gso: Fix skb_segment splat when splitting
gso_size mangled skb having linear-headed frag_list") and by
commit 9e4b7a99a03a ("net: gso: fix panic on frag_list with mixed head
alloc types") do not cover it: page-backed heads skip them, and kmalloc
heads skip them when gso_size == skb_headlen(head), which the sender
controls.

An skb entering a frag queue is an IP fragment by definition and
cannot legitimately carry GSO state: GRO does not merge fragments and
the stack segments before it fragments, so only untrusted sources are
affected. This has been reachable since
commit f43798c27684 ("tun: Allow GSO using virtio_net_hdr"), the first
path that let userspace attach GSO metadata to an IP fragment. Reset
the GSO fields of every fragment as it is queued, in
inet_frag_queue_insert(), which IPv4, IPv6, nf_conntrack_reasm and
6lowpan reassembly share; then neither the head nor the frag_list
members of the reassembled skb carry them (the members matter too:
the ip_do_fragment()/ip6_fragment() fast paths send them out as they
are). The head may remain CHECKSUM_PARTIAL; that is already accepted
on receive and resolved by skb_checksum_help() in
ip_do_fragment()/ip6_fragment() on forward.

Tested on top of net.git (dc4b95b8fee9), x86_64: the tap reproducer
above, two further IPv4 frag_list geometries that reach
BUG_ON(i >= nfrags) and BUG_ON(!list_skb->head_frag), and an IPv6
fragment-header variant (udp6_ufo_fragment()) each panic the unpatched
kernel; with this patch all four datagrams are delivered intact and
nothing is logged.

Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
Cc: stable@kernel.org
Suggested-by: Eric Dumazet <edumazet@google.com>
Assisted-by: Claude:unspecified
Signed-off-by: Xinyang Ge <xinyang@anthropic.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv4/inet_fragment.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index fc0cb993959f..c17e57ec7d5c 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -435,6 +435,13 @@ int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
 {
 	struct sk_buff *last = q->fragments_tail;
 
+	/* An IP fragment is never a GSO packet, but an untrusted source
+	 * (virtio_net_hdr) may have attached GSO metadata to it. Do not let
+	 * that reach the reassembled skb, whose head keeps the first
+	 * fragment's shinfo and whose frag_list is not GRO-shaped.
+	 */
+	skb_gso_reset(skb);
+
 	/* RFC5722, Section 4, amended by Errata ID : 3089
 	 *                          When reassembling an IPv6 datagram, if
 	 *   one or more its constituent fragments is determined to be an
-- 
2.55.0

