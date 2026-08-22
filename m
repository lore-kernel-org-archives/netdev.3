Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3F43911C6
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 22:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787439338; cv=none; b=jIoOaFbPaeoEZ3j01FOvc1GC8EXnUNWT90A6vOkJ9ps+X1fqVIvPKHbRnooUjCckz1hs8uSKuRlHvYnJRowuhUFjOQJJIuoXM5367WbzBPIRHLKvMgch0IvTv9iXHbPx87f7UxerWohzD+fmmRyVH13PIiXNtmFg5l95Oml4dm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787439338; c=relaxed/simple;
	bh=Ufjn2dH9Bw4LRLfgfJ3wcUAXKOb3cdZNzGtU0Tm+kXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ln8f+DDzfZpOvway8Zbw/pxHyvWszHYIwEDub3VEW6pOI+cq01KzZMLbPbCKTopKqjru6nW1LmhTdwHkgPVjk5+zsVmPt8e9xxOfic4U2GzRLBdGTQrYkucxDNys8tYV/wN/A/k9doco2NWSQd/RcUYjP+SymcG+QMWDX8k+0QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeqqinPn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeqqinPn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A0C1F00ACA;
	Sat, 22 Aug 2026 22:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787439333;
	bh=emE43rfGiehNXkTXDX4EdFoXU/B9TfCgDw7b0ech/Cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SeqqinPn2YSvPfamtGjt46vchXhjjUoTCHHRdqNDmzntJoDd51BDcXXWXEeEoyT0K
	 Q+7UgDweWk8PEdDkb17VnLN78vdzNDrTrBPJUOvbjyFtG7H8wI/YJ370AkJ5gD4Inm
	 97kJ80ayOFmjoeemyiOcFHHkE6mbc9sK/pOkyHybvwU09SFrbyOheh0f5Amev9moA/
	 ovToV35PqY7ZZNeduMBQffqqCStFOLoRQsVCE5aYeqIC8x2UGh4TSYNbO2uSxMYhjD
	 FYCwaeW0KOjnKoznzcDL6+H6BoIZzHp2eOxgFfE5eLndrgB1h9DyPtEG4QJy288pGi
	 maXC2GOf13mmg==
From: Jakub Kicinski <kuba@kernel.org>
To: daniel.zahka@gmail.com,
	willemdebruijn.kernel@gmail.com
Cc: edumazet@google.com,
	cratiu@nvidia.com,
	borisp@nvidia.com,
	kuniyu@google.com,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 5/6] selftests: drv-net: psp_steer: test where PSP steering sits in the Rx pipeline
Date: Sat, 22 Aug 2026 15:55:23 -0700
Message-ID: <20260822225524.2328465-6-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822225524.2328465-1-kuba@kernel.org>
References: <20260822225524.2328465-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cover the steering priority / Rx pipeline ordering.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/psp_steer.py        | 171 +++++++++++++++++-
 1 file changed, 164 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/psp_steer.py b/tools/testing/selftests/drivers/net/psp_steer.py
index 0401a7c359e7..fac2d7532d61 100644
--- a/tools/testing/selftests/drivers/net/psp_steer.py
+++ b/tools/testing/selftests/drivers/net/psp_steer.py
@@ -10,17 +10,35 @@ import socket
 from lib.py import defer
 from lib.py import ksft_run, ksft_exit
 from lib.py import ksft_eq, ksft_ge, ksft_in, ksft_ne, ksft_raises
-from lib.py import KsftSkipEx
+from lib.py import CmdExitFailure, KsftSkipEx
 from lib.py import NetDrvEpEnv
 from lib.py import NetdevFamily, NlError, PSPFamily
+from lib.py import ethtool
 
-from psp_lib import close_conn, init_psp_dev, make_psp_conn, psp_txrx, \
-    remote_conn_steer, remote_dev_steer, spi_xchg
+from psp_lib import close_conn, init_psp_dev, make_clr_conn, make_psp_conn, \
+    psp_txrx, remote_conn_steer, remote_dev_steer, spi_xchg
 from psp_lib import responder as psp_responder
 
 # Not exposed by the socket module
 _SO_INCOMING_NAPI_ID = 56
 
