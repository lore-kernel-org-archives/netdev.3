Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716797;
	b=aGLI+GNiaeKRPWjRwRZClDgGhsfDwZiS1UP5AyVFjzL682Xsi5mPnXdO3eIDCW6iPBYl
	 Lz+jyS2WPEBSpgqbXz+ApmneTeCqUzvK9OmJseAZB/PSrZmHDN0mPrg1Q16gLMsUYltWs
	 xByLqeWhZSsTy4U+XlB9qxn4/aGBawCIgRahD9qu92ueMrmGlUB5HBQ/7BCJAPl9sXn1Z
	 mgDvOonfDnuM+xCyskTSUuXkBHOZr2LxtFK7yxepY0x0wB/NlPJCKnL5Uw3jqERp3ZORQ
	 3a7xlNkDeokif3CinYtPRNku3FBbKmlVQj98BHOj2TQiOoYv/gIJZRPoLjXgzoeTuYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716797;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VvGYg4RKOcZoCIDjAJMuLObnilI7z0KtFsIeC3rNVvU=;
	b=Jvex9gwwtvUC8XyT8223P4HtHDNUCtwvOyH0PkyLZRgj1imU4ery7uIyix66rc4kitiV
	 phGp8qIvdaJNd9ocSuHEiaPKbk30e57W+ws/h+uk3B2K/orqrYciaePNS3L5Cysx6GJ9S
	 91qFNelmbCWBkocXccmMqt9Gza8s3dlRSQwiV99WW6ZSAFrK/2sSeSi4Vi8ck1YSY6nwo
	 DkN/jUNdR4PYwxNKn10rf5vzMrCkvDuffVPdknYy9Ro5yf4SjGbc7DkyA5TL3YSdtZS/8
	 DGmBsMg3DIk5DF+azY7MgKYSUELjQGg9KiECmqBkQv22hMMSFwdFsl0RyXKG1Pdi3Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="E9ricl/l";
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434C3606A32F
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 434C3606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E9ricl/l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793716797; x=1825252797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ha6+beWen/HzF3HGCwu4M8XZKad/MO6jy85k6q7op0E=;
  b=E9ricl/lm4EgPLFa629q0d9Z274m/giixSmsm+Ci7lsmCAJaOohIokTr
   i4lu7EAINq1QQLZW1eenGfEGlZ8FuK1p0YZpmYDEUs1QixgQk7dnI/BIy
   SbdTtZ81J9nUsmGWVQHi+Rg/E/OPOwvnp3ufGbY+14LPcHfmK4MsabUo+
   5uQrVbIA9HajsS5t8p0Jt2lC2QAVBA/0ynsTrv7WlGOk2/zEXiIXhQXj7
   TaQb2JXSQLtgbtXq8Uh5uuJzhk3NGewUmlAIa7KgJrYRWM3Uei4WpJ8v5
   vKcJbOEp4iXI54reKcMBMCAc7XJ9X6HoamExnlpiYDyMxlnwAnbQ18hP5
   Q==;
X-CSE-ConnectionGUID: K174Lrr0RlGptaABZY0HiA==
X-CSE-MsgGUID: K77VTV66SBmCqCQ9hsnvGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2324052"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2324052"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 06:39:57 -0800
X-CSE-ConnectionGUID: z7N/AhrPRmCxNVeZAUOubA==
X-CSE-MsgGUID: VPGlCdThR+ebnnU/j65/eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="8289938"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa013.fm.intel.com with ESMTP; 03 Nov 2026 06:39:52 -0800
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id E013F312EA;
	Tue,  3 Nov 2026 14:39:49 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org,
	Simon Horman <horms@kernel.org>,
	Michal Schmidt <mschmidt@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	bruce.richardson@intel.com,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
	padraig.j.connolly@intel.com,
	ananth.s@intel.com,
	timothy.miskell@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v4 08/15] iavf: temporary rename of IAVF_MAX_REQ_QUEUES to IAVF_MAX_REQ_QUEUES_VCV1
Date: Tue,  3 Nov 2026 15:14:49 +0100
Message-ID: <20261103141646.303620-9-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103141646.303620-1-przemyslaw.kitszel@intel.com>
References: <20261103141646.303620-1-przemyslaw.kitszel@intel.com>
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
index a41d2726ebd8..053f34c4f710 100644
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
index d39737dcd425..822d6e692d49 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -5371,7 +5371,7 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_set_master(pdev);
 
 	netdev = alloc_etherdev_mq(sizeof(struct iavf_adapter),
-				   IAVF_MAX_REQ_QUEUES);
+				   IAVF_MAX_REQ_QUEUES_VCV1);
 	if (!netdev) {
 		err = -ENOMEM;
 		goto err_alloc_etherdev;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 356565aa41c8..69241cb146e0 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -260,19 +260,19 @@ int iavf_send_vf_ptp_caps_msg(struct iavf_adapter *adapter)
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
2.54.0

