Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9459D3E5594
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 20:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791578839; cv=none; b=BWCtEocVvgIibWYLeVp+SRsPnfD5SKsvqnojr4feo+S0z8YSWbwYSupLXsTSXlYyHb3PvzUXKP6q0SG2ugU6+nt/sIwq+RlX+GODR4tyeP4nPmHI1W9oVoVBDR4hQeT+mKSUt7CtCmiZxpVA1tjhqEMW2HAs0U7+LQIUM1OUlL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791578839; c=relaxed/simple;
	bh=LBwl+SzL4uAe4dJCVrnFKcpS3FQeoy1u1iGROM2mTIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BUmu8schO3EksRjTKMUK6nqMFs1/VdvD3w4pr70lGNA/yUpKpPxeeutVa5cpsk3SqzGIj083aH496oUpEWQVtJa37Qnt/R6zmcQP9EuO3qL3d5mf6o22DbQJjFAhOLb22PhGcTO/MwnvV2ypa7lh+UHrnpSfKfSvgaB1/u22eVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNtxPOLJ; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNtxPOLJ"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-822ddb835fbso175745a34.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 13:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791578836; x=1792183636; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rkPDFYijzQZJ2NGaKP+B4N2cwOmAwTIMH1IeAG6Lc2Y=;
        b=UNtxPOLJZfM0oJ4th9IJfabEiQJssKNwXnM3t/hCUDh22zqDfLVndDrhHLG/10NcmD
         4Ob2slwhVQKkfjayiGwtEL2vEoGvgkXlLLqWoAI5NnQnDu96Y/cLLCR1v3Dy6wbBcrPq
         ol4wap2uwpOWNqCOE2VBc10d/u6e9SWLZdKVeve1TVUIaBCWgSY0CAK09afrM7S83sme
         ttO9s0tEai6PfSxRSCSJQmvBinAWLmgviWClXWoGhAU/kkWPWvlrHTZoE5aomLSbBrDa
         1PnkL+Yg7jem0btdlGq4CsaZ103wSAz3k/3CZtBz5AIrDW6oEnmnTIJT7rlX61RKicq0
         sRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791578836; x=1792183636;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rkPDFYijzQZJ2NGaKP+B4N2cwOmAwTIMH1IeAG6Lc2Y=;
        b=fd+1jV53TDG/Yc+npwGDoQ3Fa9HfQdmv09lFVDIyx3AnTeEjtMXJHSg3w1fKNCyqw/
         Xh9TV4mACU8gULHCkMkPx/FqcHWoyDsfHmB7ULAXJwy+wtIc2bcvCa35Y+yyGgZdXsX6
         yZvt8Ux/psILro07TOv8b2XjAFCjW0WTjz4Ce8L9IYJpk91xI9JZkrudiklxJxDcrQBo
         2MIGtlEDU1YyCsuSRlX3mD76Wd4BX17gf7i7Uqyd4ZP8iVJyapad15SloFWpbfJZ941Q
         z36cK/JQTgWoWJMx5qDEaj/g6aE4cExy8DpJ82RWfh5Eb5Ws8/NEZ5MBzH0hTC41QOdx
         tKMQ==
X-Gm-Message-State: AFuF++mEuv6cideJtETNYJ1cuDs6fRgYIOoZLraxE6ueiU47YvTC/rGU
	ooYKhbOp68GO0tchSuJHgGL0nRuscPwT+4ybnpTK5B9lRLw4YeBJWTlm
X-Gm-Gg: AYBFou22hg4uhM01m1EnFEhigepqGLuYhdJOMcIj7db9pmn+FaRwJ8KTzQkc32zH+1P
	S7iTnRocbQgdqePlUM8I5L0peniXQ/2Z8hgnc3pU11m+2FOwp7AD0VahNZ9bG08dlIZ8aAAGR+j
	amLVmxnVKrYiw0X7YDDRipHNcY/5pqwL/POks82CxSgG/3CPrHDtNxiX3cyM8E04NKev7EIgr/d
	go3+HoPuel+Rpyqui/Sue9FYsiJhgZyQpyzTqyMjpZT4CxF7C2/gd+gDFEcjPfFf1++oxUl/bja
	6faLjHzQe5AHdvVyBdsCva/xkV7LQg4cAJ/oKOQNgN0J29YbsiayIbUZ/rG4ukNk0Mn2tjXii0i
	b0DeK7mjnDRy7BWPLG6I3zq8ejNH9V8D6ayCkIrJfgdkEUdvGJwhmH2DeAfvivm5CecjWdzbtyi
	aW29G7ExvF5EUIiqHs+xbMMxiZT3hMEeYoyhjwEpIO4Ek5R5RdXNd5otGoLQNHZfNM9oc=
