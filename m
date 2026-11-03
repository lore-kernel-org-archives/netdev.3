Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793682144;
	b=a9fCQf+CK92ON6ApCe1GcS52ZzSGxQv5Gofyzd0PIg/+LeEq0fUgPNwOmvP87nPvIvsq
	 nXnrRNDsnVsxtbJKzQOm04drIBJouALvc/ih5qYTH+gtm8vkPAKGWFgpfqBcLd8gkrkc4
	 OSZgkg7ylZtssls0INL0SUnhRWHHxw4auvLM8ryOV9tYpSrw4+s/5YcLwZVSvyUkz0p4Z
	 AhcWU9qZw89VDfKDaC8KjVnB1Qaxrnqhk6GgDpvXi1toBfgXBRtrmJUZ9s86rgJfARk7o
	 QjWl0c2BErlyaoazgYiPIZ9I23q6YAgFVwmLtskRWaPlrIQUKNdUPGtUPX+w5fXQzwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793682144;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mfatT4OPPaPSKZTpfoKN7zDSgieSV+D5jj3GzfTbTgk=;
	b=QQQTJzgNRh8DWzEOL+P0IrPrw1g0EMcgQcJS8xC17QJGrN1wBN4oJ4Sxl2rjTLPQ9z3k
	 zdts/6lQ2LydDABVLkRTY1Hy0pBoVkq6HEihCGHIz4OQBhuj4/kNzJ3T4h0g3iUy7/Se8
	 b5iPt5iaKcFdWy3SnauyMY+iahhpSB7m4UxFpVJhImC2wA833ZwIlzmtD5HUTagnGF9N2
	 9pOosLXkIQD9Ao1g9ghjYq5Rs7XJ97c017nA88yi0mk75zSp/U66lX650fM0R4s5bLohN
	 PXh0yccJNc3gyisl0PvNkzt0ujrV5iy9x6plAySBYXdh0DBCwFcmHyQPXpYdVJ/wgrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kmstBu/k";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E44F606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 05:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kmstBu/k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61AA1F000C1;
	Tue,  3 Nov 2026 05:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793682143;
	bh=mfatT4OPPaPSKZTpfoKN7zDSgieSV+D5jj3GzfTbTgk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=kmstBu/k/rBCuhnZ3hW3btDldq5lFjCRvo5tfCPK9wLUMmh1HVUAyZ9MzqrKfg/DY
	 8DhyTunZgx9FU7Aqc4a+rmRTbMx5h5w3G48AHiErlB3IiosVyJPBxX/c7MrO8tmH+i
	 V251H/hk35JguEVo3+GpoOA7BpxxRAPWQ7i46vBIv9/g6D3DXn0BsXv4QlIZqNaUNg
	 0h8lQzq399DG9a7nCMb3HKmXVdSaYNS1N9Qz1KK1p/NyFY1o9IDWqYl4doDRsYhAcB
	 HlMvUenBqu9+qFygHK5fzn0Vqfw6Nau2HD1QIeq1vZzG4vpwri/GMvN7QdwktHDuJ/
	 GdxnGdlufSLIA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Subject: Re: [PATCH net-next v3 2/4] selftests: drv-net: add an iperf
 performance test
In-Reply-To: <20261102190827.989117-3-sdf@fomichev.me>
References: <20261102190827.989117-1-sdf@fomichev.me>
 <20261102190827.989117-3-sdf@fomichev.me>
Date: Tue, 03 Nov 2026 06:02:23 +0100
Message-ID: <875wye4ie8.fsf@all.your.base.are.belong.to.us>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Stanislav Fomichev <sdf.kernel@gmail.com> writes:

