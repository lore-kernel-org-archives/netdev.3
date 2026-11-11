Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355374;
	b=1vCWLSqSoz4nPdMYet870QW699Pi0mG5hGXuEfw6ERKVMD3clAvgN8hVbdQIqpJpJzn6
	 vVxCf0FFT4BE8O2p/yeaerIb0R/F1i1RrSvo1Bv344oH45+/zDyUndiba/wKeh/tnLbVj
	 XhlO8S47ycnmneYkRWBfY4smIeYPyE+RFB7NNQlh0cWiBa6XyfN2z8QNLAC7xC3QDCeFd
	 tiNJrJazBuUPKJ8jozDOSat0E/aX8zKHIo4C8gkt1HOeNySMoiiasZWtsBVf4F2F9sRtu
	 Xa4Ob+RaUob2PSgFfTEq8rzfpwy/pZtKNA7junvN2P8Nek2pExDWB/EE8ZFWidlfI5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=FRK1W3aFdaRvVolL1WlLwR0kT5ZytF8wiI17WeHS+W4=;
	b=KaMqK1U4ajOXMTZkMaALfo99Ghs4IvCZ4O/En6AAN3eZR9UkBcYy9z4In4tfWMTwP5qY
	 /f5YAj61TXxGGilCxA+sacOLdKh6NEmGZP1AwaAVFqklwxWnO8kXhmawCLuNY1EO7LFHj
	 HK35f2dcAq12W8InJ8EKSKCAW+lQTqBbpXKqJYl3DlNwQMUrExWd6y5xcjHn1fLSzoTKC
	 o53gSX2U8rh9ps1zwfx3aCotqffBXWs0SSZRERPFUwKR/3k1oxdgUM8FUEKljy8RLVMt9
	 vu3tFCsVXn2rd1Bjw2QmytWbHEw9IboWegaXRdDHKcFTADiIxpYTI9tckrAtTL88rpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EDCQfEMB;
	arc=none smtp.remote-ip=74.125.229.4
