Received: from mta1.migadu.com (out-249.mta1.migadu.com [95.215.58.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3E83AC0C9
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 07:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790579303; cv=none; b=TzxGNlT9jzqOTnRCgdXrriZpeSu5X0TRFTIojvjyfqx5zzxjlplwwZAVf/gRjJwQWebxJzs87YkEKYOVBPOELikdNt5o3746yUaww0h0wrfkzseFq84jJIP6frW6Zuz+OWdP72lU4JtrCgUdA3fTqVFSTLgND0yuCUyH6pe6zGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790579303; c=relaxed/simple;
	bh=Eq4/Jsrc/Xy0WIgHkyzvB1RFB+j1xp3C6BXzYbZFJ34=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nr6kTpnCkVW/047YNjhbffQYUdaaVkRN1GiPBlIapAFJS8v62iCjh3jS2Cn0f74ugYgegeyD+oSXBS0SNtaWnBQ3vo/OSDvam3KyN9FuyHfYBrpSVf7fJ+izH66tjCG9B+Km5s2LShTMw44nNv31NSpgAgVZ/KuEeZKyrm5IMiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YfoOdIWi; arc=none smtp.client-ip=95.215.58.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YfoOdIWi"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Eq4/Jsrc/Xy0WIgHkyzvB1RFB+j1xp3C6BXzYbZFJ34=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790579298; v=1; x=1791184098;
 b=YfoOdIWil66zPtlT76ZHr0X8ZPVI2v9RM1RutC1ml3+9Wo0vi9ZNRIVReGAdXqWnLTz+Dqvs
 yQblRALNL5Nb3KuUVq6VxhBGU3M2tqTVzc+zRKlvWPjx1Hug3PzW36akDZIg7c4ll33ydnjmUZM
 oA4V83oLeQn+nIyyOlqjJMro=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c891efafe860e04b;
	Mon, 28 Sep 2026 07:08:18 +0000
X-Mizu-Trace-ID: c891efafe860e04b
X-Migadu-Flow: FLOW_OUT
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	ja@ssi.bg
Cc: kerneljasonxing@gmail.com,
	netdev@vger.kernel.org,
	chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	syzbot+2b120190d9e54ad8c65d@syzkaller.appspotmail.com
Subject: [PATCH net v2] ipvs: fix infinite loop with ipvlan L3 from unconditional ipvs_property clear
Date: Mon, 28 Sep 2026 15:08:25 +0800
Message-Id: <20260928070825.818002-1-chenguang.zhao@linux.dev>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

Commit de2c211868b9 ("ipvs: Always clear ipvs_property flag in
skb_scrub_packet()") moved ipvs_reset() before the xnet check, making
the call unconditional. The intent was to fix a bpf_redirect case where
stale ipvs_property on an skb re-entering the RX path caused the SNAT
hook to be skipped. However the change is too broad: when IPVS NAT
sits above an ipvlan L3 interface in the same netns, the following
loop happens:

  LOCAL_OUT -> IPVS DNAT (sets ipvs_property=1) -> dst_output -> ipvlan
    -> skb_scrub_packet() -> ipvs_reset() clears the flag
    -> ipvlan_process_v4_outbound() -> ip_local_out() -> LOCAL_OUT
    -> IPVS sees ipvs_property=0, processes again -> infinite recursion

syzbot reported this as a stack overflow on a KASAN kernel where each
level burns ~3.3 KB of stack and XMIT_RECURSION_LIMIT falls short. On
non-KASAN kernels the dead-loop detector catches it and prints "Dead
loop on virtual device", but traffic is still broken.

Fixes: de2c211868b9 ("ipvs: Always clear ipvs_property flag in skb_scrub_packet()")
Reported-by: syzbot+2b120190d9e54ad8c65d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2b120190d9e54ad8c65d
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
v2:
 add Julian into v2.

v1:
 - https://lore.kernel.org/all/20260924063312.1194019-1-chenguang.zhao@linux.dev/

 net/core/skbuff.c    | 3 +--
 net/ipv4/ip_input.c  | 1 +
 net/ipv6/ip6_input.c | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index cc3b4b70288b..6912ca0d2228 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6303,11 +6303,10 @@ void skb_scrub_packet(struct sk_buff *skb, bool xnet)
 	skb->offload_fwd_mark = 0;
 	skb->offload_l3_fwd_mark = 0;
 #endif
-	ipvs_reset(skb);
-
 	if (!xnet)
 		return;
 
+	ipvs_reset(skb);
 	skb->mark = 0;
 	skb_clear_tstamp(skb);
 }
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 9860178752b8..00f3b328e90a 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -609,6 +609,7 @@ int ip_rcv(struct sk_buff *skb, struct net_device *dev, struct packet_type *pt,
 	if (skb == NULL)
 		return NET_RX_DROP;
 
+	ipvs_reset(skb);
 	return NF_HOOK(NFPROTO_IPV4, NF_INET_PRE_ROUTING,
 		       net, NULL, skb, dev, NULL,
 		       ip_rcv_finish);
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index d332ec60f915..05917095ef6d 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -348,6 +348,7 @@ int ipv6_rcv(struct sk_buff *skb, struct net_device *dev, struct packet_type *pt
 	skb = ip6_rcv_core(skb, dev, net);
 	if (skb == NULL)
 		return NET_RX_DROP;
+	ipvs_reset(skb);
 	return NF_HOOK(NFPROTO_IPV6, NF_INET_PRE_ROUTING,
 		       net, NULL, skb, dev, NULL,
 		       ip6_rcv_finish);
-- 
2.25.1

