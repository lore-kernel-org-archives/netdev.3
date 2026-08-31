Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE3837646E
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158114; cv=none; b=kiKz1lr/ia5V+OyJflDtVLf9ltjTb5JyCoGV7ZsM80YWGDDvxeq71MzQiwTIv9Kd+BNHfTtxkQskNUN6dwZi/ny6/ER2nUwG/J/sp0WPTLdFq0saR6gHM9a3xveHJi0QRBAu9IlIFgX8UcPVYytaowDhTBI+ch5K+24b4tyD3EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158114; c=relaxed/simple;
	bh=GsgnByecsVce4mWaCb/ClIjWWFX9UtnppJg3RAxeMjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sZe4MD39wDHkxjvtJIQuTqk5PlVxfZsCXTHcmboYH8l1ErUXR1lk8i51Z/i25bm3rz0plAdkC454aMyZhN7HADBhBY/My1aRN8ornEdYNUu64EP7Yzhvku58bYPBh7pJDa1DCUjcTz8DQNd8tqqJvA8D0mUluOKjRrj6q3EobfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVtNFBiK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVtNFBiK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249A61F000E9;
	Mon, 31 Aug 2026 06:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788158111;
	bh=LZShA9nvFEUGY7cZN/IXhVgQZQC4A6F3eTnN5SwEff4=;
	h=From:Date:Subject:To:Cc;
	b=EVtNFBiKlR6VfpQAoOTc0EeWsdbjHDZss24cYENgtmDs0TQlqwUvdEpnxNr7BTBfq
	 ijuKKBCWr3Dzvp1wSZ2LTIjY2/+GsPRrUoBjtLmJ9ijIyIvaL1Aj2dqW2gomQW+rlY
	 t3xQ/n+FkARw1BeSQNMKAMjyobCZzhHJdD5vaAjhQinFPAATHeC7V7gZM/jYAPfMGY
	 LmNSOtqjOL/drvIRevA2RjGocK949LPJZZqRIBoo11bjbOT49rq/aLyjuHNtVKRfc/
	 n5TRLNw3XeZQuwEAXwgB7VOaaR9MES+dKTKat1TkcB6NGL/qssUaCafjV1csYHHZbW
	 Eb0eGSKqIDrRw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 31 Aug 2026 08:34:57 +0200
Subject: [PATCH net-next v5] net: airoha: add HW GRO offload support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-airoha-eth-lro-v5-1-6b0f50401121@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WQ22rDMAxAf6X4eQ7yJXHcp/7H6IMvSmOWxpudh
 Y6Sf5+blwWSIRAIcXQkPUnGFDCT8+lJEs4hhziWon47Edeb8YY0+FITDryBmgM1IcXeUJx6OqR
 ITe2ZE41gLWOkQJ8Ju/BYB76TESc64mMi19LpQ55i+llNM1v7/w2dGS3BtXNCqKZBffnANOJQx
 XR7SVauxCEHaB1aQNM5seVeO8x8693zvPBcIjcalRFaHXoZHHK1tKi11Yb7eucVW2+740XhvQf
 tWGcBAI+8SsAhV36vG+FBtri/V/55W1A7Xq5/9oyhs0p5eYk5V1/fZnDxfq9KItdlWX4BXZSz/
 CUCAAA=
X-Change-ID: 20260520-airoha-eth-lro-a5d1c3631811
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, Madhur Agrawal <madhur.agrawal@airoha.com>
X-Mailer: b4 0.14.3

Add hardware GRO offload support to the airoha_eth driver, leveraging
the EN7581/AN7583 SoC's 8 dedicated LRO hardware queues mapped to RX
queues 24-31. HW GRO offloading does not support Scatter-Gather (SG) so
it is required to increase the page_pool allocation order to 2 for RX
queues 24-31 (LRO queues).
Since HW GRO is configured per-QDMA and shared across all devices using
it, HW GRO is mutually exclusive with multiple devices bound to the
same QDMA block. Call airoha_update_netdev_features() in
airoha_dev_set_qdma() so that NETIF_F_GRO_HW availability is re-evaluated
whenever the QDMA user count changes (device registration and runtime QDMA
migration).
Set CHECKSUM_PARTIAL with pseudo-header checksum on aggregated packets
so that L3-forwarded traffic is correctly handled by the GSO/TSO path
on the egress device.
The HW does not report the per-segment MSS (msg3[31:16] only reports
the max aggregated size), so the gso_size of an aggregated packet is
just an approximation computed as DIV_ROUND_UP(data_len, agg_count).
The LRO engine always aggregates n-1 MSS-sized TCP segments plus one
shorter tail for an aggregate of n segments, so this approximation
re-segments into exactly agg_count segments without ever exceeding the
original MSS.

Performance comparison between GRO and HW GRO has been carried out using
a 10Gbps NIC:
GRO:    ~2.7 Gbps
HW GRO: ~8.2 Gbps

