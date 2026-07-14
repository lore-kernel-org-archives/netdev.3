Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2AE37D123
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 11:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029493; cv=none; b=jjeX6R+UarHdymaUgsyoY4u42qSK1hA6OUs8UORC+KI2sXgYAigf1AT/eGddwTsLBMu6D7TiE6oMOJ/t9TUh1bCNjg0oY2JPCQFF16G3wJ/DRuCmMxnogSnpVMd/m9pPtIj4OqGOfPc6REe8JtwMrBAlUHy+SYth+VB1oVLr5oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029493; c=relaxed/simple;
	bh=VXuxGDJ+jHD6GfacGQCsOJ0NZa2qKLOQNrBkm9tBygk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bP+0/Zlz/slgZJAbypvqGZxLZhjBQPlUveFYIaVuiWP5WNgpv/8YCmqYLJ0/1MYZd9dAHl0PcChvol/a80gkSFGeeaivUuO0/JSI8qavWnU+YwzqVSiicJKvFjKLK/JtiHOfHhHUprCZ7oW+L4LaLmLOAt9NORA9UxBO7AEjBUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YlyVnqGf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YlyVnqGf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YlyVnqGf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YlyVnqGf"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B852177E33;
	Tue, 14 Jul 2026 11:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1784029473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sd7lDihRSBGTUbxQdwRuwBk86k26buWSXm5BAaQzKto=;
	b=YlyVnqGfVfq6QeZfp9Q5B3ZpVJe43xFx7OpOqt3+bi16Vst5pUJIcYw8W4R3AcJaMzOdYp
	D2mkvuthzIOt9HakwQoSJm7hhMefl3RdYhB0sW5J0F07HtgIAFYg8ojbrhGU3oKVYZDNBX
	EO3hclB/Pt8Izajzy30h0llX3lFTG48=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=YlyVnqGf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1784029473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sd7lDihRSBGTUbxQdwRuwBk86k26buWSXm5BAaQzKto=;
	b=YlyVnqGfVfq6QeZfp9Q5B3ZpVJe43xFx7OpOqt3+bi16Vst5pUJIcYw8W4R3AcJaMzOdYp
	D2mkvuthzIOt9HakwQoSJm7hhMefl3RdYhB0sW5J0F07HtgIAFYg8ojbrhGU3oKVYZDNBX
	EO3hclB/Pt8Izajzy30h0llX3lFTG48=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85FFB779AF;
	Tue, 14 Jul 2026 11:44:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SFqsHyEhVmp+cwAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 14 Jul 2026 11:44:33 +0000
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
Subject: [PATCHv3 net-next 8/9] net: usb: usbnet: remove outdated sanity check
Date: Tue, 14 Jul 2026 13:44:28 +0200
Message-ID: <20260714114429.1073434-8-oneukum@suse.com>
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
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B852177E33
X-Spam-Flag: NO
X-Spam-Score: -1.51
X-Spam-Level: 
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
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[to_ip_from(RLz16omcg76fjdrcypgyg1war3)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

The cdc state is now included as a proper member in the descriptor.
There is no point in checking whether it fits into the scratchpad
area. Just remove the check.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
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

