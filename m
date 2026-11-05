Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=12.32.117.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793850342;
	b=4lwbu5urjL+4GS20kqSLuoQrrXMLXsslLDU0Ly4vpIkqgOSLo8gdLg2BKv9vJcmS68sf
	 /SyXi9jRrB8BHqIbm2KStIqOd9bpJi1/TY2YoLFxpJu1kEjjkDVZOzQI9z7eAtZ+U75OM
	 m7kugyo+F4hxX/7qC1YfJVdG08tk7bvYyreJDc8JEtXPxq9KN6EZP88w5mdee1mBVjwpW
	 Rw6RPhFFf+2oAWQ5/zfSC25OxQRrYUlJY/W7PEBxg3+YgU8Ww9tOm0Rc08ddXpum1NBet
	 nJHJbO57RuNOMRceTP4ESjNMAAP4ax+2MttA3v+AqsAtGCmGYsfYivNLVARl6FH78kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793850342;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xUycs49iyBFMeXbpWXGjy0EJt9nA4UxzOEjGUuZDFYQ=;
	b=uZanvj47VloL4b0ht7UrHqM+wavpq+ASFjijTAzBAgfryDDKeRccy/bdmvwCxVIsQjf+
	 KAbEW6FqCMAg7VN25pVaVHT9U1P8Hz1KHIUZ1IeFuY2d6Jw9efa0gIC/8JdS2vO4gh+8x
	 ylJFV7dQtFljXc1/M00tyjPeIigxJPU+9FsDCX/1NwLVXw9U8ObryEKjPJvpLZl6Hh/Rn
	 228ltJ9LEtSNy2dPTT6aSb2m8FBJQeENOmOuT/8uMYk2GG3uZnc161rH4GpY+fasrvJbX
	 OVdMpXaBU+3JC6JjgLagiGL/vGJtJpURj5z5FCdWnGlOmv269Pdnc8GUW8NcMR/vORw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chelsio.com;
	spf=pass smtp.mailfrom=chelsio.com;
	arc=none smtp.remote-ip=12.32.117.8
Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA47606A339
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 03:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DA47606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from mehrangarh-blr-asicdesigners-com.asicdesigners.com (mehrangarh.blr.asicdesigners.com [10.193.185.169])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 6A53hj3w002480;
	Wed, 4 Nov 2026 19:45:26 -0800
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, bharat@chelsio.com,
        harshitha.vr@chelsio.com
Subject: [PATCH net-next v5 REPOST 10/12] cxgb4: extend CUDBG support for T7 adapters
Date: Thu,  5 Nov 2026 08:15:47 -0500
Message-Id: <20261105131549.547554-11-bharat@chelsio.com>
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

Update the CUDBG infrastructure to support T7-specific debug data
collection.

Add support for collecting CIM IBQ and OBQ debug entities from T7
adapters, including the additional queues introduced by T7 and support
for multicore.

Also add T7 indirect register collection support using the new indirect
register definitions, while preserving the existing register access
mechanism for T5/T6.

Debug tooling needs to read and write individual adapter registers and
to read SGE contexts and queue descriptors without collecting a full
cudbg dump. Add a private ioctl providing four commands

Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 .../net/ethernet/chelsio/cxgb4/cudbg_entity.h |  114 +-
 drivers/net/ethernet/chelsio/cxgb4/cudbg_if.h |   56 +-
 .../net/ethernet/chelsio/cxgb4/cudbg_lib.c    | 1088 ++++++++++++++---
 .../net/ethernet/chelsio/cxgb4/cudbg_lib.h    |   60 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    |    1 -
 .../net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c  |   20 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |  242 ++++
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c    |   20 -
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.h    |    1 +
 9 files changed, 1400 insertions(+), 202 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cudbg_entity.h b/drivers/net/ethernet/chelsio/cxgb4/cudbg_entity.h
index d5218e74284c..8295b330a7b9 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cudbg_entity.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cudbg_entity.h
@@ -21,13 +21,58 @@ struct cudbg_mbox_log {
 	u32 lo[MBOX_LEN / 8];
 };
 
