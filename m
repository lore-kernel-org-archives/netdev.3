Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB31C547073
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 20:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231084; cv=none; b=jgo7Cqc5cdkJb7TivTBFf4vwNfk6BmgEiErr2NcMPacwki7kd8PhDyNLTJ7CP9r36wB3CTMa1IWbpf3a5N2VU0CGxxOlI/nUImxkmVuPTwyCm5/Z9HliRPfBgfb4k4hD96n5NpGhvuXWQYG2XxA+4RmnClgyPs26x+2QienD+is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231084; c=relaxed/simple;
	bh=sFQg39AUIb4dnECbXNLr+0I/YnQCELcOISVcYJYTELg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8EUgoJGySpyTTdk5MCwt4UL5WN9bqhVnTEkZZ/mi7sHqJQhEkIUdcJhGgZPYS2+pdmePzlLZohTBBqfIMI+HgLQ96f+Qg+ydPCYX16lOwaq1q0IK0SkpgRk8jjRFmFubIYW88+F8MlX8WaF/uhFQ+8CbcEXUy/axBTyZ72n6rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EoU72sYk; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoU72sYk"
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-39e501442e2so759260a91.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 13:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791231081; x=1791835881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F0Bzpu/liLptwG8IwP56b0/o51Xc06hjPl06b09zlWY=;
        b=EoU72sYkoEBUGZCitofzHP1HL1vvubSt/qkYTx7oCLgvAV+cvrn6K191ok1aZHvHgk
         9fO3Rlfd8eROV8ATYk4wGFZFaXizaA2Z7N7JMTeyzA8mFwGEkZFH4r2elyPW4u9phjrF
         Z9RGBBGpJcrdWniFuxmQwmkSmu1Xh9YTAPCRVGFmfxdC7+aYcIum0MEBM+NyFYp8VUwf
         ClCz7xN1GlUmRQn5QZLg7AVoJjuubPnM4+tYwB9WTtNdOqfj70+oUX9d8ldmshmeXBUA
         9jHWxVVEiAvbJ0iITXLgKruMD9jGKQ1ZbSc3vxUPzZkHHWrp4iFcrzI8Hf8kpU0QIrlE
         00Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791231081; x=1791835881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F0Bzpu/liLptwG8IwP56b0/o51Xc06hjPl06b09zlWY=;
        b=a39cg40/AUvDpF86lA8yFCMDvSgAS+i0htpqtewXI/dZ42lDV+1C2HEVRA6NYAK8Q5
         Z7RkIY/GD58hndDWPvvB7izAXoPCmyyUuX69aM3rKIYBXArkezw4a2RbshQDNEaPK2vx
         hsm22eTvNxnfhhUp56ml+3u0QrWoMR2rnb/F8gxGbG4klVjrAuq9usCW1L4Bn2l8kM+d
         Xt949h3aqnhUmocWGl+L6tsBY06UYgbG37nFxKJjQtO0V4j1ZF//2A+uY7QpZGx6RCMB
         6A7mbGxT/2yHfemRvxmLhq3qysnhVby2Krnatm6afzo/frZicTfgFpx4iwspromul7Qw
         S8fA==
X-Gm-Message-State: AFq9FYIhDxTVc/gB/zxeD9BKB2ArDTEdYxpM2hdPbtLbQKkBp0j7/Acv
	6IrlZk0hYUMwUV+kIBzfxJskmlq6C1MTNNT4iVBpDqwJpaVYPyq1y4gJ5zO5SzYg
X-Gm-Gg: AYBFou3UfHLH6Rwm4FVvn2OkPmkUY16YM8y34CwImjPcX26YhoUfs/XuON6TygaMjOV
	A0vEmgESRzUnoMIl4+EQds5RpendV6NsaoMTaDkHorPw0w5sSzEioph4KCHLOzPPSBxPbQT/kzA
	RaJEfp2ZvQQ9D//St3OWQKrwyq+lU/va1NCuExOn0ZUN/vMerJj5ikR++AVu+JAcakKI1dSSobf
	0FFaBKN6wHy6Mzn5ilRX70Qos9bu/m9sKNkvOb8Ep+czR9D7mZ+6E5tS/w1eQsdL9Xp/SYcI6AC
	zgqriYY9svf19w3J6x0Q20S96Evq35XCzAFoIQ3l+vAYeL+G+a95pt69TG6E+19zPEQiAIbJAs9
	bBFYMSoa/vceiMuPz4sCZH3pj40MhCIEuUZwRU696q76orNTnUxyvN6ioMsvEFWiGYUVOXHv+qJ
	7WgWA+hdEyWmZW8Az/ItPykp7CXOq+PUX5d2RaJ83OTu1OPWbHZyVqPGKmnIz7omQU
