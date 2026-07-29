Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB62418A43;
	Wed, 29 Jul 2026 20:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785357921; cv=none; b=TImgJ5EAmPHWkf7HCTT0RooMXDL6tDPZuzbMnT5N1o9VJ69rb2rCci4h1wfcH5eDuFWrcIr5CRLtuPPItM21ppPPcz9zGLpwOM0VQK580AkwPDhtqo40FUyTbBJPb3rqiX5Ok75oWGfiigJoNWnd2EuTXzZ+ZzUFYOIXx/PB5lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785357921; c=relaxed/simple;
	bh=p9D6ADmgnvp/zXthJ9yl8W8NNzi9AVUjf3jxkNykmZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FV2OKBY2j9347IaqJKKxnZSC1bTry6BwO1Uq23e67VgtinsShs2IvYT+rhlyoXQHNcZfvw1285pz4jn2X0v7Wq/5eM778yF4t4Me/i7OrijC/GYHHI9/z4Q2jSHRvB+0dgZtMT0w/0mrnEHQXKZkwu7N8RmdKnMKgyqY1lG6hiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aS+1HUsZ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aS+1HUsZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785357915; x=1816893915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p9D6ADmgnvp/zXthJ9yl8W8NNzi9AVUjf3jxkNykmZE=;
  b=aS+1HUsZs061dph5iU5EGl06/nHe5IXFGHbHZyasSVVDF5/Sk2G4EvLk
   nn9yWxY4Cl/J62fAkLYk4wteShk6/3gXuW07p1+hmeYcDnihS9rtcofLb
   g1vWCoW9cvaQJ/sN5xQM24HRuok379HlYtPHcEcL3HWD9T71Aw30KRb2/
   Pt7YS7hloKLCTvUSqlThKfIInLh8cHxZl3f0cOyN5NO8tmI99sQ6lC3Kx
   qXvmgCsIxKBA3z9dDD1Hw1oXm0JMwexwJv0y146hK6QiX30hUhTgPb9x/
   KE+Tr7ZBm49ZZ7KPllAzoteZJwfNxYjMSijU5TXYhepQfQHIq/WovQbS9
   g==;
X-CSE-ConnectionGUID: /zqL5LpKRbK+K7ZeCG0zbg==
X-CSE-MsgGUID: TEIsU7lrR+KW8DfHGw3ufQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="84952359"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="84952359"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 13:45:08 -0700
X-CSE-ConnectionGUID: 6+xt6gNLTVyjzTaINX94zg==
X-CSE-MsgGUID: H2iNHBwOSkWTK4u9Fh47kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="264381326"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 29 Jul 2026 13:45:08 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Victor Raj <anthony.l.nguyen@intel.com>,
	larysa.zaremba@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	sridhar.samudrala@intel.com,
	michal.swiatkowski@linux.intel.com,
	maciej.fijalkowski@intel.com,
	emil.s.tantilov@intel.com,
	madhu.chittim@intel.com,
	joshua.a.hay@intel.com,
	jacob.e.keller@intel.com,
	jayaprakash.shanmugam@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	corbet@lwn.net,
	richardcochran@gmail.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next v6 01/15] virtchnl: move virtchnl and virtchnl2 headers to 'include/linux/net/intel'
Date: Wed, 29 Jul 2026 13:44:48 -0700
Message-ID: <20260729204505.3373950-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260729204505.3373950-1-anthony.l.nguyen@intel.com>
References: <20260729204505.3373950-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Raj <victor.raj@intel.com>

virtchnl2 headers will be used by both idpf and ixd drivers, so they have
to be moved to an include directory. On top of that, it would be useful to
place all iavf headers together with other intel networking headers.

