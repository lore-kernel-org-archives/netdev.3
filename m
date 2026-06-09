Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6826541166B
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 21:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040978; cv=none; b=UwUA0Zfk8zbDfz8D3H9N4ptYo93VC8tLx6SuN2AxQmfYmOCg4MPTW/ZcEPLlK9+fRqicPw59Sop1GNna2HE0PbZBsHsIvUvPcS2+qqEJRNFI5vG6BV81vcle7P8VQmO1ufC/0JYZO3LCAxr270vk2vmZZRS5/9yqnKVtsB585Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040978; c=relaxed/simple;
	bh=NP6Xr2q4rX9oeicejTYQiqSXD1XP0yd/iBbKE9d96x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=byMIwGySu52I/Z8vViAds6rSv/fycrOzWO77VL5U9sZ/wgIyVnIG/jPnq174eoNocMsKvpXBkXhC52JnVZUarll6U/szZR8O9fNDvjJLQInF+O3OP+fo2VTSmQRNDTxugZxH4Gz32hcMHICWuY8rpTEPeHYr7nTUgMeebulmXt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VwDdSABi; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VwDdSABi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781040976; x=1812576976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NP6Xr2q4rX9oeicejTYQiqSXD1XP0yd/iBbKE9d96x0=;
  b=VwDdSABit51myq3wj27EjFe+rShcu1vzfz+IEWXkQ5Wue38mBcmKX5l5
   wggMAc5X2JMaEGMBt4w+/DDoSHwNJWT1RZyNfZXp19E8pDtg5q/4XMsQm
   mYnN/k4RQWBHLq3JP1DuwfdzR0V4KNyVSTVj1b0jnw+sM0hFD2aIWlWyF
   KyebYgIZ5CAZIx18hj6s9sD91n5KWNphsSHnzKm81ej1b4zV1GRFZKY/E
   ZTt8if5oNt99kobui/ZzwzOfJ2qkIINcdi4N8TIZs7Hytd6xrgk1Z56IA
   0uyVIsBb0Cx1WhHlP74iznT0g2/RMJSA//DdqxY1q51Jci4vUTCYwmbd0
   g==;
X-CSE-ConnectionGUID: f2qJdlxvRqGKd5I/U/DUog==
X-CSE-MsgGUID: oSeDYvVzQfu2lijZsFGD6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81568569"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81568569"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 14:36:09 -0700
X-CSE-ConnectionGUID: HyUIamRkTOCqqyCEqDmvOw==
X-CSE-MsgGUID: R0Ykh0K9TGKpYJaW5xGx1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245838591"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 09 Jun 2026 14:36:08 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	dima.ruinskiy@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: [PATCH net-next 08/15] e1000e: use ktime_get_real_ns() in e1000e_systim_reset()
Date: Tue,  9 Jun 2026 14:35:49 -0700
Message-ID: <20260609213559.178657-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260609213559.178657-1-anthony.l.nguyen@intel.com>
References: <20260609213559.178657-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Replace ktime_to_ns(ktime_get_real()) with the direct equivalent
ktime_get_real_ns() in e1000e_systim_reset().  Using the combined helper
avoids the unnecessary intermediate ktime_t variable and makes the
intent clearer.

Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 5b7ba1594f0d..3bdeb5f0dbea 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3943,7 +3943,7 @@ static void e1000e_systim_reset(struct e1000_adapter *adapter)
 	/* reset the systim ns time counter */
 	spin_lock_irqsave(&adapter->systim_lock, flags);
 	timecounter_init(&adapter->tc, &adapter->cc,
-			 ktime_to_ns(ktime_get_real()));
+			 ktime_get_real_ns());
 	spin_unlock_irqrestore(&adapter->systim_lock, flags);
 
 	/* restore the previous hwtstamp configuration settings */
-- 
2.47.1

