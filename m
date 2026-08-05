Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1D83F4100
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 21:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965754; cv=none; b=ow5eRy27/yEYjlNlxQQYyQ6xYV3phPtshcjoc0ITi6rqBGWbw2ZHYBQnzO8q7+R+r933lyvKHguwWsAEmufMjA7K+KUHDRu/7j5VM2+8gNjDHiF+iE9VQSiIrTwL9iWtqQfogNzrby4oGcgH47m592o3e7i9qnCHlKULpnEuDYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965754; c=relaxed/simple;
	bh=+YTY44pLgeGFXsPjTrDua0NtxeyqppKCSedOw8Mpr2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IN5aKYnlkMRotXlI0us0JOwGgXwtv93vFCu47Qp8prvWVqS58V2vVrTATCOVzWQt3pvclISc0b3bYOWhVSGlY39ZsVC1UUH5G8rgou/tKytRi09NZ8qNnTFcSEUgWttgL4gH87C2qd6D5jpj9yvy8VHKS7RthCFN6RJx2YZMU0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D3/5SM8Q; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D3/5SM8Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785965752; x=1817501752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+YTY44pLgeGFXsPjTrDua0NtxeyqppKCSedOw8Mpr2w=;
  b=D3/5SM8Qg992+IQpH6du4gJVq5QOlfcxYlfqXBT5I/hgMeZ0waouopJH
   zenhypYYqu8Z4dkXWAig2plmiko7DeojaUxjXJDnma82jpFc9G5koauLB
   H2r+vbTDj4Izy+uMgdVWJ/iN/YBWSY9Mh7YFK3hPDvW9Wq9TVRK8DpvGS
   GMR3091ShDMXqVWgo35y6LDp3PDUB5p4q7IDI+6aORZQFEIESXewHnYoR
   Hj0gOhTnOGRd29bhw4tO4uT/+zxvW9Tz8iJRcNkc9LTKcdLyrpozERVqi
   I32UuLwu5eMRMhcVv0ix15+fFuGU7YlCQ2i8ds7i4xDlh7GYwQKrB7cJz
   A==;
X-CSE-ConnectionGUID: XYR7iL+1RWmA8dTznqZq9g==
X-CSE-MsgGUID: GARxRMq2SwyeCXaxVfEIOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="109343525"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="109343525"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 14:35:48 -0700
X-CSE-ConnectionGUID: m6xjOWYRRZmtxwAI2tspsw==
X-CSE-MsgGUID: QwUrECawT+OD9J5g5FhDfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="286576073"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 05 Aug 2026 14:35:48 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Subject: [PATCH net-next 04/15] virtchnl: add VIRTCHNL_VLAN_ETHERTYPE_88E7 support
Date: Wed,  5 Aug 2026 14:35:29 -0700
Message-ID: <20260805213541.2281287-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260805213541.2281287-1-anthony.l.nguyen@intel.com>
References: <20260805213541.2281287-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

IEEE 802.1ah (Provider Backbone Bridging) uses ethertype 0x88E7 as the
Backbone Service Tag (B-TAG). Some deployments stack 802.1ah on top of
existing QinQ or single-tagged VLAN infrastructure, creating scenarios
where a VF needs to negotiate support for the 0x88E7 ethertype with the
PF in order to install correct VLAN filters.

Add VIRTCHNL_VLAN_ETHERTYPE_88E7 = BIT(3) to the virtchnl_vlan_support
capability bitmask so that VF drivers can advertise and negotiate 0x88E7
VLAN ethertype support through the existing VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS
handshake.

The new bit follows the established BIT(N) pattern of the enum and does
not conflict with any existing flag.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 include/linux/avf/virtchnl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 11bdab5522fd..511c8827c640 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -636,6 +636,7 @@ enum virtchnl_vlan_support {
 	VIRTCHNL_VLAN_ETHERTYPE_8100 =		BIT(0),
 	VIRTCHNL_VLAN_ETHERTYPE_88A8 =		BIT(1),
 	VIRTCHNL_VLAN_ETHERTYPE_9100 =		BIT(2),
+	VIRTCHNL_VLAN_ETHERTYPE_88E7 =		BIT(3),
 	VIRTCHNL_VLAN_TAG_LOCATION_L2TAG1 =	BIT(8),
 	VIRTCHNL_VLAN_TAG_LOCATION_L2TAG2 =	BIT(9),
 	VIRTCHNL_VLAN_TAG_LOCATION_L2TAG2_2 =	BIT(10),
-- 
2.47.1

