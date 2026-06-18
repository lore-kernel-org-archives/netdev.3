Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09706280A56
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781799789; cv=none; b=A28T68j9Xi4cZ3jsizQLesxjNTkl0C48gJkovZLYIR7ckLZyKHZmEJnkYkfSunsKHP29f0wb0i2S3F/cX6KnUO0XCtS/jA4lJVtuuhewaPaaI6yBQc+VP/kqkbvZxo32qe644LUeE9pyubFCm/zjmWICn1ec96JWSGaTJHHvXqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781799789; c=relaxed/simple;
	bh=4WhCRS5axusw9dVNdmGWUbo3u8ZT3CKzKFnejCu/JXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLtTtq7+d31009K7kiMKMSslGRg/PCCJfsqsbybi+vvHK4u9ckw+n+uzrTIhLYKm8YLGa2PbKoYMmSIEKIXziMkOVytVd5G0BPqOys+R1iO1fSoacaNSvzo295o7EgBICQ2Ra6HPpSAbJYhag59kFuorU5HIQxR4kqPd0vttAQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DV1C2OE7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H4I+QKWz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DV1C2OE7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H4I+QKWz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DV1C2OE7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H4I+QKWz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DV1C2OE7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H4I+QKWz"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 292386D48F;
	Thu, 18 Jun 2026 16:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781799769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bdVCpO9l/cJDRHtLIiGAm/LW80i6Ba8q//bfIyGGZGs=;
	b=DV1C2OE7VGp3+jZ/+42In17UvSLuy0gsBnFA6Pp5TA6okWZvrwF7k7QLLpa/oZsho53iZF
	w/TN2FyWuEpCPQxfMELE1ELplOukDeyPcktAGVjbpjyw4QXfwHoX0KA0dX20nQZhrMGIe7
	Tfabxum/2Y121a1XyI4vEt+0puArVQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781799769;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bdVCpO9l/cJDRHtLIiGAm/LW80i6Ba8q//bfIyGGZGs=;
	b=H4I+QKWzeo0cBrqSyLs6+0gjyxgoBhHudq0nbVvRXXnt1x31PUTb5jDmVuliGMc628smdJ
	pfYjNcfjepaVh/Dg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DV1C2OE7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=H4I+QKWz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781799769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bdVCpO9l/cJDRHtLIiGAm/LW80i6Ba8q//bfIyGGZGs=;
	b=DV1C2OE7VGp3+jZ/+42In17UvSLuy0gsBnFA6Pp5TA6okWZvrwF7k7QLLpa/oZsho53iZF
	w/TN2FyWuEpCPQxfMELE1ELplOukDeyPcktAGVjbpjyw4QXfwHoX0KA0dX20nQZhrMGIe7
	Tfabxum/2Y121a1XyI4vEt+0puArVQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781799769;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bdVCpO9l/cJDRHtLIiGAm/LW80i6Ba8q//bfIyGGZGs=;
	b=H4I+QKWzeo0cBrqSyLs6+0gjyxgoBhHudq0nbVvRXXnt1x31PUTb5jDmVuliGMc628smdJ
	pfYjNcfjepaVh/Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B618779A8;
	Thu, 18 Jun 2026 16:22:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8FF3D1gbNGqCDgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 18 Jun 2026 16:22:48 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: nicolas.dichtel@6wind.com,
	shemminger@vyatta.com,
	dforster@brocade.com,
	gospo@cumulusnetworks.com,
	ddutt@cumulusnetworks.com,
	brian.haley@hp.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	idosch@nvidia.com,
	dsahern@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net 5/6] ipv6: reset value and position for proxy_ndp sysctl restart
Date: Thu, 18 Jun 2026 18:22:24 +0200
Message-ID: <20260618162225.4588-6-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260618162225.4588-1-fmancera@suse.de>
References: <20260618162225.4588-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 292386D48F
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[15];
	URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLb3xxm68jmrjpif7i5fm8f49r)];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

When handling proxy_ndp, if rtnl_net_trylock() fails, the operation is
retried but as the value was already modified by the initial
proc_dointvec() call, the restarted syscall will read the newly modified
value as the 'old' state.

Fix this by restoring the original value and position pointer before
restarting the syscall.

Fixes: c92d5491a6d9 ("netconf: add support for IPv6 proxy_ndp")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv6/addrconf.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 8ff015975e27..1cfb223476bd 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6483,8 +6483,9 @@ static int addrconf_sysctl_proxy_ndp(const struct ctl_table *ctl, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int *valp = ctl->data;
-	int ret;
+	loff_t pos = *ppos;
 	int old, new;
+	int ret;
 
 	old = *valp;
 	ret = proc_dointvec(ctl, write, buffer, lenp, ppos);
@@ -6493,8 +6494,12 @@ static int addrconf_sysctl_proxy_ndp(const struct ctl_table *ctl, int write,
 	if (write && old != new) {
 		struct net *net = ctl->extra2;
 
-		if (!rtnl_net_trylock(net))
+		if (!rtnl_net_trylock(net)) {
+			/* Restore the original values before restarting */
+			*valp = old;
+			*ppos = pos;
 			return restart_syscall();
+		}
 
 		if (valp == &net->ipv6.devconf_dflt->proxy_ndp) {
 			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
-- 
2.54.0

