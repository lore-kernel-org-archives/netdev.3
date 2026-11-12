Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794480356;
	b=iHc9BOwjmIH8Tc/hEPk2ovnccEDrRCsCiPIvsi1BSqiOAy73dyg57J9iwjYgNUnrH3eh
	 0ObH7W88n23Yq9C6piT/JIZYRtYew8NgjTUehb+WviFa2wJYSodwatiMe+nQIUp3NG0YJ
	 TaOpwOdCpTGXsP5GcgjeUFP7riC2WWnhfiJ+aAWf3I5eYGFQ1Xt7oiQ/lXVsd8+NCBkA7
	 yciLqKaUp1xcmq0dHHDXLaJrsYYArgOOiIXkQ72tEXj3tCbJupq4q/EXSPYZiMn2q+gO3
	 Q0XKNCqpFCDhlhmiEMhGHALAH0L+3yEKB+Y38TR1DG294ZOzqFnd/qUvyLw4nxduvLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480356;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=tSYotEmmpwO0914M6sxzeqhwcBbbWulbYcdw+O9tcI8=;
	b=4iaX/dXsEit5SDSZGGV5EqyQYra4kzZCHMjxDLFv7I8EBJPuPB+tu4UIgr26yVBzcmeJ
	 444jMLm82p3TyKqhVh9owOxRlVLSRu6VWtTEVYXNgi2i3MPW2kNeBuSBkl5iLnAhPz+Uz
	 EwwWBUKCA2PIElbsGbM00pmJK1oQ3ZVjdRM0ow/ot5J5vLtXRO8X51V16B5jTApJP5dVD
	 646kTs/n7u5sNaEo1h/WN7LnLOzY1b4IlwIuqMNZLKjz9B5odjXg1UpNXuadDjuxjcWHl
	 tBuw6vyyPp+1nuUgxGz1zNAbaOvS33Kue9pHLwXCffMenVW3zUjxv6f/qC6THGVUZ2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=QM+hxa8S;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=QM+hxa8S;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C82606A33E;
	Thu, 12 Nov 2026 10:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75C82606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=QM+hxa8S;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=QM+hxa8S
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6C17021C82;
	Thu, 12 Nov 2026 10:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794480353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tSYotEmmpwO0914M6sxzeqhwcBbbWulbYcdw+O9tcI8=;
	b=QM+hxa8SO3kXjLDKLwIaK+hPE+CFmebUEyVLd9wWlZ8yPay0XuEKWjb2hHPlFXwrG7DMHy
	0iAJIRyF4VSIwnjFD/uNrmNED/6mEviFTEPN33IWXPPN/7tE3xgqOLmkgHgIR9pNySZ6Qf
	Eg0gzzfNWpjJUOahQYicH3ABXC1CCb4=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=QM+hxa8S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794480353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tSYotEmmpwO0914M6sxzeqhwcBbbWulbYcdw+O9tcI8=;
	b=QM+hxa8SO3kXjLDKLwIaK+hPE+CFmebUEyVLd9wWlZ8yPay0XuEKWjb2hHPlFXwrG7DMHy
	0iAJIRyF4VSIwnjFD/uNrmNED/6mEviFTEPN33IWXPPN/7tE3xgqOLmkgHgIR9pNySZ6Qf
	Eg0gzzfNWpjJUOahQYicH3ABXC1CCb4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06AE713432;
	Thu, 12 Nov 2026 10:45:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YOzfM+CY9Wr4VwAAD6G6ig
	(envelope-from <oneukum@suse.com>); Thu, 12 Nov 2026 10:45:53 +0000
From: Oliver Neukum <oneukum@suse.com>
To: petkan@nucleusys.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH net 1/1] net: usb: rtl8150: break cycle between tasklet and URB
Date: Thu, 12 Nov 2026 11:45:11 +0100
Message-ID: <20261112104548.693456-1-oneukum@suse.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6C17021C82
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-10.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:email]
X-Spam-Score: -10.51

The tasklet can resubmit the URB, which in turn can
resubmit the tasklet. The cycle needs to be broken.
The simplest way to do so is to prevent the resubmission
of the URBs by poisoning them.

Fixes: eff674a514bd3 ("USB: rtl8150_disconnect() needs tasklet_kill()")
Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/usb/rtl8150.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index d51e43170e03..846e6329d571 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -343,6 +343,13 @@ static int alloc_all_urbs(rtl8150_t * dev)
 		return 0;
 	}
 
+	/*
+	 * They need to be blocked so that open()
+	 * can unblock them
+	 */
+	usb_block_urb(dev->rx_urb);
+	usb_block_urb(dev->tx_urb);
+	usb_block_urb(dev->intr_urb);
 	return 1;
 }
 
@@ -353,11 +360,18 @@ static void free_all_urbs(rtl8150_t * dev)
 	usb_free_urb(dev->intr_urb);
 }
 
+static void reenable_all_urbs(rtl8150_t *dev)
+{
+	usb_unpoison_urb(dev->rx_urb);
+	usb_unpoison_urb(dev->tx_urb);
+	usb_unpoison_urb(dev->intr_urb);
+}
+
 static void unlink_all_urbs(rtl8150_t * dev)
 {
-	usb_kill_urb(dev->rx_urb);
-	usb_kill_urb(dev->tx_urb);
-	usb_kill_urb(dev->intr_urb);
+	usb_poison_urb(dev->rx_urb);
+	usb_poison_urb(dev->tx_urb);
+	usb_poison_urb(dev->intr_urb);
 }
 
 static inline struct sk_buff *pull_skb(rtl8150_t *dev)
@@ -425,6 +439,11 @@ static void read_bulk_callback(struct urb *urb)
 	netdev->stats.rx_bytes += pkt_len;
 
 	spin_lock_irqsave(&dev->rx_pool_lock, flags);
+	/* prevent an eteral loop */
+	if (test_bit(RTL8150_UNPLUG, &dev->flags)) {
+		spin_unlock_irqrestore(&dev->rx_pool_lock, flags);
+		return;
+	}
 	skb = pull_skb(dev);
 	spin_unlock_irqrestore(&dev->rx_pool_lock, flags);
 	if (!skb)
@@ -518,7 +537,7 @@ static void intr_callback(struct urb *urb)
 	res = usb_submit_urb (urb, GFP_ATOMIC);
 	if (res == -ENODEV)
 		netif_device_detach(dev->netdev);
-	else if (res)
+	else if (res != -EPERM)
 		dev_err(&dev->udev->dev,
 			"can't resubmit intr, %s-%s/input0, status %d\n",
 			dev->udev->bus->bus_name, dev->udev->devpath, res);
@@ -751,6 +770,7 @@ static int rtl8150_open(struct net_device *netdev)
 	if (!dev->rx_skb)
 		return -ENOMEM;
 
+	reenable_all_urbs(dev);
 	set_registers(dev, IDR, 6, netdev->dev_addr);
 
 	usb_fill_bulk_urb(dev->rx_urb, dev->udev, usb_rcvbulkpipe(dev->udev, 1),
@@ -969,8 +989,9 @@ static void rtl8150_disconnect(struct usb_interface *intf)
 	if (dev) {
 		set_bit(RTL8150_UNPLUG, &dev->flags);
 		tasklet_kill(&dev->tl);
-		unregister_netdev(dev->netdev);
 		unlink_all_urbs(dev);
+		tasklet_kill(&dev->tl);
+		unregister_netdev(dev->netdev);
 		free_all_urbs(dev);
 		free_skb_pool(dev);
 		dev_kfree_skb(dev->rx_skb);
-- 
2.56.0

