Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7217347254D;
	Fri,  2 Oct 2026 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790934156; cv=none; b=PDfMgm+o2Ofj+FrWVzqhmXGsSGt0cnjmPKCF42dHcoGz8b6BOcycagPQBt4uQ7mcA9tfAxO0fA+0vzNiqa8b0W7qeKm8kZad+fQVpj2vGw4f1yJoTwMwPz9EErMGLYwDBpik6NJ8gQQKU8DDgSg/nh8PL5KQih8n0zJLQcjfwA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790934156; c=relaxed/simple;
	bh=D4n/jC9B4OsZIowMwYOinvRQqK6TBicIReKZ6v0d2dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7rcSXTq9SQZs2unG6vn4Ev8wFvYxQKWBZQTucvjZ6hOoZDX7OQFwvgx5sOrQksJ9uT7gZZjE9uVFYzYf4fG9jDTMQzchU19X287HaVzi5RsQVpHpEJ815R0ALT/V6XgBc2CpnAZ+6dVVnBwYosoItM7C1FMr29O/NCixqs93NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Ygrsbo+z; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Ygrsbo+z"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A47D1A4AA7;
	Fri,  2 Oct 2026 11:42:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790934145; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=mKPcFRIiin34kpiS50/ng8xqh2E/9ekM3WAmWy3OGwA=;
	b=Ygrsbo+zZExjC1bnbnYzn1zg3SEWIIfYiW4nfNo16vUrrRDeiGtVUJbAZjKZiUsrjW8zbL
	V+f3+7LZAkUpKYap51Oisnf8pKBXG1b2VcvX0XgMvYVGQApCq3IXqZ8AjDNDkISuM1VXfj
	Kh6OLfATkd5q0LWWm8+tdtvKvIPq2D0+MENBNpQFi3/Yz/NFUg2javyWA2yI0GN1Os3x38
	cxpduNLAX+VbsGM3tpnTigvZHVHYRXSvJE/fA9oQ6KfmwFKbcRspZm8/v6qsGucvfV/rHh
	TGY2akVcPUntsT8+3iz5INQ5/V+0gus3e+Cx2p50QN8Plq+ZgLriMI9hbs9m5A==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/3] net: reject ops-locked drivers without ndo_set_rx_mode_async
Date: Fri,  2 Oct 2026 11:42:08 +0200
Message-ID: <20261002094211.2350702-3-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002094211.2350702-1-nb@tipi-net.de>
References: <20261002094211.2350702-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

ndo_set_rx_mode cannot sleep and runs with netif_addr_lock_bh held, so an
ops-locked driver cannot take the instance lock from it.
ndo_set_rx_mode_async is the replacement and runs in process context.

Registration has only warned about this since v7.1, long enough to find
the offenders. Make it an error.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
I grepped for potential offenders in the tree using

  for f in $(git grep -lE 'request_ops_lock|queue_mgmt_ops|net_shaper_ops' \
                          -- drivers/net); do
          d=$(dirname $f)
          git grep -q '\.ndo_set_rx_mode\s*=' -- $d &&
          ! git grep -q 'ndo_set_rx_mode_async' -- $d && echo "$d"
  done

but haven't found any. net-next testing will show if I missed something.

 net/core/dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index a44bcfc29d54..ca7f4844cc40 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11463,8 +11463,10 @@ static int netdev_check_ops(struct net_device *dev)
 	}
 
 	if (netdev_need_ops_lock(dev) && ops->ndo_set_rx_mode &&
-	    !ops->ndo_set_rx_mode_async)
+	    !ops->ndo_set_rx_mode_async) {
 		netdev_WARN(dev, "ops-locked drivers should use ndo_set_rx_mode_async\n");
+		return -EINVAL;
+	}
 
 	return 0;
 }
-- 
2.53.0