-struct cudbg_cim_qcfg {
-	u8 chip;
-	u16 base[CIM_NUM_IBQ + CIM_NUM_OBQ_T5];
-	u16 size[CIM_NUM_IBQ + CIM_NUM_OBQ_T5];
-	u16 thres[CIM_NUM_IBQ];
-	u32 obq_wr[2 * CIM_NUM_OBQ_T5];
-	u32 stat[4 * (CIM_NUM_IBQ + CIM_NUM_OBQ_T5)];
+#define CUDBG_CIM_IBQ_REV 1
+
+struct cim_ibq_rev1 {
+	struct cudbg_ver_hdr ver_hdr;
+	u8 qid;
+	u8 coreid;
+	u32 data[]; /* Must be last */
+};
+
+#define CUDBG_CIM_OBQ_REV 1
+
+struct cim_obq_rev1 {
+	struct cudbg_ver_hdr ver_hdr;
+	u8 qid;
+	u8 coreid;
+	u32 data[]; /* Must be last */
+};
+
+#define CUDBG_CIM_QCFG_REV 1
+
+enum cudbg_entity_cim_qcfg_qtype {
+	CUDBG_ENTITY_CIM_QCFG_QTYPE_IBQ = 0,
+	CUDBG_ENTITY_CIM_QCFG_QTYPE_OBQ,
+};
+
+struct cim_qcfg_rev1_data {
+	u8 qtype;
+	u8 qid;
+	u16 base;
+	u16 size;
+	u16 thres;
+	u32 obq_wr[2];
+	u32 stat[4];
+};
+
+struct cim_qcfg_rev1 {
+	struct cudbg_ver_hdr ver_hdr;
+	u8 num_cim_ibq;
+	u8 num_cim_obq;
+	u8 coreid;
+	struct cim_qcfg_rev1_data data[]; /* Must be last */
+};
+
+#define CUDBG_CIM_LA_REV 1
+
+struct cim_la_rev1 {
+	struct cudbg_ver_hdr ver_hdr;
+	u8 coreid;
+	u8 ncol;
+	u16 nrow;
+	u32 config;
+	u32 data[]; /* Must be last */
 };
 
 struct cudbg_rss_vf_conf {
@@ -50,6 +95,25 @@ struct cudbg_hw_sched {
 	u32 map;
 };
 
+#define CUDBG_TP_INDIR_REG_REV 1
+#define CUDBG_PM_INDIR_REG_REV 1
+#define CUDBG_MA_INDIR_REG_REV 1
+#define CUDBG_UP_CIM_INDIR_REG_REV 1
+#define CUDBG_HMA_INDIR_REG_REV 1
+
+struct cudbg_indir_reg_data {
+	u32 offset;
+	u32 data;
+};
+
+struct cudbg_indir_reg_entity {
+	struct cudbg_ver_hdr ver_hdr;
+	u32 indir_reg;
+	u32 indir_data;
+	u32 nentries;
+	struct cudbg_indir_reg_data data[];
+};
+
 #define SGE_QBASE_DATA_REG_NUM 4
 
 struct sge_qbase_reg_field {
@@ -91,8 +155,8 @@ static const char * const cudbg_region[] = {
 	"Tx payload:", "Rx payload:", "LE hash:", "iSCSI region:",
 	"TDDP region:", "TPT region:", "STAG region:", "RQ region:",
 	"RQUDP region:", "PBL region:", "TXPBL region:",
-	"DBVFIFO region:", "ULPRX state:", "ULPTX state:",
-	"On-chip queues:"
+	"RRQ region:", "DBVFIFO region:", "ULPRX state:",
+	"ULPTX state:", "On-chip queues:"
 };
 
 /* Memory region info relative to current memory (i.e. wrt 0). */
@@ -187,20 +251,42 @@ struct cudbg_tid_info_region_rev1 {
 	struct cudbg_ver_hdr ver_hdr;
 	struct cudbg_tid_info_region tid;
 	u32 tid_start;
-	u32 reserved[16];
+	u32 nhash;
+	u32 clip_base;
+	u32 nclip;
+	u32 route_base;
+	u32 nroute;
+	u32 reserved[11];
 };
 
 #define CUDBG_LOWMEM_MAX_CTXT_QIDS 256
 #define CUDBG_MAX_FL_QIDS 1024
 
-struct cudbg_ch_cntxt {
-	u32 cntxt_type;
-	u32 cntxt_id;
-	u32 data[SGE_CTXT_SIZE / 4];
+#define CUDBG_SGE_CTXT_REV 1
+
+struct sge_ctxt_rev1_data {
+	u8 ctxt_type;
+	u8 size;
+	u32 ctxt_id;
+	u32 data[];
+};
+
+struct sge_ctxt_rev1 {
+	struct cudbg_ver_hdr ver_hdr;
+	u32 nentries;
+	u8 data[]; /* Must be last */
 };
 
 #define CUDBG_MAX_RPLC_SIZE 128
 
+struct cudbg_cntxt_field {
+	char *name;
+	u32 start_bit;
+	u32 end_bit;
+	u32 shift;
+	u32 islog2;
+};
+
 struct cudbg_mps_tcam {
 	u64 mask;
 	u32 rplc[8];
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cudbg_if.h b/drivers/net/ethernet/chelsio/cxgb4/cudbg_if.h
index c84719e3ca08..85c4400bf419 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cudbg_if.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cudbg_if.h
@@ -17,6 +17,12 @@
 #define CUDBG_MAJOR_VERSION 1
 #define CUDBG_MINOR_VERSION 14
 
+#define CUDBG_MAX_PARAMS 16
+
+enum {
+	CUDBG_UP_COREID_PARAM = 13,
+};
+
 enum cudbg_dbg_entity_type {
 	CUDBG_REG_DUMP = 1,
 	CUDBG_DEV_LOG = 2,
@@ -26,8 +32,8 @@ enum cudbg_dbg_entity_type {
 	CUDBG_CIM_IBQ_TP0 = 6,
 	CUDBG_CIM_IBQ_TP1 = 7,
 	CUDBG_CIM_IBQ_ULP = 8,
-	CUDBG_CIM_IBQ_SGE0 = 9,
-	CUDBG_CIM_IBQ_SGE1 = 10,
+	CUDBG_CIM_IBQ_SGE = 9,
+	CUDBG_CIM_IBQ_PCIE = 10,
 	CUDBG_CIM_IBQ_NCSI = 11,
 	CUDBG_CIM_OBQ_ULP0 = 12,
 	CUDBG_CIM_OBQ_ULP1 = 13,
@@ -71,11 +77,55 @@ enum cudbg_dbg_entity_type {
 	CUDBG_HMA = 68,
 	CUDBG_QDESC = 70,
 	CUDBG_FLASH = 71,
-	CUDBG_MAX_ENTITY = 72,
+	CUDBG_CIM_IBQ_TP2  = 73,
+	CUDBG_CIM_IBQ_TP3  = 74,
+	CUDBG_CIM_IBQ_IPC1 = 75,
+	CUDBG_CIM_IBQ_IPC2 = 76,
+	CUDBG_CIM_IBQ_IPC3 = 77,
+	CUDBG_CIM_IBQ_IPC4 = 78,
+	CUDBG_CIM_IBQ_IPC5 = 79,
+	CUDBG_CIM_IBQ_IPC6 = 80,
+	CUDBG_CIM_IBQ_IPC7 = 81,
+	CUDBG_CIM_OBQ_IPC1 = 82,
+	CUDBG_CIM_OBQ_IPC2 = 83,
+	CUDBG_CIM_OBQ_IPC3 = 84,
+	CUDBG_CIM_OBQ_IPC4 = 85,
+	CUDBG_CIM_OBQ_IPC5 = 86,
+	CUDBG_CIM_OBQ_IPC6 = 87,
+	CUDBG_CIM_OBQ_IPC7 = 88,
+	CUDBG_MAX_ENTITY,
+};
+
+struct cudbg_param {
+	u16 param_type;
+	u16 reserved;
+	union {
+		struct {
+			u32 memtype; /* which memory (EDC0, EDC1, MC) */
+			u32 start; /* start of log in firmware memory */
+			u32 size; /* size of log */
+		} devlog_param;
+		struct {
+			struct mbox_cmd_log *log;
+			u16 mbox_cmds;
+		} mboxlog_param;
+		struct {
+			const char *caller_string;
+			u8 os_type;
+		} sw_state_param;
+		struct {
+			u32 itr;
+		} yield_param;
+		u64 time;
+		u8 tcb_bit_param;
+		void *adap;
+		u8 coreid;
+	} u;
 };
 
 struct cudbg_init {
 	struct adapter *adap; /* Pointer to adapter structure */
+	struct cudbg_param dbg_params[CUDBG_MAX_PARAMS];
 	void *outbuf; /* Output buffer */
 	u32 outbuf_size;  /* Output buffer size */
 	u8 compress_type; /* Type of compression to use */
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c b/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c
index 4bae323351f7..3331a27dedff 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c
@@ -15,6 +15,7 @@
 #include "cudbg_lib.h"
 #include "cudbg_zlib.h"
 #include "cxgb4_tc_mqprio.h"
+#include "cudbg_indir_reg.h"
 
 static const u32 t6_tp_pio_array[][IREG_NUM_ELEM] = {
 	{0x7e40, 0x7e44, 0x020, 28}, /* t6_tp_pio_regs_20_to_3b */
@@ -193,12 +194,15 @@ u32 cudbg_get_entity_length(struct adapter *adap, u32 entity)
 		case CHELSIO_T6:
 			len = T5_REGMAP_SIZE;
 			break;
+		case CHELSIO_T7:
+			len = T7_REGMAP_SIZE;
+			break;
 		default:
 			break;
 		}
 		break;
 	case CUDBG_DEV_LOG:
-		len = adap->params.devlogs.size;
+		len = adap->params.devlog[0].size;
 		break;
 	case CUDBG_CIM_LA:
 		if (is_t6(adap->params.chip)) {
@@ -214,39 +218,63 @@ u32 cudbg_get_entity_length(struct adapter *adap, u32 entity)
 		len = 2 * CIM_MALA_SIZE * 5 * sizeof(u32);
 		break;
 	case CUDBG_CIM_QCFG:
-		len = sizeof(struct cudbg_cim_qcfg);
+		len = sizeof(struct cim_qcfg_rev1);
 		break;
 	case CUDBG_CIM_IBQ_TP0:
 	case CUDBG_CIM_IBQ_TP1:
 	case CUDBG_CIM_IBQ_ULP:
-	case CUDBG_CIM_IBQ_SGE0:
-	case CUDBG_CIM_IBQ_SGE1:
+	case CUDBG_CIM_IBQ_SGE:
+	case CUDBG_CIM_IBQ_PCIE:
 	case CUDBG_CIM_IBQ_NCSI:
 		len = CIM_IBQ_SIZE * 4 * sizeof(u32);
 		break;
+	case CUDBG_CIM_IBQ_TP2:
+	case CUDBG_CIM_IBQ_TP3:
+	case CUDBG_CIM_IBQ_IPC1:
+	case CUDBG_CIM_IBQ_IPC2:
+	case CUDBG_CIM_IBQ_IPC3:
+	case CUDBG_CIM_IBQ_IPC4:
+	case CUDBG_CIM_IBQ_IPC5:
+	case CUDBG_CIM_IBQ_IPC6:
+	case CUDBG_CIM_IBQ_IPC7:
+		if (CHELSIO_CHIP_VERSION(adap->params.chip) < CHELSIO_T7)
+			break;			/* len stays 0 */
+		len = CIM_IBQ_SIZE * 4 * sizeof(u32);
+		break;
 	case CUDBG_CIM_OBQ_ULP0:
-		len = cudbg_cim_obq_size(adap, 0);
+		len = cudbg_cim_obq_size(adap, 0, 0);
 		break;
 	case CUDBG_CIM_OBQ_ULP1:
-		len = cudbg_cim_obq_size(adap, 1);
+		len = cudbg_cim_obq_size(adap, 1, 0);
 		break;
 	case CUDBG_CIM_OBQ_ULP2:
-		len = cudbg_cim_obq_size(adap, 2);
+		len = cudbg_cim_obq_size(adap, 2, 0);
 		break;
 	case CUDBG_CIM_OBQ_ULP3:
-		len = cudbg_cim_obq_size(adap, 3);
+		len = cudbg_cim_obq_size(adap, 3, 0);
 		break;
 	case CUDBG_CIM_OBQ_SGE:
-		len = cudbg_cim_obq_size(adap, 4);
+		len = cudbg_cim_obq_size(adap, 4, 0);
 		break;
 	case CUDBG_CIM_OBQ_NCSI:
-		len = cudbg_cim_obq_size(adap, 5);
+		len = cudbg_cim_obq_size(adap, 5, 0);
 		break;
 	case CUDBG_CIM_OBQ_RXQ0:
-		len = cudbg_cim_obq_size(adap, 6);
+		len = cudbg_cim_obq_size(adap, 6, 0);
 		break;
 	case CUDBG_CIM_OBQ_RXQ1:
-		len = cudbg_cim_obq_size(adap, 7);
+		len = cudbg_cim_obq_size(adap, 7, 0);
+		break;
+	case CUDBG_CIM_OBQ_IPC1:
+	case CUDBG_CIM_OBQ_IPC2:
+	case CUDBG_CIM_OBQ_IPC3:
+	case CUDBG_CIM_OBQ_IPC4:
+	case CUDBG_CIM_OBQ_IPC5:
+	case CUDBG_CIM_OBQ_IPC6:
+	case CUDBG_CIM_OBQ_IPC7:
+		if (CHELSIO_CHIP_VERSION(adap->params.chip) < CHELSIO_T7)
+			break;			/* len stays 0 */
+		len = 6 * CIM_OBQ_SIZE * 4 * sizeof(u32);
 		break;
 	case CUDBG_EDC0:
 		value = t4_read_reg(adap, MA_TARGET_MEM_ENABLE_A);
@@ -350,7 +378,9 @@ u32 cudbg_get_entity_length(struct adapter *adap, u32 entity)
 		len = sizeof(u32) * CUDBG_NUM_PCIE_CONFIG_REGS;
 		break;
 	case CUDBG_DUMP_CONTEXT:
-		len = cudbg_dump_context_size(adap);
+		len = cudbg_dump_context_size(adap, (CHELSIO_CHIP_VERSION(adap->params.chip) >=
+						    CHELSIO_T7) ? SGE_CTXT_SIZE_T7 :
+								  SGE_CTXT_SIZE);
 		break;
 	case CUDBG_MPS_TCAM:
 		len = sizeof(struct cudbg_mps_tcam) *
@@ -537,10 +567,11 @@ static int cudbg_mem_desc_cmp(const void *a, const void *b)
 int cudbg_fill_meminfo(struct adapter *padap,
 		       struct cudbg_meminfo *meminfo_buff)
 {
+	u32 lo, hi, used, alloc, chip_ver;
 	struct cudbg_mem_desc *md;
-	u32 lo, hi, used, alloc;
 	int n, i;
 
+	chip_ver = CHELSIO_CHIP_VERSION(padap->params.chip);
 	memset(meminfo_buff->avail, 0,
 	       ARRAY_SIZE(meminfo_buff->avail) *
 	       sizeof(struct cudbg_mem_desc));
@@ -578,50 +609,66 @@ int cudbg_fill_meminfo(struct adapter *padap,
 		i++;
 	}
 
-	if (is_t5(padap->params.chip)) {
+	if (chip_ver >= CHELSIO_T7) {
+		/* MC0:*/
 		if (lo & EXT_MEM0_ENABLE_F) {
 			hi = t4_read_reg(padap, MA_EXT_MEMORY0_BAR_A);
 			meminfo_buff->avail[i].base =
-				cudbg_mbytes_to_bytes(EXT_MEM_BASE_G(hi));
+				cudbg_mbytes_to_bytes(T7_EXT_MEM0_BASE_G(hi));
 			meminfo_buff->avail[i].limit =
 				meminfo_buff->avail[i].base +
-				cudbg_mbytes_to_bytes(EXT_MEM_SIZE_G(hi));
+				cudbg_mbytes_to_bytes(T7_EXT_MEM0_SIZE_G(hi));
 			meminfo_buff->avail[i].idx = 3;
 			i++;
 		}
-
+		/* MC1:*/
 		if (lo & EXT_MEM1_ENABLE_F) {
 			hi = t4_read_reg(padap, MA_EXT_MEMORY1_BAR_A);
 			meminfo_buff->avail[i].base =
-				cudbg_mbytes_to_bytes(EXT_MEM1_BASE_G(hi));
+				cudbg_mbytes_to_bytes(T7_EXT_MEM1_BASE_G(hi));
 			meminfo_buff->avail[i].limit =
 				meminfo_buff->avail[i].base +
-				cudbg_mbytes_to_bytes(EXT_MEM1_SIZE_G(hi));
+				cudbg_mbytes_to_bytes(T7_EXT_MEM1_SIZE_G(hi));
 			meminfo_buff->avail[i].idx = 4;
 			i++;
 		}
-	} else {
-		if (lo & EXT_MEM_ENABLE_F) {
-			hi = t4_read_reg(padap, MA_EXT_MEMORY_BAR_A);
+		/* HMA:*/
+		if (lo & HMA_MUX_F) {
+			hi = t4_read_reg(padap, MA_HOST_MEMORY_BAR_A);
 			meminfo_buff->avail[i].base =
-				cudbg_mbytes_to_bytes(EXT_MEM_BASE_G(hi));
+				cudbg_mbytes_to_bytes(HMATARGETBASE_G(hi));
 			meminfo_buff->avail[i].limit =
 				meminfo_buff->avail[i].base +
-				cudbg_mbytes_to_bytes(EXT_MEM_SIZE_G(hi));
-			meminfo_buff->avail[i].idx = 2;
+				cudbg_mbytes_to_bytes(T7_HMA_SIZE_G(hi));
+			meminfo_buff->avail[i].idx = 5;
 			i++;
 		}
 
-		if (lo & HMA_MUX_F) {
-			hi = t4_read_reg(padap, MA_EXT_MEMORY1_BAR_A);
+	} else {
+		/* MC0:*/
+		if (lo & EXT_MEM0_ENABLE_F) {
+			hi = t4_read_reg(padap, MA_EXT_MEMORY0_BAR_A);
 			meminfo_buff->avail[i].base =
-				cudbg_mbytes_to_bytes(EXT_MEM1_BASE_G(hi));
+				cudbg_mbytes_to_bytes(EXT_MEM_BASE_G(hi));
 			meminfo_buff->avail[i].limit =
 				meminfo_buff->avail[i].base +
-				cudbg_mbytes_to_bytes(EXT_MEM1_SIZE_G(hi));
-			meminfo_buff->avail[i].idx = 5;
+				cudbg_mbytes_to_bytes(EXT_MEM0_SIZE_G(hi));
+			meminfo_buff->avail[i].idx = 2;
 			i++;
 		}
+		/* HMA: In t6 no mc1 so HMA shares mc1 address space */
+		if (chip_ver == CHELSIO_T6) {
+			if (lo & HMA_MUX_F) {
+				hi = t4_read_reg(padap, MA_EXT_MEMORY1_BAR_A);
+				meminfo_buff->avail[i].base =
+					cudbg_mbytes_to_bytes(EXT_MEM1_BASE_G(hi));
+				meminfo_buff->avail[i].limit =
+					meminfo_buff->avail[i].base +
+					cudbg_mbytes_to_bytes(EXT_MEM1_SIZE_G(hi));
+				meminfo_buff->avail[i].idx = 5;
+				i++;
+			}
+		}
 	}
 
 	if (!i) /* no memory available */
@@ -820,10 +867,7 @@ int cudbg_collect_reg_dump(struct cudbg_init *pdbg_init,
 	u32 buf_size = 0;
 	int rc = 0;
 
-	if (is_t4(padap->params.chip))
-		buf_size = T4_REGMAP_SIZE;
-	else if (is_t5(padap->params.chip) || is_t6(padap->params.chip))
-		buf_size = T5_REGMAP_SIZE;
+	buf_size = t4_get_regs_len(padap);
 
 	rc = cudbg_get_buff(pdbg_init, dbg_buff, buf_size, &temp_buff);
 	if (rc)
@@ -839,15 +883,20 @@ int cudbg_collect_fw_devlog(struct cudbg_init *pdbg_init,
 	struct adapter *padap = pdbg_init->adap;
 	struct cudbg_buffer temp_buff = { 0 };
 	struct devlog_params *dparams;
+	u8 coreid = 0;
 	int rc = 0;
 
+	if (pdbg_init->dbg_params[CUDBG_UP_COREID_PARAM].param_type ==
+			CUDBG_UP_COREID_PARAM)
+		coreid = pdbg_init->dbg_params[CUDBG_UP_COREID_PARAM].u.coreid;
+
+	dparams = &padap->params.devlog[coreid];
 	rc = t4_init_devlog_params(padap);
 	if (rc < 0) {
 		cudbg_err->sys_err = rc;
 		return rc;
 	}
 
-	dparams = &padap->params.devlogs;
 	rc = cudbg_get_buff(pdbg_init, dbg_buff, dparams->size, &temp_buff);
 	if (rc)
 		return rc;
@@ -875,39 +924,52 @@ int cudbg_collect_cim_la(struct cudbg_init *pdbg_init,
 			 struct cudbg_error *cudbg_err)
 {
 	struct adapter *padap = pdbg_init->adap;
+	struct cim_la_rev1 *cim_la_buff;
 	struct cudbg_buffer temp_buff = { 0 };
+	u8 ncol, coreid = 0;
 	int size, rc;
 	u32 cfg = 0;
+	u16 nrow;
 
-	if (is_t6(padap->params.chip)) {
-		size = padap->params.cim_la_size / 10 + 1;
-		size *= 10 * sizeof(u32);
-	} else {
-		size = padap->params.cim_la_size / 8;
-		size *= 8 * sizeof(u32);
-	}
+	if (CHELSIO_CHIP_VERSION(padap->params.chip) >= CHELSIO_T6)
+		ncol = 10;
+	else
+		ncol = 8;
+
+	if (pdbg_init->dbg_params[CUDBG_UP_COREID_PARAM].param_type ==
+			CUDBG_UP_COREID_PARAM)
+		coreid = pdbg_init->dbg_params[CUDBG_UP_COREID_PARAM].u.coreid;
 
-	size += sizeof(cfg);
+	nrow = padap->params.cim_la_size / ncol;
+	size = sizeof(*cim_la_buff) + padap->params.cim_la_size * sizeof(u32);
 	rc = cudbg_get_buff(pdbg_init, dbg_buff, size, &temp_buff);
 	if (rc)
 		return rc;
 
-	rc = t4_cim_read(padap, UP_UP_DBG_LA_CFG_A, 1, &cfg);
+	cim_la_buff = (void *)temp_buff.data;
+	cim_la_buff->ver_hdr.signature = CUDBG_ENTITY_SIGNATURE;
+	cim_la_buff->ver_hdr.revision = CUDBG_CIM_LA_REV;
+	cim_la_buff->ver_hdr.size = sizeof(*cim_la_buff) -
+		sizeof(struct cudbg_ver_hdr);
+
+	rc = t4_cim_read_core(padap, 1, coreid, UP_UP_DBG_LA_CFG_A, 1, &cfg);
 	if (rc) {
 		cudbg_err->sys_err = rc;
 		cudbg_put_buff(pdbg_init, &temp_buff);
 		return rc;
 	}
 
-	memcpy((char *)temp_buff.data, &cfg, sizeof(cfg));
-	rc = t4_cim_read_la(padap,
-			    (u32 *)((char *)temp_buff.data + sizeof(cfg)),
-			    NULL);
+	rc = t4_cim_read_la_core(padap, coreid, cim_la_buff->data, NULL);
 	if (rc < 0) {
 		cudbg_err->sys_err = rc;
 		cudbg_put_buff(pdbg_init, &temp_buff);
 		return rc;
 	}
+
+	cim_la_buff->coreid = coreid;
+	cim_la_buff->config = cfg;
+	cim_la_buff->ncol = ncol;
+	cim_la_buff->nrow = nrow;
 	return cudbg_write_and_release_buff(pdbg_init, &temp_buff, dbg_buff);
 }
 
@@ -931,41 +993,160 @@ int cudbg_collect_cim_ma_la(struct cudbg_init *pdbg_init,
 	return cudbg_write_and_release_buff(pdbg_init, &temp_buff, dbg_buff);
 }
 
+static void cudbg_cim_qcfg_copy(struct cim_qcfg_rev1_data *data, u8 num_cim_ibq,
+				u8 num_cim_obq, u16 *base, u16 *size,
+				u16 *thres, u32 *stat, u32 *obq_wr)
+{
+	u8 i = 0;
+
+	while (i < num_cim_ibq) {
+		data->qtype = CUDBG_ENTITY_CIM_QCFG_QTYPE_IBQ;
+		data->qid = i;
+		data->base = *base;
+		data->size = *size;
+		data->thres = *thres;
+		memcpy(data->stat, stat, sizeof(data->stat));
+
+		stat += ARRAY_SIZE(data->stat);
+		thres++;
+		size++;
+		base++;
+		data++;
+		i++;
+	}
+
+	while (i < num_cim_ibq + num_cim_obq) {
+		data->qtype = CUDBG_ENTITY_CIM_QCFG_QTYPE_OBQ;
+		data->qid = i - num_cim_ibq;
+		data->base = *base;
+		data->size = *size;
+		memcpy(data->stat, stat, sizeof(data->stat));
+		memcpy(data->obq_wr, obq_wr, sizeof(data->obq_wr));
+
+		obq_wr += ARRAY_SIZE(data->obq_wr);
+		stat += ARRAY_SIZE(data->stat);
+		size++;
+		base++;
+		data++;
+		i++;
+	}
+}
+
+static int cudbg_collect_cim_qcfg_t5(struct cudbg_init *pdbg_init,
+				     struct cim_qcfg_rev1_data *data,
+				     u8 num_cim_ibq, u8 num_cim_obq)
+{
+	u32 stat[4 * (CIM_NUM_IBQ + CIM_NUM_OBQ_T5)];
+	struct adapter *padap = pdbg_init->adap;
+	u16 base[CIM_NUM_IBQ + CIM_NUM_OBQ_T5];
+	u16 size[CIM_NUM_IBQ + CIM_NUM_OBQ_T5];
+	u32 obq_wr[2 * CIM_NUM_OBQ_T5];
+	u16 thres[CIM_NUM_IBQ];
+	int ret;
+
+	ret = t4_cim_read(padap, UP_IBQ_0_SHADOW_RDADDR_A,
+			  4 * (num_cim_ibq + num_cim_obq), stat);
+	if (ret < 0)
+		return ret;
+
+	ret = t4_cim_read(padap, UP_OBQ_0_SHADOW_REALADDR_A, 2 * num_cim_obq,
+			  obq_wr);
+	if (ret < 0)
+		return ret;
+
+	t4_read_cimq_cfg(padap, base, size, thres);
+
+	cudbg_cim_qcfg_copy(data, num_cim_ibq, num_cim_obq, base, size, thres,
+			    stat, obq_wr);
+	return 0;
+}
+
+static int cudbg_collect_cim_qcfg_t7(struct cudbg_init *pdbg_init, u8 coreid,
+				     struct cim_qcfg_rev1_data *data,
+				     u8 num_cim_ibq, u8 num_cim_obq)
+{
+	u32 stat[4 * (CIM_NUM_IBQ_T7 + CIM_NUM_OBQ_T7)];
+	u16 base[CIM_NUM_IBQ_T7 + CIM_NUM_OBQ_T7];
+	u16 size[CIM_NUM_IBQ_T7 + CIM_NUM_OBQ_T7];
+	struct adapter *padap = pdbg_init->adap;
+	u32 obq_wr[2 * CIM_NUM_OBQ_T7];
+	u16 thres[CIM_NUM_IBQ_T7];
+	u32 addr;
+	int ret;
+	u8 i;
+
+	ret = t4_cim_read_core(padap, 1, coreid, T7_UP_IBQ_0_SHADOW_RDADDR_A,
+			       4 * num_cim_ibq, stat);
+	if (ret < 0)
+		return ret;
+
+	ret = t4_cim_read_core(padap, 1, coreid, T7_UP_OBQ_0_SHADOW_RDADDR_A,
+			       4 * num_cim_obq, &stat[4 * num_cim_ibq]);
+	if (ret < 0)
+		return ret;
+
+	addr = T7_UP_OBQ_0_SHADOW_REALADDR_A;
+	for (i = 0; i < num_cim_obq * 2; i++, addr += 8) {
+		ret = t4_cim_read_core(padap, 1, coreid, addr, 1, &obq_wr[i]);
+		if (ret < 0)
+			return ret;
+	}
+
+	t4_read_cimq_cfg_core(padap, coreid, base, size, thres);
+
+	cudbg_cim_qcfg_copy(data, num_cim_ibq, num_cim_obq, base, size, thres,
+			    stat, obq_wr);
+	return 0;
+}
+
 int cudbg_collect_cim_qcfg(struct cudbg_init *pdbg_init,
 			   struct cudbg_buffer *dbg_buff,
 			   struct cudbg_error *cudbg_err)
 {
+	struct cim_qcfg_rev1 *cim_qcfg_buff;
+	u8 num_cim_ibq, num_cim_obq, coreid = 0;
 	struct adapter *padap = pdbg_init->adap;
+	struct cim_qcfg_rev1_data *data;
 	struct cudbg_buffer temp_buff = { 0 };
-	struct cudbg_cim_qcfg *cim_qcfg_data;
+	u32 size;
 	int rc;
 
-	rc = cudbg_get_buff(pdbg_init, dbg_buff, sizeof(struct cudbg_cim_qcfg),
-			    &temp_buff);
+	if (pdbg_init->dbg_params[CUDBG_UP_COREID_PARAM].param_type ==
+			CUDBG_UP_COREID_PARAM)
+		coreid = pdbg_init->dbg_params[CUDBG_UP_COREID_PARAM].u.coreid;
+
+	num_cim_ibq = t4_cim_num_ibq(padap);
+	num_cim_obq = t4_cim_num_obq(padap);
+	size = sizeof(*cim_qcfg_buff) +
+		((num_cim_ibq + num_cim_obq) * sizeof(*data));
+
+	rc = cudbg_get_buff(pdbg_init, dbg_buff, size, &temp_buff);
 	if (rc)
 		return rc;
 
-	cim_qcfg_data = (struct cudbg_cim_qcfg *)temp_buff.data;
-	cim_qcfg_data->chip = padap->params.chip;
-	rc = t4_cim_read(padap, UP_IBQ_0_RDADDR_A,
-			 ARRAY_SIZE(cim_qcfg_data->stat), cim_qcfg_data->stat);
-	if (rc) {
-		cudbg_err->sys_err = rc;
-		cudbg_put_buff(pdbg_init, &temp_buff);
-		return rc;
-	}
+	cim_qcfg_buff = (void *)((u8 *)temp_buff.data + temp_buff.offset);
+	cim_qcfg_buff->ver_hdr.signature = CUDBG_ENTITY_SIGNATURE;
+	cim_qcfg_buff->ver_hdr.revision = CUDBG_CIM_QCFG_REV;
+	cim_qcfg_buff->ver_hdr.size = sizeof(*cim_qcfg_buff) -
+		sizeof(struct cudbg_ver_hdr);
+
+	cim_qcfg_buff->num_cim_ibq = num_cim_ibq;
+	cim_qcfg_buff->num_cim_obq = num_cim_obq;
+	cim_qcfg_buff->coreid = coreid;
+	data = cim_qcfg_buff->data;
 
-	rc = t4_cim_read(padap, UP_OBQ_0_REALADDR_A,
-			 ARRAY_SIZE(cim_qcfg_data->obq_wr),
-			 cim_qcfg_data->obq_wr);
+	if (CHELSIO_CHIP_VERSION(padap->params.chip) >= CHELSIO_T7)
+		rc = cudbg_collect_cim_qcfg_t7(pdbg_init, coreid, data,
+					       num_cim_ibq, num_cim_obq);
+	else
+		rc = cudbg_collect_cim_qcfg_t5(pdbg_init, data, num_cim_ibq,
+					       num_cim_obq);
 	if (rc) {
 		cudbg_err->sys_err = rc;
 		cudbg_put_buff(pdbg_init, &temp_buff);
 		return rc;
 	}
 
-	t4_read_cimq_cfg(padap, cim_qcfg_data->base, cim_qcfg_data->size,
-			 cim_qcfg_data->thres);
 	return cudbg_write_and_release_buff(pdbg_init, &temp_buff, dbg_buff);
 }
 
@@ -973,20 +1154,38 @@ static int cudbg_read_cim_ibq(struct cudbg_init *pdbg_init,
 			      struct cudbg_buffer *dbg_buff,
 			      struct cudbg_error *cudbg_err, int qid)
 {
+	struct cim_ibq_rev1 *cim_ibq_buff;
 	struct adapter *padap = pdbg_init->adap;
 	struct cudbg_buffer temp_buff = { 0 };
 	int no_of_read_words, rc = 0;
+	u8 coreid = 0;
 	u32 qsize;
 
+	if (qid >= t4_cim_num_ibq(padap))
+		return CUDBG_STATUS_ENTITY_NOT_FOUND;
+
+	if (pdbg_init->dbg_params[CUDBG_UP_COREID_PARAM].param_type ==
+			CUDBG_UP_COREID_PARAM)
+		coreid = pdbg_init->dbg_params[CUDBG_UP_COREID_PARAM].u.coreid;
+
 	/* collect CIM IBQ */
 	qsize = CIM_IBQ_SIZE * 4 * sizeof(u32);
-	rc = cudbg_get_buff(pdbg_init, dbg_buff, qsize, &temp_buff);
+	rc = cudbg_get_buff(pdbg_init, dbg_buff, sizeof(*cim_ibq_buff) + qsize,
+			    &temp_buff);
 	if (rc)
 		return rc;
+	cim_ibq_buff = (void *)((u8 *)temp_buff.data + temp_buff.offset);
+	cim_ibq_buff->ver_hdr.signature = CUDBG_ENTITY_SIGNATURE;
+	cim_ibq_buff->ver_hdr.revision = CUDBG_CIM_IBQ_REV;
+	cim_ibq_buff->ver_hdr.size = sizeof(*cim_ibq_buff) -
+		sizeof(struct cudbg_ver_hdr);
+	cim_ibq_buff->qid = qid;
+	cim_ibq_buff->coreid = coreid;
 
 	/* t4_read_cim_ibq will return no. of read words or error */
-	no_of_read_words = t4_read_cim_ibq(padap, qid,
-					   (u32 *)temp_buff.data, qsize);
+	no_of_read_words = t4_read_cim_ibq_core(padap, coreid, qid,
+						cim_ibq_buff->data, qsize);
+
 	/* no_of_read_words is less than or equal to 0 means error */
 	if (no_of_read_words <= 0) {
 		if (!no_of_read_words)
@@ -1014,24 +1213,63 @@ int cudbg_collect_cim_ibq_tp1(struct cudbg_init *pdbg_init,
 	return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 1);
 }
 
+int cudbg_collect_cim_ibq_tp2(struct cudbg_init *pdbg_init,
+			      struct cudbg_buffer *dbg_buff,
+			      struct cudbg_error *cudbg_err)
+{
+	struct adapter *padap = pdbg_init->adap;
+
+	if (CHELSIO_CHIP_VERSION(padap->params.chip) <= CHELSIO_T6)
+		return CUDBG_STATUS_ENTITY_NOT_FOUND;
+
+	return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 2);
+}
+
+int cudbg_collect_cim_ibq_tp3(struct cudbg_init *pdbg_init,
+			      struct cudbg_buffer *dbg_buff,
+			      struct cudbg_error *cudbg_err)
+{
+	struct adapter *padap = pdbg_init->adap;
+
+	if (CHELSIO_CHIP_VERSION(padap->params.chip) <= CHELSIO_T6)
+		return CUDBG_STATUS_ENTITY_NOT_FOUND;
+
+	return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 3);
+}
+
 int cudbg_collect_cim_ibq_ulp(struct cudbg_init *pdbg_init,
 			      struct cudbg_buffer *dbg_buff,
 			      struct cudbg_error *cudbg_err)
 {
+	struct adapter *padap = pdbg_init->adap;
+
+	if (CHELSIO_CHIP_VERSION(padap->params.chip) >= CHELSIO_T7)
+		return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 4);
+
 	return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 2);
 }
 
-int cudbg_collect_cim_ibq_sge0(struct cudbg_init *pdbg_init,
-			       struct cudbg_buffer *dbg_buff,
-			       struct cudbg_error *cudbg_err)
+int cudbg_collect_cim_ibq_sge(struct cudbg_init *pdbg_init,
+			      struct cudbg_buffer *dbg_buff,
+			      struct cudbg_error *cudbg_err)
 {
+	struct adapter *padap = pdbg_init->adap;
+
+	if (CHELSIO_CHIP_VERSION(padap->params.chip) >= CHELSIO_T7)
+		return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 5);
+
 	return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 3);
 }
 
-int cudbg_collect_cim_ibq_sge1(struct cudbg_init *pdbg_init,
+int cudbg_collect_cim_ibq_pcie(struct cudbg_init *pdbg_init,
 			       struct cudbg_buffer *dbg_buff,
 			       struct cudbg_error *cudbg_err)
 {
+	struct adapter *padap = pdbg_init->adap;
+
+	if (CHELSIO_CHIP_VERSION(padap->params.chip) >= CHELSIO_T7)
+		return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 6);
+
 	return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 4);
 }
 
@@ -1039,17 +1277,82 @@ int cudbg_collect_cim_ibq_ncsi(struct cudbg_init *pdbg_init,
 			       struct cudbg_buffer *dbg_buff,
 			       struct cudbg_error *cudbg_err)
 {
+	struct adapter *padap = pdbg_init->adap;
+
+	if (CHELSIO_CHIP_VERSION(padap->params.chip) >= CHELSIO_T7)
+		return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 7);
+
 	return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 5);
 }
 
-u32 cudbg_cim_obq_size(struct adapter *padap, int qid)
+int cudbg_collect_cim_ibq_ipc1(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err)
+{
+	return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 9);
+}
+
+int cudbg_collect_cim_ibq_ipc2(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err)
 {
+	return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 10);
+}
+
+int cudbg_collect_cim_ibq_ipc3(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err)
+{
+	return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 11);
+}
+
+int cudbg_collect_cim_ibq_ipc4(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err)
+{
+	return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 12);
+}
+
+int cudbg_collect_cim_ibq_ipc5(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err)
+{
+	return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 13);
+}
+
+int cudbg_collect_cim_ibq_ipc6(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err)
+{
+	return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 14);
+}
+
+int cudbg_collect_cim_ibq_ipc7(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err)
+{
+	return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 15);
+}
+
+u32 cudbg_cim_obq_size(struct adapter *padap, int qid, u8 coreid)
+{
+	unsigned int v, m;
 	u32 value;
 
-	t4_write_reg(padap, CIM_QUEUE_CONFIG_REF_A, OBQSELECT_F |
-		     QUENUMSELECT_V(qid));
+	if (CHELSIO_CHIP_VERSION(padap->params.chip) >= CHELSIO_T7) {
+		v = T7_OBQSELECT_F | T7_QUENUMSELECT_V(qid) |
+		    CORESELECT_V(coreid);
+		/* value is in 512-byte units */
+		m = 128;
+	} else {
+		v = OBQSELECT_F | QUENUMSELECT_V(qid);
+		/* value is in 256-byte units */
+		m = 64;
+	}
+
+	t4_write_reg(padap, CIM_QUEUE_CONFIG_REF_A, v);
 	value = t4_read_reg(padap, CIM_QUEUE_CONFIG_CTRL_A);
-	value = CIMQSIZE_G(value) * 64; /* size in number of words */
+	value = CIMQSIZE_G(value) * m; /* size in number of words */
 	return value * sizeof(u32);
 }
 
