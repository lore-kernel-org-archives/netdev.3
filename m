Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3B134F474
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 20:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231078; cv=none; b=tBCjPwd3LHdi9p92Btq92BQczIP5XV8PaMDh57ULtiCjQRWearIbhfd0PFMdDTho7w7pXcG4hZTGfD4BIeTn/qxmNMGgGVfchKfO6RCzFuapbW3P1MzEzsYna4Lnfo/7L+a76+AR9vVoV/KO2+bm1GeF6ek+ox2T2TZMmvz0luk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231078; c=relaxed/simple;
	bh=sUzGzemmOMlLPOSjyXXz/Zn34dBQC9+ywRRqU2/+cd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ror4NcXzfNXYtNPsLyDWEL28HyZ+r+J4GOCIMntSbw7drOZSvKnonxANHk8J6xeMLtrwkVDB9w1eSHbknGdCxzizANeE36Fe3E/ftFmQ8cIttZO9fz7jFzTOlFkmGajyUeJWzANSGSJ47CYDJZv/oYP9OhqFkOroCOuAjVimuLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffSxOjfP; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffSxOjfP"
Received: by mail-pj2-f5.google.com with SMTP id 98e67ed59e1d1-3a7adbf1b3fso391066a91.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 13:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791231076; x=1791835876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U41rNBcTWGQxAOwbXmpLyKpedF2Pv6jvC3H7GKBBfc8=;
        b=ffSxOjfPEg1qHanJNUSEsfBCG8HibPhmPvlYGLi0iWIzQ1WCH7HEn0AMQMAmqqQ4vP
         Y/BP9wODtzEV/lTKJGB84JXetm58f+6ishxOYZn4gmK8q0dxz47lR9nlW8wfrD1T14D5
         WQ8KDworKoBDzLawDpY5j2Af3g5zbTNtmMvU4eIH+o7SjS1wr0v7XzhmHuw8hrlVcCoh
         VkphNTpZT02t+/PhWoHUzSEp5BBjKP4QbxGIvdE8Tk7m/RCMuSQ2pjuV+HGsFrMTcb25
         ytjrUPRO92Aq9NwZoTiMf6d/VXDc5wMzOfK644hAyy2sIGNqYXnmdDsIjwODBKormlbr
         ceIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791231076; x=1791835876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U41rNBcTWGQxAOwbXmpLyKpedF2Pv6jvC3H7GKBBfc8=;
        b=lCy5qtMK+nGZH1N6TpyMbZBKWkZVxx8hbzA/m3ncNtCJFFUGZKnb0it53uQVbS3nQe
         ZqzN0x5qlkfqrk9uCS2rxQR8L5/I9l+R9/mCSgbV+Q7Cq1Lp42xyGehgGqGVIorgp8/J
         q+pBUb0ojb5s9PBjikWseOh9PHNMrJYmwql6DZRnbWoY25c8L+fCVwgKIBshLjRq9qSP
         zjGTaGWFjrtCHWmE+1eSD/bMjkyy2sBQ9HFGsJyREc+u+gEhcvuQDYFvT/H5yoQimRZV
         v+aUPtUF1EWdSiE5LQY+b3AEtVhfXZ0Bb/ubGq3z+D5Jm2NzW6fkg9vNyIq7o5eMJso0
         xbgg==
X-Gm-Message-State: AFq9FYJuXXVeOJTgfUay/gTBFBYRLLsAx+4y+8Dh3mtgxSpt8H/cI38c
	rEmOMbJ6Qn1oas7xXJwnE0CbK4oVk7AJvipWKxgIuWi191fhKGnc7ebwAqXxd3ne
