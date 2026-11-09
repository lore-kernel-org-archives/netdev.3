Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.235
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794194717;
	b=nSg+Ylgfav8RrBUdZPCc0tMQBOWxsNfsfXhKy8DNQh2X3rqGaMnAWTqx4Rla3cpboVNV
	 nFeo53tocnqxgX2cO6FLK/tvuRQizS62QibBoxjIuWGkeojz4SPRqHqLgJgSSvayMnfGG
	 P3VdGE4ifEw0ZmzayKG33k2qZj/xInU0G2nqQ5yECuW60s+xc+v/ktIigKDSZWTtKuqKQ
	 8j6hTT30okIJIQZYPdZ46V9TDzJN8vAX2ZkY+ePp7bHcbdEUcBj0ag9dAYeLKTj1lYPgS
	 we73X36938OEOZkzQzQT3Z8sCkWDDQoEEGB60V4b3mrjSp9E5byz60szmUkJR5fvkYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794194717;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=eX8j8P14NxuO/nVOpjO9dMt0RaBSHQFzLqyVvWBQitQ=;
	b=frLrQk2NGmYhlSaP75YR/1z+UUHOLaM1mIFYtVdXLS0XzzwOsFUtlnf5iqxMIjGeyhAf
	 kLxWfSr5Xu++TYj9ycYcgIF6dr2CCtQ4cJ0bIoHbdbXX7pli4MxQAy1UqwU3SDBPF7JvU
	 xg0dNImcsA8FH7kDZthO1j3f04JZTzz187Ch6M5jLugUc8g0k8TVLTsN4ameDADeezK0Q
	 +wsPB/YXmwmBm6flDSC5vKmEmNK53m5jVnyWxY72FtAGTZqQQO3YBk3Q5J+/1AdmYMrBe
	 rKUnWGYT1ET/8Qo9Ga2OMUzDccEOHPt71agPsS/4p/5SpaRdr3oPjo1eLv2rzqWeIyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="i9IFTt/5";
	arc=none smtp.remote-ip=91.218.175.235
Received: from mta0.migadu.com (out-235.mta0.migadu.com [91.218.175.235])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7641606A325
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 03:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7641606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=i9IFTt/5
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=W/G//pJ9xL9IiX0x3itk5Nvaf/sS41owhBQxiTIoiIc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794194713; v=1; x=1794799513;
 b=i9IFTt/5JtPnpB7r9ZVVOZjtsfr28yljbjwNvk7AnCCkjQLVp1l2/JnaLaoy3xZKHd5KsU4E
 nVxfoS/AkObWzvpCIqb1r2IL35y48rBfbVAMcK9BhDCMTgpjLVNKbESbi+6BZqpxe7FJ/hFEQ/E
 hrYmQ3X++CB++/QoAvJB0X+8=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id f33263ec88be4b61;
	Mon, 09 Nov 2026 03:25:13 +0000
X-Mizu-Trace-ID: f33263ec88be4b61
X-Migadu-Flow: FLOW_OUT
Date: Mon, 9 Nov 2026 11:24:57 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, richardcochran@gmail.com,
	milena.olech@intel.com, willemdebruijn.kernel@gmail.com,
	andrew@lunn.ch, vadim.fedorenko@linux.dev, horms@kernel.org,
	almasrymina@google.com
Subject: Re: [PATCH v12 net-next 3/3] selftests: drivers/net: Implement ptp4l
 sync test using netdevsim
Message-ID: <avE9CYaESjjwBs5p@fedora>
References: <20261108201503.85000-1-maciek@machnikowski.net>
 <20261108201503.85000-4-maciek@machnikowski.net>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261108201503.85000-4-maciek@machnikowski.net>

