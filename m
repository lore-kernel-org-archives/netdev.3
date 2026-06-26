Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207743CBE79
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 05:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782452855; cv=none; b=uaxgxxEypvbJD2LFtzFnmh/jlzy+cjkaS4U8Pt35HQdbEhm8hbUDF9U/UW/MJoJt95/gw/invzSSIUXyk0a9VXrPEwHmv6eJAo/LNR8/qc1v9SIIbwTetYKqMS13+DDREMp+XKSwWU545L/yvpObZiib3Nk3w2rGi65xb4myjuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782452855; c=relaxed/simple;
	bh=jcgu0G4yFwmZlw8w+NTRKbolWpD1J9LZq4Y9zKRM4Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfa71J3PFvLx4Nmj3H0kWhCA8jk32XN/XEydMUn4nmBMjKHuArpdq9abEZynKLUC1EoqueMNQhz/9o57v+5Fh7RfowZ9woqgVwh6Mp/L6WI9PPuncpRjskr9nrXPzir4BszKh9wvngG2sFYaUjJeg0mrOMbqU8N8WhoZyndrK4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f4YAMgnh; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4YAMgnh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782452854; x=1813988854;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jcgu0G4yFwmZlw8w+NTRKbolWpD1J9LZq4Y9zKRM4Gc=;
  b=f4YAMgnhhp57RSnFsOr1vJQVZ97fO11NV+C1nTQbDZlPVRfAPrz3BinE
   jFraNA6OMpBSXnRc6M+4v3cLY+nKtrr6MPcQeKwY/shVaZqEyMC0QBt6w
   iwbWBJUvfb4H4SDmvunWNWVHO/sbNXMY/enUP8xItbzmpk9hxe6manA4w
   4XXS17uRv91/IZlOYcXzrSHC4PPhVeRkHLoix5KD2tUmRq8NpMTNAzWBP
   fjjfBT4wQVQgMmUers8JW86ngpzdCHjmRGu+Buwan6FuWZzxsDd0/8OkE
   J/CF0i1PfgeCh5/z++jwT6RH5jO0Ru2SYFcr9JCf7vl+LiXlLSviobZ61
   Q==;
X-CSE-ConnectionGUID: o9aFb9XpT3SGtqrVRbIBPA==
X-CSE-MsgGUID: i1UHEOg1RuGouYzQs+srpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="85798038"
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; 
   d="scan'208";a="85798038"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 22:47:34 -0700
X-CSE-ConnectionGUID: 1Iufo/MCQwGW6d5Bmv24vg==
X-CSE-MsgGUID: VtXMiO4BQTuaap+E1ss4Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; 
   d="scan'208";a="275485700"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa001.fm.intel.com with ESMTP; 25 Jun 2026 22:47:32 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v5 1/2] ethtool: treat RXH_GTP_TEID as intrinsically symmetric
Date: Fri, 26 Jun 2026 07:47:29 +0200
Message-ID: <20260626054730.1126969-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260626054730.1126969-1-aleksandr.loktionov@intel.com>
References: <20260626054730.1126969-1-aleksandr.loktionov@intel.com>
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
+	rxfh &= ~RXH_GTP_TEID;
+
 	sym = rxfh == (rxfh & (RXH_IP_SRC | RXH_IP_DST |
 			       RXH_L4_B_0_1 | RXH_L4_B_2_3));
 	sym &= !!(rxfh & RXH_IP_SRC)   == !!(rxfh & RXH_IP_DST);
-- 
2.52.0

