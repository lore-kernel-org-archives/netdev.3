Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6448635C689
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 23:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788132156; cv=none; b=AwsyvNyQNvHgUzkR5oyVDr2FbY4vP60RlsxPH61IbWmuXscxjVeTjFpAJMsLq7KMUjOfFEDZpnGmrTQeOrDbI727Rkp8FvhEUQY9cAfzZJGGLqAgv1jNL8BNNAGx6RTTcPFe9VLGA9JakPMiOIvBV2/xklOJBCxL0FDP9b5e3jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788132156; c=relaxed/simple;
	bh=mmgvBcFtymlseFASQXnaQLnKNTQk9SVBLpHBBlzf5e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JA8DyTu9emQBpT7f0WhYCV2M0oYgmoFvxbWdHdpk/i1S9WT7hbi2NBrrtSoc0iIytPvPXLTEmGeZlgohxr6Zh19UY2PHvTHKYeKoAt0Afv0YJ8ie3lkBHHD9/cBGjp0B689ApEiaQFtrksjk4K5ikFkBbv5eLGdCIJQ4/4LmzZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lp+SMnf9; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lp+SMnf9"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-836cb2fa1bcso24897947b3.1
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 16:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788132153; x=1788736953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ak+cBos1K2MfmrjwEC9RXVrDJ2Ri6gB8fIo5x2F1eDw=;
        b=lp+SMnf9H+ZOWm8Wtq278SZSinnUkviGH4eC67oXn1EVEy8m8Sk3yxYN6GqSK/x72Q
         KvBSjwDtfwFEljf0ycRVii9OSOqAvaAOSB7N9fn9m3BvyqCqexoZ7FUYZ202o5TJDbIE
         9H9/CtcOrPLsR1zQKnzvpvSaj8VMmbg03QupArF3HRVu3qFa196F9tOsZkn3h44hp0dz
         4OyOlmYhMJyYs3eDmUayjDK+gWBenACk6yPY1HTDQjBThJa9w4VoJaBhx+Gnfvc+yrwl
         ++ua+NRc8Q80OWbxXjWotVl0GsK+ooqPjU2PpNIKh+fxAfpfAnGBJyJ3QmeCyY448r5c
         WJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788132153; x=1788736953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ak+cBos1K2MfmrjwEC9RXVrDJ2Ri6gB8fIo5x2F1eDw=;
        b=O6zrF+GL69+wB0Mj3hYV8LV887Zosp7WP1zHra9Ik40W3ti0jrW1q6dj3328edLHq9
         XK6Cm4ewObuN00QfnFf814+99EH9UU2rf+1EXpwyWPgi70nBDEem4bU4LnckI9AqmOqo
         Gb3XuWkkOumCMR0dgWnKC1FVPZMGp33O+yze22vRzpj3LEdyHSNnNXEPzmMAKfOqCWup
         XtPObXiNR/zq2E3GuF8mAieIOQrHL0Smai8JYY1lXNiNPe2/fhHVAyq//j21CyzKcYXH
         +Z2kNknNEoTuh/I2nQVdp/N7BJDPPqNu0/Q7qWkl2v1L7rYz761jN4RVek9WbWBJMq7a
         cVbg==
X-Gm-Message-State: AFuF++l800qw5Y5NQJ9flnZjMLImVA0GM8sMDZb8XhfPzZowXFPaidvT
	9I9O08Q03zRDeHhBW+WPkVN5IzRcrXHU3DZ6Iqaqt6h4cllnAicog1er
X-Gm-Gg: AYBFou2oU7HudKVUYj+y2Ywv0DeXY1NrKtd8FFiX8qLQB4SMeKcQ8jg6yZgkAiM8pdo
	8riu8AgB1asAvoPx7f1yR9pwO/UFTJlCowdrx8aEpRI7VXq7IU9rQt5r8iq1pwRjlYmyVzfXT9z
	Wf9xWSqC6wIHurdnv1YKInDpJR4XAeho86aA2s8GGN0zxMm5QOkAHYBv3EZW0ocFQGWMpwSvJQI
	cNB0Fl5u8ZST4lChsOi5TMPFooBPkNYNADwb0xz+z3HE5rWbvksP7nKeuDxi1AZsToFR/pMEutG
	e1TzTw01cBUNsWP1wQD7kmSZ32Vs9nYPc5AqOSv24a0S11bWVOtRJvcL12IKZ20gRkDDg0GSZWr
	dpQYSmBI03L9jlnxiK4xBmvZnxi1Hd/jLtLu8oEabbx2mlwZ6Q9TNewjlv2x0/5Baec/yZ0PcXs
	NSKPvPn/3gwJn96Bo/cNJWgwybTQKXz9kW0jY2/ANE
X-Received: by 2002:a05:690c:a5c3:b0:85c:3022:5486 with SMTP id 00721157ae682-85d6a9b0914mr67010167b3.13.1788132153246;
        Sun, 30 Aug 2026 16:22:33 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e677606aesm39025937b3.45.2026.08.30.16.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 16:22:32 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matt Vollrath <tactii@gmail.com>
Subject: [PATCH iwl-next 4/8] e1000e: remove packet-split Rx path
Date: Sun, 30 Aug 2026 19:21:42 -0400
Message-ID: <20260830232146.36948-5-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260830232146.36948-1-tactii@gmail.com>
References: <20260830232146.36948-1-tactii@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This approach to Rx has not stood the test of time. All other Intel
drivers have removed it. Do the same for e1000e.

