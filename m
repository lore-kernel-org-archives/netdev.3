Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721FE472F73;
	Fri,  2 Oct 2026 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790934157; cv=none; b=CR+CpCxd+w3Vd2QXR7xfzOYtHTTrLa7EwCQejp2tJVVJwDlr5OHM68JtaRvhCgZzeriQozIFFitMBlxd6bjAgkMtALxdRwhY8TDG30rhS/w1D8bE1w6SwL06lseojgrtmudrfwTuO47dlM/BA+hoBarZL7KgZDG6BVnh9nUC5Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790934157; c=relaxed/simple;
	bh=HSXVQwgaC28ZJWP9n086IV8cGeRyI/HoFAH1kz+UIRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YW25heqF73uSHnyncntPTP6evpPqk7PUFoyZu5FAUc/yGRxS9ZdCQxR0OpcY2uLQ9+qTezxE+ll+2DE1TncPIWW0Khd5l3Zw7boGjCBflakXcU5tfOTdaTO9px2dvPyTgWUDH3RgHqbnfbfZLQnDk4OzDqbrAU5K/aiisnHg2Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=dozjey11; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="dozjey11"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2ED20A4ABE;
	Fri,  2 Oct 2026 11:42:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790934144; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=p364ds1W8e41WipqcxVfTIL8keYU5iZrv+QiNxkLURE=;
	b=dozjey11kNbCOZFpb8hyfCRAmYnKiREEP1gtinLJGUZ0S0OFdr3UpMT3wEyEa5dFMUuHw2
	FRMc2ZZ6mQXD817sT3VFNpHf1Z7btG83Du4BcaOeBhwWBynhumFZGX3A5zzaLN9W57ouma
	Kftt3ZITAPUVPwfR6mvMvS9TLxsPKgueQ5Oev0T40Rr8ThRaeHUJNbPEIxY7B3cNQEUnb7
	CSP1lxKwKNP1/K6HoRP6JWpIrXX1d+y8b3Rv01ttIv9TKQ/5T9h2prMigF3gYWIyvnDWp2
	XstUXgnuejuM0/JvrCqtYct7JmyJZRMaBZmD/hsNuEq0RzN82pvCDQc8h5p4IA==
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
Subject: [PATCH net-next v2 1/3] net: move the netdev_ops checks into a helper
Date: Fri,  2 Oct 2026 11:42:07 +0200
Message-ID: <20261002094211.2350702-2-nb@tipi-net.de>
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

register_netdevice() already does two ops sanity checks and is about to
get a third. Collect them in netdev_check_ops().

The call stays after ndo_init() because drivers set features from there.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 net/core/dev.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 5ac08da8b9d7..a44bcfc29d54 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11451,6 +11451,24 @@ static void netdev_free_phy_link_topology(struct net_device *dev)
 	}
 }
 
+static int netdev_check_ops(struct net_device *dev)
+{
+	const struct net_device_ops *ops = dev->netdev_ops;
+
+	if (((dev->hw_features | dev->features) &
+	     NETIF_F_HW_VLAN_CTAG_FILTER) &&
+	    (!ops->ndo_vlan_rx_add_vid || !ops->ndo_vlan_rx_kill_vid)) {
+		netdev_WARN(dev, "Buggy VLAN acceleration in driver!\n");
+		return -EINVAL;
+	}
+
+	if (netdev_need_ops_lock(dev) && ops->ndo_set_rx_mode &&
+	    !ops->ndo_set_rx_mode_async)
+		netdev_WARN(dev, "ops-locked drivers should use ndo_set_rx_mode_async\n");
+
+	return 0;
+}
+
 /**
  * register_netdevice() - register a network device
  * @dev: device to register
@@ -11506,19 +11524,9 @@ int register_netdevice(struct net_device *dev)
 		}
 	}
 
-	if (((dev->hw_features | dev->features) &
-	     NETIF_F_HW_VLAN_CTAG_FILTER) &&
-	    (!dev->netdev_ops->ndo_vlan_rx_add_vid ||
-	     !dev->netdev_ops->ndo_vlan_rx_kill_vid)) {
-		netdev_WARN(dev, "Buggy VLAN acceleration in driver!\n");
-		ret = -EINVAL;
+	ret = netdev_check_ops(dev);
+	if (ret)
 		goto err_uninit;
-	}
-
-	if (netdev_need_ops_lock(dev) &&
-	    dev->netdev_ops->ndo_set_rx_mode &&
-	    !dev->netdev_ops->ndo_set_rx_mode_async)
-		netdev_WARN(dev, "ops-locked drivers should use ndo_set_rx_mode_async\n");
 
 	ret = netdev_do_alloc_pcpu_stats(dev);
 	if (ret)

base-commit: 071876fd50482a68603a9460d80dd6dd58827ee1
-- 
2.53.0

