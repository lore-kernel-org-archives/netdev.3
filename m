Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E8F4CCDC7
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005606; cv=none; b=mJNYuUGo4chiWNsYKbDMBRpWZhKCnK1i2e9wh1r98AKvp5jUsrHM+MAhQJm0SKdpFl80XQxKQYD/1aG8ZWzt7rH3UqhcslenHwO+ZMrQga7tCHIpGtVuNq+OhU/n/RleqLYBG9JVtun87Wg1+u4xAX+POxr2Xp9v6dYTUZ7E0Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005606; c=relaxed/simple;
	bh=7/m0XbVt4fk5+QGYgmreOkW1YNqT4XktT08ilwF9FiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2BG9qY2b42IHMD1JT+AaaOSIzOPWNpvWeeLe44NsMqUVtbQHyd4tRgGQ2JudAGt0xcU1S54YIoIlQiKlLm5CaBOrXoKgLRFGvTzY6UFR1w+eEMCgt8m3XHvTKAv0M40zygCA513sNUmCvyveuqXhZb9Agudy3z98FRCS+TwAXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m03DCl0O; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m03DCl0O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790005604; x=1821541604;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7/m0XbVt4fk5+QGYgmreOkW1YNqT4XktT08ilwF9FiI=;
  b=m03DCl0OWYjO5F9EO6jba4c8ISL57CAEnkFJQe+V/x8FdAZCGHIBYiJ4
   B4R5BFn9WQxHSq+PzCBI9EKtxXj8FJVw1tj0RbGYGQ/6js8uyRxIz8Dk/
   cmNOKLZR2Cj+brRDc4oVG2u3lZ4eO8zIrIbxUHNdiJdXOyjBBL8N133UC
   HYtQWNYT2PYQA0dkb2rqwiKLrHLPhyyPXF7v2JhnC1voJmEm001ew8KIY
   Frwmre69d3ZIS/tzrSaEq6r0hQtLdAfVQZeUcUrBYYCfTP8dx7TN+77Nk
   BCg9cLq1uKsEi3MLqBdwRfEI6wf443DMoYsxdyxOHfdLJyqvyR7w/kYY9
   w==;
X-CSE-ConnectionGUID: Cx0PlnqzRHyrztk4gZinYg==
X-CSE-MsgGUID: j/TVV39TQguG1g41YrE/zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90553450"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="90553450"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 08:46:43 -0700
X-CSE-ConnectionGUID: k3dGegAFT2m+cN2+E3SNHg==
X-CSE-MsgGUID: BGGAazyISXeu/aex11fIzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="277498901"
Received: from txandevvm17u.an.intel.com ([10.122.196.193])
  by fmviesa004.fm.intel.com with ESMTP; 21 Sep 2026 08:46:43 -0700
From: Pei Lee Ling <pei.lee.ling@intel.com>
To: andrew@lunn.ch,
	netdev@vger.kernel.org
Cc: shubham.das@intel.com,
	siddaraju.dh@intel.com,
	balaji.chintalapalle@intel.com,
	pei.lee.ling@intel.com
Subject: [RFC PATCH net-next 1/1] ethtool: Add Clear-fec-stats ethtool handler
Date: Mon, 21 Sep 2026 10:46:37 -0500
Message-ID: <20260921154637.2376544-2-pei.lee.ling@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921154637.2376544-1-pei.lee.ling@intel.com>
References: <20260921154637.2376544-1-pei.lee.ling@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In high-speed links such as 25G, 100G, and 200G, FEC counters continuously
accumulate over time. When troubleshooting intermittent physical-layer
issues, users need to establish a clean baseline without resetting the
entire device interface. Therefore, this dedicated
FEC counter clear operation avoids unnecessary operational disruptions.

Adding a fec-clear command would also help to standardize the interface
across different network drivers, providing a more consistent and predictable
user experience.

To clear-fec-stats:
ethtool --clear-fec-stats <ETH1>

Signed-off-by: Pei Lee Ling <pei.lee.ling@intel.com>
---
 Documentation/netlink/specs/ethtool.yaml       |  3 +++
 include/linux/ethtool.h                        |  1 +
 include/uapi/linux/ethtool_netlink_generated.h |  1 +
 net/ethtool/fec.c                              | 11 ++++++++++-
 net/ethtool/netlink.h                          |  2 +-
 5 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 5dd4d1b5d94b..6943a6280f35 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1312,6 +1312,9 @@ attribute-sets:
         name: stats
         type: nest
         nested-attributes: fec-stat
