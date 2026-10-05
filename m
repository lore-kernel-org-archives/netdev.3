Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ED34BF921
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212934; cv=none; b=kLKupdhuVv6D+3aoQaIbtQy8gic7HfeIyYJ2KADzL2WY5ID8qHN/ayo476vtvtRECp6KTIuKvmYVLX1S/Y3JX7ASKIw9RWr6+GjDqHn+6qUy6Ez/BF5z5vO1iTT6vU/2e/MMTip+hqg3GFzdgvizUY+79W57NuMvz7t3QCpNrM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212934; c=relaxed/simple;
	bh=wa5F9VyCcwTEhvNCfm8/xiuVlSb7uL2If1y/bm80PoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K2czlbNDXIqk+DnptUlpC0ohSjs6nbVW4AJpQV2VMpv/aHmyP0XtYb3obBO3vzssPo6M4qJtRAOgCSz7OyLV4FiGLZnYhRgr6GWS5eLLGEp5Wju4v445D7wrf/5/OSXnIqmsjdWRXgmBYOvcZrg0NLjLggGNC5k6Kv2H9pOKnpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EfID3qr8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W0HlEuAd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aXlnnh+P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=haWUKiK8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EfID3qr8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W0HlEuAd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aXlnnh+P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="haWUKiK8"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9BBBA1F7B6;
	Mon,  5 Oct 2026 15:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791212926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qKTnA8jTdOC/ZoHULSlTljtuRlAWfmhsqjEIy+r+F+U=;
	b=EfID3qr8oKtGYoIVfFGVkvL20tC9Z4ZFKx7ktJ2YPcVyn/eeCYIgooveIQA1mbtkrUnWdb
	Wa4BXb1RFTmt8X2vP/WdbLMzq015OaHuMCCgw2uuwASpo6w9YGj0U4V0aJ2NwEV6BfAu8C
	CRphyB7aBj4uuh98RslAoPuvKHsnHPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791212926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qKTnA8jTdOC/ZoHULSlTljtuRlAWfmhsqjEIy+r+F+U=;
	b=W0HlEuAd6jirp6NaxhvEPJTCLt/65zmxD0o//282gzq9cN7GWBS5UdXzbKE6p8QtX2X8Ug
	+YnLAp3HSrIJlaCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791212922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qKTnA8jTdOC/ZoHULSlTljtuRlAWfmhsqjEIy+r+F+U=;
	b=aXlnnh+PagdMTLqMG+c6IZk4W5wnJ61hrge7NufIcCtu1gRh9Htn+5WfDYj7vOt+vpQur/
	DZMWME5lwX0Juv9KQ3XhpQ2i3AUmORsycvJTrWX6y91k5IuAASQ6m9ZPz/bYPpa+YTSPnl
	kYwCndJfCq8qPmPKYtKlZTNOneD9gPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791212922;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qKTnA8jTdOC/ZoHULSlTljtuRlAWfmhsqjEIy+r+F+U=;
	b=haWUKiK8OgWRYSun3z7EQjW1tRS3koK50tmbOBysJjGwnPDtoq94y41yFbD9A+ItkpQtoc
	hn8ft31OXJMCz8Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE47513688;
	Mon,  5 Oct 2026 15:08:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I8uoH3m9w2oaXwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 05 Oct 2026 15:08:41 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	blp@nicira.com,
	joe@wand.net.nz,
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
Subject: [PATCH net-next v2] net: openvswitch: do not set transport header on later IPv4 fragments
Date: Mon,  5 Oct 2026 17:08:31 +0200
Message-ID: <20261005150831.4831-1-fmancera@suse.de>
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
	NEURAL_HAM_LONG(-1.00)[-0.996];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Currently, check_iphdr() sets the transport header offset for all IPv4
packets, including later fragments that do not contain an L4 header.

Stop setting the transport header for non-first IPv4 fragments. This
leaves skb->transport_header at whatever value it had when the packet
entered OVS. That is only safe if no later code relies on it.

update_ip_l4_checksum() read the transport offset before checking for a
later fragment, so do the check first.

set_tcp(), set_udp() and set_sctp() had no such check. An IPv4 later
fragment keeps ip.proto set to the real protocol, and the flow may
wildcard the frag field, so validate_set() accepts these actions for it.
They then modified the start of the fragment payload as if it were an L4
header, corrupting the packet. Skip the actions for OVS_FRAG_TYPE_LATER,
as there is no L4 header to modify.