Use the standard path for any MTU <=1518.

Use the jumbo path for any MTU >1518.

This may not be an ideal breakpoint, but the next step is factoring out
the breakpoint by converging on the jumbo Rx path with page pool.

Changes to e1000e_dump should only be removal of the ps path and
un-indentation of the other path from the switch, except the correct
sized u0 overlay is used instead of u1.

The rx_header_split statistic has been removed.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
Assisted-by: Claude:claude-5-fable
---
 drivers/net/ethernet/intel/e1000e/e1000.h   |  16 +-
 drivers/net/ethernet/intel/e1000e/ethtool.c |   1 -
 drivers/net/ethernet/intel/e1000e/netdev.c  | 637 +++-----------------
 3 files changed, 81 insertions(+), 573 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index 63ebe00376f5..533d1981eb5e 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -121,11 +121,6 @@ enum e1000_boards {
 	board_pch_ptp
 };
 
-struct e1000_ps_page {
-	struct page *page;
-	u64 dma; /* must be u64 - written to hw */
-};
-
 /* wrappers around a pointer to a socket buffer,
  * so a DMA handle can be stored along with the buffer
  */
@@ -143,11 +138,7 @@ struct e1000_buffer {
 			u16 mapped_as_page;
 		};
 		/* Rx */
-		struct {
-			/* arrays of page information for packet split */
-			struct e1000_ps_page *ps_pages;
-			struct page *page;
-		};
+		struct page *page;
 	};
 };
 
@@ -265,15 +256,12 @@ struct e1000_adapter {
 	/* Rx stats */
 	u64 hw_csum_err;
 	u64 hw_csum_good;
-	u64 rx_hdr_split;
 	u32 gorc;
 	u64 gorc_old;
 	u32 alloc_rx_buff_failed;
 	u32 rx_dma_failed;
 	u32 rx_hwtstamp_cleared;
 
-	unsigned int rx_ps_pages;
-	u16 rx_ps_bsize0;
 	u32 max_frame_size;
 	u32 min_frame_size;
 
@@ -464,8 +452,6 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *adapter, u32 *timinca);
 #define FLAG2_ENABLE_S0IX_FLOWS           BIT(15)
 #define FLAG2_DISABLE_K1		   BIT(16)
 
-#define E1000_RX_DESC_PS(R, i)	    \
-	(&(((union e1000_rx_desc_packet_split *)((R).desc))[i]))
 #define E1000_RX_DESC_EXT(R, i)	    \
 	(&(((union e1000_rx_desc_extended *)((R).desc))[i]))
 #define E1000_GET_DESC(R, i, type)	(&(((struct type *)((R).desc))[i]))
diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index a8b35ae41141..b209b0c3da5f 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -85,7 +85,6 @@ static const struct e1000_stats e1000_gstrings_stats[] = {
 	E1000_STAT("tx_flow_control_xoff", stats.xofftxc),
 	E1000_STAT("rx_csum_offload_good", hw_csum_good),
 	E1000_STAT("rx_csum_offload_errors", hw_csum_err),
-	E1000_STAT("rx_header_split", rx_hdr_split),
 	E1000_STAT("alloc_rx_buff_failed", alloc_rx_buff_failed),
 	E1000_STAT("tx_smbus", stats.mgptc),
 	E1000_STAT("rx_smbus", stats.mgprc),
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 4c15ca307b08..4dc3eeb01329 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -183,24 +183,6 @@ static void e1000_regdump(struct e1000_hw *hw, struct e1000_reg_info *reginfo)
 	pr_info("%-15s %08x %08x\n", rname, regs[0], regs[1]);
 }
 
