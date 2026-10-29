Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793300131;
	b=vhY6wD/8vnCR1F7txufj+L245I5jeMSX03HFDHp4ToPZCE6Uabfsd/jlfnMqLew6N9fK
	 hgPPvxFLemUpSR08SJkVPj8s28OyBAgsnEeVebyB0PKusP7LwC6/SaJ8bV7csTa/1yfD8
	 4Cf45+nW2mUDbUMhpZbOJT8qL1cK+WlgqJYnwwgqW5doW0mLa2MMm32hcIZLiaejIIhOY
	 hxX2B9In+RMXMJ0RPkYMTIlka/8ZmwTtjaEYdyAXTX09G18PJ0+GhYofBweXYYL5taaQy
	 +O8q+ZLi/4v3OnyxK7pfmLn02Wdxsa8t0BYeIipRNGXjhI2q8d9vcg5YEYGP0b88EkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300131;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=HHrvKgT/2K3LqufqQouf4HOOub42rH6TixN7nVjIiWI=;
	b=ruzNmw1OK9Khxa74LkjRKtCW0+nLDB62JVO44sTihaXhrTyolqZR+ile9FfTacJH9pUR
	 Pu5fX9maaLXssZUOPAtQrISwsntWIhzz07ZJCz/yXb3GQ5L0MVN3b/8vIjBtBrMYVd1lK
	 MzFwTKzh3/a0yvrl4c1Dno6CN3NkiT7f3Z3lxlXxAi2SMHxEiJNLIUkOrREkWd1me7S3H
	 Dr1snubLO0vTX18Tm2gyFM61sOScseoEExLqVAuWadefEFop3Y4HvZY3f2ffPzH90ePjJ
	 jOmshmUJCC/+1pS34ykd5LVJ1NDLjcAIUUmx/idgp1NgkZiwQlbMKFw3Fy6xYiPKqRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l33wAZyU;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76FD606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 18:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C76FD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l33wAZyU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793300130; x=1824836130;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=9IFeJyzzRTdjZZaoVDPerD+tFpr/WPI7Q6Nnx12Saw4=;
  b=l33wAZyUhvfzUrcuSfWCHIQgZGnFPlN8hzC3X+/SkHqHfcPoXbPezWz3
   gvVRSyO2FvujaeGfS7JpLzY6iw5RJz6+swo0QN5vVZPOSvZuecp5oll3p
   ESQoJ6mzRRg/XWvhP2+pOVcct1rk8Z8eUUmbLj7koMfMpuAWHcObw3sRo
   2qqvd0jEHviREWFJcUwXnVOTskW8rsIPw+dM/H/itL2XvXV6BgcTdEkzo
   eIcQ0EZvpwraWyJJPxgNpU32iWan+0r9Ymr7l/ZA/EBh/J5mMwd7fM7SV
   ViPin7zZfaP1y0pC5VN5JY+lCNjp+Zsq9irJmKQQe0Sn9vQUQJYiB974J
   A==;
X-CSE-ConnectionGUID: LXHSsznyST2FnAl9FvPR5A==
X-CSE-MsgGUID: zubiSocDSTCOSrTu8+Dj5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2147527"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2147527"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 11:55:29 -0700
X-CSE-ConnectionGUID: 86H6f3mDR76aD4+yq0Ymqg==
X-CSE-MsgGUID: busP35UQSju3l+yhAQDsmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5348465"
Received: from orcnseosdtjek.amr.corp.intel.com ([10.166.28.128])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 11:55:28 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net 0/3] ice: E825: PHY restart fixes
Date: Thu, 29 Oct 2026 11:55:00 -0700
Message-Id: <20261029-jk-e825c-critical-timestamping-fixes-v1-0-72128d1dd928@intel.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWN0Q6CMBAEf4Xcs5fQEkj1V4wPtSx4KJX0ijEh/
 LtVH2c2md1IkQRKp2qjhJeoPGMBc6go3HwcwdIXJlvbztT2yNOd4WwbOCTJEvyDs8zQ7OdF4si
 DvKHsYAbXNU3bw1BJLQm/oZTOFJHp8pe6XieE/D2gff8Ad36HSI0AAAA=
