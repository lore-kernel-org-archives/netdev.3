Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5963437A49D
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785143938; cv=none; b=ZRql+voReGkbzLVvm6Zd7XnXEc6vHOHhuCGY373jUfxjHF4pQEpmzTTmf9UtOmG86x4SJtY4nRa6WVZZqhadEgROd41DKKC1h3eC5rWaonP+RT6W7Bpe6w0w12/sry+r7mtd5eWFkqHoqanuKVJWyUFlDCeuhVt5fgbYP7b3UL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785143938; c=relaxed/simple;
	bh=CbObR+b6JtWK0AZDUQgd19byKpkD4dgDdIr+HLPuBpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G4PZjfTbNQ/FRgUMb/lquqJTzyefHB9PAMTqDq/OxZf3NdCXWD/oYoG7zegbDl6rUzDUNVbj2wvGUZIWnobXifQfDbK2OLiymkGDxvgumJQDoa5pTLWIwS5iQu3TsOnXWsbTL5aDHwqieeSXX7lBu8mZPEYVh0jZKqnSGGxboVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cpdfEUa/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZJfgW5kW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WE0Z5n+2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pWiaqcrN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cpdfEUa/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZJfgW5kW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WE0Z5n+2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pWiaqcrN"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 94EC87C5B2;
	Mon, 27 Jul 2026 09:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785143931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6rE6oNZ8effJaFZ1bY42eaJfv55RG9760l5heWRjx0c=;
	b=cpdfEUa/DK+lh8uFzspPi27bwdyOha+bhRZIhiVSP4a7I+UYnUMo3VGeG/XPK52m8/2dS3
	O/FPgGYj9Ci1Wj7wCuw3Ricw2s8YM7w+1MWqa55DveNV7BSHe4iix/7rqS4rJ6a8HFEDs6
	BzliQt4RZDRCfU9N3wx7geF/mvLDtYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785143931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6rE6oNZ8effJaFZ1bY42eaJfv55RG9760l5heWRjx0c=;
	b=ZJfgW5kW6Gbduh0Ael7sF2DSeTf6Uw5Wgk41JEZJHxDGyfS4rmbwvMvnLqyHhZApBT4Qac
	uQFF2D0+k0xZ7gAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WE0Z5n+2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pWiaqcrN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785143927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6rE6oNZ8effJaFZ1bY42eaJfv55RG9760l5heWRjx0c=;
	b=WE0Z5n+2KQ/GUkldJFlCcBgKJiI8ALcNHMMnAfjP6wGPc02g1dfUU/1QhTLQnNXqjlI20q
	WSZi6Dr4LNFHhsc+comS8h9EiLDEeCautX4e8LiZb3G485WVG7wldEUVWDc0ajR7iGP7x/
	hJRfUOyPbO9U8QBkBBFwHEXJWphi8jE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785143927;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6rE6oNZ8effJaFZ1bY42eaJfv55RG9760l5heWRjx0c=;
	b=pWiaqcrNRrynqzs0p8EQR5jxFhDPUgY5gegAQ59Vc2o7NT8Mqlwk2YFNvyAcjfnsi/JYXt
	dzMi1cfzHMYyOyAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1084B779B9;
	Mon, 27 Jul 2026 09:18:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gb5DAXciZ2oVFAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 27 Jul 2026 09:18:47 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	idosch@nvidia.com,
	dsahern@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 1/2 net-next v2] ipv4: remove unnecessary reset of position pointer
Date: Mon, 27 Jul 2026 11:18:33 +0200
Message-ID: <20260727091834.6645-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,suse.de:dkim,nvidia.com:email];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 94EC87C5B2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

The position pointer is only advanced if the return value of the proc
handler is positive at new_sync_write(). Therefore no need to manually
reset it when doing error handling.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv4/devinet.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 3b31f4bec30e..47ded0f607d4 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2607,10 +2607,9 @@ static int devinet_conf_proc(const struct ctl_table *ctl, int write,
 static int devinet_sysctl_forward(const struct ctl_table *ctl, int write,
 				  void *buffer, size_t *lenp, loff_t *ppos)
 {
+	struct net *net = ctl->extra2;
 	int *valp = ctl->data;
 	int val = *valp;
-	loff_t pos = *ppos;
-	struct net *net = ctl->extra2;
 	int ret;
 
 	if (write && !ns_capable(net->user_ns, CAP_NET_ADMIN))
@@ -2623,7 +2622,6 @@ static int devinet_sysctl_forward(const struct ctl_table *ctl, int write,
 			if (!rtnl_net_trylock(net)) {
 				/* Restore the original values before restarting */
 				*valp = val;
-				*ppos = pos;
 				return restart_syscall();
 			}
 			if (valp == &IPV4_DEVCONF_ALL(net, FORWARDING)) {
-- 
2.55.0

