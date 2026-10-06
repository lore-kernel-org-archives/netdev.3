Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45673C9EF6
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 08:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791274673; cv=none; b=fOiOdwar28boiGXVBaUcAkHY1DmWcYMfV9FNLNi8Jly3LxXxn8+VMcb3uOczDXDtUlE7cAnkGVDqA+gdfJCtjf8e+BiM4056a7LF6NsRKEIGeLiwIqEasZzK3gDGzPqSdzMImp0NLdV54uK7T9xoNInLxSY1xmoyQu7eIeBIL7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791274673; c=relaxed/simple;
	bh=O8Izz4Sw4NDEqVySoi3xhr8QGGY2Ekmuiq6TdNf9B0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z3Z0UUqWLnGLXT80OFrYiyRH/EkTnQeKvJtFhDQNmgE/N74KxwgJ43p53F2XNq+NR4B4wlHcABDHO0uWs22q0NdjoTsXwrweeAejHZAkdsvR+wfDl16iPY7iUoD9ZdymR3tWLZpqv07GZtIMwTQLNaborBGUIDQ3lQnc0tG7w8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mkOytjjQ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dW28IiYn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mkOytjjQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dW28IiYn"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CD3591F385;
	Tue,  6 Oct 2026 08:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1791274660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QhnOzaE8bBQ71JyvzCOWddhycKSlWOSPkLx0UtTrWug=;
	b=mkOytjjQf6XC8Uj8imROWohNChFIn+BTnQ8X62NUrcN4BUGVsaqv7mBsZGx6x25vUj8t9/
	4/qhRNHpcPkM1vEPSYwPqI0udd9qPZ8qh0yaIJH2wiQPvgx1teOg1cYUmf8hgrQ2nkQfPm
	yLO4YgypgZprOZdlhM7MGbjesKzhJao=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1791274655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QhnOzaE8bBQ71JyvzCOWddhycKSlWOSPkLx0UtTrWug=;
	b=dW28IiYnNBGd2BrmxydMiZmkuuHaJ8Zlxnc+Fczn5HKd792GhXXU1lE90Cx4PGiG6gl5Hw
	TTU0D3QN1E466+0RhU5X6STfdRyKevqkaxzjXu6rlMc+6E5qgXVoj/Mqy/iJUbhem+Ei0y
	JimVhkEZl4PIGxFOB5ygphppPAD3fUc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D4AE136F5;
	Tue,  6 Oct 2026 08:17:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rdDtGJ+uxGpCCwAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 06 Oct 2026 08:17:35 +0000
From: Oliver Neukum <oneukum@suse.com>
To: pkshih@realtek.com,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [RFTv2] net: wireless: rtl8xxxu: do not embed URBs
Date: Tue,  6 Oct 2026 10:10:47 +0200
Message-ID: <20261006081733.323024-1-oneukum@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

The USB layer is deprecating the embedment of URBs into
other data structures. Allocate them separately.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---

v2: heading Sashiko's comments about failing to change the error paths
    and memory leaks

 drivers/net/wireless/realtek/rtl8xxxu/core.c  | 74 ++++++++++++-------
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  6 +-
 2 files changed, 50 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index bddbd0990de7..7356f91e92df 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -5097,7 +5097,8 @@ static void rtl8xxxu_free_tx_resources(struct rtl8xxxu_priv *priv)
 	list_for_each_entry_safe(tx_urb, tmp, &priv->tx_urb_free_list, list) {
 		list_del(&tx_urb->list);
 		priv->tx_urb_free_count--;
-		usb_free_urb(&tx_urb->urb);
+		usb_free_urb(tx_urb->urb);
+		kfree(tx_urb);
 	}
 	spin_unlock_irqrestore(&priv->tx_urb_lock, flags);
 }
