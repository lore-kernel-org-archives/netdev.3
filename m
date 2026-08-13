Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78F047A860
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 12:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786624981; cv=none; b=n8d0AgvJ4XuKSPJ8Y662bNjT4ybfaIZ9T1hQ2OUAZoUv+k/eGwDvtcMev2lr4+DnU8INIdJMToUfrl8uOHEzIuYIRb6p9FZ2vw46OSKxoMT/GnwAwOofGMLMfeKs9XqmLe2lXL+gPY4ba1dv4WSrT/1G80fBaK/eSJb0VGOQWu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786624981; c=relaxed/simple;
	bh=N0fQrSQprVq8ZZK3dkggJbMek7GVADvke3ylM3SUo/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mRxqt9baic2GsL+KV9gmCt8zUucrKWaJvQUGxflDOAtePNxTkRx16sNHkXRaRdzV8u3sMz047KudXXjVyosiW9353HFwWrzhXbKGt/6zLqXTAFco0aZcACHYkAVM23VWzMTSdcLpMpfYtRFO9tsII31lBi+J9GInS1ym1Ki6B84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N2EfPvZi; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N2EfPvZi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786624977; x=1818160977;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N0fQrSQprVq8ZZK3dkggJbMek7GVADvke3ylM3SUo/s=;
  b=N2EfPvZilDTsZj5OZNSady/cFEZg4z+yf2Sx9bIEP33+jiXAmd8IzveU
   /RCJFS1tbMCxAlj9pd1y2oJkBPAxvTtByKwSpcsSsXBOceID+w3Ov0kQL
   KyTCNV57rFlTdAlP7LICrUMh3KuH1TFY3LvCArP0kG+XgCcp/fejbcw1P
   3sufPDrPcS6PFux4i3Oz4yc3SGmkzh9xiYrFixwwOzRp0Vpo1L8FvBZ22
   buCvC9f5MJTxnkgdJmN2WKgLMLuTIBZpJD7RXa158urn6ImrWSHywqQjp
   7Zvh6NI0p6h7POU9qarLSOEeyI1kvlapOAH+8ZMa+OiKb/cmYeMf/OKwm
   Q==;
X-CSE-ConnectionGUID: bAD/FyAASIGiNwB7iitVRg==
X-CSE-MsgGUID: rFE0DjaeQzusGeMZEjyHuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="91071650"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="91071650"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 05:42:46 -0700
X-CSE-ConnectionGUID: 7Dpk5IwvRBmApIqEiLkrwg==
X-CSE-MsgGUID: HmIiRImsS1+EZKSLaBVF9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="262177564"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa006.jf.intel.com with ESMTP; 13 Aug 2026 05:42:44 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
	kuba@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	edumazet@google.com,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH net v2 0/3] net/sched: u32_change() fixes
Date: Thu, 13 Aug 2026 14:22:39 +0200
Message-Id: <20260813122242.1690024-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sorry for spam, previous series get treated as incomplete so resending

ALREADY ON NETDEV, SASHIKO RUN

This series fixes three bugs in cls_u32's u32_change() function:

Patch 1 fixes u32_replace_hw_knode() being fed the wrong flags variable.
Commit 695176bfe5de ("net_sched: refactor TC action init API") introduced
a function parameter `flags` that shadowed the local variable previously
set from TCA_U32_FLAGS. This caused tc_skip_sw() to always return false
during offload, silently ignoring skip_sw/skip_hw attributes. This fix
uncovered following 2 issues happening on u32_replace_hw_knode()
failure.

Patch 2 fixes a refcount leak of the linked hash table (n->ht_down) when
creating a new filter and u32_replace_hw_knode() fails. The error path
frees the node with kfree() but never drops the reference acquired by
u32_set_parms(), leaking the tc_u_hnode.

Patch 3 removes a spurious refcount_inc() in the update error path added
by commit e8d3d78c19be ("net: sched: cls_u32: Undo refcount decrement in
case update failed"). That commit misidentified an already-balanced
refcount (incremented by u32_init_knode, decremented by u32_set_parms)
as needing restoration on failure. The extra increment has no matching
decrement, permanently elevating the hash table's refcount.

Jedrzej Jagielski (3):
  net/sched: cls_u32: feed u32_replace_hw_knode() with correct set of
    flags
  net/sched: cls_u32: fix linked hash table refcount leak
  net/sched: cls_u32: remove erroneous refcount_inc()

 net/sched/cls_u32.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

-- 
2.31.1

