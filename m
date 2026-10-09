Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121744D90AF
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 12:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548136; cv=none; b=UwPPCpMTRwSvPTsvPv1Su+KFDZYMoIFB9M0fEbS6dH5Vey64FfX24G/Fe5SUIMICijXgmalqbWXZFX1W9t9Hn/Q5fvE17WvqArYhiHx81NgM+s9YlGXzxZozmzw79jlUMkoM82Wj7aJilZf7C6lq7Td5GrfZdQa9H80oLP07mY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548136; c=relaxed/simple;
	bh=zyyW0JPRXHnAAlCqzXSVcYnysy8XihclFhCJgKDu+Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRwjhHEy2wlhM8/+9hKaY57p0QfpdKENILfVCs740+yNhiX+oTPjSmMCnhuGqzgP1OxzbuAMfuHemqBQ5c5Zl1hXHralXO5NGGDNkU2wWDa7d/b+6Jz6RPCkWj337ggLwdtl78L4FoT2CpCsCA3jHuHJG0MzKrxIB7prVHbA7/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n0h3reo1; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n0h3reo1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791548124; x=1823084124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zyyW0JPRXHnAAlCqzXSVcYnysy8XihclFhCJgKDu+Bs=;
  b=n0h3reo1Uwk4uslbmYCb43FlMl5qIEsRvVNScJN0EbRwlsdKaQ1jbYNk
   b5eAGiXuYlAxEg8JE8pEGfbVPcJHSNtcZGLKZm59iJgZdZYFGTX9qVdn/
   66PnZuqEWP1TwwYai1FqhxQ1BqUPTrsPiIpz9SgKpYCjWbvipGHoyRzzV
   37d5IoMZE/DS3C15E8qorPs0aStIB5GqvF71o0AI0mgXrSVFYX8Nq5dqd
   j46Yrl4R+WklSDWKP8/AIirEO58vwyLvup5zSWGqNSFQAwrxD/YWXktGc
   K4ybad0SBC1dDGpOPi/rbctD3Q8oJ6HbgQf/t3JTVH7k3F1SsS2ayR2tg
   g==;
X-CSE-ConnectionGUID: eHoKF21TT2ayBQPEL73ABA==
X-CSE-MsgGUID: csaX8jX1T2K54LkRpA7Xpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="251181"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="251181"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 05:15:00 -0700
X-CSE-ConnectionGUID: gO7Schk2T4u434qH6QrYkw==
X-CSE-MsgGUID: T9mMVtAzRUi8ZJzI3L7Fyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="420453"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa002.fm.intel.com with ESMTP; 09 Oct 2026 05:14:56 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.245.238])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 081442FC41;
	Fri,  9 Oct 2026 13:14:53 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	edumazet@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
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
Subject: [PATCH net-next v2 08/14] iavf: temporary rename of IAVF_MAX_REQ_QUEUES to IAVF_MAX_REQ_QUEUES_VCV1
Date: Fri,  9 Oct 2026 14:04:19 +0200
Message-ID: <20261009121433.30347-9-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
References: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
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

