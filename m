Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977520;
	b=DvV/3Cmq4sHXQOeDV0K2gv/PizhgRGj6+iF/145940M2hY9feVFnc/m4AYwGvDeWFSZP
	 wrW6EM9+an442PydUaT6k7ANn/ZVJsh+fqrOvIgFm6FKnArIS5Gzy3OtjF+hu6YF/SP2/
	 pJJG3eQIJbn2Y0Pk+NTCe1QbSLVpvq6MlTSh1bMAhI3e7jvMybhbeBtT2XOikWYATt50e
	 UVR9sPemXCKfePofK5ZI650xKcnHKj2ZrwdAQ2oEv9DXy49CuRpaFIE3CQiFGQvDJEe+4
	 I+H1VsrnLeHL8U1BDtn+KzzG43VY89ZUYQzoGBNrAtGJ7a5Cpooj552XKmJJeSum8RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977520;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=U82LHASiAr83JwdwBGkkuU7MAKcYuAuWVXjLgmwYJF8=;
	b=b6xFsD08Fyt+oRy7Kpbzr9Oi/rslsgmZ9Dq1O1jUE9MW25nZT7l66tzVgVGFbi4wN2HM
	 SMPSMm2JH2NToBnuRJWA9+f4IQQbNj1/Xufw+n40XYI4rNan4bO7P7FHPO67PFnZoGt+G
	 U9hcEuyTQlQLgYWLrELDgg2HDd3QmL3XMU19s8ox/NAQKjNlEZbk+JZC5GI5EoCf86Og/
	 SJK+fT/chttsgPdkfKHjRw4ANuXIM/P+3CS0Pg8H+FhnB+CXXUoV672PgjxwK/GibzQCQ
	 rmbOVoJXeNgRhPHp00zQL9QugVgKPPdr7fuYqPH0Wp2hpfMtSVtAqIXSckyDb89LuPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wnMN4v8I;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90205606A329
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 15:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90205606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wnMN4v8I
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4af520023fdso1796535e9.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 07:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793977519; x=1794582319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U82LHASiAr83JwdwBGkkuU7MAKcYuAuWVXjLgmwYJF8=;
        b=wnMN4v8IicuRoOIY+cQIWmgkEU28aZVziS3NC9QX2/q9eLFG1CRwLpF9XQ0cTigo+K
         LzD/MAi6gvXsC0SV21woKwsiIVE8TcwjPXo+bRBLrA1LYpEG9dZTimRP0YkcI2ODKFhn
         JHsVyd278vsE/CSs3PdIbtZY9FDbzU9glU1/y0+/XkzBZq0jk4PEJQoU5LGwN5dm9Ga6
         F5xqrM/I/jsosBM3Rkj+kZKeDXmwCoziF4yMFBKR2SeMApHPIbh7QmI0qH8jN29/k3d+
         7r1l8upBf5B9nw+QB2Jd8ZLYyE4aLh/691SJ9UP/Opug284K8H4EoqLzZWuvPTJ7TUFW
         NYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793977519; x=1794582319;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U82LHASiAr83JwdwBGkkuU7MAKcYuAuWVXjLgmwYJF8=;
        b=QoUYv/Tia1wdyVzbyRKtQvMqKfdP6K07CwB0kaJEAndMsPz/ziD0q0QQ42P/Ab0mEW
         OIGwk9JFITgT2m74dwurWovczMC0O8DXY0CUzKYxsopF4yCDI4dephGxsViKCCAdNe6W
         lIesQ0ZpCZWLW7FOsUvnAQWa4pEIooWDknGPfnqoEqY9rwAxFB5rVu7Jr2eGY8K9DiG0
         aC/7Em0tgNVojUzq9ZTg10tw8PNqYHn4VyOrsvdZGg2e4MfgH2rH1YONbgFtCYFhMQm4
         +L3oYmPgt4N7IVOKWaGXQJT+1yrhTXj9idES4Oy/svMLYYA4Neh9l4dcE3CYQcwmVqcR
         ujfA==
X-Gm-Message-State: APuU4Z9DfK/UKxTZc6MH1lWjAFlYgfmfnuHJGwbjo/IRdCkwINAzru+F
	PWWuRPPgdi6PTta64x8x9xxhiURbSm2FBKUWCPgE0jnLgz7Us71qNACrgOhPKsOW
