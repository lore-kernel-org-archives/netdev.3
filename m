Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289D237C0F3
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 20:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784234255; cv=none; b=SRlYrxBjuX+5OoQPoPntL5U3oL2yo9eqkXCE/fmADFZLAnKn39w3nDJ8xMhA+0vYFbAvuvutZch+MSU6OgoTWPdkq0SU3365j5bmPbxnlddtgb17yfYJDqfi9q2jhqY+YNwnF5+06lF2UWOVzYtArSWe+wBnOhZZqg6OiqQr5/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784234255; c=relaxed/simple;
	bh=SaDBV9F6vTnxdgd3t4C+pYlPUIdHW6IKB3S+9EsclAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ty9Zj/2pi/LZDvmyMQEMteG0ESk8xZIY0RVBi+jhOZ4QJxM3k8eYOOlT7CssAg9TigcmLFfInM93uAee5YhG3Cev9NhadOkpmD/AgRj1WtrE/WoHiUZwT7bupIV3W5lbJz4lyySmt0hr4/UUa2VzNyaQU/nUcoXri53DxQ+T3ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qpLmOQl1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H3q4gaG/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qpLmOQl1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H3q4gaG/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qpLmOQl1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H3q4gaG/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qpLmOQl1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H3q4gaG/"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 06B5C78AFA;
	Thu, 16 Jul 2026 20:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784234250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s1nATWNt8/4CMEWmo3XvrTqtUUxAwDprpBZFH3yEGdw=;
	b=qpLmOQl1UWNz8w9IbFrjOl9ZsRsujlP1XaW/z67nAipMiCev4x7vsItSi/z2OGgITvvgON
	t+r3QzLigY+kVZfK0z4QC+wnixa/YrtVVlFbkybTuIImKAt+Hj1b06BnFFapBFkIwWoDf2
	r18Mvtm94eFhaJPbFaaeqOT0ex57erM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784234250;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s1nATWNt8/4CMEWmo3XvrTqtUUxAwDprpBZFH3yEGdw=;
	b=H3q4gaG/nYASEBnTpKWijJaHPCpihpTww/msgOZ+SF/9b0pTYWFJ7sR6DQdP/aNpgL7Nsv
	YGVIRQ/ls/+DvoCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qpLmOQl1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="H3q4gaG/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784234250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s1nATWNt8/4CMEWmo3XvrTqtUUxAwDprpBZFH3yEGdw=;
	b=qpLmOQl1UWNz8w9IbFrjOl9ZsRsujlP1XaW/z67nAipMiCev4x7vsItSi/z2OGgITvvgON
	t+r3QzLigY+kVZfK0z4QC+wnixa/YrtVVlFbkybTuIImKAt+Hj1b06BnFFapBFkIwWoDf2
	r18Mvtm94eFhaJPbFaaeqOT0ex57erM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784234250;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s1nATWNt8/4CMEWmo3XvrTqtUUxAwDprpBZFH3yEGdw=;
	b=H3q4gaG/nYASEBnTpKWijJaHPCpihpTww/msgOZ+SF/9b0pTYWFJ7sR6DQdP/aNpgL7Nsv
	YGVIRQ/ls/+DvoCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E181779AD;
	Thu, 16 Jul 2026 20:37:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iJLDFwlBWWrmJQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 16 Jul 2026 20:37:29 +0000
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
Subject: [PATCH 1/3 net-next] ipv4: remove unnecessary reset of position pointer
Date: Thu, 16 Jul 2026 22:37:11 +0200
Message-ID: <20260716203713.17392-2-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260716203713.17392-1-fmancera@suse.de>
References: <20260716203713.17392-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 06B5C78AFA
X-Spam-Score: -3.01

The position pointer is only advanced if the return value of the proc
handler is positive at new_sync_write(). Therefore no need to manually
reset it when doing error handling.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv4/devinet.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index a35b72662e43..8b68fe37e6ba 100644
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

