Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CAA566C58
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 18:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792090543; cv=none; b=Dr9M9QONQYdaYeORziXlUOBSMyDwbTWVVhUWHL9k6zLLy7ke4wDsly0f7UAsRxTfJVMRCaokC19XIQVKksAhNKVfpgWJXaxf3qPO0HJhC1NDmUz/azliuhR0B1N2oe7mucLgmJH7g9MMG8Heyqd3QxXBv/ZVQE58ZtRWNpch4oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792090543; c=relaxed/simple;
	bh=zyyW0JPRXHnAAlCqzXSVcYnysy8XihclFhCJgKDu+Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=poK10pzy2/dt8BeBJMEIa15x9LHF2w1mtGoxI52ppBHk/4WuAlCTPWQIVnwz324QY08cfyOd8ireloRX1GqYkuQGbpNfcDM4+yvjq9xsKPF9d39RqVbWQfbLnvOCPJ/ksCBpEc75fYy9FFDKj6LTe0YF15a4AIDIDl5Q+e+TWOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U1nWwnou; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U1nWwnou"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792090537; x=1823626537;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zyyW0JPRXHnAAlCqzXSVcYnysy8XihclFhCJgKDu+Bs=;
  b=U1nWwnou7M2OVxIW9e4e4YiqX1VPii6456VmCG4zoNh6e4/2treL+CzG
   CG1vOlceUZAlE4pekHWpbs6ppKwG6iqyx7++D1JiFzwkDoAoIGUK/M+6Z
   Wx4sEZbmDDHAZqLKfPx+ojo4mUyIiOpxzWRAjD4tctvYlWCCD0rg/H+Od
   ekehHkiXnhaKbmtnZfMd3UTJShM26GN27bPDh+wtMMJiOe39bbzrCvmp1
   JAW01yZ2IQb2LU+JHjInc+4Uvy/lTVCtrIbNU83+5k6LG5QlNW7bbJB4Y
   s4Sh4K2n5Nr6GVqEnApol1EAx4OwapA5NpyjrgvzYOk3MfxD6aYYseQUb
   g==;
X-CSE-ConnectionGUID: gMKLEchPRU2jb95/fMe2oA==
X-CSE-MsgGUID: 7Bxx4c0ORHyidR0IS40O3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="758019"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="758019"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 11:55:26 -0700
X-CSE-ConnectionGUID: e6pPqO8JRCiGsdgzUvngPQ==
X-CSE-MsgGUID: BJbTmU1PRYWOyVnlrQGtbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2003164"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 15 Oct 2026 11:55:21 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.244.208])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 95DC632EC6;
	Thu, 15 Oct 2026 19:55:19 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	edumazet@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	andrew+netdev@lunn.ch,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	leon@kernel.org,
	mbloch@nvidia.com,
	jacob.e.keller@intel.com,
	jedrzej.jagielski@intel.com,
	anzaki@gmail.com,
	brett.creeley@amd.com,
	jtornosm@redhat.com,
	ohartoov@nvidia.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v3 08/15] iavf: temporary rename of IAVF_MAX_REQ_QUEUES to IAVF_MAX_REQ_QUEUES_VCV1
Date: Thu, 15 Oct 2026 20:51:19 +0200
Message-ID: <20261015185454.6332-9-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20261015185454.6332-1-przemyslaw.kitszel@intel.com>
References: <20261015185454.6332-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename IAVF_MAX_REQ_QUEUES to IAVF_MAX_REQ_QUEUES_VCV1, in preparation for
the next patch that will extend the max to 256, using old value of 16 for
the "v1" variant of virtchnl opcodes.

Suggested-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h          |  3 ++-
 drivers/net/ethernet/intel/iavf/iavf_main.c     |  2 +-
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 10 +++++-----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 8c45536fd502..94ee18058115 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -87,7 +87,8 @@ struct iavf_vsi {
 #define IAVF_TX_DESC(R, i) (&(((struct iavf_tx_desc *)((R)->desc))[i]))
 #define IAVF_TX_CTXTDESC(R, i) \
 	(&(((struct iavf_tx_context_desc *)((R)->desc))[i]))
-#define IAVF_MAX_REQ_QUEUES 16
+/* for "old" virtchnl opcodes that accept up to 16 queues */
+#define IAVF_MAX_REQ_QUEUES_VCV1	16
 
 #define IAVF_HKEY_ARRAY_SIZE ((IAVF_VFQF_HKEY_MAX_INDEX + 1) * 4)
 #define IAVF_HLUT_ARRAY_SIZE ((IAVF_VFQF_HLUT_MAX_INDEX + 1) * 4)
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 2f8a80a11336..bb239e99e450 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -5370,7 +5370,7 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_set_master(pdev);
 
 	netdev = alloc_etherdev_mq(sizeof(struct iavf_adapter),
-				   IAVF_MAX_REQ_QUEUES);
+				   IAVF_MAX_REQ_QUEUES_VCV1);
 	if (!netdev) {
 		err = -ENOMEM;
 		goto err_alloc_etherdev;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 67d797a1003f..630a551c7566 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -268,19 +268,19 @@ int iavf_send_vf_ptp_caps_msg(struct iavf_adapter *adapter)
  **/
 static void iavf_validate_num_queues(struct iavf_adapter *adapter)
 {
-	if (adapter->vf_res->num_queue_pairs > IAVF_MAX_REQ_QUEUES) {
+	if (adapter->vf_res->num_queue_pairs > IAVF_MAX_REQ_QUEUES_VCV1) {
 		struct virtchnl_vsi_resource *vsi_res;
 		int i;
 
 		dev_info(&adapter->pdev->dev, "Received %d queues, but can only have a max of %d\n",
 			 adapter->vf_res->num_queue_pairs,
-			 IAVF_MAX_REQ_QUEUES);
+			 IAVF_MAX_REQ_QUEUES_VCV1);
 		dev_info(&adapter->pdev->dev, "Fixing by reducing queues to %d\n",
-			 IAVF_MAX_REQ_QUEUES);
-		adapter->vf_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES;
+			 IAVF_MAX_REQ_QUEUES_VCV1);
+		adapter->vf_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES_VCV1;
 		for (i = 0; i < adapter->vf_res->num_vsis; i++) {
 			vsi_res = &adapter->vf_res->vsi_res[i];
-			vsi_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES;
+			vsi_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES_VCV1;
 		}
 	}
 }
-- 
2.51.1

