Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749925;
	b=v3AYdSSoOa6YvWL9szM+DcoFXPHvUM1ztcTUFqT5ZaP68oKshGWyRORJ/epozZypT/il
	 Hhpqoi8yfmyv69At7XkfVR6N31biedT9VvdoYtQiC/IK++lHn99Q6me2s5HuNegfnWnf1
	 R8/r9ydr11AwLNREPNC505y/sNm/gsezrrYsbybWtD7HGEfkXIkKseXqHDRf0pyRyM3Gu
	 Xv3lyOV2ZI+M61oA2DrwyAI9Auva7zWKIZ4NB1t5WoemlnldAvOFUR5CSDWa+AvPsmaGx
	 1IAYj2E2AeP0vlNcCYpoxS5CQvVh0ba9+3PvrqsR4JeHZffQ9wPIj4n91Y1bfzXPWWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vBGiLdfaTr9hhPWxjFFaBCZdoDd+HhXRj6UFEZuYlTU=;
	b=LCvtCyPOTRs/c2z2brcxxfp7BS7h1RRHF/fyl9y+UOk15kGLc2jwMqFZAFmDK5Iz5v0Y
	 eCeBTiYoy6rTorjEj+iUkS9hUtnBzILOI92kabkRyf1Yq6QbN/h/tbifekbzbxVSOc2/9
	 ZPnfwhnQChNmNF04MY1An2r/g81cydPPKhE5GDwz3bynwHRU6JasV6ky3+E4L/uhQpfuM
	 c2aCfCZOM/Sc577sEYKJw8oUzB4WxLzSFWSSMyvZFmO+EzaQ0lggHG/NGar3vrraY3IQ/
	 iZ+k5A8t7I5oI1P9b2T7aNOUgGVXakW6F1+3Q56GBv0/GPd6EU+pUK3GBVeyLOH+5dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WDRMCzvo;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EE3606EEB8
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 23:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89EE3606EEB8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WDRMCzvo
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-33e5ae86ff2so50058eec.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 15:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749924; x=1794354724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vBGiLdfaTr9hhPWxjFFaBCZdoDd+HhXRj6UFEZuYlTU=;
        b=WDRMCzvod3HTozLLjk/B48nlT5cptk0mG/sIVgS5fVibcDhNkbqVIc4w215KyXlFJB
         8AhyQQNckQBGcIHaAWxZbp79JwSImP/0XQz/+I9czi1M7oW17k69Vvik8+bY6fANKB75
         65lr4qomcTlEG78i2sivwZRKMqY9VdmO8ELlaYv4gqNTtMyL+jZ2n14C5nPZAXsV1nuy
         6m9+1lc0SUwbkZnoxKUUsG15Lam+sYfnLIVUtYSYGppQ1GBLjHMCdN9+zTwtO4aQL/XE
         7TKqA770YIdt++Fuya9qB6Ct3MkoQBn0easqqLQR+n4kxdMQZ0mFlsagH6+gtpq51bQa
         eCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749924; x=1794354724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vBGiLdfaTr9hhPWxjFFaBCZdoDd+HhXRj6UFEZuYlTU=;
        b=2DG2ZeN2ZRoZgKN4xynl7xdGrFyxKf2sHlvwpAoXu82LHp+WzuYRtoJ0CZCtrD1fQ9
         9XQOJGKsMz5IWGWUvFo7k6uQE7uJ/6oy/JcrnxbU51sJ87aPBaOqIT0B9aW4dtZ2YV16
         Jp4CTcOUVjRjZx6f4bJ8iTF7hgYKCva8d5Pf4tADX42O/4rgwbEJIQi3PlGsEKoo92H8
         jfzdeQyMAKMWwlMR3tdXCJk1z6RGfMTaZH/MEuwB25/Sgw8FT8g95qoPt0J8kreS+45K
         17GZC73POyMyBpp6BnZYgWq/HcBvpUiStCQGrjsZh3h6XxVGsAwbFtyFCp/e4z1S5rCS
         ta4Q==
X-Gm-Message-State: APuU4Z+P2s483K+kGSGGX1SAtNGQiIRMIum2RQiEbMrrbrnm0ubtLVAr
	wvan7spkTWJ6Yh7K5BmI7DiPj6nguntbJXtbt6Otmpknd5upj+PT2weRdNb6V8GA
