Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89FB4F648A
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014875; cv=none; b=EyxGoAJgMSzNGLg53cxTW1jH0rR8T7sEH/joY3Jws13rrZsMfiebjvRDRxpbJlWhjboNDMlZ4d1dTOlrYyYW/bOq3vkpSwKUkX+CR/lpSBbXAVzCzQzInUkX9N0mZrEJR41FCHuMfvL1tUqkRVf7G86MTqgmPc5Ey6QQbyqdOFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014875; c=relaxed/simple;
	bh=BTVOElioEK9rnPU/6uipyk3WcaLnl+ZyqVCBGeiFycE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CT7n+J308VT2ShftbQ9YjqdwmNelvMlK1IqwCd8jzZiiL5vxSpuYNEPFbkARrUnfoEgHAeJkzZXBS9YB83rBQmIBpGymGqnobgnHqaxd1TK21I4jebZ6VOtR7RXMu0yCgvf4E1cpgpxNq5PwwLWoYkGnF6X7HpSZJV9XOeko+BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hpu0whqA; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hpu0whqA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790014873; x=1821550873;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BTVOElioEK9rnPU/6uipyk3WcaLnl+ZyqVCBGeiFycE=;
  b=Hpu0whqANh/j0sKJd0JwzKz3qf7XDIBpScQNuWwyCuZOz6V0kcuMM0V+
   NE1WALg38nELKG2llRsfzV7N+SKbOEzhOyw5a6xJxWlUEu4lqxLwGpD1p
   64A1HySc99fOD01ddm0Flgrsx+QcumkagCgr3TrkCA7OpJJR64AulIYyG
   OiFLIb6JtNJrPKya1RDUkx1fiKq2Nzi5LlL7UD0ie/5AQv54fvK6BnHF4
   5E5qu3p1jDvh9yxUUjpxHuxfz6Glh7Ncn1lPnfVxP4CRVCvf56jnotb+k
   shrg/gLOKzv5hAFasNvf0YO7wvD0KSe3FPs5e/XYrTQL9UdVtuE2xEMBd
   Q==;
X-CSE-ConnectionGUID: c3dF2KR/QUuZ4TZ+qHgsGQ==
X-CSE-MsgGUID: G2HmLiS4S26mK0rVYxESrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90426140"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="90426140"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 11:21:12 -0700
X-CSE-ConnectionGUID: RmL6OqeTTnSuwQJdupD5yg==
X-CSE-MsgGUID: eolBLf60SC+I0/YlXXiLUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="272267050"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 21 Sep 2026 11:21:11 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	przemyslaw.kitszel@intel.com,
	mschmidt@redhat.com,
	poros@redhat.com,
	aleksandr.loktionov@intel.com,
	horms@kernel.org
Subject: [PATCH net v4 0/5][pull request] ice: fix stats array overflow via proper realloc
Date: Mon, 21 Sep 2026 11:20:59 -0700
Message-ID: <20260921182106.1015019-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Przemek Kitszel says:

Fix OOB access to the stats arrays.

The first three commits are simple refactors to make the rest smaller,
the fourth one untangles the logic/lifetime of the stats array entries,
then we have the final fix by Michal for VF OOB access to the stats array.

Michal's fix was made prior to the rest, I have only slightly changed it
to base it on top of the pre-work commits, that should resolve all the
corner/error cases reported by AI.

The series was made anew vs the [v2], but the goal and spirit is similar,
but I have started from beginning instead of playing whack-a-mole with
yet another corner cases. We are also back to [v0] by Michal, as it turned
out to be more elegant finish with my first four patches already intact.

[v0]
https://lore.kernel.org/netdev/20260520183501.3360810-3-anthony.l.nguyen@intel.com

[v2]
https://sashiko.dev/#/message/20260812204619.32253-3-przemyslaw.kitszel%40intel.com
---
v4:
Rebase and resend of:
https://lore.kernel.org/intel-wired-lan/20260911113848.44086-1-przemyslaw.kitszel@intel.com/

The following are changes since commit 1e24c4f2ee44be0eee94092b5d13cbdb4bdf0d60:
  selftests: tc-testing: add a lateral-drift hfsc classify-walk test
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Michal Schmidt (1):
  ice: fix stats array overflow when VF requests more queues

Przemek Kitszel (4):
  ice: extract __ice_vsi_free_stats()
  ice: extract ice_vsi_new_stat_arrays()
  ice: extract ice_vsi_get_num_qs()
  ice: rebuild ring stats arrays instead of reallocating them in place

 drivers/net/ethernet/intel/ice/ice.h        |   8 +-
 drivers/net/ethernet/intel/ice/ice_lib.c    | 295 ++++++++++++--------
 drivers/net/ethernet/intel/ice/ice_lib.h    |   1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c |   4 +
 4 files changed, 183 insertions(+), 125 deletions(-)

-- 
2.47.1

