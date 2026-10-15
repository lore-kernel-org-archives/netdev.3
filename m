Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FA0568FAE
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 18:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792090541; cv=none; b=KIbDD4xof9jCqvE3rlq6G9UaaIIkoYtyQvYZj6IdOrkcap8DDQp7ryKAT2M9hZtbkKz1f+zXx8MuLdlWEqrNcXv5j9J2mMZDpXUHqv3G0ze52RYyJIpRj2Ew2GRSv+IYCP4MXrFrZSvw9RLX9uhfzlNMscCAyuS47XsGWRVaws0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792090541; c=relaxed/simple;
	bh=RG1SwPGWFGqPnGDKptI3PY64nF94VTae+e07ogWdYRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/DvxQtvUQtL3LSwdZZtBD86cSU2qh9K4zBDmIqFiJDXiaAzeNS/cfwiSpQl/qhUozlu9y0Rejc+AvOm66uDDLDP283+tVjl6eVrCq76WRwBiGoREJcJCkDaRsaNRI0r/+4++zzRbpupvqCYghqFkdNZMH2DFgcFXiYX8BHsbUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hKfNK/g8; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hKfNK/g8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792090538; x=1823626538;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RG1SwPGWFGqPnGDKptI3PY64nF94VTae+e07ogWdYRQ=;
  b=hKfNK/g8BMTXtk8mbWVFRlJLcDThUarP967c7/FCpAV2uRg6Qc7R7Jpr
   +fX/z35DIxruiKySQyXxyeyXGjLKX0j+KBjSn6kxtvGnKPtBhXdoq4gL5
   uWh1aRIB4wMkJ0xIJU/M5LdIqoAJBiFP8rrhnb5o+Ld3edR7NpV8O/m8I
   8S4xJtONeJ8GDGpC22ahCGbAsBVe9bSO4rA8Da3egv4kYK29HZyHyHw/I
   dIpXSM9Icj4yTqNulLNhTIiZESSvX5SEFaUDH5xaSaoH5Pi9a7VBeYGTI
   +oTEIQdhZKxUG9noO8FTqLiKUvU04VxL7ikUjd0HsdyrsqBq3tlvX0sLD
   g==;
X-CSE-ConnectionGUID: fv5c2A7CTuuIfiQsFmavhg==
X-CSE-MsgGUID: XyDT+d+xRNyfaNnEDGJ+4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="758032"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="758032"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 11:55:29 -0700
X-CSE-ConnectionGUID: k2Y7CvscR5aMJIJSeVnAfw==
X-CSE-MsgGUID: 8c/LtOSFQZKPf0a4WzQ8Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2003167"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 15 Oct 2026 11:55:23 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.244.208])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 7817532EC3;
	Thu, 15 Oct 2026 19:55:21 +0100 (IST)
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
Subject: [PATCH net-next v3 09/15] iavf: increase max number of queues to 256
Date: Thu, 15 Oct 2026 20:51:20 +0200
Message-ID: <20261015185454.6332-10-przemyslaw.kitszel@intel.com>
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

Increase the max number of queues that driver will handle to 256.
Use old legacy limit in the virtchnl handling of iavf_map_queues().

Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v2:
 * change iavf_q_vector::num_ringpairs to u16 (Sashiko)
 * drop the stale "_i=0...15" range from IAVF_Q{R,T}X_TAIL1()
