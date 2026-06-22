Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C6A3B1025
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782133789; cv=none; b=pKjMWV+TyXMfMSChGD+La/oE/y8GvsIFxbeLGglPYdYiAaODec33gvwC0f/2OtELWAoy4Gdijm5SLYsA0sBZZOG6wId/NebzMYyl1bB4+R1JYaqJv1E/WVjMga8LuULX2EPpg6EHoPTMmxi7q9MoD+9RISt9ErQ03WAK/U5LWno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782133789; c=relaxed/simple;
	bh=betrCB7L46gKYfqdHNulVqMyl3heeyERVNsK4Q03NWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lCPbuIxcPNjeSthcCuTW3Dm396K7g1dTlA/MSimLrvjFbhOxp+EnvufB3SrtIbOHNPuYLetGW9CGVgLmRnnOmC90IZJR6VjTewetxHP0BrH3WRRZHKrPxcAbBaqwPDPuHWuEV+oWHQO0wZ5XYrVTC3DZyvrpRxjM8uoISq/MHzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=F1vSUE39; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s6f0qQg8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=F1vSUE39; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s6f0qQg8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F1vSUE39";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s6f0qQg8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F1vSUE39";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s6f0qQg8"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 12D717081B;
	Mon, 22 Jun 2026 13:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782133763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=znrl2TCWwVBjdYaI4vAaTnbHUeKHg9J3GVj9xyNyTrI=;
	b=F1vSUE39dT4+YNAQ9D5pAWuta1+gtCyBZiAyBCv5AVR+pu/FPe1LQNXpasyK+nA/5WT5E7
	J08YQlYVDlHArcL2ORDXGV6aCFzEzC0qQcHcw7mF2zKwc9+6oipQOol6SmzI3NXAEGOvo/
	8VnnCaK1r9JDU3fm4R4fg0Zdak/ZiAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782133763;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=znrl2TCWwVBjdYaI4vAaTnbHUeKHg9J3GVj9xyNyTrI=;
	b=s6f0qQg86BgK8qsNBlJwExgd6KhjNdR5I5U4BxuJzL5Bc1RRlovir/UDaPHWq65qFZiM/b
	UTVyaKptOPt98pAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782133763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=znrl2TCWwVBjdYaI4vAaTnbHUeKHg9J3GVj9xyNyTrI=;
	b=F1vSUE39dT4+YNAQ9D5pAWuta1+gtCyBZiAyBCv5AVR+pu/FPe1LQNXpasyK+nA/5WT5E7
	J08YQlYVDlHArcL2ORDXGV6aCFzEzC0qQcHcw7mF2zKwc9+6oipQOol6SmzI3NXAEGOvo/
	8VnnCaK1r9JDU3fm4R4fg0Zdak/ZiAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782133763;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=znrl2TCWwVBjdYaI4vAaTnbHUeKHg9J3GVj9xyNyTrI=;
	b=s6f0qQg86BgK8qsNBlJwExgd6KhjNdR5I5U4BxuJzL5Bc1RRlovir/UDaPHWq65qFZiM/b
	UTVyaKptOPt98pAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B8D0779A8;
	Mon, 22 Jun 2026 13:09:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6EkpEwI0OWqdEQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 22 Jun 2026 13:09:22 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: nicolas.dichtel@6wind.com,
	stephen@networkplumber.org,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	idosch@nvidia.com,
	dsahern@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net v3 5/6] ipv6: fix state corruption during proxy_ndp sysctl restart
Date: Mon, 22 Jun 2026 15:08:56 +0200
Message-ID: <20260622130857.5115-6-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260622130857.5115-1-fmancera@suse.de>
References: <20260622130857.5115-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RLwhz7wtk6en1e6cs856tq4oxd)];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Score: -2.80

When handling proxy_ndp, if rtnl_net_trylock() fails, the operation is
retried but as the value was already modified by the initial
proc_dointvec() call, the restarted syscall will read the newly modified
value as the 'old' state.

Fix this by taking the RTNL lock before parsing the input value if the
operation is a write.

Fixes: c92d5491a6d9 ("netconf: add support for IPv6 proxy_ndp")
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv6/addrconf.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 5d96cbf76134..82b6f603faa0 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6482,20 +6482,19 @@ static int addrconf_sysctl_disable(const struct ctl_table *ctl, int write,
 static int addrconf_sysctl_proxy_ndp(const struct ctl_table *ctl, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
+	struct net *net = ctl->extra2;
 	int *valp = ctl->data;
-	int ret;
 	int old, new;
+	int ret;
+
+	if (write && !rtnl_net_trylock(net))
+		return restart_syscall();
 
 	old = *valp;
 	ret = proc_dointvec(ctl, write, buffer, lenp, ppos);
 	new = *valp;
 
 	if (write && old != new) {
-		struct net *net = ctl->extra2;
-
-		if (!rtnl_net_trylock(net))
-			return restart_syscall();
-
 		if (valp == &net->ipv6.devconf_dflt->proxy_ndp) {
 			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
 						     NETCONFA_PROXY_NEIGH,
@@ -6514,8 +6513,9 @@ static int addrconf_sysctl_proxy_ndp(const struct ctl_table *ctl, int write,
 						     idev->dev->ifindex,
 						     &idev->cnf);
 		}
-		rtnl_net_unlock(net);
 	}
+	if (write)
+		rtnl_net_unlock(net);
 
 	return ret;
 }
-- 
2.54.0

