Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0950D1A23B1
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773318540; cv=none; b=LUv7UAseweElJ3sXq8uXZufCOEGnvnDwz5vSCBGtWF2QjhaESp8qHrJDnz2MLJNO3sKooHPnj+2xWJdw+k9wa5cF4tJj1JFdXp4CXZr8PGoieno+DIRjqhA3yUYLu/ptxENnDhTKFxzj5+Sp11vFskZpAS3BRdGIYWLn3Se8peA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773318540; c=relaxed/simple;
	bh=N48swCPnc/SQ2HGeWAon8ulMGFAkvAKHHQFhCytw3Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GkTfRhyVI9wfRbpCln+UwA4pTXqie2M/SPEyIaBiejSa/VE8/tVc/ghP1A1/mwSPfZ50402AGX5vz+0rpvicaWb2sVsAPXIngM2k+OZ1Hlfe5Ocwk8UwH9/ReM8yz+vJtx4eJlU+UIyyytzZk4VzMcO7Xhe7irx8WA0g4agjWjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jNsNfMMg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jNsNfMMg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jNsNfMMg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jNsNfMMg"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2CA9D4D20A;
	Thu, 12 Mar 2026 12:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773318536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5pqjRRUi5SXbXPLTVoUbK3Olh4uKWFbXvBJxikEld2M=;
	b=jNsNfMMg8gEpiXKMGAb1GkJV34yf7QVJr20dZ3pDlkotJXZgQByoM1f62aYTNT1q2fmrZF
	efs4Hr/vB6azAx5LmOeB3iRA941vZ8wEsk98USnCxNwM/2vKXZOMqdneRjuMzLpezaq+97
	VqdyyoBp09Adt+ySK2NMPA/JdPH9naI=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=jNsNfMMg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773318536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5pqjRRUi5SXbXPLTVoUbK3Olh4uKWFbXvBJxikEld2M=;
	b=jNsNfMMg8gEpiXKMGAb1GkJV34yf7QVJr20dZ3pDlkotJXZgQByoM1f62aYTNT1q2fmrZF
	efs4Hr/vB6azAx5LmOeB3iRA941vZ8wEsk98USnCxNwM/2vKXZOMqdneRjuMzLpezaq+97
	VqdyyoBp09Adt+ySK2NMPA/JdPH9naI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 122333FF7F;
	Thu, 12 Mar 2026 12:28:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SDZdA4ixsmkUdQAAD6G6ig
	(envelope-from <oneukum@suse.com>); Thu, 12 Mar 2026 12:28:56 +0000
From: Oliver Neukum <oneukum@suse.com>
To: sbrabec@suse.com,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [RFC] net: usb: gl620a: check for rx buffer overflow
Date: Thu, 12 Mar 2026 13:28:37 +0100
Message-ID: <20260312122849.2010781-1-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Queue-Id: 2CA9D4D20A
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

The driver checks for a single package overflowing
maximum size. That needs to be done, but it is not
enough. As a single transmission can contain a high
number of packets, we also need to check whether
the aggregate of messages in itself short enough
overflow the buffer.
That is easiest done by checking that the current
packet does not overflow the buffer.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/usb/gl620a.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/usb/gl620a.c b/drivers/net/usb/gl620a.c
index 0bfa37c14059..3d3eb1706e2a 100644
--- a/drivers/net/usb/gl620a.c
+++ b/drivers/net/usb/gl620a.c
@@ -104,6 +104,10 @@ static int genelink_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 			return 0;
 		}
 
+		/* we also need to check for overflowing the buffer */
+		if (size > skb->len)
+			return 0;
+
 		// allocate the skb for the individual packet
 		gl_skb = alloc_skb(size, GFP_ATOMIC);
 		if (gl_skb) {
-- 
2.53.0

