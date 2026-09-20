Received: from sg-3-28.ptr.tlmpb.com (sg-3-28.ptr.tlmpb.com [101.45.255.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C203DAAB7
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 06:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789886136; cv=none; b=pS0RsuHi9Z1z7IFEEo+Jrtky6dH+IihSYoKlTkIZuEfzypY0RM6EvuqrKYkvQhhin0PCDZh7q3Kns+tjaWk5tR4NMM661FT8hLtswEG7KV+hj1kGVXrOtAsVOFSoF0xtdjpB8JOSP+y/qkZQAZIDz9lOxnvuwu/4qZKvqbuElbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789886136; c=relaxed/simple;
	bh=d5KQxVbLkqAO4A+4BPQdvJPNB/nioQ1Gkb29qs+AlLg=;
	h=Date:Content-Type:To:Cc:Subject:Message-Id:Mime-Version:From; b=U+h9prrpWPx5njaLUjslsFpq6/VcJ2QhJCeNdsOFL8CpveK7I2eLt3OW3p5U9BcJc+Ag1mGvzm0cJR0eqT1U90ZHNvewlE2ZLltZOnpnXxT1/kIBI6hQOU05WEV+PwATsgSLrJqWN8/jQYiQzS8OyC7+MSwAAj2L6TyO6XGgTQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai; spf=pass smtp.mailfrom=moonshot.ai; dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b=HvkDgpwd; arc=none smtp.client-ip=101.45.255.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b="HvkDgpwd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2510091218; d=moonshot.ai; t=1789886080; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=tZ76PrfQ1pCD6Nj0qQzyDWKZAm9N2KnC0ZB5YZcoAMI=;
 b=HvkDgpwduloUKVlnyJKPXQAGx2s1Trcz+Ecs6kY2A9xxy3rUwn/JPN/oHJ2avue0pWeYxF
 minhWgvGpaCMpxIxk/n0/v1hgN+wrACjbEFkZZPzzN4QisURx6qopo17ThLNwFZeIlfOzY
 DmdR+kEdPLn3S+Hy5afy0ax/VQnAasQira/KO2pg6XUOJXR5brmimXM8FHpleiGdllFZ2+
 KEsbmOQTgGu/hgZ0zovaGb5N/AYhayAH2tLZeVhQ7N6snK50lmEsR/ip/8ZOMgOkQifrZG
 2Q6sDWQQ1ha3NNH+pA+q4FmNsUJV2/16cBiEGGcNy4WtZ4vmpHNBbV2c4VEY+Q==
Date: Sun, 20 Sep 2026 14:34:19 +0800
X-Mailer: git-send-email 2.34.1
X-Lms-Return-Path: <lba+26aaf7e7e+008b1a+vger.kernel.org+yilinzhang@moonshot.ai>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
To: "David S. Miller" <davem@davemloft.net>, 
	"Eric Dumazet" <edumazet@google.com>, 
	"Neal Cardwell" <ncardwell@google.com>
Received: from dev.msh-dev.svc.cluster.local ([117.157.206.135]) by smtp.feishu.cn with ESMTPS; Sun, 20 Sep 2026 14:34:37 +0800
Cc: "Yilin Zhang" <yilinzhang@moonshot.ai>, <netdev@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, 
	"Kimi Security Team" <bug-report@moonshot.ai>, 
	"Weiming Shi" <shiweiming@moonshot.ai>
Subject: [PATCH] tcp: fix use-after-free of retransmit_skb_hint in tcp_send_synack()
Message-Id: <20260920063419.3587332-1-yilinzhang@moonshot.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Yilin Zhang <yilinzhang@moonshot.ai>
From: "Yilin Zhang" <yilinzhang@moonshot.ai>

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

Fixes: 75c119afe14f ("tcp: implement rb-tree based retransmit queue")
Reported-by: Kimi Security Team <bug-report@moonshot.ai>
Tested-by: Weiming Shi <shiweiming@moonshot.ai>
Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>
---
 net/ipv4/tcp_output.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 3b320ee77..498c9819a 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3694,6 +3694,7 @@ void tcp_send_active_reset(struct sock *sk, gfp_t priority,
 int tcp_send_synack(struct sock *sk)
 {
 	struct sk_buff *skb;
+	struct tcp_sock *tp = tcp_sk(sk);
 
 	skb = tcp_rtx_queue_head(sk);
 	if (!skb || !(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN)) {
@@ -3710,6 +3711,8 @@ int tcp_send_synack(struct sock *sk)
 			if (!nskb)
 				return -ENOMEM;
 			INIT_LIST_HEAD(&nskb->tcp_tsorted_anchor);
+			if (skb == tp->retransmit_skb_hint)
+				tp->retransmit_skb_hint = nskb;
 			tcp_highest_sack_replace(sk, skb, nskb);
 			tcp_rtx_queue_unlink_and_free(skb, sk);
-- 
2.43.0
