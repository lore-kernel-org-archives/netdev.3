Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F9C382F1F
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 20:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784234273; cv=none; b=r557/kPjiFKLZrX8mZfP9EB4fJRsUD69IVEan9B8j6TU2NXSdLqShFGFOsY4E0VlDCp0PHLTHZlCmZqbwzGh/3VJ/H5HRZX5jqthvPjR24caDCpjl3Zi2li38gABh1dM4KOS/4SwZ+ZCEzUqhSiqus3JN2iCuquvdwMiYk89n8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784234273; c=relaxed/simple;
	bh=+y7whFaSazrI9u4MLVgoLr8APkI/CrVVLWbMLe/NDJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NvdQa9fm4qVlc9bJlzFEsgsr7J9QtUQ48xFscgcCjeae1F/3DvRs2G7V1cCfalXhf4+9PjU8oMF9LQyTP5i/tHZRfuJnVejvdfXNuNzIjCQ2Ig06IDbhWeliSa3VgZfQNY7iiJJKRH1lnVkdULJuVn1KV98tFj5+a+MUyfO5HB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CjbK3k9O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kO7iWcxv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CjbK3k9O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kO7iWcxv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CjbK3k9O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kO7iWcxv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CjbK3k9O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kO7iWcxv"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 527583E43;
	Thu, 16 Jul 2026 20:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784234254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sgO4vJn22QD4FlXq9gCg5GcxdfLH6zGyGDfTHDuEJ+k=;
	b=CjbK3k9ORjueXLfRfXEnvpN+bmEyyh5+H0nABMfr4bWhGeLCV1llxS0j22NKTrc6z1oMH2
	dCR6gCd7X8O/jzAPcg8Wiu4VeBlYN/RVJiI9UBq7c3rj7XZOTlK8pBBeahHPxV7jcSFDad
	ThpqpnkA+ZinANmILmG39Nx6JDRLz9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784234254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sgO4vJn22QD4FlXq9gCg5GcxdfLH6zGyGDfTHDuEJ+k=;
	b=kO7iWcxvkU/8tZ7z19S9R9tqBRKnlkaxgZ/n3cziJ6DnXVU/soyY8RjZ7Crz7ZOxRiouGa
	6NISFtgPalwoTdDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CjbK3k9O;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kO7iWcxv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784234254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sgO4vJn22QD4FlXq9gCg5GcxdfLH6zGyGDfTHDuEJ+k=;
	b=CjbK3k9ORjueXLfRfXEnvpN+bmEyyh5+H0nABMfr4bWhGeLCV1llxS0j22NKTrc6z1oMH2
	dCR6gCd7X8O/jzAPcg8Wiu4VeBlYN/RVJiI9UBq7c3rj7XZOTlK8pBBeahHPxV7jcSFDad
	ThpqpnkA+ZinANmILmG39Nx6JDRLz9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784234254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sgO4vJn22QD4FlXq9gCg5GcxdfLH6zGyGDfTHDuEJ+k=;
	b=kO7iWcxvkU/8tZ7z19S9R9tqBRKnlkaxgZ/n3cziJ6DnXVU/soyY8RjZ7Crz7ZOxRiouGa
	6NISFtgPalwoTdDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B875C779AD;
	Thu, 16 Jul 2026 20:37:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SBL5KQ1BWWrmJQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 16 Jul 2026 20:37:33 +0000
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
Subject: [PATCH 3/3 net-next] ipv6: add CAP_NET_ADMIN check for forwarding and force_forwarding sysctl
Date: Thu, 16 Jul 2026 22:37:13 +0200
Message-ID: <20260716203713.17392-4-fmancera@suse.de>
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
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 527583E43
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

As commit 8292d7f6e871 ("net: ipv4: add capability check for net
administration") did for IPv4, make sure that CAP_NET_ADMIN is required
to modify IPv6 forwarding and force_forwarding sysctl. This keep the
consistency of permission check logic between both protocols.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv6/addrconf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index f6fa2715b450..b2a0e6a4189d 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6363,11 +6363,15 @@ static void ipv6_ifa_notify(int event, struct inet6_ifaddr *ifp)
 static int addrconf_sysctl_forward(const struct ctl_table *ctl, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
+	struct net *net = ctl->extra2;
 	struct ctl_table lctl;
 	int *valp = ctl->data;
 	int val = *valp;
 	int ret;
 
+	if (write && !ns_capable(net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	/*
 	 * ctl->data points to idev->cnf.forwarding, we should
 	 * not modify it until we get the rtnl lock.
@@ -6805,6 +6809,9 @@ static int addrconf_sysctl_force_forwarding(const struct ctl_table *ctl, int wri
 	int old_val = *valp;
 	int ret;
 
+	if (write && !ns_capable(net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	tmp_ctl.extra1 = SYSCTL_ZERO;
 	tmp_ctl.extra2 = SYSCTL_ONE;
 	tmp_ctl.data = &new_val;
-- 
2.55.0

