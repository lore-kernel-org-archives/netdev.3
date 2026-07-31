Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2866C330678
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785488553; cv=none; b=ZeQhnoIhonkT0H02qvfTOC4ThgKGCAHLPuic2uG1U2/uhhNZfZ2Uv5RYq8Kkt0QG3ooqL//KsRjXJqRAXG08mU/6n7GStb1QE3NF6vvKgs/5NTNJMNd64uthuC8H7oKcMuBWVwjkxGGEhwR/PGd5btPlqa1hfAOdJWVQ1mR/XDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785488553; c=relaxed/simple;
	bh=imTV0lVDCJfkhzd13WmGrGkOzMCAQaUcglG1OsyAMdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oE4S4eFHD19vfs7w1nJ53VGRAEF7AQouYKCWzB/LcfNkQpC6enbZWGMRhuk+rICuxPcUQ8gv+mMQIuO6Lt4nD5u9kNz48aKwO0uAO+IZHUEnsvB7SaVnBmWAwJgI7xUT8D46SVfV6o+krK2PtyrEGu79BAGv2sJI52OfmRPcz1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=spPR/zoE; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spPR/zoE"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-472d9d69e16so56569f8f.0
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 02:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785488549; x=1786093349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dcpIWu2gPXbEkinbrLRL7Y5Q8sZSbgxuISV/4k1U49M=;
        b=spPR/zoERGOuuUJTx57ShqNTpsxUS6lrwaP5ugtyi0wJOr4CUAiOqN6I23ruVybMkY
         WiJRSiy1V+mo/H75tUseFU6mpsweNRsmGAtWvkQaHfYAtq6wSZPgewvdrplEJKSCjS7T
         5Cl9XevwIxFmR8AOp9/pnQfziGOcpwtg3Aa6xAnAEVNcXgJ6SNzako/WUY5iWqdirCFi
         K1x27qyX5vRee5Rcu7qb5/JC6FJNWNezhkiRU/GfgnnkTFcIIPJ3O2SqaQT1N6IrsHgv
         CZUndoXNCRXb+21jas9F7Q0T7zg++GPAjukNvhqG4gRNJnV74vk96o/psgZ7DJJAqGGr
         pjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785488549; x=1786093349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dcpIWu2gPXbEkinbrLRL7Y5Q8sZSbgxuISV/4k1U49M=;
        b=Gssut4HoDemH0Ws7WN043sTxIAEdXkHN43DfhNS7O6zix1X4FprlfA9NEB9XCVS8Y7
         eGmNd2QTzHJC6Yu1rAD9DBdjAPfBcO6Iap5VLcTHDJ9Es09HEoJxNruSoCxpwQUPYinQ
         S9wiAyJMOUhefalJ1yCUduukEfFbXRo43y6BN3AYpTvEG0Smgl7PXSaqWhSwzEthFJVW
         czEcKi4EoqK92jETQqHoc3Tfcvoz7z/edDmIuFwagbuLd5gS5LObWc2Evo/zxxp4WKuT
         /7mwM7p0oXYySpcaJOzlUS7cwwq9gUdQorwR0NdoKuTRrh2AbUhsk4VXY+959nQ5qWBR
         udiA==
X-Gm-Message-State: AOJu0Yy8KlRoU3q+d7Nzf3bsX4zjV8ElDBF76/r6oqKZpvm+veagb2ng
	Fb9N9ex2CK/Lt9+IXZqChn6DpXK7h2lhLsBPAcQGEn5ugnomWJ3D7ARy1tt0g+GZPSQ=
