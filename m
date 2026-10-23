Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792745077;
	b=iFY1nSZWu9JkccWiILd/oBLUvftEuBGGXrcXc3hRdfWIjdWGtXfN88Vcqru/DyD+ry+u
	 73u8Gwpc7zvPBSuy0wn6IsFLEIjldCL2wO4jzshRypzZGKWZlkIEXyQSCUEU4q0E6PEFt
	 msVPfSnXz4Wbnl9oYREz731NBkLZZClQAfQBjTL6f45vyNvM2g7qjQb5ojOk0ewyyelbc
	 VMaWk5NJN5SVylxHmOhzml04UYodwMK/1KFJwIDi9cYOb75TWjCZx+FeQxWT+X6kaoDe8
	 cQsN3jFwvl4RCu+dcZqDtb6NxJZ1RUDVcpByaRP2QLIDKTdSp/aX7F4jB6xfaC+9zSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792745077;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=UScnVTA48/9N0/q8geSQdYaErbbmVJfcMv3/8Ch/hxY=;
	b=xhyQHCSDfeekhdFHuAzJ8xCUR3DB1pfy3vOh9X5noj3jInaV4nG127jCWhEGi876kDG+
	 EdyOcJIB3EDtTvY/u/xmOu5pOPmz/gTjiPnnNK4NQnO8uhQTkf7thU7mEcSBR7N/nEyS4
	 saiUZUOf1yFPO0oNR+vPDWkQv/4b3PeeLAQLYJ7MnRQVgnOutq6b+jltj8yFQvKRLTUfr
	 BIEbxlCSTbf2pPpPMWRlTnvIfs1vZuc6OJizb7RfX3p9FYjFTqawr105F1wNqcin3XdVb
	 1zDM6JlGwZHz+D+W6tEtjOKl9KHcQC+ExWQfut+uWZ9KixRdBBsetERV6d3mBi/J0oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZP1dOoe6;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7165606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7165606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZP1dOoe6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792745075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UScnVTA48/9N0/q8geSQdYaErbbmVJfcMv3/8Ch/hxY=;
	b=ZP1dOoe64rVsUcwkfPn0LmpkKPnaetvxHuwBgHKFlkTpZn1qxDjeNi7CqpLP14HH8GCYLw
	gs0rf3EwMNi0OMadZRN4SpoL88gY+OvTJIufPeBLo0xEr/BCPb7ta9gtktj2RJ2xPp2zYr
	DyKF7M/4FKXPZNLgR/1Lms6n9nHDoEE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-twH5tx3SOLWcoVn3nki2AQ-1; Fri,
 23 Oct 2026 04:44:29 -0400
X-MC-Unique: twH5tx3SOLWcoVn3nki2AQ-1
X-Mimecast-MFC-AGG-ID: twH5tx3SOLWcoVn3nki2AQ_1792745067
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E67BD180074A;
	Fri, 23 Oct 2026 08:44:26 +0000 (UTC)
Received: from pabeni-thinkpadp1gen8.rmtit.csb (unknown [10.44.32.68])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F34361800643;
	Fri, 23 Oct 2026 08:44:22 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	osmocom-net-gprs@lists.osmocom.org
Subject: [PATCH net] gtp: hold RCU in gtp_genl_send_echo_req()
Date: Fri, 23 Oct 2026 10:44:09 +0200
Message-ID: <ed27d133fe73afd377d3fa4e553c34e7987b6dd9.1792744478.git.pabeni@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Such function is invoked in process context, performs an RCU device
lookup and dereference the found device with no additional protection.

  =============================
  WARNING: suspicious RCU usage
  7.3.0-virtme #7 Not tainted
  -----------------------------
  net/core/dev.c:1047 RCU-list traversed in non-reader section!!

  other info that might help us debug this:

  rcu_scheduler_active = 2, debug_locks = 1
  locks held by python3/233: 2, last CPU#5:
   #0: ffffffffbab93268 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40
   #1: ffffffffbab93320 (genl_mutex){+.+.}-{4:4}, at:
                                                genl_rcv_msg+0x12c/0x160

  stack backtrace:
  CPU: 5 UID: 0 PID: 233 Comm: python3 Not tainted 7.3.0#7 PREEMPT(full)
  Hardware name: Bochs, BIOS Bochs 01/01/2011
  Call Trace:
   <TASK>
   dump_stack_lvl+0x6f/0xb0
   lockdep_rcu_suspicious.cold+0x37/0x8e
   dev_get_by_index_rcu+0x135/0x180
   gtp_find_dev+0xe7/0x360 [gtp]
   gtp_genl_send_echo_req+0x298/0xb30 [gtp]
   genl_family_rcv_msg_doit+0x20f/0x310
   genl_family_rcv_msg+0x3a8/0x640
   genl_rcv_msg+0xbb/0x160
   netlink_rcv_skb+0x154/0x3a0
   genl_rcv+0x28/0x40
   netlink_unicast+0x54b/0x860
   netlink_sendmsg+0x7fb/0xf60
   __sys_sendto+0x3d6/0x450
   __x64_sys_sendto+0xe4/0x1f0
   do_syscall_64+0xff/0x530
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  RIP: 0033:0x7ffa43b0256e
  Code: 4d 89 d8 e8 d4 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83
   f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39
   83 fa 08 75 e7 e8 03 ff ff ff 0f 1f 00 f3 0f 1e fa
  RSP: 002b:00007ffd3b8828d0 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
  RAX: ffffffffffffffda RBX: 00007ffd3b8829e0 RCX: 00007ffa43b0256e
  RDX: 0000000000000034 RSI: 00007ffa3519d0d0 RDI: 0000000000000006
  RBP: 00007ffd3b8828e0 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffa351cc0c0
  R13: 00007ffd3b8829e0 R14: 00007ffa354ca130 R15: 00007ffa4433d498
   </TASK>

