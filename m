Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355369;
	b=2E3eRBmN/XKYzPxIKVeOHS6lanzPIVg4KK2RCsITeQySlWeSE2tVrM9VgGMHDV79kiRZ
	 avTIYdt67/7/QVAgGJiDKiSOHkFosWsO2o4JcNur5VJxcPQyIVxhO111zTsjNGCjo7kMC
	 em+k8cCKuvQisUkXjjDkeC/Vcl1DTe9mjDiGbujcgMlANBoJER8p/ZAoapET/A/2WnnTr
	 TiQRN5ROEdMr6OvmEnI+dBpcY0rfEvQsSMDJK2WDJ48DMWjW1Cgz3Ar74VFq1cxTnIreV
	 ICulk2+cK4CEHDA/3rPxC9ztNfIhupgCjG7Ow+TG6c2bOjrr92s7r8U4rPqDBJan6oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355369;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7ZZ/OFN0ufJbb8Tmi6kc1Fvy321WkMZjqWXL4JlnW4A=;
	b=BgM9wmlmH02X0EGIOEEeAqTyaVBNs8nxYarRiPUBRwK82atDZ0HnsIygm4WpaUDwbGGa
	 8n44n/8X8IQ1a1EhcBBHrfdm8Aakn/XgRYzUd5MoTEoO34frBgKIKFqkSR7UkfoN/mAnN
	 noV7gq8Ny+hdSXy6OILI1fyoiioIUDONaQccoSKmHDf+5ZFeysHDjc6Fwjp1Tr8excAsT
	 KqiZ/5+ZuBdcPJXhRuHGSFWCOZfjVshz9Vb2UNGEr9j40ygfaIBVTyHrdn1wod0SGEQ1U
	 /LSTacxZpqw9kBQ2K7h+DdDsaOUBK4jGi8Zupq9pSEuqARfK7TbMpRJqWrYH9svndcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Em7NERXb;
	arc=none smtp.remote-ip=74.125.229.4