On Sun, Nov 08, 2026 at 09:15:03PM +0100, Maciek Machnikowski wrote:
> Add PTP synchronization test using ptp4l and netdevsim.
> The test uses the NetDrvEpEnv to link a local netdevsim
> device to a remote endpoint, runs ptp4l as leader and follower
> on the two ends, and waits for the follower to report the
> synchronized state (s2).
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
> ---
>  tools/testing/selftests/drivers/net/Makefile |   1 +
>  tools/testing/selftests/drivers/net/config   |   1 +
>  tools/testing/selftests/drivers/net/ptp.py   | 112 +++++++++++++++++++
>  3 files changed, 114 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/ptp.py
> 
> diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
> index 79c6f998e704..ed41a69ef6ad 100644
> --- a/tools/testing/selftests/drivers/net/Makefile
> +++ b/tools/testing/selftests/drivers/net/Makefile
> @@ -23,6 +23,7 @@ TEST_PROGS := \
>  	ping.py \
>  	pppoe_gro.py \
>  	psp.py \
> +	ptp.py \
>  	queues.py \
>  	ring_reconfig.py \
>  	rss_key.py \
> diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/selftests/drivers/net/config
> index 4838adf27fa1..30e69446d41d 100644
> --- a/tools/testing/selftests/drivers/net/config
> +++ b/tools/testing/selftests/drivers/net/config
> @@ -21,6 +21,7 @@ CONFIG_NET_SCH_INGRESS=y
>  CONFIG_NET_SCH_PRIO=m
>  CONFIG_PPP=y
>  CONFIG_PPPOE=y
> +CONFIG_PTP_1588_CLOCK_MOCK=y
>  CONFIG_TLS=y
>  CONFIG_VLAN_8021Q=m
>  CONFIG_XDP_SOCKETS=y
> diff --git a/tools/testing/selftests/drivers/net/ptp.py b/tools/testing/selftests/drivers/net/ptp.py
> new file mode 100755
> index 000000000000..1065bd42ba53
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/ptp.py
> @@ -0,0 +1,112 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# By Maciek Machnikowski <maciek@machnikowski.net> (c) 2026
> +
> +"""
> +Test suite for PTP sync using ptp4l.
> +
> +Start a ptp4l leader and follower and check that the follower locks onto the
> +leader (state s2)
> +"""
> +
> +import time
> +
> +from lib.py import (
> +    KsftSkipEx,
> +    NetDrvEpEnv,
> +    bkg,
> +    cmd,
> +    defer,
> +    fd_read_timeout,
> +    ksft_exit,
> +    ksft_pr,
> +    ksft_run,
> +    ksft_true,
> +)
> +
> +PTP4L_SYNC_TIMEOUT = 40
> +
> +
> +def _require_hw_timestamping(ifname, host=None):
> +    """Skip the test unless ifname supports HW TX and RX timestamping."""
> +    end = "Remote" if host else "Local"
> +    ts_info = cmd(f"ethtool -T {ifname}", host=host).stdout
> +    if "hardware-transmit" not in ts_info or "hardware-receive" not in ts_info:
> +        raise KsftSkipEx(
> +            f"{end} device does not support hardware timestamping")
> +
> +
> +def _poll_follower_sync(follower, timeout):
> +    """Read the follower stdout pipe until ptp4l reports sync state s2.
> +
> +    Returns a tuple (synced, output) where output is the text read so far.
> +    The synchronized ptp4l log line looks like this:
> +    ptp4l[18374.558]: master offset        844 s2 freq    +822 path delay       521
> +    """
> +    fd_file = follower.proc.stdout
> +    fd = fd_file.fileno()
> +    buf = b""
> +    deadline = time.monotonic() + timeout
> +    while time.monotonic() < deadline:
> +        if b" s2 " in buf:
> +            break
> +        if follower.proc.poll() is not None:
> +            chunk = fd_file.read()
> +            if chunk:
> +                buf += chunk
> +            break
> +        try:
> +            remaining = deadline - time.monotonic()
> +            buf += fd_read_timeout(fd, max(0, min(1, remaining)))
> +        except TimeoutError:
> +            continue
> +    return b" s2 " in buf, buf.decode("utf-8", "replace")
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
> +
> +    leader_cmd = (f"ptp4l -i {cfg.remote_ifname} -m -2 "
> +                  f"--uds_address {remote_dir}/ptp4l "
> +                  f"--uds_ro_address {remote_dir}/ptp4lro")
> +    follower_cmd = (f"ptp4l -i {cfg.ifname} -m -s -2 "
> +                    f"--uds_address {local_dir}/ptp4l "
> +                    f"--uds_ro_address {local_dir}/ptp4lro")
> +
> +    # bkg() can't reliably signal the remote ptp4l over SSH (no pty), so
> +    # kill it by pattern explicitly in addition to the normal teardown.
> +    # pkill exits 1 when ptp4l already terminated, so don't treat it as fatal.
> +    defer(cmd, f'pkill -INT -f "{leader_cmd}"', host=cfg.remote, fail=False)
> +
> +    with bkg(leader_cmd, host=cfg.remote), \
> +         bkg(follower_cmd) as follower:
> +        synced, output = _poll_follower_sync(follower, PTP4L_SYNC_TIMEOUT)
> +
> +    if not synced:
> +        ksft_pr(f"ptp4l follower did not reach locked state (s2) within "
> +                f"{PTP4L_SYNC_TIMEOUT}s")
> +        tail = output.strip().split("\n")[-10:]
> +        ksft_pr("Follower log (last 10 lines): " + " | ".join(tail))
> +    ksft_true(synced, "PTP sync timeout")
> +
> +
> +def main():
> +    """Run ksft tests."""
> +    with NetDrvEpEnv(__file__) as cfg:
> +        ksft_run([ptp_sync_test], args=(cfg, ))
> +    ksft_exit()
> +
> +
> +if __name__ == "__main__":
> +    main()
> -- 
> 2.56.0
> 

Tested-by: Hangbin Liu <liuhangbin@kylinos.cn>
Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