-static void e1000e_dump_ps_pages(struct e1000_adapter *adapter,
-				 struct e1000_buffer *bi)
-{
-	int i;
-	struct e1000_ps_page *ps_page;
-
-	for (i = 0; i < adapter->rx_ps_pages; i++) {
-		ps_page = &bi->ps_pages[i];
-
-		if (ps_page->page) {
-			pr_info("packet dump for ps_page %d:\n", i);
-			print_hex_dump(KERN_INFO, "", DUMP_PREFIX_ADDRESS,
-				       16, 1, page_address(ps_page->page),
-				       PAGE_SIZE, true);
-		}
-	}
-}
-
 /**
  * e1000e_dump - Print registers, Tx-ring and Rx-ring
  * @adapter: board private structure
@@ -218,14 +200,7 @@ static void e1000e_dump(struct e1000_adapter *adapter)
 	} *u0;
 	struct e1000_buffer *buffer_info;
 	struct e1000_ring *rx_ring = adapter->rx_ring;
-	union e1000_rx_desc_packet_split *rx_desc_ps;
 	union e1000_rx_desc_extended *rx_desc;
-	struct my_u1 {
-		__le64 a;
-		__le64 b;
-		__le64 c;
-		__le64 d;
-	} *u1;
 	u32 staterr;
 	int i = 0;
 
@@ -340,155 +315,83 @@ static void e1000e_dump(struct e1000_adapter *adapter)
 		return;
 
 	dev_info(&adapter->pdev->dev, "Rx Ring Dump\n");
-	switch (adapter->rx_ps_pages) {
-	case 1:
-	case 2:
-	case 3:
-		/* [Extended] Packet Split Receive Descriptor Format
-		 *
-		 *    +-----------------------------------------------------+
-		 *  0 |                Buffer Address 0 [63:0]              |
-		 *    +-----------------------------------------------------+
-		 *  8 |                Buffer Address 1 [63:0]              |
-		 *    +-----------------------------------------------------+
-		 * 16 |                Buffer Address 2 [63:0]              |
-		 *    +-----------------------------------------------------+
-		 * 24 |                Buffer Address 3 [63:0]              |
-		 *    +-----------------------------------------------------+
-		 */
-		pr_info("R  [desc]      [buffer 0 63:0 ] [buffer 1 63:0 ] [buffer 2 63:0 ] [buffer 3 63:0 ] [bi->dma       ] [bi->skb] <-- Ext Pkt Split format\n");
-		/* [Extended] Receive Descriptor (Write-Back) Format
-		 *
-		 *   63       48 47    32 31     13 12    8 7    4 3        0
-		 *   +------------------------------------------------------+
-		 * 0 | Packet   | IP     |  Rsvd   | MRQ   | Rsvd | MRQ RSS |
-		 *   | Checksum | Ident  |         | Queue |      |  Type   |
-		 *   +------------------------------------------------------+
-		 * 8 | VLAN Tag | Length | Extended Error | Extended Status |
-		 *   +------------------------------------------------------+
-		 *   63       48 47    32 31            20 19               0
-		 */
-		pr_info("RWB[desc]      [ck ipid mrqhsh] [vl   l0 ee  es] [ l3  l2  l1 hs] [reserved      ] ---------------- [bi->skb] <-- Ext Rx Write-Back format\n");
-		for (i = 0; i < rx_ring->count; i++) {
-			const char *next_desc;
-			buffer_info = &rx_ring->buffer_info[i];
-			rx_desc_ps = E1000_RX_DESC_PS(*rx_ring, i);
-			u1 = (struct my_u1 *)rx_desc_ps;
-			staterr =
-			    le32_to_cpu(rx_desc_ps->wb.middle.status_error);
-
-			if (i == rx_ring->next_to_use)
-				next_desc = " NTU";
-			else if (i == rx_ring->next_to_clean)
-				next_desc = " NTC";
-			else
-				next_desc = "";
-
-			if (staterr & E1000_RXD_STAT_DD) {
-				/* Descriptor Done */
-				pr_info("%s[0x%03X]     %016llX %016llX %016llX %016llX ---------------- %p%s\n",
-					"RWB", i,
-					(unsigned long long)le64_to_cpu(u1->a),
-					(unsigned long long)le64_to_cpu(u1->b),
-					(unsigned long long)le64_to_cpu(u1->c),
-					(unsigned long long)le64_to_cpu(u1->d),
-					buffer_info->skb, next_desc);
-			} else {
-				pr_info("%s[0x%03X]     %016llX %016llX %016llX %016llX %016llX %p%s\n",
-					"R  ", i,
-					(unsigned long long)le64_to_cpu(u1->a),
-					(unsigned long long)le64_to_cpu(u1->b),
-					(unsigned long long)le64_to_cpu(u1->c),
-					(unsigned long long)le64_to_cpu(u1->d),
-					(unsigned long long)buffer_info->dma,
-					buffer_info->skb, next_desc);
-
-				if (netif_msg_pktdata(adapter))
-					e1000e_dump_ps_pages(adapter,
-							     buffer_info);
-			}
-		}
-		break;
-	default:
-	case 0:
-		/* Extended Receive Descriptor (Read) Format
-		 *
-		 *   +-----------------------------------------------------+
-		 * 0 |                Buffer Address [63:0]                |
-		 *   +-----------------------------------------------------+
-		 * 8 |                      Reserved                       |
-		 *   +-----------------------------------------------------+
-		 */
-		pr_info("R  [desc]      [buf addr 63:0 ] [reserved 63:0 ] [bi->dma       ] [bi->skb] <-- Ext (Read) format\n");
-		/* Extended Receive Descriptor (Write-Back) Format
-		 *
-		 *   63       48 47    32 31    24 23            4 3        0
-		 *   +------------------------------------------------------+
-		 *   |     RSS Hash      |        |               |         |
-		 * 0 +-------------------+  Rsvd  |   Reserved    | MRQ RSS |
-		 *   | Packet   | IP     |        |               |  Type   |
-		 *   | Checksum | Ident  |        |               |         |
-		 *   +------------------------------------------------------+
-		 * 8 | VLAN Tag | Length | Extended Error | Extended Status |
-		 *   +------------------------------------------------------+
-		 *   63       48 47    32 31            20 19               0
-		 */
-		pr_info("RWB[desc]      [cs ipid    mrq] [vt   ln xe  xs] [bi->skb] <-- Ext (Write-Back) format\n");
+	/* Extended Receive Descriptor (Read) Format
+	 *
+	 *   +-----------------------------------------------------+
+	 * 0 |                Buffer Address [63:0]                |
+	 *   +-----------------------------------------------------+
+	 * 8 |                      Reserved                       |
+	 *   +-----------------------------------------------------+
+	 */
+	pr_info("R  [desc]      [buf addr 63:0 ] [reserved 63:0 ] [bi->dma       ] [bi->skb] <-- Ext (Read) format\n");
+	/* Extended Receive Descriptor (Write-Back) Format
+	 *
+	 *   63       48 47    32 31    24 23            4 3        0
+	 *   +------------------------------------------------------+
+	 *   |     RSS Hash      |        |               |         |
+	 * 0 +-------------------+  Rsvd  |   Reserved    | MRQ RSS |
+	 *   | Packet   | IP     |        |               |  Type   |
+	 *   | Checksum | Ident  |        |               |         |
+	 *   +------------------------------------------------------+
+	 * 8 | VLAN Tag | Length | Extended Error | Extended Status |
+	 *   +------------------------------------------------------+
+	 *   63       48 47    32 31            20 19               0
+	 */
+	pr_info("RWB[desc]      [cs ipid    mrq] [vt   ln xe  xs] [bi->skb] <-- Ext (Write-Back) format\n");
 