Tested-by: Madhur Agrawal <madhur.agrawal@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v5:
- Rebase on top of net-next branch.
- Fix sashiko's reported issues on v4.
- Link to v4: https://lore.kernel.org/r/20260807-airoha-eth-lro-v4-1-12d11ecb77d4@oss.qualcomm.com

Changes in v4:
- Fix qdma user check in airoha_dev_open().
- Disable hw-gro in airoha_dev_stop().
- Check hw-gro configuration in airoha_enable_qos_for_gdm34() running
  airoha_dev_check_hw_gro().
- Enable rx interrupt for queue 31.
- Check tcp_ts_reply from hw descriptor.
- Add more sanity checks in airoha_qdma_lro_rx_skb().
- Move airoha_update_netdev_features() in airoha_dev_set_qdma()
- Link to v3: https://lore.kernel.org/r/20260730-airoha-eth-lro-v3-1-631963d048e3@kernel.org

Changes in v3:
- Add missing TCP header length check.
- Fix TCP checkum calculation.
- Disable LRO running ndo_stop callback.
- Implement packet header split in order to support HW-GRO
- Link to v2: https://lore.kernel.org/r/20260610-airoha-eth-lro-v2-1-54be99b9a2d5@kernel.org

Changes in v2:
- Rebase on top of net-next main branch.
- Link to v1: https://lore.kernel.org/r/20260606-airoha-eth-lro-v1-1-0ebceb0eafc3@kernel.org

Changes in v1:
- Please note this patch depends on the following patch not applied yet
  to net-next
  https://lore.kernel.org/netdev/20260606-airoha_qdma_users-no-atomic-v1-1-86e2d6a1bfaf@kernel.org/T/#u
- Restrict LRO to single user QDMA.
- Introduce some more sanity checks.
- Disable scatter-gather for LRO queues.
- Run netif_receive_skb() for LRO packets.
- Link to v3: https://lore.kernel.org/r/20260528-airoha-eth-lro-v3-1-dd09c1fb000e@kernel.org

Changes in RFC v3:
- Fix double-free of the page_pool of airoha_qdma_lro_rx_process()
  fails.
- Set AIROHA_LRO_PAGE_ORDER according to PAGE_SIZE.
- Add missig gso metadata for the LRO packet.
- Link to v2: https://lore.kernel.org/r/20260526-airoha-eth-lro-v2-1-24e2a9e7a397@kernel.org

Changes in RFC v2:
- Improve performances fixing buf_size computation.
- Fix possible overflow in REG_CDM_LRO_LIMIT() register configuration.
- Require the device to be not running before configuring LRO.
- Fix configuration order in airoha_fe_lro_is_enabled().
- Check skb header length in airoha_qdma_lro_rx_process().
- Do not check net_device feature in airoha_qdma_rx_process() before
  executing airoha_qdma_lro_rx_process() but rely on
  airoha_qdma_lro_rx_process() logic.
- Fix possible double recycle in airoha_qdma_rx_process() for LRO
  packets.
- Always use AIROHA_RXQ_LRO_MAX_AGG_COUNT macro for max LRO aggregated
  fragments in airoha_fe_lro_init_rx_queue().
- Link to v1: https://lore.kernel.org/r/20260520-airoha-eth-lro-v1-1-129cc33766e9@kernel.org
---
 drivers/net/ethernet/airoha/airoha_eth.c  | 407 +++++++++++++++++++++++++++---
 drivers/net/ethernet/airoha/airoha_eth.h  |  26 ++
 drivers/net/ethernet/airoha/airoha_regs.h |  23 +-
 3 files changed, 426 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 64619e9a704d..57b19d7b5bd7 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -10,8 +10,10 @@
 #include <linux/tcp.h>
 #include <linux/u64_stats_sync.h>
 #include <net/dst_metadata.h>
+#include <net/ip6_checksum.h>
 #include <net/page_pool/helpers.h>
 #include <net/pkt_cls.h>
+#include <net/tcp.h>
 #include <uapi/linux/ppp_defs.h>
 
 #include "airoha_regs.h"
@@ -491,6 +493,88 @@ static void airoha_fe_crsn_qsel_init(struct airoha_eth *eth)
 				 CDM_CRSN_QSEL_Q1));
 }
 
