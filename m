Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1603A2EEE69
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166637; cv=none; b=OAeA4W61Rvp4rEsSEUAEGMcbJ5aTo2On07lamMkYZyMHMdg/74fMmbqOpuVTcp0LPoWBTHr8/w8CaNmhuX3a9aNgwhXthx4nVq9mFd0NkLMtm6B9WEAYnqT1MCMU/ZScEvxOzB5oT3mJYK+DY+5KceExzyW//UWOQXGd9EMzVwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166637; c=relaxed/simple;
	bh=097lIpU2xEmdx+YBb9L9JjNE80obm2+Aor02Nn4LrbU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IbwsdCWAYnaSoG+op6vt4Z/I2HsHtse9ohkcyCd8M6mvwCxgUWKyhxdyPUqnOe9eeuM/oss4qvRc9Gzn/YKOGkADZUZ1ljH08Fl7GDG6PoYs0qfSsX85joJ+65WBy/5ruoHRmyQ7rCOHn30FL4CyDEyUQDZCJYIrdZ4NQPUjodg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoQ6MlDs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoQ6MlDs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4681F000C5;
	Fri, 16 Oct 2026 16:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792166635;
	bh=yHpWNNua0AJeOthGlwDVs9U4hU1m9l5wVM7p8IB0ZjY=;
	h=From:To:Cc:Subject:Date;
	b=KoQ6MlDs+v9GyrdHkAQZykwP3+8UyK53/o7NSHce0hL/ThdZ6V1dhrE2gzrnUTaKz
	 DIVcxi3KGxrnq3/4tUcQduk7OJnRYq7GNOTL62S0RUDffpEtWCkGfHZiTZqSGyCfIg
	 QRcPfB+qqfFTWKgkYmZIXkxxQIYYSAppeA8Pqc0Y1WmgfOGpDMn6j3yKnJIbThjOoa
	 JYXDRqGZSZZ4G+9dR++11HvPOqUZupLGN1NYaqVVamOAI9QP8jL2d2UBa3em6IHGop
	 5/7GS68TyHEx3/rnqkFSWy2T0xRBLiVJPXing1vDASR32z0yJm4ir/20HinkfNGfUc
	 bewMbNyKBEYgA==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Qiliang Yuan <odys.yuan@gmail.com>
Subject: [PATCH net-next] veth: use peer attributes to set peer real number of queues
Date: Fri, 16 Oct 2026 18:03:51 +0200
Message-ID: <20261016160351.3022939-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

veth_newlink() creates the peer from its own attributes (tbp), which
come from the nested VETH_INFO_PEER ifinfomsg when present, so the
peer num_tx_queues/num_rx_queues follow the peer IFLA_NUM_TX_QUEUES
and IFLA_NUM_RX_QUEUES.

veth_init_queues(peer, ...) is then called with the attributes of
the first device (tb) instead, so the decision to reduce the peer to
a single real queue is based on the wrong device:

  ip link add va type veth peer vb numtxqueues 4
	-> vb has 4 tx queues, but only 1 real tx queue.

  ip link add va numtxqueues 4 type veth peer vb
	-> vb keeps nr_possible_cpus real tx queues.

Pass tbp, which is tb when no peer attributes were given.

Fixes: 9d3684c24a52 ("veth: create by default nr_possible_cpus queues")
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Cc: Qiliang Yuan <odys.yuan@gmail.com>
---
 drivers/net/veth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 38f263d4f06b406eaf0a801334272cd438386c14..ba8953fef979aac3868d39c8fb9b19becb47d8e9 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1924,7 +1924,7 @@ static int veth_newlink(struct net_device *dev,
 	priv = netdev_priv(peer);
 	rcu_assign_pointer(priv->peer, dev);
 	netdev_hold(dev, &priv->peer_tracker, GFP_KERNEL);
-	err = veth_init_queues(peer, tb);
+	err = veth_init_queues(peer, tbp);
 	if (err)
 		goto err_peer_queues;
 
-- 
2.53.0

