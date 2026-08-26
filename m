Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9673B8405
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787737739; cv=none; b=iepea6Osf2FIVErg2lRufWXnczNFKqYHAgNnwkDf9E+j07TBTqGRybuA+V9v7VCtce37YgMsEoW8iV/IPsZu82E32iO1cFbZkxMhn/wLV0OYpLSMuAaQZJ0n2ztYn2i/7/4bKzYdxwdAf07/m0rGtf7YgYS6BilXJTr8bP3Tvb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787737739; c=relaxed/simple;
	bh=uS1Gk3FU8H9sDA2GM9EWDtq+Xlygp4KxaypBMwUQwy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MuurJ/3uO5A8NKeBmUOfLqOo07Cugt8L5c9tsoAPKk+OLA9Qnsx4bWweXZYUZ6Yc6DyVBFmGrDZbzzp1gXxFj+SLz0BpecAfrGoAy9PMfA6z0ISqo8tFyyfXf8urpjsStJtK14VvX+KOcne5eUls9vtVMKXoV1kpxamp2usq5NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hXA6sJy0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hXA6sJy0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787737736; x=1819273736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uS1Gk3FU8H9sDA2GM9EWDtq+Xlygp4KxaypBMwUQwy0=;
  b=hXA6sJy0aHDxrElRhtxPbiO+O36GZeBqRFV1nsfy2EuHuuMmU6TO+aQ2
   /3qX2Mb+qauwYDQBb8YBIBfV4tKIPuKmBfQXtmDZueMIT1/r2MGvR7kSb
   R5NpKdMj6Ftl8f5S49rN0hKeBbZFz8U1ZLQF2pX/kRcX5CSWVFfQgqQEJ
   iCXryYZ7eBtA54LOnACCqo5U6KpxVcpoE8ktxSZvwZBswfT9umUfQeXkh
   P9YqI9bQB89caGWyUT/InfBysqRGX7IchhLETEjLOY6KWKb//g9juph3E
   pfpxMyskBOur7ws8jB6MzXLOUxMEES6p8FUh9HWJV6tP5tAwA58uh2/8W
   A==;
X-CSE-ConnectionGUID: 0lT6xuZ3SmOVFLdWEgKh9g==
X-CSE-MsgGUID: QckDeysES0a7fj5JWgICZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88232948"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="88232948"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 02:48:52 -0700
X-CSE-ConnectionGUID: 7B5au/OrT/C5AMFFQDelvg==
X-CSE-MsgGUID: /7CKX7J9SfO7GxMAVXRARA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="261404797"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by fmviesa009.fm.intel.com with ESMTP; 26 Aug 2026 02:48:51 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v4 1/6] ice: dpll: Add the MUX tables to the documentation
Date: Wed, 26 Aug 2026 09:48:44 +0000
Message-ID: <20260826094849.4112016-2-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826094849.4112016-1-sergey.temerkhanov@intel.com>
References: <20260826094849.4112016-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the tables documenting the DPLL pin MUX states and behavior
to the driver.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 382fbe98f2b0..9b3584fa43a9 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -92,6 +92,29 @@ static const struct dpll_pin_frequency ice_esync_range[] = {
 	DPLL_PIN_FREQUENCY_RANGE(0, DPLL_PIN_FREQUENCY_1_HZ),
 };
 
+/*
+ * SMA1/U.FL1 MUX table
+ *+----------------+-------------+------------+
+ *|                | SMA1_DIR_EN | SMA1_TX_EN |
+ *+----------------+-------------+------------+
+ *|SMA1 RX Enable  |       0     |      x     |
+ *|u.FL1 TX Enable |       0     |      0     |
+ *|SMA1 TX Enable  |       1     |      0     |
+ *|All Disable     |       1     |      1     |
+ *+----------------+-------------+------------+
+ *
+ * SMA2/U.FL2 MUX table
+ *+----------------+-------------+------------+------------+
+ *|                | SMA2_DIR_EN | SMA2_TX_EN | UFL2_RX_EN |
+ *+----------------+-------------+------------+------------+
+ *|SMA2 RX Enable  |       0     |      x     |     x      |
+ *|u.FL2 RX Enable |       1     |      x     |     0      |
+ *|SMA2 TX Enable  |       1     |      0     |     x      |
+ *|SMA2 Disable    |       1     |      1     |     x      |
+ *|All Disable     |       1     |      1     |     1      |
+ *+----------------+-------------+------------+------------+
+ */
+
 /**
  * ice_dpll_is_sw_pin - check if given pin shall be controlled by SW
  * @pf: private board structure
-- 
2.53.0

