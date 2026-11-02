Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793646509;
	b=kHkPrU/d9NLYgLxNG6ZxEaSRCe/ywAyux2Zkl2WETavhOMtd06oW0j7t8VUfc64E9VEt
	 aH2ikFLjyA2vN9qxyQOblpCT1gzna4B1Y+9zzoHepVsnOrGl/0LP6KTLrqrjLsrnORcB0
	 qAbuCcuZ9mZkmKUiWuaqZdj82HCoccWeHho2rpGawLTK89u5h7gFz4ngon9GWrGA/1jJQ
	 T3jjA/8BwzDDRf7GfOy1627c7a7JX+zp6bH8FGvMgMrnl7Bpu8admpoiyAl3IqUA5dbXD
	 EX7fOBTEJL6rGDIsOqRf9shzemQfn0g5QelKhCcZj7WMEaOeUhPcRkZUGe7ijq0G8/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646509;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ikw8gEVhvcjahIQQLACyYzboGdzTL6Z1+RtVZ9m3bts=;
	b=I/fT47g58zS4Ug+cTRhFFluL/1NJA/Y4HwnFFpH/vT6RM7oTy+ko037kSXHXjkT84zT2
	 8NyojbeZAk/UEYzcbMKEY4gwHsFZEv9CXmRPOw8xACqHz5P158ddv5pFlqHRoIkf8GrH4
	 euAEjEBMpHeTjEpEzYWg5QhjpCc3bXG/j+gBLAePURFzJ0hA7iLz/4ij8uhm1rJLPteJR
	 3gCGQGLSAxfssbxIKH3mmYboPhMg+iMLl8SGd45O5dVMaWbE79SpZhja6pnzrQNQvtoXw
	 z624/DDKxjZw/lADm5+YT4PBhJ2PlL8hF/4Jdd+AfBHjD5jQq5JHoZnJcqSYNxhkLgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fpO41EqL;
	arc=none smtp.remote-ip=74.125.229.133
