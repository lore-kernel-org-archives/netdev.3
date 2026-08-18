Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6474B463B6A
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 16:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071709; cv=none; b=q6hqpdb+pQLpuvU6LZLnnX7t2XqPJBtQ3+c5n9GvoBYcU3S46OAPjEU7mQamPc1mXSLupTj4tzAL/512JyC3vJPCEqJ2yBx16+87clJpFJCFo31vOR2+e53o5EsbTkha0Z80xnKjcyE8NEZWH/UN3HBdGddAjFkspfKln79drT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071709; c=relaxed/simple;
	bh=0Z1kpCviLfqtQ4S1NA1UEO5sU8E2F+Nfc6aC4X7NX5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U+EKZqb9EEYku21fwUL9PAQwEgRDYFOAVfJkKIPFx75c0TSsG13Bwz9PvYurWrI6u+APJrZzmtMVmPo11KoQH7TiLKVfb5W1thnmTCnRfUXFu3uWYw6dox4ENk5ulnrVjNZmQlBa8gEJqA3+kXQfyr9UWrWyRn42VUcK9IKZI4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1S65EUA; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1S65EUA"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-836c5b01e82so2125957b3.0
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 09:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787071707; x=1787676507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JPVXi5wfbRZBRemeKuFfa8ybwBAndyi5M7ZrW09Zovs=;
        b=Y1S65EUAye9cage/v7ZfPsM0VgatlHjq6cKm3HbtQ22pNJT1wpRuUvsLaoRo+cIVTJ
         2ZAARz2cZIBoRJ/n6QkVgZ+Voa0hIKC4Fw8B4X8bx+5zbzEUZEB0lcpvoc+SXKFq46Kk
         ScvF6D6YrJBIA7McGwtfR0O13IhgVk/fYElBFcgW5GW31mXsAzgHkhjffmtMJWNoWAvC
         kH13RZZyTLfqyl2yPOiC0B3GApulKqg810rXblHrYE10BSMJVyaraAYGdcjzQwdnDIHW
         LRlNyKtJU3Qi/MESv/OPthPET+1lXEBifZSxOYGex3Z2yS9dIGD2fLbIH+Ruonbqwmis
         2NeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787071707; x=1787676507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JPVXi5wfbRZBRemeKuFfa8ybwBAndyi5M7ZrW09Zovs=;
        b=HctzXpX+E2fGGqtDzi+Sd+4DGBh0t/Q/3yN3GaxqRnhREAloNfbmLvZqchUjRg6ElA
         lvIMWZAetv61+JJyT/bWWkRQUtV3Qe21n4Wgf56XJ1bognME6gw67aphdA2lEym5UmZJ
         Cdvx1kN+z+4Qp0+/qMyCP3oFIiHYR8FTfS4c++Gb34GydQ38I7xSa62yumoosaKLA6k0
         UcdB3PI5SvpPbLKvYeRP0WbpkwRA8CNPhpcHhJL2+B8K6tdO7kdp390dD/2lbi/+gyDT
         GDqRL9foyuYzZZFhJWOv0lVZZGFhonsUKprYrSGqm9sucngaO+639+3KQ3uuiX3E+L6/
         2h1w==
X-Forwarded-Encrypted: i=1; AHgh+RqWDpDgmW1dsN20gBmZhTHt8Cp6Eu+kotFZFmN8ATxdIjcWjbIttH+N3d50QL1wOgUHcRiZ2qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAcp9r8VRZN7ND4d3gZg2sP8A8bzBo9n28cIQy+7iB6n7q7m1a
	pTFQzlwPGFsCFda1qgkl935bXZD7jGs1vBNx2GMZyo8RN52e60lzUBPM
X-Gm-Gg: AR+sD10/OJEzzzylKu3XawUBuyUu0XWTszCGQb+RoZ3isoea5stfhKNvO+D7m6vQcf8
	46Cc4dw7YAlKgl6/QyKKjH4zWYu0ZD18aK2MK6RkNNlXWUTPrOIpj8jqvb5n3E5xWAqieFo2S7k
	+Cj4Wrx4KuYJhOjf5HiM4nJL+HAbwPjQm1NogmIHCOm8H3WqFDPvSxWaZLQIxzJhrKoUnz1PrVF
	H1ahK/N7uOt6fnGxmC5CM+sbKfjBRfEunj46YIwKO+SCXp973DUlNVdquxkl5yve+8sbd1v4nim
	Fx8Rix0CspIiweG4BAGzB4+yXWerG39fNoCJQjOZvvDn7ycgfAcDcz+uYxJMc5attIthK+OW/by
	8GMGJ2ZDsE6xV6lbRyyrf2rfWpXwAzwqj8L12PFiqto33NpQd+W2aUDD6su7RaVzuFofYGULSGu
	ljVHmixfHetaT1IVYXVJe0LA3lD7WsLPCCZpk8I2CPTGZpcmQZaLqtkWRpkSYqsTX04nI=
