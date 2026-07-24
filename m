Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BB9419FD8
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784895235; cv=none; b=Fo+dXvFX2eKkaNpqLxHXi5keJ6onl39zg/9QCF6cErvKCTKEp+ccwt5PNm7AR0uaeyNTuSzwKJz+awJKATE+ucyRGYkknindNF1K2TL2a5dg5HfsmwYaEAFNp3m5dL9WbRt+46lYYZmUOhtdbBXdmaQwLzhdqSc49VocfKYy2q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784895235; c=relaxed/simple;
	bh=1EhgpuYzmdDfWT+P5HVUN3eIwVgkLFfWxhb2wx0O2YA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ut6uvPU4wxENtDdpcs5YRCMcBrXscsSKuv1h4LUojzPjmR0oq5ZbxgSccRSct0ZPdE16pYSg0xRFbNwKyFa3tCHrowmMhOaZQmwdzdGqyBlZEa6lnPaIB9mlMEBtbewDrFR4r+HFdXm+EstRgFMpxYowFJ+97aDPEbINwnryGyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ixKTYNI2; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ixKTYNI2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784895233; x=1816431233;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1EhgpuYzmdDfWT+P5HVUN3eIwVgkLFfWxhb2wx0O2YA=;
  b=ixKTYNI2fpfNpb/AN0YQwSEM2eS+QX2sh9aDrE7cFzVnJHANOwEKxoox
   eM6bWKpoTmIwpuZZTLJmjOsAmb7IyBs+o7fXiG4379TGv2AvPI8UQgOPM
   rnlMDOxMDdO0MA0uT7RPEUY/aA09CViwL+0AJH8/E2OHGAWdhhmj9IO0X
   OFD4ZYSzIZQjAtMU3TrSzBl3BhewR540KZOs0vYYFxs5CmTUJDE0y0dM4
   nukt8MGvZ5coLPiA1oFVXq/w+Fis2KJcqPnQ9vqHmgUYhDbVy7aOV3evW
   N6v63NrhJC0ewZ/bjvavHDiDs0BjiMl01SHmh5IWOq/FcZyvJX9Pjb6Jj
   Q==;
X-CSE-ConnectionGUID: Sat1wBmDTgeE9x5Mqv9vSg==
X-CSE-MsgGUID: i+nKYxuTSdGBkkgijTLu4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="84686069"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="84686069"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 05:13:52 -0700
X-CSE-ConnectionGUID: DgfMutTjTR2vWz7p1WTTgQ==
X-CSE-MsgGUID: D14Hl43PTZGGzfkLTaSLug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="252367699"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by fmviesa009.fm.intel.com with ESMTP; 24 Jul 2026 05:13:51 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v2 0/4] Rework and fix ice dpll pin control
Date: Fri, 24 Jul 2026 12:13:46 +0000
Message-ID: <20260724121350.1565330-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series reworks and clarifies ice DPLL control logic.
Contains refactoring changes for better readability and
maintainability as well as the changes making the pin
controls compliant to design requirements.

v1->v2: Harden the error handling paths, additional bounds and
        pointer checks

Sergey Temerkhanov (4):
  ice: dpll: Rework multiplexed pin notifications
  ice: dpll: Use switch statements to handle pin states
  ice: dpll: Rework U.FL muxed pin (SMA) control
  ice: dpll: Rework the SMA control logic to match the requirements

 drivers/net/ethernet/intel/ice/ice_dpll.c | 347 ++++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_dpll.h |   1 +
 2 files changed, 290 insertions(+), 58 deletions(-)

-- 
2.53.0

