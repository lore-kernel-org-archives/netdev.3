Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0436D3D47C6
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776263332; cv=none; b=XjOhedZB5udsd8DOWgnTi1jGJtsCvuDx0ReTp5riBJbyiVRZDXLlSaZX/NU46qEeM+G49sjHLPYpgFxxrhQtuZN+1Gey01+0bFK5erUnJ3l8pMurCVA7mVcWWKry1c9YEp9ua9HyK9paAQkKkf6RMdCjw60Z48MmBADKvkFo884=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776263332; c=relaxed/simple;
	bh=UPq6I5ywuqsWlMV/CExGXVtW7/DyZKY/nvZFhIfzgBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Py585mz11+OIU7kOoJ0iVUaQEE2wnHJw7tQ5b5Hd3zfyuyOZRCAEVcTbk4GmXuyNxpUPpimgZ5vcfQFkOJ1QFtm3ncM8HNkhrnrDwkricNXGFFKyKgpewdezBSUfZ7uPXCMjiFGc8C8IBJBQnyIGkn09J1kpyinZvOzA++4BQyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iHlQJ3lp; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iHlQJ3lp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776263331; x=1807799331;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UPq6I5ywuqsWlMV/CExGXVtW7/DyZKY/nvZFhIfzgBM=;
  b=iHlQJ3lpk+Soo9uJBQhPyL6f+MAGM7HvHd5F3g82p0wQROFseT1Ft9JG
   Uy6ihuCG4QKux3YwHxN7LOPYNZ1LV6FX1ImfdqXUBoRxTDBXjpq5evQHS
   4ZRzckHrKlyI+yO25WuqBdQU0Ui4zKjw35ZsjgYDOEZPw+1pvvB2KinZs
   IZOPKqNmehaTA8RoATXnEHJGWmCvnvCdzapdEhOzg2HkUgVUSHyUshQwO
   i0HmW7R5enEPsPTPh8zNylj2lmTGYTB6MxfoMtngurbmWMxIhZJ84Qbgj
   6H6uZc2vtlDJJijZtxHy1DwaNt6W+rfqYF6a/pGf6tUI3iU6Z8iuQvg4f
   w==;
X-CSE-ConnectionGUID: SFG5VU/PTXmVCBS7xqezyg==
X-CSE-MsgGUID: 0iuhNdmHRH+H3hpxk7HpQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77423742"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77423742"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 07:28:50 -0700
X-CSE-ConnectionGUID: y/EfwaZqQfWVh46NKVJarA==
X-CSE-MsgGUID: qp8XxpSnSuGFks2ZaAeTHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="234467873"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa003.jf.intel.com with ESMTP; 15 Apr 2026 07:28:48 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-net v3 4/6] ixgbe: fix cls_u32 nexthdr path returning success when no entry installed
Date: Wed, 15 Apr 2026 16:28:39 +0200
Message-ID: <20260415142841.3222399-5-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260415142841.3222399-1-aleksandr.loktionov@intel.com>
References: <20260415142841.3222399-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ixgbe_configure_clsu32() returns 0 (success) after the nexthdr loop
even when ixgbe_clsu32_build_input() fails for every candidate entry
and no jump-table slot is actually programmed.  Callers that test the
return value would then falsely believe the filter was installed.

The variable 'err' already tracks the last ixgbe_clsu32_build_input()
return value; if the loop completes with a successful break, err is 0.
If all attempts failed, err holds the last failure code.  Change the
unconditional 'return 0' to 'return err' so errors are propagated
correctly.

Fixes: 1cdaaf5405ba ("ixgbe: Match on multiple headers for cls_u32 offloads")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
v2 -> v3:
 - Add Reviewed-by: Simon Horman; no code change.

v1 -> v2:
 - Add Fixes: tag; reroute from iwl-next to iwl-net (false-success
   return is a user-visible correctness bug, not a cleanup).

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 210c7b9..6e7f8a9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10311,7 +10311,7 @@ static int ixgbe_configure_clsu32(struct ixgbe_adapter *adapter,
 				kfree(jump);
 			}
 		}
-		return 0;
+		return err;
 	}
 
 	input = kzalloc_obj(*input);
-- 
2.52.0
