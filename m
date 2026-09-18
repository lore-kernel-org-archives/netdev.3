Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4D1427FBE
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738358; cv=none; b=LbhOj7bIznunSjAQxiZ++pastbkfEYkYhgoihE3A5AJugl7J99GrbYjz99GenFdT5zF5xKAELJLBnWKTaHuFZStlit1+IwsEJcT+pSO/tf92qHdSILe8wlrlM243g+y4dBgtdIhsnZtNE1Nq7hvZbP4J4zx0RPoSCpAF7NkIE1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738358; c=relaxed/simple;
	bh=gHTpFXKwL2ZqWGfSetLnqS0tikQNlo1jF0x0L1zCQfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ic3cfK+zHvMP+pVtD9QfKZzH4rhssVkjZ1FKutAhX1PjNFtKO6BspKPg5hFVXkhuLpUKJbemcjHhQHI4/M67WstPgdGWFAAOCkX/m3oibN7XG70yDU6avpyE9WBPj4Jlh2Z48akEiz1qjyKxpvtxeVtTORJwf/aOay+2sHhsVEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AUpD5dDk; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AUpD5dDk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789738357; x=1821274357;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gHTpFXKwL2ZqWGfSetLnqS0tikQNlo1jF0x0L1zCQfA=;
  b=AUpD5dDkWoL6AjMc6iM7nDr9fDA4W99poSqqzBg0VUXVlTa6cfhK9nuS
   1dkKTOzObkkUwsFS8FkiDRVsw+XTtU+pnIngpEH3MeBDRIC2zuKMmKNYa
   cND/r+9MWGkx1oXtt5HXbFHsJxClHn0xiNAva0rOM5vp93THG74FQe7Ul
   pZltFnu3v5x+ZBi1vkmpC1J7iSvbQTTdbnwNN+Fz2hR4hm/QQ3Ge0wrb3
   lNKmZ3sOi7abp242dAf9R6jIIwnuSQkZ3cDcgqE5wVhU9WfXTa0PtFEKs
   sZOh5vQSttWFrQvHjQRka4ybOUdMZMBlESwtVmIPzDJbQoFnrF+x4WH01
   A==;
X-CSE-ConnectionGUID: in5WocoLR5Wdl8hEZrRO0w==
X-CSE-MsgGUID: 8CsoAjcPTiazFhPxkKnmEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="115776407"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="115776407"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:32:36 -0700
X-CSE-ConnectionGUID: cYkKlW6NQjumJZGZlpnodw==
X-CSE-MsgGUID: Cx1N53GCQPOdsz+EFbWJdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="2835231"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa013.fm.intel.com with ESMTP; 18 Sep 2026 06:32:35 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v3 0/3] ice: fixes for pause reporting, autoneg and RDMA
Date: Fri, 18 Sep 2026 15:32:31 +0200
Message-ID: <20260918133234.4169074-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v3 of the ice fixes patchset for iwl-net.

v3 changes:
 - Patch "ice: support RDMA on 4+-port E830 devices": gate the
   "RDMA functionality is not available" dev_info() on the same
   condition that actually disables caps->rdma, instead of printing
   it unconditionally whenever num_funcs > 4. This addresses Simon
   Horman's review comment that E830 would otherwise log a spurious
   warning even though RDMA stays enabled on that hardware.
 - Patches "ice: fix asymmetric pause negotiation reporting in
   ethtool" and "ice: fix autoneg disable when link partner doesn't
   support AN" are unchanged since v2 (Reviewed-by: Simon Horman
   carried forward).

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

 drivers/net/ethernet/intel/ice/ice_common.c  | 14 +++++-----
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 29 ++++++++++++++++++--
 2 files changed, 33 insertions(+), 10 deletions(-)

-- 
2.52.0

