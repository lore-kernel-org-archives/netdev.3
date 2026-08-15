Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7EC32B13F
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 14:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786803097; cv=none; b=J81NKRgoQFXRmZvh5JmsdbGmug/qSJ8/3rKHLetNjxrjIhsi/ONgrU8blx4GdelqqhoUQLSkzlIv/m/hXY60n5p/d2gwjOVOtoITuK99BDT76KlZdTFSVjhw70Obq0HwiPKZjmjpfH2bCMUaK96tahT+h3NFm6H8IvvzEl5giyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786803097; c=relaxed/simple;
	bh=XAwpnSNYe5Kl/s+V54s0e7qW12A5Bz3fnfCDDkBa2NA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VoSCPPH7le4e+HfV713UiY4l5rL/zZilkKrCedC1usxUIu6rmDBCSaRznRbjz0KgTfVf6Vzind/KI1RnCNyoRI/vobq/bLgINRQ+Hx8+qpPrXb5cLAtbUPmbXof8Pypgc6U8XJuGzYf2HZfaPGG9Ni3W1MzM0zZs1tsMz/66T+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyvP2pNd; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyvP2pNd"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso1452003a91.1
        for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 07:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786803095; x=1787407895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qDm28i0miTI7hdZzDddvPXPqbAsLb0juDmWra4xeuko=;
        b=MyvP2pNds/H5vlvcmS11EL6uZyOwpEwxg13GCqDWYoGwhXCWWaRgGV7xUeyobooEp2
         qM2LzApql0IppXYh8DUbi8MtRKhgutQhxd/MicUa8T32U6ckbUOSY1xlwi/lbp1nUXDM
         JuyGKSq/PlIFiu6Qz6ntw3Gkma7UUr0qLaMVc4WzzE5k6x0g2vTg6cNO1xGBwhAXPFQf
         A/SDGzOw/M6yoSV8+IdZT4yVg7g4fAWSi1191kgPZfT+0IE9Ffk/5JHYQfz87aUBB4j6
         IUVNBI8q7xRSBYUCVNXilXoRgzBt3nXhxMmwjb8Y8kaOsSvwnL6AOGX8CqlN9ygr7Kxw
         oMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786803095; x=1787407895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qDm28i0miTI7hdZzDddvPXPqbAsLb0juDmWra4xeuko=;
        b=iRwUvAByRk5Vh3RabPHxGLvjhI8dSG1FVdSupT/iHwqqbhS3daxA7PFSJGvbrAJ5AO
         EdLiqzROWnVFN1yVxdqquR/sEn3RuwS3sZeVOyZ1yIfrA+K349TVu8hfuU4tPsgqbK1k
         EIL1SkMeRP6iK9PyXO4gAMtTyw/OAlV2+iJUc4paSEYxl30b4tdkq+7a/SK9XaMOUJ8l
         csAuN7nGQbFCslo4Yl3ujZ+d/bYxFmbyccK16eVkI1TRp86+UnYY0FJ8FFGjxCrTrAVk
         jUf/NpFrii9IG9jYWIZUX0Rj+yynsvrUUZE29fuQmsTfeMvuQhqBh0/3iqoI6WheauHc
         hxOg==
X-Gm-Message-State: AOJu0YxXc2G8R43xGyePupBHkMgaTcS3mREIjVInY5F/F68heEf1Z0Qv
	wC3XDT5ZWitUVwqifg8l9yTfIdnjxy7NNryxWGMbd7xzbGXEBwagIaR/0wgfj9Dt
X-Gm-Gg: AR+sD10UujUHLlqc6e3ca0yNVQAaaKV4f9Tjma9YZd6Qy3+bKhdVnV25Y/xHlKQei6V
	dB9mjMPQOfVLHwHZ1IS3UW1S/h1SI/4YZ/frKHD4a7B9Viwl7OLlKf/MIqc1oOEaokd5ClelBg7
	bPANVkVUIhTaIlrEmFCZf2dHFu2EmRsEfHcwbAWo4F7TZqnhwoTJ4rK+03/70yvI9Eu9O1ZlS/8
	WagSLDGXtgaQzrAxgRg4aZYQ4EX6mbsgL2ktQcUYgNX8Mzjzd2f5TEgIN375VOELR9FLo4YUiR5
	uaWWbEjJnI1LPf9JPrYL720+BtK5klhQaf0jwvnQ7jxS4rvDfrbR8MbWLy3CT+90zwBJJWZ4/Tk
	PxTxus63ae5eJ9xFzRUZ/1c+dv0JHj6Hy1MqkfsKcdC46oYzoP/aVyoxcGmWu8Vf7j8oQ/RKBHS
	vPU4m0kGg9ZvuTs4ronaS4b++98/CgMfYxuT9CAdUqREtbvOXMRIKvGUzt4NI2wzlVoAVoshEgL
	hzkg+9qQUx9+uWHB7qJwySche618fFtd1Q=
