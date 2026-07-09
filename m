Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612EC421EF3
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783598488; cv=none; b=I8glNTe44ZAxnd6vTfmswa398xPNkMbcb8JEsn4ojvvwiEZxT8aeaf6wgBKt/6fYnGF1UYdgb4fCP9K3beZnoiAdKsJTICwV8+x8WFPDaV1Rx/9pzTYaUpH1DndKD3u7xQPRPdTkwHttTm0+hQw8tAb+OHlLqWCc+gSfsG5o0jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783598488; c=relaxed/simple;
	bh=Htl6c36B8dE9puLyF/oy3vogvxkI7f0K2VvzunfRNqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+KVJuiCBnM88Z3cL5eHnsNAf8JPMzyPBttlYN3/90LLtZ6F/rK5Nl2nhdthZlqDTsDro3hv9U6ZoJfZkgQEMxSBVqbHHK+WtFd1d0RNsWmbD9Q+bih26n26RFQat92nzXP98aRCfVILjm+bVys/NiJnWSVpF7hRFoRB97jOEns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WHsDlsWI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WHsDlsWI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WHsDlsWI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WHsDlsWI"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3D54E761BA;
	Thu,  9 Jul 2026 12:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1783598480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2idcN/Q/emwBtFOQniHHb7bc/xbfDXc0WloxPi9y6hA=;
	b=WHsDlsWI6oXqKdRULYlXOlM+AZyoit0jbsBIOO881df2q7EgHwr6OsG8KjGlegJZHl83dW
	JM6Q1mo/Qhou8uXNM3OnvrIiwCan6a3D1H+itmGqrWB6HYK0pu+FmzRzimEjcwa8LSKDLQ
	qDu5B1cfVsCLg7jL5yRRj5zI5xweAmU=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1783598480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2idcN/Q/emwBtFOQniHHb7bc/xbfDXc0WloxPi9y6hA=;
	b=WHsDlsWI6oXqKdRULYlXOlM+AZyoit0jbsBIOO881df2q7EgHwr6OsG8KjGlegJZHl83dW
	JM6Q1mo/Qhou8uXNM3OnvrIiwCan6a3D1H+itmGqrWB6HYK0pu+FmzRzimEjcwa8LSKDLQ
	qDu5B1cfVsCLg7jL5yRRj5zI5xweAmU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00088779B4;
	Thu,  9 Jul 2026 12:01:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kMWIOo+NT2pEWQAAD6G6ig
	(envelope-from <oneukum@suse.com>); Thu, 09 Jul 2026 12:01:19 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	manuelebner@mailbox.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCHv2 net-next 2/7] net: usb: usbnet: add cdc_state to struct usbnet
Date: Thu,  9 Jul 2026 14:01:11 +0200
Message-ID: <20260709120116.1423033-2-oneukum@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709120116.1423033-1-oneukum@suse.com>
References: <20260709120116.1423033-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Score: -5.30

This allows centralisation of code using cdc_state in usbnet, reducing
code duplication. No functional change intended.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 include/linux/usb/usbnet.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
index bbf799ccf3b3..79f48eb388ee 100644
--- a/include/linux/usb/usbnet.h
+++ b/include/linux/usb/usbnet.h
@@ -16,6 +16,14 @@
 #include <linux/usb.h>
 #include <linux/spinlock.h>
 
+struct cdc_state {
+	struct usb_cdc_header_desc      *header;
+	struct usb_cdc_union_desc       *u;
+	struct usb_cdc_ether_desc       *ether;
+	struct usb_interface            *control;
+	struct usb_interface            *data;
+};
+
 /* interface from usbnet core to each USB networking link we handle */
 struct usbnet {
 	/* housekeeping */
@@ -41,6 +49,7 @@ struct usbnet {
 	/* protocol/interface state */
 	struct net_device	*net;
 	int			msg_enable;
+	struct cdc_state	cdc;		/* too common to leave out*/
 	unsigned long		data[5];
 	u32			xid;
 	u32			hard_mtu;	/* count any extra framing */
@@ -211,13 +220,6 @@ extern int usbnet_write_cmd_async(struct usbnet *dev, u8 cmd, u8 reqtype,
  * (notably, using multiple interfaces according to the CDC
  * union descriptor) get some helper code.
  */
-struct cdc_state {
-	struct usb_cdc_header_desc	*header;
-	struct usb_cdc_union_desc	*u;
-	struct usb_cdc_ether_desc	*ether;
-	struct usb_interface		*control;
-	struct usb_interface		*data;
-};
 
 extern void usbnet_cdc_update_filter(struct usbnet *dev);
 extern int usbnet_generic_cdc_bind(struct usbnet *, struct usb_interface *);
-- 
2.54.0

