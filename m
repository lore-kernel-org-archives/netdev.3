Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D933CB90F
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 22:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440924; cv=none; b=PtD/pdx5GXlMGV7Bbfe6vrb26uWlEfAkvm8r+F65u8QAvGewH41qstoBd4QuaV0tDa0BHukpWpOfGFp687FM7I8b0h93NBIF0wSZhZoqbpshS/eqFlNWcimoPLlemWAsBEVXZRcuvRoRvs+XZqoWusHnn/xpOwxgRxL7GUFRNao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440924; c=relaxed/simple;
	bh=1gPXyX9qlf669pfyosoehTWje1p/dsWF6pUPzY8+Rz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjnCmDoOPvtjJ1plyiFp1nn/AgQhoRb4WkZtooYmaSy1qE5dZC2l7qdDc9WvVFHvoBWI2SyJpIUzC4dkFzBKz7NDe23JUt64RWfnqR8IfTgXy5CMDioGCRGxCq2ELb26qSEcBrfZkzK4pHLtykAo5g+yiaawGvhuvgfR1wkTWOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m/q2KqWR; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m/q2KqWR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780440924; x=1811976924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1gPXyX9qlf669pfyosoehTWje1p/dsWF6pUPzY8+Rz8=;
  b=m/q2KqWRkATXInt7OHExBD/5nj7JMsC3FMnESVZtIj8htd65CqYQzr6/
   h3d26/UzkQJUsP9f8HXy7e/mUJ/wqXP31hOcCW8R77Z1xB9hz/bpLxJZe
   TDxpaLzF2WwHf84wVG//MG7rF4cAvHrYC4uAmY0g6TR6pJUZ8jomLEF8q
   slX2d6/bmf2Icp9zmFGxY3PlsOZ1OyQjjhtV54NOGNGILbUhl3SyUbDYZ
   J48s/O1uT9iDipJCDFnQNnYyNQBOJcZ6+l8n0Wa80Y55ygewXMPNBsc3Y
   UfIxlUAiWLZRqVsVzvYBMYgSf78HTE4dmk0fRa7SXdCrGZtcYv39Mn9bG
   Q==;
X-CSE-ConnectionGUID: ApbHdtk0RpSQJGIvXXEmZQ==
X-CSE-MsgGUID: UTqDVLKzTcuYkIVldAWPxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81421414"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81421414"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 15:55:22 -0700
X-CSE-ConnectionGUID: 7pp43W8UTmuVClM+lKfmuA==
X-CSE-MsgGUID: ytb5/fDHRfartmLxNQvA8A==
X-ExtLoop1: 1
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 02 Jun 2026 15:55:21 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Alok Tiwari <alok.a.tiwari@oracle.com>,
	anthony.l.nguyen@intel.com,
	aleksander.lobakin@intel.com,
	jacob.e.keller@intel.com,
	richardcochran@gmail.com,
	willemb@google.com,
	horms@kernel.org,
	Samuel Salin <Samuel.salin@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net 3/3] idpf: fix mailbox capability for set device clock time
Date: Tue,  2 Jun 2026 15:55:11 -0700
Message-ID: <20260602225513.393338-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260602225513.393338-1-anthony.l.nguyen@intel.com>
References: <20260602225513.393338-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alok Tiwari <alok.a.tiwari@oracle.com>

The current code incorrectly uses VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME
for both direct and mailbox capabilities, causing mailbox-only support
to be ignored and potentially reporting IDPF_PTP_NONE.

Fixes: d5dba8f7206da ("idpf: add PTP clock configuration")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
index 4a51d2727547..71fe8b2a8b4e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
@@ -51,7 +51,7 @@ void idpf_ptp_get_features_access(const struct idpf_adapter *adapter)
 
 	/* Set the device clock time */
 	direct = VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME;
-	mailbox = VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME;
+	mailbox = VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME_MB;
 	ptp->set_dev_clk_time_access = idpf_ptp_get_access(adapter,
 							   direct,
 							   mailbox);
-- 
2.47.1

