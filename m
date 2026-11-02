Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793646513;
	b=eH/18XAYsCpPvYmOzyTszql2IgWda1tRHmiWEM64suml+n1Yi9J8Kn2PsB4HL7Og5s8Z
	 IewFb5wEggR5avxTYU8/+eCjUGMbToUWn9kak9I//+fyUfzv8eqNz2pMpqzviegktCZok
	 +mrG0GwhTvcuvHVJQ11EV621BHrXvDRHUy8qbT1GvEh2B/5JxiAUUybTjepyh9XAyBpoy
	 wDuiAmvc1h69+5FUFOO2iN+A4n4/+ptfOlYG9r3pH6/qhaRLsRDVYByMKylCQM5Ze5mKk
	 x9BtzBIIxl3X++5gT9GN631zl2I/UUFwE+mcjk1od1KKvqqKhYF+PgX94hrH7H5my9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YtFqY7W8rKDzDbk4l6NF+qinF1g3cFeZzwgTyHvWnFs=;
	b=NG7nP0HkBTeFozO4Nyk9RGXTIpbtBGPJ0puKyxKYK89UbamOxgcp7CdsBflSXKjFwLpv
	 Dk0cFDrsumPZ1qceupZ20IooB40K7iqDjZCAz8iN4sSQLU1gZbumufp92FUBy8GWp1UfF
	 RkNP4e/egzpo7YwjFu+rXpZS+DaYA7+6zbGdH2WJWzXLkcSZqXjki5z03QHmwtZEFV7rn
	 lwqOeYVSuJh3tDBGdxzdzuYBi0YP7X6zEsHFx0GvLZzMFA7jBdSmEGaemqX32iyPI984v
	 XVdq0OfiuAHYxObrQNRN43LNbFmuzNVMrJIQfgq7w08Z5NAhccMFvRDT77TlCer6VJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vUfALmKQ;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3007606EEB7
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 19:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3007606EEB7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vUfALmKQ
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-369ef2c6802so427635eec.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 11:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793646512; x=1794251312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YtFqY7W8rKDzDbk4l6NF+qinF1g3cFeZzwgTyHvWnFs=;
        b=vUfALmKQL69cYyhUNIQ4iXlla3j9md/VV8sCsIYol8A+Dni3mBMsZerBVGSpsJ6Zsi
         pns3k3iqHoYKVDf9UoJKoCYXlOhBoEsEp2TuOFN3OUCNHFTNrFY+bUkBTJLMb7OBc2tO
         lcDkvseb7wHWDIQF/Y7QQM+mYvg3K5i0O7AoryCZ6tn3Or93XbBiUBN0xrb8h8/lMNOr
         TCa5atwnuKxbeaNF0BfoywMgQ0iI3xwhM0Bqhh6ATcGG1QOWlH/PtmmYyjAJQPFSLWbd
         By2AKtO0uHC8rs9REGxZR+i1B092/XljPaRDg7iLWRTqQmb87YShd/5uHU8UFMKwF7tE
         TH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793646512; x=1794251312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YtFqY7W8rKDzDbk4l6NF+qinF1g3cFeZzwgTyHvWnFs=;
        b=LKHITD3XwweqVJygA0YPrsdAQ3bmjsAXwB9C27GwrkrRfX0LbgjX8ITbzEqRvjfFlh
         4vAt2xiKOA4Z0ypagx8GLEpDZe4P9ludRzrpqT+Yd3IA2rVn0HHuoOk8lQ9/dVOyEYnc
         16d4HC4jmzYTcYx/wSvIYvUEeDf9T/DaijR+OQui8GKXTCAUWmFAle65aTrXFcr25ABC
         Ut6bfocC28zCMtdyDZIBMt8M/2C/MDQchxu+KgFRUQRDcrLT11MZPJVdU4ysJ/0xY/4s
         fwUHRx//gEZUWZaJbEmh/exYL8ZR0K5y87zFaV5xFUcikiTmO4jVYvn66ZLVFw9EISop
         Nddg==
X-Gm-Message-State: APuU4Z9Wk+bZppN3nooAe18S1HjSNORplvwTia9G13m9D26TvAqFfR7t
	B5ysJaWWl4HE+8F63pKwVqjSXqRbw5ISbgzCn5hr8jtV2kIb34eekbcr46OVktuO
