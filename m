Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA223E558A
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784277908; cv=none; b=pYt/7058oxpqaYDw9wvP+HI2nLqKES1ykkHSXmEDZN7DYpjSxI8wR9ZIgNAz71vn4NPRZ+i7rCW8L9QykE2F1xRqk/ogvB+JRJgJmbZ2QtmdFFsP3W7+EhLLkM6+PM9gXWfTAm6fjGkKySWQHW2o4Ipd/XijEFTG1B0gV+2YEc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784277908; c=relaxed/simple;
	bh=DS9zb2NbeWhZRaR9l7EvWM9SWb1gTg0CzkPsp8Dbx0U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=f73VA1hU0uAjJgWFHymfMxCynsR97+doq6RGmpxEL5MxRgIzA13lV8NoADyszwKRp/fqNt0FTM3/1ltPr+0oekReL2Qn9AIk0Y+83OUTfBURU1FXi8dg8Q2Hy3G3o0T5qUaFotVuVWamLehjJKH4UwT8nwjZFMB7EsoJ6f5pCwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Dlxogzmf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=veYVwi4Y; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rdQS+H59; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xeb3S8hQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Dlxogzmf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="veYVwi4Y";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rdQS+H59";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xeb3S8hQ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1F04678DE8;
	Fri, 17 Jul 2026 08:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784277899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VdViR0G1KMydncyi2V8OntbhkvpFS5IW5lP/oAPvnhs=;
	b=Dlxogzmf8W/Q6q7hjIN+ghXV7spmbkSKhcbYUtp4Cs5dQJLKPIKicnauHtrF0PpWa9hO+S
	MEJABf7rUWZ6OC8OrkIK0PufHujbxR2vDvVgGQltWQReIi+RddCB5+uioQ+rfNXkZaoDvI
	63kgMP5kD+XFHN29XKU71Q9uGPEwfCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784277899;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VdViR0G1KMydncyi2V8OntbhkvpFS5IW5lP/oAPvnhs=;
	b=veYVwi4Y8gMvfmPY/UWz/hNAcbLEy1ye0Q6fzGF0KDPvc+I1/xanqoET7Ifh6yuprMCz9e
	H3DwfBKbCG/whMBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784277898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VdViR0G1KMydncyi2V8OntbhkvpFS5IW5lP/oAPvnhs=;
	b=rdQS+H59OmTIEUAua7JgegFBlfVrtawYGm9aWX8wJ5keS42jGJeFjLhu729WxtCpZi38pq
	5NVgsOMsqdU6vIbxaWtAW97RBVAyD8hoM035IciXgBJEVivcKhimWg0NACDgXfnZrXLb9j
	9DEjp3A1q/q9GMXZBGFIV/zhpWbqog8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784277898;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VdViR0G1KMydncyi2V8OntbhkvpFS5IW5lP/oAPvnhs=;
	b=xeb3S8hQKZ+x8F2JBaXGPZj7pHMfyv4pehTBQRZvJYZ8JATbXWsIbLgNK2GD8VCdWtRXhx
	Qgv6iWJmPZ76bUDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A67B779AA;
	Fri, 17 Jul 2026 08:44:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KKFpAorrWWrKTgAAD6G6ig
	(envelope-from <tbogendoerfer@suse.de>); Fri, 17 Jul 2026 08:44:58 +0000
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] ice: rephrase LLDP filter fallback message
Date: Fri, 17 Jul 2026 10:44:52 +0200
Message-ID: <20260717084453.9521-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.51.0
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
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Score: -1.30

Seeing an error message in a logfile triggers scripts/admins thinking of
problems. The LLDP fallback message itself is not an error, it just
indicates it's using a different filter mechanism. So rephrase to a
less "scary" message.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 8cdc4fda89e9..59341b5a0c05 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2097,7 +2097,7 @@ void ice_vsi_cfg_sw_lldp(struct ice_vsi *vsi, bool tx, bool create)
 				goto report;
 
 			dev_info(dev,
-				 "Failed to add generic LLDP Rx filter on VSI %i error: %d, falling back to specialized AQ control\n",
+				 "Using generic LLDP Rx filter on VSI %i is not possible (%d), falling back to specialized AQ control\n",
 				 vsi->vsi_num, status);
 		}
 
-- 
2.51.0

