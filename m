Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2332DF142
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784313058; cv=none; b=M1lW87OGneZ3L/+HQONl59bhbPZai57yW413d1jiyxXCMLlZzgk6y/nkljc92K8/pLQTFtd+ez8Wh0XKSJT0eHX/4jZnKmNWdtN1qaUu5Mp8kXt3atxSMzyQiz8rtv8ksl59prAW/pGIfUvX5YWLwJqHVJYTbnzRcp4Ad3XvE5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784313058; c=relaxed/simple;
	bh=kQ5xYTtim9/FrRYzRcX9YWlL98wlinY6g363VXSlEK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lznlmU5DkWG49QUh5eDq1NfkbTZWJBwc/jIjMD//KDpx/lf0/VSiH+b+K1qRVk7CDX7OGBUMHdc4WfCb9Htn0ga7loH64LzLoWSFvAjQjT2LQegtNDPyb36VEb6g5dL/GW9g6bSupAEaryo99twj4GvcLhqIivkMwoYbOssSBVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIfBiRw/; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIfBiRw/"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84a2dcec51cso7105875b3a.3
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 11:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784313057; x=1784917857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/rbKPcjhxr3kyBN2i9c/BoOHgzV3a4F1TFOKfwG/+Xo=;
        b=fIfBiRw/o3TUb9iECTvt/lDeNT38R9yYJ5JyBk+9VJQ2BVS66f8nBTWXWmulSczoio
         pIGH+0g8RNlvOiMplBDP47n21gcy4VBe+0ZiuMA15P1aNcfnNolP3Vd+ZHWzdJh4Gawz
         0ePpyDzyOp2QJxAItnwzPDcFRGPjROsBn9L9gUPVp9UcwAsE15Zi9j5XPvqDMXHJC9kQ
         dGCq6XTRbJPc5UzFSgIf2c8gllUZ6qqTqiKZrZJaDI5YR6YHXZB6ud29hdwhQqFrxVk/
         KGcJdN4dZlIwDIqYTPzW3aC4HpDWAoE/VYNESwqfrcbmMUMQZw3X5mhT7hYweD6I0r3I
         zRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784313057; x=1784917857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/rbKPcjhxr3kyBN2i9c/BoOHgzV3a4F1TFOKfwG/+Xo=;
        b=REcoDb01we8Bi5wRjLrQwrIpS9XOsTOIzOL9dI+aZgADWboS30PTsD2FB7WrQb4Vlj
         bR63WuMCUsydoXA0HlS/+lavkTFKqj+CJsto3gMBXuD71yjwGm4KBZGH2GJ2kmJ4K76s
         k0tZWhCBqxYsjX1+bZF0N474fDVUIHms3osQN8yQfp9GD0MTkwTP9rJ4rUnS0V7+sbO1
         1mMCvBywGxb5fDGWvKTBrWvaV8DyzphJ4wXnR0l6mF6Cn+hdg4ieNQvgczcf6YEPkLPq
         LSVrMKF1YqSZKQ8+57wkPfWBDk5g4MUKUl6g3VVcZqhBOUNF9XdBhyPxoF9nP8aBy/oZ
         UH+w==
X-Forwarded-Encrypted: i=1; AHgh+RphI2/QC/aLrNzMXmxjhXnDaFp60IGpP6QJ4HEUMQjtdDg2TJyoVn9FgqrS3m7invwn/wuyVUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBYiBhT2KY75GrtoSUH+u5flU/qn6okCbHHWEzz24JC+Cf+081
	1bAekquUFWPY89u9pxTzRncPNTIopBJo/UzsD0PtJDQf6TzMz8kPsgID
X-Gm-Gg: AfdE7cm72EcYtJ8aelBjoEcv47kfrUVSU7pqgenqVXm53ElcwQCJD7rZJckzNaAj++E
	EG0ISHTs/CBOpNIF+CKlcPFdFkCAmuRR2KQhBs0CTTq2pM+Pe6lYMfWM8UvwP27vpK2X1ratgoe
	ZqALilT3cfXIbbjC9GLVugpUuNlFuHui/D1svCj2QTEmEmyxkF2EbHRDUG+bpX0YsKnDXOUwH6Y
	NbUUSIo5rtBp5a+SODL1PU//bMjKqMYsNTENhvQZl/QmMrak2R0kkXwnIesQZDxc7FEjD9UNUyw
	ByMy2R1JRjgjnK3oNFk4kYQRC3gPk/Wwy332aMBnM+rX0ZYVP++JzvGKE5H/1sFsjxz3HjLTk2L
	FEXPz+8Tr4rWrBzI+QrGReypLVYluQaIFuCmvlQ+9bNRAvIBXXqnxu0rgeFTlpgszBpSTpegKGa
	pVkCqlxkA576tV+wJuxhbsOH7isXOICE+T2YV7sRcuWi/xyo8L
