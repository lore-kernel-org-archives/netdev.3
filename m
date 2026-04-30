Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E12212D7C
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777558917; cv=none; b=UDfodRR9qi750oo4qzM6D1jIP1PJ0yJRY1fuPlG+HhL0sOCPnKKfwnJSwKBiEH9FR7/T4xCccing7627WFPxDgKMgCVUyzWaev+Fcd3S5gA8G4a2KMzAEeM1cG2Xv11i2QHdbt1Hi97G0HIsYBTxejrZne6adpnjilY7BMB5OU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777558917; c=relaxed/simple;
	bh=DCJwLVpYE8Oxc/iSi+wYoHkqwCDP0eV6aMqtwc865HA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=swkm0xagTOFpkoSoREL/+WodgQULg5POEBFREmsK9tLslS+D6iwZjsi2+rDmefUTEKp+3fEM2rEhsRl33GjMF1Tq1QMFe659TfDafn2e/QvQGCPloDWgc1E+J3pNpGFFJ51BXiwtarfkye2q7rWJee1jF5lDxsEVb+tR/kjqdKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GTv8jjJx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GTv8jjJx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777558916; x=1809094916;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DCJwLVpYE8Oxc/iSi+wYoHkqwCDP0eV6aMqtwc865HA=;
  b=GTv8jjJxZs7ktVsUyoDvGWxG4oNH8y6e5OnVcmir/thGsW00yGuwvjx7
   yQm+AGuK/jm5b7FnAQvZtB/gNoQ/CIkI3unx+mYKEHfgdV6YukRzIQC2g
   nS+BmixW2xn53k615hoQ1R36ACJXfSvu2ETJ/sBv3KvmIs8WjdJdcZawK
   0FEiBr3kZjXzdkHrV5mtXYdfUBNEcGTwb3lGH8UgMjiMsJ3w1c79ygEVw
   wmT6y/kiepX7npkhnpszlzzcC/NxdG0jdGPelgRcp9cqRxj0PaMoG6jaG
   L2eU/oJnyWjfNGlB+yfdNg1YCtxTCkgkDdtmh5q5UpPKgKjxJHTEUNnU7
   w==;
X-CSE-ConnectionGUID: nze+QQ2lQuezFX+7lS5EQg==
X-CSE-MsgGUID: GpTJIqRKSd2UDpbWSyzEFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="89105265"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="89105265"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 07:21:55 -0700
X-CSE-ConnectionGUID: wa+JDUS8Qh25A3rGOjwIWA==
X-CSE-MsgGUID: +6CKxlaFR/W8YI6VBDFvRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="236382905"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa004.fm.intel.com with ESMTP; 30 Apr 2026 07:21:54 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net] ice: reject out-of-range ptype in ice_parser_profile_init
Date: Thu, 30 Apr 2026 16:21:53 +0200
Message-ID: <20260430142153.249062-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

set_bit(rslt->ptype, prof->ptypes) operates on a DECLARE_BITMAP of
ICE_FLOW_PTYPE_MAX (1024) bits. Nothing prevents a malicious VF from
providing ptype >= 1024 through VIRTCHNL, resulting in a write past
the end of the bitmap and a kernel page fault.

Reproduced with a custom kernel module injecting a crafted
VIRTCHNL_OP_ADD_RSS_CFG on E810-C QSFP (8086:1592),
FW 4.91 0x800214af 1.3909.0, ICE COMMS DDP 1.3.53.0,
kernel 7.1.0-rc1.

crash_parser: ice_parser_profile_init @ ffffffffc0d61b60
crash_parser: setting ptype=0xffff (max valid=1023)
crash_parser: calling ice_parser_profile_init -- expect OOB crash!
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
Oops: Oops: 0002 [#1] SMP NOPTI
CPU: 56 UID: 0 PID: 165011 Comm: insmod Kdump: loaded Tainted: G S U OE 7.1.0-rc1 #1
Hardware name: Intel Corporation S2600BPB/S2600BPB
RIP: 0010:ice_parser_profile_init+0x2d/0x1d0 [ice]
Call Trace:
 <TASK>
 ? __pfx_ice_parser_profile_init+0x10/0x10 [ice]
 crash_init+0x127/0xff0 [crash_parser]
 do_one_initcall+0x45/0x310
 do_init_module+0x64/0x270
 init_module_from_file+0xcc/0xf0
 idempotent_init_module+0x17b/0x280
 __x64_sys_finit_module+0x6e/0xe0

Bail out early with -EINVAL when ptype is out of range.

Fixes: e312b3a1e209 ("ice: add API for parser profile initialization")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_parser.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
index f8e6963..3ede4c1 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.c
+++ b/drivers/net/ethernet/intel/ice/ice_parser.c
@@ -2368,6 +2368,9 @@ int ice_parser_profile_init(struct ice_parser_result *rslt,
 	u16 proto_off = 0;
 	u16 off;
 
+	if (rslt->ptype >= ICE_FLOW_PTYPE_MAX)
+		return -EINVAL;
+
 	memset(prof, 0, sizeof(*prof));
 	set_bit(rslt->ptype, prof->ptypes);
 	if (blk == ICE_BLK_SW) {
-- 
2.52.0