> Add the drivers/net/perf target, with a lib/py of its own like the one of
> drivers/net/hw. Add Iperf3Runner.measure(), which returns an Iperf3Result
> that other results can join later, and report its throughput from the tes=
t.
>
> Single-stream iperf3 throughput is flaky and can change considerably
> between back-to-back runs on the same hosts.
>
> Tested on two mlx5 hosts. Captured metric output:
>
>   # # ktap-metric-json: {"goal":"higher","name":"throughput","value":49.9=
2071602072054}
>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/Makefile              |  2 +-
>  .../selftests/drivers/net/lib/py/load.py      | 20 ++++++-
>  .../selftests/drivers/net/perf/Makefile       | 11 ++++
>  .../testing/selftests/drivers/net/perf/config |  1 +
>  .../selftests/drivers/net/perf/iperf.py       | 23 ++++++++
>  .../drivers/net/perf/lib/py/__init__.py       | 57 +++++++++++++++++++
>  .../selftests/drivers/net/perf/settings       |  1 +
>  7 files changed, 111 insertions(+), 4 deletions(-)
>  create mode 100644 tools/testing/selftests/drivers/net/perf/Makefile
>  create mode 100644 tools/testing/selftests/drivers/net/perf/config
>  create mode 100755 tools/testing/selftests/drivers/net/perf/iperf.py
>  create mode 100644 tools/testing/selftests/drivers/net/perf/lib/py/__ini=
t__.py
>  create mode 100644 tools/testing/selftests/drivers/net/perf/settings
>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/M=
akefile
> index 07c3719f8b04..c55d7792b27c 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -159,7 +159,7 @@ TARGETS_HOTPLUG =3D cpu-hotplug
>  TARGETS_HOTPLUG +=3D memory-hotplug
>=20=20
>  # Networking tests want the net/lib target, include it automatically
> -ifneq ($(filter net drivers/net drivers/net/hw,$(TARGETS)),)
> +ifneq ($(filter net drivers/net drivers/net/hw drivers/net/perf,$(TARGET=
S)),)
>  ifeq ($(filter net/lib,$(TARGETS)),)
>  	INSTALL_DEP_TARGETS :=3D net/lib
>  endif
> diff --git a/tools/testing/selftests/drivers/net/lib/py/load.py b/tools/t=
esting/selftests/drivers/net/lib/py/load.py
> index e24660e5c27f..f337b576c4b4 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/load.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/load.py
> @@ -3,10 +3,18 @@
>  import re
>  import time
>  import json
> +from dataclasses import dataclass
>=20=20
>  from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen
>=20=20
>=20=20
> +@dataclass
> +class Iperf3Result:
> +    """Average throughput (Gbps) of an iperf3 run."""
> +
> +    throughput: float
> +
> +
>  class Iperf3Runner:
>      """
>      Sets up and runs iperf3 traffic.
> @@ -53,9 +61,9 @@ from lib.py import ksft_pr, cmd, ip, rand_port, wait_po=
rt_listen
>              kwargs["timeout"] =3D duration + 5
>          return cmd(cmdline, **kwargs)
>=20=20
> -    def measure_bandwidth(self, reverse=3DFalse):
> +    def measure(self, reverse=3DFalse):
>          """
> -        Runs an iperf3 measurement and returns the average bandwidth (Gb=
ps).
> +        Runs an iperf3 measurement and returns an Iperf3Result.
>          Discards the first and last few reporting intervals and uses onl=
y the
>          middle part of the run where throughput is typically stable.
>          """
> @@ -78,7 +86,13 @@ from lib.py import ksft_pr, cmd, ip, rand_port, wait_p=
ort_listen
>=20=20
>          avg =3D sum(stable) / len(stable)
>=20=20
> -        return avg
> +        return Iperf3Result(avg)
> +
> +    def measure_bandwidth(self, reverse=3DFalse):
> +        """
> +        Runs an iperf3 measurement and returns the average bandwidth (Gb=
ps).
> +        """
> +        return self.measure(reverse=3Dreverse).throughput
>=20=20
>=20=20
>  class GenerateTraffic:
> diff --git a/tools/testing/selftests/drivers/net/perf/Makefile b/tools/te=
sting/selftests/drivers/net/perf/Makefile
> new file mode 100644
> index 000000000000..31b0b60de4f6
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/perf/Makefile
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +TEST_PROGS :=3D \
> +	iperf.py \
> +# end of TEST_PROGS
> +
> +TEST_INCLUDES :=3D \
> +	$(wildcard lib/py/*.py ../lib/py/*.py) \
> +# end of TEST_INCLUDES
> +
> +include ../../../lib.mk
> diff --git a/tools/testing/selftests/drivers/net/perf/config b/tools/test=
ing/selftests/drivers/net/perf/config
> new file mode 100644
> index 000000000000..6450f34933e6
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/perf/config
> @@ -0,0 +1 @@
> +CONFIG_IPV6=3Dy
> diff --git a/tools/testing/selftests/drivers/net/perf/iperf.py b/tools/te=
sting/selftests/drivers/net/perf/iperf.py
> new file mode 100755
> index 000000000000..5b6f0bce2a03
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/perf/iperf.py
> @@ -0,0 +1,23 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +"""Measure TCP throughput with iperf3."""
> +
> +from lib.py import Iperf3Runner, NetDrvEpEnv, ksft_exit, ksft_metric, ks=
ft_run
> +
> +
> +def tcp(cfg):
> +    """Measure TCP throughput."""
> +    result =3D Iperf3Runner(cfg).measure()
> +    ksft_metric("throughput", result.throughput, goal=3D"higher")
> +
> +
> +def main():
> +    """Run the iperf performance test."""
> +    with NetDrvEpEnv(__file__, nsim_test=3DFalse) as cfg:
> +        ksft_run([tcp], args=3D(cfg,))
> +    ksft_exit()
> +
> +
> +if __name__ =3D=3D "__main__":
> +    main()
> diff --git a/tools/testing/selftests/drivers/net/perf/lib/py/__init__.py =
b/tools/testing/selftests/drivers/net/perf/lib/py/__init__.py
> new file mode 100644
> index 000000000000..2bb2cd08ff7d
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/perf/lib/py/__init__.py
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +"""
> +Driver test environment (performance tests).
> +NetDrvEnv and NetDrvEpEnv are the main environment classes.
> +NetDrvContEnv extends NetDrvEpEnv with netkit container support.
> +Former is for local host only tests, latter creates / connects
> +to a remote endpoint. See NIPA wiki for more information about
> +running and writing driver tests.
> +"""
> +
> +import sys
> +from pathlib import Path
> +
> +KSFT_DIR =3D (Path(__file__).parent / "../../../../..").resolve()
> +
> +try:
> +    sys.path.append(KSFT_DIR.as_posix())
> +
> +    # Import one by one to avoid pylint false positives
> +    from net.lib.py import NetNS, NetNSEnter, NetdevSimDev, UserNetNS
> +    from net.lib.py import EthtoolFamily, NetdevFamily, NetshaperFamily,=
 \
> +        NlError, RtnlFamily, DevlinkFamily, PSPFamily, Netlink
> +    from net.lib.py import CmdExitFailure
> +    from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
> +        fd_read_timeout, ip, rand_port, rand_ports, wait_port_listen, \
> +        wait_file, ctl_file_write, tool
> +    from net.lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
> +    from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
> +    from net.lib.py import ksft_disruptive, ksft_exit, ksft_metric, ksft=
_pr, \
> +        ksft_run, ksft_setup, ksft_variants, KsftNamedVariant
> +    from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
> +        ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_=
none
> +    from drivers.net.lib.py import set_ethtool_feat
> +    from drivers.net.lib.py import GenerateTraffic, Remote, Iperf3Runner
> +    from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv, NetDrvContEnv
> +
> +    __all__ =3D ["NetNS", "NetNSEnter", "NetdevSimDev", "UserNetNS",
> +               "EthtoolFamily", "NetdevFamily", "NetshaperFamily",
> +               "NlError", "RtnlFamily", "DevlinkFamily", "PSPFamily", "N=
etlink",
> +               "CmdExitFailure",
> +               "bkg", "cmd", "bpftool", "bpftrace", "defer", "ethtool",
> +               "fd_read_timeout", "ip", "rand_port", "rand_ports",
> +               "wait_port_listen", "wait_file", "ctl_file_write", "tool",
> +               "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
> +               "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
> +               "ksft_disruptive", "ksft_exit", "ksft_metric", "ksft_pr",
> +               "ksft_run", "ksft_setup", "ksft_variants", "KsftNamedVari=
ant",
> +               "ksft_eq", "ksft_ge", "ksft_in", "ksft_is", "ksft_lt",
> +               "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ks=
ft_gt",
> +               "ksft_not_none",
> +               "NetDrvEnv", "NetDrvEpEnv", "NetDrvContEnv", "GenerateTra=
ffic",
> +               "Remote", "Iperf3Runner", "set_ethtool_feat"]
> +except ModuleNotFoundError as e:
> +    print("Failed importing `net` library from kernel sources")
> +    print(str(e))
> +    sys.exit(4)

nit: is there a KSFT_SKIP symbol?

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
