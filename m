Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF303358C4
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 13:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778678964; cv=none; b=h0i4FLwvypCZEtcssgSmGKT1iKaCCT0kamb4rOlXAsAOzzWdTxbacaugR/Nja71e7Wu5zp6fjXSymg33y8dxQoCp2Ycqfapd5G9n3dJzRbR/TYRsMOnT5ttLBVZLKxG+CvdHEQ36Wvr5K2ZAjo3uoudiOSIaNge3vBBhf5/ll1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778678964; c=relaxed/simple;
	bh=CgZXSDO8c1wEAvdBrbMEv8gZzSneegX5wHiIYy1/rNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sdwin9Hv2JhIsGedXrZwx1Q9JUPiGpMMwAQ1+PkAQSJZP2p3vH1XTQeZ2hiYbDEHfvmxwuVg6JDYcj5XaYgpEcOmJIjv1BW/eUmLw+2hpAV5aOfAQzYNuylyWAy9/BQPRFajcvruzU1a3/GsMhUCOJ9pPkZGyBAiQvewkBC2YvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nadJ6F5u; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nadJ6F5u; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nadJ6F5u";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nadJ6F5u"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1DC6F6AD6A;
	Wed, 13 May 2026 13:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1778678961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eCaWWbbdg0DMZ/HsSLHchgUEEF5ZUudlw1zky130mWw=;
	b=nadJ6F5u9KxA77+FkLxO9Q+NmRGP//q4ribrYs6oFinVftxsyWrJpEyzzq875ceO7Ze4x2
	mUC/WD4uVff1nwo1Dga9sZag9QWPXFyfva68AXLASOeiUyFZrSM8Fti4/LyotW4xK4UJgn
	OBBqdY4Yw5kBSxnWiHQCm8nD+6FLQWQ=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=nadJ6F5u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1778678961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eCaWWbbdg0DMZ/HsSLHchgUEEF5ZUudlw1zky130mWw=;
	b=nadJ6F5u9KxA77+FkLxO9Q+NmRGP//q4ribrYs6oFinVftxsyWrJpEyzzq875ceO7Ze4x2
	mUC/WD4uVff1nwo1Dga9sZag9QWPXFyfva68AXLASOeiUyFZrSM8Fti4/LyotW4xK4UJgn
	OBBqdY4Yw5kBSxnWiHQCm8nD+6FLQWQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9C94593A9;
	Wed, 13 May 2026 13:29:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YSoJNLB8BGoeXgAAD6G6ig
	(envelope-from <oneukum@suse.com>); Wed, 13 May 2026 13:29:20 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH net-next] net: usb: usbnet: use proper ep number macros
Date: Wed, 13 May 2026 15:29:16 +0200
Message-ID: <20260513132916.39896-1-oneukum@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1DC6F6AD6A
X-Spam-Level: 

We have macros to retrieve endpoint numbers now.
Use them.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/usb/usbnet.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index b72ba0803392..25518635b7b7 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -149,10 +149,8 @@ int usbnet_get_endpoints(struct usbnet *dev, struct usb_interface *intf)
 			return tmp;
 	}
 
-	dev->in = usb_rcvbulkpipe(dev->udev,
-				  in->desc.bEndpointAddress & USB_ENDPOINT_NUMBER_MASK);
-	dev->out = usb_sndbulkpipe(dev->udev,
-				   out->desc.bEndpointAddress & USB_ENDPOINT_NUMBER_MASK);
+	dev->in = usb_rcvbulkpipe(dev->udev, usb_endpoint_num(&in->desc));
+	dev->out = usb_sndbulkpipe(dev->udev, usb_endpoint_num(&out->desc));
 	dev->status = status;
 	return 0;
 }
@@ -232,9 +230,7 @@ static int init_status(struct usbnet *dev, struct usb_interface *intf)
 	if (!dev->driver_info->status)
 		return 0;
 
-	pipe = usb_rcvintpipe(dev->udev,
-			      dev->status->desc.bEndpointAddress
-			      & USB_ENDPOINT_NUMBER_MASK);
+	pipe = usb_rcvintpipe(dev->udev, usb_endpoint_num(&dev->status->desc));
 	maxp = usb_maxpacket(dev->udev, pipe);
 
 	/* avoid 1 msec chatter:  min 8 msec poll rate */
-- 
2.54.0

