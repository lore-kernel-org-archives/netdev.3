Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794611557;
	b=Lz3CofUmjGQOoNCWR+vBZ9wJSbDpD37SX8ugzQ4d8wKhesM+Sh7Iy2HYi2Lx9/pmu0UU
	 O7gtnjsB/T3MgT1OqzVgedCKEBBSIG6qa4sQV4rwHmAdxJsdaaDlthPtkT8JWobwSfwj7
	 oCZFB3vGCHHzOElvOTmK9Z3BAJ3ZY8CC+s9k3+qFLsNzsPtSVYe77zHvUV+odssglcpH1
	 1b/Q8GaAx2PE4yvWfjcmJZDckDhe5c7rzx1I4ByKff/iZvwQP+2Klfrco0bfHlhAyMqOo
	 fob+Fn1qO8VbKDPUrvVJvLJ0dAarWV7s+6nHpfgYqxepTa8QvybxXqOWvMiP0VHJ9aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794611557;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fde6G+0hc3EmjR8NYYhH8Ykwt5HeI96uYsN59Tmjr9A=;
	b=0Y6XysUfoF7BEu/eYkaUlAiE8KE3BpPu5jND2paWy0oFZO0SYvZMDRoryMoo3fufEQxC
	 YKydpwZAj7qu8CTJGRUzaSCZ6Syt7xKG0nbZxF1dj9LKMJhPcBeEfxgjNGto7GNRtCGpH
	 ukwD5Wi8NzYHv0nFXTSfuylInXTnUDhPI7W7YU9ACHuYsIyCcWJ+PzYOCu5SvotduuOZc
	 CmBWZU+2beRzckHK8vuni8oaNZtNx1B1Ps3Ajc7zwJSqtZCOW0mXvIIOGd2FWfNiF/eXB
	 RVo4HNoWdnWD/E10v1dBhLRvg4KnWTlRCml9FPG1P/alScD5JLoo8L+6UbGKfnY7ibw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WJ6Nsqtg;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963FD606A88F
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 23:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 963FD606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WJ6Nsqtg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794611557; x=1826147557;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V41Aq34BNg6eX5vRfpU6AgIlLQ1oFx2tS7Eosj4LMBA=;
  b=WJ6Nsqtgivuy4uilUjs2Q5+AJrx1cumJsXLUgarjCRAV3BQdQEhPxPRh
   hbvpv2vpV7co+JggH0Db5vplJDpIL88IWfYxuH6lnyfHCTCt/TQiPJ53T
   fipLkca0DNengUM6OYs+Ksou9EZEvo/6aSvvdxWeQi6R1keZIq/FLrutd
   Lzm8mGjQqbAixxYIhNSIiyNBqvrYV41TX41BzYqjEhAeQcIW6G+en/Cqy
   pyzpOazuX/8oFpOphhG1XZm5OGcrV2OkezmfWSybTjb/GadHPUdu/9vJe
   upl9SFg7mmzq4rzxvQcZ1b3Be5nU9VQMzN9iQOVzkvkbVSmKuPX7XSm1M
   g==;
X-CSE-ConnectionGUID: 5gt6uhiJSyW+SBMRA8XukQ==
X-CSE-MsgGUID: Yb6ZkexXS5qcKRm01oqkpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3443172"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3443172"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 15:12:36 -0800
X-CSE-ConnectionGUID: pnvQ5KsUQHyc+oLuQ33Dlw==
X-CSE-MsgGUID: Sh8ZrbZpQCW34wUqK0T0AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9360995"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 13 Nov 2026 15:12:35 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	david.m.ertman@intel.com,
	pengpeng@iscas.ac.cn,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	robert.malz@canonical.com,
	rkannoth@marvell.com,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net 6/6] ice: allow reading the last byte of the NVM and Shadow RAM regions
Date: Fri, 13 Nov 2026 15:12:23 -0800
Message-ID: <20261113231225.1864810-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261113231225.1864810-1-anthony.l.nguyen@intel.com>
References: <20261113231225.1864810-1-anthony.l.nguyen@intel.com>
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

From: Petr Oros <poros@redhat.com>

ice_devlink_nvm_read() rejects a read whose end lands exactly on the
region size, so feeding back the size devlink itself reports fails:

  devlink region show pci/0000:04:00.0/nvm-flash
  pci/0000:04:00.0/nvm-flash: size 10485760 snapshot [] max 1

  devlink region read pci/0000:04:00.0/nvm-flash address 0 length 10485760
  Error: ice: Cannot read beyond the region size.

shadow-ram behaves the same. The regions are created with those sizes, so
a read ending on the size is the whole region and has to be allowed.
ice_read_flat_nvm() uses > for its own Shadow RAM check, and so does
ixgbe, which grew its region support from this code.

Fixes: 3af4b40b0f2f ("ice: implement direct read for NVM and Shadow RAM regions")
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Acked-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/devlink/devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index a87a3e0a900c..9eafe7d57732 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -1953,7 +1953,7 @@ static int ice_devlink_nvm_read(struct devlink *devlink,
 		return -EOPNOTSUPP;
 	}
 
-	if (offset + size >= nvm_size) {
+	if (offset + size > nvm_size) {
 		NL_SET_ERR_MSG_MOD(extack, "Cannot read beyond the region size");
 		return -ERANGE;
 	}
-- 
2.47.1

