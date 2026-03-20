Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4F61F91D6
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 05:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773983136; cv=none; b=cBzYexRVerKa0J4iDY7mO9XqFJhnMbCXvsnH10zUIQep9LKcJs9srr7YvRBB42SEBjcQgb+cx2+pxu/X8XcnHg5turp3UH+NnEKOQ7Kyn7wRtyPqfefWSKUumXZTVe93J5shafqIxxV0UQ/S0TBWUiePYLWxenWV44qAXJ23ChY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773983136; c=relaxed/simple;
	bh=zPbmu2h3dYcVfoZeyIIRECebdDh3IS+lQz8XJwFWoRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DuGlRdeFFNl80NqezQGrNrLoUIO+yMBFgXPdQXwgF66DEnReTBReED/UqT27W3Nk7j/xVOJcKC2rMM75WptLVid/74qOo+EVKT9y8ihVTPrMA7zmXjBT20QzXL74d/gQhaoA100d5fyqxrsb1VgGGSga1+4FuY7RDZEZXus+nmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h00viKmu; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h00viKmu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773983136; x=1805519136;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zPbmu2h3dYcVfoZeyIIRECebdDh3IS+lQz8XJwFWoRc=;
  b=h00viKmuZPthn7iPaVw3vRolNi5h3ulBuCi4dlBhr3sF++S3dZMKCTtt
   f4/vCx/M4ijRF5QxxMS+J4PyzfIjtjP31nUf84btT6OiFA0cmeQaDuKkS
   5o2hHC/e/R7RRuBRkVixl6ZDCbFN2e/UQHdyCI9fN4sbWZBFkmY9bt0IY
   BoinLgot9+tnuKbeJyb00QGJX4CF/PbCGgcDpXfoyug8s68GBVDMymZei
   gLzATRjB3pdFl3l3uOELYtB9cWFtdK3Kv2YWENyd/pxi+FnDho7uPt5kd
   9SNhvxX/uJ8bHIH1f+cfFUXsQV0Fw/rJodD/Vpn4J8FySqbkm/wZfmBp8
   w==;
X-CSE-ConnectionGUID: hWAy75Z3TCGVqyRxSOjYdA==
X-CSE-MsgGUID: tWl+auerTAODjVigJubZkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="100522716"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="100522716"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 22:05:35 -0700
X-CSE-ConnectionGUID: 2wmL25AVRJ+lna9GUs3hCg==
X-CSE-MsgGUID: 6yPA7/OrQQmIWEpUs/aFKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227307296"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa003.jf.intel.com with ESMTP; 19 Mar 2026 22:05:34 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Jakub Staniszewski <jakub.staniszewski@intel.com>
Subject: [PATCH iwl-next] ice: fix FDB deletion
Date: Fri, 20 Mar 2026 06:05:33 +0100
Message-ID: <20260320050533.422475-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jakub Staniszewski <jakub.staniszewski@intel.com>

Correct the logic in ndo_fdb_del() to align with other drivers in 
upstream. The condition was inverted — it was rejecting permanent
(NUD_PERMANENT) MAC addresses while allowing non-permanent ones to be
deleted, which is the opposite of the intended behavior.

The correct logic is to reject deletion of non-permanent entries,
mirroring the fix applied to ndo_dflt_fdb_del() in commit 645359930231
("rtnetlink: Fix inverted check in ndo_dflt_fdb_del()").

Fixes: e94d4478669357cd ("ice: Implement filter sync, NDO operations and bump version")
Signed-off-by: Jakub Staniszewski <jakub.staniszewski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 348c86b..7692403 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6200,7 +6200,7 @@ ice_fdb_del(struct ndmsg *ndm, __always_unused struct nlattr *tb[],
 {
 	int err;
 
-	if (ndm->ndm_state & NUD_PERMANENT) {
+	if (!(ndm->ndm_state & NUD_PERMANENT)) {
 		netdev_err(dev, "FDB only supports static addresses\n");
 		return -EINVAL;
 	}
-- 
2.52.0

