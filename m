Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467BC4EBAED
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 22:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721730; cv=none; b=OOfqbzvBDVNyU97+zbktNy21gDIxfzaPsoh2Qs+HTcdHBznPoe3/zkVHPmhEHpI/AIU5YM6bZRL6djBeY9aGIRkTJh8vzN1jKj/H1ca8T98zcGWEy7P4FZQ2fHRe0GrOGhid4+DhyzK7iAbtBI/T3SbT2mZRRoRXyiKWPmv0Z7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721730; c=relaxed/simple;
	bh=GiDoMehYOy5VEcBUPNS73a17Q910E2ksq6ejkV6AB8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IeYSH/glkcZdGH5MGNeq5LBunsqC9RxszXG+kwlg5IzxMxqYiDa7puiTvIGL/Uf/fXdfsmVefcTrp+klRvUd2WVT3iiron85VlHl6UIu87/yLZ4jAC8H4tJmKo7p9ygHFvVYobobORhbWt22bIE2HVjr7baOyswi0Y08WAPtKT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J9zzd8+i; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J9zzd8+i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790721728; x=1822257728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GiDoMehYOy5VEcBUPNS73a17Q910E2ksq6ejkV6AB8I=;
  b=J9zzd8+i0iuC8oBVac4UINaaYImiwutWTrcXmzG8jPyG/aWEUncQS0p/
   aCDhJ6tsnk+yc9BBw35nDFBD75zrX8hiwVx2R+wXgC5x6ddHgaLpMU1Le
   VB6BwTxCzDBr33b3XqKTK2qoPV65yq4p/7AfiW1eRbuINoFt7m55MSCWz
   VlxzsnhebUlXwlY3FumSTLLFDoLbcEgpn/VoiiGWmxDeK9ptc4IJAt1oX
   S8kSc6qr48t6sZVXwJbUN0jHkCPIu5av55c+HZhIqiHaPai47E4UxQamB
   +UZEumJ5gIo4wcGvqA2/BBVGyPmaIA/I2RFgxBu714Dcjm7LqHUq5kz6k
   A==;
X-CSE-ConnectionGUID: fX7+wUq0RmSMQj2rBZ9DNA==
X-CSE-MsgGUID: 2pS8wLZlQWWicfSb/vx+XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="91548878"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="91548878"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 15:42:01 -0700
X-CSE-ConnectionGUID: uLgZhG5KSxG8Mb17PAaCIw==
X-CSE-MsgGUID: 5vsEMyJYTwu91r4ciQeciQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="313452318"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 29 Sep 2026 15:42:01 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	anthony.l.nguyen@intel.com,
	grzegorz.nitka@intel.com,
	marcin.szycik@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.korba@intel.com,
	xiongwm2026@163.com,
	ynorov@nvidia.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net-next 05/10] ice: use inline helpers instead of memcmp() for IPv6 mask checks in ice_ethtool_fdir
Date: Tue, 29 Sep 2026 15:41:45 -0700
Message-ID: <20260929224153.1455466-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260929224153.1455466-1-anthony.l.nguyen@intel.com>
References: <20260929224153.1455466-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Replace static full_ipv6_addr_mask / zero_ipv6_addr_mask structs
and the associated memcmp() calls in ice_ethtool_fdir.c with the
kernel-provided ipv6_addr_any() helper and a new ice_ipv6_mask_full()
inline, reducing boilerplate and making intent clearer.

Suggested-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../ethernet/intel/ice/ice_ethtool_ntuple.c   | 57 ++++++-------------
 1 file changed, 16 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
index 516b57ff3b1c..ad519a8513db 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
@@ -8,23 +8,10 @@
 #include "ice_fdir.h"
 #include "ice_flow.h"
 
-static struct in6_addr full_ipv6_addr_mask = {
-	.in6_u = {
-		.u6_addr8 = {
-			0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
-			0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
-		}
-	}
-};
-
-static struct in6_addr zero_ipv6_addr_mask = {
-	.in6_u = {
-		.u6_addr8 = {
-			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-		}
-	}
-};
+static bool ice_ipv6_mask_full(const __be32 *a)
+{
+	return (a[0] & a[1] & a[2] & a[3]) == cpu_to_be32(0xffffffff);
+}
 
 /* calls to ice_flow_add_prof require the number of segments in the array
  * for segs_cnt. In this code that is one more than the index.
@@ -1070,10 +1057,8 @@ ice_set_fdir_ip6_seg(struct ice_flow_seg_info *seg,
 	enum ice_flow_field src_port, dst_port;
 
 	/* make sure we don't have any empty rule */
