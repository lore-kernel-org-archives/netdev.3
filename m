Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDED02D2486;
	Thu, 15 Oct 2026 23:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108572; cv=none; b=Z2Kpso1RJNWp6exkoPaebXF9xC44psSV1xNMsHeEWWKwPGd2rQRXbR9sgCGU8OTNSV+Ku0w4zstZOfq9h9uuMzutfIi/m+gc/OZamDMVkxEFH2eb6vFaixFWxTdRCsDKh3y++Gb1rpHs2AAavP1fU8oPyRGK5Uc/6mB8RFV+NMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108572; c=relaxed/simple;
	bh=Y6xOJ/FZEZ60ZTLOfQSx9qKWhcVEugt1+98XMLwr7ds=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJ4xKL0SksTprAaK6hzICqKEo6Weiw3ToEV1UPGy430JDx40ZjRBV+u80KH1Xop2VhjshG+A5wThbNXW2mUhFeGSzS3ma3AbNDDRwjsgmLrFKS0NzGsBMp1tXV6ANlEmaSooX0C5nqzKTvTXtbd8MJ8FMpzssELl7BqEMCbDoR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=YkaYyoxq; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="YkaYyoxq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1792108571; x=1823644571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QzzUznMlKtudOmhH+teEEF+wX5F+Oj/gbu0fYozZlpk=;
  b=YkaYyoxqSMiPCosYZAvVmTZN80EYa81Gomy70bbqs/JEFtrlqgWqYxj0
   sktNRD4PZrnJnImCCtYT5cv2SifX8iCm357SqgBlJC/zprIbZrRjBDomm
   ukZ/038t/PhiDc1iClALrX4Mzname8zsJRZFX6Aa8M7ru3zmRaK0/7rZf
   OfUSu7m79VEsISvPeZE8HNIcq863+Tv3ePlXjbsZD6/CMRbCztuvJroCJ
   6NvL+h5VHwl1634PmveQrzcuocSNKJdFt88VD2KT0y6GVs+wc94AMYf3S
   T1UoFpgTFk2KXfajk7vBNbMnZUUq+AYCYWqY6vaHLTHkVBPH8Kx3ALgs8
   g==;
X-CSE-ConnectionGUID: lOQoElyMQXSAH+FiEwH4yQ==
X-CSE-MsgGUID: DM1OUUb4ScaG9WgxTsDtLg==
X-IronPort-AV: E=Sophos;i="6.27,160,1787011200"; 
   d="scan'208";a="31427771"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 23:56:11 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:28890]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.190:2525] with esmtp (Farcaster)
 id bf50fe36-5e22-4823-9b78-2097d7834e2a; Thu, 15 Oct 2026 23:56:11 +0000 (UTC)
X-Farcaster-Flow-ID: bf50fe36-5e22-4823-9b78-2097d7834e2a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 15 Oct 2026 23:56:10 +0000
Received: from dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com
 (172.19.55.127) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53; Thu, 15 Oct 2026
 23:56:10 +0000
From: David Keogh <dkeogh@amazon.com>
To: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, Nimrod Oren <noren@nvidia.com>,
	<nh-open-source@amazon.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC net-next 4/6] selftests: net: add tx_extra_headroom test
Date: Thu, 15 Oct 2026 23:53:33 +0000
Message-ID: <20261015235335.4162993-5-dkeogh@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261015235335.4162993-1-dkeogh@amazon.com>
References: <20261015235335.4162993-1-dkeogh@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Exercise the IFLA_TX_EXTRA_HEADROOM attribute through YNL: the default
of zero, setting values up to the maximum and back to zero, rejection
of a value above the maximum, supplying the attribute at link creation,
the change notification, persistence across link down/up and across a
network namespace move, and that a VLAN created on top of a configured
device does not inherit the setting.

Signed-off-by: David Keogh <dkeogh@amazon.com>
---
 tools/testing/selftests/net/Makefile          |   1 +
 .../selftests/net/tx_extra_headroom.py        | 137 ++++++++++++++++++
 2 files changed, 138 insertions(+)
 create mode 100755 tools/testing/selftests/net/tx_extra_headroom.py

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 54beea2e3..0eb9a69e9 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -120,6 +120,7 @@ TEST_PROGS := \
 	test_vxlan_vnifiltering.sh \
 	tfo_passive.sh \
 	traceroute.sh \
+	tx_extra_headroom.py \
 	txtimestamp.sh \
 	udpgro.sh \
 	udpgro_bench.sh \
