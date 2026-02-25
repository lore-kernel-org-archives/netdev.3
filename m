Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E92E33B96F
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 13:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026933; cv=none; b=U/dmq7ijFCY7MQ/q61+RHwDBpgTMeH3h5cxEVjEpXm8qwRTuaf1qJDLQHcJqp29ZznVwRASVPgP1ejdS/XFIHrVs6VwlRHh/Kw17nMAQPK7uzmRnP0RQ4G+gJRCvo+w8SxlR0vhiMN1qUejQBjdFJF+y3godOdVTJk5AbHy4/ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026933; c=relaxed/simple;
	bh=yxVFLdm33KsMlSlc4xGhy4Xh/lIXe6ydeFC0jS8Q6kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eDjeGGoUQ3QO2bASxbxowR0avxT++GenHBcfgwmgk68Gw+l7nkWA1aazTX3K+rYTJatMwpLPENMhb1guILpgfhzpWxp6ztJqmlJZlz0u4EZECF4fDLMjEwrCQrVTD38jwQfSo4PTdI7SSZNcAsHXy9xMavSfBvbnk5rbF72Z7MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PIL01JTb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nZGbCDTi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fy9FwyIk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y7CFRDk1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PIL01JTb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nZGbCDTi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fy9FwyIk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y7CFRDk1"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 64D215C66C;
	Wed, 25 Feb 2026 13:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772026929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uWvR7N40cFYsmM/FHVHwZttrkmyobfSR9FBNswNUI7M=;
	b=PIL01JTbQaVCYz1Nvgm9iLleep96DQWVHgo2pyiB13eUlDW/uLlX04hynCKEKJ4I1uceau
	ljsg5nTZ3/jm8kJOK76BXWd1lo8BQFUx6XnKpcOB7iypRTEWQjcMfFstmJcWv9OUlf1THP
	SAEEq6BmdUokYb7JDAQkmLHABQ5Dhyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772026929;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uWvR7N40cFYsmM/FHVHwZttrkmyobfSR9FBNswNUI7M=;
	b=nZGbCDTiOCZP3e7h1wGSL5n7VPeFam5MKT7gt2LT1+dN/Lo9BIK29PcpZMrHYncln1422f
	0C4bbNHy+0Npq6BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772026928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uWvR7N40cFYsmM/FHVHwZttrkmyobfSR9FBNswNUI7M=;
	b=fy9FwyIkg1hwv9ycueKQhQhBUQ3rCR5bmeOfwr1U9dJm80FgEV0Yb5zMgwpPIch34ibrGv
	wK7nd7XPSIA9bBW3+psu5WUEDp6Vx0WDmEiV2QHENkI0nZlyHlENYxXHEeXcQx92hEl5rj
	31QUPQHGUACbGL0/6KKjTLYKRFg3hfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772026928;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uWvR7N40cFYsmM/FHVHwZttrkmyobfSR9FBNswNUI7M=;
	b=Y7CFRDk16DY9Cd9G4/shl+DmoVrgVnToFDH9yfgyJJX7CjuJjlK9yUGGxpepbsnNHY0dM9
	cWntorKS1OXJa7Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3F2C3EA65;
	Wed, 25 Feb 2026 13:42:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +zSbLC/8nmnwJwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 25 Feb 2026 13:42:07 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	dsahern@kernel.org,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net-next v2] ipv6: discard fragment queue earlier if there is malformed datagram
Date: Wed, 25 Feb 2026 14:37:58 +0100
Message-ID: <20260225133758.4553-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

Currently the kernel IPv6 implementation is not dicarding the fragment
queue upon receiving a IPv6 fragment that is not 8 bytes aligned. It
relies on queue expiration to free the queue.

While RFC 8200 section 4.5 does not explicitly mention that the rest of
fragments must be discarded, it does not make sense to keep them. The
parameter problem message is sent regardless that. In addition, if the
sender is able to re-compose the datagram so it is 8 bytes aligned it
would qualify as a new whole datagram not fitting into the same fragment
queue.

The same situation happens if segment end is exceeding the IPv6 maximum
packet length. The sooner we can free resources the better during
reassembly, the better.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: handle segment end bigger than IPv6 maximum packet length 
---
 net/ipv6/reassembly.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 25ec8001898d..11f9144bebbe 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -132,6 +132,9 @@ static int ip6_frag_queue(struct net *net,
 		/* note that if prob_offset is set, the skb is freed elsewhere,
 		 * we do not free it here.
 		 */
+		inet_frag_kill(&fq->q, refs);
+		__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
+				IPSTATS_MIB_REASMFAILS);
 		return -1;
 	}
 
@@ -163,6 +166,9 @@ static int ip6_frag_queue(struct net *net,
 			 * this case. -DaveM
 			 */
 			*prob_offset = offsetof(struct ipv6hdr, payload_len);
+			inet_frag_kill(&fq->q, refs);
+			__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
+					IPSTATS_MIB_REASMFAILS);
 			return -1;
 		}
 		if (end > fq->q.len) {
-- 
2.53.0