Move abovementioned intel header files into 'include/linux/net/intel'.

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Victor Raj <victor.raj@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 MAINTAINERS                                                   | 3 +--
 drivers/net/ethernet/intel/i40e/i40e.h                        | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c                 | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_prototype.h              | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h            | 2 +-
 drivers/net/ethernet/intel/iavf/iavf.h                        | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_common.c                 | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_prototype.h              | 3 ++-
 drivers/net/ethernet/intel/iavf/iavf_types.h                  | 4 +---
 drivers/net/ethernet/intel/ice/ice.h                          | 2 +-
 drivers/net/ethernet/intel/ice/ice_common.h                   | 2 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h                   | 2 +-
 drivers/net/ethernet/intel/ice/virt/virtchnl.h                | 2 +-
 drivers/net/ethernet/intel/idpf/idpf.h                        | 2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h                   | 2 +-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.h               | 2 +-
 include/linux/{avf => net/intel}/virtchnl.h                   | 0
 .../intel/idpf => include/linux/net/intel}/virtchnl2.h        | 0
 .../idpf => include/linux/net/intel}/virtchnl2_lan_desc.h     | 0
 19 files changed, 17 insertions(+), 19 deletions(-)
 rename include/linux/{avf => net/intel}/virtchnl.h (100%)
 rename {drivers/net/ethernet/intel/idpf => include/linux/net/intel}/virtchnl2.h (100%)
 rename {drivers/net/ethernet/intel/idpf => include/linux/net/intel}/virtchnl2_lan_desc.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2d420d40782e..e6b857ff992a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13039,8 +13039,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
 F:	Documentation/networking/device_drivers/ethernet/intel/
 F:	drivers/net/ethernet/intel/
 F:	drivers/net/ethernet/intel/*/
-F:	include/linux/avf/virtchnl.h
-F:	include/linux/net/intel/*/
+F:	include/linux/net/intel/
 
 INTEL ETHERNET PROTOCOL DRIVER FOR RDMA
 M:	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 83e780919ac9..1b6a8fbaa648 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -8,8 +8,8 @@
 #include <linux/pci.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/types.h>
-#include <linux/avf/virtchnl.h>
 #include <linux/net/intel/i40e_client.h>
+#include <linux/net/intel/virtchnl.h>
 #include <net/devlink.h>
 #include <net/pkt_cls.h>
 #include <net/udp_tunnel.h>
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 59f5c1e810eb..8dadfef2c09f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1,10 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2021 Intel Corporation. */
 
-#include <linux/avf/virtchnl.h>
 #include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/etherdevice.h>
+#include <linux/net/intel/virtchnl.h>
 #include <linux/pci.h>
 #include "i40e_adminq_cmd.h"
 #include "i40e_devids.h"
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index 26bb7bffe361..e3d57550090e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -5,7 +5,7 @@
 #define _I40E_PROTOTYPE_H_
 
 #include <linux/ethtool.h>
-#include <linux/avf/virtchnl.h>
+#include <linux/net/intel/virtchnl.h>
 #include "i40e_debug.h"
 #include "i40e_type.h"
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index f558b45725c8..4e119c0502f3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -4,7 +4,7 @@
 #ifndef _I40E_VIRTCHNL_PF_H_
 #define _I40E_VIRTCHNL_PF_H_
 
-#include <linux/avf/virtchnl.h>
+#include <linux/net/intel/virtchnl.h>
 #include <linux/netdevice.h>
 #include "i40e_type.h"
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 050f8241ef5e..dc31202b2a94 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -27,6 +27,7 @@
 #include <linux/etherdevice.h>
 #include <linux/socket.h>
 #include <linux/jiffies.h>
+#include <linux/net/intel/virtchnl.h>
 #include <net/ip6_checksum.h>
 #include <net/pkt_cls.h>
 #include <net/pkt_sched.h>
@@ -37,7 +38,6 @@
 #include <net/net_shaper.h>
 
 #include "iavf_type.h"
-#include <linux/avf/virtchnl.h>
 #include "iavf_txrx.h"
 #include "iavf_fdir.h"
 #include "iavf_adv_rss.h"
diff --git a/drivers/net/ethernet/intel/iavf/iavf_common.c b/drivers/net/ethernet/intel/iavf/iavf_common.c
index 614a886bca99..277193a97d91 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_common.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_common.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
-#include <linux/avf/virtchnl.h>
+#include <linux/net/intel/virtchnl.h>
 #include <linux/bitfield.h>
 #include "iavf_type.h"
 #include "iavf_adminq.h"
diff --git a/drivers/net/ethernet/intel/iavf/iavf_prototype.h b/drivers/net/ethernet/intel/iavf/iavf_prototype.h
index 7f9f9dbf959a..1b1f6ede3920 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_prototype.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_prototype.h
@@ -4,9 +4,10 @@
 #ifndef _IAVF_PROTOTYPE_H_
 #define _IAVF_PROTOTYPE_H_
 
+#include <linux/net/intel/virtchnl.h>
+
 #include "iavf_type.h"
 #include "iavf_alloc.h"