+static void airoha_fe_lro_rxq_enable(struct airoha_eth *eth, int qdma_id,
+				     int lro_queue_index, int qid,
+				     int buf_size)
+{
+	int id = qdma_id + 1;
+
+	airoha_fe_rmw(eth, REG_CDM_LRO_LIMIT(id),
+		      CDM_LRO_AGG_NUM_MASK | CDM_LRO_AGG_SIZE_MASK,
+		      FIELD_PREP(CDM_LRO_AGG_SIZE_MASK, buf_size) |
+		      FIELD_PREP(CDM_LRO_AGG_NUM_MASK,
+				 AIROHA_RXQ_LRO_MAX_AGG_COUNT));
+	airoha_fe_rmw(eth, REG_CDM_LRO_AGE_TIME(id),
+		      CDM_LRO_AGE_TIME_MASK | CDM_LRO_AGG_TIME_MASK,
+		      FIELD_PREP(CDM_LRO_AGE_TIME_MASK,
+				 AIROHA_RXQ_LRO_MAX_AGE_TIME) |
+		      FIELD_PREP(CDM_LRO_AGG_TIME_MASK,
+				 AIROHA_RXQ_LRO_MAX_AGG_TIME));
+	airoha_fe_rmw(eth, REG_CDM_LRO_RXQ(id, lro_queue_index),
+		      LRO_RXQ_MASK(lro_queue_index),
+		      __field_prep(LRO_RXQ_MASK(lro_queue_index), qid));
+	airoha_fe_set(eth, REG_CDM_LRO_EN(id), BIT(lro_queue_index));
+}
+
+static void airoha_fe_lro_disable(struct airoha_eth *eth, int qdma_id)
+{
+	int i, id = qdma_id + 1;
+
+	airoha_fe_clear(eth, REG_CDM_LRO_EN(id), LRO_RXQ_EN_MASK);
+	airoha_fe_clear(eth, REG_CDM_LRO_LIMIT(id),
+			CDM_LRO_AGG_NUM_MASK | CDM_LRO_AGG_SIZE_MASK);
+	airoha_fe_clear(eth, REG_CDM_LRO_AGE_TIME(id),
+			CDM_LRO_AGE_TIME_MASK | CDM_LRO_AGG_TIME_MASK);
+	for (i = 0; i < AIROHA_MAX_NUM_LRO_QUEUES; i++)
+		airoha_fe_clear(eth, REG_CDM_LRO_RXQ(id, i), LRO_RXQ_MASK(i));
+}
+
+static bool airoha_fe_lro_is_enabled(struct airoha_eth *eth, int qdma_id)
+{
+	return airoha_fe_get(eth, REG_CDM_LRO_EN(qdma_id + 1),
+			     LRO_RXQ_EN_MASK);
+}
+
+static void airoha_dev_lro_enable(struct airoha_gdm_dev *dev)
+{
+	struct airoha_qdma *qdma = airoha_qdma_deref(dev);
+	struct airoha_eth *eth = qdma->eth;
+	int qdma_id = qdma - &eth->qdma[0];
+	int i, lro_queue_index = 0;
+
+	if (airoha_fe_lro_is_enabled(eth, qdma_id))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
+		struct airoha_queue *q = &qdma->q_rx[i];
+		u32 size;
+
+		if (!q->ndesc)
+			continue;
+
+		if (!airoha_qdma_is_lro_queue(q))
+			continue;
+
+		size = SKB_WITH_OVERHEAD(AIROHA_RX_LEN(q->buf_size));
+		size = min_t(u32, size, AIROHA_MAX_RX_SIZE);
+		airoha_fe_lro_rxq_enable(eth, qdma_id, lro_queue_index, i,
+					 size);
+		lro_queue_index++;
+	}
+}
+
+static void airoha_dev_lro_disable(struct airoha_gdm_dev *dev)
+{
+	struct airoha_qdma *qdma = airoha_qdma_deref(dev);
+	struct airoha_eth *eth = qdma->eth;
+	int qdma_id = qdma - &eth->qdma[0];
+
+	if (!airoha_fe_lro_is_enabled(eth, qdma_id))
+		return;
+
+	airoha_fe_lro_disable(eth, qdma_id);
+}
+
 static int airoha_fe_init(struct airoha_eth *eth)
 {
 	airoha_fe_maccr_init(eth);
@@ -616,6 +700,7 @@ static int airoha_qdma_fill_rx_queue(struct airoha_queue *q)
 		e->dma_addr = page_pool_get_dma_addr(page) + offset;
 		e->dma_len = SKB_WITH_OVERHEAD(AIROHA_RX_LEN(q->buf_size));
 
+		WRITE_ONCE(desc->tcp_ts_reply, 0);
 		val = FIELD_PREP(QDMA_DESC_LEN_MASK, e->dma_len);
 		WRITE_ONCE(desc->ctrl, cpu_to_le32(val));
 		WRITE_ONCE(desc->addr, cpu_to_le32(e->dma_addr));
@@ -657,12 +742,191 @@ airoha_qdma_get_gdm_dev(struct airoha_eth *eth, struct airoha_qdma_desc *desc)
 	return port->devs[d] ? port->devs[d] : ERR_PTR(-ENODEV);
 }
 
