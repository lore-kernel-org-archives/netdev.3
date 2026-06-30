Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547843E0C42
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 18:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782843695; cv=none; b=YI+hSWOcR5a8P2jeagARx6R1LlnmQM7KYa8OoYIDL9pthFTvIJx777Nuv2YVMh8WIWD82L24RenqApOXbfD7jeRbm/e/MjM5cKJ+sob6Ss/N62kX6d4qa3SK94+B7qujAfVVTY6ZHVmS2Vb49PZtc0JdjXzHI1i1sXlUpK+Ygbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782843695; c=relaxed/simple;
	bh=EbDXHwZhKWezlvHibLxaPTBKS4CLC+lVVYHUqlY3D6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCwiRCqVyvUWKgKIkTms5ecoR1+o8X8CW8Q7fPnBVeJ0k8PkQJVFBDo6f60YTsPaObqQshI8BQcdi2BXEgYeq1E/Yt2Akfpvkn3lwrmf7YLXNGR7YXsaYMm92msxcAlJsXepuFkdt1RLyBSBFepf9uEIdeejFvUoxkXh48G3nYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBC4NWei; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBC4NWei"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-847a483e344so650493b3a.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 11:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782843694; x=1783448494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7upDWRqYnMkDp7WGbybswVJOmwtvnZhv59i8fe7oAhk=;
        b=gBC4NWeiDFVEYigBLsQTMoapX9dwFD3KOHsVUTI7r+C9VnL0DJyN5bqQO68rsDZLcz
         tWJPAOQMcRVKsG54K+cmGiUDK950F93syineLzeBwA4vabZDlg1w2W96edy50TRfWxE1
         aBoeigt4LavGqN7x/Pt7+Ax7VDgnb7vtk/8VlNgKdladXRgt8hHqO2snL0XhM/2XFNq6
         aioGaJlX2H7fBKDcfq7Ny/lKYHNWM2A7tIhG/vItjhV32RtFg+vOooZcTrx5TK9LkE79
         zlw47mevUggNW43dUKnRX7vBpPj7VBG2FQfaAINv1yo8oyZNcQB434hFA/KFYXPJC+Rf
         SyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782843694; x=1783448494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7upDWRqYnMkDp7WGbybswVJOmwtvnZhv59i8fe7oAhk=;
        b=AP+CeV5WkVvEqGJoq4fugMc7GNNLM2hpZz1p+dX4Pd7VwtTsSER81qqDVmu8NHfGZe
         WDxPmcR0nIXucXfquxaahKEf4lsgOAoRQ4jTzRRil2M434QbONuycZEX34lQrf6jEvK9
         KoyIOBbqHt1HgdvpCS/rG952TWD2cxAhcGslmwYwUMrfGldwxq7gbAKRO9OZU60HTDOE
         /fpaDXiC1RTVJRe/KFnatT9w08lqXTk7YmdVeqf5rIVka66KGPfXdmwh4Rfcp4MkpUco
         nBUrEgud452fiCSi0FgdCa6lRjAtHc9rrdG3S0k/mNaeVXKX942kwtAcUngasLhe6+7O
         zmdg==
X-Gm-Message-State: AOJu0YyFSJ1aQHFC+GJS891tyIPexgUMoVBG/FyQMz9/a9kTFo6lKyXD
	N5uzR6LX55akOTI1ukTKTulGW7qQVyGlqn5aoSjYcru+WyyUu+XQm1ZFzfQQAtQn
