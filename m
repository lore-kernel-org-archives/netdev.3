Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E3C3EBF37
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770841235; cv=none; b=E9NOEggjq9YvOzPQuWgOrhpgy/wCr0bncndzXQ7sAYzpUchnqez36vtFDekiNHvdO5xfb0LNDn9hmPf2wOu9rNqqe0otP8lMLlBtKhLk7oEQq5Z7xyGkibug0qRlf3AjSqK5SGYr8XznIG0vqK3nUbR3tUVCSo0HMOcMW9A7U1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770841235; c=relaxed/simple;
	bh=SbLcXCWjSFwUbZGrWgI9ae+n7cxmuudqEvVjQOYuLqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RKq49vO2Rn+Kq5WYxwHX5np3ZPSB6xxNvgl6XHjSMjDRWetAay40gB5WTJ21nFtKCU2FFb8QcEPoP0UpJ7UlUHJ5MSwr6Hq2Jflckoz21GXt+wy+Iru+LUGsDmxHV1o4swqOrHjHL5Mh10f8qykc+VPvtVwj3rGI8BSP5MKcZSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f9cXq3fc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yA7bC4EP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f9cXq3fc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yA7bC4EP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f9cXq3fc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yA7bC4EP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f9cXq3fc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yA7bC4EP"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED2025BDBA;
	Wed, 11 Feb 2026 20:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770841227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WFVFFByLGMDeo/RT8SqKY8m58LOsCW4GDYWP0N28Oog=;
	b=f9cXq3fcT+TX/EL3AhAgBGM27WREE4XSp/6Sm2N02rBo375eX9kCw59B+WDApIz3zBnTD0
	lG2ZtBF6D7ehTUQrbvSOsYHLZxjZ5j6rODUHAy/E7rVRAfsPOrjtdmWsZg8GXrrAoET6FR
	EtzvwjDJ+Rj8Wzp58njOtx+obP4Kboo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770841227;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WFVFFByLGMDeo/RT8SqKY8m58LOsCW4GDYWP0N28Oog=;
	b=yA7bC4EP5p4GLbGVr4cHpPa7PMnXf63GhzInY0un0NOo547klBxW6MmPHkfQAGf4LPTxXz
	cl0ZrfqyZtU2orCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=f9cXq3fc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yA7bC4EP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770841227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WFVFFByLGMDeo/RT8SqKY8m58LOsCW4GDYWP0N28Oog=;
	b=f9cXq3fcT+TX/EL3AhAgBGM27WREE4XSp/6Sm2N02rBo375eX9kCw59B+WDApIz3zBnTD0
	lG2ZtBF6D7ehTUQrbvSOsYHLZxjZ5j6rODUHAy/E7rVRAfsPOrjtdmWsZg8GXrrAoET6FR
	EtzvwjDJ+Rj8Wzp58njOtx+obP4Kboo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770841227;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WFVFFByLGMDeo/RT8SqKY8m58LOsCW4GDYWP0N28Oog=;
	b=yA7bC4EP5p4GLbGVr4cHpPa7PMnXf63GhzInY0un0NOo547klBxW6MmPHkfQAGf4LPTxXz
	cl0ZrfqyZtU2orCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EB343EA62;
	Wed, 11 Feb 2026 20:20:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JWUTFIrkjGnccAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 11 Feb 2026 20:20:26 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: fgont@si6networks.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net] ipv6: addrconf: reduce default temp_valid_lft to 2 days
Date: Wed, 11 Feb 2026 21:20:03 +0100
Message-ID: <20260211202003.4550-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: ED2025BDBA
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

This is a recommendation from RFC 8981 and it was intended to be changed
by commit 969c54646af0 ("ipv6: Implement draft-ietf-6man-rfc4941bis")
but it only changed the sysctl documentation.

Fixes: 969c54646af0 ("ipv6: Implement draft-ietf-6man-rfc4941bis")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 include/net/addrconf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 78e8b877fb25..e9511df721c6 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -8,7 +8,7 @@
 
 #define MIN_VALID_LIFETIME		(2*3600)	/* 2 hours */
 
-#define TEMP_VALID_LIFETIME		(7*86400)       /* 1 week */
+#define TEMP_VALID_LIFETIME		(2*86400)       /* 2 days */
 #define TEMP_PREFERRED_LIFETIME		(86400)         /* 24 hours */
 #define REGEN_MIN_ADVANCE		(2)             /* 2 seconds */
 #define REGEN_MAX_RETRY			(3)
-- 
2.52.0

