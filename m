Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248440;
	b=evms0HJf8ZILqrnVGU1LYVMbIMy91hl3L50KZ2sAmGh3PN+yvGyDtWLVRC160MWDixXh
	 8+n1emEfCByJ64IBIQ5x2t4CQwH0qNdRagI02fFwXKWa55SEcWyM55+Y8+x57/13eSAZM
	 UO3iTAQ7Py/D8IT4Z4zn0meVVx8J0nuFsvU82rZje6d8JugNAHXl7sbl858xcaDq5IXrT
	 GLjWpgBYHvvyjSH3m2vH/JvYNyee+NcLzxhg1I5alBTg3GjA5goSwXiOTS/AFIBu/BXOb
	 mcfkvWt1dfsuf4CIon/SS5OgNxs92k6qc/enIIGG+loPBdnltESOghIkttBgXxdB0iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=0zC4kg1d94XJgDxpm3y5aLE00I5P0Sif6z7h4sr0uIA=;
	b=UgHjMonTztV2T30zJrdFrng2h9uAvauKtpZnp/6JYtqZgmJYhw2KBsJ01MiS1Ca6pzaX
	 M2SUPGtEcgrdI+PT4/OcN0lg6370mawS2tMiG9XGIpXusVRgNHnO4B0595TJ5beNumgyl
	 i8b57OgRqECY6r3bSK7cOekFQvfUPByPyRIWJM3S8mv6bCOfVpAXt3X8rhtO4gbTaETPd
	 /BQXd4lIyxwxv5hRYJqbJCoCKaB1DLIKGZPv+sKSA3Lam9t6W2JaO4NE9hcqEfd0DBGWf
	 HcW6nu2OMdqgAFgr5oXEP1wY/zujunMHyFKyXlXdw2ZQNF5Omad4EePkuIjcoZRn4Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TIgEiMJY;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37AD606A325
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 18:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F37AD606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TIgEiMJY
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3acc98e3b3cso960043a91.3
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 10:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248439; x=1794853239; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0zC4kg1d94XJgDxpm3y5aLE00I5P0Sif6z7h4sr0uIA=;
        b=TIgEiMJYTwtZhSYQSj7k1sCWllUcHDrzR4eN7cj6pHvj8p6G3QjFvrdrxHi5E34jrD
         dRSJOszd27KfOqQqq/4yM1/qaAnrxzD4XbGS6LJ1Ew+87hyVciaDiZ456dLMQhZgNMKS
         aGzDzMpLMj0b1GidmFHmbj+58ooOJHbzj36K0HTqYMRHbaIBDyc7ptErkCRbhXmM6BFV
         jdkfRQQTOlV7uolNLn4EQ7wT3H1EL0MifYi5EBvKyFpDSLOlhjB16MKCsxxY5M/0lCME
         VvCr/fFqO10o07NMZUEC3dK9woIkGONwqLppvXS3rFuCNPwiSVzY3OMIj02Fs9UJOrLe
         2EjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248439; x=1794853239;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0zC4kg1d94XJgDxpm3y5aLE00I5P0Sif6z7h4sr0uIA=;
        b=Is5m2zI11PcwpCvV8Zx1NzHvDwhBqzpayD++nmFkUcFzYadtPuhjjsc9AFKP5oZMor
         +lyleFJCY+ryHZwt8m/SzuypRr1EmT86dZ46iv/v5sY7dd8B0+obVXLOeSUX2DWwOTYI
         KF5h+vt1LeB+iKXafWJcfAHlXAswjCnwIBuO5pKpAj+HfLj9RDpcQVhYYZLDtZL+489P
         ZP0/Qg6RgxP3l+VVeeB3a0MoHGegFeX+Ih9nCyf2/peAJS57Bbdp1YQPS7jtoCCG3FoC
         QfYbB7eg7n6Vo35eU+Oep3xupBSgGBV5zC9vM7wUv0Naou9ZlehblGRmLSbXwydJ6Ytr
         7X+g==
X-Gm-Message-State: APuU4Z/9R/xNn3/Hzwz6od2/MSfBryXtimeRwMp8i4yGAm01CWo+uM5g
	VeQsBldWY/RyY2vXGl/5T5iudi1Zk2Ywx45WJuHpXbqn8NkrB4eDu5TVXSh4QD+/R2vo7pj8yA5
	L2Dp7gyeWC0ZaAjYsIdsHEhicC8dJvE0MHS37lqM/5JWhoMgYAOqjLNpTrlz5TWPyFZN3gPya8Q
	O0Io27VNE6YLiuzQKWtAnRlgs13hUpTcJwE7GPDxB6JTxe+dJSTp7xqrpgQl8AkII=
X-Received: from pjbkn15.prod.google.com ([2002:a17:90b:480f:b0:3ae:b67:263])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1a86:b0:3b1:2810:dfdb with SMTP id 98e67ed59e1d1-3b166d1edf5mr442976a91.48.1794248438888;
 Mon, 09 Nov 2026 10:20:38 -0800 (PST)
Date: Mon,  9 Nov 2026 18:20:32 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261109182036.2910559-1-hramamurthy@google.com>
Subject: [PATCH net v5 0/4] gve: Fixes for issues discovered via net selftests
 and Sashiko
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	jordanrhee@google.com, willemb@google.com, przemyslaw.kitszel@intel.com, 
	nktgrg@google.com, maolson@google.com, jacob.e.keller@intel.com, 
	pkaligineedi@google.com, yangchun@google.com, patricion@google.com, 
	awogbemila@google.com, csully@google.com, jonolson@google.com, 
	lrizzo@google.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
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

Changes in v5:
- Link to v4: https://lore.kernel.org/netdev/20261029211634.2232784-1-hramamurthy@google.com/
- Patch 1: Also protect the single-queue restart writes with stats_lock
  (moved from patch 2) (Sashiko)
- Patch 1: Add a Fixes tag for 2e5e0932dff5, and clarify the commit
  message and the stats_lock comment
- Patch 2: Mention the ndo_get_stats64 counters in the commit message
  and add a Fixes tag for f5cedc84a30d (Sashiko)
- Patch 4: Keep queueing the service task after the synchronous link
  status update, so that resets requested during reset/suspend are
  handled once the queues come back up (Sashiko)
- Patch 2: Document that stats_lock also protects the baseline stats
- Patch 3: Explain the single fallback for both minimums in the commit
  message
- Rebased to the latest net tree

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

 drivers/net/ethernet/google/gve/gve.h        |  12 +
 drivers/net/ethernet/google/gve/gve_adminq.c |   4 +-
 drivers/net/ethernet/google/gve/gve_main.c   | 239 ++++++++++++++-----
 3 files changed, 199 insertions(+), 56 deletions(-)


base-commit: 787268686c64be60023743b527645a907e38ccca
-- 
2.56.0.455.g6c5a503b38-goog

