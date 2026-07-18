Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC9936E460
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784366764; cv=none; b=hqtAuh7WGLLq/LAK8cKJskShMVKwlrLHNcTNXNpHv4PjGDbhJmy6stm2/CD8KB0qEVQ1Fhugf53sBVoremqO45BT43xgH0zckjR1MM6DkdKFz1GtMFk8XQxi+eGFd8a5jzTeCUjqpOpTamErxBkT1WLUzNSRVPflxvYzv0Iy0jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784366764; c=relaxed/simple;
	bh=V5tbfNHmo+5s0PdsqFK8WHZyVJb6Yux3ai4P97h9D+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5k6dWqbySp+V5QW5rk/eo75fNnonmFetuSVCBq5bTRiKCnzxQVASumxxOMcPyvydqXknZmxpQ+65G66+uR8jUy7B6J/Sk0lzRRAr5GglD5q9IgenSZFmi0B+S05fzFdxanuunFHpT5BdkKA9i9QBU1l7LS8p7t8ZnqjxRlihYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=otT73yfc; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otT73yfc"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso5354149b3a.1
        for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 02:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784366763; x=1784971563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J3QOcSKLKobkAtw0/HZfjC/OUXzunAPfppvcy+NSZqI=;
        b=otT73yfcEGIjirJ6jK2mHh2yOO6INKvITvdXuv1iVICkq9Lcge8Hi0RwH193qJZG7d
         dI4DWTl6PqrqikZwGSLdSqAaXmnc3vlV56m43ANBk++BRlUPm1pWQkGFlHCX8h/Lfrga
         wqZQXx2QCwsVfG+EJe8twU6FBHBecbit0xsLvexpnLyHR/bvAX7F9HTW7+a2UgrrNfgM
         7q+H6n6n2JO2vMBgDxZDFKIzNnzXOgYgVaC0206s/8QeVpW9INVu6mJJKCAii+mFgBE1
         EjIzvadvqnUa+6QwJF2sjY7/Djr6lRnakayqYe7qeSQr4t12k9XrnPpz2qKY4I1bXfoK
         Sang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784366763; x=1784971563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J3QOcSKLKobkAtw0/HZfjC/OUXzunAPfppvcy+NSZqI=;
        b=r/RRcEyl/OxbItbKe+/GAQhosUyoQc5UWU8xCak9BS6aF06n6RmyDxATAsEy1xvOpO
         h3gQ7SxsHDAQ9iOjWuCr3hUo/dyCWveJBIGLUuuEtr+nh8Fuwf5j436kNMFT8IUr4mTH
         zXYSCtAFAyQtlaVDH+ClwFaqPiZlGFkcSI3+zPDFVgiSikgCtXxdI+f42fWL0VjvNAFW
         p7pZRiUuDUsRLJGiOhz+Q488iKD78B2WgMJdmQIOgXi7SnPSMAKk951d98SfOW8RfnqH
         wg3w4TZC4XSGdTipznhQGXiviHcDiiYp4dodEqsgZ2oXpZsESrsX238+JeddQHUExp/k
         ULCQ==
X-Forwarded-Encrypted: i=1; AHgh+RoKW5o9svAKtlW+UZky+mlryMksCPwf5HLalanYbRckCcPljvXpm0vMGIljZY1ZsbeBFwfxLDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2vAHLaH362ESPDSH/QoSXjQqAMFkD0zmzp/6HOMSeouXm5g7T
	4cmPWHVKx73sI0R88Bb0NRKlW4LPXKsVU/q3PcgjYbr5WUHlxkinAxK7
X-Gm-Gg: AfdE7cnLxV8jQg1vT5g6m40i2S8AgjBeygZh3wIe4E1cjDBQm6j+FnDcq01hJmGUcUW
	DyTzcZH5Z7JrUHv9vD1yRmUtdaTOV+PNITVuTyxY7ai4WuiX+g5BJy54AzPB7pOjOF7EiDIZkYG
	PekM5089KVC3p9JQCx2JZPCSzexk8C7KCP/Ef5QSkikr0GlAsTnIIvZqrfvETbO+5MJdOpOU/av
	RT5pa7dVu9+7ZEBpTGra4tmZJkc/px8jIAQPz/MHd2TXfuIX8CMFT63UM+y+F92nqtt8F8xZNGa
	d96YVPhLFsewVJ9jOJ8JmSs5uE5bKIEiPGbEfM5BuDAr8cW29DgOT4Xu+mHMECRv+bbZcXcdD1X
	uUWBHPjhFnx+40KDg53BaQRs2hS52Lo8ObiVoEbD0rReC8+2adoovdsU/8q/mY8iPhoVrMWDHw7
	k8Lg6M6aErdTekxvOG9rINqUZP2a5tOagzN6H+ZQ==
X-Received: by 2002:a05:6a00:3d13:b0:845:dde9:ab62 with SMTP id d2e1a72fcca58-84c2927fa27mr6626506b3a.19.1784366762755;
        Sat, 18 Jul 2026 02:26:02 -0700 (PDT)
Received: from kimi-bug-hunter.. ([47.84.186.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c30fb62fesm1950464b3a.29.2026.07.18.02.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 02:26:01 -0700 (PDT)
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
	kernel test robot <lkp@intel.com>,
	Hoang Huu Le <hoang.h.le@dektech.com.au>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v8 2/3] tipc: fix NULL deref in deferred bulk distribution on publish failure
Date: Sat, 18 Jul 2026 17:25:42 +0800
Message-ID: <20260718092544.785289-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718092544.785289-1-bestswngs@gmail.com>
References: <20260718092544.785289-1-bestswngs@gmail.com>
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

