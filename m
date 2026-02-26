Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C443921DE
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116843; cv=none; b=gqn4c886kFR3QWTzpU/VkMeaBgWvkYxKYz6tgvNYh5522jBXyezJobNGgCME7HsWVM7OVpGQ8IB9dUIYIG01Woe8/CMNfSCuGbzVnt1Bl7exW+yDI6gE8HTuooyKAPYUnyNQqX3KGMz/IfvfOhqlJuJKAmbjcvZefzx3tJhuvCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116843; c=relaxed/simple;
	bh=t0chq214HkHrpgpq/8q/aGOsHgiMN8Wk/jEfJVeixCU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQlOt8FqzoXPFj90JosfZocCzOTwiV0VNjmX5WznKcYRnDESRPE6TXS4xJd/mgfYOI7jztfiMS136TDonc92Br9ZUI9k+E/IsEo1UeVMWhnWmh871D4iEOiMu8Exb45spvAEF4vJ6SWwP9Lu+F527SQ95jNEvTKUZtEyd4Fhbls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HK5BxKLd; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HK5BxKLd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772116843; x=1803652843;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=t0chq214HkHrpgpq/8q/aGOsHgiMN8Wk/jEfJVeixCU=;
  b=HK5BxKLdJrH9Aj54vd3nCIur7lMka/OcHHhp9qARw1ikUfASnveEWWgO
   1dEccRxWUJbQMy3uHuVm3VuC7FlFdF2Wj+84zRvRq2Wk9piEIZMeEpoXe
   JfvabWd2wTox+0fQxR7vsuE9NgpGPhrm79tmn+TDwjHEUBkB+iJNnp6AG
   hNFSnzNKM682EfFRuFiRZfpvdSkJci9h4JcAVj6eeuHFQ/77hsi6WI7Fx
   IEhZuzOi1wsgEGZb2Y8LbAGa9FYjN4y1Va50TR06n1z/0z8Qx8ttCHTYi
   2nY5ykv226WxtaX4OqTxCrKqdeoFM+o9bXIPYkd3t1CJAA9R2u8S8tbMP
   g==;
X-CSE-ConnectionGUID: 8UTUtdt7TdCdq1jJijy1Dg==
X-CSE-MsgGUID: rYEbtB1qSgC6gt5h/Hhm/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="76784552"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="76784552"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 06:40:42 -0800
X-CSE-ConnectionGUID: luwEjM4mTsypoBisDCqIQA==
X-CSE-MsgGUID: lLHXtRN8TSOl5auMnhd5YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="254353837"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa001.jf.intel.com with ESMTP; 26 Feb 2026 06:40:41 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v4 1/2] ethtool: treat RXH_GTP_TEID as intrinsically symmetric
Date: Thu, 26 Feb 2026 15:40:36 +0100
Message-ID: <20260226144037.400815-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260226144037.400815-1-aleksandr.loktionov@intel.com>
References: <20260226144037.400815-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A GTP tunnel uses the same TEID value in both directions of a flow;
including TEID in the hash input does not break src/dst symmetry.

ethtool_rxfh_config_is_sym() currently rejects any hash field bitmap
that contains bits outside the four paired L3/L4 fields.  This causes
drivers that hash GTP flows on TEID to fail the kernel's preflight
validation in ethtool_check_flow_types(), making it impossible for
those drivers to support symmetric-xor transforms at all.

Strip RXH_GTP_TEID from the bitmap before the paired-field check so
that drivers may honestly report TEID hashing without blocking the
configuration of symmetric transforms.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 net/ethtool/common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 5fae329..9a3fd76 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -911,6 +911,9 @@ int ethtool_rxfh_config_is_sym(u64 rxfh)
 {
 	bool sym;
 
+	/* Strip TEID before checking - it carries no src/dst asymmetry */
+	rxfh &= ~(u64)RXH_GTP_TEID;
+
 	sym = rxfh == (rxfh & (RXH_IP_SRC | RXH_IP_DST |
 			       RXH_L4_B_0_1 | RXH_L4_B_2_3));
 	sym &= !!(rxfh & RXH_IP_SRC)   == !!(rxfh & RXH_IP_DST);
-- 
2.52.0

