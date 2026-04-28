Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E0C3DB639;
	Tue, 28 Apr 2026 07:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360939; cv=none; b=khQxVtyx8rJ1ku0ZYh8ndTmSQn3ohMbusA3mu30EJdrwYtD4+iqmBzig4HsloJz/9e/NDbmsKLEjXAbInxJ9jz8q4nnXEfBjbexUCo06x0jSGDUAfbkRX66yyy45XZBldDD5kfXC0pU7cYfp70lUx6WfFG6h6AGWMDr4535hdeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360939; c=relaxed/simple;
	bh=HG5kRVIhba2r5dqXMdQ+wk7kg+sfW7FIvNTX7Er9szc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvkcQ1DFg7tAf+3mrlpS+wBYCvAqhelJF9QaP2mXTyufIollIGMhGanCvgkMpmpHudx/87KQU5JjP6Vk5d/EYjhyVGUndP2s2QAwl2loVhGuLib4XXNSJtIfMLBbxbdOTC/JS5p8nP7VG+Ch8EQm6hOMkH7KoVaPLKqirgGqTSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XEnh3GJk; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XEnh3GJk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777360938; x=1808896938;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HG5kRVIhba2r5dqXMdQ+wk7kg+sfW7FIvNTX7Er9szc=;
  b=XEnh3GJkSFghi3iyAnrh4RIGyyTXNr42WJ19BGHyNDUE0ITwb4Wp3ah+
   OL4i/YJ6kwZdkH761PcgDGqng9g0dis8ym/5IixyS16NgUN5HGgAi/FxZ
   z5XUZXb3KLIQutz6E1ikPxocTwLfSGh2zShdqTUZBskOFhPRZwQOHaTMg
   hEK3lQtJv9e0zZ2ca9H1bOtlHe74POOOhju8QQEtfCNwmsrWvynrFJqpn
   6UAiYffYwzhxnJn+YqSgXRgWxGJhfU1f+1SMBxTNEzV6o8t3aapK1cOvl
   LmodLuvTHEJLuEveqaQEELGOzXb9AR49H12pRmyBSX3uSCenOO9b76BAL
   Q==;
X-CSE-ConnectionGUID: 2WuxMbKZRz+oCg5+P6bvAw==
X-CSE-MsgGUID: uLwstAeuTqqv80pClirQ/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="89720833"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="89720833"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:22:16 -0700
X-CSE-ConnectionGUID: sTl5WtrIRoCRTiXXpDCJ3A==
X-CSE-MsgGUID: fljOSinGSEuioRSasCh6NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="238206455"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 28 Apr 2026 00:22:14 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 0FD60A1; Tue, 28 Apr 2026 09:22:10 +0200 (CEST)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-usb@vger.kernel.org
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 6/9] thunderbolt: Add helper to figure size of the ring
Date: Tue, 28 Apr 2026 09:22:06 +0200
Message-ID: <20260428072209.3084930-7-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260428072209.3084930-1-mika.westerberg@linux.intel.com>
References: <20260428072209.3084930-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add to common header a function that returns size of the ring. This can
be used in the drivers instead of rolling own version.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 include/linux/thunderbolt.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
index 1160e0bf5c5b..9df8a356396f 100644
--- a/include/linux/thunderbolt.h
+++ b/include/linux/thunderbolt.h
@@ -641,6 +641,11 @@ static inline size_t tb_ring_frame_size(const struct ring_frame *frame)
 	return TB_MAX_FRAME_SIZE;
 }
 
+static inline size_t tb_ring_size(const struct tb_ring *ring)
+{
+	return ring->size;
+}
+
 struct tb_ring *tb_ring_alloc_tx(struct tb_nhi *nhi, int hop, int size,
 				 unsigned int flags);
 struct tb_ring *tb_ring_alloc_rx(struct tb_nhi *nhi, int hop, int size,
-- 
2.50.1

