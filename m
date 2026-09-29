Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6D757F733
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 22:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721733; cv=none; b=nXh5pQixsf72FMb4yzAuAGGAkpmWfti63PwQ/swh8yne507gG5CbfONjNd+MJMcEKKXGAjTHy8IOZhSeJh/XqHVFKw8UO3Vs2pUA1YBL0QCOHbqWFg6Aa+RDB5HDD4zRRQQ5mQqeMN0druPsWPf+euAB3VfVkoJCeaBtM8RL38U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721733; c=relaxed/simple;
	bh=RzhhiORGIrXXoTD7atPk8I0GKBuhoCopS0CTa1tmvpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTxU31+0TJpS0Gnz3DrCnFlNp0qHwdVq5Mu5G8gsMYUarxehhEGSmwi9gu0Bxb2DEnHF4yDgS1jVY/iaRWAaNGOB/EqeQuVJXWzluhH6nQdpMYSRtpz122w5DobvO7Dr1+AhhnEaL+xn/9PostNDgG0JRFJCNY0Bem8E2+QBeq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eMEDUwVk; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eMEDUwVk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790721730; x=1822257730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RzhhiORGIrXXoTD7atPk8I0GKBuhoCopS0CTa1tmvpo=;
  b=eMEDUwVknpXbYyYVhTDE5CeXJc64hqP69X+seY0XBK2O0xUCZW9wziWR
   yA28Zy87slcYfDOimsViYyshjVX4tlQPBnqfLZxwA//5WdIbmUclH5eY4
   gw0q1+cTgdITSxDcez0BbKqyd7Ou6ZwmTnVn4+jFWz2tIQN1xWpTIB1QI
   yW7NmsSw0oVLWo/qxQjOjvRkKqraQ8QAat8ZvLqe23pMVLXDGS0LIDgnx
   /zI8U5ADa3IBRcNkgy5aN4ba7nUg0+o/pbJkaTqlG6TidBWaqNmPpRyEd
   s0bVGezZWx4M4Q2NQ+NNszPaBGmEKVTzskSs3l1IqeClHiWSqJBewVvvy
   w==;
X-CSE-ConnectionGUID: qJh/tXhART6jIdBFKE+pZg==
X-CSE-MsgGUID: gbx6Mp8FSraTo/9754xnZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="91548900"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="91548900"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 15:42:02 -0700
X-CSE-ConnectionGUID: bROpgeUnTcuv0tSA8bLyow==
X-CSE-MsgGUID: r+cpl4aCS4S21HQUD+UkHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="313452332"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 29 Sep 2026 15:42:02 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>,
	anthony.l.nguyen@intel.com,
	grzegorz.nitka@intel.com,
	aleksandr.loktionov@intel.com,
	marcin.szycik@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.korba@intel.com,
	xiongwm2026@163.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Subject: [PATCH net-next 08/10] ice: simplify ice_pf_state_is_nominal()
Date: Tue, 29 Sep 2026 15:41:48 -0700
Message-ID: <20260929224153.1455466-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260929224153.1455466-1-anthony.l.nguyen@intel.com>
References: <20260929224153.1455466-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yury Norov <ynorov@nvidia.com>

The function creates a temporary mask on stack just to check that
first ICE_STATE_NOMINAL_CHECK_BITS is empty. Simplify it by using
the ice_pf_state_is_nominal().

Signed-off-by: Yury Norov <ynorov@nvidia.com>
Reviewed-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 9e08db376d3d..73996e3022ef 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1705,16 +1705,10 @@ static void ice_vsi_set_rss_flow_fld(struct ice_vsi *vsi)
  */
 bool ice_pf_state_is_nominal(struct ice_pf *pf)
 {
-	DECLARE_BITMAP(check_bits, ICE_STATE_NBITS) = { 0 };
-
 	if (!pf)
 		return false;
 
-	bitmap_set(check_bits, 0, ICE_STATE_NOMINAL_CHECK_BITS);
-	if (bitmap_intersects(pf->state, check_bits, ICE_STATE_NBITS))
-		return false;
-
-	return true;
+	return bitmap_empty(pf->state, ICE_STATE_NOMINAL_CHECK_BITS);
 }
 
 #define ICE_FW_MODE_REC_M BIT(1)
-- 
2.47.1

