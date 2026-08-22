Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1369391822
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 22:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787439336; cv=none; b=Zavpoy3SVY1Rs8F+zNq0pi9TiDQA98j+KPF5PQXHa2j7IAkj8GUsyIwpd7bops/cE3h0wkfxSS2BUniytUlJhBoDkJ3Cii/BfTpSwPn3CDB9zxJtX9VUOmkc6uz+1n1u9NNXoBxGoLC9llQjIPk8YaguPot5BAZYNMKkSIl4mxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787439336; c=relaxed/simple;
	bh=pgICsdvTZiG2E0T++rJp4BzZWgA3feQLhnvrOkQmDtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYuzs7daMuEkfd7TDrRzVJo6/3uQq5UGcieErt6YdG7rZnq6pjRoAOkJHeeRMSrKOHS+TaTxLCj9NGfjRmVPN59+GEF6UR2aRoLaGgQC0NxpXohX3zgXZqmaVgorTEmDAz9ooSq6Fjy9etOAUPLBXebhIGPlT0ZVj5f08v7uRqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpBas3Ny; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpBas3Ny"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8DB1F00A3A;
	Sat, 22 Aug 2026 22:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787439334;
	bh=56LIVM/KfXZ6g+NeYsHIUV19mmi9P3s9DZEy5Pe0DJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EpBas3NywOkw6BeqlzHFk6Xj1X9Ita6HJ2bkbjLiV4ZPrOh6+sbTaHw8qjEPXoMJl
	 hbaeibTg1c50QpcVFjI+CoFvfvS/7T5Ww3HLaJB9T9T80LA3tSDoTzkBGJp+ccoVR8
	 p+sIJK1ucT9tNd2znkY7cGU23PlqiDM9Zm5AuvZ0oaHzAyZ95uHsMYZbjlN5/4B7TH
	 DaltewZ6duixZihjGLRst+zHLXPL6eMJIEfv0rhvb1e8INWYbzHL+h2FOVrjAoERFf
	 vQztyyIbfZJSwViOtuHySztsCeail/r6MOaxgVyd49Mga1qp3ueguB5f6rI9cSxCwE
	 6QfmS2F+BIqag==
From: Jakub Kicinski <kuba@kernel.org>
To: daniel.zahka@gmail.com,
	willemdebruijn.kernel@gmail.com
Cc: edumazet@google.com,
	cratiu@nvidia.com,
	borisp@nvidia.com,
	kuniyu@google.com,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 6/6] selftests: drv-net: psp_steer: cover corner cases and races
Date: Sat, 22 Aug 2026 15:55:24 -0700
Message-ID: <20260822225524.2328465-7-kuba@kernel.org>
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

Test a PSP cookie naming a queue which went away.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/psp_steer.py        | 80 ++++++++++++++++---
 1 file changed, 70 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/psp_steer.py b/tools/testing/selftests/drivers/net/psp_steer.py
index fac2d7532d61..f61479befcc0 100644
--- a/tools/testing/selftests/drivers/net/psp_steer.py
+++ b/tools/testing/selftests/drivers/net/psp_steer.py
@@ -6,17 +6,18 @@
 import errno
 import os
 import socket
+import time
 
 from lib.py import defer
 from lib.py import ksft_run, ksft_exit
-from lib.py import ksft_eq, ksft_ge, ksft_in, ksft_ne, ksft_raises
+from lib.py import ksft_eq, ksft_ge, ksft_in, ksft_lt, ksft_ne, ksft_raises
 from lib.py import CmdExitFailure, KsftSkipEx
 from lib.py import NetDrvEpEnv
 from lib.py import NetdevFamily, NlError, PSPFamily
 from lib.py import ethtool
 
 from psp_lib import close_conn, init_psp_dev, make_clr_conn, make_psp_conn, \
-    psp_txrx, remote_conn_steer, remote_dev_steer, spi_xchg
+    psp_txrx, remote_dev_steer, req_echo, spi_xchg
 from psp_lib import responder as psp_responder
 
 # Not exposed by the socket module
@@ -43,6 +44,8 @@ _VC_TX = 1 << 0
 _VC_RX = 1 << 1
 _VC_BOTH = _VC_TX | _VC_RX
 _VC_SIZE = 8
+_IDLE_TIME = 0.5
+_FALLBACK_QUEUE = 3
 
 
 def _require_steer(cfg):
