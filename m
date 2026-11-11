Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437270;
	b=45iwcS9pAIoPI7gMD+4LAj3ns8qMzhu+Csz+5a8P1rHkx1f7flj1qqJYdhgL25Tqj0LH
	 cQfIKf6iweqNFFVpGrooZZ8MSN9I5IKYk0lvwySh2JFzPYAOQTodMwB57Yl7LW4CCpHDK
	 9wmlKhqsKnBV1QSj/nzJ3XAJVrknyWMt37EFy8usgtS9COekoQTU/hkICshsBwjOD1PSx
	 U+yqAf0MfaiobLvo9Ofl2MunVpkbmtjLtPX+Ej7ElJ1BU6zrGkCbFtZZxeXNIGZRzlbZJ
	 U3ZKNVO5vxLada5UAqcafg5PaGmwbXThxLDPcXOUWPGVcv6R4oZiItDLoWdPSF8hvDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437270;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0y9G2bMdiVayU7ew/c6nXyFE7TW4wpAw2zdzCTH7mfw=;
	b=UPAiANnaEu1DyGIf+adoI02kgANGQH33cwuGakuJZfz3wqG58iywcJPZdqaF87sJrRCW
	 Fw73Uu6xK6KZ/H+aHOv8vGAUzEc0G8z0OL3a8FxOHXr+KsoduailGAhlMND2e9z6dFV6Z
	 sCqw9OxoYIWloOT0HPhMezVA3qEZo1uKrw/chmB3eSAncLHKqRAqiXBwr0AYadOmnOQDt
	 lQRV5NF1DWkGZ85m02pmW6EEonYxprPDSLmvwD0bPiFDRz2Egqihg72rWAUYl026wVz0H
	 NKiQWUkeejmkD8siFMLGLMupOxAu7Yv4ZHo7HktWbbOD8kA4rbOhAuQPyD8ZcO6r4rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0LYj4cRS;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5BA60A6F41
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 22:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B5BA60A6F41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0LYj4cRS
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-36c9b5c6faaso2377080eec.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794437268; x=1795042068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0y9G2bMdiVayU7ew/c6nXyFE7TW4wpAw2zdzCTH7mfw=;
        b=0LYj4cRSw9cid6WlbEty8q3ohb/tnRWnGnwvt3YsyntaZxHTWCoulOTFtjO17o+har
         /dzgNlTV8ip9i+28nBomlTJqPI7XMwpmXZUzYWHKZvOyY/BG7XmJ2NHmd9BvMetTfK7r
         PRQ3LbCjBqWCSamzDcRTnMBQlo2NZ3FTmb8LC/+pXgnzpXJNNks/VqBj3khwM/Ojnvin
         oUXeRFvzbr6V4Ww/9K+PMYgY2TPT9y+Ub76B2UhhTDV/m/BEufUUO/lE0uiv1AOOKgKX
         dNjiiDnf1QouFCZBsXTSWEAmLVZTFVqHHySDDh7ZGtYwKoF1cb2KG+gK2Nw38fCmPPG1
         QIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794437268; x=1795042068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0y9G2bMdiVayU7ew/c6nXyFE7TW4wpAw2zdzCTH7mfw=;
        b=DVLqB/Opi7azBLn70G+zqXMcmbaQ2QjVDREgQ5JsYOo7wZa1B3r+S7u0MmVLwglVRO
         wsiwOPEecaYQAjOwZRrk1vpL8A+jAkjoKPg2dniPISI6bd06yR8JmVSudHS2wA1g9mkJ
         cZ+IVNvuzOfmgB+4mpgvDruR+Oy+q0ImpX4uDvGxdZHIbK2MMaQ03JPy+/4tH89m1hJW
         rO5/6xUiHb1tuGKjQht4CkJQJRT9YFOn6JFDswPRBmqgXXMSrmy+8pZKi70fjoQ+qmlE
         /cVSuLlK6k3cipNzUpcTqpZj2CWprqO1OZ7c+TJyYq5kYpAPFX1YEAaYptAzHiQ3tGIU
         owzQ==
X-Gm-Message-State: APuU4Z8GDEAkB7OV5wT5fMvBFMrcqJi/67uPWOXmL8Taa3fCKZ1JVzEQ
	VObL/uGYEKFjulVOmoGPuruMtN5VhVLjXAT/R/rQQCERPiDQT1a79WSihs6V1XVubBA=
X-Gm-Gg: AYBFou1X+E0YmZH/k9Py3xXTYjnqwufp2idgF+h34NVimhABnZ8uc3qr341T5j9dZZl
	Pfc8qj+498roP0HEn4cKAktE3jW0ogZT7Z3Gu5ZUtOd+sFolvBmbNzlKZ2HnSpZIKqDLj00Lexh
	pYBY3eXKEv0FvDiiM6JaFnTAKzFgOck8eLwIGtDtaqBXKQjmwDW++nL7dfIkFnTiSDN6eW2mEEh
	Q9Ry8AmXa7exVgi1QvrTf/qcHez3igdddhpB4axM8YcqENTA4fbhD9fqRVFPTA2bnyespnetYR+
	dAe3LR87ztTpF/Wv1U/pIL+E1teB7VAeR25bqBCIfGWgkPsfRipCSyBu0UGCuZfLT4l+9wWFRTd
	CzG9fVokgWqsOsNc1sCk52R8pz8hyVJbNmVQ3pbYAOAbMUWMwG907keDKgaKwu0l5iqXkQv1kVG
	q7ER6v9Qlv5adirdIewKr2YGkB1pcTadyxJM/QOpOJ+/UNZRr1VyIy2QeP4FKk5pTga86HxGA0D
	uyUoRWXFPcl8495ey3N8U4HFVGJk11mzMBhKm9A7mm60PQZEmU6tI7gDLi6NbrqPzkao9Hcyp0e
	6pKrIIZRZyIBoiT9ezodGFw=
X-Received: by 2002:a05:7022:ec04:b0:19a:8e3e:530e with SMTP id a92af1059eb24-1b3c02f12demr3664492c88.8.1794437268166;
        Wed, 11 Nov 2026 14:47:48 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:69::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b56c4e88sm17831071c88.0.2026.11.11.14.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:47:47 -0800 (PST)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch,
	edumazet@kernel.org,
	horms@kernel.org,
	shuah@kernel.org,
	almasrymina@google.com,
	sdf@fomichev.me,
	leitao@debian.org,
	dtatulea@nvidia.com,
	asml.silence@gmail.com,
	bobbyeshleman@meta.com,
	daniel@iogearbox.net,
	razor@blackwall.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v4 5/5] selftests: drv-net: devmem: TX from a hugepage-backed dmabuf
Date: Wed, 11 Nov 2026 14:47:40 -0800
Message-ID: <20261111224740.2744522-6-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111224740.2744522-1-sdf@fomichev.me>
References: <20261111224740.2744522-1-sdf@fomichev.me>
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

