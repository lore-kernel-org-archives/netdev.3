Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792465188;
	b=zsd4TY6eCgWkdAXrT7nUOdiafbadzFseTz5twLsKbOda/4RM4Op12FleJYPTXI1QrOF8
	 7K+Kl5mb0hG7N3tveRXWl7yfu0ra1Ai6lfxkQEGLajcHUYK+Qj5QMVM9UNXKid/+bygAU
	 RY+bZXT2rsyUwHTksVHen8UB5cmiLO0+qYeFDxPj6VObS/rxgu2zRpqxF0OvHmaEPFFdP
	 IrcieUdtthpFEx6eEcNap04kw2da8pHfdNwhHWwyBv91HX5jqXGQylGotSzZwsUfXSrkQ
	 +1ZiIjf+UaPj/ke4bQiATbOCufxNvvQc2mifG5lo9K+QHoIJ0keIwo7DsGqmXoMRC6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465188;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=BMmQHiAE36nIASIRrotnQa66U6rilX4DL+YQyDlPz+A=;
	b=3mK9Jc6PYohLEaTF/ySKoYaMRLxC3Kkuvq1TVOBqN5NdVqxj/L3s2R4G4uawKIGOzaj7
	 +C/dfiVB8sZf1LmGZWX7jPCnb53cYB7IuithIJqNML9LusjlumfagVARuiiUSozzTto8k
	 REnA+GDarP+gYQwJfNtMQS5cG3fXi/xJ1oNUjvgmdmAPQ45Vp3HttTNX1ns9EwMmzn8uo
	 aumQERU5US+z5dSs+TrKo4PKVyGgfBf7O4ohiD9nRq2VrTLjSpbYoxxc6wAd+Qu+pe7nf
	 ranXDdZXPd5wGx9EsBen/D5QIeDfRp1BvyHEG+ITmrIiMQWfU11Ug5e9bBYlr6Rffuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=gCU5Nxy9;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CED2606A319;
	Tue, 20 Oct 2026 02:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CED2606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=gCU5Nxy9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=BM
	mQHiAE36nIASIRrotnQa66U6rilX4DL+YQyDlPz+A=; b=gCU5Nxy9iuFLzF8Shl
	KuOARUY8tjIrvLjcwQSTaDenxZSfeH3Za6uNOfiGcJePgr+I+hGskY0bjYr2mVMh
	aT0KA6V4ybEKYa5xElXS83CgAmxPDSD5pr8mYllXN3wKd9k2BFgfXLBx9000NoH3
	uxwExbzo5dICDpJNvs7VBL45Y=
Received: from colol4bi5.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDHf2Hy2NZqJUlhBA--.53240S2;
	Tue, 20 Oct 2026 10:58:59 +0800 (CST)
From: Binbin Deng <18983559317@163.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Binbin Deng <18983559317@163.com>
Subject: [PATCH v1] i40e: Lock VF cloud filter list operations
Date: Tue, 20 Oct 2026 10:58:56 +0800
Message-ID: <20261020025856.519623-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
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
X-CM-TRANSID:_____wDHf2Hy2NZqJUlhBA--.53240S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxArW8Cr18KFyDtFWkArWkWFg_yoWruw48pr
	4ruwnrKr4DZF1UW3yDtr4DCF1rG34kKFW7uFyftas8JrZxtF1Uuay7KFy5ua4kCryUArnx
	XF1qva1UZrZrC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piL0ePUUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC+xPCpmrW2POUbQAA3i

A VF's cloud-filter hlist is modified by the virtchnl add and delete
handlers and by i40e_del_all_cloud_filters(), which runs when ADq is
disabled or when the VF loses trusted status.  These paths do not share a
lock.  In particular, the PF's async VF-message handler can process
VIRTCHNL_OP_DEL_CLOUD_FILTER while host-side ndo_set_vf_trust() removes
every cloud filter for that VF.

The race is reachable from a guest by issuing cloud-filter virtchnl
requests while the host revokes VF trust or disables ADq.  The VF-message
handler can traverse nodes that the bulk-delete path has already freed, or
both paths can remove the same node.  The result can be a KASAN
use-after-free, hlist corruption, incorrect filter accounting, or a panic.
The virtchnl operation-pending bit does not serialize this host-side trust
path.