-		for (i = 0; i < rx_ring->count; i++) {
-			const char *next_desc;
+	for (i = 0; i < rx_ring->count; i++) {
+		const char *next_desc;
 
-			buffer_info = &rx_ring->buffer_info[i];
-			rx_desc = E1000_RX_DESC_EXT(*rx_ring, i);
-			u1 = (struct my_u1 *)rx_desc;
-			staterr = le32_to_cpu(rx_desc->wb.upper.status_error);
+		buffer_info = &rx_ring->buffer_info[i];
+		rx_desc = E1000_RX_DESC_EXT(*rx_ring, i);
+		u0 = (struct my_u0 *)rx_desc;
+		staterr = le32_to_cpu(rx_desc->wb.upper.status_error);
 
-			if (i == rx_ring->next_to_use)
-				next_desc = " NTU";
-			else if (i == rx_ring->next_to_clean)
-				next_desc = " NTC";
-			else
-				next_desc = "";
-
-			if (staterr & E1000_RXD_STAT_DD) {
-				/* Descriptor Done */
-				pr_info("%s[0x%03X]     %016llX %016llX ---------------- %p%s\n",
-					"RWB", i,
-					(unsigned long long)le64_to_cpu(u1->a),
-					(unsigned long long)le64_to_cpu(u1->b),
-					buffer_info->skb, next_desc);
-			} else {
-				pr_info("%s[0x%03X]     %016llX %016llX %016llX %p%s\n",
-					"R  ", i,
-					(unsigned long long)le64_to_cpu(u1->a),
-					(unsigned long long)le64_to_cpu(u1->b),
-					(unsigned long long)buffer_info->dma,
-					buffer_info->skb, next_desc);
-
-				/* Jumbo buffers land in the page; a cleaned
-				 * jumbo slot keeps only its small shell skb
-				 * until it is refilled, so only dump an skb
-				 * that can hold a whole buffer.
-				 */
-				if (netif_msg_pktdata(adapter) &&
-				    buffer_info->page)
-					print_hex_dump(KERN_INFO, "",
-						       DUMP_PREFIX_ADDRESS, 16,
-						       1,
-						       page_address(buffer_info->page),
-						       adapter->rx_buffer_len,
-						       true);
-				else if (netif_msg_pktdata(adapter) &&
-					 buffer_info->skb &&
-					 skb_tailroom(buffer_info->skb) >=
-					 adapter->rx_buffer_len)
-					print_hex_dump(KERN_INFO, "",
-						       DUMP_PREFIX_ADDRESS, 16,
-						       1,
-						       buffer_info->skb->data,
-						       adapter->rx_buffer_len,
-						       true);
-			}
+		if (i == rx_ring->next_to_use)
+			next_desc = " NTU";
+		else if (i == rx_ring->next_to_clean)
+			next_desc = " NTC";
+		else
+			next_desc = "";
+
+		if (staterr & E1000_RXD_STAT_DD) {
+			/* Descriptor Done */
+			pr_info("%s[0x%03X]     %016llX %016llX ---------------- %p%s\n",
+				"RWB", i,
+				(unsigned long long)le64_to_cpu(u0->a),
+				(unsigned long long)le64_to_cpu(u0->b),
+				buffer_info->skb, next_desc);
+		} else {
+			pr_info("%s[0x%03X]     %016llX %016llX %016llX %p%s\n",
+				"R  ", i,
+				(unsigned long long)le64_to_cpu(u0->a),
+				(unsigned long long)le64_to_cpu(u0->b),
+				(unsigned long long)buffer_info->dma,
+				buffer_info->skb, next_desc);
+
+			/* Jumbo buffers land in the page; a cleaned
+			 * jumbo slot keeps only its small shell skb
+			 * until it is refilled, so only dump an skb
+			 * that can hold a whole buffer.
+			 */
+			if (netif_msg_pktdata(adapter) &&
+			    buffer_info->page)
+				print_hex_dump(KERN_INFO, "",
+					       DUMP_PREFIX_ADDRESS, 16,
+					       1,
+					       page_address(buffer_info->page),
+					       adapter->rx_buffer_len,
+					       true);
+			else if (netif_msg_pktdata(adapter) &&
+				 buffer_info->skb &&
+				 skb_tailroom(buffer_info->skb) >=
+				 adapter->rx_buffer_len)
+				print_hex_dump(KERN_INFO, "",
+					       DUMP_PREFIX_ADDRESS, 16,
+					       1,
+					       buffer_info->skb->data,
+					       adapter->rx_buffer_len,
+					       true);
 		}
 	}
 }
