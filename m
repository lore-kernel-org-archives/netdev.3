Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7F33D667E;
	Fri,  3 Apr 2026 19:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775245791; cv=none; b=rpILTVh/R5BhQuAWDKVSAermrmlBEnLQaXogQeIBhuOJHpyLHeKQIzcPkekO4Q11vCYRApUtOyrk3t+3CQeWCcS0M69QqFSCbDxbM5nXAsocsdMv0jKoX6azk9tC9/v/G7YSEHnW2hRxhps0lrbXosgyRqjTg+Ye9jO1s1QUp7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775245791; c=relaxed/simple;
	bh=mDmSvi5f7rq7k0pVns0FS2PuX9b+yA0VP9WOnPtmpe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ah9w2vMLM1r/9w4ELnWdW4xr1g+3GiLgC2TfKIljIpRqd/WRCeg+JCmBBxXRcopNBBHPyy5pBUo432kcxvIBapbXuGD/N7MMBPrU0x3ISFP70ZNVMHLkYZc832ONA0aIUlwHqweujMx/tdGAp1ZG2uwm+Z3ZmWePwcw5qhxEkbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZHKZVwT5; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZHKZVwT5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775245789; x=1806781789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mDmSvi5f7rq7k0pVns0FS2PuX9b+yA0VP9WOnPtmpe0=;
  b=ZHKZVwT5OkakcMFavnQ+MVYL0jV+Xa/rY4f43+W04b249qffwgLiH8pw
   c6I0CRTMunJcQzydYf/0XJX2KBS9x8K7k97iJ6P3el8V8T4xYuUoNdwVR
   6rp2l2h6yw8WUDKw0J+paxUHXGTEKsvDGFkW+xhtuEk8AOwRsbSnRbLtp
   yTtzxg8yRqGvL+MAXz/HCxedM80aqWkKJUoBGSet6sG8SWTIHbEq1mKPP
   3YUZ8w31xg5toknv5QsVRGV5VN8NFn4+a1J+Q/ODdu6NKIdyEXnnMXPNm
   pho9ibbyubbC2eubRrV1/NbZeNKLzg+Dexe3V4tJQXaSti44OvXRXc4nz
   w==;
X-CSE-ConnectionGUID: wXWx4FwRTXKTgc1fWqLDKQ==
X-CSE-MsgGUID: an08lAeaTZm1w9LuhiocuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="76428791"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="76428791"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 12:49:45 -0700
X-CSE-ConnectionGUID: 6V99/RMARSmFxbbT3O5Qpg==
X-CSE-MsgGUID: dV6my+btS8qJYsXOJS4nMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="265266128"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 03 Apr 2026 12:49:45 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Pavan Kumar Linga <madhu.chittim@intel.com>,
	anthony.l.nguyen@intel.com,
	larysa.zaremba@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	sridhar.samudrala@intel.com,
	anjali.singhai@intel.com,
	michal.swiatkowski@linux.intel.com,
	maciej.fijalkowski@intel.com,
	emil.s.tantilov@intel.com,
	joshua.a.hay@intel.com,
	jacob.e.keller@intel.com,
	jayaprakash.shanmugam@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	corbet@lwn.net,
	richardcochran@gmail.com,
	linux-doc@vger.kernel.org,
	Samuel Salin <Samuel.salin@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v2 06/14] idpf: remove 'vport_params_reqd' field
Date: Fri,  3 Apr 2026 12:49:28 -0700
Message-ID: <20260403194938.3577011-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260403194938.3577011-1-anthony.l.nguyen@intel.com>
References: <20260403194938.3577011-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

While sending a create vport message to the device control plane, a create
vport virtchnl message is prepared with all the required info to initialize
the vport. This info is stored in the adapter struct but never used
thereafter. So, remove the said field.

Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        |  2 --
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  2 --
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 30 +++++++------------
 3 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 3a3dc9892d16..0d08f51be7e3 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -638,7 +638,6 @@ struct idpf_vc_xn_manager;
  * @avail_queues: Device given queue limits
  * @vports: Array to store vports created by the driver
  * @netdevs: Associated Vport netdevs
- * @vport_params_reqd: Vport params requested
  * @vport_params_recvd: Vport params received
  * @vport_ids: Array of device given vport identifiers
  * @singleq_pt_lkup: Lookup table for singleq RX ptypes
