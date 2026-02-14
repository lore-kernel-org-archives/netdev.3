Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF211DF273
	for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 17:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771089960; cv=none; b=t/AX6WuIgZFxYzgrBZSDLPzTjvCCWx4tTTj/lLo4W4oIEGp633yLSNg0sTeHP68MsGNdcwKn0WtHDEKL87uyxT1yhR0G66DI2++kscPb+pNvl8BLMl1SSAilpqe1FaYKeho1a0+Tu85jC4jtMD2++sPNL1/qSNX3sPyvna9k1aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771089960; c=relaxed/simple;
	bh=GH2UpIAT+Iuco0rX45KG75aQ0UXgFed/0UbsbhBKVlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S9kNXtwhcXOM+ScWZDrH4xEEglFx0Kjwuw417VDF2gL4trtxO6+aUxiJcCbptz4QO23q3QbrqAWHCgYhpPUn5PVdNqLlMWqxZRCvnA6YJs6s5/Tz0a1ku/GlEiNLOssSBYLCiF30aCzfPwCoJbJ4ZKpkm2VgumwLO4ntZKg+fL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i/xJtF7W; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bxFAhRXq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i/xJtF7W; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bxFAhRXq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i/xJtF7W";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bxFAhRXq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i/xJtF7W";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bxFAhRXq"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 983193E738;
	Sat, 14 Feb 2026 17:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771089956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YgN5Sd6JnzUu64e/B7WrfDQRgpCEgZD+C9ihCGMB270=;
	b=i/xJtF7WizKpMLKGQ2PHEH/9DL0TcBqJl2j4af79E1C+UvVyEpNJl7tCTXKrdoMsLy96Rk
	sv5gKAm7mbLthUS1Ntihwi7UcK9964VXK1tiXDSrrCpynbyJdel2CwAa0ASA/T43nkM/H1
	0CW01AqI4+tg3tf7aJ2CFksPzesGQHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771089956;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YgN5Sd6JnzUu64e/B7WrfDQRgpCEgZD+C9ihCGMB270=;
	b=bxFAhRXq+GYRPRQEk9qj0DuAB7xlMQVg5lxzbrdHnyQrBVadJwkRQ4x1vAbqnCXFom3hbA
	I5OT/xuIzQC0PHBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="i/xJtF7W";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bxFAhRXq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771089956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YgN5Sd6JnzUu64e/B7WrfDQRgpCEgZD+C9ihCGMB270=;
	b=i/xJtF7WizKpMLKGQ2PHEH/9DL0TcBqJl2j4af79E1C+UvVyEpNJl7tCTXKrdoMsLy96Rk
	sv5gKAm7mbLthUS1Ntihwi7UcK9964VXK1tiXDSrrCpynbyJdel2CwAa0ASA/T43nkM/H1
	0CW01AqI4+tg3tf7aJ2CFksPzesGQHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771089956;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YgN5Sd6JnzUu64e/B7WrfDQRgpCEgZD+C9ihCGMB270=;
	b=bxFAhRXq+GYRPRQEk9qj0DuAB7xlMQVg5lxzbrdHnyQrBVadJwkRQ4x1vAbqnCXFom3hbA
	I5OT/xuIzQC0PHBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1C1A3EA62;
	Sat, 14 Feb 2026 17:25:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5yqtNyOwkGk5CgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sat, 14 Feb 2026 17:25:55 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	fgont@si6networks.com,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net v2] ipv6: addrconf: reduce default temp_valid_lft to 2 days
Date: Sat, 14 Feb 2026 18:25:43 +0100
Message-ID: <20260214172543.5783-1-fmancera@suse.de>
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 983193E738
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

This is a recommendation from RFC 8981 and it was intended to be changed
by commit 969c54646af0 ("ipv6: Implement draft-ietf-6man-rfc4941bis")
but it only changed the sysctl documentation.

Fixes: 969c54646af0 ("ipv6: Implement draft-ietf-6man-rfc4941bis")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: included a comment indicating the value comes from RFC 8981 section
3.8
---
 include/net/addrconf.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 78e8b877fb25..9e96776945e5 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -8,7 +8,8 @@
 
 #define MIN_VALID_LIFETIME		(2*3600)	/* 2 hours */
 
-#define TEMP_VALID_LIFETIME		(7*86400)       /* 1 week */
+/* TEMP_VALID_LIFETIME default value as specified in RFC 8981 3.8 */
+#define TEMP_VALID_LIFETIME		(2*86400)       /* 2 days */
 #define TEMP_PREFERRED_LIFETIME		(86400)         /* 24 hours */
 #define REGEN_MIN_ADVANCE		(2)             /* 2 seconds */
 #define REGEN_MAX_RETRY			(3)
-- 
2.53.0

