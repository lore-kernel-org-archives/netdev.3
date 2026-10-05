Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567C74DF4C1
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 20:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231084; cv=none; b=olJa5jfx9Ld+Gn6D7qLOoH8zZGJXNqvOdxeCeUaVC7T19s/cSTOtxGFHgQ4XSAMUTjk9AyIdQRF+j0JZgoayHeyuBE0XY4ugKPpmQ+B2b3ddTReAhst8dFFxNqxB210z03zJvW73SvOs9GynH+M5aRw3iqvRopdvYQpZqT4u7Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231084; c=relaxed/simple;
	bh=doEPdY+iV6AxdUIPDnxT+lwgj1yF5fT/mV+G5KorNmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARylD0cjMvVpHd5rjkPjXi5VQ+kv3lr7DMdmE7vlAjJkOGZn09mK9dFHnFgizK50N4YN6u7x1y7bfiK3aDRr1C1jjKVhHwAopAgq+1yzwEWS6YjtRA/rx7e2nbWlh8JLKiRR81923GfqY79KsdLzHYZ0fzQMqwvqaN90TkZ913M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVTpLOhG; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVTpLOhG"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3a81335d55aso524168a91.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 13:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791231081; x=1791835881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LLtuieqpbXZNtatGX13BM6Z66Lly/QNzzSC3FTteKwc=;
        b=JVTpLOhGGVGH7OKgVMdbsGC3yeSzY6IoFBqMo2QKEmwqvTIKRN2zK7ysU9qazZmPaO
         gx0/KHruFeZ+JxVB2eRNsbO+hmmiJTKtVXz+ljQ6pev46LLQuBLL7XdOOQKj28jxlrqt
         AJlkOXHBS0avArRBVd8lrU8I2ZWyMLqWutTzlS9J4LiHJC7Oku/xM1c1ZuQb63Ol55IP
         bDqunRyvSFP6RRi2tiCJd/FxO5EApFUrXRysvPfO1Fx/ENGyEzmuRHU0WHczUSpmCH4+
         zv5DzC02YgcoyDvAM/pOVVsveGKptGo5aSNW5mNGAgaP+PtyR8nby7ytULls3eggXYtO
         cZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791231081; x=1791835881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LLtuieqpbXZNtatGX13BM6Z66Lly/QNzzSC3FTteKwc=;
        b=aeP3QkWLky+AUolG7jVSWSVNAIOXe7L/IoGq15j2ssRzTSybPhop7ztAPODqq+D3QW
         1k8VADVbfCByRPZC6uRyrnDSG9D21/PVPOcYbmyuKy3pCa0Gd3WBXsSnYr84gYgaUP0Y
         i+nTncVp4u0mCoREw5KDbjG4kyeOcLzc1qkkBrnnz+nON2pLAfu+/DcQTLT21usHQj72
         BqeKnz+9WEXIwZJua+fTMEOwoMY7QrDMMsVWKpB3buk2ktymGZ/kGWTm5BJ8fgOXa9Tv
         RI6xHysViJFDY8HlxIgdruitGD4yzf+WkC2qCxVosI/4FdcjNA+wx/+CTQ1iWyivVo1F
         zxYA==
X-Gm-Message-State: AFq9FYLFIn/ckfYuUidZNgN0nRg2ouQhmKTdrk8kfzcwCLgunnirm2g6
	dWhmgEkwXexa0Gx7KEHq13XwGY0q6pLiUHin1HaGXBnV3SloyIVJBvjI7FjQj2qe
