Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EB73822BB;
	Mon, 23 Mar 2026 22:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774304721; cv=none; b=ZxUIXpQGCqPvsIjdDRfIbNcK0oOQ1vC8FqzKPMiBcFVXxEYVAoIX6z4/TDNqxAZ2h1ntw87ZZbq/MbwF1HFMS1EUFSVYP27B/2rAgM2U25hhhUdFBIIHfxx3kr88rJFFxzstxRp5vPxDIW+17kGH09wgQh0cTS7/ajsGAW3QJg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774304721; c=relaxed/simple;
	bh=hYTA8iUKl0X+UOSv4rV5POwDjvdL2+lTdynEuwcEsbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hpmyQ/jSUa5lNDadDbCGA/km+dfU2yTfxO0pbDEl3tn7yopRpEZL5zE6rUQMyEQAHYdAdRFyuBwbQlHMzAZc5Qr0YwT1DQhihqxzTFUU3nWKHA2D1pbUj81Xi6rEncJocWmtQEUujz8quXs3dwgMneAcS7AHS3tLwKiMyaw6ggo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l8NnmeV1; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l8NnmeV1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774304720; x=1805840720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hYTA8iUKl0X+UOSv4rV5POwDjvdL2+lTdynEuwcEsbk=;
  b=l8NnmeV1uNQs/PGoK9SeUbwl/mV8blafq/cj8ixjAg0GSGDdIcb4Vtzj
   el6dY56Lzh0VZJ4VaYaE8/xA37ktohmg8ixhedkLtqt+zVyxYt3ZQxUjP
   ZDXoi0dKlCdnDn0MbngIuj1ycW22SoTo6j+576jk1wOVAeF7VlxqI/3vs
   yYpZtqwxlsKrfMms1yP4E1dsnqxyzGk2MfN3s1Zoz35skETThOOyaTSzA
   dh2iWrJBeRAGnQVPITA8N75VN6yI0FQOGCXLn8WgELHAMlxqNYZF8iz0H
   +y/aM1X80A+Fx3ZioT0utiiiBMpiADdDjojV4FaSVWFfUfbfUoEMss/to
   g==;
X-CSE-ConnectionGUID: DM0Tcj5DTgmedSxTXz6Wug==
X-CSE-MsgGUID: 7EJ6IRSkTCujwDLfvZqrMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75221865"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75221865"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 15:25:20 -0700
X-CSE-ConnectionGUID: UV/DVek1QU6h/J6UhIZbEQ==
X-CSE-MsgGUID: /7GSf6gzTUGIwtwIDt6syA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="247207317"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by fmviesa002.fm.intel.com with ESMTP; 23 Mar 2026 15:25:16 -0700
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
Subject: [PATCH v3 net-next 2/8] dpll: allow registering FW-identified pin with a different DPLL
Date: Mon, 23 Mar 2026 23:21:27 +0100
Message-Id: <20260323222133.1796997-3-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260323222133.1796997-1-grzegorz.nitka@intel.com>
References: <20260323222133.1796997-1-grzegorz.nitka@intel.com>
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