X-Received: by 2002:a05:690c:e1c2:10b0:80c:76fd:f732 with SMTP id 00721157ae682-841316567a4mr29719077b3.26.1787071707289;
        Tue, 18 Aug 2026 09:48:27 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-840f25c13f3sm21489317b3.26.2026.08.18.09.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 09:48:26 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: ap420073@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH net] amt: do not store tunnel pointer in skb control block
Date: Tue, 18 Aug 2026 12:48:25 -0400
Message-ID: <20260818164825.63967-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An skb queued in a qdisc can outlive the tunnel it references
through a raw pointer in skb->cb. For example, a netem delay of
180s exceeds the default tunnel lifetime of 135s (igmp_qrv=1);
when the tunnel expires and is freed, the subsequent dequeue
triggers a use-after-free in amt_dev_xmit().

  BUG: KASAN: slab-use-after-free in amt_dev_xmit+0x2763/0x2e20
  Call Trace:
   amt_dev_xmit+0x2763/0x2e20 [drivers/net/amt.c:1262]
   dev_hard_start_xmit+0x22f/0x620
   sch_direct_xmit+0x12e/0xac0
   netem_dequeue+0x333/0xc50
   net_tx_action+0x35c/0xa60

Store the tunnel identity (ip4 + source_port) in skb->cb instead
of a pointer, and re-lookup the tunnel under RCU in amt_dev_xmit().
If the tunnel is gone, the query is simply dropped.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Reported-by: AutonomousCodeSecurity@microsoft.com
Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Reported-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
 drivers/net/amt.c | 30 +++++++++++++++++++++++++-----
 include/net/amt.h |  4 +++-
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 182a41d59a75..a85ba0dfe18a 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -789,6 +789,18 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 	rcu_read_unlock();
 }
 
+static struct amt_tunnel_list *amt_lookup_tunnel(struct amt_dev *amt,
+						 __be32 ip4, __be16 source_port)
+{
+	struct amt_tunnel_list *tunnel;
+
+	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list)
+		if (tunnel->ip4 == ip4 && tunnel->source_port == source_port)
+			return tunnel;
+
+	return NULL;
+}
+
 static void amt_send_igmp_gq(struct amt_dev *amt,
 			     struct amt_tunnel_list *tunnel)
 {
@@ -798,7 +810,8 @@ static void amt_send_igmp_gq(struct amt_dev *amt,
 	if (!skb)
 		return;
 
-	amt_skb_cb(skb)->tunnel = tunnel;
+	amt_skb_cb(skb)->tunnel_ip4 = tunnel->ip4;
+	amt_skb_cb(skb)->tunnel_port = tunnel->source_port;
 	dev_queue_xmit(skb);
 }
 
@@ -883,7 +896,8 @@ static void amt_send_mld_gq(struct amt_dev *amt, struct amt_tunnel_list *tunnel)
 	if (!skb)
 		return;
 
-	amt_skb_cb(skb)->tunnel = tunnel;
+	amt_skb_cb(skb)->tunnel_ip4 = tunnel->ip4;
+	amt_skb_cb(skb)->tunnel_port = tunnel->source_port;
 	dev_queue_xmit(skb);
 }
 #else
@@ -1259,15 +1273,21 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto unlock;
 	} else if (amt->mode == AMT_MODE_RELAY) {
 		if (query) {
-			tunnel = amt_skb_cb(skb)->tunnel;
+			rcu_read_lock();
+			tunnel = amt_lookup_tunnel(amt,
+						   amt_skb_cb(skb)->tunnel_ip4,
+						   amt_skb_cb(skb)->tunnel_port);
 			if (!tunnel) {
-				WARN_ON(1);
+				rcu_read_unlock();
 				goto free;
 			}
 
 			/* Do not forward unexpected query */
-			if (amt_send_membership_query(amt, skb, tunnel, v6))
+			if (amt_send_membership_query(amt, skb, tunnel, v6)) {
+				rcu_read_unlock();
 				goto free;
+			}
+			rcu_read_unlock();
 			goto unlock;
 		}
 
diff --git a/include/net/amt.h b/include/net/amt.h
index a0255491f5b0..59c4bb88fb1e 100644
--- a/include/net/amt.h
+++ b/include/net/amt.h
@@ -231,8 +231,10 @@ struct amt_relay_headers {
 	};
 } __packed;
 
+/* Tunnel identity for re-lookup; do not store a pointer here. */
 struct amt_skb_cb {
-	struct amt_tunnel_list *tunnel;
+	__be32			tunnel_ip4;
+	__be16			tunnel_port;
 };
 
 struct amt_tunnel_list {
-- 
2.52.0

