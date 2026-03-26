Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407AA3FE36E;
	Thu, 26 Mar 2026 14:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534867; cv=none; b=SqfzgJJjNzr19IwDflZ+1+f5LwrnbRgz0w6hVNRvgyp2Kd/+4aZF0R3o5ihV5V4YM4/cXe/KJkxjYiSVqIdqYE89d9iJk5CqsX6jrUZuV5kx+8FoAFDHv5RfQu2His8chgK5+BCcmUrFyVanQ93meIAC2ESSEcKyhAF4qMomIMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534867; c=relaxed/simple;
	bh=tqmpK7p7NWNh3BCWKOU0aIQ+5vvGtctJbmRBvj25oIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyPa0D5UYNnGSSuMN0YcaM1FiLCleejQjpqRQyWgGo7KWuWSYYckMB01PONy+LjOaohQIcCYhDOMnNZcsrk6VK2XJp8fxSj811F+040W/os+hVg+xGuWoUZIgq7zP6l49qFQaKXZr3WWx9U/zkr1ygIfSRh3cmRY8Rdubk6Jhco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-03 (Coremail) with SMTP id rQCowAD32+KxQMVp_67qCw--.38622S2;
	Thu, 26 Mar 2026 22:20:33 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: michael.chan@broadcom.com
Cc: pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH net v3] bnxt_en: validate firmware backing store types
Date: Thu, 26 Mar 2026 22:20:33 +0800
Message-ID: <20260326142033.82313-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260323080336.36905-1-pengpeng@iscas.ac.cn>
References: <20260323080336.36905-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAD32+KxQMVp_67qCw--.38622S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4kCr13Zw4UArWxXr4fKrg_yoW5AF4kpF
	s8uFWaqr48Gr43tay5KF40vrn8uw4Sq348JFya93ZYvF1ayF1UA34kAF9IqryDuFZ7urya
	qa1Yyrs5G390qwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWI
	evJa73UjIFyTuYvjfUFg4SDUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

bnxt_hwrm_func_backing_store_qcaps_v2() stores resp->type from the
firmware response in ctxm->type and later uses that value to index
fixed backing-store metadata arrays such as ctx_arr[] and
bnxt_bstore_to_trace[] without a local range check.

Validate the returned type before storing it and abort the query when
firmware reports a type outside BNXT_CTX_V2_MAX. Keep next_valid_type in
a dedicated variable so loop control stays clear for non-valid or
unchanged entries while resp->type is validated directly before use.

Fixes: 6a4d0774f02d ("bnxt_en: Add support for new backing store query firmware API")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
v3:
- mark the patch for net
- add a Fixes tag
- replace resp_type with next_type for loop control and validate resp->type directly

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 0751c0e4581a..59ddf7a0c0ba 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8692,6 +8692,7 @@ static int bnxt_hwrm_func_backing_store_qcaps_v2(struct bnxt *bp)
 		u8 init_val, init_off, i;
 		u32 max_entries;
 		u16 entry_size;
+		u16 next_type;
 		__le32 *p;
 		u32 flags;
 
@@ -8700,7 +8701,7 @@ static int bnxt_hwrm_func_backing_store_qcaps_v2(struct bnxt *bp)
 		if (rc)
 			goto ctx_done;
 		flags = le32_to_cpu(resp->flags);
-		type = le16_to_cpu(resp->next_valid_type);
+		next_type = le16_to_cpu(resp->next_valid_type);
 		if (!(flags & BNXT_CTX_MEM_TYPE_VALID)) {
 			bnxt_free_one_ctx_mem(bp, ctxm, true);
 			continue;
@@ -8708,12 +8709,21 @@ static int bnxt_hwrm_func_backing_store_qcaps_v2(struct bnxt *bp)
 		entry_size = le16_to_cpu(resp->entry_size);
 		max_entries = le32_to_cpu(resp->max_num_entries);
 		if (ctxm->mem_valid) {
-			if (!(flags & BNXT_CTX_MEM_PERSIST) ||
-			    ctxm->entry_size != entry_size ||
-			    ctxm->max_entries != max_entries)
-				bnxt_free_one_ctx_mem(bp, ctxm, true);
-			else
+			if ((flags & BNXT_CTX_MEM_PERSIST) &&
+			    ctxm->entry_size == entry_size &&
+			    ctxm->max_entries == max_entries) {
+				type = next_type;
 				continue;
+			}
+
+			bnxt_free_one_ctx_mem(bp, ctxm, true);
+		}
+		if (le16_to_cpu(resp->type) >= BNXT_CTX_V2_MAX) {
+			netdev_warn(bp->dev,
+				    "invalid backing store type %u returned by firmware\n",
+				    le16_to_cpu(resp->type));
+			rc = -EINVAL;
+			goto ctx_done;
 		}
 		ctxm->type = le16_to_cpu(resp->type);
 		ctxm->entry_size = entry_size;
@@ -8731,6 +8741,8 @@ static int bnxt_hwrm_func_backing_store_qcaps_v2(struct bnxt *bp)
 		for (i = 0, p = &resp->split_entry_0; i < ctxm->split_entry_cnt;
 		     i++, p++)
 			ctxm->split[i] = le32_to_cpu(*p);
+
+		type = next_type;
 	}
 	rc = bnxt_alloc_all_ctx_pg_info(bp, BNXT_CTX_V2_MAX);
 
-- 
2.50.1 (Apple Git-155)

