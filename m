Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E631A3B389E
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029513; cv=none; b=asmaDHl7JCe+mRF4+/I5p+DOkwFKlABqejnJH/6uKWK3K+uQwMLzzNBueOTBouVp/inXdg68qogmMWXsU+GfswAq7Ku1fwIqsTlSgLhuY1CxJfUHgu97hKp6Vs6vDLLLLCBQ4ASP30pN4+zyavhOOV6yXfnvumHjMXj+gdnBo1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029513; c=relaxed/simple;
	bh=vNvSf0qXVgHfUNtMAuANP6NFKvfXFc+TemzGUvUzDbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXt03voPcree51Z8E4Daw6XNcqJwJvlbVo4CnuC8Yl/NysaPVgvwhXIGgUFc8KE90N1m8rklTKZ9HjwqEyVFEVUzmuiN+uCN+svOLSRUMJU7hDA7mnn/JQDHM9LUd+AmO2IXvAAY5j+ntxhZPAGxldNnzRdEICb+KmnmUrP36dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mznjdS2E; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mznjdS2E; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mznjdS2E";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mznjdS2E"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 80AE23E2F;
	Tue, 14 Jul 2026 11:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1784029473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Y8t3t7waBQs/3CscjIPE2za67BKlscUK6Xgb31zuWw=;
	b=mznjdS2EuzFFeqCJj8G18xZk0b1nn+YGU9tM3s/W+LI0rEKmS0mC+XD0iLYk/J8qeI017T
	TESgPnSEt8GnEi3BaT16Wcj0d++HCnMxXaSAoQ+tO6WqJpQTTs4/gQKcx3W5pq8rMM+TLt
	frqmoJX3QAOy3TgA+qFK4crltb/Bc1w=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=mznjdS2E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1784029473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Y8t3t7waBQs/3CscjIPE2za67BKlscUK6Xgb31zuWw=;
	b=mznjdS2EuzFFeqCJj8G18xZk0b1nn+YGU9tM3s/W+LI0rEKmS0mC+XD0iLYk/J8qeI017T
	TESgPnSEt8GnEi3BaT16Wcj0d++HCnMxXaSAoQ+tO6WqJpQTTs4/gQKcx3W5pq8rMM+TLt
	frqmoJX3QAOy3TgA+qFK4crltb/Bc1w=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DF32779AE;
	Tue, 14 Jul 2026 11:44:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4PkEEiEhVmp+cwAAD6G6ig
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
Subject: [PATCHv3 net-next 7/9] net: usb: remove dependencies on cdc_ether
Date: Tue, 14 Jul 2026 13:44:27 +0200
Message-ID: <20260714114429.1073434-7-oneukum@suse.com>
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
X-Rspamd-Queue-Id: 80AE23E2F
X-Spam-Flag: NO
X-Spam-Score: -1.51
X-Spam-Level: 
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:email,suse.com:mid]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Now that the driver no longer exports symbols to act
as a library for other drivers other drivers don't
depend on it. Remove the dependencies.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---

v3:
- removed unneeded parantheses

 drivers/net/usb/Kconfig | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
index da0f6a138f4f..732e0d5f331d 100644
--- a/drivers/net/usb/Kconfig
+++ b/drivers/net/usb/Kconfig
@@ -258,7 +258,6 @@ config USB_NET_CDC_EEM
 config USB_NET_CDC_NCM
 	tristate "CDC NCM support"
 	depends on USB_USBNET
-	select USB_NET_CDCETHER
 	default y
 	help
 	  This driver provides support for CDC NCM (Network Control Model
@@ -399,7 +398,6 @@ config USB_NET_MCS7830
 config USB_NET_RNDIS_HOST
 	tristate "Host for RNDIS and ActiveSync devices"
 	depends on USB_USBNET
-	select USB_NET_CDCETHER
 	help
 	  This option enables hosting "Remote NDIS" USB networking links,
 	  as encouraged by Microsoft (instead of CDC Ethernet!) for use in
@@ -494,7 +492,6 @@ config USB_KC2190
 config USB_NET_ZAURUS
 	tristate "Sharp Zaurus (stock ROMs) and compatible"
 	depends on USB_USBNET
-	select USB_NET_CDCETHER
 	select CRC32
 	default y
 	help
@@ -597,7 +594,7 @@ config USB_SIERRA_NET
 
 config USB_VL600
 	tristate "LG VL600 modem dongle"
-	depends on USB_NET_CDCETHER && TTY
+	depends on TTY
 	select USB_ACM
 	help
 	  Select this if you want to use an LG Electronics 4G/LTE usb modem
@@ -634,7 +631,7 @@ config USB_NET_AQC111
 
 config USB_RTL8153_ECM
 	tristate
-	depends on USB_NET_CDCETHER && (USB_RTL8152 || USB_RTL8152=n)
+	depends on USB_RTL8152 || USB_RTL8152=n
 	default y
 	help
 	  This option supports ECM mode for RTL8153 ethernet adapter, when
-- 
2.54.0

