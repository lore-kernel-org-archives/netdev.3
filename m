Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BF6323417
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 19:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790970902; cv=none; b=RhAANa5K9b+kckD14wlpmXF7tZFqYNKL07eI6+fkd62tnPzCjhiXM7Lj6swoU6rD0aW+gttGsElvu3DIVZ8ycfhmUPUiK2ROSvRfFv8ZG+h+zwDU8XunK9kGbij+l5wlrin01IrBGtgHQIuai2X059TurgEbDNKtxlrPvh5CmQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790970902; c=relaxed/simple;
	bh=k/LwUBw0eT9k2Dq/0KfgPGIlcROjJdVTPHiyPqLeu84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XPH79EcVTC3cCPovFKKOrlyzgt1XQKaXLASAVhOHKpoiZoJB03ywLegBb2vUAB7guomqlP7oqQ4P/Xc+YE5yjKxPwqrCSP453/kD5Omb1e+L3R7f3qwlZOFE/fI0shfoWmt+SUpb1Qlj3E6jS0GyezVBD8hiUd7PMt58u56wbRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yt7cTz/t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ahpPQfrz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mMta61Xf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sqX0+Yg8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yt7cTz/t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ahpPQfrz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mMta61Xf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sqX0+Yg8"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 403AC21D51;
	Fri,  2 Oct 2026 19:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790970893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gVtIh9Y+qd59axXBVnpsVUbIzAUNm8HT7C45twNaL+A=;
	b=yt7cTz/tqQuAzh3yLERokQPXnSdl01fEwWWCddlcTcy8YCtRMqE+Eo92NqruXRsxQifziK
	x/wgPJouOn4c/RqLVogO4XPgV/wZKZRQE9eiY+oNim1vp1o0KVwDA42niJUgOilhkJ6mRW
	S9b5RqQcIs+sJLH1Vbojsd2eKD7NiOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790970893;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gVtIh9Y+qd59axXBVnpsVUbIzAUNm8HT7C45twNaL+A=;
	b=ahpPQfrzJXqTTrfzkIi0Tf7K/pByG+ynhJGXDF93YNKOOw0QgUDkwFGDd2GUXYrYEqH8iv
	W5GwLyd+DHK3nSCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790970889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gVtIh9Y+qd59axXBVnpsVUbIzAUNm8HT7C45twNaL+A=;
	b=mMta61Xf7dH5ou5piNpU4j6c5r90Xos/Ak3aMyjTkwaEyCA31mg+5++SbPE7+vqub2dyRw
	x/YZ/8bgPja9HEdssrwRZFEvKvAfGTKs8Id9pEcq77jG9FZlxAQI17FSFSzUPWXLRvO6fH
	lmRpiGb1Ehb0SBGOp9Yb6b8DoRZJw0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790970889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gVtIh9Y+qd59axXBVnpsVUbIzAUNm8HT7C45twNaL+A=;
	b=sqX0+Yg8FWW/yY8NQdd1K6Fb/evVo/vX87l4QbVeaFDdSA0RStF00a1DhEAjt7ZCi/yxU0
	uf36WYwH9hp6pbCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DFE9139E2;
	Fri,  2 Oct 2026 19:54:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XpMFDAgMwGoZDwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 02 Oct 2026 19:54:48 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	aatteka@nicira.com,
	jesse@nicira.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@kernel.org,
	davem@davemloft.net,
	i.maximets@ovn.org,
	echaudro@redhat.com,
	aconole@redhat.com,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net-next] net: openvswitch: do not set transport header on later IPv4 fragments
Date: Fri,  2 Oct 2026 21:54:36 +0200
Message-ID: <20261002195436.8473-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Currently, check_iphdr() sets the transport header offset for all IPv4
packets, including later fragments that do not contain an L4 header.

As discussed, let's not set the transport header for non-first IPv4
fragments to prevent a future out-of-bounds memory access that can
happen silently because the warning at skb_transport_header_offset()
does not trigger. In addition, defer the transport_len calculation until
after the fragment check.

Link: https://lore.kernel.org/netdev/59d32c37-6151-4649-97bf-bad050dc3f13@ovn.org/
Suggested-by: Ilya Maximets <i.maximets@ovn.org>
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
Sashiko: If you notice a similar problem at IPv6 path, we have fixed it
already in net tree, here is submission:

https://lore.kernel.org/netdev/20261002075255.5015-1-fmancera@suse.de/
---
 net/openvswitch/actions.c | 4 +++-
 net/openvswitch/flow.c    | 7 ++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index dc5ff859f114..867c26e14ead 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -322,11 +322,13 @@ static int pop_nsh(struct sk_buff *skb, struct sw_flow_key *key)
 static void update_ip_l4_checksum(struct sk_buff *skb, struct iphdr *nh,
 				  __be32 addr, __be32 new_addr)
 {
-	int transport_len = skb->len - skb_transport_offset(skb);
+	int transport_len;
 
 	if (nh->frag_off & htons(IP_OFFSET))
 		return;
 
+	transport_len = skb->len - skb_transport_offset(skb);
+
 	if (nh->protocol == IPPROTO_TCP) {
 		if (likely(transport_len >= sizeof(struct tcphdr)))
 			inet_proto_csum_replace4(&tcp_hdr(skb)->check, skb,
diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
index 1c4f3a079044..d549a58180a7 100644
--- a/net/openvswitch/flow.c
+++ b/net/openvswitch/flow.c
@@ -189,6 +189,7 @@ static bool arphdr_ok(struct sk_buff *skb)
 static int check_iphdr(struct sk_buff *skb)
 {
 	unsigned int nh_ofs = skb_network_offset(skb);
+	const struct iphdr *nh;
 	unsigned int ip_len;
 	int err;
 
@@ -201,7 +202,11 @@ static int check_iphdr(struct sk_buff *skb)
 		     skb->len < nh_ofs + ip_len))
 		return -EINVAL;
 
-	skb_set_transport_header(skb, nh_ofs + ip_len);
+	nh = ip_hdr(skb);
+
+	if (!(nh->frag_off & htons(IP_OFFSET)))
+		skb_set_transport_header(skb, nh_ofs + ip_len);
+
 	return 0;
 }
 
-- 
2.55.0

