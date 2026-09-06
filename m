Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E0D154425;
	Sun,  6 Sep 2026 14:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788703920; cv=none; b=SVfQkq4OV1Dp5BcE15hwk8xxjsSPCOt6eJmkBhX9/gnhmD7ns90pDj9fMTsOX3OSSyITpC0a5KWYgkQgVliRggKYA7v6kMZ4duhch4DIl7koPDPvneB0JluU+dd3VSFey8Sz3DGtmGrO6xdnEkkmD5dad7upJwCK7eGEbZ6SB+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788703920; c=relaxed/simple;
	bh=1Rk/+P2J6RgGxt0bh4y60H1MVb4VVsBjwH7irCp/gN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o12vmgHGobmOatXVGC1cMKjDKoz3dMjA8zn1vzkGRjYgXZgCrJwGNA9yseqV7cInyDQOXh/EtpJ4LJwS1gGIScHmcStPQw42jbQTWx+/IxbwcrkYxl3LC+T2KrrpyOXSrvraCeu6h9XsFBN2JZfAkReiaLa988GY95rL0CaFJxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Be6T7Itu; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Be6T7Itu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=T2
	6o6a+4nyv9OBJZwDf7WyKMxGvNlsFRGQa82+m6wwc=; b=Be6T7ItuVhY+hGnRVU
	E0lKqxmKIqOb64UwXuW6b13bRyLfGj2NMi3qLFw4X2Dq/6L5+BKYNnXJ1o6KWj34
	sb7TDGCxzMUWZ/cqnyrQp7+WPNwnUmIEO21p/uCwg4HelRaWxwQ5g5DxDRH6a5fA
	0hXBzqL91s3rkOSRyJz4jbqL8=
Received: from LAPTOP-BJS5C4G0 (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDHnJKSdJ1qrqsTBA--.47155S2;
	Sun, 06 Sep 2026 22:11:32 +0800 (CST)
From: Heyang Tan <thy15333007817@163.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sgoutham@marvell.com,
	rkannoth@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com
Subject: [PATCH] octeontx2-af: use seq_file for rsrc_alloc debugfs
Date: Sun,  6 Sep 2026 22:11:29 +0800
Message-ID: <20260906141129.1730-1-thy15333007817@163.com>
X-Mailer: git-send-email 2.51.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHnJKSdJ1qrqsTBA--.47155S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGrW3ur1rZr4kZFyxZF48Xrb_yoWrAFWrpa
	1YyrW8tr1qqF18J3W8Ka1UJrW5WanIqFWFgrWkW348ZFnY9F4FvFyak3yjk3y8K397tr9x
	ta98t397A3WUArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UQL0OUUUUU=
X-CM-SenderInfo: 5wk1ikatttiiixyrlqqrwthudrp/xtbC-hVE7WqddJV6ggAA3s

The rsrc_status debugfs reader writes rows directly to userspace without
respecting the caller's read count. It also uses the current row length as
the userspace stride, which can corrupt output when rows have different
widths.

Build each row in the existing kernel buffer and use seq_file to handle
userspace buffer sizes, offsets, and partial reads.

Fixes: 23205e6d06d4 ("octeontx2-af: Dump current resource provisioning status")
Signed-off-by: Heyang Tan <thy15333007817@163.com>
---
 .../marvell/octeontx2/af/rvu_debugfs.c        | 71 ++++++-------------
 1 file changed, 22 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 22ee99676879..a222998482fa 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -714,52 +714,39 @@ static int get_max_column_width(struct rvu *rvu)
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
+	int index, off, flag, pf, vf, pcifunc;
+	struct rvu *rvu = filp->private;
 	struct rvu_block block;
-	int pf, vf, pcifunc;
 	int buf_size = 2048;
 	int lf_str_size;
 	char *lfs;
 	char *buf;
 
-	/* don't allow partial reads */
-	if (*ppos != 0)
-		return 0;
-
 	buf = kzalloc(buf_size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-	/* Get the maximum width of a column */
 	lf_str_size = get_max_column_width(rvu);
+	if (lf_str_size < 0) {
+		kfree(buf);
+		return lf_str_size;
+	}
 
 	lfs = kzalloc(lf_str_size, GFP_KERNEL);
 	if (!lfs) {
 		kfree(buf);
 		return -ENOMEM;
 	}
-	off +=	scnprintf(&buf[off], buf_size - 1 - off, "%-*s", lf_str_size,
-			  "pcifunc");
+	off = scnprintf(buf, buf_size, "%-*s", lf_str_size, "pcifunc");
 	for (index = 0; index < BLK_COUNT; index++)
-		if (strlen(rvu->hw->block[index].name)) {
-			off += scnprintf(&buf[off], buf_size - 1 - off,
-					 "%-*s", lf_str_size,
-					 rvu->hw->block[index].name);
-		}
+		if (strlen(rvu->hw->block[index].name))
+			off += scnprintf(&buf[off], buf_size - 1 - off, "%-*s",
+					 lf_str_size, rvu->hw->block[index].name);
 
 	off += scnprintf(&buf[off], buf_size - 1 - off, "\n");
-	bytes_not_copied = copy_to_user(buffer + (i * off), buf, off);
-	if (bytes_not_copied)
-		goto out;
-
-	i++;
-	*ppos += off;
+	seq_puts(filp, buf);
 	for (pf = 0; pf < rvu->hw->total_pfs; pf++) {
 		for (vf = 0; vf <= rvu->hw->total_vfs; vf++) {
 			off = 0;
@@ -770,54 +757,40 @@ static ssize_t rvu_dbg_rsrc_attach_status(struct file *filp,
 
 			if (vf) {
 				sprintf(lfs, "PF%d:VF%d", pf, vf - 1);
-				off = scnprintf(&buf[off],
-						buf_size - 1 - off,
-						"%-*s", lf_str_size, lfs);
+				off = scnprintf(buf, buf_size, "%-*s", lf_str_size,
+						lfs);
 			} else {
 				sprintf(lfs, "PF%d", pf);
-				off = scnprintf(&buf[off],
-						buf_size - 1 - off,
-						"%-*s", lf_str_size, lfs);
+				off = scnprintf(buf, buf_size, "%-*s", lf_str_size,
+						lfs);
 			}
 
 			for (index = 0; index < BLK_COUNT; index++) {
 				block = rvu->hw->block[index];
 				if (!strlen(block.name))
 					continue;
-				len = 0;
-				lfs[len] = '\0';
+				lfs[0] = '\0';
 				get_lf_str_list(&block, pcifunc, lfs);
 				if (strlen(lfs))
 					flag = 1;
 
 				off += scnprintf(&buf[off], buf_size - 1 - off,
-						 "%-*s", lf_str_size, lfs);
+							 "%-*s", lf_str_size, lfs);
 			}
 			if (flag) {
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
+				off += scnprintf(&buf[off], buf_size - 1 - off, "\n");
+				seq_puts(filp, buf);
 			}
 		}
 	}
 
-out:
 	kfree(lfs);
 	kfree(buf);
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

