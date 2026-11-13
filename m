Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794549829;
	b=dt0duBu/9ZsgBBk9VpRonXT1ImUqSz8Xj6acj7DMrRBjzMYf83ukeP/8v6MYOYAW9P0y
	 fH16m4yv05OK6dNxHRyEMLeS54nTRFXiBhnOd4Ak1nrRM082+hSnV54OWqIgKYZqQCtli
	 f9tKYvQhBzDwwzln5bFX/1ngdrRdPQGJ4QV3B55E8CNuE1rs1m6BR01D+v6CIwDNJi9F3
	 bkY/ZQOfdRanJL6s+MDzca6XJDUgc2tZapCmynObcPrQbW8UTL0Kf2pqToxW7c+ne64JS
	 +WCsPaELSbW0fOo+ydYfwiJSHxgYWfe+Q8rzL/FYtEHb/nVvz9aDb5Gb2uRjCmDnxpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794549829;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=cb7V+m5HZYXGrLmOKXSoBWJ5O8CQ0qcwIGBFPuyjdDY=;
	b=qVBaioq4t36Wksi+P+z1ujdbONvRVcrsz6Qu3DgUL3WNIoiITl9QMMlzw1cXXMYUgK0G
	 ngmbjOJqogs4LUscCyPiGu8YWpblp3ozPYIvctXr6H1h2jJnTI6l56KXm1MYG+x5kVR9V
	 W3Ck9rNNmY1HWuMrQCAohIeWccjZN194MsqCocA/ZGdA5w16PP02Yz8RjdWqCPyAbJYtE
	 TMI1BsE/06ctoHzc5J39TpuWeaCUTOklO5KRZpvx2/O0lpg+T0nFXfxXoGn4Cu1sgGPOR
	 Az4LtDzdu0XRgP2lOEEeOA/fXjB0fxcD/jKzDHGlE8xtV5+X3aiQuRZtnUXPGOh+iGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LaCaCAAq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8B5606A31C
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 06:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LaCaCAAq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8101F000C6;
	Fri, 13 Nov 2026 06:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794549829;
	bh=cb7V+m5HZYXGrLmOKXSoBWJ5O8CQ0qcwIGBFPuyjdDY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LaCaCAAqW06fTr7edcZLSE+jkTewVXnAavv/5P8vb3o+x9biK/iAhj64ynaUt0q6n
	 aEpo7dWYw0apHPsth84ENyTaCT7iVIe6xauEhjYPiL7w1b72v6nK1CfE94XMLQvjEk
	 ocFMcRlDZLq9jmpSeGTAJfP+JHJrWC+QLm6B7rX2yzGK08Bqpb+m/9IrzF/hcb6vTb
	 u36KiMoMDaw2uyAp4ffZfDwTDI72PzreUGLEUxeWkW56VY3WyDHo9GWnq2giIvhR0c
	 ZXRuWW2T0Y0TDpIhF2jMIlQnMLuy/b33eHS/qo0fyyjjuddwcaf4F/8XOY8X1UGQOV
	 vz2frokQW34tw==
Subject: Re: [PATCH net-next v4 4/4] selftests: drv-net: measure devmem
 performance with kperf
From: netdev-bot+sashiko@kernel.org
To: sdf.kernel@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org
Date: Fri, 13 Nov 2026 06:03:48 +0000
Message-ID: <179454982864.2199510.563106109106531403@kernel.org>
In-Reply-To: <20261111000246.962871-5-sdf@fomichev.me>
References: <20261111000246.962871-5-sdf@fomichev.me>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] kperf() in tools/testing/selftests/drivers/net/perf/devmem.py
  never checks whether the device supports devmem before it changes the…
- [Medium] _enable_hw_gro() in
  tools/testing/selftests/drivers/net/perf/devmem.py (lines 24-31) makes…
