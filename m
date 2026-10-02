Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6D0471CF7;
	Fri,  2 Oct 2026 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935244; cv=none; b=AMW4u4Ki8LV9d8+zAdg7N8I9D95mxDGfF8czW+reaJPDa9EzUaUUrPmmtiDG2/Bn5UslHcnvC0NFwQZCuWAIkA8VNM+3KhpBHVPZsANSf76lkgGzwbsw1gzoUVodWLH3c+AZ6TUZmVJV2rkrOJTYE4n0G8CnF2SIxmEjkuzAuqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935244; c=relaxed/simple;
	bh=CbB0xLarSbWUPsNkSII7WucMqmUrPVlEYEmkAdZGf2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAGJAcTFHq1z7D8VSFe5nde6KbKSyXDYNKPWJACXtTuI2it+gs8fv1j+bhcS183AKes4YdESbuzZpSpiM18EHlgGpAdNbRrpb4vnA9LJ5Ua0Le3rwO0GOJdmWtaNI+DqragLvYpXSe29Pejh1DnpB9bEBrOLTH9BLiqeUjKfy74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FViIISWC; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FViIISWC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790935241; x=1822471241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CbB0xLarSbWUPsNkSII7WucMqmUrPVlEYEmkAdZGf2g=;
  b=FViIISWC4uuVhLmHlS1bRXAE17pKsQfgcLweri/flkjfF+WJjXaVS50M
   CMOP1m3A39HzuNl9KwwQ/jDou6QqYoNVLPB7lw0kvO/MkbGtFqIVMwFoH
   fEAsCQkAmmEfwMvdu8neZqW0upfWrtKM0160IOVt7wZJFk7VZqZ8pZlAO
   2DcQJNVyP52a3Wq4bqAonGyhKjz5LSgM8P2KUW5XPzkA/IsBTd45+HBiA
   Ei39VyE1ZYKEn/P1FPhVbC655VaM47Znhv2xqcr2m5HD7hw8Ezfksru7R
   d3ODwqibDUCjF/+zyflCQhYSkF8tpN5/Kab4K0aXfIZ8iXyUl255XWq2R
   A==;
X-CSE-ConnectionGUID: jUFnpdXURvWRnZjiP9esKw==
X-CSE-MsgGUID: 5GlofnzHRqCII41oKRDVOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="113484676"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="113484676"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 03:00:40 -0700
X-CSE-ConnectionGUID: CtfEHRCMQlu/TovrpXNHug==
X-CSE-MsgGUID: Qq9oIQwjTl+gBcU4uyzWtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="279959890"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 02 Oct 2026 03:00:37 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4B7AC9B; Fri, 02 Oct 2026 12:00:36 +0200 (CEST)
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
Subject: [PATCH net-next v2 1/5] eea: Drop temporary buffer by using %*pEhp directly
Date: Fri,  2 Oct 2026 11:59:19 +0200
Message-ID: <20261002100035.863275-2-andriy.shevchenko@linux.intel.com>
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

Instead of calling string_escape_str() followed by %s specifier,
use %*pEhp specifier directly. With this being done, drop temporary
buffer.

Note, as Sashiko pointed out in [1] the %*pEp, which is the direct
substitution of the original call to string_escape_str() with ESCAPE_NP
flag set, makes the whole thing like "no escape". To add some sanity
to this the used specifier also includes ESCAPE_HEX.

Link: https://lore.kernel.org/r/179089728102.434549.12368098081790653201@kernel.org [1]
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/ethernet/alibaba/eea/eea_adminq.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/alibaba/eea/eea_adminq.c b/drivers/net/ethernet/alibaba/eea/eea_adminq.c
index 73d0caf25700..f2284fc885c3 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_adminq.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_adminq.c
@@ -522,16 +522,9 @@ void eea_adminq_config_host_info(struct eea_net *enet)
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
+			dev_warn(dev, "Device replied: %*pEhp\n",
+				 (int)strlen(rep->reply_str), rep->reply_str);
 		}
 	}
 
-- 
2.50.1

