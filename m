Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793145963;
	b=aZDXkU3A2UINvVz6GsTGmojmE8w/fPwvDLAQ3121K2Zo7VriHEKTBjHS8mmmS5CwgJwW
	 foQEJffyV6m/vrNI0+IwjxAbUmp/J2RklgXNo9dkLQLhGOK3im9ePsxmeWZJBeGRET8DR
	 o7gXGq8hrGRHEBD54DOOz9Anc+BQg++PLlYdhvSybzY0isA9oaRXU6taGNdbGo22TIPpc
	 5cwPPQo6VRShASLA6pxtn33ThhYWiBtLp86+igWqevruFQqqR+QB4mUTmZHxox3jM0ArC
	 gIvCe3MG03//Ma7IXLn6T05tm0KY/lASJQ1Zc5MS/z21+wZMF71/KwsHLhHLyOMlTjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793145963;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=JIVPSVhg2KdPmFo5Uxu5SBxSepeIAod+FIu+ysSFAXs=;
	b=F8A9Af0N3TRM6G5vpRX64ukVQAsBjRMLGcVEJe9lMtN/nGX8xRpXyHYzAcyWTXA0SlRU
	 FuD4La5Vb8jNMYG/gYyK0QVFwb+vV9TPFnPWJmJxDwYCJCH5xKpW1OCiZFOYej4NBlygG
	 GSgrfM5mEFAAlRHk0UEtwJA++Y/Rd/yUFAEi8q2gxDpCTiTQNhAzEnJmk5WgB2qPF5ysG
	 sru3cbm81Wyp4BjRWwXWzwosFYMZC6aSYsCpcHKyi5uuJuuk5gF43D80rpIQOXOM3tD7h
	 JFvS7YvckA4tjT1GR6Sussvg66jdMMBauuX+20Lk3vBrsGIQRr6HFtIiy+qoR/RZZRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="SNfPh/RZ";
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E502A606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 00:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E502A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SNfPh/RZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793145962; x=1824681962;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=J0rB6ijMJ8J69nBOWpaWoCIbmFJvHpQPPlG/Um3zWK8=;
  b=SNfPh/RZK6L5Q/YGdtXKBducH0iRCacCc6NNnRZPxHcJN6qLy3una68i
   dNedxHg5Mje7tkRBCBcArJL+eB1IT0JGcK4/KXps3KXeooqC8M9r+qmHi
   hX4DUC5OlquzWnlrw+M1SfRK38t7+WX7gy/6bcgYtJnuQGNS+8BfyRKrc
   bEB5f2kRlRadFlNrC70BultOWzbcWqB01Gh0Mml/gE9YEkAZnObLcdeEX
   rHJ74fWV+ZU2+BeuTmKqXApr+ywRUF7UYtQIC2ILGtWM1FVHrMFM3k+xR
   KhrtNXSU+MxiQ+c6mP9HPBbBr6u0fPHTJAGUsgu85gdUgZ7DntmQXpDMP
   g==;
X-CSE-ConnectionGUID: Ou4kHgWVQwKCjIWg7l6Tpg==
X-CSE-MsgGUID: 1eXzC4ySQXOScMew0rVfSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1747195"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1747195"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 17:06:01 -0700
X-CSE-ConnectionGUID: TTg9x+cZT0WD3y95hnGvbw==
X-CSE-MsgGUID: aCWMTmcFQ+iaCWKOsWNyZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4776641"
Received: from orcnseosdtjek.amr.corp.intel.com ([10.166.28.128])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 17:06:00 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net 0/6] ice: E82x: reduced timestamp processing logic
 fixes
Date: Tue, 27 Oct 2026 17:05:36 -0700
Message-Id: <20261027-reduction-v1-0-81237c67a361@intel.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDMBQFryJvbUBTSKFXKS70+2J/F6kkUQTx7
 o26nGGYHYlRmfCqdkSumvQXCrR1Bfn0YaLRsTBsY13b2KeJHBfJpTKerhfnH04Gi9LPkV636/V
 GYEZ3y7QMX0o+LziOP2YxiIdyAAAA
