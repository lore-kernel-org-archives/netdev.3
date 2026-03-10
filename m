Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814C538F93F
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 20:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773176223; cv=none; b=tjThWMYVsxyACkU9nhd/d1KdcTB0lsSjAX+Uj1wykMd65GvkjATXs6rK0+oMzm80cu0a566Q0aAU0kEViJm/mOK/2l6N130WQYiQSZNVsQkNO3V8LpAMIqk3bPkQQ0lTD8oS+9EOWTwPiapmrvUmlgclPs4Crm6rVrzIrK/zfAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773176223; c=relaxed/simple;
	bh=2xx19+uySSCa2kZpZPxrOokoAJGsLTsCN9SN2pDONG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PhdfW7VSH2Cj3dSnQLbGbCBffg/U1Qb9AIGK2ZZNSAMjQKbOha2qhDjU1leL1HkVvO4kX0mE4uEWGk81x25BosrbqeURZ70u5vLvUr+3AUZYmWyA89LyDfAJoUcmkr9Wyv9ZSvGCJUFamY9HpuSDice2lQnPH2UkGbJfIDi/fdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RlcRmoOG; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RlcRmoOG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773176221; x=1804712221;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2xx19+uySSCa2kZpZPxrOokoAJGsLTsCN9SN2pDONG4=;
  b=RlcRmoOGf9jJK+Cb/xiLrAHiipBLIM3YxDNEIC6Szq4d73ZbaRq1nOtm
   9q0MIUtfVtTk7Og5qo8WkR2fwwaOnHzAuay0xowfP/uOoxmIYxKlko+SJ
   FNakc8UZ5ieXyCHMcT+jaz2KCk8Cklvt9ibSOg0p30QgWMvVRiNtMuTxq
   QAWC5eHW5cy+TEQ9T7i2dCorR9PMxtqML2a/focpgfJyctNrcEHQgmWUJ
   QKaBPuu72yjORTVYjdorvliwZgKJ1pd59Wpg781aOlVPknrnLfAYLHrpV
   P8RNlyGDxJCp7k9IOyCxLmk6RQmgTx2vFyowOaxB+xvJOYwnz+bEd+OuJ
   w==;
X-CSE-ConnectionGUID: 3Ey6FmlGRYKeBKNFgPhCHw==
X-CSE-MsgGUID: pzP1AW3QS72SlLsZ0dvLZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="85326041"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="85326041"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 13:56:59 -0700
X-CSE-ConnectionGUID: eL+tfCZFTwKXaGUzwkN8HA==
X-CSE-MsgGUID: REx3L1mmRZ29SGJ8aGRiVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="258162867"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 10 Mar 2026 13:56:59 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	anthony.l.nguyen@intel.com,
	david.m.ertman@intel.com,
	tatyana.e.nikolova@intel.com,
	przemyslaw.kitszel@intel.com,
	dsahern@kernel.org,
	daniel.zahka@gmail.com,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 1/5] drivers: net: ice: fix devlink parameters get without irdma
Date: Tue, 10 Mar 2026 13:56:49 -0700
Message-ID: <20260310205654.4109072-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260310205654.4109072-1-anthony.l.nguyen@intel.com>
References: <20260310205654.4109072-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nikolay Aleksandrov <nikolay@nvidia.com>

If CONFIG_IRDMA isn't enabled but there are ice NICs in the system, the
driver will prevent full devlink dev param show dump because its rdma get
callbacks return ENODEV and stop the dump. For example:
 $ devlink dev param show
 pci/0000:82:00.0:
   name msix_vec_per_pf_max type generic
     values:
       cmode driverinit value 2
   name msix_vec_per_pf_min type generic
     values:
       cmode driverinit value 2
 kernel answers: No such device

Returning EOPNOTSUPP allows the dump to continue so we can see all devices'
devlink parameters.

Fixes: c24a65b6a27c ("iidc/ice/irdma: Update IDC to support multiple consumers")
Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/devlink/devlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 6c72bd15db6d..6144cee8034d 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -1360,7 +1360,7 @@ ice_devlink_enable_roce_get(struct devlink *devlink, u32 id,
 
 	cdev = pf->cdev_info;
 	if (!cdev)
-		return -ENODEV;
+		return -EOPNOTSUPP;
 
 	ctx->val.vbool = !!(cdev->rdma_protocol & IIDC_RDMA_PROTOCOL_ROCEV2);
 
@@ -1427,7 +1427,7 @@ ice_devlink_enable_iw_get(struct devlink *devlink, u32 id,
 
 	cdev = pf->cdev_info;
 	if (!cdev)
-		return -ENODEV;
+		return -EOPNOTSUPP;
 
 	ctx->val.vbool = !!(cdev->rdma_protocol & IIDC_RDMA_PROTOCOL_IWARP);
 
-- 
2.47.1

