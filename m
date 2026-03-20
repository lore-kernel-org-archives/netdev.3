Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54061F91D6
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 05:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773983140; cv=none; b=ko6gvx0sKM0A3nCZD6gVriDZBOAadLZzBrmbUW5sSftGy4MQBeu++ZLaGdsNA/pFrU8EwBntJWIgAiMik38QLSc7GIevK5yqMI3z43A4RoqUP8DD+pPtaqoT6gl8LxTG4nREYKoDPOrRLg59QMml/ztxm9FOiEAlLVLK9VlcVCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773983140; c=relaxed/simple;
	bh=Y2X9UvI0EgjYn3IIhrToWZkRwx3++jcwtMMvMJSYZ6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uaZ9LFebJk3M4HJHAXjkHXZDDw9hFcuarbvxPJkW2u0z0jAl1oxmKd0a0TCYHqcG0Ad2cu0HDZtZZuDCO2PTJfM0KUQSVRTypzaB6SB1M+GNq1jb2H4sVRPEAbMb5rNl5lE/Niz3ArDZyIPlNHoaQzGvtSJs3GAR/hUiX+Wo7qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O0NuRAUJ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0NuRAUJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773983140; x=1805519140;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y2X9UvI0EgjYn3IIhrToWZkRwx3++jcwtMMvMJSYZ6U=;
  b=O0NuRAUJO6lhVBh6rErXf94TMPuGFA+Ld4ZPZShdkYpPMrEffbk7we+A
   hkO4hoIiPETo4lvOxM4pYaudF500MZ5ZbXKrPxj6y5yVLZtTYqceiNtSh
   sBkLtrRAX36WaysIekFkLMhC7ECnQqIBw8eCdoAsvohxv2LW1FZaDV2SY
   taYRoQYwUpcjYLwsukcaKDYzmBF/55hUdV/IG4LoKYn5mRrnsGn2Zxda7
   MOP/OrDmdoB8mQLGy+2PyMTPErUOzpVyjStt3UXF6ID1YpprAvJGKwI6y
   1moyAqxMm8MsZ3Ki503Hgl+fVz8ZL0CKihvxMFejIiKp/O5iZlOiX1Mv/
   Q==;
X-CSE-ConnectionGUID: A0YJOgFKTmOo6gwfuoAxsA==
X-CSE-MsgGUID: Nui0PikoQReJCh2OyT9/HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="100522732"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="100522732"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 22:05:39 -0700
X-CSE-ConnectionGUID: msJ+aUbWT4ym07l5lbYtkw==
X-CSE-MsgGUID: 9/a2oKZYTsqzceeNM1PWhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227307309"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa003.jf.intel.com with ESMTP; 19 Mar 2026 22:05:38 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH] ice: fix ICE_AQ_LINK_SPEED_M for 200G
Date: Fri, 20 Mar 2026 06:05:37 +0100
Message-ID: <20260320050537.422528-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Greenwalt <paul.greenwalt@intel.com>

When setting PHY configuration during driver initialization, 200G link
speed is not being advertised even when the PHY is capable. This is
because the get PHY capabilities link speed response is being masked by
ICE_AQ_LINK_SPEED_M, which does not include the 200G link speed bit.

ICE_AQ_LINK_SPEED_200GB is defined as BIT(11), but the mask 0x7FF only
covers bits 0-10. Fix ICE_AQ_LINK_SPEED_M to use GENMASK(11, 0) so
that it covers all defined link speed bits including 200G.

Fixes: 24407a01e57c ("ice: Add 200G speed/phy type use")
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 859e9c6..3cbb1b0 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1252,7 +1252,7 @@ struct ice_aqc_get_link_status_data {
 #define ICE_AQ_LINK_PWR_QSFP_CLASS_3	2
 #define ICE_AQ_LINK_PWR_QSFP_CLASS_4	3
 	__le16 link_speed;
-#define ICE_AQ_LINK_SPEED_M		0x7FF
+#define ICE_AQ_LINK_SPEED_M		GENMASK(11, 0)
 #define ICE_AQ_LINK_SPEED_10MB		BIT(0)
 #define ICE_AQ_LINK_SPEED_100MB		BIT(1)
 #define ICE_AQ_LINK_SPEED_1000MB	BIT(2)
-- 
2.52.0

