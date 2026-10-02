Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E8A47AF6E;
	Fri,  2 Oct 2026 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935247; cv=none; b=muB0Io6CeqE86jm8RMUprkHQIymoV5kWd6g884Fas70a7WezLnpgn89MvamIMqsBqDuE9gLjsiIQ7KMwbVPJtUVB2iRE13vtrYc1NWPK04FPWgogBJjNzk48Sie4X5jxlr/+kuBwkqGxm1QECNDXKLrce+SO0aD3fibs4R/9jTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935247; c=relaxed/simple;
	bh=kolBN0z85pb002HOFVk9e5XwpJhetSc/Yp+RQeUl3Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SijHSzsVZMTdDhoBIoweFsTtvMFEFNxxii54OwUDtsCsoCDzv5ynx62MK8Psxfv4A1D9PfvzpIkKWlcs0wTpSgRMAMIfI1Hs1JKE+ys6i/vOwcKw3vXgSnf4XfXtU79x1LpjKElZafiXijP+dJGJPUe6pHLWJTkuzMXELPbNc1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FQz3yVvW; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FQz3yVvW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790935246; x=1822471246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kolBN0z85pb002HOFVk9e5XwpJhetSc/Yp+RQeUl3Rg=;
  b=FQz3yVvWQ+cAZ3nKWK/bda7/xIJKGNAgLXHF6HKuDbcAnJe/53EVhELL
   j36ArSo70HCulENRYgJgcRkq+KbjDA/Wx04jIZXDE8uz8ODQLwFJeyTJ1
   E3Y39fuHofFnqq+DDMexO82LPRT0Jn/FOF+xjprbq/EeOJ2PyXwfkLrbd
   79tbzGOlzQMWSzNElkEaykOW1ikSivdr0fO0I3zaBEew1ZEtF/jSfR/Vr
   bpNt1zaxUFWsl3wz8zD42ZVe+aJvPaxlmyInqL0ikp9nq/jwlAms9RZ7R
   mnpv4ZPnhhl0jlKA8W+8jOFOT9VKLiBW+I1x93KJyaIU+CBR7ove0+3dj
   Q==;
X-CSE-ConnectionGUID: 6Ake56CUSsSWi/RC6JKAEg==
X-CSE-MsgGUID: U8POe7rZRUGykpPiqBDZlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="113484692"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="113484692"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 03:00:40 -0700
X-CSE-ConnectionGUID: 3lCg+KAARRqDQjPauVANEw==
X-CSE-MsgGUID: weS61PF0Sq+3i2mFpUgV4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="279959892"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 02 Oct 2026 03:00:37 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 53C099E; Fri, 02 Oct 2026 12:00:36 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v2 3/5] eea: Refactor error handling in eea_adminq_config_host_info()
Date: Fri,  2 Oct 2026 11:59:21 +0200
Message-ID: <20261002100035.863275-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261002100035.863275-1-andriy.shevchenko@linux.intel.com>
References: <20261002100035.863275-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use traditional pattern to check for error first in
eea_adminq_config_host_info().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/ethernet/alibaba/eea/eea_adminq.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/alibaba/eea/eea_adminq.c b/drivers/net/ethernet/alibaba/eea/eea_adminq.c
index 4876f8a1e686..92eeff32b00c 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_adminq.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_adminq.c
@@ -517,18 +517,19 @@ void eea_adminq_config_host_info(struct eea_net *enet)
 
 	rc = eea_adminq_exec(enet, EEA_AQ_CMD_HOST_INFO,
 			     cfg, sizeof(*cfg), rep, sizeof(*rep), NULL);
+	if (rc)
+		goto err_free_rep;
 
-	if (!rc) {
-		if (rep->op_code == EEA_HINFO_REP_BAD)
-			dev_warn(dev, "The hardware-driven state validation may be abnormal.\n");
+	if (rep->op_code == EEA_HINFO_REP_BAD)
+		dev_warn(dev, "The hardware-driven state validation may be abnormal.\n");
 
-		if (rep->has_reply) {
-			rep->reply_str[EEA_HINFO_MAX_REP_LEN - 1] = '\0';
-			dev_warn(dev, "Device replied: %*pEhp\n",
-				 (int)strlen(rep->reply_str), rep->reply_str);
-		}
+	if (rep->has_reply) {
+		rep->reply_str[EEA_HINFO_MAX_REP_LEN - 1] = '\0';
+		dev_warn(dev, "Device replied: %*pEhp\n",
+			 (int)strlen(rep->reply_str), rep->reply_str);
 	}
 
+err_free_rep:
 	kfree(rep);
 err_free_cfg:
 	kfree(cfg);
-- 
2.50.1

