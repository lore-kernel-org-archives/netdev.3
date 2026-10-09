Received: from mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09D7319617
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 04:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791518678; cv=none; b=JsJXbJLy/YTGM9YX0qHVC1FrdgJWha2aAza6RWu+jvUsdrI8vkfT87exW7o7qi3/5qU0T5GZTFxQMZyVaSJbiuHM/ooHRZNSDD5pzXVKsnVspGJ4wUZB4DqT52mkQi7frRqF3/0b+Pn923evRjzSL8ito6k6vFr9g2AFf7Eq25I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791518678; c=relaxed/simple;
	bh=Z7RiTtE42xGkm5ICBWHZS4V6+TbhG48J/FLHp2qlIkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LCqVtDUHjQJeiKgMIn5akvRGGD7nTra/xw2vhhLzNhVjxJOJyWWgk5BvQ28Fk1ZNChJ3KfekQUJy5kkCCnK0dn2wh/oA92cK5+5YSCXiHVT7oYTPiv9AQcOQf3E/ND14n4n1r1Qu7Tim/VFVNuQVfz1NM2iPkxeNPlo5+z9xblI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EEO8+Ht+; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EEO8+Ht+"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Z7RiTtE42xGkm5ICBWHZS4V6+TbhG48J/FLHp2qlIkU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791518665; v=1; x=1792123465;
 b=EEO8+Ht+zCMNvw4eQaOCAWi0dAv7kSLM/pXCBxL3kUaxm5lc+c1JuYYxIiWbhKZr7ExEe7IO
 HKyrlviL+SCkljkFF12R8YlB+tG12KjQ+d0ZzMZ2NRk4K6mjQ00Cbl01sK3UvSAnlyLetyiRu5N
 XcyWIIKKpaciV1uNWjotTWhU=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bcc70195f2016f7a;
	Fri, 09 Oct 2026 04:04:25 +0000
X-Mizu-Trace-ID: bcc70195f2016f7a
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Toshiaki Makita <toshiaki.makita1@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] veth: clear rx queue hint in veth_xmit
Date: Fri,  9 Oct 2026 12:04:11 +0800
Message-ID: <20261009040412.14571-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With more tx queues on one end of a veth pair than rx queues on the
other, and RPS or generic XDP enabled on the receiving end, we get:

    veth1 received packet on queue 2, but number of RX queues is 2
    WARNING: net/core/dev.c:5212 at get_rps_cpu+0x560/0x1360
    Call Trace:
     <TASK>
     netif_rx_internal+0x1af/0x4c0
     __netif_rx+0x99/0x350
     veth_xmit+0x713/0xca0
     dev_hard_start_xmit+0x166/0x5f0
     __dev_queue_xmit+0x1797/0x42d0
     ip_finish_output2+0xa34/0x1f40
     __ip_finish_output+0x510/0x7e0
     ip_finish_output+0x2f/0x320
     ip_output+0x17a/0x3f0
     ip_send_skb+0x1bc/0x220
     ......

Easy to hit with "ethtool -L veth0 tx 4", "ethtool -L veth1 rx 2",
rps_cpus set on veth1 and a few flows sent over the pair [1].

veth_xmit() uses skb->queue_mapping to pick the peer rq, but never
clears it before veth_forward_skb(), so the rx side still sees the tx
queue index. Everything on the rx side that goes through
skb_get_rx_queue(), like get_rps_cpu() and netif_get_rxqueue() for
generic XDP, takes it as a recorded rx queue and warns once it is out
of range.

Clear it before handing the skb to the peer:

- It is the tx queue index of this device, it says nothing about the
  rx queue of the peer.

- The two sides don't even agree on the encoding. The tx side stores
  the index as is, the rx side stores index + 1 so that 0 can mean
  "not recorded". So tx queue k is read back as rx queue k - 1, and
  tx queue 0 as "not recorded".

- Commit 710ad98c363a ("veth: Do not record rx queue hint in
  veth_xmit") already decided that veth should not pass any queue
  hint to the peer. There is no tx->rx queue mapping to preserve, so
  nothing is lost by clearing it.

On NETDEV_TX_BUSY the skb goes back to the qdisc, which looks up the
txq from skb->queue_mapping to decide when to retry, so restore it
there, next to the existing __skb_push().

[1]: https://lore.kernel.org/netdev/156834bb-8e40-496e-9443-9d515fa18eab@linux.dev/

Fixes: 710ad98c363a ("veth: Do not record rx queue hint in veth_xmit")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
Target net-next since it is moderate.
Full reproducer, veth1 lives in netns ns1:

  ip netns add ns1
  ip link add veth0 type veth peer name veth1
  ip link set veth1 netns ns1
  ethtool -L veth0  tx 4
  ip netns exec ns1 ethtool -L veth1 rx 2
  ip netns exec ns1 sh -c  'echo f > /sys/class/net/veth1/queues/rx-0/rps_cpus'
  ip addr add 10.9.9.1/24 dev veth0
  ip link set veth0 up
  ip netns exec ns1 ip addr add 10.9.9.2/24 dev veth1
  ip netns exec ns1 ip link set veth1 up
  for i in $(seq 200); do echo hi > /dev/udp/10.9.9.2/9999; done
---
 drivers/net/veth.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 71227d0389aa..7d181c5e387b 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -377,6 +377,9 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	skb_tx_timestamp(skb);
 
+	/* tx queue index of this device, meaningless as rx queue of the peer */
+	skb_set_queue_mapping(skb, 0);
+
 	ret = veth_forward_skb(rcv, skb, rq, use_napi);
 	switch (ret) {
 	case NET_RX_SUCCESS: /* same as NETDEV_TX_OK */
@@ -397,6 +400,8 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 		/* Restore Eth hdr pulled by dev_forward_skb/eth_type_trans */
 		__skb_push(skb, ETH_HLEN);
+		/* qdisc requeues the skb on the txq it points to */
+		skb_set_queue_mapping(skb, rxq);
 		netif_tx_stop_queue(txq);
 		/* Makes sure NAPI peer consumer runs. Consumer is responsible
 		 * for starting txq again, until then ndo_start_xmit (this
-- 
2.43.0

