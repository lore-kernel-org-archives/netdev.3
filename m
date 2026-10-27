Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103300;
	b=MKRFkXhLZoU01WGBnlBGf94EjVTNnNHRdWM+ztAvdNHSwp792yf3t/3Fzb409dZaMiH3
	 K3hvrmVS4Yplr0S2o1boU7xBsi6cgen8lNvbj83xaUvxTtJ0jCRLlqtlI8zuF14XO2owA
	 FN202OqX6HMZ5QSHI/6R0NH/kzw3Pgglz4UzyGlJ9XB6fXErwjff3OhX2vGubvstRTuf0
	 fabZESqbd9SQtflwuRwTk0WmbR7rgYk3NKNc+o5BmPYTN4RLP6EFp7RWzs5mUvsjCNTsO
	 Uh44hF4n7A8hJshcwVOZhssCDFN/4NxQxL+Cl0FlaNpWV8CtF/PkW0a8UDHG3g0cU0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103300;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=wsO1juH+qPygKRAFBHgPVkSB8xyUy8Z/UqIehySmMw0=;
	b=M8tFSPC0ooudPoN0wSGleRPkc1qClUZyscYicucuXMk8ZoWuPCeG8ZL7dj64+N9lP8ay
	 nMl4AEUtG4lLgPEyAo2Pgs0xeYNquVLAyqIhbMF0sGyodTYUpLP448ECWp7USBGze8jk7
	 8Yj8LgN76jgZTCiXQFLUENFLFulzooKpfm27Q7Hue1MKBG6dluBauT6Wlfz087CE2I3rm
	 mQaYunniWqsbSRCb42qW8bMso7tceLieizWYAocuIA43cc3Zllgwh8tENnERM8MzAZAmI
	 bADZyYj4X4FtnjPNUcvUkI2xmsAHcYgJEX9E7SQca/AtS5fsyOGYWmgPJnV7IosNyHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Td8ncVxA;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E423A60A2622
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 12:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E423A60A2622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Td8ncVxA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793103298; x=1824639298;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xgVhCO7AITK5Da2R66zir1pxG+0NCGYhJxcbZJcq+8s=;
  b=Td8ncVxAMhMkEHVubYwM0TwP4mARjw9KRMOsThMTHOcTbtJ8jwi7qplV
   f3fTexIvp/TXIXZvfXP/wRdhlTrv8rtPMZMd+TWAWERZhM8EMS5y9mDji
   Tz4nx7VfQSEue1GZtzhTabpdmesk+xeabY+ZC/FgWPppLxQgjaA25bTsm
   2qSTNK/MVW/UsSpNBE90hJKvDKSr6abzKjAqhbKSFt6pJ9fClwmNRtibu
   qiXs5xyD8kYYXm3DxxKs6gsgS5MnXT7fVcJ7J1hgr3ulrjro1tG+OOD9A
   rJ2XtsyywVYgWPEeXQ+y0DzdX6wtXcTtbrQWsLvIPx08L1FH5QZczjb9o
   g==;
X-CSE-ConnectionGUID: Hlxl+3sxRF237h4N1RAMCg==
X-CSE-MsgGUID: QZ7qA9lISN6OjzhlVT+cFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1709345"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1709345"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:14:56 -0700
X-CSE-ConnectionGUID: FyuuJV9CRuqLtWENRAVZ0Q==
X-CSE-MsgGUID: 9M7TgGGaSgyYHYOLaFEAQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4529793"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa002.jf.intel.com with ESMTP; 27 Oct 2026 05:14:54 -0700
From: Magnus Karlsson <magnus.karlsson@intel.com>
To: magnus.karlsson@gmail.com,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	maciej.fijalkowski@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Magnus Karlsson <magnus.karlsson@intel.com>
Subject: [PATCH iwl-net 0/2] ice: iavf: fix USO for 32-bit systems
Date: Tue, 27 Oct 2026 13:14:40 +0100
Message-Id: <20261027121442.907414-1-magnus.karlsson@intel.com>
X-Mailer: git-send-email 2.38.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

That USO works for these two cards on 64-bit systems is just pure
luck. Currently, the computation of the UDP segmentation header is
performed using sizeof() a pointer instead of the sizeof() the UDP
header that the pointer points to. Since the UDP header happens to be
8 bytes long and a pointer is 8 bytes long on a 64-bit system, this
works on all those systems. But no such luck for anyone using a 32-bit
system as 8 bytes != 4 bytes. So fix this by using sizeof() the UDP
header that the pointer points to instead.

This was found by an LLM while implementing something else that used USO.

Magnus Karlsson (2):
  ice: fix USO for 32-bit systems
  iavf: fix USO for 32-bit systems

 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.38.1

