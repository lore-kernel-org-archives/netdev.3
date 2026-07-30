Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362913BD642
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 08:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400211; cv=none; b=tgwKGTFa5aDW0cUBIruFoCGtKhNqT0OBoXdCNCFQM2hRjTTvvgP4cvJtkUeautu/z4mI2lxfkTDd+3LBQXl6C6ox/QdQ/clF2E44tYXDyokCtaho3C0kmvmAjoNbFrVfw0WglyAl/0h1N61dMFa3WN7W1IGtm8qQCv9xckpf5pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400211; c=relaxed/simple;
	bh=2+lD755z7Rh4q3JmyL4x3OHtwEBfh1KbS7Y4miJd/mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TK1QCaaxg/ZpFQQpczY9331TZuSG49H2WmqAt80zaiXqndj83F1Lg+JIF2KmbOt4fbDvLAOH8RLQwTXK94QF0vJtoPL2bI95YgAU5aNgunZ+bSXlcKY125Xr3g6XUyXppfmY2/wo8dhoS2Wu53v2LW6vr1AboYiv0Y049X3ZPgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7u8zbsv; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7u8zbsv"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-380f3c1b087so178585a91.3
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 01:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785400209; x=1786005009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xg7bd++vUDfsPPAlCp93j183GeX7bX18Uk0d449Ghw8=;
        b=l7u8zbsvIUf2/XTNtBlklP921yLpZmeqaCiQE9jyzpHNbkbv8pM7PEVGtTd+vyMxZb
         DP5/E53eleoncuyxHLgsDpnlco2cOMuGbr8fDPsSTkylNJnslbGCXJa6jNQP2dFSD8W+
         BdlFr8vEDKvdaouHsV7osvCv7IK1SyFHVQMuQqljww9Y/hPL40Uzt5ZETEjAFnaqFfea
         LKkT6rLzJXCTGExKxeZ0Cmf8bQIIf/nrmW7HngzT2DHfj50uS1jtzqzlDa5mSsSpq2yR
         Q/jdfQU4gtPe3NMfaWjq3O6o+YREZ4TE1wkDs4FMR/1k+MJbgRwLpAxgtf7kp3RBGfOG
         65RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785400209; x=1786005009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xg7bd++vUDfsPPAlCp93j183GeX7bX18Uk0d449Ghw8=;
        b=D2AEZVDbFe7OZPVaRBLiY1LW8ZV9PcoJRZhRaY2E8AIljtC0ZGMSQ7y+txytL3sN2B
         GKAi38POR7SLxXKCy9tzZAfvqiak6Pvm3oLMgYdH6JIlDRwYeHSxXxlwBRncNsUwX2IS
         pKaZ6ZL09UC52mjrLZdJvNXsAkTW5EH5+F2PQYHr0n4LmLeopsBZRoq2m57Opuc6S06K
         FiZqmzyScu+7X+VEqHosu1TBymxI/VF9NDlLoRlcWrnaFGzOjdVKGDOFW7rQGWtr8Ysq
         pEnwpQkGi0/WPmEDSPIno91Hgmrg/inGgyS5Y+NqsLPQxAqYLhTVL0M8S+KLvBuY8FVc
         eh9Q==
X-Gm-Message-State: AOJu0YzcPHXeW0NUXNUh1IKzQsO203tWhTRMnx8vEjLggDHfttGjiW28
	B4UpcSQAgik5gf0V5dg8zQI2Onq0TorwPSc4d2+KiRN6tCWMik38YF7U2Zljuw==
X-Gm-Gg: AR+sD13Srk10YqjGibIi8zJ1tcIUGtDl2ZGWrc8934uYqYXW+nQvZrquYL/lBVQqNMi
	4XHzs8kmABqjC0frXnidvbfbmKeMFwL5KKb438Ktzq7RaZq/PDoWWGyafyzdqZoy4RjKBpirpkl
	Cad7ytuNAOIv8prXhykeuqUl94RbWSCk1r7b2i9MuHrGuAL1urkMtOLpOckCAa7bfvhw+FA5ccL
	F5C6qrvxrO3H1uqFLrY5M6IRb9He39zaic2xxk8zefOHy0n0qiO83QT4Jn7LjfSrzMErsX6Zzmu
	f8Bd9+f0QWoTo3CfvGXekNzBPw87c+7Chp2Q7KDnhM0IYejR4lPHiOeu8fuw55xWU/oGMcjd3e8
	bTWrrHq3EAqC+W7SMgPEYyeP+ovNFw+JuJfGIl1uIkFF26BnTU2/JG4USVrizu6HE3u57Ef03Ai
	RcnywdekYVS1WtF6NJ4NmQ1q+r6JcHqwDbMzfzRQvhzZy6gi5069T8R8NfAXvJPW8yUromMgp7C
	59QBf/03IbrAWY1JRAAXsN+3V1ViekabhbptSmGwtwrD5qo8Ds=
X-Received: by 2002:a17:90b:4d0c:b0:381:28e0:6248 with SMTP id 98e67ed59e1d1-38f9bd23f50mr2067858a91.1.1785400209431;
        Thu, 30 Jul 2026 01:30:09 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f9b770e33sm664279a91.15.2026.07.30.01.30.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Jul 2026 01:30:09 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	daniel.zahka@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Qihang <q.h.hack.winter@gmail.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net v5 1/2] packet: use consistent hard_header_len in non-ring send paths
Date: Thu, 30 Jul 2026 16:29:24 +0800
Message-ID: <20260730082925.93759-2-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260730082925.93759-1-q.h.hack.winter@gmail.com>
References: <20260730082925.93759-1-q.h.hack.winter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

