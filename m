Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E308044163B
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790927612; cv=none; b=WE3cCpZGSpQHtELj6KyzeifdU4V9QLbG2ZY9/2go555H/YZdQnszcXAjXChxns1TPzw8Z0vaRCZx02G+ZlrcSqmKl0v1O/NsSDH0YE0zr+JJGAL229+sR0+v77EVkHLT7KDxRToEgEXPJ5MweAyT9kRZO4V02IpFZRxQQILvvRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790927612; c=relaxed/simple;
	bh=4NIXq87sQz4gbvko4UfvHyJc8FXTe24Eu3SMSTwArvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J2SQE8mka5K3y+ys3ot0XS+U5+OFdnDrPHViJepQNAGkGGkZiGgkq0jmcYgDpuXSc55PmO/ny41db4FR9fE/2PZzHHS5imlVf9oAISNoZxEXH1CwlsWebewVApwTKpaBtqmAPoo25gAlWtq4y0uJXNrVMtlrdnVE1zxUbEWBZDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OWmW20rB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IpCZhjOm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cp/BpM5y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5r20iau4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OWmW20rB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IpCZhjOm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cp/BpM5y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5r20iau4"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 651081FE47;
	Fri,  2 Oct 2026 07:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790927604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VwsVNyxNevp4dfeKi//n4bjszHYZju0LCPRBCNL6q3Y=;
	b=OWmW20rBTNFGoBV4geOYtTxXrY6cVDRB4ZsLlTp9ifqzHbYtAe44wSsrXiyZBS3Jgk4ucW
	7bZ8ffaARQudkO40ntpzGqTAhuKehEloW8Pk4jpLwAZRirai5Pwv5oVhEIqdNcsV4pZXcY
	F7Yn3u5C99dH9JRiMh+i6/tbR6UgL4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790927604;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VwsVNyxNevp4dfeKi//n4bjszHYZju0LCPRBCNL6q3Y=;
	b=IpCZhjOmXOlps4BLNef7/eLrlxrVlHFKXnwfLLTdrS7wm3/MqevTahzPCICpBjRCWO0iQ4
	pAvMtrtB5pu1yMDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="cp/BpM5y";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5r20iau4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790927600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VwsVNyxNevp4dfeKi//n4bjszHYZju0LCPRBCNL6q3Y=;
	b=cp/BpM5yi2QMBZmsgGy0ekQ5UJdX5HTbWRfU++JdxgzPAO9qGU9V9neIsD5lt4kD+geejy
	x91y2t/2KZlEPJzqlKa2wcVDBuoPyjhehYV3FuWVTbr9EiQdNIY7yRxpXxBXco8l9N3DYZ
	oPBsCEdsjwLgOoKB8z6tT/D0VgirT8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790927600;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VwsVNyxNevp4dfeKi//n4bjszHYZju0LCPRBCNL6q3Y=;
	b=5r20iau43HJ4ul5UCUp4PY/rPiHBqYXRVc2ru4uMRuZY7XBr6fGIoXTcK8HG5e0t39nonA
	A4gHPQMwuXKuJWDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7936113691;
	Fri,  2 Oct 2026 07:53:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zE2QEu9iv2pjFwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 02 Oct 2026 07:53:19 +0000
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
	Fernando Fernandez Mancera <fmancera@suse.de>,
	syzbot+4cc63fcfb3845e149969@syzkaller.appspotmail.com
Subject: [PATCH net v2] net: openvswitch: validate transport header presence in set_ipv6_addr
Date: Fri,  2 Oct 2026 09:52:55 +0200
Message-ID: <20261002075255.5015-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 651081FE47
X-Rspamd-Action: no action
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
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[14];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[4cc63fcfb3845e149969];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:email,suse.de:dkim];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -1.51
X-Spam-Level: 

When executing IPv6 address rewrite actions on IPv6 fragments,
set_ipv6_addr() calls update_ipv6_checksum(). If parse_ipv6hdr()
processes a non-first IPv6 fragment, it sets key->ip.proto to
NEXTHDR_FRAGMENT and returns early without calling
skb_set_transport_header().

update_ipv6_checksum() unconditionally evaluates skb_transport_offset()
on entry before checking l4_proto.  Because skb->transport_header is
uninitialized, this triggers a warning under CONFIG_DEBUG_NET=y although
it is completely harmless.

Fix this by returning early in update_ipv6_checksum() if l4_proto is
NEXTHDR_FRAGMENT. This avoids reading the uninitialized transport offset
for fragments while preserving the debug warning for any other protocol
where the transport header is unexpectedly missing.

See the syzbot trace:

!skb_transport_header_was_set(skb)
WARNING: ./include/linux/skbuff.h:3075 at skb_transport_header include/linux/skbuff.h:3075 [inline], CPU#1: syz-executor463/5635
WARNING: ./include/linux/skbuff.h:3075 at skb_transport_offset include/linux/skbuff.h:3250 [inline], CPU#1: syz-executor463/5635
WARNING: ./include/linux/skbuff.h:3075 at update_ipv6_checksum net/openvswitch/actions.c:361 [inline], CPU#1: syz-executor463/5635
WARNING: ./include/linux/skbuff.h:3075 at set_ipv6_addr+0x462/0x660 net/openvswitch/actions.c:399, CPU#1: syz-executor463/5635
[...]
RIP: 0010:skb_transport_header include/linux/skbuff.h:3075 [inline]
RIP: 0010:skb_transport_offset include/linux/skbuff.h:3250 [inline]
RIP: 0010:update_ipv6_checksum net/openvswitch/actions.c:361 [inline]
RIP: 0010:set_ipv6_addr+0x462/0x660 net/openvswitch/actions.c:399
[...]
Call Trace:
 <TASK>
 set_ipv6 net/openvswitch/actions.c:531 [inline]
 do_execute_actions+0x557e/0x8600 net/openvswitch/actions.c:1366
 ovs_execute_actions+0xde/0x520 net/openvswitch/actions.c:1592
 ovs_packet_cmd_execute+0xb4f/0xf10 net/openvswitch/datapath.c:705
 genl_family_rcv_msg_doit+0x233/0x340 net/netlink/genetlink.c:1114
 genl_rcv_msg+0x614/0x7a0 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2572
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
 netlink_unicast+0x7bd/0x940 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1916
 sock_sendmsg_nosec+0x14e/0x190 net/socket.c:800

Reported-by: syzbot+4cc63fcfb3845e149969@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4cc63fcfb3845e149969
Fixes: 3fdbd1ce11e5 ("openvswitch: add ipv6 'set' action")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/openvswitch/actions.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index dc5ff859f114..68b42e900c73 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -358,7 +358,15 @@ static void set_ip_addr(struct sk_buff *skb, struct iphdr *nh,
 static void update_ipv6_checksum(struct sk_buff *skb, u8 l4_proto,
 				 __be32 addr[4], const __be32 new_addr[4])
 {
-	int transport_len = skb->len - skb_transport_offset(skb);
+	int transport_len;
+
+	/* avoid reading the transport header offset if it isn't set,
+	 * as it triggers a warning
+	 */
+	if (l4_proto == NEXTHDR_FRAGMENT)
+		return;
+
+	transport_len = skb->len - skb_transport_offset(skb);
 
 	if (l4_proto == NEXTHDR_TCP) {
 		if (likely(transport_len >= sizeof(struct tcphdr)))
-- 
2.55.0

