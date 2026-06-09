Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B4B36215E
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781025906; cv=none; b=ofhfKP8vqn1o+hvGSyNnh0zFf83PPvXQnDmsZgsNAmRFTH/+efjsVvBtb29/xCSKHRzEbzec2ZEl4ECkmVikFSO5ySB8EK6WS9H1TDCV/Zdbt9GREVEG0DIAcZ+safg6GYJ3l4wRgMYnhiComnWrkDTNZ+9Ph+VpoLmsBL/eaeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781025906; c=relaxed/simple;
	bh=VuvrZhOahERiPEnoR8psCGdN87TZg7mRsVFM0v28rCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KuuL5IxA3DZ/rNVZv6SEv3CjaX9pdeSHH+BblG0r/3PG2q5KZCoCXa9F9Z/XQUVaUD76sSc3Tbt5oHUl4m/eDeFfdaIVvx1v1EacWasjsevvE1k9otNkhMvJyByT2eby2ihjqd4PyHp0BSc4hEAC6ILnxsnHlyFHOF8EqO8UBfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q9HHVLee; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q9HHVLee"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781025904; x=1812561904;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VuvrZhOahERiPEnoR8psCGdN87TZg7mRsVFM0v28rCo=;
  b=Q9HHVLeeA57e99kOhGJ18S2m0JOG9FDqzleyS6cpuMieI1HL7+4pmly5
   bixngQvMZDa9advtcrfwVHW+BhbIyhE0LrHX2zQvaaRkXqIbWehfYz+qU
   UteIyUMlrUXhm+SrtXZ3/8ksgnclnDoC90NHNB4n9Xqi36/UMB8nA78Fw
   qo/200Y1+IFz82B5q4NnE3bqANd6Xa4GTzvVV9wo6QxmIYzqG45J+6FSp
   0qYmLX7xMdxBJmnIVmEqug6Aq2+4jA3DJ65irVyh9jKPe4mZBiUTFNjGZ
   q4nlKpYpN9XWyRGHvAd1jouAXvMoB9BdnctQIXDjoEeaue0W8tRDWPJca
   g==;
X-CSE-ConnectionGUID: FDPJma5cSf2QtZq4StzF+w==
X-CSE-MsgGUID: XYmcYyAoREOYtzZfc5Ze2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="99373415"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="99373415"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 10:25:04 -0700
X-CSE-ConnectionGUID: w/fQcriPQl+FRhqH+oy6Ug==
X-CSE-MsgGUID: cJoBymkQRUCxUHc8EFVgCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="250995084"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 09 Jun 2026 10:25:03 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates 2026-06-09 (idpf, ixgbe, igc)
Date: Tue,  9 Jun 2026 10:24:53 -0700
Message-ID: <20260609172458.4046222-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Przemyslaw adds needed padding to idpf PTP structures to match firmware
expectations.

Larysa bypasses XPS configuration on XDP queues for ixgbe.

Khai Wen corrects offset into packet buffer when handling for frame
preemption on igc.

The following are changes since commit 0aa05daef7848a5ac11158949dc73cd741995dc1:
  Merge branch 'net-mctp-usb-minor-fixes-for-mctp-over-usb-transport-driver'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 200GbE

KhaiWenTan (1):
  igc: skip RX timestamp header for frame preemption verification

Larysa Zaremba (1):
  ixgbe: do not configure xps for XDP queues

Przemyslaw Korba (1):
  idpf: add padding to PTP virtchnl structures

 drivers/net/ethernet/intel/idpf/virtchnl2.h   | 12 +++++++++---
 drivers/net/ethernet/intel/igc/igc_main.c     |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  3 ++-
 3 files changed, 12 insertions(+), 5 deletions(-)

-- 
2.47.1