@@ -138,18 +141,19 @@ _VC_SIZE = 8
     ethtool(f"-X {cfg.ifname} {ctx}weight {weights}")
 
 
-def _require_rss_steering(cfg):
-    """Skip unless the Rx queue actually follows the RSS table
+def _rss_steers(cfg):
+    """Does the Rx queue actually follow the RSS table?
 
-    Steering can only be shown to outrank RSS on a device where RSS has
-    a say in the first place - netdevsim, for one, ignores the table.
+    Steering can only be compared against RSS on a device where RSS has a
+    say in the first place - netdevsim, for one, ignores the table. Leaves
+    the table as it found it.
     """
     probe = cfg.rx_queue_cnt - 1
 
     try:
         _rss_pin(cfg, probe)
-    except CmdExitFailure as exc:
-        raise KsftSkipEx("Device does not support RSS table updates") from exc
+    except CmdExitFailure:
+        return False
     defer(ethtool, f"-X {cfg.ifname} default")
 
     with make_clr_conn(cfg) as s:
@@ -157,10 +161,22 @@ _VC_SIZE = 8
         landed = _rx_queue(cfg, s)
         close_conn(cfg, s)
 
-    if landed != probe:
+    ethtool(f"-X {cfg.ifname} default")
+    return landed == probe
+
+
+def _require_rss_steering(cfg):
+    """Skip unless the Rx queue follows the RSS table"""
+    if not _rss_steers(cfg):
         raise KsftSkipEx("Rx queue does not follow the RSS table")
 
 
+def _set_queue_cnt(cfg, cnt):
+    """Reconfigure the device, and re-read the NAPI ids it hands out"""
+    ethtool(f"-L {cfg.ifname} combined {cnt}")
+    _queue_info(cfg)
+
+
 def _ntuple_l3_rule(cfg, target):
     """Steer this host's traffic with an L3 only rule, and clean it up
 
@@ -378,6 +394,50 @@ _VC_SIZE = 8
         close_conn(cfg, s)
 
 
+def data_steer_stale_queue(cfg):
+    """ A cookie naming a queue which went away has to fall back to RSS """
+    _require_steer(cfg)
+    _require_queues(cfg, 8)
+    _enable_steer(cfg)
+
+    nq = cfg.rx_queue_cnt
+    rss = _rss_steers(cfg)
+    if rss:
+        # Point RSS at a queue of our choosing so that "it fell back to
+        # RSS" is a statement we can actually check. Deliberately not
+        # queue 0: plenty of devices use that as a default or error queue,
+        # and landing there would prove nothing - it would also be a
+        # thundering herd waiting to happen if every stale flow went there.
+        _rss_pin(cfg, _FALLBACK_QUEUE)
+
+    defer(_set_queue_cnt, cfg, nq)
+    defer(_force_tx_queue, cfg, -1)
+    _force_tx_queue(cfg, nq - 1)
+
+    with _psp_conn(cfg) as s:
+        qid, _ = _settled_rx_queue(cfg, s, 0)
+        ksft_eq(qid, nq - 1)
+
+        # Go properly idle first. A delayed ACK landing after the
+        # reconfiguration would carry a fresh request and teach the peer a
+        # live queue, and we would end up measuring nothing.
+        time.sleep(_IDLE_TIME)
+
+        # Take the queue away without telling the peer, which goes on
+        # asking for it in every cookie it sends.
+        _set_queue_cnt(cfg, nq - 1)
+
+        # One packet, so that our ACK cannot teach the peer a new queue
+        # before we get to look at where this one landed.
+        req_echo(cfg, s)
+        qid = _rx_queue(cfg, s)
+        close_conn(cfg, s)
+
+    ksft_lt(qid, nq - 1, comment="delivered to a queue which no longer exists")
+    if rss:
+        ksft_eq(qid, _FALLBACK_QUEUE, comment="stale request did not fall back to RSS")
+
+
 def _queue_info(cfg):
     """Map NAPI ids to Rx queue ids, and count the queues"""
     netnl = NetdevFamily()
@@ -398,7 +458,7 @@ _VC_SIZE = 8
 def main() -> None:
     """ Ksft boiler plate main """
 
-    with NetDrvEpEnv(__file__, queue_count=4) as cfg:
+    with NetDrvEpEnv(__file__, queue_count=8) as cfg:
         cfg.pspnl = PSPFamily()
         _queue_info(cfg)
 
-- 
2.55.0

