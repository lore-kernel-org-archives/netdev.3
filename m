Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179A4493D3B
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 10:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791456119; cv=none; b=Oqa6vdCZkqT0OA7Eu5D7SuCxbwZtgTgq60i8J+OGd5U7D7PXtuce6ep0CC5DZABeZAh9LG19mVrqO8T/I718SIAFx3b9S8y1Oyn6E7CeQI4fvi/TDblF1MPOXwyyXyLBxtraw0Tb+hGC0tqGlrAUbdocUOt6g42hSqzr+gscg34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791456119; c=relaxed/simple;
	bh=dmxbpcI7wG34mVa0PJLGCfU2OrIF55TL7walDwNeMNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b0YXXyQMZN+ODPUH8TlGlTt5k7wO9SCEjixywxP8cCPMhjL/SaOBidQgY4bO9q0qifHDYYlce2W8W6YUo4wqhaB66o/eBKE9uNuJpJbxyMRQz3Sh5hmpmgfqAcGAcWVDwgwU431fJGa17f1Hcb1Rje4ioyw4PNis6A+Jk72qsTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 35FD121C08;
	Thu,  8 Oct 2026 10:41:56 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 422F51339F;
	Thu,  8 Oct 2026 10:41:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Zqn6BHNzx2r/TgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 08 Oct 2026 10:41:55 +0000
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
	Fernando Fernandez Mancera <fmancera@suse.de>,
	syzbot+4cc63fcfb3845e149969@syzkaller.appspotmail.com
Subject: [PATCH net v3] net: openvswitch: validate transport header presence in set_ipv6_addr
Date: Thu,  8 Oct 2026 12:41:35 +0200
Message-ID: <20261008104135.4722-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
X-Spamd-Result: default: False [0.00 / 50.00];
	TAGGED_RCPT(0.00)[4cc63fcfb3845e149969]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 35FD121C08
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Score: 0.00
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

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
v3: drop the redundant comment introduced in v2
---
 net/openvswitch/actions.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index dc5ff859f114..27152bca8a8c 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -358,7 +358,12 @@ static void set_ip_addr(struct sk_buff *skb, struct iphdr *nh,
 static void update_ipv6_checksum(struct sk_buff *skb, u8 l4_proto,
 				 __be32 addr[4], const __be32 new_addr[4])
 {
-	int transport_len = skb->len - skb_transport_offset(skb);
+	int transport_len;
+
+	if (l4_proto == NEXTHDR_FRAGMENT)
+		return;
+
+	transport_len = skb->len - skb_transport_offset(skb);
 
 	if (l4_proto == NEXTHDR_TCP) {
 		if (likely(transport_len >= sizeof(struct tcphdr)))
-- 
2.55.0

