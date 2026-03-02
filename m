Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DC333E376
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 23:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772494873; cv=none; b=UpL0yKLdCUdKi02W/Hw8KszQNdfK1EMYOqUtxUbMbTvPWOeykgljjxv+RKN2u1fVa51wg2cw+qCO19OlIdifXce4mK4Z+9tWwrrDdYqCXiiFCb7g4MueiRDEI39lhBlpVJs/GhIAQzbogNHrFBkIqB5VZCz41It+uNJLzqbf0ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772494873; c=relaxed/simple;
	bh=3EqNLmGYdK07Nvb4QPCRHEHBdf176duRygvrckSCedQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iYogdITz+0GbIiVtBp8MeX/F24T8zeSqcgS9ww+4kAXD9Y2fs/d73vYl6gaJCh8eAlqKNHjL+pzZ+b9kVR51juZTxnwJHb/bRasT77wVtmdyi/hSxIjkkSHjSRqZdVL6pMajnJH8jDC342ctThq7jOk8d/TubNP9fjaYUih66Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WQYoHpZz; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQYoHpZz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772494871; x=1804030871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3EqNLmGYdK07Nvb4QPCRHEHBdf176duRygvrckSCedQ=;
  b=WQYoHpZz5n/xtSk+7NW0rur+9iI+wL3P6eup5UA31WLuF9TwZ/W9jTFT
   03rQ5TSlX7ES4l9Dq9RhWkoZkFpsOXsNzZaG97IkmOZmNb1m3qH+r9nYV
   rm8r+DBieJDBI8jEvRDA0VICFTKWUiC2GmR/RIVkylvB/1yEHIC9EKdae
   jGiBvcYfMewDK3cUFQIXw9P4f28dbNaj+mTdzC8QC0Edq4lFQl2A09eat
   BeuwfWM+H4l6w1Hf4ab/vgqy2swKbcg2IbglJs8+S4zv8PZqjvt6CzawC
   5Ngi7JMSY2e3Fj4DvQCF9HrvtIzp9Jvp8wZvyFUwaj4S6/0cM9gJdDCzf
   A==;
X-CSE-ConnectionGUID: BwT8WYV4TwuQNgNjkQ10oQ==
X-CSE-MsgGUID: KiWrLydSRniqo7I8QU6X5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73585730"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="73585730"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 15:41:09 -0800
X-CSE-ConnectionGUID: tV4S0T+uSZOzgStKwlAHzg==
X-CSE-MsgGUID: VgdTtAe6SzapppxFcVrajQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="216233666"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 02 Mar 2026 15:41:09 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next 1/4] ice: Make name member of struct ice_cgu_pin_desc const
Date: Mon,  2 Mar 2026 15:40:59 -0800
Message-ID: <20260302234105.2658400-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260302234105.2658400-1-anthony.l.nguyen@intel.com>
References: <20260302234105.2658400-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Simon Horman <horms@kernel.org>

The name member of struct ice_cgu_pin_desc never modified.
Make it const.

Found by inspection.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 5896b346e579..9bfd3e79c580 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -258,7 +258,7 @@ enum ice_si_cgu_out_pins {
 };
 
 struct ice_cgu_pin_desc {
-	char *name;
+	const char *name;
 	u8 index;
 	enum dpll_pin_type type;
 	u32 freq_supp_num;
-- 
2.47.1

