Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793308598;
	b=vKjmM0UdhtarZinA1cXD6ChosK+kx9Y+dJyJBCr2hPSBUqmJoUT/IGFVwHNmVypwf9Ds
	 Xj+p8VQWW01N7U/tPhIGwuhXLgrU7ZWj7jfVNGxpyXfqa+PTFzLcrpusIJ6DcBB9WqiD3
	 eLm/0JHrDlrnXvrL6UTyxLKatSidppDWukJE3nSCaOoJ608o+7TzmBC7WoSoQ6Xfa5geO
	 mS6ng2Z6jEpMwbfHs0to3YniA5fsi9LSJingKSgrRZ+FhQsF78smJKtzfYV7kwLn/bdYo
	 K76nUYGjj4sRsBeFGce2mw+9RfvlZMgCuNtKL7nmVgrOonTAc3g2FrPBwlsd3fKtVTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793308598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=Y5VoJFAtzQN0hpAVbuuN4XlRwqKEISFijkslQlRcjg0=;
	b=XwM0R96tzXNEfoj/FIFJjlE0tiIp62RcYQo8Ozr2/wADZTGPlSdu4Sq4tHIg3eV6o2f5
	 qiQI45602jNx8SBWpNwuc++z665mCLaLiF+nS2wlXyyiS8no8zsl52FDRL/IukikA0huB
	 9f/gU2bt8r2Ww1TCtZrKX6QIQQwcMekViNW92jgRklzVpbgkNbDV6cfo48xtcl6jZIlp7
	 tGmLUloZUQ2ecgbJC4XgrN+FqCj2wjLdo9WnftIVxu+IH7sXacdnTmECzRPHyFK79NXX8
	 PizgLc5k/SSDz07nPyJ910X7jmZcw5CKsqlLlxFQej2LnpFeTHbk7INWfRyI5tAy/lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="atZNhZ/U";
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB18F606A31E
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB18F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=atZNhZ/U
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd8b299b05fso15453a12.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 14:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793308597; x=1793913397; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y5VoJFAtzQN0hpAVbuuN4XlRwqKEISFijkslQlRcjg0=;
        b=atZNhZ/UYenKl9MgfO5lr4mCFScIBwntXXKKbhvgKGtqlXwccK1D9P/lDkCrP+QSFT
         Z9tJwyAKoSDWte1iCLZehkckSRknrdUTGW2HZWMO3JeiDPZeHEtwQKhr1A1xItiolSWb
         GXAaXRwgOTAZz3w+5rrBqqlCfG9/8JpzYo2dHSdKZHnDpkZeXTunNviYQ8egscW+HomG
         6J1VXxWr5XDX2+dtUz/6tHKcDyYcPBHaPdJcvUUqe6o2lCEVCp7pF7/mp9uU9ra+yb50
         KjruQdYv7mrOzYXzcX0kQQM6UadQVyp4/9T/1k1qHPTSUaMdQz49khQWt9Yv2fZTqG8R
         9OUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793308597; x=1793913397;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y5VoJFAtzQN0hpAVbuuN4XlRwqKEISFijkslQlRcjg0=;
        b=2vMGTbnekJd0OS25GAgvBVExJi131fwCZDPteZQnqtuR6KodIybJUhSof8LKVyt2OI
         nPT40nKHqJCF8SDs5GjjYNhbZtmaZP7yp3sEGHk83vRyzk4qPuPUtsOL4vsVh2m6yFoS
         ccHVxGBlbb3h+wSJL90QRiawH1jZ8kz3ziETxJO4p+d7k6rdl9Q6hvU+3OBHa8eGuEg5
         cVia3tmwyByBtRPVuvlqQi9kTIFdH3VmFQhZcEDxPa/tc5HOneUgpt/qw2+1PbFPFiJb
         pai0xEruP9gn+NG0h6Oo1hcagYEhaajH7t6wZ4W1XUbsh7JJYLIDwHZbE0bqyP2NePbV
         V2ZQ==
