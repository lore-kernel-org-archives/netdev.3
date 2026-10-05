Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C429A4CE66B;
	Mon,  5 Oct 2026 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215299; cv=none; b=da3xfhmY0TcIJ8CK+aQqaaRfsvyd0Y5b89jaHGKJpSUyqyAgrEaNSu3jLECQmDSbWguIDPvYqy3Ctis9sZZwSH0Rbi/ZBXtSpzgQgGFi4UjphQsF5pv3z7rXHpEopfLfLAibn60IL/XLq6cyumv70FFjTw4x5VVXR1F0QtHNImA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215299; c=relaxed/simple;
	bh=hKaicI1krcmDsma2JjDxDvuKPDfqN3Yjvgaghs8c51Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lI/Ixrbem6tYz7jOT0GfpjJG0LaV95td7q5Lb7ihjVrChYqwgXXKO33ycxGWHPOt/cCiipM0F5JnBKw58YahNsx7Jw3/kn/VeuGk5BMlGknZqYsFoDgUUHsbnNYchUlKdvmsrnL2XOEL+S8/2lO9y8rB4Cta8ggpdogAVE93mqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=ekjeedWR; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="ekjeedWR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BV5Qlkh2AfPUrBdtG63+HacDFmwd86JpLe2nHO0knfU=; b=ekjeedWRP0ZubRZKW/QmqnxMzN
	6F4eg0fRoR9yCal/lWrKa+yx9KmrQEwNjLYd4YnI7k9fbWHtSxMS7I1skU0nElGt63ijhxh3QIUsx
	3hJUIzelgDYVJjJ7w14N3lKOMSVlTrEgsDeGnJZbmZwSOVq3XyHTz55SkFgiqT27hZTvHptGRK5Q6
	h3vh/FdQq7bhNmgs/UFWAE0zt1HWJ/XGw33N5r2RWMJzw+qmNG9w9ZXSB9domc6lQri+52AzK/vLf
	0MV3sUXTCTd1eS2nt0qGyv5jyuIKyUOT72V1fJfN8vow6a8C9p+6QG0C27sKUs25voz1i7K+dF81I
	6HCQLZ3Q==;
Received: from [115.246.246.98] (port=10743 helo=cypher.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <parvathi@couthit.com>)
	id 1xDkvB-000000054er-1FgI;
	Mon, 05 Oct 2026 11:48:10 -0400
From: Parvathi Pudi <parvathi@couthit.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	danishanwar@ti.com,
	parvathi@couthit.com,
	rogerq@kernel.org,
	pmohan@couthit.com,
	afd@ti.com,
	vadim.fedorenko@linux.dev,
	haokexin@gmail.com,
	basharath@couthit.com,
	arnd@arndb.de
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	horms@kernel.org,
	pratheesh@ti.com,
	j-rameshbabu@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	m-malladi@ti.com,
	krishna@couthit.com,
	mohan@couthit.com
Subject: [PATCH net-next v5 3/3] net: ti: icssm-prueth: Support duplicate HW offload feature for HSR and PRP
Date: Mon,  5 Oct 2026 21:11:59 +0530
Message-ID: <20261005154654.576663-4-parvathi@couthit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005154654.576663-1-parvathi@couthit.com>
References: <20261005154654.576663-1-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: parvathi@couthit.com
X-Authenticated-Sender: server.couthit.com: parvathi@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

From: Roger Quadros <rogerq@ti.com>

In HSR and PRP modes each outgoing frame must be sent on both PRU slave
ports.

Previously the driver was writing the frame into each port's transmit queue
independently after updating the tags resulting in performing two OCMC
buffer copy operations.

Frame duplicate offloading is implemented with a common shared queue
between the two ports. The driver writes the frame once into OCMC RAM,
each port reads from the shared queue and replicates the transmission to
both PRU ports, synchronising between PRU ports are maintained within
firmware with appropriate handling.

For HSR the driver inspects the encapsulated ethertype in the HSR tag.
PTP frames (ETH_P_1588) are sent on the directed port only to avoid double
duplication and all other HSR frames are duplicated to both ports.
VLAN-tagged HSR frames are handled by advancing past the 4-byte VLAN header
before reading the HSR tag.

For PRP the driver checks the 6-byte RCT trailer for the ETH_P_PRP suffix
to identify redundancy-tagged frames. Frames without an RCT are sent on the
originating port only.

NETIF_F_HW_HSR_DUP is now supported and is tied to NETIF_F_HW_HSR_TAG_RM
and NETIF_F_HW_HSR_FWD in ndo_fix_features(), since the firmware handles
all three features together.

To enable HSR/PRP offload, enable hsr-dup-offload on both slave ports:

$ ethtool -K eth2 hsr-dup-offload on
$ ethtool -K eth3 hsr-dup-offload on

With duplicate offload enabled, the HSR core sends each frame only once
through the first slave port. The firmware then duplicates and sends the
frame through both ports.

On the receive side, icssm_parse_packet_info() reads the new HostRecv bit
from the firmware instead of the unused BD Port field. This bit tells which
HSR copy should be passed to the network stack.

icssm_emac_rx_packet() ignores the other duplicate without creating an skb,
since receiving duplicate HSR packets is expected and not an error. The
OCMC-to-skb copy is also split into MAC header, VLAN, and payload parts.
This makes it possible to remove the HSR tag from the middle of the packet.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
---
 drivers/net/ethernet/ti/icssm/icssm_prueth.c  | 254 +++++++++++---
 drivers/net/ethernet/ti/icssm/icssm_prueth.h  |  13 +-
 .../ethernet/ti/icssm/icssm_prueth_common.c   |  11 +-
 .../ethernet/ti/icssm/icssm_prueth_switch.c   | 325 +++++++++++++++++-
 .../ethernet/ti/icssm/icssm_prueth_switch.h   |   1 +
 drivers/net/ethernet/ti/icssm/icssm_switch.h  |  34 +-
 6 files changed, 563 insertions(+), 75 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
index 42c83946f17a..e5e888a1e6f4 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
@@ -36,12 +36,14 @@
 #include "../icssg/icss_iep.h"
 
 #define OCMC_RAM_SIZE		(SZ_64K)
+#define PRUETH_ETHER_TYPE_OFFSET	12
 
 #define TX_START_DELAY		0x40
 #define TX_CLK_DELAY_100M	0x6
 #define HR_TIMER_TX_DELAY_US	100
 
 #define NETIF_PRUETH_LRE_OFFLOAD_FEATURES       (NETIF_F_HW_HSR_FWD | \