X-Received: by 2002:a17:90b:33cc:b0:3a5:25e:85f0 with SMTP id 98e67ed59e1d1-3a6ced64d02mr10775380a91.56.1791231080343;
        Mon, 05 Oct 2026 13:11:20 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853888d8fsm1131891a91.3.2026.10.05.13.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 13:11:20 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [RFC net-next v2 4/5] selftests: drv-net: add a kperf runner
Date: Mon,  5 Oct 2026 13:11:13 -0700
Message-ID: <20261005201115.2690830-5-sdf@fomichev.me>
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

Add a helper to manage kperf servers, run the client, and optionally report
aggregate throughput and retransmits. Use a random control port and a
unique PID file, and report server cleanup failures.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../testing/selftests/drivers/net/README.rst  |   8 +
 .../drivers/net/hw/lib/py/__init__.py         |   6 +-
 .../selftests/drivers/net/lib/py/__init__.py  |   4 +-
 .../selftests/drivers/net/lib/py/kperf.py     | 161 ++++++++++++++++++
 4 files changed, 176 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/kperf.py

diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
index 1b7264d40b79..4355d5113ec8 100644
--- a/tools/testing/selftests/drivers/net/README.rst
+++ b/tools/testing/selftests/drivers/net/README.rst
@@ -141,6 +141,14 @@ Arguments used to construct the communication channel.
   for netns - name of the "remote" namespace
   for ssh - name/address of the remote host
 
+kperf
+~~~~~
+
+Performance tests which use kperf expect ``kperf-client`` in ``PATH`` on the
+local host and ``kperf-server`` in ``PATH`` on both endpoints. Kperf is an
+optional dependency; tests which require it are skipped when it is not
+installed.
+
 Example
 =======
 
diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index cd771c00c074..c3d84d0f82b9 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -33,7 +33,8 @@ KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
         ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
     from drivers.net.lib.py import set_ethtool_feat
-    from drivers.net.lib.py import GenerateTraffic, Remote, Iperf3Runner
+    from drivers.net.lib.py import GenerateTraffic, Remote, Iperf3Runner, \
+        KperfResult, KperfRunner
     from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv, NetDrvContEnv
 
     __all__ = ["NetNS", "NetNSEnter", "NetdevSimDev", "UserNetNS",
@@ -53,7 +54,8 @@ KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
                "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
                "ksft_not_none", "ksft_not_none",
                "NetDrvEnv", "NetDrvEpEnv", "NetDrvContEnv", "GenerateTraffic",
-               "Remote", "Iperf3Runner", "set_ethtool_feat"]
+               "Remote", "Iperf3Runner", "KperfResult", "KperfRunner",
+               "set_ethtool_feat"]
 except ModuleNotFoundError as e:
     print("Failed importing `net` library from kernel sources")
     print(str(e))
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 58c2877e7928..e428d0ac1a09 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -52,11 +52,13 @@ KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
 
     from .env import NetDrvEnv, NetDrvEpEnv, NetDrvContEnv
     from .feat import set_ethtool_feat
+    from .kperf import KperfResult, KperfRunner
     from .load import GenerateTraffic, Iperf3Runner
     from .remote import Remote
 
     __all__ += ["NetDrvEnv", "NetDrvEpEnv", "NetDrvContEnv", "GenerateTraffic",
-                "Remote", "Iperf3Runner", "set_ethtool_feat"]
+                "Remote", "Iperf3Runner", "KperfResult", "KperfRunner",
+                "set_ethtool_feat"]
 except ModuleNotFoundError as e:
     print("Failed importing `net` library from kernel sources")
     print(str(e))
