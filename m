Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7522420E78
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 12:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783598522; cv=none; b=N76e5qnh67Biv/8NQf4qt4eDGWGGhpjZF3gJBYgt3gn44jnX/vltiUnjFe5cqPxLAtc2J51+VHNEoPcv2PaFidtaPAT0Qe/0ic2WIh9B0nuCDUmQt6N6D08CD0N6hM8/N9ION/PfI7fwkoNElKGGiL36RTYxzmyEV7tPu/j1h/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783598522; c=relaxed/simple;
	bh=eVuzGYpNzKifuvkK9QWsREktF/MFxxOHTPemEvvZSp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qf8wFlQrrbjHvZ2vqtHUps7h8y9pLZv+Pi+VeWCXaIWDIQfq+ZIjEjYDkaagG0cakhQjWd8baXFbDsBVrRLTkoVZz3Cik+xw9Wy38Vbnp7ceQTSiSZzMNk9S5Ul4MwgJjy3PGQzR4fDLjB0xZAFc/DdmPuZ+PQpkM49cJuqHmr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 43C43761BF;
	Thu,  9 Jul 2026 12:01:21 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DAE2779B4;
	Thu,  9 Jul 2026 12:01:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sGFVApGNT2pEWQAAD6G6ig
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
Subject: [PATCHv2 net-next 6/7] net: usb: remove dependencies on cdc_ether
Date: Thu,  9 Jul 2026 14:01:15 +0200
Message-ID: <20260709120116.1423033-6-oneukum@suse.com>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN_FAIL(0.00)[7.9.0.0.4.6.0.0.0.5.1.0.0.1.0.0.4.0.1.0.1.8.2.b.0.4.e.d.7.0.a.2.asn6.rspamd.com:server fail]
X-Rspamd-Queue-Id: 43C43761BF
X-Rspamd-Action: no action

Now that the driver no longer exports symbols to act
as a library for other drivers other drivers don't
depend on it. Remove the dependencies.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---

v2:
- added to allow removal of dependencies

 drivers/net/usb/Kconfig | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
index da0f6a138f4f..622ff080218e 100644
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
+	depends on (USB_RTL8152 || USB_RTL8152=n)
 	default y
 	help
 	  This option supports ECM mode for RTL8153 ethernet adapter, when
-- 
2.54.0

