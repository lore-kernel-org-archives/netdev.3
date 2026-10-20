Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792509628;
	b=bJ1Ov+BqclPatD0q748CedXZL3sqp+rLsbmhedwIOEuUUflE4hNBh6f0UEvIJArVa146
	 AezIjW2TLhiP9Rdl5mqYauk4mOmkd3FCb5d1LlrwwASE2pHC/xylBhhyCcLrO8Xx0bYCy
	 dP9wmYjhFKWfdpz/QRz08Ku1jVIW8KTZi0ynernz2oxIctSueh7RdAHWRxfycZ/OUEKxT
	 BO9TqGe263XJzJqCViitJ1vzc820FjbNKYxS0jrDy95Je9ikIa6RuIu6yPco/H8MjVwnX
	 uBLvSesIeO2CBRVBWverjBLBtrH8R8eRcONkz8SkPDctJkbKdrSHHc4nMxMNT9YLbPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509628;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=p9TIKS8VDMW+tXGZ/hE86qwPZJdVFZaNx+Bs5qu9VnI=;
	b=AQp5WdnlAF4inT8VSYVKcL60rlrZd8LTUMCzk8dLbBpfBzlcfD/6IjSColM/c8S+fZyj
	 nnH3YbbavMwrpnfhZFgE2j1s65YTUm66GeWU1+mIZwqenVyymkHm6kUYeDza8/blTEJjr
	 iJTfot3VRkgsbVrla1BBB4T5AwZY5/ruoNXnFNOqPgra9MFyj8F6CXkOApIkiCxetMRLg
	 TYXP25k5gxu8RJOXWhptXZ2VC86EnWifb7DWfBcc9t8wEAvMONe5MiG6bD0pkj9O5IZ5B
	 VH1LxTDhOF6ot+lZBelIPxnXwPVLt0sL+9292Z9PnGxmBIX30CJCEgnbrpJAVnsVu9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E423606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 15:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BA91F000C4;
	Tue, 20 Oct 2026 15:20:26 +0000 (UTC)
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Stephan Lipp <Stephan@adalogics.com>
Subject: [PATCH net] net: shrink the payload-only part of skb dataref to one bit
Date: Tue, 20 Oct 2026 17:19:54 +0200
Message-ID: <20261020151954.22953-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skb_shinfo(skb)->dataref is split in two 16-bit halves: the lower
one counts all references, the upper one the payload-only (nohdr)
references.

__skb_clone() increments dataref without bound, and skb_cloned()
only checks the low 16 bits. With 65,537 references the low half
reads 1, the head looks private, and pskb_expand_head() (or
skb_unclone(), skb_cow(), ...) frees it while clones still point
to it.

An unprivileged user can reach this from a user and network namespace:
about 32,770 AF_PACKET sockets on lo bring dataref to 0x10001, then
any pskb_expand_head() on the receive path (here a pull of a large
IPv6 Hop-by-Hop header) frees the shared head:

BUG: KASAN: slab-use-after-free in _copy_to_iter+0x187/0x1330
Read of size 1590 at addr ff110001104a9002 by task dataref_wrap/87
 skb_copy_datagram_iter+0x60/0x190
 packet_recvmsg+0x1f5/0x12b0
 __sys_recvfrom+0x18d/0x290
Freed by task 87:
 kfree+0xf3/0x3b0
 pskb_expand_head+0x344/0xeb0
 __pskb_pull_tail+0xf9/0x1bf0
 ipv6_parse_hopopts+0x377/0x4f0
 ip6_rcv_core+0xc67/0x1620

The upper half never holds more than 1. It is only set by
__skb_header_release(), with atomic_set() on an skb owning its head
(TCP/SCTP output, and GRO which never sees cloned skbs).
__skb_clone() clears nohdr, and __copy_skb_header() does not copy it.

Move SKB_DATAREF_SHIFT to 30, so that the reference count gets 30 bits,
and dataref stays positive. Wrapping it would need 2^30 live clones of
a single skb, which socket buffer limits and memory make unreachable.

This issue was found by Anthropic using Claude, and validated by
Ada Logics.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Stephan Lipp <Stephan@adalogics.com>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 include/linux/skbuff.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index a3ff380d43f01db0b040573c9dd7acc4e2e2cda8..58007e5db61e0228e773dc9ee688fcd1d056a345 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -633,9 +633,9 @@ struct skb_shared_info {
  *
  * Transport layers send out clones of payload skbs they hold for
  * retransmissions. To allow lower layers of the stack to prepend their headers
- * we split &skb_shared_info.dataref into two halves.
- * The lower 16 bits count the overall number of references.
- * The higher 16 bits indicate how many of the references are payload-only.
+ * we split &skb_shared_info.dataref into two parts.
+ * The lower 30 bits count the overall number of references.
+ * Bit 30 indicates whether one of the references is payload-only.
  * skb_header_cloned() checks if skb is allowed to add / write the headers.
  *
  * The creator of the skb (e.g. TCP) marks its skb as &sk_buff.nohdr
@@ -655,7 +655,7 @@ struct skb_shared_info {
  * Having multiple payload-only skbs with different lengths of hdr_len is not
  * possible. The payload-only skbs should never leave their owner.
  */
-#define SKB_DATAREF_SHIFT 16
+#define SKB_DATAREF_SHIFT 30
 #define SKB_DATAREF_MASK ((1 << SKB_DATAREF_SHIFT) - 1)
 
 
-- 
2.53.0

