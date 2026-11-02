Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793646514;
	b=hKRNbvanM9IyDcAbRiHF5peWat/BKSKqnykItDMzOtip954xeyZamqoiBt6/yyR5lxoX
	 /LIFZP0jF61P2YyhV5SKiif6SIYipxTkgiQksmMoKCTeRsaxuTxhfEhb3DAruuA6AN8VO
	 lqtchzODIT4jbv6dqe/qwLi8ciIU/SP/6k1X/ctZ+V9B5KCn/KVIh6Tzke4zYuxh1tHoi
	 XUcXD6UrSB/ex2Wa4rO9mI4apoybmjeXuY8J7fErpFGy+844evfMzGnuj8x0Gzt9bLkSl
	 q/AzhF9fiv30kb2kly2TTpkry5W/9YJ7JlC7tP0CxhnI7zFWxiSDKievuuPM7KkP/gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646514;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aHgu+KXOG5ApiHR3iYNHtkCLwTT6jF9VbfNZpDmS/N0=;
	b=LRRNEyifAwUjcJU0y4SKfF9A2ELCg7KMfg4q6WAPnzeglaxkBwVZS7xNX4de4MP8AM8e
	 r4zYryu7+hW8GYuDx6QHiEKO3az+eToSYrpX8MDU4CU/1Bf4cOaO3lVOmU5PVOyPEPjWg
	 f3ZeHFy/WaZW1kjqyZhvV8ZjiD0lTlwUiaidGfrp0BoLL5O0IHO4cdcbJ0vbbT2oAgd9I
	 pag5oDdkfWpo7vVKA+rey8B5WwIYA/nxTDMO/Jwfdn8S533+Pcd2/BuHiARThiPffMCoG
	 vpXf201zW5nJKHGkeRcP/cYeUDtbHpv9oU04OxhCvTFaqpC/E/qNAnHrNrnn3APd+/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v9my3L4i;
	arc=none smtp.remote-ip=74.125.229.133
Received: from mail-dl2-f5.google.com (mail-dl2-f5.google.com [74.125.229.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24E46082BC0
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 19:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A24E46082BC0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v9my3L4i
Received: by mail-dl2-f5.google.com with SMTP id a92af1059eb24-1ac216daf7dso1357049c88.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 11:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793646513; x=1794251313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aHgu+KXOG5ApiHR3iYNHtkCLwTT6jF9VbfNZpDmS/N0=;
        b=v9my3L4i+MmOA4sXs1EXpKWT+zwA6PYMU9arxGoLjv4GxgJFmys4y6Z2JoaQ4s4WHl
         0l4eK/CCJcT/dEc5sMEZfIFed5sKkHp6Xi/SI3FezUcsne1V7xRKbrkBVJIwGYI/ZDh1
         gTDMma6BSj4x3/+JYopb2vasR8UKQzc1fFEpOa7aqbDzQYRilLHuTVxQC5hVbJCOtscs
         9wUZNkf5U3Gdm14nbXVp5cOqV/p4JtwzT+usj8S3bwlcT6kdop1lFozMCq0F1Utx89yB
         z11j1ihlRM0kicaM5U4mv5GdUi4e3TMAspf1J0ms5FmBCsVIRVxTtj/vYYhy/D82VM0S
         FNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793646513; x=1794251313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aHgu+KXOG5ApiHR3iYNHtkCLwTT6jF9VbfNZpDmS/N0=;
        b=Aalv4FCFCQancW4a0DKummvEu58blxWLA83kthm8eGAmn1WG3ShiAy3TFWmk5zciDe
         7rVZaABtQQeq5KMoaWpopMqMvZNXguENlAw3xWgfl7PNkRhcrOKbVTMgRKJX8cVcHIBW
         BNT9qSQzT13z4RSlYZGx29egKrdLQ6qFW2JAI5eL0/EgpPgSmpt9ijDq0RXCoPccoOlX
         puLvIdhGVTpRKlmixWUwnY1odN6roWAllLc3x/F7pl+1z/OXZEquayUkVIVcNiBByh7l
         9NevYBVP1if6tEG3UWJs9wvE1X38nCYj2K8GESe2Y9CJqVJU2F4hw+cPLexwOih56nRy
         skBg==
X-Gm-Message-State: AFq9FYJvftZvEg4/f8CguEztvQF14W+SnMjxwh0lk7dn/T+Szuba3CTX
	RTtg5Aj1Mia23YRHcsHANuHurJxxbjCrXcWH82bM44CNv2QXeLutTK59UMvE06wt
X-Gm-Gg: AYBFou113pLnCoze2xtNmcvCZDCunzTTYkDUvrfEKHe8/+bIgCCCqxQcmia8MszcQi4
	xqhZT/K87hAETuRWRQ/aU8OsMYsi7IkRZMgonbhp4skG3cpuuqGH7+wk0M6J+bo1GWCtdiQBru7
	uPUVjS6uSwv2oY0rjLlhvGG2iDiL0byFaz5U5r4U3z23c/QE0hs6g4r5hqxCF7JOhma+6CjEdRE
	gncZYv7RN8kcvb+RdMeFn0/vn6+1Q4mr0+Cc2a/FECg1rSwdg5jtC8C2FaMUuDOBqLf3/7H/V1E
	gBzqZwobzhwYZbH3VCFA8EgnJk1wGHIyA/MwCSjLTOcIVVyb3p6E7cfIWZQQEW4iFmKexG3ekQv
	gx3gvOYrP0nzXOEUejedaWpF4WsfLAM2WHrtEuG5uYyDGgRILE2UxH9PaoxS6EZgd+b2SJY8aX5
	EdLpPAjRzbF4nqSroPeShXD2VuN08GijyZZfPKJgwHG7vrS01da3BamFhYL1uRaV0RURPmcrRCr
	uSa44XdhWClBQjA7fivoPuTkUy66NlV8HutPngoQBiZkGCU48UuY73UpOdemTQ0PTOiJug0g/P0
	aQZVd6QjixQHtokXNH9o1Ac=
X-Received: by 2002:a05:7023:a42:b0:16a:c6f2:60c2 with SMTP id a92af1059eb24-1ac5d88c626mr16333419c88.12.1793646512758;
        Mon, 02 Nov 2026 11:08:32 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:66::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1a9e2ed3sm34321196c88.19.2026.11.02.11.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:08:32 -0800 (PST)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v3 4/4] selftests: drv-net: measure devmem performance with kperf
Date: Mon,  2 Nov 2026 11:08:27 -0800
Message-ID: <20261102190827.989117-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102190827.989117-1-sdf@fomichev.me>
References: <20261102190827.989117-1-sdf@fomichev.me>
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

Add a separate udmabuf-backed devmem performance test using KperfRunner.
Keep correctness cases in drivers/net/hw. Skip the test when kperf or
/dev/udmabuf is missing, and fail it when the kperf run fails.

Example metric output:

  # # ktap-metric-json: {"goal":"higher","name":"throughput","value":389.127}

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