@@ -735,110 +638,6 @@ static void e1000_alloc_rx_buffers(struct e1000_ring *rx_ring,
 	rx_ring->next_to_use = i;
 }
 
-/**
- * e1000_alloc_rx_buffers_ps - Replace used receive buffers; packet split
- * @rx_ring: Rx descriptor ring
- * @cleaned_count: number to reallocate
- * @gfp: flags for allocation
- **/
-static void e1000_alloc_rx_buffers_ps(struct e1000_ring *rx_ring,
-				      int cleaned_count, gfp_t gfp)
-{
-	struct e1000_adapter *adapter = rx_ring->adapter;
-	struct net_device *netdev = adapter->netdev;
-	struct pci_dev *pdev = adapter->pdev;
-	union e1000_rx_desc_packet_split *rx_desc;
-	struct e1000_buffer *buffer_info;
-	struct e1000_ps_page *ps_page;
-	struct sk_buff *skb;
-	unsigned int i, j;
-
-	i = rx_ring->next_to_use;
-	buffer_info = &rx_ring->buffer_info[i];
-
-	while (cleaned_count--) {
-		rx_desc = E1000_RX_DESC_PS(*rx_ring, i);
-
-		for (j = 0; j < PS_PAGE_BUFFERS; j++) {
-			ps_page = &buffer_info->ps_pages[j];
-			if (j >= adapter->rx_ps_pages) {
-				/* all unused desc entries get hw null ptr */
-				rx_desc->read.buffer_addr[j + 1] =
-				    ~cpu_to_le64(0);
-				continue;
-			}
-			if (!ps_page->page) {
-				ps_page->page = alloc_page(gfp);
-				if (!ps_page->page) {
-					adapter->alloc_rx_buff_failed++;
-					goto no_buffers;
-				}
-				ps_page->dma = dma_map_page(&pdev->dev,
-							    ps_page->page,
-							    0, PAGE_SIZE,
-							    DMA_FROM_DEVICE);
-				if (dma_mapping_error(&pdev->dev,
-						      ps_page->dma)) {
-					dev_err(&adapter->pdev->dev,
-						"Rx DMA page map failed\n");
-					adapter->rx_dma_failed++;
-					goto no_buffers;
-				}
-			}
-			/* Refresh the desc even if buffer_addrs
-			 * didn't change because each write-back
-			 * erases this info.
-			 */
-			rx_desc->read.buffer_addr[j + 1] =
-			    cpu_to_le64(ps_page->dma);
-		}
-
-		skb = __netdev_alloc_skb_ip_align(netdev, adapter->rx_ps_bsize0,
-						  gfp);
-
-		if (!skb) {
-			adapter->alloc_rx_buff_failed++;
-			break;
-		}
-
-		buffer_info->skb = skb;
-		buffer_info->dma = dma_map_single(&pdev->dev, skb->data,
-						  adapter->rx_ps_bsize0,
-						  DMA_FROM_DEVICE);
-		if (dma_mapping_error(&pdev->dev, buffer_info->dma)) {
-			dev_err(&pdev->dev, "Rx DMA map failed\n");
-			adapter->rx_dma_failed++;
-			/* cleanup skb */
-			dev_kfree_skb_any(skb);
-			buffer_info->skb = NULL;
-			break;
-		}
-
-		rx_desc->read.buffer_addr[0] = cpu_to_le64(buffer_info->dma);
-
-		if (unlikely(!(i & (E1000_RX_BUFFER_WRITE - 1)))) {
-			/* Force memory writes to complete before letting h/w
-			 * know there are new descriptors to fetch.  (Only
-			 * applicable for weak-ordered memory model archs,
-			 * such as IA-64).
-			 */
-			wmb();
-			if (adapter->flags2 & FLAG2_PCIM2PCI_ARBITER_WA)
-				e1000e_update_rdt_wa(rx_ring, i << 1);
-			else
-				writel(i << 1, rx_ring->tail);
-		}
-
-		i++;
-		if (i == rx_ring->count)
-			i = 0;
-		buffer_info = &rx_ring->buffer_info[i];
-	}
-
-no_buffers:
-	rx_ring->next_to_use = i;
-}
-
 /**
  * e1000_alloc_jumbo_rx_buffers - Replace used jumbo receive buffers
  * @rx_ring: Rx descriptor ring
@@ -1326,193 +1125,6 @@ static bool e1000_clean_tx_irq(struct e1000_ring *tx_ring)
 	return count < tx_ring->count;
 }
 
-/**
- * e1000_clean_rx_irq_ps - Send received data up the network stack; packet split
- * @rx_ring: Rx descriptor ring
- * @work_done: output parameter for indicating completed work
- * @work_to_do: how many packets we can clean
- *
- * the return value indicates whether actual cleaning was done, there
- * is no guarantee that everything was cleaned
- **/
-static bool e1000_clean_rx_irq_ps(struct e1000_ring *rx_ring, int *work_done,
-				  int work_to_do)
-{
-	struct e1000_adapter *adapter = rx_ring->adapter;
-	struct e1000_hw *hw = &adapter->hw;
-	union e1000_rx_desc_packet_split *rx_desc, *next_rxd;
-	struct net_device *netdev = adapter->netdev;
-	struct pci_dev *pdev = adapter->pdev;
-	struct e1000_buffer *buffer_info, *next_buffer;
-	struct e1000_ps_page *ps_page;
-	struct sk_buff *skb;
-	unsigned int i, j;
-	u32 length, staterr;
-	int cleaned_count = 0;
-	bool cleaned = false;
-	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
-
-	i = rx_ring->next_to_clean;
-	rx_desc = E1000_RX_DESC_PS(*rx_ring, i);
-	staterr = le32_to_cpu(rx_desc->wb.middle.status_error);
-	buffer_info = &rx_ring->buffer_info[i];
-
-	while (staterr & E1000_RXD_STAT_DD) {
-		if (*work_done >= work_to_do)
-			break;
-		(*work_done)++;
-		skb = buffer_info->skb;
-		dma_rmb();	/* read descriptor and rx_buffer_info after status DD */
-
-		/* in the packet split case this is header only */
-		prefetch(skb->data - NET_IP_ALIGN);
-
-		i++;
-		if (i == rx_ring->count)
-			i = 0;
-		next_rxd = E1000_RX_DESC_PS(*rx_ring, i);
-		prefetch(next_rxd);
-
-		next_buffer = &rx_ring->buffer_info[i];
-
-		cleaned = true;
-		cleaned_count++;
-		dma_unmap_single(&pdev->dev, buffer_info->dma,
-				 adapter->rx_ps_bsize0, DMA_FROM_DEVICE);
-		buffer_info->dma = 0;
-
-		/* see !EOP comment in other Rx routine */
-		if (!(staterr & E1000_RXD_STAT_EOP))
-			adapter->flags2 |= FLAG2_IS_DISCARDING;
-
-		if (adapter->flags2 & FLAG2_IS_DISCARDING) {
-			e_dbg("Packet Split buffers didn't pick up the full packet\n");
-			dev_kfree_skb_irq(skb);
-			if (staterr & E1000_RXD_STAT_EOP)
-				adapter->flags2 &= ~FLAG2_IS_DISCARDING;
-			goto next_desc;
-		}
-
-		if (unlikely((staterr & E1000_RXDEXT_ERR_FRAME_ERR_MASK) &&
-			     !(netdev->features & NETIF_F_RXALL))) {
-			dev_kfree_skb_irq(skb);
-			goto next_desc;
-		}
-
-		length = le16_to_cpu(rx_desc->wb.middle.length0);
-
-		if (!length) {
-			e_dbg("Last part of the packet spanning multiple descriptors\n");
-			dev_kfree_skb_irq(skb);
-			goto next_desc;
-		}
-
-		/* Good Receive */
-		skb_put(skb, length);
-
-		{
-			/* this looks ugly, but it seems compiler issues make
-			 * it more efficient than reusing j
-			 */
-			int l1 = le16_to_cpu(rx_desc->wb.upper.length[0]);
-
-			/* page alloc/put takes too long and effects small
-			 * packet throughput, so unsplit small packets and
-			 * save the alloc/put
-			 */
-			if (l1 && (l1 <= copybreak) &&
-			    ((length + l1) <= adapter->rx_ps_bsize0)) {
-				ps_page = &buffer_info->ps_pages[0];
-
-				dma_sync_single_for_cpu(&pdev->dev,
-							ps_page->dma,
-							PAGE_SIZE,
-							DMA_FROM_DEVICE);
-				memcpy(skb_tail_pointer(skb),
-				       page_address(ps_page->page), l1);
-				dma_sync_single_for_device(&pdev->dev,
-							   ps_page->dma,
-							   PAGE_SIZE,
-							   DMA_FROM_DEVICE);
-
-				/* remove the CRC */
-				if (!(adapter->flags2 & FLAG2_CRC_STRIPPING)) {
-					if (!(netdev->features & NETIF_F_RXFCS))
-						l1 -= 4;
-				}
-
-				skb_put(skb, l1);
-				goto copydone;
-			}	/* if */
-		}
-
-		for (j = 0; j < PS_PAGE_BUFFERS; j++) {
-			length = le16_to_cpu(rx_desc->wb.upper.length[j]);
-			if (!length)
-				break;
-
-			ps_page = &buffer_info->ps_pages[j];
-			dma_unmap_page(&pdev->dev, ps_page->dma, PAGE_SIZE,
-				       DMA_FROM_DEVICE);
-			ps_page->dma = 0;
-			skb_fill_page_desc(skb, j, ps_page->page, 0, length);
-			ps_page->page = NULL;
-			skb->len += length;
-			skb->data_len += length;
-			skb->truesize += PAGE_SIZE;
-		}
-
-		/* strip the ethernet crc, problem is we're using pages now so
-		 * this whole operation can get a little cpu intensive
-		 */
-		if (!(adapter->flags2 & FLAG2_CRC_STRIPPING)) {
-			if (!(netdev->features & NETIF_F_RXFCS))
-				pskb_trim(skb, skb->len - 4);
-		}
-
-copydone:
-		total_rx_bytes += skb->len;
-		total_rx_packets++;
-
-		e1000_rx_checksum(adapter, staterr, skb);
-
-		e1000_rx_hash(netdev, rx_desc->wb.lower.hi_dword.rss, skb);
-
-		if (rx_desc->wb.upper.header_status &
-		    cpu_to_le16(E1000_RXDPS_HDRSTAT_HDRSP))
-			adapter->rx_hdr_split++;
-
-		e1000_receive_skb(adapter, netdev, skb, staterr,
-				  rx_desc->wb.middle.vlan);
-
-next_desc:
-		rx_desc->wb.middle.status_error &= cpu_to_le32(~0xFF);
-		buffer_info->skb = NULL;
-
-		/* return some buffers to hardware, one at a time is too slow */
-		if (cleaned_count >= E1000_RX_BUFFER_WRITE) {
-			adapter->alloc_rx_buf(rx_ring, cleaned_count,
-					      GFP_ATOMIC);
-			cleaned_count = 0;
-		}
-
-		/* use prefetched values */
-		rx_desc = next_rxd;
-		buffer_info = next_buffer;
-
-		staterr = le32_to_cpu(rx_desc->wb.middle.status_error);
-	}
-	rx_ring->next_to_clean = i;
-
-	cleaned_count = e1000_desc_unused(rx_ring);
-	if (cleaned_count)
-		adapter->alloc_rx_buf(rx_ring, cleaned_count, GFP_ATOMIC);
-
-	adapter->total_rx_bytes += total_rx_bytes;
-	adapter->total_rx_packets += total_rx_packets;
-	return cleaned;
-}
-
 static void e1000_consume_page(struct e1000_buffer *bi, struct sk_buff *skb,
 			       u16 length)
 {
@@ -1710,9 +1322,8 @@ static void e1000_clean_rx_ring(struct e1000_ring *rx_ring)
 {
 	struct e1000_adapter *adapter = rx_ring->adapter;
 	struct e1000_buffer *buffer_info;
-	struct e1000_ps_page *ps_page;
 	struct pci_dev *pdev = adapter->pdev;
-	unsigned int i, j;
+	unsigned int i;
 
 	/* Free all the Rx ring sk_buffs */
 	for (i = 0; i < rx_ring->count; i++) {
@@ -1725,10 +1336,6 @@ static void e1000_clean_rx_ring(struct e1000_ring *rx_ring)
 			else if (adapter->clean_rx == e1000_clean_jumbo_rx_irq)
 				dma_unmap_page(&pdev->dev, buffer_info->dma,
 					       PAGE_SIZE, DMA_FROM_DEVICE);
-			else if (adapter->clean_rx == e1000_clean_rx_irq_ps)
-				dma_unmap_single(&pdev->dev, buffer_info->dma,
-						 adapter->rx_ps_bsize0,
-						 DMA_FROM_DEVICE);
 			buffer_info->dma = 0;
 		}
 
@@ -1741,17 +1348,6 @@ static void e1000_clean_rx_ring(struct e1000_ring *rx_ring)
 			dev_kfree_skb(buffer_info->skb);
 			buffer_info->skb = NULL;
 		}
-
-		for (j = 0; j < PS_PAGE_BUFFERS; j++) {
-			ps_page = &buffer_info->ps_pages[j];
-			if (!ps_page->page)
-				break;
-			dma_unmap_page(&pdev->dev, ps_page->dma, PAGE_SIZE,
-				       DMA_FROM_DEVICE);
-			ps_page->dma = 0;
-			put_page(ps_page->page);
-			ps_page->page = NULL;
-		}
 	}
 
 	/* there also may be some cached data from a chained receive */
