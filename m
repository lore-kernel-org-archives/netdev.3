Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3C936F42B
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 22:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785882138; cv=none; b=O58FCni+YZfVQzQ06oMP6X7Ytyz2nWnl+4Mrv00VTwUtAK/KDj5VQfBHirHMFecz6hLGL7raZXr71BczoCr5Kawn0EkvoIcRuROiR248AIw+49lh5Q6QjEoxoPrUhUUyZGa3hv27Lq7fJfmQXOnXGOm15xV2Usv20KMD7S9wBes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785882138; c=relaxed/simple;
	bh=luplnSUjLftfqGex+cf5ZNRL9rqFQbFy2fHgzu66dgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BcHh81yL9hjkq8+wJO/pz+9rR5+0hf86TxIEqcDys2ZCLeq48cNZmvdXaM7xqo/wELzH/FJH/fvjFFmEHicWF/JMaziF43bgYAUSDa4Bw4nd4vU913De96WiGUbNcEruKELUPjf4kEPENjk3iSb+aibxUZPpuMk0lGP0QWo7kr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K28i3MOf; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K28i3MOf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785882137; x=1817418137;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=luplnSUjLftfqGex+cf5ZNRL9rqFQbFy2fHgzu66dgA=;
  b=K28i3MOfqryRuJ5mt26euTTbpaws0JUm2IdIuG0ShW00kwJBLDxduUUe
   n7bikyDNP4Kv/GyR7tJX+DMz8n1OCoEw9dkkIcuPLeN7qYN+dW+EU5XUf
   PHdK0MnrVsu2C7e0nf46VlYRn5p/V/zZyA9UK4KyFRSSNHvpcuh8T7DLL
   LccfvQt1XjJtoV2Q33LteMIcMDVwW/FMiCKw4fPTQlIYU385xD34rK7FR
   /hx0r8ggUx+WKbX5tpV4LtIxQ4z8DPZ9Rgh7lNgVnlI3WYoDlsCHvLiu2
   XdStKqgb9iyMB8Uo03aaIaxXcFzfOrOiAn1BaW3FcdWOWxmhcX3ld63Ta
   Q==;
X-CSE-ConnectionGUID: 2TQ5MGtxQBe3lpXz9X33XA==
X-CSE-MsgGUID: ESlEwOVESAq7YYAVAP36BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="96803401"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="96803401"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 15:22:17 -0700
X-CSE-ConnectionGUID: UumoA3hoTpC9nt7UEo1fHQ==
X-CSE-MsgGUID: p1iNPZMjRC2J4puyOdtH0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="257307950"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 04 Aug 2026 15:22:16 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 00/10][pull request] Intel Wired LAN Driver Updates 2026-08-04 (iavf, i40e, ice, igc)
Date: Tue,  4 Aug 2026 15:21:53 -0700
Message-ID: <20260804222205.1580328-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jose Ignacio Tornos Martinez fixes issues with VF bonding that came
about with commit ad7c7b2172c3 ("net: hold netdev instance lock during
sysfs operations").

Further details:
https://lore.kernel.org/netdev/20260623101800.991293-1-jtornosm@redhat.com/

Przemek fixes an issue on ice which increasing VF queue count causes
out-of-bounds access of the statistics arrays.

Doruk Tan Ozturk changes call of metadata_dst_free() to dst_release()
to account for refcount when freeing representors on ice.

Aaron Esau fixes a bad DCB configuration comparison in
i40e_hw_set_dcb_config() by comparing the structures instead of the pointer
variables.

Dawei Feng correct ordering of error path in i40e_vsi_setup() to stop
possible memory leak.

Philipp David changes call of netif_device_attach() to be unconditional
during igc resume, otherwise interfaces that were down prior to the call
will not be restored.

The following are changes since commit a347304b2ca1a5377d5bd2d8a72e4b4f12afe648:
  net/sched: cls_api: Always acquire rtnl_lock when destroying locked classifiers
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE

Aaron Esau (1):
  i40e: fix memcmp of pointer in i40e_hw_set_dcb_config()

Dawei Feng (1):
  i40e: fix netdev leak in i40e_vsi_setup() error paths

Doruk Tan Ozturk (1):
  ice: eswitch: fix use-after-free of metadata_dst in repr release

Jose Ignacio Tornos Martinez (4):
  iavf: return EBUSY if reset in progress or not ready during MAC change
  i40e: skip unnecessary VF reset when setting trust
  iavf: send MAC change request synchronously
  ice: skip unnecessary VF reset when setting trust

Philipp David (1):
  igc: fix netdev not re-attached after resume if interface is down

Przemek Kitszel (2):
  ice: move ice_vsi_realloc_stat_arrays() up
  ice: fix stats array overflow via proper realloc

 drivers/net/ethernet/intel/i40e/i40e_main.c   |   8 +-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  38 +++-
 drivers/net/ethernet/intel/iavf/iavf.h        |  11 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  88 ++++++--
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  99 ++++++++-
 drivers/net/ethernet/intel/ice/ice.h          |   2 +
 drivers/net/ethernet/intel/ice/ice_eswitch.c  |   2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      | 191 ++++++++----------
 drivers/net/ethernet/intel/ice/ice_sriov.c    |  35 +++-
 drivers/net/ethernet/intel/igc/igc_main.c     |   8 +-
 10 files changed, 321 insertions(+), 161 deletions(-)

-- 
2.47.1

