Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793734402;
	b=MWRy9ieAXRuwdUQzAhcj5LvTfA/551dp26DENi2cMQL18MVVqqRQKBYjsscqY+D1d85K
	 GfS5fgKGfzQy77Iu0MlEetV17BJtPnhqeF7bUxmMzS9hK51xDrdhaM79fINrDCGb+j7j7
	 6ESrxPo8nnokQoptW4clBTBHeTg31vJy8S+p+4+hNd29sE4oHOqCw6uo4VgHKHyVQ473P
	 urluDamx/9JhjhG8oTkuoSUOuRuRO9dj9boBuLQUxH0Rq3CRK3nlPKLumYQ+0c30dINi5
	 Lyp0QrS5KhomgC5KZm50POqVOkdNinPIR/ENwic7FyQHK+ZCIDLyNm3PLACqru8cWZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793734402;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=DRpHf+ODgzZxNvjt9ov8aWi7RfHJUlB5TNrAao6dUwk=;
	b=mWnh44W+proecB4FUkcQUcfDd+7E7gPDoO+/9LqyCuugV0DOGdQY1czxm2QrF6y9SEvl
	 4YllWzyp82ajnFJgIyYhJq9YQQtt4SwF5clL8Jn5GKeutZqEG3Ojm9HRXZm+lYOc+lIcy
	 RDb9eQlU39UhUbXnl2SolsplZQIiSp9Z5P8cKuPQvVudNEb7xT/LvV6AJX1ejyDIdIEfK
	 IsQXhUdp+lBe/GkD4PSoqnNJLPAdYvbSjPTQmgmbcAGnAtK6CUurDwEtHqoaIWoNHQzf5
	 sYdcPj+ifp8lvH14VzSfUnFJgmgW2OApoB/mzjpiL/9c+jDZ2lcHLdQfYeSX3JIi3OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="YuXBTCh/";
	arc=none smtp.remote-ip=74.125.229.131
