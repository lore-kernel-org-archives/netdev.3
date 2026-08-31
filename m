Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD3D3CA4B5
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 08:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163834; cv=none; b=bBCR2acSJYymywsAAvx5k0WZzVmOF3Tjlh6ILmijnn6I3xY+orRQYr4rkGcsmAyQlEKIjB1L19YX2OOLUBJekkn2SBVT+GIsodI1YSnERHqhGdxVb7yT3fUb5Qua0Kt+GiCNNZw0h3DjkSZB9IpmQS3/CUaQVx62n0OfJQgRG/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163834; c=relaxed/simple;
	bh=UmMQIVZ7V6phJ72qfkGozi2YHtQ7o8TbOUAmAaUnbdA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rvEBpkczKo9MBKwcozp7hp1v3sti4+tVnuJYKnEs/YoPDXdA+O1UEN+3cUOn1mEv2z3z51W/1bY1kzE3GwBoULxWRbsImmOIaX6tok1LOUfG6kdm256DMrDmZFE2ke2Di8u+s9vFEUHGZiL5jdIkRjXE6/ZYq8/ZJcdxWY3F1tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HQefM6JS; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HQefM6JS"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93494cce712so540587185a.3
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 01:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788163829; x=1788768629; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2WlHT2gSlKd9rBupAWlFcMP+IP/eI1USUY8tunUjfX4=;
        b=HQefM6JSBBIC2M00SAlFemyxzEgj27D7QEQuDanZ1BcB9hXtjRRm0lcAfWyGNEfzDb
         Ug42ayY4MiLJv6ayFFUsulxEMwEyCMNnKuk+tjBWw6bFKZXCbetmNX8tpYzY4kQLouZw
         Bjim/GPyGxyVxLm8HBkynYSEjos+F//Gt7zJO+SY8QRBlk6V+A93YrPGHa0K4tEcIIxf
         GmN4q6YLGmOKwFTkuzoLMk9oeL4eqe7nl66aKRekybnddfKLln33gGwj85IU9nLtqCZ2
         VrDdFvFRG9iXdyNzzb4BJtWFZJsVxmzS3RpZmy+cy3HZl6JS7AEPKhJzpibtlfbzMy+n
         oGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788163829; x=1788768629;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2WlHT2gSlKd9rBupAWlFcMP+IP/eI1USUY8tunUjfX4=;
        b=s869939tSmJAC/OilnaGY+Iv3V8vHuAxYBM3IIVNGmLUlyU/cu8WKSkTJoHIzCgo6Y
         seUCqWgi13A9edrqX8W+AIDD/DMfpxCHsfh2ScZ9RfM6/L2LMSctf8bbApyMNna0F5/L
         3NW+xcpluri7i/CwLVA/fjPCVSqrQQ0dupivUa871rNb5I4G7Bhoty8va2H660Ppm7rD
         SWNwoBIxcGI6ONyjN2HSq0BkOWReopQtkdZ1UZMImC9r6A7sbt9aLlu6xGOwEhcDtQ0g
         pMXrHOunnRucdnz8lv26Ohzb8+sRHDj1w2RHrwvVgSIQlJYV7py75WE63RWnOZ/ATxC1
         zurw==
X-Forwarded-Encrypted: i=1; AHgh+Rr48JPL/gTfFANGF3iJe8+eX1xfvliPbowk+5iI/vPKnBKvZonm5al7iIIviMcSSyVRGAkjvKo=@vger.kernel.org
X-Gm-Message-State: AFuF++mh4TM4UY/q3XQFFF/KplU9p12Q1A9p+4rRvOkPMuUFyDSeIvjk
	hXRImYxY9b4NoJu0tc29bKVJFW5KEWr9lH3GOL7Vbj4Kcxpx7VI4EEerq9m7/Hvixx6aRUfpser
	5SLWuGmV8q1VSAQ==
