Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355373;
	b=RWbsN+LM3h8FObgEsoS8wym29y2q+3KesqBxLR3gIMQENSyYac5WbbcMQ1hxwfRHCrYV
	 hZu+jacmPucYl2tj7pVuKWbPj82sIV3yZcVmkXflk3qU7pHpU/UlxDFhaFv1UGzEAw5uX
	 iqENMNveNmiWi7nwMsks1yP598EJm++JdSVV2rMpzfU2KZ4wZ0AnhzQ6s6J6bwm3lHzB7
	 BxGqaI8TPnK997kXvI7p2btmUM+a9rFoDsGHyHNf/yDb5H6KesYAkRbnlPZseeKZLziK4
	 W/uHrjngiPJQxYyqqLDBAS/FZrcC7BJa2Xqd+mO+B+XQsJveMEo8nOrgBKPp8kzBIOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3rWM8rZ/iDO2E62pLMbIiggyXTReyyu2ewIC7I+Pnek=;
	b=CwYknYtDzNYPLYVycwQeh41qEA9BHLWPeG6nkHFC45FSxk1IjgO2AxucDrWWNtTohtQJ
	 20tKR8wCx27R/JxPe8KnDchVmSKCKvXI9VPaOIV1NkQXTZpi+1DX0gx4sDyg8puq28IWU
	 vqr9aczWB0IcQshQF4ZEmOQwP/iIM5NN+vABeuIjtjEICX8GVg+QWeA3KoxHcZM/WFcP1
	 Hsj9ChLmIaAg0PQu7zzetLSWyuQ3RwWLa/uJFle3IqUq1Ot4upXARHQfhPigpNPVOSBEa
	 B2HhOVKWFRfeSKugBg2Y4vNFvVitx8KLMt2WAFJsEWG80qMUaXsKxQSeol0fjN2kHnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rt1Rm0cb;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BF7606A31C
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 00:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06BF7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rt1Rm0cb
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-35eaf84cc66so2419675eec.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 16:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794355372; x=1794960172; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3rWM8rZ/iDO2E62pLMbIiggyXTReyyu2ewIC7I+Pnek=;
        b=rt1Rm0cb5QSSu2k8q1Tpzt5K1Pp8s/+HiCYvh49QjA1ZJVrNW90fVLvz97uBalqkmc
         IYyUbtU8Op9p4S0JRI/ryAO80a2AQ++6A+2lSzS8660lv9DNvjSTOO3baKUWKYXTeftI
         VbBzlXdqJK6xTTIGmg/MP6fZYH0uM5tGvydkRi5HOTNtSo20pc3RMoTl/eY9f7ttapKw
         naFj+fycaNDlfP+zgUw5YghlS0087zwB6uYZPTroNPSw9g9wlTN0VuQikXwKK3xRiVaT
         w0e8VmTmFAdudoJbSSMQ03ixdKVgvRl98w9Jk7DiDIqZhvicpZbZaBE1iwzWOn+QSG2n
         Hgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794355372; x=1794960172;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3rWM8rZ/iDO2E62pLMbIiggyXTReyyu2ewIC7I+Pnek=;
        b=Z1niPvQ9P477P6PdxS5RlUe4KNJeRflNbKFyxr/pCobIZRqyBGt9nojntZRerRMvXy
         NyOkbyqWD9VeT7xXd/Ngu0XE8mqlskDcNAS2MUfm8XmHTi+2Rs7gFksV4bc+kKC7Qhci
         GKfzy7dNRcRBYLZgdMeAXaDk4vyfIA1HT5nSaLKNbe9+gcw2kaTQzriCBOiH4SKY/edz
         lAAh1T2A6sDPh8dz6mQhkCr8s7coh9KGECH0Xjl9MvFmbPk2SmRs9qriWGvOdRErf5Fj
         KT+ktCziWi+0hsHtY32GXWUM3OeYJe7+Uwpu2+H3I7GZaLjhTexUfnKsirDxU/CAcyLB
         BkdA==
X-Gm-Message-State: APuU4Z+SMsjsBy7eic6mDbi39xFt2oZuKfx99N5llx7h4rsPOThk5fhc
	WOhq9x687ta2kEMhzAaqw2D5LwSs4O76Wm9bzrMUf5zhAo+leaZfPBJBkllUo1seIlU=
X-Gm-Gg: AYBFou0nWcYQXtBPW74sNDSroEZPlwxCvPd23pet/a2aG5aRD9uXpogVqqGlvWrVU+M
	/B5h+v/mxfKhlXRUBgoItBUkMPhb1Tslbik1qbsdLuFhD+Jri6SdIQzDU58Xl65U6YA/ESa9fD/
	wSkLhA6nV3MEdyOq33vIi56iNTfN7TCS4VewsxGInm1eerntq9ehZ1RE7ABoMGuEhfufwn9F6yz
	Nc6WcS4w4w8xYT7q96LPMj5UEHh8Lo3pPe69kdv6k3BJzGVEYMbwX0Ua1OneyD5Is+PkSFAaZyQ
	idtE/vAkq6KFy/8Vy92Vbt3yzZI/TQrUHqpj+N4a+dykGhPSaVRC26v+AKwxDOmAK3eOcXJHsg7
	vYn8w/BndAfJDrPl9ZVq1NryD/wN+h8OhzCwAiujTJbOVlbRu+WrxsLZoh7s84bUPCYfUHKVtyF
	EltK44y4snA3ko27eZ+DL2sC+AOYJZkz9d6LWn8DQ+w813uzWeLyTUr+gT4CCcIbMNLYkknrdHG
	FYnBA+SMd9D815vuSIkDIbdXH8+n88ymL3UhxzCw8WomMVVeh1Y2WxkYvkIOdldljJuhjKtNiI8
	rtnWnyXAqzH+9NLJy2wY9yA=
X-Received: by 2002:a05:7301:2329:b0:358:3426:d601 with SMTP id 5a478bee46e88-3768366a41amr1096875eec.2.1794355371446;
        Tue, 10 Nov 2026 16:02:51 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:6e::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfe07dsm10508576eec.20.2026.11.10.16.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 16:02:51 -0800 (PST)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Subject: [PATCH net-next v4 3/4] selftests: drv-net: add a kperf runner
Date: Tue, 10 Nov 2026 16:02:45 -0800
Message-ID: <20261111000246.962871-4-sdf@fomichev.me>
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

Add a helper to manage kperf servers, run the client, and return the
aggregate throughput of both ends. Use a random control port and a unique
PID file per server, as the hosts may share /tmp, and report server cleanup
failures. kperf-server --kill waits for the sessions of a server to exit,
as they may still be releasing devmem and RX steering, which the next test
needs. A server which can log does so to a file next to its PID file, and
the end of both logs is printed when the client fails, as the client can
only tell that a server went away.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../selftests/drivers/net/lib/py/__init__.py  |   4 +-
 .../selftests/drivers/net/lib/py/kperf.py     | 157 ++++++++++++++++++
 .../drivers/net/perf/lib/py/__init__.py       |   6 +-
 3 files changed, 164 insertions(+), 3 deletions(-)
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
index 000000000000..8ee8c5ba2ff7
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/lib/py/kperf.py
@@ -0,0 +1,157 @@
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
+    def close(self):
+        """Stop the started kperf servers, which waits for their sessions."""
+        failures = []
+        while self._started:
+            remote = self._started.pop()
+            command = self._server(remote, kill=True)
+            if command.ret:
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
index f16606cedd00..fcc5234cdd57 100644
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

