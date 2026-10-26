Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036660;
	b=WVfcuhY8tjr/NH3h46cUM8bc1VMZhO7HiBSq7G1oSpr4rk++6U2kIx1IolamDsVVJhcv
	 T/YXvi0eQGkTIMkTOfom37sC4RS2HBiO+JDnNDQFngV790QRP1AP8Oo55wFaLdDeXPCTR
	 R6cA7Q6uHE/3hzoOfd52ymK2IQpHcJzkoThosl1rwZ88ql3jKRnJaiK7ZFEJ8siVaeeqt
	 JqwzCHH6k4o4YYUDdWJRz/FmJ5eqCObc5WKhEjb/ujXH2NtpSVk0apWXyYOcMDe67riSM
	 TOcR27GmBuGGlc5Va0bnZfAwvENoK28skAUdvhjZrXOoLMiz3CkqDzpU+b556bmWsyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036660;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Spamd-Result:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=5p9iljGhAmGMcuMqL9G7Y87aRZRmeVK8ZTtiwrA25ao=;
	b=dov3vj1EQS4KwE1TgFs7oKS4AosDY9z5pvtsX4IcbqpgN5vIr1tv9VUXr3U8zE1Saana
	 HOLPOy7Rin3MLz4pLlyKdMxDah9bfLDVI14RuM4+tFVvvX+OqSvuFr+/7pzTR5TVcaYG1
	 AYTMldHzjWKlwJGUF8vHj57P+NzAbnSYnOnsPWJ6hrCU9q3zDbNzYMFXM14OHDmJF+8F2
	 qZEOKuhUtwv5pyJfGO4KDm9JlmhzXKRRfro+6f4g8R0DbIQUaeVDX6BeInqpF+WIfHjGF
	 Y9SgwFCaF8JutQ3sFKF8mkXncBIZwoJ7zPZNc2WfENiUsw7nIz/Prib2WIevc7zQVBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=H2TtJLVH;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YlkK77as;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=GET5KrfS;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=V3Cv0YFv;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D97606A31F
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 17:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29D97606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=H2TtJLVH;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YlkK77as;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=GET5KrfS;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=V3Cv0YFv
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DCF3422254;
	Mon, 26 Oct 2026 17:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793036658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5p9iljGhAmGMcuMqL9G7Y87aRZRmeVK8ZTtiwrA25ao=;
	b=H2TtJLVHqkNGd28LeTC32rjFW7Z6d+dicEwdMnCu8S98tN6Zog5uWu2w3zqlactJ5YiBbo
	kbxomXsaC5gwTzxPcTKDRpqmt1I1yZBOTa5RrGdFEYGvWXeipxP3KTm1y2i08J9JfDM7HP
	x5yfPUoJO3f5o0lDUtBHt6O5EG5xdsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793036658;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5p9iljGhAmGMcuMqL9G7Y87aRZRmeVK8ZTtiwrA25ao=;
	b=YlkK77asKYeGfl1qU5NPZ2UkAzvvFdN87TGPn5SH37B6fLVal9vqZN295qGh3k9l/+SvEP
	6CZW4U5wjoxyqOAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GET5KrfS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=V3Cv0YFv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793036656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5p9iljGhAmGMcuMqL9G7Y87aRZRmeVK8ZTtiwrA25ao=;
	b=GET5KrfSxz3GYo0mRzabKtgRt9zMrA2KOAPEk7uQgkj368rQACxvS34issDerfC1PKBq+U
	6MI9TaQDDt8aa6hMT0vmtgT1FAcmgON41PVVgdh5BW4TBWpepuA08wb92sjjnP2YmGZo2I
	ouvdB1rxnkf2UF+8SYwJ46hZHx3TC1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793036656;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5p9iljGhAmGMcuMqL9G7Y87aRZRmeVK8ZTtiwrA25ao=;
	b=V3Cv0YFvMJ1mdJA/O2jWzbJKNjBAFQdeqDfZ0a0gjjkQRPPCgaUcQghq5FCIhzHPHTLetz
	iZ6HtybKdlPK+pBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E68513408;
	Mon, 26 Oct 2026 17:44:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5UVDAHCR32ptBgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 26 Oct 2026 17:44:16 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: jacob.e.keller@intel.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@kernel.org,
	davem@davemloft.net,
	jiri@resnulli.us,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Guikun Yang <yangguikun19@qq.com>
Subject: [PATCH net] devlink: region: fix snapshot id leak on kernel-allocated ids
Date: Mon, 26 Oct 2026 18:44:03 +0100
Message-ID: <20261026174403.512-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-12.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,redhat.com,davemloft.net,resnulli.us,suse.de,qq.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,qq.com:email,suse.de:email,suse.de:dkim];
	RCPT_COUNT_SEVEN(0.00)[10];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FREEMAIL_ENVRCPT(0.00)[qq.com]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.01
X-Spam-Level: 
X-Rspamd-Queue-Id: DCF3422254

When DEVLINK_CMD_REGION_NEW is issued without a snapshot id, the kernel
allocates one with __devlink_region_snapshot_id_get(). That helper counts
the caller as a user of the id, and the caller must release this hold
once it is done.

devlink_nl_region_new_doit() never drops it. The refcount of the id goes
1 (allocation) -> 2 (snapshot created) and stays at 2. When the snapshot
is deleted the count only drops to 1, so the id is never erased from
the snapshot_ids xarray. The id then stays in use for the lifetime of
the devlink instance: requesting a snapshot with that explicit id fails
with -EEXIST, and there is no snapshot left to delete to clean it up.

Reproducer steps:
  # devlink region new pci/0000:13:00.0/device-caps
  pci/0000:13:00.0/device-caps: snapshot 0
  # devlink region del pci/0000:13:00.0/device-caps snapshot 0
  # devlink region new pci/0000:13:00.0/device-caps snapshot 0
  kernel answers: File exists

Drop the caller's reference right after the snapshot has been created,
as the snapshot then holds its own.

Fixes: 043b3e22768d ("devlink: let kernel allocate region snapshot id")
Reported-by: Guikun Yang <yangguikun19@qq.com>
Closes: https://lore.kernel.org/netdev/tencent_BE912BA710539F285F9FCF28E854ABEFCD07@qq.com/
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/devlink/region.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/devlink/region.c b/net/devlink/region.c
index 537779bbff07..c22016f23a4a 100644
--- a/net/devlink/region.c
+++ b/net/devlink/region.c
@@ -719,6 +719,11 @@ int devlink_nl_region_new_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!snapshot_id_attr) {
 		struct sk_buff *msg;
 
+		/* Drop the allocation reference, the snapshot
+		 * now holds its own.
+		 */
+		__devlink_snapshot_id_decrement(devlink, snapshot_id);
+
 		snapshot = devlink_region_snapshot_get_by_id(region,
 							     snapshot_id);
 		if (WARN_ON(!snapshot)) {
-- 
2.56.0

