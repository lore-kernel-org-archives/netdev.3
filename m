Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BE747DD76
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549587; cv=none; b=AmeeFhnrMd6eJClfnejvXy+d5RMQrO6+zh7Ce9q7uiWp+v40xaTvsFoxoF6sPtzOu8JK5FdKCDt8zhkLKM9xWzRQk6tnoHD458eR1OFilRkyCD/pyt+sVBJDCYd+z9n5drwDGgbTilpyeA/NhQXAOOIi2JbgHPGr/zZvkFkoZIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549587; c=relaxed/simple;
	bh=maLE8TyixkJDvRb8hUnFmCqgWOiYx1NQer+NClbBli0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WmlUwpnXlSR0ZmjBQMRRbkv2ZxJtOiIzIJ8NHys7CQnLuxuyrcYrZlG2YLu7bJH2ANeRiqNyabHhZEjJgZNqtHyd4X2Dz45XE5bB8QMC0FquY8P65JRUFWdi7YywuyXJeUD6fpOHIrklRK9rpoXq4n1TdPPa4SP0kO6lvCGUIQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CsT32Mke; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CsT32Mke; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CsT32Mke";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CsT32Mke"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 20EFF3F919;
	Tue,  3 Mar 2026 14:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772549572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oj1nKl5tTTpX9qhWiZwy3/8YjbUoBTIHY3sqjZU78p0=;
	b=CsT32MkegdE4b/GzvxKghuELSoPM1P6zs4A1MhzJeVtKJpDKuS4vJdOLcngmsM1rkW3RiL
	NKvaOqjagu7RgE/RX8g/lFzh7spUexRbY/520nZQ3dkUKCnK9v3xGqNID5P0hTZkHXX4nv
	lApii/kC8BKNVTDznLqsRN4Oyvz15xM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772549572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oj1nKl5tTTpX9qhWiZwy3/8YjbUoBTIHY3sqjZU78p0=;
	b=CsT32MkegdE4b/GzvxKghuELSoPM1P6zs4A1MhzJeVtKJpDKuS4vJdOLcngmsM1rkW3RiL
	NKvaOqjagu7RgE/RX8g/lFzh7spUexRbY/520nZQ3dkUKCnK9v3xGqNID5P0hTZkHXX4nv
	lApii/kC8BKNVTDznLqsRN4Oyvz15xM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE0C33EA73;
	Tue,  3 Mar 2026 14:52:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wFIOOcP1pmmPKQAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 03 Mar 2026 14:52:51 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew@lunn.ch,
	bjorn@mork.no,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [RFCv2 09/13] net: usb: use allocation on demand for usbnet
Date: Tue,  3 Mar 2026 15:50:29 +0100
Message-ID: <20260303145242.1377514-9-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303145242.1377514-1-oneukum@suse.com>
References: <20260303145242.1377514-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

This converts the simple cases for allocation of
private room for mnidrivers to dynamic allocation.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/usb/ax88172a.c | 1 +
 drivers/net/usb/cdc_mbim.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/usb/ax88172a.c b/drivers/net/usb/ax88172a.c
index f9b4364e0a0f..489a09759593 100644
--- a/drivers/net/usb/ax88172a.c
+++ b/drivers/net/usb/ax88172a.c
@@ -355,4 +355,5 @@ const struct driver_info ax88172a_info = {
 		 FLAG_MULTI_PACKET,
 	.rx_fixup = ax88172a_rx_fixup,
 	.tx_fixup = asix_tx_fixup,
+	.required_room = sizeof(struct ax88172a_private),
 };
diff --git a/drivers/net/usb/cdc_mbim.c b/drivers/net/usb/cdc_mbim.c
index 5522dc137d45..e319fe37986f 100644
--- a/drivers/net/usb/cdc_mbim.c
+++ b/drivers/net/usb/cdc_mbim.c
@@ -557,6 +557,7 @@ static const struct driver_info cdc_mbim_info = {
 	.manage_power = cdc_mbim_manage_power,
 	.rx_fixup = cdc_mbim_rx_fixup,
 	.tx_fixup = cdc_mbim_tx_fixup,
+	.required_room = sizeof(struct cdc_mbim_state),
 };
 
 /* MBIM and NCM devices should not need a ZLP after NTBs with
@@ -581,6 +582,7 @@ static const struct driver_info cdc_mbim_info_zlp = {
 	.manage_power = cdc_mbim_manage_power,
 	.rx_fixup = cdc_mbim_rx_fixup,
 	.tx_fixup = cdc_mbim_tx_fixup,
+	.required_room = sizeof(struct cdc_mbim_state),
 };
 
 /* The spefication explicitly allows NDPs to be placed anywhere in the
@@ -601,6 +603,7 @@ static const struct driver_info cdc_mbim_info_ndp_to_end = {
 	.rx_fixup = cdc_mbim_rx_fixup,
 	.tx_fixup = cdc_mbim_tx_fixup,
 	.data = CDC_NCM_FLAG_NDP_TO_END,
+	.required_room = sizeof(struct cdc_mbim_state),
 };
 
 /* Some modems (e.g. Telit LE922A6) do not work properly with altsetting
@@ -616,6 +619,7 @@ static const struct driver_info cdc_mbim_info_avoid_altsetting_toggle = {
 	.rx_fixup = cdc_mbim_rx_fixup,
 	.tx_fixup = cdc_mbim_tx_fixup,
 	.data = CDC_MBIM_FLAG_AVOID_ALTSETTING_TOGGLE,
+	.required_room = sizeof(struct cdc_mbim_state),
 };
 
 static const struct usb_device_id mbim_devs[] = {
-- 
2.53.0