X-Gm-Gg: AYBFou3qzPLWoHaAQuLmO5aa2AVC7nhfwRXQkHH0dEL5nHOW/TlvJutvE6WcnQ5Vu+V
	T8qqeBtgOUR9D8rvWAM9CdUlDwCqrjhjq1TlV8LmDq6vKmfyccndVp/3jdkoKpscHvqHb5WT7UR
	+mHApwM1w7iRg/qGtVq5Kfyq6b5w2G+NUG4gPjeEbneHCNJtn173OjEVuVBlCciC1lxC/ZVgXQH
	68ljGIAxVmiZ2kohX0ubkC8KxSKn0WlFUTA2mfcQQahg1fWadyttsnrAoZO6kFMRXOjPnMqEsON
	JKgVlJsmtF/c7zx8qAeDtKR+D3D48Ht2ILINP9Iqlk/ApOWCXnp8TltCFbtkxP2e3R87uwcWapI
	9NSWVZdNgb1Y2OLs6vAAlsNJWpMV5uLxwA4l6cmOh8s+i4ESLDaLhH5t9efwCRoO1syHqodBeme
	E/4JFDotJavtKULpWrUoQdXhqO5OXzfRs2TTVEFxX1eOPKbQFVI1Gvaw/wxoUfb6NNo2dHH90Wp
	5A=
X-Received: by 2002:a17:90b:4a48:b0:3a4:85c4:68fc with SMTP id 98e67ed59e1d1-3a7872b2480mr8013503a91.29.1791231076004;
        Mon, 05 Oct 2026 13:11:16 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:41::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cce6d334cb2sm1401800a12.10.2026.10.05.13.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 13:11:15 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [RFC net-next v2 0/5] selftests: net: add performance metric reporting
Date: Mon,  5 Oct 2026 13:11:09 -0700
Message-ID: <20261005201115.2690830-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add timestamped observations and producer-defined metric policy to Python
selftests. Add iperf and kperf performance coverage.

System monitoring can live in either place:

Selftests:
- uses one KTAP format for benchmark and system metrics
- provides system metrics for direct local runs
- lets each test select the exact scope and devices
- adds kernel-side code and maintenance

NIPA:
- keeps generic monitoring out of the kernel tree
- allows collection to evolve without kernel changes
- requires runner-managed test boundaries and local tooling

This version keeps CPU and NIC monitoring in NIPA. NIPA runs each program
in drivers/net/hw/performance one subtest per process, giving the runner
exact monitoring boundaries.

Note that we still keep metric aggregation policy (ksft_metric_policy)
including regression boundaries in the tree. If we were to move it
to NIPA we'd have to have per-metric-name configs or something.

NIPA changes at https://github.com/fomichev/nipa/tree/nipa-local-hw-metrics
have a few examples. git clone & ./nipa local view will start an
http server on :44109 with two sample runs.

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

Stanislav Fomichev (5):
  selftests: net: py: add timestamped metric output
  selftests: net: py: add metric policy output
  selftests: drv-net: add an iperf performance test
  selftests: drv-net: add a kperf runner
  selftests: drv-net: measure devmem performance with kperf

 tools/testing/selftests/Makefile              |   2 +-
 .../testing/selftests/drivers/net/README.rst  |  57 +++++++
 .../drivers/net/hw/lib/py/__init__.py         |  17 +-
 .../drivers/net/hw/performance/Makefile       |  13 ++
 .../drivers/net/hw/performance/config         |   4 +
 .../drivers/net/hw/performance/devmem.py      |  99 +++++++++++
 .../drivers/net/hw/performance/iperf.py       |  27 +++
 .../drivers/net/hw/performance/settings       |   1 +
 .../selftests/drivers/net/lib/py/__init__.py  |  15 +-
 .../selftests/drivers/net/lib/py/kperf.py     | 161 ++++++++++++++++++
 .../selftests/drivers/net/lib/py/load.py      |  24 ++-
 .../testing/selftests/net/lib/py/__init__.py  |  11 +-
 tools/testing/selftests/net/lib/py/ksft.py    | 159 ++++++++++++++++-
 13 files changed, 571 insertions(+), 19 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/performance/Makefile
 create mode 100644 tools/testing/selftests/drivers/net/hw/performance/config
 create mode 100755 tools/testing/selftests/drivers/net/hw/performance/devmem.py
 create mode 100755 tools/testing/selftests/drivers/net/hw/performance/iperf.py
 create mode 100644 tools/testing/selftests/drivers/net/hw/performance/settings
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/kperf.py

-- 
2.53.0-Meta

