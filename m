Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6414349BC
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791714212; cv=none; b=ZtiocELmUy4ZWByPl1SiiwMnGEqgJ3ARZ3BiQH/IAkttOQ5kkKpCKpNpKx9FeruDilPmmscvP+z9Hw13UD1s2VZVBmVnubG1nZ4FFtae0OmdXEln5ihl+P3OSa8shl0K/Qh0nYxzmXaXhh94JolDg6P47SqI51fk2TT+VcsTA1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791714212; c=relaxed/simple;
	bh=UkejspJMABV8XUO9c0J8pEcCukwX/riAy3KkeTFeYHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t4S66bwrMAtKEEyLHjWwbyVNIA3x2+XaksUHO0wnzcDPAYwteRLP0XViKlFoJrzdzqDo1BTOEoJJG6RlfU6Tuu76VqiSAAjBKQgHjy4rKdO63ndXziaKSwo45IrHPsH73TPqyalpWyPf8jWSLdW/PQ+ViceimxxH59gHvPyoBvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LG/VeZju; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LG/VeZju"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e4af975346so6063055ad.0
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 03:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791714208; x=1792319008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/pPRjimeEtxmh2P3t5S8/c4gUxkBAEeUK/IaL4NUFWU=;
        b=LG/VeZjuTNhOQlaNyNNty+Tw9LA5wyw94Pu0AHb/tIGDweky9q4RY+zsvvgoBi+10Q
         hnaKAB2Ph16x5ly+bL6YT0Tv6w/VjDUUDzN2Ro8iv7ttHUwL3WcYxTn3aqZWjWerCGoY
         zRZFVGqW++4q84pdN/Foywa7wpBmU+wVFPT4PHAKHieUlsLCdcmj7wbronfZTd+9HdJs
         PLYzwHxYDN7PdXwbxHRuQ3dWQs2hVuccPfg2R7r3aY8uc5CgFyG2f8gA2fltKtH4O8wo
         Ez63YUjw7CizndcyWUwzP3d/8qE177+CkrM+5hbK8osBnTutqDOmuNGUfholu2FPjNsO
         lvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791714208; x=1792319008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/pPRjimeEtxmh2P3t5S8/c4gUxkBAEeUK/IaL4NUFWU=;
        b=v/feMFcFItRMfDVy3Yt37os/SECaKNf/F5TJycwWhhPsQBslqVBp27DDXH0QquL86n
         01m5xhC0wSTId5dSsp+lAEwVHmeZILEe/csNusK/5dPaTefHLSVax+YSlQb6IAkrDBXt
         rztEY0bJ6OYQLPLNGMJBX92y5HKJPErPDrOwfqYSfZ15Tje/u4mbej/st4vTAFwcoSdd
         GSoVrb3+pB9cANZJeOXpOKCaQpKYKBXPScB8WlrIwFPMgDfvGuNyVvBaM3z37wAWGgkJ
         iuZi7YdYZIF7Gwvs/c3PfcxmVV8t8KkO9vJ3a7bR+EFsQUz2Sp3u3ukAibXreo9jWtlg
         PpOg==
X-Forwarded-Encrypted: i=1; AKwUvBwNx0xhTZKRh6Q4KIGOv6Uj3me52ylMwq1E/vWMTKQx4bhExGhBHhzUnnqmGHz8XP4Cr4e9fhw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKqe6dS2PA6JhPDf+7/qMip6PA5XG7ojjqw32vonOZ4sIs9Jw6P
	bWFjtbutGhVyJbfSwMJzADH+sWzxU8Ay6XeyDug9zy2SNs+FAB5/VLbU
X-Gm-Gg: AYBFou2PRa3EUOU53IZx/0CdPmVfAPx14KT/gp2W4pSnsw3om8fX1x3zU5TdX/v1nx4
	InO0yffGt8Wsm/MYwETqmWTNJ3004NTOvA3s6mK8UnS5rR/LoQmcKp8tD4D7e7rM3rSiFAeNiwW
	AQWWKtSAuTu1VESn1PzW/wlHETNs9a4HxOR10WzDYBMasxN9VxHUD+rFt+9IPtOzSMMGyGQSEfa
	Uz4xi2jzQPj69WIuhHO0oRzcax+VfAlc+W7JO6xfhWCy+ZhSEqLbBpBhlTIEVybTAXO+5DAnnoN
	uJSYiaQ71IHEeNYnlgPh0OeB2h6Okr6G5zVAniGkYCH40EghY1B8DKxk73S6AhG10JWwg8v2+cJ
	FCuZkOWi6Y+wVsYj20qLr9JTRjrTgkCaMG/dKQK6TG7hq1JrXG9D5H5DJP3H7Hf6DL7yz5EKfJU
	zBv4BFJEc4TdVuGN0MLDFLVleKf4nFnaTLX5PwXJnIzoJBZJ1O/WMcHMNzWBKM1GdB3KMQlZCz1
	qpi9rwGhc0=
