Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24413911DC
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 11:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029485; cv=none; b=YS4yTfmRXE4+VL7bbD3PuuUP3ey/sqrwnI20v6eR5rANZOpDUkrs5L8eRpWV4zAC6v9P1VhKBr7G/T/XrUeoR4jyq5oH7GuCavurIwVV4+a3ZESNAUGgqjb1mT/oAtvHqBMXCUe1y6eA/6qmVpRjgBxj1z9+6paQfiZqrs5Fmk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029485; c=relaxed/simple;
	bh=p5LEF0TpeuJUKX9WSanvmmAQejWqAwoFRjpWjPdXn3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HU4RojJVH28SDEOTW+3tTOaIJNZTsGZkeBt3wKYxJclVsPky/AuKDGvlsMHHwsHOG6HfYtadipwFfANj9dXU/6H3NjxLqlxU0ScIn48j5q/FQe5qlj+RwvX9XvGcY4PDKwKGNqwCUq659jIiyq+cpn81cDBI4ABps3SJJ0P4cc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=I0+agjdg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=I0+agjdg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="I0+agjdg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="I0+agjdg"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B804477E2F;
	Tue, 14 Jul 2026 11:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1784029472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Enu0+TkL5+FOi84prkYHDpdzqlXme7u+bi/VxlIaI6M=;
	b=I0+agjdgqt98dPTb83pEeoB49401JRC2CDwxRBYNn7mCJhnlYgENjcqEjYsllelYFtbiVA
	BPi8m6ZA+LXalNpsfdixAS8ViI1iutiNisuVeVy35s+3arpZPp3cUPi62TQZz+3/NbCfyV
	Y4EyVJKNiICAGfDT5u59Y044egwzL+A=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1784029472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Enu0+TkL5+FOi84prkYHDpdzqlXme7u+bi/VxlIaI6M=;
	b=I0+agjdgqt98dPTb83pEeoB49401JRC2CDwxRBYNn7mCJhnlYgENjcqEjYsllelYFtbiVA
	BPi8m6ZA+LXalNpsfdixAS8ViI1iutiNisuVeVy35s+3arpZPp3cUPi62TQZz+3/NbCfyV
	Y4EyVJKNiICAGfDT5u59Y044egwzL+A=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 854E1779AF;
	Tue, 14 Jul 2026 11:44:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qOhoHyAhVmp+cwAAD6G6ig
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
Subject: [PATCHv3 net-next 4/9] net: usb: use cdc_state in struct usbnet
Date: Tue, 14 Jul 2026 13:44:24 +0200
Message-ID: <20260714114429.1073434-4-oneukum@suse.com>
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

Remove private copies as now a central state can be used.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/usb/cdc_ether.c  | 9 +++------
 drivers/net/usb/rndis_host.c | 6 +++---
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index e688fb99c61d..76ad4ffa950a 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -85,7 +85,7 @@ int usbnet_generic_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
 	u8				*buf = intf->cur_altsetting->extra;
 	int				len = intf->cur_altsetting->extralen;
 	struct usb_interface_descriptor	*d;
-	struct cdc_state		*info = (void *) &dev->data;
+	struct cdc_state		*info = &dev->cdc;
 	int				status = -ENODEV;
 	int				rndis;
 	bool				android_rndis_quirk = false;
@@ -336,7 +336,7 @@ EXPORT_SYMBOL_GPL(usbnet_ether_cdc_bind);
 
 void usbnet_cdc_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct cdc_state		*info = (void *) &dev->data;
+	struct cdc_state		*info = &dev->cdc;
 	struct usb_driver		*driver = driver_of(intf);
 
 	/* combined interface - nothing  to do */
@@ -374,10 +374,7 @@ EXPORT_SYMBOL_GPL(usbnet_cdc_unbind);
 int usbnet_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
 {
 	int				status;
-	struct cdc_state		*info = (void *) &dev->data;
-
-	BUILD_BUG_ON((sizeof(((struct usbnet *)0)->data)
-			< sizeof(struct cdc_state)));
+	struct cdc_state		*info = &dev->cdc;
 
 	status = usbnet_ether_cdc_bind(dev, intf);
 	if (status < 0)
diff --git a/drivers/net/usb/rndis_host.c b/drivers/net/usb/rndis_host.c
index 5e39d05a2d7b..d539654687c3 100644
--- a/drivers/net/usb/rndis_host.c
+++ b/drivers/net/usb/rndis_host.c
@@ -57,7 +57,7 @@ EXPORT_SYMBOL_GPL(rndis_status);
 static void rndis_msg_indicate(struct usbnet *dev, struct rndis_indicate *msg,
 				int buflen)
 {
-	struct cdc_state *info = (void *)&dev->data;
+	struct cdc_state *info = &dev->cdc;
 	struct device *udev = &info->control->dev;
 
 	if (dev->driver_info->indication) {
@@ -90,7 +90,7 @@ static void rndis_msg_indicate(struct usbnet *dev, struct rndis_indicate *msg,
  */
 int rndis_command(struct usbnet *dev, struct rndis_msg_hdr *buf, int buflen)
 {
-	struct cdc_state	*info = (void *) &dev->data;
+	struct cdc_state	*info = &dev->cdc;
 	struct usb_cdc_notification notification;
 	int			master_ifnum;
 	int			retval;
@@ -290,7 +290,7 @@ generic_rndis_bind(struct usbnet *dev, struct usb_interface *intf, int flags)
 {
 	int			retval;
 	struct net_device	*net = dev->net;
-	struct cdc_state	*info = (void *) &dev->data;
+	struct cdc_state	*info = &dev->cdc;
 	union {
 		void			*buf;
 		struct rndis_msg_hdr	*header;
-- 
2.54.0

