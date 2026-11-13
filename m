Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794549828;
	b=sWsCmyTyGI0tSWmW7rQV7GsUKaNooCcYzaZMT2PHPvtqKx3EQWmhc+ObX1I0ErVuyD9x
	 pTsTPRW+m7NgJU2EyKjGeJv6Lu8EwwhWQM2gKTCBXrVOdbO2xamK/vRb+HF9AeJIUgURX
	 epFIviGc1ZXZxLknzqxX0swO7Lve2a495JHWH+Em6HDK6nWtrTV/ffRsRD1EbA54kLXHA
	 W8FAF++XsN8kmpYQkReTKj/ZsLIklT5FqU8yTNN4ObaB1JvO/swvoO7H0LLvOZ303mW5D
	 nVg34DcvVezilrSdp2/wOTt1kRurxPG710KMjtB7VNrOr8M4C5GgJHgVyNnzXJbDr6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794549828;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=YV4norfrC55/VIeb/FA3aYa/JvEx3U0FXg7dVNyqt1Q=;
	b=QECutIfakoMrh0ppN0pN/ZUnAwCPYz/vd41axucQyyoSDpctdEPi5CGRCM5+hZmxzVWV
	 onVVE39vW5rKsWslu9Ir/ffgBdonkjsBrOGXhhAHj2pNrFlUykHJCcjK449CqBc02ATIU
	 hExx/OrLRqlJ4f1k4g1w0GiiZepcGKNcW9h5ORgWQEAWI5wQU8O/WUO1qVOLfvukFi450
	 RMXz/SeF5PBY6vpwWe93IX1TEFyDO57irvflQl8lmpgWTFWxn4CRHzDK/f3wXqJJMvdjL
	 3N+YHvCr8myXl9RUtQO1iUl9ug3HM/jzQVFXq9flZH0cpIAKOxBtmczVSJjjkn1ztrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D5jqzUVT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A488606A33A
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 06:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D5jqzUVT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B221F000C4;
	Fri, 13 Nov 2026 06:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794549828;
	bh=YV4norfrC55/VIeb/FA3aYa/JvEx3U0FXg7dVNyqt1Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D5jqzUVT4pL90kQWaPzYvrXgFTo5E9AFVcGpZjX7PM+57IZlr7ZM2LQLf9I1ASjVN
	 xdMcQK2reZ4vNGavicaJIGBsh7xnyDMKvKy6mCgg5l5vtKMEVRjqwLx6NvCtxaOi9t
	 V743OHMnxBKVlYgPI8Pc7LfNd/e9NC+5eVH50aNX/0ptYql+gBE249ZX2JWjmwHYhu
	 vYV23aPx287frWHAzkMCRom2ijJ//F8hrAGVkkO8PJE+ubmsYjIdetyGe1PxJqAo+S
	 56GLat+Wf0dsfg6xgBizJxC/Uei3r1c0H1MsS9ocn417A6Sig8DDSikVNBC0KV2Nnc
	 qc5BMppTSqvRQ==
Subject: Re: [PATCH net-next v4 3/4] selftests: drv-net: add a kperf runner
From: netdev-bot+sashiko@kernel.org
To: sdf.kernel@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org
Date: Fri, 13 Nov 2026 06:03:47 +0000
Message-ID: <179454982769.2199510.3173599793961584974@kernel.org>
In-Reply-To: <20261111000246.962871-4-sdf@fomichev.me>
References: <20261111000246.962871-4-sdf@fomichev.me>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] KperfRunner.close() in
  tools/testing/selftests/drivers/net/lib/py/kperf.py is meant to keep…
- [Low] In KperfRunner.__enter__
  (tools/testing/selftests/drivers/net/lib/py/kperf.py), a server is…
- [Low] selftests: drv-net: KperfRunner.__enter__() misses BaseException
  cleanup

--

selftests: drv-net: add a kperf runner

This adds a KperfRunner helper to the drv-net python library. It starts
kperf servers on the local and remote hosts, runs kperf-client, and
returns the aggregate throughput of both ends. Each server gets its own
PID and log file, and close() stops the servers with kperf-server --kill
and reports any cleanup failures.

> diff --git a/tools/testing/selftests/drivers/net/lib/py/kperf.py b/tools/testing/selftests/drivers/net/lib/py/kperf.py
> new file mode 100644
> index 0000000000000..8ee8c5ba2ff7b
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/lib/py/kperf.py

[ ... ]

