Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256102;
	b=Mzlh6tTkttPnWnZEIcqxrPmPg4Td+MRf693vI06hOyNMX9KfskaoMZmx/nBVXc3stnCM
	 45CLPRdXH3toYIyj9WDu6VxhsH1ezfi90jALgEcTxqoKwpD7sLATyX8k5imosUaI9bJkk
	 urSCFYiZ33zcdzTXx7Ubeso10lJDocxt4PTPdOtHyCf3XMlR7s8Z8fIPpTTQHsdxpOzJN
	 GUBLhquR+JrM4SOYlkDBIQ2h7bCK6HQOO0k2U22H+m+qfdamRqBFFaY5VSpCY/3oVmiHL
	 uvGEklz7X8VIdKkYw6bQn1FZacedmlh16ZL7MVlZ9U+M+arli/Pc2C73VoTpv94U0Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256102;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=xZjEZ5O/ivXsaFtFaAsleyW7xxTeUdLIr26GM8NfdUM=;
	b=o7ZwVSzeQA51Vg9NaZUAs94z/kK7QUAB5ZbD5PQgEaMGCVtgLXVGzffjrnr37ApYeNVh
	 Ba7AQE0ifKwNjhsyccuLelqgzZH3VqO8gBrmoc26yJ8gUoReEIUtpOX6FtX+ibpKC4JI/
	 X5Wq1v15QTAeDUgrDZk2IT0Fqykh2cPWe+lF2khHcjmqX5AbAM6AeYSwGSrxFO94NddpP
	 0aXwEA4mSU6912AYoLbKvKM9lsQKG8Oq/9JwQdrO+YhPazCNgBwHVCnHDOi8LR4yBCXtt
	 kX/qrP74J8EVDUnnEYXmgEL/t/mF3mHeXEhbFPzrGcBTpIi+FTFkuOFe0e/DMwpss8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KTwafgXM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BF3606A32A
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 20:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KTwafgXM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0826D1F008A1;
	Mon,  9 Nov 2026 20:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794256101;
	bh=xZjEZ5O/ivXsaFtFaAsleyW7xxTeUdLIr26GM8NfdUM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KTwafgXMrC4474so7BRHf+VanaER8nO0R01B99GDpvdltQR/uQ0EjtkKrKrYNqn/q
	 WRhvVmg1/ZMB3UGiUc7DZTDmFSQcHsyd6ArXvbn3tzGsbl2OxFodpdp5c4kHrDuf9A
	 LB0K02smBFfII7QkzrxwSneSbPjAPQwwGu4DncNfQtV4ktVsLRGuDa7aL9UgC1A2jp
	 Z/cKPrmGBK7XmdEnD9+o9JmhIBgy+ANN5Vs9DjVwSwOLQqF2lfvvYkSEkTrFC4ZsfL
	 uiL7ciOmDF4/6unNPWe+s6hw+RvuWBiUQej98Vf8EbxSnXkMe0hHp6QiHOmS/FI1Xy
	 m87nhNJYdb4Ug==
Subject: Re: [PATCH v12 net-next 3/3] selftests: drivers/net: Implement ptp4l
 sync test using netdevsim
From: netdev-bot+sashiko@kernel.org
To: maciek@machnikowski.net
Cc: netdev@vger.kernel.org, kuba@kernel.org, richardcochran@gmail.com,
 milena.olech@intel.com, willemdebruijn.kernel@gmail.com, andrew@lunn.ch,
 vadim.fedorenko@linux.dev, horms@kernel.org, almasrymina@google.com
Date: Mon, 09 Nov 2026 20:28:20 +0000
Message-ID: <179425610058.994134.1147534198857672730@kernel.org>
In-Reply-To: <20261108201503.85000-4-maciek@machnikowski.net>
References: <20261108201503.85000-4-maciek@machnikowski.net>
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

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 5

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] When ptp4l fails to start, ptp_sync_test() in
  tools/testing/selftests/drivers/net/ptp.py reports it as a sync…
- [Low] The test says it checks that 'the follower locks onto the
  leader'.
- [Low] In ptp_sync_test(), the local temp directory is created at line
  75 (`cmd("mktemp -d")`).
