Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E163C9EFE
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774872660; cv=none; b=fxUHplOXC2ctrSC3yNJrdov7G8yk+X6QflRryAK4/FTZO9rlrnrnLHqyP5NddfCpvIt7UXHUBZ4EJIRAS8xrSi4KLF7kwgXooeR3kNWQ4iwD5n1z4tAKbvne6L0S/Dhx1o1u+3YyaSXhbaybkXDmbRRQdL7n5/nSX96P/C9H4DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774872660; c=relaxed/simple;
	bh=+LMQoTvu244a85Ncb5u2POFz1DjpQtqMwBU9f7MsV38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q6oiBTkgbaDt8Ofk/8kyjBu/RtW7m4O2mwfVrn+t8l/QUczBGwD3ExXH+bvae3y68h5x6gkRW4MY934Xj/+BNVSqUKE3+imRBGEIJ0USKkeIWwq0tD72nWMX6IN52NJ68HchFIVRqS+aAl9VjsEAILw0K+g2uNOrmlRlcDKxjT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ATRnpqS5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=y84QewfJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ATRnpqS5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=y84QewfJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ATRnpqS5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="y84QewfJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ATRnpqS5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="y84QewfJ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4C96A5BD4C;
	Mon, 30 Mar 2026 12:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774872657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0Aiho5oPMkWNSDw5vCE+2Y0Zrx63tX6ET7WiXGit7WQ=;
	b=ATRnpqS5y5bHge/fqewsFrAy0cf4AxqRJTYmorm3eu9NEclVMRhI8Oeu72wXfyICvmc8Q7
	Q2bw2kGXiZBKO/WoUms/T3tSS0NQVu9ix848fpGXTK243342DWfHxSE1TlNaYQfFEoGCJA
	eZDYdQS8hyOmOS1jYFJ3DfMBbYy2e+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774872657;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0Aiho5oPMkWNSDw5vCE+2Y0Zrx63tX6ET7WiXGit7WQ=;
	b=y84QewfJ9bXt4vs5Ny/yi7xpmaGvsuNPUHNsKWf/l5s451i66Po59uGwvjk3oATYXN/b/N
	IO9Vtiqq6wQWNkCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ATRnpqS5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=y84QewfJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774872657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0Aiho5oPMkWNSDw5vCE+2Y0Zrx63tX6ET7WiXGit7WQ=;
	b=ATRnpqS5y5bHge/fqewsFrAy0cf4AxqRJTYmorm3eu9NEclVMRhI8Oeu72wXfyICvmc8Q7
	Q2bw2kGXiZBKO/WoUms/T3tSS0NQVu9ix848fpGXTK243342DWfHxSE1TlNaYQfFEoGCJA
	eZDYdQS8hyOmOS1jYFJ3DfMBbYy2e+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774872657;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0Aiho5oPMkWNSDw5vCE+2Y0Zrx63tX6ET7WiXGit7WQ=;
	b=y84QewfJ9bXt4vs5Ny/yi7xpmaGvsuNPUHNsKWf/l5s451i66Po59uGwvjk3oATYXN/b/N
	IO9Vtiqq6wQWNkCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94F2E4A0A2;
	Mon, 30 Mar 2026 12:10:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DR80IVBoymkKSwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 30 Mar 2026 12:10:56 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: sdf@fomichev.me,
	petrm@nvidia.com,
	idosch@nvidia.com,
	razor@blackwall.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net-next] net: vxlan: check ipv6_mod_enabled() on neigh_reduce()
Date: Mon, 30 Mar 2026 14:10:33 +0200
Message-ID: <20260330121033.4479-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Queue-Id: 4C96A5BD4C
X-Spam-Flag: NO
X-Spam-Score: -1.51
X-Spam-Level: 

IPv6 must be enabled or otherwise neigh_reduce() might cause a kernel
panic. This was prevented by a check on in6_dev. Use ipv6_mod_enabled()
instead as it is cleaner and also consistent with the code at
route_shortcircuit().

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 drivers/net/vxlan/vxlan_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index b5fbd03418b6..b3b692c4b628 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2027,13 +2027,11 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	const struct in6_addr *daddr;
 	const struct ipv6hdr *iphdr;
-	struct inet6_dev *in6_dev;
 	struct neighbour *n;
 	struct nd_msg *msg;
 
 	rcu_read_lock();
-	in6_dev = __in6_dev_get(dev);
-	if (!in6_dev)
+	if (unlikely(!ipv6_mod_enabled()))
 		goto out;
 
 	iphdr = ipv6_hdr(skb);
-- 
2.53.0

