Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59791442118;
	Tue, 29 Sep 2026 21:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790717576; cv=none; b=c1gdTLX44/feyzLWWEsBAC4bPEqwKBNscRAblY/Q+bPJidRa7ovWn/I6IrE7FPVjUCT9kf6xAHvy0GL2gYskqVf1rFlNmR//pI33dwUgimKEV9UJxK1SyMDMq+pVMVbaNiHj394oDprLtRL22f7iwe1+wOuv4YpTwak2LUPBV5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790717576; c=relaxed/simple;
	bh=Gz0tq5z0tYL6w1FoB8hKRa5wt+H1xRw+DzucfCFuZHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QPMa6TFqFzU+l1cf+Kq+2a2O+4Xbj2gUhNJTGqAMlK7Q6G0gf395JVZr+4ZaiptkTPGtL5fL7E2FGn+umURSlgjcqP/YWNeHM+V+mmgPXt4OnlqenX7LPcFL9swwNjlsDY42vc8+hgJUtnH6yWOp3grOKxglznFlXqvcoRp352I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=pf8ayj1q; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="pf8ayj1q"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C900AA4A3E;
	Tue, 29 Sep 2026 23:32:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790717569; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=C5sA6T/N/P0XZDDCgSswximuliRtR6jOs9qXovKn4R4=;
	b=pf8ayj1qNKCCLCLQjkpsCn1Cj1UOAFjhXeB8hm2H7yWkvADo6uvwYgyazwhGVrDsMgYfR9
	s2zko/okSNALEG7WWRBJ3JNAjZHJRFiwYGuzFleOCOAGMEH6Yh6S+rMr364/Eh5Nbmrbsh
	iFQchTd2ELBqeQI4KPNET+aKRnaBLAPMUt8jx0dQ+OhpQo4HP7A/OU7YMKxHIXvOsqgrNK
	mkrM2VDp2IO/Aamf3rYzNNbX4k3lC61EfZtNaRlODYhVYs/ByMNpMaMSIf9dqMl47WzQC/
	iejBa9Qu3KV0InrNUZGQN81n/ceVDhLuAPVt1uYJq9Roq1CaPgEe3sQgCUAo0w==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Nicolai Buchwitz <nb@tipi-net.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: reject a netdev that implements only one hwtstamp NDO
Date: Tue, 29 Sep 2026 23:32:32 +0200
Message-ID: <20260929213233.1555567-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
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
 net/core/dev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index f660fccfc0db..574fd0ba9080 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11447,6 +11447,13 @@ int register_netdevice(struct net_device *dev)
 		goto err_uninit;
 	}
 
+	if (!dev->netdev_ops->ndo_hwtstamp_get !=
+	    !dev->netdev_ops->ndo_hwtstamp_set) {
+		netdev_WARN(dev, "driver implements only one hwtstamp NDO\n");
+		ret = -EINVAL;
+		goto err_uninit;
+	}
+
 	if (netdev_need_ops_lock(dev) &&
 	    dev->netdev_ops->ndo_set_rx_mode &&
 	    !dev->netdev_ops->ndo_set_rx_mode_async)

base-commit: 014d795c73837ea2339a4ea8e8f82c6e959b845d
-- 
2.53.0

