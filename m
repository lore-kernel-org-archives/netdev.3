Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E883B101C;
	Fri,  2 Oct 2026 09:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790934157; cv=none; b=q+/JaYz6XL56x+6MCPX87GCc/15C/rF8u/rH1yFsF3lhu+EOyOz7PC/LGR/E910Zk1h791LXpySQKzfKUWJOiTthgXCQXAnHSfSYhlGpsDYCHkIpSbrG7Ht0cUbSPLYFLzsOrmLZLcslAMJ79ZRz1AaIuVWD7QAecuzEhRXb7ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790934157; c=relaxed/simple;
	bh=sSy+NWMa33/tkN4TpsNgNIHAGb7MtKxz/ue/3WmYi9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTJaHO1FHahiu9M7Pd3mwOV/okgw+pnydCfjX9wN/5MBm+haw8ST2tLqpprjLums/UDQqHk7WQ5Mq+WG9OVvK/LwgdMJq0RjDR55IgGwtKZIDN7+J9Xqi0GriOzPasFTfcxhdGxemKqctimaQkBJ7ethuCaQ9Q0i2E+5g/yfivg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=QumN7Hpk; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="QumN7Hpk"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7C93DA4ACF;
	Fri,  2 Oct 2026 11:42:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790934145; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=zJhTWYUd1CV02Xl4Ex7AtiljOq50ZWSv6rMaaYTIlH4=;
	b=QumN7HpkqjGQzfzr5ZRoMHk21tJ1JmwBRilzh39A4Rc4vTiq5G3t+gsxNCaf0H1tDVakjY
	Y8hv/VBlWmo9b2JkcIzBg54k61Wn3jArMR4+4USUxPqUpBXURjGoOY8xGX4w2VdywzEUut
	NyGi55VwlnwyXEl7NGtc6I85nIXVdRRyArhPntuJN/MyYMGnsAfECow1wlVwqvovnFYV5U
	AlERhfaMm5G0cjI61HClQa/ntSsOrZIb7IbimjMbfmIb48JcvBsVO73wTdLceQdv8GkIzr
	WQEvr7jqApjWehPuVHgHarFuS/Ae1vfkppapc3GObOds7C2LDMkPBLYQKHrJCw==
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
Subject: [PATCH net-next v2 3/3] net: reject a netdev that implements only one hwtstamp NDO
Date: Fri,  2 Oct 2026 11:42:09 +0200
Message-ID: <20261002094211.2350702-4-nb@tipi-net.de>
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

ndo_hwtstamp_get and ndo_hwtstamp_set only make sense as a pair. A
driver providing just one gets no complaint today, and the mismatch
turns up in user space, where a set can succeed while the matching get
fails.

Catch it at registration instead.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 net/core/dev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index ca7f4844cc40..db765cb5811e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11462,6 +11462,11 @@ static int netdev_check_ops(struct net_device *dev)
 		return -EINVAL;
 	}
 
+	if (!ops->ndo_hwtstamp_get != !ops->ndo_hwtstamp_set) {
+		netdev_WARN(dev, "driver implements only one hwtstamp NDO\n");
+		return -EINVAL;
+	}
+
 	if (netdev_need_ops_lock(dev) && ops->ndo_set_rx_mode &&
 	    !ops->ndo_set_rx_mode_async) {
 		netdev_WARN(dev, "ops-locked drivers should use ndo_set_rx_mode_async\n");
-- 
2.53.0