X-Received: by 2002:a05:6a00:bd88:b0:848:2f84:72f with SMTP id d2e1a72fcca58-84c294c5ff5mr3856332b3a.66.1784313056682;
        Fri, 17 Jul 2026 11:30:56 -0700 (PDT)
Received: from kimi-bug-hunter.. ([8.219.140.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2afd07e2sm1565255b3a.61.2026.07.17.11.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:30:56 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Cc: Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hoang Huu Le <hoang.h.le@dektech.com.au>,
	kernel test robot <lkp@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v5 1/2] tipc: fix NULL deref in tipc_named_node_up() on empty publication list
Date: Sat, 18 Jul 2026 02:30:45 +0800
Message-ID: <20260717183047.2725959-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717183047.2725959-1-bestswngs@gmail.com>
References: <20260717183047.2725959-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tipc_net_finalize() does not check the return value of
tipc_nametbl_publish(). If the publish fails, for example on a
GFP_ATOMIC allocation failure, the node state name never lands in
cluster_scope, but tn->finalized is still set. A worker deferred by
tipc_named_node_up() then wakes and calls named_distribute() with an
empty list and hits the same NULL dereference in
buf_msg(skb_peek_tail(list)) as the original bug, this time on the
tipc_node_dist_bulk workqueue. The reported crash:

 KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
 RIP: 0010:tipc_named_node_up (net/tipc/name_distr.c:196)
  tipc_named_node_up (net/tipc/name_distr.c:196 net/tipc/name_distr.c:221)
  tipc_node_write_unlock (net/tipc/node.c:428)
  tipc_rcv (net/tipc/node.c:2185)
  tipc_udp_recv (net/tipc/udp_media.c:392)
 Kernel panic - not syncing: Fatal exception in interrupt

Check the publish result and warn on failure, but still set finalized,
otherwise deferred workers would sleep forever. In
tipc_named_dist_cluster_scope() re-check cluster_scope after the wait
and skip the distribution when it is empty. This is a permanent
condition, so return 0 instead of an error, otherwise the link would
be bounced forever. Also guard the tail stamp in named_distribute()
itself, so a caller that misses the precondition gets a warning and a
link reset through the existing -ENOBUFS path instead of a crash.

Reproducing this needs an allocation failure during finalize, so I
verified it by stubbing out the publish call: both nodes log the
failure, the workers skip the distribution, no crash, no link flap.
The normal path is unchanged with the same two-node test.

Fixes: cad2929dc432 ("tipc: update a binding service via broadcast")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/tipc/name_distr.c | 11 +++++++++++
 net/tipc/net.c        |  3 ++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index b764274df758..5b0fb09226fc 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -193,6 +193,10 @@ static int named_distribute(struct net *net, struct sk_buff_head *list,
 		skb_trim(skb, INT_H_SIZE + (msg_dsz - msg_rem));
 		__skb_queue_tail(list, skb);
 	}
+	if (skb_queue_empty(list)) {
+		pr_warn("Bulk publication list empty, nothing to distribute\n");
+		return 1;
+	}
 	hdr = buf_msg(skb_peek_tail(list));
 	msg_set_last_bulk(hdr);
 	msg_set_named_seqno(hdr, seqno);
@@ -253,6 +257,13 @@ int tipc_named_dist_cluster_scope(struct net *net, u32 dnode)
 	spin_unlock_bh(&tn->nametbl_lock);
 
 	read_lock_bh(&nt->cluster_scope_lock);
+	if (unlikely(list_empty(&nt->cluster_scope))) {
+		/* finalize is done but nothing was published (publish
+		 * failed): a permanent state, nothing to synchronize.
+		 */
+		read_unlock_bh(&nt->cluster_scope_lock);
+		return 0;
+	}
 	if (named_distribute(net, &head, dnode, &nt->cluster_scope, seqno)) {
 		read_unlock_bh(&nt->cluster_scope_lock);
 		return -ENOBUFS;
diff --git a/net/tipc/net.c b/net/tipc/net.c
index 4c144e720ac1..2aa8812c551a 100644
--- a/net/tipc/net.c
+++ b/net/tipc/net.c
@@ -138,7 +138,8 @@ static void tipc_net_finalize(struct net *net, u32 addr)
 	tipc_named_reinit(net);
 	tipc_sk_reinit(net);
 	tipc_mon_reinit_self(net);
-	tipc_nametbl_publish(net, &ua, &sk, addr);
+	if (!tipc_nametbl_publish(net, &ua, &sk, addr))
+		pr_warn("Failed to publish own node state\n");
 	atomic_inc(&tn->finalized);
 	wake_up_var(&tn->finalized);
 }
-- 
2.43.0

