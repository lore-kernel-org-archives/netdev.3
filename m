Received: from mx.sorah.jp (aapne1a.mx.sorah.jp [3.112.186.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60793472F7D;
	Tue, 13 Oct 2026 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.112.186.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791887563; cv=none; b=BZuadjLCqE+ETAuaI+aNXho0MAQyw+NVVuMMiulHpsixcaQJ77w1j/0eeyr8lQukKv+lQZQizMDEvnhaoCka12sBhL+no8/yweXlVdPfvyRZxLsJSSexGKs2Ym8PpT5tJdehnZdosen4fA0tDaP4Vfu7r+cTg3AKpANNnv7UMIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791887563; c=relaxed/simple;
	bh=N7JPdNdqfZFEyw+Thoc3clrRYjinca0sWkeQwt5Q7MM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mBqvu/UH368rFi6tSsOpXsbitvoo8aK5doXqWJrUraUin0zgztNyqVkSsa49W+UIhPnsFppPNoLk2RbBXNiB5xxDSCDn5egDttZQSZ+vo3H083kZ3tVq3XUeTkja6iqmHqHwBLddkgQPs4YNSiFBAY5krIoB8kf/9nZAYJti/zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sorah.jp; spf=pass smtp.mailfrom=sorah.jp; dkim=pass (2048-bit key) header.d=sorah.jp header.i=@sorah.jp header.b=mZ9twbV2; arc=none smtp.client-ip=3.112.186.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sorah.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sorah.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sorah.jp header.i=@sorah.jp header.b="mZ9twbV2"
Received: from mafuyu (home.igw.nkmiusercontent.com [192.50.220.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx.sorah.jp (Postfix) with ESMTPSA id 1A89660547;
	Tue, 13 Oct 2026 10:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sorah.jp;
	s=nkmi1707srhjp; t=1791887105;
	bh=N7JPdNdqfZFEyw+Thoc3clrRYjinca0sWkeQwt5Q7MM=;
	h=From:To:Cc:Subject:Date;
	b=mZ9twbV2jPffNq5AwkjXvRaNrB5zij/M4wKSCbO9qVYCqmOuG3QXPeZW3FhW8QJhI
	 rsEH4U933s28U6ON6+Wnh/twJ5JIVlLceGlKsKVzndy7tGiLEMpOmqJQTqPyDJRzeH
	 omb+MKITXKsZsex08cgKyXdSxX7kakgbXpTYUEfNd63uAxwN+4TQUXcKc5zWqdiHVq
	 LkDFMl3/8k7iRGxnag9Bt17m94ArtM4wgZWjg/K56YiVTOuTqK2cvHlok3O/RUtlYn
	 Un7UZLqRHLDF/rAubuVGmrWDVa6UsxJhZKApBO2qFaC6/or1ASGI7Chiop+6Re8g4D
	 fKeSPtKVxenjQ==
From: Sorah Fukumori <her@sorah.jp>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	willemb@google.com,
	lixiaoyan@google.com,
	linux-kernel@vger.kernel.org,
	Sorah Fukumori <her@sorah.jp>
Subject: [PATCH] net: gro: don't chain linear parts larger than gso_size into frag_list
Date: Tue, 13 Oct 2026 19:24:45 +0900
Message-ID: <20261013102453.3272620-1-her@sorah.jp>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skb_gro_receive() chains an skb into the frag_list of the held packet
when its payload cannot be attached as page frags, i.e. when its head
is not a page fragment and still holds payload. Since commit
5eddb24901ee ("gro: add support of (hw)gro packets to gro stack"), that
skb may itself be a GSO packet whose linear part holds several
gso_size segments. skb_segment() cannot split the linear part of a
frag_list member across segments, so segmenting the aggregate in
software, e.g. when forwarding it to a device without NETIF_F_FRAGLIST,
hits

  BUG_ON(skb_headlen(list_skb) > len);

Fully linear GSO packets come from generic XDP. When the program does
not support frags, netif_skb_check_for_xdp() linearizes any nonlinear
skb with pskb_expand_head() and skb_linearize() and keeps its GSO
metadata. GRO on the device runs before generic XDP, so each aggregate
passed by the program carries all of its payload in a kmalloc'ed head.
A tunnel that decapsulates these packets and runs GRO again through
gro_cells then builds the bad frag_list. This was first seen on a
router that forwards TCP received over VXLAN, with a non-frags XDP
program attached in SKB mode to the underlying bond because one slave
lacks native XDP:

  kernel BUG at net/core/skbuff.c:4917!
  RIP: 0010:skb_segment+0xbb6/0xf40
  Call Trace:
   tcp_gso_segment
   ipv6_gso_segment
   skb_mac_gso_segment
   __skb_gso_segment
   validate_xmit_skb
   __dev_queue_xmit
   ip6_output
   ip6_sublist_rcv_finish
   ipv6_list_rcv
   netif_receive_skb_list_internal
   gro_complete
   dev_gro_receive
   gro_receive_skb
   gro_cell_poll
   __napi_poll
   net_rx_action

It reproduces with three network namespaces: TCP sent over VXLAN on an
IPv6 veth link to a router namespace that has an XDP_PASS program
without frags support attached to the underlay veth in generic mode
and GRO enabled on its VXLAN device, and forwards to a veth with
tx-scatter-gather-fraglist disabled.

Refuse the merge when the linear part to be chained exceeds the held
packet's gso_size. tcp_gro_receive() then flushes the held packet and
the skb starts a new GRO packet as its head, whose linear length
skb_segment() handles.

Fixes: 5eddb24901ee ("gro: add support of (hw)gro packets to gro stack")
Cc: stable@vger.kernel.org
Assisted-by: claude-opus-5-5
Signed-off-by: Sorah Fukumori <her@sorah.jp>
---
 net/core/gro.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/gro.c b/net/core/gro.c
index 29b4d02bf519..ff828a3dce3c 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -187,6 +187,10 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 	}
 
 merge:
+	/* skb_segment() cannot split the linear part of a frag_list member. */
+	if (unlikely(headlen > offset + skb_shinfo(p)->gso_size))
+		return -E2BIG;
+
 	/* sk ownership - if any - completely transferred to the aggregated packet */
 	skb->destructor = NULL;
 	skb->sk = NULL;
-- 
2.55.0

