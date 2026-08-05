Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C993C455B
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 03:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785899396; cv=none; b=Y7E1HdD88RVu5eYHJSEx5qQ2JlqaXH7CgUHEJYHWEfZoAFpx+mOyIXap8CUyRaRKMWmBUpPrluLyyNObVB6AhKE8rd7OexwUHPyYd/NQ93b3kAEoDZDsUaSfmXuFX9zrWUyYKN3XBg5PQ93iOfh2It6U2ue7DD12o1h1zwDXhLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785899396; c=relaxed/simple;
	bh=C/woTRWmGUonXtCdsEp+mRp7+8ZFj9uoVoZRMKxOzn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=O0NCIMCMZAlZG+6TCC6MNFrYgXuDl0qdBPvSvw/MKLKwCvyGQzkRbxee1lDd3WTzkXQP2+bNLw27qXWsLPdzg5rG9O32bYWtOWxqi/tRxDzsDi7YEENnJyjZHF+es9v+9leszzUBinqzQ5sMvaJC16me7lKxZZD6L9Q05LsBGLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evkqbPmC; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evkqbPmC"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38101f85591so1467355a91.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 20:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785899393; x=1786504193; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=l+BRPIV4ca41fzTyiQodU57f74PmSZTMdFIXc0/UZDc=;
        b=evkqbPmCU/w86Iid2p8p+/PlebTWFx4wbD8dr6ZLvT1vPy+va4IXDhK8mwayY1vkkw
         CJaEr12NSN5hmMKJpr4QtHfLgWTHL4SnA8lWeE8z7UlP14cx1pI2bwHz1yDE4lls2uVT
         GUPVYEqs22ZHdFGVYsXimYYx0q+LiDFvB+VprmQQPNcVlSxv0kA6tbnTEgR8l2EjX34c
         5nPSeYKwMsG6VGGqoMPrkRLIFy0maUfXtp1Nf5baAz0C+sM9SwKC/2dQOF/GQz6l8dtu
         10VhX6dw3GwMD92BgnWARzJJlIPx4R87/kVJsfglPupnW+LO0CV4ffnjUUxJmhG1TCCK
         b58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785899393; x=1786504193;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=l+BRPIV4ca41fzTyiQodU57f74PmSZTMdFIXc0/UZDc=;
        b=Kr41VVBmXR+q3iz7AsJczV5xv15mRconExaxB1fW/Otz9rsUwYuwsHADgrB80qwfPw
         QWIdsAjWteojLgBWyd7ScBmrmdAhB8276Sw82aIiiRMyrxu3J+++suVPArFTec4JAxfb
         qMUX9UqRGza+cBdAvLlSCMpYj/J2/a6BsLVjCkrFKMx6NYCaOqKlC3R7wnO2vZtbIUVx
         0ZvT5yXGIgeOC/hA6mlU49o0p3JDrQZey2ceKJtid7dfW6h6Wyf0l7PhCOh7D95ybQ2w
         iLBW4y5HYHhihIuIDO4B6oml5InP0PZhK+9Fq1ytTx05oNz8mFvvVkttbsi66g6eN+ig
         Wwaw==
X-Forwarded-Encrypted: i=1; AHgh+RoyU2Rmfwqv/UEmmiy1LH3coDFgBver3dimEy3VCFtT4TgvV0vZ+czT14927KVWGWvh21Gb/HY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZkTKnAasrel7LaPNPErY4uBGhDg6MUY7bK4Z9NWku7Zd7A7hW
	conwlNEhRZmXHM3FDrVryoTCt9KxJ+7oQsMQjoZdd/738YBFqtWpQQNFPOQpPOme
X-Gm-Gg: AR+sD135seU6RbXvSB1IjITvk83zUEg/9BP+YeIgZmCftkwb4apF7lig//h6uo4jXFd
	hKMzsl4Zv/o1ExDwN18h70dhW/bkAahRXTyaZCTD2WAVru70/LdvZpZK/3MqeoBgsQ0EuPLscph
	593DID2SNnOASI0Y5R/0XE1Tt75vF1MKx2PQdgGL0tOGnRbPHxqfjbbed4YNnLlTSmetbIAS2t+
	ZHZVsb4hTBwE+EOV53C2agjaWbda1dHC3XsZhlB6PVC2BkcL+8cT2Wf1nHvB9mX9wXUClGD9w1L
	x82r7wooZxBdTrVF9HXiBtiA5Xds9YLQOrzNR/+znxf3SlqT3hQax3j3cMDHeJi4kGMf4pg4lng
	hp+ZpqjNet13tZJVjwntS7grGb0uy7KCO6OweVYNwRikoP3WKwJVJkUOe+I0B7+XBT+FHaahe0u
	vGqT0zPXMJDdMatbqxsh6P2TrOX5dwXn5MOiulLtF/yL6MlvTwYlYNvJiqN9FQ1g/UQc3ZPw==
