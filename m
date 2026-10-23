Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792788430;
	b=nozIL3IbyyPl7gKk/myBItYmY1NUIsW9KcZpYvIZfTxuuGgINR7MCBnukl7xqhq1h5Cf
	 5FjcNet96r5IpMbIJSx/IlkFmYKbU5bQzvLdIOSPsNXzoQU4QZJ26IWWPL9rBf8kh4MLS
	 aaLHpICK81l03USUb9RMDEsokH3AyJCe3Uy2q7yeKnrVVfczZIYiTcfwOb23BWzYFWNRJ
	 Za5CiyUQdPKaESZUhkRSYBiqfyc3vLoc5whb7qBLzWCcc6UVF2NCl5ypYZPSJo5kZhJVL
	 yoc3N6mxATrq+gMLt5Km/Y2XsZEZ4QM6JbTa5lcH2ZjsLmF0QgiqqrXxw283qeoXFyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792788430;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=IZesByycO+LPzFMOrxyzTveWeZ5n5x8B7eGfO0YnZQo=;
	b=45DmGxwkqntx328q68RC4huOEQl4s0Fgr087Zk0eKLuY3e6ifp2RiiAODEniqYudHY5N
	 yS/dlJ/ikmeDBKaCscQ2eQtpi+RcE6O92MUoTFj6n0BeTz5axA/Ig+YFX7jat5byzlZdf
	 /mVP6U6Y2qQPfRjLXaY4Zrr3HtG8JYe4jWBqNEbyILG+eXRQBG/4jOO2zJx9vxb4JETRd
	 xt+71wJYPvQpToOWRh/yvp+mvoQZF/24eiv/Mx8hraaHEAZ2+KnTbvTgmiFA2guB6vL8i
	 ufgVLH2ZxzGdQNsQj85IR6G30UHT5UXYQPnfw/+5/8nz4hinLV2dPvDfsCEZ7mSHkfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="V8c5K/e+";
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA0B606A320
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 20:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BA0B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=V8c5K/e+
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-89fb6a45c48so1233645b3a.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 13:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792788429; x=1793393229; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IZesByycO+LPzFMOrxyzTveWeZ5n5x8B7eGfO0YnZQo=;
        b=V8c5K/e+wW0CaDapSsM1QWQpymmKnF2LTar/d5t91pBrzlY5j4HFDrApsLX0aNwNik
         yKgazbyKwgnMV7P6EBb7yPPqzgq4TVV1P1iyDkGuPYoGFxHD7rumtJOwcbAY8AaVTTjo
         EUCri0Iw2Ka8YitLlEopvJWuDf4MU71+79rmqIk7p59sMQLtttTViPXmEdX+oAuQXse8
         R7yFjcdQnRIgv7iA1qE/zUOl08ys5xyPfAsYihPCdeNJpqt4VNoyICVAYKki798pa0rh
         +zOCIE4kYf110o6APAkqA7NAD7UaX6jf+PkshSCA5ea9ziUGJh1HzX1FFe2IAzZm91TB
         vbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792788429; x=1793393229;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IZesByycO+LPzFMOrxyzTveWeZ5n5x8B7eGfO0YnZQo=;
        b=Gku4ThF1nu5hqCTsaqgtsU+CQa/NSUAYjrbuNAz3o8EdQJw7m7aZ5C6cS3Xq1lY61+
         vEKJbMC1n4FakayUjp1dBtGuw0dQ88kN1ztXCs5+WFXtjRaaflMyoxsbJEc9xq5LuHBg
         o3GIRMMyQX5bfoVgGm/8K9XXnGoWgiAu4yfikKrJDHo//I+KZSfpUeG87r6AU+lM12wq
         krG1BhXz9RR0uwVA/78szWoW5RvCTZunvV6OqqUmcetkt6KPCNVXOjUvjmLrKcAC5EwX
         hZeg2fuOT8eMBzgtRHW8/HoEGSG3kUax1+lzsEfUJSchhPRHfMmy3hKOJudpSYXKjKri
         PvOw==
X-Gm-Message-State: AFq9FYLOZjURMkQaLrGOZKsh+9cFarTdDkK7qv0jdqbC6TmNVHWJymnB
	FUhqFJn59CcAzeZeNsAuej6fvIYJkVe8jwoAjKyo0C3e7Plxe1Ob0MSXCTuNOwqM6zpmJwVENWt
	sZUH+Y8PrD/5xP0Z9eX0P/6pfNtNHM9W5y+5qyo3bLosWA3QfkVaUCgMAH6KC4hfxJAoXYOG2pO
	yTiOYsvJ1FAtE4pHw5xAXrZcQHnNKKdSmyqYgEyEfGxM6Ps5mD/I60S5m5Sm4O4kY=
X-Received: from pfww6-n2.prod.google.com ([2002:a05:6a00:8886:20b0:890:ac21:250c])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3f95:b0:3e2:aa08:8040 with SMTP id adf61e73a8af0-3e7cd4f4b9dmr123609637.46.1792788428424;
 Fri, 23 Oct 2026 13:47:08 -0700 (PDT)
Date: Fri, 23 Oct 2026 20:47:02 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261023204706.3112215-1-hramamurthy@google.com>
Subject: [PATCH net v3 0/4] gve: Fixes for issues discovered via net selftests
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
 drivers/net/ethernet/google/gve/gve_main.c   | 179 ++++++++++++++-----
 3 files changed, 148 insertions(+), 43 deletions(-)


base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.56.0.257.gf7497c7d27-goog

