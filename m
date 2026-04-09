Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBEE3A4531;
	Thu,  9 Apr 2026 23:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775778911; cv=none; b=J3dRv2CMGLeIgVJ6rTXddpXAU0oGohv/UL2aY6vL0dYGeUO6cPxpAcOmC3i2bhPWGJ1WjtEEg8dNKaPA+1ck2aCH2EkuP2z7vYh+0ocUHM+N0hZPNcDddgQ2R/dy/I2CcHJEmGk7vZcfQk53Dr+svRjSzPCy3JXegqqT4ZK8i3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775778911; c=relaxed/simple;
	bh=C5JnC501kAXn3wVLgMrthehP/YSXfC3I237eaYYXsTU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FPJ9mAPQagsF6Hssfvn7Xz8h7I8pPnWEc06OuV8GPM/VK3U/T83oupp6Vgx0pufpau+9moixbrNabhlZv+ptkrEuP+vhEm6AbFTFRMk1iligh7UCnVONxEzb40McBC3I+eG0LHf26akWlWPc3nl94ivrHdgifrFpiW4pJ3h/Jl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KhcBe+NZ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KhcBe+NZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775778911; x=1807314911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C5JnC501kAXn3wVLgMrthehP/YSXfC3I237eaYYXsTU=;
  b=KhcBe+NZn+6mJL0+zPhYL72L5XWhREXHgqCKi5vXQ4AqQgutx1Xwqm5a
   f3hy5IisRRnsj3QL5XlB3eik9/F2VMw5Y+mlKwQU0AMfc6iH32xH43q6N
   FrUVNPl9eDfn+DMwjNuTk99VKm0umAqDSO8LvtKYkE+Znor+23ZhHLCfC
   XxMOyFmj2vy+ty3UVtv+TY20V0R8V1W1ai/7fmceB8LZmL0iQF3F6q5xf
   JOCerlM92w8GQc/RPAlq9wET+wvY80rDeWtLa59pN+93qk752ipilGfpz
   8mdFVm5etJ1BcOR4er+qaUjLDiSP0S4h7t7Whs8WIdmSIVLTX2aU3kJw+
   g==;
X-CSE-ConnectionGUID: Chxv6T7KTsiVGOmWfoRGnQ==
X-CSE-MsgGUID: IRwF1gUpRvuBaaUAc/eraQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="87424037"
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="87424037"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 16:55:10 -0700
X-CSE-ConnectionGUID: S7vgBXxrSfe0xids/UhARw==
X-CSE-MsgGUID: 1YxCmhM5SWSQfsKWgBcFqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="228859705"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa008.jf.intel.com with ESMTP; 09 Apr 2026 16:55:06 -0700
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
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH v6 net-next 1/8] dpll: add new DPLL type for transmit clock (TXC) usage
Date: Fri, 10 Apr 2026 01:51:15 +0200
Message-Id: <20260409235122.436749-2-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260409235122.436749-1-grzegorz.nitka@intel.com>
References: <20260409235122.436749-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the DPLL subsystem with a new DPLL type, DPLL_TYPE_TXC,
representing devices that drive a transmit reference clock. Certain
PHYs, MACs and SerDes blocks use a dedicated TX reference clock for
link operation, and this clock domain is distinct from PPS- and
EEC-driven synchronization sources. Defining a dedicated type allows
user space and drivers to correctly classify and configure DPLLs
intended for TX clock generation.

The corresponding netlink specification is updated to expose "txc".

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 Documentation/netlink/specs/dpll.yaml | 3 +++
 drivers/dpll/dpll_nl.c                | 2 +-
 include/uapi/linux/dpll.h             | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 40465a3d7fc2..69e907850c01 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -138,6 +138,9 @@ definitions:
       -
         name: eec
         doc: dpll drives the Ethernet Equipment Clock
+      -
+        name: txc
+        doc: dpll drives Tx reference clock
     render-max: true
   -
     type: enum
diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
index 1e652340a5d7..9a3b70ea3ae0 100644
--- a/drivers/dpll/dpll_nl.c
+++ b/drivers/dpll/dpll_nl.c
@@ -34,7 +34,7 @@ const struct nla_policy dpll_reference_sync_nl_policy[DPLL_A_PIN_STATE + 1] = {
 static const struct nla_policy dpll_device_id_get_nl_policy[DPLL_A_TYPE + 1] = {
 	[DPLL_A_MODULE_NAME] = { .type = NLA_NUL_STRING, },
 	[DPLL_A_CLOCK_ID] = { .type = NLA_U64, },
-	[DPLL_A_TYPE] = NLA_POLICY_RANGE(NLA_U32, 1, 2),
+	[DPLL_A_TYPE] = NLA_POLICY_RANGE(NLA_U32, 1, 3),
 };
 
 /* DPLL_CMD_DEVICE_GET - do */
diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index 871685f7c353..b2045cb0a779 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -109,10 +109,12 @@ enum dpll_clock_quality_level {
  * enum dpll_type - type of dpll, valid values for DPLL_A_TYPE attribute
  * @DPLL_TYPE_PPS: dpll produces Pulse-Per-Second signal
  * @DPLL_TYPE_EEC: dpll drives the Ethernet Equipment Clock
+ * @DPLL_TYPE_TXC: dpll drives Tx reference clock
  */
 enum dpll_type {
 	DPLL_TYPE_PPS = 1,
 	DPLL_TYPE_EEC,
+	DPLL_TYPE_TXC,
 
 	/* private: */
 	__DPLL_TYPE_MAX,
-- 
2.39.3