-	if (!memcmp(tcp_ip6_spec->ip6src, &zero_ipv6_addr_mask,
-		    sizeof(struct in6_addr)) &&
-	    !memcmp(tcp_ip6_spec->ip6dst, &zero_ipv6_addr_mask,
-		    sizeof(struct in6_addr)) &&
+	if (ipv6_addr_any((struct in6_addr *)tcp_ip6_spec->ip6src) &&
+	    ipv6_addr_any((struct in6_addr *)tcp_ip6_spec->ip6dst) &&
 	    !tcp_ip6_spec->psrc && !tcp_ip6_spec->pdst)
 		return -EINVAL;
 
@@ -1097,24 +1082,20 @@ ice_set_fdir_ip6_seg(struct ice_flow_seg_info *seg,
 	*perfect_fltr = true;
 	ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_IPV6 | l4_proto);
 
-	if (!memcmp(tcp_ip6_spec->ip6src, &full_ipv6_addr_mask,
-		    sizeof(struct in6_addr)))
+	if (ice_ipv6_mask_full(tcp_ip6_spec->ip6src))
 		ice_flow_set_fld(seg, ICE_FLOW_FIELD_IDX_IPV6_SA,
 				 ICE_FLOW_FLD_OFF_INVAL, ICE_FLOW_FLD_OFF_INVAL,
 				 ICE_FLOW_FLD_OFF_INVAL, false);
-	else if (!memcmp(tcp_ip6_spec->ip6src, &zero_ipv6_addr_mask,
-			 sizeof(struct in6_addr)))
+	else if (ipv6_addr_any((struct in6_addr *)tcp_ip6_spec->ip6src))
 		*perfect_fltr = false;
 	else
 		return -EOPNOTSUPP;
 
-	if (!memcmp(tcp_ip6_spec->ip6dst, &full_ipv6_addr_mask,
-		    sizeof(struct in6_addr)))
+	if (ice_ipv6_mask_full(tcp_ip6_spec->ip6dst))
 		ice_flow_set_fld(seg, ICE_FLOW_FIELD_IDX_IPV6_DA,
 				 ICE_FLOW_FLD_OFF_INVAL, ICE_FLOW_FLD_OFF_INVAL,
 				 ICE_FLOW_FLD_OFF_INVAL, false);
-	else if (!memcmp(tcp_ip6_spec->ip6dst, &zero_ipv6_addr_mask,
-			 sizeof(struct in6_addr)))
+	else if (ipv6_addr_any((struct in6_addr *)tcp_ip6_spec->ip6dst))
 		*perfect_fltr = false;
 	else
 		return -EOPNOTSUPP;
@@ -1167,33 +1148,27 @@ ice_set_fdir_ip6_usr_seg(struct ice_flow_seg_info *seg,
 	if (usr_ip6_spec->l4_proto)
 		return -EOPNOTSUPP;
 	/* empty rules are not valid */
-	if (!memcmp(usr_ip6_spec->ip6src, &zero_ipv6_addr_mask,
-		    sizeof(struct in6_addr)) &&
-	    !memcmp(usr_ip6_spec->ip6dst, &zero_ipv6_addr_mask,
-		    sizeof(struct in6_addr)))
+	if (ipv6_addr_any((struct in6_addr *)usr_ip6_spec->ip6src) &&
+	    ipv6_addr_any((struct in6_addr *)usr_ip6_spec->ip6dst))
 		return -EINVAL;
 
 	*perfect_fltr = true;
 	ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_IPV6);
 
-	if (!memcmp(usr_ip6_spec->ip6src, &full_ipv6_addr_mask,
-		    sizeof(struct in6_addr)))
+	if (ice_ipv6_mask_full(usr_ip6_spec->ip6src))
 		ice_flow_set_fld(seg, ICE_FLOW_FIELD_IDX_IPV6_SA,
 				 ICE_FLOW_FLD_OFF_INVAL, ICE_FLOW_FLD_OFF_INVAL,
 				 ICE_FLOW_FLD_OFF_INVAL, false);
-	else if (!memcmp(usr_ip6_spec->ip6src, &zero_ipv6_addr_mask,
-			 sizeof(struct in6_addr)))
+	else if (ipv6_addr_any((struct in6_addr *)usr_ip6_spec->ip6src))
 		*perfect_fltr = false;
 	else
 		return -EOPNOTSUPP;
 
-	if (!memcmp(usr_ip6_spec->ip6dst, &full_ipv6_addr_mask,
-		    sizeof(struct in6_addr)))
+	if (ice_ipv6_mask_full(usr_ip6_spec->ip6dst))
 		ice_flow_set_fld(seg, ICE_FLOW_FIELD_IDX_IPV6_DA,
 				 ICE_FLOW_FLD_OFF_INVAL, ICE_FLOW_FLD_OFF_INVAL,
 				 ICE_FLOW_FLD_OFF_INVAL, false);
-	else if (!memcmp(usr_ip6_spec->ip6dst, &zero_ipv6_addr_mask,
-			 sizeof(struct in6_addr)))
+	else if (ipv6_addr_any((struct in6_addr *)usr_ip6_spec->ip6dst))
 		*perfect_fltr = false;
 	else
 		return -EOPNOTSUPP;
-- 
2.47.1

