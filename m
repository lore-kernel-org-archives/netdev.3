Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0853264C4
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111681; cv=none; b=hBXrO9o8pfVpqrnb9szWxlclqYRf9FA4ClnFalrPP40E+gUVy7ywjmaDmZpdcCjr8Hrkm2SWw+eWyE53ACsIlCP6OyX8jAN+B/x2UsFyjDBmHRlEC550aaPCYntRc/aCt3Ru1mqyFhreZ9oerfea0em80q3eGa4TOajVGqGrIuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111681; c=relaxed/simple;
	bh=Xwc5a3uxw4lEHg3LmvnXWJWltn7d5B6P3cO8C3Bm6u8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cd/TRXQXOyqfaLhJftHflvnfgcU+PwWnoa2APKIxyeQEdP71+NMHHKj+s9Y+DL5+N8gHc5kh1B9232Q3dL5aRjEqw1AaspQVjOlHW/1hXB23Iki+/hzHT87i5VtHFjaIwiJ20xm9DBs7QIDzm5e5fz7bsSgTTwKL8z7ZkvkK1Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6MrMDqI; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6MrMDqI"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47df6a5655aso446899f8f.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 07:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786111677; x=1786716477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gP1cElbhb3V3p02Nhz1yRliDsY/OwAxBtgzUnHt+zho=;
        b=b6MrMDqIpJeAYDgnXQ1M7zqmUaPQJiwU8tOvN6dOsIKh64PLEh1Zc4L60VHzHZmjbU
         6At3+lmNqyTT+GbumRT8kZhKBN2ycCb+r17aQkNNw4i0cnKKAjglmjrn00Yb7h8eZT95
         r1IuZm62/peoayDX4AWc0lfchJz9wgKCCzANrSUHKCoql3d2hc4kTVOlDI7QrFYoOurv
         CNpK8gKyFf6Lh5oTi6FsfA5+NpGidPKi73L9TlLzoLL0g9lHdZ//awgcYQB/p4gQDc5r
         jm5+Ttwvxhn/WFIAmhFKoIH2UR3Xol0sKfSiSTXVt8DWATbR1L2EUx2TKOTMDiCrpTDB
         hhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786111677; x=1786716477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gP1cElbhb3V3p02Nhz1yRliDsY/OwAxBtgzUnHt+zho=;
        b=PD5G55I/nqNu3tvbmMQFbhGUNyODMUY772ufgwvVCpR4+xmb5fsnEyFxJbIoKWcXGj
         oVmsgPkFEbn089uJR5MUL7WYUDCmwsznxod1QASgbW2hnPZdsaQFQuc+eOhMvXfJx+7c
         mHu/0R1EpU1kzOwKavJGXy5wr+PFL4UGo8Jocdoc9amQoh7VoYpJBQijnSG4vju8GAIG
         5X3lBYW3E0FtDiQuUIm0W4xDCPsedBl0rC4uW3ipnwrb09XIh3NKvV+koCjADkscBNjR
         d0eKaelwgsJ5qUiO1CBUFCiw92fHCvfJWHWVf2DAHQXIytaCPa+q2jPyFx08Q26AhuNl
         CMwg==
X-Gm-Message-State: AOJu0YwXs3kzvnVEStC1ALq700j0zleHRhVD1tYQz+JL63+iUMreo872
	KFQUbxdaRg8tPQXEeMNvtGZ+G7zXlkOqdVedXXQo4p4HQOuNvR9F7cA/Rc36qZd/mXo=
X-Gm-Gg: AR+sD11L21nCDCFzTClHjpbBJhCUkQ7Qio5MbDaqZ5cF/ZCUHPvVwacAFUZrJ5+l0WK
	CEJWXnk8peIZwpQwXOCgyaJ0k7hv/8OlXziALN4rbjLnTFTDu7gsVXkS44S8cBJOrRTYPIZuej5
	vQSCgkYud7dVuQK+ode2tAJfaMetOgrYOZnXYmSlJqbii+GY3l3OWPF2jJRxlCopvw5JZHHkkuo
	RoL8IHwc2Vy42X7rK8u1HerCFQs1HcyaiRtIOAGmxYtGQTVJIII27M9hc+5H6Ms8YTLbjbivPPT
	cR21T5Pl4Poc/7aQfGquKXPvApA6tZ/Xym0+tq9Yb9uQyANmnwagbAyDjI30PCrF/QcUggkyV5l
	RyRNmaTG6qENv3WZBU/ZSezCPLqVmDIuRKDE4+JPUlKdgnq6VZrSqihEhw5uWzUwDTTVtFr60Qy
	9GAHo5Xg+MZjgecMwbUD7pGDx2BLeCveFW7OsL43suKMQFDxt2GhY4AGUUNUoFMMAHUeh9UuCxl
	9zViy/IXw+gTwZ4yToW80I0HH3OGq63tKVTRpUMBmsPx3v/MSpo+4fJoBpzSAzc8GW93QgHEfnC
	YK6BczsDL/lrCuMuAyW4zpk=
X-Received: by 2002:a05:6000:1842:b0:47f:9256:52c0 with SMTP id ffacd0b85a97d-47fec634ce1mr17647347f8f.3.1786111676467;
        Fri, 07 Aug 2026 07:07:56 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-077-179-201-133.77.179.pool.telefonica.de. [77.179.201.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021506c0sm5980064f8f.11.2026.08.07.07.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 07:07:55 -0700 (PDT)
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
	sdf.kernel@gmail.com,
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH net v5 2/4] net: hsr: shrink seqnr_lock to sequence counter updates
Date: Fri,  7 Aug 2026 16:07:48 +0200
Message-ID: <20260807140751.1351-3-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260807140751.1351-1-xiexinet@gmail.com>
References: <20260807140751.1351-1-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

seqnr_lock currently covers the whole forwarding path although only the
sequence counters need serialization. Limit it to the counter updates.

The old lock also serialized the tx statistics; use DEV_STATS_INC() and
DEV_STATS_ADD() for their now-concurrent updates. Concurrently forwarded
frames may be emitted out of allocation order, which sparse-bitmap
duplicate discard tolerates.

The GSO segmentation patch depends on this shorter critical section. Apply
both only to 7.0 and newer, where sparse-bitmap duplicate discard is
present; older trees require an adapted backport.

Cc: <stable@vger.kernel.org> # 7.0.x
Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 net/hsr/hsr_device.c  | 15 ++++-----------
 net/hsr/hsr_forward.c |  9 +++++----
 net/hsr/hsr_slave.c   | 11 +----------
 3 files changed, 10 insertions(+), 25 deletions(-)

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
index 0774981a65c1..87cd72a1dc65 100644
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
 
@@ -746,8 +747,8 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
 	 * So check and increment stats for master port only here.
 	 */
 	if (port->type == HSR_PT_MASTER || port->type == HSR_PT_INTERLINK) {
-		port->dev->stats.tx_packets++;
-		port->dev->stats.tx_bytes += skb->len;
+		DEV_STATS_INC(port->dev, tx_packets);
+		DEV_STATS_ADD(port->dev, tx_bytes, skb->len);
 	}
 
 	kfree_skb(frame.skb_hsr);
@@ -757,6 +758,6 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
 
 out_drop:
 	rcu_read_unlock();
-	port->dev->stats.tx_dropped++;
+	DEV_STATS_INC(port->dev, tx_dropped);
 	kfree_skb(skb);
 }
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index 3cae70754bc4..aa2154b19c0b 100644
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

