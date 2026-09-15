Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B5343B3F7
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476971; cv=none; b=hT/ZDFcc6KUGhELpdsnz1HkNFem5nazaZhEstlF5AoLsiN//mAY6SsiTZmPH4D9tdgt3i+JNzwf6RA6bmD+s5Mq0QCf+rM8468c9uC1/kqM9eouPazIG8kDv3wdP39a3J3yEmSHJQxOs4IoTjwVvhVC7/x16BEPoDR0jov1qrQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476971; c=relaxed/simple;
	bh=On1pLPVQtHxohooxcvcmMAW3DwaX2GFpkBX9DoheHhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2azZXHHcEoyqOJ9H3L0aDw7jSzdYq6JLXx4Nscp55PsH1ODuXk2ErX0n7tBmrCwWTqozKBL1NErNbU/uxp+0B6PGiqNwUIzdf3kS6XroOaD16RZI32BmqzKzWdSB81OYKD/cTc1806C4twNEqXJtRHfw8BSOhRYIXvubOyBS7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V8qj8Y13; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V8qj8Y13"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789476970; x=1821012970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=On1pLPVQtHxohooxcvcmMAW3DwaX2GFpkBX9DoheHhM=;
  b=V8qj8Y13r+Wt7MoriR/XSCE2qBOL1uLEGEOwr/koEB+XpqOAddIQFOZK
   JWvLWEOTH0ADLnJb8CFKAtlIIKuzp6nL7EHsxCVkB0K15Wg0W0ABe3ug/
   NtiFEegEUmF8rNk2rwDv+6EeHMo9qn0ovcqSieqKCPL0Xlq1F0ow9r9BM
   WcO8tGilgvr9WqwC/FXYwHaj4CS6P7DhgyMQZd0vW9P3Jhu59B8t3Zoa8
   AhF85IxiMLLOU5MAs9HUuT7qJLqgMolrDmt3sjlOzWg6ni4+CYipRiNVn
   67XbGY+/TSNYtbDNqttfM4eoWi1f6OGGglBUgLVDMmE7CkOe6HVioKP5S
   g==;
X-CSE-ConnectionGUID: D5xJKniwRiOTizPDS3TMig==
X-CSE-MsgGUID: 2UsH6xNBRNWeVh+90lTYbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112607080"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="112607080"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 05:55:56 -0700
X-CSE-ConnectionGUID: W9wafoBsQ8ivnHBMm2LdIA==
X-CSE-MsgGUID: 1AK9FFU6TjiqLVg4vX98KQ==
X-ExtLoop1: 1
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa003.fm.intel.com with ESMTP; 15 Sep 2026 05:55:55 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v2 2/5] iavf: fix error path in iavf_request_misc_irq
Date: Tue, 15 Sep 2026 14:55:48 +0200
Message-ID: <20260915125551.3976068-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
References: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Piotr Gardocki <piotrx.gardocki@intel.com>

When request_irq() fails the interrupt vector was not registered for
the driver. Calling free_irq() on a vector that was never successfully
requested triggers a kernel warning. Drop the erroneous free_irq()
call from the error path.

Fixes: 5eae00c57f5e ("i40evf: main driver core")
Cc: stable@vger.kernel.org
Signed-off-by: Piotr Gardocki <piotrx.gardocki@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index dad001a..ab5f5adc 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -587,7 +587,6 @@ static int iavf_request_misc_irq(struct iavf_adapter *adapter)
 		dev_err(&adapter->pdev->dev,
 			"request_irq for %s failed: %d\n",
 			adapter->misc_vector_name, err);
-		free_irq(adapter->msix_entries[0].vector, netdev);
 	}
 	return err;
 }
-- 
2.52.0

