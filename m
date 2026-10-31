Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.40
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793488499;
	b=EPDHju72Bf0u1HYhChJnb0qb6mcnaBH/tCZQfQnT6TLCPoqk0WVGBCn1WmgcDWucJjxG
	 CnaDZwkDctaKDwrFBUBdklXklOnfMbhKQ+7RRW+miB5tDciG+sypp0LXvrj24S1HMV8YL
	 T+xzliqOO+uuae+6OLSJkNffr5QBDl2teezXjzBMT6TJ5Aozvpfi1SUgPKhLcuk4YBLaL
	 caUC8nuG/KCihOe+pqwqEaTPZCZTZZL4ZUN4iHYwGe05cxgQTCT8pceZuMUJKHnVkFQi/
	 LaXKQ8MEZoLEx7VLNBj1UjXtLAEYFrM4ZfChk6vchIdfCu7W6VGnLTYHvuhMyfK6pBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793488499;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=6TaFZJxPOPZTRQ82YRI0Ny9DAKqeyrjaHJ9g7rMSaMk=;
	b=f24rNkSLmgjLGaOeMkWjPfcJK+S9wFUex5Eki7dJDFdB/eGgMuaDBEmbdZJi4GU8KAlb
	 TvSENdJCTyKj09A3ZkyOYRHCqwzANsxWhs4IE1MfSE4gPSykWmqA0ZBqLWaUoWYgZoBAU
	 zS8SXWU4X4V/4yEdR+DO9DEYeAddu9BWzbjdFb1yY1GVuC23n7ZrwGqF8rQGiFzMXfVpN
	 BYusOJ6foEMdpgWkJ/PtOZKnxC5gauBqgudUtG46rFh/CXSGdn6CVFTEyU0hEIl/Qv+1A
	 axOD9b6rclA+12sJLYOBDkoTWS+vILu2H/zV43xYpErE6R3CkteTUdT0w9d1fW1xWBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=ffJ6esQk;
	arc=none smtp.remote-ip=195.10.208.40
Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BAA606A31A
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 23:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8BAA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=ffJ6esQk
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4jHDMC4pB5zFqwY;
	Sun, 01 Nov 2026 00:14:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1793488487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6TaFZJxPOPZTRQ82YRI0Ny9DAKqeyrjaHJ9g7rMSaMk=;
	b=ffJ6esQkluZw/QvoWw73lBofsBeR8jD4okrHy8zRjyCen1/9KVXqHP2LMIQB0eOJVqoKhH
	SDOD26EHtohyjmsfY2mZamzF2CAEPTfgvb1dh77MeLvK4Ki7KFJq/tGHHdpuCFzgFpyzih
	oe0RXddsjT5jLMWzCrrYvCIaH+xPxab0tfcT4dsbUC0LTTaZ69XXuA2M7Cd78ckirYY+Lg
	kFA+oO03XWsr7WGvyuj5gnH5l+HTeELRRS7nU0na5OlCE2mIofFPToquItm08wyFuZmHZr
	0E044L/k8KTN13RIq90amkEJ5W2p9PXs1whWCUR8Fau0MXam+AqGwigfBdtL1w==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
From: Antonio Quartulli <antonio@mandelbit.com>
To: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com
Cc: Antonio Quartulli <antonio@mandelbit.com>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH net v3] tun: bound the NAPI receive queue
Date: Sun,  1 Nov 2026 00:14:36 +0100
Message-ID: <20261031231444.1528758-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.0
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
X-Rspamd-Queue-Id: 4jHDMC4pB5zFqwY

With IFF_NAPI, tun_get_user() queues every written packet for NAPI on
an unbounded list. When the poll runs asynchronously (threaded NAPI)
and is slower than the writer, the queue grows until the system runs
out of memory. An unprivileged user can do this from its own user and
network namespaces, and the queued skbs are not charged to its memcg:
in a test VM, a uid 1000 process limited to 128 MB caused a global OOM
in ~6 seconds. The socket send buffer cannot bound this: tun sets it to
INT_MAX, and the build_skb() and XDP batch paths do not check it.

Drop packets once more than netdev_max_backlog of them are queued, like
enqueue_to_backlog() does, and count them as rx_dropped: before
allocating and copying them where possible, and again under the queue
lock before queueing. This covers write(), sendmsg() and the batches of
XDP buffers vhost-net passes to tun_sendmsg(), which share the queue.
Zerocopy buffers of packets dropped early are completed.

Reproducer, as an unprivileged user in a new user and network
namespace, without kernel modifications or fault injection:
  ip tuntap add t0 mode tun; ip addr add 10.11.0.1/24 dev t0
  ip link add d0 type dummy; ip addr add 10.20.0.1/24 dev d0
  ip link set t0 up; ip link set d0 up; sysctl net.ipv4.ip_forward=1
  install ~500 iptables FORWARD rules and a MASQUERADE rule on d0
  open t0 with IFF_TUN | IFF_NO_PI | IFF_NAPI
  echo 1 > /sys/class/net/t0/threaded
  write() 1400-byte IPv4 packets for 10.20.0.2 in a loop

