Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327274;
	b=kJJSSotUQyUysJVj3825fEv7FbN0C8i3gyH6vF880pQtjiccYFT65JMDjCccCAgjdXLn
	 7oLvMKX822JAsBODquizedqKoXsiiGb26T/PBi0rO8fKTDXg8h2/bVrRglxXvC5z6vrz8
	 p0bXHtw73KeEwJiYMpZes9UuOSylQvT7RpzuWkLPkG20fTfiq02t9m4Q/gUXCGsY3bLOJ
	 pEfLi0sGGbwqVRvOwwuvcw4T2I/Hsjqp2LC/mC7IpyFJ8kQHnbqCM8oaVeMPvoAT9EKKI
	 XgqrNQxekZM8Krq4k3LXsCnT9DKaTbfeoLKsoOqr6Hnx9gUw7x/1CCD8s0iMemC0GdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327274;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=v9Q/EWwiGYuJJkjQiR3cjpmLENNTVIh5BhWTJNSgmuo=;
	b=DBSwA9HudhtiKEaCg7GETs+9sprCsGae+XXtCTu7j0wYqn5cfDIxcB4gcwjVRJmwkedV
	 0LdLUOXCCz8vUe6WsEuFw6XbNPuwlZABPoyUWCJu7GKmSpQTVE8b1Ytg5wSkR0szEO58A
	 X41wMwNB7LyGgHMtShnWZBM2zbTizsN4sJma+OCpjZFWUCdeBGA+ATqiZnrioxYFPKg6R
	 xaX41TcIE5JLTsNHEmTMHzhvCV49Yf0u/tEfDNExwyp/NB0JJPN3naQSQEmIz/IDiQQt6
	 LcU6RGX1kaPEhVhj1Ubl9k5/hsDGGmlvnBkJhzTed1BO7RI2KgjN5MYrrb8wKHzwVEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ANrbdB3G;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E79D60A261D
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 16:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E79D60A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ANrbdB3G
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a56e05568aso5749455e9.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794327273; x=1794932073; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v9Q/EWwiGYuJJkjQiR3cjpmLENNTVIh5BhWTJNSgmuo=;
        b=ANrbdB3Go4OWSCgoHQhcZfpH3ER0+YbD7LsUE/pK48Qm5h+NUSsTOLmM3gxO9NL5lA
         ZKVKd/YHPpAq8U2GunH7+iAAl3JnyP2anpuIP5Dz8Vp25s8Wh3Nv/kFc2+0TVRX75dQl
         sFCRn9agjqsTk/OuQYnMHIMrVTOAsz+Z+AlmlCAYm9XL/H3lABFVa8SEi0jPK8tWcURN
         9uBPBA/45vdVFshrAw3AB8cZ51b3zWOOE52cRxP9OjhibwQBSqt1SmKg6SGqMPuaMyxo
         0sOtGeotvCSJxzlgrgYyzFqWTIxo11MrWjWcOKa+WyCFmC9L24N3rWc7d3x7EuEAsPLE
         85rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794327273; x=1794932073;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v9Q/EWwiGYuJJkjQiR3cjpmLENNTVIh5BhWTJNSgmuo=;
        b=nGe5VTAlqpekJoKIiksYPEU4p5yg+3hvacy78/qUn7wi6UtxbH0F0Km/9OJwIiluzd
         w5iAQYA+CMKdgJvTt+zI6M7yydh5WJNeMomW1LJuOdfwzP0CimyE7Ami8EJmimCGvYU7
         ftIhBMx3GEqJjWNJ5TER1APYM8lgNYC0t0pEcyTJLcbW9YL7QC0T1Yw8XVwz1TGDrR3M
         aFvR3pKx+gDXKh1eJ2ZGIAIZqFPeTIStJFmMIb+8mYTrWkCyMeCHNW15II4Nf6pBhEw1
         zOVjP6d0LfZK/7nGOHdzZL3Utz4tWoHirtXoDaRRbyDeMUWStIKPxkNl6OFy+PXIY+75
         pCfA==
X-Gm-Message-State: APuU4Z+ZCsyD7BhPqZLUZqhNYcVNhe+AIJuaFYcaLmahxsPfcl//9V3N
	/iBJqUKay7uPjqipJTDPJUYtMXAi8rklzBCCZ02Me0Yg3IlejRflpkBjQVPr6QI5
