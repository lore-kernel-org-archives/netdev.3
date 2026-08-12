Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973B116A956
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 00:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493367; cv=none; b=O/D/yYRpwopUzAl83B405mx/fzYQBHcRuzbKBFXFyGlhlt3ESTS/pQrkk/1dA6z0ckVozPKKHnwRvAM7ewHgv0XFUW9EG0NjcV8qyIiP4b9yFflsRTy7eWDiOu9y2lcMypp68vQ49aTzk2LSD2XV69lNT8z/GdqWnJME8R5/rJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493367; c=relaxed/simple;
	bh=3Gx7QYG4XVhG/hKfrYfnsMEDrRer89o2YFIUzxs4VCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QQAkiCNKHNnRbp2IaNaR6jL8Hna1kKkybujFmxBIU2g/K+qERCgl3uIF2YP1SmwSyp4WhVVy/v1tdk/QYCOrYyKEttRFbLjyb1EfocfgQUDrwtCZhKdfrRAV2ieb5d/BdncF6rbULo3VwH2OAzkcanCaYxF9BC7X6IMKfsKB7Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XJ9Hgd1R; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XJ9Hgd1R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786493365; x=1818029365;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3Gx7QYG4XVhG/hKfrYfnsMEDrRer89o2YFIUzxs4VCw=;
  b=XJ9Hgd1RU6INcU7ohvVl6vqGc/gR20qLSNLDSbEa7IzJ/M83oBr9YTDy
   Tkr+bu6SYEI95wrUgMqKEYV2HFAoWRpJGp0zCazbx5Op55lEu6btvMPGB
   QNb/+bcBeALpZgVvBbTid7HmITUPh0CWf3l6ScVyi5d/qiDMVXT5xvXUu
   SzVH3R8KQKqgEaw2BtLVY68Ofnl7nFgiuyoUxwgSJVnjLryI1OQ1No72a
   YS5S3Z8PrSN23w4oQUHROSZtWiTEAwS0VsPp+jTWGKChK0SM6VA0LJHSW
   S7cLpX/Dix/4FEB4HKdXVUUsK+ld7DPKWND0SxOB58hGp1ZCvNcKzjDjP
   A==;
X-CSE-ConnectionGUID: eDROlq4GS3CJUykRM537Mg==
X-CSE-MsgGUID: EB97MJN2RJ6o+Yf/vuoUcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="87110543"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="87110543"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 17:09:25 -0700
X-CSE-ConnectionGUID: OUMNvxMvSlms6Ny2uK+Vzg==
X-CSE-MsgGUID: +3+lqc/PR5+30Zu+7owMsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="263522971"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 11 Aug 2026 17:09:24 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	aleksander.lobakin@intel.com,
	konstantin.ilichev@intel.com,
	richardcochran@gmail.com,
	poros@redhat.com,
	przemyslaw.korba@intel.com,
	przemyslaw.kitszel@intel.com,
	robert.malz@canonical.com,
	willemb@google.com
Subject: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates 2026-08-11 (ice, idpf)
Date: Tue, 11 Aug 2026 17:09:13 -0700
Message-ID: <20260812000918.220714-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ice:
Przemyslaw Korba adds a fallback path to utilize sideband queue when the
low-latency PHY timer writes time out, likely, due to NVM updates or EMP
resets.

Petr Oros restores call to ice_clear_dflt_vsi() for the default VSI in
ice_vsi_release() to ensure no stale rules are left in the device which
can cause various issues.

Robert Malz breaks NVM reads to occur under separate lock requests as
large combined NVM reads can cause the NVM lock to be held longer than
maximum allowed time and be reclaimed by firmware.

For idpf:
Willem de Bruijn fixes possible endian issue of descriptor by adding
cpu_to_le32() call.

The following are changes since commit cba9ccb47e9fa4cc77692fb896cc5ab57a667882:
  tipc: read le->link under the node lock in tipc_node_link_down()
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Petr Oros (1):
  ice: clear the default forwarding VSI rule when releasing a VSI

Przemyslaw Korba (1):
  ice: fall back to SBQ when LL PHY timer interface times out

Robert Malz (1):
  ice: acquire NVM lock around each flash read

Willem de Bruijn (1):
  idpf: add missing cpu_to_le32 in idpf_tx_splitq_build_flow_desc

 .../net/ethernet/intel/ice/devlink/devlink.c  | 32 ++-----
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 16 +---
 drivers/net/ethernet/intel/ice/ice_lib.c      |  3 +
 drivers/net/ethernet/intel/ice/ice_nvm.c      | 90 ++++++++++---------
 drivers/net/ethernet/intel/ice/ice_nvm.h      |  2 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 38 ++++----
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  2 +-
 7 files changed, 82 insertions(+), 101 deletions(-)

-- 
2.47.1

