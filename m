Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA6B4B1CE3
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 19:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585483; cv=none; b=BCroLTAhJdWt5H3EsDyRZSxGPDEDVKWZts7Gh1CEBy30XAMOvqOtCusKynHzvR0Q8qfM/IxyvtFuu0Q+rKUt08H26vM+b06XgYILL4dYiIm+yWUp/ikUBZBaxeTHkyMrzZWsHoJRByxW6Ka8sTBZK7npvfjRTksFehh/4QjutBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585483; c=relaxed/simple;
	bh=8XevL9Tzt/3h9CSJ4yzuKMm9hdwh8VPdv0da3OYlgfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWcY++nivzOj2xWBtHpzuh0n+S5LK3QMhNa7/Z0nJQSr/upcWNL3I8OV2wp56DlW3HhrjHZdp3OGH4kQQvxskm0nQJBwrp79RinBGmTTSyaKHwHSej5I0CfZJKIK97wMZBg1cFBiFf33sTH+GpcQVrBSAlFLjAzJifZezmWaVRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SiWWfA9/; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiWWfA9/"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-39e00a5b8e7so15328a91.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 12:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789585457; x=1790190257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j8sYuN6kNbWf7BIm+8Oi4uf1pioDuhuvzECpyItTQuw=;
        b=SiWWfA9/as4kMvBOScEQY1m4jM1DaE+zZEs0laLFoQO5WHMonGkkg2lR/ebZ1n4TV3
         NtVxFvqGJyNqc+9kMB+wCJWgQqxpQOxat4bY7SaJvtsh/62PrileQzWk5PKe8tSdcgtl
         xmfegX6vhbevUL/McKG+h9jgwM6bn87OFcq1FC6eC2UkKbGgZrncvOz97pGHVIxQsUOE
         7CzhMvANwzYGCcqA9QSDoch22fcDism8SvTPfwvaCgf3NvZzjVQnnT1ZWtyjeXxUlSTx
         YpgurhEsdGWSdkR0KsTjMRztmQH+fMwrKH/fgA/Gl5h3+MudT8W4iVjyBHTZgA6wdp3z
         vCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789585457; x=1790190257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j8sYuN6kNbWf7BIm+8Oi4uf1pioDuhuvzECpyItTQuw=;
        b=zbequDsEZvyFfRxKtCeuBYSlWx4lyaMghLJTQAol4y6x2OylBHez2lv/LxCRfdt/ef
         WQmS5wlNigB8vIo2hJd0COIr8PsSW4338Z5XxY0il52ok26m8Jml64eY3m5xatgaVDnG
         t5A4phOeKqwBSW/B69uKcK4F4K4GBKin6h2fx2DRRT74t3e68Z3UnXoFytYT0rfg/2pL
         XDwxFEnb387egW6Wy4btzJys2gAt++6OxEvUeRXkmzLTMgKJgY0WoMVtGHw+ONmnk6MB
         0dIUwQGTmf/1BaGx4jPDTtrbyLCVGsO55PS+zXPVQOvF4LOVbbMA7Q7QXg+Y6kiazGc7
         yWnA==
X-Gm-Message-State: AFuF++lyEFq+s08WJ78mu/QnynvRO6gzcsLTsVMOp7CJiYbNHlmsViMp
	XmccRao/cW2K9yohQAfy6JKwjZB7PbIeVxQkT6CDIxQIJYYCL+JA58AO9hTs4rft
X-Gm-Gg: AYBFou1oqcAYXl3RcHSa2M/fHyysWu5s4MQJS8VZaosqs1A7eMF87/2Ru0lZrfP1GSF
	7/bzSiNY4caEBYKtng7CaFjkhrHRRAtvcJ47d4sxy9f8MiOnci6k0xclPCXGoWXQbwL5ddqAu19
	kKdCkCwGlJ92yy+VeeWfcihO/jPH68TqQb1AW0BUQCBvFT35hxgYz/5ycYM/ldjZrZWAl2txbL9
	jVI7bn7oeHy9t9q+4xOANKaqP59VQKQ61ycPr0b1BdtFbL6uEp52n5lVzEIKLITcVYk5MP//IXZ
	SIuOlm4xcGrwP2N+I8S50eZa20tyB5k+AgEmWDKPAUhaqJ0wlZFf9x8KBDMx+LDsQaRrbgxqDCc
	BG3Ak78Mnnf29mJsZNibdga/7eglECf2Rfyky7CqW1ow9+tXJCZiGvzsSI1XJDA9ibfagexTvL7
	4Tzaufa2j7B9615TpsrDAYGeInUcWWHw2bxyKYd/0iQr5qxBpdxEGIJTdX44I7FN6T
X-Received: by 2002:a17:90a:51c1:b0:39e:2e7c:d43c with SMTP id 98e67ed59e1d1-39e2e7ce429mr2888154a91.7.1789585456849;
        Wed, 16 Sep 2026 12:04:16 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:49::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e361b3a39sm731809a91.11.2026.09.16.12.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 12:04:16 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [RFC net-next 5/6] selftests: drv-net: add a kperf runner