X-Gm-Gg: AYBFou0hzgF6reCFDPELUvGfSQvT6pm7GNkNg+nuT/ZGXvoj0qQ9kFGfWsbQXFSOKlU
	0ueEmhPXFeUfDBWzBNZlsODtyCdq3NguT8AikOPo5gTf4hlXC7sGcnq2mYGzOkhI3CLXyYYh0fZ
	nIoLq15RzzgFoeUhZDtgkEqYPckxEWhEptHencce26cInJvqW/QN1lvsDfpa/mOvmn36SgTklxL
	K0KAUVzf2FRkbMO3sD0mMfyiRYc/h9AXMIuRXBch71W80o+0EAhp11O2R++EysmXSsCq86tDdvJ
	THd5hX80PiF0PKdnFLTuQP2q6zR4LCSq1o68nXwoelK/pbnUUkjbk7hanngQBDn1p+V2kKdJvL3
	mv1U9YviVXE+IVDGcEQhmtzLXZ5WmQIFyQ+zJLFK981uyfw1KC7pZxvvGDaY7qigGvyZk6wk4ae
	C1jKqJIhhyNipyEicHCu1h8sgmXBf1+nHulkpHntDhPeqNeX9TwjWezQUPTIPsFwcQzzzHY/sCF
	Nd0AHxXucwk3H0Swt2yoC4WoQM5jtfsQ0pQbjqoLdQDIKyeo3J7m6yIDZCkKeVbMrSsFPBOYHgF
	rVoaeArCKJFAr+eCdjRAWAovV8R+cQUlPBFLLjjRu9XlHUpTc51+Q1s8E6ogftALWImYBSEQ
X-Received: by 2002:a05:600c:4812:b0:4a2:417:7db5 with SMTP id 5b1f17b1804b1-4ba0233982cmr34471415e9.2.1794327272780;
        Tue, 10 Nov 2026 08:14:32 -0800 (PST)