X-Received: by 2002:a17:902:f78c:b0:2e5:98d7:821e with SMTP id d9443c01a7336-2e8428207f8mr61319815ad.7.1791714208455;
        Sun, 11 Oct 2026 03:23:28 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac5:d45a:16c8::245:79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422e1643sm31643955ad.70.2026.10.11.03.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 03:23:27 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: "Jason A . Donenfeld" <Jason@zx2c4.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	syzbot+de9701a2cad597c14d34@syzkaller.appspotmail.com
Subject: [PATCH net] wireguard: mark racy persistent_keepalive_interval accesses
Date: Sun, 11 Oct 2026 17:23:22 +0700
Message-ID: <20261011102322.355167-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wg_set_device_doit() updates peer->persistent_keepalive_interval under
device_update_lock, while the RX/TX paths read it locklessly in
wg_timers_any_authenticated_packet_traversal() and in the persistent
keepalive timer. KCSAN reports the race:

  BUG: KCSAN: data-race in set_peer / wg_timers_any_authenticated_packet_traversal

  write to ... by task 3648 on cpu 1:
   set_peer+0x...  drivers/net/wireguard/netlink.c:457
   wg_set_device_doit+0x...
  read to ... by task 3652 on cpu 0:
   wg_timers_any_authenticated_packet_traversal+0x...  timers.c:217
   wg_packet_consume_data_done+0x...
   wg_packet_rx_poll+0x...

The race is benign, but the reader also loads the field twice, so the
zero check and the timer expiry computation can see different values.
Load it once with READ_ONCE() and mark the writer and the other
lockless reader accordingly.

Reported-by: syzbot+de9701a2cad597c14d34@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=de9701a2cad597c14d34
Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
 drivers/net/wireguard/netlink.c | 3 ++-
 drivers/net/wireguard/timers.c  | 8 +++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
index 1da7e98d0d50..fafe2900c92b 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -454,7 +454,8 @@ static int set_peer(struct wg_device *wg, struct nlattr **attrs)
 			persistent_keepalive_interval &&
 			netif_running(wg->dev);
 
-		peer->persistent_keepalive_interval = persistent_keepalive_interval;
+		WRITE_ONCE(peer->persistent_keepalive_interval,
+			   persistent_keepalive_interval);
 		if (send_keepalive)
 			wg_packet_send_keepalive(peer);
 	}
diff --git a/drivers/net/wireguard/timers.c b/drivers/net/wireguard/timers.c
index 4016a3065602..c4697e8522b3 100644
--- a/drivers/net/wireguard/timers.c
+++ b/drivers/net/wireguard/timers.c
@@ -140,7 +140,7 @@ static void wg_expired_send_persistent_keepalive(struct timer_list *timer)
 	struct wg_peer *peer = timer_container_of(peer, timer,
 						  timer_persistent_keepalive);
 
-	if (likely(peer->persistent_keepalive_interval))
+	if (likely(READ_ONCE(peer->persistent_keepalive_interval)))
 		wg_packet_send_keepalive(peer);
 }
 
@@ -214,9 +214,11 @@ void wg_timers_session_derived(struct wg_peer *peer)
  */
 void wg_timers_any_authenticated_packet_traversal(struct wg_peer *peer)
 {
-	if (peer->persistent_keepalive_interval)
+	u16 interval = READ_ONCE(peer->persistent_keepalive_interval);
+
+	if (interval)
 		mod_peer_timer(peer, &peer->timer_persistent_keepalive,
-			jiffies + peer->persistent_keepalive_interval * HZ);
+			jiffies + interval * HZ);
 }
 
 void wg_timers_init(struct wg_peer *peer)
-- 
2.43.0

