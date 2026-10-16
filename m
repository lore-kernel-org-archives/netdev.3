Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3827352758B
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170221; cv=none; b=s1CAIC5cDXw5Uqyv3fNRY2B9g9cIqlbaG1Vv/t0GdJSC6LJ4m4bWAVlizMAxTFFzAuIc75IZMXkNe9T4UZd7Vg0jAY2mgGtPjRSvBHHBOhEowSPtJEpKP6tu4g5QKfQWTauV7CC5Qdvanj0YuiTdO0XuEB7mFsttKOtGr9wjLKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170221; c=relaxed/simple;
	bh=bW5d9qABC9sqyrA4doR3O7DzPmcAB2N4l7lrtTQ5Eqk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ALFVb/v1q0IyS+2Urnwm4FZDYh1toJmRI/Xs7b+7PAgtuGbv5vFdaqPhlZqNn0frckubnVuuaRlSauEhJmMcfgsWt4QNj1GgsN79ZyL6FCf4bXr/2COx9PFhXc3s8hhkkFQ0qtyncy3SlxyUfZcTLilpVHpqvwaRBLHCgK8q1nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUSk9xxj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUSk9xxj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE6A1F000C7;
	Fri, 16 Oct 2026 17:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792170218;
	bh=3i0YvgpP0CGYhMAVR8GscaZ3eQxE21JoxnbYmE2Ag1g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CUSk9xxjU4MW1w8YdZ9PIf0Hgbguqq3Z8SG5X2kLu7RVgOtnrOaWUJf7dq2tR1hoq
	 /D/WMMGN0d/xL3MZxT5d0C/tPiM/G0+Nf9RvSeyKAwpgII8uzAplSoCQHhNf+nAihr
	 AAxpaxhPjCFlJcdT5nJHIWXEoeeAcQxEgeW2F/ntf+MB8NCc50btOMK8zycfex7AI+
	 xbH6NgqYDolWVhMHH19RWyqL4s4SQcWVlfzIHotE/DAVjXxszv/lXRPILp+xhQvloM
	 7rn21ZJBE53DMAlgzbfGWroR2Z9XoyQCUOCzQqTToinxLiBa3ye7Ej2zGwqw4IuW6u
	 yDWeRbzLV4UCQ==
Date: Fri, 16 Oct 2026 10:03:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [RFC net-next v2 3/5] selftests: drv-net: add an iperf
 performance test
Message-ID: <20261016100337.271adfa3@kernel.org>
In-Reply-To: <20261005201115.2690830-4-sdf@fomichev.me>
References: <20261005201115.2690830-1-sdf@fomichev.me>
	<20261005201115.2690830-4-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Oct 2026 13:11:12 -0700 Stanislav Fomichev wrote:
> Add the drivers/net/hw/performance target. Report throughput and
> retransmits from Iperf3Runner when requested.
> 
> Single-stream iperf3 throughput is flaky and can change considerably
> between back-to-back runs on the same hosts.
> 
> Tested on two mlx5 hosts. Captured metric output:
> 
>   # # ktap-metric-policy-json: {"display_label":"Gbps","name":"throughput","regression":{"better":"higher","compare":"p50","relative_tolerance":0.05},"summarize":"p50"}
>   # # ktap-metric-policy-json: {"name":"tcp.retransmits","summarize":"max"}
>   # # ktap-metric-json: {"host":"local","name":"throughput","time":10.685632,"type":"scalar","value":48.561920255183196}
>   # # ktap-metric-json: {"host":"remote","name":"tcp.retransmits","time":10.68565,"type":"scalar","value":0}
> 
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/Makefile              |  2 +-
>  .../drivers/net/hw/performance/Makefile       | 10 +++++++
>  .../drivers/net/hw/performance/config         |  1 +
>  .../drivers/net/hw/performance/iperf.py       | 27 +++++++++++++++++++
>  .../drivers/net/hw/performance/settings       |  1 +
>  .../selftests/drivers/net/lib/py/load.py      | 24 +++++++++++++++--
>  6 files changed, 62 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/drivers/net/hw/performance/Makefile
>  create mode 100644 tools/testing/selftests/drivers/net/hw/performance/config
>  create mode 100755 tools/testing/selftests/drivers/net/hw/performance/iperf.py
>  create mode 100644 tools/testing/selftests/drivers/net/hw/performance/settings
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 273853937c25..7523f378e026 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -152,7 +152,7 @@ TARGETS_HOTPLUG = cpu-hotplug
>  TARGETS_HOTPLUG += memory-hotplug
>  
>  # Networking tests want the net/lib target, include it automatically
> -ifneq ($(filter net drivers/net drivers/net/hw,$(TARGETS)),)
> +ifneq ($(filter net drivers/net drivers/net/hw drivers/net/hw/performance,$(TARGETS)),)