@@ -2396,23 +1992,14 @@ int e1000e_setup_tx_resources(struct e1000_ring *tx_ring)
 int e1000e_setup_rx_resources(struct e1000_ring *rx_ring)
 {
 	struct e1000_adapter *adapter = rx_ring->adapter;
-	struct e1000_buffer *buffer_info;
-	int i, size, desc_len, err = -ENOMEM;
+	int size, desc_len, err = -ENOMEM;
 
 	size = sizeof(struct e1000_buffer) * rx_ring->count;
 	rx_ring->buffer_info = vzalloc(size);
 	if (!rx_ring->buffer_info)
 		goto err;
 
-	for (i = 0; i < rx_ring->count; i++) {
-		buffer_info = &rx_ring->buffer_info[i];
-		buffer_info->ps_pages = kzalloc_objs(struct e1000_ps_page,
-						     PS_PAGE_BUFFERS);
-		if (!buffer_info->ps_pages)
-			goto err_pages;
-	}
-
-	desc_len = sizeof(union e1000_rx_desc_packet_split);
+	desc_len = sizeof(union e1000_rx_desc_extended);
 
 	/* Round up to nearest 4K */
 	rx_ring->size = rx_ring->count * desc_len;
@@ -2420,7 +2007,7 @@ int e1000e_setup_rx_resources(struct e1000_ring *rx_ring)
 
 	err = e1000_alloc_ring_dma(adapter, rx_ring);
 	if (err)
-		goto err_pages;
+		goto err;
 
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
@@ -2428,11 +2015,6 @@ int e1000e_setup_rx_resources(struct e1000_ring *rx_ring)
 
 	return 0;
 
-err_pages:
-	for (i = 0; i < rx_ring->count; i++) {
-		buffer_info = &rx_ring->buffer_info[i];
-		kfree(buffer_info->ps_pages);
-	}
 err:
 	vfree(rx_ring->buffer_info);
 	e_err("Unable to allocate memory for the receive descriptor ring\n");
@@ -2496,13 +2078,9 @@ void e1000e_free_rx_resources(struct e1000_ring *rx_ring)
 {
 	struct e1000_adapter *adapter = rx_ring->adapter;
 	struct pci_dev *pdev = adapter->pdev;
-	int i;
 
 	e1000_clean_rx_ring(rx_ring);
 
-	for (i = 0; i < rx_ring->count; i++)
-		kfree(rx_ring->buffer_info[i].ps_pages);
-
 	vfree(rx_ring->buffer_info);
 	rx_ring->buffer_info = NULL;
 
@@ -3050,9 +2628,6 @@ static void e1000_configure_tx(struct e1000_adapter *adapter)
 	}
 }
 
