Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07BA3CC334
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779966695; cv=none; b=tXETXCgprnhCUBfjiAk9oZ6C3Mm895v29gyciqOxLa5tnqi0h3/esHqJ3a+gFQWdeWo/FKP1zTWGqYXmeCa6tPyrYGbVZs8lJtgN5UlBhPVMUJV/u05T+31XOLy66ly1jCY+VPQE2gUHybzPtVl4o3BG9OXisi1k7NkeRUyFUZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779966695; c=relaxed/simple;
	bh=6/mLvkuGL1xnkCKXf6tCfAcf8+InUB8no/yDPfAwRO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MYbrAYNrvkqQMUryAbz4i3vYiCdzUu9IZThkwcphvSQ9HFfMkoA1lKh/SWYQNgdhKK3Dsm1jVV6GeEzyK0/1U4SXdqu1IISkZNYWjOBAxbWYwNOvq39hRQMzkamQiRC8COTAt68cX4/93+2smRX68r/psbiN/jKkaX/kVfhiIpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DEOqPgtz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iDv0j0PW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DEOqPgtz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iDv0j0PW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DEOqPgtz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iDv0j0PW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DEOqPgtz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iDv0j0PW"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BAC5F6A7D8;
	Thu, 28 May 2026 11:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779966691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SSnXSCxBX7t8C73/6eUd1yqN9fiYuGSzrZguTzGV9FE=;
	b=DEOqPgtzlYfclpGRpSKqUXvuRPSE+9YNmf1gMNKX+P3AUxe4ldhdU8lgWP3OyiOHwdNUZ7
	EimV6MkHTiWnjhQ//4CTVHAlKSTB3oWU4RlggImOJ9CaBoL8A5l7plRjLVq7D+bTpnczkN
	5970ZdN5aocfuL26cpnf5ZMe4DiUz5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779966691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SSnXSCxBX7t8C73/6eUd1yqN9fiYuGSzrZguTzGV9FE=;
	b=iDv0j0PWyHt0h+O2nZKeC4TDUydXxYcamVpJh5THEI7LDISdH+YoejVG62z2MtALJI9Q61
	X5XNSw0ARaptMTDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DEOqPgtz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iDv0j0PW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779966691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SSnXSCxBX7t8C73/6eUd1yqN9fiYuGSzrZguTzGV9FE=;
	b=DEOqPgtzlYfclpGRpSKqUXvuRPSE+9YNmf1gMNKX+P3AUxe4ldhdU8lgWP3OyiOHwdNUZ7
	EimV6MkHTiWnjhQ//4CTVHAlKSTB3oWU4RlggImOJ9CaBoL8A5l7plRjLVq7D+bTpnczkN
	5970ZdN5aocfuL26cpnf5ZMe4DiUz5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779966691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SSnXSCxBX7t8C73/6eUd1yqN9fiYuGSzrZguTzGV9FE=;
	b=iDv0j0PWyHt0h+O2nZKeC4TDUydXxYcamVpJh5THEI7LDISdH+YoejVG62z2MtALJI9Q61
	X5XNSw0ARaptMTDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09F175AD5E;
	Thu, 28 May 2026 11:11:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o3tFO+IiGGq/LwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 28 May 2026 11:11:30 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: yuhuang@redhat.com,
	justin.iurman@gmail.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	idosch@nvidia.com,
	dsahern@kernel.org,
	sbrivio@redhat.com,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Chris Adams <linux@cmadams.net>
Subject: [PATCH net] Revert "ipv6: preserve insertion order for same-scope addresses"
Date: Thu, 28 May 2026 13:11:23 +0200
Message-ID: <20260528111123.4667-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BAC5F6A7D8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,kernel.org,google.com,davemloft.net,nvidia.com,suse.de,cmadams.net];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -1.51

Chris Adams reported that preserving insertion order for same-scope
addresses is causing SSH connections to be dropped after stopping a VM
while running NetworkManager.

NetworkManager is caching the networking information from the system and
later operating with it. It relies on the order of IPv6 addresses to
configure routes for outgoing traffic. Revert to the previous ordering.

This reverts commit cb3de96eea66f5e4a580086c6a1be46e765f97f4.

Fixes: cb3de96eea66 ("ipv6: preserve insertion order for same-scope addresses")
Reported-by: Chris Adams <linux@cmadams.net>
Closes: https://lore.kernel.org/netdev/20260521135310.GC977@cmadams.net/
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv6/addrconf.c                  | 2 +-
 tools/testing/selftests/net/ioam6.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 5476b6536eb7..bb84a78b80f6 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1013,7 +1013,7 @@ ipv6_link_dev_addr(struct inet6_dev *idev, struct inet6_ifaddr *ifp)
 	list_for_each(p, &idev->addr_list) {
 		struct inet6_ifaddr *ifa
 			= list_entry(p, struct inet6_ifaddr, if_list);
-		if (ifp_scope > ipv6_addr_src_scope(&ifa->addr))
+		if (ifp_scope >= ipv6_addr_src_scope(&ifa->addr))
 			break;
 	}
 
diff --git a/tools/testing/selftests/net/ioam6.sh b/tools/testing/selftests/net/ioam6.sh
index b2b99889942f..845c26dd01a9 100755
--- a/tools/testing/selftests/net/ioam6.sh
+++ b/tools/testing/selftests/net/ioam6.sh
@@ -273,8 +273,8 @@ setup()
   ip -netns $ioam_node_beta link set ioam-veth-betaR name veth1 &>/dev/null
   ip -netns $ioam_node_gamma link set ioam-veth-gamma name veth0 &>/dev/null
 
-  ip -netns $ioam_node_alpha addr add 2001:db8:1::2/64 dev veth0 &>/dev/null
   ip -netns $ioam_node_alpha addr add 2001:db8:1::50/64 dev veth0 &>/dev/null
+  ip -netns $ioam_node_alpha addr add 2001:db8:1::2/64 dev veth0 &>/dev/null
   ip -netns $ioam_node_alpha link set veth0 up &>/dev/null
   ip -netns $ioam_node_alpha link set lo up &>/dev/null
   ip -netns $ioam_node_alpha route add 2001:db8:2::/64 \
-- 
2.54.0