Received: from mail-dl2-f3.google.com (mail-dl2-f3.google.com [74.125.229.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C99606A31B
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 19:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39C99606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YuXBTCh/
Received: by mail-dl2-f3.google.com with SMTP id a92af1059eb24-1b23f91cd75so325770c88.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 11:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793734401; x=1794339201; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DRpHf+ODgzZxNvjt9ov8aWi7RfHJUlB5TNrAao6dUwk=;
        b=YuXBTCh/9wQHInJCdqQEUZkHSCIwFh0ICAddijMJaVCBVsjZBX627gmzAX82JySlC9
         3HhEWrguvbwBsj5fhN+Yb7IImHP12s6GC6kb5Arhgl5kfa1z3w4PRFZurkxaZLQk+rZP
         SgHOLX0ZMcpXMGfZ1yWg3HMoxBmkpUtB1Ydu83/ESgTd9CHt9AF7UQo9bu9B46+kLYVM
         UaCnBzb6Y0945MBtCs0ad94QtUU6I0t+GBaf2OQ8XjowjSq5xQYR+etSE2zcEd3wpSjo
         a+0V2tXcwgvi3xPbpyrA7Eecytq7SUdAcoeTwIm2FOWNp1RYaeGPIFQLtpE32ydXq9HX
         qICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793734401; x=1794339201;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DRpHf+ODgzZxNvjt9ov8aWi7RfHJUlB5TNrAao6dUwk=;
        b=tCcNJyvCEjiJeotbDWz4TufdAk3aR/a1Mu6Evf260+FDfroS5fO1mNjv8SYOzw38Vb
         sb0CiUi8wJfDqSuqzcqry2k8Ae+cnszEOi0xH1zFO/llFSMLVT/51E3kbS5JJpeuVgyN
         cbRHXleBdDIRumdzul4hewcrEcc8VHFaAFkvKsjZMKwuGs9Q3AXpzFWFPoGueLE3B/M7
         a/MwsymEghKZZf05OSL2rR2QFziaFuzbxPDQhOH0B9q0BQbKdJmPd2BhimUvZMs0/Cjj
         HWGpRzuMia62nkOO/UI9cTqWobMboAFlOYbD/JoXQYsiVEHDJA60SjDndjVyn74t3cl4
         ohgw==
X-Gm-Message-State: APuU4Z/bCJt2yyt8ed2jeM/1TCDJDVyOQOXqnX/fYocgDl8z8K5sDb6E
	BSgp2i+dGkwW/fsEk3M64iK02rMZkCK5nJahAfwY9UsVK8OxZB/Yh033
X-Gm-Gg: AYBFou1Zow+t+NvaPCYNTM2QfHQUoQpdfTsDK0JuSDJ4YdcTdzYQJJodZG7kHd7pzuR
	DU8Zi0V81Tp393jR19mjpn7yPXi6YEvDjYhcIhWaR+h7UIwqcIQJh6t8ycjiHgSxgUbQ1s+Fkfd
	1jCcB7nekK2bvb1uhvoylg/RshsqM5JmhjlmOvlCy+auv9RqvL9YpkM/5CRBHUMyVcvfOoJxy5B
	0ceDZTCyH1DcJAQnSJ4eyQXjyXThVOeFRZkl8EQhwIs+IijGKGbabyDPYWhvyM25bYdgDeAKx7h
	VaKVHp9dcrMAFUsHbfbUTnpH70dWNK286xMOn6QBoQ3ThcM6kRYfT/3MT3jcnIj+ls3BMU6oC1I
	SVG0v/Ja31QshAs8NWd29bebgloMl7rNWw4AjrWHMmmSTyh/eAg1eW5FJl5T54BqC6WnJUaNtZ/
	J3VWQJlkk4jYQJMy3QK5M7tm4S3RNfPic6JycaMMqTianpC4hg88CEKBhcEWff2W0l1GZNXidcN
	Dt3CQtWGRIV79COV0J6aPwGJ5wOFkKlV0RQ20OnknqZoeVrdvpGGT8hEMK4pbvUz97jKYm6lJwx
	b5ZZv2NI3KA9t7+kGXKOKg==
X-Received: by 2002:a05:7022:7f13:b0:195:76af:b810 with SMTP id a92af1059eb24-1ac5bf91b35mr20811181c88.25.1793734401028;
        Tue, 03 Nov 2026 11:33:21 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:70::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c2c2f7sm954213c88.9.2026.11.03.11.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 11:33:20 -0800 (PST)
Date: Tue, 3 Nov 2026 11:10:51 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v3 2/4] selftests: drv-net: add an iperf
 performance test
Message-ID: <auowsuqDwvC8c24l@devvm16445.scu0.facebook.com>
References: <20261102190827.989117-1-sdf@fomichev.me>
 <20261102190827.989117-3-sdf@fomichev.me>
 <875wye4ie8.fsf@all.your.base.are.belong.to.us>
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
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875wye4ie8.fsf@all.your.base.are.belong.to.us>

On 11/03, Björn Töpel wrote:
> Stanislav Fomichev <sdf.kernel@gmail.com> writes:
> 
> > Add the drivers/net/perf target, with a lib/py of its own like the one of
> > drivers/net/hw. Add Iperf3Runner.measure(), which returns an Iperf3Result
> > that other results can join later, and report its throughput from the test.
> >
> > Single-stream iperf3 throughput is flaky and can change considerably
> > between back-to-back runs on the same hosts.
> >
> > Tested on two mlx5 hosts. Captured metric output:
> >
> >   # # ktap-metric-json: {"goal":"higher","name":"throughput","value":49.92071602072054}
> >
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  tools/testing/selftests/Makefile              |  2 +-
> >  .../selftests/drivers/net/lib/py/load.py      | 20 ++++++-
> >  .../selftests/drivers/net/perf/Makefile       | 11 ++++
> >  .../testing/selftests/drivers/net/perf/config |  1 +
> >  .../selftests/drivers/net/perf/iperf.py       | 23 ++++++++
> >  .../drivers/net/perf/lib/py/__init__.py       | 57 +++++++++++++++++++
> >  .../selftests/drivers/net/perf/settings       |  1 +
> >  7 files changed, 111 insertions(+), 4 deletions(-)
> >  create mode 100644 tools/testing/selftests/drivers/net/perf/Makefile
> >  create mode 100644 tools/testing/selftests/drivers/net/perf/config
> >  create mode 100755 tools/testing/selftests/drivers/net/perf/iperf.py
> >  create mode 100644 tools/testing/selftests/drivers/net/perf/lib/py/__init__.py
> >  create mode 100644 tools/testing/selftests/drivers/net/perf/settings
> >
> > diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> > index 07c3719f8b04..c55d7792b27c 100644
> > --- a/tools/testing/selftests/Makefile
> > +++ b/tools/testing/selftests/Makefile
> > @@ -159,7 +159,7 @@ TARGETS_HOTPLUG = cpu-hotplug
> >  TARGETS_HOTPLUG += memory-hotplug
> >  
> >  # Networking tests want the net/lib target, include it automatically
> > -ifneq ($(filter net drivers/net drivers/net/hw,$(TARGETS)),)
> > +ifneq ($(filter net drivers/net drivers/net/hw drivers/net/perf,$(TARGETS)),)
> >  ifeq ($(filter net/lib,$(TARGETS)),)
> >  	INSTALL_DEP_TARGETS := net/lib
> >  endif
> > diff --git a/tools/testing/selftests/drivers/net/lib/py/load.py b/tools/testing/selftests/drivers/net/lib/py/load.py
> > index e24660e5c27f..f337b576c4b4 100644
> > --- a/tools/testing/selftests/drivers/net/lib/py/load.py
> > +++ b/tools/testing/selftests/drivers/net/lib/py/load.py
> > @@ -3,10 +3,18 @@
> >  import re
> >  import time
> >  import json
> > +from dataclasses import dataclass
> >  
> >  from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen
> >  
> >  
> > +@dataclass
> > +class Iperf3Result:
> > +    """Average throughput (Gbps) of an iperf3 run."""
> > +
> > +    throughput: float
> > +
> > +
> >  class Iperf3Runner:
> >      """
> >      Sets up and runs iperf3 traffic.
> > @@ -53,9 +61,9 @@ from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen
> >              kwargs["timeout"] = duration + 5
> >          return cmd(cmdline, **kwargs)
> >  
> > -    def measure_bandwidth(self, reverse=False):
> > +    def measure(self, reverse=False):
> >          """
> > -        Runs an iperf3 measurement and returns the average bandwidth (Gbps).
> > +        Runs an iperf3 measurement and returns an Iperf3Result.
> >          Discards the first and last few reporting intervals and uses only the
> >          middle part of the run where throughput is typically stable.
> >          """
> > @@ -78,7 +86,13 @@ from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen
> >  
> >          avg = sum(stable) / len(stable)
> >  
> > -        return avg
> > +        return Iperf3Result(avg)
> > +
> > +    def measure_bandwidth(self, reverse=False):
> > +        """
> > +        Runs an iperf3 measurement and returns the average bandwidth (Gbps).
> > +        """
> > +        return self.measure(reverse=reverse).throughput
> >  
> >  
> >  class GenerateTraffic:
> > diff --git a/tools/testing/selftests/drivers/net/perf/Makefile b/tools/testing/selftests/drivers/net/perf/Makefile
> > new file mode 100644
> > index 000000000000..31b0b60de4f6
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/perf/Makefile
> > @@ -0,0 +1,11 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +TEST_PROGS := \
> > +	iperf.py \
> > +# end of TEST_PROGS
> > +
> > +TEST_INCLUDES := \
> > +	$(wildcard lib/py/*.py ../lib/py/*.py) \
> > +# end of TEST_INCLUDES
> > +
> > +include ../../../lib.mk
> > diff --git a/tools/testing/selftests/drivers/net/perf/config b/tools/testing/selftests/drivers/net/perf/config
> > new file mode 100644
> > index 000000000000..6450f34933e6
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/perf/config
> > @@ -0,0 +1 @@
> > +CONFIG_IPV6=y
> > diff --git a/tools/testing/selftests/drivers/net/perf/iperf.py b/tools/testing/selftests/drivers/net/perf/iperf.py
> > new file mode 100755
> > index 000000000000..5b6f0bce2a03
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/perf/iperf.py
> > @@ -0,0 +1,23 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +"""Measure TCP throughput with iperf3."""
> > +
> > +from lib.py import Iperf3Runner, NetDrvEpEnv, ksft_exit, ksft_metric, ksft_run
> > +
> > +
> > +def tcp(cfg):
> > +    """Measure TCP throughput."""
> > +    result = Iperf3Runner(cfg).measure()
> > +    ksft_metric("throughput", result.throughput, goal="higher")
> > +
> > +
> > +def main():
> > +    """Run the iperf performance test."""
> > +    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
> > +        ksft_run([tcp], args=(cfg,))
> > +    ksft_exit()
> > +
> > +
> > +if __name__ == "__main__":
> > +    main()
> > diff --git a/tools/testing/selftests/drivers/net/perf/lib/py/__init__.py b/tools/testing/selftests/drivers/net/perf/lib/py/__init__.py
> > new file mode 100644
> > index 000000000000..2bb2cd08ff7d
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/perf/lib/py/__init__.py
> > @@ -0,0 +1,57 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +"""
> > +Driver test environment (performance tests).
> > +NetDrvEnv and NetDrvEpEnv are the main environment classes.
> > +NetDrvContEnv extends NetDrvEpEnv with netkit container support.
> > +Former is for local host only tests, latter creates / connects
> > +to a remote endpoint. See NIPA wiki for more information about
> > +running and writing driver tests.
> > +"""
> > +
> > +import sys
> > +from pathlib import Path
> > +
> > +KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
> > +
> > +try:
> > +    sys.path.append(KSFT_DIR.as_posix())
> > +
> > +    # Import one by one to avoid pylint false positives
> > +    from net.lib.py import NetNS, NetNSEnter, NetdevSimDev, UserNetNS
> > +    from net.lib.py import EthtoolFamily, NetdevFamily, NetshaperFamily, \
> > +        NlError, RtnlFamily, DevlinkFamily, PSPFamily, Netlink
> > +    from net.lib.py import CmdExitFailure
> > +    from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
> > +        fd_read_timeout, ip, rand_port, rand_ports, wait_port_listen, \
> > +        wait_file, ctl_file_write, tool
> > +    from net.lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
> > +    from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
> > +    from net.lib.py import ksft_disruptive, ksft_exit, ksft_metric, ksft_pr, \
> > +        ksft_run, ksft_setup, ksft_variants, KsftNamedVariant
> > +    from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
> > +        ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
> > +    from drivers.net.lib.py import set_ethtool_feat
> > +    from drivers.net.lib.py import GenerateTraffic, Remote, Iperf3Runner
> > +    from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv, NetDrvContEnv
> > +
> > +    __all__ = ["NetNS", "NetNSEnter", "NetdevSimDev", "UserNetNS",
> > +               "EthtoolFamily", "NetdevFamily", "NetshaperFamily",
> > +               "NlError", "RtnlFamily", "DevlinkFamily", "PSPFamily", "Netlink",
> > +               "CmdExitFailure",
> > +               "bkg", "cmd", "bpftool", "bpftrace", "defer", "ethtool",
> > +               "fd_read_timeout", "ip", "rand_port", "rand_ports",
> > +               "wait_port_listen", "wait_file", "ctl_file_write", "tool",
> > +               "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
> > +               "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
> > +               "ksft_disruptive", "ksft_exit", "ksft_metric", "ksft_pr",
> > +               "ksft_run", "ksft_setup", "ksft_variants", "KsftNamedVariant",
> > +               "ksft_eq", "ksft_ge", "ksft_in", "ksft_is", "ksft_lt",
> > +               "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
> > +               "ksft_not_none",
> > +               "NetDrvEnv", "NetDrvEpEnv", "NetDrvContEnv", "GenerateTraffic",
> > +               "Remote", "Iperf3Runner", "set_ethtool_feat"]
> > +except ModuleNotFoundError as e:
> > +    print("Failed importing `net` library from kernel sources")
> > +    print(str(e))
> > +    sys.exit(4)
> 
> nit: is there a KSFT_SKIP symbol?
> 
> Reviewed-by: Björn Töpel <bjorn@kernel.org>

It is a copy-paste from selftests/drivers/net/hw/lib/py/__init__.py (and there
is a similar code in net/lib/py/ynl.py). I guess I can add "# KSFT_SKIP"
here instead of doing the real import.
