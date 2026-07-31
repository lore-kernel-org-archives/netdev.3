Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958083A450F
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 07:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785483625; cv=none; b=hE7R/T56+Sz3pXFC9qRaZxJ4wz2Mg+BawjedglbZSobfgahji6WztSlgOFFokSUhv8JpYKLXA6AcI5cc3288E7aSwVetSEwRBdFGlDRhHhN5tgPRSMJhwyXzcVhKnE+FPiy+CWYEajNgdHukn6NOCJCVR/wT8Z3wQrvSkejXhoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785483625; c=relaxed/simple;
	bh=+Hg6Iz/qPGAVH2HXuUmTFvQO5eCaZ1xoDi2W/S1TLHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A520/YfaZMMXVhCeV416VVDKQBX+hjJCtpl/sCmr22urcZDfAYda7IwwgMbiY2W3ZKnZHvtnxxtDZ9g8fOADMpHVPKv3s/U3yywnYQ2NTJAg6kyzC/D+5WSOAvpcJ9kNn8x323p8LYbkFBMbqWAJK+tJuXUVeqXh7FJtjZIMGf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B5KX7M9X; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B5KX7M9X"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V5I4N2975229;
	Fri, 31 Jul 2026 07:39:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fTjgA/m4QpVivZiMo
	QzC1lgl6oU+D76RO43IbLRSvdk=; b=B5KX7M9XvyfZk7NPNB0KH2ob5dTHfca8W
	TCjdOXV8sPsUOEQSePa6uT9UNiV6sEtxlSHJTgtIPjXJttMUK5SfG038DfDvv1JD
	kaTEyWvxibiEs5EzX32zMgEAzpTEyE4bVn4Gyk4q+aczuI0b+ZJBV7wMlu0jC0ea
	kwwY/RzpMLAsjO6Eu8+JMHem/hvggTsezvwrkvCIZAK8boqGy02ANs+Sgb9oMNUc
	edgWuTnbzXL+usheGFUtmxf7vqX/RhnvJYO9kO88yG5oGfAjZD+DnZPEqikfJh/I
	TRbSbbRhVlY7nAEMpUdyNSAT2pE10QRS2bksjuR/uN2NfaLprXytw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwdawsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 07:39:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66V7QJ1M002143;
	Fri, 31 Jul 2026 07:39:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhpwff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 07:39:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66V7dqg617432880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 07:39:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69ED920043;
	Fri, 31 Jul 2026 07:39:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0409720040;
	Fri, 31 Jul 2026 07:39:49 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.125.83])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 07:39:48 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, hare@suse.de, sagi@grimberg.me,
        chaitanyak@nvidia.com, gjoyce@linux.ibm.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        horms@kernel.org
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [RESEND PATCH v2 3/4] nvme: add debugfs helpers for NVMe drivers
Date: Fri, 31 Jul 2026 13:09:07 +0530
Message-ID: <20260731073918.614014-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731073918.614014-1-nilay@linux.ibm.com>
References: <20260731073918.614014-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 5kj2F2b-JWg5B9vd_rT2RJBVKwZtd734
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA1MCBTYWx0ZWRfX729/xgJLbFA8
 0UgYV55OBRDjtS7d6wUegI00HST0fK+v1pH4uvMPcIHTrGLM0FLvTDAeNQLuAbhzDfQPVY5q9C6
 acuwjv0hLGZIEVdsa/RUcdcA6UfRC5Q=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6c514d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=ooCht5J9LIHKhMPangUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA1MCBTYWx0ZWRfX1hnVJ17AarAT
 tpcD1lgePmoG/AZKcq54h2n5doUDCNKifIPSh7OP94ZlzbIgfwTapQi8g+4VhTVilSqjkPZzwQ5
 yxdxrGdLixoA+0oHx7lbNwSqcNIPub2OqUWK/7EV1BqyUD2Wktsx2Iwx2aOxe2dQAmFg2t93HnM
 obV6KMmHsuEuYs9QaGbZ4LvIR5qvVrJd34uwhdOf0GjHdx+DB8JlWaj640fDar/LREl606uAJ4Z
 oNAcmVnB3dWCXAQbGXfozwoBiEflpADAVOIe+L61VwBR/Bmhb7EMOLGrpKHvKs2k8hOp8vFo683
 J7QL0u+xKXJPKtsgb/1X07rjwblsTAd2p5HJn75mkEB+glmZyWBKF+fRTrXqsPxgFRPfgleNsgq
 twwtHp/Cn6BdhvHXNgc89iWSZU1CDktW0EQ84NsAk+zQJaYv0nFukSvSJ5QaB7zrdK2Q9bKTkv3
 wm9GriEMKYMtpcAZb8Q==
X-Proofpoint-GUID: 7Op3_dPUT4IPvPTLgazjwCitPPHcalz9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310050

Introduce helper APIs that allow NVMe drivers to register and unregister
debugfs entries, along with a reusable attribute structure for defining
new debugfs files.

The implementation uses seq_file interfaces to safely expose per-
namespace or per-path statistics, while supporting both simple show
callbacks and full seq_operations.

