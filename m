Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B483803DC
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314642; cv=none; b=qKTHsJVUp+56JcOZpFozHtlkO1J1VqCgqgHJ6h86qSmDVk8a0ECHm7XScv8WqLyfBFC+gpAz7h3YT8687uuxN3iOv9mMBELDVIa7bfxuhLJdTMstefKuZC0Kw/g2C9avgsSLTI7bOej4bHjLVWllCcC2fqAt4LxChEBw1wZrIpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314642; c=relaxed/simple;
	bh=V5tbfNHmo+5s0PdsqFK8WHZyVJb6Yux3ai4P97h9D+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nv61u8NWw2HvVeDJjbaX0/w+Gf59pTN4Bztpz2LSaA60ge3iEbVJmBAruMBu4rW6bxdFTCaJySpAJDxfGbPyYJiPc97HCAMSa4uTs8EbXLu5F1tOA3xhE5O0/eq+TJ5a98+taC4pHNzh5gw/nTJP6fKBZLLBd5A8hTMbEQHL0hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYhXOkJn; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYhXOkJn"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-ca97d139d8dso3007811a12.2
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 11:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784314640; x=1784919440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J3QOcSKLKobkAtw0/HZfjC/OUXzunAPfppvcy+NSZqI=;
        b=UYhXOkJncZx5/8T+sgm9GH21yIIb0LWOdf8oCIQ0aQweS5bs8MRqORVEldNPiRyal/
         0DTsoG9zv4eyRawzjuUibKwORVt/RMA5YFLnMTrlPOANgdGhBQvja2aOvdMzgizB23o7
         92PrqHlaeVDMnV2rOqOh/9TLTfuehmDzMk3LVV20BwUdWYtPYzQzdpcW3kw4gRCaE+3E
         kQIOI/r1L3KxDtW+Xyx1mmSTHpOcHIaQgd4Wb3N2mMDI3zq/0Sb8GDgxDCAaJFU2M41Y
         aEFQ+53bQNDxXU621hkq/nFmGJhP8XsOiX19NOXMAQ7OAGtAf52yQTfh15C0khME6nrR
         74DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784314640; x=1784919440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J3QOcSKLKobkAtw0/HZfjC/OUXzunAPfppvcy+NSZqI=;
        b=lvw1HhEQQdrjipQ8REJEYQDDb2mIlsfr+fpywCiIm+Wfo2WY7RSBGN+kuvG4jrlxyG
         T+eFnyZW3qM0iBzPGI3tXOg9suxyO/NRoZ8P5d8NaPAOX+M8P6gynVHGniFs7hNIMsQX
         w0lYiYDUld8DRQjznBJv2EN1vRhguxZJw5dD8v1cSXiTAdSq4QNGGVY5NF89MaZDShA/
         dpwxWJcQ6YMT083lo9fU7cbJZtNB2vDjgOxi1XHFlAxb3+5IicYesqnc//CvHsaLBqCm
         E/tNvo2bZh/CXT/JNYMb/ONRodrqAnxCthxrlOzMzcNRyxoYoZvJyaR1LjTLs/cu+W9P
         6O+A==
X-Forwarded-Encrypted: i=1; AHgh+Rp35Atlu/l3640yTi+lKKyx3hqZX0YJv3EqJAOhbxJ1RyFxGCXIgpWV+tPWsb2jx6N4RAWCaZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8AGGfWw50u7AKCfJHmIlyivi8Uc2Z2WZL83eeg49rHgkVvp5m
	tEkP2qEF4VvSPWSKHcc41HpuPv1uKwHahPziaKM1akfv9gCcfZgpgcVV
X-Gm-Gg: AfdE7clOch6UVKAVxMMNFJBY6XJfv1Y1SkBDE41bFaTe1hI9fQ5+E4YQSsPy/eDkC4I
	kv6SW4KsKcOigZTHDPJ/5vi8f4ps45Qjw+PEcSR6bK0JspQhpGdSKtLSd/vMt2dCYhfSlvk6iTB
	/kx9p1ISPT8qVjwygrm8ca3XVu4Y06Coy1zzxsRAAQ8ERqlES3nLGp1Mp5pVIDPwqfn859H/EmK
	88CAi9auytPrjz1ktRvlhc3NYBx201gZ0Nw9paFSvFvKuZDB3wQSokqYVtzmHp6SVIDbDP0ofgx
	hkkIsumfejaHQGfCqwahm/4Tc7gT1CHBRe+zUMp4bWh+NbiTBiIl6STOwM8fuL0WhfV0Mo+fbu7
	Arr878vLgREu6dDahiSMqp3cMGQq4VWNeLu+C6Uz2p+Ei6lzom+yEYruTk6WE4pA0GwKs3H7bch
	VbfP637giN1rn2agb511j3KOyc0h7qcpX6nKPI1KY=
X-Received: by 2002:a05:6a21:1f87:b0:3c3:990b:2292 with SMTP id adf61e73a8af0-3c3ad9e2445mr4259140637.57.1784314640420;
        Fri, 17 Jul 2026 11:57:20 -0700 (PDT)
Received: from kimi-bug-hunter.. ([47.236.164.125])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2cbb7c5sm7376688c88.10.2026.07.17.11.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:57:19 -0700 (PDT)
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
Subject: [PATCH net v6 2/3] tipc: fix NULL deref in deferred bulk distribution on publish failure
Date: Sat, 18 Jul 2026 02:56:59 +0800
Message-ID: <20260717185701.2828080-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717185701.2828080-1-bestswngs@gmail.com>
References: <20260717185701.2828080-1-bestswngs@gmail.com>
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
empty list. That replays the same unguarded buf_msg(skb_peek_tail(list))
tail stamp, this time on the tipc_node_dist_bulk workqueue:

 KASAN: null-ptr-deref in range [0x00000000000000c8-0x00000000000000cf]
 RIP: 0010:named_distribute (net/tipc/name_distr.c:200)
 Workqueue: events tipc_node_dist_bulk
 Call Trace:
  tipc_named_dist_cluster_scope (net/tipc/name_distr.c:267)
  tipc_node_dist_bulk (net/tipc/node.c:403)
  process_one_work
  worker_thread
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

