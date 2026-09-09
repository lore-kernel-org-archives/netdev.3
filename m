Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B9F2C17A3;
	Wed,  9 Sep 2026 01:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788918898; cv=none; b=Kp53Hb+l/vGgO5xzPJ9YqkWLonceDiopMqbaBKL3rTxAIB20BpLj3CpnuFG8lUB0uw3/ICZsKSFl4Z47EcyOlzjwXTI17JncO8/R+7HcFACJDLnSd29FnH4HVyT7pqhZNK5iPKzSy3eWfBpOCQm2k5g9t7Y++WSUV1zZ7c//LTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788918898; c=relaxed/simple;
	bh=7ozVkbftgSEuAbtSGOYLzZoKFSz7qBH1XaAifNnlXtI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cK0+++0f2AkwzQQ7BhVXrVJs1PeJTSzpJBOB6Ox/bv+wH2BDiS+o3m7hAR9EKUVvgfuOq4N5Tswf7W5JbiO7rHA1BCNF1iDF5D+lnRyJPgf2BvEcS9MjraJ+Nc9RcY9azHH/Tk/AIm4O3Et9euVdnsJ+HWnHazlWIrxHxJgvnxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EgbJoCXG; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EgbJoCXG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=fw
	N4tmz3rp+n3zWW3xTgETF8DGgAuLH4t/UYF32mdKg=; b=EgbJoCXG1FmPJ6hEu7
	UME8VZid6S+qz93Hprmo1cclYINZH/fgtYrhBWFXC1+faQRewpmJl7olFMjBU3t5
	RlY41L/wiqqO0el3x4Sk3TNqAD4Npf1TNyKrdvbwgW2/m/jhbVRELNCyXHxOHhzs
	9l8MCIKSXdo/7TqTh61GRgQ0A=
