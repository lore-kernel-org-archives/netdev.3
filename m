Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9E04756DC
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476933; cv=none; b=NAQNuU6INsZS6i0mV0/36eB/rDZS9stLZo3mYbOmTeDRDEufd1KrFWkPPYuVP5E8MeN+t2AmZJaK77KAmsYt1miTw99+a1jeQjG1KTyJUxHENyqUpNhxcdUD1hXoseiq0Nv3Igs/Vgt+CjM3Vdw6q2Hh2pu1mpmNweAOLO/wcSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476933; c=relaxed/simple;
	bh=FeeLgtXyIcvN3lZwwvk132f5c+qCV/DoD+T1EPFYWJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WwqEUgYz8NO8RVezZCIXml+1n2Z6IH0R6V2Olx/dCVyCenYs5Z7QFBV5Viz5KNzSEsQs9CKhZ10aWsUH9CGy8XTDWpgCI78XEBAcjfxZLA014akhUBQfHpD6k+y5ftiSvmDYHKgE2vxX6R+nF54HfkAcqEI2F/OCElHBfRbrDFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TpDplQhy; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TpDplQhy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789476932; x=1821012932;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FeeLgtXyIcvN3lZwwvk132f5c+qCV/DoD+T1EPFYWJ8=;
  b=TpDplQhyk+ps3f1J4jwSxrgCR6aZrs5t+b7yt3tRqcN5naKDBn1zWIr6
   M5OE2V/PnvadMV+H5dgKd3HWdFAnCt8U60dh4ncBOrnS6LiQABk8nQDgw
   4ADeB8THoQNA4agVGfFphYNeQ2HHo/C3M4mIM73tJ/12LPJfy6+VVezE0
   EIRYELHtAE4dZ6giheueLSOyVK7DRH21usT8q6Z3qKpwi+X1zDC+kWMwf
   QYyo3nEQtvSHYogbRLUh5eNJHKTNxzqX95UWxNZMRG7ZjohlHyvXFxcj6
   HqMR2ZxzGUwzWvDp1j1HMwgetkL0iOy+N/S2c4OiEbQ09ZFsYtz1NqZbZ
   Q==;
X-CSE-ConnectionGUID: 8MiZU0YCTau9nHxQOfIUrw==
X-CSE-MsgGUID: LPDE+/fQRReX/09p9dHtXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89853100"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89853100"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 05:55:31 -0700
X-CSE-ConnectionGUID: RFU1mVnQSCemnmpBejX2JA==
X-CSE-MsgGUID: xdqzrvrvRKOzFMB8kE1x/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1225164"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa011.fm.intel.com with ESMTP; 15 Sep 2026 05:55:31 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v2 0/3] ice: fixes for pause reporting, autoneg and RDMA
Date: Tue, 15 Sep 2026 14:55:26 +0200
Message-ID: <20260915125529.3975723-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of the ice fixes patchset for iwl-net.

v2 changes:
 - Dropped patch "ice: fix 'adjust' timer programming for E830 devices"
   as it has already been applied to the iwl-net tree.
 - Dropped patch "ice: report EIPE checksum errors to the OS on E830"
   from this send pending further internal review; will be resent on
   its own once that concludes, rather than holding back the other
   three unrelated fixes.

This series fixes three issues in the Intel ice driver:

- Asymmetric Pause capability was missing from the ethtool-reported
  supported link modes, causing ethtool to always show Pause as
  unsupported even when the hardware supports asymmetric flow control.

- Autoneg disable was only attempted when AN had already completed,
  ignoring the case where the link partner does not advertise AN ability
  at all (AN37).  Both conditions should allow the user to disable
  autoneg.

- RDMA was incorrectly disabled on E830 devices with 4 or more ports
  because the generic port-limited-capabilities path capped maxtc=4 and
  then cleared the RDMA capability bit.  E830 does not have that
  limitation and must be skipped.

Konrad Knitter (1):
  ice: fix autoneg disable when link partner doesn't support AN

Lukasz Czapnik (1):
  ice: support RDMA on 4+-port E830 devices

Tomasz Lichwala (1):
  ice: fix asymmetric pause negotiation reporting in ethtool

 drivers/net/ethernet/intel/ice/ice_common.c  |  2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 29 ++++++++++++++++++--
 2 files changed, 27 insertions(+), 4 deletions(-)

-- 
2.52.0

