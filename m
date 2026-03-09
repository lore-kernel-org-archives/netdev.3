Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11FC274641
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 14:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773065460; cv=none; b=aAUguHWecKp7bsGy0rr+n98j3hlZgAeb9xg1Hx9N6ZW85++irGik+1zJdHZixazGp3vAabZI4+FrhvtKsJGQih58eLT9yyssVmdEc2btehWPfKJHtdvyH3lidE5bCriasn19ArpYflBVRoxEeHjopd5zAVchQVqxs5Dp2FoEKOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773065460; c=relaxed/simple;
	bh=06y9i1blvXKT+0qakd+4jlyn/5w+VGLU+tv5laJuacE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XkJJCrVzsl1aBD/0KNrhCZUEeWMbBr8YyeHELL7f/d47XFatZN0nebUWM1RwQTht6SQxLoo7YN5D7MgsVBZetq9KU8qaWffLxCzdKyME4vldAuHI09xnop8D1QxZw75l2nV6ANir/hFV+prXN+JAlJa9BDDResQxQjdKrTn4iEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V9XABxvJ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V9XABxvJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773065458; x=1804601458;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=06y9i1blvXKT+0qakd+4jlyn/5w+VGLU+tv5laJuacE=;
  b=V9XABxvJelLVvE0Jxu7IrSz2FSLtO/AoQjPRZkd/uzmpSSi84JqhNsrg
   f3YQYF5D9+f7VZqjdFeQnVtw8+lxeKI008B2ZuKgROAui74oAU7u7ffgq
   etFkThrA321cwXypcLiTSUzHfdoY5pR9WjswXQwUZDeWZ92AEqZWBStm3
   fcs7QOOA0jXvwIceFTGbOFFYGxZubG/iO+ts1XsRGel2viODCsXQsOg0K
   GAW1/9v2QDJs3xDgujoRgnX7KoKIBJniaXvTxRcgtuaq0etH6/HyHwIwf
   LTTV5qdis93k/rHYQkiD7C+x9TzA/93n2H3uhg0iyJonxcYeLp8+4l2rJ
   A==;
X-CSE-ConnectionGUID: 39iiSQA3TqKgymw1CB5zRA==
X-CSE-MsgGUID: lNixy9MhTEOo4mObqhst/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="99558355"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="99558355"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 07:10:57 -0700
X-CSE-ConnectionGUID: EvA5GxjlRc+V+c7JNax0gg==
X-CSE-MsgGUID: blDyQXPBTiiuXBnTw85/ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="224463312"
Received: from pae-d-dell-r7525-263.igk.intel.com ([172.28.191.240])
  by fmviesa005.fm.intel.com with ESMTP; 09 Mar 2026 07:10:56 -0700
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Przemyslaw Korba <przemyslaw.korba@intel.com>
Subject: [PATCH iwl-next] i40e: PTP: set supported flags in ptp_clock_info
Date: Mon,  9 Mar 2026 15:11:51 +0100
Message-ID: <20260309141220.343224-1-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since upstream commit d9f3e9ecc456 ("net: ptp: introduce
.supported_perout_flags to ptp_clock_info") and commit 7c571ac57d9d ("net:
ptp: introduce .supported_extts_flags to ptp_clock_info"), kernel core now
requires that the driver set the .supported_perout_flags and
.supported_extts_flags fields in PTP clock info. Otherwise, the additional
flags will be rejected by the kernel automatically.

i40e does not support perout flags, so reject any request with perout
flags.

Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ptp.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 7bcea7d9720f..8d7958692235 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -601,10 +601,18 @@ static int i40e_ptp_feature_enable(struct ptp_clock_info *ptp,
 	/* TODO: Implement flags handling for EXTTS and PEROUT */
 	switch (rq->type) {
 	case PTP_CLK_REQ_EXTTS:
+		if (rq->extts.flags & ~(PTP_ENABLE_FEATURE |
+					PTP_RISING_EDGE |
+					PTP_FALLING_EDGE |
+					PTP_STRICT_FLAGS))
+			return -EOPNOTSUPP;
+
 		func = PTP_PF_EXTTS;
 		chan = rq->extts.index;
 		break;
 	case PTP_CLK_REQ_PEROUT:
+		if (rq->perout.flags)
+			return -EOPNOTSUPP;
 		func = PTP_PF_PEROUT;
 		chan = rq->perout.index;
 		break;
@@ -1340,7 +1348,9 @@ static int i40e_init_pin_config(struct i40e_pf *pf)
 	pf->ptp_caps.n_ext_ts = 2;
 	pf->ptp_caps.pps = 1;
 	pf->ptp_caps.n_per_out = 2;
-
+	pf->ptp_caps.supported_extts_flags = PTP_RISING_EDGE |
+					     PTP_FALLING_EDGE |
+					     PTP_STRICT_FLAGS;
 	pf->ptp_caps.pin_config = kzalloc_objs(*pf->ptp_caps.pin_config,
 					       pf->ptp_caps.n_pins);
 	if (!pf->ptp_caps.pin_config)

base-commit: d5fbc991435eac7a1ead7cd2ddb5a743528718bb
-- 
2.43.0

