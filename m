Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0E03EC2EA
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 16:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739382; cv=none; b=BT1aDLA4ABDtYCPsinYr69NmbaBymlQ4KTSeldgVCHMwHW09mglm0cHeRuo1lpTWXBkew4clBdh9jH9Kno7lmdr70PicEruSZJuMcZbj2WvpA6DlqRj/t+SJjqLIO/jyJpqKiGn3UvHuPgnVvzX/hFlzaQU4pGxIk48uZEBuuQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739382; c=relaxed/simple;
	bh=cdxRSieBisfFr5FX5xnyrYTHsugWro9SEov6ZIA36qM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfywR7AbalzLEO7fZk8wz/rHkfsEBGm4ViJpjOyUyAvlCmwTSCtvr28MeWtXH9zWFTvW6x8en765jrLCj88umMzQZhKH93r3u7TrE1zz2o2MYCEWmo0Ldw30ez3fj89qEN2brwAkYBuZcmIc4MthyhovOjbCMLQK4QIOXlBzIKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcIh5Z/3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcIh5Z/3"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47c2ae992beso902934f8f.2
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 09:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784739378; x=1785344178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BqxPzTHo4F6RITjff4xFH6QwEdtq0VyFnyAnj9pOhVQ=;
        b=CcIh5Z/3UbbrJdGXbbEMTPLCRhqml73V5/Nnz8y4lq8WxTH3svz5vR4ceHdaNn7SRk
         N+FGaM/PI7Ds3k6NGsNETdk04P6Ri7b6A8VQ9yqTmNXcn5wyjQeOI6LEpQlhjXqbBPpb
         U9ZCCnw3JzUs6PPMYjBVcB2cr1peB11ZRP5C6xsJf7tczgXatxLYqIvQPfleoHfA+Ihq
         gnuXYnkoeqgYk9H3e1i8ggalKVCwwxQoapZj0ID+Gk0QPvF27UXcNcFwOAG9kQqXPBFq
         cbE5nj3t5PC8H/Sj4+H8K9JcmvFr2pBlf75Qp6fUu1DIRxdGlSKEPAhDlCsXxkTl8xdr
         w2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784739378; x=1785344178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BqxPzTHo4F6RITjff4xFH6QwEdtq0VyFnyAnj9pOhVQ=;
        b=Sm4bWJcwcT7Z8rgghOAHgLMtXP6nT5eW1bkvW547ifTsDo45dv8XkRs7b1l7e31xLU
         Wa+I9nHQmP9ql0+rhlH0qCvzkJtdu8cEFBIx55Y7Cu+oiT2yVjL2pcQfKgmWm1cck2++
         gvL49XdXkimxK1A+NTN6AMZJEVp+jE0IBFtkKLFIfwNv1gBXgvQkRnjDeqs5pARXGZuY
         uQoU4qnZ4hrzMWt4qug1Q5kZaTW19gR/m2oAWlRjc5w8/wkh0u2adUdKCxLMjrcPiCKI
         QhAKFEfU2eiyr34jt7u2UlG4mFvXZe5QIS8PWeCkMIynnnus04NaSIiwW9vPnjYqy04C
         u53A==
X-Gm-Message-State: AOJu0YxHUXfmlnFCnHYPRYDva3yehSAahCpSZuDDEg5bmxmo0mtSKyv9
	v2GWb+2nKZvpUTI7N5f+IqqsCisaxYWXXc2xO9JTJEFljRU44/HHYAGw6+P1Ty6uzcI=
X-Gm-Gg: AR+sD12CL9gPVI7kirWMXZ+9iUT3bpVf2XQlhig2DayH1WDk3T/viaH44HhJ29r081b
	GNKwOPKLmZE75bV7GHfh3VfUj7KReumCoBo8cvgx3NYIShR51fKCCT+vLeK9k043GaFLQicu0Qn
	Psddh/fjTdGJHAAcRDW1vTDjs7MymhWLodL/zw9e5wv7w6a2a8ygKTh5F0ox5csL24gVaLYTnS3
	ut5liUv5MoaVYSTsr3X06598gjhWhMoxtaFK76DsJ8UvQFR+wpcTOURtFwu5Y+9crArnuryIfwb
	AW1hsG/Vt3ooRM2vg9ilk7K9nkxwnt1vvfpJtlMAK8kQKn9TXXf0CpVrDQCLte1d/IO1wTmJRPf
	9Q0m7FU3wFnrzqhkGLhOg7XArfTwzvDLMqSguPafpA0xjJ6v03HSjoyghK759PrTVhgqTx7Gv7t
	YMmnu4X2eOWPV7BilTXaDXwgcka8/+WSJ0NE1pER72j4ovKIkMPEpoUrPLzHrk9hVi/pvmHsZBc
	8yrFBaLP03Bz62LtLGg79TCvA7nL0rs5O2Rgw==
X-Received: by 2002:a05:6000:2409:b0:47f:557d:df9 with SMTP id ffacd0b85a97d-47f7fe381eemr6510136f8f.5.1784739378433;
        Wed, 22 Jul 2026 09:56:18 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-078-051-150-230.78.51.pool.telefonica.de. [78.51.150.230])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c532d4sm7288629f8f.22.2026.07.22.09.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 09:56:17 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	qingfang.deng@linux.dev,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xin Xie <xiexinet@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 2/4] net: hsr: shrink seqnr_lock to sequence counter updates
Date: Wed, 22 Jul 2026 18:56:12 +0200
Message-ID: <20260722165614.124-3-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260722165614.124-1-xiexinet@gmail.com>
References: <20260722165614.124-1-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hsr->seqnr_lock is currently held across entire hsr_forward_skb()
calls: master TX (hsr_dev_xmit()), interlink RX (hsr_handle_frame()),
and both supervision frame builders hold it while frames are built,
classified, duplicated and forwarded on every port. The only state
that actually needs the lock is the sequence counters themselves
(hsr->sequence_nr / hsr->sup_sequence_nr).