Received: from mail-dy2-f4.google.com (mail-dy2-f4.google.com [74.125.229.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0E6606A331
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 00:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B0E6606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EDCQfEMB
Received: by mail-dy2-f4.google.com with SMTP id 5a478bee46e88-370231dbf90so1405664eec.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 16:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794355373; x=1794960173; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FRK1W3aFdaRvVolL1WlLwR0kT5ZytF8wiI17WeHS+W4=;
        b=EDCQfEMBxPwR4HAqljsckLkAadHJFm9I1zOW/aDMaRA/2MU+ieBUWCOicvCOrL6efv
         oIbaXXJjWCcFMDiplo1StCbv23019yU95eLX1wC5grAINtQgrvjoeRiKHHHX8abKeQ/P
         as6BXYy7Lajazr//VwwN+Q3hoJSnIN9SY6UFmR1FQt8qAvSvGWAqLqnFNdeAwb+xcugJ
         qV17E76CiuheeCABe7dXtwGmVzIWOUHP6cmLtKbQreROduKI7Wrvirj6qnR7+AhQNcha
         aharwLr2ocYtvyflcabwW49mYxDSRKxVmUSzKGwNpI3neT6b4A0KPayL7mwpcEwMftyY
         +VwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794355373; x=1794960173;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FRK1W3aFdaRvVolL1WlLwR0kT5ZytF8wiI17WeHS+W4=;
        b=MWjJX22uIv6SozWP7EH7NAV7d+hd43FrJFLkB4AQngmulR0L8XRfx3z+ztemDHixZq
         yfoIQ8nt7kOqgBnLLfLs12fBMdmvjv+S0IF12OEMOWtSoUJr4OjgYP3OwD6qixwYyBu1
         SIDCvBDqhraOZ8wGqaFIzdBz1V7UeapO5puKNBTgJwauKff9q6sdryrtP/eRGvzqndkU
         gRZcFdVwEW/q0ks9eOuoBLpHV1faww0aYjUrLe+vtdSRihPsT81B3uMI0FKdkx2lSfX8
         FaPXKsnCuF+qnlox6PIEi7SbH9G6lCYQ+3hmLtbYq0koUZeREvgt625goEczUg4Lu4bT
         4SDw==
X-Gm-Message-State: APuU4Z+nVTUqCwZJUlj5KP17Sb9sFxxrN51iVYU92B1WzX4iKyJABjAd
	TNTh8+nLkFPUxBG1qM15RLcWNyQdPYR/UXbJMsKP+8yszCDuBDBuAYg18Iw3nkaKc3I=
X-Gm-Gg: AYBFou2oaNFf0vj7JqZ+DcRmpVhJlP5Czk7rF5n0O0bQ2vGQ6TdQul0PzlE7WnVOIJa
	BaHk64nisZIeRwDL6/oKJWw65YfYB+D+8kQr4UJwUeAoL+eVm73KXmKf87Irq+ear3WhqlQKndi
	l834MsfgfARsk53D4aNZ2F5krAD/amD/iz/5UfsYifJsIrBcjMtDfD+JCX6SZyH/4BR4OGcqRFJ
	lGf5SXvXGVH04sp7ONbTLSxNfaA3HkqCdcBKvcDZIgvQ/iWgaROD/qXfv4j2UpBor/2GzJrtFHZ
	DRV9RXITzwjyVWbmuuK2ItsLHeRwcrAxmEUsIJQVTRYF+sR7itSKCkIYwf920gUcjIwuVPzo1tr
	I7gygZvmUdeweF3kVGq/Q/V3V7wShHpRZHc3HBnKNOogcoQOQ4C/JxZ8TxcZOWSb7wY9zr/ngAW
	cV+2EhWMMN5rNlqQ5dB3JdH9+RQH4ABM88vKyr58uBPegQYiqFPbRHAWYZHDkwytfK8V+SHoTav
	VQr9Ftsqw5JDiWrSqX9/MRX2zS+FRW5O2xcNF0LIjLUGxbJFRa947/seu/+Re1lcpJtbZ8FN7hm
	wK5OwldgqotIYIRtRnutR3U=
X-Received: by 2002:a05:701b:454c:10b0:159:2c6d:fcc3 with SMTP id a92af1059eb24-1b3c034b3e4mr653201c88.33.1794355372521;
        Tue, 10 Nov 2026 16:02:52 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:74::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11150sm14343401c88.5.2026.11.10.16.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 16:02:52 -0800 (PST)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Subject: [PATCH net-next v4 4/4] selftests: drv-net: measure devmem performance with kperf
Date: Tue, 10 Nov 2026 16:02:46 -0800
Message-ID: <20261111000246.962871-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111000246.962871-1-sdf@fomichev.me>
References: <20261111000246.962871-1-sdf@fomichev.me>
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

Add a separate udmabuf-backed devmem performance test using KperfRunner.
Keep correctness cases in drivers/net/hw. Skip the test when kperf or
/dev/udmabuf is missing, and fail it when the kperf run fails.

Example metric output:

  # # ktap-metric-json: {"goal":"higher","name":"throughput","value":389.127}

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../selftests/drivers/net/perf/Makefile       |  1 +
 .../testing/selftests/drivers/net/perf/config |  3 +
 .../selftests/drivers/net/perf/devmem.py      | 96 +++++++++++++++++++
 3 files changed, 100 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/perf/devmem.py

diff --git a/tools/testing/selftests/drivers/net/perf/Makefile b/tools/testing/selftests/drivers/net/perf/Makefile
index 31b0b60de4f6..1a90537d2726 100644
--- a/tools/testing/selftests/drivers/net/perf/Makefile
+++ b/tools/testing/selftests/drivers/net/perf/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 TEST_PROGS := \
+	devmem.py \
 	iperf.py \
 # end of TEST_PROGS
 
diff --git a/tools/testing/selftests/drivers/net/perf/config b/tools/testing/selftests/drivers/net/perf/config
index 6450f34933e6..111e9b58610d 100644
--- a/tools/testing/selftests/drivers/net/perf/config
+++ b/tools/testing/selftests/drivers/net/perf/config
@@ -1 +1,4 @@
 CONFIG_IPV6=y
+CONFIG_NET_DEVMEM=y
+CONFIG_SYNC_FILE=y
+CONFIG_UDMABUF=y
diff --git a/tools/testing/selftests/drivers/net/perf/devmem.py b/tools/testing/selftests/drivers/net/perf/devmem.py
new file mode 100755
index 000000000000..4c1fb9b51fff
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/perf/devmem.py
@@ -0,0 +1,96 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""Measure udmabuf-backed devmem TCP throughput with kperf."""
+
+from lib.py import cmd, defer, ethtool, EthtoolFamily, KperfRunner
+from lib.py import ksft_disruptive, ksft_exit, ksft_metric, ksft_run
+from lib.py import KsftSkipEx, NetDrvEpEnv
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
+        result = runner.run(client_args=devmem_args)
+
+    ksft_metric("throughput", result.target_throughput, goal="higher")
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

