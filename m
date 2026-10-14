Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128EA3CB2FA
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 12:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791981705; cv=none; b=P9nK6AiYUEZpDOI/+BulZHrMKsTKPD1ow5gG6cJ+hm+em8JKUsLE93Cm+BCncrcKf4zAL4+3TYtnxb7yv9H3fyGvrPj8GKnABiSeVEtUKegXOGLRIVzMsN/pvOt4VBu9tCbeU244/Rf3C8CMLuzpROv8IQt/EnRN7vTMcsis1yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791981705; c=relaxed/simple;
	bh=uDtuQrLVwyVg5D8eVsQAOs7YM9sqsi6Xh4FE4AUBgdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jY0aXmW8YPJtOt8l3F98Z0uizccACxUqwheYcQOS8DmaG9M88E/53JqhCFTVa29caq1iPYRR8u6VA6V21MPfdoggybK3D5LK3uctyvlNLPN37sOYKMuDRdaMhBylQvyMtpf4g303k0drfAHixx1//pJCV+Cg6EQFH16ZEPkks4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from mehrangarh-blr-asicdesigners-com.asicdesigners.com (mehrangarh.blr.asicdesigners.com [10.193.185.169])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 69ECeqZ5018414;
	Wed, 14 Oct 2026 05:41:27 -0700
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, bharat@chelsio.com
Subject: [PATCH net-next v4 11/12] cxgb4: extend debugfs support for T7 adapters
Date: Wed, 14 Oct 2026 18:12:56 -0400
Message-Id: <20261014221257.436789-12-bharat@chelsio.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20261014221257.436789-1-bharat@chelsio.com>
References: <20261014221257.436789-1-bharat@chelsio.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the debugfs infrastructure to support T7-specific debug data and
multicore adapter architectures.

Add support for collecting and displaying debug information from
individual CIM cores, including CIM logic analyzer data, queue
configuration, and queue state information. Update debugfs handlers to
use the multicore-aware access mechanisms required by T7 devices.

Also extend debugfs support for T7-specific CIM IBQ and OBQ layouts,
per-core device logs, and related debug entities.

Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c |   10 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    |    8 -
 .../ethernet/chelsio/cxgb4/cxgb4_debugfs.c    | 1029 ++++++++++++-----
 .../ethernet/chelsio/cxgb4/cxgb4_debugfs.h    |   17 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |    2 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c    |   64 +-
 6 files changed, 787 insertions(+), 343 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c b/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c
index 6954c15d2b82..7c13bc984883 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c
@@ -17,6 +17,7 @@
 #include <net/addrconf.h>
 #include "cxgb4.h"
 #include "clip_tbl.h"
