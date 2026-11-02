Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606087;
	b=O+U+J0uds1PpQQNdct9JukleeVS/MPSXr8XKk3DzB/Mwuck+zVtcXTM0Zc6DTYxZRNK7
	 bCv6+HNZG2oSsjxpjsVobQj5pfisvYcp8jB06ZYiDPty+6AZkBGBIDAHosMtyG1ScfhaD
	 1soVMKvets9qH/fTgg9mCxnmROKUYFPea2tT+iOe2u6o9x0VBHIVZrvP0AEQvujgUe9rS
	 Q3ThxrgKWGre/zR/DJmJkphzgQdgmQS4hfh5YQOzieVomDzRrXC/XG3qDAg4CNaY/xGmh
	 kVCk5STPp1j485OFwTSIZ01aNM2ylwTExouvPXbbogNd71EVA/SfqNSSiWehFUk4JjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606087;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=F+vRhjkQdcZ/D8AthEQfi6ZgjFSfPqu3F702UwA7h2k=;
	b=rOBeqQYXDEu+Ykg72uv8yhL4D9Dm4uEpBJEr0p+zm1HGijae57OnJoYuvw8t6Keq7442
	 +vIEopMH944X7M/9sO/RoP0vQ72t4adIgyP3vqHQocSckEcOU6lki2KwnGG1SDfJPQtbP
	 r5RUziJ+4pbHuUqcuaXppZK9crIafZR5gHWMctv8heX3taP8jJS+EW4eEtrs9oYrFcbRg
	 LtzLAZyYT6J7lXci/X29FH9CRAY3Uhmekecjx2/xnrG41Ks4ZpBDg3HtQeof/X+8BZeHJ
	 p0jDq2/SYoUl2IXrs4b3ybiS2AH/1GfvxhdpMB+M98wqFqDafkKdPhbtKuqi0PK2e/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=btOUhfIO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0D7606A33E
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 07:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=btOUhfIO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572A71F00A25;
	Mon,  2 Nov 2026 07:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793606087;
	bh=F+vRhjkQdcZ/D8AthEQfi6ZgjFSfPqu3F702UwA7h2k=;
	h=From:To:Cc:Subject:Date;
	b=btOUhfIOG1AtvMd/t4IOBWGydN9leKK3vFEdiIfqCstbzoVDXxTsV9o090kzWbBRS
	 ioMRPWRn2TaBmLNYJT7p6OgjIiPXMCWu2nEKR6Fm3U+s6iDvOqd/PxoF1IQLdavqa4
	 obUoyYZMRyTCtmju3wWMq7eQiTrvUfrxGj3S4KAdYT/xV4HD94CjEOChWhClv+c6CS
	 k+/93x7v7qcnpdobfCzeegvgZjjZyQnAe9mdIRGpA963OOx+zbyYwM/ls0iZZeQt5y
	 Xp1GPAETh0048PkRIrF7AmXDpSe/SZgFJjnhrGABAJpP2cQcdiiBFQiwaSmCsGsFtg
	 lJ3CVmg3mV3Ww==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Anvik Loitongbam <permissiontogallop@gmail.com>,
	Yingjie Wang <x-professor@outlook.com>
Subject: [PATCH net] tcp: ipv6: do not read ireq->pktopts from tcp_v6_send_synack()
Date: Mon,  2 Nov 2026 08:54:41 +0100
Message-ID: <20261102075441.3771550-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
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

When IPV6_FL_F_REFLECT is set on a listener, or the
net.ipv6.flowlabel_reflect sysctl has FLOWLABEL_REFLECT_ESTABLISHED,
tcp_v6_send_synack() reflects the flowlabel of the SYN packet,
reading it from the skb stored in ireq->pktopts.