+static struct sk_buff *airoha_qdma_lro_rx_skb(struct airoha_queue *q,
+					      struct airoha_qdma_desc *desc,
+					      struct airoha_queue_entry *e,
+					      u32 msg1, u32 msg2, u32 len,
+					      u32 agg_count)
+{
+	u32 msg3 = le32_to_cpu(READ_ONCE(desc->msg3));
+	u32 th_off, tcp_ack_seq, data_off, data_len;
+	struct skb_shared_info *shinfo;
+	u16 tcp_win, l2_len;
+	struct sk_buff *skb;
+	struct tcphdr *th;
+	struct page *page;
+	bool ipv4, ipv6;
+
+	ipv4 = FIELD_GET(QDMA_ETH_RXMSG_IP4_MASK, msg1);
+	ipv6 = FIELD_GET(QDMA_ETH_RXMSG_IP6_MASK, msg1);
+	if (!ipv4 && !ipv6)
+		return NULL;
+
+	l2_len = FIELD_GET(QDMA_ETH_RXMSG_L2_LEN_MASK, msg2);
+
+	if (ipv4) {
+		struct iphdr *iph;
+
+		if (len < l2_len + sizeof(*iph))
+			return NULL;
+
+		iph = (struct iphdr *)(e->buf + l2_len);
+		if (iph->protocol != IPPROTO_TCP)
+			return NULL;
+
+		if (iph->ihl < 5)
+			return NULL;
+
+		th_off = l2_len + (iph->ihl << 2);
+		if (len < th_off)
+			return NULL;
+
+		iph->tot_len = cpu_to_be16(len - l2_len);
+		iph->check = 0;
+		iph->check = ip_fast_csum((void *)iph, iph->ihl);
+	} else {
+		struct ipv6hdr *ip6h;
+
+		th_off = l2_len + sizeof(*ip6h);
+		if (len < th_off)
+			return NULL;
+
+		ip6h = (struct ipv6hdr *)(e->buf + l2_len);
+		if (ip6h->nexthdr != NEXTHDR_TCP)
+			return NULL;
+
+		ip6h->payload_len = cpu_to_be16(len - th_off);
+	}
+
+	if (len < th_off + sizeof(*th))
+		return NULL;
+
+	th = (struct tcphdr *)(e->buf + th_off);
+	if (th->doff < 5)
+		return NULL;
+
+	data_off = th_off + (th->doff << 2);
+	if (len <= data_off)
+		return NULL;
+
+	tcp_win = FIELD_GET(QDMA_ETH_RXMSG_TCP_WIN_MASK, msg3);
+	tcp_ack_seq = le32_to_cpu(READ_ONCE(desc->data));
+	th->ack_seq = cpu_to_be32(tcp_ack_seq);
+	th->window = cpu_to_be16(tcp_win);
+
+	/* Check tcp timestamp option */
+	if (th->doff == (sizeof(*th) + TCPOLEN_TSTAMP_ALIGNED) / 4) {
+		u32 topt = get_unaligned_be32(th + 1);
+
+		if (topt == ((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
+			     (TCPOPT_TIMESTAMP << 8) | TCPOLEN_TIMESTAMP)) {
+			u8 *ptr = (u8 *)th + sizeof(*th) + 2 * sizeof(__be32);
+			__le32 tcp_ts_reply = READ_ONCE(desc->tcp_ts_reply);
+
+			/* The field is pre-zeroed in the posted descriptor,
+			 * so a non-zero value is the hardware confirming the
+			 * timestamp echo reply is valid. Leave TSecr
+			 * untouched otherwise, since the hardware may not
+			 * populate it for every aggregate.
+			 */
+			if (tcp_ts_reply)
+				put_unaligned_be32(le32_to_cpu(tcp_ts_reply),
+						   ptr);
+		}
+	}
+
+	if (ipv4) {
+		struct iphdr *iph = (struct iphdr *)(e->buf + l2_len);
+
+		th->check = ~tcp_v4_check(len - th_off, iph->saddr,
+					  iph->daddr, 0);
+	} else {
+		struct ipv6hdr *ip6h = (struct ipv6hdr *)(e->buf + l2_len);
+
+		th->check = ~tcp_v6_check(len - th_off, &ip6h->saddr,
+					  &ip6h->daddr, 0);
+	}
+
+	/* Split network headers and payload to rely on GRO.
+	 * We need to do it in the driver since the NIC does
+	 * not support it.
+	 */
+	skb = napi_alloc_skb(&q->napi, data_off);
+	if (!skb)
+		return NULL;
+
+	__skb_put(skb, data_off);
+	memcpy(skb->data, e->buf, data_off);
+
+	page = virt_to_head_page(e->buf);
+	data_len = len - data_off;
+	shinfo = skb_shinfo(skb);
+	skb_add_rx_frag(skb, shinfo->nr_frags, page,
+			e->buf + data_off - page_address(page), data_len,
+			q->buf_size);
+
+	shinfo->gso_type = ipv4 ? SKB_GSO_TCPV4 : SKB_GSO_TCPV6;
+	/* HW does not report the per-segment MSS, so approximate it as
+	 * the average segment size. The LRO engine always aggregates
+	 * n-1 MSS-sized TCP segments plus one shorter tail for an
+	 * aggregate of n segments, so this still re-segments into
+	 * exactly agg_count segments, keeping gso_size/gso_segs and the
+	 * packet accounting coherent, while never overestimating the MSS.
+	 */
+	shinfo->gso_size = DIV_ROUND_UP(data_len, agg_count);
+	shinfo->gso_segs = agg_count;
+
+	skb->csum_start = skb_headroom(skb) + th_off;
+	skb->csum_offset = offsetof(struct tcphdr, check);
+	skb->ip_summed = CHECKSUM_PARTIAL;
+
+	return skb;
+}
+
+static struct sk_buff *airoha_qdma_build_rx_skb(struct airoha_queue *q,
+						struct airoha_qdma_desc *desc,
+						struct airoha_queue_entry *e,
+						struct net_device *dev,
+						u32 msg1, u32 len)
+{
+	u32 msg2 = le32_to_cpu(READ_ONCE(desc->msg2));
+	int qid = q - &q->qdma->q_rx[0];
+	struct sk_buff *skb;
+	u32 agg_count = 1;
+
+	if (airoha_qdma_is_lro_queue(q)) {
+		agg_count = FIELD_GET(QDMA_ETH_RXMSG_AGG_COUNT_MASK, msg2);
+		if (agg_count > AIROHA_RXQ_LRO_MAX_AGG_COUNT)
+			return NULL;
+	}
+
+	if (agg_count > 1) { /* LRO */
+		skb = airoha_qdma_lro_rx_skb(q, desc, e, msg1, msg2, len,
+					     agg_count);
+		if (!skb)
+			return NULL;
+	} else {
+		skb = napi_build_skb(e->buf - AIROHA_RX_HEADROOM, q->buf_size);
+		if (!skb)
+			return NULL;
+
+		skb_reserve(skb, AIROHA_RX_HEADROOM);
+		__skb_put(skb, len);
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+	}
+
+	skb_mark_for_recycle(skb);
+	skb->dev = dev;
+	skb_record_rx_queue(skb, qid);
+	skb->protocol = eth_type_trans(skb, dev);
+
+	return skb;
+}
+
 static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 {
 	enum dma_data_direction dir = page_pool_get_dma_dir(q->page_pool);
-	struct airoha_qdma *qdma = q->qdma;
-	struct airoha_eth *eth = qdma->eth;
-	int qid = q - &qdma->q_rx[0];
+	struct airoha_eth *eth = q->qdma->eth;
 	int done = 0;
 
 	while (done < budget) {
@@ -696,20 +960,14 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 		if (IS_ERR(dev))
 			goto free_frag;
 
+		msg1 = le32_to_cpu(READ_ONCE(desc->msg1));
 		netdev = netdev_from_priv(dev);
+
 		if (!q->skb) { /* first buffer */
-			q->skb = napi_build_skb(e->buf - AIROHA_RX_HEADROOM,
-						q->buf_size);
+			q->skb = airoha_qdma_build_rx_skb(q, desc, e, netdev,
+							  msg1, len);
 			if (!q->skb)
 				goto free_frag;
-
-			skb_reserve(q->skb, AIROHA_RX_HEADROOM);
-			__skb_put(q->skb, len);
-			skb_mark_for_recycle(q->skb);
-			q->skb->dev = netdev;
-			q->skb->protocol = eth_type_trans(q->skb, netdev);
-			q->skb->ip_summed = CHECKSUM_UNNECESSARY;
-			skb_record_rx_queue(q->skb, qid);
 		} else { /* scattered frame */
 			struct skb_shared_info *shinfo = skb_shinfo(q->skb);
 			int nr_frags = shinfo->nr_frags;
@@ -742,7 +1000,6 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 						  &port->dsa_meta[sptag]->dst);
 		}
 
-		msg1 = le32_to_cpu(READ_ONCE(desc->msg1));
 		hash = FIELD_GET(AIROHA_RXD4_FOE_ENTRY, msg1);
 		if (hash != AIROHA_RXD4_FOE_ENTRY)
 			skb_set_hash(q->skb, jhash_1word(hash, 0),
@@ -800,12 +1057,10 @@ static int airoha_qdma_rx_napi_poll(struct napi_struct *napi, int budget)
 static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 				     struct airoha_qdma *qdma, int ndesc)
 {
-	const struct page_pool_params pp_params = {
-		.order = 0,
+	struct page_pool_params pp_params = {
 		.pool_size = 256,
 		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
 		.dma_dir = DMA_FROM_DEVICE,
-		.max_len = PAGE_SIZE,
 		.nid = NUMA_NO_NODE,
 		.dev = qdma->eth->dev,
 		.napi = &q->napi,
@@ -813,9 +1068,10 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 	struct airoha_eth *eth = qdma->eth;
 	int qid = q - &qdma->q_rx[0], thr;
 	dma_addr_t dma_addr;
+	bool lro_q;
 
-	q->buf_size = PAGE_SIZE / 2;
 	q->qdma = qdma;
+	lro_q = airoha_qdma_is_lro_queue(q);
 
 	q->entry = devm_kzalloc(eth->dev, ndesc * sizeof(*q->entry),
 				GFP_KERNEL);
@@ -827,6 +1083,9 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 	if (!q->desc)
 		return -ENOMEM;
 
+	pp_params.order = lro_q ? AIROHA_LRO_PAGE_ORDER : 0;
+	pp_params.max_len = PAGE_SIZE << pp_params.order;
+
 	q->page_pool = page_pool_create(&pp_params);
 	if (IS_ERR(q->page_pool)) {
 		int err = PTR_ERR(q->page_pool);
@@ -835,6 +1094,7 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 		return err;
 	}
 
+	q->buf_size = lro_q ? pp_params.max_len : pp_params.max_len / 2;
 	q->ndesc = ndesc;
 	netif_napi_add(eth->napi_dev, &q->napi, airoha_qdma_rx_napi_poll);
 
@@ -848,7 +1108,12 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 			FIELD_PREP(RX_RING_THR_MASK, thr));
 	airoha_qdma_rmw(qdma, REG_RX_DMA_IDX(qid), RX_RING_DMA_IDX_MASK,
 			FIELD_PREP(RX_RING_DMA_IDX_MASK, q->head));
-	airoha_qdma_set(qdma, REG_RX_SCATTER_CFG(qid), RX_RING_SG_EN_MASK);
+	if (lro_q)
+		airoha_qdma_clear(qdma, REG_RX_SCATTER_CFG(qid),
+				  RX_RING_SG_EN_MASK);
+	else
+		airoha_qdma_set(qdma, REG_RX_SCATTER_CFG(qid),
+				RX_RING_SG_EN_MASK);
 
 	airoha_qdma_fill_rx_queue(q);
 
@@ -870,6 +1135,7 @@ static void airoha_qdma_cleanup_rx_queue(struct airoha_queue *q)
 					page_pool_get_dma_dir(q->page_pool));
 		page_pool_put_full_page(q->page_pool, page, false);
 		/* Reset DMA descriptor */
+		WRITE_ONCE(desc->tcp_ts_reply, 0);
 		WRITE_ONCE(desc->ctrl, 0);
 		WRITE_ONCE(desc->addr, 0);
 		WRITE_ONCE(desc->data, 0);
@@ -1896,6 +2162,34 @@ static void airoha_update_hw_stats(struct airoha_gdm_dev *dev)
 	spin_unlock(&port->stats_lock);
 }
 
+static void airoha_update_netdev_features(struct airoha_gdm_dev *dev)
+{
+	struct airoha_eth *eth = dev->eth;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
+		struct airoha_gdm_port *port = eth->ports[i];
+		int j;
+
+		if (!port)
+			continue;
+
+		for (j = 0; j < ARRAY_SIZE(port->devs); j++) {
+			struct airoha_gdm_dev *iter_dev = port->devs[j];
+			struct net_device *netdev;
+
+			if (!iter_dev)
+				continue;
+
+			netdev = netdev_from_priv(iter_dev);
+			if (netdev->reg_state != NETREG_REGISTERED)
+				continue;
+
+			netdev_update_features(netdev);
+		}
+	}
+}
+
 static void airoha_dev_set_xmit_frame_size(struct net_device *netdev)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
@@ -1913,14 +2207,28 @@ static int airoha_dev_open(struct net_device *netdev)
 	struct airoha_gdm_port *port = dev->port;
 	u32 pse_port = FE_PSE_PORT_PPE1;
 	struct airoha_qdma *qdma;
-	int err;
+	int qdma_id, err;
+
+	/* HW GRO is configured on the QDMA and it is shared between
+	 * all the devices using it. Refuse to open a second device on
+	 * the same QDMA if HW GRO is enabled on any device sharing it
+	 * or if this device has HW GRO enabled in its feature set.
+	 */
+	qdma = airoha_qdma_deref(dev);
+	qdma_id = qdma - &qdma->eth->qdma[0];
+
+	if (qdma->users > 1 && (airoha_fe_lro_is_enabled(qdma->eth, qdma_id) ||
+				(netdev->features & NETIF_F_GRO_HW))) {
+		netdev_warn(netdev, "required to disable HW GRO on QDMA%d\n",
+			    qdma_id);
+		return -EBUSY;
+	}
 
 	netif_tx_start_all_queues(netdev);
 	err = airoha_set_vip_for_gdm_port(dev, true);
 	if (err)
 		return err;
 
-	qdma = airoha_qdma_deref(dev);
 	if (netdev_uses_dsa(netdev))
 		airoha_fe_set(qdma->eth, REG_GDM_INGRESS_CFG(port->id),
 			      GDM_STAG_EN_MASK);
@@ -1937,6 +2245,9 @@ static int airoha_dev_open(struct net_device *netdev)
 	airoha_set_gdm_port_fwd_cfg(qdma->eth, REG_GDM_FWD_CFG(port->id),
 				    pse_port);
 
+	if (netdev->features & NETIF_F_GRO_HW)
+		airoha_dev_lro_enable(dev);
+
 	return 0;
 }
 
