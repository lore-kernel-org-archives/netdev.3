Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9466E175A74;
	Sat, 21 Mar 2026 22:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774132213; cv=none; b=XAcQ51xvHmE1qRKgUhayzTLQwKPUZH8hZeK/erMQKI9LndamFf9V48z8iTvaxYQ87dhmqgNFujyy5abWh4CwUqziY4E0rdr+QU4TlnPmAkAcwX1G6sUZe42bk0Jzxuby53FV/qXpOzn9zQV9mIGvfLXisCOqIRdmSGn732gQ110=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774132213; c=relaxed/simple;
	bh=u+5dUgI9MeglTQJUE62U2wtjfkSu8FhYrvaGjK513KY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lLxTsXuBsLGH0gLDOWjVGH4RGXDsgNWBID7r7klOLa5odpLEeMP2hKvvQUUxRsAWNWlo+SNIlRSWEeR8DobIRDIwvJESYH/fMXlkrfMSbXxHPwzdp9VH6vV+r3YaL0hAQLdrQ+nYPjqEdhmL37IQx9KFvLMH83xASOp0kEj7uRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Le/IbCKO; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Le/IbCKO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774132212; x=1805668212;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u+5dUgI9MeglTQJUE62U2wtjfkSu8FhYrvaGjK513KY=;
  b=Le/IbCKOIR+31nFRpYW5OtmA9sZZafbgCZgcdTHeaaSUUJG1R2Q0Yj1o
   pzfwv2UzqrqW/0JhtBqxb6LZR3uY2OLuXoEerRraE3+syZxz7yueH89Ca
   65fX3QOX2mILZF5fUJYb4v5g8whdtyD+V4u06LIpVzBLO2aJa3pK5Q47F
   R9+cGwPHzir1efnJrPzLSiXH24ZF015dmAff+OijkOGoEUz3W4jzSY7+7
   YEl/PhIuMtJxbH0MDY2JxQPSXX5Jq/W8Bie9mb5EL9a6MKvpea0p7lbNA
   Ka0agf2oztMQSMm11BKb4b+AqRPWesbt+RBjAYwxg8fgoWxYLsRWXYTz8
   w==;
X-CSE-ConnectionGUID: 05PZUH6RT7S4fVO7U3RrLg==
X-CSE-MsgGUID: lbI1G5frTx67IZIwPh4bEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="75150382"
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; 
   d="scan'208";a="75150382"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 15:30:12 -0700
X-CSE-ConnectionGUID: eyKSTOiXQd+v9+rgQhn4eA==
X-CSE-MsgGUID: imA/BRysR7qTDUh4Gkvk0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; 
   d="scan'208";a="261543929"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa001.jf.intel.com with ESMTP; 21 Mar 2026 15:30:08 -0700
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
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH v2 net-next 1/8] dpll: add new DPLL type for transmit clock (TXC) usage
Date: Sat, 21 Mar 2026 23:26:20 +0100
Message-Id: <20260321222627.1193603-2-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260321222627.1193603-1-grzegorz.nitka@intel.com>
References: <20260321222627.1193603-1-grzegorz.nitka@intel.com>
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

The corresponding netlink specification is updated to expose "txc"

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 Documentation/netlink/specs/dpll.yaml | 3 +++
 drivers/dpll/dpll_nl.c                | 2 +-
 include/uapi/linux/dpll.h             | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 3dd48a32f783..2a2ee37a1fc0 100644
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
index a2b22d492114..4182bdbb6dbb 100644
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
index de0005f28e5c..8f6db5d5bf0c 100644
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

