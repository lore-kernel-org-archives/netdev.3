Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5A117C211
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 01:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786757212; cv=none; b=WqfsayhfJ2yILUiXis3jgg10jS4m8qjwKn3RmTMkW28IXvEze/y22gZ8yRJWbhlxgRetV/CWZPmWW6oMyGyEtcnzxkYi96rdozXxDudb8n28DnZA5GYT1hkIS7mzRK63ZcapuKlQpxIoXoJNZv6fsXdVaMxaLOTvtxEQP4iRuAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786757212; c=relaxed/simple;
	bh=YpwQUnVulG9JPuLMVdRLJcAsL52MULHCbieWy635i+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Db0LsLYsos5XzeHFj3fMlRITe6AGgGZNwAu3FvN++vZZCdnuez4kTCz17QaL+I3CCvqeoEz2uZZLNMLI4sKplqIx8iIFL3aoW8vn/3N1W4KkwJHcKhyzM5C1FBCAot5P/ZTbiWHB9dpooLWuPjhdweXvfdui9Wxd7nEGAZRYWFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g02itqCG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g02itqCG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786757210; x=1818293210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YpwQUnVulG9JPuLMVdRLJcAsL52MULHCbieWy635i+E=;
  b=g02itqCGteKvHUC3Kz7DwO4RXslZtBTicToO/AKRzmIzCeEhk6aqPyMB
   nWifFDsdXLaNKSWr+2oER0ZOQvjvGseR/ORJviy3z/T10qVQELRmHexkz
   AZJWY7ZUrT95z61Ysq/2DhE+g0w8xN+/dIvEMaclSh/si8YLRrtODn8KA
   1yt4X2CaWUifIdm9KouxJigZGiLE9RLdYzTvM5sgnSuLVlBzPgcrFE9zm
   WuR5y8zlZ9sYnj7SenXcuKRmdfPO/9SRDuNGD0hfzfopqhqXwe+sWE+oT
   whL+DVgh+HWaJBTHno6M5MHJ3+9YANCeNtdYu64LNxE0/6F14GOHrnzUU
   w==;
X-CSE-ConnectionGUID: XntJoBwSSXOUV0z/0QXwtg==
X-CSE-MsgGUID: yZ6pN2WXQ8+wK5x3XD5Gtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="87194397"
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="87194397"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 18:26:50 -0700
X-CSE-ConnectionGUID: kngVLNCwSeSMPGzIZqsrdw==
X-CSE-MsgGUID: z3gaX29YQhC+dN/q9xJ2sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="287844776"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.5.147])
  by fmviesa002.fm.intel.com with ESMTP; 14 Aug 2026 18:26:50 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next 3/3] selftests: net: hw: add devlink info test
Date: Fri, 14 Aug 2026 13:49:19 -0400
Message-ID: <20260814174919.4177289-4-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260814174919.4177289-1-paul.greenwalt@intel.com>
References: <20260814174919.4177289-1-paul.greenwalt@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest that verifies drivers properly report device information
through the devlink info interface. This test validates:

  - devlink dev info command succeeds
  - driver name is reported and matches ethtool output
  - at least one version or serial_number is reported

The output format matches what NIPA CI uses for device regression
tracking, helping maintainers identify pass/fail status changes due
to FW updates.

Example usage:

  sudo NETIF=eth0 ./tools/testing/selftests/drivers/net/hw/devlink_info.sh

  INFO: driver: idpf
  INFO: serial_number: 00-a0-c9-ff-ff-23-45-67
  TEST: devlink info                                                  [ OK ]

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Link: https://github.com/linux-netdev/nipa/wiki/Netdev-CI-system#device-information
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../selftests/drivers/net/hw/devlink_info.sh  | 119 ++++++++++++++++++
 2 files changed, 120 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/devlink_info.sh

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 78bb0169350b..edd353f27a39 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -19,6 +19,7 @@ TEST_GEN_FILES := \
 
 TEST_PROGS = \
 	csum.py \
+	devlink_info.sh \
 	devlink_rate_cross_esw.py \
 	devlink_rate_tc_bw.py \
 	devmem.py \
