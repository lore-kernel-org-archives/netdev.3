Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AEE3559F8
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 21:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040972; cv=none; b=gBfzURkPJpO7NMlcrbtirWQ9XDDkEQ585UR2qn1NK8COazOqP38RgpG8GRelQQ/n6ZyBQ4Gr/4sF1m/oqfJqHF0xqncdfann7mnrQp7KctGIvG6IpGaqCrzcn1EZe8B8iVV7BCmb9Y6DGFRcgH4dLbQWnyj6k41jbEzppORoUk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040972; c=relaxed/simple;
	bh=g9eRWxCe/sDLEOV8MX3RsJwz2TQ1T6Wj9FBgsBv/OtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtvDsx40+Inrtmzd/jiJChXX+kQrXKAJSkSJo9DkILT0SAqdsBJ+Hys5h04r7jBK9w/1YMrl73Te/nT+qCUUNm6H49HKDwUUg5bHJu1/fyqSYSklqk3MknCPCcuOs9v+YKm5JCqjr3bK8tJxoTgVtKHqHtFxeJ5IpJ2hulX3uXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m7ZIAn/Q; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m7ZIAn/Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781040971; x=1812576971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g9eRWxCe/sDLEOV8MX3RsJwz2TQ1T6Wj9FBgsBv/OtQ=;
  b=m7ZIAn/QRfZQBGhgfo/sQivYFUqKaqjrhNEdIxvALgkGFUed0+3t6Kmf
   Aat1HV9Ihb2ck++6SgWQNg9RCPBNs+SDux35NfSBYG38ZJ47JdQuAinOR
   GJ8RhdQJBNnErK/ylldTF1kj1c2dx01i4CQjW+/54qYrg35i/O70LXZSj
   vaTHVeV6jnj/kxyTMDM6SnSBIhsrZdw7ZKXtJXJh0zver/rnwvWioE1Mr
   hVog4n/vxdGjbETp8+thcrZduz329995YxZ/9fSYcjcmoWv2dYlJhfV9Q
   ZoQyg3zT57gWHLlIxCtigL+ddCDy93tzIYEqNEXU3d/7CMuUDZ5ORQ0SL
   Q==;
X-CSE-ConnectionGUID: 91ZhsgOGRxusQZj6zjQ7AQ==
X-CSE-MsgGUID: +DxEePlWR4erPLTD/aBL6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81568532"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81568532"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 14:36:08 -0700
X-CSE-ConnectionGUID: slU50UaSRxyDORCyL+H27w==
X-CSE-MsgGUID: dtweegUuS9OpVV23xiwQGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245838574"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 09 Jun 2026 14:36:07 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Corinna Vinschen <vinschen@redhat.com>,
	anthony.l.nguyen@intel.com,
	jtornosm@redhat.com,
	przemyslaw.kitszel@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 03/15] iavf: iavf_virtchnl_completion: drop duplicate ether_addr_equal() test
Date: Tue,  9 Jun 2026 14:35:44 -0700
Message-ID: <20260609213559.178657-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260609213559.178657-1-anthony.l.nguyen@intel.com>
References: <20260609213559.178657-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Corinna Vinschen <vinschen@redhat.com>

This is just a simple cleanup fix.  Commit 35a2443d0910f ("iavf: Add
waiting for response from PF in set mac") introduced a duplicate
ether_addr_equal() check, so the current code tests the new MAC twice
against the former MAC.

Remove the outer ether_addr_equal() test, remnant of commit c5c922b3e09b
("iavf: fix MAC address setting for VFs when filter is rejected")

Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 4f2defd2331b..ec234cc8bd9d 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -2550,13 +2550,11 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 	case VIRTCHNL_OP_ADD_ETH_ADDR:
 		if (!v_retval)
 			iavf_mac_add_ok(adapter);
-		if (!ether_addr_equal(netdev->dev_addr, adapter->hw.mac.addr))
-			if (!ether_addr_equal(netdev->dev_addr,
-					      adapter->hw.mac.addr)) {
-				netif_addr_lock_bh(netdev);
-				eth_hw_addr_set(netdev, adapter->hw.mac.addr);
-				netif_addr_unlock_bh(netdev);
-			}
+		if (!ether_addr_equal(netdev->dev_addr, adapter->hw.mac.addr)) {
+			netif_addr_lock_bh(netdev);
+			eth_hw_addr_set(netdev, adapter->hw.mac.addr);
+			netif_addr_unlock_bh(netdev);
+		}
 		wake_up(&adapter->vc_waitqueue);
 		break;
 	case VIRTCHNL_OP_GET_STATS: {
-- 
2.47.1