long strings, maybe let's s@/hw/perfromance@/perf@ ?

>  ifeq ($(filter net/lib,$(TARGETS)),)
>  	INSTALL_DEP_TARGETS := net/lib
>  endif
> diff --git a/tools/testing/selftests/drivers/net/hw/performance/Makefile b/tools/testing/selftests/drivers/net/hw/performance/Makefile
> new file mode 100644
> index 000000000000..5d53ef548306
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/performance/Makefile
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +TEST_PROGS := iperf.py

here..

> +TEST_INCLUDES := \
> +	$(wildcard ../lib/py/*.py ../../lib/py/*.py) \
> +	$(wildcard ../../../../net/lib/py/*.py) \
> +	#

.. and here -

not the exact correct format for the Makefile, pls look closer

> +include ../../../../lib.mk
> diff --git a/tools/testing/selftests/drivers/net/hw/performance/config b/tools/testing/selftests/drivers/net/hw/performance/config
> new file mode 100644
> index 000000000000..6450f34933e6
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/performance/config
> @@ -0,0 +1 @@
> +CONFIG_IPV6=y
> diff --git a/tools/testing/selftests/drivers/net/hw/performance/iperf.py b/tools/testing/selftests/drivers/net/hw/performance/iperf.py
> new file mode 100755
> index 000000000000..415fb67f4100
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/performance/iperf.py
> @@ -0,0 +1,27 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +"""Measure TCP throughput with iperf3."""
> +
> +from os import path
> +import sys
> +
> +sys.path.insert(0, path.join(path.dirname(path.abspath(__file__)), ".."))

Nasty hacks. Something is not laid out right, mister.

> +from lib.py import Iperf3Runner, NetDrvEpEnv, ksft_exit, ksft_run
> +
> +
> +def tcp(cfg):
> +    """Measure TCP throughput."""
> +    Iperf3Runner(cfg).measure_bandwidth(report=True)
> +
> +
> +def main():
> +    """Run the iperf performance test."""
> +    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
> +        ksft_run([tcp], args=(cfg,))
> +    ksft_exit()
> +
> +
> +if __name__ == "__main__":
> +    main()
> diff --git a/tools/testing/selftests/drivers/net/hw/performance/settings b/tools/testing/selftests/drivers/net/hw/performance/settings
> new file mode 100644
> index 000000000000..e7b9417537fb
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/performance/settings
> @@ -0,0 +1 @@
> +timeout=0
> diff --git a/tools/testing/selftests/drivers/net/lib/py/load.py b/tools/testing/selftests/drivers/net/lib/py/load.py
> index e24660e5c27f..a7da025b4e21 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/load.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/load.py
> @@ -4,7 +4,8 @@ import re
>  import time
>  import json
>  
> -from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen
> +from lib.py import cmd, ip, ksft_metric, ksft_metric_policy, ksft_pr, \
> +    rand_port, wait_port_listen
>  
>  
>  class Iperf3Runner:
> @@ -53,12 +54,20 @@ from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen
>              kwargs["timeout"] = duration + 5
>          return cmd(cmdline, **kwargs)
>  
> -    def measure_bandwidth(self, reverse=False):
> +    def measure_bandwidth(self, reverse=False, report=False):
>          """
>          Runs an iperf3 measurement and returns the average bandwidth (Gbps).
>          Discards the first and last few reporting intervals and uses only the
>          middle part of the run where throughput is typically stable.
>          """
> +        if report:
> +            ksft_metric_policy(
> +                "throughput", summarize="p50",
> +                regression={"compare": "p50", "better": "higher",
> +                            "relative_tolerance": 0.05},
> +                display_label="Gbps")
> +            ksft_metric_policy("tcp.retransmits", summarize="max")
> +
>          self.start_server()
>          result = self.start_client(duration=10, reverse=reverse)
>  
> @@ -77,6 +86,17 @@ from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen
>          stable = samples[3:-3]
>  
>          avg = sum(stable) / len(stable)
> +        retransmits = out.get("end", {}).get("sum_sent", {}).get(
> +            "retransmits")
> +        if report:
> +            if not isinstance(retransmits, int) or \
> +                    isinstance(retransmits, bool):
> +                raise ValueError("iperf3 did not report TCP retransmits")
> +            receiver = "remote" if reverse else "local"
> +            sender = "local" if reverse else "remote"
> +            ksft_metric("throughput", avg, kind="scalar", host=receiver)
> +            ksft_metric("tcp.retransmits", retransmits, kind="scalar",
> +                        host=sender)

I'd be tempted to find a way to pass a callback to the class
for result reporting rather than teach the class how to report.
But just a thought, not sure which ends up being cleaner.
