Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6806239AD5E
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 08:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781078631; cv=none; b=oW5LaqDbA8e8ylbd18KvfA2ypVyZ+do2R6AoMrkaD3SKLXIJ2UyyHsAHHxHTjtb9tp94Th7YyVQOhXwV91kTFfOKducyXveiIl/g8uodp+BRQId460KWqCaQKRMwHHNoULLrynDGiV6X5n6fbhR9b6vNuiVM1qoY79JJaHp5s48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781078631; c=relaxed/simple;
	bh=OeSOnfqUbuPL91YlSrrZW3aMc+j+KiVkwwK29CZG/Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmHu9kqpUV+fbLFLvOfW11bToqcsSafUy8SXMYKktbisC1wUrrRXBT20duUIvEsgKZPyLd9BpV3sEtVhPdyM0ysT6MZq3kHAR6pqnzbUIR+w/pCs7vx7Dz6p0MCxrEuGFECOh5h1AJv8UtHh+H9/RHInycu2g+3CdOcUq7k3MYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=rQRlpwE8; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="rQRlpwE8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=vS5klBE3/4hEBqfKckZ6KaEwi+cGSKzFC+h/vfjR5CI=; b=rQRlpwE8i6p0o+MjEjEb+pmerL
	aaeGXtDbvVYDULbI+4PY60Be6Ait5CfzgGD55wvZSOB8jnTy4LoA6F1C9pWEQDVc80qsF7DXbTHNN
	Q3JaeMAgLN9Gh6OvXqbXT2aSn1Q0qVCGWsmEbNRAt+fGD+XY303uHmC+grGYEV/4FctL0NslM2jQ3
	F90QfNIF7Bh1KmYrgIHv8QunVBuhIwSUcD4pnBN0u6T6HwkRY/FYsN/sksi4QKPF3neXI5/mo0NV1
	+ICLgncN7WSQ8xThCgYpiSMWFU3Edn1NJfT3W72NtkyCF11UAXZGYYVxm8vYEdZQf7D+lAB2R5vOO
	hRJA2bzQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wXDuc-0009Wc-34;
	Wed, 10 Jun 2026 10:03:47 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: razor@blackwall.org,
	bobbyeshleman@meta.com,
	dw@davidwei.uk,
	netdev@vger.kernel.org
Subject: [PATCH net-next 2/4] selftests/net: Use public NetDrvContEnv API in nk_qlease fixtures
Date: Wed, 10 Jun 2026 10:03:42 +0200
Message-ID: <20260610080344.701380-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610080344.701380-1-daniel@iogearbox.net>
References: <20260610080344.701380-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28027/Wed Jun 10 08:29:13 2026)

Expose the netkit host ifname as a public attribute nk_host_ifname
(symmetric with the already-public nk_guest_ifname), rename _attach_bpf
to a public attach_bpf, and add a public detach_bpf helper that
encapsulates the tc-filter teardown bookkeeping. Switch the fixtures
to this public API. No functional change and keeps pylint happy.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/drivers/net/hw/nk_qlease.py     | 33 ++++++++---------
 .../selftests/drivers/net/lib/py/env.py       | 36 +++++++++++--------
 2 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/nk_qlease.py b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
index 81125856727f..fee114676fd8 100755
--- a/tools/testing/selftests/drivers/net/hw/nk_qlease.py
+++ b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
@@ -34,16 +34,11 @@ from lib.py import KsftSkipEx, CmdExitFailure
 
 
 def _create_netkit_pair(cfg, rxqueues=2):
-    if cfg._nk_host_ifname:
-        cmd(f"ip link del dev {cfg._nk_host_ifname}", fail=False)
-        cfg._nk_host_ifname = None
+    if cfg.nk_host_ifname:
+        cmd(f"ip link del dev {cfg.nk_host_ifname}", fail=False)
+        cfg.nk_host_ifname = None
         cfg.nk_guest_ifname = None