X-Change-ID: 20261027-reduction-fe6ac6f36cb2
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3700;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=J0rB6ijMJ8J69nBOWpaWoCIbmFJvHpQPPlG/Um3zWK8=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqyHNvFTtN+1JN+2+dOg1e+zsWHNI5VPyjpHenWMnKPjC
 yT5LpV2lLIwiHExyIopsig4hKy8bjwhTOuNsxzMHFYmkCEMXJwCMJGLuxj+mX2QNj2uWmk398KV
 aY4PL6i/aNr4NqF+Wquou5+U+tK1yxgZ5tX5VczhWrRAQX+u9o1FCmK3G67Ut3WaRHubnVsuZu/
 PDwA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

Jake Keller says:

This is a reduced set patches originally posted as part of [1] which
previously passes Sashiko review without comments. It does not completely
resolve the outstanding issues that we had, but can hopefully unblock some
progress.

First, the locking around the PTP ports list in the adapter structure is
converted to use RCU primitives and a spinlock, resolving a couple of
reports from Petr about places where the original list was accessed without
lock protection. Note that an older version of this fix used an xarray
instead of the list. The xarray has more overhead and results in an
increase of ~25 microseconds to the average latency for processing Tx
timestamps. The list is simpler and avoids this overhead.

Next, the ice_ptp_request_ts() function is updated to sequence the marking
of the in_use bitmap in order to work properly with the lockless reader in
the IRQ thread. This issue was reported by Sashiko during development.

Next, Przemyslaw Korba fixes the E822 timestamping logic to keep timestamp
requests disabled until Vernier calibration completes.

Next, the driver is modified to stop clearing the PHY_REG_TX_OFFSET_READY
bit. This bits only purpose is to tell hardware to mark any captured
timestamps as invalid. Since this also disables the necessary side effects
on read it is problematic to have cleared. According to hardware engineers,
keeping it enabled should not have any other side effects. Instead, the
tx.disabled field is used to disable new timestamps from software in a
similar manner to the older E822 devices.

Next, the driver is modified to clear the PHY_REG_TX_MEMORY_STATUS by
reading each index *prior* to the PHY soft reset. This ensures that any
stale or invalid data left in the memory array is cleared, followed by the
counter being reset via the PHY soft reset procedure.

Finally, the ice_ptp_process_tx_tstamp() function is modified to skip
unnecessarily checking the ready bitmap for ports which do not have active
timestamp requests.

I plan to rework and follow up the remaining patches from the original
series after this lands.

[1]: https://lore.kernel.org/netdev/710677e5-3668-4588-bd36-2d8f7fb692a9@intel.com/

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Sashiko previously had no complaints about the SRCU changes on the port
list. I suspect it may now complain about some invalid accesses due to the
error cleanup flows in the reset or failure. I believe those should be
considered pre-existing issues and not block this reduced series.

---
Jacob Keller (5):
      ice: use reference counting and SRCU for PTP port access
      ice: set in_use only after preparing Tx timestamp index
      ice: E825: stop clearing PHY_REG_TX_OFFSET_READY
      ice: E825: clear PHY_TSTAMP memory prior to soft reset
      ice: skip reading Tx ready bitmap on ports with no timestamps

Karol Kolacinski (1):
      ice: E822: keep Tx timestamps disabled during offset calibration

 drivers/net/ethernet/intel/ice/ice_adapter.h |  17 ++-
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  11 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h  |   2 +-
 drivers/net/ethernet/intel/ice/ice_adapter.c |  17 ++-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 218 ++++++++++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  | 143 ++++++++++--------
 6 files changed, 275 insertions(+), 133 deletions(-)
---
base-commit: abeacca61eea4f6803df4a595b656ea45c2d3249
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git main
change-id: 20261027-reduction-fe6ac6f36cb2

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>