+#include "cxgb4_debugfs.h"
 
 static inline unsigned int ipv4_clip_hash(struct clip_tbl *c, const u32 *key)
 {
@@ -249,12 +250,17 @@ EXPORT_SYMBOL(cxgb4_update_root_dev_clip);
 
 int clip_tbl_show(struct seq_file *seq, void *v)
 {
-	struct adapter *adapter = seq->private;
-	struct clip_tbl *ctbl = adapter->clipt;
+	struct t4_linux_debugfs_data *d = seq->private;
+	struct adapter *adapter = d->adap;
+	struct clip_tbl *ctbl;
 	struct clip_entry *ce;
 	char ip[60];
 	int i;
 
+	ctbl = adapter->clipt;
+	if (!ctbl)
+		return 0;
+
 	read_lock_bh(&ctbl->lock);
 
 	seq_puts(seq, "IP Address                  Users\n");
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
index bf47aecc4bb3..e6250e031609 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
@@ -455,7 +455,6 @@ struct adapter_params {
 	struct vpd_params vpd;
 	struct pf_resources pfres;
 	struct pci_params pci;
-	struct devlog_params devlogs;
 	struct devlog_params devlog[MAX_UP_CORES];
 	enum pcie_memwin drv_memwin;
 
@@ -1957,12 +1956,8 @@ u8 t4_cim_num_ibq(struct adapter *adap);
 u8 t4_cim_num_obq(struct adapter *adap);
 void t4_read_cimq_cfg_core(struct adapter *adap, u8 coreid, u16 *base,
 			   u16 *size, u16 *thres);
-int t4_read_cim_ibq(struct adapter *adap, unsigned int qid, u32 *data,
-		    size_t n);
 int t4_read_cim_obq_core(struct adapter *adap, u8 coreid, u32 qid, u32 *data,
 			 size_t n);
-int t4_read_cim_obq(struct adapter *adap, unsigned int qid, u32 *data,
-		    size_t n);
 int t4_cim_read_core(struct adapter *adap, u8 group, u8 coreid,
 		     unsigned int addr, unsigned int n, unsigned int *valp);
 int t4_cim_read(struct adapter *adap, unsigned int addr, unsigned int n,
@@ -1970,11 +1965,8 @@ int t4_cim_read(struct adapter *adap, unsigned int addr, unsigned int n,
 int t4_cim_write_core(struct adapter *adap, u8 group, u8 coreid,
 		      unsigned int addr, unsigned int n,
 		      const unsigned int *valp);
-int t4_cim_write(struct adapter *adap, unsigned int addr, unsigned int n,
-		 const unsigned int *valp);
 int t4_cim_read_la_core(struct adapter *adap, u8 coreid, u32 *la_buf,
 			u32 *wrptr);
-int t4_cim_read_la(struct adapter *adap, u32 *la_buf, unsigned int *wrptr);
 void t4_cim_read_pif_la(struct adapter *adap, u32 *pif_req, u32 *pif_rsp,
 			unsigned int *pif_req_wrptr,
 			unsigned int *pif_rsp_wrptr);
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
index e0b4b04d4aac..9f4595e992d3 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
@@ -196,21 +196,22 @@ static int cim_la_show_pc_t6(struct seq_file *seq, void *v, int idx)
 
 static int cim_la_open(struct inode *inode, struct file *file)
 {
-	int ret;
-	unsigned int cfg;
+	struct t4_linux_debugfs_data *d = inode->i_private;
+	struct adapter *adap = d->adap;
+	u8 coreid = d->coreid;
 	struct seq_tab *p;
-	struct adapter *adap = inode->i_private;
+	unsigned int cfg;
+	int ret;
 
-	ret = t4_cim_read(adap, UP_UP_DBG_LA_CFG_A, 1, &cfg);
+	ret = t4_cim_read_core(adap, 1, coreid, UP_UP_DBG_LA_CFG_A, 1, &cfg);
 	if (ret)
 		return ret;
 
-	if (is_t6(adap->params.chip)) {
-		/* +1 to account for integer division of CIMLA_SIZE/10 */
-		p = seq_open_tab(file, (adap->params.cim_la_size / 10) + 1,
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T6) {
+		p = seq_open_tab(file, adap->params.cim_la_size / 10,
 				 10 * sizeof(u32), 1,
 				 cfg & UPDBGLACAPTPCONLY_F ?
-					cim_la_show_pc_t6 : cim_la_show_t6);
+				 cim_la_show_pc_t6 : cim_la_show_t6);
 	} else {
 		p = seq_open_tab(file, adap->params.cim_la_size / 8,
 				 8 * sizeof(u32), 1,
@@ -220,7 +221,7 @@ static int cim_la_open(struct inode *inode, struct file *file)
 	if (!p)
 		return -ENOMEM;
 
-	ret = t4_cim_read_la(adap, (u32 *)p->data, NULL);
+	ret = t4_cim_read_la_core(adap, coreid, (u32 *)p->data, NULL);
 	if (ret)
 		seq_release_private(inode, file);
 	return ret;
@@ -256,8 +257,9 @@ static int cim_pif_la_show(struct seq_file *seq, void *v, int idx)
 
 static int cim_pif_la_open(struct inode *inode, struct file *file)
 {
+	struct t4_linux_debugfs_data *d = inode->i_private;
+	struct adapter *adap = d->adap;
 	struct seq_tab *p;
-	struct adapter *adap = inode->i_private;
 
 	p = seq_open_tab(file, 2 * CIM_PIFLA_SIZE, 6 * sizeof(u32), 1,
 			 cim_pif_la_show);
@@ -302,8 +304,9 @@ static int cim_ma_la_show(struct seq_file *seq, void *v, int idx)
 
 static int cim_ma_la_open(struct inode *inode, struct file *file)
 {
+	struct t4_linux_debugfs_data *d = inode->i_private;
+	struct adapter *adap = d->adap;
 	struct seq_tab *p;
-	struct adapter *adap = inode->i_private;
 
 	p = seq_open_tab(file, 2 * CIM_MALA_SIZE, 5 * sizeof(u32), 1,
 			 cim_ma_la_show);
@@ -323,8 +326,112 @@ static const struct file_operations cim_ma_la_fops = {
 	.release = seq_release_private
 };
 
+static int cim_qcfg_show_t7(struct seq_file *seq, struct adapter *adap,
+			    u8 coreid)
+{
+	static const char *const qname_t7[] = {
+		/* IBQ */
+		"TP0",
+		"TP1",
+		"TP2",
+		"TP3",
+		"ULP",
+		"SGE0",
+		"PCIE",
+		"NC-SI",
+		"RSVD",
+		"IPC1",
+		"IPC2",
+		"IPC3",
+		"IPC4",
+		"IPC5",
+		"IPC6",
+		"IPC7",
+		/* OBQ */
+		"ULP0",
+		"ULP1",
+		"ULP2",
+		"ULP3",
+		"SGE",
+		"NC-SI",
+		"SGE0-RX",
+		"RSVD",
+		"RSVD",
+		"IPC1",
+		"IPC2",
+		"IPC3",
+		"IPC4",
+		"IPC5",
+		"IPC6",
+		"IPC7",
+	};
+	u32 stat[(4 * (CIM_NUM_IBQ_T7 + CIM_NUM_OBQ_T7))];
+	u16 base[CIM_NUM_IBQ_T7 + CIM_NUM_OBQ_T7];
+	u16 size[CIM_NUM_IBQ_T7 + CIM_NUM_OBQ_T7];
+	u32 obq_wr[2 * CIM_NUM_OBQ_T7];
+	u16 thres[CIM_NUM_IBQ_T7];
+	u32 *wr = obq_wr;
+	u32 *p = stat;
+	u32 addr;
+	int ret;
+	u8 i;
+
+	ret = t4_cim_read_core(adap, 1, coreid, T7_UP_IBQ_0_SHADOW_RDADDR_A,
+			       4 * CIM_NUM_IBQ_T7, stat);
+	if (ret < 0)
+		return ret;
+
+	ret = t4_cim_read_core(adap, 1, coreid, T7_UP_OBQ_0_SHADOW_RDADDR_A,
+			       4 * CIM_NUM_OBQ_T7, &stat[4 * CIM_NUM_IBQ_T7]);
+	if (ret < 0)
+		return ret;
+
+	addr = T7_UP_OBQ_0_SHADOW_REALADDR_A;
+	for (i = 0; i < CIM_NUM_OBQ_T7 * 2; i++, addr += 8) {
+		ret = t4_cim_read_core(adap, 1, coreid, addr, 1, &obq_wr[i]);
+		if (ret < 0)
+			return ret;
+	}
+
+	t4_read_cimq_cfg_core(adap, coreid, base, size, thres);
+
+	seq_printf(seq,
+		   "  Queue  Base  Size Thres  RdPtr WrPtr  SOP  EOP Avail\n");
+
+	for (i = 0; i < CIM_NUM_IBQ_T7; i++, p += 4) {
+		if (!size[i])
+			continue;
+
+		seq_printf(seq, "%7s %5x %5u %5u %6x  %4x %4u %4u %5u\n",
+			   qname_t7[i], base[i], size[i], thres[i],
+			   IBQRDADDR_G(p[0]) & 0xfff, IBQWRADDR_G(p[1]) & 0xfff,
+			   QUESOPCNT_G(p[3]), QUEEOPCNT_G(p[3]),
+			   T7_QUEREMFLITS_G(p[2]) * 16);
+	}
+
+	for ( ; i < CIM_NUM_IBQ_T7 + CIM_NUM_OBQ_T7; i++, p += 4, wr += 2) {
+		if (!size[i])
+			continue;
+
+		seq_printf(seq, "%7s %5x %5u %12x  %4x %4u %4u %5u\n",
+			   qname_t7[i], base[i], size[i],
+			   QUERDADDR_G(p[0]) & 0xfff, (wr[0] << 1),
+			   QUESOPCNT_G(p[3]), QUEEOPCNT_G(p[3]),
+			   T7_QUEREMFLITS_G(p[2]) * 16);
+	}
+
+	return 0;
+}
+
 static int cim_qcfg_show(struct seq_file *seq, void *v)
 {
+	struct t4_linux_debugfs_data *d = seq->private;
+	struct adapter *adap = d->adap;
+	u8 coreid = d->coreid;
+
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7)
+		return cim_qcfg_show_t7(seq, adap, coreid);
+
 	static const char * const qname[] = {
 		"TP0", "TP1", "ULP", "SGE0", "SGE1", "NC-SI",
 		"ULP0", "ULP1", "ULP2", "ULP3", "SGE", "NC-SI",
@@ -332,7 +439,6 @@ static int cim_qcfg_show(struct seq_file *seq, void *v)
 	};
 
 	int i;
-	struct adapter *adap = seq->private;
 	u16 base[CIM_NUM_IBQ + CIM_NUM_OBQ_T5];
 	u16 size[CIM_NUM_IBQ + CIM_NUM_OBQ_T5];
 	u32 stat[(4 * (CIM_NUM_IBQ + CIM_NUM_OBQ_T5))];
@@ -391,16 +497,19 @@ static int cimq_show(struct seq_file *seq, void *v, int idx)
 
 static int cim_ibq_open(struct inode *inode, struct file *file)
 {
-	int ret;
+	struct t4_linux_debugfs_data *d = inode->i_private;
+	struct adapter *adap = d->adap;
+	unsigned int qid = d->data;
+	u8 coreid = d->coreid;
 	struct seq_tab *p;
-	unsigned int qid = (uintptr_t)inode->i_private & 7;
-	struct adapter *adap = inode->i_private - qid;
+	int ret;
 
 	p = seq_open_tab(file, CIM_IBQ_SIZE, 4 * sizeof(u32), 0, cimq_show);
 	if (!p)
 		return -ENOMEM;
 
-	ret = t4_read_cim_ibq(adap, qid, (u32 *)p->data, CIM_IBQ_SIZE * 4);
+	ret = t4_read_cim_ibq_core(adap, coreid, qid, (u32 *)p->data,
+				   CIM_IBQ_SIZE * 4);
 	if (ret < 0)
 		seq_release_private(inode, file);
 	else
@@ -418,16 +527,19 @@ static const struct file_operations cim_ibq_fops = {
 
 static int cim_obq_open(struct inode *inode, struct file *file)
 {
-	int ret;
+	struct t4_linux_debugfs_data *d = inode->i_private;
+	struct adapter *adap = d->adap;
+	unsigned int qid = d->data;
+	u8 coreid = d->coreid;
 	struct seq_tab *p;
-	unsigned int qid = (uintptr_t)inode->i_private & 7;
-	struct adapter *adap = inode->i_private - qid;
+	int ret;
 
 	p = seq_open_tab(file, 6 * CIM_OBQ_SIZE, 4 * sizeof(u32), 0, cimq_show);
 	if (!p)
 		return -ENOMEM;
 
-	ret = t4_read_cim_obq(adap, qid, (u32 *)p->data, 6 * CIM_OBQ_SIZE * 4);
+	ret = t4_read_cim_obq_core(adap, coreid, qid, (u32 *)p->data,
+				   6 * CIM_OBQ_SIZE * 4);
 	if (ret < 0) {
 		seq_release_private(inode, file);
 	} else {
@@ -638,8 +750,9 @@ static int tp_la_show3(struct seq_file *seq, void *v, int idx)
 
 static int tp_la_open(struct inode *inode, struct file *file)
 {
+	struct t4_linux_debugfs_data *d = inode->i_private;
+	struct adapter *adap = d->adap;
 	struct seq_tab *p;
-	struct adapter *adap = inode->i_private;
 
 	switch (DBGLAMODE_G(t4_read_reg(adap, TP_DBG_LA_CONFIG_A))) {
 	case 2:
@@ -663,11 +776,14 @@ static int tp_la_open(struct inode *inode, struct file *file)
 static ssize_t tp_la_write(struct file *file, const char __user *buf,
 			   size_t count, loff_t *pos)
 {
-	int err;
-	char s[32];
+	struct t4_linux_debugfs_data *d = file_inode(file)->i_private;
+	struct adapter *adap = d->adap;
 	unsigned long val;
-	size_t size = min(sizeof(s) - 1, count);
-	struct adapter *adap = file_inode(file)->i_private;
+	size_t size;
+	char s[32];
+	int err;
+
+	size = min(sizeof(s) - 1, count);
 
 	if (copy_from_user(s, buf, size))
 		return -EFAULT;
@@ -707,8 +823,9 @@ static int ulprx_la_show(struct seq_file *seq, void *v, int idx)
 
 static int ulprx_la_open(struct inode *inode, struct file *file)
 {
+	struct t4_linux_debugfs_data *d = inode->i_private;
+	struct adapter *adap = d->adap;
 	struct seq_tab *p;
-	struct adapter *adap = inode->i_private;
 
 	p = seq_open_tab(file, ULPRX_LA_SIZE, 8 * sizeof(u32), 1,
 			 ulprx_la_show);
@@ -748,10 +865,11 @@ static int pm_stats_show(struct seq_file *seq, void *v)
 		"Read:", "Write bypass:", "Write mem:", "Flush:"
 	};
 
-	int i;
 	u32 tx_cnt[T6_PM_NSTATS], rx_cnt[T6_PM_NSTATS];
 	u64 tx_cyc[T6_PM_NSTATS], rx_cyc[T6_PM_NSTATS];
-	struct adapter *adap = seq->private;
+	struct t4_linux_debugfs_data *d = seq->private;
+	struct adapter *adap = d->adap;
+	int i;
 
 	t4_pmtx_get_stats(adap, tx_cnt, tx_cyc);
 	t4_pmrx_get_stats(adap, rx_cnt, rx_cyc);
@@ -791,6 +909,61 @@ static int pm_stats_show(struct seq_file *seq, void *v)
 		seq_printf(seq, "Rx latency    %10u  %20llu\n",
 			   rx_cnt[i], rx_cyc[i]);
 	}
+
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7) {
+		u32 stats[T7_PM_RX_CACHE_NSTATS];
+
+		t4_pmrx_cache_get_stats(adap, stats);
+
+		i = 0;
+		seq_puts(seq, "\n\nPM RX Cache Stats\n");
+		seq_printf(seq, "%-40s    %u\n", "ReqWrite", stats[i++]);
+		seq_printf(seq, "%-40s    %u\n", "ReqReadInv", stats[i++]);
+		seq_printf(seq, "%-40s    %u\n", "ReqReadNoInv", stats[i++]);
+		seq_printf(seq, "%-40s    %u\n", "Write Split Request",
+			   stats[i++]);
+		seq_printf(seq, "%-40s    %u\n",
+			   "Normal Read Split (Read Invalidate)", stats[i++]);
+		seq_printf(seq, "%-40s    %u\n",
+			   "Feedback Read Split (Read NoInvalidate)",
+			   stats[i++]);
+		seq_printf(seq, "%-40s    %u\n", "Write Hit", stats[i++]);
+		seq_printf(seq, "%-40s    %u\n", "Normal Read Hit", stats[i++]);
+		seq_printf(seq, "%-40s    %u\n", "Feedback Read Hit",
+			   stats[i++]);
+		seq_printf(seq, "%-40s    %u\n", "Normal Read Hit Full Avail",
+			   stats[i++]);
+		seq_printf(seq, "%-40s    %u\n", "Normal Read Hit Full UnAvail",
+			   stats[i++]);
+		seq_printf(seq, "%-40s    %u\n",
+			   "Normal Read Hit Partial Avail", stats[i++]);
+		seq_printf(seq, "%-40s    %u\n", "FB Read Hit Full Avail",
+			   stats[i++]);
+		seq_printf(seq, "%-40s    %u\n", "FB Read Hit Full UnAvail",
+			   stats[i++]);
+		seq_printf(seq, "%-40s    %u\n", "FB Read Hit Partial Avail",
+			   stats[i++]);
+		seq_printf(seq, "%-40s    %u\n", "Normal Read Full Free",
+			   stats[i++]);
+		seq_printf(seq, "%-40s    %u\n",
+			   "Normal Read Part-avail Mul-Regions", stats[i++]);
+		seq_printf(seq, "%-40s    %u\n",
+			   "FB Read Part-avail Mul-Regions", stats[i++]);
+		seq_printf(seq, "%-40s    %u\n", "Write Miss FL Used",
+			   stats[i++]);
+		seq_printf(seq, "%-40s    %u\n", "Write Miss LRU Used",
+			   stats[i++]);
+		seq_printf(seq, "%-40s    %u\n",
+			   "Write Miss LRU-Multiple Evict", stats[i++]);
+		seq_printf(seq, "%-40s    %u\n", "Write Hit Increasing Islands",
+			   stats[i++]);
+		seq_printf(seq, "%-40s    %u\n",
+			   "Normal Read Island Read split", stats[i++]);
+		seq_printf(seq, "%-40s    %u\n", "Write Overflow Eviction",
+			   stats[i++]);
+		seq_printf(seq, "%-40s    %u\n", "Read Overflow Eviction",
+			   stats[i++]);
+	}
 	return 0;
 }
 
@@ -802,7 +975,8 @@ static int pm_stats_open(struct inode *inode, struct file *file)
 static ssize_t pm_stats_clear(struct file *file, const char __user *buf,
 			      size_t count, loff_t *pos)
 {
-	struct adapter *adap = file_inode(file)->i_private;
+	struct t4_linux_debugfs_data *d = file_inode(file)->i_private;
+	struct adapter *adap = d->adap;
 
 	t4_write_reg(adap, PM_RX_STAT_CONFIG_A, 0);
 	t4_write_reg(adap, PM_TX_STAT_CONFIG_A, 0);
@@ -820,8 +994,9 @@ static const struct file_operations pm_stats_debugfs_fops = {
 
 static int tx_rate_show(struct seq_file *seq, void *v)
 {
+	struct t4_linux_debugfs_data *d = seq->private;
+	struct adapter *adap = d->adap;
 	u64 nrate[NCHAN], orate[NCHAN];
-	struct adapter *adap = seq->private;
 
 	t4_get_chan_txrate(adap, nrate, orate);
 	if (adap->params.arch.nchan == NCHAN) {
@@ -856,9 +1031,10 @@ static int cctrl_tbl_show(struct seq_file *seq, void *v)
 		"0.5", "0.5625", "0.625", "0.6875", "0.75", "0.8125", "0.875",
 		"0.9375" };
 
-	int i;
+	struct t4_linux_debugfs_data *d = seq->private;
+	struct adapter *adap = d->adap;
 	u16 (*incr)[NCCTRL_WIN];
-	struct adapter *adap = seq->private;
+	int i;
 
 	incr = kmalloc_objs(*incr, NMTUS);
 	if (!incr)
@@ -902,13 +1078,16 @@ static char *unit_conv(char *buf, size_t len, unsigned int val,
 
 static int clk_show(struct seq_file *seq, void *v)
 {
+	struct t4_linux_debugfs_data *d = seq->private;
+	unsigned int cclk_ps, tre, dack_re, res;
+	struct adapter *adap = d->adap;
+	unsigned long long tp_tick_us;
 	char buf[32];
-	struct adapter *adap = seq->private;
-	unsigned int cclk_ps = 1000000000 / adap->params.vpd.cclk;  /* in ps */
-	u32 res = t4_read_reg(adap, TP_TIMER_RESOLUTION_A);
-	unsigned int tre = TIMERRESOLUTION_G(res);
-	unsigned int dack_re = DELAYEDACKRESOLUTION_G(res);
-	unsigned long long tp_tick_us = (cclk_ps << tre) / 1000000; /* in us */
+	cclk_ps = 1000000000 / adap->params.vpd.cclk;  /* in ps */
+	res = t4_read_reg(adap, TP_TIMER_RESOLUTION_A);
+	tre = TIMERRESOLUTION_G(res);
+	dack_re = DELAYEDACKRESOLUTION_G(res);
+	tp_tick_us = (cclk_ps << tre) / 1000000; /* in us */
 
 	seq_printf(seq, "Core clock period: %s ns\n",
 		   unit_conv(buf, sizeof(buf), cclk_ps, 1000));
@@ -1080,13 +1259,17 @@ static const struct seq_operations devlog_seq_ops = {
  */
 static int devlog_open(struct inode *inode, struct file *file)
 {
-	struct adapter *adap = inode->i_private;
-	struct devlog_params *dparams = &adap->params.devlogs;
+	struct t4_linux_debugfs_data *d = inode->i_private;
+	struct adapter *adap = d->adap;
+	struct devlog_params *dparams;
 	struct devlog_info *dinfo;
+	u8 coreid = d->coreid;
 	unsigned int index;
 	u32 fseqno;
 	int ret;
 
+	dparams = &adap->params.devlog[coreid];
+
 	/* If we don't know where the log is we can't do anything.
 	 */
 	if (dparams->start == 0)
@@ -1153,11 +1336,13 @@ static const struct file_operations devlog_fops = {
  */
 static int mboxlog_show(struct seq_file *seq, void *v)
 {
-	struct adapter *adapter = seq->private;
-	struct mbox_cmd_log *log = adapter->mbox_log;
+	struct t4_linux_debugfs_data *d = seq->private;
+	struct adapter *adap = d->adap;
+	struct mbox_cmd_log *log;
 	struct mbox_cmd *entry;
 	int entry_idx, i;
 
+	log = adap->mbox_log;
 	if (v == SEQ_START_TOKEN) {
 		seq_printf(seq,
 			   "%10s  %15s  %5s  %5s  %s\n",
@@ -1191,10 +1376,11 @@ static int mboxlog_show(struct seq_file *seq, void *v)
 
 static inline void *mboxlog_get_idx(struct seq_file *seq, loff_t pos)
 {
-	struct adapter *adapter = seq->private;
-	struct mbox_cmd_log *log = adapter->mbox_log;
+	struct t4_linux_debugfs_data *d = seq->private;
+	struct adapter *adap = d->adap;
 
-	return ((pos <= log->size) ? (void *)(uintptr_t)(pos + 1) : NULL);
+	return ((pos <= adap->mbox_log->size) ?
+			(void *)(uintptr_t)(pos + 1) : NULL);
 }
 
 static void *mboxlog_start(struct seq_file *seq, loff_t *pos)
@@ -1241,14 +1427,16 @@ static const struct file_operations mboxlog_fops = {
 
 static int mbox_show(struct seq_file *seq, void *v)
 {
-	static const char * const owner[] = { "none", "FW", "driver",
-					      "unknown", "<unread>" };
-
+	static const char * const owner[] = {
+		"none", "FW", "driver", "FW Deferred", "<unread>"
+	};
+	struct t4_linux_debugfs_data *d = seq->private;
+	struct adapter *adap = d->adap;
+	unsigned int mbox = d->data;
+	void __iomem *addr;
 	int i;
-	unsigned int mbox = (uintptr_t)seq->private & 7;
-	struct adapter *adap = seq->private - mbox;
-	void __iomem *addr = adap->regs + PF_REG(mbox, CIM_PF_MAILBOX_DATA_A);
 
+	addr = adap->regs + PF_REG(mbox, CIM_PF_MAILBOX_DATA_A);
 	/* For T4 we don't have a shadow copy of the Mailbox Control register.
 	 * And since reading that real register causes a side effect of
 	 * granting ownership, we're best of simply not reading it at all.
@@ -1278,14 +1466,14 @@ static int mbox_open(struct inode *inode, struct file *file)
 static ssize_t mbox_write(struct file *file, const char __user *buf,
 			  size_t count, loff_t *pos)
 {
-	int i;
-	char c = '\n', s[256];
+	struct t4_linux_debugfs_data *d = file_inode(file)->i_private;
+	struct adapter *adap = d->adap;
+	unsigned int mbox = d->data;
 	unsigned long long data[8];
-	const struct inode *ino;
-	unsigned int mbox;
-	struct adapter *adap;
+	char s[256], c = '\n';
 	void __iomem *addr;
 	void __iomem *ctrl;
+	int i;
 
 	if (count > sizeof(s) - 1 || !count)
 		return -EINVAL;
@@ -1298,9 +1486,6 @@ static ssize_t mbox_write(struct file *file, const char __user *buf,
 		   &data[7], &c) < 8 || c != '\n')
 		return -EINVAL;
 
-	ino = file_inode(file);
-	mbox = (uintptr_t)ino->i_private & 7;
-	adap = ino->i_private - mbox;
 	addr = adap->regs + PF_REG(mbox, CIM_PF_MAILBOX_DATA_A);
 	ctrl = addr + MBOX_LEN;
 
@@ -1325,10 +1510,11 @@ static const struct file_operations mbox_debugfs_fops = {
 
 static int mps_trc_show(struct seq_file *seq, void *v)
 {
-	int enabled, i;
+	struct t4_linux_debugfs_data *d = seq->private;
+	struct adapter *adap = d->adap;
+	unsigned int trcidx = d->data;
 	struct trace_params tp;
-	unsigned int trcidx = (uintptr_t)seq->private & 3;
-	struct adapter *adap = seq->private - trcidx;
+	int enabled, i;
 
 	t4_get_trace_filter(adap, &tp, trcidx, &enabled);
 	if (!enabled) {
@@ -1411,18 +1597,13 @@ static unsigned int xdigit2int(unsigned char c)
 static ssize_t mps_trc_write(struct file *file, const char __user *buf,
 			     size_t count, loff_t *pos)
 {
-	int i, enable, ret;
-	u32 *data, *mask;
-	struct trace_params tp;
-	const struct inode *ino;
-	unsigned int trcidx;
+	struct t4_linux_debugfs_data *d = file_inode(file)->i_private;
+	struct adapter *adap = d->adap;
+	unsigned int trcidx = d->data;
 	char *s, *p, *word, *end;
-	struct adapter *adap;
-	u32 j;
-
-	ino = file_inode(file);
-	trcidx = (uintptr_t)ino->i_private & 3;
-	adap = ino->i_private - trcidx;
+	struct trace_params tp;
+	int i, enable, ret;
+	u32 *data, *mask, j;
 
 	/* Don't accept input more than 1K, can't be anything valid except lots
 	 * of whitespace.  Well, use less.
@@ -1619,9 +1800,10 @@ static const struct file_operations mps_trc_debugfs_fops = {
 static ssize_t flash_read(struct file *file, char __user *buf, size_t count,
 			  loff_t *ppos)
 {
-	loff_t pos = *ppos;
+	struct t4_linux_debugfs_data *d = file->private_data;
 	loff_t avail = file_inode(file)->i_size;
-	struct adapter *adap = file->private_data;
+	struct adapter *adap = d->adap;
+	loff_t pos = *ppos;
 
 	if (pos < 0)
 		return -EINVAL;
@@ -1671,8 +1853,11 @@ static inline void tcamxy2valmask(u64 x, u64 y, u8 *addr, u64 *mask)
 
 static int mps_tcam_show(struct seq_file *seq, void *v)
 {
-	struct adapter *adap = seq->private;
-	unsigned int chip_ver = CHELSIO_CHIP_VERSION(adap->params.chip);
+	struct t4_linux_debugfs_data *d = seq->private;
+	struct adapter *adap = d->adap;
+	unsigned int chip_ver;
+
+	chip_ver = CHELSIO_CHIP_VERSION(adap->params.chip);
 	if (v == SEQ_START_TOKEN) {
 		if (chip_ver > CHELSIO_T5) {
 			seq_puts(seq, "Idx  Ethernet address     Mask     "
@@ -1683,27 +1868,91 @@ static int mps_tcam_show(struct seq_file *seq, void *v)
 				 "    P0 P1 P2 P3  ML\n");
 		} else {
 			if (adap->params.arch.mps_rplc_size > 128)
-				seq_puts(seq, "Idx  Ethernet address     Mask     "
+				seq_puts(seq,
+					 "Idx  Ethernet address     Mask     "
 					 "Vld Ports PF  VF                           "
 					 "Replication                                "
 					 "    P0 P1 P2 P3  ML\n");
 			else
-				seq_puts(seq, "Idx  Ethernet address     Mask     "
+				seq_puts(seq,
+					 "Idx  Ethernet address     Mask     "
 					 "Vld Ports PF  VF              Replication"
 					 "	         P0 P1 P2 P3  ML\n");
 		}
 	} else {
-		u64 mask;
-		u8 addr[ETH_ALEN];
+		u32 cls_lo, cls_hi, ctl, data2, vnix = 0, vniy = 0;
 		bool replicate, dip_hit = false, vlan_vld = false;
 		unsigned int idx = (uintptr_t)v - 2;
+		u8 lookup_type = 0, port_num = 0;
 		u64 tcamy, tcamx, val;
-		u32 cls_lo, cls_hi, ctl, data2, vnix = 0, vniy = 0;
+		u8 addr[ETH_ALEN];
 		u32 rplc[8] = {0};
-		u8 lookup_type = 0, port_num = 0;
 		u16 ivlan = 0;
+		u64 mask;
 
-		if (chip_ver > CHELSIO_T5) {
+		if (chip_ver >= CHELSIO_T7) {
+			/* CtlReqID   - 1: use Host Driver Requester ID
+			 * CtlCmdType - 0: Read, 1: Write
+			 * CtlXYBitSel- 0: Y bit, 1: X bit
+			  ####### for T6 ######
+			 * CtlTcamSel   - 26:25  Control bit. 0: TCAM0, 1: TCAM1
+			 * CtlTcamIndex - 24:17  Control bits. Index of TCAM location to be accessed
+			  ####### for T7B ######
+			 * CtlTcamSel   - 27:26  Control bit. 0: TCAM0, 1: TCAM1, 2: TCAM2
+			 * CtlTcamIndex - 25:17  Control bits. Index of TCAM location to be accessed
+			 */
+
+			/* Read tcamy */
+			ctl = (CTLREQID_V(1) |
+					CTLCMDTYPE_V(0) | CTLXYBITSEL_V(0));
+
+			if (idx < 512)
+				ctl |= T7_1_CTLTCAMINDEX_V(idx) | T7_CTLTCAMSEL_V(0);
+			else if (idx < 1024)
+				ctl |= T7_1_CTLTCAMINDEX_V(idx - 512) |
+					T7_CTLTCAMSEL_V(1);
+			else /* idx 1024 to 1535 */
+				ctl |= T7_1_CTLTCAMINDEX_V(idx - 1024) |
+					T7_CTLTCAMSEL_V(2);
+
+			t4_write_reg(adap, MPS_CLS_TCAM_DATA2_CTL_A, ctl);
+			val = t4_read_reg(adap, MPS_CLS_TCAM0_RDATA1_REQ_ID1_A);
+			tcamy = DMACH_G(val) << 32;
+			tcamy |= t4_read_reg(adap,
+					     MPS_CLS_TCAM0_RDATA0_REQ_ID1_A);
+			data2 = t4_read_reg(adap, MPS_CLS_TCAM0_RDATA2_REQ_ID1_A);
+			lookup_type = DATALKPTYPE_G(data2);
+			/* 0 - Outer header, 1 - Inner header
+			 * [71:48] bit locations are overloaded for
+			 * outer vs. inner lookup types.
+			 */
+			if (lookup_type && lookup_type != DATALKPTYPE_M) {
+				/* Inner header VNI */
+				vniy = (((data2 & DATAVIDH2_F) |
+							DATAVIDH1_G(data2)) << 16) |
+					VIDL_G(val);
+				dip_hit = data2 & DATADIPHIT_F;
+			} else {
+				vlan_vld = data2 & DATAVIDH2_F;
+				ivlan = VIDL_G(val);
+			}
+			port_num = DATAPORTNUM_G(data2);
+
+			/* Read tcamx. Change the control param */
+			vnix = 0;
+			ctl |= CTLXYBITSEL_V(1);
+			t4_write_reg(adap, MPS_CLS_TCAM_DATA2_CTL_A, ctl);
+			val = t4_read_reg(adap, MPS_CLS_TCAM0_RDATA1_REQ_ID1_A);
+			tcamx = DMACH_G(val) << 32;
+			tcamx |= t4_read_reg(adap, MPS_CLS_TCAM0_RDATA0_REQ_ID1_A);
+			data2 = t4_read_reg(adap, MPS_CLS_TCAM0_RDATA2_REQ_ID1_A);
+			if (lookup_type && lookup_type != DATALKPTYPE_M) {
+				/* Inner header VNI mask */
+				vnix = (((data2 & DATAVIDH2_F) |
+							DATAVIDH1_G(data2)) << 16) |
+					VIDL_G(val);
+			}
+		} else if (chip_ver > CHELSIO_T5) {
 			/* CtlCmdType - 0: Read, 1: Write
 			 * CtlTcamSel - 0: TCAM0, 1: TCAM1
 			 * CtlXYBitSel- 0: Y bit, 1: X bit
@@ -1755,8 +2004,19 @@ static int mps_tcam_show(struct seq_file *seq, void *v)
 			tcamx = t4_read_reg64(adap, MPS_CLS_TCAM_X_L(idx));
 		}
 
-		cls_lo = t4_read_reg(adap, MPS_CLS_SRAM_L(idx));
-		cls_hi = t4_read_reg(adap, MPS_CLS_SRAM_H(idx));
+		/* t7b changes MPS_T5_CLS_SRAM_H_A to indirect register */
+		if (is_t7(adap->params.chip)) {
+			u32 tmp_ctl = 0;
+
+			tmp_ctl |= SRAMWRN_V(0) |
+				SRAMINDEX_V(idx & SRAMINDEX_M);
+			t4_write_reg(adap, MPS_T5_CLS_SRAM_H_A, tmp_ctl);
+			cls_lo = t4_read_reg(adap, MPS_T5_CLS_SRAM_L_A);
+			cls_hi = t4_read_reg(adap, MPS_T5_CLS_SRAM_H_A);
+		} else {
+			cls_lo = t4_read_reg(adap, MPS_CLS_SRAM_L(idx));
+			cls_hi = t4_read_reg(adap, MPS_CLS_SRAM_H(idx));
+		}
 
 		if (tcamx & tcamy) {
 			seq_printf(seq, "%3u         -\n", idx);
@@ -1886,11 +2146,11 @@ out:	return 0;
 
 static inline void *mps_tcam_get_idx(struct seq_file *seq, loff_t pos)
 {
-	struct adapter *adap = seq->private;
-	int max_mac_addr = is_t4(adap->params.chip) ?
-				NUM_MPS_CLS_SRAM_L_INSTANCES :
-				NUM_MPS_T5_CLS_SRAM_L_INSTANCES;
-	return ((pos <= max_mac_addr) ? (void *)(uintptr_t)(pos + 1) : NULL);
+	struct t4_linux_debugfs_data *d = seq->private;
+	struct adapter *adap = d->adap;
+
+	return ((pos <= adap->params.arch.mps_tcam_size) ?
+			(void *)(uintptr_t)(pos + 1) : NULL);
 }
 
 static void *mps_tcam_start(struct seq_file *seq, loff_t *pos)
@@ -1939,7 +2199,8 @@ static const struct file_operations mps_tcam_debugfs_fops = {
  */
 static int sensors_show(struct seq_file *seq, void *v)
 {
-	struct adapter *adap = seq->private;
+	struct t4_linux_debugfs_data *d = seq->private;
+	struct adapter *adap = d->adap;
 	u32 param[7], val[7];
 	int ret;
 
@@ -1988,9 +2249,10 @@ static int rss_show(struct seq_file *seq, void *v, int idx)
 
 static int rss_open(struct inode *inode, struct file *file)
 {
-	struct adapter *adap = inode->i_private;
-	int ret, nentries;
+	struct t4_linux_debugfs_data *d = inode->i_private;
+	struct adapter *adap = d->adap;
 	struct seq_tab *p;
+	int ret, nentries;
 
 	nentries = t4_chip_rss_size(adap);
 	p = seq_open_tab(file, nentries / 8, 8 * sizeof(u16), 0, rss_show);
@@ -2028,7 +2290,8 @@ static const char *yesno(int x)
 
 static int rss_config_show(struct seq_file *seq, void *v)
 {
-	struct adapter *adapter = seq->private;
+	struct t4_linux_debugfs_data *d = seq->private;
+	struct adapter *adap = d->adap;
 	static const char * const keymode[] = {
 		"global",
 		"global and per-VF scramble",
@@ -2037,7 +2300,7 @@ static int rss_config_show(struct seq_file *seq, void *v)
 	};
 	u32 rssconf;
 
-	rssconf = t4_read_reg(adapter, TP_RSS_CONFIG_A);
+	rssconf = t4_read_reg(adap, TP_RSS_CONFIG_A);
 	seq_printf(seq, "TP_RSS_CONFIG: %#x\n", rssconf);
 	seq_printf(seq, "  Tnl4TupEnIpv6: %3s\n", yesno(rssconf &
 							TNL4TUPENIPV6_F));
@@ -2087,11 +2350,11 @@ static int rss_config_show(struct seq_file *seq, void *v)
 
 	seq_puts(seq, "\n");
 
-	rssconf = t4_read_reg(adapter, TP_RSS_CONFIG_TNL_A);
+	rssconf = t4_read_reg(adap, TP_RSS_CONFIG_TNL_A);
 	seq_printf(seq, "TP_RSS_CONFIG_TNL: %#x\n", rssconf);
 	seq_printf(seq, "  MaskSize:      %3d\n", MASKSIZE_G(rssconf));
 	seq_printf(seq, "  MaskFilter:    %3d\n", MASKFILTER_G(rssconf));
-	if (CHELSIO_CHIP_VERSION(adapter->params.chip) > CHELSIO_T5) {
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) > CHELSIO_T5) {
 		seq_printf(seq, "  HashAll:     %3s\n",
 			   yesno(rssconf & HASHALL_F));
 		seq_printf(seq, "  HashEth:     %3s\n",
@@ -2101,7 +2364,7 @@ static int rss_config_show(struct seq_file *seq, void *v)
 
 	seq_puts(seq, "\n");
 
-	rssconf = t4_read_reg(adapter, TP_RSS_CONFIG_OFD_A);
+	rssconf = t4_read_reg(adap, TP_RSS_CONFIG_OFD_A);
 	seq_printf(seq, "TP_RSS_CONFIG_OFD: %#x\n", rssconf);
 	seq_printf(seq, "  MaskSize:      %3d\n", MASKSIZE_G(rssconf));
 	seq_printf(seq, "  RRCplMapEn:    %3s\n", yesno(rssconf &
@@ -2110,16 +2373,16 @@ static int rss_config_show(struct seq_file *seq, void *v)
 
 	seq_puts(seq, "\n");
 
-	rssconf = t4_read_reg(adapter, TP_RSS_CONFIG_SYN_A);
+	rssconf = t4_read_reg(adap, TP_RSS_CONFIG_SYN_A);
 	seq_printf(seq, "TP_RSS_CONFIG_SYN: %#x\n", rssconf);
 	seq_printf(seq, "  MaskSize:      %3d\n", MASKSIZE_G(rssconf));
 	seq_printf(seq, "  UseWireCh:     %3s\n", yesno(rssconf & USEWIRECH_F));
 
 	seq_puts(seq, "\n");
 
-	rssconf = t4_read_reg(adapter, TP_RSS_CONFIG_VRT_A);
+	rssconf = t4_read_reg(adap, TP_RSS_CONFIG_VRT_A);
 	seq_printf(seq, "TP_RSS_CONFIG_VRT: %#x\n", rssconf);
-	if (CHELSIO_CHIP_VERSION(adapter->params.chip) > CHELSIO_T5) {
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) > CHELSIO_T5) {
 		seq_printf(seq, "  KeyWrAddrX:     %3d\n",
 			   KEYWRADDRX_G(rssconf));
 		seq_printf(seq, "  KeyExtend:      %3s\n",
@@ -2133,7 +2396,7 @@ static int rss_config_show(struct seq_file *seq, void *v)
 							DISABLEVLAN_F));
 	seq_printf(seq, "  EnUpSwt:       %3s\n", yesno(rssconf & ENABLEUP0_F));
 	seq_printf(seq, "  HashDelay:     %3d\n", HASHDELAY_G(rssconf));
-	if (CHELSIO_CHIP_VERSION(adapter->params.chip) <= CHELSIO_T5)
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) <= CHELSIO_T5)
 		seq_printf(seq, "  VfWrAddr:      %3d\n", VFWRADDR_G(rssconf));
 	else
 		seq_printf(seq, "  VfWrAddr:      %3d\n",
@@ -2145,7 +2408,7 @@ static int rss_config_show(struct seq_file *seq, void *v)
 
 	seq_puts(seq, "\n");
 
-	rssconf = t4_read_reg(adapter, TP_RSS_CONFIG_CNG_A);
+	rssconf = t4_read_reg(adap, TP_RSS_CONFIG_CNG_A);
 	seq_printf(seq, "TP_RSS_CONFIG_CNG: %#x\n", rssconf);
 	seq_printf(seq, "  ChnCount3:     %3s\n", yesno(rssconf & CHNCOUNT3_F));
 	seq_printf(seq, "  ChnCount2:     %3s\n", yesno(rssconf & CHNCOUNT2_F));
@@ -2180,9 +2443,11 @@ DEFINE_SHOW_ATTRIBUTE(rss_config);
 
 static int rss_key_show(struct seq_file *seq, void *v)
 {
+	struct t4_linux_debugfs_data *d = seq->private;
+	struct adapter *adap = d->adap;
 	u32 key[10];
 
-	t4_read_rss_key(seq->private, key, true);
+	t4_read_rss_key(adap, key, true);
 	seq_printf(seq, "%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x\n",
 		   key[9], key[8], key[7], key[6], key[5], key[4], key[3],
 		   key[2], key[1], key[0]);
@@ -2197,10 +2462,11 @@ static int rss_key_open(struct inode *inode, struct file *file)
 static ssize_t rss_key_write(struct file *file, const char __user *buf,
 			     size_t count, loff_t *pos)
 {
-	int i, j;
-	u32 key[10];
+	struct t4_linux_debugfs_data *d = file_inode(file)->i_private;
+	struct adapter *adap = d->adap;
 	char s[100], *p;
-	struct adapter *adap = file_inode(file)->i_private;
+	u32 key[10];
+	int i, j;
 
 	if (count > sizeof(s) - 1)
 		return -EINVAL;
@@ -2285,10 +2551,11 @@ static int rss_pf_config_show(struct seq_file *seq, void *v, int idx)
 
 static int rss_pf_config_open(struct inode *inode, struct file *file)
 {
-	struct adapter *adapter = inode->i_private;
-	struct seq_tab *p;
+	struct t4_linux_debugfs_data *d = inode->i_private;
+	struct adapter *adap = d->adap;
 	u32 rss_pf_map, rss_pf_mask;
 	struct rss_pf_conf *pfconf;
+	struct seq_tab *p;
 	int pf;
 
 	p = seq_open_tab(file, 8, sizeof(*pfconf), 1, rss_pf_config_show);
@@ -2296,12 +2563,12 @@ static int rss_pf_config_open(struct inode *inode, struct file *file)
 		return -ENOMEM;
 
 	pfconf = (struct rss_pf_conf *)p->data;
-	rss_pf_map = t4_read_rss_pf_map(adapter, true);
-	rss_pf_mask = t4_read_rss_pf_mask(adapter, true);
+	rss_pf_map = t4_read_rss_pf_map(adap, true);
+	rss_pf_mask = t4_read_rss_pf_mask(adap, true);
 	for (pf = 0; pf < 8; pf++) {
 		pfconf[pf].rss_pf_map = rss_pf_map;
 		pfconf[pf].rss_pf_mask = rss_pf_mask;
-		t4_read_rss_pf_config(adapter, pf, &pfconf[pf].rss_pf_config,
+		t4_read_rss_pf_config(adap, pf, &pfconf[pf].rss_pf_config,
 				      true);
 	}
 	return 0;
@@ -2353,18 +2620,20 @@ static int rss_vf_config_show(struct seq_file *seq, void *v, int idx)
 
 static int rss_vf_config_open(struct inode *inode, struct file *file)
 {
-	struct adapter *adapter = inode->i_private;
-	struct seq_tab *p;
+	struct t4_linux_debugfs_data *d = inode->i_private;
+	struct adapter *adap = d->adap;
 	struct rss_vf_conf *vfconf;
-	int vf, vfcount = adapter->params.arch.vfcount;
+	struct seq_tab *p;
+	int vf, vfcount;
 
+	vfcount = adap->params.arch.vfcount;
 	p = seq_open_tab(file, vfcount, sizeof(*vfconf), 1, rss_vf_config_show);
 	if (!p)
 		return -ENOMEM;
 
 	vfconf = (struct rss_vf_conf *)p->data;
 	for (vf = 0; vf < vfcount; vf++) {
-		t4_read_rss_vf_config(adapter, vf, &vfconf[vf].rss_vf_vfl,
+		t4_read_rss_vf_config(adap, vf, &vfconf[vf].rss_vf_vfl,
 				      &vfconf[vf].rss_vf_vfh, true);
 	}
 	return 0;
@@ -2384,7 +2653,8 @@ static const struct file_operations rss_vf_config_debugfs_fops = {
  */
 static int dcb_info_show(struct seq_file *seq, void *v)
 {
-	struct adapter *adap = seq->private;
+	struct t4_linux_debugfs_data *d = seq->private;
+	struct adapter *adap = d->adap;
 
 	if (v == SEQ_START_TOKEN) {
 		seq_puts(seq, "Data Center Bridging Information\n");
@@ -2405,7 +2675,6 @@ static int dcb_info_show(struct seq_file *seq, void *v)
 
 		if (dcb->msgs) {
 			int i;
-
 			seq_puts(seq, "\n  Index\t\t\t  :\t");
 			for (i = 0; i < 8; i++)
 				seq_printf(seq, " %3d", i);
@@ -2514,13 +2783,14 @@ static int dcb_info_show(struct seq_file *seq, void *v)
 static inline void *dcb_info_get_idx(struct adapter *adap, loff_t pos)
 {
 	return (pos <= adap->params.nports
-		? (void *)((uintptr_t)pos + 1)
-		: NULL);
+		      ? (void *)((uintptr_t)pos + 1)
+		      : NULL);
 }
 
 static void *dcb_info_start(struct seq_file *seq, loff_t *pos)
 {
-	struct adapter *adap = seq->private;
+	struct t4_linux_debugfs_data *d = seq->private;
+	struct adapter *adap = d->adap;
 
 	return (*pos
 		? dcb_info_get_idx(adap, *pos)
@@ -2533,7 +2803,8 @@ static void dcb_info_stop(struct seq_file *seq, void *v)
 
 static void *dcb_info_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	struct adapter *adap = seq->private;
+	struct t4_linux_debugfs_data *d = seq->private;
+	struct adapter *adap = d->adap;
 
 	(*pos)++;
 	return dcb_info_get_idx(adap, *pos);
@@ -2569,8 +2840,11 @@ static const struct file_operations dcb_info_debugfs_fops = {
 
 static int resources_show(struct seq_file *seq, void *v)
 {
-	struct adapter *adapter = seq->private;
-	struct pf_resources *pfres = &adapter->params.pfres;
+	struct t4_linux_debugfs_data *d = seq->private;
+	struct adapter *adap = d->adap;
+	struct pf_resources *pfres;
+
+	pfres = &adap->params.pfres;
 
 	#define S(desc, fmt, var) \
 		seq_printf(seq, "%-60s " fmt "\n", \
@@ -2593,12 +2867,13 @@ static int resources_show(struct seq_file *seq, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(resources);
 
+#ifdef CONFIG_CHELSIO_T4_DCB
 /**
  * ethqset2pinfo - return port_info of an Ethernet Queue Set
  * @adap: the adapter
  * @qset: Ethernet Queue Set
  */
-static inline struct port_info *ethqset2pinfo(struct adapter *adap, int qset)
+static struct port_info *ethqset2pinfo(struct adapter *adap, int qset)
 {
 	int pidx;
 
@@ -2614,6 +2889,7 @@ static inline struct port_info *ethqset2pinfo(struct adapter *adap, int qset)
 	BUG();
 	return NULL;
 }
+#endif /* CONFIG_CHELSIO_T4_DCB */
 
 static int sge_qinfo_uld_txq_entries(const struct adapter *adap, int uld)
 {
@@ -2656,7 +2932,10 @@ static int sge_qinfo_show(struct seq_file *seq, void *v)
 	const struct sge_uld_txq_info *utxq_info;
 	const struct sge_uld_rxq_info *urxq_info;
 	struct cxgb4_tc_port_mqprio *port_mqprio;
-	struct adapter *adap = seq->private;
+
+	struct t4_linux_debugfs_data *d = seq->private;
+	struct adapter *adap = d->adap;
+
 	int i, j, n, r = (uintptr_t)v - 1;
 	struct sge *s = &adap->sge;
 
@@ -3101,7 +3380,6 @@ do { \
 skip_uld:
 	if (r < ctrl_entries) {
 		const struct sge_ctrl_txq *tx = &s->ctrlq[r * 4];
-
 		n = min(4, adap->params.nports - 4 * r);
 
 		S("QType:", "Control");
@@ -3206,7 +3484,10 @@ static int sge_queue_entries(struct adapter *adap)
 
 static void *sge_queue_start(struct seq_file *seq, loff_t *pos)
 {
-	int entries = sge_queue_entries(seq->private);
+	struct t4_linux_debugfs_data *d = seq->private;
+	struct adapter *adap = d->adap;
+
+	int entries = sge_queue_entries(adap);
 
 	return *pos < entries ? (void *)((uintptr_t)*pos + 1) : NULL;
 }
@@ -3217,7 +3498,10 @@ static void sge_queue_stop(struct seq_file *seq, void *v)
 
 static void *sge_queue_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	int entries = sge_queue_entries(seq->private);
+	struct t4_linux_debugfs_data *d = seq->private;
+	struct adapter *adap = d->adap;
+
+	int entries = sge_queue_entries(adap);
 
 	++*pos;
 	return *pos < entries ? (void *)((uintptr_t)*pos + 1) : NULL;
@@ -3252,14 +3536,11 @@ static const struct file_operations sge_qinfo_debugfs_fops = {
 
 int mem_open(struct inode *inode, struct file *file)
 {
-	unsigned int mem;
-	struct adapter *adap;
+	struct t4_linux_debugfs_data *d = inode->i_private;
+	struct adapter *adap = d->adap;
 
 	file->private_data = inode->i_private;
 
-	mem = (uintptr_t)file->private_data & 0x7;
-	adap = file->private_data - mem;
-
 	(void)t4_fwcache(adap, FW_PARAM_DEV_FWCACHE_FLUSH);
 
 	return 0;
@@ -3268,10 +3549,11 @@ int mem_open(struct inode *inode, struct file *file)
 static ssize_t mem_read(struct file *file, char __user *buf, size_t count,
 			loff_t *ppos)
 {
-	loff_t pos = *ppos;
+	struct t4_linux_debugfs_data *d = file->private_data;
 	loff_t avail = file_inode(file)->i_size;
-	unsigned int mem = (uintptr_t)file->private_data & 0x7;
-	struct adapter *adap = file->private_data - mem;
+	struct adapter *adap = d->adap;
+	unsigned int mem = d->data;
+	loff_t pos = *ppos;
 	__be32 *data;
 	int ret;
 
@@ -3311,18 +3593,19 @@ static const struct file_operations mem_debugfs_fops = {
 
 static int tid_info_show(struct seq_file *seq, void *v)
 {
-	struct adapter *adap = seq->private;
+	struct t4_linux_debugfs_data *d = seq->private;
+	struct adapter *adap = d->adap;
 	const struct tid_info *t;
-	enum chip_type chip;
+	unsigned int chip_ver;
 
+	chip_ver = CHELSIO_CHIP_VERSION(adap->params.chip);
 	t = &adap->tids;
-	chip = CHELSIO_CHIP_VERSION(adap->params.chip);
+
 	if (t4_read_reg(adap, LE_DB_CONFIG_A) & HASHEN_F) {
 		unsigned int sb;
 		seq_printf(seq, "Connections in use: %u\n",
 			   atomic_read(&t->conns_in_use));
-
-		if (chip <= CHELSIO_T5)
+		if (chip_ver <= CHELSIO_T5)
 			sb = t4_read_reg(adap, LE_DB_SERVER_INDEX_A) / 4;
 		else
 			sb = t4_read_reg(adap, LE_DB_SRVR_START_INDEX_A);
@@ -3363,12 +3646,11 @@ static int tid_info_show(struct seq_file *seq, void *v)
 	if (t->nstids)
 		seq_printf(seq, "STID range: %u..%u, in use-IPv4/IPv6: %u/%u\n",
 			   (!t->stid_base &&
-			   (chip <= CHELSIO_T5)) ?
+			   (chip_ver <= CHELSIO_T5)) ?
 			   t->stid_base + 1 : t->stid_base,
 			   t->stid_base + t->nstids - 1,
 			   t->stids_in_use - t->v6_stids_in_use,
 			   t->v6_stids_in_use);
-
 	if (t->natids)
 		seq_printf(seq, "ATID range: 0..%u, in use: %u\n",
 			   t->natids - 1, t->atids_in_use);
@@ -3378,11 +3660,11 @@ static int tid_info_show(struct seq_file *seq, void *v)
 		seq_printf(seq, "SFTID range: %u..%u in use: %u\n",
 			   t->sftid_base, t->sftid_base + t->nsftids - 2,
 			   t->sftids_in_use);
-	if (t->nhpftids)
+	if (t->nhpftids && chip_ver > CHELSIO_T5)
 		seq_printf(seq, "HPFTID range: %u..%u\n", t->hpftid_base,
 			   t->hpftid_base + t->nhpftids - 1);
 	if (t->neotids)
-		seq_printf(seq, "EOTID range: %u..%u, in use: %u\n",
+		seq_printf(seq, "UOTID range: %u..%u, in use: %u\n",
 			   t->eotid_base, t->eotid_base + t->neotids - 1,
 			   atomic_read(&t->eotids_in_use));
 	if (t->ntids)
@@ -3393,22 +3675,17 @@ static int tid_info_show(struct seq_file *seq, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(tid_info);
 
-static void add_debugfs_mem(struct adapter *adap, const char *name,
-			    unsigned int idx, unsigned int size_mb)
-{
-	debugfs_create_file_size(name, 0400, adap->debugfs_root,
-				 (void *)adap + idx, &mem_debugfs_fops,
-				 size_mb << 20);
-}
-
 static ssize_t blocked_fl_read(struct file *filp, char __user *ubuf,
 			       size_t count, loff_t *ppos)
 {
-	int len;
-	const struct adapter *adap = filp->private_data;
+	struct t4_linux_debugfs_data *d = filp->private_data;
+	const struct adapter *adap = d->adap;
+	ssize_t size;
 	char *buf;
-	ssize_t size = (adap->sge.egr_sz + 3) / 4 +
-			adap->sge.egr_sz / 32 + 2; /* includes ,/\n/\0 */
+	int len;
+
+	size = (adap->sge.egr_sz + 3) / 4 + adap->sge.egr_sz / 32 +
+	       2; /* includes ,/\n/\0 */
 
 	buf = kzalloc(size, GFP_KERNEL);
 	if (!buf)
@@ -3425,9 +3702,10 @@ static ssize_t blocked_fl_read(struct file *filp, char __user *ubuf,
 static ssize_t blocked_fl_write(struct file *filp, const char __user *ubuf,
 				size_t count, loff_t *ppos)
 {
-	int err;
+	struct t4_linux_debugfs_data *d = filp->private_data;
+	struct adapter *adap = d->adap;
 	unsigned long *t;
-	struct adapter *adap = filp->private_data;
+	int err;
 
 	t = bitmap_zalloc(adap->sge.egr_sz, GFP_KERNEL);
 	if (!t)
@@ -3453,20 +3731,21 @@ static const struct file_operations blocked_fl_fops = {
 };
 
 static void mem_region_show(struct seq_file *seq, const char *name,
-			    unsigned int from, unsigned int to)
+			    u64 from, u64 to)
 {
 	char buf[40];
 
 	string_get_size((u64)to - from + 1, 1, STRING_UNITS_2, buf,
 			sizeof(buf));
-	seq_printf(seq, "%-15s %#x-%#x [%s]\n", name, from, to, buf);
+	seq_printf(seq, "%-20s %#llx-%#llx [%s]\n", name, from, to, buf);
 }
 
 static int meminfo_show(struct seq_file *seq, void *v)
 {
 	static const char * const memory[] = { "EDC0:", "EDC1:", "MC:",
 					       "MC0:", "MC1:", "HMA:"};
-	struct adapter *adap = seq->private;
+	struct t4_linux_debugfs_data *d = seq->private;
+	struct adapter *adap = d->adap;
 	struct cudbg_meminfo meminfo;
 	int i, rc;
 
@@ -3527,11 +3806,12 @@ DEFINE_SHOW_ATTRIBUTE(meminfo);
 
 static int chcr_stats_show(struct seq_file *seq, void *v)
 {
+	struct t4_linux_debugfs_data *d = seq->private;
 #if IS_ENABLED(CONFIG_CHELSIO_TLS_DEVICE)
 	struct ch_ktls_port_stats_debug *ktls_port;
 	int i = 0;
 #endif
-	struct adapter *adap = seq->private;
+	struct adapter *adap = d->adap;
 
 	seq_puts(seq, "Chelsio Crypto Accelerator Stats \n");
 	seq_printf(seq, "Cipher Ops: %10u \n",
@@ -3615,7 +3895,8 @@ do { \
 
 static void show_tcp_stats(struct seq_file *seq)
 {
-	struct adapter *adap = seq->private;
+	struct t4_linux_debugfs_data *d = seq->private;
+	struct adapter *adap = d->adap;
 	struct tp_tcp_stats v4, v6;
 
 	spin_lock(&adap->stats_lock);
@@ -3634,7 +3915,8 @@ static void show_tcp_stats(struct seq_file *seq)
 
 static void show_ddp_stats(struct seq_file *seq)
 {
-	struct adapter *adap = seq->private;
+	struct t4_linux_debugfs_data *d = seq->private;
+	struct adapter *adap = d->adap;
 	struct tp_usm_stats stats;
 
 	spin_lock(&adap->stats_lock);
@@ -3648,8 +3930,9 @@ static void show_ddp_stats(struct seq_file *seq)
 
 static void show_rdma_stats(struct seq_file *seq)
 {
-	struct adapter *adap = seq->private;
-	struct tp_rdma_stats stats;
+	struct t4_linux_debugfs_data *d = seq->private;
+	struct adapter *adap = d->adap;
+	struct tp_rdma_stats stats = {0};
 
 	spin_lock(&adap->stats_lock);
 	t4_tp_get_rdma_stats(adap, &stats, false);
@@ -3657,11 +3940,13 @@ static void show_rdma_stats(struct seq_file *seq)
 
 	PRINT_ADAP_STATS("rdma_no_rqe_mod_defer:", stats.rqe_dfr_mod);
 	PRINT_ADAP_STATS("rdma_no_rqe_pkt_defer:", stats.rqe_dfr_pkt);
+
 }
 
 static void show_tp_err_adapter_stats(struct seq_file *seq)
 {
-	struct adapter *adap = seq->private;
+	struct t4_linux_debugfs_data *d = seq->private;
+	struct adapter *adap = d->adap;
 	struct tp_err_stats stats;
 
 	spin_lock(&adap->stats_lock);
@@ -3674,7 +3959,8 @@ static void show_tp_err_adapter_stats(struct seq_file *seq)
 
 static void show_cpl_stats(struct seq_file *seq)
 {
-	struct adapter *adap = seq->private;
+	struct t4_linux_debugfs_data *d = seq->private;
+	struct adapter *adap = d->adap;
 	struct tp_cpl_stats stats;
 	u8 i;
 
@@ -3688,7 +3974,8 @@ static void show_cpl_stats(struct seq_file *seq)
 
 static void show_tp_err_channel_stats(struct seq_file *seq)
 {
-	struct adapter *adap = seq->private;
+	struct t4_linux_debugfs_data *d = seq->private;
+	struct adapter *adap = d->adap;
 	struct tp_err_stats stats;
 	u8 i;
 
@@ -3708,7 +3995,8 @@ static void show_tp_err_channel_stats(struct seq_file *seq)
 
 static void show_fcoe_stats(struct seq_file *seq)
 {
-	struct adapter *adap = seq->private;
+	struct t4_linux_debugfs_data *d = seq->private;
+	struct adapter *adap = d->adap;
 	struct tp_fcoe_stats stats[NCHAN];
 	u8 i;
 
@@ -3728,7 +4016,8 @@ static void show_fcoe_stats(struct seq_file *seq)
 
 static int tp_stats_show(struct seq_file *seq, void *v)
 {
-	struct adapter *adap = seq->private;
+	struct t4_linux_debugfs_data *d = seq->private;
+	struct adapter *adap = d->adap;
 
 	seq_puts(seq, "\n--------Adapter Stats--------\n");
 	show_tcp_stats(seq);
@@ -3738,9 +4027,8 @@ static int tp_stats_show(struct seq_file *seq, void *v)
 
 	seq_puts(seq, "\n-------- Channel Stats --------\n");
 	if (adap->params.arch.nchan == NCHAN)
-		seq_printf(seq, "%-25s %-20s %-20s %-20s %-20s\n",
-			   " ", "channel 0", "channel 1",
-			   "channel 2", "channel 3");
+		seq_printf(seq, "%-25s %-20s %-20s %-20s %-20s\n", " ",
+			   "channel 0", "channel 1", "channel 2", "channel 3");
 	else
 		seq_printf(seq, "%-25s %-20s %-20s\n",
 			   " ", "channel 0", "channel 1");
@@ -3754,32 +4042,175 @@ DEFINE_SHOW_ATTRIBUTE(tp_stats);
 
 /* Add an array of Debug FS files.
  */
-void add_debugfs_files(struct adapter *adap,
-		       struct t4_debugfs_entry *files,
-		       unsigned int nfiles)
+static void create_debugfs_file_entry(struct t4_linux_debugfs_entry *f,
+				      const char *name,
+				      const struct file_operations *ops,
+				      umode_t mode, unsigned char data)
 {
-	int i;
+	f->name = name;
+	f->ops = ops;
+	f->mode = mode;
+	f->data = data;
+}
 
-	/* debugfs support is best effort */
-	for (i = 0; i < nfiles; i++)
-		debugfs_create_file(files[i].name, files[i].mode,
-				    adap->debugfs_root,
-				    (void *)adap + files[i].data,
-				    files[i].ops);
+static void add_debugfs_file_size(struct adapter *adap, struct dentry *dentry,
+				  struct t4_linux_debugfs_entry *f, u64 size)
+{
+	struct t4_linux_debugfs_data *data;
+
+	data = devm_kzalloc(adap->pdev_dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return;
+
+	data->adap = adap;
+	data->data = f->data;
+	data->coreid = 0;
+	debugfs_create_file_size(f->name, f->mode, dentry, data, f->ops, size);
+}
+
+static void add_debugfs_mem(struct adapter *adap, const char *name,
+			    unsigned int i, unsigned int size_mb)
+{
+	struct t4_linux_debugfs_entry f;
+
+	create_debugfs_file_entry(&f, name, &mem_debugfs_fops, 0400, i);
+	add_debugfs_file_size(adap, adap->debugfs_root, &f, (u64)size_mb << 20);
 }
 
-int t4_setup_debugfs(struct adapter *adap)
+void add_debugfs_files(struct adapter *adap, struct dentry *dentry,
+		       unsigned char coreid, struct t4_linux_debugfs_entry *f,
+		       unsigned int n)
 {
+	struct t4_linux_debugfs_data *data;
 	int i;
-	u32 size = 0;
 
-	static struct t4_debugfs_entry t4_debugfs_files[] = {
+	for (i = 0; i < n; i++) {
+		data = devm_kzalloc(adap->pdev_dev, sizeof(*data), GFP_KERNEL);
+		if (!data)
+			continue;
+
+		data->adap = adap;
+		data->data = f[i].data;
+		data->coreid = coreid;
+		debugfs_create_file(f[i].name, f[i].mode, dentry, data,
+				    f[i].ops);
+	}
+}
+
+static void add_debugfs_files_multicore(struct adapter *adap)
+{
+	static struct t4_linux_debugfs_entry common_files[] = {
 		{ "cim_la", &cim_la_fops, 0400, 0 },
 		{ "cim_pif_la", &cim_pif_la_fops, 0400, 0 },
 		{ "cim_ma_la", &cim_ma_la_fops, 0400, 0 },
 		{ "cim_qcfg", &cim_qcfg_fops, 0400, 0 },
-		{ "clk", &clk_fops, 0400, 0 },
 		{ "devlog", &devlog_fops, 0400, 0 },
+	};
+	static struct t4_linux_debugfs_entry t4_files[] = {
+		{ "ibq_tp0", &cim_ibq_fops, 0400, 0 },
+		{ "ibq_tp1", &cim_ibq_fops, 0400, 1 },
+		{ "ibq_ulp", &cim_ibq_fops, 0400, 2 },
+		{ "ibq_sge", &cim_ibq_fops, 0400, 3 },
+		{ "ibq_pcie", &cim_ibq_fops, 0400, 4 },
+		{ "ibq_ncsi", &cim_ibq_fops, 0400, 5 },
+		{ "obq_ulp0", &cim_obq_fops, 0400, 0 },
+		{ "obq_ulp1", &cim_obq_fops, 0400, 1 },
+		{ "obq_ulp2", &cim_obq_fops, 0400, 2 },
+		{ "obq_ulp3", &cim_obq_fops, 0400, 3 },
+		{ "obq_sge", &cim_obq_fops, 0400, 4 },
+		{ "obq_ncsi", &cim_obq_fops, 0400, 5 },
+	};
+	static struct t4_linux_debugfs_entry t5_files[] = {
+		{ "ibq_tp0", &cim_ibq_fops, 0400, 0 },
+		{ "ibq_tp1", &cim_ibq_fops, 0400, 1 },
+		{ "ibq_ulp", &cim_ibq_fops, 0400, 2 },
+		{ "ibq_sge", &cim_ibq_fops, 0400, 3 },
+		{ "ibq_pcie", &cim_ibq_fops, 0400, 4 },
+		{ "ibq_ncsi", &cim_ibq_fops, 0400, 5 },
+		{ "obq_ulp0", &cim_obq_fops, 0400, 0 },
+		{ "obq_ulp1", &cim_obq_fops, 0400, 1 },
+		{ "obq_ulp2", &cim_obq_fops, 0400, 2 },
+		{ "obq_ulp3", &cim_obq_fops, 0400, 3 },
+		{ "obq_sge", &cim_obq_fops, 0400, 4 },
+		{ "obq_ncsi", &cim_obq_fops, 0400, 5 },
+		{ "obq_sge_rx_q0", &cim_obq_fops, 0400, 6 },
+		{ "obq_sge_rx_q1", &cim_obq_fops, 0400, 7 },
+	};
+	static struct t4_linux_debugfs_entry t7_files[] = {
+		{ "ibq_pcie", &cim_ibq_fops, 0400, 6 },
+		{ "ibq_ncsi", &cim_ibq_fops, 0400, 7 },
+		{ "ibq_ipc2", &cim_ibq_fops, 0400, 10 },
+		{ "ibq_ipc3", &cim_ibq_fops, 0400, 11 },
+		{ "ibq_ipc4", &cim_ibq_fops, 0400, 12 },
+		{ "ibq_ipc5", &cim_ibq_fops, 0400, 13 },
+		{ "ibq_ipc6", &cim_ibq_fops, 0400, 14 },
+		{ "ibq_ipc7", &cim_ibq_fops, 0400, 15 },
+		{ "obq_ncsi", &cim_obq_fops, 0400, 5 },
+		{ "obq_ipc2", &cim_obq_fops, 0400, 10 },
+		{ "obq_ipc3", &cim_obq_fops, 0400, 11 },
+		{ "obq_ipc4", &cim_obq_fops, 0400, 12 },
+		{ "obq_ipc5", &cim_obq_fops, 0400, 13 },
+		{ "obq_ipc6", &cim_obq_fops, 0400, 14 },
+		{ "obq_ipc7", &cim_obq_fops, 0400, 15 },
+	};
+	static struct t4_linux_debugfs_entry t7_sec_files[] = {
+		{ "ibq_tp0", &cim_ibq_fops, 0400, 0 },
+		{ "ibq_tp1", &cim_ibq_fops, 0400, 1 },
+		{ "ibq_tp2", &cim_ibq_fops, 0400, 2 },
+		{ "ibq_tp3", &cim_ibq_fops, 0400, 3 },
+		{ "ibq_ulp", &cim_ibq_fops, 0400, 4 },
+		{ "ibq_sge", &cim_ibq_fops, 0400, 5 },
+		{ "ibq_ipc1", &cim_ibq_fops, 0400, 9 },
+		{ "obq_ulp0", &cim_obq_fops, 0400, 0 },
+		{ "obq_ulp1", &cim_obq_fops, 0400, 1 },
+		{ "obq_ulp2", &cim_obq_fops, 0400, 2 },
+		{ "obq_ulp3", &cim_obq_fops, 0400, 3 },
+		{ "obq_sge", &cim_obq_fops, 0400, 4 },
+		{ "obq_sge_rx_q0", &cim_obq_fops, 0400, 6 },
+		{ "obq_ipc1", &cim_obq_fops, 0400, 9 },
+	};
+	u32 chip = CHELSIO_CHIP_VERSION(adap->params.chip);
+	char name[16];
+	u8 i;
+
+	switch (chip) {
+	case CHELSIO_T4:
+		add_debugfs_files(adap, adap->debugfs_root, 0, common_files,
+				  ARRAY_SIZE(common_files));
+		add_debugfs_files(adap, adap->debugfs_root, 0, t4_files,
+				  ARRAY_SIZE(t4_files));
+		break;
+	case CHELSIO_T5:
+	case CHELSIO_T6:
+		add_debugfs_files(adap, adap->debugfs_root, 0, common_files,
+				  ARRAY_SIZE(common_files));
+		add_debugfs_files(adap, adap->debugfs_root, 0, t5_files,
+				  ARRAY_SIZE(t5_files));
+		break;
+	default:
+		for (i = 0; i < adap->params.num_up_cores; i++) {
+			snprintf(name, sizeof(name), "core_%u", i);
+			adap->debugfs_multicore[i] =
+				debugfs_create_dir(name, adap->debugfs_root);
+
+			if (i == 0) {
+				add_debugfs_files(adap, adap->debugfs_multicore[i], i,
+						  t7_files, ARRAY_SIZE(t7_files));
+			}
+
+			add_debugfs_files(adap, adap->debugfs_multicore[i], i,
+					  common_files, ARRAY_SIZE(common_files));
+			add_debugfs_files(adap, adap->debugfs_multicore[i], i,
+					  t7_sec_files, ARRAY_SIZE(t7_sec_files));
+		}
+		break;
+	}
+}
+
+static int t4_setup_debugfs(struct adapter *adap)
+{
+	static struct t4_linux_debugfs_entry t4_debugfs_files[] = {
+		{ "clk", &clk_fops, 0400, 0 },
 		{ "mboxlog", &mboxlog_fops, 0400, 0 },
 		{ "mbox0", &mbox_debugfs_fops, 0600, 0 },
 		{ "mbox1", &mbox_debugfs_fops, 0600, 1 },
@@ -3789,105 +4220,177 @@ int t4_setup_debugfs(struct adapter *adap)
 		{ "mbox5", &mbox_debugfs_fops, 0600, 5 },
 		{ "mbox6", &mbox_debugfs_fops, 0600, 6 },
 		{ "mbox7", &mbox_debugfs_fops, 0600, 7 },
-		{ "trace0", &mps_trc_debugfs_fops, 0600, 0 },
-		{ "trace1", &mps_trc_debugfs_fops, 0600, 1 },
-		{ "trace2", &mps_trc_debugfs_fops, 0600, 2 },
-		{ "trace3", &mps_trc_debugfs_fops, 0600, 3 },
-		{ "l2t", &t4_l2t_fops, 0400, 0},
 		{ "mps_tcam", &mps_tcam_debugfs_fops, 0400, 0 },
-		{ "rss", &rss_debugfs_fops, 0400, 0 },
-		{ "rss_config", &rss_config_fops, 0400, 0 },
-		{ "rss_key", &rss_key_debugfs_fops, 0400, 0 },
-		{ "rss_pf_config", &rss_pf_config_debugfs_fops, 0400, 0 },
-		{ "rss_vf_config", &rss_vf_config_debugfs_fops, 0400, 0 },
-		{ "resources", &resources_fops, 0400, 0 },
-#ifdef CONFIG_CHELSIO_T4_DCB
-		{ "dcb_info", &dcb_info_debugfs_fops, 0400, 0 },
-#endif
-		{ "sge_qinfo", &sge_qinfo_debugfs_fops, 0400, 0 },
-		{ "ibq_tp0",  &cim_ibq_fops, 0400, 0 },
-		{ "ibq_tp1",  &cim_ibq_fops, 0400, 1 },
-		{ "ibq_ulp",  &cim_ibq_fops, 0400, 2 },
-		{ "ibq_sge0", &cim_ibq_fops, 0400, 3 },
-		{ "ibq_sge1", &cim_ibq_fops, 0400, 4 },
-		{ "ibq_ncsi", &cim_ibq_fops, 0400, 5 },
-		{ "obq_ulp0", &cim_obq_fops, 0400, 0 },
-		{ "obq_ulp1", &cim_obq_fops, 0400, 1 },
-		{ "obq_ulp2", &cim_obq_fops, 0400, 2 },
-		{ "obq_ulp3", &cim_obq_fops, 0400, 3 },
-		{ "obq_sge",  &cim_obq_fops, 0400, 4 },
-		{ "obq_ncsi", &cim_obq_fops, 0400, 5 },
 		{ "tp_la", &tp_la_fops, 0400, 0 },
 		{ "ulprx_la", &ulprx_la_fops, 0400, 0 },
 		{ "sensors", &sensors_fops, 0400, 0 },
+		{ "tp_stats", &tp_stats_fops, 0400, 0 },
 		{ "pm_stats", &pm_stats_debugfs_fops, 0400, 0 },
 		{ "tx_rate", &tx_rate_fops, 0400, 0 },
 		{ "cctrl", &cctrl_tbl_fops, 0400, 0 },
-#if IS_ENABLED(CONFIG_IPV6)
-		{ "clip_tbl", &clip_tbl_fops, 0400, 0 },
-#endif
-		{ "tids", &tid_info_fops, 0400, 0},
-		{ "blocked_fl", &blocked_fl_fops, 0600, 0 },
-		{ "meminfo", &meminfo_fops, 0400, 0 },
-		{ "crypto", &chcr_stats_fops, 0400, 0 },
-		{ "tp_stats", &tp_stats_fops, 0400, 0 },
-	};
-
-	/* Debug FS nodes common to all T5 and later adapters.
-	 */
-	static struct t4_debugfs_entry t5_debugfs_files[] = {
-		{ "obq_sge_rx_q0", &cim_obq_fops, 0400, 6 },
-		{ "obq_sge_rx_q1", &cim_obq_fops, 0400, 7 },
+		{ "rss", &rss_debugfs_fops, 0400, 0 },
+		{ "rss_config", &rss_config_fops, 0400, 0 },
+		{ "rss_key", &rss_key_debugfs_fops, 0400, 0 },
+		{ "rss_pf_config", &rss_pf_config_debugfs_fops, 0400, 0 },
+		{ "rss_vf_config", &rss_vf_config_debugfs_fops, 0400, 0 },
+		{ "meminfo", &meminfo_fops, 0400, 0 }
 	};
+	u32 val, chip = CHELSIO_CHIP_VERSION(adap->params.chip);
+	struct t4_linux_debugfs_entry f;
+	int i;
 
-	add_debugfs_files(adap,
-			  t4_debugfs_files,
+	add_debugfs_files(adap, adap->debugfs_root, 0, t4_debugfs_files,
 			  ARRAY_SIZE(t4_debugfs_files));
-	if (!is_t4(adap->params.chip))
-		add_debugfs_files(adap,
-				  t5_debugfs_files,
-				  ARRAY_SIZE(t5_debugfs_files));
+
+	add_debugfs_files_multicore(adap);
 
 	i = t4_read_reg(adap, MA_TARGET_MEM_ENABLE_A);
 	if (i & EDRAM0_ENABLE_F) {
-		size = t4_read_reg(adap, MA_EDRAM0_BAR_A);
-		add_debugfs_mem(adap, "edc0", MEM_EDC0, EDRAM0_SIZE_G(size));
+		val = t4_read_reg(adap, MA_EDRAM0_BAR_A);
+		if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7)
+			add_debugfs_mem(adap, "edc0", MEM_EDC0, T7_EDRAM0_SIZE_G(val));
+		else
+			add_debugfs_mem(adap, "edc0", MEM_EDC0, EDRAM0_SIZE_G(val));
 	}
+
 	if (i & EDRAM1_ENABLE_F) {
-		size = t4_read_reg(adap, MA_EDRAM1_BAR_A);
-		add_debugfs_mem(adap, "edc1", MEM_EDC1, EDRAM1_SIZE_G(size));
+		val = t4_read_reg(adap, MA_EDRAM1_BAR_A);
+		if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7)
+			add_debugfs_mem(adap, "edc1", MEM_EDC1, T7_EDRAM1_SIZE_G(val));
+		else
+			add_debugfs_mem(adap, "edc1", MEM_EDC1, EDRAM1_SIZE_G(val));
 	}
-	if (is_t5(adap->params.chip)) {
-		if (i & EXT_MEM0_ENABLE_F) {
-			size = t4_read_reg(adap, MA_EXT_MEMORY0_BAR_A);
+
+	if (i & EXT_MEM_ENABLE_F) {
+		switch (chip) {
+		case CHELSIO_T4:
+		case CHELSIO_T5:
+			val = t4_read_reg(adap, MA_EXT_MEMORY0_BAR_A);
+			add_debugfs_mem(adap, "mc0", MEM_MC0,
+					EXT_MEM0_SIZE_G(val));
+			break;
+		case CHELSIO_T6:
+			val = t4_read_reg(adap, MA_EXT_MEMORY_BAR_A);
+			add_debugfs_mem(adap, "mc", MEM_MC,
+					EXT_MEM_SIZE_G(val));
+			break;
+		default:
+			val = t4_read_reg(adap, MA_EXT_MEMORY0_BAR_A);
 			add_debugfs_mem(adap, "mc0", MEM_MC0,
-					EXT_MEM0_SIZE_G(size));
+					T7_EXT_MEM0_SIZE_G(val));
+			break;
 		}
-		if (i & EXT_MEM1_ENABLE_F) {
-			size = t4_read_reg(adap, MA_EXT_MEMORY1_BAR_A);
+	}
+
+	if (i & EXT_MEM1_ENABLE_F) {
+		switch (chip) {
+		case CHELSIO_T4:
+		case CHELSIO_T5:
+			/* No mc1 when split mode enabled */
+			if (i & MC_SPLIT_F)
+				break;
+
+			val = t4_read_reg(adap, MA_EXT_MEMORY1_BAR_A);
 			add_debugfs_mem(adap, "mc1", MEM_MC1,
-					EXT_MEM1_SIZE_G(size));
-		}
-	} else {
-		if (i & EXT_MEM_ENABLE_F) {
-			size = t4_read_reg(adap, MA_EXT_MEMORY_BAR_A);
-			add_debugfs_mem(adap, "mc", MEM_MC,
-					EXT_MEM_SIZE_G(size));
+					EXT_MEM1_SIZE_G(val));
+			break;
+		case CHELSIO_T6:
+			/* No support for mc1 */
+			break;
+		default:
+			/* No mc1 when split mode enabled */
+			if (i & MC_SPLIT_F)
+				break;
+
+			val = t4_read_reg(adap, MA_EXT_MEMORY1_BAR_A);
+			add_debugfs_mem(adap, "mc1", MEM_MC1,
+					T7_EXT_MEM1_SIZE_G(val));
+			break;
 		}
+	}
 
-		if (i & HMA_MUX_F) {
-			size = t4_read_reg(adap, MA_EXT_MEMORY1_BAR_A);
+	if (i & HMA_MUX_F) {
+		switch (chip) {
+		case CHELSIO_T4:
+		case CHELSIO_T5:
+			/* No support for hma */
+			break;
+		case CHELSIO_T6:
+			val = t4_read_reg(adap, MA_EXT_MEMORY1_BAR_A);
+			add_debugfs_mem(adap, "hma", MEM_HMA,
+					EXT_MEM_SIZE_G(val));
+			break;
+		default:
+			val = t4_read_reg(adap, MA_HOST_MEMORY_BAR_A);
 			add_debugfs_mem(adap, "hma", MEM_HMA,
-					EXT_MEM1_SIZE_G(size));
+					T7_HMA_SIZE_G(val));
+			break;
 		}
 	}
 
-	debugfs_create_file_size("flash", 0400, adap->debugfs_root, adap,
-				 &flash_debugfs_fops, adap->params.sf_size);
+	create_debugfs_file_entry(&f, "flash", &flash_debugfs_fops, 0400, 0);
+	add_debugfs_file_size(adap, adap->debugfs_root, &f,
+			      adap->params.sf_size);
+
 	debugfs_create_bool("use_backdoor", 0600,
-			    adap->debugfs_root, &adap->use_bd);
+			adap->debugfs_root, &adap->use_bd);
 	debugfs_create_bool("trace_rss", 0600,
-			    adap->debugfs_root, &adap->trace_rss);
+			adap->debugfs_root, &adap->trace_rss);
+	return 0;
+}
+
+/*
+ * Add an array of Debug FS files.
+ */
+static void cxgb4_add_debugfs_files(struct adapter *adap,
+				    struct t4_linux_debugfs_entry *files,
+				    unsigned int nfiles)
+{
+	int i;
+
+	/* debugfs support is best effort */
+	for (i = 0; i < nfiles; i++)
+		add_debugfs_files(adap, adap->debugfs_root, 0, &files[i], 1);
+}
+
+int cxgb4_setup_debugfs(struct adapter *adap)
+{
+	static struct t4_linux_debugfs_entry cxgb4_debugfs_files[] = {
+		{ "blocked_fl", &blocked_fl_fops, 0600 },
+#ifdef CONFIG_CHELSIO_T4_DCB
+		{ "dcb_info", &dcb_info_debugfs_fops, 0400, 0 },
+		#endif /* CONFIG_CHELSIO_T4_DCB */
+		{ "resources", &resources_fops, 0400, 0 },
+		{ "sge_qinfo", &sge_qinfo_debugfs_fops, 0400, 0 },
+		{ "clip_tbl", &clip_tbl_fops, 0400, 0 },
+		{ "tids", &tid_info_fops, 0400, 0 },
+		{ "trace0", &mps_trc_debugfs_fops, 0600, 0 },
+		{ "trace1", &mps_trc_debugfs_fops, 0600, 1 },
+		{ "trace2", &mps_trc_debugfs_fops, 0600, 2 },
+		{ "trace3", &mps_trc_debugfs_fops, 0600, 3 },
+		{ "l2t", &t4_l2t_fops, 0400, 0 },
+		{ "crypto", &chcr_stats_fops, 0400, 0 },
+	};
+
+	static struct t4_linux_debugfs_entry cxgb4_t7_debugfs_files[] = {
+		{ "trace4", &mps_trc_debugfs_fops, 0600, 4 },
+		{ "trace5", &mps_trc_debugfs_fops, 0600, 5 },
+		{ "trace6", &mps_trc_debugfs_fops, 0600, 6 },
+		{ "trace7", &mps_trc_debugfs_fops, 0600, 7 },
+	};
+
+	if (IS_ERR_OR_NULL(adap->debugfs_root))
+		return -1;
+
+#ifdef CONFIG_DEBUG_FS
+	t4_setup_debugfs(adap);
+#endif
+
+	cxgb4_add_debugfs_files(adap, cxgb4_debugfs_files,
+				ARRAY_SIZE(cxgb4_debugfs_files));
 
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7)
+		cxgb4_add_debugfs_files(adap, cxgb4_t7_debugfs_files,
+					ARRAY_SIZE(cxgb4_t7_debugfs_files));
 	return 0;
 }
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.h
index 1471cf0deb58..77a0ed068baa 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.h
@@ -37,7 +37,13 @@
 
 #include <linux/export.h>
 
-struct t4_debugfs_entry {
+struct t4_linux_debugfs_data {
+	struct adapter *adap;
+	unsigned int data;
+	unsigned char coreid;
+};
+
+struct t4_linux_debugfs_entry {
 	const char *name;
 	const struct file_operations *ops;
 	umode_t mode;
@@ -61,10 +67,9 @@ struct seq_tab *seq_open_tab(struct file *f, unsigned int rows,
 			     unsigned int width, unsigned int have_header,
 			     int (*show)(struct seq_file *seq, void *v, int i));
 
-int t4_setup_debugfs(struct adapter *adap);
-void add_debugfs_files(struct adapter *adap,
-		       struct t4_debugfs_entry *files,
-		       unsigned int nfiles);
+void add_debugfs_files(struct adapter *adap, struct dentry *dentry,
+		       unsigned char coreid, struct t4_linux_debugfs_entry *f,
+		       unsigned int n);
 int mem_open(struct inode *inode, struct file *file);
-
+int cxgb4_setup_debugfs(struct adapter *adap);
 #endif
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index a3b1f9db5cbe..563a0ee1ce2c 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -7190,7 +7190,7 @@ int cxgb4_adap_probe(struct adapter *adapter)
 		const char *dir_name = pci_name(adapter->pdev);
 
 		adapter->debugfs_root = debugfs_create_dir(dir_name, cxgb4_debugfs_root);
-		t4_setup_debugfs(adapter);
+		cxgb4_setup_debugfs(adapter);
 	}
 
 	if (is_uld(adapter))
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
index 742d417d2e4f..fc61ece3be7b 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -6521,7 +6521,7 @@ static bool ulprx_intr_handler(struct adapter *adap, int arg, bool verbose)
 	if (CHELSIO_CHIP_VERSION(adap->params.chip) <= CHELSIO_T5)
 		ulprx_intr_info.details = ulprx_intr_details;
 	else if (CHELSIO_CHIP_VERSION(adap->params.chip) <= CHELSIO_T6)
-		ulprx_intr_info.details =  t6_ulprx_int_cause_details;
+		ulprx_intr_info.details = t6_ulprx_int_cause_details;
 	else
 		ulprx_intr_info.details = t7_ulprx_int_cause_details;
 
@@ -14245,22 +14245,6 @@ int t4_read_cim_ibq_core(struct adapter *adap, u8 coreid, u32 qid, u32 *data,
 	return i;
 }
 
-/*
- *	t4_read_cim_ibq - read the contents of a CIM inbound queue
- *	@adap: the adapter
- *	@qid: the queue index
- *	@data: where to store the queue contents
- *	@n: capacity of @data in 32-bit words
- *
- *	Reads the contents of the selected CIM queue starting at address 0 up
- *	to the capacity of @data.  @n must be a multiple of 4.  Returns < 0 on
- *	error and the number of 32-bit words actually read on success.
- */
-int t4_read_cim_ibq(struct adapter *adap, unsigned int qid, u32 *data, size_t n)
-{
-	return t4_read_cim_ibq_core(adap, 0, qid, data, n);
-}
-
 static int t4_read_cim_obq_data_core(struct adapter *adap, u8 coreid, u32 addr,
 				     u32 *data)
 {
@@ -14320,22 +14304,6 @@ int t4_read_cim_obq_core(struct adapter *adap, u8 coreid, u32 qid, u32 *data,
 	return i;
 }
 
-/*
- * t4_read_cim_obq - read the contents of a CIM outbound queue
- * @adap: the adapter
- * @qid: the queue index
- * @data: where to store the queue contents
- * @n: capacity of @data in 32-bit words
- *
- * Reads the contents of the selected CIM queue starting at address 0 up
- * to the capacity of @data.  @n must be a multiple of 4.  Returns < 0 on
- * error and the number of 32-bit words actually read on success.
- */
-int t4_read_cim_obq(struct adapter *adap, unsigned int qid, u32 *data, size_t n)
-{
-	return t4_read_cim_obq_core(adap, 0, qid, data, n);
-}
-
 /**
  * t4_cim_read_core - read a block from CIM internal address space
  * of a control register group on specific core.
@@ -14433,21 +14401,6 @@ int t4_cim_write_core(struct adapter *adap, u8 group, u8 coreid,
 	return ret;
 }
 
-/**
- *	t4_cim_write - write a block into CIM internal address space
- *	@adap: the adapter
- *	@addr: the start address within the CIM address space
- *	@n: number of words to write
- *	@valp: set of values to write
- *
- *	Writes a block of 4-byte words into the CIM intenal address space.
- */
-int t4_cim_write(struct adapter *adap, unsigned int addr, unsigned int n,
-		 const unsigned int *valp)
-{
-	return t4_cim_write_core(adap, 0, 0, addr, n, valp);
-}
-
 /**
  *	t4_cim_read_la_core - read CIM LA capture buffer on specific core
  *	@adap: the adapter
@@ -14530,21 +14483,6 @@ int t4_cim_read_la_core(struct adapter *adap, u8 coreid, u32 *la_buf,
 	return ret;
 }
 
-/**
- *	t4_cim_read_la - read CIM LA capture buffer
- *	@adap: the adapter
- *	@la_buf: where to store the LA data
- *	@wrptr: the HW write pointer within the capture buffer
- *
- *	Reads the contents of the CIM LA buffer with the most recent entry at
- *	the end	of the returned data and with the entry at @wrptr first.
- *	We try to leave the LA in the running state we find it in.
- */
-int t4_cim_read_la(struct adapter *adap, u32 *la_buf, unsigned int *wrptr)
-{
-	return t4_cim_read_la_core(adap, 0, la_buf, wrptr);
-}
-
 /**
  *	t4_tp_read_la - read TP LA capture buffer
  *	@adap: the adapter
-- 
2.39.1

