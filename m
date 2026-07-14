Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3E238399B
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 11:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029476; cv=none; b=ie+7VWG4yP72zpNLII021Mfn4iFqjrhDNJDBLs1OG71BFRoaRRUw+ypHtHKz4sHfK+yG6tIMGHxVavoJN8N7FmVXT2PdD+u9uP9ENx9N+DEql4VXblqHCLiCDgqM13pKkQJIg53dpVvXgphCVLSx0l9oe5LQnY0HVrY8Lu4X2lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029476; c=relaxed/simple;
	bh=qkVecHnPWlWrvxbn1jGLFA7r3ztwnh+Ads2uXugq55w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECpJVcCtZEP3bODax2JC5FM3VuwxO+k4puj600ziZfo4wcW6mkPovNiQM0Af8MU0B+Sbgq/9IGY3GWGZxwuF7xDhbrTq6nPVnXDasnfpg4UJZ5vU048Jvq8Ez7FRMyJuWHU79dqtbMIFnNhKxkTAJ1UOjS7MyfBBVW41E3Ikjdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N854Dr6o; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N854Dr6o; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N854Dr6o";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N854Dr6o"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 47D1577E2D;
	Tue, 14 Jul 2026 11:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1784029472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7SG94XJgSPoCBr54IEe+BPhmsgEhA3JqMHwvfzdzbg=;
	b=N854Dr6o2Yhyy1zvz+jutTIowJDzFloCqjrFekHuzhCVRaJYjGzKVmyxjNX+zhz7aw/yFZ
	MoR5c6kXSrOlY5E9YjrnJEILsTKlD/kpyRS2h47hyjzqZ3qas4UNRTSKszXaQWYIhkx00A
	dBnPpU2KcATat23URvoOcbLSe2OGSRM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1784029472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7SG94XJgSPoCBr54IEe+BPhmsgEhA3JqMHwvfzdzbg=;
	b=N854Dr6o2Yhyy1zvz+jutTIowJDzFloCqjrFekHuzhCVRaJYjGzKVmyxjNX+zhz7aw/yFZ
	MoR5c6kXSrOlY5E9YjrnJEILsTKlD/kpyRS2h47hyjzqZ3qas4UNRTSKszXaQWYIhkx00A
	dBnPpU2KcATat23URvoOcbLSe2OGSRM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11776779AF;
	Tue, 14 Jul 2026 11:44:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gLIuAyAhVmp+cwAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 14 Jul 2026 11:44:32 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	manuelebner@mailbox.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCHv3 net-next 2/9] net: usb: centralize usbnet_cdc_zte_rx_fixup in usbnet
Date: Tue, 14 Jul 2026 13:44:22 +0200
Message-ID: <20260714114429.1073434-2-oneukum@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714114429.1073434-1-oneukum@suse.com>
References: <20260714114429.1073434-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Score: -1.30

This helper is used by multiple drivers using usbnet.
It is better to be provided by usbnet than one of them.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---

v2:
- spelling issues
- issue with lost synchronization with SPLIT packets

 drivers/net/usb/cdc_ether.c | 19 -------------------
 drivers/net/usb/usbnet.c    | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index b4df32e18461..e688fb99c61d 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -404,25 +404,6 @@ static int usbnet_cdc_zte_bind(struct usbnet *dev, struct usb_interface *intf)
 	return status;
 }
 
-/* Make sure packets have correct destination MAC address
- *
- * A firmware bug observed on some devices (ZTE MF823/831/910) is that the
- * device sends packets with a static, bogus, random MAC address (event if
- * device MAC address has been updated). Always set MAC address to that of the
- * device.
- */
-int usbnet_cdc_zte_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
-{
-	if (skb->len < ETH_HLEN || !(skb->data[0] & 0x02))
-		return 1;
-
-	skb_reset_mac_header(skb);
-	ether_addr_copy(eth_hdr(skb)->h_dest, dev->net->dev_addr);
-
-	return 1;
-}
-EXPORT_SYMBOL_GPL(usbnet_cdc_zte_rx_fixup);
-
 /* Ensure correct link state
  *
  * Some devices (ZTE MF823/831/910) export two carrier on notifications when
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 21c55d70f27c..14e9f1b1e0a2 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -2350,6 +2350,25 @@ void usbnet_cdc_status(struct usbnet *dev, struct urb *urb)
 	}
 }
 EXPORT_SYMBOL_GPL(usbnet_cdc_status);
+
+/* Make sure packets have correct destination MAC address
+ *
+ * A firmware bug observed on some devices (ZTE MF823/831/910) is that the
+ * device sends packets with a static, bogus, random MAC address (event if
+ * device MAC address has been updated). Always set MAC address to that of the
+ * device.
+ */
+int usbnet_cdc_zte_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
+{
+	if (skb->len < ETH_HLEN || !(skb->data[0] & 0x02))
+		return 1;
+
+	skb_reset_mac_header(skb);
+	ether_addr_copy(eth_hdr(skb)->h_dest, dev->net->dev_addr);
+
+	return 1;
+}
+EXPORT_SYMBOL_GPL(usbnet_cdc_zte_rx_fixup);
 /*-------------------------------------------------------------------------*/
 
 static int __init usbnet_init(void)
-- 
2.54.0

