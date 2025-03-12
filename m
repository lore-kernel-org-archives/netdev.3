Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374AC23C8A0
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 09:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741773186; cv=none; b=trHPfIEpKovRtwcF2mAbVxkaXZXWFDyvdR/kXNex1hbIkR65dNOUx8ljl4UNWGCUyGoNvNoa5w/+tmUhwsDunUHsvQ7wFmakVPQEJWLXsxTHZ5eq5nvZR5ylR2+Ed6YiIeMgG04uYX2j3ch+mnz27DvN5epXneUiaBVFTgmb3gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741773186; c=relaxed/simple;
	bh=GT+2XvPe8nkLP6O6coKIkroLz9eBrsIRPkbmE3A8i3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3AMIoDrd3N1kmO1NUDNXNFY5WGznz/7tnJ7YKkKRiD6QoESlrSENry1hCS2oJAiUQXeB/JhI3Yk6IwuikGrObkMmoINxNit+CgCDkjryeKAB8kfhumookmVridraaDWhwEfRmVmJuvLesRc2Of2B/NR1hC6E4aWH5PTWBbItuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pl+opMub; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pl+opMub"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741773185; x=1773309185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GT+2XvPe8nkLP6O6coKIkroLz9eBrsIRPkbmE3A8i3M=;
  b=Pl+opMubL//8yf5iByYlCfcZdHf11SEuCtHlmtWhMlIqx77JZvbSFT6X
   Yi9AHkWnhYcG26+4L8+7XDrFkXBVpdbd4KRdiSHhqPlDJhHlXCTgKorUX
   a0VEgeNl4048HqCLizhIUomeAiD1NiFo8lmjpexUSKqJvWnadJDUPWHPt
   11qgmsSgRonlJcBa+EM/6/4a28Hv8lKimYVITmnLFPCmtdQ9R04ZO71C6
   5MTmlULH9huEGPnlkUi8lbOOZNaPiKBGN3Lxg4s2x1U6wB5lyCjsXozgj
   LgULfGxll6SXzyihRhRUxmTKVJrirMTHU9misEXvz2M6ASaXgwWBrTWN6
   A==;
X-CSE-ConnectionGUID: 8pYlsSg+Tw6AVvF/ptJP8g==
X-CSE-MsgGUID: QLVSpiOBSRK2nJJ58tgGEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="60246382"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="60246382"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 02:53:04 -0700
X-CSE-ConnectionGUID: YL+7Ha0IQXGVJ0+0n/rO2w==
X-CSE-MsgGUID: OaVQFYliTsi2SLCwkQKtNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="151548062"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa001.fm.intel.com with ESMTP; 12 Mar 2025 02:53:02 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	pierre@stackhpc.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	christophe.leroy@csgroup.eu,
	arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH net v2 1/3] devlink: fix xa_alloc_cyclic() error handling
Date: Wed, 12 Mar 2025 10:52:49 +0100
Message-ID: <20250312095251.2554708-2-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250312095251.2554708-1-michal.swiatkowski@linux.intel.com>
References: <20250312095251.2554708-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of returning 1 from xa_alloc_cyclic() (wrapping) ERR_PTR(1) will
be returned, which will cause IS_ERR() to be false. Which can lead to
dereference not allocated pointer (rel).

Fix it by checking if err is lower than zero.

This wasn't found in real usecase, only noticed. Credit to Pierre.

Fixes: c137743bce02 ("devlink: introduce object and nested devlink relationship infra")
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 net/devlink/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index f49cd83f1955..7203c39532fc 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -117,7 +117,7 @@ static struct devlink_rel *devlink_rel_alloc(void)
 
 	err = xa_alloc_cyclic(&devlink_rels, &rel->index, rel,
 			      xa_limit_32b, &next, GFP_KERNEL);
-	if (err) {
+	if (err < 0) {
 		kfree(rel);
 		return ERR_PTR(err);
 	}
-- 
2.42.0