X-Received: by 2002:a17:90b:1652:b0:38e:7f22:f674 with SMTP id 98e67ed59e1d1-3903c628796mr1489226a91.11.1785899392717;
        Tue, 04 Aug 2026 20:09:52 -0700 (PDT)
Received: from [192.168.110.119] ([203.175.12.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3903f5fdfe5sm667822a91.4.2026.08.04.20.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 20:09:51 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Wed, 05 Aug 2026 11:09:41 +0800
Subject: [PATCH net] hsr: Avoid holding seqnr_lock while transmitting
 packets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-hsr_deadlock-v1-1-d8a6f06fc5a8@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBOmsoiuEhGmUw6FhUYE4t2Tl
 m/xf4RAninAUETw9HDg02VUZQHaKreRYJMNNdYd9iiFDX42pMxx6l1IXI3EpemqVkJOLk8rv/9
 uBEc3TCl9/w7OtWMAAAA=
X-Change-ID: 20260804-hsr_deadlock-40fd40b36154
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Lukasz Majewski <lukma@denx.de>
Cc: Felix Maurer <fmaurer@redhat.com>, Hangbin Liu <liuhangbin@gmail.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hangbin Liu <liuhangbin@kylinos.cn>, 
 syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com
X-Mailer: b4 0.14.3

From: Hangbin Liu <liuhangbin@kylinos.cn>

Commit 06afd2c31d33 ("hsr: Synchronize sending frames to have always
incremented outgoing seq nr.") added spin lock around the whole
hsr_forward_skb() path to synchronize outgoing sequence number handling.
Commit 430d67bdcb04 ("net: hsr: Use the seqnr lock for frames received
via interlink port.") also use the same approach.

However, holding seqnr_lock while transmitting packets can cause lock
dependency issues when HSR devices are stacked with other net devices.
For example, when an HSR device is enslaved to a bridge and the bridge is
enslaved to another HSR device, hsr_dev_xmit() can be called recursively
through the networking stack. Although the two seqnr_lock instances are
different in this case, the same lock class can trigger a lockdep warning,
and more complex stacking topologies could lead to a real deadlock.

Since commit aae9d6b616b5 ("hsr: Implement more robust duplicate discard
for HSR"), sequence numbers are stored in an array and no longer require
linear comparison. Protecting only the sequence number update is
sufficient. There is no need to hold seqnr_lock during the whole
forwarding operation.

Revert commit 06afd2c31d33 ("hsr: Synchronize sending frames to have always
incremented outgoing seq nr.") and commit 430d67bdcb04 ("net: hsr: Use the
seqnr lock for frames received via interlink port.") to avoid holding
seqnr_lock while transmitting packets.

Fixes: 06afd2c31d33 ("hsr: Synchronize sending frames to have always incremented outgoing seq nr.")
Fixes: 430d67bdcb04 ("net: hsr: Use the seqnr lock for frames received via interlink port.")
Reported-by: syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fbf74291c3b7e753b481
Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
I'm not sure if I should add these 2 fixes as this patch is depend on
Felix's aae9d6b616b5 ("hsr: Implement more robust duplicate discard for
HSR"). Please correct me if I need a change.
---
 net/hsr/hsr_device.c  | 12 +++++-------
 net/hsr/hsr_forward.c |  3 ++-
 net/hsr/hsr_slave.c   | 11 +----------
 3 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 5555b71ab19b..14e8d0676229 100644
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
@@ -356,13 +355,11 @@ static void send_hsr_supervision_frame(struct hsr_port *port,
 		ether_addr_copy(hsr_sp->macaddress_A, hsr->macaddress_redbox);
 	}
 
-	if (skb_put_padto(skb, ETH_ZLEN)) {
-		spin_unlock_bh(&hsr->seqnr_lock);
+	if (skb_put_padto(skb, ETH_ZLEN))
 		return;
-	}
 
 	hsr_forward_skb(skb, port);
-	spin_unlock_bh(&hsr->seqnr_lock);
+
 	return;
 }
 
@@ -402,8 +399,9 @@ static void send_prp_supervision_frame(struct hsr_port *master,
 		return;
 	}
 
-	hsr_forward_skb(skb, master);
 	spin_unlock_bh(&hsr->seqnr_lock);
+
+	hsr_forward_skb(skb, master);
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
index 01c73b4b50dd..267ffbd3c838 100644
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

---
base-commit: 2a33516f9ef59ad11844d4fc152f889449b5daf3
change-id: 20260804-hsr_deadlock-40fd40b36154

Best regards,
-- 
Hangbin Liu <liuhangbin@kylinos.cn>

