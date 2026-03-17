Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9DB39B4BC
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 08:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773737103; cv=none; b=gSzPOgRzuCWhEjgLiJEMzH73MkpuMMd31PX/unozQQOnDNqdh6r+XWw/MG9KTCIOPt/PK7peqGLo//YR1eqX/TsowwSERzeO0cXMOnKkCVcCI/Ec9+cHDizDlAARhoG5zWZ0jT9iIvp/e5KnHXF/ZeMx7H7IBx9kOadXkI0TLDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773737103; c=relaxed/simple;
	bh=IRQR4EX62gHxndHVD5ol1tVDrK0iQUrN/1zkt/4CXKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h92+1M0vB0tDCxAYvp+2qu6p55cFSOD4tU2w5nOZyNhDHqFM7422WF4TF8igmqiQaLr3DaoPgAvApFdmHAQKVn0j0HcpJDeIXzI6JTNpb5kIrn/FZidmYoE0h++KwnsjiUnTSmexzwJsFAbMSkiad/N9YojcxywGKbqqPQdf8D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mU3Axdkx; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mU3Axdkx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773737102; x=1805273102;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IRQR4EX62gHxndHVD5ol1tVDrK0iQUrN/1zkt/4CXKQ=;
  b=mU3AxdkxFoCO1oxyj2vZargMjnveC9rMmn/3VrwVFal1YZKCY72mqNmd
   /zpN+mzbSjkM98kjlEZPYnzzjojr+tVtrk/O2STXhJ2OnSdoaYjvnwd6k
   s9zxffEMMaUDrhQ+bGMHCkA7oEWXgcWkfYdc2YIfSXCh1l3KeEYCvy4/X
   ota9IWU/MOG92ZiUfKyC3c7vZ4QUqQEJ2AP58MCgxAI/1VmAcTECFxSEM
   EJ8CL4mvmH6Bp/Rbfr/SoSD185DALTlDfE/enpmy3Ihcu80FFNqdqAQSG
   tQYwJFbEs9nceMyfYk3hb4hRwjA7VG2Dxp5UsWcWF4hkRCcy7UYuPtkbk
   Q==;
X-CSE-ConnectionGUID: OI85LGrWQZ2Bbz9i1apYFQ==
X-CSE-MsgGUID: tLnzrt1TRKyTAPMWHMc7BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74651558"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74651558"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 01:45:01 -0700
X-CSE-ConnectionGUID: X0jYK42PQgeUEzYVlt/b6Q==
X-CSE-MsgGUID: Zc28UOdfQgeO2Nuz+NTU+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="219710027"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa008.fm.intel.com with ESMTP; 17 Mar 2026 01:45:00 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v1] ice: add ethtool reset support to safe mode ops
Date: Tue, 17 Mar 2026 09:44:59 +0100
Message-ID: <20260317084459.2196606-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Wire up ice_ethtool_reset() into ice_ethtool_safe_mode_ops so that the
.reset ethtool operation is available when the driver is operating in safe
mode, consistent with the behaviour exposed by the full ice_ethtool_ops.

Without this, a user-space call to ethtool --reset while the driver is in
safe mode would return EOPNOTSUPP even though the underlying reset logic
is fully implemented and works correctly.

Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 301947d..bf90bd5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -4917,6 +4917,7 @@ static const struct ethtool_ops ice_ethtool_safe_mode_ops = {
 	.set_ringparam		= ice_set_ringparam,
 	.nway_reset		= ice_nway_reset,
 	.get_channels		= ice_get_channels,
+	.reset			= ice_ethtool_reset,
 };
 
 /**
-- 
2.52.0

