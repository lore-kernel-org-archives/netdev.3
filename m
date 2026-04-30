Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605083A7F79
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777551967; cv=none; b=aUCo5DA1TpIt3IwJD4LYfIP1Bg9mqVzHoAQIsCsCTcdxLsoMvAT5/QiGM31bSBk3zaSZVYoM4W3pPVRha61DnhqJPCIgiigF5mtBvd4jAuAxHmM4Qaf3QAH83oPd6yZL2jEj1U+Bi4DAJyYDqsXPRA0rqaA7b/z0/P1cUOHXxaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777551967; c=relaxed/simple;
	bh=WoSZTJZgD5sk1nHAskzI2NqSbzu34TMeqUl/m7B6ltc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vB+ACHDdkbZUqBRmtEJhoqoy458H4PTrQqfqRYBObVmM2WkKxk4/R3sFT1m1sh+1MDDWy5nn6sv9jgxieu7t06CJIW/wZIRwWfPV1zpTBwr7eMu+sS/OU4rq0Dm2s9izJhs+ae38vc62Vl6D0tYFE/ARx5TMAxzi6+wxxWEYCJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jfe67wvQ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jfe67wvQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777551965; x=1809087965;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WoSZTJZgD5sk1nHAskzI2NqSbzu34TMeqUl/m7B6ltc=;
  b=jfe67wvQZfv3/qV3DzwE1Qf7K+YmBK1A5M2lloFkmMN6oDLYjNB9nnhi
   eysw9DsLd9lJ1NAj5O7u/psxTVKxDFR+IWmCNUCR/Hwnj0EmOJLoNkaWK
   Rg8O/qIDGHdBVag6D04udGI1i7SZJWpPb3Za8umGuzPkW1xJ8bBXjtaPI
   ynu6gc9jWd70ln7YZS1NLYsiRwNboFv1IJBxC+inOqX2WreHmhe0kq1p+
   H9hLLYKnlyXaMDrr3H+alhDdIlD8O1K5dHD7KSLtwzqa22Yaa7tOUpnM6
   pp9/grHoOSRWtn/EJk//Xu2Ry8Bzx3neLvDZaMGfxrkKWdspazmw95Ezu
   A==;
X-CSE-ConnectionGUID: gTHu1dlwSq2KFtm13xDTjQ==
X-CSE-MsgGUID: fmSbAfnIQSOK3F2S1K9lMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78689179"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="78689179"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 05:26:05 -0700
X-CSE-ConnectionGUID: cSnv3J4PTpO/KHFmOGTMGw==
X-CSE-MsgGUID: duS/1KRASjuFWY8mlw9i9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="233538420"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa006.jf.intel.com with ESMTP; 30 Apr 2026 05:26:04 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH 0/5] ice: five small fixes and cleanups
Date: Thu, 30 Apr 2026 14:25:57 +0200
Message-ID: <20260430122602.126722-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three correctness fixes and two cleanups for the ice driver.

Patch 1 corrects a kernel-doc comment in ice_ptp_hw.h that described the
ETH56G MAC Rx offset field as unsigned when it is signed (trivial doc fix,
no functional change).

Patch 2 removes the PF_SB_REM_DEV_CTL sideband register write from
ice_ptp_init_phc_e82x().  PHY access is enabled by default on E82X and
the register write was a leftover from an earlier SWITCH_MODE workaround
that is no longer needed.

Patch 3 renames ICE_SMA2_UFL2_RX_DIS to ICE_SMA2_UFL2_RX_EN to match
the actual active-high hardware semantics and inverts the three use sites
in ice_dpll.c so that the logic remains correct.

Patch 4 replaces the static per-type frequency tables for CGU pins with a
single DPLL_PIN_FREQUENCY_RANGE(1, 25 MHz) entry.  The firmware defines
an any_freq capability for configurable CGU inputs, but the old tables
restricted users to 1 PPS or 10 MHz.  GNSS pins retain a 1 PPS-only
entry since they are physically constrained.

Patch 5 exports ice_dcb_need_recfg() and calls it in the four SW LLDP
netlink setters instead of memcmp() on a non-packed struct, which is
undefined behaviour due to uninitialised padding bytes.  The redundant
memcmp in ice_pf_dcb_cfg() is removed since callers now guard it.

Aleksandr Loktionov (2):
  ice: add correct handling of SMA/u.FL states
  ice: use element-by-element comparison for DCB config changes

Arkadiusz Kubalewski (1):
  ice: fix DPLL pin frequency range in CGU pin descriptors

Karol Kolacinski (2):
  ice: fix ETH56G Rx offset type description in kernel-doc comment
  ice: remove unnecessary PF_SB_REM_DEV_CTL write for E82X

 drivers/net/ethernet/intel/ice/ice_dcb_lib.c |  13 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.h |   2 +
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c  |  30 +++-
 drivers/net/ethernet/intel/ice/ice_dpll.c    |   6 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  | 141 ++++++++++---------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h  |   8 +-
 6 files changed, 113 insertions(+), 87 deletions(-)

-- 
2.52.0