X-Gm-Gg: AYBFou1f0MrwCBXuBylk8ymZsoNU9AaNfWRO4kba9zD8Xyw7ZUukE/iy3orUuxc89Fv
	ox5N6zqz1nDL2BNLSSi10MCdtHMjAFTSIDF9UdHZ3Z3UFoNQDHg32YKHBMo1jFKUKl+dxvCWDSP
	2z2lEDdVnyCbuW2RyXVDDE3dS6h6F5jn1YbJ2oRRTOT+94p/LcvK4Sg1TAm4xtiGT0gvjLZAqqa
	mWflKuBH4z/xA9YcJku594BV5WTdXnyC+YWzGyOuwyReWYrXI0rjJhAoGLeAZr+ip5oy/q9xUsW
	AufJEGJaL8sgMV2M6VOl0zMSJowjKWJX+ITxSadOD5WcOfvwjm6SWMKxUXrn+Kl8Wh6HHjaNXDQ
	xVpzpP5rC0YcO4+w1VPRhPV2bQEXXnpwbYRDX2DCHqmJDQxtyz3S4uwItsMKbejE4c/e2PmeV3J
	5C7atmlCd7mFWkX2d58g+pJQKVkMaZ+Q0wb8W6KZoJhShazIwPfrjrSIvvWllNcQ7U
X-Received: by 2002:a17:90b:2d4c:b0:3a0:2817:1fcf with SMTP id 98e67ed59e1d1-3a6ce6ca6c8mr10417686a91.11.1791231081245;
        Mon, 05 Oct 2026 13:11:21 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:46::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8211b74c8sm2388306a91.0.2026.10.05.13.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 13:11:20 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [RFC net-next v2 5/5] selftests: drv-net: measure devmem performance with kperf
Date: Mon,  5 Oct 2026 13:11:14 -0700
Message-ID: <20261005201115.2690830-6-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005201115.2690830-1-sdf@fomichev.me>
References: <20261005201115.2690830-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a separate udmabuf-backed devmem performance test using KperfRunner.
Keep correctness cases in drivers/net/hw. Skip the test when kperf or
/dev/udmabuf is missing, and fail it when the kperf run fails.

Example metric output:

  # # ktap-metric-policy-json: {"display_label":"Gbps","name":"throughput","regression":{"better":"higher","compare":"p50","relative_tolerance":0.05},"summarize":"p50"}
  # # ktap-metric-policy-json: {"name":"tcp.retransmits","summarize":"max"}
  # # ktap-metric-json: {"host":"remote","name":"throughput","time":29.786267,"type":"scalar","value":389.29900000000004}
  # # ktap-metric-json: {"host":"remote","name":"tcp.retransmits","time":29.786286,"type":"scalar","value":698}
  # # ktap-metric-json: {"host":"local","name":"throughput","time":29.786289,"type":"scalar","value":388.772}
  # # ktap-metric-json: {"host":"local","name":"tcp.retransmits","time":29.78629,"type":"scalar","value":0}

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../drivers/net/hw/performance/Makefile       |  5 +-
 .../drivers/net/hw/performance/config         |  3 +
 .../drivers/net/hw/performance/devmem.py      | 99 +++++++++++++++++++
 3 files changed, 106 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/performance/devmem.py

