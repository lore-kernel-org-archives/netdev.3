Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449924189D6
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782991847; cv=none; b=bgMs18qXXTrcmb6xKdqgYzJMiwJLseRwJKY/L9dfmoMOhwqvwgd7yGWTp/obpJjIannKk/W2rrddA5AJw5IYVDM7V31DVHWzSfRRaNM26ibS1o98AEf7RfwnWsC4GbkGvOwSd9wstPW5dlD9iZsVaFAPu6eRi8mMdjX/OQ38VGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782991847; c=relaxed/simple;
	bh=rstFJgyxKE753P4Jrw7HbV3svWEHgBRqkt0vcWN7dmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uaykrzb3yFK9H3IMKJW8uCEkIVdnO1e3FslRlNpbVrfTkIdA3Vka88BCfPAwzw2MYGit1+mqsCSRiY8PDarYgaaGEqL965PNY/jr8fk41TyjZ48JOkiLgLDDPvylJqUb3cDEFJpysU58QBvRcxbLqzgZsNbvxLZpndGOvS662EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mPK1cH64; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mPK1cH64"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782991846; x=1814527846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rstFJgyxKE753P4Jrw7HbV3svWEHgBRqkt0vcWN7dmc=;
  b=mPK1cH64gmtlOXiaaR/iQDS4itVPipctK2CNf3L897UKjkCXi1kMdBnX
   o/f2C7LGNWXjfVylXJU9FCEs5udz1KFicz10snvDM7Ja5rjhrv4yd/5TN
   XFlE9sP6j0YYvXqHw9FqxN6g6hzspmZukJDyoosDNRG9MZ7VHAddiqGON
   HCOa3/Cre+E9YeFbxMD89X3V8XhbLCtbSV3K7gKUyxD6oUTakvpY+hgnp
   +YSXvswpRmlv3oVAJ8c+j4J9taR0ARG6vOPt7/dFrWse8uumrFkLoyWyr
   HT+Vwss0BuXeNAZFtfzgGYo1bgo80rMMg2FD0bit1tcnAG0bhFymGkvep
   w==;
X-CSE-ConnectionGUID: fd41suZZQMeKxekqOep8JA==
X-CSE-MsgGUID: qGv01ZoxRZ6vHOaOxupJSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="83611752"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="83611752"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 04:30:46 -0700
X-CSE-ConnectionGUID: UlyzB9ejQ6ytuHWtn+kUEQ==
X-CSE-MsgGUID: eVn/GHmVShmcfdW1A1v6rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="251788431"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa010.jf.intel.com with ESMTP; 02 Jul 2026 04:30:45 -0700
Received: from gond.igk.intel.com (gond.igk.intel.com [10.123.220.52])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 40CE028760;
	Thu,  2 Jul 2026 12:30:43 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	sandeep.penigalapati@intel.com,
	ananth.s@intel.com,
	alexander.duyck@gmail.com,
	anthony.l.nguyen@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v5 11/12] ice: re-introduce ice_dealloc_flow_entry() helper
Date: Thu,  2 Jul 2026 12:30:05 +0200
Message-ID: <20260702103007.97020-12-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260702103007.97020-1-marcin.szycik@linux.intel.com>
References: <20260702103007.97020-1-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was removed in commit ad667d626825 ("ice: remove null checks before
devm_kfree() calls"). Now it's useful again.

Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v5:
* ice_flow_acl_add_scen_entry_sync(), ice_flow_add_entry():
  ice_flow_acl_free_act_cntr() additions make more sense in patch adding
  this code, move them to that patch. Now this patch is a pure refactor.
v3:
* ice_flow_acl_add_scen_entry_sync(), ice_flow_add_entry(): call
  ice_flow_acl_free_act_cntr() in unroll
v2:
* Add this patch
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
2.49.0

