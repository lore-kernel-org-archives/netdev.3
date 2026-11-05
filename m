Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917273;
	b=39cxxAPpZ+ksrvRq6Y0lQwFCh8czDqhZbYQBrmHXLSRTLyCvk6mlvILcrNLOJCud20uW
	 0OVjX2ychEipNUMvw+18jDmpasDFUXvF5dTwbzQyqnISxOPnHs8Qg9feLfMaBh0y0WRel
	 v2VKntk7ywbPXVlerdchA1M7aKuVLzyATMJ+SKAdOVSI1tPN9pMYJcMrAuVDzG5QZIXhQ
	 0KQZQmkKIbIbBpfcwovoRAJxa7miv5ug1ebEFR1V3v5lkogkBi9KnVCOpieSXGLzPvh0V
	 HyHc8F04Is/Gc21nV1EKWWzdrhAD/YcdYZcYGRXqDvjgnsQClTY5Bz70XKXmclktoEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0y9G2bMdiVayU7ew/c6nXyFE7TW4wpAw2zdzCTH7mfw=;
	b=aiAhdDiIrBJF4wT0M8tR+UXH2jrmeK+xJU4Q/EsD+mpQTdIroGqWLuQ14oWr7W8GlErT
	 KbJiU/0s54jiXXWDrhgmh33uPt2KOtS/GSdbhsM8txKcG0NsWhzPa35oGqO4enGpLNwx5
	 yak3mddrLLRT2SSVGLsNXC4EfPG3WJAPjebN9Jns/5z4rgHRFRhrDAiZChy5G4wIiwINs
	 p3oMemRKXeG2dDI8Njq3NE4/OUl+UkJNpnuqcAJ7EDUGIDLId/XTRT9hC3XhKeVnEjUkj
	 rYiUleEasLq/K1nZOIQUh8bKaAZ0f7I1yfvugNCMNo1uZzNFB4d00xR4nNsbir2F3eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NuUNYLV+;
	arc=none smtp.remote-ip=74.125.229.135
Received: from mail-dl2-f7.google.com (mail-dl2-f7.google.com [74.125.229.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37EC606EEA3
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 22:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A37EC606EEA3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NuUNYLV+
Received: by mail-dl2-f7.google.com with SMTP id a92af1059eb24-14345ae29c5so51706c88.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 14:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793917272; x=1794522072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0y9G2bMdiVayU7ew/c6nXyFE7TW4wpAw2zdzCTH7mfw=;
        b=NuUNYLV++4jUcXhcktyUHvBQHsTYQnnLHg1H3d4OMbSEdJL/pLXyK49OvIgDHGf4nm
         2pQqEPQYddzFNEST/wDkBVxr4Gq7cgYoH7ZgCV6UVkDSyuH9N7HohA+49XlM2+1JISjw
         rmXnlsKvSk4sYXL+pP1hwXIlDlORuI3XaWRd7M5ZV8wHQgUa2Vq9Rv7SACSMJhh46oer
         z6+pj4IuQj2PFU7WVCaMfJvz5PQT5i3Yu4ZmMLnY7mozYPgQMHW5YadJvIeSldozb3fT
         wqX2/ESSpWQcfUOO1mtUdpcZyN7ynIzLa1vbw4I1Yn3Y2i0hOvoa6uw1fiG/4wZiCIbb
         oqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793917272; x=1794522072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0y9G2bMdiVayU7ew/c6nXyFE7TW4wpAw2zdzCTH7mfw=;
        b=fjIW3SRjJ24cv3Od15MDUdzmqW+gQFoteyfIkdJR6z82HxjXiGRge5p3fXCFN5d8zk
         tm683BofOyCtWbuaJ9UsUwBAeD+AwbUZcYmblbbXKFTwBlGssuSBmMQ7n1bf0uC0tWem
         dRZ1z1gj3RbsGjzlZ061XNZhlWpafgT+seSQz0bjqbu6OjQBO43BDYcvFGZoy+rDdDme
         MWFe5d1dWwazt8y1Mi0OSSfQHUruGY2ejl4rFyChKnxucYlc6gyy0THiRmgn3qNvZYm8
         9+p53Vc0j7i/xZNCAfE67ZKOn5AP0VR6YKtRD4/VdH5guEu6z6cR9yrUgVpqtIcUI0pW
         B+Pw==
X-Gm-Message-State: APuU4Z/vZCks6Epcvvke9Q9sDiOLBSuedSKD8TQ34x/opcNosKsLx6vr
	8sSpFhLSAEDB1jklOS5fKvq6qqTxOvCnUU0vSy0HzlLjub0L2l2M3juhOxz40rp93AI=
X-Gm-Gg: AYBFou1O89PadgiNyR00EjtfhjvmrZ79tqZWTWlHdGSMMPLn2unEIWNSnORkoajYX+U
	hv4ukrmLBf+I7JvNaBDME1phOPa9FOgADAVMhql0Iflu3PKuv+4ux2Nt72UIIwrK80SKlvk8EsC
	uUNxHHWmGnxVzoQjZUw26qLXF2sGLKySNR58LwrEOG8IAgUI98P+79kmn4O6UjYzRDi1Uoa66FM
	CDwA0P8CO9XLW48rASUEobJC3OcJTh6g5p0RitrvFFVyJR3J6HszOuddgAVa1owXc46IvGlz4kK
	mACvy1W2R+6QYkZna279NbARQp0p1PRKp+bFej2yDF2avfowbP7zUeaXoxpqllES8vTttb3jbUt
	RV8MsS0GGUOtoWbvyYS/B6SQBoj9T+xcWCqL5DnvzRZlmhGHC4Tgtp8rGGG+RxBEes2fk0i/oJf
	HsjjRfGHRNXdMj3QkR7Wz66nd38snKLXlkK6SqRaQmhv/29TwOnb9J6/wXEwE+MQF4Bw8BDjF+J
	r28s5oEL+t+FCVeh5KTDNPnTDmYN4XSLR26XdF7mK62H8554Wev3I3ibMDpVdWjFEGpPJmGAgh1
	YTy2Lf7cfi2nrIRa3fM/64qL
X-Received: by 2002:a05:701b:2505:b0:181:ccdd:ed2a with SMTP id a92af1059eb24-1b25d38077bmr447446c88.43.1793917271738;
        Thu, 05 Nov 2026 14:21:11 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:70::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1bcedsm18987045c88.7.2026.11.05.14.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 14:21:11 -0800 (PST)
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
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	alexanderduyck@fb.com,
	kernel-team@meta.com,
	sdf@fomichev.me,
	dimitri.daskalakis1@gmail.com,
	almasrymina@google.com,
	dtatulea@nvidia.com,
	bobbyeshleman@meta.com,
	asml.silence@gmail.com,
	daniel@iogearbox.net,
	razor@blackwall.org,
	leitao@debian.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v3 9/9] selftests: drv-net: devmem: TX from a hugepage-backed dmabuf
Date: Thu,  5 Nov 2026 14:20:58 -0800
Message-ID: <20261105222058.944293-10-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105222058.944293-1-sdf@fomichev.me>
References: <20261105222058.944293-1-sdf@fomichev.me>
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
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
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