diff --git a/tools/testing/selftests/net/tx_extra_headroom.py b/tools/testing/selftests/net/tx_extra_headroom.py
new file mode 100755
index 000000000..f6f087e98
--- /dev/null
+++ b/tools/testing/selftests/net/tx_extra_headroom.py
@@ -0,0 +1,137 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""Tests for the IFLA_TX_EXTRA_HEADROOM link attribute."""
+
+from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_raises, ksft_true
+from lib.py import ip
+from lib.py import NetNS, NetNSEnter
+from lib.py import Netlink, NlError, RtnlFamily
+
+ATTR = "tx-extra-headroom"
+MAX = 512
+
+
+def ifindex(name):
+    return ip(f"link show dev {name}", json=True)[0]["ifindex"]
+
+
+def get(rtnl, idx):
+    return rtnl.getlink({"ifi-index": idx})[ATTR]
+
+
+def set_(rtnl, idx, val):
+    rtnl.setlink({"ifi-index": idx, ATTR: val})
+
+
+def test_default_and_set() -> None:
+    """Default is 0, values up to the maximum are accepted, 0 resets."""
+    with NetNS() as ns, NetNSEnter(str(ns)):
+        ip("link add d0 type dummy")
+        rtnl = RtnlFamily()
+        idx = ifindex("d0")
+
+        ksft_eq(get(rtnl, idx), 0)
+        for val in (1, 256, MAX):
+            set_(rtnl, idx, val)
+            ksft_eq(get(rtnl, idx), val)
+        set_(rtnl, idx, 0)
+        ksft_eq(get(rtnl, idx), 0)
+
+
+def test_reject_above_max() -> None:
+    """Values above the maximum are rejected by the policy."""
+    with NetNS() as ns, NetNSEnter(str(ns)):
+        ip("link add d0 type dummy")
+        rtnl = RtnlFamily()
+        idx = ifindex("d0")
+
+        set_(rtnl, idx, 128)
+        with ksft_raises(NlError):
+            set_(rtnl, idx, MAX + 1)
+        ksft_eq(get(rtnl, idx), 128)
+
+
+def test_newlink() -> None:
+    """The attribute can be supplied when the link is created."""
+    with NetNS() as ns, NetNSEnter(str(ns)):
+        rtnl = RtnlFamily()
+        rtnl.newlink({"ifname": "d0", "linkinfo": {"kind": "dummy"},
+                      ATTR: 64},
+                     flags=[Netlink.NLM_F_CREATE, Netlink.NLM_F_EXCL])
+        ksft_eq(get(rtnl, ifindex("d0")), 64)
+
+
+def test_notification() -> None:
+    """A change produces a link notification carrying the new value."""
+    with NetNS() as ns, NetNSEnter(str(ns)):
+        ip("link add d0 type dummy")
+        ip("link set dev d0 up")
+        rtnl = RtnlFamily()
+        idx = ifindex("d0")
+
+        rtnl.ntf_subscribe("rtnlgrp-link")
+        set_(rtnl, idx, 192)
+
+        seen = None
+        for msg in rtnl.poll_ntf(duration=1):
+            if msg["name"] == "getlink" and msg["msg"]["ifi-index"] == idx:
+                seen = msg["msg"][ATTR]
+                break
+        ksft_eq(seen, 192)
+
+
+def test_survives_down_up() -> None:
+    """Toggling the link does not reset the value."""
+    with NetNS() as ns, NetNSEnter(str(ns)):
+        ip("link add d0 type dummy")
+        rtnl = RtnlFamily()
+        idx = ifindex("d0")
+
+        set_(rtnl, idx, 96)
+        ip("link set dev d0 up")
+        ksft_eq(get(rtnl, idx), 96)
+        ip("link set dev d0 down")
+        ksft_eq(get(rtnl, idx), 96)
+
+
+def test_survives_netns_move() -> None:
+    """Moving the link to another namespace keeps the value."""
+    with NetNS() as ns1, NetNS() as ns2:
+        with NetNSEnter(str(ns1)):
+            ip("link add d0 type dummy")
+            rtnl = RtnlFamily()
+            set_(rtnl, ifindex("d0"), 160)
+            ip(f"link set dev d0 netns {ns2}")
+
+        with NetNSEnter(str(ns2)):
+            rtnl = RtnlFamily()
+            ksft_eq(get(rtnl, ifindex("d0")), 160)
+
+
+def test_not_inherited() -> None:
+    """Stacked devices do not inherit the value of the device below."""
+    with NetNS() as ns, NetNSEnter(str(ns)):
+        ip("link add d0 type dummy")
+        rtnl = RtnlFamily()
+        set_(rtnl, ifindex("d0"), 224)
+
+        ip("link add link d0 name d0.10 type vlan id 10")
+        ksft_eq(get(rtnl, ifindex("d0.10")), 0)
+        ksft_true(rtnl.getlink({"ifi-index": ifindex("d0.10")})["headroom"]
+                  >= 4, "vlan needed_headroom")
+
+
+def main() -> None:
+    ksft_run([test_default_and_set,
+              test_reject_above_max,
+              test_newlink,
+              test_notification,
+              test_survives_down_up,
+              test_survives_netns_move,
+              test_not_inherited])
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.50.1

