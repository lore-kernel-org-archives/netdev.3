Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDBB44E052
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 06:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790577786; cv=none; b=X1727gKO4QPLxdlidIUrVNhfjz05XSQk2cPRzqq+sXGkzF+0u8fJMWPJYmjP45ikUCuuYlPe7EGDiChJk9okJDlBJ9OaZSjZZ0JCNA/m8Tyqu3BuS2/Gc9vMb101P7RFrPPWh/jvDcbIjanbMe3oFgD+nqAraXGal3S/AMOiHZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790577786; c=relaxed/simple;
	bh=y/c3vuZT9JK4EGUVD5FlxfoGZhyoXAmopRCdzFOZeII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ir00y/YZMwbNdtqGkha88MQz/khMoQaolADlMARp+6hAUEUk3jmBvu+eJHx1vfU6aQXqqE2Lur5c9zFHHYQvXsoh06uq9kncf4mQ/gCazyTV6UGvA2dH7SrDaDip6tQ+Opw0oMUlAoa+p+d6gj/AERwNLEY70WZpnE21YJZ5C+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SseIMWDQ; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SseIMWDQ"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48884b0219bso992781f8f.2
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 23:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790577779; x=1791182579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EleACgwDvShW2Hh8e1MDeVc2Sd39pZcCSkJXUD9MqEw=;
        b=SseIMWDQCk4kbVZrH/rV6/+CGE5BhaLjdwGVG+9R1HAqLdyJ6V03zEbK/S6i9QSM50
         ZvE+wCWkUbleTzjlW8exzYCPUhyJba0aXfODulFcCUdNIy11aqbMCV9GE0H336wP1F5d
         yP60YRUZ+nIM8+JBfHuJXQ4xj9EoJiwwDMxcwyZHIQ581Nzpi30XLWHGb+v5mWfDx572
         VwbsKI11Vm1KydrdmvWJvNXMhRhwYcpCLjpfuZatGkITvEC4GiJswp7IeZFVR464MLqB
         TZH3Q41rV8XO1obfUJDpNNiNDrvCUDD5SZWmoizO+Q2kz736lvyOyT1X0XqWz5h4kwkT
         9Vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790577779; x=1791182579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EleACgwDvShW2Hh8e1MDeVc2Sd39pZcCSkJXUD9MqEw=;
        b=krpD75FxK4mCsOLTYLzrLwtXOdZQL/FkGPsVpPti1gEGZk2AYNmm9lafy3mCCNbONJ
         DpmgjRR1BCtu+8sVShBFvLHVteGwJdC81njCu8NVmuQbRf+CzzeDt5haOXNYHHBmcLu1
         2YknoNzmZihGahHdZYBQrLY0zc2rmr9a5D6wFRqI3WjGvDA0mxDiqe05SKAK/+tZwrBw
         ursimYJJ8pl9n4Ns4z9SptksgHCoNpJ+5iPjXba3X4H4j6RZwpm/l5Y7jJdRN8WYm2dg
         P6sSZaWMtY5uhrxxUxHdHv798M5rTn5BWe/N8eh/yId1iOalz14dUMK2TsO8zr3k9WVo
         qh2A==
X-Gm-Message-State: AFq9FYLGpBB8LK7PogIjsTN8UrtuV6Q8lQ+W92RTDqvEvEVl8ih7gzKQ
	CFWEu1zHjY2Kb1AUq7YcR8yDxg5Qglxm8air3h9tzsfU0QGXVlu+gGWbLu2cuHap
X-Gm-Gg: AYBFou2p6XdttYwfRi2DAazGdT/Yxrm15hY3dStFyD35x8Nwa0845nIQZH5yKdN+juH
	ZrTAU9+CaIm71pDNGDJ3MXtfPHTYJ2kIT1oDUMZxhsL1p+ENRG5wV8EO9v01o1J3SGpnj92S2dq
	EiciUrVSYNO1+vtFTxHK6jVEHx5QZ7bGBjdCPAKUu0cJVdh6A/eOm31Z+uifvPdpfJTocvjTr7d
	Z5jYK3UsrwD3i+rfO4scSy4uVBAV/nJcwpudrP82GNMfCtJ1i59s6FLY6b9uYBVTRRYgvCT2rqc
	/rT4WlxDkm33IHWNbW+9GoP/1hTv2BuNorQ+glQiGsAqAiASoVitfsWtE90XYXu1uaqt/D0bDNx
	+jdgwMVXW6DeLqXkvDNJYqpKGhLojsKClX3C+cKXAAacOxP4O+RU0pJiSY6lDpDPUodmzFKT0a4
	Niaz6APM8PzjqQzw++XX2Xku4CijL9LXLJzfOqgD111NdiHAEMsbuVWgqxt+2kovtF6KVN2u5Bc
	CvrkDufoRHbEoCrQvDX/f9WD0mTmfWrr5KSeHI+qs02ta7IW6wMEfGaBEL29ecvIbJwMPA75PbR
	mtEOf0s8aKPRaMe00sRAu+7m2WFigFhVeLcPbYRQKMjs2yJJ3vYzVc+Q/SoKkCJus+nXIrV3+/m
	xBB7wJA==
X-Received: by 2002:a5d:6f1d:0:b0:487:1102:d697 with SMTP id ffacd0b85a97d-4887d9f99d4mr17976537f8f.8.1790577779202;
        Sun, 27 Sep 2026 23:42:59 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-acba-a601-4494-3582-465b-0eab.310.pool.telefonica.de. [2a02:3100:acba:a601:4494:3582:465b:eab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30b1dfsm26283196f8f.4.2026.09.27.23.42.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Sep 2026 23:42:58 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: netdev@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] netpoll: avoid blocking on the transmit lock in queue_process
Date: Mon, 28 Sep 2026 08:42:39 +0200
Message-Id: <20260928064239.32456-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260928064239.32456-1-kmehltretter@gmail.com>
References: <20260928064239.32456-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

queue_process() disables interrupts before taking the device transmit
lock with HARD_TX_LOCK(). The lock may sleep on PREEMPT_RT:

  BUG: sleeping function called from invalid context
  in_atomic(): 0, irqs_disabled(): 1, non_block: 0
  Workqueue: events queue_process
  rt_spin_lock
  queue_process
  process_one_work

Use HARD_TX_TRYLOCK() instead. If another CPU owns the lock, put the skb
back at the head of the deferred queue, restore interrupts and retry
after the existing HZ / 10 delay.

Fixes: 3640543df26f ("[PATCH] netpoll: fix netpoll lockup")
Cc: stable@vger.kernel.org # 6.12+
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 net/core/netpoll.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index e0cfcb05468e2..a3c94f0b3f764 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -166,7 +166,13 @@ static void queue_process(struct work_struct *work)
 			skb_set_queue_mapping(skb, q_index);
 		}
 		txq = netdev_get_tx_queue(dev, q_index);
-		HARD_TX_LOCK(dev, txq, smp_processor_id());
+		if (!HARD_TX_TRYLOCK(dev, txq)) {
+			netpoll_txq_queue_head(npinfo, skb);
+			local_irq_restore(flags);
+
+			schedule_delayed_work(&npinfo->tx_work, HZ / 10);
+			return;
+		}
 		if (netif_xmit_frozen_or_stopped(txq) ||
 		    !dev_xmit_complete(netpoll_start_xmit(skb, dev, txq))) {
 			netpoll_txq_queue_head(npinfo, skb);
-- 
2.53.0
