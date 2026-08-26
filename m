Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEA93BCD28
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787737738; cv=none; b=AKOMtl+PtIjVpmWzMCIb+DkCKDPXPMWAQTQg4x+Z9iGv+wmdjMhyp8PVYup15hKaNy9GE9+uuflmb0L1u+sgjEbZ7Bzo8ckJbp9nvepenFfNI0k9a4Xx/zkbLqWW6nJqKHP80acQ3bD0aZX2+tpscy7e4V7C2KzaPLs8KZJrOIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787737738; c=relaxed/simple;
	bh=qY7WCG2lM8/FG+VYanFZuap8dJ1+0ITIBbtnyEuH5ds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QWXS10bcJOB1T4eAJ9YyIz/nNtbAiQ8DJbfPdVGwxBE70pqeBz7w4Aa/lsLN9b68Gbo+BhQb7b3johRX7pzss3FuNtS0Kl9SyG1yyxiw6djBUumqISN1z/t2iqW9c+jIoBA4R0jXqvqBEgaVkTLRWItDwm8tW/PxtSusT7ok/m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cYQvYQFK; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cYQvYQFK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787737735; x=1819273735;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qY7WCG2lM8/FG+VYanFZuap8dJ1+0ITIBbtnyEuH5ds=;
  b=cYQvYQFK+p4J0E0MbyF7uxVVsIDxesGszbzAEsxZTehS8wiUaTVrR49c
   7aJqcXe2TzTd6NUJ8h6UlfY4D+b+U1wqezRVsktI383EnLA7YY8G6rBoG
   xjQZQo5xI8ZOGI67jAL/NqdYnzIMa3EK2UAMts4YHepb1hQ8JEzWyK0AF
   +6IlBYew25f12dqDGAc9qEYhuJdXJ5196T1AHT8I9s77j5Y98TD1WY3bS
   Bu7k5/RBqG0JPqA0/r/MaH1HIq5maQ9iboh/7H8dXaKaEDUMcLR9Q6OzD
   iYKgiZFU83Ms7s6DV3c1VbsYPYS1CnjoZ1WG7c4RXlVFaIOj76XhRTEsl
   Q==;
X-CSE-ConnectionGUID: QTO2F/hxT82WgE/UovSTDQ==
X-CSE-MsgGUID: i/+YkNexQ++7g+WDK2wgdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88232945"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="88232945"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 02:48:51 -0700
X-CSE-ConnectionGUID: AorEXLkCRNO8uJ6fipy6Dw==
X-CSE-MsgGUID: sEGI6fqDStGZvKc+fLx2Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="261404792"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by fmviesa009.fm.intel.com with ESMTP; 26 Aug 2026 02:48:50 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v4 0/6] Rework dpll pin control
Date: Wed, 26 Aug 2026 09:48:43 +0000
Message-ID: <20260826094849.4112016-1-sergey.temerkhanov@intel.com>
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

https://www.mail-archive.com/intel-wired-lan@osuosl.org/msg19449.html

v1->v2: Harden the error handling paths, additional bounds and
        pointer checks
v2->v3: Fully rework the rollback codepaths, rearrange changes
v3->v4: Fix transient state visibility during the state switch process

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

