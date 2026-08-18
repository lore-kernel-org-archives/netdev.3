Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4936282F1E
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787070174; cv=none; b=rJ7lMaRejzhT8PhWe3N9XnuPNDgLzaL/Cq3bkxK1rWu7nHNsdlyY9iHdB02/m9/XT1mVB5g+gXbGu5KGxUVo4QN9GS7p+BKhNAmbUjTsONCeB/OoZm8dRKCObon7Ow3TsOhMafGD0aiyJMmdQtmcMX6mbpSFZwqZOxDHLZsCTXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787070174; c=relaxed/simple;
	bh=R08ydEjlSVlKtVMsey7LWvtCm4EKMAvw1vBhLtepqBU=;
	h=From:To:Cc:Subject:Content-Type:MIME-Version; b=mI1gqN5z/LgsYpVE340qV/NdD8pXjb9P9vO8045y+y5MmhsHu/G1nJnXIrsN9CoUqCail0yOIfhsQokxWINsgtmXCsjP41T6+y7YrcJ5EmKS3kw8lbUX2LMbVhncIJ+6B9Q+heJwbCLjOagrSwZ2VtM4Myf2rF01eK5TBB4dYDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZyWBB5E9; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZyWBB5E9"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787070170; h=From:To:Subject:Content-Type:MIME-Version;
	bh=4fO+r3shhqzYosLxjQOiLfv1Ew1svlS4hKX/+9kZZYs=;
	b=ZyWBB5E9IJTdwLPEuP2i+yzYgRK49x8m0/YpOPE6NYOKB+xdek7+bmIaTboICkn6gr8ZE/fs2pTrwdS8zy54Q+tyMJn+4maVEq1bXz7ZeEhpT3JZntd0HVoelDMjmRfc4gnOplki3ocW966A2e9fgLQ9LaBZpASgW2EpqNzaoqg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=chuyf26@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X9E5Amb_1787070169;
Received: from x31j07255.sqa.na131(mailfrom:Chuyf26@linux.alibaba.com fp:SMTPD_---0X9E5Amb_1787070169 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Aug 2026 00:22:50 +0800
From: Chuyf26 <Chuyf26@linux.alibaba.com>
To: Jon Maloy <jmaloy@redhat.com>
Cc: Ying Xue <ying.xue@windriver.com>, netdev@vger.kernel.org
Subject: [PATCH] tipc: validate the size of discovery messages before parsing
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <20260818162252.x7IqMBO9ZfxD6Nut3FWzlk_CZ3zTVEYQiBO9-Wg7_Ws@z>

tipc_disc_rcv() reads the peer net hash, suggested node address and the
media address area from header words that live beyond the minimum TIPC
header size, and copies a 16 byte node identity from the message data.
tipc_msg_validate() only guarantees the minimum header size, so a
discovery message (LINK_CONFIG user) with a smaller declared header or
without data makes these accesses read past the end of the message.

The path is: a frame received on a TIPC bearer is delivered to
tipc_rcv(), which calls tipc_msg_validate() and then dispatches
non-sequential LINK_CONFIG messages to tipc_disc_rcv(). Discovery
traffic needs no established link, so any node on the bearer media can
send such a message. The accesses can read up to 52 bytes past the end
of the validated message but remain inside the skb data allocation,
where KASAN does not report them, and the values read are used as the
peer's node identity and media address.

Discovery messages are always built with the maximum size header plus a
node identity, see tipc_disc_init_msg(). Discard discovery messages
that do not carry both before accessing the fields.

Fixes: 948fa2d115c5 ("tipc: increase size of tipc discovery messages")
Reported-by: Abaci <abaci@linux.alibaba.com>
Assisted-by: abaci:qwen3.8-max
Signed-off-by: Chuyf26 <Chuyf26@linux.alibaba.com>
---
 net/tipc/discover.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/net/tipc/discover.c b/net/tipc/discover.c
index 685389d4b245..74673ca1f2d5 100644
--- a/net/tipc/discover.c
+++ b/net/tipc/discover.c
@@ -195,27 +195,47 @@ void tipc_disc_rcv(struct net *net, struct sk_buff *skb,
 {
 	struct tipc_net *tn = tipc_net(net);
 	struct tipc_msg *hdr = buf_msg(skb);
-	u32 pnet_hash = msg_peer_net_hash(hdr);
-	u16 caps = msg_node_capabilities(hdr);
+	u32 pnet_hash;
+	u16 caps;
 	bool legacy = tn->legacy_addr_format;
-	u32 sugg = msg_sugg_node_addr(hdr);
-	u32 signature = msg_node_sig(hdr);
+	u32 sugg;
+	u32 signature;
 	u8 peer_id[NODE_ID_LEN] = {0,};
-	u32 dst = msg_dest_domain(hdr);
-	u32 net_id = msg_bc_netid(hdr);
+	u32 dst;
+	u32 net_id;
 	struct tipc_media_addr maddr;
-	u32 src = msg_prevnode(hdr);
-	u32 mtyp = msg_type(hdr);
+	u32 src;
+	u32 mtyp;
 	bool dupl_addr = false;
 	bool respond = false;
 	u32 self;
 	int err;
 
+	/* Discovery messages always carry the maximum size TIPC header
+	 * plus a node identity, see tipc_disc_init_msg(). The header
+	 * fields and the media address area accessed below live beyond
+	 * the minimum header size, so discard shorter messages before
+	 * reading them.
+	 */
+	if (msg_hdr_sz(hdr) < MAX_H_SIZE ||
+	    msg_size(hdr) < MAX_H_SIZE + NODE_ID_LEN) {
+		kfree_skb(skb);
+		return;
+	}
+
 	if (skb_linearize(skb)) {
 		kfree_skb(skb);
 		return;
 	}
 	hdr = buf_msg(skb);
+	pnet_hash = msg_peer_net_hash(hdr);
+	caps = msg_node_capabilities(hdr);
+	sugg = msg_sugg_node_addr(hdr);
+	signature = msg_node_sig(hdr);
+	dst = msg_dest_domain(hdr);
+	net_id = msg_bc_netid(hdr);
+	src = msg_prevnode(hdr);
+	mtyp = msg_type(hdr);
 
 	if (caps & TIPC_NODE_ID128)
 		memcpy(peer_id, msg_node_id(hdr), NODE_ID_LEN);
-- 
2.43.5
