Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117D748CD53;
	Wed, 12 Aug 2026 21:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786569988; cv=none; b=cSuBda6rtO1uE6I3sxenIAYNUNrB1VWSr5o0+CYa5cyzEFmq7MU5dLqXcnRe8Pdtz5JNGPPBcoIBR6gneqlO7X8O0+QR62kMrcSv8b1IEgwqqH+dQY3kGeRvkzi4Z80dZSZoYXiKoFNy1yjHj+kD0VvbLihtynQHwbEYdhGmWec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786569988; c=relaxed/simple;
	bh=3IsthBo0Tx9gAVJ9+ChLbBu8DLiIuymuQHdwtlqVJi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2pSWkdADvqzQGKf5DcFwJSkTSJaYdd1kxOEXyeS4bzOaaPXe+suF8l7UAyk8I9m+zVgJamWri9f/KVVJn/yBbfBp8Df40ZnD2U4luhNpUPJ+xtoo5VCRuggOP/TnamdUMcUSjywJRbLM0oL6cXrKNQdfL7EwptmSH7HR0e6KHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PVjgfZcX; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PVjgfZcX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786569972; x=1818105972;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3IsthBo0Tx9gAVJ9+ChLbBu8DLiIuymuQHdwtlqVJi4=;
  b=PVjgfZcXQMTHTQAx3KIqgtFy/J+EQXVFsoaIaOx59c7Sr2TSrjSg1FYr
   +9G9PjX6w+ePg3Omf6lmazyMx+rH+oZfQQm+Na0Ilrq7UCvV2CVLv3qzB
   h023LCR2mByJ2K+og0XAqRydua27xzjVJ2tXR0pgC4Ci2FDAwV5+4UpLW
   QVxfLa9yp9xRBgiMUb+6o9vBbaYZwxmsV4XQ3s6MgFk10CFxguEHm8QmN
   Bi60IAKWHYQBH7ZmLIoBaicIhOamg9Rq54YWICy2fAuhh6Ap4Ow+vqAGB
   Z8G9jc73gnX64LM0+Q0il7Jy/gs6KIvLnspwyguKVHcACAq26oEG0KZtg
   g==;
X-CSE-ConnectionGUID: izLIWAfgTsWgX1ojbY5OGQ==
X-CSE-MsgGUID: RQAAN/rzT9qMLfJ1wiuXNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="97485567"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="97485567"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 14:25:40 -0700
X-CSE-ConnectionGUID: v6U6OILiSA+HkrjAbWkM7w==
X-CSE-MsgGUID: oUok/MraRR2zuyQWMLE4Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="257546248"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 12 Aug 2026 14:25:40 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	sridhar.samudrala@intel.com,
	michal.swiatkowski@linux.intel.com,
	maciej.fijalkowski@intel.com,
	emil.s.tantilov@intel.com,
	madhu.chittim@intel.com,
	joshua.a.hay@intel.com,
	jacob.e.keller@intel.com,
	jayaprakash.shanmugam@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	corbet@lwn.net,
	richardcochran@gmail.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next v8 07/15] idpf: remove unused code for getting RSS info from device
Date: Wed, 12 Aug 2026 14:25:21 -0700
Message-ID: <20260812212532.905873-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260812212532.905873-1-anthony.l.nguyen@intel.com>
References: <20260812212532.905873-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Larysa Zaremba <larysa.zaremba@intel.com>

idpf_send_get_set_rss_lut_msg() and idpf_send_get_set_rss_key_msg() do not
handle the get=true path properly. Response validation is insufficient,
memcpy size is wrong, LE-to-CPU conversion is missing. Fortunately, those
functions are never used with get=true. Given how broken this dead code is,
it is unlikely to be useful in the future.

Rename idpf_send_get_set_rss_lut_msg() to idpf_send_set_rss_lut_msg(),
idpf_send_get_set_rss_key_msg() to idpf_send_set_rss_key_msg(), remove the
get parameter and remove all get=true cases from the function.

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |   4 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 107 +++---------------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  10 +-
 3 files changed, 22 insertions(+), 99 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 99fcd8e298d6..c3ffb445297f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4676,11 +4676,11 @@ int idpf_config_rss(struct idpf_vport *vport, struct idpf_rss_data *rss_data)
 	u32 vport_id = vport->vport_id;
 	int err;
 
-	err = idpf_send_get_set_rss_key_msg(adapter, rss_data, vport_id, false);
+	err = idpf_send_set_rss_key_msg(adapter, rss_data, vport_id);
 	if (err)
 		return err;
 
