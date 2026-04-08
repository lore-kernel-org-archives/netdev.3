Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA093C3C09
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775653926; cv=none; b=cB/jAWX0esNc4cgejUakz6wN2S6GlZOTgFVFfaQR1zcVwf6JQmfBDvdjc0Twv+rT4hjYXzXMoG49xNw84d8W5IhtUb+4YVGFhXwju6ekeidGfXXZnPVZp0xBuSzXr7/a6Tl8n55QImJvb/Nt/I5dEUpX9XvXJk+UourdCE8/UT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775653926; c=relaxed/simple;
	bh=yv/bdNXZH9c8rMWd2v5owZSXHg0dmXwqwGf4QRKCawI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjQa1j3VfgkpDanh+1wQ2+SRDT8XCDaXdwdNAfbmFrWblWqKtVebwpa94cOjWhvDgfFq7jMJ+RH/+biYYIlh3WZH/Ui7S5Zt4kCZ9v9pDEUwT8uqcXdGdzARSPTk2geffWgqCDt/6371BVRamsHdK8G2coDS/nx9rFiz7TGc4fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eUyHezAc; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eUyHezAc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775653926; x=1807189926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yv/bdNXZH9c8rMWd2v5owZSXHg0dmXwqwGf4QRKCawI=;
  b=eUyHezAc29t4mztzCpoobhVYXbDdc5xiHUb+oF5hqCon7Lbi/iBrDRg1
   XXMD4sgstFuSjnV8N77pOG9ZQMIxqvmmmIU6vHJUmwkg8upLG9FJz2l26
   LaPH9g3VNFyLnxUM3rmjWnkZphupRsaQVeb49VJ6/e/xxPUctIKqyRbh8
   bOvsYORwcwwzfbgKUa0RVnczh3TNaMGWpnntApgJLHZYtcdJNQx14B27l
   XKB3wFz+T4e0HP5yV3MHGh2hpNyuL3jwEAhfnN0OOi0RqXjLltSQVGR+Z
   SG5jTCdHuOgN4KzaRlR5kI3U7aI/dkB4xC2R57JltVYXwjzWHtxMBDG5b
   A==;
X-CSE-ConnectionGUID: y4LDhvnwSdeDBllMayBepg==
X-CSE-MsgGUID: tamtvZyhSYeMOv3/aJkmvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="102087237"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="102087237"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 06:12:04 -0700
X-CSE-ConnectionGUID: Bql28W+bQUuK12k1FUl8pw==
X-CSE-MsgGUID: oDbuBW78SbCyMCnpNeUt9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="228714974"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa007.jf.intel.com with ESMTP; 08 Apr 2026 06:12:03 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v2 5/6] ixgbe: fix ITR value overflow in adaptive interrupt throttling
Date: Wed,  8 Apr 2026 15:11:53 +0200
Message-ID: <20260408131154.2661818-6-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408131154.2661818-1-aleksandr.loktionov@intel.com>
References: <20260408131154.2661818-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ixgbe_update_itr() packs a mode flag (IXGBE_ITR_ADAPTIVE_LATENCY,
bit 7) and a usecs delay (bits [6:0]) into an unsigned int, then
stores the combined value in ring_container->itr which is declared as
u8.  Values above 0xFF wrap on truncation, corrupting both the delay
and the mode flag on the next readback.

Separate the mode bits from the usecs sub-field; clamp only the usecs
portion to [0, IXGBE_ITR_ADAPTIVE_LATENCY - 1] (= 0x7F) using min_t()
so overflow cannot bleed into bit 7.

Fixes: b4ded8327fea ("ixgbe: Update adaptive ITR algorithm")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v1 -> v2:
 - Add proper [N/M] numbering so patchwork tracks it as part of the set;
   no code change.

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 210c7b9..9f3ae21 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2889,8 +2889,9 @@ static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
 	}
 
 clear_counts:
-	/* write back value */
-	ring_container->itr = itr;
+	ring_container->itr = (itr & IXGBE_ITR_ADAPTIVE_LATENCY) |
+		min_t(unsigned int, itr & ~IXGBE_ITR_ADAPTIVE_LATENCY,
+		      IXGBE_ITR_ADAPTIVE_LATENCY - 1);
 
 	/* next update should occur within next jiffy */
 	ring_container->next_update = next_update + 1;
-- 
2.52.0
