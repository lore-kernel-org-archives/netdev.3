Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E98A3C1082
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 23:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790032742; cv=none; b=MrCDM4gVp7/Wa3xXdOZq3YZQJZK49vrX2tvYebpaFerwyYTjRYVFlQpP9NYhCaZMqogc09af0qzUTBlEmo7/VP8cARgy5hRYtFpg0tOFxFSsgI6Aqjh7PAKzuLm6tLXBhV2bLF8JHNXsZFYpRd0ec39GfC9o2MmR2365nPyJ8vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790032742; c=relaxed/simple;
	bh=inaM+27U3/MAGiRQ3AimAn70uQMMSOfNqIIVPN7MUiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H4wzc072CBe9Sq3rksDxJrsf9ykLY/SyCrLodEcSKaQB4nknCB1jfBG7PHcMOrhGjcU0/2dp6A0sz/7WNQNJfa3WGjXH2cep+VEzP3V8p8m8ISoHmHCEkq+pjJaQppmxBWPbWCFNZS52RmY0r5DA7CKv4iDJGxL3OtBOPxZxVyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jx7nPxxN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jx7nPxxN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F131F000FF;
	Mon, 21 Sep 2026 23:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790032739;
	bh=kNPfaY6M/KntAfvIL3A0HWX6z6fFLRHArBcCfdRKn64=;
	h=From:To:Cc:Subject:Date;
	b=jx7nPxxN3Mj3q16duBShgN6ec4tUDc1lWCPjMp1j6yjr9uZxvzCo2m8awqzAFere/
	 JJ0yKJb2i/qaJU61C3hPS+4S91nZRs1NqEzoxV+gXPdgdDJPv7uxWn/930CK43WWj1
	 ya2sqzgZEIdvRr0+vrCs15cZY91eSiu+EV+i3jk9QfA3GZQgL7xw4QTe7QC0rT0Ynd
	 MktMZWQQihNc19RUz/FIpymMoYnGmrwQMDyOfyoboK9nzDVFmxe+oc/tnzPzeKCMYb
	 5X4O1HmbleYkap6QuvsmIAGr524Cx/ZO4JDoUemWxGkvnLPZ0Nw+Thu1PmHyMPMJiJ
	 UavyqQXrIiAew==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v2] veth: manage XDP program pointers during channel resize
Date: Mon, 21 Sep 2026 16:18:56 -0700
Message-ID: <20260921231856.1798630-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

veth_set_channels() tears down XDP resources for removed RX queues
without clearing rq->xdp_prog.  If the program is then detached or
replaced, those queues keep the old pointer after bpf_prog_put().
A later channel increase can re-enable NAPI and run the freed program.

  BUG: unable to handle page fault for address: ffffc90000256048
  Oops: Oops: 0000 [#1] SMP KASAN NOPTI
  RIP: veth_xdp_rcv_skb (include/linux/filter.h:779
                         include/net/xdp.h:696 drivers/net/veth.c:820)
  Call Trace:
   veth_xdp_rcv (drivers/net/veth.c:941)
   veth_poll (drivers/net/veth.c:986)
   __napi_poll (net/core/dev.c:7787)
   net_rx_action (net/core/dev.c:7850 net/core/dev.c:8007)
   handle_softirqs (kernel/softirq.c:645)
  Kernel panic - not syncing: Fatal exception in interrupt

Fixes: 4752eeb3d891 ("veth: implement support for set_channel ethtool op")
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - different placement to avoid extra loops
v1: https://lore.kernel.org/20260917153923.904124-3-bestswngs@gmail.com
---
 drivers/net/veth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 6ed3ee81153f..71227d0389aa 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1054,6 +1054,7 @@ static int __veth_napi_enable_range(struct net_device *dev, int start, int end)
 	for (i = start; i < end; i++) {
 		struct veth_rq *rq = &priv->rq[i];
 
+		rcu_assign_pointer(rq->xdp_prog, priv->_xdp_prog);
 		napi_enable(&rq->xdp_napi);
 		rcu_assign_pointer(priv->rq[i].napi, &priv->rq[i].xdp_napi);
 	}
@@ -1088,6 +1089,7 @@ static void veth_napi_del_range(struct net_device *dev, int start, int end)
 
 		rcu_assign_pointer(priv->rq[i].napi, NULL);
 		napi_disable(&rq->xdp_napi);
+		rcu_assign_pointer(rq->xdp_prog, NULL);
 		__netif_napi_del(&rq->xdp_napi);
 	}
 	synchronize_net();
-- 
2.55.0