-	return idpf_send_get_set_rss_lut_msg(adapter, rss_data, vport_id, false);
+	return idpf_send_set_rss_lut_msg(adapter, rss_data, vport_id);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index c4a128a114a5..21cf9bbb917b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -2848,29 +2848,26 @@ int idpf_send_get_stats_msg(struct idpf_netdev_priv *np,
 }
 
 /**
- * idpf_send_get_set_rss_lut_msg - Send virtchnl get or set RSS lut message
+ * idpf_send_set_rss_lut_msg - Send virtchnl set RSS lut message
  * @adapter: adapter pointer used to send virtchnl message
  * @rss_data: pointer to RSS key and lut info
  * @vport_id: vport identifier used while preparing the virtchnl message
- * @get: flag to set or get RSS look up table
  *
- * When rxhash is disabled, RSS LUT will be configured with zeros.  If rxhash
+ * When rxhash is disabled, RSS LUT will be configured with zeros. If rxhash
  * is enabled, the LUT values stored in driver's soft copy will be used to setup
  * the HW.
  *
  * Return: 0 on success, negative on failure.
  */
-int idpf_send_get_set_rss_lut_msg(struct idpf_adapter *adapter,
-				  struct idpf_rss_data *rss_data,
-				  u32 vport_id, bool get)
+int idpf_send_set_rss_lut_msg(struct idpf_adapter *adapter,
+			      struct idpf_rss_data *rss_data, u32 vport_id)
 {
-	struct virtchnl2_rss_lut *recv_rl __free(kfree) = NULL;
 	struct virtchnl2_rss_lut *rl __free(kfree) = NULL;
 	struct idpf_vc_xn_params xn_params = {};
-	int buf_size, lut_buf_size;
 	struct idpf_vport *vport;
 	ssize_t reply_sz;
 	bool rxhash_ena;
+	int buf_size;
 	int i;
 
 	vport = idpf_vid_to_vport(adapter, vport_id);
@@ -2889,72 +2886,34 @@ int idpf_send_get_set_rss_lut_msg(struct idpf_adapter *adapter,
 	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
 	xn_params.send_buf.iov_base = rl;
 	xn_params.send_buf.iov_len = buf_size;
+	xn_params.vc_op = VIRTCHNL2_OP_SET_RSS_LUT;
 
-	if (get) {
-		recv_rl = kzalloc(IDPF_CTLQ_MAX_BUF_LEN, GFP_KERNEL);
-		if (!recv_rl)
-			return -ENOMEM;
-		xn_params.vc_op = VIRTCHNL2_OP_GET_RSS_LUT;
-		xn_params.recv_buf.iov_base = recv_rl;
-		xn_params.recv_buf.iov_len = IDPF_CTLQ_MAX_BUF_LEN;
-	} else {
-		rl->lut_entries = cpu_to_le16(rss_data->rss_lut_size);
-		for (i = 0; i < rss_data->rss_lut_size; i++)
-			rl->lut[i] = rxhash_ena ?
-				cpu_to_le32(rss_data->rss_lut[i]) : 0;
+	rl->lut_entries = cpu_to_le16(rss_data->rss_lut_size);
+	for (i = 0; i < rss_data->rss_lut_size; i++)
+		rl->lut[i] = rxhash_ena ? cpu_to_le32(rss_data->rss_lut[i]) : 0;
 
-		xn_params.vc_op = VIRTCHNL2_OP_SET_RSS_LUT;
-	}
 	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
 	if (reply_sz < 0)
 		return reply_sz;
-	if (!get)
-		return 0;
-	if (reply_sz < sizeof(struct virtchnl2_rss_lut))
-		return -EIO;
-
-	lut_buf_size = le16_to_cpu(recv_rl->lut_entries) * sizeof(u32);
-	if (reply_sz < lut_buf_size)
-		return -EIO;
-
-	/* size didn't change, we can reuse existing lut buf */
-	if (rss_data->rss_lut_size == le16_to_cpu(recv_rl->lut_entries))
-		goto do_memcpy;
-
-	rss_data->rss_lut_size = le16_to_cpu(recv_rl->lut_entries);
-	kfree(rss_data->rss_lut);
-
-	rss_data->rss_lut = kzalloc(lut_buf_size, GFP_KERNEL);
-	if (!rss_data->rss_lut) {
-		rss_data->rss_lut_size = 0;
-		return -ENOMEM;
-	}
-
-do_memcpy:
-	memcpy(rss_data->rss_lut, recv_rl->lut, rss_data->rss_lut_size);
 
 	return 0;
 }
 
 /**
- * idpf_send_get_set_rss_key_msg - Send virtchnl get or set RSS key message
+ * idpf_send_set_rss_key_msg - Send virtchnl set RSS key message
  * @adapter: adapter pointer used to send virtchnl message
  * @rss_data: pointer to RSS key and lut info
  * @vport_id: vport identifier used while preparing the virtchnl message
- * @get: flag to set or get RSS look up table
  *
  * Return: 0 on success, negative on failure
  */
-int idpf_send_get_set_rss_key_msg(struct idpf_adapter *adapter,
-				  struct idpf_rss_data *rss_data,
-				  u32 vport_id, bool get)
+int idpf_send_set_rss_key_msg(struct idpf_adapter *adapter,
+			      struct idpf_rss_data *rss_data, u32 vport_id)
 {
-	struct virtchnl2_rss_key *recv_rk __free(kfree) = NULL;
 	struct virtchnl2_rss_key *rk __free(kfree) = NULL;
 	struct idpf_vc_xn_params xn_params = {};
 	ssize_t reply_sz;
 	int i, buf_size;
-	u16 key_size;
 
 	buf_size = struct_size(rk, key_flex, rss_data->rss_key_size);
 	rk = kzalloc(buf_size, GFP_KERNEL);
@@ -2965,49 +2924,15 @@ int idpf_send_get_set_rss_key_msg(struct idpf_adapter *adapter,
 	xn_params.send_buf.iov_base = rk;
 	xn_params.send_buf.iov_len = buf_size;
 	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
-	if (get) {
-		recv_rk = kzalloc(IDPF_CTLQ_MAX_BUF_LEN, GFP_KERNEL);
-		if (!recv_rk)
-			return -ENOMEM;
-
-		xn_params.vc_op = VIRTCHNL2_OP_GET_RSS_KEY;
-		xn_params.recv_buf.iov_base = recv_rk;
-		xn_params.recv_buf.iov_len = IDPF_CTLQ_MAX_BUF_LEN;
-	} else {
-		rk->key_len = cpu_to_le16(rss_data->rss_key_size);
-		for (i = 0; i < rss_data->rss_key_size; i++)
-			rk->key_flex[i] = rss_data->rss_key[i];
+	xn_params.vc_op = VIRTCHNL2_OP_SET_RSS_KEY;
 
-		xn_params.vc_op = VIRTCHNL2_OP_SET_RSS_KEY;
-	}
+	rk->key_len = cpu_to_le16(rss_data->rss_key_size);
+	for (i = 0; i < rss_data->rss_key_size; i++)
+		rk->key_flex[i] = rss_data->rss_key[i];
 
 	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
 	if (reply_sz < 0)
 		return reply_sz;
-	if (!get)
-		return 0;
-	if (reply_sz < sizeof(struct virtchnl2_rss_key))
-		return -EIO;
-
-	key_size = min_t(u16, NETDEV_RSS_KEY_LEN,
-			 le16_to_cpu(recv_rk->key_len));
-	if (reply_sz < key_size)
-		return -EIO;
-
-	/* key len didn't change, reuse existing buf */
-	if (rss_data->rss_key_size == key_size)
-		goto do_memcpy;
-
-	rss_data->rss_key_size = key_size;
-	kfree(rss_data->rss_key);
-	rss_data->rss_key = kzalloc(key_size, GFP_KERNEL);
-	if (!rss_data->rss_key) {
-		rss_data->rss_key_size = 0;
-		return -ENOMEM;
-	}
-
-do_memcpy:
-	memcpy(rss_data->rss_key, recv_rk->key_flex, rss_data->rss_key_size);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index 5f8ae8c5be20..e0c319bd9f38 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -208,12 +208,10 @@ int idpf_send_ena_dis_loopback_msg(struct idpf_adapter *adapter, u32 vport_id,
 int idpf_send_get_stats_msg(struct idpf_netdev_priv *np,
 			    struct idpf_port_stats *port_stats);
 int idpf_send_set_sriov_vfs_msg(struct idpf_adapter *adapter, u16 num_vfs);
-int idpf_send_get_set_rss_key_msg(struct idpf_adapter *adapter,
-				  struct idpf_rss_data *rss_data,
-				  u32 vport_id, bool get);
-int idpf_send_get_set_rss_lut_msg(struct idpf_adapter *adapter,
-				  struct idpf_rss_data *rss_data,
-				  u32 vport_id, bool get);
+int idpf_send_set_rss_key_msg(struct idpf_adapter *adapter,
+			      struct idpf_rss_data *rss_data, u32 vport_id);
+int idpf_send_set_rss_lut_msg(struct idpf_adapter *adapter,
+			      struct idpf_rss_data *rss_data, u32 vport_id);
 void idpf_vc_xn_shutdown(struct idpf_vc_xn_manager *vcxn_mngr);
 int idpf_idc_rdma_vc_send_sync(struct iidc_rdma_core_dev_info *cdev_info,
 			       u8 *send_msg, u16 msg_size,
-- 
2.47.1