---
 drivers/net/ethernet/intel/iavf/iavf.h          |  6 ++++--
 drivers/net/ethernet/intel/iavf/iavf_register.h |  4 ++--
 drivers/net/ethernet/intel/iavf/iavf_main.c     |  4 ++--
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 15 ++++++++-------
 4 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 94ee18058115..47236d5f3961 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -87,8 +87,10 @@ struct iavf_vsi {
 #define IAVF_TX_DESC(R, i) (&(((struct iavf_tx_desc *)((R)->desc))[i]))
 #define IAVF_TX_CTXTDESC(R, i) \
 	(&(((struct iavf_tx_context_desc *)((R)->desc))[i]))
+
 /* for "old" virtchnl opcodes that accept up to 16 queues */
 #define IAVF_MAX_REQ_QUEUES_VCV1	16
+#define IAVF_MAX_REQ_QUEUES		256
 
 #define IAVF_HKEY_ARRAY_SIZE ((IAVF_VFQF_HKEY_MAX_INDEX + 1) * 4)
 #define IAVF_HLUT_ARRAY_SIZE ((IAVF_VFQF_HLUT_MAX_INDEX + 1) * 4)
@@ -108,9 +110,9 @@ struct iavf_q_vector {
 	struct napi_struct napi;
 	struct iavf_ring_container rx;
 	struct iavf_ring_container tx;
-	u32 ring_mask;
+	DECLARE_BITMAP(ring_mask, IAVF_MAX_REQ_QUEUES);
 	u8 itr_countdown;	/* when 0 should adjust adaptive ITR */
-	u8 num_ringpairs;	/* total number of ring pairs in vector */
+	u16 num_ringpairs;	/* total number of ring pairs in vector */
 	u16 v_idx;		/* index in the vsi->q_vector array. */
 	u16 reg_idx;		/* register index of the interrupt */
 	char name[IFNAMSIZ + 15];
diff --git a/drivers/net/ethernet/intel/iavf/iavf_register.h b/drivers/net/ethernet/intel/iavf/iavf_register.h
index a19e88898a0b..11043e330de8 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_register.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_register.h
@@ -56,8 +56,8 @@
 #define IAVF_VFINT_ICR0_ENA1_RSVD_SHIFT 31
 #define IAVF_VFINT_ICR01 0x00004800 /* Reset: CORER */
 #define IAVF_VFINT_ITRN1(_i, _INTVF) (0x00002800 + ((_i) * 64 + (_INTVF) * 4)) /* _i=0...2, _INTVF=0...15 */ /* Reset: VFR */
-#define IAVF_QRX_TAIL1(_Q) (0x00002000 + ((_Q) * 4)) /* _i=0...15 */ /* Reset: CORER */
-#define IAVF_QTX_TAIL1(_Q) (0x00000000 + ((_Q) * 4)) /* _i=0...15 */ /* Reset: PFR */
+#define IAVF_QRX_TAIL1(_Q) (0x00002000 + ((_Q) * 4)) /* Reset: CORER */
+#define IAVF_QTX_TAIL1(_Q) (0x00000000 + ((_Q) * 4)) /* Reset: PFR */
 #define IAVF_VFQF_HENA(_i) (0x0000C400 + ((_i) * 4)) /* _i=0...1 */ /* Reset: CORER */
 #define IAVF_VFQF_HKEY(_i) (0x0000CC00 + ((_i) * 4)) /* _i=0...12 */ /* Reset: CORER */
 #define IAVF_VFQF_HKEY_MAX_INDEX 12
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index bb239e99e450..8059e855dc09 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -439,7 +439,7 @@ iavf_map_vector_to_rxq(struct iavf_adapter *adapter, int v_idx, int r_idx)
 	q_vector->rx.count++;
 	q_vector->rx.next_update = jiffies + 1;
 	q_vector->rx.target_itr = ITR_TO_REG(rx_ring->itr_setting);
-	q_vector->ring_mask |= BIT(r_idx);
+	set_bit(r_idx, q_vector->ring_mask);
 	wr32(hw, IAVF_VFINT_ITRN1(IAVF_RX_ITR, q_vector->reg_idx),
 	     q_vector->rx.current_itr >> 1);
 	q_vector->rx.current_itr = q_vector->rx.target_itr;
@@ -5370,7 +5370,7 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_set_master(pdev);
 
 	netdev = alloc_etherdev_mq(sizeof(struct iavf_adapter),
-				   IAVF_MAX_REQ_QUEUES_VCV1);
+				   IAVF_MAX_REQ_QUEUES);
 	if (!netdev) {
 		err = -ENOMEM;
 		goto err_alloc_etherdev;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 630a551c7566..3b9545d2c021 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -268,19 +268,19 @@ int iavf_send_vf_ptp_caps_msg(struct iavf_adapter *adapter)
  **/
 static void iavf_validate_num_queues(struct iavf_adapter *adapter)
 {
-	if (adapter->vf_res->num_queue_pairs > IAVF_MAX_REQ_QUEUES_VCV1) {
+	if (adapter->vf_res->num_queue_pairs > IAVF_MAX_REQ_QUEUES) {
 		struct virtchnl_vsi_resource *vsi_res;
 		int i;
 
 		dev_info(&adapter->pdev->dev, "Received %d queues, but can only have a max of %d\n",
 			 adapter->vf_res->num_queue_pairs,
-			 IAVF_MAX_REQ_QUEUES_VCV1);
+			 IAVF_MAX_REQ_QUEUES);
 		dev_info(&adapter->pdev->dev, "Fixing by reducing queues to %d\n",
-			 IAVF_MAX_REQ_QUEUES_VCV1);
-		adapter->vf_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES_VCV1;
+			 IAVF_MAX_REQ_QUEUES);
+		adapter->vf_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES;
 		for (i = 0; i < adapter->vf_res->num_vsis; i++) {
 			vsi_res = &adapter->vf_res->vsi_res[i];
-			vsi_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES_VCV1;
+			vsi_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES;
 		}
 	}
 }
@@ -583,8 +583,9 @@ void iavf_map_queues(struct iavf_adapter *adapter)
 
 		vecmap->vsi_id = adapter->vsi_res->vsi_id;
 		vecmap->vector_id = v_idx + NONQ_VECS;
-		vecmap->txq_map = q_vector->ring_mask;
-		vecmap->rxq_map = q_vector->ring_mask;
+		vecmap->txq_map = bitmap_read(q_vector->ring_mask, 0,
+					      IAVF_MAX_REQ_QUEUES_VCV1);
+		vecmap->rxq_map = vecmap->txq_map;
 		vecmap->rxitr_idx = IAVF_RX_ITR;
 		vecmap->txitr_idx = IAVF_TX_ITR;
 	}
-- 
2.51.1