@@ -1954,6 +2265,10 @@ static int airoha_dev_stop(struct net_device *netdev)
 		airoha_set_gdm_port_fwd_cfg(dev->eth,
 					    REG_GDM_FWD_CFG(port->id),
 					    FE_PSE_PORT_DROP);
+
+	if (netdev->features & NETIF_F_GRO_HW)
+		airoha_dev_lro_disable(dev);
+
 	return 0;
 }
 
@@ -2115,11 +2430,14 @@ static void airoha_dev_set_qdma(struct airoha_gdm_dev *dev)
 	qdma = &eth->qdma[!airoha_is_lan_gdm_dev(dev)];
 	cur_qdma = airoha_qdma_deref(dev);
 
-	if (cur_qdma)
+	if (cur_qdma) {
 		netif_tx_stop_all_queues(netdev);
+		airoha_dev_lro_disable(dev);
+	}
 
 	rcu_assign_pointer(dev->qdma, qdma);
 	netdev->irq = qdma->irq_banks[0].irq;
+	qdma->users++;
 	synchronize_rcu();
 
 	ppe_id = !airoha_is_lan_gdm_dev(dev) && airoha_ppe_is_enabled(eth, 1);
@@ -2136,8 +2454,12 @@ static void airoha_dev_set_qdma(struct airoha_gdm_dev *dev)
 			airoha_qdma_rr(qdma, REG_CNTR_VAL((i << 1) + 1));
 	}
 
