Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDB83783A1;
	Thu, 17 Sep 2026 20:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677953; cv=none; b=kTIuXJh51QeaD8rAPy3iMQFzNtWvvKfYmhg/fNCm0cXf8sQv80+zeyc0pTxkN7wprto6dnnxo/XwqYg7s7N+VN3VzVwG7EUeCVFjjTiwjiIwItzgNZyViAYlaq2YfU/V9WeGA4rrBLLZuUDF/YUr+qudZOjHuwyOa6PenQ1PdT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677953; c=relaxed/simple;
	bh=hKu9dHpd7qhuyVkSs7yLAHU238kUTum8f0CONaGpWls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CgiKf6+Qe6Wvmt9bj2GoxJRDlfq6D+YtfpeOVZpEwuJD6dO1j7wWkt+8KW0XBZeq1ULu3lteP+wHpTOKnBAdn3Uk3xrF5y8mn3FQvba0YGJj0TlXp+kWFapDtzwMOPNTZEFaoKseLym5TGGsTI8k0bZX/LhV2kGJqaptGKGyqD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=flXpAbKV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="flXpAbKV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789677952; x=1821213952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hKu9dHpd7qhuyVkSs7yLAHU238kUTum8f0CONaGpWls=;
  b=flXpAbKVssAVQwpHczYkW5kc97mzRSJ2spvqEbUPxfe4K9Oghs3+OKho
   6Fy8kc+noQyoOzqJZwnCQkplz1Wt6s5tbPJxhxSLaN6+I4Iv2Y6N+mKqj
   4TxFFszkc4CScyn0FBpJ5VbA4e3DRIV+1BIjlMxoV+zBNw3utrZPOIGPg
   D3QQjXA+5HdsPWhpHTFjSgavdNKa8VqimSRL2A6Wo4QfYYiY8j2peer4O
   51oonEwvHDcsN7HTXria7KYdjXEAUweYF8z7dMNxyP5oAruaHWZrp9Ya8
   dBMGqpYxJ+kcT617n9hbkOaW77a7P+oXMMyvIS8+eWfZP0i/vw53q+WWA
   A==;
X-CSE-ConnectionGUID: YelcRy6XSa2bre9rtZJtVg==
X-CSE-MsgGUID: XY4vZH2cSfi22shfhfjrjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100739301"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100739301"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 13:45:49 -0700
X-CSE-ConnectionGUID: nfGwwvWLSO+HvXG1GFd1oA==
X-CSE-MsgGUID: eqPhctAgQnqG+z0dyvbEhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="297502062"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 17 Sep 2026 13:45:49 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Mohammad Heib <mheib@redhat.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 2/3] i40e: add devlink parameter for Flow Director ATR sample rate
Date: Thu, 17 Sep 2026 13:45:39 -0700
Message-ID: <20260917204541.3072415-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260917204541.3072415-1-anthony.l.nguyen@intel.com>
References: <20260917204541.3072415-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Heib <mheib@redhat.com>

The i40e driver uses Flow Director ATR to periodically update flow
steering information for active TCP flows. The update frequency is
currently controlled by I40E_DEFAULT_ATR_SAMPLE_RATE and is fixed at
driver build time.

On systems with a large number of queues and high-rate TCP workloads,
the default sampling interval can result in frequent Flow Director
reprogramming for long-lived flows.

The amount of TCP packet reordering observed on some systems is
sensitive to the ATR sampling interval. Increasing the interval reduces
Flow Director programming activity and can significantly reduce the
associated reordering.

Since the optimal sampling interval depends on the workload and system
configuration, a single fixed value is not suitable for all deployments.

Add a devlink parameter to allow administrators to tune the ATR sample
rate at runtime without rebuilding the driver or disabling ATR
functionality entirely.

Signed-off-by: Mohammad Heib <mheib@redhat.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 Documentation/networking/devlink/i40e.rst     | 20 +++++++++++
 .../net/ethernet/intel/i40e/i40e_devlink.c    | 36 +++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/Documentation/networking/devlink/i40e.rst b/Documentation/networking/devlink/i40e.rst
index 51c887f0dc83..2cea98b631ba 100644
--- a/Documentation/networking/devlink/i40e.rst
+++ b/Documentation/networking/devlink/i40e.rst
@@ -40,6 +40,26 @@ Parameters
 
         The default value is ``0`` (internal calculation is used).
 
+.. list-table:: Driver specific parameters implemented
+    :widths: 5 5 90
+
+    * - Name
+      - Mode
+      - Description
+    * - ``atr_sample_rate``
+      - runtime
+      - Controls how frequently Flow Director ATR updates flow steering
+        information for active TCP flows.
+
+        ATR programs Flow Director entries based on sampled transmitted
+        packets. The sampling interval is specified as the number of
+        transmitted packets between ATR updates.
+
+        Lower values increase Flow Director programming activity, while
+        higher values reduce the update frequency.
+
+        Setting to ``0`` disables ATR sampling (no filters will be programmed)
+        The default value is ``20``.
 
 Info versions
 =============
diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
index 229179ccc131..6df7eb217073 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
@@ -33,12 +33,48 @@ static int i40e_max_mac_per_vf_get(struct devlink *devlink,
 	return 0;
 }
 
+static int i40e_atr_sample_rate_set(struct devlink *devlink,
+				    u32 id,
+				    struct devlink_param_gset_ctx *ctx,
+				    struct netlink_ext_ack *extack)
+{
+	struct i40e_pf *pf = devlink_priv(devlink);
+	u32 sample_rate = ctx->val.vu32;
+
+	WRITE_ONCE(pf->atr_sample_rate, sample_rate);
+	return 0;
+}
+
+static int i40e_atr_sample_rate_get(struct devlink *devlink,
+				    u32 id,
+				    struct devlink_param_gset_ctx *ctx,
+				    struct netlink_ext_ack *extack)
+{
+	struct i40e_pf *pf = devlink_priv(devlink);
+
+	ctx->val.vu32 = READ_ONCE(pf->atr_sample_rate);
+
+	return 0;
+}
+
+enum i40e_dl_param_id {
+	I40E_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
+	I40E_DEVLINK_PARAM_ID_ATR_SAMPLE_RATE,
+};
+
 static const struct devlink_param i40e_dl_params[] = {
 	DEVLINK_PARAM_GENERIC(MAX_MAC_PER_VF,
 			      BIT(DEVLINK_PARAM_CMODE_RUNTIME),
 			      i40e_max_mac_per_vf_get,
 			      i40e_max_mac_per_vf_set,
 			      NULL),
+	DEVLINK_PARAM_DRIVER(I40E_DEVLINK_PARAM_ID_ATR_SAMPLE_RATE,
+			     "atr_sample_rate",
+			     DEVLINK_PARAM_TYPE_U32,
+			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+			     i40e_atr_sample_rate_get,
+			     i40e_atr_sample_rate_set,
+			     NULL),
 };
 
 static void i40e_info_get_dsn(struct i40e_pf *pf, char *buf, size_t len)
-- 
2.47.1

