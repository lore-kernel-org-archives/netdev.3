Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A884CB8A7
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 21:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788903912; cv=none; b=PSTfABMivvG6mUG+CZjXpXUko2764HnOapY23JN1YMHF5ijoRF1YBaN7UD8ISU7rcC00wrwSl8H0Bq6rwpz4Q3fvHck68FMVIyD+BKLsYODB3NhsIvgAFbjncQG+nqXXch6Lx3VFjd9y0PDSSq9DWjqQYseLbCg9PHYY8O2qIik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788903912; c=relaxed/simple;
	bh=zKKQYUv5Tz6Kwwp2kIzpclRMQDkNBMklWozFqh5xBfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qmCY8FM3rISPoB1D8wLkUPcsTW22iOQ7BSS2USfkXJvqniiaRQ9K8CV1cQS1wdXzl3gxgK/VVWyS58mSX4NsGbMJqzGbr7omSWbTUmOibu4X6wePHA0ISZYj0SLZb+SkOkWp01LdPHWVQoVNJ0L4i2oHru/kQEnvu/XTVB7BgFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H1+SDxm/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H1+SDxm/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788903910; x=1820439910;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zKKQYUv5Tz6Kwwp2kIzpclRMQDkNBMklWozFqh5xBfA=;
  b=H1+SDxm/MIp86pvTz100tIhNNfCWfib5c+aA0bvtfaLPEgh3N+BTbHU7
   J36QsXmaGjd9IACuZAKi6vSMPaBF9PrqtHkXPi5ZlyeRXuuu5Bkng+OXa
   I7T+pR4qilEgm73eLBysiC/XgkV1TLI9yceonp+weObq6yeRIlaiK9baY
   JlZsX+Jl3j1+fhTofHnaPCAm9C02n3cMA/4ZD5SqJ5p6UVVbWZtgo03Kg
   Rbs5baXxvBJPd8vVJwblV2an4lIERPpii3ijMyulRrpt+VUqN+UweBKG9
   Lwc9ZoJ7Tai1see8gHpjXX+zXYDHHAgtrW2b+g27eFYEuuNpLIywT1E4h
   Q==;
X-CSE-ConnectionGUID: IbMjG1cVTM6+QpI6EJqZ9w==
X-CSE-MsgGUID: fsS1cA3DQZiEv20RRMDFHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106836212"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="106836212"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 14:45:09 -0700
X-CSE-ConnectionGUID: /GN6LHOuSKeqmat7Auoe4w==
X-CSE-MsgGUID: KLPSqSkETKKYfmqDWwW81Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="269782489"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 08 Sep 2026 14:45:07 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	ae878000@gmail.com,
	mhun512@gmail.com,
	joshua.a.hay@intel.com,
	sridhar.samudrala@intel.com,
	milena.olech@intel.com,
	vadim.fedorenko@linux.dev,
	willemb@google.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	jbrandeb@kernel.org
Subject: [PATCH net 0/5][pull request] Intel Wired LAN Driver Updates 2026-09-08 (idpf, ice)
Date: Tue,  8 Sep 2026 14:44:55 -0700
Message-ID: <20260908214502.528440-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For idpf:
Myeonghun Pak adds calls to disable DIM work and PTM to allow for proper
cleanup.

Josh adds check, and adjustment, for VLAN headers when processing RSC
packets.

For ice:
Jake adds call to xa_destroy for xarray sched_node_ids; also moving it
from port_info struct to ice_hw to simplify its lifecycle management.

Jakub Kicinski stores trace event data as scalars instead of
dereferencing pointers in TP_printk(), preventing use-after-free issues
during event printing and eliminating double-dereference warnings.

The following are changes since commit e0554c6276da957b6e72849520c70a97404cd1ae:
  Merge branch 'net-ethernet-cortina-fix-rx-budget-accounting'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 200GbE

Jacob Keller (1):
  ice: add missing xa_destroy for sched_node_ids

Jakub Kicinski (1):
  eth: ice: don't dereference pointers from TP_printk()

Joshua Hay (1):
  idpf: account for VLAN header when parsing RSC packet header

Myeonghun Pak (2):
  idpf: disable DIM work before freeing q_vectors
  idpf: disable PTM on probe failure and on remove

 drivers/net/ethernet/intel/ice/ice_common.c |  9 ++-
 drivers/net/ethernet/intel/ice/ice_sched.c  |  4 +-
 drivers/net/ethernet/intel/ice/ice_trace.h  | 64 ++++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_type.h   |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c |  5 ++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 34 +++++++++--
 6 files changed, 86 insertions(+), 32 deletions(-)

-- 
2.47.1