Received: from mail-dy2-f4.google.com (mail-dy2-f4.google.com [74.125.229.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE365606A321
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 00:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE365606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Em7NERXb
Received: by mail-dy2-f4.google.com with SMTP id 5a478bee46e88-36e06480786so1084693eec.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 16:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794355368; x=1794960168; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7ZZ/OFN0ufJbb8Tmi6kc1Fvy321WkMZjqWXL4JlnW4A=;
        b=Em7NERXbOQDdoDGQ4771cf98rPsDTeIWpb4qzIWGSKJmuk/ibMdqFATa+f09MW1bZU
         WwzhuqlJnBnN3YlF5Lg3k8WqFavghHbIjoZaqxeCjgxIqpGm3HQoeTllxImzj8TffxaM
         giOK5kGQEUxWtuxmxIaBW+drmsy9677e7DLeizy+plenTAx/xT/fWPMgxvMItskN7MOr
         TdzezpO6ocBD60UaL/OD6SMXga/ewi5IuroWFKov70I0JLGIlL2qH1KMSkfmRI+JmR9k
         dAseQJfzZrkky0PKGDJBG6B7mJBnmDLm/1MxecDj2TWZ/EgaZG+ni3LOkR4g6eTVH//O
         XL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794355368; x=1794960168;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7ZZ/OFN0ufJbb8Tmi6kc1Fvy321WkMZjqWXL4JlnW4A=;
        b=NepTz7dBjqdBNK30yRgoiATg2j1IWhMG1OS/tu7xPMjlMuy3WNXQmG188ranap86zG
         mGdiPz9i4scoliCdaLtbS5qEGulKsxS0FiiC+osTDWh6tS4idhaQAT5CJLmQoH1chU0s
         GBXSc5M50ck+UyjJgrp1istllIodpDCUK6Ta518I68apHuv2DWSmtZRx+2hVJQjKYW7O
         tOGlYVbN3kWhs1pmshIkw178UGE8XSZlcC4zEBzVqE+OTZ6T2Z3owyatB+L/wmzyDHRz
         OUHF4TUa8JIS7DKuELdOb9RZtCJhff4iKUwKMhGzSDP5fZ1PH0AK4IsvQCBiKybkhJs8
         r/qw==
X-Gm-Message-State: APuU4Z/0syjF5Q7ob48YI16KpHC2xATxtd5XtaQE5sM0oaaFkMFGn/Pe
	8iDlbgEvED9t5pW50YoQw3a2mrWiD0/mhBnbrFXYqUjU1/zPV9FqxvxtN/9c0hDcbPI=
X-Gm-Gg: AYBFou3LW8xxZbhIeWwebhzkLXik9XbOpD25gAJ/bJ/9mz6iz5ARb4sYiZO5dVpwhuZ
	Lu7Py6qSJK9eVb4EoHCFO7X9kXcaMyZoA0PmwwOLFHkzUIsgsQSo+gJ7YjfSfrQZM59ayPF2yWr
	EJ0oZnD0NECrqlpMO7dma2+4c08GhLqXszgwc1tNBUFwjh/AHr5TCzd/Wvt/enaMJrcMwmVOeLZ
	mD2wb8kyG85cq8X6x3Q6WhiXQPtc8rCyjT576dygePHUixyXlBeTbDkorkP5ArN9XoMqeoBNz60
	oTb8pVJuLNoiVElc6PNULu6MK6mLC+fKgOXPmmBdOaJSKpWuaQ9TI2ETNDIpWnY9sgJH5JCqNu0
	uv4lwk2zchw5ncB2NO2+irUeWBUxhdbZ9I3vy92FtjCJzKHU77rLXQv9LyNaw4JJIeczoUxAI9n
	LFUGNBqGiYCWqkerHzevhfVQkSIS5j5EUC+yhlaMW4MasTkhXvLLjb4FwekwdTntpGkgDcetWgT
	EUsv1LA5BgUoE2TcKgucOv3saYiL56hFI3axjnHUdltPpkcnZTk9s+WRqI1WZeD9L7FKiasfEG4
	8r7DRSISfwkuc+E3v6BXTcg=
X-Received: by 2002:a05:693c:895b:10b0:36f:be1f:1191 with SMTP id 5a478bee46e88-37686d329d5mr1337679eec.29.1794355367890;
        Tue, 10 Nov 2026 16:02:47 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:64::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751d9f135asm10112195eec.2.2026.11.10.16.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 16:02:46 -0800 (PST)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v4 0/4] selftests: net: add performance metric reporting
Date: Tue, 10 Nov 2026 16:02:42 -0800
Message-ID: <20261111000246.962871-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
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

Let Python selftests report numeric measurements, so that CI can track
the performance of drivers over time, and add two performance tests.

ksft_metric() reports a measurement of the current test case, which is
printed right away as JSON:

  # ktap-metric-json: {"goal":"higher","name":"throughput","value":389.127}

The goal tells a performance metric, which is better higher or lower,
from an error metric, which must be zero. Everything else, such as
units, history and regression thresholds, is up to the consumer.

The tests are in a new drivers/net/perf target, apart from the
functional tests: they need real hardware, take a while, and make no
sense on debug kernels. iperf.py measures single-stream TCP throughput
with iperf3, devmem.py the throughput of udmabuf-backed devmem TCP with
kperf [1].

System monitoring stays in NIPA, which runs each case of the perf tests
in a process of its own and attaches CPU and NIC metrics to its results.
The NIPA changes are at [2]; git clone & ./nipa local view starts an
http server on :44109 with two sample runs.

[1] https://github.com/facebookexperimental/kperf
[2] https://github.com/fomichev/nipa/tree/nipa-local-hw-metrics

v4:
- print metrics right away (Jakub)
- mark the exit code of the perf lib/py on import failures as KSFT_SKIP
  (Björn)
- let kperf-server --kill wait for the sessions of the server, drop the
  pgrep loop (Jakub):
  https://github.com/facebookexperimental/kperf/pull/47

v3:
- drop the timestamp of metrics (Jakub)
- drop the note on nested output from the docs (Jakub)
- report plain numbers, drop kind/type (Jakub)
- replace ksft_metric_policy() with a goal per metric: higher, lower
  or zero (Jakub)
- move the tests to drivers/net/perf, with a lib/py of their own (Jakub)
- fix the format of the Makefile lists (Jakub)
- report metrics from the tests rather than the runners (Jakub)
- drop the kperf section of the README (Jakub)
- stop reporting TCP retransmits
- drop the metric labels, report the throughput of the receiver only

v2:
- move system monitoring to NIPA (Jakub)
- move performance tests to drivers/net/hw/performance (Jakub)
- rename metric shape to type and document supported types (Paolo);
  kind= instead of type= (type shadows a builtin)
- remove direction from the metric example (Paolo)
- document policy processing order (Paolo)
- support producer-selected summary operations, including arbitrary pXX
- label throughput metrics in Gbps
- do not mark the iperf benchmark disruptive
- use 2 GiB udmabuf buffers for kperf devmem
- drop the ncdevmem devmem probe
- use a random kperf control port
- report kperf server cleanup failures

Stanislav Fomichev (4):
  selftests: net: py: add metric output
  selftests: drv-net: add an iperf performance test
  selftests: drv-net: add a kperf runner
  selftests: drv-net: measure devmem performance with kperf

 tools/testing/selftests/Makefile              |   2 +-
 .../testing/selftests/drivers/net/README.rst  |  16 ++
 .../selftests/drivers/net/lib/py/__init__.py  |   4 +-
 .../selftests/drivers/net/lib/py/kperf.py     | 157 ++++++++++++++++++
 .../selftests/drivers/net/lib/py/load.py      |  20 ++-
 .../selftests/drivers/net/perf/Makefile       |  12 ++
 .../testing/selftests/drivers/net/perf/config |   4 +
 .../selftests/drivers/net/perf/devmem.py      |  96 +++++++++++
 .../selftests/drivers/net/perf/iperf.py       |  23 +++
 .../drivers/net/perf/lib/py/__init__.py       |  59 +++++++
 .../selftests/drivers/net/perf/settings       |   1 +
 .../testing/selftests/net/lib/py/__init__.py  |   9 +-
 tools/testing/selftests/net/lib/py/ksft.py    |  20 +++
 13 files changed, 414 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/kperf.py
 create mode 100644 tools/testing/selftests/drivers/net/perf/Makefile
 create mode 100644 tools/testing/selftests/drivers/net/perf/config
 create mode 100755 tools/testing/selftests/drivers/net/perf/devmem.py
 create mode 100755 tools/testing/selftests/drivers/net/perf/iperf.py
 create mode 100644 tools/testing/selftests/drivers/net/perf/lib/py/__init__.py
 create mode 100644 tools/testing/selftests/drivers/net/perf/settings

-- 
2.53.0-Meta