Add the missing RCU guards and keep it for the whole function body,
while the RCU-protected device is used.

Found by code inspection, validated explicitly testing the relevant
code path.

Fixes: d33bd757d362 ("gtp: Implement GTP echo request")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/gtp.c | 44 ++++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 15b5d845fc3b..86c8c88b702c 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -2355,9 +2355,9 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 	struct gtp_dev *gtp;
 	struct flowi4 fl4;
 	struct rtable *rt;
+	int len, ret = 0;
 	struct sock *sk;
 	__be16 port;
-	int len;
 
 	if (!info->attrs[GTPA_VERSION] ||
 	    !info->attrs[GTPA_LINK] ||
@@ -2369,14 +2369,21 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 	dst_ip = nla_get_be32(info->attrs[GTPA_PEER_ADDRESS]);
 	src_ip = nla_get_be32(info->attrs[GTPA_MS_ADDRESS]);
 
+	rcu_read_lock();
 	gtp = gtp_find_dev(sock_net(skb->sk), info->attrs);
-	if (!gtp)
-		return -ENODEV;
+	if (!gtp) {
+		ret = -ENODEV;
+		goto unlock;
+	}
 
-	if (!gtp->sk_created)
-		return -EOPNOTSUPP;
-	if (!(gtp->dev->flags & IFF_UP))
-		return -ENETDOWN;
+	if (!gtp->sk_created) {
+		ret = -EOPNOTSUPP;
+		goto unlock;
+	}
+	if (!(gtp->dev->flags & IFF_UP)) {
+		ret = -ENETDOWN;
+		goto unlock;
+	}
 
 	if (version == GTP_V0) {
 		struct gtp0_header *gtp0_h;
@@ -2385,8 +2392,10 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 			sizeof(struct iphdr) + sizeof(struct udphdr);
 
 		skb_to_send = netdev_alloc_skb_ip_align(gtp->dev, len);
-		if (!skb_to_send)
-			return -ENOMEM;
+		if (!skb_to_send) {
+			ret = -ENOMEM;
+			goto unlock;
+		}
 
 		sk = gtp->sk0;
 		port = htons(GTP0_PORT);
@@ -2402,8 +2411,10 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 			sizeof(struct iphdr) + sizeof(struct udphdr);
 
 		skb_to_send = netdev_alloc_skb_ip_align(gtp->dev, len);
-		if (!skb_to_send)
-			return -ENOMEM;
+		if (!skb_to_send) {
+			ret = -ENOMEM;
+			goto unlock;
+		}
 
 		sk = gtp->sk1u;
 		port = htons(GTP1U_PORT);
@@ -2413,7 +2424,8 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 		memset(gtp1u_h, 0, sizeof(struct gtp1_header_long));
 		gtp1u_build_echo_msg(gtp1u_h, GTP_ECHO_REQ);
 	} else {
-		return -ENODEV;
+		ret = -ENODEV;
+		goto unlock;
 	}
 
 	rt = ip4_route_output_gtp(&fl4, sk, dst_ip, src_ip);
@@ -2421,7 +2433,8 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 		netdev_dbg(gtp->dev, "no route for echo request to %pI4\n",
 			   &dst_ip);
 		kfree_skb(skb_to_send);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto unlock;
 	}
 
 	local_bh_disable();
@@ -2435,7 +2448,10 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 				    dev_net(gtp->dev)),
 			    false, 0);
 	local_bh_enable();
-	return 0;
+
+unlock:
+	rcu_read_unlock();
+	return ret;
 }
 
 static const struct nla_policy gtp_genl_policy[GTPA_MAX + 1] = {
-- 
2.56.0

