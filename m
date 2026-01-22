Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AB52D060D
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 16:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099038; cv=none; b=ejwLKuugtVr48hPvzdFgZxsevgcC5+IcMFfuRuwM24SHT5TtEsz5pcgobfio5tVkIbLovo/cq+EnVVzIWrlpx7LjBcIKgDBujmzV5btowlITbDSHRN93w9T2sHRn5ssT/xCaUhBsgumdMnLSZpL/e+eeaj+AIeyYR4MCIttWKkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099038; c=relaxed/simple;
	bh=7rwY97g4ofATDXBFjwomDZ6MCIT+W7MiZ9pKqkzwOeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=peuig3Jvx3RqKBTnxJZPqnCA+iSNvBpetni1DxBTX+oH7un+74EKV+TPTP030fWMArfcyXkKHCO+Kg3WElIntvFWlV+FM4iItFLh5vl2AY9CYI4AtDi6/KcZs37IAQgqbk3gDlIXySoZYZ1m6Q6RYdZQUVtxsSc8fQyQOxPf19Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jPhd4isu; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jPhd4isu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769099030; x=1800635030;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7rwY97g4ofATDXBFjwomDZ6MCIT+W7MiZ9pKqkzwOeM=;
  b=jPhd4isu/hDKcBORZP3P8uQ4Iw20/8cca14Q2Ad/K5NgYTLu0olKN3il
   lLDRZwJ9gVU9JqyyIsjHLLGpJWWpqbnzmcp/L0wKWN4gYLPY9tWeVdQWv
   0t9GgaH+RF2egebegC4CvZP3cDWNIVxmODbA1FRNRulGK1FxZnsaK+64m
   GkTaArE9gHbR+abkA2w4cfMjs9NQmfjUWHQGObkEsmrCdUQD6XVyugont
   Y1Gj2DBNEtXWzuSugN4X5lqobf+T2PqAvPEiPYp/yDURUyrSg+kzYagsq
   mUm4mAQYZ1D/SDk9szM2cFsGqohinvwO5tJeV+qCrmNaecE09+Lo+alRo
   g==;
X-CSE-ConnectionGUID: Ovpw8LtkRQCrcgOHXFIaCw==
X-CSE-MsgGUID: 0fMKVjjeSZqEAZ0H5X0XJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="74198954"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="74198954"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 08:23:45 -0800
X-CSE-ConnectionGUID: wlr0GsckTR6DU80y2gsnmg==
X-CSE-MsgGUID: PvVe2uwWToeIfH788ICvuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="211625961"
Received: from amlin-018-252.igk.intel.com ([10.102.18.252])
  by fmviesa004.fm.intel.com with ESMTP; 22 Jan 2026 08:23:44 -0800
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next v2 0/2] ixgbe: e610: add ACI dynamic debug
Date: Thu, 22 Jan 2026 17:44:38 +0100
Message-ID: <20260122164438.112469-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable dynamic debug (dyndbg) of Admin Command Interface (ACI) for e610
adapter. Utilizes the standard dynamic debug interface. For example to
enable dyndbg at driver load:

insmod ixgbe.ko dyndbg='+p'

ACI debug output for e610 adapter is immediately printed into a kernel
log (dmesg). Example output:

ixgbe 0000:01:00.0 eth0: CQ CMD: opcode 0x0701, flags 0x3003, datalen 0x0060, retval 0x0000
ixgbe 0000:01:00.0 eth0:       cookie (h,l) 0x00000000 0x00000000
ixgbe 0000:01:00.0 eth0:       param (0,1)  0x8194E044 0x00600000
ixgbe 0000:01:00.0 eth0:       addr (h,l)   0x00000000 0x00000000
ixgbe 0000:01:00.0 eth0: Buffer:
ixgbe 0000:01:00.0 eth0: 00000000: 01 00 17 00 00 00 00 00 00 00 00 00 00 00 00 00
ixgbe 0000:01:00.0 eth0: 00000010: 1d 00 00 00 0b d5 1e 15 5e 4b 90 63 aa 0b 21 31
ixgbe 0000:01:00.0 eth0: 00000020: 69 eb cd ab dc f8 8a fd f4 53 e2 dc 54 e0 81 fa
ixgbe 0000:01:00.0 eth0: 00000030: 12 dc 41 82 01 00 00 00 24 20 08 26 53 08 00 00
ixgbe 0000:01:00.0 eth0: 00000040: 08 00 14 00 00 00 00 00 00 00 00 00 00 00 00 00
ixgbe 0000:01:00.0 eth0: 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ixgbe 0000:01:00.0 eth0: CQ CMD: opcode 0x0009, flags 0x2003, datalen 0x0000, retval 0x0000
ixgbe 0000:01:00.0 eth0:       cookie (h,l) 0x00000000 0x00000000
ixgbe 0000:01:00.0 eth0:       param (0,1)  0x00000001 0x00000000
ixgbe 0000:01:00.0 eth0:       addr (h,l)   0x00000000 0x00000000

Piotr Kwapulinski (2):
  ixgbe: e610: Convert ACI descriptor buffer to little endian
  ixgbe: e610: add ACI dynamic debug

 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 119 ++++++++++++++++--
 1 file changed, 109 insertions(+), 10 deletions(-)

-- 
v1 -> v2
  Commit message updated

2.47.1