@@ -697,7 +696,6 @@ struct idpf_adapter {
 	struct idpf_avail_queue_info avail_queues;
 	struct idpf_vport **vports;
 	struct net_device **netdevs;
-	struct virtchnl2_create_vport **vport_params_reqd;
 	struct virtchnl2_create_vport **vport_params_recvd;
 	u32 *vport_ids;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index cf966fe6c759..d88ca59edf97 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1109,8 +1109,6 @@ static void idpf_vport_rel(struct idpf_vport *vport)
 
 	kfree(adapter->vport_params_recvd[idx]);
 	adapter->vport_params_recvd[idx] = NULL;
-	kfree(adapter->vport_params_reqd[idx]);
-	adapter->vport_params_reqd[idx] = NULL;
 
 	kfree(vport);
 	adapter->num_alloc_vports--;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 113ecfc16dd7..c45a788bb9cb 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -1555,14 +1555,10 @@ int idpf_send_create_vport_msg(struct idpf_adapter *adapter,
 	ssize_t reply_sz;
 
 	buf_size = sizeof(struct virtchnl2_create_vport);
-	if (!adapter->vport_params_reqd[idx]) {
-		adapter->vport_params_reqd[idx] = kzalloc(buf_size,
-							  GFP_KERNEL);
-		if (!adapter->vport_params_reqd[idx])
-			return -ENOMEM;
-	}
+	vport_msg = kzalloc(buf_size, GFP_KERNEL);
+	if (!vport_msg)
+		return -ENOMEM;
 
-	vport_msg = adapter->vport_params_reqd[idx];
 	vport_msg->vport_type = cpu_to_le16(VIRTCHNL2_VPORT_TYPE_DEFAULT);
 	vport_msg->vport_index = cpu_to_le16(idx);
 
@@ -1579,8 +1575,7 @@ int idpf_send_create_vport_msg(struct idpf_adapter *adapter,
 	err = idpf_vport_calc_total_qs(adapter, idx, vport_msg, max_q);
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Enough queues are not available");
-
-		return err;
+		goto rel_buf;
 	}
 
 	if (!adapter->vport_params_recvd[idx]) {
@@ -1588,7 +1583,7 @@ int idpf_send_create_vport_msg(struct idpf_adapter *adapter,
 							   GFP_KERNEL);
 		if (!adapter->vport_params_recvd[idx]) {
 			err = -ENOMEM;
-			goto free_vport_params;
+			goto rel_buf;
 		}
 	}
 
@@ -1604,13 +1599,15 @@ int idpf_send_create_vport_msg(struct idpf_adapter *adapter,
 		goto free_vport_params;
 	}
 
+	kfree(vport_msg);
+
 	return 0;
 
 free_vport_params:
 	kfree(adapter->vport_params_recvd[idx]);
 	adapter->vport_params_recvd[idx] = NULL;
-	kfree(adapter->vport_params_reqd[idx]);
-	adapter->vport_params_reqd[idx] = NULL;
+rel_buf:
+	kfree(vport_msg);
 
 	return err;
 }
@@ -3416,8 +3413,6 @@ static void idpf_vport_params_buf_rel(struct idpf_adapter *adapter)
 {
 	kfree(adapter->vport_params_recvd);
 	adapter->vport_params_recvd = NULL;
-	kfree(adapter->vport_params_reqd);
-	adapter->vport_params_reqd = NULL;
 	kfree(adapter->vport_ids);
 	adapter->vport_ids = NULL;
 }
@@ -3432,15 +3427,10 @@ static int idpf_vport_params_buf_alloc(struct idpf_adapter *adapter)
 {
 	u16 num_max_vports = idpf_get_max_vports(adapter);
 
-	adapter->vport_params_reqd = kzalloc_objs(*adapter->vport_params_reqd,
-						  num_max_vports);
-	if (!adapter->vport_params_reqd)
-		return -ENOMEM;
-
 	adapter->vport_params_recvd = kzalloc_objs(*adapter->vport_params_recvd,
 						   num_max_vports);
 	if (!adapter->vport_params_recvd)
-		goto err_mem;
+		return -ENOMEM;
 
 	adapter->vport_ids = kcalloc(num_max_vports, sizeof(u32), GFP_KERNEL);
 	if (!adapter->vport_ids)
-- 
2.47.1

