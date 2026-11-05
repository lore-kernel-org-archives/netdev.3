Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=12.32.117.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793850261;
	b=3jL04OWiOx86GI2JA71W/ngI6rZhm0h3dfG9C9ySxO8RxhR7zzzwq//VdCUJzWehrug8
	 ZWi5xlFUxEbLrtq0ZVbgBlOkNn8lH2O/UVEUfj9t7huP2PTq0vc1Q+Nmj9jttyoOPklJ0
	 P65BKZJj2lj+2C57n/x1U86WG9LVpsngvSo9MIVQrBzfxmxthR8EjCi5blXiT63Ok2Goo
	 Wor9+2OB0clfAdzAVXDKAJ79SN9KbBZ5yPUGTqpMa8H7ybwGPoNu1tblMNTHEK7+feZH1
	 P9EtY2eIHHjYz4OG9DrgZCiJ04i46/1ceg6L5JJjnj/7qR2RLjY2yrlgB/WGqqG0qtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793850261;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OUuPBM1gAaVfhVRDBENQIHbXQg+3s96J8m5jTw/hkw8=;
	b=qpqDaOT0wFh3UfaYSR0/VI+XUqvy8wEAvWXe1zobyj89/Ew2MKcefBYgW6l63RDSYnmZ
	 +kYeh+9nrF4iT0Zh4POtGcuaCfbz0djzur0I4AHRN2G/ed7tHzOzpcPpCPCPP5p8R75sp
	 GdJb4qNRE8uYvJbMoSri9OTvYTOk23HGWqf3z+KMSY8sgixaC+IldNsCyZd46eAj1Le+g
	 CPkQRjA9v40nXPwkvrjw8yjJwV/UmCYNY/D360cVbhDGvBQKAIUd+dEd93XRBwNEYOD5E
	 OeoVuY8mPsznykNCcYvIsye1UiT39dNkE3EhbNBwC1VuXkDlN6NTdhttui1C15ZGmpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chelsio.com;
	spf=pass smtp.mailfrom=chelsio.com;
	arc=none smtp.remote-ip=12.32.117.8
Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3FC606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 03:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A3FC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from mehrangarh-blr-asicdesigners-com.asicdesigners.com (mehrangarh.blr.asicdesigners.com [10.193.185.169])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 6A53hj3n002480;
	Wed, 4 Nov 2026 19:43:58 -0800
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, bharat@chelsio.com,
        harshitha.vr@chelsio.com
Subject: [PATCH net-next v5 REPOST 01/12] cxgb4: add T7 hardware definitions and firmware interfaces
Date: Thu,  5 Nov 2026 08:15:38 -0500
Message-Id: <20261105131549.547554-2-bharat@chelsio.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20261105131549.547554-1-bharat@chelsio.com>
References: <20261105131549.547554-1-bharat@chelsio.com>
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

Add the initial T7-specific hardware definitions required by the cxgb4
driver. This patch updates chip identification, PCI device IDs,
register definitions, TCB layout definitions, firmware API interfaces,
firmware version information, message formats, and related constants to
provide the foundational infrastructure for upcoming T7 support.

No functional changes are introduced by this patch. It only extends the
existing hardware and firmware definition headers for T7-specific
driver functionality.

Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 .../net/ethernet/chelsio/cxgb4/t4_chip_type.h |   10 +
 drivers/net/ethernet/chelsio/cxgb4/t4_msg.h   |  109 +-
 .../ethernet/chelsio/cxgb4/t4_pci_id_tbl.h    |   21 +
 drivers/net/ethernet/chelsio/cxgb4/t4_regs.h  | 7284 ++++++++++++++---
 drivers/net/ethernet/chelsio/cxgb4/t4_tcb.h   |   16 +
 .../net/ethernet/chelsio/cxgb4/t4_values.h    |   11 +
 drivers/net/ethernet/chelsio/cxgb4/t4fw_api.h |   83 +-
 .../net/ethernet/chelsio/cxgb4/t4fw_version.h |    9 +
 8 files changed, 6401 insertions(+), 1142 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_chip_type.h b/drivers/net/ethernet/chelsio/cxgb4/t4_chip_type.h
index 721c77577ec5..444675436b01 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_chip_type.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_chip_type.h
@@ -39,6 +39,7 @@
 #define CHELSIO_T4		0x4
 #define CHELSIO_T5		0x5
 #define CHELSIO_T6		0x6
+#define CHELSIO_T7		0x7
 
 /* We code the Chelsio T4 Family "Chip Code" as a tuple:
  *
@@ -67,6 +68,11 @@ enum chip_type {
 	T6_A0 = CHELSIO_CHIP_CODE(CHELSIO_T6, 0),
 	T6_FIRST_REV	= T6_A0,
 	T6_LAST_REV	= T6_A0,
+
+	T7_A0 = CHELSIO_CHIP_CODE(CHELSIO_T7, 0),
+	T7_B0 = CHELSIO_CHIP_CODE(CHELSIO_T7, 1),
+	T7_FIRST_REV    = T7_A0,
+	T7_LAST_REV     = T7_B0,
 };
 
 static inline int is_t4(enum chip_type chip)
@@ -84,4 +90,8 @@ static inline int is_t6(enum chip_type chip)
 	return (CHELSIO_CHIP_VERSION(chip) == CHELSIO_T6);
 }
 
+static inline int is_t7(enum chip_type chip)
+{
+	return (CHELSIO_CHIP_VERSION(chip) == CHELSIO_T7);
+}
 #endif /* __T4_CHIP_TYPE_H__ */
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_msg.h b/drivers/net/ethernet/chelsio/cxgb4/t4_msg.h
index fed5f93bf620..66a55ddf0c24 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_msg.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_msg.h
@@ -88,6 +88,7 @@ enum {
 
 	CPL_RDMA_READ_REQ     = 0x60,
 
+	CPL_SET_LE_REQ        = 0x80,
 	CPL_PASS_OPEN_REQ6    = 0x81,
 	CPL_ACT_OPEN_REQ6     = 0x83,
 
@@ -544,6 +545,26 @@ struct cpl_t6_act_open_req {
 	__be32 opt3;
 };
 
+struct cpl_t7_act_open_req {
+	WR_HDR;
+	union opcode_tid ot;
+	__be16 local_port;
+	__be16 peer_port;
+	__be32 local_ip;
+	__be32 peer_ip;
+	__be64 opt0;
+	__be32 iss;
+	__be32 opt2;
+	__be64 params;
+	__be32 rsvd2;
+	__be32 opt3;
+};
+
+#define T7_FILTER_TUPLE_S       1
+#define T7_FILTER_TUPLE_M       0x7FFFFFFFFFFFFFFFULL
+#define T7_FILTER_TUPLE_V(x)    ((x) << T7_FILTER_TUPLE_S)
+#define T7_FILTER_TUPLE_G(x)    (((x) >> T7_FILTER_TUPLE_S) & T7_FILTER_TUPLE_M)
+
 struct cpl_act_open_req6 {
 	WR_HDR;
 	union opcode_tid ot;
@@ -590,6 +611,23 @@ struct cpl_t6_act_open_req6 {
 	__be32 opt3;
 };
 
+struct cpl_t7_act_open_req6 {
+	WR_HDR;
+	union opcode_tid ot;
+	__be16 local_port;
+	__be16 peer_port;
+	__be64 local_ip_hi;
+	__be64 local_ip_lo;
+	__be64 peer_ip_hi;
+	__be64 peer_ip_lo;
+	__be64 opt0;
+	__be32 iss;
+	__be32 opt2;
+	__be64 params;
+	__be32 rsvd2;
+	__be32 opt3;
+};
+
 struct cpl_act_open_rpl {
 	union opcode_tid ot;
 	__be32 atid_status;
@@ -682,10 +720,20 @@ struct cpl_get_tcb {
 #define QUEUENO_S    0
 #define QUEUENO_V(x) ((x) << QUEUENO_S)
 
+#define T7_QUEUENO_S    0
+#define T7_QUEUENO_M    0xFFF
+#define T7_QUEUENO_V(x) ((x) << T7_QUEUENO_S)
+#define T7_QUEUENO_G(x) (((x) >> T7_QUEUENO_S) & T7_QUEUENO_M)
+
 #define REPLY_CHAN_S    14
 #define REPLY_CHAN_V(x) ((x) << REPLY_CHAN_S)
 #define REPLY_CHAN_F    REPLY_CHAN_V(1U)
 
+#define T7_REPLY_CHAN_S	 12
+#define T7_REPLY_CHAN_M	 0x7
+#define T7_REPLY_CHAN_V(x)      ((x) << T7_REPLY_CHAN_S)
+#define T7_REPLY_CHAN_G(x)      (((x) >> T7_REPLY_CHAN_S) & T7_REPLY_CHAN_M)
+
 #define NO_REPLY_S    15
 #define NO_REPLY_V(x) ((x) << NO_REPLY_S)
 #define NO_REPLY_F    NO_REPLY_V(1U)
@@ -1363,6 +1411,53 @@ struct cpl_smt_write_rpl {
 #define SMTW_NORPL_V(x)	((x) << SMTW_NORPL_S)
 #define SMTW_NORPL_F	SMTW_NORPL_V(1U)
 
+struct cpl_set_le_req {
+	WR_HDR;
+	union opcode_tid ot;
+	__be16 reply_ctrl;
+	__be16 params;
+	__be64 mask_hi;
+	__be64 mask_lo;
+	__be64 val_hi;
+	__be64 val_lo;
+};
+
+/* cpl_set_le_req.reply_ctrl additional fields */
+#define LE_REQ_RXCHANNEL_S      14
+#define LE_REQ_RXCHANNEL_M      0x1
+#define LE_REQ_RXCHANNEL_V(x)   ((x) << LE_REQ_RXCHANNEL_S)
+#define LE_REQ_RXCHANNEL_G(x) (((x) >> LE_REQ_RXCHANNEL_S) & LE_REQ_RXCHANNEL_M)
+#define LE_REQ_RXCHANNEL_F      LE_REQ_RXCHANNEL_V(1U)
+
+#define LE_REQ_IP6_S    13
+#define LE_REQ_IP6_V(x) ((x) << LE_REQ_IP6_S)
+#define LE_REQ_IP6_F    LE_REQ_IP6_V(1U)
+
+/* cpl_set_le_req.params fields */
+#define LE_CHAN_S    0
+#define LE_CHAN_M    0x3
+#define LE_CHAN_V(x) ((x) << LE_CHAN_S)
+#define LE_CHAN_G(x) (((x) >> LE_CHAN_S) & LE_CHAN_M)
+
+#define LE_OFFSET_S    5
+#define LE_OFFSET_M    0x7
+#define LE_OFFSET_V(x) ((x) << LE_OFFSET_S)
+#define LE_OFFSET_G(x) (((x) >> LE_OFFSET_S) & LE_OFFSET_M)
+
+#define LE_MORE_S    8
+#define LE_MORE_V(x) ((x) << LE_MORE_S)
+#define LE_MORE_F    LE_MORE_V(1U)
+
+#define LE_REQSIZE_S    9
+#define LE_REQSIZE_M    0x7
+#define LE_REQSIZE_V(x) ((x) << LE_REQSIZE_S)
+#define LE_REQSIZE_G(x) (((x) >> LE_REQSIZE_S) & LE_REQSIZE_M)
+
+#define LE_REQCMD_S    12
+#define LE_REQCMD_M    0xF
+#define LE_REQCMD_V(x) ((x) << LE_REQCMD_S)
+#define LE_REQCMD_G(x) (((x) >> LE_REQCMD_S) & LE_REQCMD_M)
+
 struct cpl_rdma_terminate {
 	union opcode_tid ot;
 	__be16 rsvd;
@@ -1631,10 +1726,10 @@ struct cpl_tx_tnl_lso {
 	(((x) >> CPL_TX_TNL_LSO_IPV6OUT_S) & CPL_TX_TNL_LSO_IPV6OUT_M)
 #define CPL_TX_TNL_LSO_IPV6OUT_F        CPL_TX_TNL_LSO_IPV6OUT_V(1U)
 
-#define CPL_TX_TNL_LSO_ETHHDRLEN_S	16
-#define CPL_TX_TNL_LSO_ETHHDRLEN_M	0xf
-#define CPL_TX_TNL_LSO_ETHHDRLEN_V(x)	((x) << CPL_TX_TNL_LSO_ETHHDRLEN_S)
-#define CPL_TX_TNL_LSO_ETHHDRLEN_G(x)	\
+#define CPL_TX_TNL_LSO_ETHHDRLEN_S     16
+#define CPL_TX_TNL_LSO_ETHHDRLEN_M     0xf
+#define CPL_TX_TNL_LSO_ETHHDRLEN_V(x)  ((x) << CPL_TX_TNL_LSO_ETHHDRLEN_S)
+#define CPL_TX_TNL_LSO_ETHHDRLEN_G(x)  \
 	(((x) >> CPL_TX_TNL_LSO_ETHHDRLEN_S) & CPL_TX_TNL_LSO_ETHHDRLEN_M)
 
 #define CPL_TX_TNL_LSO_IPHDRLEN_S	4
@@ -1719,12 +1814,6 @@ struct cpl_tx_tnl_lso {
 #define CPL_TX_TNL_LSO_TNLTYPE_G(x)	\
 	(((x) >> CPL_TX_TNL_LSO_TNLTYPE_S) & CPL_TX_TNL_LSO_TNLTYPE_M)
 
-#define S_CPL_TX_TNL_LSO_ETHHDRLEN	16
-#define M_CPL_TX_TNL_LSO_ETHHDRLEN	0xf
-#define V_CPL_TX_TNL_LSO_ETHHDRLEN(x)	((x) << S_CPL_TX_TNL_LSO_ETHHDRLEN)
-#define G_CPL_TX_TNL_LSO_ETHHDRLEN(x)	\
-	(((x) >> S_CPL_TX_TNL_LSO_ETHHDRLEN) & M_CPL_TX_TNL_LSO_ETHHDRLEN)
-
 #define CPL_TX_TNL_LSO_TNLHDRLEN_S      0
 #define CPL_TX_TNL_LSO_TNLHDRLEN_M      0xfff
 #define CPL_TX_TNL_LSO_TNLHDRLEN_V(x)	((x) << CPL_TX_TNL_LSO_TNLHDRLEN_S)
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_pci_id_tbl.h b/drivers/net/ethernet/chelsio/cxgb4/t4_pci_id_tbl.h
index 0b1b5f9c67d4..d0921b76049d 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_pci_id_tbl.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_pci_id_tbl.h
@@ -220,6 +220,27 @@ CH_PCI_DEVICE_ID_TABLE_DEFINE_BEGIN
 	CH_PCI_ID_TABLE_FENTRY(0x608a), /* Custom T62100-CR */
 	CH_PCI_ID_TABLE_FENTRY(0x608b), /* Custom T6225-CR */
 	CH_PCI_ID_TABLE_FENTRY(0x6092), /* Custom T62100-CR-LOM */
+
+	/* T7 adapter */
+	CH_PCI_ID_TABLE_FENTRY(0x7000), /* T7-DBG */
+	CH_PCI_ID_TABLE_FENTRY(0x7001), /* T7250 */
+	CH_PCI_ID_TABLE_FENTRY(0x7002), /* S7250 */
+	CH_PCI_ID_TABLE_FENTRY(0x7003), /* T7450 */
+	CH_PCI_ID_TABLE_FENTRY(0x7004), /* S7450 */
+	CH_PCI_ID_TABLE_FENTRY(0x7005), /* T72200 */
+	CH_PCI_ID_TABLE_FENTRY(0x7006), /* S72200 */
+	CH_PCI_ID_TABLE_FENTRY(0x7007), /* T72200-FH */
+	CH_PCI_ID_TABLE_FENTRY(0x7008), /* T71400 */
+	CH_PCI_ID_TABLE_FENTRY(0x7009), /* S7210-BT */
+	CH_PCI_ID_TABLE_FENTRY(0x700a), /* T7450-RC */
+	CH_PCI_ID_TABLE_FENTRY(0x700b), /* T72200-RC */
+	CH_PCI_ID_TABLE_FENTRY(0x700c), /* T72200-FH-RC */
+	CH_PCI_ID_TABLE_FENTRY(0x700d), /* S72200-OCP3 */
+	CH_PCI_ID_TABLE_FENTRY(0x700e), /* S7450-OCP3 */
+	CH_PCI_ID_TABLE_FENTRY(0x700f), /* S7410-BT-OCP3 */
+	CH_PCI_ID_TABLE_FENTRY(0x7010), /* S7210-BT-A */
+	CH_PCI_ID_TABLE_FENTRY(0x7011), /* T7_MAYRA_7 */
+	CH_PCI_ID_TABLE_FENTRY(0x7012), /* T7-iNIC */
 CH_PCI_DEVICE_ID_TABLE_DEFINE_END;
 
 #endif /* __T4_PCI_ID_TBL_H__ */
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_regs.h b/drivers/net/ethernet/chelsio/cxgb4/t4_regs.h
index 695916ba0405..5ac262ec389f 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_regs.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_regs.h
@@ -66,6 +66,8 @@
 #define MC_BIST_STATUS_REG(reg_addr, idx) ((reg_addr) + (idx) * 4)
 #define EDC_BIST_STATUS_REG(reg_addr, idx) ((reg_addr) + (idx) * 4)
 
+#define T7_PCIE_MEM_ACCESS_REG(reg_addr, idx) ((reg_addr) + (idx) * 16)
+
 #define PCIE_FW_REG(reg_addr, idx) ((reg_addr) + (idx) * 4)
 
 #define NUM_LE_DB_DBGI_REQ_DATA_INSTANCES 17
@@ -172,6 +174,7 @@
 
 #define SGE_CTXT_DATA0_A 0x1200
 #define SGE_CTXT_DATA5_A 0x1214
+#define SGE_CTXT_DATA6_A 0x1218
 
 #define GLOBALENABLE_S    0
 #define GLOBALENABLE_V(x) ((x) << GLOBALENABLE_S)
@@ -229,8 +232,204 @@
 #define QUEUESPERPAGEPF0_V(x) ((x) << QUEUESPERPAGEPF0_S)
 #define QUEUESPERPAGEPF0_G(x) (((x) >> QUEUESPERPAGEPF0_S) & QUEUESPERPAGEPF0_M)
 
+#define SGE_INT_ENABLE1_A 0x1028
 #define SGE_INT_CAUSE1_A	0x1024
+
+#define PERR_FLM_CREDITFIFO_S    30
+#define PERR_FLM_CREDITFIFO_V(x) ((x) << PERR_FLM_CREDITFIFO_S)
+#define PERR_FLM_CREDITFIFO_F    PERR_FLM_CREDITFIFO_V(1U)
+
+#define PERR_IMSG_HINT_FIFO_S    29
+#define PERR_IMSG_HINT_FIFO_V(x) ((x) << PERR_IMSG_HINT_FIFO_S)
+#define PERR_IMSG_HINT_FIFO_F    PERR_IMSG_HINT_FIFO_V(1U)
+
+#define PERR_DMARBT_S    17
+#define PERR_DMARBT_V(x) ((x) << PERR_DMARBT_S)
+#define PERR_DMARBT_F    PERR_DMARBT_V(1U)
+
+#define PERR_FLM_DBPFIFO_S    16
+#define PERR_FLM_DBPFIFO_V(x) ((x) << PERR_FLM_DBPFIFO_S)
+#define PERR_FLM_DBPFIFO_F    PERR_FLM_DBPFIFO_V(1U)
+
+#define PERR_FLM_MCREQ_FIFO_S    15
+#define PERR_FLM_MCREQ_FIFO_V(x) ((x) << PERR_FLM_MCREQ_FIFO_S)
+#define PERR_FLM_MCREQ_FIFO_F    PERR_FLM_MCREQ_FIFO_V(1U)
+
+#define PERR_FLM_HINTFIFO_S    14
+#define PERR_FLM_HINTFIFO_V(x) ((x) << PERR_FLM_HINTFIFO_S)
+#define PERR_FLM_HINTFIFO_F    PERR_FLM_HINTFIFO_V(1U)
+
+#define PERR_ING_CTXT_MIFRSP_S    1
+#define PERR_ING_CTXT_MIFRSP_V(x) ((x) << PERR_ING_CTXT_MIFRSP_S)
+#define PERR_ING_CTXT_MIFRSP_F    PERR_ING_CTXT_MIFRSP_V(1U)
+
+#define PERR_EGR_CTXT_MIFRSP_S    0
+#define PERR_EGR_CTXT_MIFRSP_V(x) ((x) << PERR_EGR_CTXT_MIFRSP_S)
+#define PERR_EGR_CTXT_MIFRSP_F    PERR_EGR_CTXT_MIFRSP_V(1U)
+
+#define PERR_PC_RSP_S    23
+#define PERR_PC_RSP_V(x) ((x) << PERR_PC_RSP_S)
+#define PERR_PC_RSP_F    PERR_PC_RSP_V(1U)
+
+#define PERR_PC_REQ_S    22
+#define PERR_PC_REQ_V(x) ((x) << PERR_PC_REQ_S)
+#define PERR_PC_REQ_F    PERR_PC_REQ_V(1U)
+
+#define PERR_HEADERSPLIT_FIFO3_S    28
+#define PERR_HEADERSPLIT_FIFO3_V(x) ((x) << PERR_HEADERSPLIT_FIFO3_S)
+#define PERR_HEADERSPLIT_FIFO3_F    PERR_HEADERSPLIT_FIFO3_V(1U)
+
+#define PERR_HEADERSPLIT_FIFO2_S    27
+#define PERR_HEADERSPLIT_FIFO2_V(x) ((x) << PERR_HEADERSPLIT_FIFO2_S)
+#define PERR_HEADERSPLIT_FIFO2_F    PERR_HEADERSPLIT_FIFO2_V(1U)
+
+#define PERR_PAYLOAD_FIFO3_S    26
+#define PERR_PAYLOAD_FIFO3_V(x) ((x) << PERR_PAYLOAD_FIFO3_S)
+#define PERR_PAYLOAD_FIFO3_F    PERR_PAYLOAD_FIFO3_V(1U)
+
+#define PERR_PAYLOAD_FIFO2_S    25
+#define PERR_PAYLOAD_FIFO2_V(x) ((x) << PERR_PAYLOAD_FIFO2_S)
+#define PERR_PAYLOAD_FIFO2_F    PERR_PAYLOAD_FIFO2_V(1U)
+
+#define SGE_INT_ENABLE2_A 0x1034
 #define SGE_INT_CAUSE2_A	0x1030
+
+#define PERR_HINT_DELAY_FIFO1_S    30
+#define PERR_HINT_DELAY_FIFO1_V(x) ((x) << PERR_HINT_DELAY_FIFO1_S)
+#define PERR_HINT_DELAY_FIFO1_F    PERR_HINT_DELAY_FIFO1_V(1U)
+
+#define PERR_HINT_DELAY_FIFO0_S    29
+#define PERR_HINT_DELAY_FIFO0_V(x) ((x) << PERR_HINT_DELAY_FIFO0_S)
+#define PERR_HINT_DELAY_FIFO0_F    PERR_HINT_DELAY_FIFO0_V(1U)
+
+#define PERR_IMSG_PD_FIFO_S    28
+#define PERR_IMSG_PD_FIFO_V(x) ((x) << PERR_IMSG_PD_FIFO_S)
+#define PERR_IMSG_PD_FIFO_F    PERR_IMSG_PD_FIFO_V(1U)
+
+#define PERR_ULPTX_FIFO1_S    27
+#define PERR_ULPTX_FIFO1_V(x) ((x) << PERR_ULPTX_FIFO1_S)
+#define PERR_ULPTX_FIFO1_F    PERR_ULPTX_FIFO1_V(1U)
+
+#define PERR_ULPTX_FIFO0_S    26
+#define PERR_ULPTX_FIFO0_V(x) ((x) << PERR_ULPTX_FIFO0_S)
+#define PERR_ULPTX_FIFO0_F    PERR_ULPTX_FIFO0_V(1U)
+
+#define PERR_IDMA2IMSG_FIFO1_S    25
+#define PERR_IDMA2IMSG_FIFO1_V(x) ((x) << PERR_IDMA2IMSG_FIFO1_S)
+#define PERR_IDMA2IMSG_FIFO1_F    PERR_IDMA2IMSG_FIFO1_V(1U)
+
+#define PERR_IDMA2IMSG_FIFO0_S    24
+#define PERR_IDMA2IMSG_FIFO0_V(x) ((x) << PERR_IDMA2IMSG_FIFO0_S)
+#define PERR_IDMA2IMSG_FIFO0_F    PERR_IDMA2IMSG_FIFO0_V(1U)
+
+#define PERR_HEADERSPLIT_FIFO1_S    23
+#define PERR_HEADERSPLIT_FIFO1_V(x) ((x) << PERR_HEADERSPLIT_FIFO1_S)
+#define PERR_HEADERSPLIT_FIFO1_F    PERR_HEADERSPLIT_FIFO1_V(1U)
+
+#define PERR_HEADERSPLIT_FIFO0_S    22
+#define PERR_HEADERSPLIT_FIFO0_V(x) ((x) << PERR_HEADERSPLIT_FIFO0_S)
+#define PERR_HEADERSPLIT_FIFO0_F    PERR_HEADERSPLIT_FIFO0_V(1U)
+
+#define PERR_CONM_SRAM_S    14
+#define PERR_CONM_SRAM_V(x) ((x) << PERR_CONM_SRAM_S)
+#define PERR_CONM_SRAM_F    PERR_CONM_SRAM_V(1U)
+
+#define PERR_ISW_IDMA0_FIFO_S    12
+#define PERR_ISW_IDMA0_FIFO_V(x) ((x) << PERR_ISW_IDMA0_FIFO_S)
+#define PERR_ISW_IDMA0_FIFO_F    PERR_ISW_IDMA0_FIFO_V(1U)
+
+#define PERR_ISW_IDMA1_FIFO_S    11
+#define PERR_ISW_IDMA1_FIFO_V(x) ((x) << PERR_ISW_IDMA1_FIFO_S)
+#define PERR_ISW_IDMA1_FIFO_F    PERR_ISW_IDMA1_FIFO_V(1U)
+
+#define PERR_ISW_DBP_FIFO_S    10
+#define PERR_ISW_DBP_FIFO_V(x) ((x) << PERR_ISW_DBP_FIFO_S)
+#define PERR_ISW_DBP_FIFO_F    PERR_ISW_DBP_FIFO_V(1U)
+
+#define PERR_ISW_GTS_FIFO_S    9
+#define PERR_ISW_GTS_FIFO_V(x) ((x) << PERR_ISW_GTS_FIFO_S)
+#define PERR_ISW_GTS_FIFO_F    PERR_ISW_GTS_FIFO_V(1U)
+
+#define PERR_ITP_EVR_S    8
+#define PERR_ITP_EVR_V(x) ((x) << PERR_ITP_EVR_S)
+#define PERR_ITP_EVR_F    PERR_ITP_EVR_V(1U)
+
+#define PERR_FLM_CNTXMEM_S    7
+#define PERR_FLM_CNTXMEM_V(x) ((x) << PERR_FLM_CNTXMEM_S)
+#define PERR_FLM_CNTXMEM_F    PERR_FLM_CNTXMEM_V(1U)
+
+#define PERR_FLM_L1CACHE_S    6
+#define PERR_FLM_L1CACHE_V(x) ((x) << PERR_FLM_L1CACHE_S)
+#define PERR_FLM_L1CACHE_F    PERR_FLM_L1CACHE_V(1U)
+
+#define PERR_DBP_HINT_FIFO_S    5
+#define PERR_DBP_HINT_FIFO_V(x) ((x) << PERR_DBP_HINT_FIFO_S)
+#define PERR_DBP_HINT_FIFO_F    PERR_DBP_HINT_FIFO_V(1U)
+
+#define PERR_DBP_HP_FIFO_S    4
+#define PERR_DBP_HP_FIFO_V(x) ((x) << PERR_DBP_HP_FIFO_S)
+#define PERR_DBP_HP_FIFO_F    PERR_DBP_HP_FIFO_V(1U)
+
+#define PERR_ING_CTXT_CACHE_S    2
+#define PERR_ING_CTXT_CACHE_V(x) ((x) << PERR_ING_CTXT_CACHE_S)
+#define PERR_ING_CTXT_CACHE_F    PERR_ING_CTXT_CACHE_V(1U)
+
+#define PERR_EGR_CTXT_CACHE_S    1
+#define PERR_EGR_CTXT_CACHE_V(x) ((x) << PERR_EGR_CTXT_CACHE_S)
+#define PERR_EGR_CTXT_CACHE_F    PERR_EGR_CTXT_CACHE_V(1U)
+
+#define PERR_BASE_SIZE_S    0
+#define PERR_BASE_SIZE_V(x) ((x) << PERR_BASE_SIZE_S)
+#define PERR_BASE_SIZE_F    PERR_BASE_SIZE_V(1U)
+
+#define PERR_DBP_HINT_FL_FIFO_S    24
+#define PERR_DBP_HINT_FL_FIFO_V(x) ((x) << PERR_DBP_HINT_FL_FIFO_S)
+#define PERR_DBP_HINT_FL_FIFO_F    PERR_DBP_HINT_FL_FIFO_V(1U)
+
+#define PERR_EGR_DBP_TX_COAL_S    23
+#define PERR_EGR_DBP_TX_COAL_V(x) ((x) << PERR_EGR_DBP_TX_COAL_S)
+#define PERR_EGR_DBP_TX_COAL_F    PERR_EGR_DBP_TX_COAL_V(1U)
+
+#define PERR_DBP_FL_FIFO_S    22
+#define PERR_DBP_FL_FIFO_V(x) ((x) << PERR_DBP_FL_FIFO_S)
+#define PERR_DBP_FL_FIFO_F    PERR_DBP_FL_FIFO_V(1U)
+
+#define DEQ_LL_PERR_S    21
+#define DEQ_LL_PERR_V(x) ((x) << DEQ_LL_PERR_S)
+#define DEQ_LL_PERR_F    DEQ_LL_PERR_V(1U)
+
+#define ENQ_PERR_S    20
+#define ENQ_PERR_V(x) ((x) << ENQ_PERR_S)
+#define ENQ_PERR_F    ENQ_PERR_V(1U)
+
+#define DEQ_OUT_PERR_S    19
+#define DEQ_OUT_PERR_V(x) ((x) << DEQ_OUT_PERR_S)
+#define DEQ_OUT_PERR_F    DEQ_OUT_PERR_V(1U)
+
+#define BUF_PERR_S    18
+#define BUF_PERR_V(x) ((x) << BUF_PERR_S)
+#define BUF_PERR_F    BUF_PERR_V(1U)
+
+#define PERR_DB_FIFO_S    3
+#define PERR_DB_FIFO_V(x) ((x) << PERR_DB_FIFO_S)
+#define PERR_DB_FIFO_F    PERR_DB_FIFO_V(1U)
+
+#define TF_FIFO_PERR_S    24
+#define TF_FIFO_PERR_V(x) ((x) << TF_FIFO_PERR_S)
+#define TF_FIFO_PERR_F    TF_FIFO_PERR_V(1U)
+
+#define PERR_ISW_IDMA3_FIFO_S    15
+#define PERR_ISW_IDMA3_FIFO_V(x) ((x) << PERR_ISW_IDMA3_FIFO_S)
+#define PERR_ISW_IDMA3_FIFO_F    PERR_ISW_IDMA3_FIFO_V(1U)
+
+#define PERR_ISW_IDMA2_FIFO_S    13
+#define PERR_ISW_IDMA2_FIFO_V(x) ((x) << PERR_ISW_IDMA2_FIFO_S)
+#define PERR_ISW_IDMA2_FIFO_F    PERR_ISW_IDMA2_FIFO_V(1U)
+
+#define SGE_IPP_FIFO_PERR_S    5
+#define SGE_IPP_FIFO_PERR_V(x) ((x) << SGE_IPP_FIFO_PERR_S)
+#define SGE_IPP_FIFO_PERR_F    SGE_IPP_FIFO_PERR_V(1U)
+
 #define SGE_INT_CAUSE3_A	0x103c
 
 #define ERR_FLM_DBP_S    31
@@ -329,6 +528,505 @@
 #define EGRESS_SIZE_ERR_V(x) ((x) << EGRESS_SIZE_ERR_S)
 #define EGRESS_SIZE_ERR_F    EGRESS_SIZE_ERR_V(1U)
 
+#define SGE_INT_ENABLE4_A 0x10e0
+#define SGE_INT_CAUSE4_A	0x10dc
+
+#define ERR_BAD_UPFL_INC_CREDIT3_S    8
+#define ERR_BAD_UPFL_INC_CREDIT3_V(x) ((x) << ERR_BAD_UPFL_INC_CREDIT3_S)
+#define ERR_BAD_UPFL_INC_CREDIT3_F    ERR_BAD_UPFL_INC_CREDIT3_V(1U)
+
+#define ERR_BAD_UPFL_INC_CREDIT2_S    7
+#define ERR_BAD_UPFL_INC_CREDIT2_V(x) ((x) << ERR_BAD_UPFL_INC_CREDIT2_S)
+#define ERR_BAD_UPFL_INC_CREDIT2_F    ERR_BAD_UPFL_INC_CREDIT2_V(1U)
+
+#define ERR_BAD_UPFL_INC_CREDIT1_S    6
+#define ERR_BAD_UPFL_INC_CREDIT1_V(x) ((x) << ERR_BAD_UPFL_INC_CREDIT1_S)
+#define ERR_BAD_UPFL_INC_CREDIT1_F    ERR_BAD_UPFL_INC_CREDIT1_V(1U)
+
+#define ERR_BAD_UPFL_INC_CREDIT0_S    5
+#define ERR_BAD_UPFL_INC_CREDIT0_V(x) ((x) << ERR_BAD_UPFL_INC_CREDIT0_S)
+#define ERR_BAD_UPFL_INC_CREDIT0_F    ERR_BAD_UPFL_INC_CREDIT0_V(1U)
+
+#define ERR_PHYSADDR_LEN0_IDMA1_S    4
+#define ERR_PHYSADDR_LEN0_IDMA1_V(x) ((x) << ERR_PHYSADDR_LEN0_IDMA1_S)
+#define ERR_PHYSADDR_LEN0_IDMA1_F    ERR_PHYSADDR_LEN0_IDMA1_V(1U)
+
+#define ERR_PHYSADDR_LEN0_IDMA0_S    3
+#define ERR_PHYSADDR_LEN0_IDMA0_V(x) ((x) << ERR_PHYSADDR_LEN0_IDMA0_S)
+#define ERR_PHYSADDR_LEN0_IDMA0_F    ERR_PHYSADDR_LEN0_IDMA0_V(1U)
+
+#define ERR_FLM_INVALID_PKT_DROP1_S    2
+#define ERR_FLM_INVALID_PKT_DROP1_V(x) ((x) << ERR_FLM_INVALID_PKT_DROP1_S)
+#define ERR_FLM_INVALID_PKT_DROP1_F    ERR_FLM_INVALID_PKT_DROP1_V(1U)
+
+#define ERR_FLM_INVALID_PKT_DROP0_S    1
+#define ERR_FLM_INVALID_PKT_DROP0_V(x) ((x) << ERR_FLM_INVALID_PKT_DROP0_S)
+#define ERR_FLM_INVALID_PKT_DROP0_F    ERR_FLM_INVALID_PKT_DROP0_V(1U)
+
+#define ERR_UNEXPECTED_TIMER_S    0
+#define ERR_UNEXPECTED_TIMER_V(x) ((x) << ERR_UNEXPECTED_TIMER_S)
+#define ERR_UNEXPECTED_TIMER_F    ERR_UNEXPECTED_TIMER_V(1U)
+
+#define BAR2_EGRESS_LEN_OR_ADDR_ERR_S    29
+#define BAR2_EGRESS_LEN_OR_ADDR_ERR_V(x) ((x) << BAR2_EGRESS_LEN_OR_ADDR_ERR_S)
+#define BAR2_EGRESS_LEN_OR_ADDR_ERR_F    BAR2_EGRESS_LEN_OR_ADDR_ERR_V(1U)
+
+#define ERR_CPL_EXCEED_MAX_IQE_SIZE1_S    28
+#define ERR_CPL_EXCEED_MAX_IQE_SIZE1_V(x) ((x) << ERR_CPL_EXCEED_MAX_IQE_SIZE1_S)
+#define ERR_CPL_EXCEED_MAX_IQE_SIZE1_F    ERR_CPL_EXCEED_MAX_IQE_SIZE1_V(1U)
+
+#define ERR_CPL_EXCEED_MAX_IQE_SIZE0_S    27
+#define ERR_CPL_EXCEED_MAX_IQE_SIZE0_V(x) ((x) << ERR_CPL_EXCEED_MAX_IQE_SIZE0_S)
+#define ERR_CPL_EXCEED_MAX_IQE_SIZE0_F    ERR_CPL_EXCEED_MAX_IQE_SIZE0_V(1U)
+
+#define ERR_WR_LEN_TOO_LARGE3_S    26
+#define ERR_WR_LEN_TOO_LARGE3_V(x) ((x) << ERR_WR_LEN_TOO_LARGE3_S)
+#define ERR_WR_LEN_TOO_LARGE3_F    ERR_WR_LEN_TOO_LARGE3_V(1U)
+
+#define ERR_WR_LEN_TOO_LARGE2_S    25
+#define ERR_WR_LEN_TOO_LARGE2_V(x) ((x) << ERR_WR_LEN_TOO_LARGE2_S)
+#define ERR_WR_LEN_TOO_LARGE2_F    ERR_WR_LEN_TOO_LARGE2_V(1U)
+
+#define ERR_WR_LEN_TOO_LARGE1_S    24
+#define ERR_WR_LEN_TOO_LARGE1_V(x) ((x) << ERR_WR_LEN_TOO_LARGE1_S)
+#define ERR_WR_LEN_TOO_LARGE1_F    ERR_WR_LEN_TOO_LARGE1_V(1U)
+
+#define ERR_WR_LEN_TOO_LARGE0_S    23
+#define ERR_WR_LEN_TOO_LARGE0_V(x) ((x) << ERR_WR_LEN_TOO_LARGE0_S)
+#define ERR_WR_LEN_TOO_LARGE0_F    ERR_WR_LEN_TOO_LARGE0_V(1U)
+
+#define ERR_LARGE_MINFETCH_WITH_TXCOAL3_S    22
+#define ERR_LARGE_MINFETCH_WITH_TXCOAL3_V(x) ((x) << ERR_LARGE_MINFETCH_WITH_TXCOAL3_S)
+#define ERR_LARGE_MINFETCH_WITH_TXCOAL3_F    ERR_LARGE_MINFETCH_WITH_TXCOAL3_V(1U)
+
+#define ERR_LARGE_MINFETCH_WITH_TXCOAL2_S    21
+#define ERR_LARGE_MINFETCH_WITH_TXCOAL2_V(x) ((x) << ERR_LARGE_MINFETCH_WITH_TXCOAL2_S)
+#define ERR_LARGE_MINFETCH_WITH_TXCOAL2_F    ERR_LARGE_MINFETCH_WITH_TXCOAL2_V(1U)
+
+#define ERR_LARGE_MINFETCH_WITH_TXCOAL1_S    20
+#define ERR_LARGE_MINFETCH_WITH_TXCOAL1_V(x) ((x) << ERR_LARGE_MINFETCH_WITH_TXCOAL1_S)
+#define ERR_LARGE_MINFETCH_WITH_TXCOAL1_F    ERR_LARGE_MINFETCH_WITH_TXCOAL1_V(1U)
+
+#define ERR_LARGE_MINFETCH_WITH_TXCOAL0_S    19
+#define ERR_LARGE_MINFETCH_WITH_TXCOAL0_V(x) ((x) << ERR_LARGE_MINFETCH_WITH_TXCOAL0_S)
+#define ERR_LARGE_MINFETCH_WITH_TXCOAL0_F    ERR_LARGE_MINFETCH_WITH_TXCOAL0_V(1U)
+
+#define COAL_WITH_HP_DISABLE_ERR_S    18
+#define COAL_WITH_HP_DISABLE_ERR_V(x) ((x) << COAL_WITH_HP_DISABLE_ERR_S)
+#define COAL_WITH_HP_DISABLE_ERR_F    COAL_WITH_HP_DISABLE_ERR_V(1U)
+
+#define BAR2_EGRESS_COAL0_ERR_S    17
+#define BAR2_EGRESS_COAL0_ERR_V(x) ((x) << BAR2_EGRESS_COAL0_ERR_S)
+#define BAR2_EGRESS_COAL0_ERR_F    BAR2_EGRESS_COAL0_ERR_V(1U)
+
+#define BAR2_EGRESS_SIZE_ERR_S    16
+#define BAR2_EGRESS_SIZE_ERR_V(x) ((x) << BAR2_EGRESS_SIZE_ERR_S)
+#define BAR2_EGRESS_SIZE_ERR_F    BAR2_EGRESS_SIZE_ERR_V(1U)
+
+#define FLM_PC_RSP_ERR_S    15
+#define FLM_PC_RSP_ERR_V(x) ((x) << FLM_PC_RSP_ERR_S)
+#define FLM_PC_RSP_ERR_F    FLM_PC_RSP_ERR_V(1U)
+
+#define ERR_RX_CPL_PACKET_SIZE1_S    10
+#define ERR_RX_CPL_PACKET_SIZE1_V(x) ((x) << ERR_RX_CPL_PACKET_SIZE1_S)
+#define ERR_RX_CPL_PACKET_SIZE1_F    ERR_RX_CPL_PACKET_SIZE1_V(1U)
+
+#define ERR_RX_CPL_PACKET_SIZE0_S    9
+#define ERR_RX_CPL_PACKET_SIZE0_V(x) ((x) << ERR_RX_CPL_PACKET_SIZE0_S)
+#define ERR_RX_CPL_PACKET_SIZE0_F    ERR_RX_CPL_PACKET_SIZE0_V(1U)
+
+#define ERR_ISHIFT_UR1_S    31
+#define ERR_ISHIFT_UR1_V(x) ((x) << ERR_ISHIFT_UR1_S)
+#define ERR_ISHIFT_UR1_F    ERR_ISHIFT_UR1_V(1U)
+
+#define ERR_ISHIFT_UR0_S    30
+#define ERR_ISHIFT_UR0_V(x) ((x) << ERR_ISHIFT_UR0_S)
+#define ERR_ISHIFT_UR0_F    ERR_ISHIFT_UR0_V(1U)
+
+#define ERR_TH3_MAX_FETCH_S    14
+#define ERR_TH3_MAX_FETCH_V(x) ((x) << ERR_TH3_MAX_FETCH_S)
+#define ERR_TH3_MAX_FETCH_F    ERR_TH3_MAX_FETCH_V(1U)
+
+#define ERR_TH2_MAX_FETCH_S    13
+#define ERR_TH2_MAX_FETCH_V(x) ((x) << ERR_TH2_MAX_FETCH_S)
+#define ERR_TH2_MAX_FETCH_F    ERR_TH2_MAX_FETCH_V(1U)
+
+#define ERR_TH1_MAX_FETCH_S    12
+#define ERR_TH1_MAX_FETCH_V(x) ((x) << ERR_TH1_MAX_FETCH_S)
+#define ERR_TH1_MAX_FETCH_F    ERR_TH1_MAX_FETCH_V(1U)
+
+#define ERR_TH0_MAX_FETCH_S    11
+#define ERR_TH0_MAX_FETCH_V(x) ((x) << ERR_TH0_MAX_FETCH_S)
+#define ERR_TH0_MAX_FETCH_F    ERR_TH0_MAX_FETCH_V(1U)
+
+#define SGE_INT_ENABLE5_A 0x1110
+#define SGE_INT_CAUSE5_A        0x110c
+
+#define ERR_T_RXCRC_S    31
+#define ERR_T_RXCRC_V(x) ((x) << ERR_T_RXCRC_S)
+#define ERR_T_RXCRC_F    ERR_T_RXCRC_V(1U)
+
+#define PERR_MC_RSPDATA_S    30
+#define PERR_MC_RSPDATA_V(x) ((x) << PERR_MC_RSPDATA_S)
+#define PERR_MC_RSPDATA_F    PERR_MC_RSPDATA_V(1U)
+
+#define PERR_PC_RSPDATA_S    29
+#define PERR_PC_RSPDATA_V(x) ((x) << PERR_PC_RSPDATA_S)
+#define PERR_PC_RSPDATA_F    PERR_PC_RSPDATA_V(1U)
+
+#define PERR_PD_RDRSPDATA_S    28
+#define PERR_PD_RDRSPDATA_V(x) ((x) << PERR_PD_RDRSPDATA_S)
+#define PERR_PD_RDRSPDATA_F    PERR_PD_RDRSPDATA_V(1U)
+
+#define PERR_U_RXDATA_S    27
+#define PERR_U_RXDATA_V(x) ((x) << PERR_U_RXDATA_S)
+#define PERR_U_RXDATA_F    PERR_U_RXDATA_V(1U)
+
+#define PERR_UD_RXDATA_S    26
+#define PERR_UD_RXDATA_V(x) ((x) << PERR_UD_RXDATA_S)
+#define PERR_UD_RXDATA_F    PERR_UD_RXDATA_V(1U)
+
+#define PERR_UP_DATA_S    25
+#define PERR_UP_DATA_V(x) ((x) << PERR_UP_DATA_S)
+#define PERR_UP_DATA_F    PERR_UP_DATA_V(1U)
+
+#define PERR_CIM2SGE_RXDATA_S    24
+#define PERR_CIM2SGE_RXDATA_V(x) ((x) << PERR_CIM2SGE_RXDATA_S)
+#define PERR_CIM2SGE_RXDATA_F    PERR_CIM2SGE_RXDATA_V(1U)
+
+#define PERR_POINTER_DATA_FIFO0_S    16
+#define PERR_POINTER_DATA_FIFO0_V(x) ((x) << PERR_POINTER_DATA_FIFO0_S)
+#define PERR_POINTER_DATA_FIFO0_F    PERR_POINTER_DATA_FIFO0_V(1U)
+
+#define PERR_POINTER_DATA_FIFO1_S    15
+#define PERR_POINTER_DATA_FIFO1_V(x) ((x) << PERR_POINTER_DATA_FIFO1_S)
+#define PERR_POINTER_DATA_FIFO1_F    PERR_POINTER_DATA_FIFO1_V(1U)
+
+#define PERR_POINTER_HDR_FIFO0_S    14
+#define PERR_POINTER_HDR_FIFO0_V(x) ((x) << PERR_POINTER_HDR_FIFO0_S)
+#define PERR_POINTER_HDR_FIFO0_F    PERR_POINTER_HDR_FIFO0_V(1U)
+
+#define PERR_POINTER_HDR_FIFO1_S    13
+#define PERR_POINTER_HDR_FIFO1_V(x) ((x) << PERR_POINTER_HDR_FIFO1_S)
+#define PERR_POINTER_HDR_FIFO1_F    PERR_POINTER_HDR_FIFO1_V(1U)
+
+#define PERR_PAYLOAD_FIFO0_S    12
+#define PERR_PAYLOAD_FIFO0_V(x) ((x) << PERR_PAYLOAD_FIFO0_S)
+#define PERR_PAYLOAD_FIFO0_F    PERR_PAYLOAD_FIFO0_V(1U)
+
+#define PERR_PAYLOAD_FIFO1_S    11
+#define PERR_PAYLOAD_FIFO1_V(x) ((x) << PERR_PAYLOAD_FIFO1_S)
+#define PERR_PAYLOAD_FIFO1_F    PERR_PAYLOAD_FIFO1_V(1U)
+
+#define PERR_EDMA_INPUT_FIFO3_S    10
+#define PERR_EDMA_INPUT_FIFO3_V(x) ((x) << PERR_EDMA_INPUT_FIFO3_S)
+#define PERR_EDMA_INPUT_FIFO3_F    PERR_EDMA_INPUT_FIFO3_V(1U)
+
+#define PERR_EDMA_INPUT_FIFO2_S    9
+#define PERR_EDMA_INPUT_FIFO2_V(x) ((x) << PERR_EDMA_INPUT_FIFO2_S)
+#define PERR_EDMA_INPUT_FIFO2_F    PERR_EDMA_INPUT_FIFO2_V(1U)
+
+#define PERR_EDMA_INPUT_FIFO1_S    8
+#define PERR_EDMA_INPUT_FIFO1_V(x) ((x) << PERR_EDMA_INPUT_FIFO1_S)
+#define PERR_EDMA_INPUT_FIFO1_F    PERR_EDMA_INPUT_FIFO1_V(1U)
+
+#define PERR_EDMA_INPUT_FIFO0_S    7
+#define PERR_EDMA_INPUT_FIFO0_V(x) ((x) << PERR_EDMA_INPUT_FIFO0_S)
+#define PERR_EDMA_INPUT_FIFO0_F    PERR_EDMA_INPUT_FIFO0_V(1U)
+
+#define PERR_MGT_BAR2_FIFO_S    6
+#define PERR_MGT_BAR2_FIFO_V(x) ((x) << PERR_MGT_BAR2_FIFO_S)
+#define PERR_MGT_BAR2_FIFO_F    PERR_MGT_BAR2_FIFO_V(1U)
+
+#define PERR_CIM_FIFO1_S    3
+#define PERR_CIM_FIFO1_V(x) ((x) << PERR_CIM_FIFO1_S)
+#define PERR_CIM_FIFO1_F    PERR_CIM_FIFO1_V(1U)
+
+#define PERR_CIM_FIFO0_S    2
+#define PERR_CIM_FIFO0_V(x) ((x) << PERR_CIM_FIFO0_S)
+#define PERR_CIM_FIFO0_F    PERR_CIM_FIFO0_V(1U)
+
+#define PERR_IDMA_SWITCH_OUTPUT_FIFO1_S    1
+#define PERR_IDMA_SWITCH_OUTPUT_FIFO1_V(x) ((x) << PERR_IDMA_SWITCH_OUTPUT_FIFO1_S)
+#define PERR_IDMA_SWITCH_OUTPUT_FIFO1_F    PERR_IDMA_SWITCH_OUTPUT_FIFO1_V(1U)
+
+#define PERR_IDMA_SWITCH_OUTPUT_FIFO0_S    0
+#define PERR_IDMA_SWITCH_OUTPUT_FIFO0_V(x) ((x) << PERR_IDMA_SWITCH_OUTPUT_FIFO0_S)
+#define PERR_IDMA_SWITCH_OUTPUT_FIFO0_F    PERR_IDMA_SWITCH_OUTPUT_FIFO0_V(1U)
+
+#define PERR_POINTER_HDR_FIFO3_S    10
+#define PERR_POINTER_HDR_FIFO3_V(x) ((x) << PERR_POINTER_HDR_FIFO3_S)
+#define PERR_POINTER_HDR_FIFO3_F    PERR_POINTER_HDR_FIFO3_V(1U)
+
+#define PERR_POINTER_HDR_FIFO2_S    9
+#define PERR_POINTER_HDR_FIFO2_V(x) ((x) << PERR_POINTER_HDR_FIFO2_S)
+#define PERR_POINTER_HDR_FIFO2_F    PERR_POINTER_HDR_FIFO2_V(1U)
+
+#define PERR_POINTER_DATA_FIFO3_S    8
+#define PERR_POINTER_DATA_FIFO3_V(x) ((x) << PERR_POINTER_DATA_FIFO3_S)
+#define PERR_POINTER_DATA_FIFO3_F    PERR_POINTER_DATA_FIFO3_V(1U)
+
+#define PERR_POINTER_DATA_FIFO2_S    7
+#define PERR_POINTER_DATA_FIFO2_V(x) ((x) << PERR_POINTER_DATA_FIFO2_S)
+#define PERR_POINTER_DATA_FIFO2_F    PERR_POINTER_DATA_FIFO2_V(1U)
+
+#define PERR_IDMA2IMSG_FIFO3_S    3
+#define PERR_IDMA2IMSG_FIFO3_V(x) ((x) << PERR_IDMA2IMSG_FIFO3_S)
+#define PERR_IDMA2IMSG_FIFO3_F    PERR_IDMA2IMSG_FIFO3_V(1U)
+
+#define PERR_IDMA2IMSG_FIFO2_S    2
+#define PERR_IDMA2IMSG_FIFO2_V(x) ((x) << PERR_IDMA2IMSG_FIFO2_S)
+#define PERR_IDMA2IMSG_FIFO2_F    PERR_IDMA2IMSG_FIFO2_V(1U)
+
+#define PERR_HINT_DELAY_FIFO_S    0
+#define PERR_HINT_DELAY_FIFO_V(x) ((x) << PERR_HINT_DELAY_FIFO_S)
+#define PERR_HINT_DELAY_FIFO_F    PERR_HINT_DELAY_FIFO_V(1U)
+
+#define SGE_INT_ENABLE6_A 0x112c
+#define SGE_INT_CAUSE6_A	0x1128
+
+#define FATAL_TAG_MISMATCH_S    13
+#define FATAL_TAG_MISMATCH_V(x) ((x) << FATAL_TAG_MISMATCH_S)
+#define FATAL_TAG_MISMATCH_F    FATAL_TAG_MISMATCH_V(1U)
+
+#define FATAL_ENQ_CTL_RDY_S    12
+#define FATAL_ENQ_CTL_RDY_V(x) ((x) << FATAL_ENQ_CTL_RDY_S)
+#define FATAL_ENQ_CTL_RDY_F    FATAL_ENQ_CTL_RDY_V(1U)
+
+#define ERR_DB_SYNC_S    21
+#define ERR_DB_SYNC_V(x) ((x) << ERR_DB_SYNC_S)
+#define ERR_DB_SYNC_F    ERR_DB_SYNC_V(1U)
+
+#define ERR_GTS_SYNC_S    20
+#define ERR_GTS_SYNC_V(x) ((x) << ERR_GTS_SYNC_S)
+#define ERR_GTS_SYNC_F    ERR_GTS_SYNC_V(1U)
+
+#define FATAL_LARGE_COAL_S    19
+#define FATAL_LARGE_COAL_V(x) ((x) << FATAL_LARGE_COAL_S)
+#define FATAL_LARGE_COAL_F    FATAL_LARGE_COAL_V(1U)
+
+#define PL_BAR2_FRM_ERR_S    18
+#define PL_BAR2_FRM_ERR_V(x) ((x) << PL_BAR2_FRM_ERR_S)
+#define PL_BAR2_FRM_ERR_F    PL_BAR2_FRM_ERR_V(1U)
+
+#define SILENT_DROP_TX_COAL_S    17
+#define SILENT_DROP_TX_COAL_V(x) ((x) << SILENT_DROP_TX_COAL_S)
+#define SILENT_DROP_TX_COAL_F    SILENT_DROP_TX_COAL_V(1U)
+
+#define ERR_INV_CTXT4_S    16
+#define ERR_INV_CTXT4_V(x) ((x) << ERR_INV_CTXT4_S)
+#define ERR_INV_CTXT4_F    ERR_INV_CTXT4_V(1U)
+
+#define ERR_BAD_DB_PIDX4_S    15
+#define ERR_BAD_DB_PIDX4_V(x) ((x) << ERR_BAD_DB_PIDX4_S)
+#define ERR_BAD_DB_PIDX4_F    ERR_BAD_DB_PIDX4_V(1U)
+
+#define ERR_BAD_UPFL_INC_CREDIT4_S    14
+#define ERR_BAD_UPFL_INC_CREDIT4_V(x) ((x) << ERR_BAD_UPFL_INC_CREDIT4_S)
+#define ERR_BAD_UPFL_INC_CREDIT4_F    ERR_BAD_UPFL_INC_CREDIT4_V(1U)
+
+#define ERR_PC_RSP_LEN3_S    11
+#define ERR_PC_RSP_LEN3_V(x) ((x) << ERR_PC_RSP_LEN3_S)
+#define ERR_PC_RSP_LEN3_F    ERR_PC_RSP_LEN3_V(1U)
+
+#define ERR_PC_RSP_LEN2_S    10
+#define ERR_PC_RSP_LEN2_V(x) ((x) << ERR_PC_RSP_LEN2_S)
+#define ERR_PC_RSP_LEN2_F    ERR_PC_RSP_LEN2_V(1U)
+
+#define ERR_PC_RSP_LEN1_S    9
+#define ERR_PC_RSP_LEN1_V(x) ((x) << ERR_PC_RSP_LEN1_S)
+#define ERR_PC_RSP_LEN1_F    ERR_PC_RSP_LEN1_V(1U)
+
+#define ERR_PC_RSP_LEN0_S    8
+#define ERR_PC_RSP_LEN0_V(x) ((x) << ERR_PC_RSP_LEN0_S)
+#define ERR_PC_RSP_LEN0_F    ERR_PC_RSP_LEN0_V(1U)
+
+#define FATAL_ENQ2LL_VLD_S    7
+#define FATAL_ENQ2LL_VLD_V(x) ((x) << FATAL_ENQ2LL_VLD_S)
+#define FATAL_ENQ2LL_VLD_F    FATAL_ENQ2LL_VLD_V(1U)
+
+#define FATAL_LL_EMPTY_S    6
+#define FATAL_LL_EMPTY_V(x) ((x) << FATAL_LL_EMPTY_S)
+#define FATAL_LL_EMPTY_F    FATAL_LL_EMPTY_V(1U)
+
+#define FATAL_OFF_WDENQ_S    5
+#define FATAL_OFF_WDENQ_V(x) ((x) << FATAL_OFF_WDENQ_S)
+#define FATAL_OFF_WDENQ_F    FATAL_OFF_WDENQ_V(1U)
+
+#define FATAL_DEQ_S    0
+#define FATAL_DEQ_V(x) ((x) << FATAL_DEQ_S)
+#define FATAL_DEQ_F    FATAL_DEQ_V(1U)
+
+#define IMSG_DBG3_STUCK_S    25
+#define IMSG_DBG3_STUCK_V(x) ((x) << IMSG_DBG3_STUCK_S)
+#define IMSG_DBG3_STUCK_F    IMSG_DBG3_STUCK_V(1U)
+
+#define IMSG_DBG2_STUCK_S    24
+#define IMSG_DBG2_STUCK_V(x) ((x) << IMSG_DBG2_STUCK_S)
+#define IMSG_DBG2_STUCK_F    IMSG_DBG2_STUCK_V(1U)
+
+#define IMSG_DBG1_STUCK_S    23
+#define IMSG_DBG1_STUCK_V(x) ((x) << IMSG_DBG1_STUCK_S)
+#define IMSG_DBG1_STUCK_F    IMSG_DBG1_STUCK_V(1U)
+
+#define IMSG_DBG0_STUCK_S    22
+#define IMSG_DBG0_STUCK_V(x) ((x) << IMSG_DBG0_STUCK_S)
+#define IMSG_DBG0_STUCK_F    IMSG_DBG0_STUCK_V(1U)
+
+#define SGE_INT_ENABLE7_A 0x1364
+#define SGE_INT_CAUSE7_A	0x1360
+
+#define HINT_FIFO_FULL_S    25
+#define HINT_FIFO_FULL_V(x) ((x) << HINT_FIFO_FULL_S)
+#define HINT_FIFO_FULL_F    HINT_FIFO_FULL_V(1U)
+
+#define CERR_HINT_DELAY_FIFO_S    24
+#define CERR_HINT_DELAY_FIFO_V(x) ((x) << CERR_HINT_DELAY_FIFO_S)
+#define CERR_HINT_DELAY_FIFO_F    CERR_HINT_DELAY_FIFO_V(1U)
+
+#define COAL_TIMER_FIFO_PERR_S    23
+#define COAL_TIMER_FIFO_PERR_V(x) ((x) << COAL_TIMER_FIFO_PERR_S)
+#define COAL_TIMER_FIFO_PERR_F    COAL_TIMER_FIFO_PERR_V(1U)
+
+#define CMP_FIFO_PERR_S    22
+#define CMP_FIFO_PERR_V(x) ((x) << CMP_FIFO_PERR_S)
+#define CMP_FIFO_PERR_F    CMP_FIFO_PERR_V(1U)
+
+#define SGE_IPP_FIFO_CERR_S    21
+#define SGE_IPP_FIFO_CERR_V(x) ((x) << SGE_IPP_FIFO_CERR_S)
+#define SGE_IPP_FIFO_CERR_F    SGE_IPP_FIFO_CERR_V(1U)
+
+#define CERR_ING_CTXT_CACHE_S    20
+#define CERR_ING_CTXT_CACHE_V(x) ((x) << CERR_ING_CTXT_CACHE_S)
+#define CERR_ING_CTXT_CACHE_F    CERR_ING_CTXT_CACHE_V(1U)
+
+#define IMSG_CNTX_PERR_S    19
+#define IMSG_CNTX_PERR_V(x) ((x) << IMSG_CNTX_PERR_S)
+#define IMSG_CNTX_PERR_F    IMSG_CNTX_PERR_V(1U)
+
+#define PD_FIFO_PERR_S    18
+#define PD_FIFO_PERR_V(x) ((x) << PD_FIFO_PERR_S)
+#define PD_FIFO_PERR_F    PD_FIFO_PERR_V(1U)
+
+#define IMSG_512_FIFO_PERR_S    17
+#define IMSG_512_FIFO_PERR_V(x) ((x) << IMSG_512_FIFO_PERR_S)
+#define IMSG_512_FIFO_PERR_F    IMSG_512_FIFO_PERR_V(1U)
+
+#define CPLSW_FIFO_PERR_S    16
+#define CPLSW_FIFO_PERR_V(x) ((x) << CPLSW_FIFO_PERR_S)
+#define CPLSW_FIFO_PERR_F    CPLSW_FIFO_PERR_V(1U)
+
+#define IMSG_FIFO_PERR_S    15
+#define IMSG_FIFO_PERR_V(x) ((x) << IMSG_FIFO_PERR_S)
+#define IMSG_FIFO_PERR_F    IMSG_FIFO_PERR_V(1U)
+
+#define CERR_ITP_EVR_S    14
+#define CERR_ITP_EVR_V(x) ((x) << CERR_ITP_EVR_S)
+#define CERR_ITP_EVR_F    CERR_ITP_EVR_V(1U)
+
+#define CERR_CONM_SRAM_S    13
+#define CERR_CONM_SRAM_V(x) ((x) << CERR_CONM_SRAM_S)
+#define CERR_CONM_SRAM_F    CERR_CONM_SRAM_V(1U)
+
+#define CERR_EGR_CTXT_CACHE_S    12
+#define CERR_EGR_CTXT_CACHE_V(x) ((x) << CERR_EGR_CTXT_CACHE_S)
+#define CERR_EGR_CTXT_CACHE_F    CERR_EGR_CTXT_CACHE_V(1U)
+
+#define CERR_FLM_CNTXMEM_S    11
+#define CERR_FLM_CNTXMEM_V(x) ((x) << CERR_FLM_CNTXMEM_S)
+#define CERR_FLM_CNTXMEM_F    CERR_FLM_CNTXMEM_V(1U)
+
+#define CERR_FUNC_QBASE_S    10
+#define CERR_FUNC_QBASE_V(x) ((x) << CERR_FUNC_QBASE_S)
+#define CERR_FUNC_QBASE_F    CERR_FUNC_QBASE_V(1U)
+
+#define IMSG_CNTX_CERR_S    9
+#define IMSG_CNTX_CERR_V(x) ((x) << IMSG_CNTX_CERR_S)
+#define IMSG_CNTX_CERR_F    IMSG_CNTX_CERR_V(1U)
+
+#define PD_FIFO_CERR_S    8
+#define PD_FIFO_CERR_V(x) ((x) << PD_FIFO_CERR_S)
+#define PD_FIFO_CERR_F    PD_FIFO_CERR_V(1U)
+
+#define IMSG_512_FIFO_CERR_S    7
+#define IMSG_512_FIFO_CERR_V(x) ((x) << IMSG_512_FIFO_CERR_S)
+#define IMSG_512_FIFO_CERR_F    IMSG_512_FIFO_CERR_V(1U)
+
+#define CPLSW_FIFO_CERR_S    6
+#define CPLSW_FIFO_CERR_V(x) ((x) << CPLSW_FIFO_CERR_S)
+#define CPLSW_FIFO_CERR_F    CPLSW_FIFO_CERR_V(1U)
+
+#define IMSG_FIFO_CERR_S    5
+#define IMSG_FIFO_CERR_V(x) ((x) << IMSG_FIFO_CERR_S)
+#define IMSG_FIFO_CERR_F    IMSG_FIFO_CERR_V(1U)
+
+#define CERR_FLM_L1CACHE_S    0
+#define CERR_FLM_L1CACHE_V(x) ((x) << CERR_FLM_L1CACHE_S)
+#define CERR_FLM_L1CACHE_F    CERR_FLM_L1CACHE_V(1U)
+
+#define SGE_INT_ENABLE8_A 0x11cc
+#define SGE_INT_CAUSE8_A	0x11c8
+
+#define TRACE_RXPERR_S    8
+#define TRACE_RXPERR_V(x) ((x) << TRACE_RXPERR_S)
+#define TRACE_RXPERR_F    TRACE_RXPERR_V(1U)
+
+#define U3_RXPERR_S    7
+#define U3_RXPERR_V(x) ((x) << U3_RXPERR_S)
+#define U3_RXPERR_F    U3_RXPERR_V(1U)
+
+#define U2_RXPERR_S    6
+#define U2_RXPERR_V(x) ((x) << U2_RXPERR_S)
+#define U2_RXPERR_F    U2_RXPERR_V(1U)
+
+#define U1_RXPERR_S    5
+#define U1_RXPERR_V(x) ((x) << U1_RXPERR_S)
+#define U1_RXPERR_F    U1_RXPERR_V(1U)
+
+#define U0_RXPERR_S    4
+#define U0_RXPERR_V(x) ((x) << U0_RXPERR_S)
+#define U0_RXPERR_F    U0_RXPERR_V(1U)
+
+#define T3_RXPERR_S    3
+#define T3_RXPERR_V(x) ((x) << T3_RXPERR_S)
+#define T3_RXPERR_F    T3_RXPERR_V(1U)
+
+#define T2_RXPERR_S    2
+#define T2_RXPERR_V(x) ((x) << T2_RXPERR_S)
+#define T2_RXPERR_F    T2_RXPERR_V(1U)
+
+#define T1_RXPERR_S    1
+#define T1_RXPERR_V(x) ((x) << T1_RXPERR_S)
+#define T1_RXPERR_F    T1_RXPERR_V(1U)
+
+#define T0_RXPERR_S    0
+#define T0_RXPERR_V(x) ((x) << T0_RXPERR_S)
+#define T0_RXPERR_F    T0_RXPERR_V(1U)
+
+#define ERR_TIMER_ABOVE_MAX_QID_S    23
+#define ERR_TIMER_ABOVE_MAX_QID_V(x) ((x) << ERR_TIMER_ABOVE_MAX_QID_S)
+#define ERR_TIMER_ABOVE_MAX_QID_F    ERR_TIMER_ABOVE_MAX_QID_V(1U)
+
+#define ERR_ITP_TIME_PAUSED_S    20
+#define ERR_ITP_TIME_PAUSED_V(x) ((x) << ERR_ITP_TIME_PAUSED_S)
+#define ERR_ITP_TIME_PAUSED_F    ERR_ITP_TIME_PAUSED_V(1U)
+
+#define ERR_ING_PCIE_CHAN_S    11
+#define ERR_ING_PCIE_CHAN_V(x) ((x) << ERR_ING_PCIE_CHAN_S)
+#define ERR_ING_PCIE_CHAN_F    ERR_ING_PCIE_CHAN_V(1U)
+
+#define REG_ADDRESS_ERR_S    6
+#define REG_ADDRESS_ERR_V(x) ((x) << REG_ADDRESS_ERR_S)
+#define REG_ADDRESS_ERR_F    REG_ADDRESS_ERR_V(1U)
+
+#define DBP_TBUF_FULL_S    8
+#define DBP_TBUF_FULL_V(x) ((x) << DBP_TBUF_FULL_S)
+#define DBP_TBUF_FULL_F    DBP_TBUF_FULL_V(1U)
+
+#define FATAL_WRE_LEN_S    7
+#define FATAL_WRE_LEN_V(x) ((x) << FATAL_WRE_LEN_S)
+#define FATAL_WRE_LEN_F    FATAL_WRE_LEN_V(1U)
+
 #define SGE_INT_ENABLE3_A 0x1040
 #define SGE_FL_BUFFER_SIZE0_A 0x1044
 #define SGE_FL_BUFFER_SIZE1_A 0x1048
@@ -344,10 +1042,6 @@
 #define SGE_FLM_CACHE_BADDR_A 0x108c
 #define SGE_FLM_CFG_A 0x1090
 
-#define NOHDR_S    18
-#define NOHDR_V(x) ((x) << NOHDR_S)
-#define NOHDR_F    NOHDR_V(1U)
-
 #define HDRSTARTFLQ_S    11
 #define HDRSTARTFLQ_M    0x7U
 #define HDRSTARTFLQ_G(x) (((x) >> HDRSTARTFLQ_S) & HDRSTARTFLQ_M)
@@ -378,12 +1072,10 @@
 
 #define EGRTHRESHOLD_S    8
 #define EGRTHRESHOLD_M    0x3fU
-#define EGRTHRESHOLD_V(x) ((x) << EGRTHRESHOLD_S)
 #define EGRTHRESHOLD_G(x) (((x) >> EGRTHRESHOLD_S) & EGRTHRESHOLD_M)
 
 #define EGRTHRESHOLDPACKING_S    14
 #define EGRTHRESHOLDPACKING_M    0x3fU
-#define EGRTHRESHOLDPACKING_V(x) ((x) << EGRTHRESHOLDPACKING_S)
 #define EGRTHRESHOLDPACKING_G(x) \
 	(((x) >> EGRTHRESHOLDPACKING_S) & EGRTHRESHOLDPACKING_M)
 
@@ -395,37 +1087,12 @@
 #define SGE_TIMESTAMP_LO_A 0x1098
 #define SGE_TIMESTAMP_HI_A 0x109c
 
-#define TSOP_S    28
-#define TSOP_M    0x3U
-#define TSOP_V(x) ((x) << TSOP_S)
-#define TSOP_G(x) (((x) >> TSOP_S) & TSOP_M)
-
 #define TSVAL_S    0
 #define TSVAL_M    0xfffffffU
-#define TSVAL_V(x) ((x) << TSVAL_S)
 #define TSVAL_G(x) (((x) >> TSVAL_S) & TSVAL_M)
 
 #define SGE_DBFIFO_STATUS_A 0x10a4
 #define SGE_DBVFIFO_SIZE_A 0x113c
-
-#define HP_INT_THRESH_S    28
-#define HP_INT_THRESH_M    0xfU
-#define HP_INT_THRESH_V(x) ((x) << HP_INT_THRESH_S)
-
-#define LP_INT_THRESH_S    12
-#define LP_INT_THRESH_M    0xfU
-#define LP_INT_THRESH_V(x) ((x) << LP_INT_THRESH_S)
-
-#define SGE_DOORBELL_CONTROL_A 0x10a8
-
-#define NOCOALESCE_S    26
-#define NOCOALESCE_V(x) ((x) << NOCOALESCE_S)
-#define NOCOALESCE_F    NOCOALESCE_V(1U)
-
-#define ENABLE_DROP_S    13
-#define ENABLE_DROP_V(x) ((x) << ENABLE_DROP_S)
-#define ENABLE_DROP_F    ENABLE_DROP_V(1U)
-
 #define SGE_TIMER_VALUE_0_AND_1_A 0x10b8
 
 #define TIMERVALUE0_S    16
@@ -487,24 +1154,10 @@
 #define ERROR_QID_M    0x1ffffU
 #define ERROR_QID_G(x) (((x) >> ERROR_QID_S) & ERROR_QID_M)
 
-#define SGE_INT_CAUSE5_A        0x110c
-
-#define ERR_T_RXCRC_S    31
-#define ERR_T_RXCRC_V(x) ((x) << ERR_T_RXCRC_S)
-#define ERR_T_RXCRC_F    ERR_T_RXCRC_V(1U)
-
-#define HP_INT_THRESH_S    28
-#define HP_INT_THRESH_M    0xfU
-#define HP_INT_THRESH_V(x) ((x) << HP_INT_THRESH_S)
-
 #define HP_COUNT_S    16
 #define HP_COUNT_M    0x7ffU
 #define HP_COUNT_G(x) (((x) >> HP_COUNT_S) & HP_COUNT_M)
 
-#define LP_INT_THRESH_S    12
-#define LP_INT_THRESH_M    0xfU
-#define LP_INT_THRESH_V(x) ((x) << LP_INT_THRESH_S)
-
 #define LP_COUNT_S    0
 #define LP_COUNT_M    0x7ffU
 #define LP_COUNT_G(x) (((x) >> LP_COUNT_S) & LP_COUNT_M)
@@ -537,7 +1190,6 @@
 #define SGE_DBFIFO_STATUS2_A 0x1118
 
 #define HP_INT_THRESH_T5_S    10
-#define HP_INT_THRESH_T5_M    0xfU
 #define HP_INT_THRESH_T5_V(x) ((x) << HP_INT_THRESH_T5_S)
 
 #define HP_COUNT_T5_S    0
@@ -552,7 +1204,6 @@
 #define DROPPED_DB_V(x) ((x) << DROPPED_DB_S)
 #define DROPPED_DB_F    DROPPED_DB_V(1U)
 
-#define SGE_CTXT_CMD_A 0x11fc
 #define SGE_DBQ_CTXT_BADDR_A 0x1084
 
 /* registers for module PCIE */
@@ -569,8 +1220,13 @@
 #define OFFSET_M    0x3fffU
 #define OFFSET_G(x) (((x) >> OFFSET_S) & OFFSET_M)
 
+#define PCIE_INT_ENABLE_A 0x3000
 #define PCIE_INT_CAUSE_A	0x3004
 
+#define NONFATALERR_S    30
+#define NONFATALERR_V(x) ((x) << NONFATALERR_S)
+#define NONFATALERR_F    NONFATALERR_V(1U)
+
 #define UNXSPLCPLERR_S    29
 #define UNXSPLCPLERR_V(x) ((x) << UNXSPLCPLERR_S)
 #define UNXSPLCPLERR_F    UNXSPLCPLERR_V(1U)
@@ -691,6 +1347,10 @@
 #define MSIADDRLPERR_V(x) ((x) << MSIADDRLPERR_S)
 #define MSIADDRLPERR_F    MSIADDRLPERR_V(1U)
 
+#define IPGRPPERR_S    31
+#define IPGRPPERR_V(x) ((x) << IPGRPPERR_S)
+#define IPGRPPERR_F    IPGRPPERR_V(1U)
+
 #define READRSPERR_S    29
 #define READRSPERR_V(x) ((x) << READRSPERR_S)
 #define READRSPERR_F    READRSPERR_V(1U)
@@ -715,6 +1375,10 @@
 #define IPRXHDRGRPPERR_V(x) ((x) << IPRXHDRGRPPERR_S)
 #define IPRXHDRGRPPERR_F    IPRXHDRGRPPERR_V(1U)
 
+#define PIOTAGQPERR_S    23
+#define PIOTAGQPERR_V(x) ((x) << PIOTAGQPERR_S)
+#define PIOTAGQPERR_F    PIOTAGQPERR_V(1U)
+
 #define MAGRPPERR_S    22
 #define MAGRPPERR_V(x) ((x) << MAGRPPERR_S)
 #define MAGRPPERR_F    MAGRPPERR_V(1U)
@@ -723,10 +1387,18 @@
 #define VFIDPERR_V(x) ((x) << VFIDPERR_S)
 #define VFIDPERR_F    VFIDPERR_V(1U)
 
+#define HREQRDPERR_S    17
+#define HREQRDPERR_V(x) ((x) << HREQRDPERR_S)
+#define HREQRDPERR_F    HREQRDPERR_V(1U)
+
 #define HREQWRPERR_S    16
 #define HREQWRPERR_V(x) ((x) << HREQWRPERR_S)
 #define HREQWRPERR_F    HREQWRPERR_V(1U)
 
+#define DREQRDPERR_S    14
+#define DREQRDPERR_V(x) ((x) << DREQRDPERR_S)
+#define DREQRDPERR_F    DREQRDPERR_V(1U)
+
 #define DREQWRPERR_S    13
 #define DREQWRPERR_V(x) ((x) << DREQWRPERR_S)
 #define DREQWRPERR_F    DREQWRPERR_V(1U)
@@ -739,6 +1411,10 @@
 #define MSTTAGQPERR_V(x) ((x) << MSTTAGQPERR_S)
 #define MSTTAGQPERR_F    MSTTAGQPERR_V(1U)
 
+#define TGTTAGQPERR_S    9
+#define TGTTAGQPERR_V(x) ((x) << TGTTAGQPERR_S)
+#define TGTTAGQPERR_F    TGTTAGQPERR_V(1U)
+
 #define PIOREQGRPPERR_S    8
 #define PIOREQGRPPERR_V(x) ((x) << PIOREQGRPPERR_S)
 #define PIOREQGRPPERR_F    PIOREQGRPPERR_V(1U)
@@ -759,8 +1435,154 @@
 #define MSTGRPPERR_V(x) ((x) << MSTGRPPERR_S)
 #define MSTGRPPERR_F    MSTGRPPERR_V(1U)
 
-#define PCIE_NONFAT_ERR_A	0x3010
+#define PCIE_INT_ENABLE_EXT_A 0x3030
+#define PCIE_INT_ENABLE_X8_A 0x3034
+#define PCIE_INT_CAUSE_EXT_A 0x3038
+
+#define IPFORMQPERR_S    30
+#define IPFORMQPERR_V(x) ((x) << IPFORMQPERR_S)
+#define IPFORMQPERR_F    IPFORMQPERR_V(1U)
+
+#define IPFORMQCERR_S    29
+#define IPFORMQCERR_V(x) ((x) << IPFORMQCERR_S)
+#define IPFORMQCERR_F    IPFORMQCERR_V(1U)
+
+#define TRGT1GRPCERR_S    28
+#define TRGT1GRPCERR_V(x) ((x) << TRGT1GRPCERR_S)
+#define TRGT1GRPCERR_F    TRGT1GRPCERR_V(1U)
+
+#define IPSOTCERR_S    27
+#define IPSOTCERR_V(x) ((x) << IPSOTCERR_S)
+#define IPSOTCERR_F    IPSOTCERR_V(1U)
+
+#define IPRETRYCERR_S    26
+#define IPRETRYCERR_V(x) ((x) << IPRETRYCERR_S)
+#define IPRETRYCERR_F    IPRETRYCERR_V(1U)
+
+#define IPRXDATAGRPCERR_S    25
+#define IPRXDATAGRPCERR_V(x) ((x) << IPRXDATAGRPCERR_S)
+#define IPRXDATAGRPCERR_F    IPRXDATAGRPCERR_V(1U)
+
+#define IPRXHDRGRPCERR_S    24
+#define IPRXHDRGRPCERR_V(x) ((x) << IPRXHDRGRPCERR_S)
+#define IPRXHDRGRPCERR_F    IPRXHDRGRPCERR_V(1U)
+
+#define A0ARBRSPORDFIFOPERR_S    19
+#define A0ARBRSPORDFIFOPERR_V(x) ((x) << A0ARBRSPORDFIFOPERR_S)
+#define A0ARBRSPORDFIFOPERR_F    A0ARBRSPORDFIFOPERR_V(1U)
+
+#define HRSPCERR_S    18
+#define HRSPCERR_V(x) ((x) << HRSPCERR_S)
+#define HRSPCERR_F    HRSPCERR_V(1U)
+
+#define HREQRDCERR_S    17
+#define HREQRDCERR_V(x) ((x) << HREQRDCERR_S)
+#define HREQRDCERR_F    HREQRDCERR_V(1U)
+
+#define HREQWRCERR_S    16
+#define HREQWRCERR_V(x) ((x) << HREQWRCERR_S)
+#define HREQWRCERR_F    HREQWRCERR_V(1U)
+
+#define DRSPCERR_S    15
+#define DRSPCERR_V(x) ((x) << DRSPCERR_S)
+#define DRSPCERR_F    DRSPCERR_V(1U)
+
+#define DREQRDCERR_S    14
+#define DREQRDCERR_V(x) ((x) << DREQRDCERR_S)
+#define DREQRDCERR_F    DREQRDCERR_V(1U)
+
+#define DREQWRCERR_S    13
+#define DREQWRCERR_V(x) ((x) << DREQWRCERR_S)
+#define DREQWRCERR_F    DREQWRCERR_V(1U)
+
+#define CRSPCERR_S    12
+#define CRSPCERR_V(x) ((x) << CRSPCERR_S)
+#define CRSPCERR_F    CRSPCERR_V(1U)
+
+#define ARSPPERR_S    11
+#define ARSPPERR_V(x) ((x) << ARSPPERR_S)
+#define ARSPPERR_F    ARSPPERR_V(1U)
+
+#define AREQRDPERR_S    10
+#define AREQRDPERR_V(x) ((x) << AREQRDPERR_S)
+#define AREQRDPERR_F    AREQRDPERR_V(1U)
+
+#define AREQWRPERR_S    9
+#define AREQWRPERR_V(x) ((x) << AREQWRPERR_S)
+#define AREQWRPERR_F    AREQWRPERR_V(1U)
+
+#define PIOREQGRPCERR_S    8
+#define PIOREQGRPCERR_V(x) ((x) << PIOREQGRPCERR_S)
+#define PIOREQGRPCERR_F    PIOREQGRPCERR_V(1U)
+
+#define ARSPCERR_S    7
+#define ARSPCERR_V(x) ((x) << ARSPCERR_S)
+#define ARSPCERR_F    ARSPCERR_V(1U)
+
+#define AREQRDCERR_S    6
+#define AREQRDCERR_V(x) ((x) << AREQRDCERR_S)
+#define AREQRDCERR_F    AREQRDCERR_V(1U)
+
+#define AREQWRCERR_S    5
+#define AREQWRCERR_V(x) ((x) << AREQWRCERR_S)
+#define AREQWRCERR_F    AREQWRCERR_V(1U)
+
+#define MARSPPERR_S    4
+#define MARSPPERR_V(x) ((x) << MARSPPERR_S)
+#define MARSPPERR_F    MARSPPERR_V(1U)
+
+#define INICMAWDATAORDPERR_S    3
+#define INICMAWDATAORDPERR_V(x) ((x) << INICMAWDATAORDPERR_S)
+#define INICMAWDATAORDPERR_F    INICMAWDATAORDPERR_V(1U)
+
+#define EMUPERR_S    2
+#define EMUPERR_V(x) ((x) << EMUPERR_S)
+#define EMUPERR_F    EMUPERR_V(1U)
+
+#define ERRSPPERR_S    1
+#define ERRSPPERR_V(x) ((x) << ERRSPPERR_S)
+#define ERRSPPERR_F    ERRSPPERR_V(1U)
+
+#define MSTGRPCERR_S    0
+#define MSTGRPCERR_V(x) ((x) << MSTGRPCERR_S)
+#define MSTGRPCERR_F    MSTGRPCERR_V(1U)
+
+#define PCIE_INT_CAUSE_X8_A 0x303c
+
+#define X8TGTGRPPERR_S    23
+#define X8TGTGRPPERR_V(x) ((x) << X8TGTGRPPERR_S)
+#define X8TGTGRPPERR_F    X8TGTGRPPERR_V(1U)
+
+#define X8IPSOTPERR_S    22
+#define X8IPSOTPERR_V(x) ((x) << X8IPSOTPERR_S)
+#define X8IPSOTPERR_F    X8IPSOTPERR_V(1U)
+
+#define X8IPRETRYPERR_S    21
+#define X8IPRETRYPERR_V(x) ((x) << X8IPRETRYPERR_S)
+#define X8IPRETRYPERR_F    X8IPRETRYPERR_V(1U)
+
+#define X8IPRXDATAGRPPERR_S    20
+#define X8IPRXDATAGRPPERR_V(x) ((x) << X8IPRXDATAGRPPERR_S)
+#define X8IPRXDATAGRPPERR_F    X8IPRXDATAGRPPERR_V(1U)
+
+#define X8IPRXHDRGRPPERR_S    19
+#define X8IPRXHDRGRPPERR_V(x) ((x) << X8IPRXHDRGRPPERR_S)
+#define X8IPRXHDRGRPPERR_F    X8IPRXHDRGRPPERR_V(1U)
+
+#define X8IPCORECERR_S    3
+#define X8IPCORECERR_V(x) ((x) << X8IPCORECERR_S)
+#define X8IPCORECERR_F    X8IPCORECERR_V(1U)
+
+#define X8MSTGRPPERR_S    2
+#define X8MSTGRPPERR_V(x) ((x) << X8MSTGRPPERR_S)
+#define X8MSTGRPPERR_F    X8MSTGRPPERR_V(1U)
+
+#define X8MSTGRPCERR_S    1
+#define X8MSTGRPCERR_V(x) ((x) << X8MSTGRPCERR_S)
+#define X8MSTGRPCERR_F    X8MSTGRPCERR_V(1U)
+
 #define PCIE_CFG_SPACE_REQ_A	0x3060
+
 #define PCIE_CFG_SPACE_DATA_A	0x3064
 #define PCIE_MEM_ACCESS_BASE_WIN_A 0x3068
 
@@ -769,9 +1591,7 @@
 #define PCIEOFST_G(x) (((x) >> PCIEOFST_S) & PCIEOFST_M)
 
 #define BIR_S    8
-#define BIR_M    0x3U
 #define BIR_V(x) ((x) << BIR_S)
-#define BIR_G(x) (((x) >> BIR_S) & BIR_M)
 
 #define WINDOW_S    0
 #define WINDOW_M    0xffU
@@ -826,11 +1646,9 @@
 #define RFTP_V(x) ((x) << RFTP_S)
 #define RFTP_F    RFTP_V(1U)
 
-#define PTRP_S    20
-#define PTRP_V(x) ((x) << PTRP_S)
-#define PTRP_F    PTRP_V(1U)
-
+#define PCIE_CORE_UTL_SYSTEM_BUS_AGENT_INTERRUPT_ENABLE_A 0x5910
 #define PCIE_CORE_UTL_PCI_EXPRESS_PORT_STATUS_A 0x59a4
+#define PCIE_CORE_UTL_PCI_EXPRESS_PORT_INTERRUPT_ENABLE_A 0x59ac
 
 #define TPCP_S    30
 #define TPCP_V(x) ((x) << TPCP_S)
@@ -856,34 +1674,21 @@
 #define RCAP_V(x) ((x) << RCAP_S)
 #define RCAP_F    RCAP_V(1U)
 
-#define PLUP_S    23
-#define PLUP_V(x) ((x) << PLUP_S)
-#define PLUP_F    PLUP_V(1U)
-
-#define PLDN_S    22
-#define PLDN_V(x) ((x) << PLDN_S)
-#define PLDN_F    PLDN_V(1U)
-
 #define OTDD_S    21
 #define OTDD_V(x) ((x) << OTDD_S)
 #define OTDD_F    OTDD_V(1U)
 
-#define GTRP_S    20
-#define GTRP_V(x) ((x) << GTRP_S)
-#define GTRP_F    GTRP_V(1U)
-
 #define RDPE_S    18
 #define RDPE_V(x) ((x) << RDPE_S)
 #define RDPE_F    RDPE_V(1U)
 
-#define TDCE_S    17
-#define TDCE_V(x) ((x) << TDCE_S)
-#define TDCE_F    TDCE_V(1U)
-
 #define TDUE_S    16
 #define TDUE_V(x) ((x) << TDUE_S)
 #define TDUE_F    TDUE_V(1U)
 
+#define PCIE_MEM_ACCESS_OFFSET0_A 0x3708
+#define T7_PCIE_MEM_ACCESS_BASE_WIN_A 0x3700
+
 /* SPARE2 register contains 32-bit value at offset 0x6 in Serial INIT
  * Configuration flashed on EEPROM. This value corresponds to 32-bit
  * Serial Configuration Version information.
@@ -891,11 +1696,33 @@
 #define PCIE_STATIC_SPARE2_A	0x5bfc
 
 /* registers for module MC */
-#define MC_INT_CAUSE_A		0x7518
-#define MC_P_INT_CAUSE_A	0x41318
+#define MC_PAR_ENABLE_A 0x750c
+#define MC_PAR_CAUSE_A 0x7510
 
-#define ECC_UE_INT_CAUSE_S    2
-#define ECC_UE_INT_CAUSE_V(x) ((x) << ECC_UE_INT_CAUSE_S)
+#define ECC_UE_PAR_CAUSE_S    3
+#define ECC_UE_PAR_CAUSE_V(x) ((x) << ECC_UE_PAR_CAUSE_S)
+#define ECC_UE_PAR_CAUSE_F    ECC_UE_PAR_CAUSE_V(1U)
+
+#define ECC_CE_PAR_CAUSE_S    2
+#define ECC_CE_PAR_CAUSE_V(x) ((x) << ECC_CE_PAR_CAUSE_S)
+#define ECC_CE_PAR_CAUSE_F    ECC_CE_PAR_CAUSE_V(1U)
+
+#define FIFOR_PAR_CAUSE_S    1
+#define FIFOR_PAR_CAUSE_V(x) ((x) << FIFOR_PAR_CAUSE_S)
+#define FIFOR_PAR_CAUSE_F    FIFOR_PAR_CAUSE_V(1U)
+
+#define RDATA_FIFOR_PAR_CAUSE_S    0
+#define RDATA_FIFOR_PAR_CAUSE_V(x) ((x) << RDATA_FIFOR_PAR_CAUSE_S)
+#define RDATA_FIFOR_PAR_CAUSE_F    RDATA_FIFOR_PAR_CAUSE_V(1U)
+
+#define MC_INT_ENABLE_A 0x7514
+#define MC_INT_CAUSE_A		0x7518
+
+#define MC_P_INT_ENABLE_A 0x41314
+#define MC_P_INT_CAUSE_A	0x41318
+
+#define ECC_UE_INT_CAUSE_S    2
+#define ECC_UE_INT_CAUSE_V(x) ((x) << ECC_UE_INT_CAUSE_S)
 #define ECC_UE_INT_CAUSE_F    ECC_UE_INT_CAUSE_V(1U)
 
 #define ECC_CE_INT_CAUSE_S    1
@@ -912,7 +1739,6 @@
 
 #define SIGNAL_DET_S    14
 #define SIGNAL_DET_V(x) ((x) << SIGNAL_DET_S)
-#define SIGNAL_DET_F    SIGNAL_DET_V(1U)
 
 #define MC_ECC_STATUS_A		0x751c
 #define MC_P_ECC_STATUS_A	0x4131c
@@ -924,11 +1750,8 @@
 
 #define ECC_UECNT_S    0
 #define ECC_UECNT_M    0xffffU
-#define ECC_UECNT_V(x) ((x) << ECC_UECNT_S)
 #define ECC_UECNT_G(x) (((x) >> ECC_UECNT_S) & ECC_UECNT_M)
 
-#define MC_BIST_CMD_A 0x7600
-
 #define START_BIST_S    31
 #define START_BIST_V(x) ((x) << START_BIST_S)
 #define START_BIST_F    START_BIST_V(1U)
@@ -939,10 +1762,6 @@
 #define BIST_OPCODE_S    0
 #define BIST_OPCODE_V(x) ((x) << BIST_OPCODE_S)
 
-#define MC_BIST_CMD_ADDR_A 0x7604
-#define MC_BIST_CMD_LEN_A 0x7608
-#define MC_BIST_DATA_PATTERN_A 0x760c
-
 #define MC_BIST_STATUS_RDATA_A 0x7688
 
 /* registers for module MA */
@@ -954,9 +1773,12 @@
 
 #define EDRAM0_SIZE_S    0
 #define EDRAM0_SIZE_M    0xfffU
-#define EDRAM0_SIZE_V(x) ((x) << EDRAM0_SIZE_S)
 #define EDRAM0_SIZE_G(x) (((x) >> EDRAM0_SIZE_S) & EDRAM0_SIZE_M)
 
+#define T7_EDRAM0_SIZE_S    0
+#define T7_EDRAM0_SIZE_M    0xffffU
+#define T7_EDRAM0_SIZE_G(x) (((x) >> T7_EDRAM0_SIZE_S) & T7_EDRAM0_SIZE_M)
+
 #define MA_EDRAM1_BAR_A 0x77c4
 
 #define EDRAM1_BASE_S    16
@@ -965,19 +1787,20 @@
 
 #define EDRAM1_SIZE_S    0
 #define EDRAM1_SIZE_M    0xfffU
-#define EDRAM1_SIZE_V(x) ((x) << EDRAM1_SIZE_S)
 #define EDRAM1_SIZE_G(x) (((x) >> EDRAM1_SIZE_S) & EDRAM1_SIZE_M)
 
+#define T7_EDRAM1_SIZE_S    0
+#define T7_EDRAM1_SIZE_M    0xffffU
+#define T7_EDRAM1_SIZE_G(x) (((x) >> T7_EDRAM1_SIZE_S) & T7_EDRAM1_SIZE_M)
+
 #define MA_EXT_MEMORY_BAR_A 0x77c8
 
 #define EXT_MEM_BASE_S    16
 #define EXT_MEM_BASE_M    0xfffU
-#define EXT_MEM_BASE_V(x) ((x) << EXT_MEM_BASE_S)
 #define EXT_MEM_BASE_G(x) (((x) >> EXT_MEM_BASE_S) & EXT_MEM_BASE_M)
 
 #define EXT_MEM_SIZE_S    0
 #define EXT_MEM_SIZE_M    0xfffU
-#define EXT_MEM_SIZE_V(x) ((x) << EXT_MEM_SIZE_S)
 #define EXT_MEM_SIZE_G(x) (((x) >> EXT_MEM_SIZE_S) & EXT_MEM_SIZE_M)
 
 #define MA_EXT_MEMORY1_BAR_A 0x7808
@@ -992,20 +1815,40 @@
 
 #define EXT_MEM1_SIZE_S    0
 #define EXT_MEM1_SIZE_M    0xfffU
-#define EXT_MEM1_SIZE_V(x) ((x) << EXT_MEM1_SIZE_S)
 #define EXT_MEM1_SIZE_G(x) (((x) >> EXT_MEM1_SIZE_S) & EXT_MEM1_SIZE_M)
 
-#define MA_EXT_MEMORY0_BAR_A 0x77c8
+#define T7_EXT_MEM1_SIZE_S    0
+#define T7_EXT_MEM1_SIZE_M    0xffffU
+#define T7_EXT_MEM1_SIZE_G(x) (((x) >> T7_EXT_MEM1_SIZE_S) & T7_EXT_MEM1_SIZE_M)
+
+#define T7_EXT_MEM1_BASE_S    16
+#define T7_EXT_MEM1_BASE_M    0xffffU
+#define T7_EXT_MEM1_BASE_G(x) (((x) >> T7_EXT_MEM1_BASE_S) & T7_EXT_MEM1_BASE_M)
 
-#define EXT_MEM0_BASE_S    16
-#define EXT_MEM0_BASE_M    0xfffU
-#define EXT_MEM0_BASE_G(x) (((x) >> EXT_MEM0_BASE_S) & EXT_MEM0_BASE_M)
+#define MA_HOST_MEMORY_BAR_A 0x77cc
+
+#define HMATARGETBASE_S    16
+#define HMATARGETBASE_M    0xffffU
+#define HMATARGETBASE_G(x) (((x) >> HMATARGETBASE_S) & HMATARGETBASE_M)
+
+#define T7_HMA_SIZE_S    0
+#define T7_HMA_SIZE_M    0xffffU
+#define T7_HMA_SIZE_G(x) (((x) >> T7_HMA_SIZE_S) & T7_HMA_SIZE_M)
+
+#define MA_EXT_MEMORY0_BAR_A 0x77c8
 
 #define EXT_MEM0_SIZE_S    0
 #define EXT_MEM0_SIZE_M    0xfffU
-#define EXT_MEM0_SIZE_V(x) ((x) << EXT_MEM0_SIZE_S)
 #define EXT_MEM0_SIZE_G(x) (((x) >> EXT_MEM0_SIZE_S) & EXT_MEM0_SIZE_M)
 
+#define T7_EXT_MEM0_SIZE_S    0
+#define T7_EXT_MEM0_SIZE_M    0xffffU
+#define T7_EXT_MEM0_SIZE_G(x) (((x) >> T7_EXT_MEM0_SIZE_S) & T7_EXT_MEM0_SIZE_M)
+
+#define T7_EXT_MEM0_BASE_S    16
+#define T7_EXT_MEM0_BASE_M    0xffffU
+#define T7_EXT_MEM0_BASE_G(x) (((x) >> T7_EXT_MEM0_BASE_S) & T7_EXT_MEM0_BASE_M)
+
 #define MA_TARGET_MEM_ENABLE_A 0x77d8
 
 #define EXT_MEM_ENABLE_S    2
@@ -1028,6 +1871,11 @@
 #define EXT_MEM0_ENABLE_V(x) ((x) << EXT_MEM0_ENABLE_S)
 #define EXT_MEM0_ENABLE_F    EXT_MEM0_ENABLE_V(1U)
 
+#define MC_SPLIT_S    6
+#define MC_SPLIT_V(x) ((x) << MC_SPLIT_S)
+#define MC_SPLIT_F    MC_SPLIT_V(1U)
+
+#define MA_INT_ENABLE_A 0x77dc
 #define MA_INT_CAUSE_A	0x77e0
 
 #define MEM_PERR_INT_CAUSE_S    1
@@ -1038,6 +1886,10 @@
 #define MEM_WRAP_INT_CAUSE_V(x) ((x) << MEM_WRAP_INT_CAUSE_S)
 #define MEM_WRAP_INT_CAUSE_F    MEM_WRAP_INT_CAUSE_V(1U)
 
+#define MEM_TO_INT_CAUSE_S    2
+#define MEM_TO_INT_CAUSE_V(x) ((x) << MEM_TO_INT_CAUSE_S)
+#define MEM_TO_INT_CAUSE_F    MEM_TO_INT_CAUSE_V(1U)
+
 #define MA_INT_WRAP_STATUS_A	0x77e4
 
 #define MEM_WRAP_ADDRESS_S    4
@@ -1049,36 +1901,57 @@
 #define MEM_WRAP_CLIENT_NUM_G(x) \
 	(((x) >> MEM_WRAP_CLIENT_NUM_S) & MEM_WRAP_CLIENT_NUM_M)
 
+#define T7_TP_DMARBT_PAR_ERROR_S    1
+#define T7_TP_DMARBT_PAR_ERROR_V(x) ((x) << T7_TP_DMARBT_PAR_ERROR_S)
+#define T7_TP_DMARBT_PAR_ERROR_F    T7_TP_DMARBT_PAR_ERROR_V(1U)
+
+#define T7_LOGIC_FIFO_PAR_ERROR_S    0
+#define T7_LOGIC_FIFO_PAR_ERROR_V(x) ((x) << T7_LOGIC_FIFO_PAR_ERROR_S)
+#define T7_LOGIC_FIFO_PAR_ERROR_F    T7_LOGIC_FIFO_PAR_ERROR_V(1U)
+
 #define MA_PARITY_ERROR_STATUS_A	0x77f4
 #define MA_PARITY_ERROR_STATUS1_A	0x77f4
 #define MA_PARITY_ERROR_STATUS2_A	0x7804
+#define MA_PARITY_ERROR_STATUS3_A 0x7888
+#define MA_PARITY_ERROR_ENABLE1_A 0x77f0
+#define MA_PARITY_ERROR_ENABLE2_A 0x7800
+#define MA_PARITY_ERROR_ENABLE3_A 0x7884
 
-/* registers for module EDC_0 */
-#define EDC_0_BASE_ADDR		0x7900
+#define TP_DMARBT_PAR_ERROR_S    31
+#define TP_DMARBT_PAR_ERROR_V(x) ((x) << TP_DMARBT_PAR_ERROR_S)
+#define TP_DMARBT_PAR_ERROR_F    TP_DMARBT_PAR_ERROR_V(1U)
 
-#define EDC_BIST_CMD_A		0x7904
-#define EDC_BIST_CMD_ADDR_A	0x7908
-#define EDC_BIST_CMD_LEN_A	0x790c
-#define EDC_BIST_DATA_PATTERN_A 0x7910
-#define EDC_BIST_STATUS_RDATA_A	0x7928
-#define EDC_INT_CAUSE_A		0x7978
+#define LOGIC_FIFO_PAR_ERROR_S    30
+#define LOGIC_FIFO_PAR_ERROR_V(x) ((x) << LOGIC_FIFO_PAR_ERROR_S)
+#define LOGIC_FIFO_PAR_ERROR_F    LOGIC_FIFO_PAR_ERROR_V(1U)
+
+#define ARB4_PAR_WRQUEUE_ERROR_S    1
+#define ARB4_PAR_WRQUEUE_ERROR_V(x) ((x) << ARB4_PAR_WRQUEUE_ERROR_S)
+#define ARB4_PAR_WRQUEUE_ERROR_F    ARB4_PAR_WRQUEUE_ERROR_V(1U)
+
+#define ARB4_PAR_RDQUEUE_ERROR_S    0
+#define ARB4_PAR_RDQUEUE_ERROR_V(x) ((x) << ARB4_PAR_RDQUEUE_ERROR_S)
+#define ARB4_PAR_RDQUEUE_ERROR_F    ARB4_PAR_RDQUEUE_ERROR_V(1U)
+
+#define MA_LOCAL_DEBUG_CFG_A 0x78f8
+#define MA_LOCAL_DEBUG_PERF_CFG_A 0x7914
 
-#define ECC_UE_PAR_S    5
-#define ECC_UE_PAR_V(x) ((x) << ECC_UE_PAR_S)
-#define ECC_UE_PAR_F    ECC_UE_PAR_V(1U)
+#define MA_WRITE_TIMEOUT_ERROR_ENABLE_A 0x78d4
+#define MA_WRITE_TIMEOUT_ERROR_STATUS_A 0x78d8
+#define MA_READ_TIMEOUT_ERROR_ENABLE_A 0x78dc
+#define MA_READ_TIMEOUT_ERROR_STATUS_A 0x78e0
 
-#define ECC_CE_PAR_S    4
-#define ECC_CE_PAR_V(x) ((x) << ECC_CE_PAR_S)
-#define ECC_CE_PAR_F    ECC_CE_PAR_V(1U)
+/* registers for module EDC_0 */
+#define EDC_0_BASE_ADDR                0x7900
 
-#define PERR_PAR_CAUSE_S    3
-#define PERR_PAR_CAUSE_V(x) ((x) << PERR_PAR_CAUSE_S)
-#define PERR_PAR_CAUSE_F    PERR_PAR_CAUSE_V(1U)
+#define EDC_BIST_STATUS_RDATA_A	0x7928
+#define EDC_INT_ENABLE_A 0x7974
+#define EDC_INT_CAUSE_A		0x7978
 
 #define EDC_ECC_STATUS_A	0x797c
 
 /* registers for module EDC_1 */
-#define EDC_1_BASE_ADDR	0x7980
+#define EDC_1_BASE_ADDR        0x7980
 
 /* registers for module CIM */
 #define CIM_BOOT_CFG_A 0x7b00
@@ -1088,8 +1961,6 @@
 #define CIM_EXTMEM2_ADDR_SIZE_A 0x7b20
 #define CIM_PF_MAILBOX_CTRL_SHADOW_COPY_A 0x290
 
-#define  BOOTADDR_M	0xffffff00U
-
 #define UPCRST_S    0
 #define UPCRST_V(x) ((x) << UPCRST_S)
 #define UPCRST_F    UPCRST_V(1U)
@@ -1097,6 +1968,125 @@
 #define CIM_PF_MAILBOX_DATA_A 0x240
 #define CIM_PF_MAILBOX_CTRL_A 0x280
 
+#define CIM_PERR_ENABLE_A 0x7c24
+#define CIM_PERR_CAUSE_A 0x7b0c
+
+#define T7_MA_CIM_INTFPERR_S    31
+#define T7_MA_CIM_INTFPERR_V(x) ((x) << T7_MA_CIM_INTFPERR_S)
+#define T7_MA_CIM_INTFPERR_F    T7_MA_CIM_INTFPERR_V(1U)
+
+#define T7_MBHOSTPARERR_S    30
+#define T7_MBHOSTPARERR_V(x) ((x) << T7_MBHOSTPARERR_S)
+#define T7_MBHOSTPARERR_F    T7_MBHOSTPARERR_V(1U)
+
+#define MAARBINVRSPTAG_S    29
+#define MAARBINVRSPTAG_V(x) ((x) << MAARBINVRSPTAG_S)
+#define MAARBINVRSPTAG_F    MAARBINVRSPTAG_V(1U)
+
+#define MAARBFIFOPARERR_S    28
+#define MAARBFIFOPARERR_V(x) ((x) << MAARBFIFOPARERR_S)
+#define MAARBFIFOPARERR_F    MAARBFIFOPARERR_V(1U)
+
+#define SEMSRAMPARERR_S    27
+#define SEMSRAMPARERR_V(x) ((x) << SEMSRAMPARERR_S)
+#define SEMSRAMPARERR_F    SEMSRAMPARERR_V(1U)
+
+#define RSACPARERR_S    26
+#define RSACPARERR_V(x) ((x) << RSACPARERR_S)
+#define RSACPARERR_F    RSACPARERR_V(1U)
+
+#define RSADPARERR_S    25
+#define RSADPARERR_V(x) ((x) << RSADPARERR_S)
+#define RSADPARERR_F    RSADPARERR_V(1U)
+
+#define T7_PLCIM_MSTRSPDATAPARERR_S    24
+#define T7_PLCIM_MSTRSPDATAPARERR_V(x) ((x) << T7_PLCIM_MSTRSPDATAPARERR_S)
+#define T7_PLCIM_MSTRSPDATAPARERR_F    T7_PLCIM_MSTRSPDATAPARERR_V(1U)
+
+#define T7_PCIE2CIMINTFPARERR_S    23
+#define T7_PCIE2CIMINTFPARERR_V(x) ((x) << T7_PCIE2CIMINTFPARERR_S)
+#define T7_PCIE2CIMINTFPARERR_F    T7_PCIE2CIMINTFPARERR_V(1U)
+
+#define T7_NCSI2CIMINTFPARERR_S    22
+#define T7_NCSI2CIMINTFPARERR_V(x) ((x) << T7_NCSI2CIMINTFPARERR_S)
+#define T7_NCSI2CIMINTFPARERR_F    T7_NCSI2CIMINTFPARERR_V(1U)
+
+#define T7_SGE2CIMINTFPARERR_S    21
+#define T7_SGE2CIMINTFPARERR_V(x) ((x) << T7_SGE2CIMINTFPARERR_S)
+#define T7_SGE2CIMINTFPARERR_F    T7_SGE2CIMINTFPARERR_V(1U)
+
+#define T7_ULP2CIMINTFPARERR_S    20
+#define T7_ULP2CIMINTFPARERR_V(x) ((x) << T7_ULP2CIMINTFPARERR_S)
+#define T7_ULP2CIMINTFPARERR_F    T7_ULP2CIMINTFPARERR_V(1U)
+
+#define T7_TP2CIMINTFPARERR_S    19
+#define T7_TP2CIMINTFPARERR_V(x) ((x) << T7_TP2CIMINTFPARERR_S)
+#define T7_TP2CIMINTFPARERR_F    T7_TP2CIMINTFPARERR_V(1U)
+
+#define CORE7PARERR_S    18
+#define CORE7PARERR_V(x) ((x) << CORE7PARERR_S)
+#define CORE7PARERR_F    CORE7PARERR_V(1U)
+
+#define CORE6PARERR_S    17
+#define CORE6PARERR_V(x) ((x) << CORE6PARERR_S)
+#define CORE6PARERR_F    CORE6PARERR_V(1U)
+
+#define CORE5PARERR_S    16
+#define CORE5PARERR_V(x) ((x) << CORE5PARERR_S)
+#define CORE5PARERR_F    CORE5PARERR_V(1U)
+
+#define CORE4PARERR_S    15
+#define CORE4PARERR_V(x) ((x) << CORE4PARERR_S)
+#define CORE4PARERR_F    CORE4PARERR_V(1U)
+
+#define CORE3PARERR_S    14
+#define CORE3PARERR_V(x) ((x) << CORE3PARERR_S)
+#define CORE3PARERR_F    CORE3PARERR_V(1U)
+
+#define CORE2PARERR_S    13
+#define CORE2PARERR_V(x) ((x) << CORE2PARERR_S)
+#define CORE2PARERR_F    CORE2PARERR_V(1U)
+
+#define CORE1PARERR_S    12
+#define CORE1PARERR_V(x) ((x) << CORE1PARERR_S)
+#define CORE1PARERR_F    CORE1PARERR_V(1U)
+
+#define GFTPARERR_S    10
+#define GFTPARERR_V(x) ((x) << GFTPARERR_S)
+#define GFTPARERR_F    GFTPARERR_V(1U)
+
+#define MPSRSPDATAPARERR_S    9
+#define MPSRSPDATAPARERR_V(x) ((x) << MPSRSPDATAPARERR_S)
+#define MPSRSPDATAPARERR_F    MPSRSPDATAPARERR_V(1U)
+
+#define ER_RSPDATAPARERR_S    8
+#define ER_RSPDATAPARERR_V(x) ((x) << ER_RSPDATAPARERR_S)
+#define ER_RSPDATAPARERR_F    ER_RSPDATAPARERR_V(1U)
+
+#define FLOWFIFOPARERR_S    7
+#define FLOWFIFOPARERR_V(x) ((x) << FLOWFIFOPARERR_S)
+#define FLOWFIFOPARERR_F    FLOWFIFOPARERR_V(1U)
+
+#define OBQSRAMPARERR_S    6
+#define OBQSRAMPARERR_V(x) ((x) << OBQSRAMPARERR_S)
+#define OBQSRAMPARERR_F    OBQSRAMPARERR_V(1U)
+
+#define TIEQOUTPARERR_S    3
+#define TIEQOUTPARERR_V(x) ((x) << TIEQOUTPARERR_S)
+#define TIEQOUTPARERR_F    TIEQOUTPARERR_V(1U)
+
+#define TIEQINPARERR_S    2
+#define TIEQINPARERR_V(x) ((x) << TIEQINPARERR_S)
+#define TIEQINPARERR_F    TIEQINPARERR_V(1U)
+
+#define PIFRSPPARERR_S    1
+#define PIFRSPPARERR_V(x) ((x) << PIFRSPPARERR_S)
+#define PIFRSPPARERR_F    PIFRSPPARERR_V(1U)
+
+#define PIFREQPARERR_S    0
+#define PIFREQPARERR_V(x) ((x) << PIFREQPARERR_S)
+#define PIFREQPARERR_F    PIFREQPARERR_V(1U)
+
 #define MBMSGVALID_S    3
 #define MBMSGVALID_V(x) ((x) << MBMSGVALID_S)
 #define MBMSGVALID_F    MBMSGVALID_V(1U)
@@ -1122,6 +2112,7 @@
 #define MBMSGRDYINT_V(x) ((x) << MBMSGRDYINT_S)
 #define MBMSGRDYINT_F    MBMSGRDYINT_V(1U)
 
+#define CIM_HOST_INT_ENABLE_A 0x7b28
 #define CIM_HOST_INT_CAUSE_A 0x7b2c
 
 #define TIEQOUTPARERRINT_S    20
@@ -1132,18 +2123,6 @@
 #define TIEQINPARERRINT_V(x) ((x) << TIEQINPARERRINT_S)
 #define TIEQINPARERRINT_F    TIEQINPARERRINT_V(1U)
 
-#define TIMER0INT_S    2
-#define TIMER0INT_V(x) ((x) << TIMER0INT_S)
-#define TIMER0INT_F    TIMER0INT_V(1U)
-
-#define PREFDROPINT_S    1
-#define PREFDROPINT_V(x) ((x) << PREFDROPINT_S)
-#define PREFDROPINT_F    PREFDROPINT_V(1U)
-
-#define UPACCNONZERO_S    0
-#define UPACCNONZERO_V(x) ((x) << UPACCNONZERO_S)
-#define UPACCNONZERO_F    UPACCNONZERO_V(1U)
-
 #define MBHOSTPARERR_S    18
 #define MBHOSTPARERR_V(x) ((x) << MBHOSTPARERR_S)
 #define MBHOSTPARERR_F    MBHOSTPARERR_V(1U)
@@ -1200,6 +2179,87 @@
 #define OBQNCSIPARERR_V(x) ((x) << OBQNCSIPARERR_S)
 #define OBQNCSIPARERR_F    OBQNCSIPARERR_V(1U)
 
+#define TIMER1INT_S    3
+#define TIMER1INT_V(x) ((x) << TIMER1INT_S)
+#define TIMER1INT_F    TIMER1INT_V(1U)
+
+#define TIMER0INT_S    2
+#define TIMER0INT_V(x) ((x) << TIMER0INT_S)
+#define TIMER0INT_F    TIMER0INT_V(1U)
+
+#define PREFDROPINT_S    1
+#define PREFDROPINT_V(x) ((x) << PREFDROPINT_S)
+#define PREFDROPINT_F    PREFDROPINT_V(1U)
+
+#define MA_CIM_INTFPERR_S    28
+#define MA_CIM_INTFPERR_V(x) ((x) << MA_CIM_INTFPERR_S)
+#define MA_CIM_INTFPERR_F    MA_CIM_INTFPERR_V(1U)
+
+#define PLCIM_MSTRSPDATAPARERR_S    27
+#define PLCIM_MSTRSPDATAPARERR_V(x) ((x) << PLCIM_MSTRSPDATAPARERR_S)
+#define PLCIM_MSTRSPDATAPARERR_F    PLCIM_MSTRSPDATAPARERR_V(1U)
+
+#define NCSI2CIMINTFPARERR_S    26
+#define NCSI2CIMINTFPARERR_V(x) ((x) << NCSI2CIMINTFPARERR_S)
+#define NCSI2CIMINTFPARERR_F    NCSI2CIMINTFPARERR_V(1U)
+
+#define SGE2CIMINTFPARERR_S    25
+#define SGE2CIMINTFPARERR_V(x) ((x) << SGE2CIMINTFPARERR_S)
+#define SGE2CIMINTFPARERR_F    SGE2CIMINTFPARERR_V(1U)
+
+#define ULP2CIMINTFPARERR_S    24
+#define ULP2CIMINTFPARERR_V(x) ((x) << ULP2CIMINTFPARERR_S)
+#define ULP2CIMINTFPARERR_F    ULP2CIMINTFPARERR_V(1U)
+
+#define TP2CIMINTFPARERR_S    23
+#define TP2CIMINTFPARERR_V(x) ((x) << TP2CIMINTFPARERR_S)
+#define TP2CIMINTFPARERR_F    TP2CIMINTFPARERR_V(1U)
+
+#define OBQSGERX1PARERR_S    22
+#define OBQSGERX1PARERR_V(x) ((x) << OBQSGERX1PARERR_S)
+#define OBQSGERX1PARERR_F    OBQSGERX1PARERR_V(1U)
+
+#define OBQSGERX0PARERR_S    21
+#define OBQSGERX0PARERR_V(x) ((x) << OBQSGERX0PARERR_S)
+#define OBQSGERX0PARERR_F    OBQSGERX0PARERR_V(1U)
+
+#define PCIE2CIMINTFPARERR_S    29
+#define PCIE2CIMINTFPARERR_V(x) ((x) << PCIE2CIMINTFPARERR_S)
+#define PCIE2CIMINTFPARERR_F    PCIE2CIMINTFPARERR_V(1U)
+
+#define IBQPCIEPARERR_S    12
+#define IBQPCIEPARERR_V(x) ((x) << IBQPCIEPARERR_S)
+#define IBQPCIEPARERR_F    IBQPCIEPARERR_V(1U)
+
+#define CORE7ACCINT_S    22
+#define CORE7ACCINT_V(x) ((x) << CORE7ACCINT_S)
+#define CORE7ACCINT_F    CORE7ACCINT_V(1U)
+
+#define CORE6ACCINT_S    21
+#define CORE6ACCINT_V(x) ((x) << CORE6ACCINT_S)
+#define CORE6ACCINT_F    CORE6ACCINT_V(1U)
+
+#define CORE5ACCINT_S    20
+#define CORE5ACCINT_V(x) ((x) << CORE5ACCINT_S)
+#define CORE5ACCINT_F    CORE5ACCINT_V(1U)
+
+#define CORE4ACCINT_S    19
+#define CORE4ACCINT_V(x) ((x) << CORE4ACCINT_S)
+#define CORE4ACCINT_F    CORE4ACCINT_V(1U)
+
+#define CORE3ACCINT_S    18
+#define CORE3ACCINT_V(x) ((x) << CORE3ACCINT_S)
+#define CORE3ACCINT_F    CORE3ACCINT_V(1U)
+
+#define CORE2ACCINT_S    17
+#define CORE2ACCINT_V(x) ((x) << CORE2ACCINT_S)
+#define CORE2ACCINT_F    CORE2ACCINT_V(1U)
+
+#define CORE1ACCINT_S    16
+#define CORE1ACCINT_V(x) ((x) << CORE1ACCINT_S)
+#define CORE1ACCINT_F    CORE1ACCINT_V(1U)
+
+#define CIM_HOST_UPACC_INT_ENABLE_A 0x7b30
 #define CIM_HOST_UPACC_INT_CAUSE_A 0x7b34
 
 #define EEPROMWRINT_S    30
@@ -1326,6 +2386,10 @@
 #define RSVDSPACEINT_V(x) ((x) << RSVDSPACEINT_S)
 #define RSVDSPACEINT_F    RSVDSPACEINT_V(1U)
 
+#define CONWRERRINT_S    31
+#define CONWRERRINT_V(x) ((x) << CONWRERRINT_S)
+#define CONWRERRINT_F    CONWRERRINT_V(1U)
+
 /* registers for module TP */
 #define DBGLAWHLF_S    23
 #define DBGLAWHLF_V(x) ((x) << DBGLAWHLF_S)
@@ -1352,6 +2416,532 @@
 #define TP_OUT_CONFIG_A		0x7d04
 #define TP_GLOBAL_CONFIG_A	0x7d08
 
+#define TP_C_PERR_ENABLE_A 0x7f30
+#define TP_C_PERR_CAUSE_A 0x7f34
+
+#define DMXFIFOOVFL_S    26
+#define DMXFIFOOVFL_V(x) ((x) << DMXFIFOOVFL_S)
+#define DMXFIFOOVFL_F    DMXFIFOOVFL_V(1U)
+
+#define URX2TPCDDPINTF_S    25
+#define URX2TPCDDPINTF_V(x) ((x) << URX2TPCDDPINTF_S)
+#define URX2TPCDDPINTF_F    URX2TPCDDPINTF_V(1U)
+
+#define TPCDISPTOKENFIFO_S    24
+#define TPCDISPTOKENFIFO_V(x) ((x) << TPCDISPTOKENFIFO_S)
+#define TPCDISPTOKENFIFO_F    TPCDISPTOKENFIFO_V(1U)
+
+#define TPCDISPCPLFIFO3_S    23
+#define TPCDISPCPLFIFO3_V(x) ((x) << TPCDISPCPLFIFO3_S)
+#define TPCDISPCPLFIFO3_F    TPCDISPCPLFIFO3_V(1U)
+
+#define TPCDISPCPLFIFO2_S    22
+#define TPCDISPCPLFIFO2_V(x) ((x) << TPCDISPCPLFIFO2_S)
+#define TPCDISPCPLFIFO2_F    TPCDISPCPLFIFO2_V(1U)
+
+#define TPCDISPCPLFIFO1_S    21
+#define TPCDISPCPLFIFO1_V(x) ((x) << TPCDISPCPLFIFO1_S)
+#define TPCDISPCPLFIFO1_F    TPCDISPCPLFIFO1_V(1U)
+
+#define TPCDISPCPLFIFO0_S    20
+#define TPCDISPCPLFIFO0_V(x) ((x) << TPCDISPCPLFIFO0_S)
+#define TPCDISPCPLFIFO0_F    TPCDISPCPLFIFO0_V(1U)
+
+#define URXPLDINTFCRC3_S    19
+#define URXPLDINTFCRC3_V(x) ((x) << URXPLDINTFCRC3_S)
+#define URXPLDINTFCRC3_F    URXPLDINTFCRC3_V(1U)
+
+#define URXPLDINTFCRC2_S    18
+#define URXPLDINTFCRC2_V(x) ((x) << URXPLDINTFCRC2_S)
+#define URXPLDINTFCRC2_F    URXPLDINTFCRC2_V(1U)
+
+#define URXPLDINTFCRC1_S    17
+#define URXPLDINTFCRC1_V(x) ((x) << URXPLDINTFCRC1_S)
+#define URXPLDINTFCRC1_F    URXPLDINTFCRC1_V(1U)
+
+#define URXPLDINTFCRC0_S    16
+#define URXPLDINTFCRC0_V(x) ((x) << URXPLDINTFCRC0_S)
+#define URXPLDINTFCRC0_F    URXPLDINTFCRC0_V(1U)
+
+#define DMXDBFIFO_S    15
+#define DMXDBFIFO_V(x) ((x) << DMXDBFIFO_S)
+#define DMXDBFIFO_F    DMXDBFIFO_V(1U)
+
+#define DMXDBSRAM_S    14
+#define DMXDBSRAM_V(x) ((x) << DMXDBSRAM_S)
+#define DMXDBSRAM_F    DMXDBSRAM_V(1U)
+
+#define DMXCPLFIFO_S    13
+#define DMXCPLFIFO_V(x) ((x) << DMXCPLFIFO_S)
+#define DMXCPLFIFO_F    DMXCPLFIFO_V(1U)
+
+#define DMXCPLSRAM_S    12
+#define DMXCPLSRAM_V(x) ((x) << DMXCPLSRAM_S)
+#define DMXCPLSRAM_F    DMXCPLSRAM_V(1U)
+
+#define DMXCSUMFIFO_S    11
+#define DMXCSUMFIFO_V(x) ((x) << DMXCSUMFIFO_S)
+#define DMXCSUMFIFO_F    DMXCSUMFIFO_V(1U)
+
+#define DMXLENFIFO_S    10
+#define DMXLENFIFO_V(x) ((x) << DMXLENFIFO_S)
+#define DMXLENFIFO_F    DMXLENFIFO_V(1U)
+
+#define DMXCHECKFIFO_S    9
+#define DMXCHECKFIFO_V(x) ((x) << DMXCHECKFIFO_S)
+#define DMXCHECKFIFO_F    DMXCHECKFIFO_V(1U)
+
+#define DMXWINFIFO_S    8
+#define DMXWINFIFO_V(x) ((x) << DMXWINFIFO_S)
+#define DMXWINFIFO_F    DMXWINFIFO_V(1U)
+
+#define EGTOKENFIFO_S    7
+#define EGTOKENFIFO_V(x) ((x) << EGTOKENFIFO_S)
+#define EGTOKENFIFO_F    EGTOKENFIFO_V(1U)
+
+#define EGDATAFIFO_S    6
+#define EGDATAFIFO_V(x) ((x) << EGDATAFIFO_S)
+#define EGDATAFIFO_F    EGDATAFIFO_V(1U)
+
+#define UTX2TPCINTF3_S    5
+#define UTX2TPCINTF3_V(x) ((x) << UTX2TPCINTF3_S)
+#define UTX2TPCINTF3_F    UTX2TPCINTF3_V(1U)
+
+#define UTX2TPCINTF2_S    4
+#define UTX2TPCINTF2_V(x) ((x) << UTX2TPCINTF2_S)
+#define UTX2TPCINTF2_F    UTX2TPCINTF2_V(1U)
+
+#define UTX2TPCINTF1_S    3
+#define UTX2TPCINTF1_V(x) ((x) << UTX2TPCINTF1_S)
+#define UTX2TPCINTF1_F    UTX2TPCINTF1_V(1U)
+
+#define UTX2TPCINTF0_S    2
+#define UTX2TPCINTF0_V(x) ((x) << UTX2TPCINTF0_S)
+#define UTX2TPCINTF0_F    UTX2TPCINTF0_V(1U)
+
+#define LBKTOKENFIFO_S    1
+#define LBKTOKENFIFO_V(x) ((x) << LBKTOKENFIFO_S)
+#define LBKTOKENFIFO_F    LBKTOKENFIFO_V(1U)
+
+#define LBKDATAFIFO_S    0
+#define LBKDATAFIFO_V(x) ((x) << LBKDATAFIFO_S)
+#define LBKDATAFIFO_F    LBKDATAFIFO_V(1U)
+
+#define TP_E_EG_PERR_ENABLE_A 0x7f38
+#define TP_E_EG_PERR_CAUSE_A 0x7f3c
+
+#define MPSLPBKTOKENFIFO_S    25
+#define MPSLPBKTOKENFIFO_V(x) ((x) << MPSLPBKTOKENFIFO_S)
+#define MPSLPBKTOKENFIFO_F    MPSLPBKTOKENFIFO_V(1U)
+
+#define MPSMACTOKENFIFO_S    24
+#define MPSMACTOKENFIFO_V(x) ((x) << MPSMACTOKENFIFO_S)
+#define MPSMACTOKENFIFO_F    MPSMACTOKENFIFO_V(1U)
+
+#define DISPIPSECFIFO3_S    23
+#define DISPIPSECFIFO3_V(x) ((x) << DISPIPSECFIFO3_S)
+#define DISPIPSECFIFO3_F    DISPIPSECFIFO3_V(1U)
+
+#define DISPTCPFIFO3_S    22
+#define DISPTCPFIFO3_V(x) ((x) << DISPTCPFIFO3_S)
+#define DISPTCPFIFO3_F    DISPTCPFIFO3_V(1U)
+
+#define DISPIPFIFO3_S    21
+#define DISPIPFIFO3_V(x) ((x) << DISPIPFIFO3_S)
+#define DISPIPFIFO3_F    DISPIPFIFO3_V(1U)
+
+#define DISPETHFIFO3_S    20
+#define DISPETHFIFO3_V(x) ((x) << DISPETHFIFO3_S)
+#define DISPETHFIFO3_F    DISPETHFIFO3_V(1U)
+
+#define DISPGREFIFO3_S    19
+#define DISPGREFIFO3_V(x) ((x) << DISPGREFIFO3_S)
+#define DISPGREFIFO3_F    DISPGREFIFO3_V(1U)
+
+#define DISPCPL5FIFO3_S    18
+#define DISPCPL5FIFO3_V(x) ((x) << DISPCPL5FIFO3_S)
+#define DISPCPL5FIFO3_F    DISPCPL5FIFO3_V(1U)
+
+#define DISPIPSECFIFO2_S    17
+#define DISPIPSECFIFO2_V(x) ((x) << DISPIPSECFIFO2_S)
+#define DISPIPSECFIFO2_F    DISPIPSECFIFO2_V(1U)
+
+#define DISPTCPFIFO2_S    16
+#define DISPTCPFIFO2_V(x) ((x) << DISPTCPFIFO2_S)
+#define DISPTCPFIFO2_F    DISPTCPFIFO2_V(1U)
+
+#define DISPIPFIFO2_S    15
+#define DISPIPFIFO2_V(x) ((x) << DISPIPFIFO2_S)
+#define DISPIPFIFO2_F    DISPIPFIFO2_V(1U)
+
+#define DISPETHFIFO2_S    14
+#define DISPETHFIFO2_V(x) ((x) << DISPETHFIFO2_S)
+#define DISPETHFIFO2_F    DISPETHFIFO2_V(1U)
+
+#define DISPGREFIFO2_S    13
+#define DISPGREFIFO2_V(x) ((x) << DISPGREFIFO2_S)
+#define DISPGREFIFO2_F    DISPGREFIFO2_V(1U)
+
+#define DISPCPL5FIFO2_S    12
+#define DISPCPL5FIFO2_V(x) ((x) << DISPCPL5FIFO2_S)
+#define DISPCPL5FIFO2_F    DISPCPL5FIFO2_V(1U)
+
+#define DISPIPSECFIFO1_S    11
+#define DISPIPSECFIFO1_V(x) ((x) << DISPIPSECFIFO1_S)
+#define DISPIPSECFIFO1_F    DISPIPSECFIFO1_V(1U)
+
+#define DISPTCPFIFO1_S    10
+#define DISPTCPFIFO1_V(x) ((x) << DISPTCPFIFO1_S)
+#define DISPTCPFIFO1_F    DISPTCPFIFO1_V(1U)
+
+#define DISPIPFIFO1_S    9
+#define DISPIPFIFO1_V(x) ((x) << DISPIPFIFO1_S)
+#define DISPIPFIFO1_F    DISPIPFIFO1_V(1U)
+
+#define DISPETHFIFO1_S    8
+#define DISPETHFIFO1_V(x) ((x) << DISPETHFIFO1_S)
+#define DISPETHFIFO1_F    DISPETHFIFO1_V(1U)
+
+#define DISPGREFIFO1_S    7
+#define DISPGREFIFO1_V(x) ((x) << DISPGREFIFO1_S)
+#define DISPGREFIFO1_F    DISPGREFIFO1_V(1U)
+
+#define DISPCPL5FIFO1_S    6
+#define DISPCPL5FIFO1_V(x) ((x) << DISPCPL5FIFO1_S)
+#define DISPCPL5FIFO1_F    DISPCPL5FIFO1_V(1U)
+
+#define DISPIPSECFIFO0_S    5
+#define DISPIPSECFIFO0_V(x) ((x) << DISPIPSECFIFO0_S)
+#define DISPIPSECFIFO0_F    DISPIPSECFIFO0_V(1U)
+
+#define DISPTCPFIFO0_S    4
+#define DISPTCPFIFO0_V(x) ((x) << DISPTCPFIFO0_S)
+#define DISPTCPFIFO0_F    DISPTCPFIFO0_V(1U)
+
+#define DISPIPFIFO0_S    3
+#define DISPIPFIFO0_V(x) ((x) << DISPIPFIFO0_S)
+#define DISPIPFIFO0_F    DISPIPFIFO0_V(1U)
+
+#define DISPETHFIFO0_S    2
+#define DISPETHFIFO0_V(x) ((x) << DISPETHFIFO0_S)
+#define DISPETHFIFO0_F    DISPETHFIFO0_V(1U)
+
+#define DISPGREFIFO0_S    1
+#define DISPGREFIFO0_V(x) ((x) << DISPGREFIFO0_S)
+#define DISPGREFIFO0_F    DISPGREFIFO0_V(1U)
+
+#define DISPCPL5FIFO0_S    0
+#define DISPCPL5FIFO0_V(x) ((x) << DISPCPL5FIFO0_S)
+#define DISPCPL5FIFO0_F    DISPCPL5FIFO0_V(1U)
+
+#define TP_E_IN0_PERR_ENABLE_A 0x7f40
+#define TP_E_IN0_PERR_CAUSE_A 0x7f44
+
+#define DMXISSFIFO_S    30
+#define DMXISSFIFO_V(x) ((x) << DMXISSFIFO_S)
+#define DMXISSFIFO_F    DMXISSFIFO_V(1U)
+
+#define DMXERRFIFO_S    29
+#define DMXERRFIFO_V(x) ((x) << DMXERRFIFO_S)
+#define DMXERRFIFO_F    DMXERRFIFO_V(1U)
+
+#define DMXATTFIFO_S    28
+#define DMXATTFIFO_V(x) ((x) << DMXATTFIFO_S)
+#define DMXATTFIFO_F    DMXATTFIFO_V(1U)
+
+#define DMXTCPFIFO_S    27
+#define DMXTCPFIFO_V(x) ((x) << DMXTCPFIFO_S)
+#define DMXTCPFIFO_F    DMXTCPFIFO_V(1U)
+
+#define DMXMPAFIFO_S    26
+#define DMXMPAFIFO_V(x) ((x) << DMXMPAFIFO_S)
+#define DMXMPAFIFO_F    DMXMPAFIFO_V(1U)
+
+#define DMXOPTFIFO_S    25
+#define DMXOPTFIFO_V(x) ((x) << DMXOPTFIFO_S)
+#define DMXOPTFIFO_F    DMXOPTFIFO_V(1U)
+
+#define INGTOKENFIFO_S    24
+#define INGTOKENFIFO_V(x) ((x) << INGTOKENFIFO_S)
+#define INGTOKENFIFO_F    INGTOKENFIFO_V(1U)
+
+#define DMXPLDCHKOVFL1_S    21
+#define DMXPLDCHKOVFL1_V(x) ((x) << DMXPLDCHKOVFL1_S)
+#define DMXPLDCHKOVFL1_F    DMXPLDCHKOVFL1_V(1U)
+
+#define DMXPLDCHKFIFO1_S    20
+#define DMXPLDCHKFIFO1_V(x) ((x) << DMXPLDCHKFIFO1_S)
+#define DMXPLDCHKFIFO1_F    DMXPLDCHKFIFO1_V(1U)
+
+#define DMXOPTFIFO1_S    19
+#define DMXOPTFIFO1_V(x) ((x) << DMXOPTFIFO1_S)
+#define DMXOPTFIFO1_F    DMXOPTFIFO1_V(1U)
+
+#define DMXMPAFIFO1_S    18
+#define DMXMPAFIFO1_V(x) ((x) << DMXMPAFIFO1_S)
+#define DMXMPAFIFO1_F    DMXMPAFIFO1_V(1U)
+
+#define DMXDBFIFO1_S    17
+#define DMXDBFIFO1_V(x) ((x) << DMXDBFIFO1_S)
+#define DMXDBFIFO1_F    DMXDBFIFO1_V(1U)
+
+#define DMXATTFIFO1_S    16
+#define DMXATTFIFO1_V(x) ((x) << DMXATTFIFO1_S)
+#define DMXATTFIFO1_F    DMXATTFIFO1_V(1U)
+
+#define DMXISSFIFO1_S    15
+#define DMXISSFIFO1_V(x) ((x) << DMXISSFIFO1_S)
+#define DMXISSFIFO1_F    DMXISSFIFO1_V(1U)
+
+#define DMXTCPFIFO1_S    14
+#define DMXTCPFIFO1_V(x) ((x) << DMXTCPFIFO1_S)
+#define DMXTCPFIFO1_F    DMXTCPFIFO1_V(1U)
+
+#define DMXERRFIFO1_S    13
+#define DMXERRFIFO1_V(x) ((x) << DMXERRFIFO1_S)
+#define DMXERRFIFO1_F    DMXERRFIFO1_V(1U)
+
+#define MPS2TPINTF1_S    12
+#define MPS2TPINTF1_V(x) ((x) << MPS2TPINTF1_S)
+#define MPS2TPINTF1_F    MPS2TPINTF1_V(1U)
+
+#define DMXPLDCHKOVFL0_S    9
+#define DMXPLDCHKOVFL0_V(x) ((x) << DMXPLDCHKOVFL0_S)
+#define DMXPLDCHKOVFL0_F    DMXPLDCHKOVFL0_V(1U)
+
+#define DMXPLDCHKFIFO0_S    8
+#define DMXPLDCHKFIFO0_V(x) ((x) << DMXPLDCHKFIFO0_S)
+#define DMXPLDCHKFIFO0_F    DMXPLDCHKFIFO0_V(1U)
+
+#define DMXOPTFIFO0_S    7
+#define DMXOPTFIFO0_V(x) ((x) << DMXOPTFIFO0_S)
+#define DMXOPTFIFO0_F    DMXOPTFIFO0_V(1U)
+
+#define DMXMPAFIFO0_S    6
+#define DMXMPAFIFO0_V(x) ((x) << DMXMPAFIFO0_S)
+#define DMXMPAFIFO0_F    DMXMPAFIFO0_V(1U)
+
+#define DMXDBFIFO0_S    5
+#define DMXDBFIFO0_V(x) ((x) << DMXDBFIFO0_S)
+#define DMXDBFIFO0_F    DMXDBFIFO0_V(1U)
+
+#define DMXATTFIFO0_S    4
+#define DMXATTFIFO0_V(x) ((x) << DMXATTFIFO0_S)
+#define DMXATTFIFO0_F    DMXATTFIFO0_V(1U)
+
+#define DMXISSFIFO0_S    3
+#define DMXISSFIFO0_V(x) ((x) << DMXISSFIFO0_S)
+#define DMXISSFIFO0_F    DMXISSFIFO0_V(1U)
+
+#define DMXTCPFIFO0_S    2
+#define DMXTCPFIFO0_V(x) ((x) << DMXTCPFIFO0_S)
+#define DMXTCPFIFO0_F    DMXTCPFIFO0_V(1U)
+
+#define DMXERRFIFO0_S    1
+#define DMXERRFIFO0_V(x) ((x) << DMXERRFIFO0_S)
+#define DMXERRFIFO0_F    DMXERRFIFO0_V(1U)
+
+#define MPS2TPINTF0_S    0
+#define MPS2TPINTF0_V(x) ((x) << MPS2TPINTF0_S)
+#define MPS2TPINTF0_F    MPS2TPINTF0_V(1U)
+
+#define TP_E_IN1_PERR_ENABLE_A 0x7f48
+#define TP_E_IN1_PERR_CAUSE_A 0x7f4c
+
+#define DMXPLDCHKOVFL3_S    21
+#define DMXPLDCHKOVFL3_V(x) ((x) << DMXPLDCHKOVFL3_S)
+#define DMXPLDCHKOVFL3_F    DMXPLDCHKOVFL3_V(1U)
+
+#define DMXPLDCHKFIFO3_S    20
+#define DMXPLDCHKFIFO3_V(x) ((x) << DMXPLDCHKFIFO3_S)
+#define DMXPLDCHKFIFO3_F    DMXPLDCHKFIFO3_V(1U)
+
+#define DMXOPTFIFO3_S    19
+#define DMXOPTFIFO3_V(x) ((x) << DMXOPTFIFO3_S)
+#define DMXOPTFIFO3_F    DMXOPTFIFO3_V(1U)
+
+#define DMXMPAFIFO3_S    18
+#define DMXMPAFIFO3_V(x) ((x) << DMXMPAFIFO3_S)
+#define DMXMPAFIFO3_F    DMXMPAFIFO3_V(1U)
+
+#define DMXDBFIFO3_S    17
+#define DMXDBFIFO3_V(x) ((x) << DMXDBFIFO3_S)
+#define DMXDBFIFO3_F    DMXDBFIFO3_V(1U)
+
+#define DMXATTFIFO3_S    16
+#define DMXATTFIFO3_V(x) ((x) << DMXATTFIFO3_S)
+#define DMXATTFIFO3_F    DMXATTFIFO3_V(1U)
+
+#define DMXISSFIFO3_S    15
+#define DMXISSFIFO3_V(x) ((x) << DMXISSFIFO3_S)
+#define DMXISSFIFO3_F    DMXISSFIFO3_V(1U)
+
+#define DMXTCPFIFO3_S    14
+#define DMXTCPFIFO3_V(x) ((x) << DMXTCPFIFO3_S)
+#define DMXTCPFIFO3_F    DMXTCPFIFO3_V(1U)
+
+#define DMXERRFIFO3_S    13
+#define DMXERRFIFO3_V(x) ((x) << DMXERRFIFO3_S)
+#define DMXERRFIFO3_F    DMXERRFIFO3_V(1U)
+
+#define MPS2TPINTF3_S    12
+#define MPS2TPINTF3_V(x) ((x) << MPS2TPINTF3_S)
+#define MPS2TPINTF3_F    MPS2TPINTF3_V(1U)
+
+#define DMXPLDCHKOVFL2_S    9
+#define DMXPLDCHKOVFL2_V(x) ((x) << DMXPLDCHKOVFL2_S)
+#define DMXPLDCHKOVFL2_F    DMXPLDCHKOVFL2_V(1U)
+
+#define DMXPLDCHKFIFO2_S    8
+#define DMXPLDCHKFIFO2_V(x) ((x) << DMXPLDCHKFIFO2_S)
+#define DMXPLDCHKFIFO2_F    DMXPLDCHKFIFO2_V(1U)
+
+#define DMXOPTFIFO2_S    7
+#define DMXOPTFIFO2_V(x) ((x) << DMXOPTFIFO2_S)
+#define DMXOPTFIFO2_F    DMXOPTFIFO2_V(1U)
+
+#define DMXMPAFIFO2_S    6
+#define DMXMPAFIFO2_V(x) ((x) << DMXMPAFIFO2_S)
+#define DMXMPAFIFO2_F    DMXMPAFIFO2_V(1U)
+
+#define DMXDBFIFO2_S    5
+#define DMXDBFIFO2_V(x) ((x) << DMXDBFIFO2_S)
+#define DMXDBFIFO2_F    DMXDBFIFO2_V(1U)
+
+#define DMXATTFIFO2_S    4
+#define DMXATTFIFO2_V(x) ((x) << DMXATTFIFO2_S)
+#define DMXATTFIFO2_F    DMXATTFIFO2_V(1U)
+
+#define DMXISSFIFO2_S    3
+#define DMXISSFIFO2_V(x) ((x) << DMXISSFIFO2_S)
+#define DMXISSFIFO2_F    DMXISSFIFO2_V(1U)
+
+#define DMXTCPFIFO2_S    2
+#define DMXTCPFIFO2_V(x) ((x) << DMXTCPFIFO2_S)
+#define DMXTCPFIFO2_F    DMXTCPFIFO2_V(1U)
+
+#define DMXERRFIFO2_S    1
+#define DMXERRFIFO2_V(x) ((x) << DMXERRFIFO2_S)
+#define DMXERRFIFO2_F    DMXERRFIFO2_V(1U)
+
+#define MPS2TPINTF2_S    0
+#define MPS2TPINTF2_V(x) ((x) << MPS2TPINTF2_S)
+#define MPS2TPINTF2_F    MPS2TPINTF2_V(1U)
+
+#define TP_O_PERR_ENABLE_A 0x7f50
+#define TP_O_PERR_CAUSE_A 0x7f54
+
+#define DMARBTPERR_S    31
+#define DMARBTPERR_V(x) ((x) << DMARBTPERR_S)
+#define DMARBTPERR_F    DMARBTPERR_V(1U)
+
+#define MMGRCACHEDATASRAM_S    24
+#define MMGRCACHEDATASRAM_V(x) ((x) << MMGRCACHEDATASRAM_S)
+#define MMGRCACHEDATASRAM_F    MMGRCACHEDATASRAM_V(1U)
+
+#define MMGRCACHETAGFIFO_S    23
+#define MMGRCACHETAGFIFO_V(x) ((x) << MMGRCACHETAGFIFO_S)
+#define MMGRCACHETAGFIFO_F    MMGRCACHETAGFIFO_V(1U)
+
+#define DBL2TLUTPERR_S    22
+#define DBL2TLUTPERR_V(x) ((x) << DBL2TLUTPERR_S)
+#define DBL2TLUTPERR_F    DBL2TLUTPERR_V(1U)
+
+#define DBTXTIDPERR_S    21
+#define DBTXTIDPERR_V(x) ((x) << DBTXTIDPERR_S)
+#define DBTXTIDPERR_F    DBTXTIDPERR_V(1U)
+
+#define DBEXTPERR_S    20
+#define DBEXTPERR_V(x) ((x) << DBEXTPERR_S)
+#define DBEXTPERR_F    DBEXTPERR_V(1U)
+
+#define DBOPPERR_S    19
+#define DBOPPERR_V(x) ((x) << DBOPPERR_S)
+#define DBOPPERR_F    DBOPPERR_V(1U)
+
+#define TMCACHEPERR_S    18
+#define TMCACHEPERR_V(x) ((x) << TMCACHEPERR_S)
+#define TMCACHEPERR_F    TMCACHEPERR_V(1U)
+
+#define TPPROTOSRAM_S    16
+#define TPPROTOSRAM_V(x) ((x) << TPPROTOSRAM_S)
+#define TPPROTOSRAM_F    TPPROTOSRAM_V(1U)
+
+#define HSPSRAM_S    15
+#define HSPSRAM_V(x) ((x) << HSPSRAM_S)
+#define HSPSRAM_F    HSPSRAM_V(1U)
+
+#define RATEGRPSRAM_S    14
+#define RATEGRPSRAM_V(x) ((x) << RATEGRPSRAM_S)
+#define RATEGRPSRAM_F    RATEGRPSRAM_V(1U)
+
+#define TXFBSEQFIFO_S    13
+#define TXFBSEQFIFO_V(x) ((x) << TXFBSEQFIFO_S)
+#define TXFBSEQFIFO_F    TXFBSEQFIFO_V(1U)
+
+#define CMDATASRAM_S    12
+#define CMDATASRAM_V(x) ((x) << CMDATASRAM_S)
+#define CMDATASRAM_F    CMDATASRAM_V(1U)
+
+#define CMTAGFIFO_S    11
+#define CMTAGFIFO_V(x) ((x) << CMTAGFIFO_S)
+#define CMTAGFIFO_F    CMTAGFIFO_V(1U)
+
+#define RFCOPFIFO_S    10
+#define RFCOPFIFO_V(x) ((x) << RFCOPFIFO_S)
+#define RFCOPFIFO_F    RFCOPFIFO_V(1U)
+
+#define DELINVFIFO_S    9
+#define DELINVFIFO_V(x) ((x) << DELINVFIFO_S)
+#define DELINVFIFO_F    DELINVFIFO_V(1U)
+
+#define RSSCFGSRAM_S    8
+#define RSSCFGSRAM_V(x) ((x) << RSSCFGSRAM_S)
+#define RSSCFGSRAM_F    RSSCFGSRAM_V(1U)
+
+#define RSSKEYSRAM_S    7
+#define RSSKEYSRAM_V(x) ((x) << RSSKEYSRAM_S)
+#define RSSKEYSRAM_F    RSSKEYSRAM_V(1U)
+
+#define RSSLKPSRAM_S    6
+#define RSSLKPSRAM_V(x) ((x) << RSSLKPSRAM_S)
+#define RSSLKPSRAM_F    RSSLKPSRAM_V(1U)
+
+#define SRQSRAM_S    5
+#define SRQSRAM_V(x) ((x) << SRQSRAM_S)
+#define SRQSRAM_F    SRQSRAM_V(1U)
+
+#define ARPDASRAM_S    4
+#define ARPDASRAM_V(x) ((x) << ARPDASRAM_S)
+#define ARPDASRAM_F    ARPDASRAM_V(1U)
+
+#define ARPSASRAM_S    3
+#define ARPSASRAM_V(x) ((x) << ARPSASRAM_S)
+#define ARPSASRAM_F    ARPSASRAM_V(1U)
+
+#define ARPGRESRAM_S    2
+#define ARPGRESRAM_V(x) ((x) << ARPGRESRAM_S)
+#define ARPGRESRAM_F    ARPGRESRAM_V(1U)
+
+#define ARPIPSECSRAM1_S    1
+#define ARPIPSECSRAM1_V(x) ((x) << ARPIPSECSRAM1_S)
+#define ARPIPSECSRAM1_F    ARPIPSECSRAM1_V(1U)
+
+#define ARPIPSECSRAM0_S    0
+#define ARPIPSECSRAM0_V(x) ((x) << ARPIPSECSRAM0_S)
+#define ARPIPSECSRAM0_F    ARPIPSECSRAM0_V(1U)
+
+#define TP_CERR_ENABLE_A 0x7f58
+#define TP_CERR_CAUSE_A 0x7f5c
+
+#define TPCEGDATAFIFO_S    8
+#define TPCEGDATAFIFO_V(x) ((x) << TPCEGDATAFIFO_S)
+#define TPCEGDATAFIFO_F    TPCEGDATAFIFO_V(1U)
+
+#define TPCLBKDATAFIFO_S    7
+#define TPCLBKDATAFIFO_V(x) ((x) << TPCLBKDATAFIFO_S)
+#define TPCLBKDATAFIFO_F    TPCLBKDATAFIFO_V(1U)
+
 #define ACTIVEFILTERCOUNTS_S    22
 #define ACTIVEFILTERCOUNTS_V(x) ((x) << ACTIVEFILTERCOUNTS_S)
 #define ACTIVEFILTERCOUNTS_F    ACTIVEFILTERCOUNTS_V(1U)
@@ -1387,11 +2977,6 @@
 #define DBGLAMODE_M	0x3U
 #define DBGLAMODE_G(x)	(((x) >> DBGLAMODE_S) & DBGLAMODE_M)
 
-#define FIVETUPLELOOKUP_S    17
-#define FIVETUPLELOOKUP_M    0x3U
-#define FIVETUPLELOOKUP_V(x) ((x) << FIVETUPLELOOKUP_S)
-#define FIVETUPLELOOKUP_G(x) (((x) >> FIVETUPLELOOKUP_S) & FIVETUPLELOOKUP_M)
-
 #define TP_PARA_REG2_A 0x7d68
 
 #define MAXRXDATA_S    16
@@ -1429,47 +3014,6 @@
 #define INITSRTT_M    0xffffU
 #define INITSRTT_G(x) (((x) >> INITSRTT_S) & INITSRTT_M)
 
-#define PERSMAX_S    0
-#define PERSMAX_M    0x3fffffffU
-#define PERSMAX_V(x) ((x) << PERSMAX_S)
-#define PERSMAX_G(x) (((x) >> PERSMAX_S) & PERSMAX_M)
-
-#define SYNSHIFTMAX_S    24
-#define SYNSHIFTMAX_M    0xffU
-#define SYNSHIFTMAX_V(x) ((x) << SYNSHIFTMAX_S)
-#define SYNSHIFTMAX_G(x) (((x) >> SYNSHIFTMAX_S) & SYNSHIFTMAX_M)
-
-#define RXTSHIFTMAXR1_S    20
-#define RXTSHIFTMAXR1_M    0xfU
-#define RXTSHIFTMAXR1_V(x) ((x) << RXTSHIFTMAXR1_S)
-#define RXTSHIFTMAXR1_G(x) (((x) >> RXTSHIFTMAXR1_S) & RXTSHIFTMAXR1_M)
-
-#define RXTSHIFTMAXR2_S    16
-#define RXTSHIFTMAXR2_M    0xfU
-#define RXTSHIFTMAXR2_V(x) ((x) << RXTSHIFTMAXR2_S)
-#define RXTSHIFTMAXR2_G(x) (((x) >> RXTSHIFTMAXR2_S) & RXTSHIFTMAXR2_M)
-
-#define PERSHIFTBACKOFFMAX_S    12
-#define PERSHIFTBACKOFFMAX_M    0xfU
-#define PERSHIFTBACKOFFMAX_V(x) ((x) << PERSHIFTBACKOFFMAX_S)
-#define PERSHIFTBACKOFFMAX_G(x) \
-	(((x) >> PERSHIFTBACKOFFMAX_S) & PERSHIFTBACKOFFMAX_M)
-
-#define PERSHIFTMAX_S    8
-#define PERSHIFTMAX_M    0xfU
-#define PERSHIFTMAX_V(x) ((x) << PERSHIFTMAX_S)
-#define PERSHIFTMAX_G(x) (((x) >> PERSHIFTMAX_S) & PERSHIFTMAX_M)
-
-#define KEEPALIVEMAXR1_S    4
-#define KEEPALIVEMAXR1_M    0xfU
-#define KEEPALIVEMAXR1_V(x) ((x) << KEEPALIVEMAXR1_S)
-#define KEEPALIVEMAXR1_G(x) (((x) >> KEEPALIVEMAXR1_S) & KEEPALIVEMAXR1_M)
-
-#define KEEPALIVEMAXR2_S    0
-#define KEEPALIVEMAXR2_M    0xfU
-#define KEEPALIVEMAXR2_V(x) ((x) << KEEPALIVEMAXR2_S)
-#define KEEPALIVEMAXR2_G(x) (((x) >> KEEPALIVEMAXR2_S) & KEEPALIVEMAXR2_M)
-
 #define ROWINDEX_S    16
 #define ROWINDEX_V(x) ((x) << ROWINDEX_S)
 
@@ -1522,8 +3066,34 @@
 #define TP_PIO_DATA_A	0x7e44
 #define TP_MIB_INDEX_A	0x7e50
 #define TP_MIB_DATA_A	0x7e54
+
+#define TP_INT_ENABLE_A 0x7e70
 #define TP_INT_CAUSE_A	0x7e74
 
+#define TPCERR_S    5
+#define TPCERR_V(x) ((x) << TPCERR_S)
+#define TPCERR_F    TPCERR_V(1U)
+
+#define OTHERPERR_S    4
+#define OTHERPERR_V(x) ((x) << OTHERPERR_S)
+#define OTHERPERR_F    OTHERPERR_V(1U)
+
+#define TPEING1PERR_S    3
+#define TPEING1PERR_V(x) ((x) << TPEING1PERR_S)
+#define TPEING1PERR_F    TPEING1PERR_V(1U)
+
+#define TPEING0PERR_S    2
+#define TPEING0PERR_V(x) ((x) << TPEING0PERR_S)
+#define TPEING0PERR_F    TPEING0PERR_V(1U)
+
+#define TPEEGPERR_S    1
+#define TPEEGPERR_V(x) ((x) << TPEEGPERR_S)
+#define TPEEGPERR_F    TPEEGPERR_V(1U)
+
+#define TPCPERR_S    0
+#define TPCPERR_V(x) ((x) << TPCPERR_S)
+#define TPCPERR_F    TPCPERR_V(1U)
+
 #define TP_FLM_FREE_PS_CNT_A 0x7e80
 #define TP_FLM_FREE_RX_CNT_A 0x7e84
 
@@ -1533,14 +3103,12 @@
 
 #define FREERXPAGECOUNT_S    0
 #define FREERXPAGECOUNT_M    0x1fffffU
-#define FREERXPAGECOUNT_V(x) ((x) << FREERXPAGECOUNT_S)
 #define FREERXPAGECOUNT_G(x) (((x) >> FREERXPAGECOUNT_S) & FREERXPAGECOUNT_M)
 
 #define TP_FLM_FREE_TX_CNT_A 0x7e88
 
 #define FREETXPAGECOUNT_S    0
 #define FREETXPAGECOUNT_M    0x1fffffU
-#define FREETXPAGECOUNT_V(x) ((x) << FREETXPAGECOUNT_S)
 #define FREETXPAGECOUNT_G(x) (((x) >> FREETXPAGECOUNT_S) & FREETXPAGECOUNT_M)
 
 #define FLMTXFLSTEMPTY_S    30
@@ -1625,13 +3193,57 @@
 #define FCOE_V(x) ((x) << FCOE_S)
 #define FCOE_F    FCOE_V(1U)
 
-#define FILTERMODE_S    15
-#define FILTERMODE_V(x) ((x) << FILTERMODE_S)
-#define FILTERMODE_F    FILTERMODE_V(1U)
+#define TCPFLAGS_S    13
+#define TCPFLAGS_V(x) ((x) << TCPFLAGS_S)
+#define TCPFLAGS_F    TCPFLAGS_V(1U)
+
+#define SYNONLY_S    12
+#define SYNONLY_V(x) ((x) << SYNONLY_S)
+#define SYNONLY_F    SYNONLY_V(1U)
+
+#define T7_FRAGMENTATION_S    10
+#define T7_FRAGMENTATION_V(x) ((x) << T7_FRAGMENTATION_S)
+#define T7_FRAGMENTATION_F    T7_FRAGMENTATION_V(1U)
+
+#define T7_MPSHITTYPE_S    9
+#define T7_MPSHITTYPE_V(x) ((x) << T7_MPSHITTYPE_S)
+#define T7_MPSHITTYPE_F    T7_MPSHITTYPE_V(1U)
+
+#define T7_MACMATCH_S    8
+#define T7_MACMATCH_V(x) ((x) << T7_MACMATCH_S)
+#define T7_MACMATCH_F    T7_MACMATCH_V(1U)
 
-#define FCOEMASK_S    14
-#define FCOEMASK_V(x) ((x) << FCOEMASK_S)
-#define FCOEMASK_F    FCOEMASK_V(1U)
+#define T7_ETHERTYPE_S    7
+#define T7_ETHERTYPE_V(x) ((x) << T7_ETHERTYPE_S)
+#define T7_ETHERTYPE_F    T7_ETHERTYPE_V(1U)
+
+#define T7_PROTOCOL_S    6
+#define T7_PROTOCOL_V(x) ((x) << T7_PROTOCOL_S)
+#define T7_PROTOCOL_F    T7_PROTOCOL_V(1U)
+
+#define T7_TOS_S    5
+#define T7_TOS_V(x) ((x) << T7_TOS_S)
+#define T7_TOS_F    T7_TOS_V(1U)
+
+#define T7_VLAN_S    4
+#define T7_VLAN_V(x) ((x) << T7_VLAN_S)
+#define T7_VLAN_F    T7_VLAN_V(1U)
+
+#define T7_VNIC_ID_S    3
+#define T7_VNIC_ID_V(x) ((x) << T7_VNIC_ID_S)
+#define T7_VNIC_ID_F    T7_VNIC_ID_V(1U)
+
+#define T7_PORT_S    2
+#define T7_PORT_V(x) ((x) << T7_PORT_S)
+#define T7_PORT_F    T7_PORT_V(1U)
+
+#define T7_FCOE_S    1
+#define T7_FCOE_V(x) ((x) << T7_FCOE_S)
+#define T7_FCOE_F    T7_FCOE_V(1U)
+
+#define IPSECIDX_S    0
+#define IPSECIDX_V(x) ((x) << IPSECIDX_S)
+#define IPSECIDX_F    IPSECIDX_V(1U)
 
 #define TP_INGRESS_CONFIG_A	0x141
 
@@ -1670,14 +3282,150 @@
 #define TP_MIB_FCOE_BYTE_0_HI_A	0x50
 #define TP_MIB_OFD_VLN_DROP_0_A	0x58
 #define TP_MIB_USM_PKTS_A	0x5c
-#define TP_MIB_RQE_DFR_PKT_A	0x64
+#define TP_CHANNEL_MAP_A 0x27
 
+#define T7_LB_MODE_S    30
+#define T7_LB_MODE_M    0x3U
+#define T7_LB_MODE_G(x) (((x) >> T7_LB_MODE_S) & T7_LB_MODE_M)
+
+#define TP_MIB_RQE_DFR_PKT_A	0x64
+
+#define ULP_TX_INT_ENABLE_2_A 0x8e7c
+#define ULP_TX_INT_CAUSE_2_A 0x8e80
+
+#define FSO_HDR_SRAM_PERR_SET3_S    7
+#define FSO_HDR_SRAM_PERR_SET3_V(x) ((x) << FSO_HDR_SRAM_PERR_SET3_S)
+#define FSO_HDR_SRAM_PERR_SET3_F    FSO_HDR_SRAM_PERR_SET3_V(1U)
+
+#define FSO_HDR_SRAM_PERR_SET2_S    6
+#define FSO_HDR_SRAM_PERR_SET2_V(x) ((x) << FSO_HDR_SRAM_PERR_SET2_S)
+#define FSO_HDR_SRAM_PERR_SET2_F    FSO_HDR_SRAM_PERR_SET2_V(1U)
+
+#define FSO_HDR_SRAM_PERR_SET1_S    5
+#define FSO_HDR_SRAM_PERR_SET1_V(x) ((x) << FSO_HDR_SRAM_PERR_SET1_S)
+#define FSO_HDR_SRAM_PERR_SET1_F    FSO_HDR_SRAM_PERR_SET1_V(1U)
+
+#define FSO_HDR_SRAM_PERR_SET0_S    4
+#define FSO_HDR_SRAM_PERR_SET0_V(x) ((x) << FSO_HDR_SRAM_PERR_SET0_S)
+#define FSO_HDR_SRAM_PERR_SET0_F    FSO_HDR_SRAM_PERR_SET0_V(1U)
+
+#define T10_PI_SRAM_PERR_SET3_S    3
+#define T10_PI_SRAM_PERR_SET3_V(x) ((x) << T10_PI_SRAM_PERR_SET3_S)
+#define T10_PI_SRAM_PERR_SET3_F    T10_PI_SRAM_PERR_SET3_V(1U)
+
+#define T10_PI_SRAM_PERR_SET2_S    2
+#define T10_PI_SRAM_PERR_SET2_V(x) ((x) << T10_PI_SRAM_PERR_SET2_S)
+#define T10_PI_SRAM_PERR_SET2_F    T10_PI_SRAM_PERR_SET2_V(1U)
+
+#define T10_PI_SRAM_PERR_SET1_S    1
+#define T10_PI_SRAM_PERR_SET1_V(x) ((x) << T10_PI_SRAM_PERR_SET1_S)
+#define T10_PI_SRAM_PERR_SET1_F    T10_PI_SRAM_PERR_SET1_V(1U)
+
+#define T10_PI_SRAM_PERR_SET0_S    0
+#define T10_PI_SRAM_PERR_SET0_V(x) ((x) << T10_PI_SRAM_PERR_SET0_S)
+#define T10_PI_SRAM_PERR_SET0_F    T10_PI_SRAM_PERR_SET0_V(1U)
+
+#define EDMA_IN_FIFO_PERR_SET3_S    31
+#define EDMA_IN_FIFO_PERR_SET3_V(x) ((x) << EDMA_IN_FIFO_PERR_SET3_S)
+#define EDMA_IN_FIFO_PERR_SET3_F    EDMA_IN_FIFO_PERR_SET3_V(1U)
+
+#define EDMA_IN_FIFO_PERR_SET2_S    30
+#define EDMA_IN_FIFO_PERR_SET2_V(x) ((x) << EDMA_IN_FIFO_PERR_SET2_S)
+#define EDMA_IN_FIFO_PERR_SET2_F    EDMA_IN_FIFO_PERR_SET2_V(1U)
+
+#define EDMA_IN_FIFO_PERR_SET1_S    29
+#define EDMA_IN_FIFO_PERR_SET1_V(x) ((x) << EDMA_IN_FIFO_PERR_SET1_S)
+#define EDMA_IN_FIFO_PERR_SET1_F    EDMA_IN_FIFO_PERR_SET1_V(1U)
+
+#define EDMA_IN_FIFO_PERR_SET0_S    28
+#define EDMA_IN_FIFO_PERR_SET0_V(x) ((x) << EDMA_IN_FIFO_PERR_SET0_S)
+#define EDMA_IN_FIFO_PERR_SET0_F    EDMA_IN_FIFO_PERR_SET0_V(1U)
+
+#define ALIGN_CTL_FIFO_PERR_SET3_S    27
+#define ALIGN_CTL_FIFO_PERR_SET3_V(x) ((x) << ALIGN_CTL_FIFO_PERR_SET3_S)
+#define ALIGN_CTL_FIFO_PERR_SET3_F    ALIGN_CTL_FIFO_PERR_SET3_V(1U)
+
+#define ALIGN_CTL_FIFO_PERR_SET2_S    26
+#define ALIGN_CTL_FIFO_PERR_SET2_V(x) ((x) << ALIGN_CTL_FIFO_PERR_SET2_S)
+#define ALIGN_CTL_FIFO_PERR_SET2_F    ALIGN_CTL_FIFO_PERR_SET2_V(1U)
+
+#define ALIGN_CTL_FIFO_PERR_SET1_S    25
+#define ALIGN_CTL_FIFO_PERR_SET1_V(x) ((x) << ALIGN_CTL_FIFO_PERR_SET1_S)
+#define ALIGN_CTL_FIFO_PERR_SET1_F    ALIGN_CTL_FIFO_PERR_SET1_V(1U)
+
+#define ALIGN_CTL_FIFO_PERR_SET0_S    24
+#define ALIGN_CTL_FIFO_PERR_SET0_V(x) ((x) << ALIGN_CTL_FIFO_PERR_SET0_S)
+#define ALIGN_CTL_FIFO_PERR_SET0_F    ALIGN_CTL_FIFO_PERR_SET0_V(1U)
+
+#define SGE_FIFO_PERR_SET3_S    23
+#define SGE_FIFO_PERR_SET3_V(x) ((x) << SGE_FIFO_PERR_SET3_S)
+#define SGE_FIFO_PERR_SET3_F    SGE_FIFO_PERR_SET3_V(1U)
+
+#define SGE_FIFO_PERR_SET2_S    22
+#define SGE_FIFO_PERR_SET2_V(x) ((x) << SGE_FIFO_PERR_SET2_S)
+#define SGE_FIFO_PERR_SET2_F    SGE_FIFO_PERR_SET2_V(1U)
+
+#define SGE_FIFO_PERR_SET1_S    21
+#define SGE_FIFO_PERR_SET1_V(x) ((x) << SGE_FIFO_PERR_SET1_S)
+#define SGE_FIFO_PERR_SET1_F    SGE_FIFO_PERR_SET1_V(1U)
+
+#define SGE_FIFO_PERR_SET0_S    20
+#define SGE_FIFO_PERR_SET0_V(x) ((x) << SGE_FIFO_PERR_SET0_S)
+#define SGE_FIFO_PERR_SET0_F    SGE_FIFO_PERR_SET0_V(1U)
+
+#define STAG_FIFO_PERR_SET3_S    19
+#define STAG_FIFO_PERR_SET3_V(x) ((x) << STAG_FIFO_PERR_SET3_S)
+#define STAG_FIFO_PERR_SET3_F    STAG_FIFO_PERR_SET3_V(1U)
+
+#define STAG_FIFO_PERR_SET2_S    18
+#define STAG_FIFO_PERR_SET2_V(x) ((x) << STAG_FIFO_PERR_SET2_S)
+#define STAG_FIFO_PERR_SET2_F    STAG_FIFO_PERR_SET2_V(1U)
+
+#define STAG_FIFO_PERR_SET1_S    17
+#define STAG_FIFO_PERR_SET1_V(x) ((x) << STAG_FIFO_PERR_SET1_S)
+#define STAG_FIFO_PERR_SET1_F    STAG_FIFO_PERR_SET1_V(1U)
+
+#define STAG_FIFO_PERR_SET0_S    16
+#define STAG_FIFO_PERR_SET0_V(x) ((x) << STAG_FIFO_PERR_SET0_S)
+#define STAG_FIFO_PERR_SET0_F    STAG_FIFO_PERR_SET0_V(1U)
+
+#define MAP_FIFO_PERR_SET3_S    15
+#define MAP_FIFO_PERR_SET3_V(x) ((x) << MAP_FIFO_PERR_SET3_S)
+#define MAP_FIFO_PERR_SET3_F    MAP_FIFO_PERR_SET3_V(1U)
+
+#define MAP_FIFO_PERR_SET2_S    14
+#define MAP_FIFO_PERR_SET2_V(x) ((x) << MAP_FIFO_PERR_SET2_S)
+#define MAP_FIFO_PERR_SET2_F    MAP_FIFO_PERR_SET2_V(1U)
+
+#define MAP_FIFO_PERR_SET1_S    13
+#define MAP_FIFO_PERR_SET1_V(x) ((x) << MAP_FIFO_PERR_SET1_S)
+#define MAP_FIFO_PERR_SET1_F    MAP_FIFO_PERR_SET1_V(1U)
+
+#define MAP_FIFO_PERR_SET0_S    12
+#define MAP_FIFO_PERR_SET0_V(x) ((x) << MAP_FIFO_PERR_SET0_S)
+#define MAP_FIFO_PERR_SET0_F    MAP_FIFO_PERR_SET0_V(1U)
+
+#define DMA_FIFO_PERR_SET3_S    11
+#define DMA_FIFO_PERR_SET3_V(x) ((x) << DMA_FIFO_PERR_SET3_S)
+#define DMA_FIFO_PERR_SET3_F    DMA_FIFO_PERR_SET3_V(1U)
+
+#define DMA_FIFO_PERR_SET2_S    10
+#define DMA_FIFO_PERR_SET2_V(x) ((x) << DMA_FIFO_PERR_SET2_S)
+#define DMA_FIFO_PERR_SET2_F    DMA_FIFO_PERR_SET2_V(1U)
+
+#define DMA_FIFO_PERR_SET1_S    9
+#define DMA_FIFO_PERR_SET1_V(x) ((x) << DMA_FIFO_PERR_SET1_S)
+#define DMA_FIFO_PERR_SET1_F    DMA_FIFO_PERR_SET1_V(1U)
+
+#define DMA_FIFO_PERR_SET0_S    8
+#define DMA_FIFO_PERR_SET0_V(x) ((x) << DMA_FIFO_PERR_SET0_S)
+#define DMA_FIFO_PERR_SET0_F    DMA_FIFO_PERR_SET0_V(1U)
+
+#define ULP_TX_INT_ENABLE_3_A 0x8e88
+#define ULP_TX_INT_CAUSE_3_A 0x8e8c
+
+#define ULP_TX_INT_ENABLE_A 0x8dc8
 #define ULP_TX_INT_CAUSE_A	0x8dcc
-#define ULP_TX_TPT_LLIMIT_A	0x8dd4
-#define ULP_TX_TPT_ULIMIT_A	0x8dd8
-#define ULP_TX_PBL_LLIMIT_A	0x8ddc
-#define ULP_TX_PBL_ULIMIT_A	0x8de0
-#define ULP_TX_ERR_TABLE_BASE_A 0x8e04
 
 #define PBL_BOUND_ERR_CH3_S    31
 #define PBL_BOUND_ERR_CH3_V(x) ((x) << PBL_BOUND_ERR_CH3_S)
@@ -1695,1146 +3443,3330 @@
 #define PBL_BOUND_ERR_CH0_V(x) ((x) << PBL_BOUND_ERR_CH0_S)
 #define PBL_BOUND_ERR_CH0_F    PBL_BOUND_ERR_CH0_V(1U)
 
-#define PM_RX_INT_CAUSE_A	0x8fdc
-#define PM_RX_STAT_CONFIG_A 0x8fc8
-#define PM_RX_STAT_COUNT_A 0x8fcc
-#define PM_RX_STAT_LSB_A 0x8fd0
-#define PM_RX_DBG_CTRL_A 0x8fd0
-#define PM_RX_DBG_DATA_A 0x8fd4
-#define PM_RX_DBG_STAT_MSB_A 0x10013
+#define SGE2ULP_FIFO_PERR_SET3_S    27
+#define SGE2ULP_FIFO_PERR_SET3_V(x) ((x) << SGE2ULP_FIFO_PERR_SET3_S)
+#define SGE2ULP_FIFO_PERR_SET3_F    SGE2ULP_FIFO_PERR_SET3_V(1U)
 
-#define PMRX_FRAMING_ERROR_F	0x003ffff0U
+#define SGE2ULP_FIFO_PERR_SET2_S    26
+#define SGE2ULP_FIFO_PERR_SET2_V(x) ((x) << SGE2ULP_FIFO_PERR_SET2_S)
+#define SGE2ULP_FIFO_PERR_SET2_F    SGE2ULP_FIFO_PERR_SET2_V(1U)
 
-#define ZERO_E_CMD_ERROR_S    22
-#define ZERO_E_CMD_ERROR_V(x) ((x) << ZERO_E_CMD_ERROR_S)
-#define ZERO_E_CMD_ERROR_F    ZERO_E_CMD_ERROR_V(1U)
+#define SGE2ULP_FIFO_PERR_SET1_S    25
+#define SGE2ULP_FIFO_PERR_SET1_V(x) ((x) << SGE2ULP_FIFO_PERR_SET1_S)
+#define SGE2ULP_FIFO_PERR_SET1_F    SGE2ULP_FIFO_PERR_SET1_V(1U)
 
-#define OCSPI_PAR_ERROR_S    3
-#define OCSPI_PAR_ERROR_V(x) ((x) << OCSPI_PAR_ERROR_S)
-#define OCSPI_PAR_ERROR_F    OCSPI_PAR_ERROR_V(1U)
+#define SGE2ULP_FIFO_PERR_SET0_S    24
+#define SGE2ULP_FIFO_PERR_SET0_V(x) ((x) << SGE2ULP_FIFO_PERR_SET0_S)
+#define SGE2ULP_FIFO_PERR_SET0_F    SGE2ULP_FIFO_PERR_SET0_V(1U)
 
-#define DB_OPTIONS_PAR_ERROR_S    2
-#define DB_OPTIONS_PAR_ERROR_V(x) ((x) << DB_OPTIONS_PAR_ERROR_S)
-#define DB_OPTIONS_PAR_ERROR_F    DB_OPTIONS_PAR_ERROR_V(1U)
+#define CIM2ULP_FIFO_PERR_SET3_S    23
+#define CIM2ULP_FIFO_PERR_SET3_V(x) ((x) << CIM2ULP_FIFO_PERR_SET3_S)
+#define CIM2ULP_FIFO_PERR_SET3_F    CIM2ULP_FIFO_PERR_SET3_V(1U)
 
-#define IESPI_PAR_ERROR_S    1
-#define IESPI_PAR_ERROR_V(x) ((x) << IESPI_PAR_ERROR_S)
-#define IESPI_PAR_ERROR_F    IESPI_PAR_ERROR_V(1U)
+#define CIM2ULP_FIFO_PERR_SET2_S    22
+#define CIM2ULP_FIFO_PERR_SET2_V(x) ((x) << CIM2ULP_FIFO_PERR_SET2_S)
+#define CIM2ULP_FIFO_PERR_SET2_F    CIM2ULP_FIFO_PERR_SET2_V(1U)
 
-#define ULP_TX_LA_RDPTR_0_A 0x8ec0
-#define ULP_TX_LA_RDDATA_0_A 0x8ec4
-#define ULP_TX_LA_WRPTR_0_A 0x8ec8
-#define ULP_TX_ASIC_DEBUG_CTRL_A 0x8f70
+#define CIM2ULP_FIFO_PERR_SET1_S    21
+#define CIM2ULP_FIFO_PERR_SET1_V(x) ((x) << CIM2ULP_FIFO_PERR_SET1_S)
+#define CIM2ULP_FIFO_PERR_SET1_F    CIM2ULP_FIFO_PERR_SET1_V(1U)
 
-#define ULP_TX_ASIC_DEBUG_0_A 0x8f74
-#define ULP_TX_ASIC_DEBUG_1_A 0x8f78
-#define ULP_TX_ASIC_DEBUG_2_A 0x8f7c
-#define ULP_TX_ASIC_DEBUG_3_A 0x8f80
-#define ULP_TX_ASIC_DEBUG_4_A 0x8f84
+#define CIM2ULP_FIFO_PERR_SET0_S    20
+#define CIM2ULP_FIFO_PERR_SET0_V(x) ((x) << CIM2ULP_FIFO_PERR_SET0_S)
+#define CIM2ULP_FIFO_PERR_SET0_F    CIM2ULP_FIFO_PERR_SET0_V(1U)
 
-/* registers for module PM_RX */
-#define PM_RX_BASE_ADDR 0x8fc0
+#define CQE_FIFO_PERR_SET3_S    19
+#define CQE_FIFO_PERR_SET3_V(x) ((x) << CQE_FIFO_PERR_SET3_S)
+#define CQE_FIFO_PERR_SET3_F    CQE_FIFO_PERR_SET3_V(1U)
 
-#define PMRX_E_PCMD_PAR_ERROR_S    0
-#define PMRX_E_PCMD_PAR_ERROR_V(x) ((x) << PMRX_E_PCMD_PAR_ERROR_S)
-#define PMRX_E_PCMD_PAR_ERROR_F    PMRX_E_PCMD_PAR_ERROR_V(1U)
+#define CQE_FIFO_PERR_SET2_S    18
+#define CQE_FIFO_PERR_SET2_V(x) ((x) << CQE_FIFO_PERR_SET2_S)
+#define CQE_FIFO_PERR_SET2_F    CQE_FIFO_PERR_SET2_V(1U)
 
-#define PM_TX_INT_CAUSE_A	0x8ffc
-#define PM_TX_STAT_CONFIG_A 0x8fe8
-#define PM_TX_STAT_COUNT_A 0x8fec
-#define PM_TX_STAT_LSB_A 0x8ff0
-#define PM_TX_DBG_CTRL_A 0x8ff0
-#define PM_TX_DBG_DATA_A 0x8ff4
-#define PM_TX_DBG_STAT_MSB_A 0x1001a
+#define CQE_FIFO_PERR_SET1_S    17
+#define CQE_FIFO_PERR_SET1_V(x) ((x) << CQE_FIFO_PERR_SET1_S)
+#define CQE_FIFO_PERR_SET1_F    CQE_FIFO_PERR_SET1_V(1U)
 
-#define PCMD_LEN_OVFL0_S    31
-#define PCMD_LEN_OVFL0_V(x) ((x) << PCMD_LEN_OVFL0_S)
-#define PCMD_LEN_OVFL0_F    PCMD_LEN_OVFL0_V(1U)
+#define CQE_FIFO_PERR_SET0_S    16
+#define CQE_FIFO_PERR_SET0_V(x) ((x) << CQE_FIFO_PERR_SET0_S)
+#define CQE_FIFO_PERR_SET0_F    CQE_FIFO_PERR_SET0_V(1U)
 
-#define PCMD_LEN_OVFL1_S    30
-#define PCMD_LEN_OVFL1_V(x) ((x) << PCMD_LEN_OVFL1_S)
-#define PCMD_LEN_OVFL1_F    PCMD_LEN_OVFL1_V(1U)
+#define PBL_FIFO_PERR_SET3_S    15
+#define PBL_FIFO_PERR_SET3_V(x) ((x) << PBL_FIFO_PERR_SET3_S)
+#define PBL_FIFO_PERR_SET3_F    PBL_FIFO_PERR_SET3_V(1U)
 
-#define PCMD_LEN_OVFL2_S    29
-#define PCMD_LEN_OVFL2_V(x) ((x) << PCMD_LEN_OVFL2_S)
-#define PCMD_LEN_OVFL2_F    PCMD_LEN_OVFL2_V(1U)
+#define PBL_FIFO_PERR_SET2_S    14
+#define PBL_FIFO_PERR_SET2_V(x) ((x) << PBL_FIFO_PERR_SET2_S)
+#define PBL_FIFO_PERR_SET2_F    PBL_FIFO_PERR_SET2_V(1U)
 
-#define ZERO_C_CMD_ERROR_S    28
-#define ZERO_C_CMD_ERROR_V(x) ((x) << ZERO_C_CMD_ERROR_S)
-#define ZERO_C_CMD_ERROR_F    ZERO_C_CMD_ERROR_V(1U)
+#define PBL_FIFO_PERR_SET1_S    13
+#define PBL_FIFO_PERR_SET1_V(x) ((x) << PBL_FIFO_PERR_SET1_S)
+#define PBL_FIFO_PERR_SET1_F    PBL_FIFO_PERR_SET1_V(1U)
 
-#define  PMTX_FRAMING_ERROR_F 0x0ffffff0U
+#define PBL_FIFO_PERR_SET0_S    12
+#define PBL_FIFO_PERR_SET0_V(x) ((x) << PBL_FIFO_PERR_SET0_S)
+#define PBL_FIFO_PERR_SET0_F    PBL_FIFO_PERR_SET0_V(1U)
 
-#define OESPI_PAR_ERROR_S    3
-#define OESPI_PAR_ERROR_V(x) ((x) << OESPI_PAR_ERROR_S)
-#define OESPI_PAR_ERROR_F    OESPI_PAR_ERROR_V(1U)
+#define CMD_FIFO_PERR_SET3_S    11
+#define CMD_FIFO_PERR_SET3_V(x) ((x) << CMD_FIFO_PERR_SET3_S)
+#define CMD_FIFO_PERR_SET3_F    CMD_FIFO_PERR_SET3_V(1U)
 
-#define ICSPI_PAR_ERROR_S    1
-#define ICSPI_PAR_ERROR_V(x) ((x) << ICSPI_PAR_ERROR_S)
-#define ICSPI_PAR_ERROR_F    ICSPI_PAR_ERROR_V(1U)
+#define CMD_FIFO_PERR_SET2_S    10
+#define CMD_FIFO_PERR_SET2_V(x) ((x) << CMD_FIFO_PERR_SET2_S)
+#define CMD_FIFO_PERR_SET2_F    CMD_FIFO_PERR_SET2_V(1U)
 
-#define PMTX_C_PCMD_PAR_ERROR_S    0
-#define PMTX_C_PCMD_PAR_ERROR_V(x) ((x) << PMTX_C_PCMD_PAR_ERROR_S)
-#define PMTX_C_PCMD_PAR_ERROR_F    PMTX_C_PCMD_PAR_ERROR_V(1U)
+#define CMD_FIFO_PERR_SET1_S    9
+#define CMD_FIFO_PERR_SET1_V(x) ((x) << CMD_FIFO_PERR_SET1_S)
+#define CMD_FIFO_PERR_SET1_F    CMD_FIFO_PERR_SET1_V(1U)
 
-#define MPS_PORT_STAT_TX_PORT_BYTES_L 0x400
-#define MPS_PORT_STAT_TX_PORT_BYTES_H 0x404
-#define MPS_PORT_STAT_TX_PORT_FRAMES_L 0x408
-#define MPS_PORT_STAT_TX_PORT_FRAMES_H 0x40c
-#define MPS_PORT_STAT_TX_PORT_BCAST_L 0x410
-#define MPS_PORT_STAT_TX_PORT_BCAST_H 0x414
-#define MPS_PORT_STAT_TX_PORT_MCAST_L 0x418
-#define MPS_PORT_STAT_TX_PORT_MCAST_H 0x41c
-#define MPS_PORT_STAT_TX_PORT_UCAST_L 0x420
-#define MPS_PORT_STAT_TX_PORT_UCAST_H 0x424
-#define MPS_PORT_STAT_TX_PORT_ERROR_L 0x428
-#define MPS_PORT_STAT_TX_PORT_ERROR_H 0x42c
-#define MPS_PORT_STAT_TX_PORT_64B_L 0x430
-#define MPS_PORT_STAT_TX_PORT_64B_H 0x434
-#define MPS_PORT_STAT_TX_PORT_65B_127B_L 0x438
-#define MPS_PORT_STAT_TX_PORT_65B_127B_H 0x43c
-#define MPS_PORT_STAT_TX_PORT_128B_255B_L 0x440
-#define MPS_PORT_STAT_TX_PORT_128B_255B_H 0x444
-#define MPS_PORT_STAT_TX_PORT_256B_511B_L 0x448
-#define MPS_PORT_STAT_TX_PORT_256B_511B_H 0x44c
-#define MPS_PORT_STAT_TX_PORT_512B_1023B_L 0x450
-#define MPS_PORT_STAT_TX_PORT_512B_1023B_H 0x454
-#define MPS_PORT_STAT_TX_PORT_1024B_1518B_L 0x458
-#define MPS_PORT_STAT_TX_PORT_1024B_1518B_H 0x45c
-#define MPS_PORT_STAT_TX_PORT_1519B_MAX_L 0x460
-#define MPS_PORT_STAT_TX_PORT_1519B_MAX_H 0x464
-#define MPS_PORT_STAT_TX_PORT_DROP_L 0x468
-#define MPS_PORT_STAT_TX_PORT_DROP_H 0x46c
-#define MPS_PORT_STAT_TX_PORT_PAUSE_L 0x470
-#define MPS_PORT_STAT_TX_PORT_PAUSE_H 0x474
-#define MPS_PORT_STAT_TX_PORT_PPP0_L 0x478
-#define MPS_PORT_STAT_TX_PORT_PPP0_H 0x47c
-#define MPS_PORT_STAT_TX_PORT_PPP1_L 0x480
-#define MPS_PORT_STAT_TX_PORT_PPP1_H 0x484
-#define MPS_PORT_STAT_TX_PORT_PPP2_L 0x488
-#define MPS_PORT_STAT_TX_PORT_PPP2_H 0x48c
-#define MPS_PORT_STAT_TX_PORT_PPP3_L 0x490
-#define MPS_PORT_STAT_TX_PORT_PPP3_H 0x494
-#define MPS_PORT_STAT_TX_PORT_PPP4_L 0x498
-#define MPS_PORT_STAT_TX_PORT_PPP4_H 0x49c
-#define MPS_PORT_STAT_TX_PORT_PPP5_L 0x4a0
-#define MPS_PORT_STAT_TX_PORT_PPP5_H 0x4a4
-#define MPS_PORT_STAT_TX_PORT_PPP6_L 0x4a8
-#define MPS_PORT_STAT_TX_PORT_PPP6_H 0x4ac
-#define MPS_PORT_STAT_TX_PORT_PPP7_L 0x4b0
-#define MPS_PORT_STAT_TX_PORT_PPP7_H 0x4b4
-#define MPS_PORT_STAT_LB_PORT_BYTES_L 0x4c0
-#define MPS_PORT_STAT_LB_PORT_BYTES_H 0x4c4
-#define MPS_PORT_STAT_LB_PORT_FRAMES_L 0x4c8
-#define MPS_PORT_STAT_LB_PORT_FRAMES_H 0x4cc
-#define MPS_PORT_STAT_LB_PORT_BCAST_L 0x4d0
-#define MPS_PORT_STAT_LB_PORT_BCAST_H 0x4d4
-#define MPS_PORT_STAT_LB_PORT_MCAST_L 0x4d8
-#define MPS_PORT_STAT_LB_PORT_MCAST_H 0x4dc
-#define MPS_PORT_STAT_LB_PORT_UCAST_L 0x4e0
-#define MPS_PORT_STAT_LB_PORT_UCAST_H 0x4e4
-#define MPS_PORT_STAT_LB_PORT_ERROR_L 0x4e8
-#define MPS_PORT_STAT_LB_PORT_ERROR_H 0x4ec
-#define MPS_PORT_STAT_LB_PORT_64B_L 0x4f0
-#define MPS_PORT_STAT_LB_PORT_64B_H 0x4f4
-#define MPS_PORT_STAT_LB_PORT_65B_127B_L 0x4f8
-#define MPS_PORT_STAT_LB_PORT_65B_127B_H 0x4fc
-#define MPS_PORT_STAT_LB_PORT_128B_255B_L 0x500
-#define MPS_PORT_STAT_LB_PORT_128B_255B_H 0x504
-#define MPS_PORT_STAT_LB_PORT_256B_511B_L 0x508
-#define MPS_PORT_STAT_LB_PORT_256B_511B_H 0x50c
-#define MPS_PORT_STAT_LB_PORT_512B_1023B_L 0x510
-#define MPS_PORT_STAT_LB_PORT_512B_1023B_H 0x514
-#define MPS_PORT_STAT_LB_PORT_1024B_1518B_L 0x518
-#define MPS_PORT_STAT_LB_PORT_1024B_1518B_H 0x51c
-#define MPS_PORT_STAT_LB_PORT_1519B_MAX_L 0x520
-#define MPS_PORT_STAT_LB_PORT_1519B_MAX_H 0x524
-#define MPS_PORT_STAT_LB_PORT_DROP_FRAMES 0x528
-#define MPS_PORT_STAT_LB_PORT_DROP_FRAMES_L 0x528
-#define MPS_PORT_STAT_RX_PORT_BYTES_L 0x540
-#define MPS_PORT_STAT_RX_PORT_BYTES_H 0x544
-#define MPS_PORT_STAT_RX_PORT_FRAMES_L 0x548
-#define MPS_PORT_STAT_RX_PORT_FRAMES_H 0x54c
-#define MPS_PORT_STAT_RX_PORT_BCAST_L 0x550
-#define MPS_PORT_STAT_RX_PORT_BCAST_H 0x554
-#define MPS_PORT_STAT_RX_PORT_MCAST_L 0x558
-#define MPS_PORT_STAT_RX_PORT_MCAST_H 0x55c
-#define MPS_PORT_STAT_RX_PORT_UCAST_L 0x560
-#define MPS_PORT_STAT_RX_PORT_UCAST_H 0x564
-#define MPS_PORT_STAT_RX_PORT_MTU_ERROR_L 0x568
-#define MPS_PORT_STAT_RX_PORT_MTU_ERROR_H 0x56c
-#define MPS_PORT_STAT_RX_PORT_MTU_CRC_ERROR_L 0x570
-#define MPS_PORT_STAT_RX_PORT_MTU_CRC_ERROR_H 0x574
-#define MPS_PORT_STAT_RX_PORT_CRC_ERROR_L 0x578
-#define MPS_PORT_STAT_RX_PORT_CRC_ERROR_H 0x57c
-#define MPS_PORT_STAT_RX_PORT_LEN_ERROR_L 0x580
-#define MPS_PORT_STAT_RX_PORT_LEN_ERROR_H 0x584
-#define MPS_PORT_STAT_RX_PORT_SYM_ERROR_L 0x588
-#define MPS_PORT_STAT_RX_PORT_SYM_ERROR_H 0x58c
-#define MPS_PORT_STAT_RX_PORT_64B_L 0x590
-#define MPS_PORT_STAT_RX_PORT_64B_H 0x594
-#define MPS_PORT_STAT_RX_PORT_65B_127B_L 0x598
-#define MPS_PORT_STAT_RX_PORT_65B_127B_H 0x59c
-#define MPS_PORT_STAT_RX_PORT_128B_255B_L 0x5a0
-#define MPS_PORT_STAT_RX_PORT_128B_255B_H 0x5a4
-#define MPS_PORT_STAT_RX_PORT_256B_511B_L 0x5a8
-#define MPS_PORT_STAT_RX_PORT_256B_511B_H 0x5ac
-#define MPS_PORT_STAT_RX_PORT_512B_1023B_L 0x5b0
-#define MPS_PORT_STAT_RX_PORT_512B_1023B_H 0x5b4
-#define MPS_PORT_STAT_RX_PORT_1024B_1518B_L 0x5b8
-#define MPS_PORT_STAT_RX_PORT_1024B_1518B_H 0x5bc
-#define MPS_PORT_STAT_RX_PORT_1519B_MAX_L 0x5c0
-#define MPS_PORT_STAT_RX_PORT_1519B_MAX_H 0x5c4
-#define MPS_PORT_STAT_RX_PORT_PAUSE_L 0x5c8
-#define MPS_PORT_STAT_RX_PORT_PAUSE_H 0x5cc
-#define MPS_PORT_STAT_RX_PORT_PPP0_L 0x5d0
-#define MPS_PORT_STAT_RX_PORT_PPP0_H 0x5d4
-#define MPS_PORT_STAT_RX_PORT_PPP1_L 0x5d8
-#define MPS_PORT_STAT_RX_PORT_PPP1_H 0x5dc
-#define MPS_PORT_STAT_RX_PORT_PPP2_L 0x5e0
-#define MPS_PORT_STAT_RX_PORT_PPP2_H 0x5e4
-#define MPS_PORT_STAT_RX_PORT_PPP3_L 0x5e8
-#define MPS_PORT_STAT_RX_PORT_PPP3_H 0x5ec
-#define MPS_PORT_STAT_RX_PORT_PPP4_L 0x5f0
-#define MPS_PORT_STAT_RX_PORT_PPP4_H 0x5f4
-#define MPS_PORT_STAT_RX_PORT_PPP5_L 0x5f8
-#define MPS_PORT_STAT_RX_PORT_PPP5_H 0x5fc
-#define MPS_PORT_STAT_RX_PORT_PPP6_L 0x600
-#define MPS_PORT_STAT_RX_PORT_PPP6_H 0x604
-#define MPS_PORT_STAT_RX_PORT_PPP7_L 0x608
-#define MPS_PORT_STAT_RX_PORT_PPP7_H 0x60c
-#define MPS_PORT_STAT_RX_PORT_LESS_64B_L 0x610
-#define MPS_PORT_STAT_RX_PORT_LESS_64B_H 0x614
-#define MAC_PORT_MAGIC_MACID_LO 0x824
-#define MAC_PORT_MAGIC_MACID_HI 0x828
-#define MAC_PORT_TX_TS_VAL_LO   0x928
-#define MAC_PORT_TX_TS_VAL_HI   0x92c
+#define CMD_FIFO_PERR_SET0_S    8
+#define CMD_FIFO_PERR_SET0_V(x) ((x) << CMD_FIFO_PERR_SET0_S)
+#define CMD_FIFO_PERR_SET0_F    CMD_FIFO_PERR_SET0_V(1U)
 
-#define MAC_PORT_EPIO_DATA0_A 0x8c0
-#define MAC_PORT_EPIO_DATA1_A 0x8c4
-#define MAC_PORT_EPIO_DATA2_A 0x8c8
-#define MAC_PORT_EPIO_DATA3_A 0x8cc
-#define MAC_PORT_EPIO_OP_A 0x8d0
+#define LSO_HDR_SRAM_PERR_SET3_S    7
+#define LSO_HDR_SRAM_PERR_SET3_V(x) ((x) << LSO_HDR_SRAM_PERR_SET3_S)
+#define LSO_HDR_SRAM_PERR_SET3_F    LSO_HDR_SRAM_PERR_SET3_V(1U)
 
-#define MAC_PORT_CFG2_A 0x818
+#define LSO_HDR_SRAM_PERR_SET2_S    6
+#define LSO_HDR_SRAM_PERR_SET2_V(x) ((x) << LSO_HDR_SRAM_PERR_SET2_S)
+#define LSO_HDR_SRAM_PERR_SET2_F    LSO_HDR_SRAM_PERR_SET2_V(1U)
 
-#define MAC_PORT_PTP_SUM_LO_A 0x990
-#define MAC_PORT_PTP_SUM_HI_A 0x994
+#define LSO_HDR_SRAM_PERR_SET1_S    5
+#define LSO_HDR_SRAM_PERR_SET1_V(x) ((x) << LSO_HDR_SRAM_PERR_SET1_S)
+#define LSO_HDR_SRAM_PERR_SET1_F    LSO_HDR_SRAM_PERR_SET1_V(1U)
 
-#define MPS_CMN_CTL_A	0x9000
+#define LSO_HDR_SRAM_PERR_SET0_S    4
+#define LSO_HDR_SRAM_PERR_SET0_V(x) ((x) << LSO_HDR_SRAM_PERR_SET0_S)
+#define LSO_HDR_SRAM_PERR_SET0_F    LSO_HDR_SRAM_PERR_SET0_V(1U)
 
-#define COUNTPAUSEMCRX_S    5
-#define COUNTPAUSEMCRX_V(x) ((x) << COUNTPAUSEMCRX_S)
-#define COUNTPAUSEMCRX_F    COUNTPAUSEMCRX_V(1U)
+#define ULP_TX_INT_ENABLE_1_A 0x8dc8
+#define ULP_TX_INT_CAUSE_1_A 0x8dcc
 
-#define COUNTPAUSESTATRX_S    4
-#define COUNTPAUSESTATRX_V(x) ((x) << COUNTPAUSESTATRX_S)
-#define COUNTPAUSESTATRX_F    COUNTPAUSESTATRX_V(1U)
+#define TLS_DSGL_PARERR3_S    3
+#define TLS_DSGL_PARERR3_V(x) ((x) << TLS_DSGL_PARERR3_S)
+#define TLS_DSGL_PARERR3_F    TLS_DSGL_PARERR3_V(1U)
 
-#define COUNTPAUSEMCTX_S    3
-#define COUNTPAUSEMCTX_V(x) ((x) << COUNTPAUSEMCTX_S)
-#define COUNTPAUSEMCTX_F    COUNTPAUSEMCTX_V(1U)
+#define TLS_DSGL_PARERR2_S    2
+#define TLS_DSGL_PARERR2_V(x) ((x) << TLS_DSGL_PARERR2_S)
+#define TLS_DSGL_PARERR2_F    TLS_DSGL_PARERR2_V(1U)
 
-#define COUNTPAUSESTATTX_S    2
-#define COUNTPAUSESTATTX_V(x) ((x) << COUNTPAUSESTATTX_S)
+#define TLS_DSGL_PARERR1_S    1
+#define TLS_DSGL_PARERR1_V(x) ((x) << TLS_DSGL_PARERR1_S)
+#define TLS_DSGL_PARERR1_F    TLS_DSGL_PARERR1_V(1U)
+
+#define TLS_DSGL_PARERR0_S    0
+#define TLS_DSGL_PARERR0_V(x) ((x) << TLS_DSGL_PARERR0_S)
+#define TLS_DSGL_PARERR0_F    TLS_DSGL_PARERR0_V(1U)
+
+#define ULP_TX_TPT_LLIMIT_A	0x8dd4
+#define ULP_TX_TPT_ULIMIT_A	0x8dd8
+#define ULP_TX_PBL_LLIMIT_A	0x8ddc
+#define ULP_TX_PBL_ULIMIT_A	0x8de0
+#define ULP_TX_ERR_TABLE_BASE_A 0x8e04
+
+#define GF_SGE_FIFO_PARERR3_S    31
+#define GF_SGE_FIFO_PARERR3_V(x) ((x) << GF_SGE_FIFO_PARERR3_S)
+#define GF_SGE_FIFO_PARERR3_F    GF_SGE_FIFO_PARERR3_V(1U)
+
+#define GF_SGE_FIFO_PARERR2_S    30
+#define GF_SGE_FIFO_PARERR2_V(x) ((x) << GF_SGE_FIFO_PARERR2_S)
+#define GF_SGE_FIFO_PARERR2_F    GF_SGE_FIFO_PARERR2_V(1U)
+
+#define GF_SGE_FIFO_PARERR1_S    29
+#define GF_SGE_FIFO_PARERR1_V(x) ((x) << GF_SGE_FIFO_PARERR1_S)
+#define GF_SGE_FIFO_PARERR1_F    GF_SGE_FIFO_PARERR1_V(1U)
+
+#define GF_SGE_FIFO_PARERR0_S    28
+#define GF_SGE_FIFO_PARERR0_V(x) ((x) << GF_SGE_FIFO_PARERR0_S)
+#define GF_SGE_FIFO_PARERR0_F    GF_SGE_FIFO_PARERR0_V(1U)
+
+#define DEDUPE_SGE_FIFO_PARERR3_S    27
+#define DEDUPE_SGE_FIFO_PARERR3_V(x) ((x) << DEDUPE_SGE_FIFO_PARERR3_S)
+#define DEDUPE_SGE_FIFO_PARERR3_F    DEDUPE_SGE_FIFO_PARERR3_V(1U)
+
+#define DEDUPE_SGE_FIFO_PARERR2_S    26
+#define DEDUPE_SGE_FIFO_PARERR2_V(x) ((x) << DEDUPE_SGE_FIFO_PARERR2_S)
+#define DEDUPE_SGE_FIFO_PARERR2_F    DEDUPE_SGE_FIFO_PARERR2_V(1U)
+
+#define DEDUPE_SGE_FIFO_PARERR1_S    25
+#define DEDUPE_SGE_FIFO_PARERR1_V(x) ((x) << DEDUPE_SGE_FIFO_PARERR1_S)
+#define DEDUPE_SGE_FIFO_PARERR1_F    DEDUPE_SGE_FIFO_PARERR1_V(1U)
+
+#define DEDUPE_SGE_FIFO_PARERR0_S    24
+#define DEDUPE_SGE_FIFO_PARERR0_V(x) ((x) << DEDUPE_SGE_FIFO_PARERR0_S)
+#define DEDUPE_SGE_FIFO_PARERR0_F    DEDUPE_SGE_FIFO_PARERR0_V(1U)
+
+#define GF3_DSGL_FIFO_PARERR_S    23
+#define GF3_DSGL_FIFO_PARERR_V(x) ((x) << GF3_DSGL_FIFO_PARERR_S)
+#define GF3_DSGL_FIFO_PARERR_F    GF3_DSGL_FIFO_PARERR_V(1U)
+
+#define GF2_DSGL_FIFO_PARERR_S    22
+#define GF2_DSGL_FIFO_PARERR_V(x) ((x) << GF2_DSGL_FIFO_PARERR_S)
+#define GF2_DSGL_FIFO_PARERR_F    GF2_DSGL_FIFO_PARERR_V(1U)
+
+#define GF1_DSGL_FIFO_PARERR_S    21
+#define GF1_DSGL_FIFO_PARERR_V(x) ((x) << GF1_DSGL_FIFO_PARERR_S)
+#define GF1_DSGL_FIFO_PARERR_F    GF1_DSGL_FIFO_PARERR_V(1U)
+
+#define GF0_DSGL_FIFO_PARERR_S    20
+#define GF0_DSGL_FIFO_PARERR_V(x) ((x) << GF0_DSGL_FIFO_PARERR_S)
+#define GF0_DSGL_FIFO_PARERR_F    GF0_DSGL_FIFO_PARERR_V(1U)
+
+#define DEDUPE3_DSGL_FIFO_PARERR_S    19
+#define DEDUPE3_DSGL_FIFO_PARERR_V(x) ((x) << DEDUPE3_DSGL_FIFO_PARERR_S)
+#define DEDUPE3_DSGL_FIFO_PARERR_F    DEDUPE3_DSGL_FIFO_PARERR_V(1U)
+
+#define DEDUPE2_DSGL_FIFO_PARERR_S    18
+#define DEDUPE2_DSGL_FIFO_PARERR_V(x) ((x) << DEDUPE2_DSGL_FIFO_PARERR_S)
+#define DEDUPE2_DSGL_FIFO_PARERR_F    DEDUPE2_DSGL_FIFO_PARERR_V(1U)
+
+#define DEDUPE1_DSGL_FIFO_PARERR_S    17
+#define DEDUPE1_DSGL_FIFO_PARERR_V(x) ((x) << DEDUPE1_DSGL_FIFO_PARERR_S)
+#define DEDUPE1_DSGL_FIFO_PARERR_F    DEDUPE1_DSGL_FIFO_PARERR_V(1U)
+
+#define DEDUPE0_DSGL_FIFO_PARERR_S    16
+#define DEDUPE0_DSGL_FIFO_PARERR_V(x) ((x) << DEDUPE0_DSGL_FIFO_PARERR_S)
+#define DEDUPE0_DSGL_FIFO_PARERR_F    DEDUPE0_DSGL_FIFO_PARERR_V(1U)
+
+#define XP10_SGE_FIFO_PARERR_S    15
+#define XP10_SGE_FIFO_PARERR_V(x) ((x) << XP10_SGE_FIFO_PARERR_S)
+#define XP10_SGE_FIFO_PARERR_F    XP10_SGE_FIFO_PARERR_V(1U)
+
+#define DSGL_PAR_ERR_S    14
+#define DSGL_PAR_ERR_V(x) ((x) << DSGL_PAR_ERR_S)
+#define DSGL_PAR_ERR_F    DSGL_PAR_ERR_V(1U)
+
+#define CDDIP_INT_S    13
+#define CDDIP_INT_V(x) ((x) << CDDIP_INT_S)
+#define CDDIP_INT_F    CDDIP_INT_V(1U)
+
+#define CCEIP_INT_S    12
+#define CCEIP_INT_V(x) ((x) << CCEIP_INT_S)
+#define CCEIP_INT_F    CCEIP_INT_V(1U)
+
+#define TLS_SGE_FIFO_PARERR3_S    11
+#define TLS_SGE_FIFO_PARERR3_V(x) ((x) << TLS_SGE_FIFO_PARERR3_S)
+#define TLS_SGE_FIFO_PARERR3_F    TLS_SGE_FIFO_PARERR3_V(1U)
+
+#define TLS_SGE_FIFO_PARERR2_S    10
+#define TLS_SGE_FIFO_PARERR2_V(x) ((x) << TLS_SGE_FIFO_PARERR2_S)
+#define TLS_SGE_FIFO_PARERR2_F    TLS_SGE_FIFO_PARERR2_V(1U)
+
+#define TLS_SGE_FIFO_PARERR1_S    9
+#define TLS_SGE_FIFO_PARERR1_V(x) ((x) << TLS_SGE_FIFO_PARERR1_S)
+#define TLS_SGE_FIFO_PARERR1_F    TLS_SGE_FIFO_PARERR1_V(1U)
+
+#define TLS_SGE_FIFO_PARERR0_S    8
+#define TLS_SGE_FIFO_PARERR0_V(x) ((x) << TLS_SGE_FIFO_PARERR0_S)
+#define TLS_SGE_FIFO_PARERR0_F    TLS_SGE_FIFO_PARERR0_V(1U)
+
+#define ULP2SMARBT_RSP_PERR_S    6
+#define ULP2SMARBT_RSP_PERR_V(x) ((x) << ULP2SMARBT_RSP_PERR_S)
+#define ULP2SMARBT_RSP_PERR_F    ULP2SMARBT_RSP_PERR_V(1U)
+
+#define ULPTX2MA_RSP_PERR_S    5
+#define ULPTX2MA_RSP_PERR_V(x) ((x) << ULPTX2MA_RSP_PERR_S)
+#define ULPTX2MA_RSP_PERR_F    ULPTX2MA_RSP_PERR_V(1U)
+
+#define PCIE2ULP_PERR3_S    4
+#define PCIE2ULP_PERR3_V(x) ((x) << PCIE2ULP_PERR3_S)
+#define PCIE2ULP_PERR3_F    PCIE2ULP_PERR3_V(1U)
+
+#define PCIE2ULP_PERR2_S    3
+#define PCIE2ULP_PERR2_V(x) ((x) << PCIE2ULP_PERR2_S)
+#define PCIE2ULP_PERR2_F    PCIE2ULP_PERR2_V(1U)
+
+#define PCIE2ULP_PERR1_S    2
+#define PCIE2ULP_PERR1_V(x) ((x) << PCIE2ULP_PERR1_S)
+#define PCIE2ULP_PERR1_F    PCIE2ULP_PERR1_V(1U)
+
+#define PCIE2ULP_PERR0_S    1
+#define PCIE2ULP_PERR0_V(x) ((x) << PCIE2ULP_PERR0_S)
+#define PCIE2ULP_PERR0_F    PCIE2ULP_PERR0_V(1U)
+
+#define CIM2ULP_PERR_S    0
+#define CIM2ULP_PERR_V(x) ((x) << CIM2ULP_PERR_S)
+#define CIM2ULP_PERR_F    CIM2ULP_PERR_V(1U)
+
+#define ULP_TX_INT_ENABLE_4_A 0x8e94
+#define ULP_TX_INT_CAUSE_4_A 0x8e98
+
+#define XP10_2_ULP_PERR_S    7
+#define XP10_2_ULP_PERR_V(x) ((x) << XP10_2_ULP_PERR_S)
+#define XP10_2_ULP_PERR_F    XP10_2_ULP_PERR_V(1U)
+
+#define ULP_2_XP10_PERR_S    6
+#define ULP_2_XP10_PERR_V(x) ((x) << ULP_2_XP10_PERR_S)
+#define ULP_2_XP10_PERR_F    ULP_2_XP10_PERR_V(1U)
+
+#define CMD_FIFO_LB1_S    5
+#define CMD_FIFO_LB1_V(x) ((x) << CMD_FIFO_LB1_S)
+#define CMD_FIFO_LB1_F    CMD_FIFO_LB1_V(1U)
+
+#define CMD_FIFO_LB0_S    4
+#define CMD_FIFO_LB0_V(x) ((x) << CMD_FIFO_LB0_S)
+#define CMD_FIFO_LB0_F    CMD_FIFO_LB0_V(1U)
+
+#define TF_TP_PERR_S    3
+#define TF_TP_PERR_V(x) ((x) << TF_TP_PERR_S)
+#define TF_TP_PERR_F    TF_TP_PERR_V(1U)
+
+#define TF_SGE_PERR_S    2
+#define TF_SGE_PERR_V(x) ((x) << TF_SGE_PERR_S)
+#define TF_SGE_PERR_F    TF_SGE_PERR_V(1U)
+
+#define TF_MEM_PERR_S    1
+#define TF_MEM_PERR_V(x) ((x) << TF_MEM_PERR_S)
+#define TF_MEM_PERR_F    TF_MEM_PERR_V(1U)
+
+#define TF_MP_PERR_S    0
+#define TF_MP_PERR_V(x) ((x) << TF_MP_PERR_S)
+#define TF_MP_PERR_F    TF_MP_PERR_V(1U)
+
+#define ULP_TX_INT_ENABLE_5_A 0x8ec4
+#define ULP_TX_INT_CAUSE_5_A 0x8ec8
+
+#define DEDUPE_PERR3_S    23
+#define DEDUPE_PERR3_V(x) ((x) << DEDUPE_PERR3_S)
+#define DEDUPE_PERR3_F    DEDUPE_PERR3_V(1U)
+
+#define DEDUPE_PERR2_S    22
+#define DEDUPE_PERR2_V(x) ((x) << DEDUPE_PERR2_S)
+#define DEDUPE_PERR2_F    DEDUPE_PERR2_V(1U)
+
+#define DEDUPE_PERR1_S    21
+#define DEDUPE_PERR1_V(x) ((x) << DEDUPE_PERR1_S)
+#define DEDUPE_PERR1_F    DEDUPE_PERR1_V(1U)
+
+#define DEDUPE_PERR0_S    20
+#define DEDUPE_PERR0_V(x) ((x) << DEDUPE_PERR0_S)
+#define DEDUPE_PERR0_F    DEDUPE_PERR0_V(1U)
+
+#define GF_PERR3_S    19
+#define GF_PERR3_V(x) ((x) << GF_PERR3_S)
+#define GF_PERR3_F    GF_PERR3_V(1U)
+
+#define GF_PERR2_S    18
+#define GF_PERR2_V(x) ((x) << GF_PERR2_S)
+#define GF_PERR2_F    GF_PERR2_V(1U)
+
+#define GF_PERR1_S    17
+#define GF_PERR1_V(x) ((x) << GF_PERR1_S)
+#define GF_PERR1_F    GF_PERR1_V(1U)
+
+#define GF_PERR0_S    16
+#define GF_PERR0_V(x) ((x) << GF_PERR0_S)
+#define GF_PERR0_F    GF_PERR0_V(1U)
+
+#define SGE2ULP_INV_PERR_S    13
+#define SGE2ULP_INV_PERR_V(x) ((x) << SGE2ULP_INV_PERR_S)
+#define SGE2ULP_INV_PERR_F    SGE2ULP_INV_PERR_V(1U)
+
+#define T7_PL_BUSPERR_S    12
+#define T7_PL_BUSPERR_V(x) ((x) << T7_PL_BUSPERR_S)
+#define T7_PL_BUSPERR_F    T7_PL_BUSPERR_V(1U)
+
+#define TLSTX2ULPTX_PERR3_S    11
+#define TLSTX2ULPTX_PERR3_V(x) ((x) << TLSTX2ULPTX_PERR3_S)
+#define TLSTX2ULPTX_PERR3_F    TLSTX2ULPTX_PERR3_V(1U)
+
+#define TLSTX2ULPTX_PERR2_S    10
+#define TLSTX2ULPTX_PERR2_V(x) ((x) << TLSTX2ULPTX_PERR2_S)
+#define TLSTX2ULPTX_PERR2_F    TLSTX2ULPTX_PERR2_V(1U)
+
+#define TLSTX2ULPTX_PERR1_S    9
+#define TLSTX2ULPTX_PERR1_V(x) ((x) << TLSTX2ULPTX_PERR1_S)
+#define TLSTX2ULPTX_PERR1_F    TLSTX2ULPTX_PERR1_V(1U)
+
+#define TLSTX2ULPTX_PERR0_S    8
+#define TLSTX2ULPTX_PERR0_V(x) ((x) << TLSTX2ULPTX_PERR0_S)
+#define TLSTX2ULPTX_PERR0_F    TLSTX2ULPTX_PERR0_V(1U)
+
+#define XP10_2_ULP_PL_PERR_S    1
+#define XP10_2_ULP_PL_PERR_V(x) ((x) << XP10_2_ULP_PL_PERR_S)
+#define XP10_2_ULP_PL_PERR_F    XP10_2_ULP_PL_PERR_V(1U)
+
+#define ULP_2_XP10_PL_PERR_S    0
+#define ULP_2_XP10_PL_PERR_V(x) ((x) << ULP_2_XP10_PL_PERR_S)
+#define ULP_2_XP10_PL_PERR_F    ULP_2_XP10_PL_PERR_V(1U)
+
+#define ULP_TX_INT_CAUSE_6_A 0x8ed0
+#define ULP_TX_INT_ENABLE_6_A 0x8ed4
+
+#define DDR_HDR_FIFO_PERR_SET3_S    12
+#define DDR_HDR_FIFO_PERR_SET3_V(x) ((x) << DDR_HDR_FIFO_PERR_SET3_S)
+#define DDR_HDR_FIFO_PERR_SET3_F    DDR_HDR_FIFO_PERR_SET3_V(1U)
+
+#define DDR_HDR_FIFO_PERR_SET2_S    11
+#define DDR_HDR_FIFO_PERR_SET2_V(x) ((x) << DDR_HDR_FIFO_PERR_SET2_S)
+#define DDR_HDR_FIFO_PERR_SET2_F    DDR_HDR_FIFO_PERR_SET2_V(1U)
+
+#define DDR_HDR_FIFO_PERR_SET1_S    10
+#define DDR_HDR_FIFO_PERR_SET1_V(x) ((x) << DDR_HDR_FIFO_PERR_SET1_S)
+#define DDR_HDR_FIFO_PERR_SET1_F    DDR_HDR_FIFO_PERR_SET1_V(1U)
+
+#define DDR_HDR_FIFO_PERR_SET0_S    9
+#define DDR_HDR_FIFO_PERR_SET0_V(x) ((x) << DDR_HDR_FIFO_PERR_SET0_S)
+#define DDR_HDR_FIFO_PERR_SET0_F    DDR_HDR_FIFO_PERR_SET0_V(1U)
+
+#define PRE_MP_RSP_PERR_SET3_S    8
+#define PRE_MP_RSP_PERR_SET3_V(x) ((x) << PRE_MP_RSP_PERR_SET3_S)
+#define PRE_MP_RSP_PERR_SET3_F    PRE_MP_RSP_PERR_SET3_V(1U)
+
+#define PRE_MP_RSP_PERR_SET2_S    7
+#define PRE_MP_RSP_PERR_SET2_V(x) ((x) << PRE_MP_RSP_PERR_SET2_S)
+#define PRE_MP_RSP_PERR_SET2_F    PRE_MP_RSP_PERR_SET2_V(1U)
+
+#define PRE_MP_RSP_PERR_SET1_S    6
+#define PRE_MP_RSP_PERR_SET1_V(x) ((x) << PRE_MP_RSP_PERR_SET1_S)
+#define PRE_MP_RSP_PERR_SET1_F    PRE_MP_RSP_PERR_SET1_V(1U)
+
+#define PRE_MP_RSP_PERR_SET0_S    5
+#define PRE_MP_RSP_PERR_SET0_V(x) ((x) << PRE_MP_RSP_PERR_SET0_S)
+#define PRE_MP_RSP_PERR_SET0_F    PRE_MP_RSP_PERR_SET0_V(1U)
+
+#define PRE_CQE_FIFO_PERR_SET3_S    4
+#define PRE_CQE_FIFO_PERR_SET3_V(x) ((x) << PRE_CQE_FIFO_PERR_SET3_S)
+#define PRE_CQE_FIFO_PERR_SET3_F    PRE_CQE_FIFO_PERR_SET3_V(1U)
+
+#define PRE_CQE_FIFO_PERR_SET2_S    3
+#define PRE_CQE_FIFO_PERR_SET2_V(x) ((x) << PRE_CQE_FIFO_PERR_SET2_S)
+#define PRE_CQE_FIFO_PERR_SET2_F    PRE_CQE_FIFO_PERR_SET2_V(1U)
+
+#define PRE_CQE_FIFO_PERR_SET1_S    2
+#define PRE_CQE_FIFO_PERR_SET1_V(x) ((x) << PRE_CQE_FIFO_PERR_SET1_S)
+#define PRE_CQE_FIFO_PERR_SET1_F    PRE_CQE_FIFO_PERR_SET1_V(1U)
+
+#define PRE_CQE_FIFO_PERR_SET0_S    1
+#define PRE_CQE_FIFO_PERR_SET0_V(x) ((x) << PRE_CQE_FIFO_PERR_SET0_S)
+#define PRE_CQE_FIFO_PERR_SET0_F    PRE_CQE_FIFO_PERR_SET0_V(1U)
+
+#define RSP_FIFO_PERR_SET_S    0
+#define RSP_FIFO_PERR_SET_V(x) ((x) << RSP_FIFO_PERR_SET_S)
+#define RSP_FIFO_PERR_SET_F    RSP_FIFO_PERR_SET_V(1U)
+
+#define ULP_TX_INT_CAUSE_7_A 0x8edc
+#define ULP_TX_INT_ENABLE_7_A 0x8ee0
+
+#define TLS_SGE_FIFO_CORERR3_S    23
+#define TLS_SGE_FIFO_CORERR3_V(x) ((x) << TLS_SGE_FIFO_CORERR3_S)
+#define TLS_SGE_FIFO_CORERR3_F    TLS_SGE_FIFO_CORERR3_V(1U)
+
+#define TLS_SGE_FIFO_CORERR2_S    22
+#define TLS_SGE_FIFO_CORERR2_V(x) ((x) << TLS_SGE_FIFO_CORERR2_S)
+#define TLS_SGE_FIFO_CORERR2_F    TLS_SGE_FIFO_CORERR2_V(1U)
+
+#define TLS_SGE_FIFO_CORERR1_S    21
+#define TLS_SGE_FIFO_CORERR1_V(x) ((x) << TLS_SGE_FIFO_CORERR1_S)
+#define TLS_SGE_FIFO_CORERR1_F    TLS_SGE_FIFO_CORERR1_V(1U)
+
+#define TLS_SGE_FIFO_CORERR0_S    20
+#define TLS_SGE_FIFO_CORERR0_V(x) ((x) << TLS_SGE_FIFO_CORERR0_S)
+#define TLS_SGE_FIFO_CORERR0_F    TLS_SGE_FIFO_CORERR0_V(1U)
+
+#define LSO_HDR_SRAM_CERR_SET3_S    19
+#define LSO_HDR_SRAM_CERR_SET3_V(x) ((x) << LSO_HDR_SRAM_CERR_SET3_S)
+#define LSO_HDR_SRAM_CERR_SET3_F    LSO_HDR_SRAM_CERR_SET3_V(1U)
+
+#define LSO_HDR_SRAM_CERR_SET2_S    18
+#define LSO_HDR_SRAM_CERR_SET2_V(x) ((x) << LSO_HDR_SRAM_CERR_SET2_S)
+#define LSO_HDR_SRAM_CERR_SET2_F    LSO_HDR_SRAM_CERR_SET2_V(1U)
+
+#define LSO_HDR_SRAM_CERR_SET1_S    17
+#define LSO_HDR_SRAM_CERR_SET1_V(x) ((x) << LSO_HDR_SRAM_CERR_SET1_S)
+#define LSO_HDR_SRAM_CERR_SET1_F    LSO_HDR_SRAM_CERR_SET1_V(1U)
+
+#define LSO_HDR_SRAM_CERR_SET0_S    16
+#define LSO_HDR_SRAM_CERR_SET0_V(x) ((x) << LSO_HDR_SRAM_CERR_SET0_S)
+#define LSO_HDR_SRAM_CERR_SET0_F    LSO_HDR_SRAM_CERR_SET0_V(1U)
+
+#define CORE_CMD_FIFO_CERR_SET_CH3_LB1_S    15
+#define CORE_CMD_FIFO_CERR_SET_CH3_LB1_V(x) ((x) << CORE_CMD_FIFO_CERR_SET_CH3_LB1_S)
+#define CORE_CMD_FIFO_CERR_SET_CH3_LB1_F    CORE_CMD_FIFO_CERR_SET_CH3_LB1_V(1U)
+
+#define CORE_CMD_FIFO_CERR_SET_CH2_LB1_S    14
+#define CORE_CMD_FIFO_CERR_SET_CH2_LB1_V(x) ((x) << CORE_CMD_FIFO_CERR_SET_CH2_LB1_S)
+#define CORE_CMD_FIFO_CERR_SET_CH2_LB1_F    CORE_CMD_FIFO_CERR_SET_CH2_LB1_V(1U)
+
+#define CORE_CMD_FIFO_CERR_SET_CH1_LB1_S    13
+#define CORE_CMD_FIFO_CERR_SET_CH1_LB1_V(x) ((x) << CORE_CMD_FIFO_CERR_SET_CH1_LB1_S)
+#define CORE_CMD_FIFO_CERR_SET_CH1_LB1_F    CORE_CMD_FIFO_CERR_SET_CH1_LB1_V(1U)
+
+#define CORE_CMD_FIFO_CERR_SET_CH0_LB1_S    12
+#define CORE_CMD_FIFO_CERR_SET_CH0_LB1_V(x) ((x) << CORE_CMD_FIFO_CERR_SET_CH0_LB1_S)
+#define CORE_CMD_FIFO_CERR_SET_CH0_LB1_F    CORE_CMD_FIFO_CERR_SET_CH0_LB1_V(1U)
+
+#define CORE_CMD_FIFO_CERR_SET_CH3_LB0_S    11
+#define CORE_CMD_FIFO_CERR_SET_CH3_LB0_V(x) ((x) << CORE_CMD_FIFO_CERR_SET_CH3_LB0_S)
+#define CORE_CMD_FIFO_CERR_SET_CH3_LB0_F    CORE_CMD_FIFO_CERR_SET_CH3_LB0_V(1U)
+
+#define CORE_CMD_FIFO_CERR_SET_CH2_LB0_S    10
+#define CORE_CMD_FIFO_CERR_SET_CH2_LB0_V(x) ((x) << CORE_CMD_FIFO_CERR_SET_CH2_LB0_S)
+#define CORE_CMD_FIFO_CERR_SET_CH2_LB0_F    CORE_CMD_FIFO_CERR_SET_CH2_LB0_V(1U)
+
+#define CORE_CMD_FIFO_CERR_SET_CH1_LB0_S    9
+#define CORE_CMD_FIFO_CERR_SET_CH1_LB0_V(x) ((x) << CORE_CMD_FIFO_CERR_SET_CH1_LB0_S)
+#define CORE_CMD_FIFO_CERR_SET_CH1_LB0_F    CORE_CMD_FIFO_CERR_SET_CH1_LB0_V(1U)
+
+#define CORE_CMD_FIFO_CERR_SET_CH0_LB0_S    8
+#define CORE_CMD_FIFO_CERR_SET_CH0_LB0_V(x) ((x) << CORE_CMD_FIFO_CERR_SET_CH0_LB0_S)
+#define CORE_CMD_FIFO_CERR_SET_CH0_LB0_F    CORE_CMD_FIFO_CERR_SET_CH0_LB0_V(1U)
+
+#define CQE_FIFO_CERR_SET3_S    7
+#define CQE_FIFO_CERR_SET3_V(x) ((x) << CQE_FIFO_CERR_SET3_S)
+#define CQE_FIFO_CERR_SET3_F    CQE_FIFO_CERR_SET3_V(1U)
+
+#define CQE_FIFO_CERR_SET2_S    6
+#define CQE_FIFO_CERR_SET2_V(x) ((x) << CQE_FIFO_CERR_SET2_S)
+#define CQE_FIFO_CERR_SET2_F    CQE_FIFO_CERR_SET2_V(1U)
+
+#define CQE_FIFO_CERR_SET1_S    5
+#define CQE_FIFO_CERR_SET1_V(x) ((x) << CQE_FIFO_CERR_SET1_S)
+#define CQE_FIFO_CERR_SET1_F    CQE_FIFO_CERR_SET1_V(1U)
+
+#define CQE_FIFO_CERR_SET0_S    4
+#define CQE_FIFO_CERR_SET0_V(x) ((x) << CQE_FIFO_CERR_SET0_S)
+#define CQE_FIFO_CERR_SET0_F    CQE_FIFO_CERR_SET0_V(1U)
+
+#define PRE_CQE_FIFO_CERR_SET3_S    3
+#define PRE_CQE_FIFO_CERR_SET3_V(x) ((x) << PRE_CQE_FIFO_CERR_SET3_S)
+#define PRE_CQE_FIFO_CERR_SET3_F    PRE_CQE_FIFO_CERR_SET3_V(1U)
+
+#define PRE_CQE_FIFO_CERR_SET2_S    2
+#define PRE_CQE_FIFO_CERR_SET2_V(x) ((x) << PRE_CQE_FIFO_CERR_SET2_S)
+#define PRE_CQE_FIFO_CERR_SET2_F    PRE_CQE_FIFO_CERR_SET2_V(1U)
+
+#define PRE_CQE_FIFO_CERR_SET1_S    1
+#define PRE_CQE_FIFO_CERR_SET1_V(x) ((x) << PRE_CQE_FIFO_CERR_SET1_S)
+#define PRE_CQE_FIFO_CERR_SET1_F    PRE_CQE_FIFO_CERR_SET1_V(1U)
+
+#define PRE_CQE_FIFO_CERR_SET0_S    0
+#define PRE_CQE_FIFO_CERR_SET0_V(x) ((x) << PRE_CQE_FIFO_CERR_SET0_S)
+#define PRE_CQE_FIFO_CERR_SET0_F    PRE_CQE_FIFO_CERR_SET0_V(1U)
+
+#define ULP_TX_INT_CAUSE_8_A 0x8ee4
+#define ULP_TX_INT_ENABLE_8_A 0x8ee8
+
+#define MEM_RSP_FIFO_CERR_SET3_S    28
+#define MEM_RSP_FIFO_CERR_SET3_V(x) ((x) << MEM_RSP_FIFO_CERR_SET3_S)
+#define MEM_RSP_FIFO_CERR_SET3_F    MEM_RSP_FIFO_CERR_SET3_V(1U)
+
+#define MEM_RSP_FIFO_CERR_SET2_S    27
+#define MEM_RSP_FIFO_CERR_SET2_V(x) ((x) << MEM_RSP_FIFO_CERR_SET2_S)
+#define MEM_RSP_FIFO_CERR_SET2_F    MEM_RSP_FIFO_CERR_SET2_V(1U)
+
+#define MEM_RSP_FIFO_CERR_SET1_S    26
+#define MEM_RSP_FIFO_CERR_SET1_V(x) ((x) << MEM_RSP_FIFO_CERR_SET1_S)
+#define MEM_RSP_FIFO_CERR_SET1_F    MEM_RSP_FIFO_CERR_SET1_V(1U)
+
+#define MEM_RSP_FIFO_CERR_SET0_S    25
+#define MEM_RSP_FIFO_CERR_SET0_V(x) ((x) << MEM_RSP_FIFO_CERR_SET0_S)
+#define MEM_RSP_FIFO_CERR_SET0_F    MEM_RSP_FIFO_CERR_SET0_V(1U)
+
+#define PI_SRAM_CERR_SET3_S    24
+#define PI_SRAM_CERR_SET3_V(x) ((x) << PI_SRAM_CERR_SET3_S)
+#define PI_SRAM_CERR_SET3_F    PI_SRAM_CERR_SET3_V(1U)
+
+#define PI_SRAM_CERR_SET2_S    23
+#define PI_SRAM_CERR_SET2_V(x) ((x) << PI_SRAM_CERR_SET2_S)
+#define PI_SRAM_CERR_SET2_F    PI_SRAM_CERR_SET2_V(1U)
+
+#define PI_SRAM_CERR_SET1_S    22
+#define PI_SRAM_CERR_SET1_V(x) ((x) << PI_SRAM_CERR_SET1_S)
+#define PI_SRAM_CERR_SET1_F    PI_SRAM_CERR_SET1_V(1U)
+
+#define PI_SRAM_CERR_SET0_S    21
+#define PI_SRAM_CERR_SET0_V(x) ((x) << PI_SRAM_CERR_SET0_S)
+#define PI_SRAM_CERR_SET0_F    PI_SRAM_CERR_SET0_V(1U)
+
+#define PRE_MP_RSP_CERR_SET3_S    20
+#define PRE_MP_RSP_CERR_SET3_V(x) ((x) << PRE_MP_RSP_CERR_SET3_S)
+#define PRE_MP_RSP_CERR_SET3_F    PRE_MP_RSP_CERR_SET3_V(1U)
+
+#define PRE_MP_RSP_CERR_SET2_S    19
+#define PRE_MP_RSP_CERR_SET2_V(x) ((x) << PRE_MP_RSP_CERR_SET2_S)
+#define PRE_MP_RSP_CERR_SET2_F    PRE_MP_RSP_CERR_SET2_V(1U)
+
+#define PRE_MP_RSP_CERR_SET1_S    18
+#define PRE_MP_RSP_CERR_SET1_V(x) ((x) << PRE_MP_RSP_CERR_SET1_S)
+#define PRE_MP_RSP_CERR_SET1_F    PRE_MP_RSP_CERR_SET1_V(1U)
+
+#define PRE_MP_RSP_CERR_SET0_S    17
+#define PRE_MP_RSP_CERR_SET0_V(x) ((x) << PRE_MP_RSP_CERR_SET0_S)
+#define PRE_MP_RSP_CERR_SET0_F    PRE_MP_RSP_CERR_SET0_V(1U)
+
+#define DDR_HDR_FIFO_CERR_SET3_S    16
+#define DDR_HDR_FIFO_CERR_SET3_V(x) ((x) << DDR_HDR_FIFO_CERR_SET3_S)
+#define DDR_HDR_FIFO_CERR_SET3_F    DDR_HDR_FIFO_CERR_SET3_V(1U)
+
+#define DDR_HDR_FIFO_CERR_SET2_S    15
+#define DDR_HDR_FIFO_CERR_SET2_V(x) ((x) << DDR_HDR_FIFO_CERR_SET2_S)
+#define DDR_HDR_FIFO_CERR_SET2_F    DDR_HDR_FIFO_CERR_SET2_V(1U)
+
+#define DDR_HDR_FIFO_CERR_SET1_S    14
+#define DDR_HDR_FIFO_CERR_SET1_V(x) ((x) << DDR_HDR_FIFO_CERR_SET1_S)
+#define DDR_HDR_FIFO_CERR_SET1_F    DDR_HDR_FIFO_CERR_SET1_V(1U)
+
+#define DDR_HDR_FIFO_CERR_SET0_S    13
+#define DDR_HDR_FIFO_CERR_SET0_V(x) ((x) << DDR_HDR_FIFO_CERR_SET0_S)
+#define DDR_HDR_FIFO_CERR_SET0_F    DDR_HDR_FIFO_CERR_SET0_V(1U)
+
+#define CMD_FIFO_CERR_SET3_S    12
+#define CMD_FIFO_CERR_SET3_V(x) ((x) << CMD_FIFO_CERR_SET3_S)
+#define CMD_FIFO_CERR_SET3_F    CMD_FIFO_CERR_SET3_V(1U)
+
+#define CMD_FIFO_CERR_SET2_S    11
+#define CMD_FIFO_CERR_SET2_V(x) ((x) << CMD_FIFO_CERR_SET2_S)
+#define CMD_FIFO_CERR_SET2_F    CMD_FIFO_CERR_SET2_V(1U)
+
+#define CMD_FIFO_CERR_SET1_S    10
+#define CMD_FIFO_CERR_SET1_V(x) ((x) << CMD_FIFO_CERR_SET1_S)
+#define CMD_FIFO_CERR_SET1_F    CMD_FIFO_CERR_SET1_V(1U)
+
+#define CMD_FIFO_CERR_SET0_S    9
+#define CMD_FIFO_CERR_SET0_V(x) ((x) << CMD_FIFO_CERR_SET0_S)
+#define CMD_FIFO_CERR_SET0_F    CMD_FIFO_CERR_SET0_V(1U)
+
+#define GF_SGE_FIFO_CORERR3_S    8
+#define GF_SGE_FIFO_CORERR3_V(x) ((x) << GF_SGE_FIFO_CORERR3_S)
+#define GF_SGE_FIFO_CORERR3_F    GF_SGE_FIFO_CORERR3_V(1U)
+
+#define GF_SGE_FIFO_CORERR2_S    7
+#define GF_SGE_FIFO_CORERR2_V(x) ((x) << GF_SGE_FIFO_CORERR2_S)
+#define GF_SGE_FIFO_CORERR2_F    GF_SGE_FIFO_CORERR2_V(1U)
+
+#define GF_SGE_FIFO_CORERR1_S    6
+#define GF_SGE_FIFO_CORERR1_V(x) ((x) << GF_SGE_FIFO_CORERR1_S)
+#define GF_SGE_FIFO_CORERR1_F    GF_SGE_FIFO_CORERR1_V(1U)
+
+#define GF_SGE_FIFO_CORERR0_S    5
+#define GF_SGE_FIFO_CORERR0_V(x) ((x) << GF_SGE_FIFO_CORERR0_S)
+#define GF_SGE_FIFO_CORERR0_F    GF_SGE_FIFO_CORERR0_V(1U)
+
+#define DEDUPE_SGE_FIFO_CORERR3_S    4
+#define DEDUPE_SGE_FIFO_CORERR3_V(x) ((x) << DEDUPE_SGE_FIFO_CORERR3_S)
+#define DEDUPE_SGE_FIFO_CORERR3_F    DEDUPE_SGE_FIFO_CORERR3_V(1U)
+
+#define DEDUPE_SGE_FIFO_CORERR2_S    3
+#define DEDUPE_SGE_FIFO_CORERR2_V(x) ((x) << DEDUPE_SGE_FIFO_CORERR2_S)
+#define DEDUPE_SGE_FIFO_CORERR2_F    DEDUPE_SGE_FIFO_CORERR2_V(1U)
+
+#define DEDUPE_SGE_FIFO_CORERR1_S    2
+#define DEDUPE_SGE_FIFO_CORERR1_V(x) ((x) << DEDUPE_SGE_FIFO_CORERR1_S)
+#define DEDUPE_SGE_FIFO_CORERR1_F    DEDUPE_SGE_FIFO_CORERR1_V(1U)
+
+#define DEDUPE_SGE_FIFO_CORERR0_S    1
+#define DEDUPE_SGE_FIFO_CORERR0_V(x) ((x) << DEDUPE_SGE_FIFO_CORERR0_S)
+#define DEDUPE_SGE_FIFO_CORERR0_F    DEDUPE_SGE_FIFO_CORERR0_V(1U)
+
+#define RSP_FIFO_CERR_SET_S    0
+#define RSP_FIFO_CERR_SET_V(x) ((x) << RSP_FIFO_CERR_SET_S)
+#define RSP_FIFO_CERR_SET_F    RSP_FIFO_CERR_SET_V(1U)
+
+#define PM_RX_INT_ENABLE_2_A 0x10060
+#define PM_RX_INT_CAUSE_2_A 0x10061
+
+#define CACHE_SRAM_ODD_CERR_S    12
+#define CACHE_SRAM_ODD_CERR_V(x) ((x) << CACHE_SRAM_ODD_CERR_S)
+#define CACHE_SRAM_ODD_CERR_F    CACHE_SRAM_ODD_CERR_V(1U)
+
+#define CACHE_SRAM_EVEN_CERR_S    11
+#define CACHE_SRAM_EVEN_CERR_V(x) ((x) << CACHE_SRAM_EVEN_CERR_S)
+#define CACHE_SRAM_EVEN_CERR_F    CACHE_SRAM_EVEN_CERR_V(1U)
+
+#define CACHE_LRU_LEFT_CERR_S    10
+#define CACHE_LRU_LEFT_CERR_V(x) ((x) << CACHE_LRU_LEFT_CERR_S)
+#define CACHE_LRU_LEFT_CERR_F    CACHE_LRU_LEFT_CERR_V(1U)
+
+#define CACHE_LRU_RIGHT_CERR_S    9
+#define CACHE_LRU_RIGHT_CERR_V(x) ((x) << CACHE_LRU_RIGHT_CERR_S)
+#define CACHE_LRU_RIGHT_CERR_F    CACHE_LRU_RIGHT_CERR_V(1U)
+
+#define CACHE_ISLAND_CERR_S    8
+#define CACHE_ISLAND_CERR_V(x) ((x) << CACHE_ISLAND_CERR_S)
+#define CACHE_ISLAND_CERR_F    CACHE_ISLAND_CERR_V(1U)
+
+#define OCSPI_CERR_S    7
+#define OCSPI_CERR_V(x) ((x) << OCSPI_CERR_S)
+#define OCSPI_CERR_F    OCSPI_CERR_V(1U)
+
+#define IESPI_CERR_S    6
+#define IESPI_CERR_V(x) ((x) << IESPI_CERR_S)
+#define IESPI_CERR_F    IESPI_CERR_V(1U)
+
+#define OCSPI2_RX_FRAMING_ERROR_S    5
+#define OCSPI2_RX_FRAMING_ERROR_V(x) ((x) << OCSPI2_RX_FRAMING_ERROR_S)
+#define OCSPI2_RX_FRAMING_ERROR_F    OCSPI2_RX_FRAMING_ERROR_V(1U)
+
+#define OCSPI3_RX_FRAMING_ERROR_S    4
+#define OCSPI3_RX_FRAMING_ERROR_V(x) ((x) << OCSPI3_RX_FRAMING_ERROR_S)
+#define OCSPI3_RX_FRAMING_ERROR_F    OCSPI3_RX_FRAMING_ERROR_V(1U)
+
+#define OCSPI2_TX_FRAMING_ERROR_S    3
+#define OCSPI2_TX_FRAMING_ERROR_V(x) ((x) << OCSPI2_TX_FRAMING_ERROR_S)
+#define OCSPI2_TX_FRAMING_ERROR_F    OCSPI2_TX_FRAMING_ERROR_V(1U)
+
+#define OCSPI3_TX_FRAMING_ERROR_S    2
+#define OCSPI3_TX_FRAMING_ERROR_V(x) ((x) << OCSPI3_TX_FRAMING_ERROR_S)
+#define OCSPI3_TX_FRAMING_ERROR_F    OCSPI3_TX_FRAMING_ERROR_V(1U)
+
+#define OCSPI2_OFIFO2X_TX_FRAMING_ERROR_S    1
+#define OCSPI2_OFIFO2X_TX_FRAMING_ERROR_V(x) ((x) << OCSPI2_OFIFO2X_TX_FRAMING_ERROR_S)
+#define OCSPI2_OFIFO2X_TX_FRAMING_ERROR_F    OCSPI2_OFIFO2X_TX_FRAMING_ERROR_V(1U)
+
+#define OCSPI3_OFIFO2X_TX_FRAMING_ERROR_S    0
+#define OCSPI3_OFIFO2X_TX_FRAMING_ERROR_V(x) ((x) << OCSPI3_OFIFO2X_TX_FRAMING_ERROR_S)
+#define OCSPI3_OFIFO2X_TX_FRAMING_ERROR_F    OCSPI3_OFIFO2X_TX_FRAMING_ERROR_V(1U)
+
+#define PM_RX_PERR_ENABLE_A 0x10062
+#define PM_RX_PERR_CAUSE_A 0x10063
+
+#define T7_SDC_ERR_S    31
+#define T7_SDC_ERR_V(x) ((x) << T7_SDC_ERR_S)
+#define T7_SDC_ERR_F    T7_SDC_ERR_V(1U)
+
+#define T7_MA_INTF_SDC_ERR_S    30
+#define T7_MA_INTF_SDC_ERR_V(x) ((x) << T7_MA_INTF_SDC_ERR_S)
+#define T7_MA_INTF_SDC_ERR_F    T7_MA_INTF_SDC_ERR_V(1U)
+
+#define E_PCMD_PERR_S    21
+#define E_PCMD_PERR_V(x) ((x) << E_PCMD_PERR_S)
+#define E_PCMD_PERR_F    E_PCMD_PERR_V(1U)
+
+#define CACHE_RSP_DFIFO_PERR_S    20
+#define CACHE_RSP_DFIFO_PERR_V(x) ((x) << CACHE_RSP_DFIFO_PERR_S)
+#define CACHE_RSP_DFIFO_PERR_F    CACHE_RSP_DFIFO_PERR_V(1U)
+
+#define CACHE_SRAM_ODD_PERR_S    19
+#define CACHE_SRAM_ODD_PERR_V(x) ((x) << CACHE_SRAM_ODD_PERR_S)
+#define CACHE_SRAM_ODD_PERR_F    CACHE_SRAM_ODD_PERR_V(1U)
+
+#define CACHE_SRAM_EVEN_PERR_S    18
+#define CACHE_SRAM_EVEN_PERR_V(x) ((x) << CACHE_SRAM_EVEN_PERR_S)
+#define CACHE_SRAM_EVEN_PERR_F    CACHE_SRAM_EVEN_PERR_V(1U)
+
+#define CACHE_RSVD_PERR_S    17
+#define CACHE_RSVD_PERR_V(x) ((x) << CACHE_RSVD_PERR_S)
+#define CACHE_RSVD_PERR_F    CACHE_RSVD_PERR_V(1U)
+
+#define CACHE_LRU_LEFT_PERR_S    16
+#define CACHE_LRU_LEFT_PERR_V(x) ((x) << CACHE_LRU_LEFT_PERR_S)
+#define CACHE_LRU_LEFT_PERR_F    CACHE_LRU_LEFT_PERR_V(1U)
+
+#define CACHE_LRU_RIGHT_PERR_S    15
+#define CACHE_LRU_RIGHT_PERR_V(x) ((x) << CACHE_LRU_RIGHT_PERR_S)
+#define CACHE_LRU_RIGHT_PERR_F    CACHE_LRU_RIGHT_PERR_V(1U)
+
+#define CACHE_RSP_CMD_PERR_S    14
+#define CACHE_RSP_CMD_PERR_V(x) ((x) << CACHE_RSP_CMD_PERR_S)
+#define CACHE_RSP_CMD_PERR_F    CACHE_RSP_CMD_PERR_V(1U)
+
+#define CACHE_SRAM_CMD_PERR_S    13
+#define CACHE_SRAM_CMD_PERR_V(x) ((x) << CACHE_SRAM_CMD_PERR_S)
+#define CACHE_SRAM_CMD_PERR_F    CACHE_SRAM_CMD_PERR_V(1U)
+
+#define CACHE_MA_CMD_PERR_S    12
+#define CACHE_MA_CMD_PERR_V(x) ((x) << CACHE_MA_CMD_PERR_S)
+#define CACHE_MA_CMD_PERR_F    CACHE_MA_CMD_PERR_V(1U)
+
+#define CACHE_TCAM_PERR_S    11
+#define CACHE_TCAM_PERR_V(x) ((x) << CACHE_TCAM_PERR_S)
+#define CACHE_TCAM_PERR_F    CACHE_TCAM_PERR_V(1U)
+
+#define CACHE_ISLAND_PERR_S    10
+#define CACHE_ISLAND_PERR_V(x) ((x) << CACHE_ISLAND_PERR_S)
+#define CACHE_ISLAND_PERR_F    CACHE_ISLAND_PERR_V(1U)
+
+#define MC_WCNT_FIFO_PERR_S    9
+#define MC_WCNT_FIFO_PERR_V(x) ((x) << MC_WCNT_FIFO_PERR_S)
+#define MC_WCNT_FIFO_PERR_F    MC_WCNT_FIFO_PERR_V(1U)
+
+#define MC_WDATA_FIFO_PERR_S    8
+#define MC_WDATA_FIFO_PERR_V(x) ((x) << MC_WDATA_FIFO_PERR_S)
+#define MC_WDATA_FIFO_PERR_F    MC_WDATA_FIFO_PERR_V(1U)
+
+#define MC_RCNT_FIFO_PERR_S    7
+#define MC_RCNT_FIFO_PERR_V(x) ((x) << MC_RCNT_FIFO_PERR_S)
+#define MC_RCNT_FIFO_PERR_F    MC_RCNT_FIFO_PERR_V(1U)
+
+#define MC_RDATA_FIFO_PERR_S    6
+#define MC_RDATA_FIFO_PERR_V(x) ((x) << MC_RDATA_FIFO_PERR_S)
+#define MC_RDATA_FIFO_PERR_F    MC_RDATA_FIFO_PERR_V(1U)
+
+#define TOKEN_FIFO_PERR_S    5
+#define TOKEN_FIFO_PERR_V(x) ((x) << TOKEN_FIFO_PERR_S)
+#define TOKEN_FIFO_PERR_F    TOKEN_FIFO_PERR_V(1U)
+
+#define T7_BUNDLE_LEN_PARERR_S    4
+#define T7_BUNDLE_LEN_PARERR_V(x) ((x) << T7_BUNDLE_LEN_PARERR_S)
+#define T7_BUNDLE_LEN_PARERR_F    T7_BUNDLE_LEN_PARERR_V(1U)
+
+#define PM_TX_DBG_STAT0_A 0x1002c
+
+#define PM_TX_INT_ENABLE_A 0x8ff8
+#define PM_TX_INT_CAUSE_A 0x8ffc
+
+#define PCMD_LEN_OVFL0_S    31
+#define PCMD_LEN_OVFL0_V(x) ((x) << PCMD_LEN_OVFL0_S)
+#define PCMD_LEN_OVFL0_F    PCMD_LEN_OVFL0_V(1U)
+
+#define PCMD_LEN_OVFL1_S    30
+#define PCMD_LEN_OVFL1_V(x) ((x) << PCMD_LEN_OVFL1_S)
+#define PCMD_LEN_OVFL1_F    PCMD_LEN_OVFL1_V(1U)
+
+#define PCMD_LEN_OVFL2_S    29
+#define PCMD_LEN_OVFL2_V(x) ((x) << PCMD_LEN_OVFL2_S)
+#define PCMD_LEN_OVFL2_F    PCMD_LEN_OVFL2_V(1U)
+
+#define OESPI_PAR_ERROR_S    3
+#define OESPI_PAR_ERROR_V(x) ((x) << OESPI_PAR_ERROR_S)
+#define OESPI_PAR_ERROR_F    OESPI_PAR_ERROR_V(1U)
+
+#define ICSPI_PAR_ERROR_S    1
+#define ICSPI_PAR_ERROR_V(x) ((x) << ICSPI_PAR_ERROR_S)
+#define ICSPI_PAR_ERROR_F    ICSPI_PAR_ERROR_V(1U)
+
+#define C_PCMD_PAR_ERROR_S    0
+#define C_PCMD_PAR_ERROR_V(x) ((x) << C_PCMD_PAR_ERROR_S)
+#define C_PCMD_PAR_ERROR_F    C_PCMD_PAR_ERROR_V(1U)
+
+#define T7_ZERO_C_CMD_ERROR_S    30
+#define T7_ZERO_C_CMD_ERROR_V(x) ((x) << T7_ZERO_C_CMD_ERROR_S)
+#define T7_ZERO_C_CMD_ERROR_F    T7_ZERO_C_CMD_ERROR_V(1U)
+
+#define OESPI_COR_ERR_S    29
+#define OESPI_COR_ERR_V(x) ((x) << OESPI_COR_ERR_S)
+#define OESPI_COR_ERR_F    OESPI_COR_ERR_V(1U)
+
+#define ICSPI_COR_ERR_S    28
+#define ICSPI_COR_ERR_V(x) ((x) << ICSPI_COR_ERR_S)
+#define ICSPI_COR_ERR_F    ICSPI_COR_ERR_V(1U)
+
+#define ICSPI_OVFL_S    24
+#define ICSPI_OVFL_V(x) ((x) << ICSPI_OVFL_S)
+#define ICSPI_OVFL_F    ICSPI_OVFL_V(1U)
+
+#define PCMD_LEN_OVFL3_S    23
+#define PCMD_LEN_OVFL3_V(x) ((x) << PCMD_LEN_OVFL3_S)
+#define PCMD_LEN_OVFL3_F    PCMD_LEN_OVFL3_V(1U)
+
+#define T7_PCMD_LEN_OVFL2_S    22
+#define T7_PCMD_LEN_OVFL2_V(x) ((x) << T7_PCMD_LEN_OVFL2_S)
+#define T7_PCMD_LEN_OVFL2_F    T7_PCMD_LEN_OVFL2_V(1U)
+
+#define T7_PCMD_LEN_OVFL1_S    21
+#define T7_PCMD_LEN_OVFL1_V(x) ((x) << T7_PCMD_LEN_OVFL1_S)
+#define T7_PCMD_LEN_OVFL1_F    T7_PCMD_LEN_OVFL1_V(1U)
+
+#define T7_PCMD_LEN_OVFL0_S    20
+#define T7_PCMD_LEN_OVFL0_V(x) ((x) << T7_PCMD_LEN_OVFL0_S)
+#define T7_PCMD_LEN_OVFL0_F    T7_PCMD_LEN_OVFL0_V(1U)
+
+#define PM_TX_PERR_ENABLE_A 0x10028
+#define PM_TX_PERR_CAUSE_A 0x10029
+
+#define OSPI_OVERFLOW3_TX_S    23
+#define OSPI_OVERFLOW3_TX_V(x) ((x) << OSPI_OVERFLOW3_TX_S)
+#define OSPI_OVERFLOW3_TX_F    OSPI_OVERFLOW3_TX_V(1U)
+
+#define OSPI_OVERFLOW2_TX_S    22
+#define OSPI_OVERFLOW2_TX_V(x) ((x) << OSPI_OVERFLOW2_TX_S)
+#define OSPI_OVERFLOW2_TX_F    OSPI_OVERFLOW2_TX_V(1U)
+
+#define OSPI_OVERFLOW1_TX_S    21
+#define OSPI_OVERFLOW1_TX_V(x) ((x) << OSPI_OVERFLOW1_TX_S)
+#define OSPI_OVERFLOW1_TX_F    OSPI_OVERFLOW1_TX_V(1U)
+
+#define OSPI_OVERFLOW0_TX_S    20
+#define OSPI_OVERFLOW0_TX_V(x) ((x) << OSPI_OVERFLOW0_TX_S)
+#define OSPI_OVERFLOW0_TX_F    OSPI_OVERFLOW0_TX_V(1U)
+
+#define T7_BUNDLE_LEN_OVFL_EN_S    18
+#define T7_BUNDLE_LEN_OVFL_EN_V(x) ((x) << T7_BUNDLE_LEN_OVFL_EN_S)
+#define T7_BUNDLE_LEN_OVFL_EN_F    T7_BUNDLE_LEN_OVFL_EN_V(1U)
+
+#define T7_M_INTFPERREN_S    17
+#define T7_M_INTFPERREN_V(x) ((x) << T7_M_INTFPERREN_S)
+#define T7_M_INTFPERREN_F    T7_M_INTFPERREN_V(1U)
+
+#define T7_1_SDC_ERR_S    16
+#define T7_1_SDC_ERR_V(x) ((x) << T7_1_SDC_ERR_S)
+#define T7_1_SDC_ERR_F    T7_1_SDC_ERR_V(1U)
+
+#define TOKEN_PAR_ERROR_S    5
+#define TOKEN_PAR_ERROR_V(x) ((x) << TOKEN_PAR_ERROR_S)
+#define TOKEN_PAR_ERROR_F    TOKEN_PAR_ERROR_V(1U)
+
+#define BUNDLE_LEN_PAR_ERROR_S    4
+#define BUNDLE_LEN_PAR_ERROR_V(x) ((x) << BUNDLE_LEN_PAR_ERROR_S)
+#define BUNDLE_LEN_PAR_ERROR_F    BUNDLE_LEN_PAR_ERROR_V(1U)
+
+#define C_PCMD_TOKEN_PAR_ERROR_S    0
+#define C_PCMD_TOKEN_PAR_ERROR_V(x) ((x) << C_PCMD_TOKEN_PAR_ERROR_S)
+#define C_PCMD_TOKEN_PAR_ERROR_F    C_PCMD_TOKEN_PAR_ERROR_V(1U)
+
+#define PM_RX_INT_ENABLE_A 0x8fd8
+#define PM_RX_INT_CAUSE_A	0x8fdc
+#define PM_RX_STAT_CONFIG_A 0x8fc8
+#define PM_RX_STAT_COUNT_A 0x8fcc
+#define PM_RX_STAT_LSB_A 0x8fd0
+#define PM_RX_DBG_CTRL_A 0x8fd0
+#define PM_RX_DBG_DATA_A 0x8fd4
+#define PM_RX_DBG_STAT_MSB_A 0x10013
+
+#define PMRX_FRAMING_ERROR_F	0x003ffff0U
+
+#define ZERO_E_CMD_ERROR_S    22
+#define ZERO_E_CMD_ERROR_V(x) ((x) << ZERO_E_CMD_ERROR_S)
+#define ZERO_E_CMD_ERROR_F    ZERO_E_CMD_ERROR_V(1U)
+
+#define OCSPI_PAR_ERROR_S    3
+#define OCSPI_PAR_ERROR_V(x) ((x) << OCSPI_PAR_ERROR_S)
+#define OCSPI_PAR_ERROR_F    OCSPI_PAR_ERROR_V(1U)
+
+#define DB_OPTIONS_PAR_ERROR_S    2
+#define DB_OPTIONS_PAR_ERROR_V(x) ((x) << DB_OPTIONS_PAR_ERROR_S)
+#define DB_OPTIONS_PAR_ERROR_F    DB_OPTIONS_PAR_ERROR_V(1U)
+
+#define IESPI_PAR_ERROR_S    1
+#define IESPI_PAR_ERROR_V(x) ((x) << IESPI_PAR_ERROR_S)
+#define IESPI_PAR_ERROR_F    IESPI_PAR_ERROR_V(1U)
+
+#define E_PCMD_PAR_ERROR_S    0
+#define E_PCMD_PAR_ERROR_V(x) ((x) << E_PCMD_PAR_ERROR_S)
+#define E_PCMD_PAR_ERROR_F    E_PCMD_PAR_ERROR_V(1U)
+
+#define MA_INTF_SDC_ERR_S    26
+#define MA_INTF_SDC_ERR_V(x) ((x) << MA_INTF_SDC_ERR_S)
+#define MA_INTF_SDC_ERR_F    MA_INTF_SDC_ERR_V(1U)
+
+#define BUNDLE_LEN_PARERR_S    25
+#define BUNDLE_LEN_PARERR_V(x) ((x) << BUNDLE_LEN_PARERR_S)
+#define BUNDLE_LEN_PARERR_F    BUNDLE_LEN_PARERR_V(1U)
+
+#define BUNDLE_LEN_OVFL_S    24
+#define BUNDLE_LEN_OVFL_V(x) ((x) << BUNDLE_LEN_OVFL_S)
+#define BUNDLE_LEN_OVFL_F    BUNDLE_LEN_OVFL_V(1U)
+
+#define SDC_ERR_S    23
+#define SDC_ERR_V(x) ((x) << SDC_ERR_S)
+#define SDC_ERR_F    SDC_ERR_V(1U)
+
+#define MASTER_PERR_S    31
+#define MASTER_PERR_V(x) ((x) << MASTER_PERR_S)
+#define MASTER_PERR_F    MASTER_PERR_V(1U)
+
+#define ULP_TX_LA_RDPTR_0_A 0x8ec0
+#define ULP_TX_LA_RDDATA_0_A 0x8ec4
+#define ULP_TX_LA_WRPTR_0_A 0x8ec8
+#define ULP_TX_ASIC_DEBUG_CTRL_A 0x8f70
+
+#define ULP_TX_ASIC_DEBUG_0_A 0x8f74
+#define ULP_TX_ASIC_DEBUG_1_A 0x8f78
+#define ULP_TX_ASIC_DEBUG_2_A 0x8f7c
+#define ULP_TX_ASIC_DEBUG_3_A 0x8f80
+#define ULP_TX_ASIC_DEBUG_4_A 0x8f84
+
+/* registers for module PM_RX */
+#define PM_RX_BASE_ADDR 0x8fc0
+
+#define PMRX_E_PCMD_PAR_ERROR_S    0
+#define PMRX_E_PCMD_PAR_ERROR_V(x) ((x) << PMRX_E_PCMD_PAR_ERROR_S)
+#define PMRX_E_PCMD_PAR_ERROR_F    PMRX_E_PCMD_PAR_ERROR_V(1U)
+
+#define PM_TX_STAT_CONFIG_A 0x8fe8
+#define PM_TX_STAT_COUNT_A 0x8fec
+#define PM_TX_STAT_LSB_A 0x8ff0
+#define PM_TX_DBG_CTRL_A 0x8ff0
+#define PM_TX_DBG_DATA_A 0x8ff4
+#define T7_PM_TX_DBG_STAT_MSB_A 0x10000
+#define PM_TX_DBG_STAT_MSB_A 0x1001a
+
+#define ZERO_C_CMD_ERROR_S    28
+#define ZERO_C_CMD_ERROR_V(x) ((x) << ZERO_C_CMD_ERROR_S)
+#define ZERO_C_CMD_ERROR_F    ZERO_C_CMD_ERROR_V(1U)
+
+#define  PMTX_FRAMING_ERROR_F 0x0ffffff0U
+
+#define PMTX_C_PCMD_PAR_ERROR_S    0
+#define PMTX_C_PCMD_PAR_ERROR_V(x) ((x) << PMTX_C_PCMD_PAR_ERROR_S)
+#define PMTX_C_PCMD_PAR_ERROR_F    PMTX_C_PCMD_PAR_ERROR_V(1U)
+
+#define MPS_PORT_STAT_TX_PORT_BYTES_L 0x400
+#define MPS_PORT_STAT_TX_PORT_BYTES_H 0x404
+#define MPS_PORT_STAT_TX_PORT_FRAMES_L 0x408
+#define MPS_PORT_STAT_TX_PORT_FRAMES_H 0x40c
+#define MPS_PORT_STAT_TX_PORT_BCAST_L 0x410
+#define MPS_PORT_STAT_TX_PORT_BCAST_H 0x414
+#define MPS_PORT_STAT_TX_PORT_MCAST_L 0x418
+#define MPS_PORT_STAT_TX_PORT_MCAST_H 0x41c
+#define MPS_PORT_STAT_TX_PORT_UCAST_L 0x420
+#define MPS_PORT_STAT_TX_PORT_UCAST_H 0x424
+#define MPS_PORT_STAT_TX_PORT_ERROR_L 0x428
+#define MPS_PORT_STAT_TX_PORT_ERROR_H 0x42c
+#define MPS_PORT_STAT_TX_PORT_64B_L 0x430
+#define MPS_PORT_STAT_TX_PORT_64B_H 0x434
+#define MPS_PORT_STAT_TX_PORT_65B_127B_L 0x438
+#define MPS_PORT_STAT_TX_PORT_65B_127B_H 0x43c
+#define MPS_PORT_STAT_TX_PORT_128B_255B_L 0x440
+#define MPS_PORT_STAT_TX_PORT_128B_255B_H 0x444
+#define MPS_PORT_STAT_TX_PORT_256B_511B_L 0x448
+#define MPS_PORT_STAT_TX_PORT_256B_511B_H 0x44c
+#define MPS_PORT_STAT_TX_PORT_512B_1023B_L 0x450
+#define MPS_PORT_STAT_TX_PORT_512B_1023B_H 0x454
+#define MPS_PORT_STAT_TX_PORT_1024B_1518B_L 0x458
+#define MPS_PORT_STAT_TX_PORT_1024B_1518B_H 0x45c
+#define MPS_PORT_STAT_TX_PORT_1519B_MAX_L 0x460
+#define MPS_PORT_STAT_TX_PORT_1519B_MAX_H 0x464
+#define MPS_PORT_STAT_TX_PORT_DROP_L 0x468
+#define MPS_PORT_STAT_TX_PORT_DROP_H 0x46c
+#define MPS_PORT_STAT_TX_PORT_PAUSE_L 0x470
+#define MPS_PORT_STAT_TX_PORT_PAUSE_H 0x474
+#define MPS_PORT_STAT_TX_PORT_PPP0_L 0x478
+#define MPS_PORT_STAT_TX_PORT_PPP0_H 0x47c
+#define MPS_PORT_STAT_TX_PORT_PPP1_L 0x480
+#define MPS_PORT_STAT_TX_PORT_PPP1_H 0x484
+#define MPS_PORT_STAT_TX_PORT_PPP2_L 0x488
+#define MPS_PORT_STAT_TX_PORT_PPP2_H 0x48c
+#define MPS_PORT_STAT_TX_PORT_PPP3_L 0x490
+#define MPS_PORT_STAT_TX_PORT_PPP3_H 0x494
+#define MPS_PORT_STAT_TX_PORT_PPP4_L 0x498
+#define MPS_PORT_STAT_TX_PORT_PPP4_H 0x49c
+#define MPS_PORT_STAT_TX_PORT_PPP5_L 0x4a0
+#define MPS_PORT_STAT_TX_PORT_PPP5_H 0x4a4
+#define MPS_PORT_STAT_TX_PORT_PPP6_L 0x4a8
+#define MPS_PORT_STAT_TX_PORT_PPP6_H 0x4ac
+#define MPS_PORT_STAT_TX_PORT_PPP7_L 0x4b0
+#define MPS_PORT_STAT_TX_PORT_PPP7_H 0x4b4
+#define MPS_PORT_STAT_LB_PORT_BYTES_L 0x4c0
+#define MPS_PORT_STAT_LB_PORT_BYTES_H 0x4c4
+#define MPS_PORT_STAT_LB_PORT_FRAMES_L 0x4c8
+#define MPS_PORT_STAT_LB_PORT_FRAMES_H 0x4cc
+#define MPS_PORT_STAT_LB_PORT_BCAST_L 0x4d0
+#define MPS_PORT_STAT_LB_PORT_BCAST_H 0x4d4
+#define MPS_PORT_STAT_LB_PORT_MCAST_L 0x4d8
+#define MPS_PORT_STAT_LB_PORT_MCAST_H 0x4dc
+#define MPS_PORT_STAT_LB_PORT_UCAST_L 0x4e0
+#define MPS_PORT_STAT_LB_PORT_UCAST_H 0x4e4
+#define MPS_PORT_STAT_LB_PORT_ERROR_L 0x4e8
+#define MPS_PORT_STAT_LB_PORT_ERROR_H 0x4ec
+#define MPS_PORT_STAT_LB_PORT_64B_L 0x4f0
+#define MPS_PORT_STAT_LB_PORT_64B_H 0x4f4
+#define MPS_PORT_STAT_LB_PORT_65B_127B_L 0x4f8
+#define MPS_PORT_STAT_LB_PORT_65B_127B_H 0x4fc
+#define MPS_PORT_STAT_LB_PORT_128B_255B_L 0x500
+#define MPS_PORT_STAT_LB_PORT_128B_255B_H 0x504
+#define MPS_PORT_STAT_LB_PORT_256B_511B_L 0x508
+#define MPS_PORT_STAT_LB_PORT_256B_511B_H 0x50c
+#define MPS_PORT_STAT_LB_PORT_512B_1023B_L 0x510
+#define MPS_PORT_STAT_LB_PORT_512B_1023B_H 0x514
+#define MPS_PORT_STAT_LB_PORT_1024B_1518B_L 0x518
+#define MPS_PORT_STAT_LB_PORT_1024B_1518B_H 0x51c
+#define MPS_PORT_STAT_LB_PORT_1519B_MAX_L 0x520
+#define MPS_PORT_STAT_LB_PORT_1519B_MAX_H 0x524
+#define MPS_PORT_STAT_LB_PORT_DROP_FRAMES 0x528
+#define MPS_PORT_STAT_LB_PORT_DROP_FRAMES_L 0x528
+#define MPS_PORT_STAT_RX_PORT_BYTES_L 0x540
+#define MPS_PORT_STAT_RX_PORT_BYTES_H 0x544
+#define MPS_PORT_STAT_RX_PORT_FRAMES_L 0x548
+#define MPS_PORT_STAT_RX_PORT_FRAMES_H 0x54c
+#define MPS_PORT_STAT_RX_PORT_BCAST_L 0x550
+#define MPS_PORT_STAT_RX_PORT_BCAST_H 0x554
+#define MPS_PORT_STAT_RX_PORT_MCAST_L 0x558
+#define MPS_PORT_STAT_RX_PORT_MCAST_H 0x55c
+#define MPS_PORT_STAT_RX_PORT_UCAST_L 0x560
+#define MPS_PORT_STAT_RX_PORT_UCAST_H 0x564
+#define MPS_PORT_STAT_RX_PORT_MTU_ERROR_L 0x568
+#define MPS_PORT_STAT_RX_PORT_MTU_ERROR_H 0x56c
+#define MPS_PORT_STAT_RX_PORT_MTU_CRC_ERROR_L 0x570
+#define MPS_PORT_STAT_RX_PORT_MTU_CRC_ERROR_H 0x574
+#define MPS_PORT_STAT_RX_PORT_CRC_ERROR_L 0x578
+#define MPS_PORT_STAT_RX_PORT_CRC_ERROR_H 0x57c
+#define MPS_PORT_STAT_RX_PORT_LEN_ERROR_L 0x580
+#define MPS_PORT_STAT_RX_PORT_LEN_ERROR_H 0x584
+#define MPS_PORT_STAT_RX_PORT_SYM_ERROR_L 0x588
+#define MPS_PORT_STAT_RX_PORT_SYM_ERROR_H 0x58c
+#define MPS_PORT_STAT_RX_PORT_64B_L 0x590
+#define MPS_PORT_STAT_RX_PORT_64B_H 0x594
+#define MPS_PORT_STAT_RX_PORT_65B_127B_L 0x598
+#define MPS_PORT_STAT_RX_PORT_65B_127B_H 0x59c
+#define MPS_PORT_STAT_RX_PORT_128B_255B_L 0x5a0
+#define MPS_PORT_STAT_RX_PORT_128B_255B_H 0x5a4
+#define MPS_PORT_STAT_RX_PORT_256B_511B_L 0x5a8
+#define MPS_PORT_STAT_RX_PORT_256B_511B_H 0x5ac
+#define MPS_PORT_STAT_RX_PORT_512B_1023B_L 0x5b0
+#define MPS_PORT_STAT_RX_PORT_512B_1023B_H 0x5b4
+#define MPS_PORT_STAT_RX_PORT_1024B_1518B_L 0x5b8
+#define MPS_PORT_STAT_RX_PORT_1024B_1518B_H 0x5bc
+#define MPS_PORT_STAT_RX_PORT_1519B_MAX_L 0x5c0
+#define MPS_PORT_STAT_RX_PORT_1519B_MAX_H 0x5c4
+#define MPS_PORT_STAT_RX_PORT_PAUSE_L 0x5c8
+#define MPS_PORT_STAT_RX_PORT_PAUSE_H 0x5cc
+#define MPS_PORT_STAT_RX_PORT_PPP0_L 0x5d0
+#define MPS_PORT_STAT_RX_PORT_PPP0_H 0x5d4
+#define MPS_PORT_STAT_RX_PORT_PPP1_L 0x5d8
+#define MPS_PORT_STAT_RX_PORT_PPP1_H 0x5dc
+#define MPS_PORT_STAT_RX_PORT_PPP2_L 0x5e0
+#define MPS_PORT_STAT_RX_PORT_PPP2_H 0x5e4
+#define MPS_PORT_STAT_RX_PORT_PPP3_L 0x5e8
+#define MPS_PORT_STAT_RX_PORT_PPP3_H 0x5ec
+#define MPS_PORT_STAT_RX_PORT_PPP4_L 0x5f0
+#define MPS_PORT_STAT_RX_PORT_PPP4_H 0x5f4
+#define MPS_PORT_STAT_RX_PORT_PPP5_L 0x5f8
+#define MPS_PORT_STAT_RX_PORT_PPP5_H 0x5fc
+#define MPS_PORT_STAT_RX_PORT_PPP6_L 0x600
+#define MPS_PORT_STAT_RX_PORT_PPP6_H 0x604
+#define MPS_PORT_STAT_RX_PORT_PPP7_L 0x608
+#define MPS_PORT_STAT_RX_PORT_PPP7_H 0x60c
+#define MPS_PORT_STAT_RX_PORT_LESS_64B_L 0x610
+#define MPS_PORT_STAT_RX_PORT_LESS_64B_H 0x614
+#define MAC_PORT_MAGIC_MACID_LO 0x824
+#define MAC_PORT_MAGIC_MACID_HI 0x828
+#define T7_MAC_PORT_TX_TS_VAL_LO 0x88c
+#define MAC_PORT_TX_TS_VAL_LO   0x928
+#define MAC_PORT_TX_TS_VAL_HI   0x92c
+
+#define MAC_PORT_EPIO_DATA0_A 0x8c0
+#define MAC_PORT_EPIO_DATA1_A 0x8c4
+#define MAC_PORT_EPIO_DATA2_A 0x8c8
+#define MAC_PORT_EPIO_DATA3_A 0x8cc
+#define MAC_PORT_EPIO_OP_A 0x8d0
+
+#define MAC_PORT_CFG2_A 0x818
+
+#define MAC_PORT_PTP_SUM_LO_A 0x990
+#define MAC_PORT_PTP_SUM_HI_A 0x994
+
+#define MAC_INT_EN_CMN_A 0x380c8
+#define MAC_INT_CAUSE_CMN_A 0x380cc
+
+#define FLOCK_ASSERTED_S    5
+#define FLOCK_ASSERTED_V(x) ((x) << FLOCK_ASSERTED_S)
+#define FLOCK_ASSERTED_F    FLOCK_ASSERTED_V(1U)
+
+#define FLOCK_LOST_S    4
+#define FLOCK_LOST_V(x) ((x) << FLOCK_LOST_S)
+#define FLOCK_LOST_F    FLOCK_LOST_V(1U)
+
+#define PHASE_LOCK_ASSERTED_S    3
+#define PHASE_LOCK_ASSERTED_V(x) ((x) << PHASE_LOCK_ASSERTED_S)
+#define PHASE_LOCK_ASSERTED_F    PHASE_LOCK_ASSERTED_V(1U)
+
+#define PHASE_LOCK_LOST_S    2
+#define PHASE_LOCK_LOST_V(x) ((x) << PHASE_LOCK_LOST_S)
+#define PHASE_LOCK_LOST_F    PHASE_LOCK_LOST_V(1U)
+
+#define LOCK_ASSERTED_S    1
+#define LOCK_ASSERTED_V(x) ((x) << LOCK_ASSERTED_S)
+#define LOCK_ASSERTED_F    LOCK_ASSERTED_V(1U)
+
+#define LOCK_LOST_S    0
+#define LOCK_LOST_V(x) ((x) << LOCK_LOST_S)
+#define LOCK_LOST_F    LOCK_LOST_V(1U)
+
+#define MPS_CMN_CTL_A	0x9000
+
+#define COUNTPAUSEMCRX_S    5
+#define COUNTPAUSEMCRX_V(x) ((x) << COUNTPAUSEMCRX_S)
+#define COUNTPAUSEMCRX_F    COUNTPAUSEMCRX_V(1U)
+
+#define COUNTPAUSESTATRX_S    4
+#define COUNTPAUSESTATRX_V(x) ((x) << COUNTPAUSESTATRX_S)
+#define COUNTPAUSESTATRX_F    COUNTPAUSESTATRX_V(1U)
+
+#define COUNTPAUSEMCTX_S    3
+#define COUNTPAUSEMCTX_V(x) ((x) << COUNTPAUSEMCTX_S)
+#define COUNTPAUSEMCTX_F    COUNTPAUSEMCTX_V(1U)
+
+#define COUNTPAUSESTATTX_S    2
+#define COUNTPAUSESTATTX_V(x) ((x) << COUNTPAUSESTATTX_S)
 #define COUNTPAUSESTATTX_F    COUNTPAUSESTATTX_V(1U)
 
-#define NUMPORTS_S    0
-#define NUMPORTS_M    0x3U
-#define NUMPORTS_G(x) (((x) >> NUMPORTS_S) & NUMPORTS_M)
+#define NUMPORTS_S    0
+#define NUMPORTS_M    0x3U
+#define NUMPORTS_G(x) (((x) >> NUMPORTS_S) & NUMPORTS_M)
+
+#define MPS_INT_CAUSE_A 0x9008
+#define MPS_TX_INT_ENABLE_A 0x9404
+#define MPS_TX_INT_CAUSE_A 0x9408
+#define MPS_TX_INT2_ENABLE_A 0x9498
+#define MPS_TX_INT2_CAUSE_A 0x949c
+#define MPS_TX_INT3_ENABLE_A 0x94a4
+#define MPS_TX_INT3_CAUSE_A 0x94a8
+#define MPS_TX_INT4_ENABLE_A 0x94b0
+#define MPS_TX_INT4_CAUSE_A 0x94b4
+
+#define RX_FINAL_TF_FIFO_PERR_S    19
+#define RX_FINAL_TF_FIFO_PERR_V(x) ((x) << RX_FINAL_TF_FIFO_PERR_S)
+#define RX_FINAL_TF_FIFO_PERR_F    RX_FINAL_TF_FIFO_PERR_V(1U)
+
+#define MPS_STAT_CTL_A 0x9600
+
+#define PORTERR_S    16
+#define PORTERR_V(x) ((x) << PORTERR_S)
+#define PORTERR_F    PORTERR_V(1U)
+
+#define FRMERR_S    15
+#define FRMERR_V(x) ((x) << FRMERR_S)
+#define FRMERR_F    FRMERR_V(1U)
+
+#define SECNTERR_S    14
+#define SECNTERR_V(x) ((x) << SECNTERR_S)
+#define SECNTERR_F    SECNTERR_V(1U)
+
+#define BUBBLE_S    13
+#define BUBBLE_V(x) ((x) << BUBBLE_S)
+#define BUBBLE_F    BUBBLE_V(1U)
+
+#define TXDESCFIFO_S    9
+#define TXDESCFIFO_M    0xfU
+#define TXDESCFIFO_V(x) ((x) << TXDESCFIFO_S)
+
+#define TXDATAFIFO_S    5
+#define TXDATAFIFO_M    0xfU
+#define TXDATAFIFO_V(x) ((x) << TXDATAFIFO_S)
+
+#define NCSIFIFO_S    4
+#define NCSIFIFO_V(x) ((x) << NCSIFIFO_S)
+#define NCSIFIFO_F    NCSIFIFO_V(1U)
+
+#define TPFIFO_S    0
+#define TPFIFO_M    0xfU
+#define TPFIFO_V(x) ((x) << TPFIFO_S)
+
+#define T7_PORTERR_S    28
+#define T7_PORTERR_V(x) ((x) << T7_PORTERR_S)
+#define T7_PORTERR_F    T7_PORTERR_V(1U)
+
+#define T7_FRMERR_S    27
+#define T7_FRMERR_V(x) ((x) << T7_FRMERR_S)
+#define T7_FRMERR_F    T7_FRMERR_V(1U)
+
+#define T7_SECNTERR_S    26
+#define T7_SECNTERR_V(x) ((x) << T7_SECNTERR_S)
+#define T7_SECNTERR_F    T7_SECNTERR_V(1U)
+
+#define T7_BUBBLE_S    25
+#define T7_BUBBLE_V(x) ((x) << T7_BUBBLE_S)
+#define T7_BUBBLE_F    T7_BUBBLE_V(1U)
+
+#define TX_TF_FIFO_PERR_S    19
+#define TX_TF_FIFO_PERR_V(x) ((x) << TX_TF_FIFO_PERR_S)
+#define TX_TF_FIFO_PERR_F    TX_TF_FIFO_PERR_V(1U)
+
+#define TX_FIFO_PERR_S    18
+#define TX_FIFO_PERR_V(x) ((x) << TX_FIFO_PERR_S)
+#define TX_FIFO_PERR_F    TX_FIFO_PERR_V(1U)
+
+#define NCSI2MPS_S    5
+#define NCSI2MPS_V(x) ((x) << NCSI2MPS_S)
+#define NCSI2MPS_F    NCSI2MPS_V(1U)
+
+#define MPS_STAT_INT_ENABLE_A 0x9608
+#define MPS_STAT_INT_CAUSE_A 0x960c
+
+#define PLREADSYNCERR_S    0
+#define PLREADSYNCERR_V(x) ((x) << PLREADSYNCERR_S)
+#define PLREADSYNCERR_F    PLREADSYNCERR_V(1U)
+
+#define MPS_STAT_PERR_INT_ENABLE_SRAM_A 0x9610
+#define MPS_STAT_PERR_INT_CAUSE_SRAM_A		0x9614
+
+#define MPS_STAT_PERR_INT_ENABLE_TX_FIFO_A 0x961c
+#define MPS_STAT_PERR_INT_CAUSE_TX_FIFO_A	0x9620
+#define MPS_STAT_PERR_INT_ENABLE_RX_FIFO_A 0x9628
+#define MPS_STAT_PERR_INT_CAUSE_RX_FIFO_A	0x962c
+
+#define MPS_STAT_RX_BG_0_MAC_DROP_FRAME_L 0x9640
+#define MPS_STAT_RX_BG_0_MAC_DROP_FRAME_H 0x9644
+#define MPS_STAT_RX_BG_1_MAC_DROP_FRAME_L 0x9648
+#define MPS_STAT_RX_BG_1_MAC_DROP_FRAME_H 0x964c
+#define MPS_STAT_RX_BG_2_MAC_DROP_FRAME_L 0x9650
+#define MPS_STAT_RX_BG_2_MAC_DROP_FRAME_H 0x9654
+#define MPS_STAT_RX_BG_3_MAC_DROP_FRAME_L 0x9658
+#define MPS_STAT_RX_BG_3_MAC_DROP_FRAME_H 0x965c
+#define MPS_STAT_RX_BG_0_LB_DROP_FRAME_L 0x9660
+#define MPS_STAT_RX_BG_0_LB_DROP_FRAME_H 0x9664
+#define MPS_STAT_RX_BG_1_LB_DROP_FRAME_L 0x9668
+#define MPS_STAT_RX_BG_1_LB_DROP_FRAME_H 0x966c
+#define MPS_STAT_RX_BG_2_LB_DROP_FRAME_L 0x9670
+#define MPS_STAT_RX_BG_2_LB_DROP_FRAME_H 0x9674
+#define MPS_STAT_RX_BG_3_LB_DROP_FRAME_L 0x9678
+#define MPS_STAT_RX_BG_3_LB_DROP_FRAME_H 0x967c
+#define MPS_STAT_RX_BG_0_MAC_TRUNC_FRAME_L 0x9680
+#define MPS_STAT_RX_BG_0_MAC_TRUNC_FRAME_H 0x9684
+#define MPS_STAT_RX_BG_1_MAC_TRUNC_FRAME_L 0x9688
+#define MPS_STAT_RX_BG_1_MAC_TRUNC_FRAME_H 0x968c
+#define MPS_STAT_RX_BG_2_MAC_TRUNC_FRAME_L 0x9690
+#define MPS_STAT_RX_BG_2_MAC_TRUNC_FRAME_H 0x9694
+#define MPS_STAT_RX_BG_3_MAC_TRUNC_FRAME_L 0x9698
+#define MPS_STAT_RX_BG_3_MAC_TRUNC_FRAME_H 0x969c
+#define MPS_STAT_RX_BG_0_LB_TRUNC_FRAME_L 0x96a0
+#define MPS_STAT_RX_BG_0_LB_TRUNC_FRAME_H 0x96a4
+#define MPS_STAT_RX_BG_1_LB_TRUNC_FRAME_L 0x96a8
+#define MPS_STAT_RX_BG_1_LB_TRUNC_FRAME_H 0x96ac
+#define MPS_STAT_RX_BG_2_LB_TRUNC_FRAME_L 0x96b0
+#define MPS_STAT_RX_BG_2_LB_TRUNC_FRAME_H 0x96b4
+#define MPS_STAT_RX_BG_3_LB_TRUNC_FRAME_L 0x96b8
+#define MPS_STAT_RX_BG_3_LB_TRUNC_FRAME_H 0x96bc
+#define MPS_STAT_PERR_INT_ENABLE_SRAM1_A 0x96c0
+#define MPS_STAT_PERR_INT_CAUSE_SRAM1_A 0x96c4
+
+#define MPS_TRC_CFG_A 0x9800
+
+#define TRCFIFOEMPTY_S    4
+#define TRCFIFOEMPTY_V(x) ((x) << TRCFIFOEMPTY_S)
+#define TRCFIFOEMPTY_F    TRCFIFOEMPTY_V(1U)
+
+#define TRCIGNOREDROPINPUT_S    3
+#define TRCIGNOREDROPINPUT_V(x) ((x) << TRCIGNOREDROPINPUT_S)
+#define TRCIGNOREDROPINPUT_F    TRCIGNOREDROPINPUT_V(1U)
+
+#define TRCKEEPDUPLICATES_S    2
+#define TRCKEEPDUPLICATES_V(x) ((x) << TRCKEEPDUPLICATES_S)
+#define TRCKEEPDUPLICATES_F    TRCKEEPDUPLICATES_V(1U)
+
+#define TRCEN_S    1
+#define TRCEN_V(x) ((x) << TRCEN_S)
+#define TRCEN_F    TRCEN_V(1U)
+
+#define TRCMULTIFILTER_S    0
+#define TRCMULTIFILTER_V(x) ((x) << TRCMULTIFILTER_S)
+#define TRCMULTIFILTER_F    TRCMULTIFILTER_V(1U)
+
+#define MPS_TRC_RSS_CONTROL_A		0x9808
+#define MPS_TRC_FILTER1_RSS_CONTROL_A	0x9ff4
+#define MPS_TRC_FILTER2_RSS_CONTROL_A	0x9ffc
+#define MPS_TRC_FILTER3_RSS_CONTROL_A	0xa004
+#define MPS_T5_TRC_RSS_CONTROL_A	0xa00c
+
+#define RSSCONTROL_S    16
+#define RSSCONTROL_V(x) ((x) << RSSCONTROL_S)
+
+#define QUEUENUMBER_S    0
+#define QUEUENUMBER_V(x) ((x) << QUEUENUMBER_S)
+
+#define TFINVERTMATCH_S    24
+#define TFINVERTMATCH_V(x) ((x) << TFINVERTMATCH_S)
+#define TFINVERTMATCH_F    TFINVERTMATCH_V(1U)
+
+#define TFEN_S    22
+#define TFEN_V(x) ((x) << TFEN_S)
+#define TFEN_F    TFEN_V(1U)
+
+#define TFPORT_S    18
+#define TFPORT_M    0xfU
+#define TFPORT_V(x) ((x) << TFPORT_S)
+#define TFPORT_G(x) (((x) >> TFPORT_S) & TFPORT_M)
+
+#define TFLENGTH_S    8
+#define TFLENGTH_M    0x1fU
+#define TFLENGTH_V(x) ((x) << TFLENGTH_S)
+#define TFLENGTH_G(x) (((x) >> TFLENGTH_S) & TFLENGTH_M)
+
+#define TFOFFSET_S    0
+#define TFOFFSET_M    0x1fU
+#define TFOFFSET_V(x) ((x) << TFOFFSET_S)
+#define TFOFFSET_G(x) (((x) >> TFOFFSET_S) & TFOFFSET_M)
+
+#define T5_TFINVERTMATCH_S    25
+#define T5_TFINVERTMATCH_V(x) ((x) << T5_TFINVERTMATCH_S)
+#define T5_TFINVERTMATCH_F    T5_TFINVERTMATCH_V(1U)
+
+#define T5_TFEN_S    23
+#define T5_TFEN_V(x) ((x) << T5_TFEN_S)
+#define T5_TFEN_F    T5_TFEN_V(1U)
+
+#define T5_TFPORT_S    18
+#define T5_TFPORT_M    0x1fU
+#define T5_TFPORT_V(x) ((x) << T5_TFPORT_S)
+#define T5_TFPORT_G(x) (((x) >> T5_TFPORT_S) & T5_TFPORT_M)
+
+#define MPS_TRC_FILTER_MATCH_CTL_A_A 0x9810
+#define MPS_TRC_FILTER_MATCH_CTL_B_A 0x9820
+#define T7_MPS_TRC_FILTER_MATCH_CTL_A_A 0xa460
+#define T7_MPS_TRC_FILTER_MATCH_CTL_B_A 0xa480
+#define T7_MPS_T5_TRC_RSS_CONTROL_A 0xa434
+
+#define TFMINPKTSIZE_S    16
+#define TFMINPKTSIZE_M    0x1ffU
+#define TFMINPKTSIZE_V(x) ((x) << TFMINPKTSIZE_S)
+#define TFMINPKTSIZE_G(x) (((x) >> TFMINPKTSIZE_S) & TFMINPKTSIZE_M)
+
+#define TFCAPTUREMAX_S    0
+#define TFCAPTUREMAX_M    0x3fffU
+#define TFCAPTUREMAX_V(x) ((x) << TFCAPTUREMAX_S)
+#define TFCAPTUREMAX_G(x) (((x) >> TFCAPTUREMAX_S) & TFCAPTUREMAX_M)
+
+#define MPS_TRC_FILTER0_MATCH_A 0x9c00
+#define MPS_TRC_FILTER0_DONT_CARE_A 0x9c80
+#define MPS_TRC_FILTER1_MATCH_A 0x9d00
+
+#define TP_RSS_CONFIG_A 0x7df0
+
+#define TNL4TUPENIPV6_S    31
+#define TNL4TUPENIPV6_V(x) ((x) << TNL4TUPENIPV6_S)
+#define TNL4TUPENIPV6_F    TNL4TUPENIPV6_V(1U)
+
+#define TNL2TUPENIPV6_S    30
+#define TNL2TUPENIPV6_V(x) ((x) << TNL2TUPENIPV6_S)
+#define TNL2TUPENIPV6_F    TNL2TUPENIPV6_V(1U)
+
+#define TNL4TUPENIPV4_S    29
+#define TNL4TUPENIPV4_V(x) ((x) << TNL4TUPENIPV4_S)
+#define TNL4TUPENIPV4_F    TNL4TUPENIPV4_V(1U)
+
+#define TNL2TUPENIPV4_S    28
+#define TNL2TUPENIPV4_V(x) ((x) << TNL2TUPENIPV4_S)
+#define TNL2TUPENIPV4_F    TNL2TUPENIPV4_V(1U)
+
+#define TNLTCPSEL_S    27
+#define TNLTCPSEL_V(x) ((x) << TNLTCPSEL_S)
+#define TNLTCPSEL_F    TNLTCPSEL_V(1U)
+
+#define TNLIP6SEL_S    26
+#define TNLIP6SEL_V(x) ((x) << TNLIP6SEL_S)
+#define TNLIP6SEL_F    TNLIP6SEL_V(1U)
+
+#define TNLVRTSEL_S    25
+#define TNLVRTSEL_V(x) ((x) << TNLVRTSEL_S)
+#define TNLVRTSEL_F    TNLVRTSEL_V(1U)
+
+#define TNLMAPEN_S    24
+#define TNLMAPEN_V(x) ((x) << TNLMAPEN_S)
+#define TNLMAPEN_F    TNLMAPEN_V(1U)
+
+#define OFDHASHSAVE_S    19
+#define OFDHASHSAVE_V(x) ((x) << OFDHASHSAVE_S)
+#define OFDHASHSAVE_F    OFDHASHSAVE_V(1U)
+
+#define OFDVRTSEL_S    18
+#define OFDVRTSEL_V(x) ((x) << OFDVRTSEL_S)
+#define OFDVRTSEL_F    OFDVRTSEL_V(1U)
+
+#define OFDMAPEN_S    17
+#define OFDMAPEN_V(x) ((x) << OFDMAPEN_S)
+#define OFDMAPEN_F    OFDMAPEN_V(1U)
+
+#define OFDLKPEN_S    16
+#define OFDLKPEN_V(x) ((x) << OFDLKPEN_S)
+#define OFDLKPEN_F    OFDLKPEN_V(1U)
+
+#define SYN4TUPENIPV6_S    15
+#define SYN4TUPENIPV6_V(x) ((x) << SYN4TUPENIPV6_S)
+#define SYN4TUPENIPV6_F    SYN4TUPENIPV6_V(1U)
+
+#define SYN2TUPENIPV6_S    14
+#define SYN2TUPENIPV6_V(x) ((x) << SYN2TUPENIPV6_S)
+#define SYN2TUPENIPV6_F    SYN2TUPENIPV6_V(1U)
+
+#define SYN4TUPENIPV4_S    13
+#define SYN4TUPENIPV4_V(x) ((x) << SYN4TUPENIPV4_S)
+#define SYN4TUPENIPV4_F    SYN4TUPENIPV4_V(1U)
+
+#define SYN2TUPENIPV4_S    12
+#define SYN2TUPENIPV4_V(x) ((x) << SYN2TUPENIPV4_S)
+#define SYN2TUPENIPV4_F    SYN2TUPENIPV4_V(1U)
+
+#define SYNIP6SEL_S    11
+#define SYNIP6SEL_V(x) ((x) << SYNIP6SEL_S)
+#define SYNIP6SEL_F    SYNIP6SEL_V(1U)
+
+#define SYNVRTSEL_S    10
+#define SYNVRTSEL_V(x) ((x) << SYNVRTSEL_S)
+#define SYNVRTSEL_F    SYNVRTSEL_V(1U)
+
+#define SYNMAPEN_S    9
+#define SYNMAPEN_V(x) ((x) << SYNMAPEN_S)
+#define SYNMAPEN_F    SYNMAPEN_V(1U)
+
+#define SYNLKPEN_S    8
+#define SYNLKPEN_V(x) ((x) << SYNLKPEN_S)
+#define SYNLKPEN_F    SYNLKPEN_V(1U)
+
+#define CHANNELENABLE_S    7
+#define CHANNELENABLE_V(x) ((x) << CHANNELENABLE_S)
+#define CHANNELENABLE_F    CHANNELENABLE_V(1U)
+
+#define PORTENABLE_S    6
+#define PORTENABLE_V(x) ((x) << PORTENABLE_S)
+#define PORTENABLE_F    PORTENABLE_V(1U)
+
+#define TNLALLLOOKUP_S    5
+#define TNLALLLOOKUP_V(x) ((x) << TNLALLLOOKUP_S)
+#define TNLALLLOOKUP_F    TNLALLLOOKUP_V(1U)
+
+#define VIRTENABLE_S    4
+#define VIRTENABLE_V(x) ((x) << VIRTENABLE_S)
+#define VIRTENABLE_F    VIRTENABLE_V(1U)
+
+#define CONGESTIONENABLE_S    3
+#define CONGESTIONENABLE_V(x) ((x) << CONGESTIONENABLE_S)
+#define CONGESTIONENABLE_F    CONGESTIONENABLE_V(1U)
+
+#define HASHTOEPLITZ_S    2
+#define HASHTOEPLITZ_V(x) ((x) << HASHTOEPLITZ_S)
+#define HASHTOEPLITZ_F    HASHTOEPLITZ_V(1U)
+
+#define UDPENABLE_S    1
+#define UDPENABLE_V(x) ((x) << UDPENABLE_S)
+#define UDPENABLE_F    UDPENABLE_V(1U)
+
+#define DISABLE_S    0
+#define DISABLE_V(x) ((x) << DISABLE_S)
+#define DISABLE_F    DISABLE_V(1U)
+
+#define TP_RSS_CONFIG_TNL_A 0x7df4
+
+#define MASKSIZE_S    28
+#define MASKSIZE_M    0xfU
+#define MASKSIZE_V(x) ((x) << MASKSIZE_S)
+#define MASKSIZE_G(x) (((x) >> MASKSIZE_S) & MASKSIZE_M)
+
+#define MASKFILTER_S    16
+#define MASKFILTER_M    0x7ffU
+#define MASKFILTER_V(x) ((x) << MASKFILTER_S)
+#define MASKFILTER_G(x) (((x) >> MASKFILTER_S) & MASKFILTER_M)
+
+#define USEWIRECH_S    0
+#define USEWIRECH_V(x) ((x) << USEWIRECH_S)
+#define USEWIRECH_F    USEWIRECH_V(1U)
+
+#define HASHALL_S    2
+#define HASHALL_V(x) ((x) << HASHALL_S)
+#define HASHALL_F    HASHALL_V(1U)
+
+#define HASHETH_S    1
+#define HASHETH_V(x) ((x) << HASHETH_S)
+#define HASHETH_F    HASHETH_V(1U)
+
+#define TP_RSS_CONFIG_OFD_A 0x7df8
+
+#define RRCPLMAPEN_S    20
+#define RRCPLMAPEN_V(x) ((x) << RRCPLMAPEN_S)
+#define RRCPLMAPEN_F    RRCPLMAPEN_V(1U)
+
+#define RRCPLQUEWIDTH_S    16
+#define RRCPLQUEWIDTH_M    0xfU
+#define RRCPLQUEWIDTH_V(x) ((x) << RRCPLQUEWIDTH_S)
+#define RRCPLQUEWIDTH_G(x) (((x) >> RRCPLQUEWIDTH_S) & RRCPLQUEWIDTH_M)
+
+#define TP_RSS_CONFIG_SYN_A 0x7dfc
+#define TP_RSS_CONFIG_VRT_A 0x7e00
+
+#define VFRDRG_S    25
+#define VFRDRG_V(x) ((x) << VFRDRG_S)
+#define VFRDRG_F    VFRDRG_V(1U)
+
+#define VFRDEN_S    24
+#define VFRDEN_V(x) ((x) << VFRDEN_S)
+#define VFRDEN_F    VFRDEN_V(1U)
+
+#define VFPERREN_S    23
+#define VFPERREN_V(x) ((x) << VFPERREN_S)
+#define VFPERREN_F    VFPERREN_V(1U)
+
+#define KEYPERREN_S    22
+#define KEYPERREN_V(x) ((x) << KEYPERREN_S)
+#define KEYPERREN_F    KEYPERREN_V(1U)
+
+#define DISABLEVLAN_S    21
+#define DISABLEVLAN_V(x) ((x) << DISABLEVLAN_S)
+#define DISABLEVLAN_F    DISABLEVLAN_V(1U)
+
+#define ENABLEUP0_S    20
+#define ENABLEUP0_V(x) ((x) << ENABLEUP0_S)
+#define ENABLEUP0_F    ENABLEUP0_V(1U)
+
+#define HASHDELAY_S    16
+#define HASHDELAY_M    0xfU
+#define HASHDELAY_V(x) ((x) << HASHDELAY_S)
+#define HASHDELAY_G(x) (((x) >> HASHDELAY_S) & HASHDELAY_M)
+
+#define VFWRADDR_S    8
+#define VFWRADDR_M    0x7fU
+#define VFWRADDR_V(x) ((x) << VFWRADDR_S)
+#define VFWRADDR_G(x) (((x) >> VFWRADDR_S) & VFWRADDR_M)
+
+#define KEYMODE_S    6
+#define KEYMODE_M    0x3U
+#define KEYMODE_V(x) ((x) << KEYMODE_S)
+#define KEYMODE_G(x) (((x) >> KEYMODE_S) & KEYMODE_M)
+
+#define VFWREN_S    5
+#define VFWREN_V(x) ((x) << VFWREN_S)
+#define VFWREN_F    VFWREN_V(1U)
+
+#define KEYWREN_S    4
+#define KEYWREN_V(x) ((x) << KEYWREN_S)
+#define KEYWREN_F    KEYWREN_V(1U)
+
+#define KEYWRADDR_S    0
+#define KEYWRADDR_M    0xfU
+#define KEYWRADDR_V(x) ((x) << KEYWRADDR_S)
+#define KEYWRADDR_G(x) (((x) >> KEYWRADDR_S) & KEYWRADDR_M)
+
+#define KEYWRADDRX_S    30
+#define KEYWRADDRX_M    0x3U
+#define KEYWRADDRX_V(x) ((x) << KEYWRADDRX_S)
+#define KEYWRADDRX_G(x) (((x) >> KEYWRADDRX_S) & KEYWRADDRX_M)
+
+#define KEYEXTEND_S    26
+#define KEYEXTEND_V(x) ((x) << KEYEXTEND_S)
+#define KEYEXTEND_F    KEYEXTEND_V(1U)
+
+#define LKPIDXSIZE_S    24
+#define LKPIDXSIZE_M    0x3U
+#define LKPIDXSIZE_V(x) ((x) << LKPIDXSIZE_S)
+#define LKPIDXSIZE_G(x) (((x) >> LKPIDXSIZE_S) & LKPIDXSIZE_M)
+
+#define TP_RSS_VFL_CONFIG_A 0x3a
+#define TP_RSS_VFH_CONFIG_A 0x3b
+
+#define ENABLEUDPHASH_S    31
+#define ENABLEUDPHASH_V(x) ((x) << ENABLEUDPHASH_S)
+#define ENABLEUDPHASH_F    ENABLEUDPHASH_V(1U)
+
+#define VFUPEN_S    30
+#define VFUPEN_V(x) ((x) << VFUPEN_S)
+#define VFUPEN_F    VFUPEN_V(1U)
+
+#define VFVLNEX_S    28
+#define VFVLNEX_V(x) ((x) << VFVLNEX_S)
+#define VFVLNEX_F    VFVLNEX_V(1U)
+
+#define VFPRTEN_S    27
+#define VFPRTEN_V(x) ((x) << VFPRTEN_S)
+#define VFPRTEN_F    VFPRTEN_V(1U)
+
+#define VFCHNEN_S    26
+#define VFCHNEN_V(x) ((x) << VFCHNEN_S)
+#define VFCHNEN_F    VFCHNEN_V(1U)
+
+#define DEFAULTQUEUE_S    16
+#define DEFAULTQUEUE_M    0x3ffU
+#define DEFAULTQUEUE_G(x) (((x) >> DEFAULTQUEUE_S) & DEFAULTQUEUE_M)
+
+#define VFIP6TWOTUPEN_S    6
+#define VFIP6TWOTUPEN_V(x) ((x) << VFIP6TWOTUPEN_S)
+#define VFIP6TWOTUPEN_F    VFIP6TWOTUPEN_V(1U)
+
+#define VFIP4FOURTUPEN_S    5
+#define VFIP4FOURTUPEN_V(x) ((x) << VFIP4FOURTUPEN_S)
+#define VFIP4FOURTUPEN_F    VFIP4FOURTUPEN_V(1U)
+
+#define VFIP4TWOTUPEN_S    4
+#define VFIP4TWOTUPEN_V(x) ((x) << VFIP4TWOTUPEN_S)
+#define VFIP4TWOTUPEN_F    VFIP4TWOTUPEN_V(1U)
+
+#define KEYINDEX_S    0
+#define KEYINDEX_M    0xfU
+#define KEYINDEX_G(x) (((x) >> KEYINDEX_S) & KEYINDEX_M)
+
+#define MAPENABLE_S    31
+#define MAPENABLE_V(x) ((x) << MAPENABLE_S)
+#define MAPENABLE_F    MAPENABLE_V(1U)
+
+#define CHNENABLE_S    30
+#define CHNENABLE_V(x) ((x) << CHNENABLE_S)
+#define CHNENABLE_F    CHNENABLE_V(1U)
+
+#define LE_DB_DBGI_CONFIG_A 0x19cf0
+
+#define DBGICMDBUSY_S    3
+#define DBGICMDBUSY_V(x) ((x) << DBGICMDBUSY_S)
+#define DBGICMDBUSY_F    DBGICMDBUSY_V(1U)
+
+#define DBGICMDSTRT_S    2
+#define DBGICMDSTRT_V(x) ((x) << DBGICMDSTRT_S)
+#define DBGICMDSTRT_F    DBGICMDSTRT_V(1U)
+
+#define DBGICMDMODE_S    0
+#define DBGICMDMODE_M    0x3U
+#define DBGICMDMODE_V(x) ((x) << DBGICMDMODE_S)
+
+#define LE_DB_DBGI_REQ_TCAM_CMD_A 0x19cf4
+
+#define DBGICMD_S    20
+#define DBGICMD_M    0xfU
+#define DBGICMD_V(x) ((x) << DBGICMD_S)
+
+#define DBGITID_S    0
+#define DBGITID_M    0xfffffU
+#define DBGITID_V(x) ((x) << DBGITID_S)
+
+#define LE_DB_DBGI_REQ_DATA_A 0x19d00
+#define LE_DB_DBGI_RSP_STATUS_A 0x19d94
+
+#define LE_DB_DBGI_RSP_DATA_A 0x19da0
+
+#define PRTENABLE_S    29
+#define PRTENABLE_V(x) ((x) << PRTENABLE_S)
+#define PRTENABLE_F    PRTENABLE_V(1U)
+
+#define UDPFOURTUPEN_S    28
+#define UDPFOURTUPEN_V(x) ((x) << UDPFOURTUPEN_S)
+#define UDPFOURTUPEN_F    UDPFOURTUPEN_V(1U)
+
+#define IP6FOURTUPEN_S    27
+#define IP6FOURTUPEN_V(x) ((x) << IP6FOURTUPEN_S)
+#define IP6FOURTUPEN_F    IP6FOURTUPEN_V(1U)
+
+#define IP6TWOTUPEN_S    26
+#define IP6TWOTUPEN_V(x) ((x) << IP6TWOTUPEN_S)
+#define IP6TWOTUPEN_F    IP6TWOTUPEN_V(1U)
+
+#define IP4FOURTUPEN_S    25
+#define IP4FOURTUPEN_V(x) ((x) << IP4FOURTUPEN_S)
+#define IP4FOURTUPEN_F    IP4FOURTUPEN_V(1U)
+
+#define IP4TWOTUPEN_S    24
+#define IP4TWOTUPEN_V(x) ((x) << IP4TWOTUPEN_S)
+#define IP4TWOTUPEN_F    IP4TWOTUPEN_V(1U)
+
+#define IVFWIDTH_S    20
+#define IVFWIDTH_M    0xfU
+#define IVFWIDTH_V(x) ((x) << IVFWIDTH_S)
+#define IVFWIDTH_G(x) (((x) >> IVFWIDTH_S) & IVFWIDTH_M)
+
+#define CH1DEFAULTQUEUE_S    10
+#define CH1DEFAULTQUEUE_M    0x3ffU
+#define CH1DEFAULTQUEUE_V(x) ((x) << CH1DEFAULTQUEUE_S)
+#define CH1DEFAULTQUEUE_G(x) (((x) >> CH1DEFAULTQUEUE_S) & CH1DEFAULTQUEUE_M)
+
+#define CH0DEFAULTQUEUE_S    0
+#define CH0DEFAULTQUEUE_M    0x3ffU
+#define CH0DEFAULTQUEUE_V(x) ((x) << CH0DEFAULTQUEUE_S)
+#define CH0DEFAULTQUEUE_G(x) (((x) >> CH0DEFAULTQUEUE_S) & CH0DEFAULTQUEUE_M)
+
+#define VFLKPIDX_S    8
+#define VFLKPIDX_M    0xffU
+#define VFLKPIDX_G(x) (((x) >> VFLKPIDX_S) & VFLKPIDX_M)
+
+#define T6_VFWRADDR_S    8
+#define T6_VFWRADDR_M    0xffU
+#define T6_VFWRADDR_V(x) ((x) << T6_VFWRADDR_S)
+#define T6_VFWRADDR_G(x) (((x) >> T6_VFWRADDR_S) & T6_VFWRADDR_M)
+
+#define TP_RSS_CONFIG_CNG_A 0x7e04
+#define TP_RSS_CONFIG_SRAM_A 0x7e0c
+#define TP_RSS_SECRET_KEY0_A 0x40
+#define TP_RSS_PF0_CONFIG_A 0x30
+#define TP_RSS_PF_MAP_A 0x38
+#define TP_RSS_PF_MSK_A 0x39
+
+#define PF1LKPIDX_S    3
+
+#define PF0LKPIDX_M    0x7U
+
+#define PF1MSKSIZE_S    4
+#define PF1MSKSIZE_M    0xfU
+
+#define CHNCOUNT3_S    31
+#define CHNCOUNT3_V(x) ((x) << CHNCOUNT3_S)
+#define CHNCOUNT3_F    CHNCOUNT3_V(1U)
+
+#define CHNCOUNT2_S    30
+#define CHNCOUNT2_V(x) ((x) << CHNCOUNT2_S)
+#define CHNCOUNT2_F    CHNCOUNT2_V(1U)
+
+#define CHNCOUNT1_S    29
+#define CHNCOUNT1_V(x) ((x) << CHNCOUNT1_S)
+#define CHNCOUNT1_F    CHNCOUNT1_V(1U)
+
+#define CHNCOUNT0_S    28
+#define CHNCOUNT0_V(x) ((x) << CHNCOUNT0_S)
+#define CHNCOUNT0_F    CHNCOUNT0_V(1U)
+
+#define CHNUNDFLOW3_S    27
+#define CHNUNDFLOW3_V(x) ((x) << CHNUNDFLOW3_S)
+#define CHNUNDFLOW3_F    CHNUNDFLOW3_V(1U)
+
+#define CHNUNDFLOW2_S    26
+#define CHNUNDFLOW2_V(x) ((x) << CHNUNDFLOW2_S)
+#define CHNUNDFLOW2_F    CHNUNDFLOW2_V(1U)
+
+#define CHNUNDFLOW1_S    25
+#define CHNUNDFLOW1_V(x) ((x) << CHNUNDFLOW1_S)
+#define CHNUNDFLOW1_F    CHNUNDFLOW1_V(1U)
+
+#define CHNUNDFLOW0_S    24
+#define CHNUNDFLOW0_V(x) ((x) << CHNUNDFLOW0_S)
+#define CHNUNDFLOW0_F    CHNUNDFLOW0_V(1U)
+
+#define RSTCHN3_S    19
+#define RSTCHN3_V(x) ((x) << RSTCHN3_S)
+#define RSTCHN3_F    RSTCHN3_V(1U)
+
+#define RSTCHN2_S    18
+#define RSTCHN2_V(x) ((x) << RSTCHN2_S)
+#define RSTCHN2_F    RSTCHN2_V(1U)
+
+#define RSTCHN1_S    17
+#define RSTCHN1_V(x) ((x) << RSTCHN1_S)
+#define RSTCHN1_F    RSTCHN1_V(1U)
+
+#define RSTCHN0_S    16
+#define RSTCHN0_V(x) ((x) << RSTCHN0_S)
+#define RSTCHN0_F    RSTCHN0_V(1U)
+
+#define UPDVLD_S    15
+#define UPDVLD_V(x) ((x) << UPDVLD_S)
+#define UPDVLD_F    UPDVLD_V(1U)
+
+#define XOFF_S    14
+#define XOFF_V(x) ((x) << XOFF_S)
+#define XOFF_F    XOFF_V(1U)
+
+#define UPDCHN3_S    13
+#define UPDCHN3_V(x) ((x) << UPDCHN3_S)
+#define UPDCHN3_F    UPDCHN3_V(1U)
+
+#define UPDCHN2_S    12
+#define UPDCHN2_V(x) ((x) << UPDCHN2_S)
+#define UPDCHN2_F    UPDCHN2_V(1U)
+
+#define UPDCHN1_S    11
+#define UPDCHN1_V(x) ((x) << UPDCHN1_S)
+#define UPDCHN1_F    UPDCHN1_V(1U)
+
+#define UPDCHN0_S    10
+#define UPDCHN0_V(x) ((x) << UPDCHN0_S)
+#define UPDCHN0_F    UPDCHN0_V(1U)
+
+#define QUEUE_S    0
+#define QUEUE_M    0x3ffU
+#define QUEUE_V(x) ((x) << QUEUE_S)
+#define QUEUE_G(x) (((x) >> QUEUE_S) & QUEUE_M)
+
+#define MPS_TRC_INT_ENABLE_A 0x9858
+#define MPS_TRC_INT_CAUSE_A	0x985c
+
+#define T7_TRCPLERRENB_S    17
+#define T7_TRCPLERRENB_V(x) ((x) << T7_TRCPLERRENB_S)
+#define T7_TRCPLERRENB_F    T7_TRCPLERRENB_V(1U)
+
+#define T7_MISCPERR_S    16
+#define T7_MISCPERR_V(x) ((x) << T7_MISCPERR_S)
+#define T7_MISCPERR_F    T7_MISCPERR_V(1U)
+
+#define MISCPERR_S    8
+#define MISCPERR_V(x) ((x) << MISCPERR_S)
+#define MISCPERR_F    MISCPERR_V(1U)
+
+#define PKTFIFO_S    4
+#define PKTFIFO_M    0xfU
+#define PKTFIFO_V(x) ((x) << PKTFIFO_S)
+
+#define FILTMEM_S    0
+#define FILTMEM_M    0xfU
+#define FILTMEM_V(x) ((x) << FILTMEM_S)
+
+#define CIM2MPS_INTF_PAR_S    4
+#define CIM2MPS_INTF_PAR_V(x) ((x) << CIM2MPS_INTF_PAR_S)
+#define CIM2MPS_INTF_PAR_F    CIM2MPS_INTF_PAR_V(1U)
+
+#define TCAM_CRC_SRAM_S    3
+#define TCAM_CRC_SRAM_V(x) ((x) << TCAM_CRC_SRAM_S)
+#define TCAM_CRC_SRAM_F    TCAM_CRC_SRAM_V(1U)
+
+#define MPS_CLS_INT_ENABLE_A 0xd024
+#define MPS_CLS_INT_CAUSE_A 0xd028
+
+#define T7_PLERRENB_S    5
+#define T7_PLERRENB_V(x) ((x) << T7_PLERRENB_S)
+#define T7_PLERRENB_F    T7_PLERRENB_V(1U)
+
+#define HASHSRAM_S    2
+#define HASHSRAM_V(x) ((x) << HASHSRAM_S)
+#define HASHSRAM_F    HASHSRAM_V(1U)
+
+#define MATCHTCAM_S    1
+#define MATCHTCAM_V(x) ((x) << MATCHTCAM_S)
+#define MATCHTCAM_F    MATCHTCAM_V(1U)
+
+#define MATCHSRAM_S    0
+#define MATCHSRAM_V(x) ((x) << MATCHSRAM_S)
+#define MATCHSRAM_F    MATCHSRAM_V(1U)
+
+#define MPS_RX_PERR_INT_ENABLE_A 0x11078
+#define MPS_RX_FUNC_INT_CAUSE_A 0x11084
+
+#define MTU_ERR3_S    19
+#define MTU_ERR3_V(x) ((x) << MTU_ERR3_S)
+#define MTU_ERR3_F    MTU_ERR3_V(1U)
+
+#define MTU_ERR2_S    18
+#define MTU_ERR2_V(x) ((x) << MTU_ERR2_S)
+#define MTU_ERR2_F    MTU_ERR2_V(1U)
+
+#define MTU_ERR1_S    17
+#define MTU_ERR1_V(x) ((x) << MTU_ERR1_S)
+#define MTU_ERR1_F    MTU_ERR1_V(1U)
+
+#define MTU_ERR0_S    16
+#define MTU_ERR0_V(x) ((x) << MTU_ERR0_S)
+#define MTU_ERR0_F    MTU_ERR0_V(1U)
+
+#define DBG_LEN_ERR_S    15
+#define DBG_LEN_ERR_V(x) ((x) << DBG_LEN_ERR_S)
+#define DBG_LEN_ERR_F    DBG_LEN_ERR_V(1U)
+
+#define DBG_SPI_ERR_S    14
+#define DBG_SPI_ERR_V(x) ((x) << DBG_SPI_ERR_S)
+#define DBG_SPI_ERR_F    DBG_SPI_ERR_V(1U)
+
+#define DBG_SE_CNT_ERR_S    13
+#define DBG_SE_CNT_ERR_V(x) ((x) << DBG_SE_CNT_ERR_S)
+#define DBG_SE_CNT_ERR_F    DBG_SE_CNT_ERR_V(1U)
+
+#define DBG_SPI_LEN_SE_CNT_ERR_S    12
+#define DBG_SPI_LEN_SE_CNT_ERR_V(x) ((x) << DBG_SPI_LEN_SE_CNT_ERR_S)
+#define DBG_SPI_LEN_SE_CNT_ERR_F    DBG_SPI_LEN_SE_CNT_ERR_V(1U)
+
+#define MPS_RX_FUNC_INT_ENABLE_A 0x11088
+#define MPS_RX_PERR_INT_ENABLE2_A 0x11090
+#define MPS_RX_PERR_INT_CAUSE2_A 0x1108c
+
+#define CRYPTO2MPS_RX0_PERR_S    31
+#define CRYPTO2MPS_RX0_PERR_V(x) ((x) << CRYPTO2MPS_RX0_PERR_S)
+#define CRYPTO2MPS_RX0_PERR_F    CRYPTO2MPS_RX0_PERR_V(1U)
+
+#define CRYPTO2MPS_RX1_PERR_S    30
+#define CRYPTO2MPS_RX1_PERR_V(x) ((x) << CRYPTO2MPS_RX1_PERR_S)
+#define CRYPTO2MPS_RX1_PERR_F    CRYPTO2MPS_RX1_PERR_V(1U)
+
+#define CRYPTO2MPS_RX2_PERR_S    29
+#define CRYPTO2MPS_RX2_PERR_V(x) ((x) << CRYPTO2MPS_RX2_PERR_S)
+#define CRYPTO2MPS_RX2_PERR_F    CRYPTO2MPS_RX2_PERR_V(1U)
+
+#define CRYPTO2MPS_RX3_PERR_S    28
+#define CRYPTO2MPS_RX3_PERR_V(x) ((x) << CRYPTO2MPS_RX3_PERR_S)
+#define CRYPTO2MPS_RX3_PERR_F    CRYPTO2MPS_RX3_PERR_V(1U)
+
+#define INIC2MPS_TX1_PERR_S    27
+#define INIC2MPS_TX1_PERR_V(x) ((x) << INIC2MPS_TX1_PERR_S)
+#define INIC2MPS_TX1_PERR_F    INIC2MPS_TX1_PERR_V(1U)
+
+#define INIC2MPS_TX0_PERR_S    26
+#define INIC2MPS_TX0_PERR_V(x) ((x) << INIC2MPS_TX0_PERR_S)
+#define INIC2MPS_TX0_PERR_F    INIC2MPS_TX0_PERR_V(1U)
+
+#define XGMAC2MPS_RX1_PERR_S    25
+#define XGMAC2MPS_RX1_PERR_V(x) ((x) << XGMAC2MPS_RX1_PERR_S)
+#define XGMAC2MPS_RX1_PERR_F    XGMAC2MPS_RX1_PERR_V(1U)
+
+#define XGMAC2MPS_RX0_PERR_S    24
+#define XGMAC2MPS_RX0_PERR_V(x) ((x) << XGMAC2MPS_RX0_PERR_S)
+#define XGMAC2MPS_RX0_PERR_F    XGMAC2MPS_RX0_PERR_V(1U)
+
+#define MPS_DWRR_FIFO_PERR_S    14
+#define MPS_DWRR_FIFO_PERR_V(x) ((x) << MPS_DWRR_FIFO_PERR_S)
+#define MPS_DWRR_FIFO_PERR_F    MPS_DWRR_FIFO_PERR_V(1U)
+
+#define MAC_TF_FIFO_PERR_S    13
+#define MAC_TF_FIFO_PERR_V(x) ((x) << MAC_TF_FIFO_PERR_S)
+#define MAC_TF_FIFO_PERR_F    MAC_TF_FIFO_PERR_V(1U)
+
+#define MAC2MPS_PT3_PERR_S    12
+#define MAC2MPS_PT3_PERR_V(x) ((x) << MAC2MPS_PT3_PERR_S)
+#define MAC2MPS_PT3_PERR_F    MAC2MPS_PT3_PERR_V(1U)
+
+#define MAC2MPS_PT2_PERR_S    11
+#define MAC2MPS_PT2_PERR_V(x) ((x) << MAC2MPS_PT2_PERR_S)
+#define MAC2MPS_PT2_PERR_F    MAC2MPS_PT2_PERR_V(1U)
+
+#define MAC2MPS_PT1_PERR_S    10
+#define MAC2MPS_PT1_PERR_V(x) ((x) << MAC2MPS_PT1_PERR_S)
+#define MAC2MPS_PT1_PERR_F    MAC2MPS_PT1_PERR_V(1U)
+
+#define MAC2MPS_PT0_PERR_S    9
+#define MAC2MPS_PT0_PERR_V(x) ((x) << MAC2MPS_PT0_PERR_S)
+#define MAC2MPS_PT0_PERR_F    MAC2MPS_PT0_PERR_V(1U)
+
+#define TP_LPBK_FIFO_PERR_S    8
+#define TP_LPBK_FIFO_PERR_V(x) ((x) << TP_LPBK_FIFO_PERR_S)
+#define TP_LPBK_FIFO_PERR_F    TP_LPBK_FIFO_PERR_V(1U)
+
+#define TP_LPBK_TF_PERR_S    7
+#define TP_LPBK_TF_PERR_V(x) ((x) << TP_LPBK_TF_PERR_S)
+#define TP_LPBK_TF_PERR_F    TP_LPBK_TF_PERR_V(1U)
+
+#define MPS_RX_PERR_INT_ENABLE3_A 0x11314
+#define MPS_RX_PERR_INT_CAUSE3_A 0x11310
+
+#define FIFO_REPL_CH3_CERR_S    28
+#define FIFO_REPL_CH3_CERR_V(x) ((x) << FIFO_REPL_CH3_CERR_S)
+#define FIFO_REPL_CH3_CERR_F    FIFO_REPL_CH3_CERR_V(1U)
+
+#define FIFO_REPL_CH2_CERR_S    27
+#define FIFO_REPL_CH2_CERR_V(x) ((x) << FIFO_REPL_CH2_CERR_S)
+#define FIFO_REPL_CH2_CERR_F    FIFO_REPL_CH2_CERR_V(1U)
+
+#define FIFO_REPL_CH1_CERR_S    26
+#define FIFO_REPL_CH1_CERR_V(x) ((x) << FIFO_REPL_CH1_CERR_S)
+#define FIFO_REPL_CH1_CERR_F    FIFO_REPL_CH1_CERR_V(1U)
+
+#define FIFO_REPL_CH0_CERR_S    25
+#define FIFO_REPL_CH0_CERR_V(x) ((x) << FIFO_REPL_CH0_CERR_S)
+#define FIFO_REPL_CH0_CERR_F    FIFO_REPL_CH0_CERR_V(1U)
+
+#define VLAN_FILTER_RAM_CERR_S    24
+#define VLAN_FILTER_RAM_CERR_V(x) ((x) << VLAN_FILTER_RAM_CERR_S)
+#define VLAN_FILTER_RAM_CERR_F    VLAN_FILTER_RAM_CERR_V(1U)
+
+#define MPS_RX_TD_STAT_FIFO_PERR_CH3_S    23
+#define MPS_RX_TD_STAT_FIFO_PERR_CH3_V(x) ((x) << MPS_RX_TD_STAT_FIFO_PERR_CH3_S)
+#define MPS_RX_TD_STAT_FIFO_PERR_CH3_F    MPS_RX_TD_STAT_FIFO_PERR_CH3_V(1U)
+
+#define RPLCT_HDR_FIFO_IN_PERR_CH3_S    22
+#define RPLCT_HDR_FIFO_IN_PERR_CH3_V(x) ((x) << RPLCT_HDR_FIFO_IN_PERR_CH3_S)
+#define RPLCT_HDR_FIFO_IN_PERR_CH3_F    RPLCT_HDR_FIFO_IN_PERR_CH3_V(1U)
+
+#define ID_FIFO_IN_PERR_CH3_S    21
+#define ID_FIFO_IN_PERR_CH3_V(x) ((x) << ID_FIFO_IN_PERR_CH3_S)
+#define ID_FIFO_IN_PERR_CH3_F    ID_FIFO_IN_PERR_CH3_V(1U)
+
+#define DESC_HDR2_PERR_CH3_S    20
+#define DESC_HDR2_PERR_CH3_V(x) ((x) << DESC_HDR2_PERR_CH3_S)
+#define DESC_HDR2_PERR_CH3_F    DESC_HDR2_PERR_CH3_V(1U)
+
+#define FIFO_REPL_PERR_CH3_S    19
+#define FIFO_REPL_PERR_CH3_V(x) ((x) << FIFO_REPL_PERR_CH3_S)
+#define FIFO_REPL_PERR_CH3_F    FIFO_REPL_PERR_CH3_V(1U)
+
+#define MPS_RX_TD_PERR_CH3_S    18
+#define MPS_RX_TD_PERR_CH3_V(x) ((x) << MPS_RX_TD_PERR_CH3_S)
+#define MPS_RX_TD_PERR_CH3_F    MPS_RX_TD_PERR_CH3_V(1U)
+
+#define MPS_RX_TD_STAT_FIFO_PERR_CH2_S    17
+#define MPS_RX_TD_STAT_FIFO_PERR_CH2_V(x) ((x) << MPS_RX_TD_STAT_FIFO_PERR_CH2_S)
+#define MPS_RX_TD_STAT_FIFO_PERR_CH2_F    MPS_RX_TD_STAT_FIFO_PERR_CH2_V(1U)
+
+#define RPLCT_HDR_FIFO_IN_PERR_CH2_S    16
+#define RPLCT_HDR_FIFO_IN_PERR_CH2_V(x) ((x) << RPLCT_HDR_FIFO_IN_PERR_CH2_S)
+#define RPLCT_HDR_FIFO_IN_PERR_CH2_F    RPLCT_HDR_FIFO_IN_PERR_CH2_V(1U)
+
+#define ID_FIFO_IN_PERR_CH2_S    15
+#define ID_FIFO_IN_PERR_CH2_V(x) ((x) << ID_FIFO_IN_PERR_CH2_S)
+#define ID_FIFO_IN_PERR_CH2_F    ID_FIFO_IN_PERR_CH2_V(1U)
+
+#define DESC_HDR2_PERR_CH2_S    14
+#define DESC_HDR2_PERR_CH2_V(x) ((x) << DESC_HDR2_PERR_CH2_S)
+#define DESC_HDR2_PERR_CH2_F    DESC_HDR2_PERR_CH2_V(1U)
+
+#define FIFO_REPL_PERR_CH2_S    13
+#define FIFO_REPL_PERR_CH2_V(x) ((x) << FIFO_REPL_PERR_CH2_S)
+#define FIFO_REPL_PERR_CH2_F    FIFO_REPL_PERR_CH2_V(1U)
+
+#define MPS_RX_TD_PERR_CH2_S    12
+#define MPS_RX_TD_PERR_CH2_V(x) ((x) << MPS_RX_TD_PERR_CH2_S)
+#define MPS_RX_TD_PERR_CH2_F    MPS_RX_TD_PERR_CH2_V(1U)
+
+#define MPS_RX_TD_STAT_FIFO_PERR_CH1_S    11
+#define MPS_RX_TD_STAT_FIFO_PERR_CH1_V(x) ((x) << MPS_RX_TD_STAT_FIFO_PERR_CH1_S)
+#define MPS_RX_TD_STAT_FIFO_PERR_CH1_F    MPS_RX_TD_STAT_FIFO_PERR_CH1_V(1U)
+
+#define RPLCT_HDR_FIFO_IN_PERR_CH1_S    10
+#define RPLCT_HDR_FIFO_IN_PERR_CH1_V(x) ((x) << RPLCT_HDR_FIFO_IN_PERR_CH1_S)
+#define RPLCT_HDR_FIFO_IN_PERR_CH1_F    RPLCT_HDR_FIFO_IN_PERR_CH1_V(1U)
+
+#define ID_FIFO_IN_PERR_CH1_S    9
+#define ID_FIFO_IN_PERR_CH1_V(x) ((x) << ID_FIFO_IN_PERR_CH1_S)
+#define ID_FIFO_IN_PERR_CH1_F    ID_FIFO_IN_PERR_CH1_V(1U)
+
+#define DESC_HDR2_PERR_CH1_S    8
+#define DESC_HDR2_PERR_CH1_V(x) ((x) << DESC_HDR2_PERR_CH1_S)
+#define DESC_HDR2_PERR_CH1_F    DESC_HDR2_PERR_CH1_V(1U)
+
+#define FIFO_REPL_PERR_CH1_S    7
+#define FIFO_REPL_PERR_CH1_V(x) ((x) << FIFO_REPL_PERR_CH1_S)
+#define FIFO_REPL_PERR_CH1_F    FIFO_REPL_PERR_CH1_V(1U)
+
+#define MPS_RX_TD_PERR_CH1_S    6
+#define MPS_RX_TD_PERR_CH1_V(x) ((x) << MPS_RX_TD_PERR_CH1_S)
+#define MPS_RX_TD_PERR_CH1_F    MPS_RX_TD_PERR_CH1_V(1U)
+
+#define MPS_RX_TD_STAT_FIFO_PERR_CH0_S    5
+#define MPS_RX_TD_STAT_FIFO_PERR_CH0_V(x) ((x) << MPS_RX_TD_STAT_FIFO_PERR_CH0_S)
+#define MPS_RX_TD_STAT_FIFO_PERR_CH0_F    MPS_RX_TD_STAT_FIFO_PERR_CH0_V(1U)
+
+#define RPLCT_HDR_FIFO_IN_PERR_CH0_S    4
+#define RPLCT_HDR_FIFO_IN_PERR_CH0_V(x) ((x) << RPLCT_HDR_FIFO_IN_PERR_CH0_S)
+#define RPLCT_HDR_FIFO_IN_PERR_CH0_F    RPLCT_HDR_FIFO_IN_PERR_CH0_V(1U)
+
+#define ID_FIFO_IN_PERR_CH0_S    3
+#define ID_FIFO_IN_PERR_CH0_V(x) ((x) << ID_FIFO_IN_PERR_CH0_S)
+#define ID_FIFO_IN_PERR_CH0_F    ID_FIFO_IN_PERR_CH0_V(1U)
+
+#define DESC_HDR2_PERR_CH0_S    2
+#define DESC_HDR2_PERR_CH0_V(x) ((x) << DESC_HDR2_PERR_CH0_S)
+#define DESC_HDR2_PERR_CH0_F    DESC_HDR2_PERR_CH0_V(1U)
+
+#define FIFO_REPL_PERR_CH0_S    1
+#define FIFO_REPL_PERR_CH0_V(x) ((x) << FIFO_REPL_PERR_CH0_S)
+#define FIFO_REPL_PERR_CH0_F    FIFO_REPL_PERR_CH0_V(1U)
+
+#define MPS_RX_TD_PERR_CH0_S    0
+#define MPS_RX_TD_PERR_CH0_V(x) ((x) << MPS_RX_TD_PERR_CH0_S)
+#define MPS_RX_TD_PERR_CH0_F    MPS_RX_TD_PERR_CH0_V(1U)
+
+#define MPS_RX_PERR_INT_ENABLE4_A 0x11320
+#define MPS_RX_PERR_INT_CAUSE4_A 0x1131c
+
+#define VNI_MULTICAST_FIFO_ECC_ERR_CH3_S    30
+#define VNI_MULTICAST_FIFO_ECC_ERR_CH3_V(x) ((x) << VNI_MULTICAST_FIFO_ECC_ERR_CH3_S)
+#define VNI_MULTICAST_FIFO_ECC_ERR_CH3_F    VNI_MULTICAST_FIFO_ECC_ERR_CH3_V(1U)
+
+#define VNI_MULTICAST_FIFO_ECC_ERR_CH2_S    29
+#define VNI_MULTICAST_FIFO_ECC_ERR_CH2_V(x) ((x) << VNI_MULTICAST_FIFO_ECC_ERR_CH2_S)
+#define VNI_MULTICAST_FIFO_ECC_ERR_CH2_F    VNI_MULTICAST_FIFO_ECC_ERR_CH2_V(1U)
+
+#define HASH_SRAM_CLS_ENG1_S    28
+#define HASH_SRAM_CLS_ENG1_V(x) ((x) << HASH_SRAM_CLS_ENG1_S)
+#define HASH_SRAM_CLS_ENG1_F    HASH_SRAM_CLS_ENG1_V(1U)
+
+#define HASH_SRAM_CLS_ENG0_S    27
+#define HASH_SRAM_CLS_ENG0_V(x) ((x) << HASH_SRAM_CLS_ENG0_S)
+#define HASH_SRAM_CLS_ENG0_F    HASH_SRAM_CLS_ENG0_V(1U)
+
+#define CLS_TCAM_SRAM_CLS_ENG1_S    26
+#define CLS_TCAM_SRAM_CLS_ENG1_V(x) ((x) << CLS_TCAM_SRAM_CLS_ENG1_S)
+#define CLS_TCAM_SRAM_CLS_ENG1_F    CLS_TCAM_SRAM_CLS_ENG1_V(1U)
+
+#define CLS_TCAM_CRC_SRAM_CLS_ENG1_S    25
+#define CLS_TCAM_CRC_SRAM_CLS_ENG1_V(x) ((x) << CLS_TCAM_CRC_SRAM_CLS_ENG1_S)
+#define CLS_TCAM_CRC_SRAM_CLS_ENG1_F    CLS_TCAM_CRC_SRAM_CLS_ENG1_V(1U)
+
+#define CLS_TCAM_SRAM_CLS_ENG0_S    24
+#define CLS_TCAM_SRAM_CLS_ENG0_V(x) ((x) << CLS_TCAM_SRAM_CLS_ENG0_S)
+#define CLS_TCAM_SRAM_CLS_ENG0_F    CLS_TCAM_SRAM_CLS_ENG0_V(1U)
+
+#define CLS_TCAM_CRC_SRAM_CLS_ENG0_S    23
+#define CLS_TCAM_CRC_SRAM_CLS_ENG0_V(x) ((x) << CLS_TCAM_CRC_SRAM_CLS_ENG0_S)
+#define CLS_TCAM_CRC_SRAM_CLS_ENG0_F    CLS_TCAM_CRC_SRAM_CLS_ENG0_V(1U)
+
+#define DWRR_CH_FIFO_ECC_ERR_S    18
+#define DWRR_CH_FIFO_ECC_ERR_V(x) ((x) << DWRR_CH_FIFO_ECC_ERR_S)
+#define DWRR_CH_FIFO_ECC_ERR_F    DWRR_CH_FIFO_ECC_ERR_V(1U)
+
+#define MAC_RX_FIFO_ECC_ERR_S    17
+#define MAC_RX_FIFO_ECC_ERR_V(x) ((x) << MAC_RX_FIFO_ECC_ERR_S)
+#define MAC_RX_FIFO_ECC_ERR_F    MAC_RX_FIFO_ECC_ERR_V(1U)
+
+#define LPBK_RX_FIFO_ECC_ERR_S    16
+#define LPBK_RX_FIFO_ECC_ERR_V(x) ((x) << LPBK_RX_FIFO_ECC_ERR_S)
+#define LPBK_RX_FIFO_ECC_ERR_F    LPBK_RX_FIFO_ECC_ERR_V(1U)
+
+#define CRS_DATA_STORE_N_FWD_CH3_S    15
+#define CRS_DATA_STORE_N_FWD_CH3_V(x) ((x) << CRS_DATA_STORE_N_FWD_CH3_S)
+#define CRS_DATA_STORE_N_FWD_CH3_F    CRS_DATA_STORE_N_FWD_CH3_V(1U)
+
+#define TRACE_FWD_FIFO_CERR_CH3_S    14
+#define TRACE_FWD_FIFO_CERR_CH3_V(x) ((x) << TRACE_FWD_FIFO_CERR_CH3_S)
+#define TRACE_FWD_FIFO_CERR_CH3_F    TRACE_FWD_FIFO_CERR_CH3_V(1U)
+
+#define TRANSPARENT_ENCAP_FWD_FIFO_CERR_CH3_S    13
+#define TRANSPARENT_ENCAP_FWD_FIFO_CERR_CH3_V(x) ((x) << TRANSPARENT_ENCAP_FWD_FIFO_CERR_CH3_S)
+#define TRANSPARENT_ENCAP_FWD_FIFO_CERR_CH3_F    TRANSPARENT_ENCAP_FWD_FIFO_CERR_CH3_V(1U)
+
+#define PTP_TRACE_FWD_FIFO_CERR_CH3_S    12
+#define PTP_TRACE_FWD_FIFO_CERR_CH3_V(x) ((x) << PTP_TRACE_FWD_FIFO_CERR_CH3_S)
+#define PTP_TRACE_FWD_FIFO_CERR_CH3_F    PTP_TRACE_FWD_FIFO_CERR_CH3_V(1U)
+
+#define CRS_DATA_STORE_N_FWD_CH2_S    11
+#define CRS_DATA_STORE_N_FWD_CH2_V(x) ((x) << CRS_DATA_STORE_N_FWD_CH2_S)
+#define CRS_DATA_STORE_N_FWD_CH2_F    CRS_DATA_STORE_N_FWD_CH2_V(1U)
+
+#define TRACE_FWD_FIFO_CERR_CH2_S    10
+#define TRACE_FWD_FIFO_CERR_CH2_V(x) ((x) << TRACE_FWD_FIFO_CERR_CH2_S)
+#define TRACE_FWD_FIFO_CERR_CH2_F    TRACE_FWD_FIFO_CERR_CH2_V(1U)
+
+#define TRANSPARENT_ENCAP_FWD_FIFO_CERR_CH2_S    9
+#define TRANSPARENT_ENCAP_FWD_FIFO_CERR_CH2_V(x) ((x) << TRANSPARENT_ENCAP_FWD_FIFO_CERR_CH2_S)
+#define TRANSPARENT_ENCAP_FWD_FIFO_CERR_CH2_F    TRANSPARENT_ENCAP_FWD_FIFO_CERR_CH2_V(1U)
+
+#define PTP_TRACE_FWD_FIFO_CERR_CH2_S    8
+#define PTP_TRACE_FWD_FIFO_CERR_CH2_V(x) ((x) << PTP_TRACE_FWD_FIFO_CERR_CH2_S)
+#define PTP_TRACE_FWD_FIFO_CERR_CH2_F    PTP_TRACE_FWD_FIFO_CERR_CH2_V(1U)
+
+#define CRS_DATA_STORE_N_FWD_CH1_S    7
+#define CRS_DATA_STORE_N_FWD_CH1_V(x) ((x) << CRS_DATA_STORE_N_FWD_CH1_S)
+#define CRS_DATA_STORE_N_FWD_CH1_F    CRS_DATA_STORE_N_FWD_CH1_V(1U)
+
+#define TRACE_FWD_FIFO_CERR_CH1_S    6
+#define TRACE_FWD_FIFO_CERR_CH1_V(x) ((x) << TRACE_FWD_FIFO_CERR_CH1_S)
+#define TRACE_FWD_FIFO_CERR_CH1_F    TRACE_FWD_FIFO_CERR_CH1_V(1U)
+
+#define TRANSPARENT_ENCAP_FWD_FIFO_CERR_CH1_S    5
+#define TRANSPARENT_ENCAP_FWD_FIFO_CERR_CH1_V(x) ((x) << TRANSPARENT_ENCAP_FWD_FIFO_CERR_CH1_S)
+#define TRANSPARENT_ENCAP_FWD_FIFO_CERR_CH1_F    TRANSPARENT_ENCAP_FWD_FIFO_CERR_CH1_V(1U)
+
+#define PTP_TRACE_FWD_FIFO_CERR_CH1_S    4
+#define PTP_TRACE_FWD_FIFO_CERR_CH1_V(x) ((x) << PTP_TRACE_FWD_FIFO_CERR_CH1_S)
+#define PTP_TRACE_FWD_FIFO_CERR_CH1_F    PTP_TRACE_FWD_FIFO_CERR_CH1_V(1U)
+
+#define CRS_DATA_STORE_N_FWD_CH0_S    3
+#define CRS_DATA_STORE_N_FWD_CH0_V(x) ((x) << CRS_DATA_STORE_N_FWD_CH0_S)
+#define CRS_DATA_STORE_N_FWD_CH0_F    CRS_DATA_STORE_N_FWD_CH0_V(1U)
+
+#define TRACE_FWD_FIFO_CERR_CH0_S    2
+#define TRACE_FWD_FIFO_CERR_CH0_V(x) ((x) << TRACE_FWD_FIFO_CERR_CH0_S)
+#define TRACE_FWD_FIFO_CERR_CH0_F    TRACE_FWD_FIFO_CERR_CH0_V(1U)
+
+#define TRANSPARENT_ENCAP_FWD_FIFO_CERR_CH0_S    1
+#define TRANSPARENT_ENCAP_FWD_FIFO_CERR_CH0_V(x) ((x) << TRANSPARENT_ENCAP_FWD_FIFO_CERR_CH0_S)
+#define TRANSPARENT_ENCAP_FWD_FIFO_CERR_CH0_F    TRANSPARENT_ENCAP_FWD_FIFO_CERR_CH0_V(1U)
+
+#define PTP_TRACE_FWD_FIFO_CERR_CH0_S    0
+#define PTP_TRACE_FWD_FIFO_CERR_CH0_V(x) ((x) << PTP_TRACE_FWD_FIFO_CERR_CH0_S)
+#define PTP_TRACE_FWD_FIFO_CERR_CH0_F    PTP_TRACE_FWD_FIFO_CERR_CH0_V(1U)
+
+#define MPS_RX_PERR_INT_ENABLE5_A 0x1132c
+#define MPS_RX_PERR_INT_CAUSE5_A 0x11328
+
+#define MPS2CRYP_RX_FIFO3_PERR_S    31
+#define MPS2CRYP_RX_FIFO3_PERR_V(x) ((x) << MPS2CRYP_RX_FIFO3_PERR_S)
+#define MPS2CRYP_RX_FIFO3_PERR_F    MPS2CRYP_RX_FIFO3_PERR_V(1U)
+
+#define MPS2CRYP_RX_FIFO2_PERR_S    30
+#define MPS2CRYP_RX_FIFO2_PERR_V(x) ((x) << MPS2CRYP_RX_FIFO2_PERR_S)
+#define MPS2CRYP_RX_FIFO2_PERR_F    MPS2CRYP_RX_FIFO2_PERR_V(1U)
+
+#define MPS2CRYP_RX_FIFO1_PERR_S    29
+#define MPS2CRYP_RX_FIFO1_PERR_V(x) ((x) << MPS2CRYP_RX_FIFO1_PERR_S)
+#define MPS2CRYP_RX_FIFO1_PERR_F    MPS2CRYP_RX_FIFO1_PERR_V(1U)
+
+#define MPS2CRYP_RX_FIFO0_PERR_S    28
+#define MPS2CRYP_RX_FIFO0_PERR_V(x) ((x) << MPS2CRYP_RX_FIFO0_PERR_S)
+#define MPS2CRYP_RX_FIFO0_PERR_F    MPS2CRYP_RX_FIFO0_PERR_V(1U)
+
+#define VNI_MULTICAST_SRAM2_PERR_S    27
+#define VNI_MULTICAST_SRAM2_PERR_V(x) ((x) << VNI_MULTICAST_SRAM2_PERR_S)
+#define VNI_MULTICAST_SRAM2_PERR_F    VNI_MULTICAST_SRAM2_PERR_V(1U)
+
+#define VNI_MULTICAST_SRAM1_PERR_S    26
+#define VNI_MULTICAST_SRAM1_PERR_V(x) ((x) << VNI_MULTICAST_SRAM1_PERR_S)
+#define VNI_MULTICAST_SRAM1_PERR_F    VNI_MULTICAST_SRAM1_PERR_V(1U)
+
+#define VNI_MULTICAST_SRAM0_PERR_S    25
+#define VNI_MULTICAST_SRAM0_PERR_V(x) ((x) << VNI_MULTICAST_SRAM0_PERR_S)
+#define VNI_MULTICAST_SRAM0_PERR_F    VNI_MULTICAST_SRAM0_PERR_V(1U)
+
+#define MAC_MULTICAST_SRAM4_PERR_S    24
+#define MAC_MULTICAST_SRAM4_PERR_V(x) ((x) << MAC_MULTICAST_SRAM4_PERR_S)
+#define MAC_MULTICAST_SRAM4_PERR_F    MAC_MULTICAST_SRAM4_PERR_V(1U)
+
+#define MAC_MULTICAST_SRAM3_PERR_S    23
+#define MAC_MULTICAST_SRAM3_PERR_V(x) ((x) << MAC_MULTICAST_SRAM3_PERR_S)
+#define MAC_MULTICAST_SRAM3_PERR_F    MAC_MULTICAST_SRAM3_PERR_V(1U)
+
+#define MAC_MULTICAST_SRAM2_PERR_S    22
+#define MAC_MULTICAST_SRAM2_PERR_V(x) ((x) << MAC_MULTICAST_SRAM2_PERR_S)
+#define MAC_MULTICAST_SRAM2_PERR_F    MAC_MULTICAST_SRAM2_PERR_V(1U)
+
+#define MAC_MULTICAST_SRAM1_PERR_S    21
+#define MAC_MULTICAST_SRAM1_PERR_V(x) ((x) << MAC_MULTICAST_SRAM1_PERR_S)
+#define MAC_MULTICAST_SRAM1_PERR_F    MAC_MULTICAST_SRAM1_PERR_V(1U)
+
+#define MAC_MULTICAST_SRAM0_PERR_S    20
+#define MAC_MULTICAST_SRAM0_PERR_V(x) ((x) << MAC_MULTICAST_SRAM0_PERR_S)
+#define MAC_MULTICAST_SRAM0_PERR_F    MAC_MULTICAST_SRAM0_PERR_V(1U)
+
+#define MEM_WRAP_IPSEC_HDR_UPD_FIFO3_PERR_S    19
+#define MEM_WRAP_IPSEC_HDR_UPD_FIFO3_PERR_V(x) ((x) << MEM_WRAP_IPSEC_HDR_UPD_FIFO3_PERR_S)
+#define MEM_WRAP_IPSEC_HDR_UPD_FIFO3_PERR_F    MEM_WRAP_IPSEC_HDR_UPD_FIFO3_PERR_V(1U)
+
+#define MEM_WRAP_IPSEC_HDR_UPD_FIFO2_PERR_S    18
+#define MEM_WRAP_IPSEC_HDR_UPD_FIFO2_PERR_V(x) ((x) << MEM_WRAP_IPSEC_HDR_UPD_FIFO2_PERR_S)
+#define MEM_WRAP_IPSEC_HDR_UPD_FIFO2_PERR_F    MEM_WRAP_IPSEC_HDR_UPD_FIFO2_PERR_V(1U)
+
+#define MEM_WRAP_IPSEC_HDR_UPD_FIFO1_PERR_S    17
+#define MEM_WRAP_IPSEC_HDR_UPD_FIFO1_PERR_V(x) ((x) << MEM_WRAP_IPSEC_HDR_UPD_FIFO1_PERR_S)
+#define MEM_WRAP_IPSEC_HDR_UPD_FIFO1_PERR_F    MEM_WRAP_IPSEC_HDR_UPD_FIFO1_PERR_V(1U)
+
+#define MEM_WRAP_IPSEC_HDR_UPD_FIFO0_PERR_S    16
+#define MEM_WRAP_IPSEC_HDR_UPD_FIFO0_PERR_V(x) ((x) << MEM_WRAP_IPSEC_HDR_UPD_FIFO0_PERR_S)
+#define MEM_WRAP_IPSEC_HDR_UPD_FIFO0_PERR_F    MEM_WRAP_IPSEC_HDR_UPD_FIFO0_PERR_V(1U)
+
+#define MEM_WRAP_CR2MPS_RX_FIFO3_PERR_S    15
+#define MEM_WRAP_CR2MPS_RX_FIFO3_PERR_V(x) ((x) << MEM_WRAP_CR2MPS_RX_FIFO3_PERR_S)
+#define MEM_WRAP_CR2MPS_RX_FIFO3_PERR_F    MEM_WRAP_CR2MPS_RX_FIFO3_PERR_V(1U)
+
+#define MEM_WRAP_CR2MPS_RX_FIFO2_PERR_S    14
+#define MEM_WRAP_CR2MPS_RX_FIFO2_PERR_V(x) ((x) << MEM_WRAP_CR2MPS_RX_FIFO2_PERR_S)
+#define MEM_WRAP_CR2MPS_RX_FIFO2_PERR_F    MEM_WRAP_CR2MPS_RX_FIFO2_PERR_V(1U)
+
+#define MEM_WRAP_CR2MPS_RX_FIFO1_PERR_S    13
+#define MEM_WRAP_CR2MPS_RX_FIFO1_PERR_V(x) ((x) << MEM_WRAP_CR2MPS_RX_FIFO1_PERR_S)
+#define MEM_WRAP_CR2MPS_RX_FIFO1_PERR_F    MEM_WRAP_CR2MPS_RX_FIFO1_PERR_V(1U)
 
-#define MPS_INT_CAUSE_A 0x9008
-#define MPS_TX_INT_CAUSE_A 0x9408
-#define MPS_STAT_CTL_A 0x9600
+#define MEM_WRAP_CR2MPS_RX_FIFO0_PERR_S    12
+#define MEM_WRAP_CR2MPS_RX_FIFO0_PERR_V(x) ((x) << MEM_WRAP_CR2MPS_RX_FIFO0_PERR_S)
+#define MEM_WRAP_CR2MPS_RX_FIFO0_PERR_F    MEM_WRAP_CR2MPS_RX_FIFO0_PERR_V(1U)
 
-#define FRMERR_S    15
-#define FRMERR_V(x) ((x) << FRMERR_S)
-#define FRMERR_F    FRMERR_V(1U)
+#define MEM_WRAP_NON_IPSEC_FIFO3_PERR_S    11
+#define MEM_WRAP_NON_IPSEC_FIFO3_PERR_V(x) ((x) << MEM_WRAP_NON_IPSEC_FIFO3_PERR_S)
+#define MEM_WRAP_NON_IPSEC_FIFO3_PERR_F    MEM_WRAP_NON_IPSEC_FIFO3_PERR_V(1U)
 
-#define SECNTERR_S    14
-#define SECNTERR_V(x) ((x) << SECNTERR_S)
-#define SECNTERR_F    SECNTERR_V(1U)
+#define MEM_WRAP_NON_IPSEC_FIFO2_PERR_S    10
+#define MEM_WRAP_NON_IPSEC_FIFO2_PERR_V(x) ((x) << MEM_WRAP_NON_IPSEC_FIFO2_PERR_S)
+#define MEM_WRAP_NON_IPSEC_FIFO2_PERR_F    MEM_WRAP_NON_IPSEC_FIFO2_PERR_V(1U)
 
-#define BUBBLE_S    13
-#define BUBBLE_V(x) ((x) << BUBBLE_S)
-#define BUBBLE_F    BUBBLE_V(1U)
+#define MEM_WRAP_NON_IPSEC_FIFO1_PERR_S    9
+#define MEM_WRAP_NON_IPSEC_FIFO1_PERR_V(x) ((x) << MEM_WRAP_NON_IPSEC_FIFO1_PERR_S)
+#define MEM_WRAP_NON_IPSEC_FIFO1_PERR_F    MEM_WRAP_NON_IPSEC_FIFO1_PERR_V(1U)
 
-#define TXDESCFIFO_S    9
-#define TXDESCFIFO_M    0xfU
-#define TXDESCFIFO_V(x) ((x) << TXDESCFIFO_S)
+#define MEM_WRAP_NON_IPSEC_FIFO0_PERR_S    8
+#define MEM_WRAP_NON_IPSEC_FIFO0_PERR_V(x) ((x) << MEM_WRAP_NON_IPSEC_FIFO0_PERR_S)
+#define MEM_WRAP_NON_IPSEC_FIFO0_PERR_F    MEM_WRAP_NON_IPSEC_FIFO0_PERR_V(1U)
 
-#define TXDATAFIFO_S    5
-#define TXDATAFIFO_M    0xfU
-#define TXDATAFIFO_V(x) ((x) << TXDATAFIFO_S)
+#define MEM_WRAP_TP_DB_REQ_FIFO3_PERR_S    7
+#define MEM_WRAP_TP_DB_REQ_FIFO3_PERR_V(x) ((x) << MEM_WRAP_TP_DB_REQ_FIFO3_PERR_S)
+#define MEM_WRAP_TP_DB_REQ_FIFO3_PERR_F    MEM_WRAP_TP_DB_REQ_FIFO3_PERR_V(1U)
 
-#define NCSIFIFO_S    4
-#define NCSIFIFO_V(x) ((x) << NCSIFIFO_S)
-#define NCSIFIFO_F    NCSIFIFO_V(1U)
+#define MEM_WRAP_TP_DB_REQ_FIFO2_PERR_S    6
+#define MEM_WRAP_TP_DB_REQ_FIFO2_PERR_V(x) ((x) << MEM_WRAP_TP_DB_REQ_FIFO2_PERR_S)
+#define MEM_WRAP_TP_DB_REQ_FIFO2_PERR_F    MEM_WRAP_TP_DB_REQ_FIFO2_PERR_V(1U)
 
-#define TPFIFO_S    0
-#define TPFIFO_M    0xfU
-#define TPFIFO_V(x) ((x) << TPFIFO_S)
+#define MEM_WRAP_TP_DB_REQ_FIFO1_PERR_S    5
+#define MEM_WRAP_TP_DB_REQ_FIFO1_PERR_V(x) ((x) << MEM_WRAP_TP_DB_REQ_FIFO1_PERR_S)
+#define MEM_WRAP_TP_DB_REQ_FIFO1_PERR_F    MEM_WRAP_TP_DB_REQ_FIFO1_PERR_V(1U)
 
-#define MPS_STAT_PERR_INT_CAUSE_SRAM_A		0x9614
-#define MPS_STAT_PERR_INT_CAUSE_TX_FIFO_A	0x9620
-#define MPS_STAT_PERR_INT_CAUSE_RX_FIFO_A	0x962c
+#define MEM_WRAP_TP_DB_REQ_FIFO0_PERR_S    4
+#define MEM_WRAP_TP_DB_REQ_FIFO0_PERR_V(x) ((x) << MEM_WRAP_TP_DB_REQ_FIFO0_PERR_S)
+#define MEM_WRAP_TP_DB_REQ_FIFO0_PERR_F    MEM_WRAP_TP_DB_REQ_FIFO0_PERR_V(1U)
 
-#define MPS_STAT_RX_BG_0_MAC_DROP_FRAME_L 0x9640
-#define MPS_STAT_RX_BG_0_MAC_DROP_FRAME_H 0x9644
-#define MPS_STAT_RX_BG_1_MAC_DROP_FRAME_L 0x9648
-#define MPS_STAT_RX_BG_1_MAC_DROP_FRAME_H 0x964c
-#define MPS_STAT_RX_BG_2_MAC_DROP_FRAME_L 0x9650
-#define MPS_STAT_RX_BG_2_MAC_DROP_FRAME_H 0x9654
-#define MPS_STAT_RX_BG_3_MAC_DROP_FRAME_L 0x9658
-#define MPS_STAT_RX_BG_3_MAC_DROP_FRAME_H 0x965c
-#define MPS_STAT_RX_BG_0_LB_DROP_FRAME_L 0x9660
-#define MPS_STAT_RX_BG_0_LB_DROP_FRAME_H 0x9664
-#define MPS_STAT_RX_BG_1_LB_DROP_FRAME_L 0x9668
-#define MPS_STAT_RX_BG_1_LB_DROP_FRAME_H 0x966c
-#define MPS_STAT_RX_BG_2_LB_DROP_FRAME_L 0x9670
-#define MPS_STAT_RX_BG_2_LB_DROP_FRAME_H 0x9674
-#define MPS_STAT_RX_BG_3_LB_DROP_FRAME_L 0x9678
-#define MPS_STAT_RX_BG_3_LB_DROP_FRAME_H 0x967c
-#define MPS_STAT_RX_BG_0_MAC_TRUNC_FRAME_L 0x9680
-#define MPS_STAT_RX_BG_0_MAC_TRUNC_FRAME_H 0x9684
-#define MPS_STAT_RX_BG_1_MAC_TRUNC_FRAME_L 0x9688
-#define MPS_STAT_RX_BG_1_MAC_TRUNC_FRAME_H 0x968c
-#define MPS_STAT_RX_BG_2_MAC_TRUNC_FRAME_L 0x9690
-#define MPS_STAT_RX_BG_2_MAC_TRUNC_FRAME_H 0x9694
-#define MPS_STAT_RX_BG_3_MAC_TRUNC_FRAME_L 0x9698
-#define MPS_STAT_RX_BG_3_MAC_TRUNC_FRAME_H 0x969c
-#define MPS_STAT_RX_BG_0_LB_TRUNC_FRAME_L 0x96a0
-#define MPS_STAT_RX_BG_0_LB_TRUNC_FRAME_H 0x96a4
-#define MPS_STAT_RX_BG_1_LB_TRUNC_FRAME_L 0x96a8
-#define MPS_STAT_RX_BG_1_LB_TRUNC_FRAME_H 0x96ac
-#define MPS_STAT_RX_BG_2_LB_TRUNC_FRAME_L 0x96b0
-#define MPS_STAT_RX_BG_2_LB_TRUNC_FRAME_H 0x96b4
-#define MPS_STAT_RX_BG_3_LB_TRUNC_FRAME_L 0x96b8
-#define MPS_STAT_RX_BG_3_LB_TRUNC_FRAME_H 0x96bc
+#define MEM_WRAP_CNTRL_FIFO3_PERR_S    3
+#define MEM_WRAP_CNTRL_FIFO3_PERR_V(x) ((x) << MEM_WRAP_CNTRL_FIFO3_PERR_S)
+#define MEM_WRAP_CNTRL_FIFO3_PERR_F    MEM_WRAP_CNTRL_FIFO3_PERR_V(1U)
 
-#define MPS_TRC_CFG_A 0x9800
+#define MEM_WRAP_CNTRL_FIFO2_PERR_S    2
+#define MEM_WRAP_CNTRL_FIFO2_PERR_V(x) ((x) << MEM_WRAP_CNTRL_FIFO2_PERR_S)
+#define MEM_WRAP_CNTRL_FIFO2_PERR_F    MEM_WRAP_CNTRL_FIFO2_PERR_V(1U)
 
-#define TRCFIFOEMPTY_S    4
-#define TRCFIFOEMPTY_V(x) ((x) << TRCFIFOEMPTY_S)
-#define TRCFIFOEMPTY_F    TRCFIFOEMPTY_V(1U)
+#define MEM_WRAP_CNTRL_FIFO1_PERR_S    1
+#define MEM_WRAP_CNTRL_FIFO1_PERR_V(x) ((x) << MEM_WRAP_CNTRL_FIFO1_PERR_S)
+#define MEM_WRAP_CNTRL_FIFO1_PERR_F    MEM_WRAP_CNTRL_FIFO1_PERR_V(1U)
 
-#define TRCIGNOREDROPINPUT_S    3
-#define TRCIGNOREDROPINPUT_V(x) ((x) << TRCIGNOREDROPINPUT_S)
-#define TRCIGNOREDROPINPUT_F    TRCIGNOREDROPINPUT_V(1U)
+#define MEM_WRAP_CNTRL_FIFO0_PERR_S    0
+#define MEM_WRAP_CNTRL_FIFO0_PERR_V(x) ((x) << MEM_WRAP_CNTRL_FIFO0_PERR_S)
+#define MEM_WRAP_CNTRL_FIFO0_PERR_F    MEM_WRAP_CNTRL_FIFO0_PERR_V(1U)
 
-#define TRCKEEPDUPLICATES_S    2
-#define TRCKEEPDUPLICATES_V(x) ((x) << TRCKEEPDUPLICATES_S)
-#define TRCKEEPDUPLICATES_F    TRCKEEPDUPLICATES_V(1U)
+#define MPS_RX_PERR_INT_ENABLE6_A 0x11338
+#define MPS_RX_PERR_INT_CAUSE6_A 0x11334
 
-#define TRCEN_S    1
-#define TRCEN_V(x) ((x) << TRCEN_S)
-#define TRCEN_F    TRCEN_V(1U)
+#define T7_MEM_WRAP_IPSEC_HDR_UPD_FIFO3_PERR_S    23
+#define T7_MEM_WRAP_IPSEC_HDR_UPD_FIFO3_PERR_V(x) ((x) << T7_MEM_WRAP_IPSEC_HDR_UPD_FIFO3_PERR_S)
+#define T7_MEM_WRAP_IPSEC_HDR_UPD_FIFO3_PERR_F    T7_MEM_WRAP_IPSEC_HDR_UPD_FIFO3_PERR_V(1U)
 
-#define TRCMULTIFILTER_S    0
-#define TRCMULTIFILTER_V(x) ((x) << TRCMULTIFILTER_S)
-#define TRCMULTIFILTER_F    TRCMULTIFILTER_V(1U)
+#define T7_MEM_WRAP_IPSEC_HDR_UPD_FIFO2_PERR_S    22
+#define T7_MEM_WRAP_IPSEC_HDR_UPD_FIFO2_PERR_V(x) ((x) << T7_MEM_WRAP_IPSEC_HDR_UPD_FIFO2_PERR_S)
+#define T7_MEM_WRAP_IPSEC_HDR_UPD_FIFO2_PERR_F    T7_MEM_WRAP_IPSEC_HDR_UPD_FIFO2_PERR_V(1U)
 
-#define MPS_TRC_RSS_CONTROL_A		0x9808
-#define MPS_TRC_FILTER1_RSS_CONTROL_A	0x9ff4
-#define MPS_TRC_FILTER2_RSS_CONTROL_A	0x9ffc
-#define MPS_TRC_FILTER3_RSS_CONTROL_A	0xa004
-#define MPS_T5_TRC_RSS_CONTROL_A	0xa00c
+#define T7_MEM_WRAP_IPSEC_HDR_UPD_FIFO1_PERR_S    21
+#define T7_MEM_WRAP_IPSEC_HDR_UPD_FIFO1_PERR_V(x) ((x) << T7_MEM_WRAP_IPSEC_HDR_UPD_FIFO1_PERR_S)
+#define T7_MEM_WRAP_IPSEC_HDR_UPD_FIFO1_PERR_F    T7_MEM_WRAP_IPSEC_HDR_UPD_FIFO1_PERR_V(1U)
 
-#define RSSCONTROL_S    16
-#define RSSCONTROL_V(x) ((x) << RSSCONTROL_S)
+#define T7_MEM_WRAP_IPSEC_HDR_UPD_FIFO0_PERR_S    20
+#define T7_MEM_WRAP_IPSEC_HDR_UPD_FIFO0_PERR_V(x) ((x) << T7_MEM_WRAP_IPSEC_HDR_UPD_FIFO0_PERR_S)
+#define T7_MEM_WRAP_IPSEC_HDR_UPD_FIFO0_PERR_F    T7_MEM_WRAP_IPSEC_HDR_UPD_FIFO0_PERR_V(1U)
 
-#define QUEUENUMBER_S    0
-#define QUEUENUMBER_V(x) ((x) << QUEUENUMBER_S)
+#define MEM_WRAP_CR2MPS_UPDTD_HDR_FIFO3_PERR_S    19
+#define MEM_WRAP_CR2MPS_UPDTD_HDR_FIFO3_PERR_V(x) ((x) << MEM_WRAP_CR2MPS_UPDTD_HDR_FIFO3_PERR_S)
+#define MEM_WRAP_CR2MPS_UPDTD_HDR_FIFO3_PERR_F    MEM_WRAP_CR2MPS_UPDTD_HDR_FIFO3_PERR_V(1U)
 
-#define TFINVERTMATCH_S    24
-#define TFINVERTMATCH_V(x) ((x) << TFINVERTMATCH_S)
-#define TFINVERTMATCH_F    TFINVERTMATCH_V(1U)
+#define MEM_WRAP_CR2MPS_UPDTD_HDR_FIFO2_PERR_S    18
+#define MEM_WRAP_CR2MPS_UPDTD_HDR_FIFO2_PERR_V(x) ((x) << MEM_WRAP_CR2MPS_UPDTD_HDR_FIFO2_PERR_S)
+#define MEM_WRAP_CR2MPS_UPDTD_HDR_FIFO2_PERR_F    MEM_WRAP_CR2MPS_UPDTD_HDR_FIFO2_PERR_V(1U)
 
-#define TFEN_S    22
-#define TFEN_V(x) ((x) << TFEN_S)
-#define TFEN_F    TFEN_V(1U)
+#define MEM_WRAP_CR2MPS_UPDTD_HDR_FIFO1_PERR_S    17
+#define MEM_WRAP_CR2MPS_UPDTD_HDR_FIFO1_PERR_V(x) ((x) << MEM_WRAP_CR2MPS_UPDTD_HDR_FIFO1_PERR_S)
+#define MEM_WRAP_CR2MPS_UPDTD_HDR_FIFO1_PERR_F    MEM_WRAP_CR2MPS_UPDTD_HDR_FIFO1_PERR_V(1U)
+
+#define MEM_WRAP_CR2MPS_UPDTD_HDR_FIFO0_PERR_S    16
+#define MEM_WRAP_CR2MPS_UPDTD_HDR_FIFO0_PERR_V(x) ((x) << MEM_WRAP_CR2MPS_UPDTD_HDR_FIFO0_PERR_S)
+#define MEM_WRAP_CR2MPS_UPDTD_HDR_FIFO0_PERR_F    MEM_WRAP_CR2MPS_UPDTD_HDR_FIFO0_PERR_V(1U)
+
+#define MPS_RX_PG_RSV0_A 0x11010
+#define MPS_RX_PG_RSV4_A 0x11020
+#define MPS_RX_PERR_INT_CAUSE_A 0x11074
+#define MPS_RX_MAC_BG_PG_CNT0_A 0x11208
+#define MPS_RX_LPBK_BG_PG_CNT0_A 0x11218
+
+#define MPS_RX_VXLAN_TYPE_A 0x11234
+
+#define VXLAN_EN_S    16
+#define VXLAN_EN_V(x) ((x) << VXLAN_EN_S)
+#define VXLAN_EN_F    VXLAN_EN_V(1U)
+
+#define VXLAN_S    0
+#define VXLAN_M    0xffffU
+#define VXLAN_V(x) ((x) << VXLAN_S)
+#define VXLAN_G(x) (((x) >> VXLAN_S) & VXLAN_M)
+
+#define MPS_RX_GENEVE_TYPE_A 0x11238
+
+#define GENEVE_EN_S    16
+#define GENEVE_EN_V(x) ((x) << GENEVE_EN_S)
+#define GENEVE_EN_F    GENEVE_EN_V(1U)
+
+#define GENEVE_S    0
+#define GENEVE_M    0xffffU
+#define GENEVE_V(x) ((x) << GENEVE_S)
+#define GENEVE_G(x) (((x) >> GENEVE_S) & GENEVE_M)
+
+#define T7_MPS_TRC_INT_ENABLE_A 0xa4e0
+#define T7_MPS_TRC_INT_CAUSE_A 0xa4e4
+#define T7_MPS_RX_VXLAN_TYPE_A 0x1123c
+#define T7_MPS_RX_GENEVE_TYPE_A 0x11240
+#define MPS_CLS_TCAM_Y_L_A 0xf000
+#define MPS_CLS_TCAM_DATA0_A 0xf000
+#define MPS_CLS_TCAM_DATA1_A 0xf004
+#define MPS_TRC_INT_ENABLE2_A 0xa4f4
+#define MPS_TRC_INT_CAUSE2_A 0xa4f8
+
+#define CTLREQID_S    30
+#define CTLREQID_V(x) ((x) << CTLREQID_S)
+
+#define MPS_VF_RPLCT_MAP0_A 0x1111c
+#define MPS_VF_RPLCT_MAP1_A 0x11120
+#define MPS_VF_RPLCT_MAP2_A 0x11124
+#define MPS_VF_RPLCT_MAP3_A 0x11128
+#define MPS_VF_RPLCT_MAP4_A 0x11300
+#define MPS_VF_RPLCT_MAP5_A 0x11304
+#define MPS_VF_RPLCT_MAP6_A 0x11308
+#define MPS_VF_RPLCT_MAP7_A 0x1130c
+
+#define VIDL_S    16
+#define VIDL_M    0xffffU
+#define VIDL_G(x) (((x) >> VIDL_S) & VIDL_M)
+
+#define DATALKPTYPE_S    10
+#define DATALKPTYPE_M    0x3U
+#define DATALKPTYPE_V(x) ((x) << DATALKPTYPE_S)
+#define DATALKPTYPE_G(x) (((x) >> DATALKPTYPE_S) & DATALKPTYPE_M)
+
+#define DATAPORTNUM_S    12
+#define DATAPORTNUM_M    0xfU
+#define DATAPORTNUM_V(x) ((x) << DATAPORTNUM_S)
+#define DATAPORTNUM_G(x) (((x) >> DATAPORTNUM_S) & DATAPORTNUM_M)
+
+#define DATADIPHIT_S    8
+#define DATADIPHIT_V(x) ((x) << DATADIPHIT_S)
+#define DATADIPHIT_F    DATADIPHIT_V(1U)
+
+#define DATAVIDH2_S    7
+#define DATAVIDH2_V(x) ((x) << DATAVIDH2_S)
+#define DATAVIDH2_F    DATAVIDH2_V(1U)
+
+#define DATAVIDH1_S    0
+#define DATAVIDH1_M    0x7fU
+#define DATAVIDH1_G(x) (((x) >> DATAVIDH1_S) & DATAVIDH1_M)
+
+#define MPS_CLS_TCAM_RDATA0_REQ_ID1_A 0xf020
+#define MPS_CLS_TCAM_RDATA1_REQ_ID1_A 0xf024
+#define MPS_CLS_TCAM_RDATA2_REQ_ID1_A 0xf028
+
+#define USED_S    16
+#define USED_M    0x7ffU
+#define USED_G(x) (((x) >> USED_S) & USED_M)
+
+#define ALLOC_S    0
+#define ALLOC_M    0x7ffU
+#define ALLOC_G(x) (((x) >> ALLOC_S) & ALLOC_M)
+
+#define T5_USED_S    16
+#define T5_USED_M    0xfffU
+#define T5_USED_G(x) (((x) >> T5_USED_S) & T5_USED_M)
+
+#define T5_ALLOC_S    0
+#define T5_ALLOC_M    0xfffU
+#define T5_ALLOC_G(x) (((x) >> T5_ALLOC_S) & T5_ALLOC_M)
+
+#define DMACH_S    0
+#define DMACH_M    0xffffU
+#define DMACH_G(x) (((x) >> DMACH_S) & DMACH_M)
+
+#define MPS_CLS_TCAM_X_L_A 0xf008
+#define MPS_CLS_TCAM_DATA2_CTL_A 0xf008
+
+#define CTLCMDTYPE_S    31
+#define CTLCMDTYPE_V(x) ((x) << CTLCMDTYPE_S)
+#define CTLCMDTYPE_F    CTLCMDTYPE_V(1U)
+
+#define CTLTCAMSEL_S    25
+#define CTLTCAMSEL_V(x) ((x) << CTLTCAMSEL_S)
+
+#define CTLTCAMINDEX_S    17
+#define CTLTCAMINDEX_V(x) ((x) << CTLTCAMINDEX_S)
+
+#define CTLXYBITSEL_S    16
+#define CTLXYBITSEL_V(x) ((x) << CTLXYBITSEL_S)
+
+#define MPS_CLS_TCAM_Y_L(idx) (MPS_CLS_TCAM_Y_L_A + (idx) * 16)
+#define NUM_MPS_CLS_TCAM_Y_L_INSTANCES 512
+
+#define MPS_CLS_TCAM_X_L(idx) (MPS_CLS_TCAM_X_L_A + (idx) * 16)
+#define NUM_MPS_CLS_TCAM_X_L_INSTANCES 512
+
+#define T7_CTLTCAMSEL_S    26
+#define T7_CTLTCAMSEL_V(x) ((x) << T7_CTLTCAMSEL_S)
+
+#define T7_1_CTLTCAMINDEX_S    17
+#define T7_1_CTLTCAMINDEX_V(x) ((x) << T7_1_CTLTCAMINDEX_S)
+
+#define MPS_CLS_SRAM_L_A 0xe000
+
+#define T6_MULTILISTEN0_S    26
+
+#define T6_SRAM_PRIO3_S    23
+#define T6_SRAM_PRIO3_M    0x7U
+#define T6_SRAM_PRIO3_G(x) (((x) >> T6_SRAM_PRIO3_S) & T6_SRAM_PRIO3_M)
+
+#define T6_SRAM_PRIO2_S    20
+#define T6_SRAM_PRIO2_M    0x7U
+#define T6_SRAM_PRIO2_G(x) (((x) >> T6_SRAM_PRIO2_S) & T6_SRAM_PRIO2_M)
+
+#define T6_SRAM_PRIO1_S    17
+#define T6_SRAM_PRIO1_M    0x7U
+#define T6_SRAM_PRIO1_G(x) (((x) >> T6_SRAM_PRIO1_S) & T6_SRAM_PRIO1_M)
+
+#define T6_SRAM_PRIO0_S    14
+#define T6_SRAM_PRIO0_M    0x7U
+#define T6_SRAM_PRIO0_G(x) (((x) >> T6_SRAM_PRIO0_S) & T6_SRAM_PRIO0_M)
+
+#define T6_SRAM_VLD_S    13
+#define T6_SRAM_VLD_V(x) ((x) << T6_SRAM_VLD_S)
+#define T6_SRAM_VLD_F    T6_SRAM_VLD_V(1U)
+
+#define T6_REPLICATE_S    12
+#define T6_REPLICATE_V(x) ((x) << T6_REPLICATE_S)
+#define T6_REPLICATE_F    T6_REPLICATE_V(1U)
+
+#define T6_PF_S    9
+#define T6_PF_M    0x7U
+#define T6_PF_G(x) (((x) >> T6_PF_S) & T6_PF_M)
+
+#define T6_VF_VALID_S    8
+#define T6_VF_VALID_V(x) ((x) << T6_VF_VALID_S)
+#define T6_VF_VALID_F    T6_VF_VALID_V(1U)
+
+#define T6_VF_S    0
+#define T6_VF_M    0xffU
+#define T6_VF_G(x) (((x) >> T6_VF_S) & T6_VF_M)
+
+#define MPS_CLS_SRAM_H_A 0xe004
+
+#define MPS_CLS_SRAM_L(idx) (MPS_CLS_SRAM_L_A + (idx) * 8)
+#define NUM_MPS_CLS_SRAM_L_INSTANCES 336
 
-#define TFPORT_S    18
-#define TFPORT_M    0xfU
-#define TFPORT_V(x) ((x) << TFPORT_S)
-#define TFPORT_G(x) (((x) >> TFPORT_S) & TFPORT_M)
+#define MPS_CLS_SRAM_H(idx) (MPS_CLS_SRAM_H_A + (idx) * 8)
+#define NUM_MPS_CLS_SRAM_H_INSTANCES 336
 
-#define TFLENGTH_S    8
-#define TFLENGTH_M    0x1fU
-#define TFLENGTH_V(x) ((x) << TFLENGTH_S)
-#define TFLENGTH_G(x) (((x) >> TFLENGTH_S) & TFLENGTH_M)
+#define MULTILISTEN0_S    25
 
-#define TFOFFSET_S    0
-#define TFOFFSET_M    0x1fU
-#define TFOFFSET_V(x) ((x) << TFOFFSET_S)
-#define TFOFFSET_G(x) (((x) >> TFOFFSET_S) & TFOFFSET_M)
+#define REPLICATE_S    11
+#define REPLICATE_V(x) ((x) << REPLICATE_S)
+#define REPLICATE_F    REPLICATE_V(1U)
 
-#define T5_TFINVERTMATCH_S    25
-#define T5_TFINVERTMATCH_V(x) ((x) << T5_TFINVERTMATCH_S)
-#define T5_TFINVERTMATCH_F    T5_TFINVERTMATCH_V(1U)
+#define PF_S    8
+#define PF_M    0x7U
+#define PF_G(x) (((x) >> PF_S) & PF_M)
 
-#define T5_TFEN_S    23
-#define T5_TFEN_V(x) ((x) << T5_TFEN_S)
-#define T5_TFEN_F    T5_TFEN_V(1U)
+#define VF_VALID_S    7
+#define VF_VALID_V(x) ((x) << VF_VALID_S)
+#define VF_VALID_F    VF_VALID_V(1U)
 
-#define T5_TFPORT_S    18
-#define T5_TFPORT_M    0x1fU
-#define T5_TFPORT_V(x) ((x) << T5_TFPORT_S)
-#define T5_TFPORT_G(x) (((x) >> T5_TFPORT_S) & T5_TFPORT_M)
+#define VF_S    0
+#define VF_M    0x7fU
+#define VF_G(x) (((x) >> VF_S) & VF_M)
 
-#define MPS_TRC_FILTER_MATCH_CTL_A_A 0x9810
-#define MPS_TRC_FILTER_MATCH_CTL_B_A 0x9820
+#define SRAM_PRIO3_S    22
+#define SRAM_PRIO3_M    0x7U
+#define SRAM_PRIO3_G(x) (((x) >> SRAM_PRIO3_S) & SRAM_PRIO3_M)
 
-#define TFMINPKTSIZE_S    16
-#define TFMINPKTSIZE_M    0x1ffU
-#define TFMINPKTSIZE_V(x) ((x) << TFMINPKTSIZE_S)
-#define TFMINPKTSIZE_G(x) (((x) >> TFMINPKTSIZE_S) & TFMINPKTSIZE_M)
+#define SRAM_PRIO2_S    19
+#define SRAM_PRIO2_M    0x7U
+#define SRAM_PRIO2_G(x) (((x) >> SRAM_PRIO2_S) & SRAM_PRIO2_M)
 
-#define TFCAPTUREMAX_S    0
-#define TFCAPTUREMAX_M    0x3fffU
-#define TFCAPTUREMAX_V(x) ((x) << TFCAPTUREMAX_S)
-#define TFCAPTUREMAX_G(x) (((x) >> TFCAPTUREMAX_S) & TFCAPTUREMAX_M)
+#define SRAM_PRIO1_S    16
+#define SRAM_PRIO1_M    0x7U
+#define SRAM_PRIO1_G(x) (((x) >> SRAM_PRIO1_S) & SRAM_PRIO1_M)
 
-#define MPS_TRC_FILTER0_MATCH_A 0x9c00
-#define MPS_TRC_FILTER0_DONT_CARE_A 0x9c80
-#define MPS_TRC_FILTER1_MATCH_A 0x9d00
+#define SRAM_PRIO0_S    13
+#define SRAM_PRIO0_M    0x7U
+#define SRAM_PRIO0_G(x) (((x) >> SRAM_PRIO0_S) & SRAM_PRIO0_M)
 
-#define TP_RSS_CONFIG_A 0x7df0
+#define SRAM_VLD_S    12
+#define SRAM_VLD_V(x) ((x) << SRAM_VLD_S)
+#define SRAM_VLD_F    SRAM_VLD_V(1U)
 
-#define TNL4TUPENIPV6_S    31
-#define TNL4TUPENIPV6_V(x) ((x) << TNL4TUPENIPV6_S)
-#define TNL4TUPENIPV6_F    TNL4TUPENIPV6_V(1U)
+#define PORTMAP_S    0
+#define PORTMAP_M    0xfU
+#define PORTMAP_G(x) (((x) >> PORTMAP_S) & PORTMAP_M)
 
-#define TNL2TUPENIPV6_S    30
-#define TNL2TUPENIPV6_V(x) ((x) << TNL2TUPENIPV6_S)
-#define TNL2TUPENIPV6_F    TNL2TUPENIPV6_V(1U)
+#define CPL_INTR_ENABLE_A 0x19050
+#define CPL_INTR_CAUSE_A 0x19054
 
-#define TNL4TUPENIPV4_S    29
-#define TNL4TUPENIPV4_V(x) ((x) << TNL4TUPENIPV4_S)
-#define TNL4TUPENIPV4_F    TNL4TUPENIPV4_V(1U)
+#define CIM_OP_MAP_PERR_S    5
+#define CIM_OP_MAP_PERR_V(x) ((x) << CIM_OP_MAP_PERR_S)
+#define CIM_OP_MAP_PERR_F    CIM_OP_MAP_PERR_V(1U)
 
-#define TNL2TUPENIPV4_S    28
-#define TNL2TUPENIPV4_V(x) ((x) << TNL2TUPENIPV4_S)
-#define TNL2TUPENIPV4_F    TNL2TUPENIPV4_V(1U)
+#define CIM_OVFL_ERROR_S    4
+#define CIM_OVFL_ERROR_V(x) ((x) << CIM_OVFL_ERROR_S)
+#define CIM_OVFL_ERROR_F    CIM_OVFL_ERROR_V(1U)
 
-#define TNLTCPSEL_S    27
-#define TNLTCPSEL_V(x) ((x) << TNLTCPSEL_S)
-#define TNLTCPSEL_F    TNLTCPSEL_V(1U)
+#define TP_FRAMING_ERROR_S    3
+#define TP_FRAMING_ERROR_V(x) ((x) << TP_FRAMING_ERROR_S)
+#define TP_FRAMING_ERROR_F    TP_FRAMING_ERROR_V(1U)
 
-#define TNLIP6SEL_S    26
-#define TNLIP6SEL_V(x) ((x) << TNLIP6SEL_S)
-#define TNLIP6SEL_F    TNLIP6SEL_V(1U)
+#define SGE_FRAMING_ERROR_S    2
+#define SGE_FRAMING_ERROR_V(x) ((x) << SGE_FRAMING_ERROR_S)
+#define SGE_FRAMING_ERROR_F    SGE_FRAMING_ERROR_V(1U)
 
-#define TNLVRTSEL_S    25
-#define TNLVRTSEL_V(x) ((x) << TNLVRTSEL_S)
-#define TNLVRTSEL_F    TNLVRTSEL_V(1U)
+#define CIM_FRAMING_ERROR_S    1
+#define CIM_FRAMING_ERROR_V(x) ((x) << CIM_FRAMING_ERROR_S)
+#define CIM_FRAMING_ERROR_F    CIM_FRAMING_ERROR_V(1U)
 
-#define TNLMAPEN_S    24
-#define TNLMAPEN_V(x) ((x) << TNLMAPEN_S)
-#define TNLMAPEN_F    TNLMAPEN_V(1U)
+#define ZERO_SWITCH_ERROR_S    0
+#define ZERO_SWITCH_ERROR_V(x) ((x) << ZERO_SWITCH_ERROR_S)
+#define ZERO_SWITCH_ERROR_F    ZERO_SWITCH_ERROR_V(1U)
 
-#define OFDHASHSAVE_S    19
-#define OFDHASHSAVE_V(x) ((x) << OFDHASHSAVE_S)
-#define OFDHASHSAVE_F    OFDHASHSAVE_V(1U)
+#define PERR_CPL_128TO128_1_S    7
+#define PERR_CPL_128TO128_1_V(x) ((x) << PERR_CPL_128TO128_1_S)
+#define PERR_CPL_128TO128_1_F    PERR_CPL_128TO128_1_V(1U)
 
-#define OFDVRTSEL_S    18
-#define OFDVRTSEL_V(x) ((x) << OFDVRTSEL_S)
-#define OFDVRTSEL_F    OFDVRTSEL_V(1U)
+#define PERR_CPL_128TO128_0_S    6
+#define PERR_CPL_128TO128_0_V(x) ((x) << PERR_CPL_128TO128_0_S)
+#define PERR_CPL_128TO128_0_F    PERR_CPL_128TO128_0_V(1U)
 
-#define OFDMAPEN_S    17
-#define OFDMAPEN_V(x) ((x) << OFDMAPEN_S)
-#define OFDMAPEN_F    OFDMAPEN_V(1U)
+#define PERR_CPL_128TO128_3_S    9
+#define PERR_CPL_128TO128_3_V(x) ((x) << PERR_CPL_128TO128_3_S)
+#define PERR_CPL_128TO128_3_F    PERR_CPL_128TO128_3_V(1U)
 
-#define OFDLKPEN_S    16
-#define OFDLKPEN_V(x) ((x) << OFDLKPEN_S)
-#define OFDLKPEN_F    OFDLKPEN_V(1U)
+#define PERR_CPL_128TO128_2_S    8
+#define PERR_CPL_128TO128_2_V(x) ((x) << PERR_CPL_128TO128_2_S)
+#define PERR_CPL_128TO128_2_F    PERR_CPL_128TO128_2_V(1U)
 
-#define SYN4TUPENIPV6_S    15
-#define SYN4TUPENIPV6_V(x) ((x) << SYN4TUPENIPV6_S)
-#define SYN4TUPENIPV6_F    SYN4TUPENIPV6_V(1U)
+#define SMB_INT_ENABLE_A 0x1908c
+#define SMB_INT_CAUSE_A 0x19090
 
-#define SYN2TUPENIPV6_S    14
-#define SYN2TUPENIPV6_V(x) ((x) << SYN2TUPENIPV6_S)
-#define SYN2TUPENIPV6_F    SYN2TUPENIPV6_V(1U)
+#define MSTTXFIFOPARINT_S    21
+#define MSTTXFIFOPARINT_V(x) ((x) << MSTTXFIFOPARINT_S)
+#define MSTTXFIFOPARINT_F    MSTTXFIFOPARINT_V(1U)
 
-#define SYN4TUPENIPV4_S    13
-#define SYN4TUPENIPV4_V(x) ((x) << SYN4TUPENIPV4_S)
-#define SYN4TUPENIPV4_F    SYN4TUPENIPV4_V(1U)
+#define MSTRXFIFOPARINT_S    20
+#define MSTRXFIFOPARINT_V(x) ((x) << MSTRXFIFOPARINT_S)
+#define MSTRXFIFOPARINT_F    MSTRXFIFOPARINT_V(1U)
 
-#define SYN2TUPENIPV4_S    12
-#define SYN2TUPENIPV4_V(x) ((x) << SYN2TUPENIPV4_S)
-#define SYN2TUPENIPV4_F    SYN2TUPENIPV4_V(1U)
+#define SLVFIFOPARINT_S    19
+#define SLVFIFOPARINT_V(x) ((x) << SLVFIFOPARINT_S)
+#define SLVFIFOPARINT_F    SLVFIFOPARINT_V(1U)
 
-#define SYNIP6SEL_S    11
-#define SYNIP6SEL_V(x) ((x) << SYNIP6SEL_S)
-#define SYNIP6SEL_F    SYNIP6SEL_V(1U)
+#define SLVUNEXPBUSSTOPINT_S    18
+#define SLVUNEXPBUSSTOPINT_V(x) ((x) << SLVUNEXPBUSSTOPINT_S)
+#define SLVUNEXPBUSSTOPINT_F    SLVUNEXPBUSSTOPINT_V(1U)
 
-#define SYNVRTSEL_S    10
-#define SYNVRTSEL_V(x) ((x) << SYNVRTSEL_S)
-#define SYNVRTSEL_F    SYNVRTSEL_V(1U)
+#define SLVUNEXPBUSSTARTINT_S    17
+#define SLVUNEXPBUSSTARTINT_V(x) ((x) << SLVUNEXPBUSSTARTINT_S)
+#define SLVUNEXPBUSSTARTINT_F    SLVUNEXPBUSSTARTINT_V(1U)
 
-#define SYNMAPEN_S    9
-#define SYNMAPEN_V(x) ((x) << SYNMAPEN_S)
-#define SYNMAPEN_F    SYNMAPEN_V(1U)
+#define SLVCOMMANDCODEINVINT_S    16
+#define SLVCOMMANDCODEINVINT_V(x) ((x) << SLVCOMMANDCODEINVINT_S)
+#define SLVCOMMANDCODEINVINT_F    SLVCOMMANDCODEINVINT_V(1U)
 
-#define SYNLKPEN_S    8
-#define SYNLKPEN_V(x) ((x) << SYNLKPEN_S)
-#define SYNLKPEN_F    SYNLKPEN_V(1U)
+#define SLVBYTECNTERRINT_S    15
+#define SLVBYTECNTERRINT_V(x) ((x) << SLVBYTECNTERRINT_S)
+#define SLVBYTECNTERRINT_F    SLVBYTECNTERRINT_V(1U)
 
-#define CHANNELENABLE_S    7
-#define CHANNELENABLE_V(x) ((x) << CHANNELENABLE_S)
-#define CHANNELENABLE_F    CHANNELENABLE_V(1U)
+#define SLVUNEXPACKMSTINT_S    14
+#define SLVUNEXPACKMSTINT_V(x) ((x) << SLVUNEXPACKMSTINT_S)
+#define SLVUNEXPACKMSTINT_F    SLVUNEXPACKMSTINT_V(1U)
 
-#define PORTENABLE_S    6
-#define PORTENABLE_V(x) ((x) << PORTENABLE_S)
-#define PORTENABLE_F    PORTENABLE_V(1U)
+#define SLVUNEXPNACKMSTINT_S    13
+#define SLVUNEXPNACKMSTINT_V(x) ((x) << SLVUNEXPNACKMSTINT_S)
+#define SLVUNEXPNACKMSTINT_F    SLVUNEXPNACKMSTINT_V(1U)
 
-#define TNLALLLOOKUP_S    5
-#define TNLALLLOOKUP_V(x) ((x) << TNLALLLOOKUP_S)
-#define TNLALLLOOKUP_F    TNLALLLOOKUP_V(1U)
+#define SLVNOBUSSTOPINT_S    12
+#define SLVNOBUSSTOPINT_V(x) ((x) << SLVNOBUSSTOPINT_S)
+#define SLVNOBUSSTOPINT_F    SLVNOBUSSTOPINT_V(1U)
 
-#define VIRTENABLE_S    4
-#define VIRTENABLE_V(x) ((x) << VIRTENABLE_S)
-#define VIRTENABLE_F    VIRTENABLE_V(1U)
+#define SLVNOREPSTARTINT_S    11
+#define SLVNOREPSTARTINT_V(x) ((x) << SLVNOREPSTARTINT_S)
+#define SLVNOREPSTARTINT_F    SLVNOREPSTARTINT_V(1U)
 
-#define CONGESTIONENABLE_S    3
-#define CONGESTIONENABLE_V(x) ((x) << CONGESTIONENABLE_S)
-#define CONGESTIONENABLE_F    CONGESTIONENABLE_V(1U)
+#define SLVRXADDRINT_S    10
+#define SLVRXADDRINT_V(x) ((x) << SLVRXADDRINT_S)
+#define SLVRXADDRINT_F    SLVRXADDRINT_V(1U)
 
-#define HASHTOEPLITZ_S    2
-#define HASHTOEPLITZ_V(x) ((x) << HASHTOEPLITZ_S)
-#define HASHTOEPLITZ_F    HASHTOEPLITZ_V(1U)
+#define SLVRXPECERRINT_S    9
+#define SLVRXPECERRINT_V(x) ((x) << SLVRXPECERRINT_S)
+#define SLVRXPECERRINT_F    SLVRXPECERRINT_V(1U)
 
-#define UDPENABLE_S    1
-#define UDPENABLE_V(x) ((x) << UDPENABLE_S)
-#define UDPENABLE_F    UDPENABLE_V(1U)
+#define SLVPREPTOARPINT_S    8
+#define SLVPREPTOARPINT_V(x) ((x) << SLVPREPTOARPINT_S)
+#define SLVPREPTOARPINT_F    SLVPREPTOARPINT_V(1U)
 
-#define DISABLE_S    0
-#define DISABLE_V(x) ((x) << DISABLE_S)
-#define DISABLE_F    DISABLE_V(1U)
+#define SLVTIMEOUTINT_S    7
+#define SLVTIMEOUTINT_V(x) ((x) << SLVTIMEOUTINT_S)
+#define SLVTIMEOUTINT_F    SLVTIMEOUTINT_V(1U)
 
-#define TP_RSS_CONFIG_TNL_A 0x7df4
+#define SLVERRINT_S    6
+#define SLVERRINT_V(x) ((x) << SLVERRINT_S)
+#define SLVERRINT_F    SLVERRINT_V(1U)
 
-#define MASKSIZE_S    28
-#define MASKSIZE_M    0xfU
-#define MASKSIZE_V(x) ((x) << MASKSIZE_S)
-#define MASKSIZE_G(x) (((x) >> MASKSIZE_S) & MASKSIZE_M)
+#define SLVDONEINT_S    5
+#define SLVDONEINT_V(x) ((x) << SLVDONEINT_S)
+#define SLVDONEINT_F    SLVDONEINT_V(1U)
 
-#define MASKFILTER_S    16
-#define MASKFILTER_M    0x7ffU
-#define MASKFILTER_V(x) ((x) << MASKFILTER_S)
-#define MASKFILTER_G(x) (((x) >> MASKFILTER_S) & MASKFILTER_M)
+#define SLVRXRDYINT_S    4
+#define SLVRXRDYINT_V(x) ((x) << SLVRXRDYINT_S)
+#define SLVRXRDYINT_F    SLVRXRDYINT_V(1U)
 
-#define USEWIRECH_S    0
-#define USEWIRECH_V(x) ((x) << USEWIRECH_S)
-#define USEWIRECH_F    USEWIRECH_V(1U)
+#define MSTTIMEOUTINT_S    3
+#define MSTTIMEOUTINT_V(x) ((x) << MSTTIMEOUTINT_S)
+#define MSTTIMEOUTINT_F    MSTTIMEOUTINT_V(1U)
 
-#define HASHALL_S    2
-#define HASHALL_V(x) ((x) << HASHALL_S)
-#define HASHALL_F    HASHALL_V(1U)
+#define MSTNACKINT_S    2
+#define MSTNACKINT_V(x) ((x) << MSTNACKINT_S)
+#define MSTNACKINT_F    MSTNACKINT_V(1U)
 
-#define HASHETH_S    1
-#define HASHETH_V(x) ((x) << HASHETH_S)
-#define HASHETH_F    HASHETH_V(1U)
+#define MSTLOSTARBINT_S    1
+#define MSTLOSTARBINT_V(x) ((x) << MSTLOSTARBINT_S)
+#define MSTLOSTARBINT_F    MSTLOSTARBINT_V(1U)
 
-#define TP_RSS_CONFIG_OFD_A 0x7df8
+#define MSTDONEINT_S    0
+#define MSTDONEINT_V(x) ((x) << MSTDONEINT_S)
+#define MSTDONEINT_F    MSTDONEINT_V(1U)
 
-#define RRCPLMAPEN_S    20
-#define RRCPLMAPEN_V(x) ((x) << RRCPLMAPEN_S)
-#define RRCPLMAPEN_F    RRCPLMAPEN_V(1U)
+#define ULP_RX_INT_ENABLE_A 0x19154
+#define ULP_RX_INT_CAUSE_A 0x19158
 
-#define RRCPLQUEWIDTH_S    16
-#define RRCPLQUEWIDTH_M    0xfU
-#define RRCPLQUEWIDTH_V(x) ((x) << RRCPLQUEWIDTH_S)
-#define RRCPLQUEWIDTH_G(x) (((x) >> RRCPLQUEWIDTH_S) & RRCPLQUEWIDTH_M)
+#define CAUSE_CTX_1_S    24
+#define CAUSE_CTX_1_V(x) ((x) << CAUSE_CTX_1_S)
+#define CAUSE_CTX_1_F    CAUSE_CTX_1_V(1U)
 
-#define TP_RSS_CONFIG_SYN_A 0x7dfc
-#define TP_RSS_CONFIG_VRT_A 0x7e00
+#define CAUSE_CTX_0_S    23
+#define CAUSE_CTX_0_V(x) ((x) << CAUSE_CTX_0_S)
+#define CAUSE_CTX_0_F    CAUSE_CTX_0_V(1U)
 
-#define VFRDRG_S    25
-#define VFRDRG_V(x) ((x) << VFRDRG_S)
-#define VFRDRG_F    VFRDRG_V(1U)
+#define CAUSE_FF_S    22
+#define CAUSE_FF_V(x) ((x) << CAUSE_FF_S)
+#define CAUSE_FF_F    CAUSE_FF_V(1U)
 
-#define VFRDEN_S    24
-#define VFRDEN_V(x) ((x) << VFRDEN_S)
-#define VFRDEN_F    VFRDEN_V(1U)
+#define CAUSE_APF_1_S    21
+#define CAUSE_APF_1_V(x) ((x) << CAUSE_APF_1_S)
+#define CAUSE_APF_1_F    CAUSE_APF_1_V(1U)
 
-#define VFPERREN_S    23
-#define VFPERREN_V(x) ((x) << VFPERREN_S)
-#define VFPERREN_F    VFPERREN_V(1U)
+#define CAUSE_APF_0_S    20
+#define CAUSE_APF_0_V(x) ((x) << CAUSE_APF_0_S)
+#define CAUSE_APF_0_F    CAUSE_APF_0_V(1U)
 
-#define KEYPERREN_S    22
-#define KEYPERREN_V(x) ((x) << KEYPERREN_S)
-#define KEYPERREN_F    KEYPERREN_V(1U)
+#define CAUSE_AF_1_S    19
+#define CAUSE_AF_1_V(x) ((x) << CAUSE_AF_1_S)
+#define CAUSE_AF_1_F    CAUSE_AF_1_V(1U)
 
-#define DISABLEVLAN_S    21
-#define DISABLEVLAN_V(x) ((x) << DISABLEVLAN_S)
-#define DISABLEVLAN_F    DISABLEVLAN_V(1U)
+#define CAUSE_AF_0_S    18
+#define CAUSE_AF_0_V(x) ((x) << CAUSE_AF_0_S)
+#define CAUSE_AF_0_F    CAUSE_AF_0_V(1U)
 
-#define ENABLEUP0_S    20
-#define ENABLEUP0_V(x) ((x) << ENABLEUP0_S)
-#define ENABLEUP0_F    ENABLEUP0_V(1U)
+#define CAUSE_DDPDF_1_S    17
+#define CAUSE_DDPDF_1_V(x) ((x) << CAUSE_DDPDF_1_S)
+#define CAUSE_DDPDF_1_F    CAUSE_DDPDF_1_V(1U)
 
-#define HASHDELAY_S    16
-#define HASHDELAY_M    0xfU
-#define HASHDELAY_V(x) ((x) << HASHDELAY_S)
-#define HASHDELAY_G(x) (((x) >> HASHDELAY_S) & HASHDELAY_M)
+#define CAUSE_DDPMF_1_S    16
+#define CAUSE_DDPMF_1_V(x) ((x) << CAUSE_DDPMF_1_S)
+#define CAUSE_DDPMF_1_F    CAUSE_DDPMF_1_V(1U)
 
-#define VFWRADDR_S    8
-#define VFWRADDR_M    0x7fU
-#define VFWRADDR_V(x) ((x) << VFWRADDR_S)
-#define VFWRADDR_G(x) (((x) >> VFWRADDR_S) & VFWRADDR_M)
+#define CAUSE_MEMRF_1_S    15
+#define CAUSE_MEMRF_1_V(x) ((x) << CAUSE_MEMRF_1_S)
+#define CAUSE_MEMRF_1_F    CAUSE_MEMRF_1_V(1U)
 
-#define KEYMODE_S    6
-#define KEYMODE_M    0x3U
-#define KEYMODE_V(x) ((x) << KEYMODE_S)
-#define KEYMODE_G(x) (((x) >> KEYMODE_S) & KEYMODE_M)
+#define CAUSE_PRSDF_1_S    14
+#define CAUSE_PRSDF_1_V(x) ((x) << CAUSE_PRSDF_1_S)
+#define CAUSE_PRSDF_1_F    CAUSE_PRSDF_1_V(1U)
 
-#define VFWREN_S    5
-#define VFWREN_V(x) ((x) << VFWREN_S)
-#define VFWREN_F    VFWREN_V(1U)
+#define CAUSE_DDPDF_0_S    13
+#define CAUSE_DDPDF_0_V(x) ((x) << CAUSE_DDPDF_0_S)
+#define CAUSE_DDPDF_0_F    CAUSE_DDPDF_0_V(1U)
 
-#define KEYWREN_S    4
-#define KEYWREN_V(x) ((x) << KEYWREN_S)
-#define KEYWREN_F    KEYWREN_V(1U)
+#define CAUSE_DDPMF_0_S    12
+#define CAUSE_DDPMF_0_V(x) ((x) << CAUSE_DDPMF_0_S)
+#define CAUSE_DDPMF_0_F    CAUSE_DDPMF_0_V(1U)
 
-#define KEYWRADDR_S    0
-#define KEYWRADDR_M    0xfU
-#define KEYWRADDR_V(x) ((x) << KEYWRADDR_S)
-#define KEYWRADDR_G(x) (((x) >> KEYWRADDR_S) & KEYWRADDR_M)
+#define CAUSE_MEMRF_0_S    11
+#define CAUSE_MEMRF_0_V(x) ((x) << CAUSE_MEMRF_0_S)
+#define CAUSE_MEMRF_0_F    CAUSE_MEMRF_0_V(1U)
 
-#define KEYWRADDRX_S    30
-#define KEYWRADDRX_M    0x3U
-#define KEYWRADDRX_V(x) ((x) << KEYWRADDRX_S)
-#define KEYWRADDRX_G(x) (((x) >> KEYWRADDRX_S) & KEYWRADDRX_M)
+#define CAUSE_PRSDF_0_S    10
+#define CAUSE_PRSDF_0_V(x) ((x) << CAUSE_PRSDF_0_S)
+#define CAUSE_PRSDF_0_F    CAUSE_PRSDF_0_V(1U)
 
-#define KEYEXTEND_S    26
-#define KEYEXTEND_V(x) ((x) << KEYEXTEND_S)
-#define KEYEXTEND_F    KEYEXTEND_V(1U)
+#define CAUSE_PCMDF_1_S    9
+#define CAUSE_PCMDF_1_V(x) ((x) << CAUSE_PCMDF_1_S)
+#define CAUSE_PCMDF_1_F    CAUSE_PCMDF_1_V(1U)
 
-#define LKPIDXSIZE_S    24
-#define LKPIDXSIZE_M    0x3U
-#define LKPIDXSIZE_V(x) ((x) << LKPIDXSIZE_S)
-#define LKPIDXSIZE_G(x) (((x) >> LKPIDXSIZE_S) & LKPIDXSIZE_M)
+#define CAUSE_TPTCF_1_S    8
+#define CAUSE_TPTCF_1_V(x) ((x) << CAUSE_TPTCF_1_S)
+#define CAUSE_TPTCF_1_F    CAUSE_TPTCF_1_V(1U)
 
-#define TP_RSS_VFL_CONFIG_A 0x3a
-#define TP_RSS_VFH_CONFIG_A 0x3b
+#define CAUSE_DDPCF_1_S    7
+#define CAUSE_DDPCF_1_V(x) ((x) << CAUSE_DDPCF_1_S)
+#define CAUSE_DDPCF_1_F    CAUSE_DDPCF_1_V(1U)
 
-#define ENABLEUDPHASH_S    31
-#define ENABLEUDPHASH_V(x) ((x) << ENABLEUDPHASH_S)
-#define ENABLEUDPHASH_F    ENABLEUDPHASH_V(1U)
+#define CAUSE_MPARF_1_S    6
+#define CAUSE_MPARF_1_V(x) ((x) << CAUSE_MPARF_1_S)
+#define CAUSE_MPARF_1_F    CAUSE_MPARF_1_V(1U)
 
-#define VFUPEN_S    30
-#define VFUPEN_V(x) ((x) << VFUPEN_S)
-#define VFUPEN_F    VFUPEN_V(1U)
+#define CAUSE_MPARC_1_S    5
+#define CAUSE_MPARC_1_V(x) ((x) << CAUSE_MPARC_1_S)
+#define CAUSE_MPARC_1_F    CAUSE_MPARC_1_V(1U)
 
-#define VFVLNEX_S    28
-#define VFVLNEX_V(x) ((x) << VFVLNEX_S)
-#define VFVLNEX_F    VFVLNEX_V(1U)
+#define CAUSE_PCMDF_0_S    4
+#define CAUSE_PCMDF_0_V(x) ((x) << CAUSE_PCMDF_0_S)
+#define CAUSE_PCMDF_0_F    CAUSE_PCMDF_0_V(1U)
 
-#define VFPRTEN_S    27
-#define VFPRTEN_V(x) ((x) << VFPRTEN_S)
-#define VFPRTEN_F    VFPRTEN_V(1U)
+#define CAUSE_TPTCF_0_S    3
+#define CAUSE_TPTCF_0_V(x) ((x) << CAUSE_TPTCF_0_S)
+#define CAUSE_TPTCF_0_F    CAUSE_TPTCF_0_V(1U)
 
-#define VFCHNEN_S    26
-#define VFCHNEN_V(x) ((x) << VFCHNEN_S)
-#define VFCHNEN_F    VFCHNEN_V(1U)
+#define CAUSE_DDPCF_0_S    2
+#define CAUSE_DDPCF_0_V(x) ((x) << CAUSE_DDPCF_0_S)
+#define CAUSE_DDPCF_0_F    CAUSE_DDPCF_0_V(1U)
 
-#define DEFAULTQUEUE_S    16
-#define DEFAULTQUEUE_M    0x3ffU
-#define DEFAULTQUEUE_G(x) (((x) >> DEFAULTQUEUE_S) & DEFAULTQUEUE_M)
+#define CAUSE_MPARF_0_S    1
+#define CAUSE_MPARF_0_V(x) ((x) << CAUSE_MPARF_0_S)
+#define CAUSE_MPARF_0_F    CAUSE_MPARF_0_V(1U)
 
-#define VFIP6TWOTUPEN_S    6
-#define VFIP6TWOTUPEN_V(x) ((x) << VFIP6TWOTUPEN_S)
-#define VFIP6TWOTUPEN_F    VFIP6TWOTUPEN_V(1U)
+#define CAUSE_MPARC_0_S    0
+#define CAUSE_MPARC_0_V(x) ((x) << CAUSE_MPARC_0_S)
+#define CAUSE_MPARC_0_F    CAUSE_MPARC_0_V(1U)
 
-#define VFIP4FOURTUPEN_S    5
-#define VFIP4FOURTUPEN_V(x) ((x) << VFIP4FOURTUPEN_S)
-#define VFIP4FOURTUPEN_F    VFIP4FOURTUPEN_V(1U)
+#define SE_CNT_MISMATCH_1_S    26
+#define SE_CNT_MISMATCH_1_V(x) ((x) << SE_CNT_MISMATCH_1_S)
+#define SE_CNT_MISMATCH_1_F    SE_CNT_MISMATCH_1_V(1U)
 
-#define VFIP4TWOTUPEN_S    4
-#define VFIP4TWOTUPEN_V(x) ((x) << VFIP4TWOTUPEN_S)
-#define VFIP4TWOTUPEN_F    VFIP4TWOTUPEN_V(1U)
+#define SE_CNT_MISMATCH_0_S    25
+#define SE_CNT_MISMATCH_0_V(x) ((x) << SE_CNT_MISMATCH_0_S)
+#define SE_CNT_MISMATCH_0_F    SE_CNT_MISMATCH_0_V(1U)
 
-#define KEYINDEX_S    0
-#define KEYINDEX_M    0xfU
-#define KEYINDEX_G(x) (((x) >> KEYINDEX_S) & KEYINDEX_M)
+#define CERR_PCMD_FIFO_3_S    19
+#define CERR_PCMD_FIFO_3_V(x) ((x) << CERR_PCMD_FIFO_3_S)
+#define CERR_PCMD_FIFO_3_F    CERR_PCMD_FIFO_3_V(1U)
 
-#define MAPENABLE_S    31
-#define MAPENABLE_V(x) ((x) << MAPENABLE_S)
-#define MAPENABLE_F    MAPENABLE_V(1U)
+#define CERR_PCMD_FIFO_2_S    18
+#define CERR_PCMD_FIFO_2_V(x) ((x) << CERR_PCMD_FIFO_2_S)
+#define CERR_PCMD_FIFO_2_F    CERR_PCMD_FIFO_2_V(1U)
 
-#define CHNENABLE_S    30
-#define CHNENABLE_V(x) ((x) << CHNENABLE_S)
-#define CHNENABLE_F    CHNENABLE_V(1U)
+#define CERR_PCMD_FIFO_1_S    17
+#define CERR_PCMD_FIFO_1_V(x) ((x) << CERR_PCMD_FIFO_1_S)
+#define CERR_PCMD_FIFO_1_F    CERR_PCMD_FIFO_1_V(1U)
 
-#define LE_DB_DBGI_CONFIG_A 0x19cf0
+#define CERR_PCMD_FIFO_0_S    16
+#define CERR_PCMD_FIFO_0_V(x) ((x) << CERR_PCMD_FIFO_0_S)
+#define CERR_PCMD_FIFO_0_F    CERR_PCMD_FIFO_0_V(1U)
 
-#define DBGICMDBUSY_S    3
-#define DBGICMDBUSY_V(x) ((x) << DBGICMDBUSY_S)
-#define DBGICMDBUSY_F    DBGICMDBUSY_V(1U)
+#define CERR_DATA_FIFO_3_S    15
+#define CERR_DATA_FIFO_3_V(x) ((x) << CERR_DATA_FIFO_3_S)
+#define CERR_DATA_FIFO_3_F    CERR_DATA_FIFO_3_V(1U)
 
-#define DBGICMDSTRT_S    2
-#define DBGICMDSTRT_V(x) ((x) << DBGICMDSTRT_S)
-#define DBGICMDSTRT_F    DBGICMDSTRT_V(1U)
+#define CERR_DATA_FIFO_2_S    14
+#define CERR_DATA_FIFO_2_V(x) ((x) << CERR_DATA_FIFO_2_S)
+#define CERR_DATA_FIFO_2_F    CERR_DATA_FIFO_2_V(1U)
 
-#define DBGICMDMODE_S    0
-#define DBGICMDMODE_M    0x3U
-#define DBGICMDMODE_V(x) ((x) << DBGICMDMODE_S)
+#define CERR_DATA_FIFO_1_S    13
+#define CERR_DATA_FIFO_1_V(x) ((x) << CERR_DATA_FIFO_1_S)
+#define CERR_DATA_FIFO_1_F    CERR_DATA_FIFO_1_V(1U)
 
-#define LE_DB_DBGI_REQ_TCAM_CMD_A 0x19cf4
+#define CERR_DATA_FIFO_0_S    12
+#define CERR_DATA_FIFO_0_V(x) ((x) << CERR_DATA_FIFO_0_S)
+#define CERR_DATA_FIFO_0_F    CERR_DATA_FIFO_0_V(1U)
 
-#define DBGICMD_S    20
-#define DBGICMD_M    0xfU
-#define DBGICMD_V(x) ((x) << DBGICMD_S)
+#define SE_CNT_MISMATCH_3_S    11
+#define SE_CNT_MISMATCH_3_V(x) ((x) << SE_CNT_MISMATCH_3_S)
+#define SE_CNT_MISMATCH_3_F    SE_CNT_MISMATCH_3_V(1U)
 
-#define DBGITID_S    0
-#define DBGITID_M    0xfffffU
-#define DBGITID_V(x) ((x) << DBGITID_S)
+#define SE_CNT_MISMATCH_2_S    10
+#define SE_CNT_MISMATCH_2_V(x) ((x) << SE_CNT_MISMATCH_2_S)
+#define SE_CNT_MISMATCH_2_F    SE_CNT_MISMATCH_2_V(1U)
 
-#define LE_DB_DBGI_REQ_DATA_A 0x19d00
-#define LE_DB_DBGI_RSP_STATUS_A 0x19d94
+#define T7_SE_CNT_MISMATCH_1_S    9
+#define T7_SE_CNT_MISMATCH_1_V(x) ((x) << T7_SE_CNT_MISMATCH_1_S)
+#define T7_SE_CNT_MISMATCH_1_F    T7_SE_CNT_MISMATCH_1_V(1U)
 
-#define LE_DB_DBGI_RSP_DATA_A 0x19da0
+#define T7_SE_CNT_MISMATCH_0_S    8
+#define T7_SE_CNT_MISMATCH_0_V(x) ((x) << T7_SE_CNT_MISMATCH_0_S)
+#define T7_SE_CNT_MISMATCH_0_F    T7_SE_CNT_MISMATCH_0_V(1U)
 
-#define PRTENABLE_S    29
-#define PRTENABLE_V(x) ((x) << PRTENABLE_S)
-#define PRTENABLE_F    PRTENABLE_V(1U)
+#define T7_ENABLE_CTX_3_S    7
+#define T7_ENABLE_CTX_3_V(x) ((x) << T7_ENABLE_CTX_3_S)
+#define T7_ENABLE_CTX_3_F    T7_ENABLE_CTX_3_V(1U)
 
-#define UDPFOURTUPEN_S    28
-#define UDPFOURTUPEN_V(x) ((x) << UDPFOURTUPEN_S)
-#define UDPFOURTUPEN_F    UDPFOURTUPEN_V(1U)
+#define T7_ENABLE_CTX_2_S    6
+#define T7_ENABLE_CTX_2_V(x) ((x) << T7_ENABLE_CTX_2_S)
+#define T7_ENABLE_CTX_2_F    T7_ENABLE_CTX_2_V(1U)
 
-#define IP6FOURTUPEN_S    27
-#define IP6FOURTUPEN_V(x) ((x) << IP6FOURTUPEN_S)
-#define IP6FOURTUPEN_F    IP6FOURTUPEN_V(1U)
+#define T7_ENABLE_CTX_1_S    5
+#define T7_ENABLE_CTX_1_V(x) ((x) << T7_ENABLE_CTX_1_S)
+#define T7_ENABLE_CTX_1_F    T7_ENABLE_CTX_1_V(1U)
 
-#define IP6TWOTUPEN_S    26
-#define IP6TWOTUPEN_V(x) ((x) << IP6TWOTUPEN_S)
-#define IP6TWOTUPEN_F    IP6TWOTUPEN_V(1U)
+#define T7_ENABLE_CTX_0_S    4
+#define T7_ENABLE_CTX_0_V(x) ((x) << T7_ENABLE_CTX_0_S)
+#define T7_ENABLE_CTX_0_F    T7_ENABLE_CTX_0_V(1U)
 
-#define IP4FOURTUPEN_S    25
-#define IP4FOURTUPEN_V(x) ((x) << IP4FOURTUPEN_S)
-#define IP4FOURTUPEN_F    IP4FOURTUPEN_V(1U)
+#define T7_ENABLE_ALN_SDC_ERR_3_S    3
+#define T7_ENABLE_ALN_SDC_ERR_3_V(x) ((x) << T7_ENABLE_ALN_SDC_ERR_3_S)
+#define T7_ENABLE_ALN_SDC_ERR_3_F    T7_ENABLE_ALN_SDC_ERR_3_V(1U)
 
-#define IP4TWOTUPEN_S    24
-#define IP4TWOTUPEN_V(x) ((x) << IP4TWOTUPEN_S)
-#define IP4TWOTUPEN_F    IP4TWOTUPEN_V(1U)
+#define T7_ENABLE_ALN_SDC_ERR_2_S    2
+#define T7_ENABLE_ALN_SDC_ERR_2_V(x) ((x) << T7_ENABLE_ALN_SDC_ERR_2_S)
+#define T7_ENABLE_ALN_SDC_ERR_2_F    T7_ENABLE_ALN_SDC_ERR_2_V(1U)
 
-#define IVFWIDTH_S    20
-#define IVFWIDTH_M    0xfU
-#define IVFWIDTH_V(x) ((x) << IVFWIDTH_S)
-#define IVFWIDTH_G(x) (((x) >> IVFWIDTH_S) & IVFWIDTH_M)
+#define T7_ENABLE_ALN_SDC_ERR_1_S    1
+#define T7_ENABLE_ALN_SDC_ERR_1_V(x) ((x) << T7_ENABLE_ALN_SDC_ERR_1_S)
+#define T7_ENABLE_ALN_SDC_ERR_1_F    T7_ENABLE_ALN_SDC_ERR_1_V(1U)
 
-#define CH1DEFAULTQUEUE_S    10
-#define CH1DEFAULTQUEUE_M    0x3ffU
-#define CH1DEFAULTQUEUE_V(x) ((x) << CH1DEFAULTQUEUE_S)
-#define CH1DEFAULTQUEUE_G(x) (((x) >> CH1DEFAULTQUEUE_S) & CH1DEFAULTQUEUE_M)
+#define T7_ENABLE_ALN_SDC_ERR_0_S    0
+#define T7_ENABLE_ALN_SDC_ERR_0_V(x) ((x) << T7_ENABLE_ALN_SDC_ERR_0_S)
+#define T7_ENABLE_ALN_SDC_ERR_0_F    T7_ENABLE_ALN_SDC_ERR_0_V(1U)
 
-#define CH0DEFAULTQUEUE_S    0
-#define CH0DEFAULTQUEUE_M    0x3ffU
-#define CH0DEFAULTQUEUE_V(x) ((x) << CH0DEFAULTQUEUE_S)
-#define CH0DEFAULTQUEUE_G(x) (((x) >> CH0DEFAULTQUEUE_S) & CH0DEFAULTQUEUE_M)
+#define ULP_RX_ISCSI_LLIMIT_A 0x1915c
+#define ULP_RX_ISCSI_ULIMIT_A 0x19160
+#define ULP_RX_ISCSI_TAGMASK_A 0x19164
+#define ULP_RX_ISCSI_PSZ_A 0x19168
+#define ULP_RX_TDDP_LLIMIT_A 0x1916c
+#define ULP_RX_TDDP_ULIMIT_A 0x19170
+#define ULP_RX_STAG_LLIMIT_A 0x1917c
+#define ULP_RX_STAG_ULIMIT_A 0x19180
+#define ULP_RX_RQ_LLIMIT_A 0x19184
+#define ULP_RX_RQ_ULIMIT_A 0x19188
+#define ULP_RX_PBL_LLIMIT_A 0x1918c
+#define ULP_RX_PBL_ULIMIT_A 0x19190
+#define ULP_RX_CTX_BASE_A 0x19194
+#define ULP_RX_RQUDP_LLIMIT_A 0x191a4
+#define ULP_RX_RQUDP_ULIMIT_A 0x191a8
+#define ULP_RX_LA_CTL_A 0x1923c
+#define ULP_RX_LA_RDPTR_A 0x19240
+#define ULP_RX_LA_RDDATA_A 0x19244
+#define ULP_RX_LA_WRPTR_A 0x19248
+#define ULP_RX_TLS_KEY_LLIMIT_A 0x192ac
+#define ULP_RX_TLS_KEY_ULIMIT_A 0x192b0
 
-#define VFLKPIDX_S    8
-#define VFLKPIDX_M    0xffU
-#define VFLKPIDX_G(x) (((x) >> VFLKPIDX_S) & VFLKPIDX_M)
+#define ULP_RX_INT_ENABLE_INTERFACE_A 0x191c0
+#define ULP_RX_INT_CAUSE_INTERFACE_A 0x191c4
 
-#define T6_VFWRADDR_S    8
-#define T6_VFWRADDR_M    0xffU
-#define T6_VFWRADDR_V(x) ((x) << T6_VFWRADDR_S)
-#define T6_VFWRADDR_G(x) (((x) >> T6_VFWRADDR_S) & T6_VFWRADDR_M)
+#define CAUSE_ULPRX2SBT_RSPPERR_S    31
+#define CAUSE_ULPRX2SBT_RSPPERR_V(x) ((x) << CAUSE_ULPRX2SBT_RSPPERR_S)
+#define CAUSE_ULPRX2SBT_RSPPERR_F    CAUSE_ULPRX2SBT_RSPPERR_V(1U)
 
-#define TP_RSS_CONFIG_CNG_A 0x7e04
-#define TP_RSS_SECRET_KEY0_A 0x40
-#define TP_RSS_PF0_CONFIG_A 0x30
-#define TP_RSS_PF_MAP_A 0x38
-#define TP_RSS_PF_MSK_A 0x39
+#define CAUSE_ULPRX2MA_RSPPERR_S    30
+#define CAUSE_ULPRX2MA_RSPPERR_V(x) ((x) << CAUSE_ULPRX2MA_RSPPERR_S)
+#define CAUSE_ULPRX2MA_RSPPERR_F    CAUSE_ULPRX2MA_RSPPERR_V(1U)
 
-#define PF1LKPIDX_S    3
+#define CAUSE_PIO_BUS_PERR_S    29
+#define CAUSE_PIO_BUS_PERR_V(x) ((x) << CAUSE_PIO_BUS_PERR_S)
+#define CAUSE_PIO_BUS_PERR_F    CAUSE_PIO_BUS_PERR_V(1U)
 
-#define PF0LKPIDX_M    0x7U
+#define CAUSE_PM2ULP_SNOOPDATA_3_S    19
+#define CAUSE_PM2ULP_SNOOPDATA_3_V(x) ((x) << CAUSE_PM2ULP_SNOOPDATA_3_S)
+#define CAUSE_PM2ULP_SNOOPDATA_3_F    CAUSE_PM2ULP_SNOOPDATA_3_V(1U)
 
-#define PF1MSKSIZE_S    4
-#define PF1MSKSIZE_M    0xfU
+#define CAUSE_PM2ULP_SNOOPDATA_2_S    18
+#define CAUSE_PM2ULP_SNOOPDATA_2_V(x) ((x) << CAUSE_PM2ULP_SNOOPDATA_2_S)
+#define CAUSE_PM2ULP_SNOOPDATA_2_F    CAUSE_PM2ULP_SNOOPDATA_2_V(1U)
 
-#define CHNCOUNT3_S    31
-#define CHNCOUNT3_V(x) ((x) << CHNCOUNT3_S)
-#define CHNCOUNT3_F    CHNCOUNT3_V(1U)
+#define CAUSE_PM2ULP_SNOOPDATA_1_S    17
+#define CAUSE_PM2ULP_SNOOPDATA_1_V(x) ((x) << CAUSE_PM2ULP_SNOOPDATA_1_S)
+#define CAUSE_PM2ULP_SNOOPDATA_1_F    CAUSE_PM2ULP_SNOOPDATA_1_V(1U)
 
-#define CHNCOUNT2_S    30
-#define CHNCOUNT2_V(x) ((x) << CHNCOUNT2_S)
-#define CHNCOUNT2_F    CHNCOUNT2_V(1U)
+#define CAUSE_PM2ULP_SNOOPDATA_0_S    16
+#define CAUSE_PM2ULP_SNOOPDATA_0_V(x) ((x) << CAUSE_PM2ULP_SNOOPDATA_0_S)
+#define CAUSE_PM2ULP_SNOOPDATA_0_F    CAUSE_PM2ULP_SNOOPDATA_0_V(1U)
 
-#define CHNCOUNT1_S    29
-#define CHNCOUNT1_V(x) ((x) << CHNCOUNT1_S)
-#define CHNCOUNT1_F    CHNCOUNT1_V(1U)
+#define CAUSE_TLS2ULP_DATA_3_S    15
+#define CAUSE_TLS2ULP_DATA_3_V(x) ((x) << CAUSE_TLS2ULP_DATA_3_S)
+#define CAUSE_TLS2ULP_DATA_3_F    CAUSE_TLS2ULP_DATA_3_V(1U)
 
-#define CHNCOUNT0_S    28
-#define CHNCOUNT0_V(x) ((x) << CHNCOUNT0_S)
-#define CHNCOUNT0_F    CHNCOUNT0_V(1U)
+#define CAUSE_TLS2ULP_DATA_2_S    14
+#define CAUSE_TLS2ULP_DATA_2_V(x) ((x) << CAUSE_TLS2ULP_DATA_2_S)
+#define CAUSE_TLS2ULP_DATA_2_F    CAUSE_TLS2ULP_DATA_2_V(1U)
 
-#define CHNUNDFLOW3_S    27
-#define CHNUNDFLOW3_V(x) ((x) << CHNUNDFLOW3_S)
-#define CHNUNDFLOW3_F    CHNUNDFLOW3_V(1U)
+#define CAUSE_TLS2ULP_DATA_1_S    13
+#define CAUSE_TLS2ULP_DATA_1_V(x) ((x) << CAUSE_TLS2ULP_DATA_1_S)
+#define CAUSE_TLS2ULP_DATA_1_F    CAUSE_TLS2ULP_DATA_1_V(1U)
 
-#define CHNUNDFLOW2_S    26
-#define CHNUNDFLOW2_V(x) ((x) << CHNUNDFLOW2_S)
-#define CHNUNDFLOW2_F    CHNUNDFLOW2_V(1U)
+#define CAUSE_TLS2ULP_DATA_0_S    12
+#define CAUSE_TLS2ULP_DATA_0_V(x) ((x) << CAUSE_TLS2ULP_DATA_0_S)
+#define CAUSE_TLS2ULP_DATA_0_F    CAUSE_TLS2ULP_DATA_0_V(1U)
 
-#define CHNUNDFLOW1_S    25
-#define CHNUNDFLOW1_V(x) ((x) << CHNUNDFLOW1_S)
-#define CHNUNDFLOW1_F    CHNUNDFLOW1_V(1U)
+#define CAUSE_TLS2ULP_PLENDATA_3_S    11
+#define CAUSE_TLS2ULP_PLENDATA_3_V(x) ((x) << CAUSE_TLS2ULP_PLENDATA_3_S)
+#define CAUSE_TLS2ULP_PLENDATA_3_F    CAUSE_TLS2ULP_PLENDATA_3_V(1U)
 
-#define CHNUNDFLOW0_S    24
-#define CHNUNDFLOW0_V(x) ((x) << CHNUNDFLOW0_S)
-#define CHNUNDFLOW0_F    CHNUNDFLOW0_V(1U)
+#define CAUSE_TLS2ULP_PLENDATA_2_S    10
+#define CAUSE_TLS2ULP_PLENDATA_2_V(x) ((x) << CAUSE_TLS2ULP_PLENDATA_2_S)
+#define CAUSE_TLS2ULP_PLENDATA_2_F    CAUSE_TLS2ULP_PLENDATA_2_V(1U)
 
-#define RSTCHN3_S    19
-#define RSTCHN3_V(x) ((x) << RSTCHN3_S)
-#define RSTCHN3_F    RSTCHN3_V(1U)
+#define CAUSE_TLS2ULP_PLENDATA_1_S    9
+#define CAUSE_TLS2ULP_PLENDATA_1_V(x) ((x) << CAUSE_TLS2ULP_PLENDATA_1_S)
+#define CAUSE_TLS2ULP_PLENDATA_1_F    CAUSE_TLS2ULP_PLENDATA_1_V(1U)
 
-#define RSTCHN2_S    18
-#define RSTCHN2_V(x) ((x) << RSTCHN2_S)
-#define RSTCHN2_F    RSTCHN2_V(1U)
+#define CAUSE_TLS2ULP_PLENDATA_0_S    8
+#define CAUSE_TLS2ULP_PLENDATA_0_V(x) ((x) << CAUSE_TLS2ULP_PLENDATA_0_S)
+#define CAUSE_TLS2ULP_PLENDATA_0_F    CAUSE_TLS2ULP_PLENDATA_0_V(1U)
 
-#define RSTCHN1_S    17
-#define RSTCHN1_V(x) ((x) << RSTCHN1_S)
-#define RSTCHN1_F    RSTCHN1_V(1U)
+#define CAUSE_PM2ULP_DATA_3_S    7
+#define CAUSE_PM2ULP_DATA_3_V(x) ((x) << CAUSE_PM2ULP_DATA_3_S)
+#define CAUSE_PM2ULP_DATA_3_F    CAUSE_PM2ULP_DATA_3_V(1U)
 
-#define RSTCHN0_S    16
-#define RSTCHN0_V(x) ((x) << RSTCHN0_S)
-#define RSTCHN0_F    RSTCHN0_V(1U)
+#define CAUSE_PM2ULP_DATA_2_S    6
+#define CAUSE_PM2ULP_DATA_2_V(x) ((x) << CAUSE_PM2ULP_DATA_2_S)
+#define CAUSE_PM2ULP_DATA_2_F    CAUSE_PM2ULP_DATA_2_V(1U)
 
-#define UPDVLD_S    15
-#define UPDVLD_V(x) ((x) << UPDVLD_S)
-#define UPDVLD_F    UPDVLD_V(1U)
+#define CAUSE_PM2ULP_DATA_1_S    5
+#define CAUSE_PM2ULP_DATA_1_V(x) ((x) << CAUSE_PM2ULP_DATA_1_S)
+#define CAUSE_PM2ULP_DATA_1_F    CAUSE_PM2ULP_DATA_1_V(1U)
 
-#define XOFF_S    14
-#define XOFF_V(x) ((x) << XOFF_S)
-#define XOFF_F    XOFF_V(1U)
+#define CAUSE_PM2ULP_DATA_0_S    4
+#define CAUSE_PM2ULP_DATA_0_V(x) ((x) << CAUSE_PM2ULP_DATA_0_S)
+#define CAUSE_PM2ULP_DATA_0_F    CAUSE_PM2ULP_DATA_0_V(1U)
 
-#define UPDCHN3_S    13
-#define UPDCHN3_V(x) ((x) << UPDCHN3_S)
-#define UPDCHN3_F    UPDCHN3_V(1U)
+#define CAUSE_TP2ULP_PCMD_3_S    3
+#define CAUSE_TP2ULP_PCMD_3_V(x) ((x) << CAUSE_TP2ULP_PCMD_3_S)
+#define CAUSE_TP2ULP_PCMD_3_F    CAUSE_TP2ULP_PCMD_3_V(1U)
 
-#define UPDCHN2_S    12
-#define UPDCHN2_V(x) ((x) << UPDCHN2_S)
-#define UPDCHN2_F    UPDCHN2_V(1U)
+#define CAUSE_TP2ULP_PCMD_2_S    2
+#define CAUSE_TP2ULP_PCMD_2_V(x) ((x) << CAUSE_TP2ULP_PCMD_2_S)
+#define CAUSE_TP2ULP_PCMD_2_F    CAUSE_TP2ULP_PCMD_2_V(1U)
 
-#define UPDCHN1_S    11
-#define UPDCHN1_V(x) ((x) << UPDCHN1_S)
-#define UPDCHN1_F    UPDCHN1_V(1U)
+#define CAUSE_TP2ULP_PCMD_1_S    1
+#define CAUSE_TP2ULP_PCMD_1_V(x) ((x) << CAUSE_TP2ULP_PCMD_1_S)
+#define CAUSE_TP2ULP_PCMD_1_F    CAUSE_TP2ULP_PCMD_1_V(1U)
 
-#define UPDCHN0_S    10
-#define UPDCHN0_V(x) ((x) << UPDCHN0_S)
-#define UPDCHN0_F    UPDCHN0_V(1U)
+#define CAUSE_TP2ULP_PCMD_0_S    0
+#define CAUSE_TP2ULP_PCMD_0_V(x) ((x) << CAUSE_TP2ULP_PCMD_0_S)
+#define CAUSE_TP2ULP_PCMD_0_F    CAUSE_TP2ULP_PCMD_0_V(1U)
 
-#define QUEUE_S    0
-#define QUEUE_M    0x3ffU
-#define QUEUE_V(x) ((x) << QUEUE_S)
-#define QUEUE_G(x) (((x) >> QUEUE_S) & QUEUE_M)
+#define ULP_RX_INT_ENABLE_2_A 0x1926c
+#define ULP_RX_INT_CAUSE_2_A 0x19270
 
-#define MPS_TRC_INT_CAUSE_A	0x985c
+#define ULPRX2MA_INTFPERR_S    8
+#define ULPRX2MA_INTFPERR_V(x) ((x) << ULPRX2MA_INTFPERR_S)
+#define ULPRX2MA_INTFPERR_F    ULPRX2MA_INTFPERR_V(1U)
 
-#define MISCPERR_S    8
-#define MISCPERR_V(x) ((x) << MISCPERR_S)
-#define MISCPERR_F    MISCPERR_V(1U)
+#define ALN_SDC_ERR_1_S    7
+#define ALN_SDC_ERR_1_V(x) ((x) << ALN_SDC_ERR_1_S)
+#define ALN_SDC_ERR_1_F    ALN_SDC_ERR_1_V(1U)
 
-#define PKTFIFO_S    4
-#define PKTFIFO_M    0xfU
-#define PKTFIFO_V(x) ((x) << PKTFIFO_S)
+#define ALN_SDC_ERR_0_S    6
+#define ALN_SDC_ERR_0_V(x) ((x) << ALN_SDC_ERR_0_S)
+#define ALN_SDC_ERR_0_F    ALN_SDC_ERR_0_V(1U)
 
-#define FILTMEM_S    0
-#define FILTMEM_M    0xfU
-#define FILTMEM_V(x) ((x) << FILTMEM_S)
+#define PF_UNTAGGED_TPT_1_S    5
+#define PF_UNTAGGED_TPT_1_V(x) ((x) << PF_UNTAGGED_TPT_1_S)
+#define PF_UNTAGGED_TPT_1_F    PF_UNTAGGED_TPT_1_V(1U)
 
-#define MPS_CLS_INT_CAUSE_A 0xd028
+#define PF_UNTAGGED_TPT_0_S    4
+#define PF_UNTAGGED_TPT_0_V(x) ((x) << PF_UNTAGGED_TPT_0_S)
+#define PF_UNTAGGED_TPT_0_F    PF_UNTAGGED_TPT_0_V(1U)
 
-#define HASHSRAM_S    2
-#define HASHSRAM_V(x) ((x) << HASHSRAM_S)
-#define HASHSRAM_F    HASHSRAM_V(1U)
+#define PF_PBL_1_S    3
+#define PF_PBL_1_V(x) ((x) << PF_PBL_1_S)
+#define PF_PBL_1_F    PF_PBL_1_V(1U)
 
-#define MATCHTCAM_S    1
-#define MATCHTCAM_V(x) ((x) << MATCHTCAM_S)
-#define MATCHTCAM_F    MATCHTCAM_V(1U)
+#define PF_PBL_0_S    2
+#define PF_PBL_0_V(x) ((x) << PF_PBL_0_S)
+#define PF_PBL_0_F    PF_PBL_0_V(1U)
 
-#define MATCHSRAM_S    0
-#define MATCHSRAM_V(x) ((x) << MATCHSRAM_S)
-#define MATCHSRAM_F    MATCHSRAM_V(1U)
+#define DDP_HINT_1_S    1
+#define DDP_HINT_1_V(x) ((x) << DDP_HINT_1_S)
+#define DDP_HINT_1_F    DDP_HINT_1_V(1U)
 
-#define MPS_RX_PG_RSV0_A 0x11010
-#define MPS_RX_PG_RSV4_A 0x11020
-#define MPS_RX_PERR_INT_CAUSE_A 0x11074
-#define MPS_RX_MAC_BG_PG_CNT0_A 0x11208
-#define MPS_RX_LPBK_BG_PG_CNT0_A 0x11218
+#define DDP_HINT_0_S    0
+#define DDP_HINT_0_V(x) ((x) << DDP_HINT_0_S)
+#define DDP_HINT_0_F    DDP_HINT_0_V(1U)
 
-#define MPS_RX_VXLAN_TYPE_A 0x11234
+#define ULP_RX_INT_ENABLE_PCMD_A 0x19300
+#define ULP_RX_INT_CAUSE_PCMD_A 0x19304
 
-#define VXLAN_EN_S    16
-#define VXLAN_EN_V(x) ((x) << VXLAN_EN_S)
-#define VXLAN_EN_F    VXLAN_EN_V(1U)
+#define CAUSE_PCMD_SFIFO_3_S    30
+#define CAUSE_PCMD_SFIFO_3_V(x) ((x) << CAUSE_PCMD_SFIFO_3_S)
+#define CAUSE_PCMD_SFIFO_3_F    CAUSE_PCMD_SFIFO_3_V(1U)
 
-#define VXLAN_S    0
-#define VXLAN_M    0xffffU
-#define VXLAN_V(x) ((x) << VXLAN_S)
-#define VXLAN_G(x) (((x) >> VXLAN_S) & VXLAN_M)
+#define CAUSE_PCMD_FIFO_3_S    29
+#define CAUSE_PCMD_FIFO_3_V(x) ((x) << CAUSE_PCMD_FIFO_3_S)
+#define CAUSE_PCMD_FIFO_3_F    CAUSE_PCMD_FIFO_3_V(1U)
 
-#define MPS_RX_GENEVE_TYPE_A 0x11238
+#define CAUSE_PCMD_DDP_HINT_3_S    28
+#define CAUSE_PCMD_DDP_HINT_3_V(x) ((x) << CAUSE_PCMD_DDP_HINT_3_S)
+#define CAUSE_PCMD_DDP_HINT_3_F    CAUSE_PCMD_DDP_HINT_3_V(1U)
 
-#define GENEVE_EN_S    16
-#define GENEVE_EN_V(x) ((x) << GENEVE_EN_S)
-#define GENEVE_EN_F    GENEVE_EN_V(1U)
+#define CAUSE_PCMD_TPT_3_S    27
+#define CAUSE_PCMD_TPT_3_V(x) ((x) << CAUSE_PCMD_TPT_3_S)
+#define CAUSE_PCMD_TPT_3_F    CAUSE_PCMD_TPT_3_V(1U)
 
-#define GENEVE_S    0
-#define GENEVE_M    0xffffU
-#define GENEVE_V(x) ((x) << GENEVE_S)
-#define GENEVE_G(x) (((x) >> GENEVE_S) & GENEVE_M)
+#define CAUSE_PCMD_DDP_3_S    26
+#define CAUSE_PCMD_DDP_3_V(x) ((x) << CAUSE_PCMD_DDP_3_S)
+#define CAUSE_PCMD_DDP_3_F    CAUSE_PCMD_DDP_3_V(1U)
 
-#define MPS_CLS_TCAM_Y_L_A 0xf000
-#define MPS_CLS_TCAM_DATA0_A 0xf000
-#define MPS_CLS_TCAM_DATA1_A 0xf004
+#define CAUSE_PCMD_MPAR_3_S    25
+#define CAUSE_PCMD_MPAR_3_V(x) ((x) << CAUSE_PCMD_MPAR_3_S)
+#define CAUSE_PCMD_MPAR_3_F    CAUSE_PCMD_MPAR_3_V(1U)
 
-#define CTLREQID_S    30
-#define CTLREQID_V(x) ((x) << CTLREQID_S)
+#define CAUSE_PCMD_MPAC_3_S    24
+#define CAUSE_PCMD_MPAC_3_V(x) ((x) << CAUSE_PCMD_MPAC_3_S)
+#define CAUSE_PCMD_MPAC_3_F    CAUSE_PCMD_MPAC_3_V(1U)
 
-#define MPS_VF_RPLCT_MAP0_A 0x1111c
-#define MPS_VF_RPLCT_MAP1_A 0x11120
-#define MPS_VF_RPLCT_MAP2_A 0x11124
-#define MPS_VF_RPLCT_MAP3_A 0x11128
-#define MPS_VF_RPLCT_MAP4_A 0x11300
-#define MPS_VF_RPLCT_MAP5_A 0x11304
-#define MPS_VF_RPLCT_MAP6_A 0x11308
-#define MPS_VF_RPLCT_MAP7_A 0x1130c
+#define CAUSE_PCMD_SFIFO_2_S    22
+#define CAUSE_PCMD_SFIFO_2_V(x) ((x) << CAUSE_PCMD_SFIFO_2_S)
+#define CAUSE_PCMD_SFIFO_2_F    CAUSE_PCMD_SFIFO_2_V(1U)
 
-#define VIDL_S    16
-#define VIDL_M    0xffffU
-#define VIDL_G(x) (((x) >> VIDL_S) & VIDL_M)
+#define CAUSE_PCMD_FIFO_2_S    21
+#define CAUSE_PCMD_FIFO_2_V(x) ((x) << CAUSE_PCMD_FIFO_2_S)
+#define CAUSE_PCMD_FIFO_2_F    CAUSE_PCMD_FIFO_2_V(1U)
 
-#define DATALKPTYPE_S    10
-#define DATALKPTYPE_M    0x3U
-#define DATALKPTYPE_G(x) (((x) >> DATALKPTYPE_S) & DATALKPTYPE_M)
+#define CAUSE_PCMD_DDP_HINT_2_S    20
+#define CAUSE_PCMD_DDP_HINT_2_V(x) ((x) << CAUSE_PCMD_DDP_HINT_2_S)
+#define CAUSE_PCMD_DDP_HINT_2_F    CAUSE_PCMD_DDP_HINT_2_V(1U)
 
-#define DATAPORTNUM_S    12
-#define DATAPORTNUM_M    0xfU
-#define DATAPORTNUM_V(x) ((x) << DATAPORTNUM_S)
-#define DATAPORTNUM_G(x) (((x) >> DATAPORTNUM_S) & DATAPORTNUM_M)
+#define CAUSE_PCMD_TPT_2_S    19
+#define CAUSE_PCMD_TPT_2_V(x) ((x) << CAUSE_PCMD_TPT_2_S)
+#define CAUSE_PCMD_TPT_2_F    CAUSE_PCMD_TPT_2_V(1U)
+
+#define CAUSE_PCMD_DDP_2_S    18
+#define CAUSE_PCMD_DDP_2_V(x) ((x) << CAUSE_PCMD_DDP_2_S)
+#define CAUSE_PCMD_DDP_2_F    CAUSE_PCMD_DDP_2_V(1U)
+
+#define CAUSE_PCMD_MPAR_2_S    17
+#define CAUSE_PCMD_MPAR_2_V(x) ((x) << CAUSE_PCMD_MPAR_2_S)
+#define CAUSE_PCMD_MPAR_2_F    CAUSE_PCMD_MPAR_2_V(1U)
 
-#define DATALKPTYPE_S    10
-#define DATALKPTYPE_M    0x3U
-#define DATALKPTYPE_V(x) ((x) << DATALKPTYPE_S)
-#define DATALKPTYPE_G(x) (((x) >> DATALKPTYPE_S) & DATALKPTYPE_M)
+#define CAUSE_PCMD_MPAC_2_S    16
+#define CAUSE_PCMD_MPAC_2_V(x) ((x) << CAUSE_PCMD_MPAC_2_S)
+#define CAUSE_PCMD_MPAC_2_F    CAUSE_PCMD_MPAC_2_V(1U)
 
-#define DATADIPHIT_S    8
-#define DATADIPHIT_V(x) ((x) << DATADIPHIT_S)
-#define DATADIPHIT_F    DATADIPHIT_V(1U)
+#define CAUSE_PCMD_SFIFO_1_S    14
+#define CAUSE_PCMD_SFIFO_1_V(x) ((x) << CAUSE_PCMD_SFIFO_1_S)
+#define CAUSE_PCMD_SFIFO_1_F    CAUSE_PCMD_SFIFO_1_V(1U)
 
-#define DATAVIDH2_S    7
-#define DATAVIDH2_V(x) ((x) << DATAVIDH2_S)
-#define DATAVIDH2_F    DATAVIDH2_V(1U)
+#define CAUSE_PCMD_FIFO_1_S    13
+#define CAUSE_PCMD_FIFO_1_V(x) ((x) << CAUSE_PCMD_FIFO_1_S)
+#define CAUSE_PCMD_FIFO_1_F    CAUSE_PCMD_FIFO_1_V(1U)
 
-#define DATAVIDH1_S    0
-#define DATAVIDH1_M    0x7fU
-#define DATAVIDH1_G(x) (((x) >> DATAVIDH1_S) & DATAVIDH1_M)
+#define CAUSE_PCMD_DDP_HINT_1_S    12
+#define CAUSE_PCMD_DDP_HINT_1_V(x) ((x) << CAUSE_PCMD_DDP_HINT_1_S)
+#define CAUSE_PCMD_DDP_HINT_1_F    CAUSE_PCMD_DDP_HINT_1_V(1U)
 
-#define MPS_CLS_TCAM_RDATA0_REQ_ID1_A 0xf020
-#define MPS_CLS_TCAM_RDATA1_REQ_ID1_A 0xf024
-#define MPS_CLS_TCAM_RDATA2_REQ_ID1_A 0xf028
+#define CAUSE_PCMD_TPT_1_S    11
+#define CAUSE_PCMD_TPT_1_V(x) ((x) << CAUSE_PCMD_TPT_1_S)
+#define CAUSE_PCMD_TPT_1_F    CAUSE_PCMD_TPT_1_V(1U)
 
-#define USED_S    16
-#define USED_M    0x7ffU
-#define USED_G(x) (((x) >> USED_S) & USED_M)
+#define CAUSE_PCMD_DDP_1_S    10
+#define CAUSE_PCMD_DDP_1_V(x) ((x) << CAUSE_PCMD_DDP_1_S)
+#define CAUSE_PCMD_DDP_1_F    CAUSE_PCMD_DDP_1_V(1U)
 
-#define ALLOC_S    0
-#define ALLOC_M    0x7ffU
-#define ALLOC_G(x) (((x) >> ALLOC_S) & ALLOC_M)
+#define CAUSE_PCMD_MPAR_1_S    9
+#define CAUSE_PCMD_MPAR_1_V(x) ((x) << CAUSE_PCMD_MPAR_1_S)
+#define CAUSE_PCMD_MPAR_1_F    CAUSE_PCMD_MPAR_1_V(1U)
 
-#define T5_USED_S    16
-#define T5_USED_M    0xfffU
-#define T5_USED_G(x) (((x) >> T5_USED_S) & T5_USED_M)
+#define CAUSE_PCMD_MPAC_1_S    8
+#define CAUSE_PCMD_MPAC_1_V(x) ((x) << CAUSE_PCMD_MPAC_1_S)
+#define CAUSE_PCMD_MPAC_1_F    CAUSE_PCMD_MPAC_1_V(1U)
 
-#define T5_ALLOC_S    0
-#define T5_ALLOC_M    0xfffU
-#define T5_ALLOC_G(x) (((x) >> T5_ALLOC_S) & T5_ALLOC_M)
+#define CAUSE_PCMD_SFIFO_0_S    6
+#define CAUSE_PCMD_SFIFO_0_V(x) ((x) << CAUSE_PCMD_SFIFO_0_S)
+#define CAUSE_PCMD_SFIFO_0_F    CAUSE_PCMD_SFIFO_0_V(1U)
 
-#define DMACH_S    0
-#define DMACH_M    0xffffU
-#define DMACH_G(x) (((x) >> DMACH_S) & DMACH_M)
+#define CAUSE_PCMD_FIFO_0_S    5
+#define CAUSE_PCMD_FIFO_0_V(x) ((x) << CAUSE_PCMD_FIFO_0_S)
+#define CAUSE_PCMD_FIFO_0_F    CAUSE_PCMD_FIFO_0_V(1U)
 
-#define MPS_CLS_TCAM_X_L_A 0xf008
-#define MPS_CLS_TCAM_DATA2_CTL_A 0xf008
+#define CAUSE_PCMD_DDP_HINT_0_S    4
+#define CAUSE_PCMD_DDP_HINT_0_V(x) ((x) << CAUSE_PCMD_DDP_HINT_0_S)
+#define CAUSE_PCMD_DDP_HINT_0_F    CAUSE_PCMD_DDP_HINT_0_V(1U)
 
-#define CTLCMDTYPE_S    31
-#define CTLCMDTYPE_V(x) ((x) << CTLCMDTYPE_S)
-#define CTLCMDTYPE_F    CTLCMDTYPE_V(1U)
+#define CAUSE_PCMD_TPT_0_S    3
+#define CAUSE_PCMD_TPT_0_V(x) ((x) << CAUSE_PCMD_TPT_0_S)
+#define CAUSE_PCMD_TPT_0_F    CAUSE_PCMD_TPT_0_V(1U)
 
-#define CTLTCAMSEL_S    25
-#define CTLTCAMSEL_V(x) ((x) << CTLTCAMSEL_S)
+#define CAUSE_PCMD_DDP_0_S    2
+#define CAUSE_PCMD_DDP_0_V(x) ((x) << CAUSE_PCMD_DDP_0_S)
+#define CAUSE_PCMD_DDP_0_F    CAUSE_PCMD_DDP_0_V(1U)
 
-#define CTLTCAMINDEX_S    17
-#define CTLTCAMINDEX_V(x) ((x) << CTLTCAMINDEX_S)
+#define CAUSE_PCMD_MPAR_0_S    1
+#define CAUSE_PCMD_MPAR_0_V(x) ((x) << CAUSE_PCMD_MPAR_0_S)
+#define CAUSE_PCMD_MPAR_0_F    CAUSE_PCMD_MPAR_0_V(1U)
 
-#define CTLXYBITSEL_S    16
-#define CTLXYBITSEL_V(x) ((x) << CTLXYBITSEL_S)
+#define CAUSE_PCMD_MPAC_0_S    0
+#define CAUSE_PCMD_MPAC_0_V(x) ((x) << CAUSE_PCMD_MPAC_0_S)
+#define CAUSE_PCMD_MPAC_0_F    CAUSE_PCMD_MPAC_0_V(1U)
 
-#define MPS_CLS_TCAM_Y_L(idx) (MPS_CLS_TCAM_Y_L_A + (idx) * 16)
-#define NUM_MPS_CLS_TCAM_Y_L_INSTANCES 512
+#define ULP_RX_INT_ENABLE_DATA_A 0x19310
+#define ULP_RX_INT_CAUSE_DATA_A 0x19314
 
-#define MPS_CLS_TCAM_X_L(idx) (MPS_CLS_TCAM_X_L_A + (idx) * 16)
-#define NUM_MPS_CLS_TCAM_X_L_INSTANCES 512
+#define CAUSE_DATA_SNOOP_3_S    29
+#define CAUSE_DATA_SNOOP_3_V(x) ((x) << CAUSE_DATA_SNOOP_3_S)
+#define CAUSE_DATA_SNOOP_3_F    CAUSE_DATA_SNOOP_3_V(1U)
 
-#define MPS_CLS_SRAM_L_A 0xe000
+#define CAUSE_DATA_SFIFO_3_S    28
+#define CAUSE_DATA_SFIFO_3_V(x) ((x) << CAUSE_DATA_SFIFO_3_S)
+#define CAUSE_DATA_SFIFO_3_F    CAUSE_DATA_SFIFO_3_V(1U)
 
-#define T6_MULTILISTEN0_S    26
+#define CAUSE_DATA_FIFO_3_S    27
+#define CAUSE_DATA_FIFO_3_V(x) ((x) << CAUSE_DATA_FIFO_3_S)
+#define CAUSE_DATA_FIFO_3_F    CAUSE_DATA_FIFO_3_V(1U)
 
-#define T6_SRAM_PRIO3_S    23
-#define T6_SRAM_PRIO3_M    0x7U
-#define T6_SRAM_PRIO3_G(x) (((x) >> T6_SRAM_PRIO3_S) & T6_SRAM_PRIO3_M)
+#define CAUSE_DATA_DDP_3_S    26
+#define CAUSE_DATA_DDP_3_V(x) ((x) << CAUSE_DATA_DDP_3_S)
+#define CAUSE_DATA_DDP_3_F    CAUSE_DATA_DDP_3_V(1U)
 
-#define T6_SRAM_PRIO2_S    20
-#define T6_SRAM_PRIO2_M    0x7U
-#define T6_SRAM_PRIO2_G(x) (((x) >> T6_SRAM_PRIO2_S) & T6_SRAM_PRIO2_M)
+#define CAUSE_DATA_CTX_3_S    25
+#define CAUSE_DATA_CTX_3_V(x) ((x) << CAUSE_DATA_CTX_3_S)
+#define CAUSE_DATA_CTX_3_F    CAUSE_DATA_CTX_3_V(1U)
 
-#define T6_SRAM_PRIO1_S    17
-#define T6_SRAM_PRIO1_M    0x7U
-#define T6_SRAM_PRIO1_G(x) (((x) >> T6_SRAM_PRIO1_S) & T6_SRAM_PRIO1_M)
+#define CAUSE_DATA_PARSER_3_S    24
+#define CAUSE_DATA_PARSER_3_V(x) ((x) << CAUSE_DATA_PARSER_3_S)
+#define CAUSE_DATA_PARSER_3_F    CAUSE_DATA_PARSER_3_V(1U)
 
-#define T6_SRAM_PRIO0_S    14
-#define T6_SRAM_PRIO0_M    0x7U
-#define T6_SRAM_PRIO0_G(x) (((x) >> T6_SRAM_PRIO0_S) & T6_SRAM_PRIO0_M)
+#define CAUSE_DATA_SNOOP_2_S    21
+#define CAUSE_DATA_SNOOP_2_V(x) ((x) << CAUSE_DATA_SNOOP_2_S)
+#define CAUSE_DATA_SNOOP_2_F    CAUSE_DATA_SNOOP_2_V(1U)
 
-#define T6_SRAM_VLD_S    13
-#define T6_SRAM_VLD_V(x) ((x) << T6_SRAM_VLD_S)
-#define T6_SRAM_VLD_F    T6_SRAM_VLD_V(1U)
+#define CAUSE_DATA_SFIFO_2_S    20
+#define CAUSE_DATA_SFIFO_2_V(x) ((x) << CAUSE_DATA_SFIFO_2_S)
+#define CAUSE_DATA_SFIFO_2_F    CAUSE_DATA_SFIFO_2_V(1U)
 
-#define T6_REPLICATE_S    12
-#define T6_REPLICATE_V(x) ((x) << T6_REPLICATE_S)
-#define T6_REPLICATE_F    T6_REPLICATE_V(1U)
+#define CAUSE_DATA_FIFO_2_S    19
+#define CAUSE_DATA_FIFO_2_V(x) ((x) << CAUSE_DATA_FIFO_2_S)
+#define CAUSE_DATA_FIFO_2_F    CAUSE_DATA_FIFO_2_V(1U)
 
-#define T6_PF_S    9
-#define T6_PF_M    0x7U
-#define T6_PF_G(x) (((x) >> T6_PF_S) & T6_PF_M)
+#define CAUSE_DATA_DDP_2_S    18
+#define CAUSE_DATA_DDP_2_V(x) ((x) << CAUSE_DATA_DDP_2_S)
+#define CAUSE_DATA_DDP_2_F    CAUSE_DATA_DDP_2_V(1U)
 
-#define T6_VF_VALID_S    8
-#define T6_VF_VALID_V(x) ((x) << T6_VF_VALID_S)
-#define T6_VF_VALID_F    T6_VF_VALID_V(1U)
+#define CAUSE_DATA_CTX_2_S    17
+#define CAUSE_DATA_CTX_2_V(x) ((x) << CAUSE_DATA_CTX_2_S)
+#define CAUSE_DATA_CTX_2_F    CAUSE_DATA_CTX_2_V(1U)
 
-#define T6_VF_S    0
-#define T6_VF_M    0xffU
-#define T6_VF_G(x) (((x) >> T6_VF_S) & T6_VF_M)
+#define CAUSE_DATA_PARSER_2_S    16
+#define CAUSE_DATA_PARSER_2_V(x) ((x) << CAUSE_DATA_PARSER_2_S)
+#define CAUSE_DATA_PARSER_2_F    CAUSE_DATA_PARSER_2_V(1U)
 
-#define MPS_CLS_SRAM_H_A 0xe004
+#define CAUSE_DATA_SNOOP_1_S    13
+#define CAUSE_DATA_SNOOP_1_V(x) ((x) << CAUSE_DATA_SNOOP_1_S)
+#define CAUSE_DATA_SNOOP_1_F    CAUSE_DATA_SNOOP_1_V(1U)
 
-#define MPS_CLS_SRAM_L(idx) (MPS_CLS_SRAM_L_A + (idx) * 8)
-#define NUM_MPS_CLS_SRAM_L_INSTANCES 336
+#define CAUSE_DATA_SFIFO_1_S    12
+#define CAUSE_DATA_SFIFO_1_V(x) ((x) << CAUSE_DATA_SFIFO_1_S)
+#define CAUSE_DATA_SFIFO_1_F    CAUSE_DATA_SFIFO_1_V(1U)
 
-#define MPS_CLS_SRAM_H(idx) (MPS_CLS_SRAM_H_A + (idx) * 8)
-#define NUM_MPS_CLS_SRAM_H_INSTANCES 336
+#define CAUSE_DATA_FIFO_1_S    11
+#define CAUSE_DATA_FIFO_1_V(x) ((x) << CAUSE_DATA_FIFO_1_S)
+#define CAUSE_DATA_FIFO_1_F    CAUSE_DATA_FIFO_1_V(1U)
 
-#define MULTILISTEN0_S    25
+#define CAUSE_DATA_DDP_1_S    10
+#define CAUSE_DATA_DDP_1_V(x) ((x) << CAUSE_DATA_DDP_1_S)
+#define CAUSE_DATA_DDP_1_F    CAUSE_DATA_DDP_1_V(1U)
 
-#define REPLICATE_S    11
-#define REPLICATE_V(x) ((x) << REPLICATE_S)
-#define REPLICATE_F    REPLICATE_V(1U)
+#define CAUSE_DATA_CTX_1_S    9
+#define CAUSE_DATA_CTX_1_V(x) ((x) << CAUSE_DATA_CTX_1_S)
+#define CAUSE_DATA_CTX_1_F    CAUSE_DATA_CTX_1_V(1U)
 
-#define PF_S    8
-#define PF_M    0x7U
-#define PF_G(x) (((x) >> PF_S) & PF_M)
+#define CAUSE_DATA_PARSER_1_S    8
+#define CAUSE_DATA_PARSER_1_V(x) ((x) << CAUSE_DATA_PARSER_1_S)
+#define CAUSE_DATA_PARSER_1_F    CAUSE_DATA_PARSER_1_V(1U)
 
-#define VF_VALID_S    7
-#define VF_VALID_V(x) ((x) << VF_VALID_S)
-#define VF_VALID_F    VF_VALID_V(1U)
+#define CAUSE_DATA_SNOOP_0_S    5
+#define CAUSE_DATA_SNOOP_0_V(x) ((x) << CAUSE_DATA_SNOOP_0_S)
+#define CAUSE_DATA_SNOOP_0_F    CAUSE_DATA_SNOOP_0_V(1U)
 
-#define VF_S    0
-#define VF_M    0x7fU
-#define VF_G(x) (((x) >> VF_S) & VF_M)
+#define CAUSE_DATA_SFIFO_0_S    4
+#define CAUSE_DATA_SFIFO_0_V(x) ((x) << CAUSE_DATA_SFIFO_0_S)
+#define CAUSE_DATA_SFIFO_0_F    CAUSE_DATA_SFIFO_0_V(1U)
 
-#define SRAM_PRIO3_S    22
-#define SRAM_PRIO3_M    0x7U
-#define SRAM_PRIO3_G(x) (((x) >> SRAM_PRIO3_S) & SRAM_PRIO3_M)
+#define CAUSE_DATA_FIFO_0_S    3
+#define CAUSE_DATA_FIFO_0_V(x) ((x) << CAUSE_DATA_FIFO_0_S)
+#define CAUSE_DATA_FIFO_0_F    CAUSE_DATA_FIFO_0_V(1U)
 
-#define SRAM_PRIO2_S    19
-#define SRAM_PRIO2_M    0x7U
-#define SRAM_PRIO2_G(x) (((x) >> SRAM_PRIO2_S) & SRAM_PRIO2_M)
+#define CAUSE_DATA_DDP_0_S    2
+#define CAUSE_DATA_DDP_0_V(x) ((x) << CAUSE_DATA_DDP_0_S)
+#define CAUSE_DATA_DDP_0_F    CAUSE_DATA_DDP_0_V(1U)
 
-#define SRAM_PRIO1_S    16
-#define SRAM_PRIO1_M    0x7U
-#define SRAM_PRIO1_G(x) (((x) >> SRAM_PRIO1_S) & SRAM_PRIO1_M)
+#define CAUSE_DATA_CTX_0_S    1
+#define CAUSE_DATA_CTX_0_V(x) ((x) << CAUSE_DATA_CTX_0_S)
+#define CAUSE_DATA_CTX_0_F    CAUSE_DATA_CTX_0_V(1U)
 
-#define SRAM_PRIO0_S    13
-#define SRAM_PRIO0_M    0x7U
-#define SRAM_PRIO0_G(x) (((x) >> SRAM_PRIO0_S) & SRAM_PRIO0_M)
+#define CAUSE_DATA_PARSER_0_S    0
+#define CAUSE_DATA_PARSER_0_V(x) ((x) << CAUSE_DATA_PARSER_0_S)
+#define CAUSE_DATA_PARSER_0_F    CAUSE_DATA_PARSER_0_V(1U)
 
-#define SRAM_VLD_S    12
-#define SRAM_VLD_V(x) ((x) << SRAM_VLD_S)
-#define SRAM_VLD_F    SRAM_VLD_V(1U)
+#define ULP_RX_INT_ENABLE_ARB_A 0x19320
+#define ULP_RX_INT_CAUSE_ARB_A 0x19324
 
-#define PORTMAP_S    0
-#define PORTMAP_M    0xfU
-#define PORTMAP_G(x) (((x) >> PORTMAP_S) & PORTMAP_M)
+#define CAUSE_ARB_PBL_PF_3_S    27
+#define CAUSE_ARB_PBL_PF_3_V(x) ((x) << CAUSE_ARB_PBL_PF_3_S)
+#define CAUSE_ARB_PBL_PF_3_F    CAUSE_ARB_PBL_PF_3_V(1U)
 
-#define CPL_INTR_CAUSE_A 0x19054
+#define CAUSE_ARB_PF_3_S    26
+#define CAUSE_ARB_PF_3_V(x) ((x) << CAUSE_ARB_PF_3_S)
+#define CAUSE_ARB_PF_3_F    CAUSE_ARB_PF_3_V(1U)
 
-#define CIM_OP_MAP_PERR_S    5
-#define CIM_OP_MAP_PERR_V(x) ((x) << CIM_OP_MAP_PERR_S)
-#define CIM_OP_MAP_PERR_F    CIM_OP_MAP_PERR_V(1U)
+#define CAUSE_ARB_TPT_PF_3_S    25
+#define CAUSE_ARB_TPT_PF_3_V(x) ((x) << CAUSE_ARB_TPT_PF_3_S)
+#define CAUSE_ARB_TPT_PF_3_F    CAUSE_ARB_TPT_PF_3_V(1U)
 
-#define CIM_OVFL_ERROR_S    4
-#define CIM_OVFL_ERROR_V(x) ((x) << CIM_OVFL_ERROR_S)
-#define CIM_OVFL_ERROR_F    CIM_OVFL_ERROR_V(1U)
+#define CAUSE_ARB_F_3_S    24
+#define CAUSE_ARB_F_3_V(x) ((x) << CAUSE_ARB_F_3_S)
+#define CAUSE_ARB_F_3_F    CAUSE_ARB_F_3_V(1U)
 
-#define TP_FRAMING_ERROR_S    3
-#define TP_FRAMING_ERROR_V(x) ((x) << TP_FRAMING_ERROR_S)
-#define TP_FRAMING_ERROR_F    TP_FRAMING_ERROR_V(1U)
+#define CAUSE_ARB_PBL_PF_2_S    19
+#define CAUSE_ARB_PBL_PF_2_V(x) ((x) << CAUSE_ARB_PBL_PF_2_S)
+#define CAUSE_ARB_PBL_PF_2_F    CAUSE_ARB_PBL_PF_2_V(1U)
 
-#define SGE_FRAMING_ERROR_S    2
-#define SGE_FRAMING_ERROR_V(x) ((x) << SGE_FRAMING_ERROR_S)
-#define SGE_FRAMING_ERROR_F    SGE_FRAMING_ERROR_V(1U)
+#define CAUSE_ARB_PF_2_S    18
+#define CAUSE_ARB_PF_2_V(x) ((x) << CAUSE_ARB_PF_2_S)
+#define CAUSE_ARB_PF_2_F    CAUSE_ARB_PF_2_V(1U)
 
-#define CIM_FRAMING_ERROR_S    1
-#define CIM_FRAMING_ERROR_V(x) ((x) << CIM_FRAMING_ERROR_S)
-#define CIM_FRAMING_ERROR_F    CIM_FRAMING_ERROR_V(1U)
+#define CAUSE_ARB_TPT_PF_2_S    17
+#define CAUSE_ARB_TPT_PF_2_V(x) ((x) << CAUSE_ARB_TPT_PF_2_S)
+#define CAUSE_ARB_TPT_PF_2_F    CAUSE_ARB_TPT_PF_2_V(1U)
 
-#define ZERO_SWITCH_ERROR_S    0
-#define ZERO_SWITCH_ERROR_V(x) ((x) << ZERO_SWITCH_ERROR_S)
-#define ZERO_SWITCH_ERROR_F    ZERO_SWITCH_ERROR_V(1U)
+#define CAUSE_ARB_F_2_S    16
+#define CAUSE_ARB_F_2_V(x) ((x) << CAUSE_ARB_F_2_S)
+#define CAUSE_ARB_F_2_F    CAUSE_ARB_F_2_V(1U)
 
-#define SMB_INT_CAUSE_A 0x19090
+#define CAUSE_ARB_PBL_PF_1_S    11
+#define CAUSE_ARB_PBL_PF_1_V(x) ((x) << CAUSE_ARB_PBL_PF_1_S)
+#define CAUSE_ARB_PBL_PF_1_F    CAUSE_ARB_PBL_PF_1_V(1U)
 
-#define MSTTXFIFOPARINT_S    21
-#define MSTTXFIFOPARINT_V(x) ((x) << MSTTXFIFOPARINT_S)
-#define MSTTXFIFOPARINT_F    MSTTXFIFOPARINT_V(1U)
+#define CAUSE_ARB_PF_1_S    10
+#define CAUSE_ARB_PF_1_V(x) ((x) << CAUSE_ARB_PF_1_S)
+#define CAUSE_ARB_PF_1_F    CAUSE_ARB_PF_1_V(1U)
 
-#define MSTRXFIFOPARINT_S    20
-#define MSTRXFIFOPARINT_V(x) ((x) << MSTRXFIFOPARINT_S)
-#define MSTRXFIFOPARINT_F    MSTRXFIFOPARINT_V(1U)
+#define CAUSE_ARB_TPT_PF_1_S    9
+#define CAUSE_ARB_TPT_PF_1_V(x) ((x) << CAUSE_ARB_TPT_PF_1_S)
+#define CAUSE_ARB_TPT_PF_1_F    CAUSE_ARB_TPT_PF_1_V(1U)
 
-#define SLVFIFOPARINT_S    19
-#define SLVFIFOPARINT_V(x) ((x) << SLVFIFOPARINT_S)
-#define SLVFIFOPARINT_F    SLVFIFOPARINT_V(1U)
+#define CAUSE_ARB_F_1_S    8
+#define CAUSE_ARB_F_1_V(x) ((x) << CAUSE_ARB_F_1_S)
+#define CAUSE_ARB_F_1_F    CAUSE_ARB_F_1_V(1U)
 
-#define ULP_RX_INT_CAUSE_A 0x19158
-#define ULP_RX_ISCSI_LLIMIT_A 0x1915c
-#define ULP_RX_ISCSI_ULIMIT_A 0x19160
-#define ULP_RX_ISCSI_TAGMASK_A 0x19164
-#define ULP_RX_ISCSI_PSZ_A 0x19168
-#define ULP_RX_TDDP_LLIMIT_A 0x1916c
-#define ULP_RX_TDDP_ULIMIT_A 0x19170
-#define ULP_RX_STAG_LLIMIT_A 0x1917c
-#define ULP_RX_STAG_ULIMIT_A 0x19180
-#define ULP_RX_RQ_LLIMIT_A 0x19184
-#define ULP_RX_RQ_ULIMIT_A 0x19188
-#define ULP_RX_PBL_LLIMIT_A 0x1918c
-#define ULP_RX_PBL_ULIMIT_A 0x19190
-#define ULP_RX_CTX_BASE_A 0x19194
-#define ULP_RX_RQUDP_LLIMIT_A 0x191a4
-#define ULP_RX_RQUDP_ULIMIT_A 0x191a8
-#define ULP_RX_LA_CTL_A 0x1923c
-#define ULP_RX_LA_RDPTR_A 0x19240
-#define ULP_RX_LA_RDDATA_A 0x19244
-#define ULP_RX_LA_WRPTR_A 0x19248
-#define ULP_RX_TLS_KEY_LLIMIT_A 0x192ac
-#define ULP_RX_TLS_KEY_ULIMIT_A 0x192b0
+#define CAUSE_ARB_PBL_PF_0_S    3
+#define CAUSE_ARB_PBL_PF_0_V(x) ((x) << CAUSE_ARB_PBL_PF_0_S)
+#define CAUSE_ARB_PBL_PF_0_F    CAUSE_ARB_PBL_PF_0_V(1U)
+
+#define CAUSE_ARB_PF_0_S    2
+#define CAUSE_ARB_PF_0_V(x) ((x) << CAUSE_ARB_PF_0_S)
+#define CAUSE_ARB_PF_0_F    CAUSE_ARB_PF_0_V(1U)
+
+#define CAUSE_ARB_TPT_PF_0_S    1
+#define CAUSE_ARB_TPT_PF_0_V(x) ((x) << CAUSE_ARB_TPT_PF_0_S)
+#define CAUSE_ARB_TPT_PF_0_F    CAUSE_ARB_TPT_PF_0_V(1U)
+
+#define CAUSE_ARB_F_0_S    0
+#define CAUSE_ARB_F_0_V(x) ((x) << CAUSE_ARB_F_0_S)
+#define CAUSE_ARB_F_0_F    CAUSE_ARB_F_0_V(1U)
 
 #define HPZ3_S    24
 #define HPZ3_V(x) ((x) << HPZ3_S)
@@ -2850,6 +6782,10 @@
 
 #define ULP_RX_TDDP_PSZ_A 0x19178
 
+#define MPS_CLS_TCAM0_RDATA1_REQ_ID1_A 0xf020
+#define MPS_CLS_TCAM0_RDATA0_REQ_ID1_A 0xf01c
+#define MPS_CLS_TCAM0_RDATA2_REQ_ID1_A 0xf024
+
 /* registers for module SF */
 #define SF_DATA_A 0x193f8
 #define SF_OP_A 0x193fc
@@ -2873,7 +6809,12 @@
 #define OP_V(x) ((x) << OP_S)
 #define OP_F    OP_V(1U)
 
+#define QUADREADDISABLE_S    5
+#define QUADREADDISABLE_V(x) ((x) << QUADREADDISABLE_S)
+#define QUADREADDISABLE_F    QUADREADDISABLE_V(1U)
+
 #define PL_PF_INT_CAUSE_A 0x3c0
+#define PL_PF_INT_ENABLE_A 0x3c4
 
 #define PFSW_S    3
 #define PFSW_V(x) ((x) << PFSW_S)
@@ -2883,20 +6824,14 @@
 #define PFCIM_V(x) ((x) << PFCIM_S)
 #define PFCIM_F    PFCIM_V(1U)
 
-#define PL_PF_INT_ENABLE_A 0x3c4
 #define PL_PF_CTL_A 0x3c8
 
 #define PL_WHOAMI_A 0x19400
+#define PL_PERR_CAUSE_A 0x19404
 
-#define SOURCEPF_S    8
-#define SOURCEPF_M    0x7U
-#define SOURCEPF_G(x) (((x) >> SOURCEPF_S) & SOURCEPF_M)
-
-#define T6_SOURCEPF_S    9
-#define T6_SOURCEPF_M    0x7U
-#define T6_SOURCEPF_G(x) (((x) >> T6_SOURCEPF_S) & T6_SOURCEPF_M)
-
-#define PL_INT_CAUSE_A 0x1940c
+#define UART_S    28
+#define UART_V(x) ((x) << UART_S)
+#define UART_F    UART_V(1U)
 
 #define ULP_TX_S    27
 #define ULP_TX_V(x) ((x) << ULP_TX_S)
@@ -2906,6 +6841,10 @@
 #define SGE_V(x) ((x) << SGE_S)
 #define SGE_F    SGE_V(1U)
 
+#define HMA_S    25
+#define HMA_V(x) ((x) << HMA_S)
+#define HMA_F    HMA_V(1U)
+
 #define CPL_SWITCH_S    24
 #define CPL_SWITCH_V(x) ((x) << CPL_SWITCH_S)
 #define CPL_SWITCH_F    CPL_SWITCH_V(1U)
@@ -2950,6 +6889,10 @@
 #define PCIE_V(x) ((x) << PCIE_S)
 #define PCIE_F    PCIE_V(1U)
 
+#define PMU_S    13
+#define PMU_V(x) ((x) << PMU_S)
+#define PMU_F    PMU_V(1U)
+
 #define XGMAC_KR1_S    12
 #define XGMAC_KR1_V(x) ((x) << XGMAC_KR1_S)
 #define XGMAC_KR1_F    XGMAC_KR1_V(1U)
@@ -2982,19 +6925,258 @@
 #define NCSI_V(x) ((x) << NCSI_S)
 #define NCSI_F    NCSI_V(1U)
 
-#define MPS_S    4
-#define MPS_V(x) ((x) << MPS_S)
-#define MPS_F    MPS_V(1U)
+#define MPS_S    4
+#define MPS_V(x) ((x) << MPS_S)
+#define MPS_F    MPS_V(1U)
+
+#define MI_S    3
+#define MI_V(x) ((x) << MI_S)
+#define MI_F    MI_V(1U)
+
+#define DBG_S    2
+#define DBG_V(x) ((x) << DBG_S)
+#define DBG_F    DBG_V(1U)
+
+#define I2CM_S    1
+#define I2CM_V(x) ((x) << I2CM_S)
+#define I2CM_F    I2CM_V(1U)
+
+#define CIM_S    0
+#define CIM_V(x) ((x) << CIM_S)
+#define CIM_F    CIM_V(1U)
+
+#define T7_PL_PERR_CRYPTO_KEY_S    31
+#define T7_PL_PERR_CRYPTO_KEY_V(x) ((x) << T7_PL_PERR_CRYPTO_KEY_S)
+#define T7_PL_PERR_CRYPTO_KEY_F    T7_PL_PERR_CRYPTO_KEY_V(1U)
+
+#define T7_PL_PERR_CRYPTO1_S    30
+#define T7_PL_PERR_CRYPTO1_V(x) ((x) << T7_PL_PERR_CRYPTO1_S)
+#define T7_PL_PERR_CRYPTO1_F    T7_PL_PERR_CRYPTO1_V(1U)
+
+#define T7_PL_PERR_CRYPTO0_S    29
+#define T7_PL_PERR_CRYPTO0_V(x) ((x) << T7_PL_PERR_CRYPTO0_S)
+#define T7_PL_PERR_CRYPTO0_F    T7_PL_PERR_CRYPTO0_V(1U)
+
+#define T7_PL_PERR_GCACHE_S    28
+#define T7_PL_PERR_GCACHE_V(x) ((x) << T7_PL_PERR_GCACHE_S)
+#define T7_PL_PERR_GCACHE_F    T7_PL_PERR_GCACHE_V(1U)
+
+#define T7_PL_PERR_ULP_TX_S    26
+#define T7_PL_PERR_ULP_TX_V(x) ((x) << T7_PL_PERR_ULP_TX_S)
+#define T7_PL_PERR_ULP_TX_F    T7_PL_PERR_ULP_TX_V(1U)
+
+#define T7_PL_PERR_SGE_S    25
+#define T7_PL_PERR_SGE_V(x) ((x) << T7_PL_PERR_SGE_S)
+#define T7_PL_PERR_SGE_F    T7_PL_PERR_SGE_V(1U)
+
+#define T7_PL_PERR_HMA_S    24
+#define T7_PL_PERR_HMA_V(x) ((x) << T7_PL_PERR_HMA_S)
+#define T7_PL_PERR_HMA_F    T7_PL_PERR_HMA_V(1U)
+
+#define T7_PL_PERR_CPL_SWITCH_S    23
+#define T7_PL_PERR_CPL_SWITCH_V(x) ((x) << T7_PL_PERR_CPL_SWITCH_S)
+#define T7_PL_PERR_CPL_SWITCH_F    T7_PL_PERR_CPL_SWITCH_V(1U)
+
+#define T7_PL_PERR_ULP_RX_S    22
+#define T7_PL_PERR_ULP_RX_V(x) ((x) << T7_PL_PERR_ULP_RX_S)
+#define T7_PL_PERR_ULP_RX_F    T7_PL_PERR_ULP_RX_V(1U)
+
+#define T7_PL_PERR_PM_RX_S    21
+#define T7_PL_PERR_PM_RX_V(x) ((x) << T7_PL_PERR_PM_RX_S)
+#define T7_PL_PERR_PM_RX_F    T7_PL_PERR_PM_RX_V(1U)
+
+#define T7_PL_PERR_PM_TX_S    20
+#define T7_PL_PERR_PM_TX_V(x) ((x) << T7_PL_PERR_PM_TX_S)
+#define T7_PL_PERR_PM_TX_F    T7_PL_PERR_PM_TX_V(1U)
+
+#define T7_PL_PERR_MA_S    19
+#define T7_PL_PERR_MA_V(x) ((x) << T7_PL_PERR_MA_S)
+#define T7_PL_PERR_MA_F    T7_PL_PERR_MA_V(1U)
+
+#define T7_PL_PERR_TP_S    18
+#define T7_PL_PERR_TP_V(x) ((x) << T7_PL_PERR_TP_S)
+#define T7_PL_PERR_TP_F    T7_PL_PERR_TP_V(1U)
+
+#define T7_PL_PERR_LE_S    17
+#define T7_PL_PERR_LE_V(x) ((x) << T7_PL_PERR_LE_S)
+#define T7_PL_PERR_LE_F    T7_PL_PERR_LE_V(1U)
+
+#define T7_PL_PERR_EDC1_S    16
+#define T7_PL_PERR_EDC1_V(x) ((x) << T7_PL_PERR_EDC1_S)
+#define T7_PL_PERR_EDC1_F    T7_PL_PERR_EDC1_V(1U)
+
+#define T7_PL_PERR_EDC0_S    15
+#define T7_PL_PERR_EDC0_V(x) ((x) << T7_PL_PERR_EDC0_S)
+#define T7_PL_PERR_EDC0_F    T7_PL_PERR_EDC0_V(1U)
+
+#define T7_PL_PERR_MC1_S    14
+#define T7_PL_PERR_MC1_V(x) ((x) << T7_PL_PERR_MC1_S)
+#define T7_PL_PERR_MC1_F    T7_PL_PERR_MC1_V(1U)
+
+#define T7_PL_PERR_MC0_S    13
+#define T7_PL_PERR_MC0_V(x) ((x) << T7_PL_PERR_MC0_S)
+#define T7_PL_PERR_MC0_F    T7_PL_PERR_MC0_V(1U)
+
+#define T7_PL_PERR_PCIE_S    12
+#define T7_PL_PERR_PCIE_V(x) ((x) << T7_PL_PERR_PCIE_S)
+#define T7_PL_PERR_PCIE_F    T7_PL_PERR_PCIE_V(1U)
+
+#define T7_PL_PERR_UART_S    11
+#define T7_PL_PERR_UART_V(x) ((x) << T7_PL_PERR_UART_S)
+#define T7_PL_PERR_UART_F    T7_PL_PERR_UART_V(1U)
+
+#define T7_PL_PERR_PMU_S    10
+#define T7_PL_PERR_PMU_V(x) ((x) << T7_PL_PERR_PMU_S)
+#define T7_PL_PERR_PMU_F    T7_PL_PERR_PMU_V(1U)
+
+#define T7_PL_PERR_MAC_S    9
+#define T7_PL_PERR_MAC_V(x) ((x) << T7_PL_PERR_MAC_S)
+#define T7_PL_PERR_MAC_F    T7_PL_PERR_MAC_V(1U)
+
+#define T7_PL_PERR_SMB_S    8
+#define T7_PL_PERR_SMB_V(x) ((x) << T7_PL_PERR_SMB_S)
+#define T7_PL_PERR_SMB_F    T7_PL_PERR_SMB_V(1U)
+
+#define T7_PL_PERR_SF_S    7
+#define T7_PL_PERR_SF_V(x) ((x) << T7_PL_PERR_SF_S)
+#define T7_PL_PERR_SF_F    T7_PL_PERR_SF_V(1U)
+
+#define T7_PL_PERR_PL_S    6
+#define T7_PL_PERR_PL_V(x) ((x) << T7_PL_PERR_PL_S)
+#define T7_PL_PERR_PL_F    T7_PL_PERR_PL_V(1U)
+
+#define T7_PL_PERR_NCSI_S    5
+#define T7_PL_PERR_NCSI_V(x) ((x) << T7_PL_PERR_NCSI_S)
+#define T7_PL_PERR_NCSI_F    T7_PL_PERR_NCSI_V(1U)
+
+#define T7_PL_PERR_MPS_S    4
+#define T7_PL_PERR_MPS_V(x) ((x) << T7_PL_PERR_MPS_S)
+#define T7_PL_PERR_MPS_F    T7_PL_PERR_MPS_V(1U)
+
+#define T7_PL_PERR_MI_S    3
+#define T7_PL_PERR_MI_V(x) ((x) << T7_PL_PERR_MI_S)
+#define T7_PL_PERR_MI_F    T7_PL_PERR_MI_V(1U)
+
+#define T7_PL_PERR_DBG_S    2
+#define T7_PL_PERR_DBG_V(x) ((x) << T7_PL_PERR_DBG_S)
+#define T7_PL_PERR_DBG_F    T7_PL_PERR_DBG_V(1U)
+
+#define T7_PL_PERR_I2CM_S    1
+#define T7_PL_PERR_I2CM_V(x) ((x) << T7_PL_PERR_I2CM_S)
+#define T7_PL_PERR_I2CM_F    T7_PL_PERR_I2CM_V(1U)
+
+#define T7_PL_PERR_CIM_S    0
+#define T7_PL_PERR_CIM_V(x) ((x) << T7_PL_PERR_CIM_S)
+#define T7_PL_PERR_CIM_F    T7_PL_PERR_CIM_V(1U)
+
+#define SOURCEPF_S    8
+#define SOURCEPF_M    0x7U
+#define SOURCEPF_G(x) (((x) >> SOURCEPF_S) & SOURCEPF_M)
+
+#define T6_SOURCEPF_S    9
+#define T6_SOURCEPF_M    0x7U
+#define T6_SOURCEPF_G(x) (((x) >> T6_SOURCEPF_S) & T6_SOURCEPF_M)
+
+#define PL_PERR_ENABLE_A 0x19408
+#define PL_INT_ENABLE_A 0x19410
+#define PL_INT_CAUSE_A 0x1940c
+
+#define MC1_S    31
+#define MC1_V(x) ((x) << MC1_S)
+#define MC1_F    MC1_V(1U)
+
+#define MAC3_S    12
+#define MAC3_V(x) ((x) << MAC3_S)
+#define MAC3_F    MAC3_V(1U)
+
+#define MAC2_S    11
+#define MAC2_V(x) ((x) << MAC2_S)
+#define MAC2_F    MAC2_V(1U)
+
+#define MC0_S    15
+#define MC0_V(x) ((x) << MC0_S)
+#define MC0_F    MC0_V(1U)
+
+#define MAC1_S    10
+#define MAC1_V(x) ((x) << MAC1_S)
+#define MAC1_F    MAC1_V(1U)
+
+#define MAC0_S    9
+#define MAC0_V(x) ((x) << MAC0_S)
+#define MAC0_F    MAC0_V(1U)
+
+#define T7_FLR_S    31
+#define T7_FLR_V(x) ((x) << T7_FLR_S)
+#define T7_FLR_F    T7_FLR_V(1U)
+
+#define T7_SW_CIM_S    30
+#define T7_SW_CIM_V(x) ((x) << T7_SW_CIM_S)
+#define T7_SW_CIM_F    T7_SW_CIM_V(1U)
+
+#define T7_HMA_S    27
+#define T7_HMA_V(x) ((x) << T7_HMA_S)
+#define T7_HMA_F    T7_HMA_V(1U)
+
+#define T7_UART_S    14
+#define T7_UART_V(x) ((x) << T7_UART_S)
+#define T7_UART_F    T7_UART_V(1U)
+
+#define T7_ULP_TX_S    29
+#define T7_ULP_TX_V(x) ((x) << T7_ULP_TX_S)
+#define T7_ULP_TX_F    T7_ULP_TX_V(1U)
+
+#define T7_SGE_S    28
+#define T7_SGE_V(x) ((x) << T7_SGE_S)
+#define T7_SGE_F    T7_SGE_V(1U)
+
+#define T7_CPL_SWITCH_S    26
+#define T7_CPL_SWITCH_V(x) ((x) << T7_CPL_SWITCH_S)
+#define T7_CPL_SWITCH_F    T7_CPL_SWITCH_V(1U)
+
+#define T7_ULP_RX_S    25
+#define T7_ULP_RX_V(x) ((x) << T7_ULP_RX_S)
+#define T7_ULP_RX_F    T7_ULP_RX_V(1U)
+
+#define T7_PM_RX_S    24
+#define T7_PM_RX_V(x) ((x) << T7_PM_RX_S)
+#define T7_PM_RX_F    T7_PM_RX_V(1U)
+
+#define T7_PM_TX_S    23
+#define T7_PM_TX_V(x) ((x) << T7_PM_TX_S)
+#define T7_PM_TX_F    T7_PM_TX_V(1U)
+
+#define T7_MA_S    22
+#define T7_MA_V(x) ((x) << T7_MA_S)
+#define T7_MA_F    T7_MA_V(1U)
+
+#define T7_TP_S    21
+#define T7_TP_V(x) ((x) << T7_TP_S)
+#define T7_TP_F    T7_TP_V(1U)
+
+#define T7_LE_S    20
+#define T7_LE_V(x) ((x) << T7_LE_S)
+#define T7_LE_F    T7_LE_V(1U)
+
+#define T7_EDC1_S    19
+#define T7_EDC1_V(x) ((x) << T7_EDC1_S)
+#define T7_EDC1_F    T7_EDC1_V(1U)
+
+#define T7_EDC0_S    18
+#define T7_EDC0_V(x) ((x) << T7_EDC0_S)
+#define T7_EDC0_F    T7_EDC0_V(1U)
 
-#define CIM_S    0
-#define CIM_V(x) ((x) << CIM_S)
-#define CIM_F    CIM_V(1U)
+#define T7_PCIE_S    15
+#define T7_PCIE_V(x) ((x) << T7_PCIE_S)
+#define T7_PCIE_F    T7_PCIE_V(1U)
 
-#define MC1_S    31
-#define MC1_V(x) ((x) << MC1_S)
-#define MC1_F    MC1_V(1U)
+#define T7_MC1_S    17
+#define T7_MC1_V(x) ((x) << T7_MC1_S)
+#define T7_MC1_F    T7_MC1_V(1U)
+
+#define T7_MC0_S    16
+#define T7_MC0_V(x) ((x) << T7_MC0_S)
+#define T7_MC0_F    T7_MC0_V(1U)
 
-#define PL_INT_ENABLE_A 0x19410
 #define PL_INT_MAP0_A 0x19414
 #define PL_RST_A 0x19428
 
@@ -3006,16 +7188,33 @@
 #define PIORSTMODE_V(x) ((x) << PIORSTMODE_S)
 #define PIORSTMODE_F    PIORSTMODE_V(1U)
 
+#define PL_PL_INT_ENABLE_A 0x19434
 #define PL_PL_INT_CAUSE_A 0x19430
 
 #define FATALPERR_S    4
 #define FATALPERR_V(x) ((x) << FATALPERR_S)
 #define FATALPERR_F    FATALPERR_V(1U)
 
+#define INVALIDACCESS_S    3
+#define INVALIDACCESS_V(x) ((x) << INVALIDACCESS_S)
+#define INVALIDACCESS_F    INVALIDACCESS_V(1U)
+
+#define TIMEOUT_S    2
+#define TIMEOUT_V(x) ((x) << TIMEOUT_S)
+#define TIMEOUT_F    TIMEOUT_V(1U)
+
+#define PLERR_S    1
+#define PLERR_V(x) ((x) << PLERR_S)
+#define PLERR_F    PLERR_V(1U)
+
 #define PERRVFID_S    0
 #define PERRVFID_V(x) ((x) << PERRVFID_S)
 #define PERRVFID_F    PERRVFID_V(1U)
 
+#define PL_BUSPERR_S    6
+#define PL_BUSPERR_V(x) ((x) << PL_BUSPERR_S)
+#define PL_BUSPERR_F    PL_BUSPERR_V(1U)
+
 #define PL_REV_A 0x1943c
 
 #define REV_S    0
@@ -3023,25 +7222,24 @@
 #define REV_V(x) ((x) << REV_S)
 #define REV_G(x) (((x) >> REV_S) & REV_M)
 
-#define HASHTBLMEMCRCERR_S    27
-#define HASHTBLMEMCRCERR_V(x) ((x) << HASHTBLMEMCRCERR_S)
-#define HASHTBLMEMCRCERR_F    HASHTBLMEMCRCERR_V(1U)
+#define PL_INT_ENABLE2_A 0x1947c
+#define PL_INT_CAUSE2_A 0x19478
 
-#define CMDTIDERR_S    22
-#define CMDTIDERR_V(x) ((x) << CMDTIDERR_S)
-#define CMDTIDERR_F    CMDTIDERR_V(1U)
+#define CRYPTO_KEY_S    4
+#define CRYPTO_KEY_V(x) ((x) << CRYPTO_KEY_S)
+#define CRYPTO_KEY_F    CRYPTO_KEY_V(1U)
 
-#define T6_UNKNOWNCMD_S    3
-#define T6_UNKNOWNCMD_V(x) ((x) << T6_UNKNOWNCMD_S)
-#define T6_UNKNOWNCMD_F    T6_UNKNOWNCMD_V(1U)
+#define CRYPTO1_S    3
+#define CRYPTO1_V(x) ((x) << CRYPTO1_S)
+#define CRYPTO1_F    CRYPTO1_V(1U)
 
-#define T6_LIP0_S    2
-#define T6_LIP0_V(x) ((x) << T6_LIP0_S)
-#define T6_LIP0_F    T6_LIP0_V(1U)
+#define CRYPTO0_S    2
+#define CRYPTO0_V(x) ((x) << CRYPTO0_S)
+#define CRYPTO0_F    CRYPTO0_V(1U)
 
-#define T6_LIPMISS_S    1
-#define T6_LIPMISS_V(x) ((x) << T6_LIPMISS_S)
-#define T6_LIPMISS_F    T6_LIPMISS_V(1U)
+#define GCACHE_S    1
+#define GCACHE_V(x) ((x) << GCACHE_S)
+#define GCACHE_F    GCACHE_V(1U)
 
 #define LE_DB_CONFIG_A 0x19c04
 #define LE_DB_ROUTING_TABLE_INDEX_A 0x19c10
@@ -3062,13 +7260,147 @@
 #define HASHTBLSIZE_M    0x1ffffU
 #define HASHTBLSIZE_G(x) (((x) >> HASHTBLSIZE_S) & HASHTBLSIZE_M)
 
+#define VFPARERR_S    14
+#define VFPARERR_V(x) ((x) << VFPARERR_S)
+#define VFPARERR_F    VFPARERR_V(1U)
+
 #define LE_DB_HASH_TID_BASE_A 0x19c30
 #define LE_DB_HASH_TBL_BASE_ADDR_A 0x19c30
-#define LE_DB_INT_CAUSE_A 0x19c3c
 #define LE_DB_CLCAM_TID_BASE_A 0x19df4
 #define LE_DB_TID_HASHBASE_A 0x19df8
 #define T6_LE_DB_HASH_TID_BASE_A 0x19df8
 
+#define LE_DB_INT_ENABLE_A 0x19c38
+#define LE_DB_INT_CAUSE_A 0x19c3c
+
+#define CLIPSUBERR_S    29
+#define CLIPSUBERR_V(x) ((x) << CLIPSUBERR_S)
+#define CLIPSUBERR_F    CLIPSUBERR_V(1U)
+
+#define CLCAMFIFOERR_S    28
+#define CLCAMFIFOERR_V(x) ((x) << CLCAMFIFOERR_S)
+#define CLCAMFIFOERR_F    CLCAMFIFOERR_V(1U)
+
+#define HASHTBLMEMCRCERR_S    27
+#define HASHTBLMEMCRCERR_V(x) ((x) << HASHTBLMEMCRCERR_S)
+#define HASHTBLMEMCRCERR_F    HASHTBLMEMCRCERR_V(1U)
+
+#define CTCAMINVLDENT_S    26
+#define CTCAMINVLDENT_V(x) ((x) << CTCAMINVLDENT_S)
+#define CTCAMINVLDENT_F    CTCAMINVLDENT_V(1U)
+
+#define TCAMINVLDENT_S    25
+#define TCAMINVLDENT_V(x) ((x) << TCAMINVLDENT_S)
+#define TCAMINVLDENT_F    TCAMINVLDENT_V(1U)
+
+#define TOTCNTERR_S    24
+#define TOTCNTERR_V(x) ((x) << TOTCNTERR_S)
+#define TOTCNTERR_F    TOTCNTERR_V(1U)
+
+#define CMDPRSRINTERR_S    23
+#define CMDPRSRINTERR_V(x) ((x) << CMDPRSRINTERR_S)
+#define CMDPRSRINTERR_F    CMDPRSRINTERR_V(1U)
+
+#define CMDTIDERR_S    22
+#define CMDTIDERR_V(x) ((x) << CMDTIDERR_S)
+#define CMDTIDERR_F    CMDTIDERR_V(1U)
+
+#define T6_ACTRGNFULL_S    21
+#define T6_ACTRGNFULL_V(x) ((x) << T6_ACTRGNFULL_S)
+#define T6_ACTRGNFULL_F    T6_ACTRGNFULL_V(1U)
+
+#define T6_ACTCNTIPV6TZERO_S    20
+#define T6_ACTCNTIPV6TZERO_V(x) ((x) << T6_ACTCNTIPV6TZERO_S)
+#define T6_ACTCNTIPV6TZERO_F    T6_ACTCNTIPV6TZERO_V(1U)
+
+#define T6_ACTCNTIPV4TZERO_S    19
+#define T6_ACTCNTIPV4TZERO_V(x) ((x) << T6_ACTCNTIPV4TZERO_S)
+#define T6_ACTCNTIPV4TZERO_F    T6_ACTCNTIPV4TZERO_V(1U)
+
+#define T6_ACTCNTIPV6ZERO_S    18
+#define T6_ACTCNTIPV6ZERO_V(x) ((x) << T6_ACTCNTIPV6ZERO_S)
+#define T6_ACTCNTIPV6ZERO_F    T6_ACTCNTIPV6ZERO_V(1U)
+
+#define T6_ACTCNTIPV4ZERO_S    17
+#define T6_ACTCNTIPV4ZERO_V(x) ((x) << T6_ACTCNTIPV4ZERO_S)
+#define T6_ACTCNTIPV4ZERO_F    T6_ACTCNTIPV4ZERO_V(1U)
+
+#define MAIFWRINTPERR_S    16
+#define MAIFWRINTPERR_V(x) ((x) << MAIFWRINTPERR_S)
+#define MAIFWRINTPERR_F    MAIFWRINTPERR_V(1U)
+
+#define HASHTBLMEMACCERR_S    15
+#define HASHTBLMEMACCERR_V(x) ((x) << HASHTBLMEMACCERR_S)
+#define HASHTBLMEMACCERR_F    HASHTBLMEMACCERR_V(1U)
+
+#define TCAMCRCERR_S    14
+#define TCAMCRCERR_V(x) ((x) << TCAMCRCERR_S)
+#define TCAMCRCERR_F    TCAMCRCERR_V(1U)
+
+#define TCAMINTPERR_S    13
+#define TCAMINTPERR_V(x) ((x) << TCAMINTPERR_S)
+#define TCAMINTPERR_F    TCAMINTPERR_V(1U)
+
+#define VFSRAMPERR_S    12
+#define VFSRAMPERR_V(x) ((x) << VFSRAMPERR_S)
+#define VFSRAMPERR_F    VFSRAMPERR_V(1U)
+
+#define SRVSRAMPERR_S    11
+#define SRVSRAMPERR_V(x) ((x) << SRVSRAMPERR_S)
+#define SRVSRAMPERR_F    SRVSRAMPERR_V(1U)
+
+#define SSRAMINTPERR_S    10
+#define SSRAMINTPERR_V(x) ((x) << SSRAMINTPERR_S)
+#define SSRAMINTPERR_F    SSRAMINTPERR_V(1U)
+
+#define CLCAMINTPERR_S    9
+#define CLCAMINTPERR_V(x) ((x) << CLCAMINTPERR_S)
+#define CLCAMINTPERR_F    CLCAMINTPERR_V(1U)
+
+#define CLCAMCRCPARERR_S    8
+#define CLCAMCRCPARERR_V(x) ((x) << CLCAMCRCPARERR_S)
+#define CLCAMCRCPARERR_F    CLCAMCRCPARERR_V(1U)
+
+#define HASHTBLACCFAIL_S    7
+#define HASHTBLACCFAIL_V(x) ((x) << HASHTBLACCFAIL_S)
+#define HASHTBLACCFAIL_F    HASHTBLACCFAIL_V(1U)
+
+#define TCAMACCFAIL_S    6
+#define TCAMACCFAIL_V(x) ((x) << TCAMACCFAIL_S)
+#define TCAMACCFAIL_F    TCAMACCFAIL_V(1U)
+
+#define SRVSRAMACCFAIL_S    5
+#define SRVSRAMACCFAIL_V(x) ((x) << SRVSRAMACCFAIL_S)
+#define SRVSRAMACCFAIL_F    SRVSRAMACCFAIL_V(1U)
+
+#define CLIPTCAMACCFAIL_S    4
+#define CLIPTCAMACCFAIL_V(x) ((x) << CLIPTCAMACCFAIL_S)
+#define CLIPTCAMACCFAIL_F    CLIPTCAMACCFAIL_V(1U)
+
+#define T6_UNKNOWNCMD_S    3
+#define T6_UNKNOWNCMD_V(x) ((x) << T6_UNKNOWNCMD_S)
+#define T6_UNKNOWNCMD_F    T6_UNKNOWNCMD_V(1U)
+
+#define T6_LIP0_S    2
+#define T6_LIP0_V(x) ((x) << T6_LIP0_S)
+#define T6_LIP0_F    T6_LIP0_V(1U)
+
+#define T6_LIPMISS_S    1
+#define T6_LIPMISS_V(x) ((x) << T6_LIPMISS_S)
+#define T6_LIPMISS_F    T6_LIPMISS_V(1U)
+
+#define PIPELINEERR_S    0
+#define PIPELINEERR_V(x) ((x) << PIPELINEERR_S)
+#define PIPELINEERR_F    PIPELINEERR_V(1U)
+
+#define CACHEINTPERR_S    31
+#define CACHEINTPERR_V(x) ((x) << CACHEINTPERR_S)
+#define CACHEINTPERR_F    CACHEINTPERR_V(1U)
+
+#define CACHESRAMPERR_S    30
+#define CACHESRAMPERR_V(x) ((x) << CACHESRAMPERR_S)
+#define CACHESRAMPERR_F    CACHESRAMPERR_V(1U)
+
 #define HASHEN_S    20
 #define HASHEN_V(x) ((x) << HASHEN_S)
 #define HASHEN_F    HASHEN_V(1U)
@@ -3085,6 +7417,10 @@
 #define UNKNOWNCMD_V(x) ((x) << UNKNOWNCMD_S)
 #define UNKNOWNCMD_F    UNKNOWNCMD_V(1U)
 
+#define ACTRGNFULL_S    7
+#define ACTRGNFULL_V(x) ((x) << ACTRGNFULL_S)
+#define ACTRGNFULL_F    ACTRGNFULL_V(1U)
+
 #define PARITYERR_S    6
 #define PARITYERR_V(x) ((x) << PARITYERR_S)
 #define PARITYERR_F    PARITYERR_V(1U)
@@ -3101,14 +7437,6 @@
 #define BASEADDR_M    0x1fffffffU
 #define BASEADDR_G(x) (((x) >> BASEADDR_S) & BASEADDR_M)
 
-#define TCAMINTPERR_S    13
-#define TCAMINTPERR_V(x) ((x) << TCAMINTPERR_S)
-#define TCAMINTPERR_F    TCAMINTPERR_V(1U)
-
-#define SSRAMINTPERR_S    10
-#define SSRAMINTPERR_V(x) ((x) << SSRAMINTPERR_S)
-#define SSRAMINTPERR_F    SSRAMINTPERR_V(1U)
-
 #define LE_DB_RSP_CODE_0_A	0x19c74
 
 #define TCAM_ACTV_HIT_S		0
@@ -3126,8 +7454,13 @@
 #define LE_3_DB_HASH_MASK_GEN_IPV4_T6_A	0x19eac
 #define LE_4_DB_HASH_MASK_GEN_IPV4_T6_A	0x19eb0
 
+#define NCSI_INT_ENABLE_A 0x1a0d4
 #define NCSI_INT_CAUSE_A 0x1a0d8
 
+#define CIM2NC_PERR_S    9
+#define CIM2NC_PERR_V(x) ((x) << CIM2NC_PERR_S)
+#define CIM2NC_PERR_F    CIM2NC_PERR_V(1U)
+
 #define CIM_DM_PRTY_ERR_S    8
 #define CIM_DM_PRTY_ERR_V(x) ((x) << CIM_DM_PRTY_ERR_S)
 #define CIM_DM_PRTY_ERR_F    CIM_DM_PRTY_ERR_V(1U)
@@ -3144,6 +7477,53 @@
 #define RXFIFO_PRTY_ERR_V(x) ((x) << RXFIFO_PRTY_ERR_S)
 #define RXFIFO_PRTY_ERR_F    RXFIFO_PRTY_ERR_V(1U)
 
+#define NCSI_XGMAC0_INT_ENABLE_A 0x1a2d4
+#define NCSI_XGMAC0_INT_CAUSE_A 0x1a2d8
+
+#define XAUIPCSDECERR_S    24
+#define XAUIPCSDECERR_V(x) ((x) << XAUIPCSDECERR_S)
+#define XAUIPCSDECERR_F    XAUIPCSDECERR_V(1U)
+
+#define RGMIIRXFIFOOVERFLOW_S    23
+#define RGMIIRXFIFOOVERFLOW_V(x) ((x) << RGMIIRXFIFOOVERFLOW_S)
+#define RGMIIRXFIFOOVERFLOW_F    RGMIIRXFIFOOVERFLOW_V(1U)
+
+#define RGMIIRXFIFOUNDERFLOW_S    22
+#define RGMIIRXFIFOUNDERFLOW_V(x) ((x) << RGMIIRXFIFOUNDERFLOW_S)
+#define RGMIIRXFIFOUNDERFLOW_F    RGMIIRXFIFOUNDERFLOW_V(1U)
+
+#define RXPKTSIZEERROR_S    21
+#define RXPKTSIZEERROR_V(x) ((x) << RXPKTSIZEERROR_S)
+#define RXPKTSIZEERROR_F    RXPKTSIZEERROR_V(1U)
+
+#define WOLPATDETECTED_S    20
+#define WOLPATDETECTED_V(x) ((x) << WOLPATDETECTED_S)
+#define WOLPATDETECTED_F    WOLPATDETECTED_V(1U)
+
+#define TXFIFO_UNDERRUN_S    13
+#define TXFIFO_UNDERRUN_V(x) ((x) << TXFIFO_UNDERRUN_S)
+#define TXFIFO_UNDERRUN_F    TXFIFO_UNDERRUN_V(1U)
+
+#define RXFIFO_OVERFLOW_S    12
+#define RXFIFO_OVERFLOW_V(x) ((x) << RXFIFO_OVERFLOW_S)
+#define RXFIFO_OVERFLOW_F    RXFIFO_OVERFLOW_V(1U)
+
+#define XAUIPCSCTCERR_S    3
+#define XAUIPCSCTCERR_V(x) ((x) << XAUIPCSCTCERR_S)
+#define XAUIPCSCTCERR_F    XAUIPCSCTCERR_V(1U)
+
+#define XAUIPCSALIGNCHANGE_S    2
+#define XAUIPCSALIGNCHANGE_V(x) ((x) << XAUIPCSALIGNCHANGE_S)
+#define XAUIPCSALIGNCHANGE_F    XAUIPCSALIGNCHANGE_V(1U)
+
+#define RGMIILINKSTSCHANGE_S    1
+#define RGMIILINKSTSCHANGE_V(x) ((x) << RGMIILINKSTSCHANGE_S)
+#define RGMIILINKSTSCHANGE_F    RGMIILINKSTSCHANGE_V(1U)
+
+#define XGM_INT_S    2
+#define XGM_INT_V(x) ((x) << XGM_INT_S)
+#define XGM_INT_F    XGM_INT_V(1U)
+
 #define XGMAC_PORT_CFG2_A 0x1018
 
 #define PATEN_S    18
@@ -3171,8 +7551,180 @@
 #define ADDRESS_V(x) ((x) << ADDRESS_S)
 
 #define MAC_PORT_INT_CAUSE_A 0x8dc
+#define T7_MAC_PORT_INT_EN_A 0x868
+#define T7_MAC_PORT_INT_CAUSE_A 0x86c
+
+#define MAC2MPS_PERR_CAUSE_S    31
+#define MAC2MPS_PERR_CAUSE_V(x) ((x) << MAC2MPS_PERR_CAUSE_S)
+#define MAC2MPS_PERR_CAUSE_F    MAC2MPS_PERR_CAUSE_V(1U)
+
+#define MAC_PPS_INT_CAUSE_S    30
+#define MAC_PPS_INT_CAUSE_V(x) ((x) << MAC_PPS_INT_CAUSE_S)
+#define MAC_PPS_INT_CAUSE_F    MAC_PPS_INT_CAUSE_V(1U)
+
+#define MAC_TX_TS_AVAIL_INT_CAUSE_S    29
+#define MAC_TX_TS_AVAIL_INT_CAUSE_V(x) ((x) << MAC_TX_TS_AVAIL_INT_CAUSE_S)
+#define MAC_TX_TS_AVAIL_INT_CAUSE_F    MAC_TX_TS_AVAIL_INT_CAUSE_V(1U)
+
+#define MAC_PATDETWAKE_INT_CAUSE_S    26
+#define MAC_PATDETWAKE_INT_CAUSE_V(x) ((x) << MAC_PATDETWAKE_INT_CAUSE_S)
+#define MAC_PATDETWAKE_INT_CAUSE_F    MAC_PATDETWAKE_INT_CAUSE_V(1U)
+
+#define MAC_MAGIC_WAKE_INT_CAUSE_S    25
+#define MAC_MAGIC_WAKE_INT_CAUSE_V(x) ((x) << MAC_MAGIC_WAKE_INT_CAUSE_S)
+#define MAC_MAGIC_WAKE_INT_CAUSE_F    MAC_MAGIC_WAKE_INT_CAUSE_V(1U)
+
+#define MAC_SIGDETCHG_INT_CAUSE_S    24
+#define MAC_SIGDETCHG_INT_CAUSE_V(x) ((x) << MAC_SIGDETCHG_INT_CAUSE_S)
+#define MAC_SIGDETCHG_INT_CAUSE_F    MAC_SIGDETCHG_INT_CAUSE_V(1U)
+
+#define MAC_PCS_LINK_GOOD_CAUSE_S    12
+#define MAC_PCS_LINK_GOOD_CAUSE_V(x) ((x) << MAC_PCS_LINK_GOOD_CAUSE_S)
+#define MAC_PCS_LINK_GOOD_CAUSE_F    MAC_PCS_LINK_GOOD_CAUSE_V(1U)
+
+#define MAC_PCS_LINK_FAIL_CAUSE_S    11
+#define MAC_PCS_LINK_FAIL_CAUSE_V(x) ((x) << MAC_PCS_LINK_FAIL_CAUSE_S)
+#define MAC_PCS_LINK_FAIL_CAUSE_F    MAC_PCS_LINK_FAIL_CAUSE_V(1U)
+
+#define MAC_REM_FAULT_INT_CAUSE_S    7
+#define MAC_REM_FAULT_INT_CAUSE_V(x) ((x) << MAC_REM_FAULT_INT_CAUSE_S)
+#define MAC_REM_FAULT_INT_CAUSE_F    MAC_REM_FAULT_INT_CAUSE_V(1U)
+
+#define MAC_LOC_FAULT_INT_CAUSE_S    6
+#define MAC_LOC_FAULT_INT_CAUSE_V(x) ((x) << MAC_LOC_FAULT_INT_CAUSE_S)
+#define MAC_LOC_FAULT_INT_CAUSE_F    MAC_LOC_FAULT_INT_CAUSE_V(1U)
+
+#define MAC_LINK_DOWN_INT_CAUSE_S    5
+#define MAC_LINK_DOWN_INT_CAUSE_V(x) ((x) << MAC_LINK_DOWN_INT_CAUSE_S)
+#define MAC_LINK_DOWN_INT_CAUSE_F    MAC_LINK_DOWN_INT_CAUSE_V(1U)
+
+#define MAC_LINK_UP_INT_CAUSE_S    4
+#define MAC_LINK_UP_INT_CAUSE_V(x) ((x) << MAC_LINK_UP_INT_CAUSE_S)
+#define MAC_LINK_UP_INT_CAUSE_F    MAC_LINK_UP_INT_CAUSE_V(1U)
+
+#define MAC_AN_DONE_INT_CAUSE_S    3
+#define MAC_AN_DONE_INT_CAUSE_V(x) ((x) << MAC_AN_DONE_INT_CAUSE_S)
+#define MAC_AN_DONE_INT_CAUSE_F    MAC_AN_DONE_INT_CAUSE_V(1U)
+
+#define MAC_AN_PGRD_INT_CAUSE_S    2
+#define MAC_AN_PGRD_INT_CAUSE_V(x) ((x) << MAC_AN_PGRD_INT_CAUSE_S)
+#define MAC_AN_PGRD_INT_CAUSE_F    MAC_AN_PGRD_INT_CAUSE_V(1U)
+
+#define MAC_TXFIFO_ERR_INT_CAUSE_S    1
+#define MAC_TXFIFO_ERR_INT_CAUSE_V(x) ((x) << MAC_TXFIFO_ERR_INT_CAUSE_S)
+#define MAC_TXFIFO_ERR_INT_CAUSE_F    MAC_TXFIFO_ERR_INT_CAUSE_V(1U)
+
+#define MAC_RXFIFO_ERR_INT_CAUSE_S    0
+#define MAC_RXFIFO_ERR_INT_CAUSE_V(x) ((x) << MAC_RXFIFO_ERR_INT_CAUSE_S)
+#define MAC_RXFIFO_ERR_INT_CAUSE_F    MAC_RXFIFO_ERR_INT_CAUSE_V(1U)
+
+#define MAC_PORT_PERR_INT_EN_A 0x8e0
+#define MAC_PORT_PERR_INT_CAUSE_A 0x8e4
+#define T7_MAC_PORT_PERR_INT_EN_A 0x870
+#define T7_MAC_PORT_PERR_INT_CAUSE_A 0x874
+#define MAC_PORT_PERR_INT_EN_100G_A 0x884
+#define MAC_PORT_PERR_INT_CAUSE_100G_A 0x888
+#define T7_MAC_PORT_PERR_INT_EN_100G_A 0x82c
+#define T7_MAC_PORT_PERR_INT_CAUSE_100G_A 0x830
+
+#define MAC_PERR_INT_EN_MTIP_A 0x380d0
+#define MAC_PERR_INT_CAUSE_MTIP_A 0x380d4
+
+#define MAC_IOS_INTR_EN_QUAD0_A 0x3a090
+#define MAC_IOS_INTR_CAUSE_QUAD0_A 0x3a094
+
+#define Q0_MAILBOX_INT_ASSERT_S    24
+#define Q0_MAILBOX_INT_ASSERT_V(x) ((x) << Q0_MAILBOX_INT_ASSERT_S)
+#define Q0_MAILBOX_INT_ASSERT_F    Q0_MAILBOX_INT_ASSERT_V(1U)
+
+#define MAC_IOS_INTR_EN_QUAD1_A 0x3a098
+#define MAC_IOS_INTR_CAUSE_QUAD1_A 0x3a09c
+
+#define Q1_MAILBOX_INT_ASSERT_S    24
+#define Q1_MAILBOX_INT_ASSERT_V(x) ((x) << Q1_MAILBOX_INT_ASSERT_S)
+#define Q1_MAILBOX_INT_ASSERT_F    Q1_MAILBOX_INT_ASSERT_V(1U)
+
+#define PERR_MAC0_TX_S    19
+#define PERR_MAC0_TX_V(x) ((x) << PERR_MAC0_TX_S)
+#define PERR_MAC0_TX_F    PERR_MAC0_TX_V(1U)
+
+#define PERR_MAC1_TX_S    18
+#define PERR_MAC1_TX_V(x) ((x) << PERR_MAC1_TX_S)
+#define PERR_MAC1_TX_F    PERR_MAC1_TX_V(1U)
+
+#define PERR_MAC2_TX_S    17
+#define PERR_MAC2_TX_V(x) ((x) << PERR_MAC2_TX_S)
+#define PERR_MAC2_TX_F    PERR_MAC2_TX_V(1U)
+
+#define PERR_MAC3_TX_S    16
+#define PERR_MAC3_TX_V(x) ((x) << PERR_MAC3_TX_S)
+#define PERR_MAC3_TX_F    PERR_MAC3_TX_V(1U)
+
+#define PERR_MAC4_TX_S    15
+#define PERR_MAC4_TX_V(x) ((x) << PERR_MAC4_TX_S)
+#define PERR_MAC4_TX_F    PERR_MAC4_TX_V(1U)
+
+#define PERR_MAC5_TX_S    14
+#define PERR_MAC5_TX_V(x) ((x) << PERR_MAC5_TX_S)
+#define PERR_MAC5_TX_F    PERR_MAC5_TX_V(1U)
+
+#define PERR_MAC0_RX_S    13
+#define PERR_MAC0_RX_V(x) ((x) << PERR_MAC0_RX_S)
+#define PERR_MAC0_RX_F    PERR_MAC0_RX_V(1U)
+
+#define PERR_MAC1_RX_S    12
+#define PERR_MAC1_RX_V(x) ((x) << PERR_MAC1_RX_S)
+#define PERR_MAC1_RX_F    PERR_MAC1_RX_V(1U)
+
+#define PERR_MAC2_RX_S    11
+#define PERR_MAC2_RX_V(x) ((x) << PERR_MAC2_RX_S)
+#define PERR_MAC2_RX_F    PERR_MAC2_RX_V(1U)
+
+#define PERR_MAC3_RX_S    10
+#define PERR_MAC3_RX_V(x) ((x) << PERR_MAC3_RX_S)
+#define PERR_MAC3_RX_F    PERR_MAC3_RX_V(1U)
+
+#define PERR_MAC4_RX_S    9
+#define PERR_MAC4_RX_V(x) ((x) << PERR_MAC4_RX_S)
+#define PERR_MAC4_RX_F    PERR_MAC4_RX_V(1U)
+
+#define PERR_MAC5_RX_S    8
+#define PERR_MAC5_RX_V(x) ((x) << PERR_MAC5_RX_S)
+#define PERR_MAC5_RX_F    PERR_MAC5_RX_V(1U)
+
+#define PERR_MAC_STAT_RX_S    7
+#define PERR_MAC_STAT_RX_V(x) ((x) << PERR_MAC_STAT_RX_S)
+#define PERR_MAC_STAT_RX_F    PERR_MAC_STAT_RX_V(1U)
+
+#define PERR_MAC_STAT_TX_S    3
+#define PERR_MAC_STAT_TX_V(x) ((x) << PERR_MAC_STAT_TX_S)
+#define PERR_MAC_STAT_TX_F    PERR_MAC_STAT_TX_V(1U)
+
+#define PERR_MAC_STAT_CAP_S    2
+#define PERR_MAC_STAT_CAP_V(x) ((x) << PERR_MAC_STAT_CAP_S)
+#define PERR_MAC_STAT_CAP_F    PERR_MAC_STAT_CAP_V(1U)
+
+#define XGMAC_PORT_INT_EN_A 0x10d8
 #define XGMAC_PORT_INT_CAUSE_A 0x10dc
 
+#define RXFIFOOVERFLOW_S    10
+#define RXFIFOOVERFLOW_V(x) ((x) << RXFIFOOVERFLOW_S)
+#define RXFIFOOVERFLOW_F    RXFIFOOVERFLOW_V(1U)
+
+#define MAC_PORT_INT_EN_A 0x8d8
+
+#define T6_PERR_PKT_RAM_S    31
+#define T6_PERR_PKT_RAM_V(x) ((x) << T6_PERR_PKT_RAM_S)
+#define T6_PERR_PKT_RAM_F    T6_PERR_PKT_RAM_V(1U)
+
+#define T6_PERR_MASK_RAM_S    30
+#define T6_PERR_MASK_RAM_V(x) ((x) << T6_PERR_MASK_RAM_S)
+#define T6_PERR_MASK_RAM_F    T6_PERR_MASK_RAM_V(1U)
+
+#define T6_PERR_CRC_RAM_S    29
+#define T6_PERR_CRC_RAM_V(x) ((x) << T6_PERR_CRC_RAM_S)
+#define T6_PERR_CRC_RAM_F    T6_PERR_CRC_RAM_V(1U)
+
 #define TP_TX_MOD_QUEUE_REQ_MAP_A 0x7e28
 
 #define TP_TX_MOD_QUEUE_WEIGHT0_A 0x7e30
@@ -3197,18 +7749,34 @@
 #define TP_TX_SCHED_FIFO_A 0x24
 #define TP_TX_SCHED_PCMD_A 0x25
 
-#define NUM_MPS_CLS_SRAM_L_INSTANCES 336
 #define NUM_MPS_T5_CLS_SRAM_L_INSTANCES 512
 
+#define MPS_T5_CLS_SRAM_L_A 0xe000
+#define MPS_T5_CLS_SRAM_H_A 0xe004
+
+#define SRAMWRN_S    31
+#define SRAMWRN_V(x) ((x) << SRAMWRN_S)
+
+#define SRAMINDEX_S    16
+#define SRAMINDEX_M    0x7ffU
+#define SRAMINDEX_V(x) ((x) << SRAMINDEX_S)
+
 #define T5_PORT0_BASE 0x30000
 #define T5_PORT_STRIDE 0x4000
 #define T5_PORT_BASE(idx) (T5_PORT0_BASE + (idx) * T5_PORT_STRIDE)
 #define T5_PORT_REG(idx, reg) (T5_PORT_BASE(idx) + (reg))
 
+#define T7_PORT0_BASE 0x30000
+#define T7_PORT_STRIDE 0x2000
+#define T7_PORT_BASE(idx) (T7_PORT0_BASE + (idx) * T7_PORT_STRIDE)
+#define T7_PORT_REG(idx, reg) (T7_PORT_BASE(idx) + (reg))
+
 #define MC_0_BASE_ADDR 0x40000
 #define MC_1_BASE_ADDR 0x48000
 #define MC_STRIDE (MC_1_BASE_ADDR - MC_0_BASE_ADDR)
 #define MC_REG(reg, idx) (reg + MC_STRIDE * idx)
+#define MC_T7_STRIDE (MC_T71_BASE_ADDR - MC_T70_BASE_ADDR)
+#define MC_T7_REG(reg, idx) ((reg) + MC_T7_STRIDE * (idx))
 
 #define MC_P_BIST_CMD_A			0x41400
 #define MC_P_BIST_CMD_ADDR_A		0x41404
@@ -3223,6 +7791,10 @@
 #define EDC_H_BIST_CMD_LEN_A		0x5000c
 #define EDC_H_BIST_DATA_PATTERN_A	0x50010
 #define EDC_H_BIST_STATUS_RDATA_A	0x50028
+#define EDC_H_INT_ENABLE_A 0x50074
+#define EDC_H_INT_CAUSE_A 0x50078
+
+#define EDC_H_ECC_STATUS_A 0x5007c
 
 #define EDC_H_ECC_ERR_ADDR_A		0x50084
 #define EDC_T51_BASE_ADDR		0x50800
@@ -3234,6 +7806,390 @@
 #define PL_VF_WHOAMI_A 0x0
 #define PL_VF_REVISION_A 0x8
 
+#define PL_TIMEOUT_STATUS0_A 0x194f4
+#define PL_TIMEOUT_STATUS1_A 0x194f8
+
+/* registers for module CRYPTO_0 */
+#define CRYPTO_0_BASE_ADDR 0x44000
+
+#define TLS_TX_CH_INT_ENABLE_A 0x44008
+#define TLS_TX_CH_INT_CAUSE_A 0x4400c
+
+#define TLS_TX_CH_REG(reg_addr, idx) ((reg_addr) + (idx) * 256)
+#define NUM_TLS_TX_CH_INSTANCES 6
+
+#define KEX_CERR_S    4
+#define KEX_CERR_V(x) ((x) << KEX_CERR_S)
+#define KEX_CERR_F    KEX_CERR_V(1U)
+
+#define KEYLENERR_S    3
+#define KEYLENERR_V(x) ((x) << KEYLENERR_S)
+#define KEYLENERR_F    KEYLENERR_V(1U)
+
+#define INTF1_PERR_S    2
+#define INTF1_PERR_V(x) ((x) << INTF1_PERR_S)
+#define INTF1_PERR_F    INTF1_PERR_V(1U)
+
+#define INTF0_PERR_S    1
+#define INTF0_PERR_V(x) ((x) << INTF0_PERR_S)
+#define INTF0_PERR_F    INTF0_PERR_V(1U)
+
+#define KEX_PERR_S    0
+#define KEX_PERR_V(x) ((x) << KEX_PERR_S)
+#define KEX_PERR_F    KEX_PERR_V(1U)
+
+/* registers for module CRYPTO_1 */
+#define CRYPTO_1_BASE_ADDR 0x45000
+
+/* registers for module CRYPTO_KEY */
+
+#define CRYPTO_KEY_INT_ENABLE_A 0x46008
+#define CRYPTO_KEY_INT_CAUSE_A 0x4600c
+
+#define MA_FIFO_PERR_S    22
+#define MA_FIFO_PERR_V(x) ((x) << MA_FIFO_PERR_S)
+#define MA_FIFO_PERR_F    MA_FIFO_PERR_V(1U)
+
+#define MA_RSP_PERR_S    21
+#define MA_RSP_PERR_V(x) ((x) << MA_RSP_PERR_S)
+#define MA_RSP_PERR_F    MA_RSP_PERR_V(1U)
+
+#define ING_CACHE_DATA_PERR_S    19
+#define ING_CACHE_DATA_PERR_V(x) ((x) << ING_CACHE_DATA_PERR_S)
+#define ING_CACHE_DATA_PERR_F    ING_CACHE_DATA_PERR_V(1U)
+
+#define ING_CACHE_TAG_PERR_S    18
+#define ING_CACHE_TAG_PERR_V(x) ((x) << ING_CACHE_TAG_PERR_S)
+#define ING_CACHE_TAG_PERR_F    ING_CACHE_TAG_PERR_V(1U)
+
+#define LKP_KEY_REQ_PERR_S    17
+#define LKP_KEY_REQ_PERR_V(x) ((x) << LKP_KEY_REQ_PERR_S)
+#define LKP_KEY_REQ_PERR_F    LKP_KEY_REQ_PERR_V(1U)
+
+#define LKP_CLIP_TCAM_PERR_S    16
+#define LKP_CLIP_TCAM_PERR_V(x) ((x) << LKP_CLIP_TCAM_PERR_S)
+#define LKP_CLIP_TCAM_PERR_F    LKP_CLIP_TCAM_PERR_V(1U)
+
+#define LKP_MAIN_TCAM_PERR_S    15
+#define LKP_MAIN_TCAM_PERR_V(x) ((x) << LKP_MAIN_TCAM_PERR_S)
+#define LKP_MAIN_TCAM_PERR_F    LKP_MAIN_TCAM_PERR_V(1U)
+
+#define EGR_KEY_REQ_PERR_S    14
+#define EGR_KEY_REQ_PERR_V(x) ((x) << EGR_KEY_REQ_PERR_S)
+#define EGR_KEY_REQ_PERR_F    EGR_KEY_REQ_PERR_V(1U)
+
+#define EGR_CACHE_DATA_PERR_S    13
+#define EGR_CACHE_DATA_PERR_V(x) ((x) << EGR_CACHE_DATA_PERR_S)
+#define EGR_CACHE_DATA_PERR_F    EGR_CACHE_DATA_PERR_V(1U)
+
+#define EGR_CACHE_TAG_PERR_S    12
+#define EGR_CACHE_TAG_PERR_V(x) ((x) << EGR_CACHE_TAG_PERR_S)
+#define EGR_CACHE_TAG_PERR_F    EGR_CACHE_TAG_PERR_V(1U)
+
+#define CIM_PERR_S    11
+#define CIM_PERR_V(x) ((x) << CIM_PERR_S)
+#define CIM_PERR_F    CIM_PERR_V(1U)
+
+#define MA_INV_RSP_TAG_S    10
+#define MA_INV_RSP_TAG_V(x) ((x) << MA_INV_RSP_TAG_S)
+#define MA_INV_RSP_TAG_F    MA_INV_RSP_TAG_V(1U)
+
+#define ING_KEY_RANGE_ERR_S    9
+#define ING_KEY_RANGE_ERR_V(x) ((x) << ING_KEY_RANGE_ERR_S)
+#define ING_KEY_RANGE_ERR_F    ING_KEY_RANGE_ERR_V(1U)
+
+#define ING_MFIFO_OVFL_S    8
+#define ING_MFIFO_OVFL_V(x) ((x) << ING_MFIFO_OVFL_S)
+#define ING_MFIFO_OVFL_F    ING_MFIFO_OVFL_V(1U)
+
+#define LKP_REQ_OVFL_S    7
+#define LKP_REQ_OVFL_V(x) ((x) << LKP_REQ_OVFL_S)
+#define LKP_REQ_OVFL_F    LKP_REQ_OVFL_V(1U)
+
+#define EOK_WAIT_ERR_S    6
+#define EOK_WAIT_ERR_V(x) ((x) << EOK_WAIT_ERR_S)
+#define EOK_WAIT_ERR_F    EOK_WAIT_ERR_V(1U)
+
+#define EGR_KEY_RANGE_ERR_S    5
+#define EGR_KEY_RANGE_ERR_V(x) ((x) << EGR_KEY_RANGE_ERR_S)
+#define EGR_KEY_RANGE_ERR_F    EGR_KEY_RANGE_ERR_V(1U)
+
+#define EGR_MFIFO_OVFL_S    4
+#define EGR_MFIFO_OVFL_V(x) ((x) << EGR_MFIFO_OVFL_S)
+#define EGR_MFIFO_OVFL_F    EGR_MFIFO_OVFL_V(1U)
+
+#define SEQ_WRAP_HP_OVFL_S    3
+#define SEQ_WRAP_HP_OVFL_V(x) ((x) << SEQ_WRAP_HP_OVFL_S)
+#define SEQ_WRAP_HP_OVFL_F    SEQ_WRAP_HP_OVFL_V(1U)
+
+#define SEQ_WRAP_LP_OVFL_S    2
+#define SEQ_WRAP_LP_OVFL_V(x) ((x) << SEQ_WRAP_LP_OVFL_S)
+#define SEQ_WRAP_LP_OVFL_F    SEQ_WRAP_LP_OVFL_V(1U)
+
+#define EGR_SEQ_WRAP_HP_S    1
+#define EGR_SEQ_WRAP_HP_V(x) ((x) << EGR_SEQ_WRAP_HP_S)
+#define EGR_SEQ_WRAP_HP_F    EGR_SEQ_WRAP_HP_V(1U)
+
+#define EGR_SEQ_WRAP_LP_S    0
+#define EGR_SEQ_WRAP_LP_V(x) ((x) << EGR_SEQ_WRAP_LP_S)
+#define EGR_SEQ_WRAP_LP_F    EGR_SEQ_WRAP_LP_V(1U)
+
+/* registers for module MC_T70 */
+#define MC_T70_BASE_ADDR 0x48000
+
+#define MC_IND_ADDR_A 0x48000
+#define MC_IND_DATA_A 0x48004
+#define MC_P_DDRCTL_INT_ENABLE_A 0x4930c
+#define MC_P_DDRCTL_INT_CAUSE_A 0x49310
+
+#define HIF_WDATA_PTR_ADDR_ERR_INTR_DCH1_CAUSE_S    5
+#define HIF_WDATA_PTR_ADDR_ERR_INTR_DCH1_CAUSE_V(x) \
+	((x) << HIF_WDATA_PTR_ADDR_ERR_INTR_DCH1_CAUSE_S)
+#define HIF_WDATA_PTR_ADDR_ERR_INTR_DCH1_CAUSE_F    HIF_WDATA_PTR_ADDR_ERR_INTR_DCH1_CAUSE_V(1U)
+
+#define HIF_RDATA_CRC_ERR_INTR_DCH1_CAUSE_S    4
+#define HIF_RDATA_CRC_ERR_INTR_DCH1_CAUSE_V(x) ((x) << HIF_RDATA_CRC_ERR_INTR_DCH1_CAUSE_S)
+#define HIF_RDATA_CRC_ERR_INTR_DCH1_CAUSE_F    HIF_RDATA_CRC_ERR_INTR_DCH1_CAUSE_V(1U)
+
+#define HIF_RDATA_ADDR_ERR_INTR_DCH1_CAUSE_S    3
+#define HIF_RDATA_ADDR_ERR_INTR_DCH1_CAUSE_V(x) ((x) << HIF_RDATA_ADDR_ERR_INTR_DCH1_CAUSE_S)
+#define HIF_RDATA_ADDR_ERR_INTR_DCH1_CAUSE_F    HIF_RDATA_ADDR_ERR_INTR_DCH1_CAUSE_V(1U)
+
+#define HIF_WDATA_PTR_ADDR_ERR_INTR_DCH0_CAUSE_S    2
+#define HIF_WDATA_PTR_ADDR_ERR_INTR_DCH0_CAUSE_V(x) \
+	((x) << HIF_WDATA_PTR_ADDR_ERR_INTR_DCH0_CAUSE_S)
+#define HIF_WDATA_PTR_ADDR_ERR_INTR_DCH0_CAUSE_F    HIF_WDATA_PTR_ADDR_ERR_INTR_DCH0_CAUSE_V(1U)
+
+#define HIF_RDATA_CRC_ERR_INTR_DCH0_CAUSE_S    1
+#define HIF_RDATA_CRC_ERR_INTR_DCH0_CAUSE_V(x) ((x) << HIF_RDATA_CRC_ERR_INTR_DCH0_CAUSE_S)
+#define HIF_RDATA_CRC_ERR_INTR_DCH0_CAUSE_F    HIF_RDATA_CRC_ERR_INTR_DCH0_CAUSE_V(1U)
+
+#define HIF_RDATA_ADDR_ERR_INTR_DCH0_CAUSE_S    0
+#define HIF_RDATA_ADDR_ERR_INTR_DCH0_CAUSE_V(x) ((x) << HIF_RDATA_ADDR_ERR_INTR_DCH0_CAUSE_S)
+#define HIF_RDATA_ADDR_ERR_INTR_DCH0_CAUSE_F    HIF_RDATA_ADDR_ERR_INTR_DCH0_CAUSE_V(1U)
+
+#define T7_MC_P_PAR_ENABLE_A 0x49314
+#define T7_MC_P_PAR_CAUSE_A 0x49318
+
+#define HIF_WDATA_Q_PARERR_DCH1_CAUSE_S    13
+#define HIF_WDATA_Q_PARERR_DCH1_CAUSE_V(x) ((x) << HIF_WDATA_Q_PARERR_DCH1_CAUSE_S)
+#define HIF_WDATA_Q_PARERR_DCH1_CAUSE_F    HIF_WDATA_Q_PARERR_DCH1_CAUSE_V(1U)
+
+#define DDRCTL_ECC_CE_PAR_DCH1_CAUSE_S    12
+#define DDRCTL_ECC_CE_PAR_DCH1_CAUSE_V(x) ((x) << DDRCTL_ECC_CE_PAR_DCH1_CAUSE_S)
+#define DDRCTL_ECC_CE_PAR_DCH1_CAUSE_F    DDRCTL_ECC_CE_PAR_DCH1_CAUSE_V(1U)
+
+#define DDRCTL_ECC_CE_PAR_DCH0_CAUSE_S    11
+#define DDRCTL_ECC_CE_PAR_DCH0_CAUSE_V(x) ((x) << DDRCTL_ECC_CE_PAR_DCH0_CAUSE_S)
+#define DDRCTL_ECC_CE_PAR_DCH0_CAUSE_F    DDRCTL_ECC_CE_PAR_DCH0_CAUSE_V(1U)
+
+#define DDRCTL_ECC_UE_PAR_DCH1_CAUSE_S    10
+#define DDRCTL_ECC_UE_PAR_DCH1_CAUSE_V(x) ((x) << DDRCTL_ECC_UE_PAR_DCH1_CAUSE_S)
+#define DDRCTL_ECC_UE_PAR_DCH1_CAUSE_F    DDRCTL_ECC_UE_PAR_DCH1_CAUSE_V(1U)
+
+#define DDRCTL_ECC_UE_PAR_DCH0_CAUSE_S    9
+#define DDRCTL_ECC_UE_PAR_DCH0_CAUSE_V(x) ((x) << DDRCTL_ECC_UE_PAR_DCH0_CAUSE_S)
+#define DDRCTL_ECC_UE_PAR_DCH0_CAUSE_F    DDRCTL_ECC_UE_PAR_DCH0_CAUSE_V(1U)
+
+#define WDATARAM_PARERR_DCH1_CAUSE_S    8
+#define WDATARAM_PARERR_DCH1_CAUSE_V(x) ((x) << WDATARAM_PARERR_DCH1_CAUSE_S)
+#define WDATARAM_PARERR_DCH1_CAUSE_F    WDATARAM_PARERR_DCH1_CAUSE_V(1U)
+
+#define WDATARAM_PARERR_DCH0_CAUSE_S    7
+#define WDATARAM_PARERR_DCH0_CAUSE_V(x) ((x) << WDATARAM_PARERR_DCH0_CAUSE_S)
+#define WDATARAM_PARERR_DCH0_CAUSE_F    WDATARAM_PARERR_DCH0_CAUSE_V(1U)
+
+#define BIST_ADDR_FIFO_PARERR_CAUSE_S    6
+#define BIST_ADDR_FIFO_PARERR_CAUSE_V(x) ((x) << BIST_ADDR_FIFO_PARERR_CAUSE_S)
+#define BIST_ADDR_FIFO_PARERR_CAUSE_F    BIST_ADDR_FIFO_PARERR_CAUSE_V(1U)
+
+#define BIST_ERR_ADDR_FIFO_PARERR_CAUSE_S    5
+#define BIST_ERR_ADDR_FIFO_PARERR_CAUSE_V(x) ((x) << BIST_ERR_ADDR_FIFO_PARERR_CAUSE_S)
+#define BIST_ERR_ADDR_FIFO_PARERR_CAUSE_F    BIST_ERR_ADDR_FIFO_PARERR_CAUSE_V(1U)
+
+#define HIF_WDATA_Q_PARERR_DCH0_CAUSE_S    4
+#define HIF_WDATA_Q_PARERR_DCH0_CAUSE_V(x) ((x) << HIF_WDATA_Q_PARERR_DCH0_CAUSE_S)
+#define HIF_WDATA_Q_PARERR_DCH0_CAUSE_F    HIF_WDATA_Q_PARERR_DCH0_CAUSE_V(1U)
+
+#define HIF_RSPDATA_Q_PARERR_DCH1_CAUSE_S    3
+#define HIF_RSPDATA_Q_PARERR_DCH1_CAUSE_V(x) ((x) << HIF_RSPDATA_Q_PARERR_DCH1_CAUSE_S)
+#define HIF_RSPDATA_Q_PARERR_DCH1_CAUSE_F    HIF_RSPDATA_Q_PARERR_DCH1_CAUSE_V(1U)
+
+#define HIF_RSPDATA_Q_PARERR_DCH0_CAUSE_S    2
+#define HIF_RSPDATA_Q_PARERR_DCH0_CAUSE_V(x) ((x) << HIF_RSPDATA_Q_PARERR_DCH0_CAUSE_S)
+#define HIF_RSPDATA_Q_PARERR_DCH0_CAUSE_F    HIF_RSPDATA_Q_PARERR_DCH0_CAUSE_V(1U)
+
+#define HIF_WDATA_MASK_FIFO_PARERR_DCH1_CAUSE_S    1
+#define HIF_WDATA_MASK_FIFO_PARERR_DCH1_CAUSE_V(x) ((x) << HIF_WDATA_MASK_FIFO_PARERR_DCH1_CAUSE_S)
+#define HIF_WDATA_MASK_FIFO_PARERR_DCH1_CAUSE_F    HIF_WDATA_MASK_FIFO_PARERR_DCH1_CAUSE_V(1U)
+
+#define HIF_WDATA_MASK_FIFO_PARERR_DCH0_CAUSE_S    0
+#define HIF_WDATA_MASK_FIFO_PARERR_DCH0_CAUSE_V(x) ((x) << HIF_WDATA_MASK_FIFO_PARERR_DCH0_CAUSE_S)
+#define HIF_WDATA_MASK_FIFO_PARERR_DCH0_CAUSE_F    HIF_WDATA_MASK_FIFO_PARERR_DCH0_CAUSE_V(1U)
+
+#define MC_P_PAR_ENABLE_A 0x4130c
+#define MC_P_PAR_CAUSE_A 0x41310
+#define T7_MC_P_INT_ENABLE_A 0x4931c
+#define T7_MC_P_INT_CAUSE_A 0x49320
+#define MC_REGB_DDRC_CH0_ECCCTL_A 0x1060c
+#define MC_REGB_DDRC_CH1_ECCCTL_A 0x1160c
+
+#define ECC_UNCORRECTED_ERR_INTR_EN_S    9
+#define ECC_UNCORRECTED_ERR_INTR_EN_V(x) ((x) << ECC_UNCORRECTED_ERR_INTR_EN_S)
+#define ECC_UNCORRECTED_ERR_INTR_EN_F    ECC_UNCORRECTED_ERR_INTR_EN_V(1U)
+
+#define ECC_CORRECTED_ERR_INTR_EN_S    8
+#define ECC_CORRECTED_ERR_INTR_EN_V(x) ((x) << ECC_CORRECTED_ERR_INTR_EN_S)
+#define ECC_CORRECTED_ERR_INTR_EN_F    ECC_CORRECTED_ERR_INTR_EN_V(1U)
+
+#define ECC_UNCORRECTED_ERR_CLR_S    1
+#define ECC_UNCORRECTED_ERR_CLR_V(x) ((x) << ECC_UNCORRECTED_ERR_CLR_S)
+#define ECC_UNCORRECTED_ERR_CLR_F    ECC_UNCORRECTED_ERR_CLR_V(1U)
+
+#define ECC_CORRECTED_ERR_CLR_S    0
+#define ECC_CORRECTED_ERR_CLR_V(x) ((x) << ECC_CORRECTED_ERR_CLR_S)
+#define ECC_CORRECTED_ERR_CLR_F    ECC_CORRECTED_ERR_CLR_V(1U)
+
+#define DDRPHY_INT_CAUSE_S    4
+#define DDRPHY_INT_CAUSE_V(x) ((x) << DDRPHY_INT_CAUSE_S)
+#define DDRPHY_INT_CAUSE_F    DDRPHY_INT_CAUSE_V(1U)
+
+#define DDRCTL_INT_CAUSE_S    3
+#define DDRCTL_INT_CAUSE_V(x) ((x) << DDRCTL_INT_CAUSE_S)
+#define DDRCTL_INT_CAUSE_F    DDRCTL_INT_CAUSE_V(1U)
+
+#define T7_ECC_CE_INT_CAUSE_S    2
+#define T7_ECC_CE_INT_CAUSE_V(x) ((x) << T7_ECC_CE_INT_CAUSE_S)
+#define T7_ECC_CE_INT_CAUSE_F    T7_ECC_CE_INT_CAUSE_V(1U)
+
+#define T7_ECC_UE_INT_CAUSE_S    1
+#define T7_ECC_UE_INT_CAUSE_V(x) ((x) << T7_ECC_UE_INT_CAUSE_S)
+#define T7_ECC_UE_INT_CAUSE_F    T7_ECC_UE_INT_CAUSE_V(1U)
+
+#define MC_DWC_DDRPHYA_MASTER0_BASE0_PHYINTERRUPTENABLE_A 0x20100
+#define MC_DWC_DDRPHYA_MASTER0_BASE0_PHYINTERRUPTMASK_A 0x20102
+#define MC_DWC_DDRPHYA_MASTER0_BASE0_PHYINTERRUPTCLEAR_A 0x20103
+#define MC_DWC_DDRPHYA_MASTER0_BASE0_PHYINTERRUPTSTATUS_A 0x20104
+
+/* registers for module MC_T71 */
+#define MC_T71_BASE_ADDR 0x58000
+
+/* registers for module GCACHE */
+#define GCACHE_INT_ENABLE_A 0x51544
+#define GCACHE_INT_CAUSE_A 0x51548
+
+#define GC1_SRAM_RSP_DATAQ_PERR_INT_CAUSE_S    27
+#define GC1_SRAM_RSP_DATAQ_PERR_INT_CAUSE_V(x) ((x) << GC1_SRAM_RSP_DATAQ_PERR_INT_CAUSE_S)
+#define GC1_SRAM_RSP_DATAQ_PERR_INT_CAUSE_F    GC1_SRAM_RSP_DATAQ_PERR_INT_CAUSE_V(1U)
+
+#define GC0_SRAM_RSP_DATAQ_PERR_INT_CAUSE_S    26
+#define GC0_SRAM_RSP_DATAQ_PERR_INT_CAUSE_V(x) ((x) << GC0_SRAM_RSP_DATAQ_PERR_INT_CAUSE_S)
+#define GC0_SRAM_RSP_DATAQ_PERR_INT_CAUSE_F    GC0_SRAM_RSP_DATAQ_PERR_INT_CAUSE_V(1U)
+
+#define GC1_WQDATA_FIFO_PERR_INT_CAUSE_S    25
+#define GC1_WQDATA_FIFO_PERR_INT_CAUSE_V(x) ((x) << GC1_WQDATA_FIFO_PERR_INT_CAUSE_S)
+#define GC1_WQDATA_FIFO_PERR_INT_CAUSE_F    GC1_WQDATA_FIFO_PERR_INT_CAUSE_V(1U)
+
+#define GC0_WQDATA_FIFO_PERR_INT_CAUSE_S    24
+#define GC0_WQDATA_FIFO_PERR_INT_CAUSE_V(x) ((x) << GC0_WQDATA_FIFO_PERR_INT_CAUSE_S)
+#define GC0_WQDATA_FIFO_PERR_INT_CAUSE_F    GC0_WQDATA_FIFO_PERR_INT_CAUSE_V(1U)
+
+#define GC1_RDTAG_QUEUE_PERR_INT_CAUSE_S    23
+#define GC1_RDTAG_QUEUE_PERR_INT_CAUSE_V(x) ((x) << GC1_RDTAG_QUEUE_PERR_INT_CAUSE_S)
+#define GC1_RDTAG_QUEUE_PERR_INT_CAUSE_F    GC1_RDTAG_QUEUE_PERR_INT_CAUSE_V(1U)
+
+#define GC0_RDTAG_QUEUE_PERR_INT_CAUSE_S    22
+#define GC0_RDTAG_QUEUE_PERR_INT_CAUSE_V(x) ((x) << GC0_RDTAG_QUEUE_PERR_INT_CAUSE_S)
+#define GC0_RDTAG_QUEUE_PERR_INT_CAUSE_F    GC0_RDTAG_QUEUE_PERR_INT_CAUSE_V(1U)
+
+#define GC1_SRAM_RDTAG_QUEUE_PERR_INT_CAUSE_S    21
+#define GC1_SRAM_RDTAG_QUEUE_PERR_INT_CAUSE_V(x) ((x) << GC1_SRAM_RDTAG_QUEUE_PERR_INT_CAUSE_S)
+#define GC1_SRAM_RDTAG_QUEUE_PERR_INT_CAUSE_F    GC1_SRAM_RDTAG_QUEUE_PERR_INT_CAUSE_V(1U)
+
+#define GC0_SRAM_RDTAG_QUEUE_PERR_INT_CAUSE_S    20
+#define GC0_SRAM_RDTAG_QUEUE_PERR_INT_CAUSE_V(x) ((x) << GC0_SRAM_RDTAG_QUEUE_PERR_INT_CAUSE_S)
+#define GC0_SRAM_RDTAG_QUEUE_PERR_INT_CAUSE_F    GC0_SRAM_RDTAG_QUEUE_PERR_INT_CAUSE_V(1U)
+
+#define GC1_RSP_PERR_INT_CAUSE_S    19
+#define GC1_RSP_PERR_INT_CAUSE_V(x) ((x) << GC1_RSP_PERR_INT_CAUSE_S)
+#define GC1_RSP_PERR_INT_CAUSE_F    GC1_RSP_PERR_INT_CAUSE_V(1U)
+
+#define GC0_RSP_PERR_INT_CAUSE_S    18
+#define GC0_RSP_PERR_INT_CAUSE_V(x) ((x) << GC0_RSP_PERR_INT_CAUSE_S)
+#define GC0_RSP_PERR_INT_CAUSE_F    GC0_RSP_PERR_INT_CAUSE_V(1U)
+
+#define GC1_LRU_UERR_INT_CAUSE_S    17
+#define GC1_LRU_UERR_INT_CAUSE_V(x) ((x) << GC1_LRU_UERR_INT_CAUSE_S)
+#define GC1_LRU_UERR_INT_CAUSE_F    GC1_LRU_UERR_INT_CAUSE_V(1U)
+
+#define GC0_LRU_UERR_INT_CAUSE_S    16
+#define GC0_LRU_UERR_INT_CAUSE_V(x) ((x) << GC0_LRU_UERR_INT_CAUSE_S)
+#define GC0_LRU_UERR_INT_CAUSE_F    GC0_LRU_UERR_INT_CAUSE_V(1U)
+
+#define GC1_TAG_UERR_INT_CAUSE_S    15
+#define GC1_TAG_UERR_INT_CAUSE_V(x) ((x) << GC1_TAG_UERR_INT_CAUSE_S)
+#define GC1_TAG_UERR_INT_CAUSE_F    GC1_TAG_UERR_INT_CAUSE_V(1U)
+
+#define GC0_TAG_UERR_INT_CAUSE_S    14
+#define GC0_TAG_UERR_INT_CAUSE_V(x) ((x) << GC0_TAG_UERR_INT_CAUSE_S)
+#define GC0_TAG_UERR_INT_CAUSE_F    GC0_TAG_UERR_INT_CAUSE_V(1U)
+
+#define GC1_LRU_CERR_INT_CAUSE_S    13
+#define GC1_LRU_CERR_INT_CAUSE_V(x) ((x) << GC1_LRU_CERR_INT_CAUSE_S)
+#define GC1_LRU_CERR_INT_CAUSE_F    GC1_LRU_CERR_INT_CAUSE_V(1U)
+
+#define GC0_LRU_CERR_INT_CAUSE_S    12
+#define GC0_LRU_CERR_INT_CAUSE_V(x) ((x) << GC0_LRU_CERR_INT_CAUSE_S)
+#define GC0_LRU_CERR_INT_CAUSE_F    GC0_LRU_CERR_INT_CAUSE_V(1U)
+
+#define GC1_TAG_CERR_INT_CAUSE_S    11
+#define GC1_TAG_CERR_INT_CAUSE_V(x) ((x) << GC1_TAG_CERR_INT_CAUSE_S)
+#define GC1_TAG_CERR_INT_CAUSE_F    GC1_TAG_CERR_INT_CAUSE_V(1U)
+
+#define GC0_TAG_CERR_INT_CAUSE_S    10
+#define GC0_TAG_CERR_INT_CAUSE_V(x) ((x) << GC0_TAG_CERR_INT_CAUSE_S)
+#define GC0_TAG_CERR_INT_CAUSE_F    GC0_TAG_CERR_INT_CAUSE_V(1U)
+
+#define GC1_CE_INT_CAUSE_S    9
+#define GC1_CE_INT_CAUSE_V(x) ((x) << GC1_CE_INT_CAUSE_S)
+#define GC1_CE_INT_CAUSE_F    GC1_CE_INT_CAUSE_V(1U)
+
+#define GC0_CE_INT_CAUSE_S    8
+#define GC0_CE_INT_CAUSE_V(x) ((x) << GC0_CE_INT_CAUSE_S)
+#define GC0_CE_INT_CAUSE_F    GC0_CE_INT_CAUSE_V(1U)
+
+#define GC1_UE_INT_CAUSE_S    7
+#define GC1_UE_INT_CAUSE_V(x) ((x) << GC1_UE_INT_CAUSE_S)
+#define GC1_UE_INT_CAUSE_F    GC1_UE_INT_CAUSE_V(1U)
+
+#define GC0_UE_INT_CAUSE_S    6
+#define GC0_UE_INT_CAUSE_V(x) ((x) << GC0_UE_INT_CAUSE_S)
+#define GC0_UE_INT_CAUSE_F    GC0_UE_INT_CAUSE_V(1U)
+
+#define GC1_CMD_PAR_INT_CAUSE_S    5
+#define GC1_CMD_PAR_INT_CAUSE_V(x) ((x) << GC1_CMD_PAR_INT_CAUSE_S)
+#define GC1_CMD_PAR_INT_CAUSE_F    GC1_CMD_PAR_INT_CAUSE_V(1U)
+
+#define GC1_DATA_PAR_INT_CAUSE_S    4
+#define GC1_DATA_PAR_INT_CAUSE_V(x) ((x) << GC1_DATA_PAR_INT_CAUSE_S)
+#define GC1_DATA_PAR_INT_CAUSE_F    GC1_DATA_PAR_INT_CAUSE_V(1U)
+
+#define GC0_CMD_PAR_INT_CAUSE_S    3
+#define GC0_CMD_PAR_INT_CAUSE_V(x) ((x) << GC0_CMD_PAR_INT_CAUSE_S)
+#define GC0_CMD_PAR_INT_CAUSE_F    GC0_CMD_PAR_INT_CAUSE_V(1U)
+
+#define GC0_DATA_PAR_INT_CAUSE_S    2
+#define GC0_DATA_PAR_INT_CAUSE_V(x) ((x) << GC0_DATA_PAR_INT_CAUSE_S)
+#define GC0_DATA_PAR_INT_CAUSE_F    GC0_DATA_PAR_INT_CAUSE_V(1U)
+
+#define ILLADDRACCESS1_INT_CAUSE_S    1
+#define ILLADDRACCESS1_INT_CAUSE_V(x) ((x) << ILLADDRACCESS1_INT_CAUSE_S)
+#define ILLADDRACCESS1_INT_CAUSE_F    ILLADDRACCESS1_INT_CAUSE_V(1U)
+
+#define ILLADDRACCESS0_INT_CAUSE_S    0
+#define ILLADDRACCESS0_INT_CAUSE_V(x) ((x) << ILLADDRACCESS0_INT_CAUSE_S)
+#define ILLADDRACCESS0_INT_CAUSE_F    ILLADDRACCESS0_INT_CAUSE_V(1U)
+
 /* registers for module CIM */
 #define CIM_HOST_ACC_CTRL_A	0x7b50
 #define CIM_HOST_ACC_DATA_A	0x7b54
@@ -3248,13 +8204,33 @@
 #define HOSTWRITE_V(x)	((x) << HOSTWRITE_S)
 #define HOSTWRITE_F	HOSTWRITE_V(1U)
 
+#define T7_HOSTBUSY_S    31
+#define T7_HOSTBUSY_V(x) ((x) << T7_HOSTBUSY_S)
+#define T7_HOSTBUSY_F    T7_HOSTBUSY_V(1U)
+
+#define T7_HOSTWRITE_S    30
+#define T7_HOSTWRITE_V(x) ((x) << T7_HOSTWRITE_S)
+#define T7_HOSTWRITE_F    T7_HOSTWRITE_V(1U)
+
+#define HOSTGRPSEL_S    28
+#define HOSTGRPSEL_V(x) ((x) << HOSTGRPSEL_S)
+
+#define HOSTCORESEL_S    24
+#define HOSTCORESEL_V(x) ((x) << HOSTCORESEL_S)
+
 #define CIM_IBQ_DBG_CFG_A 0x7b60
 
+#define IBQDBGCORE_S    28
+#define IBQDBGCORE_V(x) ((x) << IBQDBGCORE_S)
+
 #define IBQDBGADDR_S    16
 #define IBQDBGADDR_M    0xfffU
 #define IBQDBGADDR_V(x) ((x) << IBQDBGADDR_S)
 #define IBQDBGADDR_G(x) (((x) >> IBQDBGADDR_S) & IBQDBGADDR_M)
 
+#define T7_IBQDBGADDR_S    12
+#define T7_IBQDBGADDR_V(x) ((x) << T7_IBQDBGADDR_S)
+
 #define IBQDBGBUSY_S    1
 #define IBQDBGBUSY_V(x) ((x) << IBQDBGBUSY_S)
 #define IBQDBGBUSY_F    IBQDBGBUSY_V(1U)
@@ -3265,6 +8241,12 @@
 
 #define CIM_OBQ_DBG_CFG_A 0x7b64
 
+#define OBQDBGCORE_S    28
+#define OBQDBGCORE_V(x) ((x) << OBQDBGCORE_S)
+
+#define T7_OBQDBGADDR_S    12
+#define T7_OBQDBGADDR_V(x) ((x) << T7_OBQDBGADDR_S)
+
 #define OBQDBGADDR_S    16
 #define OBQDBGADDR_M    0xfffU
 #define OBQDBGADDR_V(x) ((x) << OBQDBGADDR_S)
@@ -3329,6 +8311,21 @@
 #define UPDBGLACAPTPCONLY_F	UPDBGLACAPTPCONLY_V(1U)
 
 #define CIM_QUEUE_CONFIG_REF_A 0x7b48
+
+#define CORESELECT_S    6
+#define CORESELECT_V(x) ((x) << CORESELECT_S)
+
+#define T7_OBQSELECT_S    5
+#define T7_OBQSELECT_V(x) ((x) << T7_OBQSELECT_S)
+#define T7_OBQSELECT_F    T7_OBQSELECT_V(1U)
+
+#define T7_IBQSELECT_S    4
+#define T7_IBQSELECT_V(x) ((x) << T7_IBQSELECT_S)
+#define T7_IBQSELECT_F    T7_IBQSELECT_V(1U)
+
+#define T7_QUENUMSELECT_S    0
+#define T7_QUENUMSELECT_V(x) ((x) << T7_QUENUMSELECT_S)
+
 #define CIM_QUEUE_CONFIG_CTRL_A 0x7b4c
 
 #define CIMQSIZE_S    24
@@ -3383,4 +8380,43 @@
 #define QUENUMSELECT_S    0
 #define QUENUMSELECT_V(x) ((x) << QUENUMSELECT_S)
 
+/* registers for module HMA */
+#define HMA_LOCAL_DEBUG_CFG_A 0x51320
+
+#define HMA_INT_ENABLE_A 0x51304
+#define HMA_INT_CAUSE_A 0x51308
+
+#define GK_UF_INT_CAUSE_S    6
+#define GK_UF_INT_CAUSE_V(x) ((x) << GK_UF_INT_CAUSE_S)
+#define GK_UF_INT_CAUSE_F    GK_UF_INT_CAUSE_V(1U)
+
+#define IDTF_INT_CAUSE_S    5
+#define IDTF_INT_CAUSE_V(x) ((x) << IDTF_INT_CAUSE_S)
+#define IDTF_INT_CAUSE_F    IDTF_INT_CAUSE_V(1U)
+
+#define OTF_INT_CAUSE_S    4
+#define OTF_INT_CAUSE_V(x) ((x) << OTF_INT_CAUSE_S)
+#define OTF_INT_CAUSE_F    OTF_INT_CAUSE_V(1U)
+
+#define RTF_INT_CAUSE_S    3
+#define RTF_INT_CAUSE_V(x) ((x) << RTF_INT_CAUSE_S)
+#define RTF_INT_CAUSE_F    RTF_INT_CAUSE_V(1U)
+
+#define PCIEMST_INT_CAUSE_S    2
+#define PCIEMST_INT_CAUSE_V(x) ((x) << PCIEMST_INT_CAUSE_S)
+#define PCIEMST_INT_CAUSE_F    PCIEMST_INT_CAUSE_V(1U)
+
+#define MAMST_INT_CAUSE_S    1
+#define MAMST_INT_CAUSE_V(x) ((x) << MAMST_INT_CAUSE_S)
+#define MAMST_INT_CAUSE_F    MAMST_INT_CAUSE_V(1U)
+
+/* registers for module UP */
+#define T7_UP_IBQ_0_SHADOW_RDADDR_A 0x400
+#define T7_UP_OBQ_0_SHADOW_RDADDR_A 0x600
+#define T7_UP_OBQ_0_SHADOW_REALADDR_A 0x704
+
+#define T7_QUEREMFLITS_S    0
+#define T7_QUEREMFLITS_M    0xfffU
+#define T7_QUEREMFLITS_G(x) (((x) >> T7_QUEREMFLITS_S) & T7_QUEREMFLITS_M)
+
 #endif /* __T4_REGS_H */
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_tcb.h b/drivers/net/ethernet/chelsio/cxgb4/t4_tcb.h
index 22a0220123ad..1b7fc71dd835 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_tcb.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_tcb.h
@@ -141,4 +141,20 @@
 #define TF_NON_OFFLOAD_V(x)	((x) << TF_NON_OFFLOAD_S)
 #define TF_NON_OFFLOAD_F	TF_NON_OFFLOAD_V(1)
 
+#define TCB_T_RTT_TS_RECENT_AGE_W    6
+#define TCB_T_RTT_TS_RECENT_AGE_S    0
+#define TCB_T_RTT_TS_RECENT_AGE_M    0xffffffffULL
+#define TCB_T_RTT_TS_RECENT_AGE_V(x) ((x) << TCB_T_RTT_TS_RECENT_AGE_S)
+
+#define TF_MIGRATING_S    0
+#define TF_MIGRATING_V(x) ((x) << TF_MIGRATING_S)
+
+#define TF_RECV_TSTMP_S    53
+#define TF_RECV_TSTMP_V(x) ((__u64)(x) << TF_RECV_TSTMP_S)
+
+#define TF_PEND_CTL1_S    56
+#define TF_PEND_CTL1_V(x) ((__u64)(x) << TF_PEND_CTL1_S)
+
+#define TF_PEND_CTL2_S    57
+#define TF_PEND_CTL2_V(x) ((__u64)(x) << TF_PEND_CTL2_S)
 #endif /* __T4_TCB_H */
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_values.h b/drivers/net/ethernet/chelsio/cxgb4/t4_values.h
index eb1aa82149db..1598d8cdd696 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_values.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_values.h
@@ -125,12 +125,20 @@
 /* PCI-E definitions */
 #define WINDOW_SHIFT_X		10
 #define PCIEOFST_SHIFT_X	10
+#define T7_MEMOFST_SHIFT_X	4
 
 /* TP_VLAN_PRI_MAP controls which subset of fields will be present in the
  * Compressed Filter Tuple for LE filters.  Each bit set in TP_VLAN_PRI_MAP
  * selects for a particular field being present.  These fields, when present
  * in the Compressed Filter Tuple, have the following widths in bits.
  */
+#define FT_FIRST_S                      FCOE_S
+#define FT_LAST_S                       FRAGMENTATION_S
+
+#define T7_FT_FIRST_S                   IPSECIDX_S
+#define T7_FT_LAST_S                    TCPFLAGS_S
+
+#define FT_IPSECIDX_W                   12
 #define FT_FCOE_W                       1
 #define FT_PORT_W                       3
 #define FT_VNIC_ID_W                    17
@@ -141,6 +149,9 @@
 #define FT_MACMATCH_W                   9
 #define FT_MPSHITTYPE_W                 3
 #define FT_FRAGMENTATION_W              1
+#define FT_ROCE_W			1
+#define FT_SYNONLY_W			1
+#define FT_TCPFLAGS_W			12
 
 /* Some of the Compressed Filter Tuple fields have internal structure.  These
  * bit shifts/masks describe those structures.  All shifts are relative to the
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4fw_api.h b/drivers/net/ethernet/chelsio/cxgb4/t4fw_api.h
index 2419459a0b85..7bd0c0d8a73c 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4fw_api.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4fw_api.h
@@ -434,6 +434,13 @@ struct fw_filter2_wr {
 #define FW_FILTER_WR_RX_RPL_IQ_G(x)     \
 	(((x) >> FW_FILTER_WR_RX_RPL_IQ_S) & FW_FILTER_WR_RX_RPL_IQ_M)
 
+#define FW_FILTER2_WR_SWAPMAC_S	 0
+#define FW_FILTER2_WR_SWAPMAC_M	 0x1
+#define FW_FILTER2_WR_SWAPMAC_V(x)      ((x) << FW_FILTER2_WR_SWAPMAC_S)
+#define FW_FILTER2_WR_SWAPMAC_G(x) \
+	(((x) >> FW_FILTER2_WR_SWAPMAC_S) & FW_FILTER2_WR_SWAPMAC_M)
+#define FW_FILTER2_WR_SWAPMAC_F	 FW_FILTER2_WR_SWAPMAC_V(1U)
+
 #define FW_FILTER2_WR_FILTER_TYPE_S	1
 #define FW_FILTER2_WR_FILTER_TYPE_M	0x1
 #define FW_FILTER2_WR_FILTER_TYPE_V(x)	((x) << FW_FILTER2_WR_FILTER_TYPE_S)
@@ -460,6 +467,13 @@ struct fw_filter2_wr {
 #define FW_FILTER2_WR_ULP_TYPE_G(x)     \
 	(((x) >> FW_FILTER2_WR_ULP_TYPE_S) & FW_FILTER2_WR_ULP_TYPE_M)
 
+#define FW_FILTER2_WR_TX_LOOP_S	 29
+#define FW_FILTER2_WR_TX_LOOP_M	 0x1
+#define FW_FILTER2_WR_TX_LOOP_V(x)      ((x) << FW_FILTER2_WR_TX_LOOP_S)
+#define FW_FILTER2_WR_TX_LOOP_G(x)      \
+	    (((x) >> FW_FILTER2_WR_TX_LOOP_S) & FW_FILTER2_WR_TX_LOOP_M)
+#define FW_FILTER2_WR_TX_LOOP_F	 FW_FILTER2_WR_TX_LOOP_V(1U)
+
 #define FW_FILTER_WR_MACI_S     23
 #define FW_FILTER_WR_MACI_M     0x1ff
 #define FW_FILTER_WR_MACI_V(x)  ((x) << FW_FILTER_WR_MACI_S)
@@ -1414,6 +1428,9 @@ enum fw_params_param_dmaq {
 	FW_PARAMS_PARAM_DMAQ_CONM_CTXT = 0x20,
 };
 
+#define T7_DMAQ_CONM_CTXT_CH_VEC_S 2
+#define T7_DMAQ_CONM_CTXT_CH_VEC_V(x)  ((x) << T7_DMAQ_CONM_CTXT_CH_VEC_S)
+
 enum fw_params_param_dev_ktls_hw {
 	FW_PARAMS_PARAM_DEV_KTLS_HW_DISABLE      = 0x00,
 	FW_PARAMS_PARAM_DEV_KTLS_HW_ENABLE       = 0x01,
@@ -1882,6 +1899,12 @@ struct fw_eq_eth_cmd {
 #define FW_EQ_ETH_CMD_EQSTOP_V(x)	((x) << FW_EQ_ETH_CMD_EQSTOP_S)
 #define FW_EQ_ETH_CMD_EQSTOP_F	FW_EQ_ETH_CMD_EQSTOP_V(1U)
 
+#define FW_EQ_ETH_CMD_COREGROUP_S      16
+#define FW_EQ_ETH_CMD_COREGROUP_M      0x3f
+#define FW_EQ_ETH_CMD_COREGROUP_V(x)   ((x) << FW_EQ_ETH_CMD_COREGROUP_S)
+#define FW_EQ_ETH_CMD_COREGROUP_G(x) \
+	(((x) >> FW_EQ_ETH_CMD_COREGROUP_S) & FW_EQ_ETH_CMD_COREGROUP_M)
+
 #define FW_EQ_ETH_CMD_EQID_S	0
 #define FW_EQ_ETH_CMD_EQID_M	0xfffff
 #define FW_EQ_ETH_CMD_EQID_V(x)	((x) << FW_EQ_ETH_CMD_EQID_S)
@@ -2010,6 +2033,12 @@ struct fw_eq_ctrl_cmd {
 #define FW_EQ_CTRL_CMD_CMPLIQID_S	20
 #define FW_EQ_CTRL_CMD_CMPLIQID_V(x)	((x) << FW_EQ_CTRL_CMD_CMPLIQID_S)
 
+#define FW_EQ_CTRL_CMD_COREGROUP_S     16
+#define FW_EQ_CTRL_CMD_COREGROUP_M     0x3f
+#define FW_EQ_CTRL_CMD_COREGROUP_V(x)  ((x) << FW_EQ_CTRL_CMD_COREGROUP_S)
+#define FW_EQ_CTRL_CMD_COREGROUP_G(x) \
+	(((x) >> FW_EQ_CTRL_CMD_COREGROUP_S) & FW_EQ_CTRL_CMD_COREGROUP_M)
+
 #define FW_EQ_CTRL_CMD_EQID_S		0
 #define FW_EQ_CTRL_CMD_EQID_M		0xfffff
 #define FW_EQ_CTRL_CMD_EQID_V(x)	((x) << FW_EQ_CTRL_CMD_EQID_S)
@@ -2597,7 +2626,7 @@ struct fw_acl_vlan_cmd {
 #define FW_ACL_VLAN_CMD_EN_M		0x1
 #define FW_ACL_VLAN_CMD_EN_V(x)		((x) << FW_ACL_VLAN_CMD_EN_S)
 #define FW_ACL_VLAN_CMD_EN_G(x)         \
-	(((x) >> S_FW_ACL_VLAN_CMD_EN_S) & FW_ACL_VLAN_CMD_EN_M)
+	(((x) >> FW_ACL_VLAN_CMD_EN_S_S) & FW_ACL_VLAN_CMD_EN_M)
 #define FW_ACL_VLAN_CMD_EN_F            FW_ACL_VLAN_CMD_EN_V(1U)
 
 #define FW_ACL_VLAN_CMD_DROPNOVLAN_S	7
@@ -3107,8 +3136,26 @@ enum fw_port_type {
 	FW_PORT_TYPE_SFP28,
 	FW_PORT_TYPE_KR_SFP28,
 	FW_PORT_TYPE_KR_XLAUI,
-
-	FW_PORT_TYPE_NONE = FW_PORT_CMD_PTYPE_M
+	/* Applicable on T7 */
+	FW_PORT_TYPE_BARE_LINK_50G    = 23,   /* No, 1, 50G */
+	FW_PORT_TYPE_BARE_LINK_100G   = 24,   /* No, 2, 100G/50G */
+	FW_PORT_TYPE_BARE_LINK_200G   = 25,   /* No, 4, 200G/100G/50G */
+	FW_PORT_TYPE_SFP56	      = 26,   /* No, 1, 50G/25G */
+	FW_PORT_TYPE_QSFP56	      = 27,   /* No, 4, 200G/100G/50G/25G */
+	FW_PORT_TYPE_QSFP56_4_50G     = 28,   /* No, 1, 50G */
+	FW_PORT_TYPE_KR_50G	      = 29,   /* No, 1, 50G */
+	FW_PORT_TYPE_KR2_100G	      = 30,   /* No, 2, 100G/50G */
+	FW_PORT_TYPE_KR4_200G	      = 31,   /* No, 4, 200G/100G/50G */
+	FW_PORT_TYPE_QSFP56_2_50G     = 32,   /* No, 1, 50G */
+	FW_PORT_TYPE_OSFP	      = 33,   /* No, 8, 400G/200G/100G/50G */
+	FW_PORT_TYPE_QSFPDD	      = 34,   /* No, 8, 400G/200G/100G/50G  */
+	FW_PORT_TYPE_OSFP_2_200G      = 35,   /* No, 4, 200G/100G/50G */
+	FW_PORT_TYPE_QSFP_4_100G      = 36,   /* No, 2, 100G/50G */
+	FW_PORT_TYPE_QSFPDD_2_200G    = 37,   /* No, 4, 200G/100G/50G */
+	FW_PORT_TYPE_KR8_400G	      = 38,   /* No, 8, 400G/200G/100G/50G? */
+	FW_PORT_TYPE_MAX,
+
+	FW_PORT_TYPE_NONE = FW_PORT_CMD_PORTTYPE32_M
 };
 
 enum fw_port_module_type {
@@ -3119,6 +3166,7 @@ enum fw_port_module_type {
 	FW_PORT_MOD_TYPE_TWINAX_PASSIVE,
 	FW_PORT_MOD_TYPE_TWINAX_ACTIVE,
 	FW_PORT_MOD_TYPE_LRM,
+	FW_PORT_MOD_TYPE_DR,
 	FW_PORT_MOD_TYPE_ERROR		= FW_PORT_CMD_MODTYPE_M - 3,
 	FW_PORT_MOD_TYPE_UNKNOWN	= FW_PORT_CMD_MODTYPE_M - 2,
 	FW_PORT_MOD_TYPE_NOTSUPPORTED	= FW_PORT_CMD_MODTYPE_M - 1,
@@ -3770,13 +3818,17 @@ struct fw_hdr {
 	__u32   reserved3;
 	__u32   reserved4;
 	__be32  flags;
-	__be32  reserved6[23];
+	__be32  reserved6[4];
+	__u8    reserved7[3];
+	__u8    dsign_len;
+	__u8    dsign[72];	      /* fw binary digital signature */
 };
 
 enum fw_hdr_chip {
 	FW_HDR_CHIP_T4,
 	FW_HDR_CHIP_T5,
-	FW_HDR_CHIP_T6
+	FW_HDR_CHIP_T6,
+	FW_HDR_CHIP_T7
 };
 
 #define FW_HDR_FW_VER_MAJOR_S	24
@@ -3888,7 +3940,9 @@ struct fw_devlog_cmd {
 	__u8   r2[7];
 	__be32 memtype_devlog_memaddr16_devlog;
 	__be32 memsize_devlog;
-	__be32 r3[2];
+	__u8   num_devlog;
+	__u8   r3[3];
+	__be32 r4;
 };
 
 #define FW_DEVLOG_CMD_MEMTYPE_DEVLOG_S		28
@@ -3915,8 +3969,14 @@ struct fw_devlog_cmd {
  */
 #define PCIE_FW_PF_DEVLOG		7
 
+#define PCIE_FW_PF_DEVLOG_COUNT_MSB_S  31
+#define PCIE_FW_PF_DEVLOG_COUNT_MSB_M  0x1
+#define PCIE_FW_PF_DEVLOG_COUNT_MSB_V(x) ((x) << PCIE_FW_PF_DEVLOG_COUNT_MSB_S)
+#define PCIE_FW_PF_DEVLOG_COUNT_MSB_G(x) \
+	(((x) >> PCIE_FW_PF_DEVLOG_COUNT_MSB_S) & PCIE_FW_PF_DEVLOG_COUNT_MSB_M)
+
 #define PCIE_FW_PF_DEVLOG_NENTRIES128_S	28
-#define PCIE_FW_PF_DEVLOG_NENTRIES128_M	0xf
+#define PCIE_FW_PF_DEVLOG_NENTRIES128_M	0x7
 #define PCIE_FW_PF_DEVLOG_NENTRIES128_V(x) \
 	((x) << PCIE_FW_PF_DEVLOG_NENTRIES128_S)
 #define PCIE_FW_PF_DEVLOG_NENTRIES128_G(x) \
@@ -3929,8 +3989,15 @@ struct fw_devlog_cmd {
 #define PCIE_FW_PF_DEVLOG_ADDR16_G(x) \
 	(((x) >> PCIE_FW_PF_DEVLOG_ADDR16_S) & PCIE_FW_PF_DEVLOG_ADDR16_M)
 
+#define PCIE_FW_PF_DEVLOG_COUNT_LSB_S  3
+#define PCIE_FW_PF_DEVLOG_COUNT_LSB_M  0x1
+#define PCIE_FW_PF_DEVLOG_COUNT_LSB_V(x) \
+	((x) << PCIE_FW_PF_DEVLOG_COUNT_LSB_S)
+#define PCIE_FW_PF_DEVLOG_COUNT_LSB_G(x) \
+	(((x) >> PCIE_FW_PF_DEVLOG_COUNT_LSB_S) & PCIE_FW_PF_DEVLOG_COUNT_LSB_M)
+
 #define PCIE_FW_PF_DEVLOG_MEMTYPE_S	0
-#define PCIE_FW_PF_DEVLOG_MEMTYPE_M	0xf
+#define PCIE_FW_PF_DEVLOG_MEMTYPE_M	0x7
 #define PCIE_FW_PF_DEVLOG_MEMTYPE_V(x)	((x) << PCIE_FW_PF_DEVLOG_MEMTYPE_S)
 #define PCIE_FW_PF_DEVLOG_MEMTYPE_G(x) \
 	(((x) >> PCIE_FW_PF_DEVLOG_MEMTYPE_S) & PCIE_FW_PF_DEVLOG_MEMTYPE_M)
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4fw_version.h b/drivers/net/ethernet/chelsio/cxgb4/t4fw_version.h
index a02b1dff403e..d19979c8bfc0 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4fw_version.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4fw_version.h
@@ -61,4 +61,13 @@
 #define T6FW_MIN_VERSION_MAJOR 0x00
 #define T6FW_MIN_VERSION_MINOR 0x00
 #define T6FW_MIN_VERSION_MICRO 0x00
+
+#define T7FW_VERSION_MAJOR 0x01
+#define T7FW_VERSION_MINOR 0x19
+#define T7FW_VERSION_MICRO 0x01
+#define T7FW_VERSION_BUILD 0x1B
+
+#define T7FW_MIN_VERSION_MAJOR 0x00
+#define T7FW_MIN_VERSION_MINOR 0x00
+#define T7FW_MIN_VERSION_MICRO 0x00
 #endif
-- 
2.39.1

