Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6561A41C6A;
	Tue,  8 Sep 2026 01:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788832499; cv=none; b=l20TdO4ZK+paYD+pGPivh3Q9Rtor1FE9Z1WwtWgUVNmdEan8EG6ux9ZGyYqh8YawZ3gd1o7LkUSNU3HQh8Lz6h1+1Q/9Ul7rTUYkgyDbSakWOdqEk/GVJMLas/MAbmRiHHv7ibHUVzWPM/vUlBrbSn53yU2teji5lC009kQgzlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788832499; c=relaxed/simple;
	bh=2KHz+9PXx//SdcHWJC0BWk4fQ0RyF97GJFgAaSYlJWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pe2Tit5HAcq7VOitgmHJCFPugP+s3Kme2ww9+kvpc5nKdQMhrYRwIORUtFLpv2uidUU/zKLcHV2YBANiV1V99SWPNuvnfS7DxHuQRa9jp1nUeOPkSUA74H+GXCd8HZLp7km0Ll2WPriD5RekWDP7jLMDaXRnlS11UJlKPp6Uv0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RsFmmtF6; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RsFmmtF6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=aB
	UHwBWmpgi9/lMoTRo3LUqOohStkqLLrAeFh+KYDAc=; b=RsFmmtF6xyPnQN87U9
	OpOfn0FUFK4Q03yxEXhSTgqiOyZuaPjY0ukrY4f2vjVDQ2/j2IFkUm6rnE8O+NCW
	7qvYyTzbxR+FO7j0g+WH2MJVM7X4OWjxdvUJSMtBSwZrzs3Z/oJ2flVTx1anSLVQ
	3+eY93d9s/7+73Nz7JXIT+2c4=
Received: from LAPTOP-BJS5C4G0 (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wBnX9Liap9qm1g6BQ--.20701S2;
	Tue, 08 Sep 2026 09:54:44 +0800 (CST)
From: Heyang Tan <thy15333007817@163.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sgoutham@marvell.com,
	rkannoth@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com
Subject: [PATCH v2] octeontx2-af: use seq_file for rsrc_alloc debugfs
Date: Tue,  8 Sep 2026 09:54:35 +0800
Message-ID: <20260908015435.1213-1-thy15333007817@163.com>
X-Mailer: git-send-email 2.51.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnX9Liap9qm1g6BQ--.20701S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF47Jr43JF4fGw18GryUJrb_yoWrKF13pa
	1Yyry0yr4qqF18J3WDKa1UJFyrWan0qFW0grWku34ru3ZYkF4Fqr1Yk3yjgayrGrWvyr90
	qa98trZ7C3WjyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UQXoxUUUUU=
X-CM-SenderInfo: 5wk1ikatttiiixyrlqqrwthudrp/xtbC-gVWAGqfauWLXAAA3A

The rsrc_alloc debugfs reader writes rows directly to userspace without
respecting the caller's read count. It also uses the current row length as
the userspace stride, which can corrupt output when rows have different
widths.

Use seq_file to handle userspace buffer sizes, offsets, and partial reads,
and write output columns directly to the seq_file buffer.

Fixes: 23205e6d06d4 ("octeontx2-af: Dump current resource provisioning status")
Signed-off-by: Heyang Tan <thy15333007817@163.com>
---
Changes in v2:
- Write columns directly to the seq_file buffer as suggested by Ratheesh.
- Preserve skipping PF/VF rows without allocated resources.

Link: https://lore.kernel.org/netdev/20260906141129.1730-1-thy15333007817@163.com/
Compile-tested: drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.o
Not hardware-tested.

 .../marvell/octeontx2/af/rvu_debugfs.c        | 104 ++++++------------
 1 file changed, 33 insertions(+), 71 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 22ee99676879..fcbf4ba0e10a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -714,110 +714,72 @@ static int get_max_column_width(struct rvu *rvu)
 }
 
 /* Dumps current provisioning status of all RVU block LFs */
