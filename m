Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765C53905EF
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187810; cv=none; b=kBVLizIJlL8Jc3CZE2b+oO0ibhLniav3jBVmK2lnmdOAXsQ304KyeAW2+eXAaZJBBQwmOI9REQ6myeYO2Ds0nvB2b2LVWVVF9OUEn3y3H21giylUDL+ZY545dnZ8oejZb9F80D3jTkZIzEGXrFH4REKz4fr1lZjd6DksdOsjLDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187810; c=relaxed/simple;
	bh=H5foepN8aexM1UQq0RaDqG3HWzUyygLeU7cCbXw9+Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pED1Ar/Jq7XB3At8Q2/8GYBe2ETbZ4fVyaMIuXjNpe9azHYXfqGRDuRUh6EGLILWtSknCDje8DSugxfl40H49s8pbS7iqzYPyOF4OAWm8nvVBqJx4T+W+P9giMU8wuqrrYJxKN4KXxfmqxxlkw7TjY0DA6br0N9HxEyU1GwZ8Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O6NEKKBp; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O6NEKKBp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788187809; x=1819723809;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H5foepN8aexM1UQq0RaDqG3HWzUyygLeU7cCbXw9+Tw=;
  b=O6NEKKBpBCzDIN2zQz3L/GR3w914vAekiNx1h8lhYdwsb5ulJGN+hbPw
   hj/o4SfrJrLY2fwJ1k78aKEErGxKmhiTTuKYuMqFvk0oJtGF54lOaR7zP
   03kui6G1lK55CQDsNTGajs6bpTbUFtlNFZj0ZL+z/2p4qqcIDtY/UopAm
   TK3J1IZimx5ZFhgfJPFnSDCxoSDvbEnURWbpjPq2bDBbwYPxZtXVp1pWz
   VmKrF+BYDXT9G3jqGVx1NfZ7CUsQC9pX+PiTlcii4YE24+uKTgIt6QlVH
   R8B3VJNYkSGJx+d7dZcqjUh1NMW1UK5FRRQUJ+N3MACY6OwIx4VI6RuhK
   w==;
X-CSE-ConnectionGUID: TyRS0lYKTXeF/8liZoM2Xg==
X-CSE-MsgGUID: KZUkt6nFRoSK1gtySERKqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="76144519"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="76144519"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 07:50:08 -0700
X-CSE-ConnectionGUID: 5xc3wQyvTuS/qXMQvShaUA==
X-CSE-MsgGUID: DUVEpbOoSrOSapURv7i1QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="273003691"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by orviesa005.jf.intel.com with ESMTP; 31 Aug 2026 07:50:07 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v5 0/6] Rework dpll pin control
Date: Mon, 31 Aug 2026 14:49:59 +0000
Message-ID: <20260831145005.191040-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series reworks and clarifies DPLL control logic. Contains
refactoring changes for better readability as well as the changes making
the pin controls compliant to design requirements.
Bounds checking is added to avoid any potential out-of-bounds access

https://mail-archive.com/intel-wired-lan@osuosl.org/msg19535.html

v1->v2: Harden the error handling paths, additional bounds and
        pointer checks
v2->v3: Fully rework the rollback codepaths, rearrange changes
v3->v4: Fix transient state visibility during the state switch process
v4->v5: Minor formatting changes, additional NULL pointer check

Sergey Temerkhanov (6):
  ice: dpll: Add the MUX tables to the documentation
  ice: dpll: Rework multiplexed pin notifications
  ice: dpll: Use switch statements to handle pin states
  ice: dpll: Check for bounds when updating the pin states
  ice: dpll: Rework U.FL muxed pin (SMA) control
  ice: dpll: Rework the SMA control logic to match the requirements

 drivers/net/ethernet/intel/ice/ice_dpll.c | 544 ++++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_dpll.h |   1 +
 2 files changed, 456 insertions(+), 89 deletions(-)

-- 
2.53.0