Shrink the locking to the individual counter updates:
handle_std_frame() now takes the lock around its sequence number
allocation (replacing the lockdep assertion), the master TX and
interlink RX paths drop their outer lock, and the supervision
builders release the lock right after updating their counter instead
of holding it across frame construction and forwarding.

Sequence numbers remain unique and monotonically allocated per
counter; concurrent inputs may now interleave allocations, which is
fine as the output paths were already concurrent.

This is a prerequisite for unfolding GSO super-packets at the forward
entry: segmentation with its dozens of GFP_ATOMIC allocations must
not run with BH disabled under the global sequence lock.

The locking being narrowed here was introduced by 06afd2c31d33
("hsr: Synchronize sending frames to have always incremented outgoing
seq nr."), briefly removed by b3c9e65eb227 ("net: hsr: remove
seqnr_lock") and reinstated for the interlink RX path by 430d67bdcb04
("net: hsr: Use the seqnr lock for frames received via interlink
port.") after a syzbot lockdep report. All sequence counter updates
remain protected; only the forwarding work moves out of the critical
section.

Cc: stable@vger.kernel.org
Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 net/hsr/hsr_device.c  | 15 ++++-----------
 net/hsr/hsr_forward.c |  3 ++-
 net/hsr/hsr_slave.c   | 11 +----------
 3 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 5555b71ab..3fd1762d8 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -232,9 +232,7 @@ static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		skb->dev = master->dev;
 		skb_reset_mac_header(skb);
 		skb_reset_mac_len(skb);
-		spin_lock_bh(&hsr->seqnr_lock);
 		hsr_forward_skb(skb, master);
-		spin_unlock_bh(&hsr->seqnr_lock);
 	} else {
 		dev_core_stats_tx_dropped_inc(dev);
 		dev_kfree_skb_any(skb);
@@ -335,6 +333,7 @@ static void send_hsr_supervision_frame(struct hsr_port *port,
 		hsr_stag->sequence_nr = htons(hsr->sequence_nr);
 		hsr->sequence_nr++;
 	}
+	spin_unlock_bh(&hsr->seqnr_lock);
 
 	hsr_stag->tlv.HSR_TLV_type = type;
 	/* HSRv0 has 6 unused bytes after the MAC */
@@ -356,14 +355,10 @@ static void send_hsr_supervision_frame(struct hsr_port *port,
 		ether_addr_copy(hsr_sp->macaddress_A, hsr->macaddress_redbox);
 	}
 
-	if (skb_put_padto(skb, ETH_ZLEN)) {
-		spin_unlock_bh(&hsr->seqnr_lock);
+	if (skb_put_padto(skb, ETH_ZLEN))
 		return;
-	}
 
 	hsr_forward_skb(skb, port);
-	spin_unlock_bh(&hsr->seqnr_lock);
-	return;
 }
 
 static void send_prp_supervision_frame(struct hsr_port *master,
@@ -390,6 +385,7 @@ static void send_prp_supervision_frame(struct hsr_port *master,
 	spin_lock_bh(&hsr->seqnr_lock);
 	hsr_stag->sequence_nr = htons(hsr->sup_sequence_nr);
 	hsr->sup_sequence_nr++;
+	spin_unlock_bh(&hsr->seqnr_lock);
 	hsr_stag->tlv.HSR_TLV_type = PRP_TLV_LIFE_CHECK_DD;
 	hsr_stag->tlv.HSR_TLV_length = sizeof(struct hsr_sup_payload);
 
@@ -397,13 +393,10 @@ static void send_prp_supervision_frame(struct hsr_port *master,
 	hsr_sp = skb_put(skb, sizeof(struct hsr_sup_payload));
 	ether_addr_copy(hsr_sp->macaddress_A, master->dev->dev_addr);
 
-	if (skb_put_padto(skb, ETH_ZLEN)) {
-		spin_unlock_bh(&hsr->seqnr_lock);
+	if (skb_put_padto(skb, ETH_ZLEN))
 		return;
-	}
 
 	hsr_forward_skb(skb, master);
-	spin_unlock_bh(&hsr->seqnr_lock);
 }
 
 /* Announce (supervision frame) timer function
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 0774981a6..8e4158a9b 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -621,9 +621,10 @@ static void handle_std_frame(struct sk_buff *skb,
 	if (port->type == HSR_PT_MASTER ||
 	    port->type == HSR_PT_INTERLINK) {
 		/* Sequence nr for the master/interlink node */
-		lockdep_assert_held(&hsr->seqnr_lock);
+		spin_lock_bh(&hsr->seqnr_lock);
 		frame->sequence_nr = hsr->sequence_nr;
 		hsr->sequence_nr++;
+		spin_unlock_bh(&hsr->seqnr_lock);
 	}
 }
 
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index cefbbfbd5..c7fd021f0 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -73,16 +73,7 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)
 	}
 	skb_reset_mac_len(skb);
 
-	/* Only the frames received over the interlink port will assign a
-	 * sequence number and require synchronisation vs other sender.
-	 */
-	if (port->type == HSR_PT_INTERLINK) {
-		spin_lock_bh(&hsr->seqnr_lock);
-		hsr_forward_skb(skb, port);
-		spin_unlock_bh(&hsr->seqnr_lock);
-	} else {
-		hsr_forward_skb(skb, port);
-	}
+	hsr_forward_skb(skb, port);
 
 finish_consume:
 	return RX_HANDLER_CONSUMED;
-- 
2.43.0