Received: from LAPTOP-BJS5C4G0 (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3_zphvKBqY2huBg--.48624S2;
	Wed, 09 Sep 2026 09:54:42 +0800 (CST)
From: Heyang Tan <thy15333007817@163.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sgoutham@marvell.com,
	rkannoth@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com
Subject: [PATCH v3] octeontx2-af: use seq_file for rsrc_alloc debugfs
Date: Wed,  9 Sep 2026 09:54:37 +0800
Message-ID: <20260909015437.1042-1-thy15333007817@163.com>
X-Mailer: git-send-email 2.51.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_zphvKBqY2huBg--.48624S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKr4kZr1xXF1fuw4rZF4ruFg_yoWxGw1Dpa
	1YyryxKr4qqr18G3W7KF48ZFs5Gan5tFW8XFyv9348C3Z8Gr4Iqr4Ykr47Ka1rGrZ7tr90
	gry5KFZ7CF15Jr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UNXoxUUUUU=
X-CM-SenderInfo: 5wk1ikatttiiixyrlqqrwthudrp/xtbC4gQLtGqgvGS+NQAA3A

The rsrc_alloc debugfs reader writes rows directly to userspace without
respecting the caller's read count. It also uses the current row length as
the userspace stride, which can corrupt output when rows have different
widths.

Use seq_file to handle userspace buffer sizes, offsets, and partial reads.

The LF list formatter is used both to determine the widest column and skip
PF/VF rows with no resources, and to emit the final table. Let it measure
the formatted length when no seq_file is supplied, and write directly to
the seq_file during rendering. This preserves the pre-scan behavior while
removing the temporary string buffers.

Fixes: 23205e6d06d4 ("octeontx2-af: Dump current resource provisioning status")
Assisted-by: LLM Codex
Signed-off-by: Heyang Tan <thy15333007817@163.com>

Changes in v3:
- Format LF lists directly in the seq_file buffer and remove temporary buffers.
- Measure, rather than emit, LF lists during width calculation and row scans.
- Explain the two formatter modes in a code comment.
- Preserve column alignment with seq_setwidth() and seq_pad().
- Reorder local declarations in reverse Christmas tree order.

Link: https://lore.kernel.org/netdev/20260906141129.1730-1-thy15333007817@163.com/
---
 .../marvell/octeontx2/af/rvu_debugfs.c        | 114 +++++++++++-------
 1 file changed, 69 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index fcbf4ba0e10a..1f177851e76d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -646,10 +646,29 @@ static ssize_t rvu_dbg_lmtst_map_table_display(struct file *filp,
 
 RVU_DEBUG_FOPS(lmtst_map_table, lmtst_map_table_display, NULL);
 
-static void get_lf_str_list(const struct rvu_block *block, int pcifunc,
-			    char *lfs)
+static int get_num_digits(int number)
 {
-	int lf = 0, seq = 0, len = 0, prev_lf = block->lf.max;
+	int width = 1;
+
+	while (number >= 10) {
+		number /= 10;
+		width++;
+	}
+
+	return width;
+}
+
+/*
+ * Pre-scan callers need the formatted length to size columns and skip empty
+ * PF/VF rows. Passing NULL keeps those scans from emitting output before the
+ * final rendering pass.
+ */
+static int format_lf_str_list(struct seq_file *filp,
+			      const struct rvu_block *block, int pcifunc)
+{
+	int prev_lf = block->lf.max;
+	int lf = 0, len = 0;
+	bool seq = false;
 
 	for_each_set_bit(lf, block->lf.bmap, block->lf.max) {
 		if (lf >= block->lf.max)
@@ -664,32 +683,40 @@ static void get_lf_str_list(const struct rvu_block *block, int pcifunc,
 			continue;
 		}
 
-		if (seq)
-			len += sprintf(lfs + len, "-%d,%d", prev_lf, lf);
-		else
-			len += (len ? sprintf(lfs + len, ",%d", lf) :
-				      sprintf(lfs + len, "%d", lf));
+		if (seq) {
+			if (filp)
+				seq_printf(filp, "-%d,%d", prev_lf, lf);
+			len += get_num_digits(prev_lf) + get_num_digits(lf) + 2;
+		} else if (len) {
+			if (filp)
+				seq_printf(filp, ",%d", lf);
+			len += get_num_digits(lf) + 1;
+		} else {
+			if (filp)
+				seq_printf(filp, "%d", lf);
+			len += get_num_digits(lf);
+		}
 
 		prev_lf = lf;
-		seq = 0;
+		seq = false;
 	}
 
-	if (seq)
-		len += sprintf(lfs + len, "-%d", prev_lf);
+	if (seq) {
+		if (filp)
+			seq_printf(filp, "-%d", prev_lf);
+		len += get_num_digits(prev_lf) + 1;
+	}
 
-	lfs[len] = '\0';
+	return len;
 }
 
 static int get_max_column_width(struct rvu *rvu)
 {
-	int index, pf, vf, lf_str_size = 12, buf_size = 256;
 	struct rvu_block block;
+	int lf_str_size = 12;
+	int index, pf, vf;
 	u16 pcifunc;
-	char *buf;
-
-	buf = kzalloc(buf_size, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
+	int len;
 
 	for (pf = 0; pf < rvu->hw->total_pfs; pf++) {
 		for (vf = 0; vf <= rvu->hw->total_vfs; vf++) {
@@ -702,39 +729,38 @@ static int get_max_column_width(struct rvu *rvu)
 				if (!strlen(block.name))
 					continue;
 
-				get_lf_str_list(&block, pcifunc, buf);
-				if (lf_str_size <= strlen(buf))
-					lf_str_size = strlen(buf) + 1;
+				len = format_lf_str_list(NULL, &block, pcifunc);
+				if (lf_str_size <= len)
+					lf_str_size = len + 1;
 			}
 		}
 	}
 
-	kfree(buf);
 	return lf_str_size;
 }
 
 /* Dumps current provisioning status of all RVU block LFs */
 static int rvu_dbg_rsrc_attach_status(struct seq_file *filp, void *unused)
 {
-	int index, pf, vf, pcifunc;
 	struct rvu *rvu = filp->private;
+	int index, pf, vf, pcifunc;
 	struct rvu_block block;
 	int lf_str_size;
-	char *lfs;
+	int len;
 
 	lf_str_size = get_max_column_width(rvu);
-	if (lf_str_size < 0)
-		return lf_str_size;
 
-	lfs = kzalloc(lf_str_size, GFP_KERNEL);
-	if (!lfs)
-		return -ENOMEM;
+	seq_setwidth(filp, lf_str_size);
+	seq_puts(filp, "pcifunc");
+	seq_pad(filp, ' ');
+	for (index = 0; index < BLK_COUNT; index++) {
+		if (!strlen(rvu->hw->block[index].name))
+			continue;
 
-	seq_printf(filp, "%-*s", lf_str_size, "pcifunc");
-	for (index = 0; index < BLK_COUNT; index++)
-		if (strlen(rvu->hw->block[index].name))
-			seq_printf(filp, "%-*s", lf_str_size,
-				   rvu->hw->block[index].name);
+		seq_setwidth(filp, lf_str_size);
+		seq_puts(filp, rvu->hw->block[index].name);
+		seq_pad(filp, ' ');
+	}
 
 	seq_putc(filp, '\n');
 	for (pf = 0; pf < rvu->hw->total_pfs; pf++) {
@@ -747,35 +773,33 @@ static int rvu_dbg_rsrc_attach_status(struct seq_file *filp, void *unused)
 				block = rvu->hw->block[index];
 				if (!strlen(block.name))
 					continue;
-				lfs[0] = '\0';
-				get_lf_str_list(&block, pcifunc, lfs);
-				if (strlen(lfs))
+				len = format_lf_str_list(NULL, &block, pcifunc);
+				if (len)
 					break;
 			}
 			if (index == BLK_COUNT)
 				continue;
 
+			seq_setwidth(filp, lf_str_size);
 			if (vf)
-				sprintf(lfs, "PF%d:VF%d", pf, vf - 1);
+				seq_printf(filp, "PF%d:VF%d", pf, vf - 1);
 			else
-				sprintf(lfs, "PF%d", pf);
-			seq_printf(filp, "%-*s", lf_str_size, lfs);
+				seq_printf(filp, "PF%d", pf);
+			seq_pad(filp, ' ');
 
 			for (index = 0; index < BLK_COUNT; index++) {
 				block = rvu->hw->block[index];
 				if (!strlen(block.name))
 					continue;
 
-				lfs[0] = '\0';
-				get_lf_str_list(&block, pcifunc, lfs);
-				seq_printf(filp, "%-*s", lf_str_size, lfs);
+				seq_setwidth(filp, lf_str_size);
+				format_lf_str_list(filp, &block, pcifunc);
+				seq_pad(filp, ' ');
 			}
 			seq_putc(filp, '\n');
 		}
 	}
 
-	kfree(lfs);
-
 	return 0;
 }
 
-- 
2.34.1

