Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C827E23BF93
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 23:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738886022; cv=none; b=Et+a4gkmF4POdO8QJOb5eRM/0sCNGCz7xm4/sSz7R7lhqHGg1EYxdOrLW8YzZG48GuttjFn02Vtpf/8UbW95JnejHNYgQyxKxufeUypNnwWqtZyUxV3AXUDl3rcgQ16YabuvEU16LVSussUQEumUOxY41x09cEuN7d98UWZw/QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738886022; c=relaxed/simple;
	bh=iNaH/YU5xOvH6KfojSk+uEkDuszWwQHA6WQVw+2U9+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/KYtnj+ozHh5yv0qiGZTzaCe9vJV5rCQk14cXJJyCYMMNhnRcw53xePmYcZzHL7sHYoDMqug9kRYzj9ysqjsaPZg3DDNSFRkbEu5oVKAUSnJ6/aiXqj9o66+XXz+SCJOObMBZ+DXVbG9cew8eLBP2PtasjoVyNo/KsUDWfKIhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVEFX2kk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVEFX2kk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBE7C4CEDF;
	Thu,  6 Feb 2025 23:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738886022;
	bh=iNaH/YU5xOvH6KfojSk+uEkDuszWwQHA6WQVw+2U9+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mVEFX2kkZI2AaUbC0hZiSqXutsOB0A5PBNWUqfStjL417dIgBmuf2GW+AUdtF5vDj
	 3pBLNpdvY5DbzuihTs2+eZUGpRKk8VNGUf08nsRAby7hNMatovty02omKDmsKL1VZP
	 ObCLwhm0F8oxBDs5baMrvd99oiKnBqD3ZZ4uUDhUWkwKDYwOZhMszcMotXypivRriq
	 bTJoqdkRHJdM9X0ff8eyCJ4ZWY9H3Bvi5yFrIolMNxpphyOnh8Wvag/4i+qF0N2A9H
	 8WsKEjn4cMm/7J/5EdDzDxBlWVhtuv4ch3k2pHOblZT/dDy+LnfwESd86nq5wiSYqZ
	 ngTtcmLgYfIfA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 6/7] selftests: drv-net: rss_ctx: skip tests which need multiple contexts cleanly
Date: Thu,  6 Feb 2025 15:53:33 -0800
Message-ID: <20250206235334.1425329-7-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206235334.1425329-1-kuba@kernel.org>
References: <20250206235334.1425329-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no good API to check how many contexts device supports.
But initial tests sense the context count already, so just store
that number and skip tests which we know need more.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/hw/rss_ctx.py       | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index 7e5f4602e6b3..d6e69d7d5e43 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -59,6 +59,14 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
         raise KsftSkipEx("Ntuple filters not enabled on the device: " + str(features["ntuple-filters"]))
 
 
+def require_context_cnt(cfg, need_cnt):
+    # There's no good API to get the context count, so the tests
+    # which try to add a lot opportunisitically set the count they
+    # discovered. Careful with test ordering!
+    if need_cnt and cfg.context_cnt and cfg.context_cnt < need_cnt:
+        raise KsftSkipEx(f"Test requires at least {need_cnt} contexts, but device only has {cfg.context_cnt}")
+
+
 # Get Rx packet counts for all queues, as a simple list of integers
 # if @prev is specified the prev counts will be subtracted
 def _get_rx_cnts(cfg, prev=None):
@@ -457,6 +465,8 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
                 raise
             ksft_pr(f"Failed to create context {i + 1}, trying to test what we got")
             ctx_cnt = i
+            if cfg.context_cnt is None:
+                cfg.context_cnt = ctx_cnt
             break
 
         _rss_key_check(cfg, context=ctx_id)
@@ -512,8 +522,7 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
     """
 
     require_ntuple(cfg)
-
-    requested_ctx_cnt = ctx_cnt
+    require_context_cnt(cfg, 4)
 
     # Try to allocate more queues when necessary
     qcnt = len(_get_rx_cnts(cfg))
@@ -578,9 +587,6 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
     remove_ctx(-1)
     check_traffic()
 
-    if requested_ctx_cnt != ctx_cnt:
-        raise KsftSkipEx(f"Tested only {ctx_cnt} contexts, wanted {requested_ctx_cnt}")
-
 
 def test_rss_context_overlap(cfg, other_ctx=0):
     """
@@ -589,6 +595,8 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
     """
 
     require_ntuple(cfg)
+    if other_ctx:
+        require_context_cnt(cfg, 2)
 
     queue_cnt = len(_get_rx_cnts(cfg))
     if queue_cnt < 4:
@@ -741,6 +749,7 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
 
 def main() -> None:
     with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
+        cfg.context_cnt = None
         cfg.ethnl = EthtoolFamily()
         cfg.netdevnl = NetdevFamily()
 
-- 
2.48.1

