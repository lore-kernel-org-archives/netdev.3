Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0383E9F9E
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 22:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787004711; cv=none; b=kHiUsE9dxwaBMb6aog4N7ClwPrMvCyTxXop4DHIxOSFEtZEar5qnkZ+CAfFjJqLMu5Zpwb8xDjMrkkuGfyNbJJQFUAzCjlkyroyJBHRKQtYgR4M1NMZGvqvuXd6RoEML4XCs7Ni3h0QHnEfELrrjoz5tspEecefOpPJSyj2rCdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787004711; c=relaxed/simple;
	bh=1PRdDbyGK2x5Cm9fYoW+ehM+Ut5dkNl2H844oFMEITE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uICsKKiShGIuCyFKQtuiYInhJnoRyRwbRQ7Ff7mBJnn/C70OONLBWsYr3HgQJ17jC7hjXSLcGjAyvO8lbrvOZTVfkIJwYsaKJT01xsNxerDMW+sWEEtJjYvTkcUalNVpZtusuULBQ5WmWBb0woHO5LIsMGBwNKuoCq2Ddk2M8K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHoccXYk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHoccXYk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087101F000E9;
	Mon, 17 Aug 2026 22:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787004709;
	bh=3jFPNesp5kb75a/QK5IFBXfK8n0WRh3JEi91cgC3K+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AHoccXYkPKR2XTtGW1c0vRdkU7KzUYOs411trtEFvtji0wO1odZxa0wIEzVH/Qlob
	 JROmd1QNDbQearOKhDtHF7qo2pYouZkxRHSCF/inX7PSaddXFkCHXyXIlmrlwZlyY0
	 ecVJMlj4MThJn1Gw1IYuM8kij7gTSgBAoZWl1n1SJiOzhreKLC0gP/pfyWoul+96do
	 TSnFspFaEOY1TUSoHMN84ODdiloRghS/YmVEragiPC/gofqYGOJG1I2e9fHRNqeQ9P
	 yUKrZUeT3G/vD1fqZgM1+zFChkdBGGfj8N+Awh7D2QLYeNnZTVq8Y0wbvUuRpJcMOZ
	 9vxpXYVzJib4A==
From: Jakub Kicinski <kuba@kernel.org>
To: rjethwani@purestorage.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH v16 10/10] selftests: net: add TLS hardware offload test
Date: Mon, 17 Aug 2026 15:11:48 -0700
Message-ID: <20260817221148.3666558-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807183853.2288959-11-rjethwani@purestorage.com>
References: <20260807183853.2288959-11-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
selftests: net: add TLS hardware offload test

This adds a two-node kTLS hardware offload selftest: a C helper acts as
either TLS client or server, and a Python harness drives it over
NetDrvEpEnv and checks the /proc/net/tls_stat counters.  It covers TLS
1.2/1.3, AES-GCM-128/256, rekey with several buffer sizes, and burst
variants that stress TX and RX rekey.

A few questions about the helper and the harness below.

> diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
> new file mode 100644
> index 000000000000..1882e2f073ad
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
> @@ -0,0 +1,975 @@

[ ... ]

