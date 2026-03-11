Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71053D332F
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 11:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773228575; cv=none; b=DcqmOHNYkQ6kn+7L0Cuq7yNSAqntOl8tOEZqtVMCMw6FvyMu4KlyMT0CZ+MlGaNa6Gna0fD6zuFsqahvO6ZeJSGaCSQd05ScGTZzk2c4iTPruphm26fut0xXM9QvCUGybUl6LyrWd+TsMhCVSVoRT87Rbh5k81pwj9T8ifp7f3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773228575; c=relaxed/simple;
	bh=MijpmT8d0aOim4CYsO8ErOlvGdsJ76FcghLWFsRJnJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TgjKfnL9tUOv+Q86E+rxgNyviQoOAq81Og8aFBE0Rus18+83/xwRFCu3Ctjue/gCDYUUX6tNi/tDOGknWgiwC6C/fV4CDGcJ35me1uPj2osVbuiAfP8YopGCmv6rEEbLJgf6qittizJkh1Nb1crrTmARUicMvKa+VbIO5lxL1/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rT8eorlI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rT8eorlI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rT8eorlI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rT8eorlI"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E84935BE09;
	Wed, 11 Mar 2026 11:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773228567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fYCxMWNvkCX04iAEnfLuVsU822DGnyYOHK5haHnUdIU=;
	b=rT8eorlILYfFv+9W0cbZCHaC63X2H2onfIJBmugBs5GZ9ioUIbcUlfluIUFe/+/VIgd2Eg
	QllTAKUjfuvL8gg2/iJF6iHTdtuZBx4tJQKHpWYi70iZ0KMKPmSHEP0zKU9T9aTCnnln27
	Cl6+orVwWm1uaS+q6P9177m/FI0r2vk=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773228567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fYCxMWNvkCX04iAEnfLuVsU822DGnyYOHK5haHnUdIU=;
	b=rT8eorlILYfFv+9W0cbZCHaC63X2H2onfIJBmugBs5GZ9ioUIbcUlfluIUFe/+/VIgd2Eg
	QllTAKUjfuvL8gg2/iJF6iHTdtuZBx4tJQKHpWYi70iZ0KMKPmSHEP0zKU9T9aTCnnln27
	Cl6+orVwWm1uaS+q6P9177m/FI0r2vk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B00BB3F9C0;
	Wed, 11 Mar 2026 11:29:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S/vXKRdSsWlMVwAAD6G6ig
	(envelope-from <oneukum@suse.com>); Wed, 11 Mar 2026 11:29:27 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 1/1 net-next] net: usb: cdc-ether: unify error handling in probe
Date: Wed, 11 Mar 2026 12:28:51 +0100
Message-ID: <20260311112919.678686-1-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.977];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spam-Level: 

usbnet_generic_cdc_bind() is duplicating the error handling
multiple times. That is bad. Unify it with jumps.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/usb/cdc_ether.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index a032c1ded406..327cfdfe36e0 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -115,7 +115,7 @@ int usbnet_generic_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
 	int				len = intf->cur_altsetting->extralen;
 	struct usb_interface_descriptor	*d;
 	struct cdc_state		*info = (void *) &dev->data;
-	int				status;
+	int				status = -ENODEV;
 	int				rndis;
 	bool				android_rndis_quirk = false;
 	struct usb_driver		*driver = driver_of(intf);
@@ -288,16 +288,11 @@ int usbnet_generic_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
 	if (info->data != info->control) {
 		status = usb_driver_claim_interface(driver, info->data, dev);
 		if (status < 0)
-			return status;
+			goto bad_desc;
 	}
 	status = usbnet_get_endpoints(dev, info->data);
-	if (status < 0) {
-		/* ensure immediate exit from usbnet_disconnect */
-		usb_set_intfdata(info->data, NULL);
-		if (info->data != info->control)
-			usb_driver_release_interface(driver, info->data);
-		return status;
-	}
+	if (status < 0)
+		goto bail_out_and_release;
 
 	/* status endpoint: optional for CDC Ethernet, not RNDIS (or ACM) */
 	if (info->data != info->control)
@@ -317,9 +312,8 @@ int usbnet_generic_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
 	}
 	if (rndis && !dev->status) {
 		dev_dbg(&intf->dev, "missing RNDIS status endpoint\n");
-		usb_set_intfdata(info->data, NULL);
-		usb_driver_release_interface(driver, info->data);
-		return -ENODEV;
+		status = -ENODEV;
+		goto bail_out_and_release;
 	}
 
 	/* override ethtool_ops */
@@ -327,9 +321,13 @@ int usbnet_generic_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
 
 	return 0;
 
+bail_out_and_release:
+	usb_set_intfdata(info->data, NULL);
+	if (info->data != info->control)
+		usb_driver_release_interface(driver, info->data);
 bad_desc:
 	dev_info(&dev->udev->dev, "bad CDC descriptors\n");
-	return -ENODEV;
+	return status;
 }
 EXPORT_SYMBOL_GPL(usbnet_generic_cdc_bind);
 
-- 
2.53.0