Since commit 079096f103fa ("tcp/dccp: install syn_recv requests
into ehash table"), request sockets are processed without holding
the listener lock. A cpu can then process a retransmitted SYN for a
request socket, and send a SYNACK from tcp_check_req(), while another
cpu receives the ACK completing the 3WHS. tcp_v6_syn_recv_sock()
consumes ireq->pktopts when it wins the hashdance, and the first cpu
reads a freed skb:

  BUG: KASAN: slab-use-after-free in tcp_v6_send_synack (include/linux/skbuff.h:3152 include/linux/ipv6.h:110 net/ipv6/tcp_ipv6.c:582)
  Read of size 8 at addr ffff88802b08b608 by task poc-ipv6-pktopt/5076

  Call Trace:
   <IRQ>
   tcp_v6_send_synack (include/linux/skbuff.h:3152 include/linux/ipv6.h:110 net/ipv6/tcp_ipv6.c:582)
   tcp_rtx_synack (net/ipv4/tcp_output.c:4719)
   tcp_check_req (net/ipv4/tcp_minisocks.c:762)
   tcp_v6_rcv (net/ipv6/tcp_ipv6.c:1826)
   ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:479)
   ip6_input_finish (net/ipv6/ip6_input.c:534)
   ip6_input (include/linux/netfilter.h:325 include/linux/netfilter.h:319 net/ipv6/ip6_input.c:545)
   ipv6_rcv (include/net/dst.h:481 net/ipv6/ip6_input.c:119 include/linux/netfilter.h:325 include/linux/netfilter.h:319 net/ipv6/ip6_input.c:351)

  Freed by task 5074 on cpu 0 at 15.412249s:
   kmem_cache_free (include/linux/kasan.h:235 mm/slub.c:2780 mm/slub.c:6630 mm/slub.c:6757)
   tcp_v6_syn_recv_sock (net/ipv6/tcp_ipv6.c:1528)
   tcp_check_req (net/ipv4/tcp_minisocks.c:934)
   tcp_v6_rcv (net/ipv6/tcp_ipv6.c:1826)
   ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:479)
   ip6_input_finish (net/ipv6/ip6_input.c:534)

Request socket migration has the same issue: reqsk_migrate_reset()
transfers ireq->pktopts to the clone, which can be freed while
another cpu holding a reference on the old request socket is still
sending a SYNACK.

The SYNACK timer itself is not an issue, because
inet_csk_reqsk_queue_drop() calls timer_delete_sync().

Save the flowlabel of the SYN in the request socket instead, so that
tcp_v6_send_synack() no longer needs ireq->pktopts.

As a side effect, the flowlabel is also reflected for SYN packets
reusing a TIME_WAIT socket, as ireq->pktopts is not set in this case.

Fixes: e994b2f0fb92 ("tcp: do not lock listener to process SYN packets")
Fixes: 079096f103fa ("tcp/dccp: install syn_recv requests into ehash table")
Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
Reported-by: Anvik Loitongbam <permissiontogallop@gmail.com>
Reported-by: Yingjie Wang <x-professor@outlook.com>
Closes: https://lore.kernel.org/netdev/82c31e4d5043f3dbd11b44177cfba779d335aae3.1793599929.git.x-professor@outlook.com/
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
Initially reported to security@ mailing list by Anvik Loitongbam, with a patch.
Anvik Loitongbam provided a reproducer.
I was able to trigger the ASAN warning before the patch, and checked
the warning can no longer trigger.

Yingjie Wang also sent a public patch later, very similar to Anvik's one.

 include/linux/tcp.h | 3 +++
 net/ipv6/tcp_ipv6.c | 5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index d18f7bc1e5d0f73c1c7452fbc573fa7cb38b206f..5a4c61fc240ec2d4554795cea7bbd65bbea0ef02 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -179,6 +179,9 @@ struct tcp_request_sock {
 	u8				ao_rcv_next;
 	bool				used_tcp_ao;
 #endif
+#if IS_ENABLED(CONFIG_IPV6)
+	__be32				syn_flowlabel;
+#endif
 };
 
 #define tcp_rsk(ptr) container_of_const(ptr, struct tcp_request_sock, req.req)
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index e006a30360eae1b43a4d53173b46b931ae668825..d406cd3c8ceabfdbb66f3e1b4f9e9a74754e8d0b 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -578,8 +578,8 @@ static int tcp_v6_send_synack(const struct sock *sk, struct dst_entry *dst,
 				    &ireq->ir_v6_rmt_addr);
 
 		fl6->daddr = ireq->ir_v6_rmt_addr;
-		if (inet6_test_bit(REPFLOW, sk) && ireq->pktopts)
-			fl6->flowlabel = ip6_flowlabel(ipv6_hdr(ireq->pktopts));
+		if (inet6_test_bit(REPFLOW, sk))
+			fl6->flowlabel = tcp_rsk(req)->syn_flowlabel;
 
 		tclass = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_reflect_tos) ?
 				(tcp_rsk(req)->syn_tos & ~INET_ECN_MASK) |
@@ -789,6 +789,7 @@ static void tcp_v6_init_req(struct request_sock *req,
 	ireq->ir_v6_loc_addr = ipv6_hdr(skb)->daddr;
 	ireq->ir_rmt_addr = LOOPBACK4_IPV6;
 	ireq->ir_loc_addr = LOOPBACK4_IPV6;
+	tcp_rsk(req)->syn_flowlabel = ip6_flowlabel(ipv6_hdr(skb));
 
 	/* So that link locals have meaning */
 	if ((!sk_listener->sk_bound_dev_if || l3_slave) &&
-- 
2.53.0