Tested with the reproducer in an x86-64 VM: memory use stays flat
and the forwarding rate is unchanged. The vhost-net paths are only
build-tested, and the kselftests have not been run yet.

Still open: the limit counts packets rather than bytes and applies per
queue, the NAPI poll splices the queue out while it runs so up to about
twice the limit can be in flight, and the queued skbs are still not
charged to the writer's memcg.

Found, fixed and tested with the help of an AI coding assistant
(Claude Code).

Fixes: 943170998b20 ("tun: enable NAPI for TUN/TAP driver")
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
v3:
- Also bound the sendmsg() paths, which share the queue: zerocopy
  buffers are completed when dropped early, and the batched XDP buffers
  of tun_xdp_one() are covered too (Willem)
- Drop the IFF_NAPI_FRAGS exclusion: tun_get_user() never queues in
  that mode (napi_gro_frags() is synchronous), so the early check only
  fires if tun_xdp_one() filled the same queue, and dropping is fine
  then too (Willem)
- Recheck under the queue lock before queueing (Willem)
- Compare with > like enqueue_to_backlog() (Willem)
- Keep the includes sorted (Willem)
- Add the reproducer and a testing statement to the commit message

v2: https://lore.kernel.org/netdev/20261030152540.1409884-1-antonio@mandelbit.com/
- Cc netdev and the maintainers

Notes:
- Affected since 943170998b20 (v4.15). Reproduced on mainline
  7be4bc52fd9e; the code is unchanged in net/main 94cea342e891, which
  this patch is based on and was build-tested (W=1) against.
- Mitigation: disallow unprivileged user namespaces or restrict
  access to /dev/net/tun.

 drivers/net/tun.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 770b8fe085c3..df5f0cbd1b16 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -58,6 +58,7 @@
 #include <linux/nsproxy.h>
 #include <linux/virtio_net.h>
 #include <linux/rcupdate.h>
+#include <net/hotdata.h>
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
 #include <net/rtnetlink.h>
@@ -227,6 +228,15 @@ struct veth {
 static void tun_flow_init(struct tun_struct *tun);
 static void tun_flow_uninit(struct tun_struct *tun);
 
+/* In IFF_NAPI mode written packets wait in the tfile's sk_write_queue for the
+ * NAPI poll, which may run later in a kthread or ksoftirqd. Bound that queue
+ * like the per-CPU backlog of netif_rx().
+ */
+static bool tun_napi_queue_full(const struct sk_buff_head *queue)
+{
+	return skb_queue_len_lockless(queue) > READ_ONCE(net_hotdata.max_backlog);
+}
+
 static int tun_napi_receive(struct napi_struct *napi, int budget)
 {
 	struct tun_file *tfile = container_of(napi, struct tun_file, napi);
@@ -1856,6 +1866,20 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 			zerocopy = true;
 	}
 
+	/* Drop before allocating and copying when the NAPI queue is full. The
+	 * check is repeated under the queue lock before queueing.
+	 */
+	if (tfile->napi_enabled &&
+	    unlikely(tun_napi_queue_full(&tfile->sk.sk_write_queue))) {
+		if (msg_control) {
+			struct ubuf_info *uarg = msg_control;
+
+			uarg->ops->complete(NULL, uarg, false);
+		}
+		dev_core_stats_rx_dropped_inc(tun->dev);
+		return total_len;
+	}
+
 	if (!frags && tun_can_build_skb(tun, tfile, len, noblock, zerocopy)) {
 		/* For the packet that is not easy to be processed
 		 * (e.g gso or jumbo packet), we will do it at after
@@ -2045,6 +2069,14 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 			goto free_skb;
 		}
 
+		if (unlikely(tun_napi_queue_full(queue))) {
+			spin_unlock_bh(&queue->lock);
+			rcu_read_unlock();
+			kfree_skb_reason(skb, SKB_DROP_REASON_FULL_RING);
+			dev_core_stats_rx_dropped_inc(tun->dev);
+			return total_len;
+		}
+
 		__skb_queue_tail(queue, skb);
 		queue_len = skb_queue_len(queue);
 		spin_unlock(&queue->lock);
@@ -2649,6 +2681,13 @@ static int tun_xdp_one(struct tun_struct *tun,
 			return -EBUSY;
 		}
 
+		if (unlikely(tun_napi_queue_full(queue))) {
+			spin_unlock(&queue->lock);
+			kfree_skb_reason(skb, SKB_DROP_REASON_FULL_RING);
+			dev_core_stats_rx_dropped_inc(tun->dev);
+			return 0;
+		}
+
 		__skb_queue_tail(queue, skb);
 		spin_unlock(&queue->lock);
 		ret = 1;
-- 
2.56.0