-	if (cur_qdma)
+	if (cur_qdma) {
+		cur_qdma->users--;
 		netif_tx_wake_all_queues(netdev);
+	}
+
+	airoha_update_netdev_features(dev);
 }
 
 static int airoha_dev_init(struct net_device *netdev)
@@ -2288,6 +2610,32 @@ int airoha_get_fe_port(struct airoha_gdm_dev *dev)
 	}
 }
 
+static netdev_features_t airoha_dev_fix_features(struct net_device *netdev,
+						 netdev_features_t features)
+{
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_qdma *qdma;
+
+	qdma = airoha_qdma_deref(dev);
+	if (qdma->users > 1)
+		features &= ~NETIF_F_GRO_HW;
+
+	return features;
+}
+
+static int airoha_dev_set_features(struct net_device *netdev,
+				   netdev_features_t features)
+{
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+
+	if (features & NETIF_F_GRO_HW)
+		airoha_dev_lro_enable(dev);
+	else
+		airoha_dev_lro_disable(dev);
+
+	return 0;
+}
+
 static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 				   struct net_device *netdev)
 {
@@ -3199,7 +3547,7 @@ static int airoha_enable_qos_for_gdm34(struct net_device *netdev,
 	struct airoha_gdm_dev *wan_dev, *dev = netdev_priv(netdev);
 	struct airoha_gdm_port *port = dev->port;
 	struct airoha_eth *eth = dev->eth;
-	int err = -EBUSY;
+	int err;
 
 	if (port->id != AIROHA_GDM3_IDX &&
 	    port->id != AIROHA_GDM4_IDX) {
@@ -3218,6 +3566,7 @@ static int airoha_enable_qos_for_gdm34(struct net_device *netdev,
 		    wan_dev->port->id == AIROHA_GDM2_IDX) {
 			NL_SET_ERR_MSG_MOD(extack,
 					   "QoS configured for WAN device");
+			err = -EBUSY;
 			goto error_unlock;
 		}
 		airoha_disable_qos_for_gdm34(netdev_from_priv(wan_dev));
@@ -3343,6 +3692,8 @@ static const struct net_device_ops airoha_netdev_ops = {
 	.ndo_stop		= airoha_dev_stop,
 	.ndo_change_mtu		= airoha_dev_change_mtu,
 	.ndo_select_queue	= airoha_dev_select_queue,
+	.ndo_fix_features	= airoha_dev_fix_features,
+	.ndo_set_features	= airoha_dev_set_features,
 	.ndo_start_xmit		= airoha_dev_xmit,
 	.ndo_get_stats64        = airoha_dev_get_stats64,
 	.ndo_set_mac_address	= airoha_dev_set_macaddr,
@@ -3430,11 +3781,9 @@ static int airoha_alloc_gdm_device(struct airoha_eth *eth,
 	netdev->ethtool_ops = &airoha_ethtool_ops;
 	netdev->max_mtu = AIROHA_MAX_MTU;
 	netdev->watchdog_timeo = 5 * HZ;
-	netdev->hw_features = NETIF_F_IP_CSUM | NETIF_F_RXCSUM | NETIF_F_TSO6 |
-			      NETIF_F_IPV6_CSUM | NETIF_F_SG | NETIF_F_TSO |
-			      NETIF_F_HW_TC;
-	netdev->features |= netdev->hw_features;
-	netdev->vlan_features = netdev->hw_features;
+	netdev->hw_features = AIROHA_HW_FEATURES | NETIF_F_GRO_HW;
+	netdev->features |= AIROHA_HW_FEATURES;
+	netdev->vlan_features = AIROHA_HW_FEATURES;
 	SET_NETDEV_DEV(netdev, eth->dev);
 
 	/* reserve hw queues for HTB offloading */
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index fa9a8edce22f..84cadbb53866 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -45,6 +45,18 @@
 	 (_n) == 15 ? 128 :		\
 	 (_n) ==  0 ? 1024 : 16)
 
+#define AIROHA_LRO_PAGE_ORDER		get_order(SZ_16K)
+#define AIROHA_MAX_NUM_LRO_QUEUES	8
+#define AIROHA_RXQ_LRO_EN_MASK		GENMASK(31, 24)
+#define AIROHA_RXQ_LRO_MAX_AGG_COUNT	64
+#define AIROHA_RXQ_LRO_MAX_AGG_TIME	100
+#define AIROHA_RXQ_LRO_MAX_AGE_TIME	2000
+
+#define AIROHA_HW_FEATURES			\
+	(NETIF_F_IP_CSUM | NETIF_F_RXCSUM |	\
+	 NETIF_F_TSO6 | NETIF_F_IPV6_CSUM |	\
+	 NETIF_F_SG | NETIF_F_TSO | NETIF_F_HW_TC)
+
 #define PSE_RSV_PAGES			128
 #define PSE_QUEUE_RSV_PAGES		64
 
@@ -560,6 +572,8 @@ struct airoha_qdma {
 	struct airoha_eth *eth;
 	void __iomem *regs;
 
+	int users;
+
 	struct airoha_irq_bank irq_banks[AIROHA_MAX_NUM_IRQ_BANKS];
 
 	struct airoha_tx_irq_queue q_tx_irq[AIROHA_NUM_TX_IRQ];
@@ -714,6 +728,18 @@ static inline bool airoha_is_7583(struct airoha_eth *eth)
 	return eth->soc->version == 0x7583;
 }
 
+static inline bool airoha_qdma_is_lro_queue(struct airoha_queue *q)
+{
+	struct airoha_qdma *qdma = q->qdma;
+	int qid = q - &qdma->q_rx[0];
+
+	/* EN7581 SoC supports at most 8 LRO rx queues */
+	BUILD_BUG_ON(hweight32(AIROHA_RXQ_LRO_EN_MASK) >
+		     AIROHA_MAX_NUM_LRO_QUEUES);
+
+	return !!(AIROHA_RXQ_LRO_EN_MASK & BIT(qid));
+}
+
 int airoha_get_fe_port(struct airoha_gdm_dev *dev);
 bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
 			     struct airoha_gdm_dev *dev);
diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
index 442b48c9b991..07dd04859fde 100644
--- a/drivers/net/ethernet/airoha/airoha_regs.h
+++ b/drivers/net/ethernet/airoha/airoha_regs.h
@@ -122,6 +122,20 @@
 #define CDM_CRSN_QSEL_REASON_MASK(_n)	\
 	GENMASK(4 + (((_n) % 4) << 3),	(((_n) % 4) << 3))
 
+#define REG_CDM_LRO_RXQ(_n, _m)		(CDM_BASE(_n) + 0x78 + ((_m) & 0x4))
+#define LRO_RXQ_MASK(_n)		GENMASK(4 + (((_n) & 0x3) << 3), ((_n) & 0x3) << 3)
+
+#define REG_CDM_LRO_EN(_n)		(CDM_BASE(_n) + 0x80)
+#define LRO_RXQ_EN_MASK			GENMASK(7, 0)
+
+#define REG_CDM_LRO_LIMIT(_n)		(CDM_BASE(_n) + 0x84)
+#define CDM_LRO_AGG_NUM_MASK		GENMASK(23, 16)
+#define CDM_LRO_AGG_SIZE_MASK		GENMASK(15, 0)
+
+#define REG_CDM_LRO_AGE_TIME(_n)	(CDM_BASE(_n) + 0x88)
+#define CDM_LRO_AGE_TIME_MASK		GENMASK(31, 16)
+#define CDM_LRO_AGG_TIME_MASK		GENMASK(15, 0)
+
 #define REG_GDM_FWD_CFG(_n)		GDM_BASE(_n)
 #define GDM_PAD_EN_MASK			BIT(28)
 #define GDM_DROP_CRC_ERR_MASK		BIT(23)
@@ -887,9 +901,16 @@
 #define QDMA_ETH_RXMSG_SPORT_MASK	GENMASK(25, 21)
 #define QDMA_ETH_RXMSG_CRSN_MASK	GENMASK(20, 16)
 #define QDMA_ETH_RXMSG_PPE_ENTRY_MASK	GENMASK(15, 0)
+/* RX MSG2 */
+#define QDMA_ETH_RXMSG_AGG_COUNT_MASK	GENMASK(31, 24)
+#define QDMA_ETH_RXMSG_L2_LEN_MASK	GENMASK(6, 0)
+/* RX MSG3 */
+/* max aggregated size in bytes */
+#define QDMA_ETH_RXMSG_AGG_LEN_MASK	GENMASK(31, 16)
+#define QDMA_ETH_RXMSG_TCP_WIN_MASK	GENMASK(15, 0)
 
 struct airoha_qdma_desc {
-	__le32 rsv;
+	__le32 tcp_ts_reply;
 	__le32 ctrl;
 	__le32 addr;
 	__le32 data;

---
base-commit: 1bb784eb6e38fd73143f021608e4ef3095d0c0d7
change-id: 20260520-airoha-eth-lro-a5d1c3631811

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>

