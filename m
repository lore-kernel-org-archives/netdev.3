Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CE73CF02A;
	Wed, 20 May 2026 09:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779270094; cv=none; b=s8rvvy7PGvLbc50N9b9pbDXQTipaRU28mPdAJRZTjgXaE0yH6eJyoOKi3Iq5bKukblnQUGZpNcHUACv2rYwGHGgSdL0l1CAoq3YuyugeWqu2fDcq7/iyZ9dwycac+W6sHtOMlbPSeW5A4OMRw3Ma+W3OlggMMDgk16I03dEOcUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779270094; c=relaxed/simple;
	bh=0CIYW/gbW5djTp4U2PoSARXuN+Tj7BNt7+huCOXfV+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kqiFgZ5YA3gd8zTV07zF44GPWXkte+r9YH33XOSS3dkQp2NGT96plcxxHzmqbiFRua7F0x/9kj/nvj1JkHqJyOsi6bOzgyTQLS4rRTiq98CfCNEsMBs1oMXSRzsQgEmR4pNyc+kwLTbercBILGnmFezLbXsebg8rQZfFzXgKKkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ByaF5vKu; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ByaF5vKu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779270090; x=1810806090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0CIYW/gbW5djTp4U2PoSARXuN+Tj7BNt7+huCOXfV+o=;
  b=ByaF5vKuzubW5JNykVf+0JLPXyKHYB3X66yqrsX7KVJ4CZ4O1f/0soiR
   0/ZuW/7iL4UdbmK6mCW9/Y34mduk1e9j1rkP8E8GqaNzN/i1l3CJk6bPz
   6Xf34+AcQnjd7TkPVent9614uuSkRKj63fLj8/ca/K6HsI6j96vqnTUP1
   YM0D7qIHAzZvMJyDjpFxO5hIdaEjjKO1nyeAW2qCeKT10lN3nv11Ni2C7
   lBPS+cEoYktwZkejZbPUhGe/LlBzI8G5Urq7FE/7o3vdRTO6CVx0p6eVO
   5W84um8mY3kVbtUCjZ2d1rG4P7eTwJUIiGmQVuXrxFIfRnJP01xhknGqk
   A==;
X-CSE-ConnectionGUID: H4dfxTYKT5SlD/mLnsv+2g==
X-CSE-MsgGUID: VRCN3jesQI+uQO6p7p9geg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="90860398"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="90860398"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 02:41:28 -0700
X-CSE-ConnectionGUID: PEzX8WWXQEOLyIR6+s21fg==
X-CSE-MsgGUID: 6P9eejyhTwm6p70jWgvMWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="240365092"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa007.jf.intel.com with ESMTP; 20 May 2026 02:41:23 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	poros@redhat.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	Prathosh.Satish@microchip.com,
	ivecera@redhat.com,
	jiri@resnulli.us,
	arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev,
	donald.hunter@gmail.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH v10 net-next 4/8] dpll: allow fwnode pins to attempt state change without capability bit
Date: Wed, 20 May 2026 11:36:24 +0200
Message-Id: <20260520093628.3930705-5-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260520093628.3930705-1-grzegorz.nitka@intel.com>
References: <20260520093628.3930705-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pins registered with an fwnode may have .state_on_dpll_set implemented
without advertising DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE upfront.
Requiring the bit for fwnode pins ties firmware description to driver
implementation details unnecessarily.

Relax the capability check in dpll_pin_state_set() and
dpll_pin_on_pin_state_set(): when a pin has an associated fwnode, bypass
the capability gate and let the ops layer decide, returning -EOPNOTSUPP
if .state_on_dpll_set is absent. Non-fwnode pins retain the original
strict behavior.

This is used later in the series by the SyncE_Ref output pin, which
relies on the fwnode path for state control.

Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/dpll/dpll_netlink.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index f709e3dcd58e..025b9df4f934 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -1327,8 +1327,11 @@ dpll_pin_on_pin_state_set(struct dpll_pin *pin, u32 parent_idx,
 	unsigned long i;
 	int ret;
 
+	/* fwnode pins may not set the capability bit upfront; let the ops
+	 * layer return -EOPNOTSUPP if the operation is unsupported.
+	 */
 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
-	      pin->prop.capabilities)) {
+	      pin->prop.capabilities) && !pin->fwnode) {
 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
 		return -EOPNOTSUPP;
 	}
@@ -1363,8 +1366,11 @@ dpll_pin_state_set(struct dpll_device *dpll, struct dpll_pin *pin,
 	struct dpll_pin_ref *ref;
 	int ret;
 
+	/* fwnode pins may not set the capability bit upfront; let the ops
+	 * layer return -EOPNOTSUPP if the operation is unsupported.
+	 */
 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
-	      pin->prop.capabilities)) {
+	      pin->prop.capabilities) && !pin->fwnode) {
 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
 		return -EOPNOTSUPP;
 	}
-- 
2.39.3

