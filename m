Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492D3381EAF
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790042176; cv=none; b=Q1fuoy6QkYSB463br+I9U/xZvoFgGDH9zevFtCraruCS/l/YMKz5NQ1l1kh2TL9+cNt0y8vN5sRQlOEEhXOHYEoP6V9vmhs2SKwC00hdtGc+CVZkgDqOjPqcFyrQ0tsxqkG0hMnuoIIBFomCQyi4OGJ9KEOAvf1xqoqOsxqFOyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790042176; c=relaxed/simple;
	bh=QRAQ+poW3yxTFEEk1rIwf5aqOURFAZrsJGma6IDinAc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EM61jn1GZJOUYuf7Gh6RNAV54MjLRxOF2d6JO8wTyRH7CjONua3HKesR1hN0WiNX5iZof+7m9NACRv8+6TtRSR0VBTNEbotnqt+u8LO8+IaJQqgpzRO7d21/ocJQ4dTjFDyAZzOxGBnVCedRA+FmkyzNGeypOIk+0S9nCrAOFYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsCZvR6B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsCZvR6B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761491F00893;
	Tue, 22 Sep 2026 01:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790042174;
	bh=R8inby/WiInztafOmrQih6NvKhTGTGu9RHkvmUKz2/Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PsCZvR6BWiyNSTt8NE1FkcfLEzZ+bZfdQSJq9JwAmGiSrWDYurodl9lfOJD3A6+q/
	 O/xd6smxCNEiwd/ecNeXYVphj8+IIPW6A/1bk+3Jp2To4FmP78qtjaRSUMjWHVc8Nf
	 G+z4Jw9I7gcl80RM/NeSw2mdwvY+v1gJlcg70XRBSrH6AC5/5Cg59NKj9L3VrKxN9t
	 KgVC37OaH0i/oSlFyBx9Vl0ndWc5a0T5kya+H++VcK9LLcJRvtdEUtrvpm+hp/2ZAD
	 nmuoDizkO52dxQsS4akoV9Gw1s6fP7fGEhZ6CfdY/LKAepCgsGSNYBFFiuWBa5/aSp
	 BKkA2wJKeMz/Q==
Subject:
 Re: [PATCH net-next v17 14/15] selftests: net: add TLS hardware offload test
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
 kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, leon@kernel.org, andrew.gospodarek@broadcom.com
Date: Tue, 22 Sep 2026 01:56:13 +0000
Message-ID: <179004217306.2160803.4239379777878519433@kernel.org>
In-Reply-To: <20260917224355.2288021-15-rjethwani@purestorage.com>
References: <20260917224355.2288021-15-rjethwani@purestorage.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 6 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] check_tls_support() in
  tools/testing/selftests/drivers/net/hw/tls_hw_offload.py runs…
- [Medium] check_tls_support() only inspects the direction-wide `tls-hw-
  tx-offload` / `tls-hw-rx-offload` netdev feature bits, which say…
- [Medium] The comment added in run_tls_test() asserts that the `finally`
  clause reaps a hung helper 'within this variant's window' so it cannot…
- [Medium] verify_tls_counters() accepts an aborted rekey as a legitimate
  terminal outcome: it asserts only `TlsTxRekeyAborted <= 1` and…
- [Medium] run_tls_test() starts the server with bkg(..., exit_wait=True)
  - which captures stdout/stderr into pipes and does not call…
- [Medium] In burst mode the server never validates how many complete
  iterations it received.
- [Low] HW_CRYPTO_COUNTERS maps only 'mlx5_core' to
  tx_tls_encrypted_packets / rx_tls_decrypted_packets, so…
- [Low] parse_int_arg(optarg, 1, INT_MAX, "iteration count",
  &num_iterations) (tls_hw_offload.c:1042) explicitly accepts -n…
- [Low] server_accept_tls() arms a 30 s SO_RCVTIMEO for accept()
  (tls_hw_offload.c:666) while the harness joins the background server…

--

