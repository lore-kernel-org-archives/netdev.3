Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794532113;
	b=Njth+ObPuXXHjGwSOKIDMt2KrAc5H05WXVz5ujGKNa9K6jxOcJFdUS8u7sLpYn11V2au
	 4y+NPJie8Ea1teWI5zJxgujAy1RXF0uTB9fxfSnbI05OGTnJgaTsOqSQbdXIsuLOBAPHS
	 vZQmjJqYg2DVL2Asssf513C6oZdBM9KnVQ7m9XIxHgTHv7fOnr3Mt2tKStoEKzfzmYwN1
	 v07DgB/6dsz+wczBbH9JE9HVqQPmYr17Kb4bv6pijIcVteMnxKx19gVxra1tGuS41UIcf
	 uj/ASipjYZ4vO2aDchR80GLcWrcLGYzFn82D/ordYNdaTh5O+SUPPPmll1EbqIPlU+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794532113;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VfkhSy3UWNK1wUNwtpizITXqTOUwLRletHc/mH1J4Gc=;
	b=OxAccF2J+A3dNgLatED0BY0yJ11vJ156L9PvJq12YGkABOBAKKD2ExJDQ/bLkHrxpUV1
	 0m3tqgWrI97nSoOmnsby1nw/5BOp1q17FZYfq84rnqcilCCRDethdG1H06ww/EuQ3Q6zb
	 whwI2s99LfbHAy15aFVRxS8XLav5CDxgcNFGzq8Rm6wgv4lghoOz1ww9BquJaHbhYwwG6
	 wiZdMhmbBuoAb9ygiHzWToIuUMnvN8UqaJmDzZsKgsA3zd5HX/hzGHbl9fBV2GVQWKUVP
	 cDAxklqLcgL2Ehctrn5NS1+VZVGQ3G2pCW+ojsRwGBpdno25ti9/x59uEJ/aq8nLaJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="SSq/6NJf";
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E84F606A32A
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 01:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E84F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SSq/6NJf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794532112; x=1826068112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xMMo5kDl2lDu5t/K9k/e6Fuhw9JIcGyKKkyF/qkXgKQ=;
  b=SSq/6NJfJyRe+Y7CO0lh9HWBb5NegDe4UKzmMS+X5ES1fAD52AdtD/5a
   S4sBPJUXuCBn2NqbRAgh48dJrD9Gb1821Ejjb5dv18Wx4QmmoBweNks2w
   jczLUgTICimu4wgghyDV2eREOlHjqFMTra3tEfKPSHO+O8vvaS93FqsCP
   I2yWTiWm/NRjBssqMH9ErPwfIfHpL2MKJ1b4iNMDhe7359kZ7lPLoVnuL
   Zha/kz0byJOoPD0Axl5iPXOXJ4+Qtj9SATcUN2Tlc7CKV3xWC91UTiLsD
   9T7Ync8CfrVS3xY4390sZUk3+CmqAMu6mUgX6IqYP5rxWplwGvfSxOdV0
   Q==;
X-CSE-ConnectionGUID: rCOxSoVLRHKEkq2XUg4OTw==
X-CSE-MsgGUID: XeXLi9j6SPeGahb6jzflFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3252590"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3252590"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 17:08:31 -0800
X-CSE-ConnectionGUID: GCkd5ik4TC+Dd+FoQKtetw==
X-CSE-MsgGUID: u8cu8H2fQPWcNP0B4sR3aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="9214831"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 12 Nov 2026 16:58:29 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Ivy Lopez <skunkolee@gmail.com>,
	anthony.l.nguyen@intel.com,
	dima.ruinskiy@intel.com,
	luoxuanqiang@kylinos.cn,
	nsvatoslav515@gmail.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Moriya Kadosh <moriyax.kadosh@intel.com>
Subject: [PATCH net 1/3] e1000e: fix incorrect modified flag check in e1000_read_nvm_spt()
Date: Thu, 12 Nov 2026 16:58:18 -0800
Message-ID: <20261113005823.130021-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261113005823.130021-1-anthony.l.nguyen@intel.com>
References: <20261113005823.130021-1-anthony.l.nguyen@intel.com>
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

From: Ivy Lopez <skunkolee@gmail.com>

e1000_read_nvm_spt() reads two adjacent 16-bit NVM words as one
32-bit dword for efficiency. When deciding whether to use the
shadow RAM value for the high word (data[i + 1]), it incorrectly
checks the "modified" flag of the low word (shadow_ram[offset + i])
instead of the high word's own flag (shadow_ram[offset + i + 1]).

This can cause silent NVM shadow RAM corruption:
 - if only the high word is marked modified, its pending write is
   lost and the stale flash value is returned instead
 - if only the low word is marked modified, the high word is
   incorrectly overwritten with the low word's shadow value

This function is used on all PCH chips from SPT onward (SPT, CNP,
TGP, ADP, MTP, etc). The bug has been present since the dword-read
optimization was introduced for these chips.

Note: this was found via code review while investigating a separate
reproducible packet loss issue on I219-LM (SPT+ PCH). Testing showed
this fix does not resolve that particular symptom, but the flag
check is still a genuine logic bug that can corrupt shadow RAM
contents and should be fixed regardless.

Fixes: 79849ebc0e06 ("e1000e: initial support for i219")
Signed-off-by: Ivy Lopez <skunkolee@gmail.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Tested-by: Moriya Kadosh <moriyax.kadosh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index aa90e0ce8aca..87cd1cdc6f10 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -3473,7 +3473,7 @@ static s32 e1000_read_nvm_spt(struct e1000_hw *hw, u16 offset, u16 words,
 				    dev_spec->shadow_ram[offset + i].value;
 			else
 				data[i] = (u16)(dword & 0xFFFF);
-			if (dev_spec->shadow_ram[offset + i].modified)
+			if (dev_spec->shadow_ram[offset + i + 1].modified)
 				data[i + 1] =
 				    dev_spec->shadow_ram[offset + i + 1].value;
 			else
-- 
2.47.1