X-Change-ID: 20261029-jk-e825c-critical-timestamping-fixes-8e1f86335de1
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Alexander Nowlin <alexander.nowlin@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, jacob.e.keller@intel.com, 
 maciej.machnikowski@intel.com, przemyslaw.korba@intel.com, 
 sergey.temerkhanov@intel.com, arkadiusz.kubalewski@intel.com, 
 richardcochran@gmail.com, horms@kernel.org
X-Mailer: b4 0.17-dev-67df5
X-Developer-Signature: v=1; a=openpgp-sha256; l=4262;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=9IFeJyzzRTdjZZaoVDPerD+tFpr/WPI7Q6Nnx12Saw4=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqzH02ZMbpbz7PPWfhlx7ecE8z8KC7ZZP7E3iT48PdhQf
 RbTZM3ejhIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACbiPYvhm2K4reT0QPl5ZWGL
 ers2zHGTTNnU/LPo9o6j52VnpxmXMPz3nVC/ju3WatN2kU+7u68qswfdqjHxKbxhur3c/9iyBnE
 eAA==
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

This is a subset of the timestamp processing logic fixes that were
previously posted at [1] and [2]. It focuses specifically on the E825 timer
restart procedure, including three fixes which we have deemed the most
critical for reaching customer deployments due to recently reported issues.

First, the driver is modified to stop clearing the PHY_REG_TX_OFFSET_READY
register. This register controls whether a captured timestamp will have its
"valid" bit set. A timestamp captured while this register still increments
the internal counter. However, since the valid bit is clear, reads of this
timestamp will not trigger the internal counter decrement, leading to an
off-by-one error in the hardware logic. Instead of clearing the offset
ready register, disable timestamp requests purely in software and mark
outstanding timestamps as stale to prevent reporting timestamps that should
be considered valid.

Next, the E825 soft reset procedure is extended to sweep the timestamp
memory region with reads before the soft reset is performed. Reading a
timestamp triggers hardware side effects including automatically clearing
the "valid" bit of the timestamp in the memory, and clearing the "ready"
bit from the timestamp bitmap. The hardware soft reset register does reset
the ready bitmap, but does not automatically clear the "valid" bits from
the timestamps in the memory bank. Additionally, the hardware does not
initialize the memory bank to zero at power on. The sweep ensures that
the memory region will have all the valid bits cleared and the device will
be in a consistent state after the soft reset. The sweep is performed as
part of the soft reset because the reads could otherwise leave the internal
counter in an off-by-one state. By always pairing the sweep with a soft
reset, the memory region is cleared and the soft reset resets the ready
bitmap and internal counter to a known good state.

Finally, the E825 timer restart procedure is extended to include performing
a PHY soft reset. By performing a soft reset, the driver can be sure that
the device is in a known good state at every link up. This also provides a
mechanism to recover if any faulty logic still causes the internal
timestamp counter to become out of sync. The system administrator can reset
the link, triggering a PHY timer restart.

These fixes originally came along with other changes to the driver
timestamping logic flow, but have been separated as they are deemed the
most critical for upcoming E825 deployments. The remaining changes from the
original series continue to suffer from AI feedback pointing out potential
race conditions. The link changes especially may need some deeper
investigation to resolve. I appreciate the maintainers patience with this
work including the multiple rounds on the original series and helping find
a path forward.

Link: [1] https://lore.kernel.org/netdev/710677e5-3668-4588-bd36-2d8f7fb692a9@intel.com/
Link: [2] https://lore.kernel.org/netdev/20261027-reduction-v1-0-81237c67a361@intel.com/

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes:
- The missing mutex_unlock() in the -ENODEV case has been fixed.
- A small typo in the kdoc has been fixed.

I've double checked this round through my own local sashiko instance 3
times and didn't get any remaining reports after a few runs. I only have
claude models, but hopefully there won't be any remaining complaints... :D

---
Jacob Keller (3):
      ice: E825: stop clearing PHY_REG_TX_OFFSET_READY
      ice: E825: clear PHY_TSTAMP memory prior to soft reset
      ice: E825: perform a soft reset when starting the PHY timer

 drivers/net/ethernet/intel/ice/ice_ptp.h    |   5 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |   2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c    |  43 ++++++--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 155 ++++++++++++++++------------
 4 files changed, 126 insertions(+), 79 deletions(-)
---
base-commit: 8f44631ba02afe9fff2f0a0fb66560ab19df87fd
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git main
change-id: 20261029-jk-e825c-critical-timestamping-fixes-8e1f86335de1

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>