selftests: net: add TLS hardware offload test

This adds a two-node kTLS hardware offload selftest: a C helper binary that
acts as TLS client or server, plus a Python harness built on NetDrvEpEnv
that snapshots and verifies the TLS MIB counters around each run. Variants
cover TLS 1.2/1.3 with AES-GCM-128/256, echo-mode rekeys over several
buffer sizes, and burst variants that stress TX and RX KeyUpdate handling.

A few questions about the test logic and the harness below.

> diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
> index d89a9ba17655..169e608516bd 100644
> --- a/tools/testing/selftests/drivers/net/hw/config
> +++ b/tools/testing/selftests/drivers/net/hw/config
> @@ -22,6 +22,8 @@ CONFIG_NET_IPIP=y
>  CONFIG_NETKIT=y
>  CONFIG_NET_SCH_INGRESS=y
>  CONFIG_SYNC_FILE=y
> +CONFIG_TLS=y
> +CONFIG_TLS_DEVICE=y
>  CONFIG_UDMABUF=y
>  CONFIG_USER_NS=y
>  CONFIG_VXLAN=y

[ ... ]

> diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
> new file mode 100644
> index 000000000000..303c6752ace2
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
> @@ -0,0 +1,1132 @@

[ ... ]

> +	rekey_interval = num_iterations / (num_rekeys + 1);
> +	next_rekey_at = rekey_interval;
> +
> +	for (i = 1; i <= num_iterations; i++) {

[Severity: Low]
Is -n INT_MAX actually a usable value here?  main() accepts it:

	case 'n':
		if (parse_int_arg(optarg, 1, INT_MAX, "iteration count",
				  &num_iterations) < 0)

but do_client() drives a signed int with an inclusive bound, so
terminating the loop requires evaluating INT_MAX + 1, which is signed
overflow; with wrapping arithmetic i goes negative and the loop keeps
going.  do_server() has the same shape with send_iter++ in the burst
path.  The harness never passes anything near that, so this is only
reachable from the command line the usage text advertises - would
capping the accepted range (or making the counters unsigned/long) be
preferable?

> +		int this_size;

[ ... ]

> +	/* Bound accept() so a client that never connects (a deploy or connect
> +	 * failure on the peer) does not block the server forever and leak the
> +	 * process past the harness timeout. accept() honours SO_RCVTIMEO on the
> +	 * listening socket; the client connects right after wait_port_listen(),
> +	 * so 30s is generous.
> +	 */
> +	{
> +		struct timeval tv = { .tv_sec = 30, .tv_usec = 0 };
> +
> +		setsockopt(lsk, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
> +	}

[Severity: Low]
Does this 30 s bound in server_accept_tls() actually keep the server
inside the variant that started it?  run_tls_test() joins the server
through bkg(..., exit_wait=True), which reaches cmd.process() with no
timeout argument, i.e. the 20 s default in
tools/testing/selftests/net/lib/py/utils.py:

    def process(self, terminate=True, fail=None, expect_fail=False, timeout=20)

So on a client-side setup failure the helper's own accept() bound
outlives the harness's join window, and the listening socket plus the
process can still be around while the next variant picks a rand_port()
and takes its before/after counter snapshots.  Would 30 s here want to
be shorter than the harness join timeout, or the join given an explicit
timeout?

[ ... ]

> +	/* Main receive loop */
> +	while (1) {
> +		char *dst = burst_mode ? buf + filled : buf;
> +		size_t want = burst_mode ? (size_t)(send_size - filled)
> +					 : (size_t)buf_size;
> +
> +		n = recv_tls_message(csk, dst, want, &record_type, 0);
> +		if (n == 0) {
> +			/* A clean close on an iteration boundary is success;
> +			 * one with a partial iteration still buffered means the
> +			 * peer dropped the tail - the truncated-data case this
> +			 * test exists to catch, so fail loudly.
> +			 */
> +			if (burst_mode && filled) {
> +				printf("FAIL: closed mid-iteration (%d/%d bytes buffered)\n",
> +				       filled, send_size);
> +				goto out;
> +			}
> +			printf("Connection closed by client\n");
> +			break;
> +		}

[Severity: Medium]
Does this catch the truncation case the comment describes?  The EOF
check only rejects a partial iteration (filled != 0).  If a whole number
of send_size iterations is lost at the end of the stream, filled is 0,
do_server() breaks out and sets test_result = 0.

The count is tracked but never checked: recv_count++ happens per
completed iteration and is never compared against an expected total,
and run_tls_test() passes -n only to the client:

    if num_iterations:
        client_parts.append(f"-n {num_iterations}")

So losing a suffix of complete iterations - for instance after the last
KeyUpdate, where the rekey deltas already match and check_hw_crypto()
only needs one packet - passes on both helpers and in the harness.
Would passing the expected iteration count to the server and comparing
recv_count against it close that?

> +		if (n < 0) {
> +			printf("FAIL: recv failed: %s\n", strerror(errno));
> +			goto out;
> +		}

[ ... ]

> +		recv_count++;
> +		printf("Received %zd bytes (total: %zd, count: %d)\n",
> +		       n, total, recv_count);
> +
> +		if (send_all(csk, buf, n) < 0)
> +			goto out;
> +		printf("Echoed %zd bytes back to client\n", n);
> +	}

[Severity: Medium]
Can this per-recv logging stall the echo path?  The server is started
with bkg(server_cmd, host=server_host, exit_wait=True), which captures
stdout/stderr into pipes and only calls communicate() when the context
exits, while the harness waits for the client inside that context:

    with bkg(server_cmd, host=server_host, exit_wait=True):
        wait_port_listen(port, host=server_host)
        ...
        client.process(terminate=False, fail=True, timeout=cmd_timeout)

Two lines per recv from do_server() fill a 64 KiB pipe after roughly
1500 recvs.  Once printf() blocks, the server stops calling recv() and
send_all(), the client sits in client_recv_echo() waiting for an echo,
and nobody drains the server's pipe until the client finishes.  The 8 s
SO_RCVTIMEO turns that into "FAIL: Echo recv failed" rather than a hang,
but the failure has nothing to do with the kernel.  Would draining the
server's output concurrently, redirecting it to a file, or dropping the
per-iteration logging avoid this for the high-volume echo variants
(large_buf sends 100 x 2 MiB)?

[ ... ]

> diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> new file mode 100755
> index 000000000000..99ae5b3b8996
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> @@ -0,0 +1,446 @@

[ ... ]

> +# Per-packet HW crypto counters exposed via `ethtool -S` on the DUT NIC,
> +# keyed by the `ethtool -i` driver name. TlsTxDevice/TlsRxDevice in
> +# /proc/net/tls_stat only prove tls_dev_add() accepted the offload; these
> +# increment once per packet the NIC actually encrypted/decrypted (mlx5 counts
> +# gso_segs, not records), so they prove the HW crypto path was exercised.
> +# Names are driver-specific, so the
> +# check only runs on drivers listed here and is skipped (not failed) on
> +# others, keeping the test portable across NICs.
> +HW_CRYPTO_COUNTERS = {
> +    'mlx5_core': {'Tx': 'tx_tls_encrypted_packets',
> +                  'Rx': 'rx_tls_decrypted_packets'},
> +}

[Severity: Low]
Are these names really driver-specific?  Documentation/networking/tls-offload.rst
lists tx_tls_encrypted_packets and rx_tls_decrypted_packets under the
"minimum set of TLS-related statistics [that] should be reported by the
driver", and nfp (nfp_net_ethtool.c), cxgb4 and funeth export exactly
those strings.

With only mlx5_core in the table, check_hw_crypto() prints a NOTE and
returns on every other driver, leaving no assertion that the NIC did any
crypto.  check_path() does not substitute for it, since
do_tls_setsockopt_conf() bumps TlsTxDevice/TlsRxDevice at context
install time, before any record is processed.  Could the lookup fall
back to those documented names for any driver that exposes them?

> +def check_tls_support(cfg):
> +    """Skip the suite unless both hosts have kTLS and the DUT HW offload."""
> +    # The tls module is autoloaded lazily on the first TCP_ULP="tls"
> +    # setsockopt, so /proc/net/tls_stat (created from the module's pernet
> +    # init) may not exist yet on a freshly booted host. Load the module
> +    # explicitly before probing for it.
> +    try:
> +        cmd("modprobe tls")
> +        cmd("modprobe tls", host=cfg.remote)
> +        cmd("test -f /proc/net/tls_stat")
> +        cmd("test -f /proc/net/tls_stat", host=cfg.remote)
> +    except CmdExitFailure as e:
> +        raise KsftSkipEx(f"kTLS not supported: {e}") from e

[Severity: Medium]
Should the modprobe calls be inside this try block?  cmd() defaults to
fail=True and raises CmdExitFailure on a non-zero exit, so any modprobe
failure unrelated to kTLS - no modules.dep for a locally built kernel,
no modprobe on a minimal peer rootfs, kmod refusing a builtin - is
reported as "kTLS not supported" and skips the whole suite even though
/proc/net/tls_stat exists and offload works.

The config fragment this patch adds asks for CONFIG_TLS=y /
CONFIG_TLS_DEVICE=y, i.e. the intended configuration is built-in, where
the modprobe is unnecessary and the following test -f probe is already
authoritative.  Would making the modprobe best-effort (fail=False, or
its own try/except) avoid a permanent skip in that configuration?

> +
> +    try:
> +        features = cmd(f"ethtool -k {cfg.ifname}").stdout
> +        if 'tls-hw-tx-offload: on' not in features:
> +            raise KsftSkipEx("Device does not support TLS HW TX offload")
> +        if 'tls-hw-rx-offload: on' not in features:
> +            raise KsftSkipEx("Device does not support TLS HW RX offload")
> +    except CmdExitFailure as e:
> +        raise KsftSkipEx(f"Cannot determine TLS HW offload support: {e}") from e

[Severity: Medium]
Are the per-direction feature bits enough to gate the whole matrix?
They say nothing about which version/cipher tuples the device can
install, and drivers advertise them while rejecting tuples:

drivers/net/ethernet/netronome/nfp/crypto/tls.c:nfp_net_tls_add() {
	...
	if (crypto_info->version != TLS_1_2_VERSION)
		return -EOPNOTSUPP;
	...
}

mlx5 similarly checks separate firmware caps.  On an initial install
failure do_tls_setsockopt_conf() falls back to software:

net/tls/tls_main.c:do_tls_setsockopt_conf() {
	...
		} else {
			rc = tls_set_sw_offload(sk, 1, update ? crypto_info : NULL);
			...
			conf = TLS_SW;
	...
}

so the run proceeds in SW and check_path(..., require_hw=True) then
fails with "HW offload not engaged".  On an nfp or chcr NIC that means
the TLS 1.3 and AES-GCM-256 variants report failures rather than skips -
could the harness probe each tuple (for example a throwaway socket
install, or a TlsTxDevice check used to skip) instead of asserting?

[ ... ]

> +    if expected_rekeys > 0:
> +        if with_tx:

[ ... ]

> +            ksft_ge(1, diff('TlsTxRekeyAborted'),
> +                    comment=f"{role} Tx: TlsTxRekeyAborted expected <= 1")
> +            ksft_eq(diff('TlsTxRekeyOk') + diff('TlsTxRekeyAborted') +
> +                    diff('TlsTxRekeyFallback'), expected_rekeys,
> +                    comment=f"{role} Tx: rekey outcomes must sum to "
> +                            f"{expected_rekeys}")

[Severity: Medium]
Should an aborted rekey count as a satisfied expectation?  The Aborted
counters are emitted when a still-pending rekey is destroyed at teardown,
i.e. when it never completed:

net/tls/tls_device.c:tls_device_free_resources_tx() {
	...
	if (test_bit(TLS_TX_REKEY_PENDING, &tls_ctx->flags)) {
		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYABORTED);
	...
}

net/tls/tls_device.c:tls_device_offload_cleanup_rx() {
	...
	if (rx_ctx && rx_ctx->dev_add_pending) {
		rx_ctx->dev_add_pending = 0;
		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYABORTED);
	...
}

With Aborted folded into the sum, the single-rekey variants ("single",
burst_rx_rekey_every_10000, burst_rx_zc_rekey_every_20000) pass with
RekeyOk=0, RekeyAborted=1, Fallback=0, Error=0, CurrRekey=0 - no
successful HW rekey at all.  The RX block has the same shape.

Multi-rekey variants have a related hole, since a superseded pending
rekey bumps Ok without a HW reinstall:

net/tls/tls_device.c:tls_set_device_offload_rekey() {
	...
	if (defer) {
		if (!rekey_pending)
			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXREKEY);
		else
			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
	...
}

so N-1 Ok plus 1 Aborted also passes.  check_hw_crypto() spans the whole
connection, so records sent under the initial key satisfy it too.  Would
requiring RekeyOk == expected_rekeys on the DUT (and Aborted == 0) be
the stricter oracle intended here?

[ ... ]

> +    with bkg(server_cmd, host=server_host, exit_wait=True):
> +        wait_port_listen(port, host=server_host)
> +        # Start the client in the background so we keep a handle to it. A
> +        # foreground cmd() raises TimeoutExpired from inside its constructor
> +        # if the client hangs, and since the child is not killed on timeout
> +        # it would be left running with no handle to reap it. A leaked
> +        # client keeps bumping the per-netns TLS counters (TlsTxRekeyAborted,
> +        # TlsDecryptError, ...) and would corrupt the before/after
> +        # measurement window of a later variant. The finally clause reaps it
> +        # within this variant's window instead.
> +        client = cmd(client_cmd, host=client_host, background=True)
> +        try:
> +            client.process(terminate=False, fail=True, timeout=cmd_timeout)
> +        finally:
> +            if client.proc.poll() is None:
> +                client.process(terminate=True, fail=False, timeout=5)

[Severity: Medium]
Does the finally clause reap a client that runs on the peer?  With the
ssh backend, cmd.proc is the local ssh client:

tools/testing/selftests/drivers/net/lib/py/remote_ssh.py:Remote.cmd() {
    def cmd(self, comm):
        return subprocess.Popen(["ssh", "-q", self.name, comm],
                                stdout=subprocess.PIPE, stderr=subprocess.PIPE)
}

There is no pty and no remote PID tracking, and cmd._process_terminate()
only signals that handle:

    def _process_terminate(self, terminate, timeout):
        if terminate:
            self.proc.terminate()
        stdout, stderr = self.proc.communicate(timeout=timeout)

so SIGTERM reaches ssh, not tls_hw_offload on the peer, and there is no
SIGKILL fallback when communicate(timeout=5) expires.  The helper also
no longer dies when its stdout pipe closes, since main() does:

	signal(SIGPIPE, SIG_IGN);

printf() just returns EPIPE and the send/recv loop continues.

This covers the paths the new cleanup code is aimed at: the burst_rx_*
variants set dut_role="server", so the client runs remotely for up to
BURST_TIMEOUT_S, and the dut_role="client" variants run the server
remotely under bkg().  A surviving remote helper keeps driving kTLS
while the next variant takes its /proc/net/tls_stat and ethtool -S
snapshots, which breaks the exact equalities (rekey outcome sums,
TlsCurrTxRekey == 0, TlsDecryptError == 0).  Would the remote helper
need an explicit kill (pkill over ssh, ssh -tt, or a recorded remote
pid) for the comment's guarantee to hold?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917224355.2288021-1-rjethwani%40purestorage.com