Date: Wed, 16 Sep 2026 12:04:08 -0700
Message-ID: <20260916190409.1222272-6-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916190409.1222272-1-sdf@fomichev.me>
References: <20260916190409.1222272-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper to manage kperf servers on both endpoints. Run the client and
report aggregate throughput and retransmits. Use a unique PID file for
cleanup and keep the external kperf tools optional.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../testing/selftests/drivers/net/README.rst  |   8 +
 .../drivers/net/hw/lib/py/__init__.py         |   5 +-
 .../selftests/drivers/net/lib/py/__init__.py  |   4 +-
 .../selftests/drivers/net/lib/py/kperf.py     | 148 ++++++++++++++++++
 4 files changed, 162 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/kperf.py

diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
index 03373d6cecb0..36a79148c0b5 100644
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
index 857bd016e5e0..5502969bfee4 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -34,7 +34,7 @@ KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
         ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
     from drivers.net.lib.py import GenerateTraffic, Remote, SystemMonitor, \
-        Iperf3Runner
+        Iperf3Runner, KperfResult, KperfRunner
     from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv, NetDrvContEnv
 
     __all__ = ["NetNS", "NetNSEnter", "NetdevSimDev", "UserNetNS",
@@ -55,7 +55,8 @@ KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
                "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
                "ksft_not_none", "ksft_not_none",
                "NetDrvEnv", "NetDrvEpEnv", "NetDrvContEnv", "GenerateTraffic",
-               "Remote", "Iperf3Runner", "SystemMonitor"]
+               "Remote", "Iperf3Runner", "SystemMonitor", "KperfResult",
+               "KperfRunner"]
 except ModuleNotFoundError as e:
     print("Failed importing `net` library from kernel sources")
     print(str(e))
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index e418837f0b00..5f75ce61fb65 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -53,12 +53,14 @@ KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
                "ksft_not_none", "ksft_not_none"]
 
     from .env import NetDrvEnv, NetDrvEpEnv, NetDrvContEnv
+    from .kperf import KperfResult, KperfRunner
     from .load import GenerateTraffic, Iperf3Runner
     from .system_monitor import SystemMonitor
     from .remote import Remote
 
     __all__ += ["NetDrvEnv", "NetDrvEpEnv", "NetDrvContEnv", "GenerateTraffic",
-                "Remote", "Iperf3Runner", "SystemMonitor"]
+                "Remote", "Iperf3Runner", "SystemMonitor", "KperfResult",
+                "KperfRunner"]
 except ModuleNotFoundError as e:
     print("Failed importing `net` library from kernel sources")
     print(str(e))
diff --git a/tools/testing/selftests/drivers/net/lib/py/kperf.py b/tools/testing/selftests/drivers/net/lib/py/kperf.py
new file mode 100644
index 000000000000..9f909dd2507f
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/lib/py/kperf.py
@@ -0,0 +1,148 @@
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
+from lib.py import cmd, ksft_metric, ksft_metric_aggregate, \
+    ksft_metric_reporting_enabled, ksft_pr, wait_port_listen
+
+
+KPERF_PORT = 18323
+
+_SECTION_RE = re.compile(r"==\s+(Source|Target)\b")
+_RATE_RE = re.compile(r"\b(Tx|Rx)\s*([0-9]+(?:\.[0-9]+)?)\s+Gbps\b")
+_TCP_HEADER = "TCP retrans reord rtt rttvar d_ce snd_wnd cwnd"
+_TCP_ROW_RE = re.compile(r"^\s*(?:[^:\s]+:\s*)?(\d+)(?:\s+\d+){6}\s*$")
+
+
+@dataclass
+class KperfResult:
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
+        self._started = []
+        env.require_cmd("kperf-client", local=True)
+        env.require_cmd("kperf-server", local=True, remote=True)
+
+    def _server(self, remote, kill=False):
+        host = self.env.remote if remote else None
+        address = self.env.remote_addr if remote else self.env.addr
+        args = ["kperf-server", "--pid-file", self._pid_file]
+        args += ["--kill"] if kill else ["--addr", address]
+        return cmd(shlex.join(args) if remote else args, host=host,
+                   fail=not kill)
+
+    def __enter__(self):
+        try:
+            for remote in (False, True):
+                self._server(remote)
+                self._started.append(remote)
+            wait_port_listen(KPERF_PORT)
+            wait_port_listen(KPERF_PORT, host=self.env.remote)
+        except Exception:
+            self.close()
+            raise
+        return self
+
+    def close(self):
+        while self._started:
+            self._server(self._started.pop(), kill=True)
+
+    def __exit__(self, _exc_type, _exc_value, _exc_tb):
+        self.close()
+
+    def run(self, client_args=()):
+        """Run kperf and report results when a SystemMonitor is active."""
+        argv = ["kperf-client", "--src", self.env.remote_addr,
+                "--dst", self.env.addr]
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
+        if ksft_metric_reporting_enabled():
+            ksft_metric_aggregate(
+                "throughput", summarize="distribution",
+                regression={"compare": "p50", "better": "higher",
+                            "relative_tolerance": 0.05})
+            ksft_metric_aggregate("tcp.retransmits", summarize="max")
+            for host, throughput, retransmits in (
+                    ("remote", result.source_throughput,
+                     result.source_retransmits),
+                    ("local", result.target_throughput,
+                     result.target_retransmits)):
+                ksft_metric("throughput", throughput, shape="scalar",
+                            host=host)
+                ksft_metric("tcp.retransmits", retransmits, shape="scalar",
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