-#include <linux/avf/virtchnl.h>
 
 /* Prototypes for shared code functions that are not in
  * the standard function pointer structures.  These are
diff --git a/drivers/net/ethernet/intel/iavf/iavf_types.h b/drivers/net/ethernet/intel/iavf/iavf_types.h
index a095855122bf..35d6d8fcca04 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_types.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_types.h
@@ -4,9 +4,7 @@
 #ifndef _IAVF_TYPES_H_
 #define _IAVF_TYPES_H_
 
-#include "iavf_types.h"
-
-#include <linux/avf/virtchnl.h>
+#include <linux/net/intel/virtchnl.h>
 #include <linux/ptp_clock_kernel.h>
 
 /* structure used to queue PTP commands for processing */
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index fc91b6665f90..db3c7015c56c 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -36,7 +36,7 @@
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/auxiliary_bus.h>
-#include <linux/avf/virtchnl.h>
+#include <linux/net/intel/virtchnl.h>
 #include <linux/cpu_rmap.h>
 #include <linux/dim.h>
 #include <linux/gnss.h>
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 9f5344212195..d1d674ca644f 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -5,13 +5,13 @@
 #define _ICE_COMMON_H_
 
 #include <linux/bitfield.h>
+#include <linux/net/intel/virtchnl.h>
 
 #include "ice.h"
 #include "ice_type.h"
 #include "ice_nvm.h"
 #include "ice_flex_pipe.h"
 #include "ice_parser.h"
-#include <linux/avf/virtchnl.h>
 #include "ice_switch.h"
 #include "ice_fdir.h"
 
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index 7a9c75d1d07c..fa436b3b1eac 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -8,9 +8,9 @@
 #include <linux/hashtable.h>
 #include <linux/bitmap.h>
 #include <linux/mutex.h>
+#include <linux/net/intel/virtchnl.h>
 #include <linux/pci.h>
 #include <net/devlink.h>
-#include <linux/avf/virtchnl.h>
 #include "ice_type.h"
 #include "ice_flow.h"
 #include "virt/fdir.h"
diff --git a/drivers/net/ethernet/intel/ice/virt/virtchnl.h b/drivers/net/ethernet/intel/ice/virt/virtchnl.h
index 71bb456e2d71..d11789b3ae1f 100644
--- a/drivers/net/ethernet/intel/ice/virt/virtchnl.h
+++ b/drivers/net/ethernet/intel/ice/virt/virtchnl.h
@@ -7,7 +7,7 @@
 #include <linux/types.h>
 #include <linux/bitops.h>
 #include <linux/if_ether.h>
-#include <linux/avf/virtchnl.h>
+#include <linux/net/intel/virtchnl.h>
 #include "ice_vf_lib.h"
 
 /* Restrict number of MAC Addr and VLAN that non-trusted VF can programmed */
diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index ec1b75f039bb..984944bab28b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -23,8 +23,8 @@ struct idpf_rss_data;
 
 #include <linux/net/intel/iidc_rdma.h>
 #include <linux/net/intel/iidc_rdma_idpf.h>
+#include <linux/net/intel/virtchnl2.h>
 
-#include "virtchnl2.h"
 #include "idpf_txrx.h"
 #include "idpf_controlq.h"
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 4be5b3b6d3ed..08b048664029 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -5,6 +5,7 @@
 #define _IDPF_TXRX_H_
 
 #include <linux/dim.h>
+#include <linux/net/intel/virtchnl2_lan_desc.h>
 
 #include <net/libeth/cache.h>
 #include <net/libeth/types.h>
@@ -13,7 +14,6 @@
 #include <net/xdp.h>
 
 #include "idpf_lan_txrx.h"
-#include "virtchnl2_lan_desc.h"
 
 #define IDPF_LARGE_MAX_Q			256
 #define IDPF_MAX_Q				16
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index 6876e3ed9d1b..972dd88cf3d2 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -4,7 +4,7 @@
 #ifndef _IDPF_VIRTCHNL_H_
 #define _IDPF_VIRTCHNL_H_
 
-#include "virtchnl2.h"
+#include <linux/net/intel/virtchnl2.h>
 
 #define IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC	(60 * 1000)
 #define IDPF_VC_XN_IDX_M		GENMASK(7, 0)
diff --git a/include/linux/avf/virtchnl.h b/include/linux/net/intel/virtchnl.h
similarity index 100%
rename from include/linux/avf/virtchnl.h
rename to include/linux/net/intel/virtchnl.h
diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/include/linux/net/intel/virtchnl2.h
similarity index 100%
rename from drivers/net/ethernet/intel/idpf/virtchnl2.h
rename to include/linux/net/intel/virtchnl2.h
diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2_lan_desc.h b/include/linux/net/intel/virtchnl2_lan_desc.h
similarity index 100%
rename from drivers/net/ethernet/intel/idpf/virtchnl2_lan_desc.h
rename to include/linux/net/intel/virtchnl2_lan_desc.h
-- 
2.47.1

