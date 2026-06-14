Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353D130D41E
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781432779; cv=none; b=iBV+lwdg50mnKAohchWOZ1Av/Slg7NWpmnQRUdkmxmOljFk0Z9ZFCXJzA47qcsZfuzmeuZx+kMhQe7x/V+GwKeB4Im3us5KXVIJlPMkqzbFdHhaydyB5eE8jdPpbiS3s5McziJGpJibWM5NBLs238qNHf1v9kee9b+l5AE/L0kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781432779; c=relaxed/simple;
	bh=/IQtEb5qR5CNrceEupu2yvMDy6gxu/zpX7HTUHenOAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJrQUmSXs9jL3IsgZGdBaEzfLRtgDLXoMrg2C8aCPF1o7md36xoEP5jBTM2Vfiy6Qq2pzY048bEk9vM0CCU4qxAiw0Wz0sUofVXVGdNDeH5UJYcWZVec2LD2PXRo0Ca9C51oy3nTb5jis3bRaNsfz7BOxwIfHWFcLUWh50TAc5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=gI12Z3o6; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="gI12Z3o6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ZSmQ8kWsiapuKrhCUhWjCPriTs0ENjQmkQnX9dcO3cY=; b=gI12Z3o677fGOtfvPClGXwPowj
	LOmYQpF8rJ7x0Auxjy9PfyD26f5nduNJMc/rjUnuvOj+sOKxwwuR1ztZXtVd2XkBPW0UTu1mgENgy
	TGO6VoM7o6lQ9okObazX1du9Z0YVjcnfpMjxZqvp7QLHDqmX/Jb9CpEh6UWmd9A7JooO+BZqlMer/
	kdSiWqnw/nTtOAYCSp0sifqIYdrOEAUA3NDCfRndpfNoE81exe4AAUBWUlESZYGWHLDA9Ha2EJsbw
	WZ6OyqQ1cvNPK0sQ40IEsq/9LMt54B56aRyi5cOtIoBmDKIQwrcwI6ruG6q/Gt+dpuk9AUMp2snnI
	6mXo3H4Q==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wYi2b-000Ngw-15;
	Sun, 14 Jun 2026 12:26:09 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: razor@blackwall.org,
	bobbyeshleman@meta.com,
	dw@davidwei.uk,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 2/4] selftests/net: Use public NetDrvContEnv API in nk_qlease fixtures
Date: Sun, 14 Jun 2026 12:26:05 +0200
Message-ID: <20260614102607.863838-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260614102607.863838-1-daniel@iogearbox.net>
References: <20260614102607.863838-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28031/Sun Jun 14 08:35:08 2026)

Expose the netkit host ifname as a public attribute nk_host_ifname
(symmetric with the already-public nk_guest_ifname), rename _attach_bpf
to a public attach_bpf, and add a public detach_bpf helper that
encapsulates the tc-filter teardown bookkeeping. Switch the fixtures
to this public API. No functional change and keeps pylint happy.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/drivers/net/hw/nk_qlease.py |  9 ++-------
 tools/testing/selftests/drivers/net/lib/py/env.py   | 10 ++++++++--
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/nk_qlease.py b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
index 3723574dcd30..b97663820ccf 100755
--- a/tools/testing/selftests/drivers/net/hw/nk_qlease.py
+++ b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
@@ -38,12 +38,7 @@ def _create_netkit_pair(cfg, rxqueues=2):
         cmd(f"ip link del dev {cfg.nk_host_ifname}", fail=False)
         cfg.nk_host_ifname = None
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
@@ -102,7 +97,7 @@ def _create_netkit_pair(cfg, rxqueues=2):
         ns=cfg.netns,
     )
 
-    cfg._attach_bpf()
+    cfg.attach_bpf()
 
 
 def _setup_lease(cfg, rxqueues=2):
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index b188ee55c76b..e4ab99b905b1 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -401,7 +401,7 @@ class NetDrvContEnv(NetDrvEpEnv):
         self.nk_guest_ifindex = netkit_links[0]['ifindex']
 
         self._setup_ns()
-        self._attach_bpf()
+        self.attach_bpf()
         if primary_rx_redirect:
             self._attach_primary_rx_redirect_bpf()
 
@@ -524,7 +524,13 @@ class NetDrvContEnv(NetDrvEpEnv):
             return bpf_obj
         return None
 
-    def _attach_bpf(self):
+    def detach_bpf(self):
+        if self._tc_attached:
+            cmd(f"tc filter del dev {self.ifname} ingress pref "
+                f"{self._bpf_prog_pref}", fail=False)
+            self._tc_attached = False
+
+    def attach_bpf(self):
         bpf_obj = self._find_bpf_obj("nk_forward.bpf.o")
         if not bpf_obj:
             raise KsftSkipEx("BPF prog nk_forward.bpf.o not found")
-- 
2.43.0