IPv6 later fragments are not affected, since their ip.proto is
NEXTHDR_FRAGMENT and validate_set() rejects L4 set actions for them.

Link: https://lore.kernel.org/netdev/59d32c37-6151-4649-97bf-bad050dc3f13@ovn.org/
Suggested-by: Ilya Maximets <i.maximets@ovn.org>
Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
Fixes: a175a723301a ("openvswitch: Add SCTP support")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
Note: since the data corruption issue was actually found by sashiko, I
suggest we still take this on net-next instead of net, this is just a
corner-case most users won't ever hit.

Sashiko: If you notice a similar problem at IPv6 path, we have fixed it
already in net tree, here is submission:

https://lore.kernel.org/netdev/20261002075255.5015-1-fmancera@suse.de/
---
 net/openvswitch/actions.c | 19 ++++++++++++++++---
 net/openvswitch/flow.c    |  9 +++++++--
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index dc5ff859f114..8556a5a74ccd 100644
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
@@ -590,6 +592,9 @@ static int set_udp(struct sk_buff *skb, struct sw_flow_key *flow_key,
 	__be16 src, dst;
 	int err;
 
+	if (flow_key->ip.frag == OVS_FRAG_TYPE_LATER)
+		return 0;
+
 	err = skb_ensure_writable(skb, skb_transport_offset(skb) +
 				  sizeof(struct udphdr));
 	if (unlikely(err))
@@ -633,6 +638,9 @@ static int set_tcp(struct sk_buff *skb, struct sw_flow_key *flow_key,
 	__be16 src, dst;
 	int err;
 
+	if (flow_key->ip.frag == OVS_FRAG_TYPE_LATER)
+		return 0;
+
 	err = skb_ensure_writable(skb, skb_transport_offset(skb) +
 				  sizeof(struct tcphdr));
 	if (unlikely(err))
@@ -658,11 +666,16 @@ static int set_sctp(struct sk_buff *skb, struct sw_flow_key *flow_key,
 		    const struct ovs_key_sctp *key,
 		    const struct ovs_key_sctp *mask)
 {
-	unsigned int sctphoff = skb_transport_offset(skb);
-	struct sctphdr *sh;
 	__le32 old_correct_csum, new_csum, old_csum;
+	unsigned int sctphoff;
+	struct sctphdr *sh;
 	int err;
 
+	if (flow_key->ip.frag == OVS_FRAG_TYPE_LATER)
+		return 0;
+
+	sctphoff = skb_transport_offset(skb);
+
 	err = skb_ensure_writable(skb, sctphoff + sizeof(struct sctphdr));
 	if (unlikely(err))
 		return err;
diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
index 1c4f3a079044..52cc63837445 100644
--- a/net/openvswitch/flow.c
+++ b/net/openvswitch/flow.c
@@ -189,6 +189,7 @@ static bool arphdr_ok(struct sk_buff *skb)
 static int check_iphdr(struct sk_buff *skb)
 {
 	unsigned int nh_ofs = skb_network_offset(skb);
+	const struct iphdr *nh;
 	unsigned int ip_len;
 	int err;
 
@@ -201,7 +202,10 @@ static int check_iphdr(struct sk_buff *skb)
 		     skb->len < nh_ofs + ip_len))
 		return -EINVAL;
 
-	skb_set_transport_header(skb, nh_ofs + ip_len);
+	nh = ip_hdr(skb);
+	if (!(nh->frag_off & htons(IP_OFFSET)))
+		skb_set_transport_header(skb, nh_ofs + ip_len);
+
 	return 0;
 }
 
@@ -898,7 +902,8 @@ static int key_extract_l3l4(struct sk_buff *skb, struct sw_flow_key *key)
  *    - skb->transport_header: If key->eth.type is ETH_P_IP or ETH_P_IPV6
  *      on output, then just past the IP header, if one is present and
  *      of a correct length, otherwise the same as skb->network_header.
- *      For other key->eth.type values it is left untouched.
+ *      For later IP fragments and for other key->eth.type values it is
+ *      left untouched.
  *
  *    - skb->protocol: the type of the data starting at skb->network_header.
  *      Equals to key->eth.type.
-- 
2.55.0

