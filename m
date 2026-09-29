Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330EF3B774F
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 23:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790723603; cv=none; b=Q9cP4yMexE8/bnptB0irsXtTFwqe20OSruHMk1OyYtbWPgonzXHhk3zpSQvJ02L2HtXvjXfEr+qgqwjHLdkYtd1quCddrSBqIwINN8BksS2gKR9+xmgjJuTrZmaplTDUquw0f4UVqFv9DmgcfHx1RhqLXAGdiSUd0OJcTfAfcT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790723603; c=relaxed/simple;
	bh=MgdOA69ImKXHSrD5xRsaYgWggtJj7DCxORgx8PJsmsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YB7t5/gFjgVasEQ86TECxcJeRQSQgADxCEcjOkd3B4AcMH9jTfggboLVs9nJATqZQP+0C8WN4lwa9bjvPvkn+kCHJjaiBTWTXQkRW2pUOXxHjhh0dF+aAXTIyC0/H6sSnLOIm1QD1CnahtmSmKuFlWCtU9XI+P2ud6pdkaTchC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gWKc5Nhl; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gWKc5Nhl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790723601; x=1822259601;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MgdOA69ImKXHSrD5xRsaYgWggtJj7DCxORgx8PJsmsk=;
  b=gWKc5Nhlof+NlavM2Q2Wm7uRnxx2nX5rGGI9p/lq9Qkpm41Ob6zEgVM/
   cTMfBCg1MeDIFroJIPEsXt+hyR+1LrnLqF7YVMSXEeR0if+8lWaaooB/Z
   LeYLfUjQ5/Jt4KMe7srtnpLnin8TH/OXjQoceZMnpmMr126OJI5sIS63Z
   tbndOqhaH5XQb0XMA7O1D3rs4wiZ9e7h+TFPrRzFSfhg5f2wIR1gZQJlW
   taSuIrzJ6KUQTWW+r76gq4w3vitKCgEYR9T7BT3ZAjQ7ODj+OyaO3Dutu
   DewxkxFQCQg2ayXKJACRJiUOx3WbXRogNRTFuqnVucFdKaywk0Vnt5JPQ
   w==;
X-CSE-ConnectionGUID: Y0jMM8wYSq21VVJddgmUtg==
X-CSE-MsgGUID: N6FaXdLETQ+TqCzeqfsymA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="91550407"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="91550407"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 16:13:20 -0700
X-CSE-ConnectionGUID: 6yDZzUhMShGhesZhSa3ygQ==
X-CSE-MsgGUID: /R/iiIa5R9KS5R1DKwEMLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="280264662"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 29 Sep 2026 16:13:19 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	aleksander.lobakin@intel.com,
	sridhar.samudrala@intel.com,
	emil.s.tantilov@intel.com,
	boolli@google.com,
	decot@google.com,
	brianvv@google.com
Subject: [PATCH net-next 0/2][pull request] Intel Wired LAN Driver Updates 2026-09-29 (idpf, libie)
Date: Tue, 29 Sep 2026 16:12:59 -0700
Message-ID: <20260929231305.1515873-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alexander Lobakin adds flow-based XDP fallback on idpf for firmware
without Tx FIFO support by tracking out-of-order descriptor completions;
the faster queue-based path is used when available.

Li Li improves virtchnl failure diagnostics in libie by logging
transaction details to aid in debugging.

The following are changes since commit 6e23f90f2b8c3ea3bf904f86f3ed06bf2844b4bc:
  Merge branch 'net-consolidate-devmem-net_iov-freelist-and-dma-handling'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 200GbE

Alexander Lobakin (1):
  idpf: add flow-based XDP fallback for FWs without Tx FIFO support

Li Li (1):
  libie: log more info when virtchnl fails

 drivers/net/ethernet/intel/idpf/idpf.h      |   2 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c |  12 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  18 +--
 drivers/net/ethernet/intel/idpf/xdp.c       | 131 +++++++++++++++++++-
 drivers/net/ethernet/intel/idpf/xdp.h       |  73 ++++++++++-
 drivers/net/ethernet/intel/libie/controlq.c |  11 ++
 include/net/libeth/xdp.h                    |  13 ++
 7 files changed, 241 insertions(+), 19 deletions(-)

-- 
2.47.1