@@ -1057,20 +1360,38 @@ static int cudbg_read_cim_obq(struct cudbg_init *pdbg_init,
 			      struct cudbg_buffer *dbg_buff,
 			      struct cudbg_error *cudbg_err, int qid)
 {
+	struct cim_obq_rev1 *cim_obq_buff;
 	struct adapter *padap = pdbg_init->adap;
 	struct cudbg_buffer temp_buff = { 0 };
 	int no_of_read_words, rc = 0;
+	u8 coreid = 0;
 	u32 qsize;
 
+	if (qid >= t4_cim_num_obq(padap))
+		return CUDBG_STATUS_ENTITY_NOT_FOUND;
+
+	if (pdbg_init->dbg_params[CUDBG_UP_COREID_PARAM].param_type ==
+			CUDBG_UP_COREID_PARAM)
+		coreid = pdbg_init->dbg_params[CUDBG_UP_COREID_PARAM].u.coreid;
+
 	/* collect CIM OBQ */
-	qsize =  cudbg_cim_obq_size(padap, qid);
-	rc = cudbg_get_buff(pdbg_init, dbg_buff, qsize, &temp_buff);
+	qsize = cudbg_cim_obq_size(padap, qid, coreid);
+	rc = cudbg_get_buff(pdbg_init, dbg_buff, sizeof(*cim_obq_buff) + qsize,
+			    &temp_buff);
 	if (rc)
 		return rc;
+	cim_obq_buff = (void *)((u8 *)temp_buff.data + temp_buff.offset);
+	cim_obq_buff->ver_hdr.signature = CUDBG_ENTITY_SIGNATURE;
+	cim_obq_buff->ver_hdr.revision = CUDBG_CIM_OBQ_REV;
+	cim_obq_buff->ver_hdr.size = sizeof(*cim_obq_buff) -
+		sizeof(struct cudbg_ver_hdr);
+	cim_obq_buff->qid = qid;
+	cim_obq_buff->coreid = coreid;
 
 	/* t4_read_cim_obq will return no. of read words or error */
-	no_of_read_words = t4_read_cim_obq(padap, qid,
-					   (u32 *)temp_buff.data, qsize);
+	no_of_read_words = t4_read_cim_obq_core(padap, coreid, qid,
+						cim_obq_buff->data, qsize);
+
 	/* no_of_read_words is less than or equal to 0 means error */
 	if (no_of_read_words <= 0) {
 		if (!no_of_read_words)
@@ -1140,6 +1461,55 @@ int cudbg_collect_obq_sge_rx_q1(struct cudbg_init *pdbg_init,
 	return cudbg_read_cim_obq(pdbg_init, dbg_buff, cudbg_err, 7);
 }
 
+int cudbg_collect_cim_obq_ipc1(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err)
+{
+	return cudbg_read_cim_obq(pdbg_init, dbg_buff, cudbg_err, 9);
+}
+
+int cudbg_collect_cim_obq_ipc2(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err)
+{
+	return cudbg_read_cim_obq(pdbg_init, dbg_buff, cudbg_err, 10);
+}
+
+int cudbg_collect_cim_obq_ipc3(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err)
+{
+	return cudbg_read_cim_obq(pdbg_init, dbg_buff, cudbg_err, 11);
+}
+
+int cudbg_collect_cim_obq_ipc4(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err)
+{
+	return cudbg_read_cim_obq(pdbg_init, dbg_buff, cudbg_err, 12);
+}
+
+int cudbg_collect_cim_obq_ipc5(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err)
+{
+	return cudbg_read_cim_obq(pdbg_init, dbg_buff, cudbg_err, 13);
+}
+
+int cudbg_collect_cim_obq_ipc6(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err)
+{
+	return cudbg_read_cim_obq(pdbg_init, dbg_buff, cudbg_err, 14);
+}
+
+int cudbg_collect_cim_obq_ipc7(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err)
+{
+	return cudbg_read_cim_obq(pdbg_init, dbg_buff, cudbg_err, 15);
+}
+
 static int cudbg_meminfo_get_mem_index(struct adapter *padap,
 				       struct cudbg_meminfo *mem_info,
 				       u8 mem_type, u8 *idx)
@@ -1286,9 +1656,9 @@ static int cudbg_memory_read(struct cudbg_init *pdbg_init, int win,
 {
 	u32 win_pf, memoffset, mem_aperture, mem_base;
 	struct adapter *adap = pdbg_init->adap;
-	u32 pos, offset, resid;
+	u32 offset, resid;
+	u64 pos, *buf;
 	u32 *res_buf;
-	u64 *buf;
 	int ret;
 
 	/* Argument sanity checks ...
@@ -1316,7 +1686,7 @@ static int cudbg_memory_read(struct cudbg_init *pdbg_init, int win,
 	/* Set up initial PCI-E Memory Window to cover the start of our
 	 * transfer.
 	 */
-	t4_memory_update_win(adap, win, pos | win_pf);
+	t4_pcie_mem_access_offset_write(adap, pos, win, win_pf);
 
 	/* Transfer data from the adapter */
 	while (len > 0) {
@@ -1331,7 +1701,7 @@ static int cudbg_memory_read(struct cudbg_init *pdbg_init, int win,
 		if (offset == mem_aperture) {
 			pos += mem_aperture;
 			offset = 0;
-			t4_memory_update_win(adap, win, pos | win_pf);
+			t4_pcie_mem_access_offset_write(adap, pos, win, win_pf);
 		}
 	}
 
@@ -1349,7 +1719,7 @@ static int cudbg_memory_read(struct cudbg_init *pdbg_init, int win,
 		if (offset == mem_aperture) {
 			pos += mem_aperture;
 			offset = 0;
-			t4_memory_update_win(adap, win, pos | win_pf);
+			t4_pcie_mem_access_offset_write(adap, pos, win, win_pf);
 		}
 	}
 
@@ -1653,6 +2023,33 @@ int cudbg_collect_hw_sched(struct cudbg_init *pdbg_init,
 	return cudbg_write_and_release_buff(pdbg_init, &temp_buff, dbg_buff);
 }
 
+static void *cudbg_collect_indir_reg_init(struct cudbg_indir_reg_entity *e,
+					  u16 rev, u32 indir_reg,
+					  u32 indir_data, u32 nentries)
+{
+	struct cudbg_ver_hdr *ver_hdr = &e->ver_hdr;
+
+	ver_hdr->signature = CUDBG_ENTITY_SIGNATURE;
+	ver_hdr->revision = rev;
+	ver_hdr->size = sizeof(*e) - sizeof(*ver_hdr);
+
+	e->indir_reg = indir_reg;
+	e->indir_data = indir_data;
+	e->nentries = nentries;
+	return e;
+}
+
+static void *cudbg_collect_indir_reg_init_next(struct cudbg_indir_reg_entity *e,
+					       u16 rev, u32 indir_reg,
+					       u32 indir_data, u32 nentries)
+{
+	struct cudbg_indir_reg_entity *n;
+
+	n = (void *)((u8 *)e + (sizeof(*e) + sizeof(e->data[0]) * e->nentries));
+	return cudbg_collect_indir_reg_init(n, rev, indir_reg, indir_data,
+					    nentries);
+}
+
 int cudbg_collect_tp_indirect(struct cudbg_init *pdbg_init,
 			      struct cudbg_buffer *dbg_buff,
 			      struct cudbg_error *cudbg_err)
@@ -1663,6 +2060,77 @@ int cudbg_collect_tp_indirect(struct cudbg_init *pdbg_init,
 	int i, rc, n = 0;
 	u32 size;
 
+	if (CHELSIO_CHIP_VERSION(padap->params.chip) >= CHELSIO_T7) {
+		/* T7 path - new indirect reg framework */
+		struct cudbg_indir_reg_entity *tp_tm_entity, *tp_pio_entity;
+		struct cudbg_indir_reg_entity *tp_mib_entity;
+		const struct cudbg_indir_type_entry *tp_tm_arr;
+		const struct cudbg_indir_type_entry *tp_pio_arr;
+		const struct cudbg_indir_type_entry *tp_mib_arr;
+		struct cudbg_indir_reg_data *reg_data;
+		u32 chip_ver;
+
+		chip_ver = CHELSIO_CHIP_VERSION(padap->params.chip);
+		tp_tm_arr = cudbg_get_indir_reg_info(chip_ver, CUDBG_INDIR_TYPE_TP_TM_PIO_ADDR);
+		tp_pio_arr = cudbg_get_indir_reg_info(chip_ver, CUDBG_INDIR_TYPE_TP_PIO_ADDR);
+		tp_mib_arr = cudbg_get_indir_reg_info(chip_ver, CUDBG_INDIR_TYPE_TP_MIB_INDEX);
+
+		if (!tp_tm_arr || !tp_pio_arr || !tp_mib_arr)
+			return CUDBG_STATUS_ENTITY_NOT_FOUND;
+
+		size = sizeof(*tp_tm_entity) + sizeof(*tp_pio_entity) +
+			sizeof(*tp_mib_entity) + sizeof(*reg_data) *
+			(tp_tm_arr->nentries + tp_pio_arr->nentries +
+			 tp_mib_arr->nentries);
+
+		rc = cudbg_get_buff(pdbg_init, dbg_buff, size, &temp_buff);
+		if (rc)
+			return rc;
+
+		tp_tm_entity = cudbg_collect_indir_reg_init((void *)temp_buff.data,
+							    CUDBG_TP_INDIR_REG_REV,
+							    TP_TM_PIO_ADDR_A,
+							    TP_TM_PIO_DATA_A,
+							    tp_tm_arr->nentries);
+
+		tp_pio_entity = cudbg_collect_indir_reg_init_next(tp_tm_entity,
+								  CUDBG_TP_INDIR_REG_REV,
+								  TP_PIO_ADDR_A,
+								  TP_PIO_DATA_A,
+								  tp_pio_arr->nentries);
+
+		tp_mib_entity = cudbg_collect_indir_reg_init_next(tp_pio_entity,
+								  CUDBG_TP_INDIR_REG_REV,
+								  TP_MIB_INDEX_A,
+								  TP_MIB_DATA_A,
+								  tp_mib_arr->nentries);
+
+		reg_data = tp_tm_entity->data;
+		for (i = 0; i < tp_tm_entity->nentries; i++, reg_data++) {
+			reg_data->offset = tp_tm_arr->reg_arr[i].addr;
+			t4_tp_tm_pio_read(pdbg_init->adap, &reg_data->data, 1,
+					  reg_data->offset, true);
+		}
+
+		reg_data = tp_pio_entity->data;
+		for (i = 0; i < tp_pio_entity->nentries; i++, reg_data++) {
+			reg_data->offset = tp_pio_arr->reg_arr[i].addr;
+			t4_tp_pio_read(pdbg_init->adap, &reg_data->data, 1,
+				       reg_data->offset, true);
+		}
+
+		reg_data = tp_mib_entity->data;
+		for (i = 0; i < tp_mib_entity->nentries; i++, reg_data++) {
+			reg_data->offset = tp_mib_arr->reg_arr[i].addr;
+			t4_tp_mib_read(pdbg_init->adap, &reg_data->data, 1,
+				       reg_data->offset, true);
+		}
+
+		return cudbg_write_and_release_buff(pdbg_init, &temp_buff,
+				dbg_buff);
+	}
+
+	/* T5/T6 path */
 	if (is_t5(padap->params.chip))
 		n = sizeof(t5_tp_pio_array) +
 		    sizeof(t5_tp_tm_pio_array) +
@@ -2061,6 +2529,36 @@ int cudbg_collect_pcie_indirect(struct cudbg_init *pdbg_init,
 	return cudbg_write_and_release_buff(pdbg_init, &temp_buff, dbg_buff);
 }
 
+static void cudbg_collect_indir_reg(struct adapter *padap,
+				    struct cudbg_indir_reg_entity *e,
+				    const struct cudbg_indir_type_entry *arr,
+				    u16 rev, u32 indir_reg, u32 indir_data)
+{
+	struct cudbg_indir_reg_entity *entity;
+	struct cudbg_indir_reg_data *reg_data;
+	u32 i;
+
+	entity = cudbg_collect_indir_reg_init(e, rev, indir_reg, indir_data,
+					      arr->nentries);
+	reg_data = entity->data;
+	for (i = 0; i < entity->nentries; i++, reg_data++) {
+		reg_data->offset = arr->reg_arr[i].addr;
+		t4_read_indirect(padap, entity->indir_reg, entity->indir_data,
+				 &reg_data->data, 1, reg_data->offset);
+	}
+}
+
+static void cudbg_collect_indir_reg_next(struct adapter *padap,
+					 struct cudbg_indir_reg_entity *e,
+					 const struct cudbg_indir_type_entry *arr,
+					 u16 rev, u32 indir_reg, u32 indir_data)
+{
+	struct cudbg_indir_reg_entity *n;
+
+	n = (void *)((u8 *)e + (sizeof(*e) + sizeof(e->data[0]) * e->nentries));
+	cudbg_collect_indir_reg(padap, n, arr, rev, indir_reg, indir_data);
+}
+
 int cudbg_collect_pm_indirect(struct cudbg_init *pdbg_init,
 			      struct cudbg_buffer *dbg_buff,
 			      struct cudbg_error *cudbg_err)
@@ -2071,6 +2569,46 @@ int cudbg_collect_pm_indirect(struct cudbg_init *pdbg_init,
 	int i, rc, n;
 	u32 size;
 
+	if (CHELSIO_CHIP_VERSION(padap->params.chip) >= CHELSIO_T7) {
+		/* T7 path - new indirect reg framework */
+		const struct cudbg_indir_type_entry *pm_rx_arr, *pm_tx_arr;
+		u32 chip_ver;
+
+		chip_ver = CHELSIO_CHIP_VERSION(padap->params.chip);
+		pm_rx_arr = cudbg_get_indir_reg_info(chip_ver,
+						     CUDBG_INDIR_TYPE_PM_RX_DBG_CTRL);
+		pm_tx_arr = cudbg_get_indir_reg_info(chip_ver,
+						     CUDBG_INDIR_TYPE_PM_TX_DBG_CTRL);
+
+		if (!pm_rx_arr || !pm_tx_arr)
+			return CUDBG_STATUS_ENTITY_NOT_FOUND;
+
+		size = sizeof(struct cudbg_indir_reg_entity) +
+			sizeof(struct cudbg_indir_reg_data) *
+			pm_rx_arr->nentries;
+		size += sizeof(struct cudbg_indir_reg_entity) +
+			sizeof(struct cudbg_indir_reg_data) *
+			pm_tx_arr->nentries;
+
+		rc = cudbg_get_buff(pdbg_init, dbg_buff, size, &temp_buff);
+		if (rc)
+			return rc;
+
+		cudbg_collect_indir_reg(padap, (void *)temp_buff.data,
+					pm_rx_arr, CUDBG_PM_INDIR_REG_REV,
+					PM_RX_DBG_CTRL_A,
+					PM_RX_DBG_CTRL_A + 4);
+
+		cudbg_collect_indir_reg_next(padap, (void *)temp_buff.data,
+					     pm_tx_arr, CUDBG_PM_INDIR_REG_REV,
+					     PM_TX_DBG_CTRL_A,
+					     PM_TX_DBG_CTRL_A + 4);
+
+		return cudbg_write_and_release_buff(pdbg_init, &temp_buff,
+						    dbg_buff);
+	}
+
+	/* T5/T6 path */
 	n = sizeof(t5_pm_rx_array) / (IREG_NUM_ELEM * sizeof(u32));
 	size = sizeof(struct ireg_buf) * n * 2;
 	rc = cudbg_get_buff(pdbg_init, dbg_buff, size, &temp_buff);
@@ -2153,16 +2691,18 @@ int cudbg_collect_tid(struct cudbg_init *pdbg_init,
 	 FW_PARAMS_PARAM_Y_V(0) | \
 	 FW_PARAMS_PARAM_Z_V(0))
 
-	para[0] = FW_PARAM_PFVF_A(ETHOFLD_START);
-	para[1] = FW_PARAM_PFVF_A(ETHOFLD_END);
-	rc = t4_query_params(padap, padap->mbox, padap->pf, 0, 2, para, val);
-	if (rc <  0) {
-		cudbg_err->sys_err = rc;
-		cudbg_put_buff(pdbg_init, &temp_buff);
-		return rc;
+	if (padap->flags & CXGB4_FW_OK) {
+		para[0] = FW_PARAM_PFVF_A(ETHOFLD_START);
+		para[1] = FW_PARAM_PFVF_A(ETHOFLD_END);
+		rc = t4_query_params(padap, padap->mbox, padap->pf, 0, 2, para, val);
+		if (rc <  0) {
+			cudbg_err->sys_err = rc;
+			cudbg_put_buff(pdbg_init, &temp_buff);
+			return rc;
+		}
+		tid->uotid_base = val[0];
+		tid->nuotids = val[1] - val[0] + 1;
 	}
-	tid->uotid_base = val[0];
-	tid->nuotids = val[1] - val[0] + 1;
 
 	if (is_t5(padap->params.chip)) {
 		tid->sb = t4_read_reg(padap, LE_DB_SERVER_INDEX_A) / 4;
@@ -2255,7 +2795,7 @@ static int cudbg_sge_ctxt_check_valid(u32 *buf, int type)
 	return buf[index] & (1U << bit);
 }
 
-static int cudbg_get_ctxt_region_info(struct adapter *padap,
+static int cudbg_get_ctxt_region_info(struct adapter *padap, u8 sge_ctxt_size,
 				      struct cudbg_region_info *ctx_info,
 				      u8 *mem_type)
 {
@@ -2303,7 +2843,7 @@ static int cudbg_get_ctxt_region_info(struct adapter *padap,
 	/* Get number of data freelist queues */
 	flq = HDRSTARTFLQ_G(value);
 	ctx_info[CTXT_FLM].exist = true;
-	ctx_info[CTXT_FLM].end = (CUDBG_MAX_FL_QIDS >> flq) * SGE_CTXT_SIZE;
+	ctx_info[CTXT_FLM].end = (CUDBG_MAX_FL_QIDS >> flq) * sge_ctxt_size;
 
 	/* The number of CONM contexts are same as number of freelist
 	 * queues.
@@ -2314,30 +2854,31 @@ static int cudbg_get_ctxt_region_info(struct adapter *padap,
 	return 0;
 }
 
-int cudbg_dump_context_size(struct adapter *padap)
+static u32 cudbg_sge_ctxt_entry_size(u8 sge_ctxt_size)
 {
-	struct cudbg_region_info region_info[CTXT_CNM + 1] = { {0} };
-	u8 mem_type[CTXT_INGRESS + 1] = { 0 };
-	u32 i, size = 0;
-	int rc;
+	return sizeof(struct sge_ctxt_rev1_data) + sge_ctxt_size;
+}
 
-	/* Get max valid qid for each type of queue */
-	rc = cudbg_get_ctxt_region_info(padap, region_info, mem_type);
-	if (rc)
-		return rc;
+int cudbg_dump_context_size(struct adapter *padap, u8 sge_ctxt_size)
+{
+	struct cudbg_region_info region_info[CTXT_MAX] = { {0} };
+	u32 i, nr_entries = 0;
+	u32 entry_size;
 
-	for (i = 0; i < CTXT_CNM; i++) {
+	for (i = 0; i < CTXT_MAX; i++) {
 		if (!region_info[i].exist) {
 			if (i == CTXT_EGRESS || i == CTXT_INGRESS)
-				size += CUDBG_LOWMEM_MAX_CTXT_QIDS *
-					SGE_CTXT_SIZE;
+				nr_entries += CUDBG_LOWMEM_MAX_CTXT_QIDS;
 			continue;
 		}
 
-		size += (region_info[i].end - region_info[i].start + 1) /
-			SGE_CTXT_SIZE;
+		nr_entries += (region_info[i].end -
+			       region_info[i].start + 1) /
+			       sge_ctxt_size;
 	}
-	return size * sizeof(struct cudbg_ch_cntxt);
+
+	entry_size = cudbg_sge_ctxt_entry_size(sge_ctxt_size);
+	return nr_entries * entry_size;
 }
 
 static void cudbg_read_sge_ctxt(struct cudbg_init *pdbg_init, u32 cid,
@@ -2359,32 +2900,48 @@ static void cudbg_read_sge_ctxt(struct cudbg_init *pdbg_init, u32 cid,
 		t4_sge_ctxt_rd_bd(padap, cid, ctype, data);
 }
 
-static void cudbg_get_sge_ctxt_fw(struct cudbg_init *pdbg_init, u32 max_qid,
-				  u8 ctxt_type,
-				  struct cudbg_ch_cntxt **out_buff)
+static u32 cudbg_get_sge_ctxt_fw(struct cudbg_init *pdbg_init, u8 sge_ctxt_size,
+				 u32 max_qid, u8 ctxt_type,
+				 struct sge_ctxt_rev1 *ctxt_buff,
+				 struct sge_ctxt_rev1_data **out_buff)
 {
-	struct cudbg_ch_cntxt *buff = *out_buff;
+	struct sge_ctxt_rev1_data *buff;
+	u8 *out = (u8 *)*out_buff;
+	u32 j, total_size = 0;
+	u32 entry_size;
 	int rc;
-	u32 j;
+
+	entry_size = cudbg_sge_ctxt_entry_size(sge_ctxt_size);
 
 	for (j = 0; j < max_qid; j++) {
+		buff = (struct sge_ctxt_rev1_data *)out;
+
 		cudbg_read_sge_ctxt(pdbg_init, j, ctxt_type, buff->data);
 		rc = cudbg_sge_ctxt_check_valid(buff->data, ctxt_type);
 		if (!rc)
 			continue;
 
-		buff->cntxt_type = ctxt_type;
-		buff->cntxt_id = j;
-		buff++;
+		buff->ctxt_type = ctxt_type;
+		buff->ctxt_id = j;
+		buff->size = sge_ctxt_size;
+		total_size += entry_size;
+		ctxt_buff->nentries++;
+		out += entry_size;
 		if (ctxt_type == CTXT_FLM) {
+			buff = (struct sge_ctxt_rev1_data *)out;
+
 			cudbg_read_sge_ctxt(pdbg_init, j, CTXT_CNM, buff->data);
-			buff->cntxt_type = CTXT_CNM;
-			buff->cntxt_id = j;
-			buff++;
+			buff->ctxt_type = CTXT_CNM;
+			buff->ctxt_id = j;
+			buff->size = sge_ctxt_size;
+			total_size += entry_size;
+			ctxt_buff->nentries++;
+			out += entry_size;
 		}
 	}
 
-	*out_buff = buff;
+	*out_buff = (struct sge_ctxt_rev1_data *)out;
+	return total_size;
 }
 
 int cudbg_collect_dump_context(struct cudbg_init *pdbg_init,
@@ -2393,27 +2950,39 @@ int cudbg_collect_dump_context(struct cudbg_init *pdbg_init,
 {
 	struct cudbg_region_info region_info[CTXT_CNM + 1] = { {0} };
 	struct adapter *padap = pdbg_init->adap;
+	struct sge_ctxt_rev1 *ctxt_buff;
+	struct sge_ctxt_rev1_data *buff;
 	u32 j, size, max_ctx_size, max_ctx_qid;
 	u8 mem_type[CTXT_INGRESS + 1] = { 0 };
 	struct cudbg_buffer temp_buff = { 0 };
-	struct cudbg_ch_cntxt *buff;
+	u8 i, k, sge_ctxt_size;
 	u8 *ctx_buf;
-	u8 i, k;
 	int rc;
 
+	if (CHELSIO_CHIP_VERSION(padap->params.chip) >= CHELSIO_T7)
+		sge_ctxt_size = SGE_CTXT_SIZE_T7;
+	else
+		sge_ctxt_size = SGE_CTXT_SIZE;
+
 	/* Get max valid qid for each type of queue */
-	rc = cudbg_get_ctxt_region_info(padap, region_info, mem_type);
+	rc = cudbg_get_ctxt_region_info(padap, sge_ctxt_size, region_info, mem_type);
 	if (rc)
 		return rc;
 
-	rc = cudbg_dump_context_size(padap);
+	rc = cudbg_dump_context_size(padap, sge_ctxt_size);
 	if (rc <= 0)
 		return CUDBG_STATUS_ENTITY_NOT_FOUND;
 
 	size = rc;
-	rc = cudbg_get_buff(pdbg_init, dbg_buff, size, &temp_buff);
+	rc = cudbg_get_buff(pdbg_init, dbg_buff, size + sizeof(*ctxt_buff), &temp_buff);
 	if (rc)
 		return rc;
+	ctxt_buff = (void *)temp_buff.data;
+	ctxt_buff->ver_hdr.signature = CUDBG_ENTITY_SIGNATURE;
+	ctxt_buff->ver_hdr.revision = CUDBG_SGE_CTXT_REV;
+	ctxt_buff->ver_hdr.size = sizeof(*ctxt_buff) -
+		sizeof(struct cudbg_ver_hdr);
+	ctxt_buff->nentries = 0;
 
 	/* Get buffer with enough space to read the biggest context
 	 * region in memory.
@@ -2429,7 +2998,7 @@ int cudbg_collect_dump_context(struct cudbg_init *pdbg_init,
 		return -ENOMEM;
 	}
 
-	buff = (struct cudbg_ch_cntxt *)temp_buff.data;
+	buff = (struct sge_ctxt_rev1_data *)ctxt_buff->data;
 
 	/* Collect EGRESS and INGRESS context data.
 	 * In case of failures, fallback to collecting via FW or
@@ -2438,13 +3007,13 @@ int cudbg_collect_dump_context(struct cudbg_init *pdbg_init,
 	for (i = CTXT_EGRESS; i <= CTXT_INGRESS; i++) {
 		if (!region_info[i].exist) {
 			max_ctx_qid = CUDBG_LOWMEM_MAX_CTXT_QIDS;
-			cudbg_get_sge_ctxt_fw(pdbg_init, max_ctx_qid, i,
-					      &buff);
+			cudbg_get_sge_ctxt_fw(pdbg_init, sge_ctxt_size, max_ctx_qid, i,
+					      ctxt_buff, &buff);
 			continue;
 		}
 
 		max_ctx_size = region_info[i].end - region_info[i].start + 1;
-		max_ctx_qid = max_ctx_size / SGE_CTXT_SIZE;
+		max_ctx_qid = max_ctx_size / sge_ctxt_size;
 
 		/* If firmware is not attached/alive, use backdoor register
 		 * access to collect dump.
@@ -2459,8 +3028,8 @@ int cudbg_collect_dump_context(struct cudbg_init *pdbg_init,
 
 		if (rc || !is_fw_attached(pdbg_init)) {
 			max_ctx_qid = CUDBG_LOWMEM_MAX_CTXT_QIDS;
-			cudbg_get_sge_ctxt_fw(pdbg_init, max_ctx_qid, i,
-					      &buff);
+			cudbg_get_sge_ctxt_fw(pdbg_init, sge_ctxt_size, max_ctx_qid, i,
+					      ctxt_buff, &buff);
 			continue;
 		}
 
@@ -2468,22 +3037,26 @@ int cudbg_collect_dump_context(struct cudbg_init *pdbg_init,
 			__be64 *dst_off;
 			u64 *src_off;
 
-			src_off = (u64 *)(ctx_buf + j * SGE_CTXT_SIZE);
+			src_off = (u64 *)(ctx_buf + j * sge_ctxt_size);
 			dst_off = (__be64 *)buff->data;
 
 			/* The data is stored in 64-bit cpu order.  Convert it
 			 * to big endian before parsing.
 			 */
-			for (k = 0; k < SGE_CTXT_SIZE / sizeof(u64); k++)
+			for (k = 0; k < sge_ctxt_size / sizeof(u64); k++)
 				dst_off[k] = cpu_to_be64(src_off[k]);
 
 			rc = cudbg_sge_ctxt_check_valid(buff->data, i);
 			if (!rc)
 				continue;
 
-			buff->cntxt_type = i;
-			buff->cntxt_id = j;
-			buff++;
+			buff->ctxt_type = i;
+			buff->ctxt_id = j;
+			buff->size = sge_ctxt_size;
+			ctxt_buff->nentries++;
+			buff = (struct sge_ctxt_rev1_data *)
+				((u8 *)buff +
+				 cudbg_sge_ctxt_entry_size(sge_ctxt_size));
 		}
 	}
 
@@ -2492,11 +3065,11 @@ int cudbg_collect_dump_context(struct cudbg_init *pdbg_init,
 	/* Collect FREELIST and CONGESTION MANAGER contexts */
 	max_ctx_size = region_info[CTXT_FLM].end -
 		       region_info[CTXT_FLM].start + 1;
-	max_ctx_qid = max_ctx_size / SGE_CTXT_SIZE;
+	max_ctx_qid = max_ctx_size / sge_ctxt_size;
 	/* Since FLM and CONM are 1-to-1 mapped, the below function
 	 * will fetch both FLM and CONM contexts.
 	 */
-	cudbg_get_sge_ctxt_fw(pdbg_init, max_ctx_qid, CTXT_FLM, &buff);
+	cudbg_get_sge_ctxt_fw(pdbg_init, sge_ctxt_size, max_ctx_qid, CTXT_FLM, ctxt_buff, &buff);
 
 	return cudbg_write_and_release_buff(pdbg_init, &temp_buff, dbg_buff);
 }
@@ -2544,7 +3117,72 @@ static int cudbg_collect_tcam_index(struct cudbg_init *pdbg_init,
 	u32 ctl, data2;
 	int rc = 0;
 
-	if (CHELSIO_CHIP_VERSION(padap->params.chip) >= CHELSIO_T6) {
+	if (CHELSIO_CHIP_VERSION(padap->params.chip) >= CHELSIO_T7) {
+		/* CtlReqID   - 1: use Host Driver Requester ID
+		 * CtlCmdType - 0: Read, 1: Write
+		 * CtlXYBitSel- 0: Y bit, 1: X bit
+		 ####### for T6 ######
+		 * CtlTcamSel     -   26:25    Control bit. 0: TCAM0, 1: TCAM1.
+		 * CtlTcamIndex   -   24:17    Control bits. Index of TCAM location to be accessed.
+
+		 ####### for T7B ######
+		 * CtlTcamSel     -   27:26    Control bit. 0: TCAM0, 1: TCAM1, 2: TCAM2.
+		 * CtlTcamIndex   -   25:17    Control bits. Index of TCAM location to be accessed.
+		 */
+
+		/* Read tcamy */
+		ctl = (CTLREQID_V(1) | CTLCMDTYPE_V(0) | CTLXYBITSEL_V(0));
+		if (idx < 512)
+			ctl |= T7_1_CTLTCAMINDEX_V(idx) | T7_CTLTCAMSEL_V(0);
+		else if (idx < 1024)
+			ctl |= T7_1_CTLTCAMINDEX_V(idx - 512) |
+				T7_CTLTCAMSEL_V(1);
+		else /* idx 1024 to 1535 */
+			ctl |= T7_1_CTLTCAMINDEX_V(idx - 1024) |
+				T7_CTLTCAMSEL_V(2);
+
+		t4_write_reg(padap, MPS_CLS_TCAM_DATA2_CTL_A, ctl);
+		val = t4_read_reg(padap, MPS_CLS_TCAM0_RDATA1_REQ_ID1_A);
+		tcamy = DMACH_G(val) << 32;
+		tcamy |= t4_read_reg(padap, MPS_CLS_TCAM0_RDATA0_REQ_ID1_A);
+		data2 = t4_read_reg(padap, MPS_CLS_TCAM0_RDATA2_REQ_ID1_A);
+		tcam->lookup_type = DATALKPTYPE_G(data2);
+
+		/* 0 - Outer header, 1 - Inner header
+		 * [71:48] bit locations are overloaded for
+		 * outer vs. inner lookup types.
+		 */
+		if (tcam->lookup_type &&
+		    tcam->lookup_type != DATALKPTYPE_M) {
+			/* Inner header VNI */
+			tcam->vniy =
+				(((data2 & DATAVIDH2_F) | (DATAVIDH1_G(data2)))
+				 << 16) |
+				VIDL_G(val);
+			tcam->dip_hit = data2 & DATADIPHIT_F;
+		} else {
+			tcam->vlan_vld = data2 & DATAVIDH2_F;
+			tcam->ivlan = VIDL_G(val);
+		}
+
+		tcam->port_num = DATAPORTNUM_G(data2);
+
+		/* Read tcamx. Change the control param */
+		ctl |= CTLXYBITSEL_V(1);
+		t4_write_reg(padap, MPS_CLS_TCAM_DATA2_CTL_A, ctl);
+		val = t4_read_reg(padap, MPS_CLS_TCAM0_RDATA1_REQ_ID1_A);
+		tcamx = DMACH_G(val) << 32;
+		tcamx |= t4_read_reg(padap, MPS_CLS_TCAM0_RDATA0_REQ_ID1_A);
+		data2 = t4_read_reg(padap, MPS_CLS_TCAM0_RDATA2_REQ_ID1_A);
+		if (tcam->lookup_type &&
+		    tcam->lookup_type != DATALKPTYPE_M) {
+			/* Inner header VNI mask */
+			tcam->vnix =
+				(((data2 & DATAVIDH2_F) | (DATAVIDH1_G(data2)))
+				 << 16) |
+				VIDL_G(val);
+		}
+	} else if (CHELSIO_CHIP_VERSION(padap->params.chip) > CHELSIO_T5) {
 		/* CtlReqID   - 1: use Host Driver Requester ID
 		 * CtlCmdType - 0: Read, 1: Write
 		 * CtlTcamSel - 0: TCAM0, 1: TCAM1
@@ -2602,13 +3240,24 @@ static int cudbg_collect_tcam_index(struct cudbg_init *pdbg_init,
 	if (tcamx & tcamy)
 		return rc;
 
-	tcam->cls_lo = t4_read_reg(padap, MPS_CLS_SRAM_L(idx));
-	tcam->cls_hi = t4_read_reg(padap, MPS_CLS_SRAM_H(idx));
+	/* t7b changes MPS_T5_CLS_SRAM_H_A to indirect register */
+	if (is_t7(padap->params.chip)) {
+		u32 tmp_ctl = 0;
 
-	if (is_t5(padap->params.chip))
-		tcam->repli = (tcam->cls_lo & REPLICATE_F);
-	else if (is_t6(padap->params.chip))
+		tmp_ctl |= SRAMWRN_V(0) |
+			SRAMINDEX_V(idx & SRAMINDEX_M);
+		t4_write_reg(padap, MPS_T5_CLS_SRAM_H_A, tmp_ctl);
+		tcam->cls_lo = t4_read_reg(padap, MPS_T5_CLS_SRAM_L_A);
+		tcam->cls_hi = t4_read_reg(padap, MPS_T5_CLS_SRAM_H_A);
+	} else {
+		tcam->cls_lo = t4_read_reg(padap, MPS_CLS_SRAM_L(idx));
+		tcam->cls_hi = t4_read_reg(padap, MPS_CLS_SRAM_H(idx));
+	}
+
+	if (CHELSIO_CHIP_VERSION(padap->params.chip) > CHELSIO_T5)
 		tcam->repli = (tcam->cls_lo & T6_REPLICATE_F);
+	else
+		tcam->repli = (tcam->cls_lo & REPLICATE_F);
 
 	if (tcam->repli) {
 		struct fw_ldst_cmd ldst_cmd;
@@ -2966,20 +3615,62 @@ int cudbg_collect_ma_indirect(struct cudbg_init *pdbg_init,
 {
 	struct adapter *padap = pdbg_init->adap;
 	struct cudbg_buffer temp_buff = { 0 };
-	struct ireg_buf *ma_indr;
-	int i, rc, n;
-	u32 size, j;
+	int i, j, rc, n;
+	u32 size;
 
 	if (CHELSIO_CHIP_VERSION(padap->params.chip) < CHELSIO_T6)
 		return CUDBG_STATUS_ENTITY_NOT_FOUND;
 
+	if (CHELSIO_CHIP_VERSION(padap->params.chip) >= CHELSIO_T7) {
+		/* T7 path - new indirect reg framework */
+		const struct cudbg_indir_type_entry *ma_arr, *ma_perf_arr;
+		u32 chip_ver;
+
+		chip_ver = CHELSIO_CHIP_VERSION(padap->params.chip);
+		ma_arr = cudbg_get_indir_reg_info(chip_ver,
+						  CUDBG_INDIR_TYPE_MA_LOCAL_DEBUG_CFG);
+		ma_perf_arr = cudbg_get_indir_reg_info(chip_ver,
+						       CUDBG_INDIR_TYPE_MA_LOCAL_DEBUG_PERF_CFG);
+
+		if (!ma_arr)
+			return CUDBG_STATUS_ENTITY_NOT_FOUND;
+
+		size = sizeof(struct cudbg_indir_reg_entity) +
+			sizeof(struct cudbg_indir_reg_data) * ma_arr->nentries;
+
+		if (ma_perf_arr)
+			size += sizeof(struct cudbg_indir_reg_entity) +
+				sizeof(struct cudbg_indir_reg_data) *
+				ma_perf_arr->nentries;
+
+		rc = cudbg_get_buff(pdbg_init, dbg_buff, size, &temp_buff);
+		if (rc)
+			return rc;
+
+		cudbg_collect_indir_reg(padap, (void *)temp_buff.data,
+					ma_arr, CUDBG_MA_INDIR_REG_REV,
+					MA_LOCAL_DEBUG_CFG_A,
+					MA_LOCAL_DEBUG_CFG_A + 4);
+
+		if (ma_perf_arr)
+			cudbg_collect_indir_reg_next(padap, (void *)temp_buff.data, ma_perf_arr,
+						     CUDBG_MA_INDIR_REG_REV,
+						     MA_LOCAL_DEBUG_PERF_CFG_A,
+						     MA_LOCAL_DEBUG_PERF_CFG_A + 4);
+
+		return cudbg_write_and_release_buff(pdbg_init, &temp_buff,
+						    dbg_buff);
+	}
+
+	/* T6 path */
 	n = sizeof(t6_ma_ireg_array) / (IREG_NUM_ELEM * sizeof(u32));
 	size = sizeof(struct ireg_buf) * n * 2;
+
 	rc = cudbg_get_buff(pdbg_init, dbg_buff, size, &temp_buff);
 	if (rc)
 		return rc;
 
-	ma_indr = (struct ireg_buf *)temp_buff.data;
+	struct ireg_buf *ma_indr = (struct ireg_buf *)temp_buff.data;
 	for (i = 0; i < n; i++) {
 		struct ireg_field *ma_fli = &ma_indr->tp_pio;
 		u32 *buff = ma_indr->outbuf;
@@ -3094,9 +3785,67 @@ int cudbg_collect_up_cim_indirect(struct cudbg_init *pdbg_init,
 	else if (is_t6(padap->params.chip))
 		n = sizeof(t6_up_cim_reg_array) /
 		    ((IREG_NUM_ELEM + 1) * sizeof(u32));
-	else
+	else if (CHELSIO_CHIP_VERSION(padap->params.chip) >= CHELSIO_T7) {
+		/* T7 path - new indirect reg framework */
+		const struct cudbg_indir_type_entry *cim_arr, *up_arr;
+		struct cudbg_indir_reg_entity *cim_entity, *up_entity;
+		struct cudbg_indir_reg_data *reg_data;
+		u8 coreid = 0, groupid = 0;
+		u32 chip_ver;
+
+		chip_ver = CHELSIO_CHIP_VERSION(padap->params.chip);
+		cim_arr = cudbg_get_indir_reg_info(chip_ver, CUDBG_INDIR_TYPE_CIM_CTL);
+		up_arr = cudbg_get_indir_reg_info(chip_ver, CUDBG_INDIR_TYPE_UP);
+
+		if (!cim_arr || !up_arr)
+			return CUDBG_STATUS_ENTITY_NOT_FOUND;
+
+		if (pdbg_init->dbg_params[CUDBG_UP_COREID_PARAM].param_type ==
+				CUDBG_UP_COREID_PARAM)
+			coreid = pdbg_init->dbg_params[CUDBG_UP_COREID_PARAM].u.coreid;
+
+		size = sizeof(*cim_entity) + sizeof(*up_entity) +
+		       sizeof(*reg_data) * (cim_arr->nentries + up_arr->nentries);
+
+		rc = cudbg_get_buff(pdbg_init, dbg_buff, size, &temp_buff);
+		if (rc)
+			return rc;
+
+		cim_entity = cudbg_collect_indir_reg_init((void *)temp_buff.data,
+							  CUDBG_UP_CIM_INDIR_REG_REV,
+							  CIM_HOST_ACC_CTRL_A,
+							  CIM_HOST_ACC_DATA_A,
+							  cim_arr->nentries);
+
+		up_entity = cudbg_collect_indir_reg_init_next(cim_entity,
+							      CUDBG_UP_CIM_INDIR_REG_REV,
+							      CIM_HOST_ACC_CTRL_A,
+							      CIM_HOST_ACC_DATA_A,
+							      up_arr->nentries);
+
+		reg_data = cim_entity->data;
+		for (i = 0; i < cim_entity->nentries; i++, reg_data++) {
+			reg_data->offset = cim_arr->reg_arr[i].addr;
+			t4_cim_read_core(padap, groupid, coreid,
+					 reg_data->offset, 1, &reg_data->data);
+		}
+
+		groupid = 1; /* T7 UP uses groupid 1 */
+
+		reg_data = up_entity->data;
+		for (i = 0; i < up_entity->nentries; i++, reg_data++) {
+			reg_data->offset = up_arr->reg_arr[i].addr;
+			t4_cim_read_core(padap, groupid, coreid,
+					 reg_data->offset, 1, &reg_data->data);
+		}
+
+		return cudbg_write_and_release_buff(pdbg_init, &temp_buff,
+						    dbg_buff);
+	} else {
 		return CUDBG_STATUS_NOT_IMPLEMENTED;
+	}
 
+	/* T5/T6 path */
 	size = sizeof(struct ireg_buf) * n;
 	rc = cudbg_get_buff(pdbg_init, dbg_buff, size, &temp_buff);
 	if (rc)
@@ -3275,20 +4024,47 @@ int cudbg_collect_hma_indirect(struct cudbg_init *pdbg_init,
 {
 	struct adapter *padap = pdbg_init->adap;
 	struct cudbg_buffer temp_buff = { 0 };
-	struct ireg_buf *hma_indr;
 	int i, rc, n;
 	u32 size;
 
 	if (CHELSIO_CHIP_VERSION(padap->params.chip) < CHELSIO_T6)
 		return CUDBG_STATUS_ENTITY_NOT_FOUND;
 
+	if (CHELSIO_CHIP_VERSION(padap->params.chip) >= CHELSIO_T7) {
+		/* T7 path - new indirect reg framework */
+		const struct cudbg_indir_type_entry *hma_arr;
+		u32 chip_ver;
+
+		chip_ver = CHELSIO_CHIP_VERSION(padap->params.chip);
+		hma_arr = cudbg_get_indir_reg_info(chip_ver,
+						   CUDBG_INDIR_TYPE_HMAT6_LOCAL_DEBUG_CFG);
+		if (!hma_arr)
+			return CUDBG_STATUS_ENTITY_NOT_FOUND;
+
+		size = sizeof(struct cudbg_indir_reg_entity) +
+		       sizeof(struct cudbg_indir_reg_data) * hma_arr->nentries;
+
+		rc = cudbg_get_buff(pdbg_init, dbg_buff, size, &temp_buff);
+		if (rc)
+			return rc;
+
+		cudbg_collect_indir_reg(padap, (void *)temp_buff.data,
+					hma_arr, CUDBG_HMA_INDIR_REG_REV,
+					HMA_LOCAL_DEBUG_CFG_A,
+					HMA_LOCAL_DEBUG_CFG_A + 4);
+
+		return cudbg_write_and_release_buff(pdbg_init, &temp_buff,
+						    dbg_buff);
+	}
+
+	/* T6 path */
 	n = sizeof(t6_hma_ireg_array) / (IREG_NUM_ELEM * sizeof(u32));
 	size = sizeof(struct ireg_buf) * n;
 	rc = cudbg_get_buff(pdbg_init, dbg_buff, size, &temp_buff);
 	if (rc)
 		return rc;
 
-	hma_indr = (struct ireg_buf *)temp_buff.data;
+	struct ireg_buf *hma_indr = (struct ireg_buf *)temp_buff.data;
 	for (i = 0; i < n; i++) {
 		struct ireg_field *hma_fli = &hma_indr->tp_pio;
 		u32 *buff = hma_indr->outbuf;
@@ -3581,7 +4357,7 @@ int cudbg_collect_flash(struct cudbg_init *pdbg_init,
 	u32 addr, i;
 	int rc;
 
-	addr = FLASH_EXP_ROM_START;
+	addr = FLASH_LOC_EXP_ROM;
 
 	for (i = 0; i < count; i += SF_PAGE_SIZE) {
 		n = min_t(u32, count - i, SF_PAGE_SIZE);
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.h b/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.h
index d6d6cd298930..d92a445bf3b5 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.h
@@ -30,10 +30,10 @@ int cudbg_collect_cim_ibq_tp1(struct cudbg_init *pdbg_init,
 int cudbg_collect_cim_ibq_ulp(struct cudbg_init *pdbg_init,
 			      struct cudbg_buffer *dbg_buff,
 			      struct cudbg_error *cudbg_err);
-int cudbg_collect_cim_ibq_sge0(struct cudbg_init *pdbg_init,
-			       struct cudbg_buffer *dbg_buff,
-			       struct cudbg_error *cudbg_err);
-int cudbg_collect_cim_ibq_sge1(struct cudbg_init *pdbg_init,
+int cudbg_collect_cim_ibq_sge(struct cudbg_init *pdbg_init,
+			      struct cudbg_buffer *dbg_buff,
+			      struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_ibq_pcie(struct cudbg_init *pdbg_init,
 			       struct cudbg_buffer *dbg_buff,
 			       struct cudbg_error *cudbg_err);
 int cudbg_collect_cim_ibq_ncsi(struct cudbg_init *pdbg_init,
@@ -165,13 +165,61 @@ int cudbg_collect_qdesc(struct cudbg_init *pdbg_init,
 int cudbg_collect_flash(struct cudbg_init *pdbg_init,
 			struct cudbg_buffer *dbg_buff,
 			struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_ibq_tp2(struct cudbg_init *pdbg_init,
+			      struct cudbg_buffer *dbg_buff,
+			      struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_ibq_tp3(struct cudbg_init *pdbg_init,
+			      struct cudbg_buffer *dbg_buff,
+			      struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_ibq_ipc1(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_ibq_ipc2(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_ibq_ipc3(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_ibq_ipc4(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_ibq_ipc5(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_ibq_ipc6(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_ibq_ipc7(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_obq_ipc1(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_obq_ipc2(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_obq_ipc3(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_obq_ipc4(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_obq_ipc5(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_obq_ipc6(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_obq_ipc7(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err);
 
 u32 cudbg_get_entity_length(struct adapter *adap, u32 entity);
 struct cudbg_entity_hdr *cudbg_get_entity_hdr(void *outbuf, int i);
 void cudbg_align_debug_buffer(struct cudbg_buffer *dbg_buff,
 			      struct cudbg_entity_hdr *entity_hdr);
-u32 cudbg_cim_obq_size(struct adapter *padap, int qid);
-int cudbg_dump_context_size(struct adapter *padap);
+u32 cudbg_cim_obq_size(struct adapter *padap, int qid, u8 coreid);
+int cudbg_dump_context_size(struct adapter *padap, u8 sge_ctxt_size);
 
 int cudbg_fill_meminfo(struct adapter *padap,
 		       struct cudbg_meminfo *meminfo_buff);
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
index 8409e759f5ae..bf47aecc4bb3 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
@@ -1857,7 +1857,6 @@ void t4_setup_memwin(struct adapter *adap, u32 memwin_base, u32 window);
 
 int t4_memory_rw_init(struct adapter *adap, int win, int mtype, u32 *mem_off,
 		      u32 *mem_base, u32 *mem_aperture);
-void t4_memory_update_win(struct adapter *adap, int win, u32 addr);
 void t4_memory_rw_residual(struct adapter *adap, u32 off, u32 addr, u8 *buf,
 			   int dir);
 #define T4_MEMORY_WRITE	0
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c
index dd66b244466d..f2b98f1b4d61 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c
@@ -27,8 +27,8 @@ static const struct cxgb4_collect_entity cxgb4_collect_hw_dump[] = {
 	{ CUDBG_CIM_IBQ_TP0, cudbg_collect_cim_ibq_tp0 },
 	{ CUDBG_CIM_IBQ_TP1, cudbg_collect_cim_ibq_tp1 },
 	{ CUDBG_CIM_IBQ_ULP, cudbg_collect_cim_ibq_ulp },
-	{ CUDBG_CIM_IBQ_SGE0, cudbg_collect_cim_ibq_sge0 },
-	{ CUDBG_CIM_IBQ_SGE1, cudbg_collect_cim_ibq_sge1 },
+	{ CUDBG_CIM_IBQ_SGE, cudbg_collect_cim_ibq_sge },
+	{ CUDBG_CIM_IBQ_PCIE, cudbg_collect_cim_ibq_pcie },
 	{ CUDBG_CIM_IBQ_NCSI, cudbg_collect_cim_ibq_ncsi },
 	{ CUDBG_CIM_OBQ_ULP0, cudbg_collect_cim_obq_ulp0 },
 	{ CUDBG_CIM_OBQ_ULP1, cudbg_collect_cim_obq_ulp1 },
@@ -64,6 +64,22 @@ static const struct cxgb4_collect_entity cxgb4_collect_hw_dump[] = {
 	{ CUDBG_UP_CIM_INDIRECT, cudbg_collect_up_cim_indirect },
 	{ CUDBG_PBT_TABLE, cudbg_collect_pbt_tables },
 	{ CUDBG_HMA_INDIRECT, cudbg_collect_hma_indirect },
+	{ CUDBG_CIM_IBQ_TP2, cudbg_collect_cim_ibq_tp2 },
+	{ CUDBG_CIM_IBQ_TP3, cudbg_collect_cim_ibq_tp3 },
+	{ CUDBG_CIM_IBQ_IPC1, cudbg_collect_cim_ibq_ipc1 },
+	{ CUDBG_CIM_IBQ_IPC2, cudbg_collect_cim_ibq_ipc2 },
+	{ CUDBG_CIM_IBQ_IPC3, cudbg_collect_cim_ibq_ipc3 },
+	{ CUDBG_CIM_IBQ_IPC4, cudbg_collect_cim_ibq_ipc4 },
+	{ CUDBG_CIM_IBQ_IPC5, cudbg_collect_cim_ibq_ipc5 },
+	{ CUDBG_CIM_IBQ_IPC6, cudbg_collect_cim_ibq_ipc6 },
+	{ CUDBG_CIM_IBQ_IPC7, cudbg_collect_cim_ibq_ipc7 },
+	{ CUDBG_CIM_OBQ_IPC1, cudbg_collect_cim_obq_ipc1 },
+	{ CUDBG_CIM_OBQ_IPC2, cudbg_collect_cim_obq_ipc2 },
+	{ CUDBG_CIM_OBQ_IPC3, cudbg_collect_cim_obq_ipc3 },
+	{ CUDBG_CIM_OBQ_IPC4, cudbg_collect_cim_obq_ipc4 },
+	{ CUDBG_CIM_OBQ_IPC5, cudbg_collect_cim_obq_ipc5 },
+	{ CUDBG_CIM_OBQ_IPC6, cudbg_collect_cim_obq_ipc6 },
+	{ CUDBG_CIM_OBQ_IPC7, cudbg_collect_cim_obq_ipc7 },
 };
 
 static const struct cxgb4_collect_entity cxgb4_collect_flash_dump[] = {
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index be4c8cbbad95..a3b1f9db5cbe 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -3097,6 +3097,247 @@ static int cxgb_hwtstamp_set(struct net_device *dev,
 	return 0;
 }
 
+enum {
+	CUDBG_SETREG        = 1024,
+	CUDBG_GETREG        = 1025,
+	CUDBG_GET_SGE_CTXT  = 1059,
+	CUDBG_GET_SGE_DESC2 = 1060,
+};
+
+enum {
+	CUDBG_CNTXT_TYPE_EGRESS  = 0,
+	CUDBG_CNTXT_TYPE_FL      = 1,
+	CUDBG_CNTXT_TYPE_RSP     = 2,
+	CUDBG_CNTXT_TYPE_CQ      = 3,
+	CUDBG_CNTXT_TYPE_CONG    = 4,
+};
+
+enum {
+	CUDBG_SGE_QTYPE_TX_ETH    = 1,
+	CUDBG_SGE_QTYPE_TX_OFLD   = 2,
+	CUDBG_SGE_QTYPE_TX_CTRL   = 3,
+	CUDBG_SGE_QTYPE_FL        = 4,
+	CUDBG_SGE_QTYPE_RSP       = 5,
+	CUDBG_SGE_QTYPE_TX_CRYPTO = 6,
+};
+
+struct cudbg_reg {
+	u32 cmd;
+	u32 addr;
+	u32 val;
+};
+
+struct cudbg_mem_range {
+	u32 cmd;
+	u32 mem_id;
+	u32 addr;
+	u32 len;
+	u32 version;
+	u8  buf[];
+};
+
+static int cudbg_get_qdesc(struct adapter *adap, int qtype,
+			   unsigned int qid, unsigned int idx,
+			   unsigned char *data)
+{
+	struct sge *p = &adap->sge;
+	int i, len = sizeof(struct tx_desc);
+
+	if (qtype == CUDBG_SGE_QTYPE_TX_ETH) {
+		const struct sge_eth_txq *q = p->ethtxq;
+
+		for (i = 0; i < ARRAY_SIZE(p->ethtxq); i++, q++)
+			if (q->q.cntxt_id == qid && q->q.desc &&
+			    idx < q->q.size) {
+				memcpy(data, &q->q.desc[idx], len);
+				return len;
+			}
+	}
+
+	if (qtype == CUDBG_SGE_QTYPE_TX_CTRL) {
+		const struct sge_ctrl_txq *q = p->ctrlq;
+
+		for (i = 0; i < ARRAY_SIZE(p->ctrlq); i++, q++)
+			if (q->q.cntxt_id == qid && q->q.desc &&
+			    idx < q->q.size) {
+				memcpy(data, &q->q.desc[idx], len);
+				return len;
+			}
+	}
+
+	if (qtype == CUDBG_SGE_QTYPE_TX_OFLD ||
+	    qtype == CUDBG_SGE_QTYPE_TX_CRYPTO) {
+		struct sge_uld_txq_info *utxq_info;
+		unsigned int uld_type;
+		int i;
+
+		uld_type = (qtype == CUDBG_SGE_QTYPE_TX_OFLD) ?
+			    CXGB4_TX_OFLD : CXGB4_TX_CRYPTO;
+
+		utxq_info = adap->sge.uld_txq_info[uld_type];
+		if (!utxq_info)
+			return -EINVAL;
+
+		for (i = 0; i < utxq_info->ntxq; i++) {
+			const struct sge_uld_txq *q = &utxq_info->uldtxq[i];
+
+			if (q->q.cntxt_id == qid && q->q.desc &&
+			    idx < q->q.size) {
+				memcpy(data, &q->q.desc[idx], len);
+				return len;
+			}
+		}
+	}
+
+	if (qtype == CUDBG_SGE_QTYPE_FL) {
+		const struct sge_fl *q = NULL;
+
+		if (qid >= p->egr_start &&
+		    qid < p->egr_start + p->egr_sz)
+			q = p->egr_map[qid - p->egr_start];
+		if (q && idx < q->size) {
+			*(__be64 *)data = q->desc[idx];
+			return sizeof(u64);
+		}
+	}
+
+	if (qtype == CUDBG_SGE_QTYPE_RSP) {
+		const struct sge_rspq *q = NULL;
+
+		if (qid >= p->ingr_start &&
+		    qid < p->ingr_start + p->ingr_sz)
+			q = p->ingr_map[qid - p->ingr_start];
+		if (q && idx < q->size) {
+			len = q->iqe_len;
+			idx *= len / sizeof(u64);
+			memcpy(data, &q->desc[idx], len);
+			return len;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int cxgb_extension_ioctl(struct net_device *dev,
+				void __user *useraddr)
+{
+	struct adapter *adap = netdev2adap(dev);
+	u32 cmd;
+	int ret = 0;
+
+	if (!ns_capable(dev_net(dev)->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
+	if (copy_from_user(&cmd, useraddr, sizeof(cmd)))
+		return -EFAULT;
+
+	switch (cmd) {
+	case CUDBG_GETREG: {
+		struct cudbg_reg edata;
+
+		if (copy_from_user(&edata, useraddr, sizeof(edata)))
+			return -EFAULT;
+		if ((edata.addr & 3) != 0 ||
+		    edata.addr >= t4_get_regs_len(adap))
+			return -EINVAL;
+		edata.val = t4_read_reg(adap, edata.addr);
+		if (copy_to_user(useraddr, &edata, sizeof(edata)))
+			return -EFAULT;
+		break;
+	}
+	case CUDBG_SETREG: {
+		struct cudbg_reg edata;
+
+		if (copy_from_user(&edata, useraddr, sizeof(edata)))
+			return -EFAULT;
+		if ((edata.addr & 3) != 0 ||
+		    edata.addr >= t4_get_regs_len(adap))
+			return -EINVAL;
+		t4_write_reg(adap, edata.addr, edata.val);
+		break;
+	}
+	case CUDBG_GET_SGE_CTXT: {
+		u32 buf[SGE_CTXT_SIZE_T7 / 4];
+		u8 size = SGE_CTXT_SIZE;
+		struct cudbg_mem_range t;
+		enum ctxt_type ctype;
+
+		if (copy_from_user(&t, useraddr, sizeof(t)))
+			return -EFAULT;
+		if (t.len < SGE_CTXT_SIZE || t.addr > CTXTQID_M)
+			return -EINVAL;
+		if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7) {
+			if (t.len < SGE_CTXT_SIZE_T7)
+				return -EINVAL;
+			size = SGE_CTXT_SIZE_T7;
+		}
+
+		switch (t.mem_id) {
+		case CUDBG_CNTXT_TYPE_EGRESS:
+			ctype = CTXT_EGRESS;
+			break;
+		case CUDBG_CNTXT_TYPE_FL:
+			ctype = CTXT_FLM;
+			break;
+		case CUDBG_CNTXT_TYPE_RSP:
+		case CUDBG_CNTXT_TYPE_CQ:
+			ctype = CTXT_INGRESS;
+			break;
+		case CUDBG_CNTXT_TYPE_CONG:
+			ctype = CTXT_CNM;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		if ((adap->flags & CXGB4_FW_OK) && !adap->use_bd)
+			ret = t4_sge_ctxt_rd(adap, adap->mbox,
+					     t.addr, ctype, buf);
+		else
+			ret = t4_sge_ctxt_rd_bd(adap, t.addr, ctype, buf);
+		if (ret)
+			return ret;
+
+		t.version = mk_adap_vers(adap);
+		if (copy_to_user(useraddr + sizeof(t), buf, size) ||
+		    copy_to_user(useraddr, &t, sizeof(t)))
+			return -EFAULT;
+		break;
+	}
+	case CUDBG_GET_SGE_DESC2: {
+		unsigned char buf[128];
+		struct cudbg_mem_range edesc;
+
+		if (copy_from_user(&edesc, useraddr, sizeof(edesc)))
+			return -EFAULT;
+		/* upper 8 bits of mem_id = queue type, lower 24 = qid */
+		ret = cudbg_get_qdesc(adap,
+				      edesc.mem_id >> 24,
+				      edesc.mem_id & 0xffffff,
+				      edesc.addr, buf);
+		if (ret < 0)
+			return ret;
+		if (edesc.len < ret)
+			return -EINVAL;
+		edesc.len = ret;
+		edesc.version = mk_adap_vers(adap);
+		if (copy_to_user(useraddr + sizeof(edesc), buf, edesc.len) ||
+		    copy_to_user(useraddr, &edesc, sizeof(edesc)))
+			return -EFAULT;
+		break;
+	}
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static int cxgb_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
+			       void __user *data, int cmd)
+{
+	return cxgb_extension_ioctl(dev, data);
+}
+
 static int cxgb_ioctl(struct net_device *dev, struct ifreq *req, int cmd)
 {
 	unsigned int mbox;
@@ -3866,6 +4107,7 @@ static const struct net_device_ops cxgb4_netdev_ops = {
 	.ndo_set_features     = cxgb_set_features,
 	.ndo_validate_addr    = eth_validate_addr,
 	.ndo_eth_ioctl        = cxgb_ioctl,
+	.ndo_siocdevprivate   = cxgb_siocdevprivate,
 	.ndo_change_mtu       = cxgb_change_mtu,
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller  = cxgb_netpoll,
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
index 04550a362504..742d417d2e4f 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -580,26 +580,6 @@ int t4_memory_rw_init(struct adapter *adap, int win, int mtype, u32 *mem_off,
 	return 0;
 }
 
-/**
- * t4_memory_update_win - Move memory window to specified address.
- * @adap: the adapter
- * @win: PCI-E Memory Window to use
- * @addr: location to move.
- *
- * Move memory window to specified address.
- */
-void t4_memory_update_win(struct adapter *adap, int win, u32 addr)
-{
-	t4_write_reg(adap,
-		     PCIE_MEM_ACCESS_REG(PCIE_MEM_ACCESS_OFFSET_A, win),
-		     addr);
-	/* Read it back to ensure that changes propagate before we
-	 * attempt to use the new value.
-	 */
-	t4_read_reg(adap,
-		    PCIE_MEM_ACCESS_REG(PCIE_MEM_ACCESS_OFFSET_A, win));
-}
-
 /**
  * t4_memory_rw_residual - Read/Write residual data.
  * @adap: the adapter
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.h b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.h
index 13c56fedfc5c..6f45f68e4299 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.h
@@ -80,6 +80,7 @@ enum ctxt_type {
 	CTXT_INGRESS,
 	CTXT_FLM,
 	CTXT_CNM,
+	CTXT_MAX,
 };
 
 enum {
-- 
2.39.1

