Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD1F23EAA6
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787650893; cv=none; b=pcKXgef7rKFUnPHfrxq65wNyUBqqldnCQUYW7ySpBy5uXtk6uWCdRlZYYnwKRD4wy/qF7akaq5PxsbjLi16soW9UJcM96hEcqGU4wV/vDu8QPdmynj8u90HuUqrr4I488ud3JaM6G1axaob3rTa5Tofx9Ftjgg4CIvggtVGeTq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787650893; c=relaxed/simple;
	bh=UjXta4/qBzNdjtnUmPdRD+qgROJ+TLF0pMSC3UgKxRo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cjw5xqU5FtXdYLdfuLwAb99wJLRzQEmfSLxk49gXZ1WwQ6wnUB5a4+ayaOYOKmtDW/+NYapR8uP/pQaA2/f+W5FBtb9fJ6ZD3mMNFglE/iIrETwfKh0ChMY3QZtKUWpKf3Gf3egzvyF9AbgATnJ91l2VWbyTiyMRe/uA3nN+3co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WXkWr5ow; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WXkWr5ow"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mk7nOAf+e/FaROUlTpjPV2bCZtnbby00JME7ZoGRdjo=;
	b=WXkWr5owgrpDitcpgeAa6HQ9gycStvSusa5wwIw+VGkmuNUX66oGX+Ch62Hl2hBd/sc0Q9OR7
	PI6ji8SDKIeync3JXAmOONwdSyLumEBM9LPN7vXlNnuWHIAlPCS6L+bPD91AWkSQx/g5vPQgnY+
	qREC+A3Ro3WN+HPnZCgUkgI=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hTjF75QZfzRhR0;
	Tue, 25 Aug 2026 17:30:35 +0800 (CST)
Received: from whupemk200012.china.huawei.com (unknown [7.152.185.169])
	by mail.maildlp.com (Postfix) with ESMTPS id CE40340538;
	Tue, 25 Aug 2026 17:41:18 +0800 (CST)
