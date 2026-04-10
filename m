Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B5F3A5437
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775807371; cv=none; b=GiXjP/xoNx7HHvj2J8zaLLQjHv5O56z1uIdR6ci8mjuw2iFHJQJGqXZycHiijkQJ6ByZNqNDM+I3zYf0RcpBfzAkHkbx/BSZrCkc0dLUg3adqufCOaIkOTx+d1DK+LCiKfW2vsDIQIipGr0pjKcr5iubs5KF7eWjV6UFvy2+FuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775807371; c=relaxed/simple;
	bh=NcU0Iz9MD/rDovwL1/g0sA94Rz0+LbfmauAxlyFyR6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P57cegzIrIOEzK6D8eaQh4bxr6LmuegQxUoXLIjBQMRK1LCDvTLw9iNSM5S3htKzum1GExvCzFSpVIpPNGYeAsmskvz7U8rWGR7Fs2xZrAynO4y2a+e1mX5X/Px5pzW462X/GSRKBvVAPP29zQ1xIQmVdUsLlc9uDHEJGUX+RR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hj3nMhFH; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hj3nMhFH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775807369; x=1807343369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NcU0Iz9MD/rDovwL1/g0sA94Rz0+LbfmauAxlyFyR6A=;
  b=hj3nMhFHfR3Jhxk5Q/GXPFeBoiQGh4Jw92mucPltKK8lfVI6avppWoSD
   ReAizf2E6tQ81usGv2xp/yXJyV0a45x2cBNzSaF6FrfGBRxnUP0s8G2pZ
   mxdApXWS5QCvaYivrvrcBZVDoI+h4DxFLkH8NsHQEQGvjt0WkqlxE7+6q
   zEySqQ5uuaEnt6Reg5sIxwrxBgrEn1SpR9318zsk44hY92dGDst5zeeop
   G92VfA5rzRjDU/1VXk9idbtSmPpXQktfgFT3O5asY/GMr70RLC349m5sU
   Xmh1yQaHOqKRA5uxI/+rUYY64zTztnQCuMUNaqOEYAqxJCn3WrXW5euxq
   g==;
X-CSE-ConnectionGUID: sg+1UYuXSC6DnqSXTjN8xQ==
X-CSE-MsgGUID: HHIIEAXXTseqQTJTFLOSJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="77007924"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="77007924"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 00:49:29 -0700
X-CSE-ConnectionGUID: WJom4z9jSietYueaIRcQKA==
X-CSE-MsgGUID: n7uYW9p8TIeLoY4+ufg6qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="228941865"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa008.jf.intel.com with ESMTP; 10 Apr 2026 00:49:28 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH iwl-next 3/10] ice: add PORT_AUI and PORT_NONE ethtool port type reporting
Date: Fri, 10 Apr 2026 09:49:14 +0200
Message-ID: <20260410074921.1254213-4-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
References: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that ICE_MEDIA_AUI and ICE_MEDIA_NONE enum values exist,
ice_get_link_ksettings() reports PORT_OTHER for both of them because the
switch falls through to the former default handler.

Replace the catch-all default with an explicit ICE_MEDIA_UNKNOWN case for
PORT_OTHER, and add proper ICE_MEDIA_AUI -> PORT_AUI and
ICE_MEDIA_NONE -> PORT_NONE mappings.  The switch now covers every
enum ice_media_type value.

Suggested-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 11 +++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index caec297..6857fcd 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1901,9 +1901,18 @@ ice_get_link_ksettings(struct net_device *netdev,
 		ethtool_link_ksettings_add_link_mode(ks, advertising, FIBRE);
 		ks->base.port = PORT_DA;
 		break;
-	default:
+	case ICE_MEDIA_AUI:
+		ethtool_link_ksettings_add_link_mode(ks, supported, AUI);
+		ethtool_link_ksettings_add_link_mode(ks, advertising, AUI);
+		ks->base.port = PORT_AUI;
+		break;
+	case ICE_MEDIA_NONE:
+		ks->base.port = PORT_NONE;
+		break;
+	case ICE_MEDIA_UNKNOWN:
 		ks->base.port = PORT_OTHER;
 		break;
+	/* All ice_media_type enum values are explicitly handled above. */
 	}
 
 	/* flow control is symmetric and always supported */
-- 
2.52.0