Received: from mail-dl2-f5.google.com (mail-dl2-f5.google.com [74.125.229.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72649606A327
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 19:08:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72649606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fpO41EqL
Received: by mail-dl2-f5.google.com with SMTP id a92af1059eb24-1ac216daf7dso1357031c88.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 11:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793646508; x=1794251308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ikw8gEVhvcjahIQQLACyYzboGdzTL6Z1+RtVZ9m3bts=;
        b=fpO41EqLCKOu2SNqwmu/JyFzQI1ucLgXgpFjhAgLmMRYqiH54Kshy7G73e9KYODIXh
         YsocpqpeFK3iMEAMh0hAAilDhMuJpjO2CySqjm0OGRgTiJGD/PE1y4VgsntAFQIc+aas
         MfFyYGbvCRHxABZmC+UYASCEB4ie1hENiympS/hUXwwvkBP/bRjjQfRRlrr4wDcE4KIs
         Jb9XJwmEElb9rzeTfYgA4Ji30U4V2IHmt4PDPGoyS4h5BYd0ydq2aic/J7i1vF7DNKUT
         4FCLjZogDxkY6EgTJZLcTVXVdKMNTvj5B7xIH+cN7tdaqtqakUAkTt4C0al0FJmzaB4N
         XbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793646508; x=1794251308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ikw8gEVhvcjahIQQLACyYzboGdzTL6Z1+RtVZ9m3bts=;
        b=WGc6TglcAHh+T9RXxsFriObF8StYX/ea7I9tp+EMbTu+F89yl3F2XpHVOjQRokyKJO
         ygXnx+Z+01khmzWu/HSamU6sdv46HBCGVPIqO16FYEMOzpzzhUVIVnv5RXDGCzxn4NWH
         dQKC2+wkucInvPFwnwTXf4IUFjCJjPP+tEpI5tgKvXcAn7gFY4GqdaJDNywbslkEc+YI
         CWC4Rj/Q9v0SA6RQ8Q5pUzOVshK/2dP037kGNz6BCpu+hHZmHEQoaO0+kZywc7w9S5Ml
         CjyvnoW9j1j1hwLXgHsTid9CuNQd4p9y6Jv4ydKVm0/8OZxNDVSbrkHv96YbtrVl1QnJ
         eX1Q==
X-Gm-Message-State: AFq9FYJAcZ0+5rn98GTx1lrcaq3ASXM6RtGxanj1qy3E0ypBKsqqo3Dy
	Av0FgNLRmjy/S0a93AlBhHr8UxFkuG4v6LOXe29uny9ttv+NjajrWK0Q5diy3nPv
X-Gm-Gg: AYBFou1FWEH+eaAhTTu7IaU+ZP53bX1CYDHt9bFXrtU8+eTx+sDJyEE++lfJzOkuVyV
	kpF6H1URlSMxP2C+L9tp9CkbMehBcfDqpvSbDa2IMv4xU11VtoXBsf0EuvaCFDdOereYZIHp+xD
	fmfAgjhVznPQDBVvVgI5trO43ZAYL+Qg+FQUyFGAPBLzZ+aJjTzbCtxjmD2WOfMiupEC+NgZSWJ
	nuQh1zyw7t+2hKQ1eLe5rgHREaU3psjtSfy/hUMDhjuNf0HeKyoLRs1zE76sGtzOdK0/gznTNHi
	VptuiL1kzRyGTAzmOaFcBxjFh1nquhpBusfeU0OzzJy/VEw9G6C/zO3KVooJHYUARer1yevErlG
	WqO9M98Vn2aE2dJ2/4VJIPKJGicr2GPynRApQXt78Pl5+9AQf4EsxcId8+HHQ83EF6ryDHhLMlS
	hWoqs8PpsIapdSRuWZm/1f0TiKG1ybKPQEERcPXJEk2sGPKqADus/lMUmB72yPlTDq83Bc5zFxG
	PbUAEhXqetDuLthBnGRj4Qi6MGzaGbKqOyobvcvvGFKAlC3qUKA9JpI+n+H7DgFYtPfOfHQb7f+
	dAmnG2BrHBwqUEAU9d3BfDs=
X-Received: by 2002:a05:7022:120c:b0:15a:4155:3d9a with SMTP id a92af1059eb24-1ac609808c6mr14709933c88.47.1793646508204;
        Mon, 02 Nov 2026 11:08:28 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:67::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1a9e2ed3sm34320847c88.19.2026.11.02.11.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:08:27 -0800 (PST)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v3 0/4] selftests: net: add performance metric reporting
Date: Mon,  2 Nov 2026 11:08:23 -0800
Message-ID: <20261102190827.989117-1-sdf@fomichev.me>
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
Content-Transfer-Encoding: 8bit

Let Python selftests report numeric measurements, so that CI can track
the performance of drivers over time, and add two performance tests.

ksft_metric() reports a measurement of the current test case, which is
printed as JSON right before the test result:

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
 .../testing/selftests/drivers/net/README.rst  |  17 ++
 .../selftests/drivers/net/lib/py/__init__.py  |   4 +-
 .../selftests/drivers/net/lib/py/kperf.py     | 181 ++++++++++++++++++
 .../selftests/drivers/net/lib/py/load.py      |  20 +-
 .../selftests/drivers/net/perf/Makefile       |  12 ++
 .../testing/selftests/drivers/net/perf/config |   4 +
 .../selftests/drivers/net/perf/devmem.py      |  96 ++++++++++
 .../selftests/drivers/net/perf/iperf.py       |  23 +++
 .../drivers/net/perf/lib/py/__init__.py       |  59 ++++++
 .../selftests/drivers/net/perf/settings       |   1 +
 .../testing/selftests/net/lib/py/__init__.py  |   9 +-
 tools/testing/selftests/net/lib/py/ksft.py    |  28 +++
 13 files changed, 447 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/kperf.py
 create mode 100644 tools/testing/selftests/drivers/net/perf/Makefile
 create mode 100644 tools/testing/selftests/drivers/net/perf/config
 create mode 100755 tools/testing/selftests/drivers/net/perf/devmem.py
 create mode 100755 tools/testing/selftests/drivers/net/perf/iperf.py
 create mode 100644 tools/testing/selftests/drivers/net/perf/lib/py/__init__.py
 create mode 100644 tools/testing/selftests/drivers/net/perf/settings

-- 
2.53.0-Meta

