Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2AB3CEB8B
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596686; cv=none; b=Kxi9TM5/Xkpy83psFKKJ6P2kFehYWhQvaQWdIAVPL9neeDoG/3/lKxZsXE4aAaJeJny6SKJYyBnu7pOswf+bbMi5EUCYNEeDnqXNC6M6fjKZGnNvA2kUJgFXh+wtT/Fs9+ldSIAgFA2ZSGQSixAyaInkI8/2AUaRZghdu1pKhyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596686; c=relaxed/simple;
	bh=QTbc+V8S9tIlg4mhaTbYxSvbv3dy+sH80dNtXOoQmKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPtI4APLurYf99Qd5qnoq6iQtLOQtndBZvkUHqh2ZnJH8APBPgjQFLqEnzz71TdujncbcAPaiXYST9EphX17wp9LXM4Il8/S12HZ4JAvErCrBBEFFg+cUd8F00Dg32P8d/Y2wQBbNHLMCC5t0syAv6czPnoS6obyuQXyfZe3s/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPMfPwro; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPMfPwro"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774596679; x=1806132679;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QTbc+V8S9tIlg4mhaTbYxSvbv3dy+sH80dNtXOoQmKA=;
  b=RPMfPwro71BEyrYG8deNXjEVTCge7XdizZTNs1dd9uVy4B72xEXqUigb
   YTyYpHsCVvrkXV/3PzpPar3+J2LL2I8vJqm9hXRMlngRHl5wdZfxq1mfj
   P52KdBXj79ec/AcW8FGWVcfzSdqBqReALpVwDu3V1YTzwWGdXJWKHkPat
   LWS1yT+CSUkFD7zGN2cJuf4rguHUMiEQGDXTpA6DhZAKAQRpWu+Nlz3TS
   vZi8b309vOIBcQBUeYtsQDVu3dEc4FQ8INS3cIPmyziWwZsBFr8KXnb/B
   Ib5fy6VHcJGa7P0AEhlo6MCma+2iJbotxNZwvnv6DH3cdUJacCoqBQx4C
   g==;
X-CSE-ConnectionGUID: aoU7tAFLShej6low7qDd0Q==
X-CSE-MsgGUID: k6WqAJgxT3yuzD2a75lx2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75734335"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75734335"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 00:31:04 -0700
X-CSE-ConnectionGUID: z9BBHnttQH2GFsKTFs2Nhg==
X-CSE-MsgGUID: Adr+VMHDTJ+eNwSeTiifwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="255740450"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa002.jf.intel.com with ESMTP; 27 Mar 2026 00:31:03 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next] ixgbe: extend 5 s SWFW semaphore timeout to all X550EM variants
Date: Fri, 27 Mar 2026 08:30:46 +0100
Message-ID: <20260327073046.134085-12-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marta Plantykow <marta.a.plantykow@intel.com>

The 5-second SWFW semaphore timeout added for X550 (ixgbe_mac_X550)
also applies to X550EM devices (e.g. X550EM_a, X550EM_x) since they
share the same FW and the same SR-dump-driven worst-case latency of
~3.2 s / module-update latency of ~4.5 s.  Change the mac-type
comparison from '== ixgbe_mac_X550' to a range check that covers
all three X550-family enum values (ixgbe_mac_X550, ixgbe_mac_X550EM_x,
ixgbe_mac_x550em_a) without inadvertently capturing later entries such
as ixgbe_mac_e610 which share the same swfw-sync function but have
not been validated against this exact timing requirement.

Signed-off-by: Marta Plantykow <marta.a.plantykow@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
index 85047ef..298958d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
@@ -577,7 +577,8 @@ int ixgbe_acquire_swfw_sync_X540(struct ixgbe_hw *hw, u32 mask)
 
 	swmask |= swi2c_mask;
 	fwmask |= swi2c_mask << 2;
-	if (hw->mac.type == ixgbe_mac_X550)
+	if (hw->mac.type >= ixgbe_mac_X550 &&
+	    hw->mac.type <= ixgbe_mac_x550em_a)
 		timeout = 1000;
 
 	for (i = 0; i < timeout; i++) {
-- 
2.52.0