+						 NETIF_F_HW_HSR_DUP | \
 						 NETIF_F_HW_HSR_TAG_RM)
 
 /* ICSSM (v2.1) - supports 64-bit IEP counter.
@@ -79,6 +81,32 @@ static void icssm_prueth_set_fw_offsets(struct prueth *prueth)
 	}
 }
 
+/* Queue Descriptors initialization for HSR PRP */
+const struct prueth_queue_desc hsr_prp_txopt_queue_descs[][NUM_QUEUES] = {
+	[PRUETH_PORT_QUEUE_HOST] = {
+		{ .rd_ptr = P0_Q1_BD_OFFSET, .wr_ptr = P0_Q1_BD_OFFSET, },
+		{ .rd_ptr = P0_Q2_BD_OFFSET, .wr_ptr = P0_Q2_BD_OFFSET, },
+		{ .rd_ptr = P0_Q3_BD_OFFSET, .wr_ptr = P0_Q3_BD_OFFSET, },
+		{ .rd_ptr = P0_Q4_BD_OFFSET, .wr_ptr = P0_Q4_BD_OFFSET, },
+	},
+	[PRUETH_PORT_QUEUE_MII0] = {
+		{ .rd_ptr = P0_Q3_BD_OFFSET, .wr_ptr = P0_Q3_BD_OFFSET, },
+		{ .rd_ptr = P0_Q4_BD_OFFSET, .wr_ptr = P0_Q4_BD_OFFSET, },
+		{ .rd_ptr = P1_Q3_TXOPT_BD_OFFSET,
+			.wr_ptr = P1_Q3_TXOPT_BD_OFFSET, },
+		{ .rd_ptr = P2_Q1_TXOPT_BD_OFFSET,
+			.wr_ptr = P2_Q1_TXOPT_BD_OFFSET, },
+	},
+	[PRUETH_PORT_QUEUE_MII1] = {
+		{ .rd_ptr = P0_Q1_BD_OFFSET, .wr_ptr = P0_Q1_BD_OFFSET, },
+		{ .rd_ptr = P0_Q2_BD_OFFSET, .wr_ptr = P0_Q2_BD_OFFSET, },
+		{ .rd_ptr = P1_Q3_TXOPT_BD_OFFSET,
+			.wr_ptr = P1_Q3_TXOPT_BD_OFFSET, },
+		{ .rd_ptr = P2_Q1_TXOPT_BD_OFFSET,
+			.wr_ptr = P2_Q1_TXOPT_BD_OFFSET, },
+	}
+};
+
 static void icssm_prueth_write_reg(struct prueth *prueth,
 				   enum prueth_mem region,
 				   unsigned int reg, u32 val)
@@ -552,32 +580,37 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac *emac,
 				   struct sk_buff *skb,
 				   enum prueth_queue_id queue_id)
 {
+	struct prueth_queue_desc __iomem *queue_desc_other_port = NULL;
 	struct prueth_queue_desc __iomem *queue_desc;
 	const struct prueth_queue_info *txqueue;
-	struct net_device *ndev = emac->ndev;
 	struct prueth *prueth = emac->prueth;
 	unsigned int buffer_desc_count;
 	int free_blocks, update_block;
+	struct vlan_ethhdr *vlan_hdr;
 	bool buffer_wrapped = false;
 	int write_block, read_block;
+	int free_blocks_other_port;
+	int read_block_other_port;
 	void *src_addr, *dst_addr;
+	u16 bd_rd_ptr_other_port;
+	struct hsr_tag *hsr_tag;
+	struct ethhdr *ethhdr;
+	bool is_vlan = false;
 	int pkt_block_size;
 	void __iomem *sram;
 	void __iomem *dram;
 	int txport, pktlen;
 	u16 update_wr_ptr;
 	u32 wr_buf_desc;
+	u16 prp_ethtype;
 	void *ocmc_ram;
+	__be16 proto;
+	u8 *hdr;
 
 	if (!PRUETH_IS_EMAC(prueth))
 		dram = prueth->mem[PRUETH_MEM_DRAM1].va;
 	else
 		dram = emac->prueth->mem[emac->dram].va;
-	if (eth_skb_pad(skb)) {
-		if (netif_msg_tx_err(emac) && net_ratelimit())
-			netdev_err(ndev, "packet pad failed\n");
-		return -ENOMEM;
-	}
 
 	/* which port to tx: MII0 or MII1 */
 	txport = emac->tx_port_queue;
@@ -585,7 +618,10 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac *emac,
 	pktlen = skb->len;
 	/* Get the tx queue */
 	queue_desc = emac->tx_queue_descs + queue_id;
-	if (!PRUETH_IS_EMAC(prueth))
+	/* Tx queue context */
+	if (prueth_is_lre(prueth))
+		txqueue = &lre_queue_infos[txport][queue_id];
+	else if (PRUETH_IS_SWITCH(prueth))
 		txqueue = &sw_queue_infos[txport][queue_id];
 	else
 		txqueue = &queue_infos[txport][queue_id];
@@ -608,6 +644,29 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac *emac,
 		free_blocks = buffer_desc_count;
 	}
 
+	/* Fetch queue state for the second LRE port */
+	if (prueth_is_lre(prueth)) {
+		queue_desc_other_port = emac->tx_queue_descs_other_port +
+					queue_id;
+		bd_rd_ptr_other_port = readw(&queue_desc_other_port->rd_ptr);
+
+		read_block_other_port = (bd_rd_ptr_other_port -
+					 txqueue->buffer_desc_offset) / BD_SIZE;
+
+		if (write_block > read_block_other_port) {
+			free_blocks_other_port = buffer_desc_count -
+						 write_block;
+			free_blocks_other_port += read_block_other_port;
+		} else if (write_block < read_block_other_port) {
+			free_blocks_other_port = read_block_other_port -
+						 write_block;
+		} else {
+			free_blocks_other_port = buffer_desc_count;
+		}
+
+		if (free_blocks_other_port < free_blocks)
+			free_blocks = free_blocks_other_port;
+	}
 	pkt_block_size = DIV_ROUND_UP(pktlen, ICSS_BLOCK_SIZE);
 	if (pkt_block_size > free_blocks) /* out of queue space */
 		return -ENOBUFS;
@@ -657,6 +716,51 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac *emac,
 	if (PRUETH_IS_HSR(prueth))
 		wr_buf_desc |= BIT(PRUETH_BD_HSR_FRAME_SHIFT);
 
+	if (prueth_is_lre(prueth)) {
+		ethhdr = (struct ethhdr *)skb_mac_header(skb);
+		proto = ethhdr->h_proto;
+
+		if (proto == htons(ETH_P_8021Q)) {
+			vlan_hdr = (struct vlan_ethhdr *)ethhdr;
+			proto = vlan_hdr->h_vlan_encapsulated_proto;
+			is_vlan = true;
+		}
+
+		/* Check if the SKB has HSR tag */
+		if (PRUETH_IS_HSR(prueth) && proto == htons(ETH_P_HSR)) {
+			hdr = skb_mac_header(skb) + ETH_HLEN;
+			if (is_vlan)
+				hdr += VLAN_HLEN;
+
+			hsr_tag = (struct hsr_tag *)hdr;
+
+			/* PTP frames (ETH_P_1588) are directed frames
+			 * so skip the duplication
+			 */
+			if (hsr_tag->encap_proto != htons(ETH_P_1588)) {
+				wr_buf_desc |= PRUETH_BD_LAN_INFO_MASK;
+			} else {
+				wr_buf_desc |= (txport <<
+						PRUETH_BD_LAN_A_SHIFT);
+			}
+			wr_buf_desc |= PRUETH_BD_RED_PKT_MASK;
+		} else if (PRUETH_IS_PRP(prueth)) {
+			/* Check if the SKB has PRP tag */
+			prp_ethtype = get_unaligned_be16(skb_tail_pointer(skb) -
+							 ETH_TLEN);
+
+			if (prp_ethtype == ETH_P_PRP) {
+				wr_buf_desc |= PRUETH_BD_LAN_INFO_MASK;
+				wr_buf_desc |= PRUETH_BD_RED_PKT_MASK;
+			} else {
+				wr_buf_desc |= (txport <<
+						PRUETH_BD_LAN_A_SHIFT);
+			}
+		} else {
+			wr_buf_desc |= (txport << PRUETH_BD_LAN_A_SHIFT);
+		}
+	}
+
 	sram = prueth->mem[PRUETH_MEM_SHARED_RAM].va;
 	if (!PRUETH_IS_EMAC(prueth))
 		writel(wr_buf_desc, sram + readw(&queue_desc->wr_ptr));