X-Received: from qknsg19.prod.google.com ([2002:a05:620a:9353:b0:936:c39f:5c4c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2ade:b0:937:45fb:6b95 with SMTP id af79cd13be357-939137e2d44mr2218687585a.17.1788163828668;
 Mon, 31 Aug 2026 01:10:28 -0700 (PDT)
Date: Mon, 31 Aug 2026 08:10:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260831081027.3209554-1-edumazet@google.com>
Subject: [PATCH net] net: bonding: annotate lockless writes with WRITE_ONCE()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Jay Vosburgh <jv@jvosburgh.net>
Content-Type: text/plain; charset="UTF-8"

Several fields in bonding are read locklessly using READ_ONCE()
(or ACCESS_ONCE() previously) but have corresponding writes that
do not use WRITE_ONCE().

Add WRITE_ONCE() annotations to:
- bond->send_peer_notif decrements in bond_peer_notify_may_events()
  and reset in bond_close().
- bond->slave_cnt increments and decrements in bond_enslave() and
  __bond_release_one().
- bond->recv_probe updates in bond_open(), bond_option_arp_interval_set()
  and rlb_initialize().
- slaves->count decrement in bond_skip_slave().

Fixes: 4d97480b1806 ("bonding: use local function pointer of bond->recv_probe in bond_handle_frame")
Fixes: 9a72c2da690d ("bonding: fix div by zero while enslaving and transmitting")
Fixes: ee6377147409 ("bonding: Simplify the xmit function for modes that use xmit_hash")
Fixes: 429208aab9db ("net: bonding: add the READ_ONCE/WRITE_ONCE for outside lock accessing")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>
---
 drivers/net/bonding/bond_alb.c     |  2 +-
 drivers/net/bonding/bond_main.c    | 14 +++++++-------
 drivers/net/bonding/bond_options.c |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index 839f7482dc1823b12a13437a4b6639e3b63d46ec..d2fb67a47cf99651423602c39a3c89a5f5379913 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -875,7 +875,7 @@ static int rlb_initialize(struct bonding *bond)
 	spin_unlock_bh(&bond->mode_lock);
 
 	/* register to receive ARPs */
-	bond->recv_probe = rlb_arp_recv;
+	WRITE_ONCE(bond->recv_probe, rlb_arp_recv);
 
 	return 0;
 }
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index ef9eb0c53c661fddc48bea03f8091f239dd0f3e8..947d92a669b676524ce7a3786bc8acbc8d36fb3c 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1245,7 +1245,7 @@ static void bond_peer_notify_may_events(struct bonding *bond, bool force)
 	}
 
 	if (notified || force)
-		bond->send_peer_notif--;
+		WRITE_ONCE(bond->send_peer_notif, bond->send_peer_notif - 1);
 }
 
 /**
@@ -2284,7 +2284,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		}
 	}
 
-	bond->slave_cnt++;
+	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1);
 	netdev_compute_master_upper_features(bond->dev, true);
 	bond_set_carrier(bond);
 
@@ -2533,7 +2533,7 @@ static int __bond_release_one(struct net_device *bond_dev,
 
 	unblock_netpoll_tx();
 	synchronize_rcu();
-	bond->slave_cnt--;
+	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt - 1);
 
 	if (!bond_has_slaves(bond)) {
 		call_netdevice_notifiers(NETDEV_CHANGEADDR, bond->dev);
@@ -4385,13 +4385,13 @@ static int bond_open(struct net_device *bond_dev)
 
 	if (bond->params.arp_interval) {  /* arp interval, in milliseconds. */
 		queue_delayed_work(bond->wq, &bond->arp_work, 0);
-		bond->recv_probe = bond_rcv_validate;
+		WRITE_ONCE(bond->recv_probe, bond_rcv_validate);
 	}
 
 	if (BOND_MODE(bond) == BOND_MODE_8023AD) {
 		queue_delayed_work(bond->wq, &bond->ad_work, 0);
 		/* register to receive LACPDUs */
-		bond->recv_probe = bond_3ad_lacpdu_recv;
+		WRITE_ONCE(bond->recv_probe, bond_3ad_lacpdu_recv);
 		bond_3ad_initiate_agg_selection(bond, 1);
 
 		bond_for_each_slave(bond, slave, iter)
@@ -4413,7 +4413,7 @@ static int bond_close(struct net_device *bond_dev)
 	struct slave *slave;
 
 	bond_work_cancel_all(bond);
-	bond->send_peer_notif = 0;
+	WRITE_ONCE(bond->send_peer_notif, 0);
 	WRITE_ONCE(bond->recv_probe, NULL);
 
 	/* Wait for any in-flight RX handlers */
@@ -5118,7 +5118,7 @@ static void bond_skip_slave(struct bond_up_slave *slaves,
 		if (skipslave == slaves->arr[idx]) {
 			slaves->arr[idx] =
 				slaves->arr[slaves->count - 1];
-			slaves->count--;
+			WRITE_ONCE(slaves->count, slaves->count - 1);
 			break;
 		}
 	}
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 36b8d89387ee5d67a51087fa2c6edd0de579ab3f..9efadeff6a2238960828a0604e304108ad9c2dc7 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1147,11 +1147,11 @@ static int bond_option_arp_interval_set(struct bonding *bond,
 		 */
 		if (!newval->value) {
 			if (bond->params.arp_validate)
-				bond->recv_probe = NULL;
+				WRITE_ONCE(bond->recv_probe, NULL);
 			cancel_delayed_work_sync(&bond->arp_work);
 		} else {
 			/* arp_validate can be set only in active-backup mode */
-			bond->recv_probe = bond_rcv_validate;
+			WRITE_ONCE(bond->recv_probe, bond_rcv_validate);
 			cancel_delayed_work_sync(&bond->mii_work);
 			queue_delayed_work(bond->wq, &bond->arp_work, 0);
 		}
-- 
2.55.0.897.gb25b4bd76c-goog