-#define PAGE_USE_COUNT(S) (((S) >> PAGE_SHIFT) + \
-			   (((S) & (PAGE_SIZE - 1)) ? 1 : 0))
-
 /**
  * e1000_setup_rctl - configure the receive control registers
  * @adapter: Board private structure
@@ -3061,7 +2636,6 @@ static void e1000_setup_rctl(struct e1000_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
 	u32 rctl, rfctl;
-	u32 pages = 0;
 
 	/* Workaround Si errata on PCHx - configure jumbo frame flow.
 	 * If jumbo frames not set, program related MAC/PHY registers
@@ -3144,49 +2718,6 @@ static void e1000_setup_rctl(struct e1000_adapter *adapter)
 	rfctl |= E1000_RFCTL_EXTEN;
 	ew32(RFCTL, rfctl);
 
-	/* 82571 and greater support packet-split where the protocol
-	 * header is placed in skb->data and the packet data is
-	 * placed in pages hanging off of skb_shinfo(skb)->nr_frags.
-	 * In the case of a non-split, skb->data is linearly filled,
-	 * followed by the page buffers.  Therefore, skb->data is
-	 * sized to hold the largest protocol header.
-	 *
-	 * allocations using alloc_page take too long for regular MTU
-	 * so only enable packet split for jumbo frames
-	 *
-	 * Using pages when the page size is greater than 16k wastes
-	 * a lot of memory, since we allocate 3 pages at all times
-	 * per packet.
-	 */
-	pages = PAGE_USE_COUNT(adapter->netdev->mtu);
-	if ((pages <= 3) && (PAGE_SIZE <= 16384) && (rctl & E1000_RCTL_LPE))
-		adapter->rx_ps_pages = pages;
-	else
-		adapter->rx_ps_pages = 0;
-
-	if (adapter->rx_ps_pages) {
-		u32 psrctl = 0;
-
-		/* Enable Packet split descriptors */
-		rctl |= E1000_RCTL_DTYP_PS;
-
-		psrctl |= adapter->rx_ps_bsize0 >> E1000_PSRCTL_BSIZE0_SHIFT;
-
-		switch (adapter->rx_ps_pages) {
-		case 3:
-			psrctl |= PAGE_SIZE << E1000_PSRCTL_BSIZE3_SHIFT;
-			fallthrough;
-		case 2:
-			psrctl |= PAGE_SIZE << E1000_PSRCTL_BSIZE2_SHIFT;
-			fallthrough;
-		case 1:
-			psrctl |= PAGE_SIZE >> E1000_PSRCTL_BSIZE1_SHIFT;
-			break;
-		}
-
-		ew32(PSRCTL, psrctl);
-	}
-
 	/* This is useful for sniffing bad packets. */
 	if (adapter->netdev->features & NETIF_F_RXALL) {
 		/* UPE and MPE will be handled by normal PROMISC logic
@@ -3222,18 +2753,11 @@ static void e1000_configure_rx(struct e1000_adapter *adapter)
 	u64 rdba;
 	u32 rdlen, rctl, rxcsum, ctrl_ext;
 
-	if (adapter->rx_ps_pages) {
-		/* this is a 32 byte descriptor */
-		rdlen = rx_ring->count *
-		    sizeof(union e1000_rx_desc_packet_split);
-		adapter->clean_rx = e1000_clean_rx_irq_ps;
-		adapter->alloc_rx_buf = e1000_alloc_rx_buffers_ps;
-	} else if (adapter->netdev->mtu > ETH_FRAME_LEN + ETH_FCS_LEN) {
-		rdlen = rx_ring->count * sizeof(union e1000_rx_desc_extended);
+	rdlen = rx_ring->count * sizeof(union e1000_rx_desc_extended);
+	if (adapter->netdev->mtu > ETH_FRAME_LEN + ETH_FCS_LEN) {
 		adapter->clean_rx = e1000_clean_jumbo_rx_irq;
 		adapter->alloc_rx_buf = e1000_alloc_jumbo_rx_buffers;
 	} else {
-		rdlen = rx_ring->count * sizeof(union e1000_rx_desc_extended);
 		adapter->clean_rx = e1000_clean_rx_irq;
 		adapter->alloc_rx_buf = e1000_alloc_rx_buffers;
 	}
@@ -4492,7 +4016,6 @@ static int e1000_sw_init(struct e1000_adapter *adapter)
 	struct net_device *netdev = adapter->netdev;
 
 	adapter->rx_buffer_len = VLAN_ETH_FRAME_LEN + ETH_FCS_LEN;
-	adapter->rx_ps_bsize0 = 128;
 	adapter->max_frame_size = netdev->mtu + VLAN_ETH_HLEN + ETH_FCS_LEN;
 	adapter->min_frame_size = ETH_ZLEN + ETH_FCS_LEN;
 	adapter->tx_ring_count = E1000_DEFAULT_TXD;
-- 
2.43.0