X-Received: by 2002:a17:90b:586b:b0:381:bc4c:da5b with SMTP id 98e67ed59e1d1-3933b91c2ddmr13297173a91.18.1786803094806;
        Sat, 15 Aug 2026 07:11:34 -0700 (PDT)
Received: from fedora.fibertel.com.ar ([200.55.79.212])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1413887ee65sm18943747c88.10.2026.08.15.07.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 07:11:34 -0700 (PDT)
Sender: Mariano Baragiola <mariano.ignacio.baragiola@gmail.com>
From: Mariano Baragiola <mbaragiola@linux.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com,
	littlesmilingcloud@gmail.com,
	Mariano Baragiola <mbaragiola@linux.com>
Subject: [PATCH] udp: resubmit encapsulation packets on all multicast listeners
Date: Sat, 15 Aug 2026 11:11:28 -0300
Message-ID: <20260815141128.1564949-1-mbaragiola@linux.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

UDP encapsulation handlers (FOU/GUE and similar) return a positive
protocol number from udp_queue_rcv_skb()/udpv6_queue_rcv_skb() when the
UDP header has been consumed and the packet must be resubmitted to the
IP protocol handler. Unicast paths already propagate that return value.

Multicast delivery called consume_skb() on every positive return, so the
inner packet was dropped instead of being reinjected.

Commit 3cb8d4b9bfeb ("udp: fix encapsulation packet resubmit in multicast
deliver") fixed only the primary ("first") socket path on net-next and is
not yet in net. Secondary listeners still clone the skb and drop it on a
positive return, and net itself still drops the primary socket path too.

Resubmit secondary clones inline via ip_protocol_deliver_rcu() /
ip6_protocol_deliver_rcu() (matching the GSO segment path in
udp_queue_rcv_skb()/udpv6_queue_rcv_skb()), and propagate the primary
socket return value with the same IPv4/IPv6 sign convention as the
unicast helpers.

Fixes: ca065d0cf80f ("udp: no longer use SLAB_DESTROY_BY_RCU")
Signed-off-by: Mariano Baragiola <mbaragiola@linux.com>
---
 net/ipv4/udp.c | 16 ++++++++++++----
 net/ipv6/udp.c | 16 ++++++++++++----
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 70f6cbd4ef73..d6a17b0462b6 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2475,6 +2475,7 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 	struct udp_hslot *hslot;
 	struct sk_buff *nskb;
 	bool use_hash2;
+	int ret;
 
 	hash2_any = 0;
 	hash2 = 0;
@@ -2508,8 +2509,13 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 			__UDP_INC_STATS(net, UDP_MIB_INERRORS);
 			continue;
 		}
-		if (udp_queue_rcv_skb(sk, nskb) > 0)
-			consume_skb(nskb);
+		/* >0 means the encap handler wants IP-level resubmit. Do that
+		 * inline for secondary listeners; only the first socket can
+		 * propagate the protocol number to the caller.
+		 */
+		ret = udp_queue_rcv_skb(sk, nskb);
+		if (ret > 0)
+			ip_protocol_deliver_rcu(net, nskb, ret);
 	}
 
 	/* Also lookup *:port if we are using hash2 and haven't done so yet. */
@@ -2519,8 +2525,10 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 	}
 
 	if (first) {
-		if (udp_queue_rcv_skb(first, skb) > 0)
-			consume_skb(skb);
+		ret = udp_queue_rcv_skb(first, skb);
+		/* Match udp_unicast_rcv_skb(): return -protocol for IPv4. */
+		if (ret > 0)
+			return -ret;
 	} else {
 		kfree_skb(skb);
 		__UDP_INC_STATS(net, UDP_MIB_IGNOREDMULTI);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 15e032194ecc..65dd944211e9 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -949,6 +949,7 @@ static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 	struct udp_hslot *hslot;
 	struct sk_buff *nskb;
 	bool use_hash2;
+	int ret;
 
 	hash2_any = 0;
 	hash2 = 0;
@@ -987,8 +988,13 @@ static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 			continue;
 		}
 
-		if (udpv6_queue_rcv_skb(sk, nskb) > 0)
-			consume_skb(nskb);
+		/* >0 means the encap handler wants IP-level resubmit. Do that
+		 * inline for secondary listeners; only the first socket can
+		 * propagate the nexthdr to the caller.
+		 */
+		ret = udpv6_queue_rcv_skb(sk, nskb);
+		if (ret > 0)
+			ip6_protocol_deliver_rcu(net, nskb, ret, true);
 	}
 
 	/* Also lookup *:port if we are using hash2 and haven't done so yet. */
@@ -998,8 +1004,10 @@ static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 	}
 
 	if (first) {
-		if (udpv6_queue_rcv_skb(first, skb) > 0)
-			consume_skb(skb);
+		ret = udpv6_queue_rcv_skb(first, skb);
+		/* Match udp6_unicast_rcv_skb(): return protocol for IPv6. */
+		if (ret > 0)
+			return ret;
 	} else {
 		kfree_skb(skb);
 		__UDP6_INC_STATS(net, UDP_MIB_IGNOREDMULTI);
-- 
2.55.0