+      -
+        name: stats-clear
+        type: u8
   -
     name: module-eeprom
     attr-cnt-name: __ethtool-a-module-eeprom-cnt
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 12683b5d125e..d5ec9f415adc 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1319,6 +1319,7 @@ struct ethtool_ops {
 	void	(*get_fec_stats)(struct net_device *dev,
 				 struct ethtool_fec_stats *fec_stats,
 				 struct ethtool_fec_hist *hist);
+	int	(*clear_fec_stats)(struct net_device *dev);
 	int	(*get_fecparam)(struct net_device *,
 				      struct ethtool_fecparam *);
 	int	(*set_fecparam)(struct net_device *,
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 8134baf7860f..01c5b754c3db 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -595,6 +595,7 @@ enum {
 	ETHTOOL_A_FEC_AUTO,
 	ETHTOOL_A_FEC_ACTIVE,
 	ETHTOOL_A_FEC_STATS,
+	ETHTOOL_A_FEC_STATS_CLEAR,
 
 	__ETHTOOL_A_FEC_CNT,
 	ETHTOOL_A_FEC_MAX = (__ETHTOOL_A_FEC_CNT - 1)
diff --git a/net/ethtool/fec.c b/net/ethtool/fec.c
index e2d539271060..edfa535477cb 100644
--- a/net/ethtool/fec.c
+++ b/net/ethtool/fec.c
@@ -290,10 +290,11 @@ static int fec_fill_reply(struct sk_buff *skb,
 
 /* FEC_SET */
 
-const struct nla_policy ethnl_fec_set_policy[ETHTOOL_A_FEC_AUTO + 1] = {
+const struct nla_policy ethnl_fec_set_policy[ETHTOOL_A_FEC_MAX + 1] = {
 	[ETHTOOL_A_FEC_HEADER]	= NLA_POLICY_NESTED(ethnl_header_policy),
 	[ETHTOOL_A_FEC_MODES]	= { .type = NLA_NESTED },
 	[ETHTOOL_A_FEC_AUTO]	= NLA_POLICY_MAX(NLA_U8, 1),
+	[ETHTOOL_A_FEC_STATS_CLEAR] = NLA_POLICY_MAX(NLA_U8, 1),
 };
 
 static int
@@ -315,6 +316,14 @@ ethnl_set_fec(struct ethnl_req_info *req_info, struct genl_info *info)
 	u8 fec_auto;
 	int ret;
 
+	if (tb[ETHTOOL_A_FEC_STATS_CLEAR]) {
+		if (!dev->ethtool_ops->clear_fec_stats)
+			return -EOPNOTSUPP;
+
+		ret = dev->ethtool_ops->clear_fec_stats(dev);
+		return ret < 0 ? ret : 1;
+	}
+
 	ret = dev->ethtool_ops->get_fecparam(dev, &fec);
 	if (ret < 0)
 		return ret;
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 3e969a070f9f..2a2096066b7d 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -508,7 +508,7 @@ extern const struct nla_policy ethnl_cable_test_act_policy[ETHTOOL_A_CABLE_TEST_
 extern const struct nla_policy ethnl_cable_test_tdr_act_policy[ETHTOOL_A_CABLE_TEST_TDR_CFG + 1];
 extern const struct nla_policy ethnl_tunnel_info_get_policy[ETHTOOL_A_TUNNEL_INFO_HEADER + 1];
 extern const struct nla_policy ethnl_fec_get_policy[ETHTOOL_A_FEC_HEADER + 1];
-extern const struct nla_policy ethnl_fec_set_policy[ETHTOOL_A_FEC_AUTO + 1];
+extern const struct nla_policy ethnl_fec_set_policy[ETHTOOL_A_FEC_MAX + 1];
 extern const struct nla_policy ethnl_module_eeprom_get_policy[ETHTOOL_A_MODULE_EEPROM_I2C_ADDRESS + 1];
 extern const struct nla_policy ethnl_stats_get_policy[ETHTOOL_A_STATS_SRC + 1];
 extern const struct nla_policy ethnl_phc_vclocks_get_policy[ETHTOOL_A_PHC_VCLOCKS_HEADER + 1];
-- 
2.43.0

