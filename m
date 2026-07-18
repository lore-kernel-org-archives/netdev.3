Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835BE385D70
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 09:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784365801; cv=none; b=qqWA7rLgY1sPWVEjubv+7p1YH2zCnFhR/ov7JRp70qBw/v3DQnRVcRr2AmpGdWdDgqiT1VH+cUuU+UDCa+5EQIZ/vzgwhqXIEoS0RPFmLmBS8+JCKG7xnyzs+aIDwUcaFq1ItvVYKSBPWAF0vexrqivHGGlxtQxvbcje/inl12s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784365801; c=relaxed/simple;
	bh=V5tbfNHmo+5s0PdsqFK8WHZyVJb6Yux3ai4P97h9D+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+sw1A75cABeW28LU77LM9l0OuKly1DqYd3MpRAP2DaMzHz1ljJoQNA+r9Ov31vo2uhphfPxGsvcVFXFkmCxZNlNvO/4LbSA8C1ui4ykSN4iXLVISUbJuguOvpOf8QVQF4iqpGc0vwNh7bDZSlzrZMhdtsMoPEByA38mF+Dw1hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjaAjlfN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjaAjlfN"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ccdb73f0e1so47363755ad.3
        for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 02:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784365800; x=1784970600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J3QOcSKLKobkAtw0/HZfjC/OUXzunAPfppvcy+NSZqI=;
        b=mjaAjlfNum6htTy6SNYsMwbMpKMjzTl0kuccvzkOt4jASHS77/2bRF49jB9d9BjHOQ
         RShzDAFtE2I5m+1tgs71P9deaxWjSY7y+7A7x+8X+1LPwBkA4EY8s9bfHPkgDVLuDRYl
         iwjvZTu+rtmC5KJ1Ekv7gNBEkN/4Z3t6aQqM3puKqE98aTrIxAH5L3mRoPYavX0fDgUn
         MXisrJaitjLF+r2hcCtDOsq2sQmmHMqJi+Pg4Xdam9hSnMnc6ZlyytbETEMhGGryPfVp
         2qEETXv8vfv7X2FQpardybFXW0AzM9upumSCMxypvYaW83DL2AKEMUGQaWsYvJSW5VgY
         eyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784365800; x=1784970600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J3QOcSKLKobkAtw0/HZfjC/OUXzunAPfppvcy+NSZqI=;
        b=VatJ6oNgQeQ41HFnB5STYLbNbFxrpRoQZdSGJkrtqEG6xrcSfm6IRZKFejVjutP7gP
         BrHYUk/oYV1DGhig4EzqRluhl5M1KRct6ROsyZ2QL9GHxfjcfcpAYWLGbK1762DVxrw8
         7Ub6x0Q4syM233v6WMl9u8jcvl0Ekd4XqS5qtIftqeo70jMtp2DfiEel9zchmb3xxu80
         sp67FybIU9M7wCv2kkUn7MmYD2oSi1LCXODDfFR9WMC1s7F47jnjM1UpA3FGpy2oQwtK
         nBKu/cB321qrXxB8RJa0yfquWQXQ1M0RycEZ6jQgK/rdsSdJ6Obs/kRAo4pD3oTNOgVO
         DIBg==
X-Forwarded-Encrypted: i=1; AHgh+Rrlp3054cMhZ1GJ1phU2bTAmSZFKAb3O8/fGI+NWjSGG/fDCCcsmCDXcx69Kyvt3GUb1Ls51YY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRX7tnjzFROUfcFK3ILeUnChnk4R6IUmArP7SXjWJ7TApnEgVS
	SE/Dzin5ObVKVy07E1NswRvxdBSf0gPWBo5JP4jY2UJWG0IAR7QbMjr5
X-Gm-Gg: AfdE7cmr3BiZpVRP9BNotXQL2+0YX1I1bdx6vRD66mycSIfhpjIIi8Pnhm5uv80wDr4
	lnsP3tkVLOxYBOcnFvUtpKiyesgMHCt5tvjVQzSP2o1Kkf7IvjnKh9xHMQRY2a/TDRRz3ZVz8Ra
	SgzQVt4F7Cm3pqVhomXGZmk76JCrPuQ3TRXKE9skftm6ZA4E1WK7UnQxzlpvbdvtmWEFznIdflT
	awUZWHe8tCjWo4UfIzm6WEoK+3sYyaXMb+Zd2PNUZGgfSvPYc8qKGNu12Hr3+h2DGOO0nUdshPl
	O20tzIaL+4WurXbls5+z6X4xg+dq/3KpG9+7G/sOzWnQ8SYkI2oQrQkxEwS3BAUaXqYozv69CZw
	VkzfSKs2YOhCQ5pVSFO4+PUozva2DCoolnVOkqEB9oZ9qX6Yn2O7oV+4qQe7m+wIqTWc0RR2HZA
	dY4gLAhny4bwm2uJOMpOuCvH0nLfM/Q5TyCsM6BBY=
X-Received: by 2002:a17:903:1b0c:b0:2c9:e5e6:8621 with SMTP id d9443c01a7336-2cf3496bdf7mr65570815ad.25.1784365799860;
        Sat, 18 Jul 2026 02:09:59 -0700 (PDT)
Received: from kimi-bug-hunter.. ([47.236.164.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3479463bsm24285495ad.80.2026.07.18.02.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 02:09:59 -0700 (PDT)
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
Subject: [PATCH net v7 2/3] tipc: fix NULL deref in deferred bulk distribution on publish failure
Date: Sat, 18 Jul 2026 17:09:29 +0800
Message-ID: <20260718090931.724303-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718090931.724303-1-bestswngs@gmail.com>
References: <20260718090931.724303-1-bestswngs@gmail.com>
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

