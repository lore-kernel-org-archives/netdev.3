Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C91C278161
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787345144; cv=none; b=LvfR903+7f6V13iEXgZ/qAYeGrgKtToCPg4k5PK3m6TZBuEwItu24z0It2HW8GPNM4mI1EmBy1jc1YxJJwjLusnFzeiWAS7EdbpecvfQEPwwmdKRX1W5b3Q1qCZJR2lY62G4BCt4/D0wOut6JjMBQiAIwVmz4jXcgLxkb7kgYog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787345144; c=relaxed/simple;
	bh=0rYOLMo4ukcedW9FgwPW5csDLI8wptNpe3twaodXtuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBxk6qp3wdkgPM1tEMB/hBXKyXHdglTeZcEkELUG3SAv+CYduz7xzDaejS0joUZ1Oj8ZLU1hYkeejF2d5YYQF1gsajhOcz4mkpKsPSdH12F06/nxQ1KrWWy7tn66wYpJ8mFJg+gTlqqwXOGvX709LMTeBL7YPQwzU+8X9kqGEIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kBh+AC+1; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kBh+AC+1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787345143; x=1818881143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0rYOLMo4ukcedW9FgwPW5csDLI8wptNpe3twaodXtuE=;
  b=kBh+AC+19XZYnvjC90PO0yDYGSPjmsufLdg4P+7V4VsUADDx3d7i0FHL
   h7m2zC4gQ8NfPe7ZXMvylsM7aJ1pGv1sR/6bfA4qqmmpwgCtjbp1ljnhi
   YWhrND82P/fDL1X6ulrBITvH41lfK5oUTqo9158UkP39+NyDoEjmGveZp
   +KamrW12fdLTkW/Rfb2JqslfKfFImFwxJGklbQ4y3imO9yJP5MuU65mOP
   G+aafPq0ypinwprmRgsZxp+ckJVqfw5lAcoH55U58rQlG7Y+YBPVxN+qf
   tasXI+xTsW27LYxA6z/K16TEjc6oG/Ec+aoLkEnlM/ac13YtDNxyl2Yq0
   Q==;
X-CSE-ConnectionGUID: Yi91US7fTCOAiCZqvVEcVA==
X-CSE-MsgGUID: ybQ/36PCRpKQjc3/TTxeFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="88027599"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88027599"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 13:45:42 -0700
X-CSE-ConnectionGUID: 6VZdxs7uQA+MDLsEI84MzA==
X-CSE-MsgGUID: bo/9nv63R0O3x1cqV09nAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="268400224"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 21 Aug 2026 13:45:42 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	aleksandr.loktionov@intel.com,
	sdf@fomichev.me,
	horms@kernel.org,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 1/4] iavf: return EBUSY if reset in progress or not ready during MAC change
Date: Fri, 21 Aug 2026 13:45:33 -0700
Message-ID: <20260821204537.2189112-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260821204537.2189112-1-anthony.l.nguyen@intel.com>
References: <20260821204537.2189112-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

When a MAC address change is requested while the VF is resetting or still
initializing, return -EBUSY immediately instead of attempting the
operation.

Additionally, during early initialization states (before __IAVF_DOWN),
the PF may be slow to respond to MAC change requests, causing long
delays. Only allow MAC changes once the VF reaches __IAVF_DOWN state or
later, when the watchdog is running and the VF is ready for operations.

After commit ad7c7b2172c3 ("net: hold netdev instance lock
during sysfs operations"), MAC changes are called with the netdev lock
held, so we should not wait with the lock held during reset or
initialization. This allows the caller to retry or handle the busy state
appropriately without blocking other operations.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 29b8403a066b..630388e9d28c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1042,6 +1042,9 @@ static int iavf_set_mac(struct net_device *netdev, void *p)
 	struct sockaddr *addr = p;
 	int ret;
 
+	if (iavf_is_reset_in_progress(adapter) || adapter->state < __IAVF_DOWN)
+		return -EBUSY;
+
 	if (!is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
 
-- 
2.47.1