+
+# Mirrors the helpers of the same name in hw/rss_ctx.py, which lives in a
+# directory this test cannot import from.
+def ethtool_create(cfg, act, opts):
+    output = ethtool(f"{act} {cfg.ifname} {opts}").stdout
+    # "New RSS context is 1" / "Added rule with ID 7", we want the integer
+    return int(output.split()[-1])
+
+
+def require_ntuple(cfg):
+    features = ethtool(f"-k {cfg.ifname}", json=True)[0]
+    if not features["ntuple-filters"]["active"]:
+        if features["ntuple-filters"]["fixed"]:
+            raise KsftSkipEx("Device does not support ntuple-filters")
+        ethtool(f"-K {cfg.ifname} ntuple-filters on")
+        defer(ethtool, f"-K {cfg.ifname} ntuple-filters off")
+
 _VC_TX = 1 << 0
 _VC_RX = 1 << 1
 _VC_BOTH = _VC_TX | _VC_RX
@@ -92,6 +110,14 @@ _VC_SIZE = 8
     return s
 
 
+def _rx_queue(cfg, s):
+    """Rx queue the socket's last packet arrived on"""
+    napi_id = s.getsockopt(socket.SOL_SOCKET, _SO_INCOMING_NAPI_ID)
+    ksft_ne(napi_id, 0, comment="socket saw no traffic?")
+    ksft_in(napi_id, cfg.napi2queue, comment="unknown NAPI id")
+    return cfg.napi2queue[napi_id]
+
+
 def _settled_rx_queue(cfg, s, sent):
     """Run traffic until the peer picked our request up, report the queue
 
@@ -101,10 +127,52 @@ _VC_SIZE = 8
     sent = psp_txrx(cfg, s, 1, sent)
     sent = psp_txrx(cfg, s, 1, sent)
 
-    napi_id = s.getsockopt(socket.SOL_SOCKET, _SO_INCOMING_NAPI_ID)
-    ksft_ne(napi_id, 0, comment="socket saw no traffic?")
-    ksft_in(napi_id, cfg.napi2queue, comment="unknown NAPI id")
-    return cfg.napi2queue[napi_id], sent
+    return _rx_queue(cfg, s), sent
+
+
+def _rss_pin(cfg, qid, context=None):
+    """Point an RSS indirection table at a single queue"""
+    ctx = f"context {context} " if context is not None else ""
+    weights = " ".join("1" if i == qid else "0"
+                       for i in range(cfg.rx_queue_cnt))
+    ethtool(f"-X {cfg.ifname} {ctx}weight {weights}")
+
+
+def _require_rss_steering(cfg):
+    """Skip unless the Rx queue actually follows the RSS table
+
+    Steering can only be shown to outrank RSS on a device where RSS has
+    a say in the first place - netdevsim, for one, ignores the table.
+    """
+    probe = cfg.rx_queue_cnt - 1
+
+    try:
+        _rss_pin(cfg, probe)
+    except CmdExitFailure as exc:
+        raise KsftSkipEx("Device does not support RSS table updates") from exc
+    defer(ethtool, f"-X {cfg.ifname} default")
+
+    with make_clr_conn(cfg) as s:
+        psp_txrx(cfg, s, 1)
+        landed = _rx_queue(cfg, s)
+        close_conn(cfg, s)
+
+    if landed != probe:
+        raise KsftSkipEx("Rx queue does not follow the RSS table")
+
+
+def _ntuple_l3_rule(cfg, target):
+    """Steer this host's traffic with an L3 only rule, and clean it up
+
+    L3 only on purpose: whether the classifier sees the inner TCP ports
+    of a PSP packet or just the outer UDP encapsulation is up to the
+    device, the addresses are there either way.
+    """
+    flow = (f"flow-type ip{cfg.addr_ipver} "
+            f"src-ip {cfg.remote_addr} dst-ip {cfg.addr} {target}")
+    rule = ethtool_create(cfg, "-N", flow)
+    defer(ethtool, f"-N {cfg.ifname} delete {rule}")
+    return rule
 
 
 #
@@ -221,6 +289,95 @@ _VC_SIZE = 8
         close_conn(cfg, s)
 
 
+def data_steer_no_grant(cfg):
+    """ We ask and nobody grants: nothing is steered """
+    _require_steer(cfg)
+    _require_queues(cfg, 3)
+    _require_rss_steering(cfg)
+    _enable_steer(cfg, local=_VC_RX, remote=0)
+
+    # RSS says 2, we would be asking for 1 if anyone were listening
+    _rss_pin(cfg, 2)
+    defer(_force_tx_queue, cfg, -1)
+    _force_tx_queue(cfg, 1)
+
+    with _psp_conn(cfg) as s:
+        qid, _ = _settled_rx_queue(cfg, s, 0)
+        ksft_eq(qid, 2, comment="steered without the peer granting anything")
+        close_conn(cfg, s)
+
+
+def data_steer_beats_rss(cfg):
+    """ Steering has to win over the RSS table """
+    _require_steer(cfg)
+    _require_queues(cfg, 3)
+    _enable_steer(cfg)
+    _require_rss_steering(cfg)
+
+    # RSS says 2, steering is going to ask for 1
+    _rss_pin(cfg, 2)
+    defer(_force_tx_queue, cfg, -1)
+    _force_tx_queue(cfg, 1)
+
+    with _psp_conn(cfg) as s:
+        qid, _ = _settled_rx_queue(cfg, s, 0)
+        ksft_eq(qid, 1)
+        close_conn(cfg, s)
+
+
+def data_steer_beats_rss_ctx(cfg):
+    """ Steering has to win over an additional RSS context as well """
+    _require_steer(cfg)
+    _require_queues(cfg, 3)
+    _enable_steer(cfg)
+    _require_rss_steering(cfg)
+    require_ntuple(cfg)
+
+    # Three distinct answers: default RSS says 0, the context says 2,
+    # and steering is going to ask for 1.
+    _rss_pin(cfg, 0)
+    ctx = ethtool_create(cfg, "-X", "context new")
+    defer(ethtool, f"-X {cfg.ifname} context {ctx} delete")
+    _rss_pin(cfg, 2, context=ctx)
+    _ntuple_l3_rule(cfg, f"context {ctx}")
+
+    # Without a cookie the context has to be the one deciding, otherwise
+    # the check below would pass without steering doing anything.
+    with make_clr_conn(cfg) as s:
+        psp_txrx(cfg, s, 1)
+        ksft_eq(_rx_queue(cfg, s), 2, comment="RSS context not in use")
+        close_conn(cfg, s)
+
+    defer(_force_tx_queue, cfg, -1)
+    _force_tx_queue(cfg, 1)
+
+    with _psp_conn(cfg) as s:
+        qid, _ = _settled_rx_queue(cfg, s, 0)
+        ksft_eq(qid, 1, comment="steering did not escape the RSS context")
+        close_conn(cfg, s)
+
+
+def data_ntuple_beats_steer(cfg):
+    """ An ntuple rule naming a queue outranks steering """
+    _require_steer(cfg)
+    _require_queues(cfg, 3)
+    _enable_steer(cfg)
+    _require_rss_steering(cfg)
+    require_ntuple(cfg)
+
+    # RSS says 0, the rule says 2, steering is going to ask for 1
+    _rss_pin(cfg, 0)
+    _ntuple_l3_rule(cfg, "action 2")
+
+    defer(_force_tx_queue, cfg, -1)
+    _force_tx_queue(cfg, 1)
+
+    with _psp_conn(cfg) as s:
+        qid, _ = _settled_rx_queue(cfg, s, 0)
+        ksft_eq(qid, 2, comment="steering overrode an explicit ntuple rule")
+        close_conn(cfg, s)
+
+
 def _queue_info(cfg):
     """Map NAPI ids to Rx queue ids, and count the queues"""
     netnl = NetdevFamily()
-- 
2.55.0