X-Gm-Gg: AR+sD11Acx6KoALiHlRJx/DgidW4VjEWkAS9wXxJ86VkxkKy/3uC5n0owcLEU0gZUXv
	2DHbH2IMxKD8nQ0i8vAgqXANMZSPza8/A48x0rQ+8tbVz5MUrgGhZX5yKN1X43LvBa2Uzduigyp
	V9km9TbcGW5zVgXfAlUJitMG+O903nS3dJ02Z2OIhb+5FbEBjibAMyig4gNkZFHknWynpKRm8iv
	3sdrUh5Aoz2TlZR1x9ctm+lneuaEYU5XVJ+pN05FAeVVpAHoW94Edca20cfsZYRuy+uztxZYDT9
	J/XU5LaJmn1SbDEWgxB9UGIMq7GOzngb3h2rK6qxwEIP/X43PQeTkiQ2Rquc0d8Mme2sBXPshYq
	yjt2/69xLQyjYll1Q7dThj11jz9yyFRZLp3XoWBdcHQEvPSN9DUjtvAHZY/HhwxrIBzw2HDD2CW
	KukfWXo5P+2OCyzsZQru2uJSDJrxwRWeFikDlXPLY/1aaRK8IfxxV/cIMGEPZu159rhzl3Gj/mZ
	cCda7MxAQ6NzmHqNLt3Q/hwCKofaj/fyQqKV3UMmP60hEWqnP7YtET7wgMmIoP2LHqf++s+6W7l
	fYph79KRydGT2Gp2Y04kIg==
X-Received: by 2002:a05:6000:240a:b0:470:f631:8316 with SMTP id ffacd0b85a97d-47fd2b4e441mr3218259f8f.3.1785488548831;
        Fri, 31 Jul 2026 02:02:28 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-077-184-219-058.77.184.pool.telefonica.de. [77.184.219.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d1a58sm2965051f8f.7.2026.07.31.02.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 02:02:28 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	kees@kernel.org,
	petr.wozniak@gmail.com,
	qingfang.deng@linux.dev,
	fmaurer@redhat.com,
	luka.gejak@linux.dev,
	bigeasy@linutronix.de,
	xiaoliang.yang_1@nxp.com,
	skhawaja@google.com,
	stable@vger.kernel.org,
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH net v3 2/4] net: hsr: shrink seqnr_lock to sequence counter updates
Date: Fri, 31 Jul 2026 11:02:21 +0200
Message-ID: <20260731090224.18-3-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260731090224.18-1-xiexinet@gmail.com>
References: <20260731090224.18-1-xiexinet@gmail.com>
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

Ordering: with IFF_NO_QUEUE and dev->lltx, hsr_dev_xmit() is
concurrently callable, and this change removes the old
allocation-through-forward ordering guarantee there: master-TX frames
may now be emitted out of sequence-allocation order. On the current
tree this is safe because duplicate discard tracks individual
sequence numbers in sparse bitmaps (commit aae9d6b616b5 ("hsr:
Implement more robust duplicate discard for HSR") and
commit 415e6367512b ("hsr: Implement more robust duplicate discard
for PRP")) rather than requiring monotonic arrival. Sequence numbers
remain unique and monotonically allocated per counter.

This is a latency/critical-section prerequisite for unfolding GSO
super-packets at the forward entry (not a functional prerequisite):
the segmentation work should not extend the global sequence lock's
critical section. Patch 3 depends on this change; their automatic
stable selection is limited to 7.0 and newer, where sparse-bitmap
duplicate discard accepts out-of-order arrival. Older stable branches
require an adapted backport.

History of the lock being narrowed: it was introduced by
commit 06afd2c31d33 ("hsr: Synchronize sending frames to have always
incremented outgoing seq nr.") and briefly removed by
commit b3c9e65eb227 ("net: hsr: remove seqnr_lock") in net. Merge
commit 46ae4d0a4897 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
reverted that removal because
commit 430d67bdcb04 ("net: hsr: Use the seqnr lock for frames
received via interlink port.") in net-next had already superseded it
by adding locking for the interlink RX path. All sequence counter
updates remain protected; only the forwarding work moves out of the
critical section.

Cc: <stable@vger.kernel.org> # 7.0.x
Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 net/hsr/hsr_device.c  | 15 ++++-----------
 net/hsr/hsr_forward.c |  3 ++-
 net/hsr/hsr_slave.c   | 11 +----------
 3 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 5555b71ab19b..3fd1762d8916 100644
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
index 0774981a65c1..8e4158a9b57c 100644
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
index da06b21cdf51..0ca55d9323c5 100644
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

