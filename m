Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E986B2931DF;
	Tue, 29 Sep 2026 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670452; cv=none; b=e8UYthDh43zspQGd60S8UHS8o/4kUse0CTrSfR1ifntXW4K4A0l7NuQ5V07LQB7XCRcjSAFCxqntqtXiQGs+mDkuY4CFHdL2Bh6QTEsSLjKUUkPEAc3apVE6bSrooH4mmcEil4EKi0hLqrmxerNMggLMJx/MXAksDFWwRGUWSZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670452; c=relaxed/simple;
	bh=OLyupj4VY2YdQb6ysUVJTbnElUAa+kENmXAjI+Ba+Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=piEVOVVICneA58h4yiejEuXKlqdBaAXecf1bl4DrkhPUTZA+LG3T8fbk3kUsXFSuxYnmAaTw6ld6QwcD5keB440bg99HDe8h/d9hVXllfAj7q+vpDl6yRbN2/HhjwL/aAg6pC/k81upjUUHPZsECVTQROF9GueyxSnP2mbJr7h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lKtpxG6J; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lKtpxG6J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790670449; x=1822206449;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OLyupj4VY2YdQb6ysUVJTbnElUAa+kENmXAjI+Ba+Gk=;
  b=lKtpxG6JMQsXPfIzWqSA2oHnWjZK2zzq4oGfw+Uyq1Lcq9SEr6eWjo8X
   TDTiGBt00S3OlB8m7D9Q64haDVtsKbCNMmSHT2K8sWDd0h8DaoBtcykFX
   5Txsi5zy8A+9L/irDNW6tCNmPaZGJ+8MUjh8o6VOv+HaDW5F5lm8RxqZC
   z7aXFv8BxPLz8lojGUuJQjc/RVNVjY3MiOP4jspDcVdMsFDK7xuJPmC/R
   oBwehRxpN9Ee7R6RyveyaNzOHxTH/XZ8gqiB1Ti4CzzQ+MmE6AdeAsnPI
   CVBHvTLAhaoAHjFYRcy19E1v3DguP9JKTGm4ZHDBnp8a6hZj2UtGSpzv/
   g==;
X-CSE-ConnectionGUID: PkC5E9wyQ/yxIATDRs12Zw==
X-CSE-MsgGUID: rh7lApFZRuOeAT6lQcv98g==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="94264651"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="94264651"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 01:27:28 -0700
X-CSE-ConnectionGUID: mTZreb/GQQOIAd/exbegJw==
X-CSE-MsgGUID: zWxYh8ooTQeerp3UuqfzmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="278518144"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 29 Sep 2026 01:27:25 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id D1ECB99; Tue, 29 Sep 2026 10:27:23 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v1 1/1] eea: Drop temporary buffer by using %pEp directly
Date: Tue, 29 Sep 2026 10:27:22 +0200
Message-ID: <20260929082722.3368741-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of calling string_escape_str() followed by %s specifier,
use %pEp specifier directly. With this being done, drop temporary
buffer.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/ethernet/alibaba/eea/eea_adminq.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/alibaba/eea/eea_adminq.c b/drivers/net/ethernet/alibaba/eea/eea_adminq.c
index 73d0caf25700..d17575a76890 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_adminq.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_adminq.c
@@ -522,16 +522,8 @@ void eea_adminq_config_host_info(struct eea_net *enet)
 			dev_warn(dev, "The hardware-driven state validation may be abnormal.\n");
 
 		if (rep->has_reply) {
-			char buf[EEA_HINFO_MAX_REP_LEN] = {0};
-
 			rep->reply_str[EEA_HINFO_MAX_REP_LEN - 1] = '\0';
-
-			string_escape_str(rep->reply_str, buf, sizeof(buf),
-					  ESCAPE_NP, NULL);
-
-			buf[EEA_HINFO_MAX_REP_LEN - 1] = '\0';
-
-			dev_warn(dev, "Device replied: %s\n", buf);
+			dev_warn(dev, "Device replied: %pEp\n", rep->reply_str);
 		}
 	}
 
-- 
2.50.1