X-Gm-Gg: AfdE7ckN5TuRImhzBYITYr6WkHp1rJbKlflPjIyApilrO9uNwmV3y1C6G4wI+HClpLy
	42/URyIctrxzZTHWhww1s3sIPTdP/18JX5YLdX1QoXbrhQr7M62NiB9/qQh3zTpG3ICKJbF6POD
	zfuPKNy/3GBXtPg49vo0uDqFVEKGs0mi92FyromZ/az4EHnzaTfXNsYZrPuY8xdrWepk8KMt2/q
	PLsAQCJb5ettbI7Nm1Fn4SHZ9K+Ma8RwuwZrcG+pkfqYeR4Eg6w3wohnGJZpbT6hrQPuehs9ejz
	YpjHnu3w7vcxqBX3Ad8EILfZjT8/jiiZetbhS2O4R3ZvOk1CG6tb45GbimVmW8HQuFrcQQH1YDH
	kFmomdk8nRzmzMOcWEVRNqGlXzRcsxP+k2wNvynRCNlXSm4jBezAuW6IhIqFLQsKrHU2DKscgby
	zFlnnFog==
X-Received: by 2002:a05:6a00:3e10:b0:842:499d:450e with SMTP id d2e1a72fcca58-847a82d978dmr2043269b3a.20.1782843693633;
        Tue, 30 Jun 2026 11:21:33 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a032609esm2529887b3a.41.2026.06.30.11.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:21:32 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next 2/6] net: dsa: hold instance lock on close-on-shutdown paths
Date: Tue, 30 Jun 2026 11:21:25 -0700
Message-ID: <20260630182129.1601784-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630182129.1601784-1-sdf@fomichev.me>
References: <20260630182129.1601784-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netif_close_many will soon assert ops lock (for locked DOWN/GOING_DOWN).
Update dsa_switch_shutdown to manually grab and release the ops lock.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/dsa/dsa.c  | 20 +++++++++++++++++---
 net/dsa/user.c | 19 +++++++++++++++++--
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 9cb732f6b1e3..da53a666d4b8 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/of_net.h>
 #include <net/dsa_stubs.h>
+#include <net/netdev_lock.h>
 #include <net/sch_generic.h>
 
 #include "conduit.h"
@@ -1620,10 +1621,23 @@ void dsa_switch_shutdown(struct dsa_switch *ds)
 
 	rtnl_lock();
 
-	dsa_switch_for_each_cpu_port(dp, ds)
-		list_add(&dp->conduit->close_list, &close_list);
+	dsa_switch_for_each_cpu_port(dp, ds) {
+		if (!(dp->conduit->flags & IFF_UP))
+			continue;
+		list_add_tail(&dp->conduit->close_list, &close_list);
+		netdev_lock_ops(dp->conduit);
+	}
+
+	netif_close_many(&close_list, false);
 
-	netif_close_many(&close_list, true);
+	while (!list_empty(&close_list)) {
+		struct net_device *conduit;
+
+		conduit = list_first_entry(&close_list, struct net_device,
+					   close_list);
+		netdev_unlock_ops(conduit);
+		list_del_init(&conduit->close_list);
+	}
 
 	dsa_switch_for_each_user_port(dp, ds) {
 		conduit = dsa_port_to_conduit(dp);
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 8704c1a3a5b7..8ea47444d6d5 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -13,6 +13,7 @@
 #include <linux/of_net.h>
 #include <linux/of_mdio.h>
 #include <linux/mdio.h>
+#include <net/netdev_lock.h>
 #include <net/rtnetlink.h>
 #include <net/pkt_cls.h>
 #include <net/selftests.h>
@@ -3600,10 +3601,24 @@ static int dsa_user_netdevice_event(struct notifier_block *nb,
 			if (dp->cpu_dp != cpu_dp)
 				continue;
 
-			list_add(&dp->user->close_list, &close_list);
+			if (!(dp->user->flags & IFF_UP))
+				continue;
+
+			list_add_tail(&dp->user->close_list, &close_list);
+			netdev_lock_ops(dp->user);
 		}
 
-		netif_close_many(&close_list, true);
+		netif_close_many(&close_list, false);
+
+		while (!list_empty(&close_list)) {
+			struct net_device *user_dev;
+
+			user_dev = list_first_entry(&close_list,
+						    struct net_device,
+						    close_list);
+			netdev_unlock_ops(user_dev);
+			list_del_init(&user_dev->close_list);
+		}
 
 		return NOTIFY_OK;
 	}
-- 
2.53.0-Meta

