Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA72D45C70F
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 11:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788779057; cv=none; b=BoJ44qOpBNs2L3V2xEBpNmjIyy5Vx49td+93E/JgezV3ozt9ZuHSq8W/Nk/dMnfDOK5Cvqz3TWlASD1eYGP87KNjjeabdCFhUMhAJAaOn3VK3av5DikNqJWKPy8DO/wfKrLpea4xBj/6raUn7m+ln4ZqxY+aShvpog0i7dS5OCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788779057; c=relaxed/simple;
	bh=dkW+c/aEGHdcs31Czl1Xa8/WURGdNAowLoEHdpJjXfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GKffMBzkvDNsxuoqNXnFPl3vZWZqUyEDqz3Lu4HqrakI2W0pOCjMwB43T3xS5M2PGHRp83opvCA/Bef+yPc4b3uQtPNMUXGeVlufCI7clzt/HcWbKMyBsg2gaTFxl3QSFSwWhwRa334qnZ4kwgVDZxN69hfySppKEWhCIpljPVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BfKpRE5B; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BfKpRE5B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788779056; x=1820315056;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dkW+c/aEGHdcs31Czl1Xa8/WURGdNAowLoEHdpJjXfI=;
  b=BfKpRE5BT1WzWAhrqXzAuI8gJ8DhTrXeEfHMnN/rSISJS017Vbo1wMuB
   CS2Q8LxchQQxyy1kC0cGMgmimNwalFOMF3qOH8DmcVrYDuwTbz0xbjYpN
   uUcIf6KBzObEZc3TZPsYYXEd5nLflTrzhhgRXGerYMOHfluEIYprhD2J6
   FSKzdzEKpYyszfJudAGXunsx2a5iWncByUPKdCYJB3IicFQdce1G5WPR7
   Saq3Mm80EJWUCiclYQagVxtz1YbUZcLhUcngl04QuXj6Oig7D8ACONJbO
   r09ZcB+Zx6iERE6qaqxqiRc41NKhGJuF23RD/kApz8iJwGldf/7ZwhWlS
   g==;
X-CSE-ConnectionGUID: /0N04ImyQAaOjPfzZH1hRg==
X-CSE-MsgGUID: uGAJl93nQ9qtpDVbO2VF4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="89214056"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="89214056"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 04:04:16 -0700
X-CSE-ConnectionGUID: nCHJH4QvSISRu6YUYVk0xw==
X-CSE-MsgGUID: y94bKgtUTiK7LCnB9PwkKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="274195229"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by orviesa003.jf.intel.com with ESMTP; 07 Sep 2026 04:04:14 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v1 00/10] Interrupts helper in libie
Date: Mon,  7 Sep 2026 12:24:07 +0200
Message-ID: <20260907102418.2697317-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

To not copy the same code to handle interrupts in ixd driver move it to
libie_irq module and use in both idpf and ixd.

First part is changing current idpf code to make it more friendly to be
moved to the lib. Basically there is no need to store MSI-X entries in
separate table. Instead of that store it in xarray which also replace
custom lifo implementation.

Patch with libie is about moving the code to the new module. No
functional changes here, just moving the code or adding some more
descriptions.

The irq code is similar in ice. One patch also coverd the changes in ice
driver.

Last patches is the implementation in ixd driver. To manage MSI-X it
needs to first map correct regions. Do this using virtchnl command,
similiary as in idpf.

Michal Swiatkowski (10):
  idpf: store HW vectors information
  idpf: fill q_vector interrupt registers one by one
  idpf: get rid of msix_entries array
  idpf: drop v_idx from q_vector structure
  libie, idpf: move irq code to libie
  libie, idpf: move hardware irq info struct to libie
  libie, idpf: move parsing alloc vectors command to libie
  ice: use libie_irq for interrupts managing
  ixd: support for getting lan memory regions
  ixd: use interrupt for mailbox communication

 drivers/net/ethernet/intel/Kconfig            |   1 +
 drivers/net/ethernet/intel/ice/ice.h          |   5 +-
 drivers/net/ethernet/intel/ice/ice_base.c     |   4 +-
 drivers/net/ethernet/intel/ice/ice_idc.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_irq.c      | 181 +-------
 drivers/net/ethernet/intel/ice/ice_irq.h      |  14 -
 drivers/net/ethernet/intel/ice/ice_lib.c      |   3 -
 drivers/net/ethernet/intel/ice/ice_main.c     |  15 +-
 drivers/net/ethernet/intel/idpf/Kconfig       |   1 +
 drivers/net/ethernet/intel/idpf/idpf.h        |  70 +--
 drivers/net/ethernet/intel/idpf/idpf_dev.c    | 108 ++---
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 430 +++++-------------
 drivers/net/ethernet/intel/idpf/idpf_main.c   |   3 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 136 +++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  23 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c | 109 ++---
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 162 +------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   9 +-
 drivers/net/ethernet/intel/ixd/Kconfig        |   1 +
 drivers/net/ethernet/intel/ixd/ixd.h          |  27 ++
 drivers/net/ethernet/intel/ixd/ixd_ctlq.c     |   8 +-
 drivers/net/ethernet/intel/ixd/ixd_lan_regs.h |  18 +
 drivers/net/ethernet/intel/ixd/ixd_lib.c      |  93 ++++
 drivers/net/ethernet/intel/ixd/ixd_main.c     | 127 +++++-
 drivers/net/ethernet/intel/ixd/ixd_virtchnl.c |  70 +++
 drivers/net/ethernet/intel/libie/Kconfig      |   6 +
 drivers/net/ethernet/intel/libie/Makefile     |   4 +
 drivers/net/ethernet/intel/libie/irq.c        | 363 +++++++++++++++
 include/linux/net/intel/libie/irq.h           | 118 +++++
 29 files changed, 1174 insertions(+), 939 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/libie/irq.c
 create mode 100644 include/linux/net/intel/libie/irq.h

-- 
2.49.0