X-Gm-Gg: AYBFou2UD3WESvWUS6HioC1xRcMRbG42hilRmP8sOQjXsOiCxOqEAFxRhq19RqXTSLZ
	pYIDaDzV4zzztPLrPT4u6u3cr7J/yuPaNMznp1DOurjIyJypiY3oY1yvb1etZtw8Wie9EhjjXKf
	Jr/2BsAZZoP4cOtixUcFqOIMgv49VII2Np+A+bqWzHf2ecKM/WE56/wLPMeSt1UFgW7dgHruffr
	qGopPMXtRO8eXh1cJV1/aGilpehH63bCDHPOCG/Ci+e/mPRGo6zkjYqx0v7Pr7uLeyWJi+6VoyT
	+yVqL/iPztdjPSrV3nWoxXi7pm0tOMRGrlfFuj5FpsgXFIE/1RtBuHz8Mx6nk5ObdMin1X1+RJe
	O7YeK9VJLuBPJBmRIE2dEjrxGufSmgLUS4RBERgnf/CVKcnmS1JmzfQ7SpVYEgi0/A5KlROFjDz
	El2K4xdbuyAHQS4fOcteFN8LFOwew74f5kGQTIFvZUGUxX0r4csWYaODu7lKGhe45n1bJTJjNTe
	Z35hyfxNUJpu4c2zncoOwyfui42zrTvSSid0o7oA4bYlwiKWGQseW0d7M8nPRmoQck5tlOn6xA9
	9PnMC8FTskWvPPK7NdsSzr8=
X-Received: by 2002:a05:693c:88d7:10b0:36a:1f8:a589 with SMTP id 5a478bee46e88-36a4240abf8mr21688235eec.27.1793749923582;
        Tue, 03 Nov 2026 15:52:03 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:73::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3989670sm1929806eec.25.2026.11.03.15.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:52:03 -0800 (PST)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	edumazet@kernel.org,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	bobbyeshleman@meta.com,
	asml.silence@gmail.com,
	razor@blackwall.org,
	daniel@iogearbox.net,
	leitao@debian.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 7/7] selftests: drv-net: devmem: TX from a hugepage-backed dmabuf
Date: Tue,  3 Nov 2026 15:51:52 -0800
Message-ID: <20261103235152.1904727-8-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103235152.1904727-1-sdf@fomichev.me>
References: <20261103235152.1904727-1-sdf@fomichev.me>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TX net_iovs are now sized from the dmabuf layout, but the TX tests
use a regular memfd, which usually keeps them small. Add -H to ncdevmem
to back the udmabuf with 2MB hugepages and a TX test which sends a 3MB
buffer from it, so that frags end at and continue past the 2MB net_iov
boundary. The payload has a 7 byte period to catch offset errors.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
Acked-by: Mina Almasry <almasrymina@google.com>
---
 .../selftests/drivers/net/hw/devmem.py        | 10 ++++-
 .../selftests/drivers/net/hw/devmem_lib.py    | 43 +++++++++++++++++--
 .../selftests/drivers/net/hw/ncdevmem.c       |  8 +++-
 .../selftests/drivers/net/hw/nk_devmem.py     | 11 ++++-
 4 files changed, 63 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
index 82c11ffc4add..aa7141fb36f7 100755
--- a/tools/testing/selftests/drivers/net/hw/devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -3,7 +3,7 @@
 
 from os import path
 from devmem_lib import (setup_test, run_rx, run_tx, run_tx_chunks, run_rx_hds,
-                        run_rx_large_niov)
+                        run_rx_large_niov, run_tx_large_niov)
 from lib.py import ksft_run, ksft_exit, ksft_disruptive
 from lib.py import NetDrvEpEnv
 
@@ -36,12 +36,18 @@ from lib.py import NetDrvEpEnv
     run_rx_large_niov(cfg)
 
 
+@ksft_disruptive
+def check_tx_large_niov(cfg) -> None:
+    """Run the devmem TX test from a hugepage-backed dmabuf."""
+    run_tx_large_niov(cfg)
+
+
 def main() -> None:
     """Run the devmem test cases."""
     with NetDrvEpEnv(__file__) as cfg:
         setup_test(cfg, path.abspath(path.dirname(__file__) + "/ncdevmem"))
         ksft_run([check_rx, check_tx, check_tx_chunks, check_rx_hds,
-                  check_rx_large_niov],
+                  check_rx_large_niov, check_tx_large_niov],
                  args=(cfg,))
     ksft_exit()
 
