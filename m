Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FC3402435
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 12:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777551968; cv=none; b=HJ1gY+max9JurD3NMczkJCekSFseNhJVzBCjFXZ1WMAGrkrRmy9m19sVt5kOmDaDZYukTJTwr4uGpT7wlQMpv5MIg8cICWI9aCkMQTsUmaLKE3Ro7fBr553A9GvHTvs57UotgwajLeNLroEt6bqw6GbGOvYtxgzJ0Y4e2DvM3uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777551968; c=relaxed/simple;
	bh=Y1C501JONhNNAVfQFgCHZpYKC+oUFWqSXemVKft+MIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbXwlCM0IPoPSjdoA4BIKWEMICRttcOau7XsIKmaV9LlTkp0A3RDkcJEhmq+dwHqnTNd7dJToLjDNf/FGifCuXngrioE6S7NlvBDnZZzuFaz5uzrSzDhjIdToqTtIeV7byFwccAdzdp+WSlDRRwnEQEBqAAcgunuzq3ivIlgjWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nayGQg+B; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nayGQg+B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777551966; x=1809087966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y1C501JONhNNAVfQFgCHZpYKC+oUFWqSXemVKft+MIg=;
  b=nayGQg+B7Gc3uO0EQzfKR2gd4XkSwxZtx96EgQCioFfJp16MBZv+LZOo
   r+m/PQbFpz/MSPForFF6Ns7tVckUDn/zRFkoBQPGG8GEhXr52zzM+lS/N
   z1Vj6d6vaYjBDJI2kVsvA7cTPYsDk7ELMOgjUmxcjvBkvit8OrrBx0Xgn
   Nsdo4ul5eWsyKabbr5lsrhk/pMpbqZH+McdC/UkbARZqWDuU4pVaINW6J
   uuQkHPab9CSY8oxp4mHtd+F5wl//0s2/bDFvdmcL4zTp/iBICKqCZvCMz
   iKtjyKcmN2Z2TzV3CBZuI/06R0a6/JkKRuL6k1HM/kTOkX5luyvE1Ze2X
   A==;
X-CSE-ConnectionGUID: qaEu5ugXRm6fduOMYdSWUg==
X-CSE-MsgGUID: 0HooY1FVSOu+bXV9bTx2iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78689181"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="78689181"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 05:26:06 -0700
X-CSE-ConnectionGUID: iGpTe9cgTJqrJcYaeqGlxw==
X-CSE-MsgGUID: Mfr2tqbKTTGcHSYViPM7Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="233538423"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa006.jf.intel.com with ESMTP; 30 Apr 2026 05:26:05 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH 1/5] ice: fix ETH56G Rx offset type description in kernel-doc comment
Date: Thu, 30 Apr 2026 14:25:58 +0200
Message-ID: <20260430122602.126722-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260430122602.126722-1-aleksandr.loktionov@intel.com>
References: <20260430122602.126722-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

The ETH56G MAC register configuration Rx offset field stores a signed
integer, not an unsigned one. Correct the struct comment that incorrectly
described it as '11 bit unsigned int'. Also update 'unsigned ints' to
'unsigned integers' for consistency.

Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 9bfd3e7..c1aa408 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -144,9 +144,9 @@ struct ice_vernier_info_e82x {
  * @tx_offset: total Tx offset, fixed point
  * @rx_offset: total Rx offset, contains value for bitslip/deskew, fixed point
  *
- * All fixed point registers except Rx offset are 23 bit unsigned ints with
+ * All fixed point registers except Rx offset are 23 bit unsigned integers with
  * a 9 bit fractional.
- * Rx offset is 11 bit unsigned int with a 9 bit fractional.
+ * Rx offset is 11 bit signed integer with a 9 bit fractional.
  */
 struct ice_eth56g_mac_reg_cfg {
 	struct {
-- 
2.52.0