Serialize cloud-filter control operations with a mutex.  Hold it across
the firmware add or delete, hlist update, and free, so bulk deletion and
individual add/delete operations cannot observe a partially removed list.
The lock is file-local and slow-path only.

Found during a static-analysis-assisted audit: candidate sites were
surfaced by a Coccinelle rule, and the reader/writer paths were
confirmed by LLM-assisted (GLM-5.3) code inspection. Due to a lack 
of hardware infrastructureThe issue was not observed at runtime.
It is identified by code inspection only.

Fixes: e284fc280473 ("i40e: Add and delete cloud filter")
Assisted-by: GLM-5.3 coccinelle
Signed-off-by: Binbin Deng <18983559317@163.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index a26c3d47ec15..f73a710f42f1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3740,6 +3740,8 @@ static struct i40e_vsi *i40e_find_vsi_from_seid(struct i40e_vf *vf, u16 seid)
  *
  * This function deletes all cloud filters
  **/
+static DEFINE_MUTEX(i40e_vf_cloud_filter_lock);
+
 static void i40e_del_all_cloud_filters(struct i40e_vf *vf)
 {
 	struct i40e_cloud_filter *cfilter = NULL;
@@ -3748,6 +3750,7 @@ static void i40e_del_all_cloud_filters(struct i40e_vf *vf)
 	struct hlist_node *node;
 	int ret;
 
+	mutex_lock(&i40e_vf_cloud_filter_lock);
 	hlist_for_each_entry_safe(cfilter, node,
 				  &vf->cloud_filter_list, cloud_node) {
 		vsi = i40e_find_vsi_from_seid(vf, cfilter->seid);
@@ -3773,6 +3776,7 @@ static void i40e_del_all_cloud_filters(struct i40e_vf *vf)
 		kfree(cfilter);
 		vf->num_cloud_filters--;
 	}
+	mutex_unlock(&i40e_vf_cloud_filter_lock);
 }
 
 /**
@@ -3856,6 +3860,7 @@ static int i40e_vc_del_cloud_filter(struct i40e_vf *vf, u8 *msg)
 	}
 
 	/* get the vsi to which the tc belongs to */
+	mutex_lock(&i40e_vf_cloud_filter_lock);
 	vsi = pf->vsi[vf->ch[vcf->action_meta].vsi_idx];
 	cfilter.seid = vsi->seid;
 	cfilter.flags = vcf->field_flags;
@@ -3870,6 +3875,7 @@ static int i40e_vc_del_cloud_filter(struct i40e_vf *vf, u8 *msg)
 			"VF %d: Failed to delete cloud filter, err %pe aq_err %s\n",
 			vf->vf_id, ERR_PTR(ret),
 			libie_aq_str(pf->hw.aq.asq_last_status));
+		mutex_unlock(&i40e_vf_cloud_filter_lock);
 		goto err;
 	}
 
@@ -3901,6 +3907,7 @@ static int i40e_vc_del_cloud_filter(struct i40e_vf *vf, u8 *msg)
 		kfree(cf);
 		vf->num_cloud_filters--;
 	}
+	mutex_unlock(&i40e_vf_cloud_filter_lock);
 
 err:
 	return i40e_vc_send_resp_to_vf(vf, VIRTCHNL_OP_DEL_CLOUD_FILTER,
@@ -4002,6 +4009,7 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf *vf, u8 *msg)
 	}
 
 	/* get the VSI to which the TC belongs to */
+	mutex_lock(&i40e_vf_cloud_filter_lock);
 	vsi = pf->vsi[vf->ch[vcf->action_meta].vsi_idx];
 	cfilter->seid = vsi->seid;
 	cfilter->flags = vcf->field_flags;
@@ -4016,6 +4024,7 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf *vf, u8 *msg)
 			"VF %d: Failed to add cloud filter, err %pe aq_err %s\n",
 			vf->vf_id, ERR_PTR(aq_ret),
 			libie_aq_str(pf->hw.aq.asq_last_status));
+		mutex_unlock(&i40e_vf_cloud_filter_lock);
 		goto err_free;
 	}
 
@@ -4024,6 +4033,7 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf *vf, u8 *msg)
 	/* release the pointer passing it to the collection */
 	cfilter = NULL;
 	vf->num_cloud_filters++;
+	mutex_unlock(&i40e_vf_cloud_filter_lock);
 err_free:
 	kfree(cfilter);
 err_out:
-- 
2.43.0

