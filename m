Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7918E39FCCC;
	Wed,  2 Sep 2026 08:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337294; cv=none; b=l3utYENKuBeSRfnAqx1FzSijtk/UwVt1hlnzDhJCHvZVYuZTlt0mGFKmG5IuYpqRD2Jk2ZSMJ3d1KjZjOdEcmfCJet8jsX+OnINTmgHfmKbTRlIKOyY0OkAGHKc1btNnQnq9yjZbV09/ul6D1tDbtMF1ivOkBcq8jXFWZmoXG0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337294; c=relaxed/simple;
	bh=Ep14FP4jyjllWySYdzkc0YioYsJ+m7KZq4YYu96tQFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZvqdWuyT1OpNQgehqE8l89vvOC0d3EErgBAdmDhO6GdgildOZC90bF0Nw0b+T96ufK5+HtyHd2NVkLmBHApx1nyZnEte8VlDx8au07NHdM/Ot68mlQYF0olee33OU0S/EN/LUSu4nu+tCYx/2N8x4J/nfMI9PKWXZxqY+1mHZJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RDTy6Rry; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RDTy6Rry"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788337292; x=1819873292;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ep14FP4jyjllWySYdzkc0YioYsJ+m7KZq4YYu96tQFA=;
  b=RDTy6Rry385kKYMUkoZzJUv0MVKOPFXH+zaUbY47T+VngClGFJVU+MnZ
   up1ZpR0RWFJSibPf+mjWxRqHyAf1lwEQsWrSoK9oJo0ppQDEni/pYtiaw
   bWhGYgX4C5/JSQoGcUvFWmsmvjG/kPnPY3WGioVRrxhuPOlTRSVJeE13a
   G4E3MmwoblX93sKt1BOoKlhI5q+Ik0US94RFFsBJPUhVXoDKE9xleFSl6
   KFHDKE87fWUQIZ2hEnhEFBXeRHHcvZ56xLA5VRyJvrg2R9K1hBEw7E28b
   xrl+0vJ5hozQAjZB7CGyy8v3OKQEETJWE6SlIODJSs93XKrpFHCTSQxck
   Q==;
X-CSE-ConnectionGUID: ZPrVCtA4RJm9KyQ2iAqL7w==
X-CSE-MsgGUID: W+Tyt36kQ1KSVai0x5QqYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88664293"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="88664293"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 01:21:32 -0700
X-CSE-ConnectionGUID: bRH9wogoS5+AXrAAjuWKJA==
X-CSE-MsgGUID: Ux2V+hdoQLy+x2inlqgn3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="273521568"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 02 Sep 2026 01:21:29 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 21FF699; Wed, 02 Sep 2026 10:21:28 +0200 (CEST)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-usb@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 0/2] thunderbolt / net: Allow batching of descriptors
Date: Wed,  2 Sep 2026 10:21:26 +0200
Message-ID: <20260902082128.1148463-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series makes the Thunderbolt/USB4 networking driver batch the
desriptors to avoid writing the doorbell register for each separately.
This improves throughput.

I can take these through Thunderbolt/USB4 tree as the 2/2 depends on the
1/2.

Mika Westerberg (2):
  thunderbolt: Allow batching of descriptors
  net: thunderbolt: Update ring indices only after all frames are queued

 drivers/net/thunderbolt/main.c |  6 ++--
 drivers/thunderbolt/nhi.c      | 58 +++++++++++++++++++++++++++++-----
 include/linux/thunderbolt.h    | 42 ++++++++++++++++++++++--
 3 files changed, 93 insertions(+), 13 deletions(-)

-- 
2.50.1