> +    def _server(self, remote, kill=False):
> +        host = self.env.remote if remote else None
> +        address = self.env.remote_addr if remote else self.env.addr
> +        args = ["kperf-server", "--pid-file", self._pid_file(remote)]
> +        if kill:
> +            args.append("--kill")
> +        else:
> +            args += ["--addr", address, "--port", str(self._port)]
> +            # The output of a daemon is lost, unless it can log
> +            usage = cmd("kperf-server --help", host=host, fail=False)
> +            if "--log-file" in usage.stdout + usage.stderr:
> +                args += ["--log-file", self._log_file(remote)]
> +        return cmd(shlex.join(args) if remote else args, host=host,
> +                   fail=not kill)

[ ... ]

> +    def __enter__(self):
> +        try:
> +            for remote in (False, True):
> +                self._server(remote)
> +                self._started.append(remote)

[Severity: Low]
A server is added to self._started only after self._server(remote)
returns successfully. What happens if kperf-server has already
daemonized and written its PID file, and the start command then raises?

For example, the remote ssh session could drop and exit with 255, or it
could stall past the default 20 second cmd() timeout after the daemon
has detached. CmdExitFailure or TimeoutExpired would be raised before
the append.

The except block below calls self.close(), which only walks
self._started, so --kill is never issued for that PID file. Could this
leave the daemon running, along with its PID and log files, and holding
devmem or RX steering into later tests?

Since --kill already runs with fail=False, one option is to record the
server before starting it. Another is to always issue --kill for both
PID files during cleanup.

> +            wait_port_listen(self._port)
> +            wait_port_listen(self._port, host=self.env.remote)
> +        except Exception:
> +            self.close()
> +            raise
> +        return self
> +
> +    def close(self):
> +        """Stop the started kperf servers, which waits for their sessions."""
> +        failures = []
> +        while self._started:
> +            remote = self._started.pop()
> +            command = self._server(remote, kill=True)
> +            if command.ret:
> +                failures.append(command)

[Severity: Low]
Does this rollback still run if the test is interrupted while the
servers are starting?

The kselftest SIGTERM handler, _ksft_intr() in
tools/testing/selftests/net/lib/py/ksft.py, raises KsftTerminate,
which subclasses KeyboardInterrupt. Neither of them derives from
Exception. A SIGTERM timeout from the runner, or a Ctrl-C, can arrive
while the second kperf-server is being started or while __enter__()
is polling in wait_port_listen(). In that case this handler is
skipped.

The with statement also does not call __exit__() when __enter__()
raises. So the servers already recorded in self._started never get a
kperf-server --kill. They would keep running in the background and
listening on the control port. Their PID and log files under
/tmp/ksft-kperf-* would also be left behind.

The handler re-raises anyway, so would it make sense to catch
BaseException here? That way the started servers are also stopped on
SIGTERM and KeyboardInterrupt.

[Severity: Medium]
Can the kill command raise here instead of returning a non-zero ret?

_server(remote, kill=True) calls cmd() with fail=False but keeps the
default timeout from tools/testing/selftests/net/lib/py/utils.py:

    def __init__(self, comm, shell=None, fail=True, expect_fail=False, ns=None,
                 background=False, host=None, timeout=20, ksft_ready=None,

That leads to cmd.process()->_process_terminate(), which does:

    stdout, stderr = self.proc.communicate(timeout=timeout)

fail=False only affects the return code check after communicate()
returns. If the kill takes longer than 20 seconds, subprocess.
TimeoutExpired is raised anyway. The commit message says this can
happen, since --kill waits for sessions that may still be releasing
devmem and RX steering. A stalled ssh link would trigger it too.

When that happens, the exception leaves the while self._started loop.
pop() handles the remote server first, so if the remote kill times
out:

  - the local kperf-server is never killed
  - neither log file is removed by the rm -f
  - the RuntimeError that collects the failures is skipped
  - the timed out kill subprocess keeps running, because communicate()
    does not kill the child on timeout

__exit__ calls close() only once, so would a stale server be left
holding the devmem or RX steering resources that the next test needs?

On the __enter__ error path, the TimeoutExpired from close() also
becomes the exception that is raised, and the original setup error is
only chained as context.

Would it make sense to pass a larger timeout to the kill command? The
loop could also catch exceptions per server, so the remaining servers
and log files still get cleaned up.

> +            host = self.env.remote if remote else None
> +            args = ["rm", "-f", self._log_file(remote)]
> +            cmd(shlex.join(args) if remote else args, host=host, fail=False)
> +        if failures:
> +            details = "\n".join(str(command) for command in failures)
> +            raise RuntimeError(f"failed to stop kperf server(s)\n{details}")
> +
> +    def __exit__(self, _exc_type, _exc_value, _exc_tb):
> +        self.close()

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111000246.962871-1-sdf%40fomichev.me