X-Gm-Message-State: AFq9FYIFDAC9ABqHM0EiIrRm61g91OPpn1azARSS8d77m2qst53z4Ekm
	JCQndWwjwn8EN6NoSM+jZCmaRzY/yqDoYOwJ+5mMJwoTal9BkwYJ6J7IuqzqsdsWbd/BisV5j+H
	HTUzHpOav4WhLlLzqGgCeirWe4/3QU4DLPZlp4YZuUJUDfrBkDyGCSnd1ijvqv1htiC8sZH85PZ
	96O7y08RQEm6g/qitZH9fyYHzKHB4WDcOAQFgcw/cS0aqx36drqoXovcei76pEIuA=
X-Received: from pfaq14.prod.google.com ([2002:a05:6a00:a88e:b0:89b:34dc:b094])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3b44:b0:3e2:8f5b:8ba6 with SMTP id adf61e73a8af0-3e9286461e6mr403587637.2.1793308596954;
 Thu, 29 Oct 2026 14:16:36 -0700 (PDT)
Date: Thu, 29 Oct 2026 21:16:30 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261029211634.2232784-1-hramamurthy@google.com>
Subject: [PATCH net v4 0/4] gve: Fixes for issues discovered via net selftests
 and Sashiko
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	jordanrhee@google.com, willemb@google.com, przemyslaw.kitszel@intel.com, 
	nktgrg@google.com, maolson@google.com, jacob.e.keller@intel.com, 
	pkaligineedi@google.com, yangchun@google.com, patricion@google.com, 
	awogbemila@google.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pin-yen Lin <treapking@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Pin-yen Lin <treapking@google.com>

This patch series addresses several issues in the gve driver. All four of
these fixes were either uncovered by running the net selftests or
suggested by Sashiko in the previous version.

The series includes the following changes:

- Patch 1 introduces a spinlock (stats_lock) to robustly synchronize stats
  queries (including ndo_get_stats64 and queue stats) against queue
  teardown and restart, preventing UAF and out-of-bounds reads. This was
  discovered by the drivers/net/stats.py selftest.
- Patch 2 fixes an issue where interface stats would go backwards when the
  interface was brought down or its configuration was adjusted. This was
  also discovered by the drivers/net/stats.py selftest.
- Patch 3 ensures the driver falls back to the default minimum ring size if
  the corresponding device option values are exposed as 0. This prevents
  userspace from configuring unexpectedly small ring sizes. This was
  discovered by the drivers/net/ring_reconfig.py selftest.
- Patch 4 makes sure ethtool configuration modifications are done
  synchronously before returning to the userspace. This was discovered by
  the drivers/net/ping.py selftest.

Changes in v4:
- Link to v3: https://lore.kernel.org/netdev/20261023204706.3112215-1-hramamurthy@google.com/
- Patch 1: Clarify the commit message and change the Fixes tag (Sashiko)
- Patch 2: Report the live XDP TX ring counters in the base stats and
  take stats_lock around the priv->rx[idx] writes in
  gve_rx_queue_start() (Sashiko)
- Patch 4: Take netdev_lock() around the link status update in
  gve_service_task() (Sashiko)

Changes in v3:
- Link to v2: https://lore.kernel.org/netdev/20260425002450.163421-1-hramamurthy@google.com/
- Protect all stats queries and queue lifecycle updates with a spinlock
  (Sashiko)
- Drop u64_stats_sync for the base stats and use the spinlock instead
- Save base stats in gve_queues_mem_remove() and gve_rx_queue_stop()
- Drop unused rx_dropped and tx_dropped accumulation in
  gve_add_base_stats()
- Fix the Fixes tag of patch 4
- Refined the commit messages
- Rebased to the latest net tree

Changes in v2:
- Add a NULL pointer check in gve_get_ring_err_stats() (Sashiko)
- Use local variable to prevent inflates from u64_stats_fetch_retry()
  (Sashiko)
- Add u64_stats_fetch/begin to protect base stats (Sashiko)

Debarghya Kundu (1):
  gve: Fix backward stats when interface goes down or configuration is
    adjusted

Pin-yen Lin (3):
  gve: Fix race between stats query and queue reconfig
  gve: Block invalid ring sizes when device options are 0
  gve: Fix link flap after ethtool ops

 drivers/net/ethernet/google/gve/gve.h        |   8 +
 drivers/net/ethernet/google/gve/gve_adminq.c |   4 +-
 drivers/net/ethernet/google/gve/gve_main.c   | 236 ++++++++++++++-----
 3 files changed, 191 insertions(+), 57 deletions(-)


base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.56.0.307.g5fe7bd680c-goog

