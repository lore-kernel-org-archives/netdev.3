Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE985038E8
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 12:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068509; cv=none; b=E+oESGbAGKEFiV4FrgRDe/YjJTGUz6Lq3Ze7BBa/bAbIc21bZG9/9VzcbxafCe0VuE/X349OJsWuCH+eqlB+V9+iY+JINtRcJBZ4Wkax5Sa+zt5D4XnUAH+Fo/eFmJpjahXL9jL0iSqMzZ/Thrs8QnjCL4FZCm8txcxy8esmkM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068509; c=relaxed/simple;
	bh=CBxgp8hd5VqFuHEiXGD6BxJwJP6dlRrq66zEDcFm0AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rh9NOnyYUYfTXI6oznVt2z7FNgSraTP9/744U+e0ep0XqOJqtWuxa2ON1G5OjB0L9DrT2soblTVe/FkOzEZpDaNpCtiKtZrSWkNv5NbbwpnwhJXoPsSimFpOmvkRENEPWsFnRUfpPK3RxrFxOV3JxrPm/mG52cJ2GYC8T7NqXds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VafmoCbN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Afbi+h3U; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VafmoCbN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Afbi+h3U; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VafmoCbN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Afbi+h3U";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VafmoCbN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Afbi+h3U"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 08B651FDD9;
	Thu, 15 Oct 2026 12:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792068506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=l53wZ1T6OIcdWRKp/q9mEA/mABVpHS45YXdDwTw5Gfs=;
	b=VafmoCbNwvAxCVho4a5W4HY9/a+iGu4tnQOoDU8L1uXeWVKwWjISflHZu1lKzhJNu06Pqj
	beQWMaEeXTghZ1k2qDd7YilvG/8kEPpHFDNX6V3jtQasq2vDC8NAd5PZeJ/0Bs+kDOFYh3
	5QNK6l4sGlxq/IoM7g7d/VVWcfxPSkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792068506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=l53wZ1T6OIcdWRKp/q9mEA/mABVpHS45YXdDwTw5Gfs=;
	b=Afbi+h3UNLkKS+o6csG7XNY0xSke74lI3l4iiHkBofZOeglDIvedMd9TWkGHj5LriKyHfc
	Gukxet0sEr5ajXDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792068506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=l53wZ1T6OIcdWRKp/q9mEA/mABVpHS45YXdDwTw5Gfs=;
	b=VafmoCbNwvAxCVho4a5W4HY9/a+iGu4tnQOoDU8L1uXeWVKwWjISflHZu1lKzhJNu06Pqj
	beQWMaEeXTghZ1k2qDd7YilvG/8kEPpHFDNX6V3jtQasq2vDC8NAd5PZeJ/0Bs+kDOFYh3
	5QNK6l4sGlxq/IoM7g7d/VVWcfxPSkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792068506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=l53wZ1T6OIcdWRKp/q9mEA/mABVpHS45YXdDwTw5Gfs=;
	b=Afbi+h3UNLkKS+o6csG7XNY0xSke74lI3l4iiHkBofZOeglDIvedMd9TWkGHj5LriKyHfc
	Gukxet0sEr5ajXDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6ADE41373D;
	Thu, 15 Oct 2026 12:48:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7MJWDY7L0GoCLQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 15 Oct 2026 12:48:15 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	jesse@nicira.com,
	aatteka@nicira.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@kernel.org,
	davem@davemloft.net,
	i.maximets@ovn.org,
	echaudro@redhat.com,
	aconole@redhat.com,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 1/2 net-next] net: openvswitch: skip IPv4 later fragments on TCP/UDP set actions
Date: Thu, 15 Oct 2026 14:47:48 +0200
Message-ID: <20261015124749.4694-1-fmancera@suse.de>
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
	NEURAL_HAM_SHORT(-0.20)[-0.995];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO

An IPv4 later fragment carries no L4 header, but key extraction leaves
ip.proto set to the real protocol and the flow may wildcard the frag
field, so validate_set() accepts such packets. set_tcp() and set_udp()
then treat the first bytes of the fragment payload as an L4 header,
rewrite them as ports and patch the bytes at the checksum offset,
corrupting the packet.

Skip these actions for OVS_FRAG_TYPE_LATER. IPv6 later fragments are not
affected, since their ip.proto is NEXTHDR_FRAGMENT and validate_set()
rejects L4 set actions for them.

Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/openvswitch/actions.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 27152bca8a8c..4aade471afc4 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -595,6 +595,9 @@ static int set_udp(struct sk_buff *skb, struct sw_flow_key *flow_key,
 	__be16 src, dst;
 	int err;
 
+	if (flow_key->ip.frag == OVS_FRAG_TYPE_LATER)
+		return 0;
+
 	err = skb_ensure_writable(skb, skb_transport_offset(skb) +
 				  sizeof(struct udphdr));
 	if (unlikely(err))
@@ -638,6 +641,9 @@ static int set_tcp(struct sk_buff *skb, struct sw_flow_key *flow_key,
 	__be16 src, dst;
 	int err;
 
+	if (flow_key->ip.frag == OVS_FRAG_TYPE_LATER)
+		return 0;
+
 	err = skb_ensure_writable(skb, skb_transport_offset(skb) +
 				  sizeof(struct tcphdr));
 	if (unlikely(err))
-- 
2.55.0

