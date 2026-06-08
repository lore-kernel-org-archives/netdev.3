Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756D3341ADF
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 23:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780961487; cv=none; b=Lovfu/NPu2zegl1nPZRGLZucLSz5bbt/oOdC64IAfXXVWDP4piYTVN3x8CH412IIlhoCkxPj+tPGoXXuJ4Sqhesk4Ge8yecjOZaISRFQ1gHt2YDawg326SlGjMcaVwVfzo0tpx4zBF16ZkgvEXwdJx/EeqZWjWtLGT6a2zYmrGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780961487; c=relaxed/simple;
	bh=O33neITJ7urgh3sJsxucZb7ss/mpiM7ipfFs/zeVnw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jw4igOY66v9vbFiygRBFFQq+U1SK6pG1XHpLK/MLvwBPmswjuA6VhAIn04qZwSk+p7F+LumR5B60vQgMcOoBnI1Y498y3WW1LARA5naZM09vkbzgE4TkpvldAEDD0pQOclSdv84MsS0l2dj6LHUGx1709zGGKTBVLkSuot4eyR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sPCXYGp5; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPCXYGp5"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7e255c15ffcso7091547b3.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 16:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780961485; x=1781566285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LhKFs0Meyz8+QaTlJdHk/5mq3/Ry7EPOHb06ioJIQk=;
        b=sPCXYGp5kcCQ3HjAFM2jUlorFUELqZi5TrR5EmweNGGUluKVT/lD8RQXUzFoFN0cCv
         riJ4QdaCJoSX8XXVLKSc+RAK/5o3CVU2oObHsqXZyhIBvi4Ini8Y3BveBZRrmKNaWQhd
         b3syKJ+Q8wsWprWIrTwcjQJLzYDlk4/dyTAsI2jTBG+canrpnDZ+CBFEkHtiX424JY5E
         k2FYRcOROg8utpITdTZ0s3DQe72PMh8bhLyo8t5BKr7HJPOXsJ1FxLeapfq3EFSPYbv3
         5Ecp4opY5INoMTBQmYwnM7tzORSukEJ4XU97BQqc3mfhHKAMnJPT2e/+sJbKBdaOMeZu
         EUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780961485; x=1781566285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7LhKFs0Meyz8+QaTlJdHk/5mq3/Ry7EPOHb06ioJIQk=;
        b=OZ+vZ1cOYKadCXAqRqmOwBrD0ckZGP3IfxFGKyOdDEuR7VHNhdH5dVk7Ar89BOMDtQ
         NQDElKWTAshQp6MJoA1XETu7CxYEOBbVi5GimTcd+ZQHaNkjWm0ZfWGo5PtRqrYfaWZg
         uNTaWLmG9+XgT4n6/c0x31ulNvnmt1wWnhPzFt9yNGP5Bi4xRxjVti2yoX/qmvzFC2Uq
         gBW2tG1XhGXnGuW7dCOlq9Ng1rRdJGpp5WBVKvec7so0IL7LDaGQDkMV9wboTJNvOMm1
         HbH7PtFDI/YbtizN2VRirhvUieinca0jan9YuE7VKRLWX9NK8xZ11RnyL4vJp5qHt9nQ
         +d7Q==
X-Gm-Message-State: AOJu0YwYabJ0Dn0hcb039LfGxXfYY8HJzhDwgQYAup2gZEx0TKFQAX4D
	blXwD5tzo35MJQAuYToLY50E7H0B3jbMwxbzsHarGuGpX5gMk0JmTk45JXzx5Q==
X-Gm-Gg: Acq92OEzzOutuooSiXYspoLktlhpUm4sfwapSdtz2SW8qh0pB2TrLm8T4ZGXRFqN5XS
	yQ0o+iw/iHsPDhYv+j4Uf7/qbm5G5DJU7XyYgih1g8T07fsopCIwB1XoyYLUlKPRLFvPhv3hRMJ
	XvGqizfRf0u221amHlhoBFwuAhhQ7wn/UFW88kecJcgHvwD/96eUw01szkDXF0vZ3zUMDTBHlh8
	Onuuy+rGvDA3qcgCnl0gEeITef5uxahzh/fO97ngxMIyHMigwihPEGt1Abu/rs5JAYiUUuKwkto
	hiZC0jWf+meSqq7RL6B70pHTtt6sSzdnn6UbujflhJJXYUa37OrqnAADZF0Ad/cSqzaTqxKTQ1V
	JfylJH5uchNLgy/orvo/ySsw1E1q86R5YWZgVH8mJzCd1CG8mqYFJDQLQ9deHCcRDdOGetVxoUt
	MAh/f4+6aV/eyhI0zjTNOyzkZXKSNahV7WFQ==
X-Received: by 2002:a05:690c:94:b0:7db:d527:b8eb with SMTP id 00721157ae682-7ed0db9ba48mr96968717b3.8.1780961485593;
        Mon, 08 Jun 2026 16:31:25 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:5::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea215825dfsm89788627b3.15.2026.06.08.16.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 16:31:25 -0700 (PDT)
From: Wei Wang <weibunny.kernel@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Wei Wang <weibunny@fb.com>
Subject: [PATCH v16 net-next 06/10] selftests/net: rename _nk_host_ifname to nk_host_ifname
Date: Mon,  8 Jun 2026 16:31:14 -0700
Message-ID: <20260608233118.2694144-7-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260608233118.2694144-1-weibunny.kernel@gmail.com>
References: <20260608233118.2694144-1-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Wang <weibunny@fb.com>