This will be used by subsequent patches to expose NVMe-TCP queue
and flow information for tuning NVMe TCP I/O workqueue and network stack
components.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/Makefile  |   2 +-
 drivers/nvme/host/debugfs.c | 129 ++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h    |  10 +++
 3 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 drivers/nvme/host/debugfs.c

diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index 6414ec968f99..7962dfc3b2ad 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_NVME_FC)			+= nvme-fc.o
 obj-$(CONFIG_NVME_TCP)			+= nvme-tcp.o
 obj-$(CONFIG_NVME_APPLE)		+= nvme-apple.o
 
-nvme-core-y				+= core.o ioctl.o sysfs.o pr.o
+nvme-core-y				+= core.o ioctl.o sysfs.o pr.o debugfs.o
 nvme-core-$(CONFIG_NVME_VERBOSE_ERRORS)	+= constants.o
 nvme-core-$(CONFIG_TRACING)		+= trace.o
 nvme-core-$(CONFIG_NVME_MULTIPATH)	+= multipath.o
diff --git a/drivers/nvme/host/debugfs.c b/drivers/nvme/host/debugfs.c
new file mode 100644
index 000000000000..b4802ea3bd48
--- /dev/null
+++ b/drivers/nvme/host/debugfs.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 IBM Corporation
+ *	Nilay Shroff <nilay@linux.ibm.com>
+ */
+
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+
+#include "nvme.h"
+
+struct nvme_debugfs_attr {
+	const char *name;
+	umode_t mode;
+	int (*show)(void *data, struct seq_file *m);
+	const struct seq_operations *seq_ops;
+	bool (*get)(void *data);
+	void (*put)(void *data);
+};
+
+struct nvme_debugfs_ctx {
+	void *data;
+	struct nvme_debugfs_attr *attr;
+};
+
+static int nvme_debugfs_show(struct seq_file *m, void *v)
+{
+	struct nvme_debugfs_ctx *ctx = m->private;
+	void *data = ctx->data;
+	struct nvme_debugfs_attr *attr = ctx->attr;
+
+	return attr->show(data, m);
+}
+
+static int nvme_debugfs_open(struct inode *inode, struct file *file)
+{
+	void *data = inode->i_private;
+	struct nvme_debugfs_attr *attr = debugfs_get_aux(file);
+	struct nvme_debugfs_ctx *ctx;
+	struct seq_file *m;
+	int ret;
+
+	if (attr->get && !attr->get(data))
+		return -ENODEV;
+
+	ctx = kzalloc_obj(*ctx);
+	if (WARN_ON_ONCE(!ctx)) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ctx->data = data;
+	ctx->attr = attr;
+
+	if (attr->seq_ops) {
+		ret = seq_open(file, attr->seq_ops);
+		if (ret)
+			goto out_free;
+
+		m = file->private_data;
+		m->private = ctx;
+		return ret;
+	}
+
+	if (WARN_ON_ONCE(!attr->show)) {
+		ret = -EPERM;
+		goto out_free;
+	}
+
+	ret = single_open(file, nvme_debugfs_show, ctx);
+	if (!ret)
+		return ret;
+
+out_free:
+	kfree(ctx);
+out:
+	if (attr->put)
+		attr->put(data);
+	return ret;
+}
+
+static int nvme_debugfs_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *m = file->private_data;
+	struct nvme_debugfs_ctx *ctx = m->private;
+	struct nvme_debugfs_attr *attr = ctx->attr;
+	int ret;
+
+	if (attr->seq_ops)
+		ret = seq_release(inode, file);
+	else
+		ret = single_release(inode, file);
+
+	if (attr->put)
+		attr->put(ctx->data);
+
+	kfree(ctx);
+	return ret;
+}
+
+static const struct file_operations nvme_debugfs_fops = {
+	.owner   = THIS_MODULE,
+	.open    = nvme_debugfs_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = nvme_debugfs_release,
+};
+
+static const struct nvme_debugfs_attr nvme_ns_debugfs_attrs[] = {
+	{},
+};
+
+static void nvme_debugfs_create_files(struct request_queue *q,
+		const struct nvme_debugfs_attr *attr, void *data)
+{
+	if (WARN_ON_ONCE(!q->debugfs_dir))
+		return;
+
+	for (; attr->name; attr++)
+		debugfs_create_file_aux(attr->name, attr->mode, q->debugfs_dir,
+				data, (void *)attr, &nvme_debugfs_fops);
+}
+
+void nvme_debugfs_register(struct gendisk *disk)
+{
+	nvme_debugfs_create_files(disk->queue, nvme_ns_debugfs_attrs,
+			disk->private_data);
+}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 824651cc898d..72f9d9c668a1 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -474,6 +474,16 @@ struct nvme_ctrl {
 	u16			awupf; /* 0's based value. */
 };
 
+void nvme_debugfs_register(struct gendisk *disk);
+static inline void nvme_debugfs_unregister(struct gendisk *disk)
+{
+	/*
+	 * Nothing to do for now. When the request queue is unregistered,
+	 * all files under q->debugfs_dir are recursively deleted.
+	 * This is just a placeholder; the compiler will optimize it out.
+	 */
+}
+
 static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
 {
 	return READ_ONCE(ctrl->state);
-- 
2.53.0