- [Low] Both ptp4l instances turn on hardware timestamping on their
  interfaces (tx_type=HWTSTAMP_TX_ON, a PTP rx_filter; netdevsim…
- [Low] _require_hw_timestamping() only checks `ethtool -T` for the
  'hardware-transmit' and 'hardware-receive' strings.
- [Low] Both ptp4l command lines in ptp_sync_test() use the default
  tx_timestamp_timeout (no --tx_timestamp_timeout and no config file).

--

selftests: drivers/net: Implement ptp4l sync test using netdevsim

This commit adds a ptp.py selftest. It uses NetDrvEpEnv to link a local
netdevsim device to a remote endpoint and runs ptp4l as leader and
follower on the two ends. The test passes once the follower reports
the synchronized state (s2).

> diff --git a/tools/testing/selftests/drivers/net/ptp.py b/tools/testing/selftests/drivers/net/ptp.py
> new file mode 100755
> index 0000000000000..1065bd42ba538
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/ptp.py

[ ... ]

> +def _require_hw_timestamping(ifname, host=None):
> +    """Skip the test unless ifname supports HW TX and RX timestamping."""
> +    end = "Remote" if host else "Local"
> +    ts_info = cmd(f"ethtool -T {ifname}", host=host).stdout
> +    if "hardware-transmit" not in ts_info or "hardware-receive" not in ts_info:

[Severity: Low]
This check only looks for the hardware-transmit and hardware-receive
strings. Should it also compare the PTP Hardware Clock index of the local
and remote interfaces?

With NetDrvEpEnv the remote can be a netns that holds a sibling port of
the same NIC. Some multi-port NICs share one PHC across all ports.

In that setup the follower ptp4l would discipline the same clock that the
leader uses as its time source. The offset would be close to zero by
construction, so the test could reach s2 without measuring sync between
two independent clocks.

netdevsim is not affected, because each port gets its own mock PHC.

> +        raise KsftSkipEx(
> +            f"{end} device does not support hardware timestamping")
> +
> +
> +def _poll_follower_sync(follower, timeout):

[ ... ]

> +        try:
> +            remaining = deadline - time.monotonic()
> +            buf += fd_read_timeout(fd, max(0, min(1, remaining)))
> +        except TimeoutError:
> +            continue
> +    return b" s2 " in buf, buf.decode("utf-8", "replace")

[Severity: Low]
Is finding the " s2 " substring enough to show that "the follower locks
onto the leader", as the module docstring says? The master offset printed
on the same log line is never checked.

With the default config (step_threshold=0), the PI servo moves from s0 to
s1 to s2 within a few Sync intervals. It then stays in s2 whatever the
offset is.

Both netdevsim mock PHCs also start at 0 on CLOCK_MONOTONIC_RAW:

drivers/ptp/ptp_mock.c:mock_phc_create() {
    ...
	timecounter_init(&phc->tc, &phc->cc, 0);
    ...
}

So the two clocks already agree to within milliseconds before the servo
does anything.

Would the test still pass if adjfine/adjtime/settime64 on the follower
PHC had no effect? One option is to require the reported offset to stay
below a threshold for a few samples.

> +
> +
> +def ptp_sync_test(cfg):
> +    """Verify ptp4l leader/follower synchronization reaches state s2."""
> +    cfg.require_cmd("ptp4l", remote=True)
> +    cfg.require_cmd("ethtool", remote=True)
> +
> +    _require_hw_timestamping(cfg.ifname)
> +    _require_hw_timestamping(cfg.remote_ifname, host=cfg.remote)
> +
> +    local_dir = cmd("mktemp -d").stdout.strip()
> +    remote_dir = cmd("mktemp -d", host=cfg.remote).stdout.strip()
> +    defer(cmd, f"rm -rf {local_dir}")
> +    defer(cmd, f"rm -rf {remote_dir}", host=cfg.remote)

[Severity: Low]
What happens to local_dir if the remote mktemp fails? cmd() defaults to
fail=True, so it raises CmdExitFailure before the local rm -rf is
deferred, and the local temp directory is left behind.

Registering each defer() right after its mktemp would avoid this.

> +
> +    leader_cmd = (f"ptp4l -i {cfg.remote_ifname} -m -2 "
> +                  f"--uds_address {remote_dir}/ptp4l "
> +                  f"--uds_ro_address {remote_dir}/ptp4lro")
> +    follower_cmd = (f"ptp4l -i {cfg.ifname} -m -s -2 "
> +                    f"--uds_address {local_dir}/ptp4l "
> +                    f"--uds_ro_address {local_dir}/ptp4lro")

[Severity: Low]
Both command lines use ptp4l's default tx_timestamp_timeout. netdevsim
delivers TX timestamps synchronously from nsim_start_xmit() via
skb_tstamp_tx(), so the default is enough there.

Some real NICs deliver TX timestamps later, from a PTP aux worker or a
FIFO polled on interrupt. Could that delay exceed the default, so that
ptp4l faults the port and never reaches s2?

The test supports real devices through NetDrvEpEnv, so this would show up
as a plain "PTP sync timeout" FAIL with no hint about the timestamp
timeout. One could argue such a timeout is a valid failure signal, but
the output would not point to it.

> +
> +    # bkg() can't reliably signal the remote ptp4l over SSH (no pty), so
> +    # kill it by pattern explicitly in addition to the normal teardown.
> +    # pkill exits 1 when ptp4l already terminated, so don't treat it as fatal.
> +    defer(cmd, f'pkill -INT -f "{leader_cmd}"', host=cfg.remote, fail=False)

[Severity: Low]
Both ptp4l instances turn on hardware timestamping on their interfaces.
netdevsim also upgrades the rx filter to HWTSTAMP_FILTER_ALL in
nsim_set_ts_config(). The follower additionally steps the local PHC and
changes its frequency.

The only cleanup registered here is the pkill and the temp dir removal.
Nothing saves or restores the original timestamping config.

With netdevsim the devices are torn down when NetDrvEpEnv exits, so
nothing persists. When the test runs on real NICs (NETIF/REMOTE_*), would
both interfaces be left with HW timestamping enabled, and the local PHC
left with the servo's last step and frequency?

hw/nic_timestamp.py saves orig_tscfg and restores it with
__set_hwtimestamp_config(cfg, orig_tscfg). Would something similar make
sense here?

> +
> +    with bkg(leader_cmd, host=cfg.remote), \
> +         bkg(follower_cmd) as follower:
> +        synced, output = _poll_follower_sync(follower, PTP4L_SYNC_TIMEOUT)

[Severity: Medium]
What happens here if either ptp4l fails to start?

If the follower exits early, _poll_follower_sync() sees that
follower.proc.poll() is not None. It reads what is left on stdout, breaks
out of the loop and returns synced=False. That is the same result as a
real 40s sync timeout.

The leader is never polled. A leader that dies at startup costs the full
PTP4L_SYNC_TIMEOUT and is also reported as a sync timeout.

Neither bkg() call passes fail=, so on exit cmd.process() is called with
terminate=True and fail=None:

tools/testing/selftests/net/lib/py/utils.py:cmd.process() {
    ...
        if fail is None:
            fail = not terminate
    ...
}

As a result, a non-zero exit status and the stderr of either ptp4l are
silently dropped. ptp4l writes option errors and its usage text to
stderr, so the follower log tail printed below would be empty or
unhelpful.

One concrete trigger is --uds_ro_address, which is passed to both
instances. If I recall correctly, this option first appeared in linuxptp
4.0, while cfg.require_cmd("ptp4l") only checks that the binary exists.

On a host with an older linuxptp (some distros still ship 3.1.x), would
both instances exit at once, and the test FAIL with no visible cause
instead of skipping?

Could the test detect an early exit of either process and print its
stderr, or skip when ptp4l rejects the options?

> +
> +    if not synced:
> +        ksft_pr(f"ptp4l follower did not reach locked state (s2) within "
> +                f"{PTP4L_SYNC_TIMEOUT}s")
> +        tail = output.strip().split("\n")[-10:]
> +        ksft_pr("Follower log (last 10 lines): " + " | ".join(tail))
> +    ksft_true(synced, "PTP sync timeout")

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108201503.85000-1-maciek%40machnikowski.net