diff --git a/tools/testing/selftests/drivers/net/hw/performance/Makefile b/tools/testing/selftests/drivers/net/hw/performance/Makefile
index 5d53ef548306..27afdace92e6 100644
--- a/tools/testing/selftests/drivers/net/hw/performance/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/performance/Makefile
@@ -1,6 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 
-TEST_PROGS := iperf.py
+TEST_PROGS := \
+	devmem.py \
+	iperf.py \
+	#
 
 TEST_INCLUDES := \
 	$(wildcard ../lib/py/*.py ../../lib/py/*.py) \
diff --git a/tools/testing/selftests/drivers/net/hw/performance/config b/tools/testing/selftests/drivers/net/hw/performance/config
index 6450f34933e6..111e9b58610d 100644
--- a/tools/testing/selftests/drivers/net/hw/performance/config
+++ b/tools/testing/selftests/drivers/net/hw/performance/config
@@ -1 +1,4 @@
 CONFIG_IPV6=y
+CONFIG_NET_DEVMEM=y
+CONFIG_SYNC_FILE=y
+CONFIG_UDMABUF=y
diff --git a/tools/testing/selftests/drivers/net/hw/performance/devmem.py b/tools/testing/selftests/drivers/net/hw/performance/devmem.py
new file mode 100755
index 000000000000..033485f926e4
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/performance/devmem.py
@@ -0,0 +1,99 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""Measure udmabuf-backed devmem TCP throughput with kperf."""
+
+from os import path
+import sys
+
+sys.path.insert(0, path.join(path.dirname(path.abspath(__file__)), ".."))
+
+from lib.py import cmd, defer, ethtool, EthtoolFamily, KperfRunner
+from lib.py import ksft_disruptive, ksft_exit, ksft_run, KsftSkipEx
+from lib.py import NetDrvEpEnv
+
+
+UDMABUF_LIMIT = "/sys/module/udmabuf/parameters/size_limit_mb"
+UDMABUF_SIZE_MB = 2048
+
+
+def _set_udmabuf_limit(host) -> None:
+    current = cmd(f"cat {UDMABUF_LIMIT}", host=host).stdout.strip()
+    if int(current) >= UDMABUF_SIZE_MB:
+        return
+
+    cmd(f"echo {UDMABUF_SIZE_MB} > {UDMABUF_LIMIT}", host=host, shell=True)
+    defer(cmd, f"echo {current} > {UDMABUF_LIMIT}", host=host, shell=True)
+
+
+def _enable_hw_gro(cfg) -> None:
+    features = ethtool(f"-k {cfg.ifname}", json=True)[0]
+    hw_gro = features["rx-gro-hw"]
+    if not hw_gro["active"]:
+        if hw_gro["fixed"]:
+            raise KsftSkipEx("Test requires rx-gro-hw support")
+        ethtool(f"-K {cfg.ifname} rx-gro-hw on")
+        defer(ethtool, f"-K {cfg.ifname} rx-gro-hw off")
+
+
+@ksft_disruptive
+def kperf(cfg) -> None:
+    """Measure udmabuf-backed devmem performance with kperf."""
+    runner = KperfRunner(cfg)
+
+    for name, host in (("local", None), ("remote", cfg.remote)):
+        if cmd("test -c /dev/udmabuf", host=host, fail=False).ret:
+            raise KsftSkipEx(f"Test requires /dev/udmabuf on the {name} host")
+        _set_udmabuf_limit(host)
+
+    # kperf reprograms the RSS indirection table for its queues.
+    defer(ethtool, f"-X {cfg.ifname} default")
+
+    _enable_hw_gro(cfg)
+
+    ethnl = EthtoolFamily()
+    rings = ethnl.rings_get({"header": {"dev-index": cfg.ifindex}})
+    restore = {
+        "header": {"dev-index": cfg.ifindex},
+        "tcp-data-split": rings.get("tcp-data-split", "unknown"),
+    }
+    config = {
+        "header": {"dev-index": cfg.ifindex},
+        "tcp-data-split": "enabled",
+    }
+    # Memory providers require a zero threshold where the driver has one.
+    if "hds-thresh" in rings:
+        restore["hds-thresh"] = rings["hds-thresh"]
+        config["hds-thresh"] = 0
+    defer(ethnl.rings_set, restore)
+    ethnl.rings_set(config)
+
+    devmem_args = [
+        "--time", "15",
+        "--num-connections", "4",
+        "--read-size", str(64 << 20),
+        "--write-size", str(64 << 20),
+        "--pin-off", "4",
+        "--num-rx-queues", "4",
+        "--dmabuf-rx-size-mb", str(UDMABUF_SIZE_MB),
+        "--dmabuf-tx-size-mb", str(UDMABUF_SIZE_MB),
+        "--validate", "no",
+        "--devmem-rx",
+        "--devmem-tx",
+        "--devmem-rx-memory", "host",
+        "--devmem-tx-memory", "host",
+    ]
+
+    with runner:
+        runner.run(client_args=devmem_args, report=True)
+
+
+def main() -> None:
+    """Run the devmem performance test."""
+    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
+        ksft_run([kperf], args=(cfg,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.53.0-Meta