diff --git a/tools/testing/selftests/drivers/net/hw/devlink_info.sh b/tools/testing/selftests/drivers/net/hw/devlink_info.sh
new file mode 100755
index 000000000000..b2ee880590c4
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/devlink_info.sh
@@ -0,0 +1,119 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test devlink info support
+#
+# This test verifies that the driver properly reports device information
+# through the devlink info interface. The output format matches what
+# NIPA CI uses for regression tracking (see Device information section
+# at https://github.com/linux-netdev/nipa/wiki/Netdev-CI-system).
+#
+# Validates:
+#   - devlink dev info command succeeds
+#   - driver name is reported and matches ethtool
+#   - at least one version or serial_number is reported
+#   - serial_number is logged if present
+#
+# Usage:
+#   NETIF=eth0 ./devlink_info.sh
+
+lib_dir=$(dirname "$0")/../../../net
+
+ALL_TESTS="devlink_info_test"
+source "$lib_dir"/lib.sh
+
+require_command devlink
+require_command jq
+require_command ethtool
+
+DL_HANDLE=""
+
+setup_prepare()
+{
+	# Try to get devlink handle from devlink port first
+	DL_HANDLE=$(devlink -j port show 2>/dev/null |
+		jq -r --arg netif "$NETIF" \
+			'.port | to_entries[] |
+			 select(.value.netdev == $netif) | .key' 2>/dev/null |
+		cut -d/ -f1-2)
+
+	# Fallback: get PCI address from ethtool and check if devlink device exists
+	if [ -z "$DL_HANDLE" ]; then
+		local bus_info
+		bus_info=$(ethtool -i "$NETIF" 2>/dev/null | awk '/^bus-info:/ {print $2}')
+		if [ -n "$bus_info" ]; then
+			DL_HANDLE="pci/$bus_info"
+			# Verify this devlink device exists
+			if ! devlink dev show "$DL_HANDLE" &>/dev/null; then
+				DL_HANDLE=""
+			fi
+		fi
+	fi
+
+	if [ -z "$DL_HANDLE" ]; then
+		echo "SKIP: Could not find devlink handle for $NETIF"
+		exit $ksft_skip
+	fi
+}
+
+info_get()
+{
+	local name
+
+	name=$1
+	cmd_jq "devlink dev info $DL_HANDLE -j" ".[][][\"$name\"]" "-e"
+}
+
+has_any_version()
+{
+	local info
+	info=$(devlink -j dev info $DL_HANDLE)
+
+	# Check if any version category exists and has at least one entry
+	echo "$info" | jq -e '.[][].versions | length > 0' > /dev/null 2>&1
+}
+
+devlink_info_test()
+{
+	RET=0
+
+	# Test devlink info command succeeds
+	devlink dev info $DL_HANDLE > /dev/null
+	check_err $? "devlink dev info failed for $DL_HANDLE"
+
+	# Test driver name is reported
+	local driver
+	driver=$(info_get "driver")
+	check_err $? "Failed to get driver name"
+
+	# Verify driver matches ethtool output
+	local expected_driver
+	expected_driver=$(ethtool -i "$NETIF" | awk '/^driver:/ {print $2}')
+	check_err $? "Failed to get driver from ethtool"
+	if [ -z "$expected_driver" ]; then
+		check_err 1 "Failed to get driver from ethtool"
+	fi
+	if [ "$driver" != "$expected_driver" ]; then
+		check_err 1 "Driver mismatch: devlink='$driver' ethtool='$expected_driver'"
+	else
+		log_info "driver: $driver"
+	fi
+
+	# Test at least one version OR serial_number is reported (needed for device tracking)
+	local serial
+	serial=$(info_get "serial_number" 2>/dev/null)
+	if [ -n "$serial" ]; then
+		log_info "serial_number: $serial"
+	fi
+
+	if ! has_any_version && [ -z "$serial" ]; then
+		check_err 1 "No versions or serial_number reported"
+	fi
+
+	log_test "devlink info"
+}
+
+setup_prepare
+tests_run
+
+exit $EXIT_STATUS
-- 
2.52.0

