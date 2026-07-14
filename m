Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229413B27C1
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 11:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029500; cv=none; b=liJlI3oNlHcgl4i+D4NHwiPwRzxTpzHI+5xoIGhE1fU5mlbT/+PrhrxiNbPEHgJokBUHy8lO4Eao/fbKwCZSUt6XdUL7w7JTPJ7UgTA5zhO1k8ZMvN980pjjtENydep1CeUuqxnztk2KOZvzgmi9sP7uZw3bORxcsR4ZWMTAjXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029500; c=relaxed/simple;
	bh=WN++4PiQVtaSIQZEGOz3Rbyzx8A7cSHakrZfyK6W5Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwOr2Vw1gWr5+0hfuXHi6UmcexSOkhtNx0nDrzNV1wnHmdr0e21HV5n+l6e8svlZOuxIIsj/Nw+WWVTcyQAzdMVDoLbEk52IEENdZ6DZaAo23WT+0shnEeaQfawiW70MvHJ/kT7lkiM+NmPSZdrANkshdDRIxnBhYcFblGiVAMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=n3FLQV0n; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DONg2CsR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="n3FLQV0n";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DONg2CsR"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F29D977E34;
	Tue, 14 Jul 2026 11:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1784029474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wa8xfTrtdPUYc25tlb71+dHhzufOEBD9q7G/upAWK+s=;
	b=n3FLQV0ngu9sqVjcJ41UPysQUBDIU0Ww9YCK2Plf8ISE6HzMyfGir8th4c06qWYxVfw4G0
	mbb7YoTlOGFQDehtxEa4CrWwytupHqxSziyTzIr6sqOxSGSKL2R7T7dlqy3Fgx92GunUqH
	80GrXfo16AxOhOATrjs5q9XosUKE71I=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1784029473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wa8xfTrtdPUYc25tlb71+dHhzufOEBD9q7G/upAWK+s=;
	b=DONg2CsRG34pzwJDGKsADY5oHsjfXd7GJoRFCLrVSQVy45fFeqzABgjOWCnxhyOKa83BAz
	w7KVNsVwY5xxcz97xQjKeZjUSa3x8JuaVRVd82FM7zYeo8Nq40IBEwovWUfPsk3Dzf/MD5
	Ln2UdMzN3ACm5mZ9Xd75IhzdW98vbwY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDB86779AE;
	Tue, 14 Jul 2026 11:44:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KJtVLSEhVmp+cwAAD6G6ig
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
Subject: [PATCHv3 net-next 9/9] net: usb: usbnet: corrections in the comments
Date: Tue, 14 Jul 2026 13:44:29 +0200
Message-ID: <20260714114429.1073434-9-oneukum@suse.com>
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLp6hgsbiwipf7smy58x9iwpej)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Score: -1.30

Correct grammar in comments.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---

v3:
- added to fix concerns about language in comments

 drivers/net/usb/usbnet.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 0347f6887222..76bbbfb7a24e 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -2351,12 +2351,12 @@ void usbnet_cdc_status(struct usbnet *dev, struct urb *urb)
 }
 EXPORT_SYMBOL_GPL(usbnet_cdc_status);
 
-/* Make sure packets have correct destination MAC address
+/* Make sure packets have the correct destination MAC address
  *
  * A firmware bug observed on some devices (ZTE MF823/831/910) is that the
- * device sends packets with a static, bogus, random MAC address (event if
- * device MAC address has been updated). Always set MAC address to that of the
- * device.
+ * device sends packets with a static, bogus, random MAC address (event if the
+ * device MAC address has been updated). Always set the MAC address to that
+ * of the device.
  */
 int usbnet_cdc_zte_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 {
-- 
2.54.0

