Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D953CBE66
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 05:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782452854; cv=none; b=ZsnloDpcS1hR8bAwV9R7+rimZnFtz83az/wMU7BhyuX/1zTDqthG/AV6yqJw7IvqGpi9M17N58dkrSg4bIr1k8NPP8x5+Vo/M9NmMoUh2NXwDFEl4XvLP7bgJ3CZL93oCiaaZi2wVBlTkPUGeJE0jTJeJIMhjMKuLpL34ymgQL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782452854; c=relaxed/simple;
	bh=54qse0Zod1IPGDYwpG/5iToZX2jpx6R59l5KQJ9Nw7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mgqc+ztuW03IgWyjiWbaAqK07yTVQY6/Fnn/rTez7mDE42gTuCJK/tA6QXnFALOjCJaqqSaEEnJv1DpJ9lbbaU/4gIeg4Wv3OWa1Yknpt/AZgIO5pg+7xyaGTzqi8n4CrhflTDl+XfwwtEW1QLdT95IwcbWOcjT5B1xfrMzhSsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EPlwObPX; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EPlwObPX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782452853; x=1813988853;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=54qse0Zod1IPGDYwpG/5iToZX2jpx6R59l5KQJ9Nw7A=;
  b=EPlwObPXCTP6+ryWy1MYR9DMKXZ7gEsc2iSHpEkswqt75p0fcxnq2oL+
   A9FtHioaAJAJfjQh9DWADkukGBuU41K9DT6ycjGQQGHO02Dj0Itb+FlN8
   au88DnYkD77RUJd+5G0YoKhrjAmlLD5QdKZ5eVv2jMtDDUAvXB4moN9QP
   zom0Wl2oNi09qbHE4NyP86mEK5gNQUO6EY8IV+3Vd1Gvpft9cZiNCrLMv
   MelWY67x4lTzXYcJrakYuLCxgE2aXEs28C+cHHoy7aTEkobIcF2LM3wnw
   bmRlgTXLY3AmVyJLDiDL7cJ0ahmKnIgW2rSrNwsaJueI7n88cK5TQBDCW
   A==;
X-CSE-ConnectionGUID: tFcdZvWBSe+OszmdO9Jwbw==
X-CSE-MsgGUID: jFhHq9t4RbO3JNUclc2xlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="85798036"
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; 
   d="scan'208";a="85798036"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 22:47:33 -0700
X-CSE-ConnectionGUID: Jlz4PYoUS2acI1/4QdazrQ==
X-CSE-MsgGUID: 4YdA1x6CRP+uyuT9h4SJWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; 
   d="scan'208";a="275485693"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa001.fm.intel.com with ESMTP; 25 Jun 2026 22:47:31 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v5 0/2] ice: implement symmetric RSS hash configuration
Date: Fri, 26 Jun 2026 07:47:28 +0200
Message-ID: <20260626054730.1126969-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ice driver has advertised symmetric RSS support via
supported_input_xfrm since the capability was added, but ice_set_rxfh()
ignored the input_xfrm parameter entirely, so enabling symmetric hashing
had no actual effect.

This series fixes that.  Patch 1 extends the ethtool core so that
drivers hashing GTP flows on TEID can report it honestly without
blocking symmetric-xor configuration.  Patch 2 wires up the ice driver.

The need for patch 1 surfaced because GTP flow profiles in ice always
include TEID in the hash.  ethtool_check_flow_types() calls
get_rxfh_fields() for every hashable flow type before allowing
symmetric-xor; ethtool_rxfh_config_is_sym() rejected any bitmap
containing RXH_GTP_TEID since it has no src/dst counterpart.  TEID
is the same value in both tunnel directions, so this rejection is
incorrect: including it does not break symmetry.

Rather than hiding TEID from the reported fields (which would silently
misrepresent hardware behaviour), patch 1 fixes the validator, and
patch 2 reports TEID honestly.

Tested with tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
on an E810 card running kernel 6.19-rc8.

---
v4 -> v5:
 - remove redundant (u64) type conversion

v3 -> v4:
 - Drop the ICE_HASH_INVALID fallback in ice_get_rxfh_fields() that
   fabricated default L3+L4 hash fields when no hardware RSS config
   exists for a flow type; returning zero fields is more honest and
   avoids misrepresenting hardware state
 - Drop the companion "if (!l3 && !l4)" special case in the
   pair-completion block; it was only necessary to cover the synthetic
   defaults added by the fallback, which is now gone
 - No functional change to ice_set_rxfh() or the ethtool core patch

v2 -> v3:
 - Split into 2 patches: ethtool core fix separate from driver change
 - Drop the RXH_GTP_TEID stripping workaround from the driver; instead
   fix ethtool_rxfh_config_is_sym() to accept TEID as intrinsically
   symmetric (patch 1)
 - Fix ice_get_rxfh_fields(): the v2 unconditional assignment
   "nfc->data = ICE_RSS_ALLOWED_FIELDS" clobbered fields set earlier in
   the same function; replaced with pair-completion using |= so only
   the missing half of a partial pair is filled in
 - Remove ICE_RSS_ALLOWED_FIELDS define (no longer needed)
 - Report RXH_GTP_TEID honestly for GTP flow types

v1 -> v2:
 - Preserve valid symmetric RSS fields instead of overwriting nfc->data
   unconditionally

Aleksandr Loktionov (2):
  ethtool: treat RXH_GTP_TEID as intrinsically symmetric
  ice: implement symmetric RSS hash configuration

 drivers/net/ethernet/intel/ice/ice_ethtool.c | 40 +++++++++++++---
 drivers/net/ethernet/intel/ice/ice_lib.c     |  7 ++--
 drivers/net/ethernet/intel/ice/ice_lib.h     |  1 +
 net/ethtool/common.c                         |  3 +++
 4 files changed, 40 insertions(+), 11 deletions(-)

-- 
2.43.0
