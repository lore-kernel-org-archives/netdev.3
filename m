Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3DA403B0F;
	Tue,  9 Jun 2026 21:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040973; cv=none; b=OCejaEvZakYX0iXMsagszh/DWuKqedyIaHuwVHIupT5hYGPOIUNFEFz/usxE8ZPHjQrSE2o5MmYg3ADT1i16qiddWRGR0p0R3VL03+ykcHAP/zIryK2d6QsGABNvcwJoBCiI3WrSa2d0570mVOuCYjXjNvQPb0fuIbu4ZW1WUWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040973; c=relaxed/simple;
	bh=TfRtoTukIxNTpCmnZepw81KvhCR4VU8Z1a9IfYc6ZVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcEsk3xoakgF0+RJ8a1Wfi0xryhsNf8w7Lm9ogW0OpxiU9ubetP6IWB6bf34byCVCut/H/0lTaKMQRxY1k/8p/ItlAagjxJ2pYNrGHe0W4/phJuqYyNhgph8seuBnWTZCJ/qpPUv5CDfUptdRTb1LJXuzzEFbH/K306hYapnfVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hy9gBwc6; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hy9gBwc6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781040971; x=1812576971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TfRtoTukIxNTpCmnZepw81KvhCR4VU8Z1a9IfYc6ZVE=;
  b=Hy9gBwc6K09HGn90OiEJ0aBw4bhl13UjVU1fNYqcc5tPX3GYfmpckOrw
   e11EIM5G2N2UAd1R6TurvrXuUDzh8qHOIIOJZfGBCsWkUZDgVCp/5oV+B
   mw2bA01XnNFR/xUF3m5BTiZSd2LA669hCSl1j/RCZS2WKxVhHFHAprQPb
   WnLFRqbH9qVqYdRJmFdBN9lQGT0BhKseRtmcvssZgx0AMj4wITGru9Ohq
   g3sIBqTAkVsKXrbwelzJMunHc1nfH8Y4MtZ6pJjSP9JpFLDgI53qTr1Aa
   S04wPH094dtoodjzSXx0BU7N7khzE4QsHGIbelo/AAtkkUOXe5rlLlSpT
   g==;
X-CSE-ConnectionGUID: waoeuhdWTtmiAanyLnBD8Q==
X-CSE-MsgGUID: XY1FH1PdRJitfeXv3YYHqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81568539"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81568539"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 14:36:08 -0700
X-CSE-ConnectionGUID: jLq7otKERSmpgjp1FbtyGw==
X-CSE-MsgGUID: 6n3pgaEJQruzMsXRRTKhEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245838578"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 09 Jun 2026 14:36:07 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jakub Raczynski <j.raczynski@samsung.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	kernel-janitors@vger.kernel.org,
	error27@gmail.com
Subject: [PATCH net-next 04/15] net/intel: Replace manual array size calculation with ARRAY_SIZE
Date: Tue,  9 Jun 2026 14:35:45 -0700
Message-ID: <20260609213559.178657-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260609213559.178657-1-anthony.l.nguyen@intel.com>
References: <20260609213559.178657-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Raczynski <j.raczynski@samsung.com>

There are still places in the code where manual calculation of array size
exist, but it is good to enforce usage of single macro through the whole
code as it makes code bit more readable.
While at it, beautify condition surrounding it by reversing check and remove
unnecessary casting.

Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
Reviewed-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.h | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_adminq.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.h b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
index 1be97a3a86ce..dcf3baec7b73 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
@@ -109,7 +109,7 @@ static inline int i40e_aq_rc_to_posix(int aq_ret, int aq_rc)
 		-EFBIG,      /* I40E_AQ_RC_EFBIG */
 	};
 
-	if (!((u32)aq_rc < (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
+	if (aq_rc >= ARRAY_SIZE(aq_to_posix))
 		return -ERANGE;
 
 	return aq_to_posix[aq_rc];
diff --git a/drivers/net/ethernet/intel/iavf/iavf_adminq.h b/drivers/net/ethernet/intel/iavf/iavf_adminq.h
index bbf5c4b3a2ae..dd2f61172157 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_adminq.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_adminq.h
@@ -113,7 +113,7 @@ static inline int iavf_aq_rc_to_posix(int aq_ret, int aq_rc)
 	if (aq_ret == IAVF_ERR_ADMIN_QUEUE_TIMEOUT)
 		return -EAGAIN;
 
-	if (!((u32)aq_rc < (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
+	if (aq_rc >= ARRAY_SIZE(aq_to_posix))
 		return -ERANGE;
 
 	return aq_to_posix[aq_rc];
-- 
2.47.1

