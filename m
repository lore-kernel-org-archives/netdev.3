Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2FE41F5D7
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787226199; cv=none; b=cUXP6afHxHw7Iz3NL5wKW1/F1qQHyh4TlzrE/pxmFmnu0UNA8nLI8zRbeSF2pSZjzCo0LDanDficvQYbZgaDKUQe+kvQZz4h5InrmUzB142FWZcBenarJNOShBKLm7THInC7oOJWKjSkt9oE74Zc6t7J2gSBSKbmWI4bkTCOXNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787226199; c=relaxed/simple;
	bh=GbUEeQgHO4G6iYdMPK95ntbU1AsgYQoXrK38tX4cEdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=itLnhbGg4hJgxEdhGI4z9T+vx0vmhmmNk83vd0y5w9IAdG197jC3TnEUvKmT+TVBUjuwZPCYjtrrtvdlccRoYIAQyDz+KpIoMtaAIW3H01GRogYoxy0uUjDqTxvTf7yEEuypBWjlMYDX1S64DOWgntr0ZYMRe8SipK/TFeY8G68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cBx4YEIf; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cBx4YEIf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787226198; x=1818762198;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GbUEeQgHO4G6iYdMPK95ntbU1AsgYQoXrK38tX4cEdw=;
  b=cBx4YEIfBNm8hXO2hXqLBwN7Nw6/eQNS0NaIu+BEWdv7nbka4nfvQur4
   uDwb5OkV4FedmKbcPzT1CG+nlhHOu2okgA/h7ahcpDo41uLH4I/D69ojc
   bUYZktpmdNaebPPNeAAUOhRPEz4PVHh7k468MBsYDCcmPOJt/jSbqTPDh
   QxGSDaFCpkjzPe+PmCH4PZoFZfdAj8rNyWI7MRMXZwcw/EnlKexx2hBay
   vcsrF66KCPpaO39Iuu+KWY1qovCpdW6iwRNXNvoyriFgsnF+SEzP6gGjQ
   5lYhHM/mC5MO3sOPVsyBvMizmby8is0gO+LPb00WffXjy0J7bT6hFtjZL
   w==;
X-CSE-ConnectionGUID: CbuEX5A8QtGpK9iaBbWxQA==
X-CSE-MsgGUID: s91HILDNSUCTwdW1KHcbew==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="113297128"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="113297128"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 04:43:17 -0700
X-CSE-ConnectionGUID: /SfVVEWYTJu2USIPJDbvyQ==
X-CSE-MsgGUID: pk3qe8pNToCvLlip5EM2Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="264207473"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa006.jf.intel.com with ESMTP; 20 Aug 2026 04:43:16 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net] ice: fix bound parser hash offset before reading packet data
Date: Thu, 20 Aug 2026 13:43:14 +0200
Message-ID: <20260820114314.646344-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ice_rt_ho_set() uses the HO register as the starting offset of an
ICE_GPR_HV_SIZE-byte memcpy() out of rt->pkt_buf. Potentially HO can
be advanced by user-controlled data reachable through
ice_parse_raw_rss_pattern() -> ice_parser_run() ->
ice_parser_rt_execute() -> ice_rt_gpr_set() -> ice_rt_ho_set(), i.e. a
VF-supplied raw RSS pattern (virt/rss.c), with no bound against the
size of pkt_buf.

Clamp HO to the last offset from which ICE_GPR_HV_SIZE bytes can still
be read out of pkt_buf, deriving the limit from sizeof(rt->pkt_buf)
so it stays correct if the packet buffer layout changes.

Fixes: 9a4c07aaa0f5 ("ice: add parser execution main loop")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_parser_rt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_parser_rt.c b/drivers/net/ethernet/intel/ice/ice_parser_rt.c
index 3995d66..bfdb50b 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser_rt.c
+++ b/drivers/net/ethernet/intel/ice/ice_parser_rt.c
@@ -10,6 +10,8 @@ static void ice_rt_tsr_set(struct ice_parser_rt *rt, u16 tsr)
 
 static void ice_rt_ho_set(struct ice_parser_rt *rt, u16 ho)
 {
+	/* keep the ICE_GPR_HV_SIZE-byte read below within pkt_buf */
+	ho = min_t(u16, ho, sizeof(rt->pkt_buf) - ICE_GPR_HV_SIZE);
 	rt->gpr[ICE_GPR_HO_IDX] = ho;
 	memcpy(&rt->gpr[ICE_GPR_HV_IDX], &rt->pkt_buf[ho], ICE_GPR_HV_SIZE);
 }
-- 
2.52.0

