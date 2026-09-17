Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0FC4E5333
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670392; cv=none; b=EprpkzImc4xdInZbYi25Uh+LJgv3iopSRk0z8H3Oiri4m7rCfdIm7o/3Rg7dGIqcI/q0mvEYcXstiq4d6z1Qv9RO0rcGs73MZmZsbt7IuhOKSUVEvEo4CMpe5j1wDJ/Mdje0r1kuuG5iBIpRirfVN1/BAsj2lH/GX+UYLKj0EX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670392; c=relaxed/simple;
	bh=PZqcu5Z/+0WYCE/fG0DMtIy7YiUx+WwDhF9WLuXN+/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WgBiB5vudNeT4JvKYjhOEMLd6qdI+w8ssLrcvOHRSUpUq9KmEceHZGi1KhrCBrenD5fphJSJJn4cIA+kNfAy0gIRhKm8qKnAJfdVxOawTggqA5Fz2AwgUYDeKBK4Kvf6apUBgosxtakwPXx/8u3GRJOZljeHYKaT+kLw4eLePZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JgxOa2mq; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JgxOa2mq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789670390; x=1821206390;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PZqcu5Z/+0WYCE/fG0DMtIy7YiUx+WwDhF9WLuXN+/A=;
  b=JgxOa2mqB9R0ZcR/46XFmrhP7rYXVe6GnoOXaCxJzJOBCzc3DteoO4EL
   MzpJWVoJg1jdtKExNAGKf775BJEVgaJRIC9Y6k4iTY63+mrx57iQDWQzg
   6clGpx9f1wNxjVkiUPCLnIDy9plRUxlIOvc9H3EIbWBuxmzehfoaUL9P/
   7oxr2Kf8iKACnOXEdo7mLyt15r3y5H1hbNxoPFsj6JwPoPnoFL5yCyMbM
   luCu55TX1jiX7RbtjUpIwV9NYDwC84q0JQ9/gARrrry3d9YMmHpoGB4Bp
   WrJiimqxw1gRogK/nuH2Go0C6KaZMdSsR95ylkcEhNHxoJUMc/6MEJDy3
   w==;
X-CSE-ConnectionGUID: 9Lt3prdjQgqyXPxHE5hgtw==
X-CSE-MsgGUID: bwnwc7+NQfuxBpzQhj8dgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100722131"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100722131"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 11:39:40 -0700
X-CSE-ConnectionGUID: pZ6SKfI/Qm+lTEJcgUVz9w==
X-CSE-MsgGUID: EoAcrslFTBGQvTuSc7/Okg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="267728778"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 17 Sep 2026 11:39:39 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com,
	sandeep.penigalapati@intel.com,
	ananth.s@intel.com,
	alexander.duyck@gmail.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next v2 11/12] ice: re-introduce ice_dealloc_flow_entry() helper
Date: Thu, 17 Sep 2026 11:39:23 -0700
Message-ID: <20260917183927.2692068-12-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260917183927.2692068-1-anthony.l.nguyen@intel.com>
References: <20260917183927.2692068-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcin Szycik <marcin.szycik@linux.intel.com>

It was removed in commit ad667d626825 ("ice: remove null checks before
devm_kfree() calls"). Now it's useful again.

Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_flow.c | 35 +++++++++++++----------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
index e0a1d8463d6f..de751774affc 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.c
+++ b/drivers/net/ethernet/intel/ice/ice_flow.c
@@ -1589,6 +1589,23 @@ ice_flow_find_prof_id(struct ice_hw *hw, enum ice_block blk, u64 prof_id)
 	return NULL;
 }
 
+/**
+ * ice_dealloc_flow_entry - Deallocate flow entry memory
+ * @hw: pointer to the HW struct
+ * @entry: flow entry to be removed
+ */
+static void
+ice_dealloc_flow_entry(struct ice_hw *hw, struct ice_flow_entry *entry)
+{
+	if (!entry)
+		return;
+
+	kfree(entry->entry);
+	kfree(entry->range_buf);
+	kfree(entry->acts);
+	devm_kfree(ice_hw_to_dev(hw), entry);
+}
+
 /**
  * ice_flow_get_hw_prof - return the HW profile for a specific profile ID handle
  * @hw: pointer to the HW struct
@@ -1757,11 +1774,7 @@ static int ice_flow_rem_entry_sync(struct ice_hw *hw, enum ice_block blk,
 	}
 
 	list_del(&entry->l_entry);
-
-	kfree(entry->entry);
-	kfree(entry->range_buf);
-	kfree(entry->acts);
-	devm_kfree(ice_hw_to_dev(hw), entry);
+	ice_dealloc_flow_entry(hw, entry);
 
 	return 0;
 }
@@ -2948,10 +2961,7 @@ static int ice_flow_acl_add_scen_entry_sync(struct ice_hw *hw,
 		if (e->acts_cnt && e->acts)
 			ice_flow_acl_free_act_cntr(hw, e->acts, e->acts_cnt);
 		exist->id = e->id;
-		kfree(e->entry);
-		kfree(e->range_buf);
-		kfree(e->acts);
-		devm_kfree(ice_hw_to_dev(hw), e);
+		ice_dealloc_flow_entry(hw, e);
 		*entry = exist;
 	}
 out:
@@ -3075,12 +3085,7 @@ int ice_flow_add_entry(struct ice_hw *hw, enum ice_block blk, u64 prof_id,
 	if (blk == ICE_BLK_ACL && e->acts_cnt && e->acts)
 		ice_flow_acl_free_act_cntr(hw, e->acts, e->acts_cnt);
 dealloc_entry:
-	if (e) {
-		kfree(e->entry);
-		kfree(e->range_buf);
-		kfree(e->acts);
-		devm_kfree(ice_hw_to_dev(hw), e);
-	}
+	ice_dealloc_flow_entry(hw, e);
 
 	return status;
 }
-- 
2.47.1