packet_snd() reads dev->hard_header_len multiple times while allocating
and constructing an skb. Device reconfiguration can change this value
concurrently, for example through bonding device type changes.

For SOCK_RAW, packet_snd() can save a larger value in reserve and later
allocate headroom using a smaller value. Moving skb->data back by reserve
then places it before skb->head, and the following copy from userspace can
attempt an out-of-bounds write.

packet_sendmsg_spkt() has the same issue because it calculates its
reservation and header offset from separate reads before dropping the RCU
read lock to allocate the skb.

Add LL_RESERVED_SPACE_EX() for callers that already saved a header length.
Read hard_header_len once in packet_snd() and use it for allocation and
construction. In packet_sendmsg_spkt(), preserve the allocation-time value
through the device lookup retry.

The separate SOCK_DGRAM consistency problem between hard_header_len and
header_ops->create is not addressed here.

Fixes: b84bbaf7a6c8 ("packet: in packet_snd start writing at link layer allocation")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 include/linux/netdevice.h |  6 ++++--
 net/packet/af_packet.c    | 26 ++++++++++++++++----------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9981d637f8b5..e50e8abc1392 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -300,9 +300,11 @@ struct hh_cache {
  * We could use other alignment values, but we must maintain the
  * relationship HH alignment <= LL alignment.
  */
-#define LL_RESERVED_SPACE(dev) \
-	((((dev)->hard_header_len + READ_ONCE((dev)->needed_headroom)) \
+#define LL_RESERVED_SPACE_EX(dev, hlen) \
+	((((hlen) + READ_ONCE((dev)->needed_headroom)) \
 	  & ~(HH_DATA_MOD - 1)) + HH_DATA_MOD)
+#define LL_RESERVED_SPACE(dev) \
+	LL_RESERVED_SPACE_EX(dev, (dev)->hard_header_len)
 #define LL_RESERVED_SPACE_EXTRA(dev,extra) \
 	((((dev)->hard_header_len + READ_ONCE((dev)->needed_headroom) + (extra)) \
 	  & ~(HH_DATA_MOD - 1)) + HH_DATA_MOD)
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index e75d2932475a..88674a6e868c 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1953,8 +1953,9 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 	struct net_device *dev;
 	struct sockcm_cookie sockc;
 	__be16 proto = 0;
-	int err;
+	int hard_header_len;
 	int extra_len = 0;
+	int err;
 
 	/*
 	 *	Get and verify the address.
@@ -1997,14 +1998,18 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 		extra_len = 4; /* We're doing our own CRC */
 	}
 
+	/* Keep the allocation-time header length across retry. */
+	if (!skb)
+		hard_header_len = READ_ONCE(dev->hard_header_len);
+
 	err = -EMSGSIZE;
-	if (len > dev->mtu + dev->hard_header_len + VLAN_HLEN + extra_len)
+	if (len > dev->mtu + hard_header_len + VLAN_HLEN + extra_len)
 		goto out_unlock;
 
 	if (!skb) {
-		size_t reserved = LL_RESERVED_SPACE(dev);
+		size_t reserved = LL_RESERVED_SPACE_EX(dev, hard_header_len);
 		int tlen = dev->needed_tailroom;
-		unsigned int hhlen = dev->header_ops ? dev->hard_header_len : 0;
+		unsigned int hhlen = dev->header_ops ? hard_header_len : 0;
 
 		rcu_read_unlock();
 		skb = sock_wmalloc(sk, len + reserved + tlen, 0, GFP_KERNEL);
@@ -2034,7 +2039,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 		err = -EINVAL;
 		goto out_unlock;
 	}
-	if (len > (dev->mtu + dev->hard_header_len + extra_len) &&
+	if (len > (dev->mtu + hard_header_len + extra_len) &&
 	    !packet_extra_vlan_len_allowed(dev, skb)) {
 		err = -EMSGSIZE;
 		goto out_unlock;
@@ -2956,7 +2961,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 	int offset = 0;
 	struct packet_sock *po = pkt_sk(sk);
 	int vnet_hdr_sz = READ_ONCE(po->vnet_hdr_sz);
-	int hlen, tlen, linear;
+	int hard_header_len, hlen, tlen, linear;
 	int extra_len = 0;
 
 	/*
@@ -2996,8 +3001,9 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 			goto out_unlock;
 	}
 
+	hard_header_len = READ_ONCE(dev->hard_header_len);
 	if (sock->type == SOCK_RAW)
-		reserve = dev->hard_header_len;
+		reserve = hard_header_len;
 	if (vnet_hdr_sz) {
 		err = packet_snd_vnet_parse(msg, &len, &vnet_hdr, vnet_hdr_sz);
 		if (err)
@@ -3018,10 +3024,10 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 		goto out_unlock;
 
 	err = -ENOBUFS;
-	hlen = LL_RESERVED_SPACE(dev);
+	hlen = LL_RESERVED_SPACE_EX(dev, hard_header_len);
 	tlen = dev->needed_tailroom;
 	linear = __virtio16_to_cpu(vio_le(), vnet_hdr.hdr_len);
-	linear = max(linear, min_t(int, len, dev->hard_header_len));
+	linear = max(linear, min_t(int, len, hard_header_len));
 	skb = packet_alloc_skb(sk, hlen + tlen, hlen, len, linear,
 			       msg->msg_flags & MSG_DONTWAIT, &err);
 	if (skb == NULL)
@@ -3037,7 +3043,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 	} else if (reserve) {
 		skb_reserve(skb, -reserve);
 		if (len < reserve + sizeof(struct ipv6hdr) &&
-		    dev->min_header_len != dev->hard_header_len)
+		    dev->min_header_len != hard_header_len)
 			skb_reset_network_header(skb);
 	}
 
-- 
2.50.1 (Apple Git-155)