@@ -5148,12 +5149,11 @@ static void rtl8xxxu_free_tx_urb(struct rtl8xxxu_priv *priv,
 
 static void rtl8xxxu_tx_complete(struct urb *urb)
 {
-	struct sk_buff *skb = (struct sk_buff *)urb->context;
+	struct rtl8xxxu_tx_urb *tx_urb = urb->context;
+	struct sk_buff *skb = tx_urb->skb;
 	struct ieee80211_tx_info *tx_info;
 	struct ieee80211_hw *hw;
 	struct rtl8xxxu_priv *priv;
-	struct rtl8xxxu_tx_urb *tx_urb =
-		container_of(urb, struct rtl8xxxu_tx_urb, urb);
 
 	tx_info = IEEE80211_SKB_CB(skb);
 	hw = tx_info->rate_driver_data[0];
@@ -5592,13 +5592,14 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
 	if (priv->rtl_chip == RTL8710B || priv->rtl_chip == RTL8192F)
 		tx_desc->csum = ~tx_desc->csum;
 
-	usb_fill_bulk_urb(&tx_urb->urb, priv->udev, priv->pipe_out[queue],
-			  skb->data, skb->len, rtl8xxxu_tx_complete, skb);
+	tx_urb->skb = skb;
+	usb_fill_bulk_urb(tx_urb->urb, priv->udev, priv->pipe_out[queue],
+			  skb->data, skb->len, rtl8xxxu_tx_complete, tx_urb);
 
-	usb_anchor_urb(&tx_urb->urb, &priv->tx_anchor);
-	ret = usb_submit_urb(&tx_urb->urb, GFP_ATOMIC);
+	usb_anchor_urb(tx_urb->urb, &priv->tx_anchor);
+	ret = usb_submit_urb(tx_urb->urb, GFP_ATOMIC);
 	if (ret) {
-		usb_unanchor_urb(&tx_urb->urb);
+		usb_unanchor_urb(tx_urb->urb);
 		rtl8xxxu_free_tx_urb(priv, tx_urb);
 		goto error;
 	}
@@ -5826,7 +5827,8 @@ static void rtl8xxxu_free_rx_resources(struct rtl8xxxu_priv *priv)
 				 &priv->rx_urb_pending_list, list) {
 		list_del(&rx_urb->list);
 		priv->rx_urb_pending_count--;
-		usb_free_urb(&rx_urb->urb);
+		usb_free_urb(rx_urb->urb);
+		kfree(rx_urb);
 	}
 
 	spin_unlock_irqrestore(&priv->rx_urb_lock, flags);
@@ -5851,9 +5853,10 @@ static void rtl8xxxu_queue_rx_urb(struct rtl8xxxu_priv *priv,
 		if (priv->rx_urb_pending_count > RTL8XXXU_RX_URB_PENDING_WATER)
 			schedule_work(&priv->rx_urb_wq);
 	} else {
-		skb = (struct sk_buff *)rx_urb->urb.context;
+		skb = rx_urb->skb;
 		dev_kfree_skb_irq(skb);
-		usb_free_urb(&rx_urb->urb);
+		usb_free_urb(rx_urb->urb);
+		kfree(rx_urb);
 	}
 
 	spin_unlock_irqrestore(&priv->rx_urb_lock, flags);
@@ -5864,7 +5867,6 @@ static void rtl8xxxu_rx_urb_work(struct work_struct *work)
 	struct rtl8xxxu_priv *priv;
 	struct rtl8xxxu_rx_urb *rx_urb, *tmp;
 	struct list_head local;
-	struct sk_buff *skb;
 	unsigned long flags;
 	int ret;
 
@@ -5896,9 +5898,9 @@ static void rtl8xxxu_rx_urb_work(struct work_struct *work)
 		default:
 			dev_warn(&priv->udev->dev,
 				 "failed to requeue urb with error %i\n", ret);
-			skb = (struct sk_buff *)rx_urb->urb.context;
-			dev_kfree_skb(skb);
-			usb_free_urb(&rx_urb->urb);
+			dev_kfree_skb(rx_urb->skb);
+			usb_free_urb(rx_urb->urb);
+			kfree(rx_urb);
 		}
 	}
 }