- [Medium] In kperf()
  (tools/testing/selftests/drivers/net/perf/devmem.py), `defer(ethtool,…
- [Medium] kperf() saves `rings.get("tcp-data-split", "unknown")` (line
  53) and writes that value back explicitly in the deferred restore…

--

selftests: drv-net: measure devmem performance with kperf

This commit adds a udmabuf-backed devmem TCP throughput test to
drivers/net/perf. The test uses KperfRunner and reports the result as a
ktap metric. Before running kperf with devmem RX/TX, it raises the
udmabuf size limit and enables HW GRO and tcp-data-split.

> diff --git a/tools/testing/selftests/drivers/net/perf/devmem.py b/tools/testing/selftests/drivers/net/perf/devmem.py
> new file mode 100755
> index 0000000000000..4c1fb9b51fff9
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/perf/devmem.py
> @@ -0,0 +1,96 @@

[ ... ]

> +def _enable_hw_gro(cfg) -> None:
> +    features = ethtool(f"-k {cfg.ifname}", json=True)[0]
> +    hw_gro = features["rx-gro-hw"]
> +    if not hw_gro["active"]:
> +        if hw_gro["fixed"]:
> +            raise KsftSkipEx("Test requires rx-gro-hw support")
> +        ethtool(f"-K {cfg.ifname} rx-gro-hw on")
> +        defer(ethtool, f"-K {cfg.ifname} rx-gro-hw off")

[Severity: Medium]

Is HW GRO actually required for devmem here? The commit message says the
test skips "when kperf or /dev/udmabuf is missing". _enable_hw_gro() adds
a third skip condition: rx-gro-hw being fixed off.

Devmem does not depend on NETIF_F_GRO_HW in general. As far as I can tell,
only mlx5 ties tcp-data-split to GRO_HW, in
mlx5e_ethtool_set_tcp_data_split().

fbnic registers fbnic_queue_mgmt_ops and advertises
ETHTOOL_RING_USE_TCP_DATA_SPLIT, but it never sets NETIF_F_GRO_HW. Its
rx-gro-hw is reported as "off [fixed]", so this test would always skip
on fbnic.

On NICs where rx-gro-hw is off but not fixed, turning it on also changes
what the reported throughput metric measures compared with the device's
default configuration.

Could the HW GRO requirement be dropped? If it is needed, could the
commit message mention it and explain why?

> +
> +
> +@ksft_disruptive
> +def kperf(cfg) -> None:

[ ... ]

> +    # kperf reprograms the RSS indirection table for its queues.
> +    defer(ethtool, f"-X {cfg.ifname} default")
> +
> +    _enable_hw_gro(cfg)

[Severity: Medium]

Should this defer be registered later? It is armed before
_enable_hw_gro() can raise KsftSkipEx, and before anything has touched
RSS.

If rx-gro-hw is fixed off, the test skips, but ksft_flush_defer() still
runs "ethtool -X <ifname> default". On a device without set_rxfh support
that command exits non-zero, and ksft_flush_defer() sets
KSFT_RESULT = False. The output then becomes:

  not ok 1 ... # SKIP Test requires rx-gro-hw support

ktap_result() also clears KSFT_RESULT_ALL, so ksft_exit() returns 1, and
a plain skip turns into an overall failure.

On devices that do support set_rxfh (fbnic, for example, which always
takes the skip path above), any custom RSS indirection table gets reset
even though kperf never ran.

On the success path, too, the cleanup resets RSS to the default instead
of restoring the previous table.

> +
> +    ethnl = EthtoolFamily()
> +    rings = ethnl.rings_get({"header": {"dev-index": cfg.ifindex}})
> +    restore = {
> +        "header": {"dev-index": cfg.ifindex},
> +        "tcp-data-split": rings.get("tcp-data-split", "unknown"),
> +    }

[Severity: Medium]

Will this restore return the device to its original HDS configuration?
The other in-tree tests that enable tcp-data-split restore "unknown"
instead of writing back the reported value. These include configure_nic()
in hw/devmem_lib.py, hw/iou-zcrx.py, hw/nk_qlease.py and hds.py.

The snapshot is also taken after _enable_hw_gro() has already changed
the device. On bnxt, bnxt_get_ringparam() reports the live state rather
than hds_config:

drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c:bnxt_get_ringparam() {
    ...
	if (bp->flags & BNXT_FLAG_AGG_RINGS) {
		...
		kernel_ering->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_ENABLED;
	} else {
		...
		kernel_ering->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_DISABLED;
	}
    ...
}

With HW GRO enabled, the snapshot therefore reads "enabled". The deferred
rings_set() then sends ENABLED explicitly, and ethnl_set_rings() saves it
as the user configuration:

	dev->cfg_pending->hds_config = kernel_ringparam.tcp_data_split;

bnxt_set_ringparam() clears BNXT_FLAG_HDS only for UNKNOWN. Header split
stays forced on, and hds_config stays ENABLED instead of going back to
auto.

If the snapshot read "disabled" instead, bnxt_set_ringparam() rejects it
with -EINVAL because it differs from hds_config. The whole restore,
including hds-thresh, is dropped, and the failing defer marks the test
as failed.

In both cases header split is left on, and later non-frags XDP attaches
are refused in dev_xdp_attach():

	if (dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
	    prog && !prog->aux->xdp_has_frags) {
		NL_SET_ERR_MSG(extack, "unable to install XDP to device using tcp-data-split");
		return -EBUSY;

That can break later tests on the same machine.

Would it be more robust to restore "unknown", as hw/devmem_lib.py does?

> +    config = {
> +        "header": {"dev-index": cfg.ifindex},
> +        "tcp-data-split": "enabled",
> +    }
> +    # Memory providers require a zero threshold where the driver has one.
> +    if "hds-thresh" in rings:
> +        restore["hds-thresh"] = rings["hds-thresh"]
> +        config["hds-thresh"] = 0
> +    defer(ethnl.rings_set, restore)
> +    ethnl.rings_set(config)

[Severity: Medium]

What happens here on a NIC that has HW GRO but no header-split or devmem
support? drivers/net/perf is a generic suite. The only skip conditions
are a missing kperf, a missing /dev/udmabuf, or rx-gro-hw being fixed
off.

Take virtio_net with guest TSO as an example. rx-gro-hw is active by
default, so _enable_hw_gro() passes. virtio_net does not advertise
ETHTOOL_RING_USE_TCP_DATA_SPLIT, so this rings_set() gets -EOPNOTSUPP
from ethnl_set_rings_validate(), and ksft_run() counts the NlError as a
failure.

The restore defer registered just above also sends tcp-data-split, so it
fails the same way. qede, hns3 and bnx2x appear to behave the same.

idpf and ice support tcp-data-split but have no queue_mgmt_ops. There
this rings_set() succeeds, but devmem binding fails, kperf-client exits
non-zero, and KperfRunner.run() raises RuntimeError. That is also
reported as a failure rather than a skip.

The hw tests handle this case with require_devmem() in hw/devmem_lib.py:

    if not cfg.devmem_supported[RX_PAGE_SIZE_DEFAULT]:
        raise KsftSkipEx("Test requires devmem support")

Should this test do an equivalent probe before it modifies the device?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111000246.962871-1-sdf%40fomichev.me
