Received: from va-2-28.ptr.blmpb.com (va-2-28.ptr.blmpb.com [209.127.231.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C1937DAB3
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 04:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790225378; cv=none; b=ocZEnNRAhvjtw/eLcTmwi4+1JZUzrGtCKETpcZyXo/y/VPO//fYf0IvT5j2BzNsauVdmsrjshyNyWb3BE2L+phDKyrmylw+w05gy4lBznVMLRpAGJNnR82HvEwjlTPQhYPJF4CZ1vdkxthzCDINfQigPSniELUrIcVUo76DMOxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790225378; c=relaxed/simple;
	bh=SRRE5vH2xWhVM0n07zQNcBz3Xo30sw0ugh+tK08GwaI=;
	h=Content-Type:From:Subject:Cc:Date:In-Reply-To:To:Mime-Version:
	 References:Message-Id; b=YozEjmmmcJ60Npr3jEyW0QWH3B3rCZL11Kt5ldIBVXJdH2YrRDNgkMaJLmtP2jcDUN9e07/7PIdUipLPB3EJNtw2Rs2V6qSMrlvh682hUosz2zlbpLdIfJu5Un39O5vGCz1uqwMOqHWakCpUds4hn7hd0KIOoKHJ8syQye2Xlsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai; spf=pass smtp.mailfrom=moonshot.ai; dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b=MMst6vu2; arc=none smtp.client-ip=209.127.231.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b="MMst6vu2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2510091218; d=moonshot.ai; t=1790225365; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=VzWNvO+VCktud0ooksAfIolDOleAru0qNZ8v4lffjwE=;
 b=MMst6vu2BhMhcCWZCgMBroP4ECOyvrU/4uevKzh+YnoX+YbF+I7ecWtlUMx+Q9IgdwBxVs
 sIa+689g+6nYd5u5/oadads1bnIuyal8Sn9gBwVZaXmPz9iGnTmOFwMb5/V/yTZR5Q/pSw
 aRG0KTPDjFDRRL/TNmNlGNs1EP415jp9U9hBeUiKOG1v9P1kFPydxsoo7Z0AIaI2UX5R5K
 DWSizCrIrFbI6He+j7TiqrmTVveIlxPROvQdOCzismRKrlDvqKhZSuA2s6OJOMDAm8DGAw
 ycGBukkuC+XCVRTelbFayvqtrRJq2IbrxEM+re28BBkOoETLvYg1iZ/wfv+BIw==
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
From: "Yilin Zhang" <yilinzhang@moonshot.ai>
Subject: [PATCH v2] tcp: fix use-after-free of retransmit_skb_hint in tcp_send_synack()
X-Lms-Return-Path: <lba+26ab4abd3+a88dd7+vger.kernel.org+yilinzhang@moonshot.ai>
Cc: "Yilin Zhang" <yilinzhang@moonshot.ai>, <netdev@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, 
	"Kimi Security Team" <bug-report@moonshot.ai>, 
	"Weiming Shi" <shiweiming@moonshot.ai>
Date: Thu, 24 Sep 2026 12:49:00 +0800
In-Reply-To: <20260920063419.3587332-1-yilinzhang@moonshot.ai>
To: "David S . Miller" <davem@davemloft.net>, 
	"Jakub Kicinski" <kuba@kernel.org>, "Eric Dumazet" <edumazet@google.com>, 
	"Neal Cardwell" <ncardwell@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260920063419.3587332-1-yilinzhang@moonshot.ai>
X-Original-From: Yilin Zhang <yilinzhang@moonshot.ai>
Message-Id: <8a9dff4063a2745653b7e88ceb745d75efa16e68.1790224474.git.yilinzhang@moonshot.ai>
Received: from dev.msh-dev.svc.cluster.local ([117.157.206.135]) by smtp.feishu.cn with ESMTPS; Thu, 24 Sep 2026 12:49:22 +0800
Content-Transfer-Encoding: 7bit

When tcp_send_synack() replaces the cloned SYN skb at the head of the
retransmit queue with a copy, it frees the original with
tcp_rtx_queue_unlink_and_free() and only repairs tp->highest_sack.
tp->retransmit_skb_hint keeps pointing at the freed
skbuff_fclone_cache object.

The dangling hint is read in tcp_verify_retransmit_hint() and used as
the root of the rbtree walk in tcp_xmit_retransmit_queue().  An
unprivileged TFO client (sendmsg(MSG_FASTOPEN)) can arm the hint with
an attacker-supplied ICMP fragmentation-needed message, after which a
simultaneous open frees the armed SYN skb:

  BUG: KASAN: slab-use-after-free in tcp_mark_skb_lost (net/ipv4/tcp_input.c:1316)
  Read of size 4 at addr ffff88800604d928 by task swapper/1/0
  Call Trace:
   tcp_mark_skb_lost (net/ipv4/tcp_input.c:1316)
   tcp_simple_retransmit (net/ipv4/tcp_input.c:3158)
   tcp_v4_err (net/ipv4/tcp_ipv4.c:587)

Sync the hint to the copy.

Fixes: c31b70c9968f ("tcp: Add logic to check for SYN w/ data in tcp_simple_retransmit")
Reported-by: Kimi Security Team <bug-report@moonshot.ai>
Tested-by: Weiming Shi <shiweiming@moonshot.ai>
Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>
---
Changes in v2:
- Correct the Fixes: tag (Eric Dumazet).
---
 net/ipv4/tcp_output.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index d960e3de7d50..e0c392e29de5 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3886,6 +3886,7 @@ void tcp_send_active_reset(struct sock *sk, enum sk_rst_reason reason)
  */
 int tcp_send_synack(struct sock *sk)
 {
+	struct tcp_sock *tp = tcp_sk(sk);
 	struct sk_buff *skb;
 
 	skb = tcp_rtx_queue_head(sk);
@@ -3903,6 +3904,8 @@ int tcp_send_synack(struct sock *sk)
 			if (!nskb)
 				return -ENOMEM;
 			INIT_LIST_HEAD(&nskb->tcp_tsorted_anchor);
+			if (skb == tp->retransmit_skb_hint)
+				tp->retransmit_skb_hint = nskb;
 			tcp_highest_sack_replace(sk, skb, nskb);
 			tcp_rtx_queue_unlink_and_free(skb, sk);
 			__skb_header_release(nskb);
-- 
2.34.1
