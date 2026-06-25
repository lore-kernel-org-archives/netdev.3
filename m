Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4BE3E8326
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 15:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782400485; cv=none; b=RGuJW8pZBbZFD2qO3gh5HAsdKO6DiBts8QDIFzWwIrE9TQEn+ZdINBGuV4Y3hhNhfT8XGjxyYnh5EsOHE9jhmFjoCGk/mka8TSerdhq2vL9hGrFEuncBZptZBxiFvB+/uIs/8mzw/tpV4Et4I+5ZUgK3yYlikdtjHRhypedxqrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782400485; c=relaxed/simple;
	bh=qcsBNcZnHyQgCK+3BSI8JZB02DcVgc0h2SEbrwsRgh4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LwmdRaES5iR498CRutaNFb7paitfi6m3KaFjgpEgB7yTWHwmuy7yuPulWM2kVxFjKG059KuCUI/5Rdu5ZL62mcrfequ1tirVgtF1Ie9izICbsHzYxKheGsC8UGRguJ9QbT7VNbgWJqGLb7TGU5NJLfHYaRvht7iiUwvi1yRh4C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YHbHDMfS; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YHbHDMfS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782400483; x=1813936483;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qcsBNcZnHyQgCK+3BSI8JZB02DcVgc0h2SEbrwsRgh4=;
  b=YHbHDMfSemQoPiLUPK8g6WIZgXJpAYLKWPnog/gowAts93+DBxi3FnQq
   UuynlEtBw90BdCO9iDCuQADYv3akVRCg9OMGe5noqBWnSty1M7DXN86/M
   eUWrqLHM6kEoUk2im/coDTWZIF4VZCCBKC+ZkE5k7/z3oIZLOczQ+XvMw
   b5UOiwzPlaoWGnB/lvcO4pBCzwU5bYjPF0TunfuIjz1IUWdWkFzXlk40B
   XPvi7V91iWBJUSBjXtM/qiCPxUqVqq06B45R9JW76X3nflN4jxsi8FEt9
   MD2trUpz4DwsOgTvNJ4qcudSx7KJLWklvoHB5Q+wT8YT/PoyHIlstpwrv
   g==;
X-CSE-ConnectionGUID: Epz/fylVS4uCuj7AyWkjOA==
X-CSE-MsgGUID: Rdw9q3krQ0CSJgzrjJM1ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83304521"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="83304521"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 08:14:42 -0700
X-CSE-ConnectionGUID: 3Js0l7x8Tk2OZU5axmxEfg==
X-CSE-MsgGUID: zVX3tQDURWapNRg7P3Cvdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="254866926"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa004.jf.intel.com with ESMTP; 25 Jun 2026 08:14:40 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v4 net 0/3] i40e: re-init and UAF fixes
Date: Thu, 25 Jun 2026 17:14:28 +0200
Message-Id: <20260625151431.1102838-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4:
- add preceding patch that fixes a case when some of re-init allocations
  failed and we missed de-registering netdev at failure path
- pull out i40e_vsi_setup() changes onto separate patch
v3:
- address UAF when ring arrays were freed before q_vector's ring
  containers (Sashiko, Jacob)
- remove bool params from alloc/free array routines (Simon)
v2:
- NULL vsi->tx_rings in i40e_vsi_alloc_arrays() (Sashiko)

Maciej Fijalkowski (3):
  i40e: unregister netdev before clearing VSI on reinit failure
  i40e: fix potential UAF in i40e_vsi_setup()'s error path
  i40e: keep q_vectors array in sync with channel count changes

 drivers/net/ethernet/intel/i40e/i40e_main.c | 76 ++++++++++++---------
 1 file changed, 45 insertions(+), 31 deletions(-)

-- 
2.43.0