diff --git a/tools/testing/selftests/drivers/net/lib/py/kperf.py b/tools/testing/selftests/drivers/net/lib/py/kperf.py
new file mode 100644
index 000000000000..f0149a50fdc9
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/lib/py/kperf.py
@@ -0,0 +1,161 @@
+# SPDX-License-Identifier: GPL-2.0
+
+"""Run and parse kperf network performance measurements."""
+
+import re
+import shlex
+import subprocess
+import uuid
+from dataclasses import dataclass
+
+from lib.py import cmd, ksft_metric, ksft_metric_policy, ksft_pr, \
+    rand_port, wait_port_listen
+
+
+_SECTION_RE = re.compile(r"==\s+(Source|Target)\b")
+_RATE_RE = re.compile(r"\b(Tx|Rx)\s*([0-9]+(?:\.[0-9]+)?)\s+Gbps\b")
+_TCP_HEADER = "TCP retrans reord rtt rttvar d_ce snd_wnd cwnd"
+_TCP_ROW_RE = re.compile(r"^\s*(?:[^:\s]+:\s*)?(\d+)(?:\s+\d+){6}\s*$")
+
+
+@dataclass
+class KperfResult:
+    """Aggregate throughput (Gbps) and retransmits of both endpoints."""
+
+    source_throughput: float
+    target_throughput: float
+    source_retransmits: int
+    target_retransmits: int
+
+
+class KperfRunner:
+    """Manage kperf servers and run measurements between test endpoints."""
+
+    def __init__(self, env):
+        self.env = env
+        self._pid_file = f"/tmp/ksft-kperf-{uuid.uuid4().hex[:8]}.pid"
+        self._port = rand_port()
+        self._started = []
+        env.require_cmd("kperf-client", local=True)
+        env.require_cmd("kperf-server", local=True, remote=True)
+
+    def _server(self, remote, kill=False):
+        host = self.env.remote if remote else None
+        address = self.env.remote_addr if remote else self.env.addr
+        args = ["kperf-server", "--pid-file", self._pid_file]
+        if kill:
+            args.append("--kill")
+        else:
+            args += ["--addr", address, "--port", str(self._port)]
+        return cmd(shlex.join(args) if remote else args, host=host,
+                   fail=not kill)
+
+    def __enter__(self):
+        try:
+            for remote in (False, True):
+                self._server(remote)
+                self._started.append(remote)
+            wait_port_listen(self._port)
+            wait_port_listen(self._port, host=self.env.remote)
+        except Exception:
+            self.close()
+            raise
+        return self
+
+    def close(self):
+        """Stop the started kperf servers."""
+        failures = []
+        while self._started:
+            command = self._server(self._started.pop(), kill=True)
+            if command.ret:
+                failures.append(command)
+        if failures:
+            details = "\n".join(str(command) for command in failures)
+            raise RuntimeError(f"failed to stop kperf server(s)\n{details}")
+
+    def __exit__(self, _exc_type, _exc_value, _exc_tb):
+        self.close()
+
+    def run(self, client_args=(), report=False):
+        """Run kperf and optionally report throughput and retransmits."""
+        argv = ["kperf-client", "--src", self.env.remote_addr,
+                "--dst", self.env.addr, "--src-svc", str(self._port),
+                "--dst-svc", str(self._port)]
+        argv += [str(arg) for arg in client_args]
+        command = cmd(argv, background=True)
+        try:
+            command.process(terminate=False, fail=False, timeout=300)
+        except subprocess.TimeoutExpired as error:
+            command.proc.kill()
+            command.process(terminate=False, fail=False)
+            raise RuntimeError(f"kperf client timed out\n{command!r}") \
+                from error
+        if command.ret:
+            raise RuntimeError(
+                f"kperf client exited with status {command.ret}\n{command!r}")
+
+        try:
+            result = self.parse(command.stdout + "\n" + command.stderr)
+        except ValueError:
+            ksft_pr(command)
+            raise
+
+        if report:
+            ksft_metric_policy(
+                "throughput", summarize="p50",
+                regression={"compare": "p50", "better": "higher",
+                            "relative_tolerance": 0.05},
+                display_label="Gbps")
+            ksft_metric_policy("tcp.retransmits", summarize="max")
+            for host, throughput, retransmits in (
+                    ("remote", result.source_throughput,
+                     result.source_retransmits),
+                    ("local", result.target_throughput,
+                     result.target_retransmits)):
+                ksft_metric("throughput", throughput, kind="scalar",
+                            host=host)
+                ksft_metric("tcp.retransmits", retransmits, kind="scalar",
+                            host=host)
+        return result
+
+    @staticmethod
+    def parse(output):
+        """Parse human-readable kperf client output."""
+        throughput = {"Source": [], "Target": []}
+        retransmits = {"Source": [], "Target": []}
+        section = None
+        in_tcp = False
+
+        for line in output.splitlines():
+            match = _SECTION_RE.search(line)
+            if match:
+                section = match.group(1)
+                in_tcp = False
+                continue
+            if section is None:
+                continue
+
+            match = _RATE_RE.search(line)
+            if match:
+                direction, value = match.groups()
+                if (section, direction) in (("Source", "Tx"),
+                                             ("Target", "Rx")):
+                    throughput[section].append(float(value))
+                continue
+
+            if _TCP_HEADER in line:
+                in_tcp = True
+                continue
+            if in_tcp:
+                match = _TCP_ROW_RE.match(line)
+                if match:
+                    retransmits[section].append(int(match.group(1)))
+
+        values = (*throughput.values(), *retransmits.values())
+        if not all(values):
+            raise ValueError("incomplete kperf result")
+
+        return KperfResult(sum(throughput["Source"]),
+                           sum(throughput["Target"]),
+                           sum(retransmits["Source"]),
+                           sum(retransmits["Target"]))
-- 
2.53.0-Meta

