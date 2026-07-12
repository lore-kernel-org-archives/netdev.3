Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF3B23394E
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 01:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783820518; cv=none; b=eSTk+fEOAKHlX9DFf2HBPnVWH5Yed43wvCKErJdYCzsl8NmwcLEgzgzQ6ZEhvjZ77JIkmm9y8GyHtytofHrguQV3bL6Bsb8xHpEXbbpU/syWfUZjLMxBegBsNYdLWkyMo/qlHxC3I4+9pPv3kcPWbn57sIWPgXAlad9wyQoJ2og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783820518; c=relaxed/simple;
	bh=TpwsS3ZxQYl68T8MwrchFq6805MV4lT3mfxRZ9Boj/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEhdNlAr5EhCxY8RnKlVYcyLJ1Ec0vu5r/5pDJ1gEVoBHGJDfK6nSwvu8ukziypgb1f7VexZlZQRJGPe/AfLiOkZnUrWix0lWXtCWBCX9o/XTRAEdvvlj6ih3b7DlZ5INBZAjInK5f6FXSg9rmvDpkw0PSmb4WtRV9n7TMD69hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sCM6Lm9h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wncbQMP1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sCM6Lm9h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wncbQMP1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sCM6Lm9h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wncbQMP1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sCM6Lm9h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wncbQMP1"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8845B7703C;
	Sun, 12 Jul 2026 01:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783820515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZoPcHYEGD8R6PwA4h0KIaZQb7Br2ptM7JAgdO/OEiw=;
	b=sCM6Lm9h4trwDKVS4e5G5sPs2L4bVZtZTf8VZEKpWW0cDNI+5wo2LVcePvhDZckK7c1xa/
	u8h8T5e3HSKrompIffEyJLJJ1uKdjBvetkghQHPZyIg7vKacco0PFeUk1Zw9tRxLOfayDG
	h2ayRmGsrr2JTPjgflxiDF0aAvdYh4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783820515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZoPcHYEGD8R6PwA4h0KIaZQb7Br2ptM7JAgdO/OEiw=;
	b=wncbQMP1GDlsv0nfxyay2ImbDTacbVpe9Dk8jNlev3xiv7jCPsKuCdSCs+9vM7NScpz+NF
	4X6gmtaJmBo/okAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783820515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZoPcHYEGD8R6PwA4h0KIaZQb7Br2ptM7JAgdO/OEiw=;
	b=sCM6Lm9h4trwDKVS4e5G5sPs2L4bVZtZTf8VZEKpWW0cDNI+5wo2LVcePvhDZckK7c1xa/
	u8h8T5e3HSKrompIffEyJLJJ1uKdjBvetkghQHPZyIg7vKacco0PFeUk1Zw9tRxLOfayDG
	h2ayRmGsrr2JTPjgflxiDF0aAvdYh4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783820515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZoPcHYEGD8R6PwA4h0KIaZQb7Br2ptM7JAgdO/OEiw=;
	b=wncbQMP1GDlsv0nfxyay2ImbDTacbVpe9Dk8jNlev3xiv7jCPsKuCdSCs+9vM7NScpz+NF
	4X6gmtaJmBo/okAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5026779B5;
	Sun, 12 Jul 2026 01:41:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kEcJKeLwUmqRegAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 12 Jul 2026 01:41:54 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	idosch@nvidia.com,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/13 RFC net-next] net: ipv4: make CONFIG_IPV4 boolean
Date: Sun, 12 Jul 2026 03:39:11 +0200
Message-ID: <20260712013941.4570-14-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260712013941.4570-1-fmancera@suse.de>
References: <20260712013941.4570-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,suse.de,gmail.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLrr9ek4ud4f4qwi71m7motjzt)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 

Change CONFIG_IPV4 from hidden 'def_bool y' into an exposed boolean.
This allows users to explicitly disable IPv4 via Kconfig to build
IPv6-only or pure L2 kernel network stack. The default is kept at 'y' to
prevent breaking existing configurations.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv4/Kconfig | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index 51bf05d9770c..fa30cc407223 100644
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -3,7 +3,15 @@
 # IP configuration
 #
 config IPV4
-	def_bool y
+	bool "The IPv4 protocol"
+	default y
+	help
+	  Support for IP version 4 (IPv4).
+
+	  Disabling this option compiles the kernel networking stack without
+	  IPv4 support, resulting in a IPv6-only or pure L2 system.
+
+	  If unsure, say Y.
 
 config IP_MULTICAST
 	bool "IP: multicasting"
-- 
2.54.0