X-Gm-Gg: AYBFou2ly1/YS9rkt8tXEqo01T9etI3X6SrNpchHGKaJxM2QjVXQb/6ZNm3l5qzS4Bk
	D27d5FkOACsz7sn7eugqsoWpXIv0WVE/Ai6WwcjyqUv+FXkxkCKfrdT4m8ANuxX5EWguazCOZSq
	NOgAlA0v30uYJnMTAqc4lSNX3kMJ28wz2VXJbqO43P11BpLW/6YzFdaaWx5Pwf13CxulmZSo4wi
	fUwhgW0V+4nXytwgG1c358q+P6tgbffcYeCbzvazJM/gTzHb/tMlBm5hq8XXCS+oWECRMbv+w/7
	LxeDhPhTtvFzmjvnHTPml/wwT8tHhK8uOobhq9I39KYgkoHvi7j+fK0Ffhe4uKpjjyE6+FsjKBd
	m+dfNOATWu7A0IRh2PN8q06MslZc47fSaQglf/e5sIN5grQL0k7FVziOCNYHG5MwioBkxz4DQny
	FITTPP4Zt8wa6azWMKtK9EYcNDyFeXIPPB0QEhjLCMX89ig/n3U+FLqDNw3CC0BZhlyUAFSb92w
	Hbj+T7t6XWb3Ig2ZCtOidK8Ion/gmh0wgCPw+0YW6ue24NS3SChWmVkfoBnizVROpOJKx/Ppia0
	ATfKPghV1edFZcq5SEPAE5E=
X-Received: by 2002:a05:7301:1448:b0:359:fb64:11d7 with SMTP id 5a478bee46e88-36a423f6263mr16592770eec.11.1793646511730;
        Mon, 02 Nov 2026 11:08:31 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:6f::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a429467cdsm37559375eec.19.2026.11.02.11.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:08:31 -0800 (PST)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v3 3/4] selftests: drv-net: add a kperf runner
Date: Mon,  2 Nov 2026 11:08:26 -0800
Message-ID: <20261102190827.989117-4-sdf@fomichev.me>
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

Add a helper to manage kperf servers, run the client, and return the
aggregate throughput of both ends. Use a random control port and a unique
PID file per server, as the hosts may share /tmp, and report server cleanup
failures. Stopping the servers waits for their sessions to exit, as they
may still be releasing devmem and RX steering, which the next test needs. A
server which can log does so to a file next to its PID file, and the end of
both logs is printed when the client fails, as the client can only tell
that a server went away.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../selftests/drivers/net/lib/py/__init__.py  |   4 +-
 .../selftests/drivers/net/lib/py/kperf.py     | 181 ++++++++++++++++++
 .../drivers/net/perf/lib/py/__init__.py       |   6 +-
 3 files changed, 188 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/kperf.py

diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 40ccdcf0c378..7a32f6516a12 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -49,11 +49,13 @@ KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
 
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
index 000000000000..53870d0caf14
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/lib/py/kperf.py
@@ -0,0 +1,181 @@
+# SPDX-License-Identifier: GPL-2.0
+
+"""Run and parse kperf network performance measurements."""
+
+import re
+import shlex
+import subprocess
+import time
+import uuid
+from dataclasses import dataclass
+
+from lib.py import cmd, ksft_pr, rand_port, wait_port_listen
+
+
+_SECTION_RE = re.compile(r"==\s+(Source|Target)\b")
+_RATE_RE = re.compile(r"\b(Tx|Rx)\s*([0-9]+(?:\.[0-9]+)?)\s+Gbps\b")
+
+
+@dataclass
+class KperfResult:
+    """Aggregate throughput (Gbps) of both endpoints."""
+
+    source_throughput: float
+    target_throughput: float
+
+
+class KperfRunner:
+    """Manage kperf servers and run measurements between test endpoints."""
+
+    def __init__(self, env):
+        self.env = env
+        self._pid_prefix = f"/tmp/ksft-kperf-{uuid.uuid4().hex[:8]}"
+        self._port = rand_port()
+        self._started = []
+        env.require_cmd("kperf-client", local=True)
+        env.require_cmd("kperf-server", local=True, remote=True)
+
+    def _pid_file(self, remote):
+        # The hosts may share /tmp (netns), and kperf-server kills the
+        # process named in an existing PID file.
+        return f"{self._pid_prefix}-{'remote' if remote else 'local'}.pid"
+
+    def _log_file(self, remote):
+        return f"{self._pid_prefix}-{'remote' if remote else 'local'}.log"
+
+    def _server(self, remote, kill=False):
+        host = self.env.remote if remote else None
+        address = self.env.remote_addr if remote else self.env.addr
+        args = ["kperf-server", "--pid-file", self._pid_file(remote)]
+        if kill:
+            args.append("--kill")
+        else:
+            args += ["--addr", address, "--port", str(self._port)]
+            # The output of a daemon is lost, unless it can log
+            usage = cmd("kperf-server --help", host=host, fail=False)
+            if "--log-file" in usage.stdout + usage.stderr:
+                args += ["--log-file", self._log_file(remote)]
+        return cmd(shlex.join(args) if remote else args, host=host,
+                   fail=not kill)
+
+    def _print_logs(self):
+        """Print the end of the logs of the servers, to tell why the client
+        failed.
+        """
+        for remote in self._started:
+            host = self.env.remote if remote else None
+            args = ["tail", "-n", "30", self._log_file(remote)]
+            log = cmd(shlex.join(args) if remote else args, host=host,
+                      fail=False)
+            if log.stdout.strip():
+                name = "remote" if remote else "local"
+                ksft_pr(f"kperf-server log ({name}):\n{log.stdout.strip()}")
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
+    def _wait_exit(self, remote, timeout=60):
+        """Wait for the sessions of a server to exit.
+
+        Killing the server leaves its sessions, which exit once they have
+        released their devmem and RX steering, which the next test needs.
+        Being forked, they run with the server's command line.  The
+        bracket keeps pgrep from matching the shell which runs it.
+        """
+        host = self.env.remote if remote else None
+        args = ["pgrep", "-f",
+                f"[k]perf-server --pid-file {self._pid_file(remote)}"]
+        deadline = time.monotonic() + timeout
+        while True:
+            pgrep = cmd(shlex.join(args) if remote else args, host=host,
+                        fail=False)
+            if pgrep.ret:
+                return None
+            if time.monotonic() > deadline:
+                return pgrep
+            time.sleep(0.1)
+
+    def close(self):
+        """Stop the started kperf servers, and wait for their sessions."""
+        failures = []
+        while self._started:
+            remote = self._started.pop()
+            command = self._server(remote, kill=True)
+            if not command.ret:
+                command = self._wait_exit(remote)
+            if command:
+                failures.append(command)
+            host = self.env.remote if remote else None
+            args = ["rm", "-f", self._log_file(remote)]
+            cmd(shlex.join(args) if remote else args, host=host, fail=False)
+        if failures:
+            details = "\n".join(str(command) for command in failures)
+            raise RuntimeError(f"failed to stop kperf server(s)\n{details}")
+
+    def __exit__(self, _exc_type, _exc_value, _exc_tb):
+        self.close()
+
+    def run(self, client_args=()):
+        """Run kperf and return its KperfResult."""
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
+            self._print_logs()
+            raise RuntimeError(f"kperf client timed out\n{command!r}") \
+                from error
+        if command.ret:
+            self._print_logs()
+            raise RuntimeError(
+                f"kperf client exited with status {command.ret}\n{command!r}")
+
+        try:
+            result = self.parse(command.stdout + "\n" + command.stderr)
+        except ValueError:
+            ksft_pr(command)
+            self._print_logs()
+            raise
+
+        return result
+
+    @staticmethod
+    def parse(output):
+        """Parse human-readable kperf client output."""
+        throughput = {"Source": [], "Target": []}
+        section = None
+
+        for line in output.splitlines():
+            match = _SECTION_RE.search(line)
+            if match:
+                section = match.group(1)
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
+
+        if not all(throughput.values()):
+            raise ValueError("incomplete kperf result")
+
+        return KperfResult(sum(throughput["Source"]),
+                           sum(throughput["Target"]))
diff --git a/tools/testing/selftests/drivers/net/perf/lib/py/__init__.py b/tools/testing/selftests/drivers/net/perf/lib/py/__init__.py
index 2bb2cd08ff7d..c07f1ac5e80a 100644
--- a/tools/testing/selftests/drivers/net/perf/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/perf/lib/py/__init__.py
@@ -32,7 +32,8 @@ KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
         ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
     from drivers.net.lib.py import set_ethtool_feat
-    from drivers.net.lib.py import GenerateTraffic, Remote, Iperf3Runner
+    from drivers.net.lib.py import GenerateTraffic, Remote, Iperf3Runner, \
+        KperfResult, KperfRunner
     from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv, NetDrvContEnv
 
     __all__ = ["NetNS", "NetNSEnter", "NetdevSimDev", "UserNetNS",
@@ -50,7 +51,8 @@ KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
                "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
                "ksft_not_none",
                "NetDrvEnv", "NetDrvEpEnv", "NetDrvContEnv", "GenerateTraffic",
-               "Remote", "Iperf3Runner", "set_ethtool_feat"]
+               "Remote", "Iperf3Runner", "KperfResult", "KperfRunner",
+               "set_ethtool_feat"]
 except ModuleNotFoundError as e:
     print("Failed importing `net` library from kernel sources")
     print(str(e))
-- 
2.53.0-Meta

