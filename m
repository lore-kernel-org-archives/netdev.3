Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9931C331EBA
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 04:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790396317; cv=none; b=WR1np1r8zOQXq39NPQU+hYEJpK5P68rH3P0mfHlgfr99wwje6AYwtmLyTAI1hDhxTGyjxIm91vT2+PpBSasr/btfV2bq+w3KEetFgKRS1XZ/nA2/Rzr8zDXal/AJSQW2pmhUGjGzfPEEW4qB9zzaniep1vkjtT0vwnTtH+OwDME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790396317; c=relaxed/simple;
	bh=MZfs4nEXdeDqMxE38XXWHbicj5wwFmjoRarpVvF3pPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uG/0E+IJYs7M98aqKw8sPuwEgRcNaa/kNqkxXmgszmhmWObS7xu336o3XnGo0P6yKbieSt9RuWfPAYQZaHHlaHiUprHvOSRiFiCr+LFDzjrJv+JEEhbDYt12bNidHv0OfyIAeib7KrqwCE4Fw++aTdFX94BdcuK5qXIU5V6lD8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4JqDvXf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4JqDvXf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446661F00899;
	Sat, 26 Sep 2026 04:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790396315;
	bh=ZBxgb9dmNUbf8TNnDurS62ON8qhkXQCIs58csoVRdFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W4JqDvXfNjSDL/TFkiR50++uYr71EXrBywbk0P0+auw/TJlgQ4TMqG0eF0MB/Dsp1
	 TY3aiOGIC1uzc3Ww8Qr5nKaKDvvc/B0f0IJ6WIGxZcrIddtpQlKKwxwSupJa335B1s
	 Cv3DlwDrqX+tMPvwLXaE9pHKXjY887+BFWNyqXoHHl0qbVF9/M57GIj0+EpSgUbwAS
	 REsGzerp0R2pex+Td1Ck6pTrBlDz+XSS3/i5QzXYePnKaYGxRz1cEwxI8H6v3QauZ/
	 kmaSxrDb5ayN/hytSaR3jSL5cvjrF94O0XeNI7aoR8CZh0trIn4h4i8FXENdQIQ4Dt
	 v2CnsTdjP3pHg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH net-next v2 2/2] selftests: net: add test for netdev instance lock ordering on unregister
Date: Fri, 25 Sep 2026 21:18:32 -0700
Message-ID: <20260926041832.1649675-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926041832.1649675-1-kuba@kernel.org>
References: <20260926041832.1649675-1-kuba@kernel.org>
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

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Eric Dumazet <edumazet@google.com>
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

