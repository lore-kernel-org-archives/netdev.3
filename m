Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320164;
	b=AHZpT28JdpAvL1pWK9tVN6bQi1lsfqMIeP1GVKIQ/i/egici5X9BjH7cNu4s/K86dlj/
	 alFQoSTzfFrogzJ1ICRgpBYJq9Be31imM09SM2047DROcfYUQpq6Vz+CZMbHgYLcPc2Gb
	 bHPipY49PKKLjnq/aFYkEA+vsy+H/RcCf8ZE9PYbHXXwYZMarevWbYzZ2Ld6vDKptMot+
	 suSZXZ24g3obKUJIibkUuq5yDJHTmXWiHM8ZAdk58eEdyKiJUyCkI8UYn19PyNopnKNS8
	 A+d9BynvBg341mMwc7y9SoIIVg5y2u84D2akGoQdNfxGNwnArdEAcObkbCEGKYYzIQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320164;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hSYuw/5ai3j0r6oXoXoB4/VX+f5EWuzN3G9Lk04OUNc=;
	b=gf3MSlRTd7fUTXjxwOIRBOfQdXpJEW4BeEouo6JOZCGBMgwkJJ06M+LtnJkg02xW+Rm3
	 Yg/GLKIo6XxMhUZyzh3upSMciTmDawbhFuHzSrfIxbsRUJcNJCp6zwIIeSDbay1ANs3If
	 /WGYU86HmckUXave8LJZ3CvJQ2j1ds2UCD8IYfSyRoluponCLc8Gu1uJi9yU101NZ3iA2
	 SjO3f8uNzxyte3cKORY9rM1Jcca6nVpui1/aAfFAXEPdWu5iErsdHdQ86Ueti4wubZsCo
	 ZmYijLhB5+5IjsB/Gn8IBGxrH1oZ7ysxjZTXHlF5Ux1NF3KXR5yyETyb6IclQIB2mbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=meGRFftm;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A505060A3812
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A505060A3812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=meGRFftm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794320163; x=1825856163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OkXAE5v6SIJaghS0yz7m2Pr/fwEIYC/JHsBtLA7qKbE=;
  b=meGRFftm3okxaUmM6/WEJwzr9ixhezrtjoTqNkvOEA+07tq6tSSaVx9y
   5Cd5LGz5mCB35/Iu/kVYrZaouQ5GysHKxNqg0dgZ/nGiT3ts0ynQ5R8Sp
   ul1w5ZjgY90Vl5mf7389rqLo7O26JcI7eMsCxRdKZJkC+fGFkF7daZ+rL
   gFqUQRUbGFWr9xd4+R9FHdlcIKZRpSJ2PRjIoEYV5FF8+0bGIVovnyKuY
   1QfsXeGESGEjuPNzRb5shtCDbbK3XsC4xZF5ZqJJ/tU/U8HlT3x73FCPz
   GXmRr3zFDyIFEY3pA3miu1OSTtNClZqbs1MRZj5/nbo7/EhjOsvlkrQhS
   Q==;
X-CSE-ConnectionGUID: REjfdABVToucfLfKHzDlog==
X-CSE-MsgGUID: N+frafXcQ++mrqhc+taW3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3091151"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3091151"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 06:16:03 -0800
X-CSE-ConnectionGUID: +YGH1Hh1QM2aQVPNSNAMGg==
X-CSE-MsgGUID: FuUaf62sQB+2VckMzFGGcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8327644"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa003.fm.intel.com with ESMTP; 10 Nov 2026 06:15:58 -0800
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.244.251])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 550AA2FC57;
	Tue, 10 Nov 2026 14:15:56 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
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
	ohartoov@nvidia.com,
	Petr Oros <poros@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v5 08/15] iavf: temporary rename of IAVF_MAX_REQ_QUEUES to IAVF_MAX_REQ_QUEUES_VCV1
Date: Tue, 10 Nov 2026 15:07:17 +0100
Message-ID: <20261110141534.95614-9-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20261110141534.95614-1-przemyslaw.kitszel@intel.com>
References: <20261110141534.95614-1-przemyslaw.kitszel@intel.com>
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
2.51.1

