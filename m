Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80AB4279FE
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783598513; cv=none; b=DiGoAPOKgyVXSINxpMM7pj58gHwN0cklBo9t6PQ+NYvbau7b2mdW5eMDyT/0EBDrnJAMKjWn5sXuxj1CXvOCkEl6GQgO6LE72oewsLOW+DkI3Zo0YduDpHW8+9f3snwK4obXlN1tRP2sge8SGuKwca535upnd9UnZpv2rJeeLhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783598513; c=relaxed/simple;
	bh=YaftiL5RUxufmRXVLTK7iUc4Nc+XKY2chptq1eO62ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YF3NZCwLBiH3fG6a25drNjyIA5BRE3HuUJoUW3RdSYH8kD1iYwVOHs5A/Iy5lVzlmyRG1VXYeVGwK8Ryl9hgu+uevb1BthHzJ0ju1uYwERlZnxcXDL5ph7RStA2URuzj4jDWzYU8RoaWtfbEZIeHIbnoVO6ZwhEkdteKyiuOV5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8CC35761C1;
	Thu,  9 Jul 2026 12:01:21 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4850A779B5;
	Thu,  9 Jul 2026 12:01:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WDiqEJGNT2pEWQAAD6G6ig
	(envelope-from <oneukum@suse.com>); Thu, 09 Jul 2026 12:01:21 +0000
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
Subject: [PATCHv2 net-next 7/7] net: usb: usbnet: remove outdated sanity check
Date: Thu,  9 Jul 2026 14:01:16 +0200
Message-ID: <20260709120116.1423033-7-oneukum@suse.com>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 8CC35761C1
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN_FAIL(0.00)[7.9.0.0.4.6.0.0.0.5.1.0.0.1.0.0.4.0.1.0.1.8.2.b.0.4.e.d.7.0.a.2.asn6.rspamd.com:server fail];
	TAGGED_RCPT(0.00)[netdev]

The cdc state is now included as a proper member in the descriptor.
There is no point in checking whether it fits into the scratchpad
area. Just remove the check.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---

v2:

- added to address concern about maintainability

 drivers/net/usb/usbnet.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index ce932c81382e..0347f6887222 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -2457,9 +2457,6 @@ int usbnet_generic_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
 	struct usb_driver		*driver = driver_of(intf);
 	struct usb_cdc_parsed_header header;
 
-	if (sizeof(dev->data) < sizeof(*info))
-		return -EDOM;
-
 	/* expect strict spec conformance for the descriptors, but
 	 * cope with firmware which stores them in the wrong place
 	 */
-- 
2.54.0

