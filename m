Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20175313293;
	Thu,  2 Apr 2026 23:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775171425; cv=none; b=czH6+5ya2b75UDogSaS7tXEzW1yk1svvX9tKidrm4LENhPzKh1+1CrPEXYa4KYgbVWy0rdekSbNdgYXN4z3M6o15u3/kE9/sGV4REiyjCqrC05UojzGBNHEwT0537w7jbHKJZn6O4zcCCWSaQmFK337VLl0e94VGXwTnBqvmxbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775171425; c=relaxed/simple;
	bh=mGVGmB9xUUY2QySpvbbDhKQd8FqE0QgLo4M6A/it0eo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dng6YQ+xS0MrKokUYVzKzVdsoHVdB7UHc1oixHd/gnUXcZYGX4h7ZsFFyKpk1nF27CWnjyd9XKzBi/L95cmcuaU0W4zeYsN/F72ska9kmXeBFRIpGmY1m/VGYa2Q346CPuToFOZz4qf+LZrbfN/w7sv+mPgKrAjfPjEIZA2QcyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OhXhTDSm; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OhXhTDSm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775171424; x=1806707424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mGVGmB9xUUY2QySpvbbDhKQd8FqE0QgLo4M6A/it0eo=;
  b=OhXhTDSmc2wiPf62vLUBeWeSt8A7KMt22M7waSMH3gPE5+YYIV4v0OKw
   MJu0OBPRIeZ0EqmthEvvH1AcRHmdCMy0r69F+7WL6MRGEcuTry0tUzTjr
   yZpxsoev0Ucik96Pa/y3ClFNh5ZYI/eHjYT9pro45cvBwhTRxKFdHJFmv
   Cc5/pAKoBsVdZxqNbdfoOfZj17VP16Ueq3Y9677STQyF1sxQagbRdS8Td
   St6KpqBn5K8Kyjn+03tWNJzBpXF4TMnbYmQ+0mKpmzhCP4Czu4Io9XkTm
   YD9oYc57xIBBvJ3OzNpWV8KD4ReK8Hp8W5IVjGCOSnowKEdLu3y1Ek9Yl
   g==;
X-CSE-ConnectionGUID: I9ZwxKGeTn+wyHZ/gTCahg==
X-CSE-MsgGUID: Ih0g9J/0TFaN5W9isUefEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76123067"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="76123067"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 16:10:24 -0700
X-CSE-ConnectionGUID: ZdJQoyjIQ1O3dk3ees0qwQ==
X-CSE-MsgGUID: NHCIa/5pR6qVwkOxvLZoOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="227044424"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa008.jf.intel.com with ESMTP; 02 Apr 2026 16:10:20 -0700
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
Subject: [PATCH v5 net-next 2/8] dpll: allow registering FW-identified pin with a different DPLL
Date: Fri,  3 Apr 2026 01:06:20 +0200
Message-Id: <20260402230626.3826719-3-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260402230626.3826719-1-grzegorz.nitka@intel.com>
References: <20260402230626.3826719-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Relax the (module, clock_id) equality requirement when registering a
pin identified by firmware (pin->fwnode). Some platforms associate a
FW-described pin with a DPLL instance that differs from the pin's
(module, clock_id) tuple. For such pins, permit registration without
requiring the strict match. Non-FW pins still require equality.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/dpll/dpll_core.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 3f54754cdec4..55ad03977d6d 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -880,11 +880,21 @@ dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 		return -EINVAL;
 
 	mutex_lock(&dpll_lock);
-	if (WARN_ON(!(dpll->module == pin->module &&
-		      dpll->clock_id == pin->clock_id)))
+
+	/*
+	 * For pins identified via firmware (pin->fwnode), allow registration
+	 * even if the pin's (module, clock_id) differs from the target DPLL.
+	 * For non-fwnode pins, require a strict (module, clock_id) match.
+	 */
+	if (!pin->fwnode &&
+	    WARN_ON_ONCE(dpll->module != pin->module ||
+			 dpll->clock_id != pin->clock_id)) {
 		ret = -EINVAL;
-	else
-		ret = __dpll_pin_register(dpll, pin, ops, priv, NULL);
+		goto out_unlock;
+	}
+
+	ret = __dpll_pin_register(dpll, pin, ops, priv, NULL);
+out_unlock:
 	mutex_unlock(&dpll_lock);
 
 	return ret;
-- 
2.39.3