diff --git a/tools/testing/selftests/drivers/net/hw/devmem_lib.py b/tools/testing/selftests/drivers/net/hw/devmem_lib.py
index 71b916c16196..8058fd1ddd50 100644
--- a/tools/testing/selftests/drivers/net/hw/devmem_lib.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem_lib.py
@@ -2,6 +2,7 @@
 # pylint: disable=invalid-name,too-many-arguments
 """Shared helpers for devmem TCP selftests."""
 
+import hashlib
 import os
 import re
 
@@ -42,15 +43,17 @@ NR_HUGEPAGES_FILE = "/proc/sys/vm/nr_hugepages"
     defer(_restore_nr_hugepages, nr_hugepages)
 
 
-def _probe_devmem(cfg, rx_page_size):
+def _probe_devmem(cfg, rx_page_size, hugepages=False):
     """Return True if ncdevmem can bind cfg.ifname at @rx_page_size."""
     probe_command = f"{cfg.bin_local} -f {cfg.ifname}"
     if rx_page_size != RX_PAGE_SIZE_DEFAULT:
         probe_command += f" -b {rx_page_size}"
+    if hugepages:
+        probe_command += " -H"
     return cmd(probe_command, fail=False, shell=True).ret == 0
 
 
-def require_devmem(cfg, rx_page_size=RX_PAGE_SIZE_DEFAULT):
+def require_devmem(cfg, rx_page_size=RX_PAGE_SIZE_DEFAULT, hugepages=False):
     """Probe ncdevmem on cfg.ifname and SKIP the test if devmem isn't supported."""
     if rx_page_size not in PROBE_RX_PAGE_SIZES:
         raise RuntimeError(
@@ -63,10 +66,15 @@ NR_HUGEPAGES_FILE = "/proc/sys/vm/nr_hugepages"
         # ncdevmem's queue range and cause the probe to fail.
         cfg.devmem_supported = {size: _probe_devmem(cfg, size)
                                 for size in PROBE_RX_PAGE_SIZES}
+        cfg.devmem_hugepages = _probe_devmem(cfg, RX_PAGE_SIZE_DEFAULT,
+                                             hugepages=True)
 
     if not cfg.devmem_supported[RX_PAGE_SIZE_DEFAULT]:
         raise KsftSkipEx("Test requires devmem support")
 
+    if hugepages and not cfg.devmem_hugepages:
+        raise KsftSkipEx("Test requires a 2MB hugepage-backed dmabuf")
+
     if rx_page_size != RX_PAGE_SIZE_DEFAULT:
         page_size = os.sysconf("SC_PAGE_SIZE")
         if not _is_aligned(rx_page_size, page_size):
@@ -169,7 +177,7 @@ def ncdevmem_rx(cfg, port, verify=True, fail_on_linear=False, flow_steer=False,
     return " ".join(parts)
 
 
-def ncdevmem_tx(cfg, port, chunk_size=0):
+def ncdevmem_tx(cfg, port, chunk_size=0, hugepages=False):
     """Build the ncdevmem TX send command."""
     if hasattr(cfg, 'netns'):
         ifname = cfg.nk_guest_ifname
@@ -182,6 +190,8 @@ def ncdevmem_rx(cfg, port, verify=True, fail_on_linear=False, flow_steer=False,
 
     if chunk_size:
         extras.append(f"-z {chunk_size}")
+    if hugepages:
+        extras.append("-H")
 
     parts = [cfg.bin_local, f"-f {ifname}", f"-s {addr}",
              f"-p {port}", *extras]
@@ -269,6 +279,33 @@ def ncdevmem_rx(cfg, port, verify=True, fail_on_linear=False, flow_steer=False,
     ksft_eq(socat.stdout.strip(), "hello\nworld")
 
 
+def run_tx_large_niov(cfg):
+    """Run the devmem TX test from a 2MB hugepage-backed dmabuf.
+
+    The kernel sizes TX niovs from the dmabuf layout. Send a single buffer
+    larger than a hugepage so that frags end at and continue past the niov
+    boundary.
+    """
+    require_devmem(cfg, hugepages=True)
+    _reserve_hugepages()
+    configure_nic(cfg)
+    netns = getattr(cfg, "netns", None)
+    port = rand_port()
+    size = 3 * 1024 * 1024
+    pattern = "abcdefg"
+    expected = (pattern * (size // len(pattern) + 1))[:size]
+    tx_cmd = ncdevmem_tx(cfg, port, hugepages=True)
+    # Hash on the remote, bkg() only drains stdout once the command exits.
+    listen_cmd = f"{socat_listen(cfg, port)} | sha256sum"
+
+    with bkg(listen_cmd, host=cfg.remote, exit_wait=True) as socat:
+        wait_port_listen(port, host=cfg.remote)
+        cmd(f"bash -c 'yes {pattern} | tr -d \"\\n\" | head -c {size} | {tx_cmd}'",
+            ns=netns, shell=True)
+    ksft_eq(socat.stdout.split()[0],
+            hashlib.sha256(expected.encode()).hexdigest())
+
+
 def run_rx_large_niov(cfg):
     """Run the devmem RX test with a large niov (rx-page-size > PAGE_SIZE).
 
diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index 918e3b51f3b8..e29ff27087e7 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -104,6 +104,7 @@ static uint32_t tx_dmabuf_id;
 static int waittime_ms = 500;
 static bool fail_on_linear;
 static uint32_t rx_page_size;
+static bool use_hugepages;
 
 /* System state loaded by current_config_load() */
 #define MAX_FLOWS	8
@@ -162,7 +163,7 @@ static struct memory_buffer *udmabuf_alloc(size_t size)
 	}
 
 	memfd_flags = MFD_ALLOW_SEALING;
-	if (rx_page_size > getpagesize())
+	if (use_hugepages || rx_page_size > getpagesize())
 		memfd_flags |= MFD_HUGETLB | MFD_HUGE_2MB;
 
 	ctx->memfd = memfd_create("udmabuf-test", memfd_flags);
@@ -1428,11 +1429,14 @@ int main(int argc, char *argv[])
 	int is_server = 0, opt;
 	int ret, err = 1;
 
-	while ((opt = getopt(argc, argv, "Lls:c:p:v:q:t:f:z:nb:")) != -1) {
+	while ((opt = getopt(argc, argv, "Lls:c:p:v:q:t:f:z:nb:H")) != -1) {
 		switch (opt) {
 		case 'L':
 			fail_on_linear = true;
 			break;
+		case 'H':
+			use_hugepages = true;
+			break;
 		case 'l':
 			is_server = 1;
 			break;
diff --git a/tools/testing/selftests/drivers/net/hw/nk_devmem.py b/tools/testing/selftests/drivers/net/hw/nk_devmem.py
index 61c6f31f01e5..799030db7c12 100755
--- a/tools/testing/selftests/drivers/net/hw/nk_devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/nk_devmem.py
@@ -4,7 +4,7 @@
 
 import os
 from devmem_lib import (setup_test, run_rx, run_tx, run_tx_chunks, run_rx_hds,
-                        run_rx_large_niov)
+                        run_rx_large_niov, run_tx_large_niov)
 from lib.py import ksft_run, ksft_exit, ksft_disruptive
 from lib.py import NetDrvContEnv
 
@@ -37,6 +37,12 @@ from lib.py import NetDrvContEnv
     run_rx_large_niov(cfg)
 
 
+@ksft_disruptive
+def check_nk_tx_large_niov(cfg) -> None:
+    """Run the devmem TX large-niov test through netkit."""
+    run_tx_large_niov(cfg)
+
+
 def main() -> None:
     """Run the netkit devmem test cases."""
     with NetDrvContEnv(__file__, rxqueues=2, primary_rx_redirect=True) as cfg:
@@ -44,7 +50,8 @@ from lib.py import NetDrvContEnv
                    os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                 "ncdevmem"))
         ksft_run([check_nk_rx, check_nk_tx, check_nk_tx_chunks,
-                  check_nk_rx_hds, check_nk_rx_large_niov], args=(cfg,))
+                  check_nk_rx_hds, check_nk_rx_large_niov,
+                  check_nk_tx_large_niov], args=(cfg,))
     ksft_exit()
 
 
-- 
2.53.0-Meta

