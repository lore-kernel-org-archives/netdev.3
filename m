Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB273583AC2
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 22:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202954; cv=none; b=D0ibTrVXr+iMbiBpX+dDLQJqkwhHRFcBxw4/iwFB4KGneDEU4xdgXztWJBb6/JvEWUeJGdGJ7FGD8PWCC7CtGaxx3DQ28p2EdIfO4lXSuo1hqaNkKRCKqRSA4/yCi4NBmCxxK0mkt8/Bhpog5m9FqjvvPvvlmMdMSRfhY94nedo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202954; c=relaxed/simple;
	bh=3VwlLHtYwGGDue9ADUKvt5+5UN3Ot0fOe4PaJFjnSGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxgmR4iBxvjGIRyAQULwEJvYRcELlJRi83sthR6QsdtlmChcsI+c+oSj/I0wNaHRZXNmIFdcASgHwthmT//0Kbvf9EvVaVG2zX1iIZac+1OQoHTM9rH+C/+sdIbdIhVsjglaNW73zaUd4VETto+VRuM2ore4PxXDYH8t5nol7Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pfdws4U6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pfdws4U6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C151F00A08;
	Wed, 23 Sep 2026 22:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790202950;
	bh=JlgVoZISP2w4DAHIYhp7TqRfbXkloMUd8Zyzs2W0USA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pfdws4U6e7Wo4YbBaVjWH+1PekEB+AkvctoSFp5MFcMi4M0YDH9C7NJKoc/DtDj+/
	 JKxTl2V7rPlWift+LTNVe45tX/FnGgWoaC3In8yGl3vpGM98EbsnUluc4Be7MPKXpL
	 4NLSavvkk42JQiA9eBvYfP+YmQI74MGS/DaeM9wgAfEQj71NTzjTW2XZgY7xNV5uWG
	 /KKCkbkwiwMw5lDzrjEo8WBZvtvAL3T4sFUt1X36ZWRg7UTxalylercPx58kWpqFKT
	 mKoqjZGXZoqvdqtePOiFB6CgYx7zBz7t0u6AgClMJrWlEfN7EZ+N4hdtCp24zPvqCY
	 wXSf4pcYBKuKA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/2] selftests: net: add test for netdev instance lock ordering on unregister
Date: Wed, 23 Sep 2026 15:35:45 -0700
Message-ID: <20260923223545.3815583-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923223545.3815583-1-kuba@kernel.org>
References: <20260923223545.3815583-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dismantle two netns holding a dummy and a netkit pair registered in
opposite order. unregister_netdevice_many_notify() takes the instance
locks of all the devices at once, nesting the two kinds of devices one
way for the first netns and the other way for the second. With lockdep
enabled this used to trigger a circular locking report.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/Makefile       |  1 +
 tools/testing/selftests/net/netdev_lock.py | 42 ++++++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100755 tools/testing/selftests/net/netdev_lock.py

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 3ee3378f8b26..d4ca82fec0b4 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -67,6 +67,7 @@ TEST_PROGS := \
 	nat6to4.sh \
 	ndisc_unsolicited_na_test.sh \
 	netdev-l2addr.sh \
+	netdev_lock.py \
 	netdevice.sh \
 	netns-name.sh \
 	netns-sysctl.sh \
diff --git a/tools/testing/selftests/net/netdev_lock.py b/tools/testing/selftests/net/netdev_lock.py
new file mode 100755
index 000000000000..0015b987eb9d
--- /dev/null
+++ b/tools/testing/selftests/net/netdev_lock.py
@@ -0,0 +1,42 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""Tests for the netdev instance lock."""
+
+from lib.py import ksft_run, ksft_exit
+from lib.py import ip
+from lib.py import NetNS
+
+
+def test_unreg_order() -> None:
+    """Dismantle two netns holding the same two kinds of ops locked device,
+    registered in opposite order.
+
+    unregister_netdevice_many_notify() takes the instance lock of every
+    device in the batch and holds them all at once, so the two kinds end up
+    nested one way round for the first netns and the other way round for
+    the second.
+    """
+    with NetNS() as ns1, NetNS() as ns2:
+        net1, net2 = str(ns1), str(ns2)
+
+        ip("link add du0 type dummy", ns=net1)
+        ip("link add nk0 type netkit peer name nk1", ns=net1)
+
+        ip("link add nk0 type netkit peer name nk1", ns=net2)
+        ip("link add du0 type dummy", ns=net2)
+
+        # only devices which are up get locked during unregister
+        for net in (net1, net2):
+            for dev in ("du0", "nk0", "nk1"):
+                ip(f"link set {dev} up", ns=net)
+
+
+def main() -> None:
+    """Ksft boilerplate main."""
+    ksft_run([test_unreg_order])
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.55.0