@@ -669,6 +773,10 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac *emac,
 	update_wr_ptr = txqueue->buffer_desc_offset + (update_block * BD_SIZE);
 	writew(update_wr_ptr, &queue_desc->wr_ptr);
 
+	/* update the write pointer in queue descriptor of other port */
+	if (prueth_is_lre(prueth))
+		writew(update_wr_ptr, &queue_desc_other_port->wr_ptr);
+
 	return 0;
 }
 
@@ -681,8 +789,10 @@ void icssm_parse_packet_info(struct prueth *prueth, u32 buffer_descriptor,
 	else
 		pkt_info->start_offset = false;
 
-	pkt_info->port = (buffer_descriptor & PRUETH_BD_PORT_MASK) >>
-			 PRUETH_BD_PORT_SHIFT;
+	/* Flag from BD to indicate packet is valid for HOST or not. */
+	pkt_info->host_recv_flag = !!(buffer_descriptor &
+				      PRUETH_BD_HOST_RECV_MASK);
+
 	pkt_info->length = (buffer_descriptor & PRUETH_BD_LENGTH_MASK) >>
 			   PRUETH_BD_LENGTH_SHIFT;
 	pkt_info->broadcast = !!(buffer_descriptor & PRUETH_BD_BROADCAST_MASK);
@@ -712,17 +822,19 @@ int icssm_emac_rx_packet(struct prueth_emac *emac, u16 *bd_rd_ptr,
 	struct net_device *ndev = emac->ndev;
 	unsigned int buffer_desc_count;
 	int read_block, update_block;
+	struct vlan_ethhdr *vlan_hdr;
 	unsigned int actual_pkt_len;
 	bool buffer_wrapped = false;
+	int adjust_for_hsr_tag = 0;
 	void *src_addr, *dst_addr;
-	u16 start_offset = 0;
+	bool has_hsr_tag = false;
+	bool has_vlan = false;
+	struct ethhdr *ethhdr;
 	struct sk_buff *skb;
 	int pkt_block_size;
 	void *ocmc_ram;
+	__be16 proto;
 
-	if (PRUETH_IS_HSR(emac->prueth))
-		start_offset = (pkt_info->start_offset ?
-				ICSSM_LRE_TAG_SIZE : 0);
 	/* the PRU firmware deals mostly in pointers already
 	 * offset into ram, we would like to deal in indexes
 	 * within the queue we are working with for code
@@ -731,6 +843,8 @@ int icssm_emac_rx_packet(struct prueth_emac *emac, u16 *bd_rd_ptr,
 	buffer_desc_count = icssm_get_buff_desc_count(rxqueue);
 	read_block = (*bd_rd_ptr - rxqueue->buffer_desc_offset) / BD_SIZE;
 	pkt_block_size = DIV_ROUND_UP(pkt_info->length, ICSS_BLOCK_SIZE);
+	/* OCMC RAM is not cached and read order is not important */
+	ocmc_ram = (__force void *)emac->prueth->mem[PRUETH_MEM_OCMC].va;
 
 	/* calculate end BD address post read */
 	update_block = read_block + pkt_block_size;
@@ -742,11 +856,36 @@ int icssm_emac_rx_packet(struct prueth_emac *emac, u16 *bd_rd_ptr,
 			buffer_wrapped = true;
 	}
 
+	/* Get the start address of the first buffer from
+	 * the read buffer description
+	 */
+	src_addr = ocmc_ram + rxqueue->buffer_offset +
+		   (read_block * ICSS_BLOCK_SIZE);
+
 	/* calculate new pointer in ram */
 	*bd_rd_ptr = rxqueue->buffer_desc_offset + (update_block * BD_SIZE);
 
-	/* Exclude the HSR tag bytes already stripped by firmware, if any. */
-	actual_pkt_len = pkt_info->length - start_offset;
+	if (PRUETH_IS_HSR(emac->prueth)) {
+		if (!pkt_info->host_recv_flag)
+			return 0;
+
+		ethhdr = (struct ethhdr *)src_addr;
+		proto = ethhdr->h_proto;
+
+		if (proto == htons(ETH_P_8021Q)) {
+			has_vlan = true;
+			vlan_hdr = (struct vlan_ethhdr *)ethhdr;
+			proto = vlan_hdr->h_vlan_encapsulated_proto;
+		}
+
+		if (proto == htons(ETH_P_HSR) && !pkt_info->timestamp)
+			has_hsr_tag = true;
+	}
+
+	actual_pkt_len = pkt_info->length;
+
+	if (has_hsr_tag)
+		actual_pkt_len -= ICSSM_LRE_TAG_SIZE;
 
 	/* Allocate a socket buffer for this packet */
 	skb = netdev_alloc_skb_ip_align(ndev, actual_pkt_len);
@@ -758,15 +897,23 @@ int icssm_emac_rx_packet(struct prueth_emac *emac, u16 *bd_rd_ptr,
 
 	dst_addr = skb->data;
 
-	/* OCMC RAM is not cached and read order is not important */
-	ocmc_ram = (__force void *)emac->prueth->mem[PRUETH_MEM_OCMC].va;
+	/* Copy destination and source MAC address */
+	memcpy(dst_addr, src_addr, PRUETH_ETHER_TYPE_OFFSET);
+	src_addr += PRUETH_ETHER_TYPE_OFFSET;
+	dst_addr += PRUETH_ETHER_TYPE_OFFSET;
 
-	/* Get the start address of the first buffer from
-	 * the read buffer description
-	 */
-	src_addr = ocmc_ram + rxqueue->buffer_offset +
-		   (read_block * ICSS_BLOCK_SIZE);
-	src_addr += start_offset;
+	adjust_for_hsr_tag += PRUETH_ETHER_TYPE_OFFSET;
+
+	if (has_vlan) {
+		memcpy(dst_addr, src_addr, VLAN_HLEN);
+		src_addr += VLAN_HLEN;
+		dst_addr += VLAN_HLEN;
+		adjust_for_hsr_tag += VLAN_HLEN;
+	}
+
+	/* HSR tag removal handling */
+	if (has_hsr_tag)
+		src_addr += ICSSM_LRE_TAG_SIZE;
 
 	/* Copy the data from PRU buffers(OCMC) to socket buffer(DRAM) */
 	if (buffer_wrapped) { /* wrapped around buffer */
@@ -780,22 +927,23 @@ int icssm_emac_rx_packet(struct prueth_emac *emac, u16 *bd_rd_ptr,
 		if (pkt_info->length < bytes)
 			bytes = pkt_info->length;
 
-		/* If applicable, account for the HSR tag removed */
-		bytes -= start_offset;
+		if (has_hsr_tag)
+			bytes -= ICSSM_LRE_TAG_SIZE;
 
 		/* copy non-wrapped part */
-		memcpy(dst_addr, src_addr, bytes);
+		memcpy(dst_addr, src_addr, bytes - adjust_for_hsr_tag);
 
 		/* copy wrapped part */
-		dst_addr += bytes;
+		dst_addr += (bytes - adjust_for_hsr_tag);
 		remaining = actual_pkt_len - bytes;
 
 		src_addr = ocmc_ram + rxqueue->buffer_offset;
 		memcpy(dst_addr, src_addr, remaining);
 		src_addr += remaining;
 	} else {
-		memcpy(dst_addr, src_addr, actual_pkt_len);
-		src_addr += actual_pkt_len;
+		memcpy(dst_addr, src_addr, actual_pkt_len -
+		       adjust_for_hsr_tag);
+		src_addr += actual_pkt_len - adjust_for_hsr_tag;
 	}
 
 	if (PRUETH_IS_SWITCH(emac->prueth)) {
@@ -1313,17 +1461,31 @@ static enum netdev_tx icssm_emac_ndo_start_xmit(struct sk_buff *skb,
 						struct net_device *ndev)
 {
 	struct prueth_emac *emac = netdev_priv(ndev);
+	/* Spinlock for Tx Queues */
+	spinlock_t *lock_queue;
+	unsigned long flags;
 	int ret;
 	u16 qid;
 
 	qid = icssm_prueth_get_tx_queue_id(emac->prueth, skb);
+	/* Select the TX queue spin lock for this queue ID */
+	if (prueth_is_lre(emac->prueth))
+		lock_queue = &emac->prueth->lre_host_queue_lock[qid - 2];
+	else
+		lock_queue = &emac->host_queue_lock[qid - 2];
+
+	if (eth_skb_pad(skb)) {
+		if (netif_msg_tx_err(emac) && net_ratelimit())
+			netdev_err(ndev, "packet pad failed\n");
+		atomic64_inc(&emac->stats.tx_dropped);
+		return NETDEV_TX_OK;
+	}
+
+	spin_lock_irqsave(lock_queue, flags);
 	ret = icssm_prueth_tx_enqueue(emac, skb, qid);
-	if (ret) {
-		if (ret != -ENOBUFS && netif_msg_tx_err(emac) &&
-		    net_ratelimit())
-			netdev_err(ndev, "packet queue failed: %d\n", ret);
+	spin_unlock_irqrestore(lock_queue, flags);
+	if (ret)
 		goto fail_tx;
-	}
 
 	atomic64_inc(&emac->stats.tx_packets);
 	atomic64_add(skb->len, &emac->stats.tx_bytes);
@@ -1338,10 +1500,6 @@ static enum netdev_tx icssm_emac_ndo_start_xmit(struct sk_buff *skb,
 			      us_to_ktime(HR_TIMER_TX_DELAY_US),
 			      HRTIMER_MODE_REL_PINNED);
 		ret = NETDEV_TX_BUSY;
-	} else {
-		/* error */
-		atomic64_inc(&emac->stats.tx_dropped);
-		ret = NET_XMIT_DROP;
 	}
 
 	return ret;
@@ -1568,19 +1726,22 @@ static void icssm_emac_ndo_set_rx_mode(struct net_device *ndev)
 static netdev_features_t icssm_emac_ndo_fix_features(struct net_device *ndev,
 						     netdev_features_t features)
 {
-	/* hsr tag removal offload and hsr fwd offload are tightly coupled in
-	 * firmware implementation. Both these features need to be enabled /
-	 * disabled together.
+	/* hsr tag removal offload, hsr fwd offload and hsr dup offload are
+	 * tightly coupled in firmware implementation. These features
+	 * must always be enabled/disabled together.
 	 */
 	if (!(ndev->features & NETIF_PRUETH_LRE_OFFLOAD_FEATURES))
 		if ((features & NETIF_F_HW_HSR_FWD) ||
-		    (features & NETIF_F_HW_HSR_TAG_RM))
+		    (features & NETIF_F_HW_HSR_TAG_RM) ||
+		    (features & NETIF_F_HW_HSR_DUP))
 			features |= NETIF_PRUETH_LRE_OFFLOAD_FEATURES;
 
 	if ((ndev->features & NETIF_F_HW_HSR_FWD) ||
-	    (ndev->features & NETIF_F_HW_HSR_TAG_RM))
+	    (ndev->features & NETIF_F_HW_HSR_TAG_RM) ||
+	    (ndev->features & NETIF_F_HW_HSR_DUP))
 		if (!(features & NETIF_F_HW_HSR_FWD) ||
-		    !(features & NETIF_F_HW_HSR_TAG_RM))
+		    !(features & NETIF_F_HW_HSR_TAG_RM) ||
+		    !(features & NETIF_F_HW_HSR_DUP))
 			features &= ~NETIF_PRUETH_LRE_OFFLOAD_FEATURES;
 
 	return features;
@@ -1786,6 +1947,9 @@ static int icssm_prueth_netdev_init(struct prueth *prueth,
 	spin_lock_init(&emac->lock);
 	spin_lock_init(&emac->addr_lock);
 
+	spin_lock_init(&emac->host_queue_lock[0]);
+	spin_lock_init(&emac->host_queue_lock[1]);
+
 	/* get mac address from DT and set private and netdev addr */
 	ret = of_get_ethdev_address(eth_node, ndev);
 	if (!is_valid_ether_addr(ndev->dev_addr)) {
@@ -2383,6 +2547,8 @@ static int icssm_prueth_probe(struct platform_device *pdev)
 
 	prueth->support_lre = has_lre;
 	spin_lock_init(&prueth->addr_lock);
+	spin_lock_init(&prueth->lre_host_queue_lock[0]);
+	spin_lock_init(&prueth->lre_host_queue_lock[1]);
 	/* setup netdev interfaces */
 	if (eth0_node) {
 		ret = icssm_prueth_netdev_init(prueth, eth0_node);
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.h b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
index 8cca5b87d4ff..9ed4176b66fa 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth.h
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
@@ -94,7 +94,7 @@ struct prueth_queue_info {
  * struct prueth_packet_info - Info about a packet in buffer
  * @start_offset: true if frame carries an HSR/PRP start offset
  * @shadow: this packet is stored in the collision queue
- * @port: port packet is on
+ * @host_recv_flag: this frame should be received by host
  * @length: length of packet
  * @broadcast: this packet is a broadcast packet
  * @error: this packet has an error
@@ -105,7 +105,7 @@ struct prueth_queue_info {
 struct prueth_packet_info {
 	bool start_offset;
 	bool shadow;
-	unsigned int port;
+	bool host_recv_flag;
 	unsigned int length;
 	bool broadcast;
 	bool error;
@@ -240,6 +240,8 @@ struct prueth_emac {
 	struct phy_device *phydev;
 	struct prueth_queue_desc __iomem *rx_queue_descs;
 	struct prueth_queue_desc __iomem *tx_queue_descs;
+	/* LRE duplicates each TX frame to both ports */
+	struct prueth_queue_desc __iomem *tx_queue_descs_other_port;
 
 	int link;
 	int speed;
@@ -263,6 +265,7 @@ struct prueth_emac {
 	spinlock_t lock;
 	spinlock_t addr_lock;   /* serialize access to VLAN/MC filter table */
 
+	spinlock_t host_queue_lock[NUM_QUEUES / 2];
 	struct hrtimer tx_hrtimer;
 	struct prueth_emac_stats stats;
 	int offload_fwd_mark;
@@ -314,9 +317,15 @@ struct prueth {
 	u8 emac_configured;
 	u8 hsr_members;
 	u8 br_members;
+
+	/* Per-queue TX lock - LRE uses only two priority queues
+	 * one for high priority and the other for low priority.
+	 */
+	spinlock_t lre_host_queue_lock[NUM_QUEUES / 2];
 };
 
 extern const struct prueth_queue_desc queue_descs[][NUM_QUEUES];
+extern const struct prueth_queue_desc hsr_prp_txopt_queue_descs[][NUM_QUEUES];
 
 void icssm_parse_packet_info(struct prueth *prueth, u32 buffer_descriptor,
 			     struct prueth_packet_info *pkt_info);
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c b/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c
index 1a5e5a84345e..de61304e2011 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c
@@ -161,16 +161,17 @@ static int icssm_prueth_common_emac_rx_packets(struct prueth_emac *emac,
 			used++;
 		}
 
-		/* Zero the BD after consuming it, a misaligned rd_ptr
-		 * would otherwise mistake stale data for a valid incoming
-		 * frame.
+		/* Leave the BD intact after reading. Firmware reuses it to
+		 * forward the frame to the second LRE port.
 		 */
 		if (port == 0) {
-			writel(0, shared_ram + bd_rd_ptr);
+			if (PRUETH_IS_SWITCH(prueth))
+				writel(0, shared_ram + bd_rd_ptr);
 			writew(update_rd_ptr, &queue_desc->rd_ptr);
 			bd_rd_ptr = update_rd_ptr;
 		} else {
-			writel(0, shared_ram + bd_rd_ptr_o);
+			if (PRUETH_IS_SWITCH(prueth))
+				writel(0, shared_ram + bd_rd_ptr_o);
 			writew(update_rd_ptr, &queue_desc_o->rd_ptr);
 			bd_rd_ptr_o = update_rd_ptr;
 		}
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c
index 9d67fc7c23ac..7bc65b2901cb 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c
@@ -199,6 +199,189 @@ static const struct prueth_queue_info rx_queue_infos[][NUM_QUEUES] = {
 	},
 };
 
+/* Tx Queue context for HSR and PRP */
+const struct prueth_queue_info lre_queue_infos[][NUM_QUEUES] = {
+	[PRUETH_PORT_QUEUE_HOST] = {
+		[PRUETH_QUEUE1] = {
+			P0_Q1_BUFFER_OFFSET,
+			P0_QUEUE_DESC_OFFSET,
+			P0_Q1_BD_OFFSET,
+			P0_Q1_BD_OFFSET + ((HOST_QUEUE_1_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE2] = {
+			P0_Q2_BUFFER_OFFSET,
+			P0_QUEUE_DESC_OFFSET + 8,
+			P0_Q2_BD_OFFSET,
+			P0_Q2_BD_OFFSET + ((HOST_QUEUE_2_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE3] = {
+			P0_Q3_BUFFER_OFFSET,
+			P0_QUEUE_DESC_OFFSET + 16,
+			P0_Q3_BD_OFFSET,
+			P0_Q3_BD_OFFSET + ((HOST_QUEUE_3_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE4] = {
+			P0_Q4_BUFFER_OFFSET,
+			P0_QUEUE_DESC_OFFSET + 24,
+			P0_Q4_BD_OFFSET,
+			P0_Q4_BD_OFFSET + ((HOST_QUEUE_4_SIZE - 1) * BD_SIZE),
+		},
+	},
+	[PRUETH_PORT_QUEUE_MII0] = {
+		[PRUETH_QUEUE1] = {
+			P0_Q3_BUFFER_OFFSET,
+			P0_Q3_BUFFER_OFFSET +
+				((HOST_QUEUE_3_SIZE - 1) * ICSS_BLOCK_SIZE),
+			P0_Q3_BD_OFFSET,
+			P0_Q3_BD_OFFSET + ((HOST_QUEUE_1_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE2] = {
+			P0_Q4_BUFFER_OFFSET,
+			P0_Q4_BUFFER_OFFSET +
+				((HOST_QUEUE_4_SIZE - 1) * ICSS_BLOCK_SIZE),
+			P0_Q4_BD_OFFSET,
+			P0_Q4_BD_OFFSET + ((HOST_QUEUE_2_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE3] = {
+			P1_Q3_TXOPT_BUFFER_OFFSET,
+			P1_Q3_TXOPT_BUFFER_OFFSET +
+				((QUEUE_3_TXOPT_SIZE - 1) * ICSS_BLOCK_SIZE),
+			P1_Q3_TXOPT_BD_OFFSET,
+			P1_Q3_TXOPT_BD_OFFSET +
+				((QUEUE_3_TXOPT_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE4] = {
+			P2_Q1_TXOPT_BUFFER_OFFSET,
+			P2_Q1_TXOPT_BUFFER_OFFSET +
+				((QUEUE_4_TXOPT_SIZE - 1) * ICSS_BLOCK_SIZE),
+			P2_Q1_TXOPT_BD_OFFSET,
+			P2_Q1_TXOPT_BD_OFFSET +
+				((QUEUE_4_TXOPT_SIZE - 1) * BD_SIZE),
+		},
+	},
+	[PRUETH_PORT_QUEUE_MII1] = {
+		[PRUETH_QUEUE1] = {
+			P0_Q1_BUFFER_OFFSET,
+			P0_Q1_BUFFER_OFFSET +
+				((HOST_QUEUE_1_SIZE - 1) * ICSS_BLOCK_SIZE),
+			P0_Q1_BD_OFFSET,
+			P0_Q1_BD_OFFSET +
+				((HOST_QUEUE_1_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE2] = {
+			P0_Q2_BUFFER_OFFSET,
+			P0_Q2_BUFFER_OFFSET +
+				((HOST_QUEUE_2_SIZE - 1) * ICSS_BLOCK_SIZE),
+			P0_Q2_BD_OFFSET,
+			P0_Q2_BD_OFFSET +
+				((HOST_QUEUE_2_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE3] = {
+			P1_Q3_TXOPT_BUFFER_OFFSET,
+			P1_Q3_TXOPT_BUFFER_OFFSET +
+				((QUEUE_3_TXOPT_SIZE - 1) * ICSS_BLOCK_SIZE),
+			P1_Q3_TXOPT_BD_OFFSET,
+			P1_Q3_TXOPT_BD_OFFSET +
+				((QUEUE_3_TXOPT_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE4] = {
+			P2_Q1_TXOPT_BUFFER_OFFSET,
+			P2_Q1_TXOPT_BUFFER_OFFSET +
+				((QUEUE_4_TXOPT_SIZE - 1) * ICSS_BLOCK_SIZE),
+			P2_Q1_TXOPT_BD_OFFSET,
+			P2_Q1_TXOPT_BD_OFFSET +
+				((QUEUE_4_TXOPT_SIZE - 1) * BD_SIZE),
+		},
+
+	},
+};
+
+/* Rx Queue Context for HSR and PRP */
+static const struct prueth_queue_info lre_rx_queue_infos[][NUM_QUEUES] = {
+	[PRUETH_PORT_QUEUE_HOST] = {
+		[PRUETH_QUEUE1] = {
+			P0_Q1_BUFFER_OFFSET,
+			HOST_QUEUE_DESC_OFFSET,
+			P0_Q1_BD_OFFSET,
+			P0_Q1_BD_OFFSET + ((HOST_QUEUE_1_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE2] = {
+			P0_Q2_BUFFER_OFFSET,
+			HOST_QUEUE_DESC_OFFSET + 8,
+			P0_Q2_BD_OFFSET,
+			P0_Q2_BD_OFFSET + ((HOST_QUEUE_2_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE3] = {
+			P0_Q3_BUFFER_OFFSET,
+			HOST_QUEUE_DESC_OFFSET + 16,
+			P0_Q3_BD_OFFSET,
+			P0_Q3_BD_OFFSET + ((HOST_QUEUE_3_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE4] = {
+			P0_Q4_BUFFER_OFFSET,
+			HOST_QUEUE_DESC_OFFSET + 24,
+			P0_Q4_BD_OFFSET,
+			P0_Q4_BD_OFFSET + ((HOST_QUEUE_4_SIZE - 1) * BD_SIZE),
+		},
+	},
+	[PRUETH_PORT_QUEUE_MII0] = {
+		[PRUETH_QUEUE1] = {
+			P0_Q3_BUFFER_OFFSET,
+			P1_QUEUE_DESC_OFFSET,
+			P0_Q3_BD_OFFSET,
+			P0_Q3_BD_OFFSET + ((HOST_QUEUE_3_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE2] = {
+			P0_Q4_BUFFER_OFFSET,
+			P1_QUEUE_DESC_OFFSET + 8,
+			P0_Q4_BD_OFFSET,
+			P0_Q4_BD_OFFSET + ((HOST_QUEUE_4_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE3] = {
+			P1_Q3_TXOPT_BUFFER_OFFSET,
+			P1_QUEUE_DESC_OFFSET + 16,
+			P1_Q3_TXOPT_BD_OFFSET,
+			P1_Q3_TXOPT_BD_OFFSET +
+				((QUEUE_3_TXOPT_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE4] = {
+			P2_Q1_TXOPT_BUFFER_OFFSET,
+			P1_QUEUE_DESC_OFFSET + 24,
+			P2_Q1_TXOPT_BD_OFFSET,
+			P2_Q1_TXOPT_BD_OFFSET +
+				((QUEUE_4_TXOPT_SIZE - 1) * BD_SIZE),
+		},
+	},
+	[PRUETH_PORT_QUEUE_MII1] = {
+		[PRUETH_QUEUE1] = {
+			P0_Q1_BUFFER_OFFSET,
+			P2_QUEUE_DESC_OFFSET,
+			P0_Q1_BD_OFFSET,
+			P0_Q1_BD_OFFSET + ((HOST_QUEUE_1_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE2] = {
+			P0_Q2_BUFFER_OFFSET,
+			P2_QUEUE_DESC_OFFSET + 8,
+			P0_Q2_BD_OFFSET,
+			P0_Q2_BD_OFFSET + ((HOST_QUEUE_2_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE3] = {
+			P1_Q3_TXOPT_BUFFER_OFFSET,
+			P2_QUEUE_DESC_OFFSET + 16,
+			P1_Q3_TXOPT_BD_OFFSET,
+			P1_Q3_TXOPT_BD_OFFSET +
+				((QUEUE_3_TXOPT_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE4] = {
+			P2_Q1_TXOPT_BUFFER_OFFSET,
+			P2_QUEUE_DESC_OFFSET + 24,
+			P2_Q1_TXOPT_BD_OFFSET,
+			P2_Q1_TXOPT_BD_OFFSET +
+				((QUEUE_4_TXOPT_SIZE - 1) * BD_SIZE),
+		},
+	},
+};
+
 void icssm_prueth_sw_free_fdb_table(struct prueth *prueth)
 {
 	if (prueth->emac_configured)
@@ -856,8 +1039,12 @@ void icssm_prueth_sw_hostconfig(struct prueth *prueth)
 
 	/* queue information table */
 	dram = dram1_base + P0_Q1_RX_CONTEXT_OFFSET;
-	memcpy_toio(dram, sw_queue_infos[PRUETH_PORT_QUEUE_HOST],
-		    sizeof(sw_queue_infos[PRUETH_PORT_QUEUE_HOST]));
+	if (prueth_is_lre(prueth))
+		memcpy_toio(dram, lre_queue_infos[PRUETH_PORT_QUEUE_HOST],
+			    sizeof(lre_queue_infos[PRUETH_PORT_QUEUE_HOST]));
+	else
+		memcpy_toio(dram, sw_queue_infos[PRUETH_PORT_QUEUE_HOST],
+			    sizeof(sw_queue_infos[PRUETH_PORT_QUEUE_HOST]));
 
 	/* buffer descriptor offset table*/
 	dram = dram1_base + QUEUE_DESCRIPTOR_OFFSET_ADDR;
@@ -882,8 +1069,15 @@ void icssm_prueth_sw_hostconfig(struct prueth *prueth)
 
 	/* queue table */
 	dram = dram1_base + P0_QUEUE_DESC_OFFSET;
-	memcpy_toio(dram, queue_descs[PRUETH_PORT_QUEUE_HOST],
-		    sizeof(queue_descs[PRUETH_PORT_QUEUE_HOST]));
+	if (prueth_is_lre(prueth))
+		memcpy_toio(dram,
+			    hsr_prp_txopt_queue_descs[PRUETH_PORT_QUEUE_HOST],
+			    sizeof(hsr_prp_txopt_queue_descs
+				    [PRUETH_PORT_QUEUE_HOST]));
+	else
+		memcpy_toio(dram, queue_descs[PRUETH_PORT_QUEUE_HOST],
+			    sizeof(queue_descs[PRUETH_PORT_QUEUE_HOST]));
+
 }
 
 void icssm_prueth_sw_config_packet_timestamping(struct prueth *prueth)
@@ -898,7 +1092,7 @@ static int icssm_prueth_sw_port_config(struct prueth *prueth,
 				       enum prueth_port port_id)
 {
 	unsigned int tx_context_ofs_addr, rx_context_ofs, queue_desc_ofs;
-	void __iomem *dram, *dram_base, *dram_mac;
+	void __iomem *dram, *dram_base;
 	struct prueth_emac *emac;
 	void __iomem *dram1_base;
 
@@ -909,26 +1103,17 @@ static int icssm_prueth_sw_port_config(struct prueth *prueth,
 		tx_context_ofs_addr     = TX_CONTEXT_P1_Q1_OFFSET_ADDR;
 		rx_context_ofs          = P1_Q1_RX_CONTEXT_OFFSET;
 		queue_desc_ofs          = P1_QUEUE_DESC_OFFSET;
-
-		/* for switch PORT MII0 mac addr is in DRAM0. */
-		dram_mac = prueth->mem[PRUETH_MEM_DRAM0].va;
 		break;
 	case PRUETH_PORT_MII1:
 		tx_context_ofs_addr     = TX_CONTEXT_P2_Q1_OFFSET_ADDR;
 		rx_context_ofs          = P2_Q1_RX_CONTEXT_OFFSET;
 		queue_desc_ofs          = P2_QUEUE_DESC_OFFSET;
-
-		/* for switch PORT MII1 mac addr is in DRAM1. */
-		dram_mac = prueth->mem[PRUETH_MEM_DRAM1].va;
 		break;
 	default:
 		netdev_err(emac->ndev, "invalid port\n");
 		return -EINVAL;
 	}
 
-	/* setup mac address */
-	memcpy_toio(dram_mac + PORT_MAC_ADDR, emac->mac_addr, 6);
-
 	/* Remaining switch port configs are in DRAM1 */
 	dram_base = prueth->mem[PRUETH_MEM_DRAM1].va;
 
@@ -983,21 +1168,129 @@ static int icssm_prueth_sw_port_config(struct prueth *prueth,
 	return 0;
 }
 
+/* Configure TX/RX queue contexts and buffer descriptor tables for LRE port */
+static void icssm_prueth_lre_port_config(struct prueth *prueth,
+					 enum prueth_port port_id)
+{
+	unsigned int tx_context_ofs_addr, rx_context_ofs, queue_desc_ofs;
+	void __iomem *dram, *dram_base;
+	struct prueth_emac *emac;
+
+	if (port_id == PRUETH_PORT_MII0) {
+		tx_context_ofs_addr     = TX_CONTEXT_P1_Q1_OFFSET_ADDR;
+		rx_context_ofs          = P1_Q1_RX_CONTEXT_OFFSET;
+		queue_desc_ofs          = P1_QUEUE_DESC_OFFSET;
+	} else if (port_id ==  PRUETH_PORT_MII1) {
+		tx_context_ofs_addr     = TX_CONTEXT_P2_Q1_OFFSET_ADDR;
+		rx_context_ofs          = P2_Q1_RX_CONTEXT_OFFSET;
+		queue_desc_ofs          = P2_QUEUE_DESC_OFFSET;
+	} else {
+		dev_err(prueth->dev, "invalid port %d\n", port_id);
+		return;
+	}
+
+	emac = prueth->emac[port_id - 1];
+	/* Remaining switch port configs are in DRAM1 */
+	dram_base = prueth->mem[PRUETH_MEM_DRAM1].va;
+
+	/* queue information table */
+	memcpy_toio(dram_base + tx_context_ofs_addr,
+		    lre_queue_infos[port_id],
+		    sizeof(lre_queue_infos[port_id]));
+
+	memcpy_toio(dram_base + rx_context_ofs,
+		    lre_rx_queue_infos[port_id],
+		    sizeof(lre_rx_queue_infos[port_id]));
+
+	/* buffer descriptor offset table*/
+	dram = dram_base + QUEUE_DESCRIPTOR_OFFSET_ADDR +
+		(port_id * NUM_QUEUES * sizeof(u16));
+	writew(lre_queue_infos[port_id][PRUETH_QUEUE1].buffer_desc_offset,
+	       dram);
+	writew(lre_queue_infos[port_id][PRUETH_QUEUE2].buffer_desc_offset,
+	       dram + 2);
+	writew(lre_queue_infos[port_id][PRUETH_QUEUE3].buffer_desc_offset,
+	       dram + 4);
+	writew(lre_queue_infos[port_id][PRUETH_QUEUE4].buffer_desc_offset,
+	       dram + 6);
+
+	/* buffer offset table */
+	dram = dram_base + QUEUE_OFFSET_ADDR +
+		port_id * NUM_QUEUES * sizeof(u16);
+	writew(lre_queue_infos[port_id][PRUETH_QUEUE1].buffer_offset, dram);
+	writew(lre_queue_infos[port_id][PRUETH_QUEUE2].buffer_offset,
+	       dram + 2);
+	writew(lre_queue_infos[port_id][PRUETH_QUEUE3].buffer_offset,
+	       dram + 4);
+	writew(lre_queue_infos[port_id][PRUETH_QUEUE4].buffer_offset,
+	       dram + 6);
+
+	/* queue size lookup table */
+	dram = dram_base + QUEUE_SIZE_ADDR +
+		port_id * NUM_QUEUES * sizeof(u16);
+	writew(HOST_QUEUE_1_SIZE, dram);
+	writew(HOST_QUEUE_2_SIZE, dram + 2);
+	writew(QUEUE_3_TXOPT_SIZE, dram + 4);
+	writew(QUEUE_4_TXOPT_SIZE, dram + 6);
+
+	/* queue table */
+	memcpy_toio(dram_base + queue_desc_ofs,
+		    &hsr_prp_txopt_queue_descs[port_id][0],
+		    4 * sizeof(hsr_prp_txopt_queue_descs[port_id][0]));
+
+	/* In HSR/PRP mode both slave ports share the host receive queue
+	 * descriptor region (P0_QUEUE_DESC_OFFSET). The firmware arbitrates
+	 * ownership; the driver always reads from the same host-side descriptor
+	 * base regardless of which physical port the frame arrived on.
+	 */
+	emac->rx_queue_descs = dram_base + P0_QUEUE_DESC_OFFSET;
+	emac->tx_queue_descs = dram_base +
+		lre_rx_queue_infos[port_id][PRUETH_QUEUE1].queue_desc_offset;
+
+	if (port_id == PRUETH_PORT_MII0) {
+		emac->tx_queue_descs_other_port = dram_base +
+			lre_rx_queue_infos
+			[port_id + 1][PRUETH_QUEUE1].queue_desc_offset;
+	} else if (port_id == PRUETH_PORT_MII1) {
+		emac->tx_queue_descs_other_port = dram_base +
+			lre_rx_queue_infos
+			[port_id - 1][PRUETH_QUEUE1].queue_desc_offset;
+	}
+}
+
 int icssm_prueth_sw_emac_config(struct prueth_emac *emac)
 {
 	struct prueth *prueth = emac->prueth;
 	u32 sharedramaddr, ocmcaddr;
-	int ret;
+	void __iomem *dram_mac;
+	int ret = 0;
 
 	/* PRU needs local shared RAM address for C28 */
 	sharedramaddr = ICSS_LOCAL_SHARED_RAM;
 	/* PRU needs real global OCMC address for C30*/
 	ocmcaddr = (u32)prueth->mem[PRUETH_MEM_OCMC].pa;
 
+	if (emac->port_id == PRUETH_PORT_MII0) {
+		dram_mac = prueth->mem[PRUETH_MEM_DRAM0].va;
+	} else if (emac->port_id == PRUETH_PORT_MII1) {
+		dram_mac = prueth->mem[PRUETH_MEM_DRAM1].va;
+	} else {
+		netdev_err(emac->ndev, "invalid port\n");
+		return -EINVAL;
+	}
+
+	/* setup mac address */
+	memcpy_toio(dram_mac + PORT_MAC_ADDR, emac->mac_addr, ETH_ALEN);
+
 	if (prueth->emac_configured & BIT(emac->port_id))
 		return 0;
 
-	ret = icssm_prueth_sw_port_config(prueth, emac->port_id);
+	if (prueth_is_lre(prueth) && !prueth->emac_configured) {
+		icssm_prueth_lre_port_config(prueth, PRUETH_PORT_MII0);
+		icssm_prueth_lre_port_config(prueth, PRUETH_PORT_MII1);
+	} else if (PRUETH_IS_SWITCH(prueth)) {
+		ret = icssm_prueth_sw_port_config(prueth, emac->port_id);
+	}
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h
index fe7197f9a6da..a009827b01d7 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h
@@ -17,6 +17,7 @@ u8 icssm_prueth_sw_get_stp_state(struct prueth *prueth,
 				 enum prueth_port port);
 
 extern const struct prueth_queue_info sw_queue_infos[][4];
+extern const struct prueth_queue_info lre_queue_infos[][4];
 
 void icssm_prueth_sw_fdb_tbl_init(struct prueth *prueth);
 int icssm_prueth_sw_init_fdb_table(struct prueth *prueth);
diff --git a/drivers/net/ethernet/ti/icssm/icssm_switch.h b/drivers/net/ethernet/ti/icssm/icssm_switch.h
index b4d6b8660539..ec5925c812c3 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_switch.h
+++ b/drivers/net/ethernet/ti/icssm/icssm_switch.h
@@ -24,6 +24,9 @@
 #define QUEUE_3_SIZE		97	/* Protocol specific */
 #define QUEUE_4_SIZE		97	/* NRT (IP,ARP, ICMP) */
 
+#define QUEUE_3_TXOPT_SIZE	194	/* Protocol specific - High Priority */
+#define QUEUE_4_TXOPT_SIZE	194	/* NRT(IP,ARP, ICMP) - Low Priority*/
+
 /* Host queue size (number of BDs). Each BD points to data buffer of 32 bytes.
  * HOST PORT QUEUES can buffer up to 4 full sized frames per queue
  */
@@ -51,18 +54,19 @@
  *				address found in FDB). For switch only.
  * 8..12	Block_length	number of valid bytes in this specific block.
  *				Will be <=32 bytes on last block of packet
+ * 8		RED_INFO	Set if the frame carries an HSR or PRP
+ *				redundancy tag
+ * 10		HostRecv	Set if the frame is destined for the host port.
+ *				For HSR only.
  * 13		More		"More" bit indicating that there are more blocks
  * 14		Shadow		indicates that "index" is pointing into shadow
  *				buffer
  * 15		TimeStamp	indicates that this packet has time stamp in
  *				separate buffer - only needed if PTP runs on
  *				host
- * 16..17	Port		different meaning for ingress and egress,
- *				Ingress: Port = 0 indicates phy port 1 and
- *				Port = 1 indicates phy port 2.
- *				Egress: 0 sends on phy port 1 and 1 sends on
- *				phy port 2. Port = 2 goes over MAC table
- *				look-up
+ * 16..17	LAN		Destination LAN for transmission:
+ *				bit 16 = LAN A, bit 17 = LAN B, set both to
+ *				duplicate to both LANs. For HSR and PRP only.
  * 18..28	Length		11 bit of total packet length which is put into
  *				first BD only so that host access only one BD
  * 29		VlanTag		indicates that packet has Length/Type field of
@@ -86,14 +90,21 @@
 #define PRUETH_BD_SW_FLOOD_MASK		BIT(7)
 #define PRUETH_BD_SW_FLOOD_SHIFT	7
 
+#define PRUETH_BD_RED_PKT_MASK		BIT(8)
+#define PRUETH_BD_RED_PKT		8
+
+#define PRUETH_BD_HOST_RECV_MASK	BIT(10)
+#define PRUETH_BD_HOST_RECV_SHIFT	10
+
 #define	PRUETH_BD_SHADOW_MASK		BIT(14)
 #define	PRUETH_BD_SHADOW_SHIFT		14
 
 #define PRUETH_BD_TIMESTAMP_MASK	BIT(15)
 #define PRUETH_BD_TIMESTAMP_SHIFT	15
 
-#define PRUETH_BD_PORT_MASK		GENMASK(17, 16)
-#define PRUETH_BD_PORT_SHIFT		16
+#define PRUETH_BD_LAN_INFO_MASK		GENMASK(17, 16)
+#define PRUETH_BD_LAN_A_SHIFT		16
+#define PRUETH_BD_LAN_B_SHIFT		17
 
 #define PRUETH_BD_LENGTH_MASK		GENMASK(28, 18)
 #define PRUETH_BD_LENGTH_SHIFT		18
@@ -298,6 +309,9 @@
 #define P0_Q4_BD_OFFSET		(P0_Q3_BD_OFFSET + HOST_QUEUE_3_SIZE * BD_SIZE)
 #define P0_Q3_BD_OFFSET		(P0_Q2_BD_OFFSET + HOST_QUEUE_2_SIZE * BD_SIZE)
 #define P0_Q2_BD_OFFSET		(P0_Q1_BD_OFFSET + HOST_QUEUE_1_SIZE * BD_SIZE)
+#define P1_Q3_TXOPT_BD_OFFSET	(P0_Q4_BD_OFFSET + HOST_QUEUE_4_SIZE * BD_SIZE)
+#define P2_Q1_TXOPT_BD_OFFSET	(P1_Q3_TXOPT_BD_OFFSET +	\
+				 QUEUE_3_TXOPT_SIZE * BD_SIZE)
 #define P0_Q1_BD_OFFSET		P0_BUFFER_DESC_OFFSET
 #define P0_BUFFER_DESC_OFFSET	SRAM_START_OFFSET
 
@@ -334,6 +348,10 @@
 				 ICSS_BLOCK_SIZE)
 #define P0_Q2_BUFFER_OFFSET	(P0_Q1_BUFFER_OFFSET + HOST_QUEUE_1_SIZE * \
 				 ICSS_BLOCK_SIZE)
+#define P1_Q3_TXOPT_BUFFER_OFFSET	(P0_Q4_BUFFER_OFFSET +	\
+					 HOST_QUEUE_4_SIZE * ICSS_BLOCK_SIZE)
+#define P2_Q1_TXOPT_BUFFER_OFFSET	(P1_Q3_TXOPT_BUFFER_OFFSET +	\
+					 QUEUE_3_TXOPT_SIZE * ICSS_BLOCK_SIZE)
 #define P0_COL_BUFFER_OFFSET	0xEE00
 #define P0_Q1_BUFFER_OFFSET	0x0000
 
-- 
2.43.0

