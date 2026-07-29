Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5310941A4FE;
	Wed, 29 Jul 2026 20:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785357932; cv=none; b=Vd3EJHY1kaocDwKfyN1ygKcEsACgD0rjL696VMHQ1q9J1PNX03b3aRjoOWA01mThX3V1MNOUPu4oe66lvxOVKroFzYOh44YPMXfEXXTZzEjaIB5bPQ+1cgaSIX3lRE2uW3KxsK6L5DVssW1uq+IwLiT6lepj17PMMhO92D01mEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785357932; c=relaxed/simple;
	bh=oA82n15PWldsjXF7KNMcuABB+uy8gm2dGtRrXXKHdrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DpC/iapI1oo7gpleY8yy/cPJdYCEO4Z1iKRH2QR0Uaa/8b+dypY24dCf985sQzMLLiNP9N7r5cnzv8ttR+9vi2P0wdeBchAMLURjCZ9lPtnQ08m/qWxO2hU9dFI0ZznVPP7Med+ZzNI1AZ8K95jWowIopxLQ+z9rhFl1yV84WjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rls+IOji; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rls+IOji"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785357927; x=1816893927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oA82n15PWldsjXF7KNMcuABB+uy8gm2dGtRrXXKHdrw=;
  b=Rls+IOjiGlDWXEQJb0Xuia6uTkWaEN77DVhbjD9ohbt5B0nVMXGf/aZQ
   EUSoL+uqE5YsXjYCMqZ5SKtcRlMnT2VmAKA+iSZifvdEb9/O800w0Piny
   N3bTvbEOYAj3Gb8MDXTlirvLEmjgewrhuKZUcwZ2V5HAE4BGL4hJn5gLW
   QJR+BOZnHxQoi/8ZYMjH3B9WozuwjTbuuivpXfZ49e+hcsndX8Sxna8FX
   gl0R66r1bKymy/KLjAm/MK//a1V9JWSbDZEfc6QBt/3sLa371amON87ey
   bLf5iOxJE4Kh2rQjAMbhjW95VaGgX6/1YM9q45lRONhQ9HWFqQ56gldvf
   A==;
X-CSE-ConnectionGUID: 6qDA6zbJQbm31Ui3zF5vGQ==
X-CSE-MsgGUID: ts8ZsBnMQSKUx0zU1cV7TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="84952419"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="84952419"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 13:45:10 -0700
X-CSE-ConnectionGUID: uJqOI+bzSU2QqWXJDVdQUw==
X-CSE-MsgGUID: ORqti9//SA6QTmQKvfGi4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="264381352"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 29 Jul 2026 13:45:10 -0700
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
Subject: [PATCH net-next v6 07/15] idpf: remove unused code for getting RSS info from device
Date: Wed, 29 Jul 2026 13:44:54 -0700
Message-ID: <20260729204505.3373950-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260729204505.3373950-1-anthony.l.nguyen@intel.com>
References: <20260729204505.3373950-1-anthony.l.nguyen@intel.com>
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
index 566b08ca3a6c..1625fb10ac93 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4679,11 +4679,11 @@ int idpf_config_rss(struct idpf_vport *vport, struct idpf_rss_data *rss_data)
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
index 39c321db0661..39f227196df8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -2847,29 +2847,26 @@ int idpf_send_get_stats_msg(struct idpf_netdev_priv *np,
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
@@ -2888,72 +2885,34 @@ int idpf_send_get_set_rss_lut_msg(struct idpf_adapter *adapter,
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
@@ -2964,49 +2923,15 @@ int idpf_send_get_set_rss_key_msg(struct idpf_adapter *adapter,
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
index 972dd88cf3d2..7210dc7b426b 100644
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

