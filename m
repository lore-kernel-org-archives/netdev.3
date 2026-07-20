Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8655D3630A9
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 11:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784548790; cv=none; b=vAgsh2Qraer1NxI2u01g6EuQi3ymv/KAJdobbt5So38O0/+1AX5CSnwlyGx076RedUFFZ2muitysc9eZYDqDS4EaatKjbY22FxeHW/cdM6nMNJH8YMf2N2Xy+NWFjDAspsIAYPrFzGPl7tydWGgfTpTijv993d+zDFqiDof0J1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784548790; c=relaxed/simple;
	bh=cQpFxk8hs1T7IiXEb5h07BYkfLQqnsRKlmfqU5be4UU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R3l0VYuD9ssx51LiSH/STEQpBRKq3JemdKU3Ry0ZMHFZHB37Qp9Npp/P2QcyjFbx+zsQ7eCCjWSat9RVoJBhWNmopznzFT1fyZoGm3JKBUYNjDvkYItFWaXagE7r4HFdm/Xhcz/LD57gu1Qg5UhFNigi7d9iO6CfZlgCaXi0JW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=moXUJ+H6; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="moXUJ+H6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784548788; x=1816084788;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cQpFxk8hs1T7IiXEb5h07BYkfLQqnsRKlmfqU5be4UU=;
  b=moXUJ+H6uZCB8csdO0cFl+xU7blbkH6zjcLPPW/zgOjnGyrit8ntDYF4
   tU3Bs3FbqnPpsrEfQRsIn1g9y/sMihOP+KDkSUU8CEeiHc84gX7iHAZ62
   sLjQ25hmyYvkgykRw2bsFfhiTW/it1vHk/dsAhwod/uNu/4/8N4ti5Dli
   2Iivfg9GCbdaRwwiY2xODui1xFB4+vJYMAebYnGtmCZyfGUiWCRxy9OWo
   3RIKa8QckdIzj1zDWAc5i6ra4B4QIpr5hQF9+CH8BW2U695/kt1nTUecy
   ASkW52LH6w8DgoKD9SzCXoKQoPOdBnUk39QloqQqt9cDfNfBOb4ofqSfq
   Q==;
X-CSE-ConnectionGUID: g6rCz8bIT1uMmjVfqz34IA==
X-CSE-MsgGUID: nbEActXOSLyVj8TFdIoYQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85328161"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="85328161"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 04:59:48 -0700
X-CSE-ConnectionGUID: AYe2gW+wTI6btREDZPeZlw==
X-CSE-MsgGUID: W1JydWI6RTW7h641hKN2jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="258078352"
Received: from pae-d-dell-r7525-263.igk.intel.com ([172.28.191.240])
  by orviesa009.jf.intel.com with ESMTP; 20 Jul 2026 04:59:46 -0700
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksandr.loktionov@intel.com,
	arkadiusz.kubalewski@intel.com,
	konstantin.ilichev@intel.com
Subject: [PATCH iwl-net 0/4] ice: fix PTP timestamp handling issues
Date: Mon, 20 Jul 2026 14:01:28 +0200
Message-ID: <20260720120151.2675206-1-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series fixes several PTP timestamp handling issues in the ice
driver that manifest during link state transitions on E82x devices.
Together, these issues can cause Tx timestamp timeouts, ptp4l service
disruptions, and on PREEMPT_RT kernels, a system livelock requiring a
hard reboot.

The root cause is a set of race conditions in the PTP link change path.
When taking the link down (ice_down) or bringing it up
(ice_up_complete), the PTP recalibration and cleanup were not properly
synchronized with actual physical link transitions. This allowed Tx
timestamp requests to be queued against uncalibrated or stopped PHY
hardware, producing orphaned timestamp ready bits in the PHY registers.

On E82x, the PHY will not generate a new timestamp interrupt until all
outstanding ready bits have been read. Orphaned bits — set for slots
with no matching software tracker entry — are never read, permanently
blocking new timestamp interrupts. The existing periodic work detects
this symptom and re-triggers the interrupt, but without clearing the
stale bits, this creates an infinite trigger loop. On PREEMPT_RT
kernels, the resulting interrupt storm causes RCU stalls and eventually
a full system livelock.

Arkadiusz Kubalewski (1):
  ice: call PTP link change only from link events

Jacob Keller (1):
  ice: clear unexpected Tx timestamp ready bits to prevent stuck PHY

Karol Kolacinski (2):
  ice: keep Tx timestamps disabled until offset calibration completes
  ice: cancel E82x offset verification work during reset preparation

 drivers/net/ethernet/intel/ice/ice_main.c   |   3 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c    | 155 +++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c |  89 +++++++++--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |   1 +
 drivers/net/ethernet/intel/ice/ice_type.h   |   7 +
 5 files changed, 219 insertions(+), 36 deletions(-)

-- 
2.43.0