-static ssize_t rvu_dbg_rsrc_attach_status(struct file *filp,
-					  char __user *buffer,
-					  size_t count, loff_t *ppos)
+static int rvu_dbg_rsrc_attach_status(struct seq_file *filp, void *unused)
 {
-	int index, off = 0, flag = 0, len = 0, i = 0;
-	struct rvu *rvu = filp->private_data;
-	int bytes_not_copied = 0;
+	int index, pf, vf, pcifunc;
+	struct rvu *rvu = filp->private;
 	struct rvu_block block;
-	int pf, vf, pcifunc;
-	int buf_size = 2048;
 	int lf_str_size;
 	char *lfs;
-	char *buf;
-
-	/* don't allow partial reads */
-	if (*ppos != 0)
-		return 0;
-
-	buf = kzalloc(buf_size, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
 
-	/* Get the maximum width of a column */
 	lf_str_size = get_max_column_width(rvu);
+	if (lf_str_size < 0)
+		return lf_str_size;
 
 	lfs = kzalloc(lf_str_size, GFP_KERNEL);
-	if (!lfs) {
-		kfree(buf);
+	if (!lfs)
 		return -ENOMEM;
-	}
-	off +=	scnprintf(&buf[off], buf_size - 1 - off, "%-*s", lf_str_size,
-			  "pcifunc");
-	for (index = 0; index < BLK_COUNT; index++)
-		if (strlen(rvu->hw->block[index].name)) {
-			off += scnprintf(&buf[off], buf_size - 1 - off,
-					 "%-*s", lf_str_size,
-					 rvu->hw->block[index].name);
-		}
 
-	off += scnprintf(&buf[off], buf_size - 1 - off, "\n");
-	bytes_not_copied = copy_to_user(buffer + (i * off), buf, off);
-	if (bytes_not_copied)
-		goto out;
+	seq_printf(filp, "%-*s", lf_str_size, "pcifunc");
+	for (index = 0; index < BLK_COUNT; index++)
+		if (strlen(rvu->hw->block[index].name))
+			seq_printf(filp, "%-*s", lf_str_size,
+				   rvu->hw->block[index].name);
 
-	i++;
-	*ppos += off;
+	seq_putc(filp, '\n');
 	for (pf = 0; pf < rvu->hw->total_pfs; pf++) {
 		for (vf = 0; vf <= rvu->hw->total_vfs; vf++) {
-			off = 0;
-			flag = 0;
 			pcifunc = rvu_make_pcifunc(rvu->pdev, pf, vf);
 			if (!pcifunc)
 				continue;
 
-			if (vf) {
+			for (index = 0; index < BLK_COUNT; index++) {
+				block = rvu->hw->block[index];
+				if (!strlen(block.name))
+					continue;
+				lfs[0] = '\0';
+				get_lf_str_list(&block, pcifunc, lfs);
+				if (strlen(lfs))
+					break;
+			}
+			if (index == BLK_COUNT)
+				continue;
+
+			if (vf)
 				sprintf(lfs, "PF%d:VF%d", pf, vf - 1);
-				off = scnprintf(&buf[off],
-						buf_size - 1 - off,
-						"%-*s", lf_str_size, lfs);
-			} else {
+			else
 				sprintf(lfs, "PF%d", pf);
-				off = scnprintf(&buf[off],
-						buf_size - 1 - off,
-						"%-*s", lf_str_size, lfs);
-			}
+			seq_printf(filp, "%-*s", lf_str_size, lfs);
 
 			for (index = 0; index < BLK_COUNT; index++) {
 				block = rvu->hw->block[index];
 				if (!strlen(block.name))
 					continue;
-				len = 0;
-				lfs[len] = '\0';
-				get_lf_str_list(&block, pcifunc, lfs);
-				if (strlen(lfs))
-					flag = 1;
 
-				off += scnprintf(&buf[off], buf_size - 1 - off,
-						 "%-*s", lf_str_size, lfs);
-			}
-			if (flag) {
-				off +=	scnprintf(&buf[off],
-						  buf_size - 1 - off, "\n");
-				bytes_not_copied = copy_to_user(buffer +
-								(i * off),
-								buf, off);
-				if (bytes_not_copied)
-					goto out;
-
-				i++;
-				*ppos += off;
+				lfs[0] = '\0';
+				get_lf_str_list(&block, pcifunc, lfs);
+				seq_printf(filp, "%-*s", lf_str_size, lfs);
 			}
+			seq_putc(filp, '\n');
 		}
 	}
 
-out:
 	kfree(lfs);
-	kfree(buf);
-	if (bytes_not_copied)
-		return -EFAULT;
 
-	return *ppos;
+	return 0;
 }
 
-RVU_DEBUG_FOPS(rsrc_status, rsrc_attach_status, NULL);
+RVU_DEBUG_SEQ_FOPS(rsrc_status, rsrc_attach_status, NULL);
 
 static int rvu_dbg_rvu_pf_cgx_map_display(struct seq_file *filp, void *unused)
 {
-- 
2.34.1