Rename _nk_host_ifname to nk_host_ifname in NetDrvContEnv to make it
a public attribute, matching the nk_guest_ifname rename. Tests that
access the host-side netkit interface name (e.g. for cleanup after
deleting the netkit pair) no longer trigger pylint protected-access
warnings.

Signed-off-by: Wei Wang <weibunny@fb.com>
---
 .../selftests/drivers/net/hw/nk_qlease.py     |  4 +--
 .../selftests/drivers/net/lib/py/env.py       | 26 +++++++++----------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/nk_qlease.py b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
index 139a91ebd229..f5fd64775989 100755
--- a/tools/testing/selftests/drivers/net/hw/nk_qlease.py
+++ b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
@@ -193,9 +193,9 @@ def test_destroy(cfg) -> None:
     kill_timer = threading.Timer(1, rx_proc.proc.terminate)
     kill_timer.start()
 
-    ip(f"link del dev {cfg._nk_host_ifname}")
+    ip(f"link del dev {cfg.nk_host_ifname}")
     kill_timer.join()
-    cfg._nk_host_ifname = None
+    cfg.nk_host_ifname = None
     cfg.nk_guest_ifname = None
 
     queue_info = netdevnl.queue_get(
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 9ccea3b44800..59b0f2533ab4 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -341,7 +341,7 @@ class NetDrvContEnv(NetDrvEpEnv):
                  userns=False, **kwargs):
         self.netns = None
         self._userns = userns
-        self._nk_host_ifname = None
+        self.nk_host_ifname = None
         self.nk_guest_ifname = None
         self._tc_clsact_added = False
         self._tc_attached = False
@@ -395,7 +395,7 @@ class NetDrvContEnv(NetDrvEpEnv):
             raise KsftSkipEx("Failed to create netkit pair")
 
         netkit_links.sort(key=lambda x: x['ifindex'])
-        self._nk_host_ifname = netkit_links[1]['ifname']
+        self.nk_host_ifname = netkit_links[1]['ifname']
         self.nk_guest_ifname = netkit_links[0]['ifname']
         self.nk_host_ifindex = netkit_links[1]['ifindex']
         self.nk_guest_ifindex = netkit_links[0]['ifindex']
@@ -407,11 +407,11 @@ class NetDrvContEnv(NetDrvEpEnv):
 
     def __del__(self):
         if self._primary_rx_redirect_attached:
-            cmd(f"tc filter del dev {self._nk_host_ifname} ingress", fail=False)
+            cmd(f"tc filter del dev {self.nk_host_ifname} ingress", fail=False)
             self._primary_rx_redirect_attached = False
 
         if self._primary_rx_redirect_clsact_added:
-            cmd(f"tc qdisc del dev {self._nk_host_ifname} clsact", fail=False)
+            cmd(f"tc qdisc del dev {self.nk_host_ifname} clsact", fail=False)
             self._primary_rx_redirect_clsact_added = False
 
         if self._tc_attached:
@@ -427,9 +427,9 @@ class NetDrvContEnv(NetDrvEpEnv):
                 host=self.remote, fail=False)
             self._remote_route_added = False
 
-        if self._nk_host_ifname:
-            cmd(f"ip link del dev {self._nk_host_ifname}")
-            self._nk_host_ifname = None
+        if self.nk_host_ifname:
+            cmd(f"ip link del dev {self.nk_host_ifname}")
+            self.nk_host_ifname = None
             self.nk_guest_ifname = None
 
         if self._init_ns_attached:
@@ -470,9 +470,9 @@ class NetDrvContEnv(NetDrvEpEnv):
         self._init_ns_attached = True
         ip("netns set init 0", ns=self.netns)
         ip(f"link set dev {self.nk_guest_ifname} netns {self.netns.name}")
-        ip(f"link set dev {self._nk_host_ifname} up")
-        ip(f"-6 addr add fe80::1/64 dev {self._nk_host_ifname} nodad")
-        ip(f"-6 route add {self.nk_guest_ipv6}/128 via fe80::2 dev {self._nk_host_ifname}")
+        ip(f"link set dev {self.nk_host_ifname} up")
+        ip(f"-6 addr add fe80::1/64 dev {self.nk_host_ifname} nodad")
+        ip(f"-6 route add {self.nk_guest_ipv6}/128 via fe80::2 dev {self.nk_host_ifname}")
 
         ip("link set lo up", ns=self.netns)
         ip(f"link set dev {self.nk_guest_ifname} up", ns=self.netns)
@@ -548,9 +548,9 @@ class NetDrvContEnv(NetDrvEpEnv):
         if not bpf_obj:
             raise KsftSkipEx("nk_primary_rx_redirect.bpf.o not found")
 
-        if self._tc_ensure_clsact(self._nk_host_ifname):
+        if self._tc_ensure_clsact(self.nk_host_ifname):
             self._primary_rx_redirect_clsact_added = True
-        cmd(f"tc filter add dev {self._nk_host_ifname} ingress"
+        cmd(f"tc filter add dev {self.nk_host_ifname} ingress"
             f" bpf obj {bpf_obj} sec tc/ingress direct-action")
         self._primary_rx_redirect_attached = True
 
@@ -559,7 +559,7 @@ class NetDrvContEnv(NetDrvEpEnv):
         self._remote_route_added = True
 
         filters = json.loads(
-            cmd(f"tc -j filter show dev {self._nk_host_ifname} ingress").stdout)
+            cmd(f"tc -j filter show dev {self.nk_host_ifname} ingress").stdout)
         redirect_prog_id = None
         for bpf in filters:
             if 'options' not in bpf:
-- 
2.52.0