> +static int do_client(void)
> +{

[ ... ]

> +		n = send(csk, buf, this_size, 0);
> +		if (n != this_size) {
> +			printf("FAIL: send failed: %s\n", strerror(errno));
> +			goto out;
> +		}
> +
> +		if (!burst_mode) {
> +			printf("Sent %zd bytes (iteration %d)\n", n, i);
> +			if (client_recv_echo(csk, buf, echo_buf, n) < 0)
> +				goto out;
> +		}

[Severity: Medium]
Can echo (non-burst) mode deadlock for large payloads?

do_client() issues one blocking send() of the whole payload and only
calls client_recv_echo() afterwards, so it does not read anything from
the socket while the send is outstanding.

On the other side, do_server() reads one record with recv_flags == 0 and
then blocks inside server_echo_send() before it returns to recv():

	for (sent = 0; sent < n; sent += ret) {
		ret = send(fd, buf + sent, n - sent, 0);

Once the echo direction fills up (server send buffer plus client receive
buffer, which cannot autotune because the client never copies data out),
the server blocks in send() and stops draining the forward direction.
The client then blocks in its own send().  Neither side sets
SO_SNDTIMEO/SO_RCVTIMEO, uses non-blocking I/O, or has a second reader,
so is there anything that breaks the cycle?

The large_buf rekey variant drives this path with 2 MiB per iteration:

    KsftNamedVariant("large_buf", 10, 2097152),

With initial tcp_wmem[1]/tcp_rmem[1] defaults only a few hundred KiB can
be in flight per direction, well below 2 MiB.  The client cmd() then
times out (cmd_timeout is 10 for non-burst runs) and the variant is
reported as a TLS offload counter failure rather than as a hang.  Would
a bounded per-iteration payload in echo mode, or a socket timeout, be
preferable here?

[Severity: Low]
Should this send() loop over the remainder instead of treating a short
count as fatal?  Every other transfer in this file loops:
client_recv_echo() uses "while (total < len)" and server_echo_send()
uses "for (sent = 0; sent < n; sent += ret)".

A blocking SOCK_STREAM send() can return a short count without setting
errno, so "FAIL: send failed: %s" would print a stale strerror(errno)
value.  In burst mode a short send also breaks the framing contract that
the server's MSG_WAITALL recv() relies on, since server_verify_burst()
expects exactly send_size bytes per iteration.

[ ... ]

> diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> new file mode 100755
> index 000000000000..b8f5a3314030
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> @@ -0,0 +1,295 @@

[ ... ]

> +# Burst variants push hundreds of MB and perform many rekeys; the
> +# default cmd() timeout (5s) is too short.
> +BURST_TIMEOUT_S = 180

[Severity: Low]
Is the "(5s)" in this comment correct?  tools/testing/selftests/net/lib/py/utils.py
declares the default as 20 s in both places:

    def __init__(self, comm, shell=None, fail=True, expect_fail=False, ns=None,
                 background=False, host=None, timeout=20, ksft_ready=None,
                 ksft_wait=None):
...
    def process(self, terminate=True, fail=None, expect_fail=False, timeout=20):

Following the 5 s premise, run_tls_test() sets "cmd_timeout =
BURST_TIMEOUT_S if burst else 10", which lowers the non-burst client
timeout below the library default.

Also, BURST_TIMEOUT_S is only passed to the client cmd().  bkg takes no
timeout argument and bkg.__exit__() calls self.process() without one, so
the background server that handles the same "hundreds of MB" is drained
with communicate(timeout=20).  If it needs longer after the client exits,
subprocess.TimeoutExpired escapes bkg.__exit__() rather than producing a
test failure.

> +def check_tls_support(cfg):
> +    try:
> +        cmd("test -f /proc/net/tls_stat")
> +        cmd("test -f /proc/net/tls_stat", host=cfg.remote)
> +    except CmdExitFailure as e:
> +        raise KsftSkipEx(f"kTLS not supported: {e}")

[Severity: Medium]
Does this check actually test for kTLS support, or only for the tls
module already being loaded?

/proc/net/tls_stat is created from the module's pernet registration path:

net/tls/tls_proc.c:tls_proc_init() {
	if (!proc_create_net_single("tls_stat", 0444, net->proc_net,
	...
}

reached via module_init(tls_register) -> register_pernet_subsys(&tls_proc_ops).
With the common CONFIG_TLS=m the module is autoloaded on the first
TCP_ULP="tls" setsockopt, so on a freshly booted DUT or peer the file
does not exist yet and check_tls_support() raises KsftSkipEx("kTLS not
supported") from main() before ksft_run(), skipping all variants on a
machine that fully supports offload.

Would a modprobe, or probing an actual TLS ULP socket first, be more
reliable?

> +def read_tls_stats(host=None):
> +    stats = defaultdict(int)
> +    output = cmd("cat /proc/net/tls_stat", host=host)

[Severity: Low]
These are per-netns counters (TLS_INC_STATS(sock_net(sk), ...) exposed
through net->mib.tls_statistics), and these tests run in the host
namespace on a real NIC via NetDrvEpEnv(__file__, nsim_test=False).  Any
other kTLS user in the same namespace during the before/after window
perturbs the deltas that check_eq_sum() and check_zero() require to
match exactly.

There is also a harness-internal path for this.  When
cmd(client_cmd, timeout=cmd_timeout) times out, utils.py does:

        if terminate:
            self.proc.terminate()
        stdout, stderr = self.proc.communicate(timeout=timeout)

For a foreground cmd() the child is not killed on TimeoutExpired, so the
orphaned client keeps running and its eventual socket teardown can bump
TlsTxRekeyAborted or TlsDecryptError inside a later variant's
measurement window.  Can one timeout (for example the large_buf hang
above) cascade into counter failures in unrelated variants?

> +def check_path(before, after, direction, role, require_hw):
> +    """On the DUT, require HW offload; on the remote, HW or SW is fine."""
> +    dev = stat_diff(before, after, f'Tls{direction}Device')
> +    sw = stat_diff(before, after, f'Tls{direction}Sw')
> +    if require_hw:
> +        if dev < 1:
> +            ksft_pr(f"FAIL: {role} {direction}: HW offload not engaged "
> +                    f"(Device={dev}, Sw={sw})")
> +            return 1

[Severity: Low]
Does a TlsTxDevice/TlsRxDevice delta of at least 1 show that the device
actually performed record crypto?

Those MIBs are bumped once per socket at setsockopt() time only:

net/tls/tls_main.c:do_tls_setsockopt_conf() {
		if (!rc) {
			if (!update) {
				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXDEVICE);
				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
			}
	...
}

so they record that tls_dev_add() accepted the connection, not that any
record was encrypted or decrypted in hardware.  A socket whose RX
offload later degrades to software still satisfies dev >= 1, since
TLS_RX_DEV_DEGRADED is set at runtime:

net/tls/tls_device.c:tls_device_down() {
		/* Start skipping the RX resync logic completely. */
		set_bit(TLS_RX_DEV_DEGRADED, &ctx->flags);
	...
}

For the non-rekey variants (expected_rekeys == 0) check_path() is the
only assertion that runs, so is the central premise of a test placed
under drivers/net/hw verified at all there?

[ ... ]

> +    if expected_rekeys > 0:
> +        if with_tx:

[ ... ]

> +            errors += check_eq_sum(stats_before, stats_after,
> +                                   ['TlsTxRekeyOk', 'TlsTxRekeyAborted'],
> +                                   expected_rekeys, role)
> +            errors += check_zero(stats_before, stats_after,
> +                                 'TlsTxRekeyError', role)
> +            errors += check_zero(stats_before, stats_after,
> +                                 'TlsTxRekeyFallback', role)

[Severity: Medium]
Should TlsTxRekeyFallback and TlsRxRekeyFallback be required to stay at
zero?  Those counters are the kernel's accounting for intentional,
graceful degradation to software when a device key (re)install fails,
and the fallback path returns success:

net/tls/tls_device.c:tls_device_complete_rekey() {
rekey_fail:
	...
	TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYFALLBACK);
	TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
	TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW);

	return 0;
}

The RX side does the same on a failed rekey dev_add:

	} else if (is_rekey) {
		set_bit(TLS_RX_DEV_DEGRADED, &tls_ctx->flags);
		set_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags);
		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYFALLBACK);

A NIC has a bounded pool of TLS contexts and a rekey needs a fresh one
while the old is retired, and the burst variants rekey very aggressively
on a single connection (burst_tx_rekey_every_1 does 50 rekeys, one per
64 KiB send; burst_rx_rekey_every_10 does 20 RX rekeys).  If a device
falls back, check_zero('TlsTxRekeyFallback') fails and the exact
check_eq_sum(Ok + Aborted == N) fails at the same time, giving two
failures with nothing to distinguish "device out of contexts" from a
kernel rekey bug.  A TX fallback also leaves the socket in software for
good, so one transient failure affects every remaining rekey on that
connection.

> +            errors += check_zero(stats_before, stats_after,
> +                                 'TlsTxRekeyInProgress', role)
> +        if with_rx:

[ ... ]

> +            errors += check_eq_sum(stats_before, stats_after,
> +                                   ['TlsRxRekeyOk', 'TlsRxRekeyAborted'],
> +                                   expected_rekeys, role)
> +            errors += check_min(stats_before, stats_after,
> +                                'TlsRxRekeyReceived', expected_rekeys, role)

[Severity: Low]
These strict rekey assertions also run for the remote peer
(is_dut=False); only the hardware-vs-software path check is relaxed
there.  Rekey support and the Tls*Rekey* MIB names are recent additions,
and read_tls_stats() builds a defaultdict(int), so a peer kernel that
does not export them yields 0 and produces a hard failure such as
"expected == 1, got 0" instead of a skip.  The only peer-side gate is
the /proc/net/tls_stat existence check.

This also does not match the run_tls_test() docstring, which says the
remote "may run any kernel without HW offload".  Should the peer-side
rekey checks be gated on the counters being present?

[ ... ]
