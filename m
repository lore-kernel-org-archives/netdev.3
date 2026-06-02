Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B46F3C7DF5
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 22:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440922; cv=none; b=bjP3TRe3bF1ZgI3YUN0MGMNx4hXtCzHIgM4BQ4bZCvB9Vhd+4zxp9L2h0wgeVuk7HLuypRB9f/QwH+v508FEXt8WasIAb89matpzg3VFxiaeArEMDkrZ5GlOhmLrEIGlsl01WJV1GtmEQrAzM21DxBjrOjXDNCc3sIvwv0qKurw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440922; c=relaxed/simple;
	bh=dZZC4tIKtPj3Xtq4Bix5YI4A/gNFE6wgV+fdOL+VJbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TB5hI/urPym4YeWxTvmEC5TY4J0BSw5DOPY7FJpcIPyDyN70GX7D1UZ2ue4A130AQz0hqD8IV4+3Giq6mtId8ie6jr7obO1q1y6ynB+l2CagYEr1LFZ8rJGwLqOPz+Hoe8SFO0jBtZ1e3kNjA0WpsIEW3S3K5Pb8qN7GN+zSou8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZjRUsCi; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZjRUsCi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780440921; x=1811976921;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dZZC4tIKtPj3Xtq4Bix5YI4A/gNFE6wgV+fdOL+VJbE=;
  b=YZjRUsCiw4IKpiJ1eVPv6grgOiFUz1QF3fHi8kn4lg/1xsh3uXB3uUdf
   cUuRGLT1GnYSpd5EaTl2ZUVEh0LXsod0J46ZhEXNHCeSE7VI42hzGrPbX
   viYFQUhEXHBrIzIDSuSPbnDgELmjx7DyLhIu6i2o08x945P3zBemBkaji
   YL2v78eadjqaLvrsmqGr8HTo8hnKjD+Eth3oN7PMF6fh9TqH7c0UxyHX9
   oLTZwQbQkpWC6fyb6c/w/TvMviQG95VGlAdD64Jq3pQHGJr81X9FpqvZP
   1yiiu2lfjvNSdy9LmkabcHGbOjnmVUuEMNVH32BVsIdz4HQ+aiuNljIYa
   g==;
X-CSE-ConnectionGUID: vNNyQM2bRnC3W9eEt9B6ww==
X-CSE-MsgGUID: CbEoB3ZcSOqWThKPWaWWsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81421394"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81421394"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 15:55:20 -0700
X-CSE-ConnectionGUID: ff41/f3VQHWne5RadA22RA==
X-CSE-MsgGUID: 2JYIL/vvR8yKFjTVnavU4A==
X-ExtLoop1: 1
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 02 Jun 2026 15:55:20 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates 2026-06-02 (i40e, ice, idpf)
Date: Tue,  2 Jun 2026 15:55:08 -0700
Message-ID: <20260602225513.393338-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Maciej fixes i40e to keep q_vectors in sync through channel changes
which caused issues with reconfiguration.

Petr Oros adds missing callbacks for U.FL DPLL pins on ice.

Alok Tiwari corrects copy/paste error causing incorrect reporting of PTP
mailbox capability for idpf.

The following are changes since commit 3522b21fd7e1863d0734537737bd59f1b90d0190:
  devlink: Release nested relation on devlink free
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE

Alok Tiwari (1):
  idpf: fix mailbox capability for set device clock time

Maciej Fijalkowski (1):
  i40e: keep q_vectors array in sync with channel count changes

Petr Oros (1):
  ice: fix missing priority callbacks for U.FL DPLL pins

 drivers/net/ethernet/intel/i40e/i40e_main.c | 73 +++++++++++++--------
 drivers/net/ethernet/intel/ice/ice_dpll.c   |  2 +
 drivers/net/ethernet/intel/idpf/idpf_ptp.c  |  2 +-
 3 files changed, 47 insertions(+), 30 deletions(-)

-- 
2.47.1