@@ -6544,11 +6546,10 @@ int rtl8xxxu_parse_rxdesc24(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
 
 static void rtl8xxxu_rx_complete(struct urb *urb)
 {
-	struct rtl8xxxu_rx_urb *rx_urb =
-		container_of(urb, struct rtl8xxxu_rx_urb, urb);
+	struct rtl8xxxu_rx_urb *rx_urb = urb->context;
 	struct ieee80211_hw *hw = rx_urb->hw;
 	struct rtl8xxxu_priv *priv = hw->priv;
-	struct sk_buff *skb = (struct sk_buff *)urb->context;
+	struct sk_buff *skb = rx_urb->skb;
 	struct device *dev = &priv->udev->dev;
 
 	skb_put(skb, urb->actual_length);
@@ -6557,7 +6558,7 @@ static void rtl8xxxu_rx_complete(struct urb *urb)
 		priv->fops->parse_rx_desc(priv, skb);
 
 		skb = NULL;
-		rx_urb->urb.context = NULL;
+		rx_urb->urb->context = NULL;
 		rtl8xxxu_queue_rx_urb(priv, rx_urb);
 	} else {
 		dev_dbg(dev, "%s: status %i\n",	__func__, urb->status);
@@ -6592,12 +6593,13 @@ static int rtl8xxxu_submit_rx_urb(struct rtl8xxxu_priv *priv,
 		return -ENOMEM;
 
 	memset(skb->data, 0, rx_desc_sz);
-	usb_fill_bulk_urb(&rx_urb->urb, priv->udev, priv->pipe_in, skb->data,
-			  skb_size, rtl8xxxu_rx_complete, skb);
-	usb_anchor_urb(&rx_urb->urb, &priv->rx_anchor);
-	ret = usb_submit_urb(&rx_urb->urb, GFP_ATOMIC);
+	rx_urb->skb = skb;
+	usb_fill_bulk_urb(rx_urb->urb, priv->udev, priv->pipe_in, skb->data,
+			  skb_size, rtl8xxxu_rx_complete, rx_urb);
+	usb_anchor_urb(rx_urb->urb, &priv->rx_anchor);
+	ret = usb_submit_urb(rx_urb->urb, GFP_ATOMIC);
 	if (ret)
-		usb_unanchor_urb(&rx_urb->urb);
+		usb_unanchor_urb(rx_urb->urb);
 	return ret;
 }
 
@@ -7435,7 +7437,14 @@ static int rtl8xxxu_start(struct ieee80211_hw *hw)
 
 			goto error_out;
 		}
-		usb_init_urb(&tx_urb->urb);
+		tx_urb->urb = usb_alloc_urb(0, GFP_KERNEL);
+		if (!tx_urb->urb) {
+			kfree(tx_urb);
+			if (!i)
+				ret = -ENOMEM;
+
+			goto error_out;
+		}
 		INIT_LIST_HEAD(&tx_urb->list);
 		tx_urb->hw = hw;
 		list_add(&tx_urb->list, &priv->tx_urb_free_list);
@@ -7456,15 +7465,24 @@ static int rtl8xxxu_start(struct ieee80211_hw *hw)
 
 			goto error_out;
 		}
-		usb_init_urb(&rx_urb->urb);
+		rx_urb->urb = usb_alloc_urb(0, GFP_KERNEL);
+		if (!rx_urb->urb) {
+			kfree(rx_urb);
+			if (!i)
+				ret = -ENOMEM;
+
+			goto error_out;
+		}
 		INIT_LIST_HEAD(&rx_urb->list);
 		rx_urb->hw = hw;
 
 		ret = rtl8xxxu_submit_rx_urb(priv, rx_urb);
 		if (ret) {
 			if (ret != -ENOMEM) {
-				skb = (struct sk_buff *)rx_urb->urb.context;
+				struct rtl8xxxu_rx_urb *u = rx_urb->urb->context;
+				skb = u->skb;
 				dev_kfree_skb(skb);
+				u->skb = NULL;
 			}
 			rtl8xxxu_queue_rx_urb(priv, rx_urb);
 		}
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index eeb18eb0e4c0..06cf743605c2 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1948,15 +1948,17 @@ struct rtl8xxxu_vif {
 };
 
 struct rtl8xxxu_rx_urb {
-	struct urb urb;
+	struct urb *urb;
 	struct ieee80211_hw *hw;
 	struct list_head list;
+	struct sk_buff *skb;
 };
 
 struct rtl8xxxu_tx_urb {
-	struct urb urb;
+	struct urb *urb;
 	struct ieee80211_hw *hw;
 	struct list_head list;
+	struct sk_buff *skb;
 };
 
 struct rtl8xxxu_fileops {
-- 
2.55.0

