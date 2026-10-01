Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2584D414409
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 08:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790844753; cv=none; b=aWUZ+oYZo4O/GugSujdG8UH5ch4FAn5hWKWxIV9MmJTKlAwAH1imfsF54pmC3pvQ2ndKPUVLrrZ4oPuKhObaZ9nXM52x3LMLlxCOhe3EcUsD3AuELKXarXucmz/Y3Je94YlM1Yac5n+kYwGnMnB7Cm7nw1HAyCxMtbEH8+r0y4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790844753; c=relaxed/simple;
	bh=tQ3nhyRdHVGgqGkPxw1/kFLznKlqLUUEfyvuq7F5LCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cbV/L55DfnoBc8s+JD3b+v5oi1ryHSe0SbOebQa0swNsrWbrPfdDFfQFrf33dplXfGYr3V0JUX/9btUq3cLrwuWYbhdQjv8QLuu6vNTLs2WoDyhovOalwYT7HFffZMPZWjS1pWd5Y8IR/BQQUOTzJetQ0Zw4EQ1RGBxGpXkGFWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NJ4YHVzf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XnEtUY42; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SBl/pFrh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CgiMiRyP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NJ4YHVzf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XnEtUY42";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SBl/pFrh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CgiMiRyP"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C32A821EA4;
	Thu,  1 Oct 2026 08:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790844745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3AA2PsFdjTQ7hjjk/rtRs33YqKNWPQrl/mnE7sGpv38=;
	b=NJ4YHVzfJWdlyJADAoIcohEITGpThkQCGoEYWrWkY6ieU1xSDBLc1D2t13ktpWu1XqV5FW
	v3pXD1BmxLi0Z+1DWe+V0heWBsQrZZyNfQHEzbxn9AmTBlMWD0xFEn58x3rqHJS3Ecdz3M
	QqRPg3FFcbRhhg4hPg1NQYu/iLXUC7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790844745;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3AA2PsFdjTQ7hjjk/rtRs33YqKNWPQrl/mnE7sGpv38=;
	b=XnEtUY42ZVSqBCqKdxSddchigNxU78Ht/yLfEhASXB0jaZq/i80PRwNZlbTdwtKz0keOGY
	fyjrnnS6Wrvig7AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="SBl/pFrh";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CgiMiRyP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790844741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3AA2PsFdjTQ7hjjk/rtRs33YqKNWPQrl/mnE7sGpv38=;
	b=SBl/pFrhhPkiL8q7bckVJxMIRNZ68XEKYb1cbUTHiM9pvhleqVitJk2yqjvBCDypbVDOqF
	rlnyqqasGFyePAcVpxCXiOIt3fnYcwi/hjehmyThmaqJne4ULqaPL3soy5mI65BVBUvTip
	BgfJ4tznDflFghgmBpJiJ86v+j642/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790844741;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3AA2PsFdjTQ7hjjk/rtRs33YqKNWPQrl/mnE7sGpv38=;
	b=CgiMiRyPU8sXoSnyFpwCYByJW+XpxAuF/rfyVt/W12sQG2n8A5CkNesCgLp3dKnYNVuqsS
	/u0mPnK64iWzXjCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1535136B2;
	Thu,  1 Oct 2026 08:52:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XVtYIEQfvmpZfQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 01 Oct 2026 08:52:20 +0000
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
Subject: [PATCH net] net: openvswitch: validate transport header presence in set_ipv6_addr
Date: Thu,  1 Oct 2026 10:52:05 +0200
Message-ID: <20261001085205.3822-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C32A821EA4
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TAGGED_RCPT(0.00)[4cc63fcfb3845e149969];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email]
X-Spam-Flag: NO
X-Spam-Score: -1.51
X-Spam-Level: 

When executing IPv6 address rewrite actions on IPv6 fragments,
set_ipv6_addr() might attempt to recalculate the L4 header checksum
calling skb_transport_header() with an uninitialized transport header.
This can potentially lead to a OOB write. A warning is triggered with
DEBUG_NET=y.

Fix this by recalculating the checksum only if there is a valid
transport header in the skb. Otherwise, assume this is a fragment and
skip it.

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
 net/openvswitch/actions.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index dc5ff859f114..a14668565ec4 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -395,7 +395,7 @@ static void set_ipv6_addr(struct sk_buff *skb, u8 l4_proto,
 			  __be32 addr[4], const __be32 new_addr[4],
 			  bool recalculate_csum)
 {
-	if (recalculate_csum)
+	if (recalculate_csum && skb_transport_header_was_set(skb))
 		update_ipv6_checksum(skb, l4_proto, addr, new_addr);
 
 	skb_clear_hash(skb);
-- 
2.55.0