X-Gm-Gg: AYBFou2oVyF9B4/dh5p1zbQz/4fYECKUbvq/6KlRM0qbteCoLMLiZIsZvI+rqWmY+ea
	hHdKC2X1k5sysRMCg56J5O038gwEJqf0DcLZv+ig+zvRyGqL/F2ttJwMfH/PTZF8vLPWNrpr04G
	2YAFx2qmzThULJve1zRRJFCw89p3p740tlm15yb18TZHmuWs8wDiEjRmXR8fHK9I0KIJ6KVOQgj
	xABX0iZRU1nDlMyRpPrx1/LRxG87GrIl+wwOQ1UOSARbMB7WPcoz4OQnGCMUciG/JH1xo3oGek7
	PTu+AAoo6h+oJAMyAj+zr0dMtlhTMBx3ZWNaz6CjKeOL18VQrLgWdWjCbxnNWBuVumUcOYoTGoF
	9MHdvTrdpyWYe1XKk3lxe7lFDJ8/7BRoTXIpHQqi+/gfF+BQwRzlQBBFpnkr1+Jmo7ud8AFvtve
	x9Xf3GLPYEr86KJ1si+btflG1PvYtoY+ahByJVXBKs+GX8zl0Gg2GQUTeLwKQfGiaqz6UQePW6j
	RfFyyp3tzPbb/aDFI/KrqAqPYjVtz5oRe2Q9IETtxqUrBeNuah7YlDYsRso+Fi8RhkukZWCu4Wg
	B3fIoEqoUnXkm+7w17XKgwUW6RBa5Qby9d2czR8iv3v124U1Yy93NOIx3hZeYyShxHoeqfnV
X-Received: by 2002:a05:600c:6d8f:b0:4b6:2242:d0be with SMTP id 5b1f17b1804b1-4b6d82b2c85mr38024365e9.0.1793977518886;
        Fri, 06 Nov 2026 07:05:18 -0800 (PST)
Received: from localhost.localdomain ([193.255.169.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56e58fcc6sm260950305e9.2.2026.11.06.07.05.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 07:05:18 -0800 (PST)
From: =?UTF-8?q?Bilal=20Yaz=C4=B1c=C4=B1o=C4=9Flu?= <ahmetbilalyazicioglu@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	hmohsin@meta.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Bilal=20Yaz=C4=B1c=C4=B1o=C4=9Flu?= <ahmetbilalyazicioglu@gmail.com>
Subject: [PATCH net 1/2] selftests: drv-net: ring_reconfig: handle devices without channel config
Date: Fri,  6 Nov 2026 18:05:08 +0300
Message-ID: <20261106150509.30458-2-ahmetbilalyazicioglu@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106150509.30458-1-ahmetbilalyazicioglu@gmail.com>
References: <20261106150509.30458-1-ahmetbilalyazicioglu@gmail.com>
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
e1000e) make ETHTOOL_MSG_CHANNELS_GET fail with -EOPNOTSUPP. YNL
raises that as an NlError, so ring_reconfig reports two failures on
such devices:

 - channels() fails on its first channels_get call, although there
   is nothing to test;
 - ringparam() fails in _configure_min_ring_cnt() before any ring
   size is tested. The helper only reduces the channel count to
   speed up the reconfiguration, ringparam() does not depend on it.

Skip channels() and return early from _configure_min_ring_cnt() when
the channel query is not supported, logging that the channel count
was left unchanged. Other netlink errors are still reported as
failures.

The issue was found through AI-assisted source code analysis
(OpenAI Codex) and confirmed on a ThinkPad T480 with an Intel I219-V
(e1000e, 8086:15d8): "ethtool -l" fails with "Operation not
supported" while "ethtool -g" works, and running the test functions
with the in-tree YNL library against the device fails with NlError
95 (EOPNOTSUPP).

No remote endpoint was available, so the full test was not run. On
the same machine the test functions were run under ksft_run with a
stub environment and all ethtool set requests blocked: channels() is
now skipped and _configure_min_ring_cnt() returns after the channel
query. Behaviour on devices which support channels was only checked
against an emulated ethtool family.

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

 .../selftests/drivers/net/ring_reconfig.py    | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/ring_reconfig.py b/tools/testing/selftests/drivers/net/ring_reconfig.py
index 6682d4badfb..baac20e8d3e 100755
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
@@ -88,7 +99,14 @@ def channels(cfg) -> None:
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
-- 
2.56.0