X-Received: by 2002:a05:6830:6d45:b0:822:978:f7bd with SMTP id 46e09a7af769-8309815eac7mr2560571a34.28.1791578836162;
        Fri, 09 Oct 2026 13:47:16 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-830385ba23csm2799922a34.7.2026.10.09.13.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 13:47:15 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Fri, 09 Oct 2026 13:46:47 -0700
Subject: [PATCH net-next v2 7/7] selftests: drv-net: psp: add a tx rekey
 drain test for SADB drivers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-psp-v2-7-5596ab50f677@gmail.com>
References: <20261009-psp-v2-0-5596ab50f677@gmail.com>
In-Reply-To: <20261009-psp-v2-0-5596ab50f677@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.13.0

Drivers that export the tx-key-count stat, should drain queued tx key
deletions in a timely manner.

Add a test that performs multiple tx rekeys on a connection and waits
to make sure tx-key-count returns to pre-rekey level.

There is a bit of noise in tx-key-count due to stale timewait sockets
from prior tests. If these sockets die between the initial and final
readings, it could only serve to cover up for a queued key deletion
that is not actually drained, so the test should not flake, but may
fail to detect an actual driver bug.

This test will likely not work if other processes on the system are
using psp on the DUT, because then the tx-key-count will be completely
unrelated to what we are doing in our tests.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 tools/testing/selftests/drivers/net/psp.py | 38 +++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index af67c9e8c40f..b22891b7f5ce 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -15,7 +15,7 @@ from contextlib import contextmanager
 
 from lib.py import defer
 from lib.py import ksft_run, ksft_exit, ksft_pr
-from lib.py import ksft_true, ksft_eq, ksft_ne, ksft_gt, ksft_raises
+from lib.py import ksft_true, ksft_eq, ksft_ne, ksft_ge, ksft_gt, ksft_raises
 from lib.py import ksft_not_none
 from lib.py import ksft_variants, KsftNamedVariant
 from lib.py import KsftSkipEx, KsftFailEx
@@ -30,6 +30,8 @@ TCP_ULP = 31
 
 _PSP_MAX_KEY_LEN = 32
 _PSP_ASSOC_MSG = f'!IB3x{_PSP_MAX_KEY_LEN}s'
+_TX_REKEY_ROUNDS = 20
+_TX_KEY_DRAIN_TIMEOUT = 5
 
 
 def _get_outq(s):
@@ -202,6 +204,19 @@ def _require_version(cfg, version):
 def _get_stat(cfg, key):
     return cfg.pspnl.get_stats({'dev-id': cfg.psp_dev_id})[key]
 
+
+def _get_tx_key_count(cfg):
+    return cfg.pspnl.get_stats({'dev-id': cfg.psp_dev_id}).get('tx-key-count')
+
+
+def _wait_tx_key_drain(cfg, base):
+    cnt = _get_tx_key_count(cfg)
+    end = time.monotonic() + _TX_KEY_DRAIN_TIMEOUT
+    while cnt > base and time.monotonic() < end:
+        time.sleep(0.1)
+        cnt = _get_tx_key_count(cfg)
+    ksft_ge(base, cnt, comment="tx keys not removed from device after rekey")
+
 #
 # Test case boiler plate
 #
@@ -730,6 +745,27 @@ def rekey_tx_basic(cfg, version):
         _close_psp_conn(cfg, s)
 
 
+def rekey_tx_drain(cfg):
+    """Test that Tx rekeys do not leak keys on the device"""
+    _init_psp_dev(cfg)
+
+    if _get_tx_key_count(cfg) is None:
+        raise KsftSkipEx("Device does not track Tx keys")
+
+    s = _establish_psp_conn(cfg, 0)
+    try:
+        data_len = _psp_txrx(cfg, s, 1)
+        base = _get_tx_key_count(cfg)
+
+        for _ in range(_TX_REKEY_ROUNDS):
+            _remote_key_rotate(cfg)
+            data_len = _rekey_tx(cfg, s, data_len)
+
+        _wait_tx_key_drain(cfg, base)
+    finally:
+        _close_psp_conn(cfg, s)
+
+
 @ksft_variants(_get_psp_ver_variants())
 def rekey_both_sides(cfg, version):
     """Test rekeying both directions"""

-- 
2.52.0