-    if getattr(cfg, "_tc_attached", False):
-        cmd(
-            f"tc filter del dev {cfg.ifname} ingress pref {cfg._bpf_prog_pref}",
-            fail=False,
-        )
-        cfg._tc_attached = False
+    cfg.detach_bpf()
 
     all_links = ip("-d link show", json=True)
     old_idxs = {
@@ -79,17 +74,17 @@ def _create_netkit_pair(cfg, rxqueues=2):
         raise KsftSkipEx("Failed to create netkit pair")
 
     nk_links.sort(key=lambda x: x["ifindex"])
-    cfg._nk_host_ifname = nk_links[1]["ifname"]
+    cfg.nk_host_ifname = nk_links[1]["ifname"]
     cfg.nk_guest_ifname = nk_links[0]["ifname"]
     cfg.nk_host_ifindex = nk_links[1]["ifindex"]
     cfg.nk_guest_ifindex = nk_links[0]["ifindex"]
 
     ip(f"link set dev {cfg.nk_guest_ifname} netns {cfg.netns.name}")
-    ip(f"link set dev {cfg._nk_host_ifname} up")
-    ip(f"-6 addr add fe80::1/64 dev {cfg._nk_host_ifname} nodad")
+    ip(f"link set dev {cfg.nk_host_ifname} up")
+    ip(f"-6 addr add fe80::1/64 dev {cfg.nk_host_ifname} nodad")
     ip(
         f"-6 route add {cfg.nk_guest_ipv6}/128 via fe80::2 "
-        f"dev {cfg._nk_host_ifname}"
+        f"dev {cfg.nk_host_ifname}"
     )
     ip(f"link set dev {cfg.nk_guest_ifname} up", ns=cfg.netns)
     ip(f"-6 addr add fe80::2/64 dev {cfg.nk_guest_ifname}", ns=cfg.netns)
@@ -102,7 +97,7 @@ def _create_netkit_pair(cfg, rxqueues=2):
         ns=cfg.netns,
     )
 
-    cfg._attach_bpf()
+    cfg.attach_bpf()
 
 
 def _setup_lease(cfg, rxqueues=2):
@@ -135,9 +130,9 @@ def _setup_lease(cfg, rxqueues=2):
 
 
 def _teardown_netkit(cfg):
-    if cfg._nk_host_ifname:
-        cmd(f"ip link del dev {cfg._nk_host_ifname}", fail=False)
-        cfg._nk_host_ifname = None
+    if cfg.nk_host_ifname:
+        cmd(f"ip link del dev {cfg.nk_host_ifname}", fail=False)
+        cfg.nk_host_ifname = None
         cfg.nk_guest_ifname = None
 
 
@@ -320,9 +315,9 @@ def test_destroy(cfg) -> None:
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
index 2cc78b8a2152..e1038a02760e 100644
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
@@ -395,23 +395,23 @@ class NetDrvContEnv(NetDrvEpEnv):
             raise KsftSkipEx("Failed to create netkit pair")
 
         netkit_links.sort(key=lambda x: x['ifindex'])
-        self._nk_host_ifname = netkit_links[1]['ifname']
+        self.nk_host_ifname = netkit_links[1]['ifname']
         self.nk_guest_ifname = netkit_links[0]['ifname']
         self.nk_host_ifindex = netkit_links[1]['ifindex']
         self.nk_guest_ifindex = netkit_links[0]['ifindex']
 
         self._setup_ns()
-        self._attach_bpf()
+        self.attach_bpf()
         if primary_rx_redirect:
             self._attach_primary_rx_redirect_bpf()
 
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
@@ -512,7 +512,13 @@ class NetDrvContEnv(NetDrvEpEnv):
                 return map_id
         raise Exception(f"Failed to find .bss map for prog {prog_id}")
 
-    def _attach_bpf(self):
+    def detach_bpf(self):
+        if self._tc_attached:
+            cmd(f"tc filter del dev {self.ifname} ingress pref "
+                f"{self._bpf_prog_pref}", fail=False)
+            self._tc_attached = False
+
+    def attach_bpf(self):
         bpf_obj = self.test_dir / "nk_forward.bpf.o"
         if not bpf_obj.exists():
             raise KsftSkipEx("BPF prog not found")
@@ -539,9 +545,9 @@ class NetDrvContEnv(NetDrvEpEnv):
         if not bpf_obj.exists():
             raise KsftSkipEx("Primary RX redirect BPF prog not found")
 
-        if self._tc_ensure_clsact(self._nk_host_ifname):
+        if self._tc_ensure_clsact(self.nk_host_ifname):
             self._primary_rx_redirect_clsact_added = True
-        cmd(f"tc filter add dev {self._nk_host_ifname} ingress"
+        cmd(f"tc filter add dev {self.nk_host_ifname} ingress"
             f" bpf obj {bpf_obj} sec tc/ingress direct-action")
         self._primary_rx_redirect_attached = True
 
@@ -550,7 +556,7 @@ class NetDrvContEnv(NetDrvEpEnv):
         self._remote_route_added = True
 
         filters = json.loads(
-            cmd(f"tc -j filter show dev {self._nk_host_ifname} ingress").stdout)
+            cmd(f"tc -j filter show dev {self.nk_host_ifname} ingress").stdout)
         redirect_prog_id = None
         for bpf in filters:
             if 'options' not in bpf:
-- 
2.43.0

