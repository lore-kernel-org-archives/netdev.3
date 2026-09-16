Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3655D3559F8
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 19:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585478; cv=none; b=dJjNfGwZ3z90jTxTojbme9eAMfZdFL7cFghBGfvJOJsg+ZXf6CJvFIffP30b2LEn9C8428vyg3MKrzN2Z67VcO+/OM2YQ40vpcM8QHUJMBqevatqeHxUapIZHhG5urXQ9jQPtm/LwCaxD85PSJSppTmYUrYBZnj6946C5D2wocU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585478; c=relaxed/simple;
	bh=AqLp0O8pH/U0YW6iBwX9XTz72KkxEZmRXDM+vc3yr7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ooIR5+93MLmWC4HX8CYIesM28xQnSXh3DRzuwYQWbei5q9BvFVT12ToTX2ijkDgws5NzfcMQ/Ya7k/0+fJAUqqY27IBpjBDA4GTuSQG3sP1Yg8jDlImNQip/yJT84pMJQ5TiL2msiTFhF4semPS4DH3tLg7Q5GVQn7PEjDO6FEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAsc95U+; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAsc95U+"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2cb3f5bb19aso143095ad.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 12:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789585451; x=1790190251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PJr3M4Fn6AOsxn2PsFJrDkKi4bdkHxqrhVJmMIc2FfA=;
        b=dAsc95U+AEXBpA+bnxJwjyj0ENxZacmy92clEOLk6vT0ewlxRobHf9UqMNeQiQ8XJb
         CiEpMYGh4RrelWBDyK1BIYPFQBvdP3ZyyNoTQYqsYJEFml+m/ktFKEvgN6L9U+QLS8/s
         8h8AhCS5EP9MIm8VEau51t/oUBD5qPTd+KJOEvrVLoAJMIU2lXfuoW2xsm/moYH3XJll
         OThgjcDooCQDd87bzCT6TCstil1YZGWLc5JQsrTqjPv5cMEBHKzoPqmWfZCMM8HA80Dn
         a2EUkqzUH3atQCTSK1goBTtj4kcpDY1EP99VakXnGS1K4G1Dm/9zgqvK13Q4M3t5C/Py
         ATkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789585451; x=1790190251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PJr3M4Fn6AOsxn2PsFJrDkKi4bdkHxqrhVJmMIc2FfA=;
        b=dCsFq5aXJBZM+wrkvuxJ/gFOgL+6gpM6UsFHhikbjvPbxLb7aimz9c2koHYFmLHH8w
         w0oensBlDHn+939Y51DOXiVEOgcSNv2vurweFI4hHB/bpoog/K+mYWtk6PDb8oAKzLeH
         aeZTSCHLyalWP1vmsIbOKGyPBEx9McoIbrkXBwqUmkWT9SyJ5FFy8ipnm04zCA60RQB6
         DsroxmnfZFQr9UDK9qXNk8x1JZ0SXKC//d6Er7V3ySnIQrwPNskeJLDutCzPg5trSjP6
         njaVquloDV9JeyfEFe8JSJbOOngPFAGPHBLNqd0pE2jP8Urt2L6FQowPmLltLn744CN9
         xAbw==
X-Gm-Message-State: AFuF++m6YhujLRBNiL+Flfm48KL2t7eoe7m/Zxqry5R/FfSIidlU0Sx6
	e8UtcjsdZY5+MZjMMaZcZ2aE0FNvWmPAY9zBSgSpiZo/boffNA1gBjZ200+/Ixzv
X-Gm-Gg: AYBFou2Lm8AZni7maxw/ZKNphlB99+6nWmQ40LJQMW2LfV9Z+1wcs8gR7k6g/jCc/ar
	Jc2NfdXtA3T6rht2o3Ljj51lH8F5jX41LM4HuGX8J4LkA+5TF46hWPw85Rhy387UlNoicr+pRMs
	XFcXDxGwCN1/9gogzMx3GBjEtzLm9Jov0w/wQfA+E49PGLS4uaOlLjr6tIGina1xTXwUMMuIEg1
	xF/B/JS+eqpwpDiRt21gy3p3JVvJ8ungLUy9q6b2lWA//ZBikZVNimU34zEL9/eepQjhKtDeVPZ
	O83cYF99TEq05Wos2mLqCIeZpTdcdHxvLfNMaeL1wptBKxs4ohDXGkHfwdYKQp3ZNWn2RxFFsbq
	1TnNb6K9BPsuIcKPs1Q2o7+ABcIIvJf3TAxUWzAI7AgZTatI9G+Y/J7m9d16eP6mzsrMGtXNZpO
	pdqSb9aGGccM/DtqhzzZJ/9yMKgjYuMViS8+N3GDbcmI6yp5vPonrjlDf8LCUhbTb9
X-Received: by 2002:a17:902:e54d:b0:2dd:76b1:3509 with SMTP id d9443c01a7336-2dd8e4109f0mr79071425ad.14.1789585450796;
        Wed, 16 Sep 2026 12:04:10 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4e::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89eb5618sm16237315ad.32.2026.09.16.12.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 12:04:10 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [RFC net-next 0/6] selftests: net: add performance metric reporting
Date: Wed, 16 Sep 2026 12:04:03 -0700
Message-ID: <20260916190409.1222272-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sharing as an RFC to get the feedback on the overall approach. Current
model is where the ktap side drives system monitoring and nipa only
collects/interprets/draws. Another way we can do it is to move system
monitoring stuff to nipa.

ktap-side monitoring pros/cons:
- pro: same format for system vs test metrics (same parser, same
  aggregator, etc)
- pro: test controls when the system collection starts
- pro: test controls what the system collects (say, on multi-nic
  machines, we collect only the things that matter)
- pro: local runs produce the same output (and we can add some tools to
  produce the aggregates for local analysis)

- con: bespoke metrics aggregation format defined/exported by the test (but
  I think we still need it for non-system metrics regardless?)
- con: extra code/complexity on ksft side (although it's only SystemMonitor,
  the rest of this patch series still relevant)

nipa-side monitoring pros/cons:
- pro: more code stays on nipa side
- pro: tests don't care about system side of things, it's always
  collected on nipa side
- pro: each nipa runner can define its own policy/thresholds (although,
  why would we want it only for the system side and not the test side?)

- con: separate collection & parsing (system vs test)
- con: local runs need nipa if we want to observe the metrics

Stanislav Fomichev (6):
  selftests: net: py: add timestamped metric output
  selftests: net: py: add metric policy output
  selftests: drv-net: add a system performance monitor
  selftests: drv-net: add an iperf performance test
  selftests: drv-net: add a kperf runner
  selftests: drv-net: measure devmem performance with kperf

 .../testing/selftests/drivers/net/README.rst  |  56 ++++
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../selftests/drivers/net/hw/devmem.py        |  70 ++++-
 .../testing/selftests/drivers/net/hw/iperf.py |  21 ++
 .../drivers/net/hw/lib/py/__init__.py         |  19 +-
 .../selftests/drivers/net/lib/py/__init__.py  |  18 +-
 .../selftests/drivers/net/lib/py/kperf.py     | 148 +++++++++++
 .../selftests/drivers/net/lib/py/load.py      |  25 +-
 .../drivers/net/lib/py/system_monitor.py      | 240 ++++++++++++++++++
 .../testing/selftests/net/lib/py/__init__.py  |  12 +-
 tools/testing/selftests/net/lib/py/ksft.py    | 174 ++++++++++++-
 11 files changed, 763 insertions(+), 21 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/iperf.py
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/kperf.py
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/system_monitor.py

-- 
2.53.0-Meta