Received: from localhost.localdomain (10.50.85.175) by
 whupemk200012.china.huawei.com (7.152.185.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 17:41:17 +0800
From: Dong Chenchen <dongchenchen2@huawei.com>
To: <pablo@netfilter.org>, <laforge@gnumonks.org>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <dsahern@kernel.org>, <kees@kernel.org>, <netdev@vger.kernel.org>,
	<osmocom-net-gprs@lists.osmocom.org>, <zhangchangzhong@huawei.com>, Dong
 Chenchen <dongchenchen2@huawei.com>,
	<syzbot+83181a31faf9455499c5@syzkaller.appspotmail.com>
Subject: [PATCH net v2] net: iptunnel: fix stale transport header during tunnel decapsulation
Date: Tue, 25 Aug 2026 17:50:00 +0800
Message-ID: <20260825095000.1461124-1-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 whupemk200012.china.huawei.com (7.152.185.169)

Syzbot reported a crash in qdisc_pkt_len_segs_init() caused by a stale
transport_header offset after tunnel decapsulation.

BUG: unable to handle page fault for address: ffffed102091a42e
Oops: Oops: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 340 Comm: qdisc_uaf_repro Not tainted 7.2.0-rc4-00061-g248951ddc14d #256 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:__asan_load2
<IRQ>
qdisc_pkt_len_segs_init (net/core/dev.c:4145)
__dev_queue_xmit (net/core/dev.c:4787)
br_dev_queue_push_xmit (net/bridge/br_forward.c:53)
br_handle_frame_finish (net/bridge/br_input.c:229)
br_handle_frame (net/bridge/br_input.c:315)
__netif_receive_skb_core.constprop.0 (net/core/dev.c:6099)
__netif_receive_skb_list_core (net/core/dev.c:6287)
netif_receive_skb_list_internal (net/core/dev.c:6445)
napi_complete_done (net/core/dev.c:6813)
gro_cell_poll (net/core/gro_cells.c:74)
__napi_poll (net/core/dev.c:7735)
net_rx_action (net/core/dev.c:7798 net/core/dev.c:7955)
handle_softirqs (kernel/softirq.c:622)
do_softirq (kernel/softirq.c:523  kernel/softirq.c:510 )
__local_bh_enable_ip (kernel/softirq.c:450)
tun_get_user (drivers/net/tun.c:1986 (discriminator 1))
tun_chr_write_iter (drivers/net/tun.c:2032)

The issue is completely latent until qdisc read transport header in
commit 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()").
The crash requires four conditions to line up:

1. The incoming packet is encapsulated and carries GSO metadata. The outer
   transport header offset is stored in skb->transport_header while the
   packet is still in the outer tunnel context.
2. The tunnel receiver strips the outer headers. skb->data is advanced to
   the inner frame, but skb->transport_header is left pointing to the
   now-removed outer L4 header, so it becomes a negative offset relative to
   the new data.
3. The inner frame is not delivered to the local IP stack. Instead, it
   is forwarded at L2 by a bridge or HSR, so ip_rcv_core() never runs and
   the transport header is not reset to the inner L4 offset.
4. The forwarding path calls __dev_queue_xmit(), which enters
   qdisc_pkt_len_segs_init(). That function computes the GSO header length
   from skb_transport_offset(skb). Because the offset is negative, the
   unsigned cast overflows and pskb_may_pull(skb, hdr_len +
   sizeof(struct tcphdr)) reads past the end of the skb, triggering a
   KASAN fault or page fault.

The issue specifically requires GSO packets (shinfo->gso_size != 0), which
are processed/aggregated through gro_cells. Fix this by clearing
transport_header to the ~0U sentinel in gro_cell for all tunnnel driver.
GTP does not support GRO/GSO, drop the evil GSO packets in GTP directly.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+83181a31faf9455499c5@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69de2bee.a00a0220.475f0.0041.GAE@google.com/T/
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
---
 drivers/net/gtp.c      | 5 +++++
 include/linux/skbuff.h | 5 +++++
 net/core/gro_cells.c   | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 9a12cc53da00..fbf617b1acc9 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -312,6 +312,11 @@ static int gtp_inner_proto(struct sk_buff *skb, unsigned int hdrlen,
 static int gtp_rx(struct pdp_ctx *pctx, struct sk_buff *skb,
 		  unsigned int hdrlen, unsigned int role, __u16 inner_proto)
 {
+	if (skb_is_gso(skb)) {
+		netdev_dbg(pctx->dev, "GSO is not support in GTP\n");
+		goto err;
+	}
+
 	if (!gtp_check_ms(skb, pctx, hdrlen, role, inner_proto)) {
 		netdev_dbg(pctx->dev, "No PDP ctx for this MS\n");
 		return 1;
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 22eda1d54a0e..626bbb9bae1a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3082,6 +3082,11 @@ static inline bool skb_transport_header_was_set(const struct sk_buff *skb)
 	return skb->transport_header != (typeof(skb->transport_header))~0U;
 }
 
+static inline void skb_unset_transport_header(struct sk_buff *skb)
+{
+	skb->transport_header = (typeof(skb->transport_header))~0U;
+}
+
 static inline unsigned char *skb_transport_header(const struct sk_buff *skb)
 {
 	DEBUG_NET_WARN_ON_ONCE(!skb_transport_header_was_set(skb));
diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
index 1b84385c04bd..d8c0a2867120 100644
--- a/net/core/gro_cells.c
+++ b/net/core/gro_cells.c
@@ -22,6 +22,8 @@ int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb)
 	if (unlikely(!(dev->flags & IFF_UP)))
 		goto drop;
 
+	skb_unset_transport_header(skb);
+
 	if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)) {
 		res = netif_rx(skb);
 		goto unlock;
-- 
2.25.1