Received: from localhost.localdomain ([95.183.147.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0235ef62sm46825525e9.2.2026.11.10.08.14.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 08:14:32 -0800 (PST)
From: =?UTF-8?q?Bilal=20Yaz=C4=B1c=C4=B1o=C4=9Flu?= <ahmetbilalyazicioglu@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Mohsin Bashir <hmohsin@meta.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Bilal=20Yaz=C4=B1c=C4=B1o=C4=9Flu?= <ahmetbilalyazicioglu@gmail.com>
Subject: [PATCH net v2 1/2] selftests: drv-net: ring_reconfig: handle devices without channel config
Date: Tue, 10 Nov 2026 19:14:22 +0300
Message-ID: <20261110161423.77910-2-ahmetbilalyazicioglu@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110161423.77910-1-ahmetbilalyazicioglu@gmail.com>
References: <20261110161423.77910-1-ahmetbilalyazicioglu@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Drivers which don't implement the ethtool get_channels op (e.g.
e1000e) make ETHTOOL_MSG_CHANNELS_GET fail with -EOPNOTSUPP, and
drivers which implement get_channels but not set_channels (e.g.
vmxnet3, r8169) make ETHTOOL_MSG_CHANNELS_SET fail the same way. YNL
raises that as an NlError, so ring_reconfig reports failures on such
devices:

 - channels() fails on its first channels_get call or, if the device
   can't change channels, when restoring the original counts;
 - ringparam() fails in _configure_min_ring_cnt() before any ring
   size is tested. The helper only reduces the channel count to
   speed up the reconfiguration, ringparam() does not depend on it.

Skip channels() when the channel query is not supported, or when every
channel layout it tries is rejected with -EOPNOTSUPP; nothing was
changed in that case, so the restore is dropped. Return early from
_configure_min_ring_cnt() when the channel count can't be queried or
changed, logging that it was left unchanged. Other netlink errors are
still reported as failures.

The issue was found through AI-assisted source code analysis
(OpenAI Codex) and confirmed on a ThinkPad T480 with an Intel I219-V
(e1000e, 8086:15d8): "ethtool -l" fails with "Operation not
supported" while "ethtool -g" works, and running the test functions
with the in-tree YNL library against the device fails with NlError
95 (EOPNOTSUPP). The get_channels-only case was reported by the
Sashiko AI review of v1.

No remote endpoint was available, so the full test was not run. On
the same machine, an earlier version of this patch with the same
channel query handling was run under ksft_run with a stub
environment and all ethtool set requests blocked: channels() was
skipped and _configure_min_ring_cnt() returned after the channel
query. The handling of a rejected channel change, and devices which
support changing channels, were only checked against an emulated
ethtool family.

Fixes: ecca75ae5ae6 ("selftests: drv-net: replace the nsim ring test with a drv-net one")
Signed-off-by: Bilal Yazıcıoğlu <ahmetbilalyazicioglu@gmail.com>
---

Notes:
    Note, not part of this fix: with this patch ringparam() gets past
    _configure_min_ring_cnt() on e1000e and reaches the ring size loop.
    e1000e clamps ring sizes below 64 instead of rejecting them, so the
    check that the requested minimum was applied is expected to fail on
    that driver. I could not run that part (it needs a remote endpoint),
    and whether the test or the driver should change is a separate
    question.

 .../selftests/drivers/net/ring_reconfig.py    | 45 +++++++++++++++++--
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/ring_reconfig.py b/tools/testing/selftests/drivers/net/ring_reconfig.py
index 6682d4badfb..c7491154d1d 100755
--- a/tools/testing/selftests/drivers/net/ring_reconfig.py
+++ b/tools/testing/selftests/drivers/net/ring_reconfig.py
@@ -5,6 +5,7 @@
 Test channel and ring size configuration via ethtool (-L / -G).
 """
 
+import errno
 import socket
 import struct
 import time
@@ -26,6 +27,16 @@ MIN_TX_RING = 32
 MAX_TX_RING = 1024
 
 
+def _channels_get_or_skip(cfg, ehdr):
+    """ Get the channel config, skip the test if the device has none. """
+    try:
+        return cfg.eth.channels_get(ehdr)
+    except NlError as e:
+        if e.error == errno.EOPNOTSUPP:
+            raise KsftSkipEx("device does not support channel config") from e
+        raise
+
+
 def channels(cfg) -> None:
     """
     Twiddle channel counts in various combinations of parameters.
@@ -33,7 +44,7 @@ def channels(cfg) -> None:
     if the config is accepted and crashes.
     """
     ehdr = {'header':{'dev-index': cfg.ifindex}}
-    chans = cfg.eth.channels_get(ehdr)
+    chans = _channels_get_or_skip(cfg, ehdr)
 
     all_keys = ["rx", "tx", "combined"]
     mixes = [{"combined"}, {"rx", "tx"}, {"rx", "combined"}, {"tx", "combined"},
@@ -47,21 +58,26 @@ def channels(cfg) -> None:
             supported.add(key)
             restore |= {key + "-count": chans[key + "-count"]}
 
-    defer(cfg.eth.channels_set, ehdr | restore)
+    restore_chans = defer(cfg.eth.channels_set, ehdr | restore)
 
     def test_config(config):
+        applied = False
         try:
             cfg.eth.channels_set(ehdr | config)
+            applied = True
             get = cfg.eth.channels_get(ehdr)
             for k, v in config.items():
                 ksft_eq(get.get(k, 0), v)
         except NlError as e:
             failed.append(mix)
+            if e.error == errno.EOPNOTSUPP and not applied:
+                unsupported.append(mix)
             ksft_pr("Can't set", config, e)
         else:
             ksft_pr("Okay", config)
 
     failed = []
+    unsupported = []
     for mix in mixes:
         if not mix.issubset(supported):
             continue
@@ -72,6 +88,13 @@ def channels(cfg) -> None:
             config[key + "-count"] = 1 if key in mix else 0
         test_config(config)
 
+    # Every config was rejected as unsupported, so nothing was changed:
+    # the device reports channels but can't change them
+    attempted = [m for m in mixes if m.issubset(supported)]
+    if attempted and unsupported == attempted:
+        restore_chans.cancel()
+        raise KsftSkipEx("device does not support changing channels")
+
     for mix in mixes:
         if not mix.issubset(supported):
             continue
@@ -88,7 +111,14 @@ def channels(cfg) -> None:
 def _configure_min_ring_cnt(cfg) -> None:
     """ Try to configure a single Rx/Tx ring. """
     ehdr = {'header':{'dev-index': cfg.ifindex}}
-    chans = cfg.eth.channels_get(ehdr)
+    try:
+        chans = cfg.eth.channels_get(ehdr)
+    except NlError as e:
+        # Reducing the channel count is only an optimization
+        if e.error == errno.EOPNOTSUPP:
+            ksft_pr("Channel configuration unsupported; continuing ring test")
+            return
+        raise
 
     all_keys = ["rx-count", "tx-count", "combined-count"]
     restore = {}
@@ -107,7 +137,14 @@ def _configure_min_ring_cnt(cfg) -> None:
         # looks like we're already on 1 channel
         return
 
-    cfg.eth.channels_set(ehdr | config)
+    try:
+        cfg.eth.channels_set(ehdr | config)
+    except NlError as e:
+        # Some drivers report channels but can't change them
+        if e.error == errno.EOPNOTSUPP:
+            ksft_pr("Channel configuration unsupported; continuing ring test")
+            return
+        raise
     defer(cfg.eth.channels_set, ehdr | restore)
 
 
-- 
2.56.0

