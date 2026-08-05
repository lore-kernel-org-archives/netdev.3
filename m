Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAF946D2DC
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 12:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785934697; cv=none; b=HHGm9TcE/94qNLpsC2qf+CJeOmn6j0uSuajiXqyjlsy3v5GDpzNiNHz0Krh9yjt4o9DrzIrCr5HACPCIT62/c4YD8IftD+SCRGZejihyEqzNV9hBgoVbktLwlryIxOSqsr9cruM+dj3iADgNBndtgTNLVecJae/aoO0rciYnXi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785934697; c=relaxed/simple;
	bh=B9hksGm9ntRRj9QAGHsjEV4YR/Q7/10o0v3GbCpC97g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAq3e5Ef8sfFAP/9GJOfDIijTySgZmKYDJYhnC6CDSZzRV6I5BbSFp59/wWKIf4qnOlhU0qQ6pBzQNwoObQdjqZVBpdhqc8uENTlYQK1rEGmy1snhCrDv7rVa37YywI2xVBBxkhGtVIlr8BcOhAZG8wy6ETmvYmi+EtqBIAzk7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLL7D4IR; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLL7D4IR"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c8612812170so96755a12.2
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 05:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785934694; x=1786539494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/CQIRskVYtbOfiKczfu0y6F86/TMtPEfVhmtJ7xiMZw=;
        b=DLL7D4IRxGa3Z59tiyOZRDtJwxI18b9baAXQZiPaic9mFwXWAZA02GFwCT5djAdqFR
         83vfXLzsnvHFXaG39lYra7cxlAITpeX319/bOucLrlh7srax3abB94GKb2debGzMnA32
         BH5ZWSYy81pIyDp3ywy2IOOdg2j+mD1bcy+5X4D3z0slrw6tpyprkCN2yAWsWxtiH/Y/
         Oh1SsXhpDuyNULm1uzxiJnmidOKgWPxFKq1vF32Sk4hqkMFL4xcDbkOwyWD+sawQHI+H
         /M0dhwT968SHTWvDqPh5oeN+tJ2YzNGHP8HwDeieQaW/aqU8Ds7VxulKjFQwWAsMHrrG
         T+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785934694; x=1786539494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/CQIRskVYtbOfiKczfu0y6F86/TMtPEfVhmtJ7xiMZw=;
        b=WWMpdYLehtvrRC6wXS/w0XuehibOSI1ZjCPIdAkujjwdPwIMPba+A0oQaQroNLYw61
         zY5Kpi5/al0eZjz6EYGktgkDqdSDpnqJHFWMC4dSoKvatJdX1tqSd5m7J1l7hXezZwTE
         ItzDQHf50VJU+h2OjZ/VrIkyIlVH7iTHplEuhwtUugodukDYH6gdHoMsuvgFcQOHDBvd
         yXeC7xJZoT+JNRXP/mM+6VMTlTD1PHHEo1I2IIj45pHtWvRZQ4v4CH1RCC927chfiBFC
         KnDqOF95z/KaLluhdA0z7zx6PbsBobTlCmNB6mfXkIxT0+4gYJ/34gZ+N00J6y5tJOOb
         77fQ==
X-Gm-Message-State: AOJu0YzOFNvyQyM3044eCH23oKTokJ6vb4cKLpIODX6IHuLzxGbMwDA8
	6k1C4KRTNavHRXWe9H1FAG+uNjG8w7bdA6rXNfrbVh7RN6QozfZF1ZXoBp5bWA==
X-Gm-Gg: AR+sD12HHh81LsEc5LYOFA+4/nRvO0tbOKRGgCr/6NgsKtGwRezbYL6J+hoCDQxcAic
	NMQFiftheKVLF5eXNc/5VoFKkasysxLvE7ndCFzt7J2txyUcsE+W/Wn54icpLYiX+EQCI5AYNY9
	j8HwiSS11Cbgclot4kD82FUVPCTkCpzqhkavXLKgddtaSh1lm9DDis8d3q23REDpdAsS+AdbIOv
	G7D+97oPwxpakgdjDFepsUnh35GGPBHw58mD2Esyj5ZI97G8en29C/DUXDWIeuNFO/V2M+WsYfZ
	1jCX9RWAtZfGah6gWuYy9xG1JXTUJ08NTtMtZY+tWSoXkWtgL+CMrN+kWyWxhovjlk5i13wbiZf
	np/w84QHONGaE2gcsUwtOTwO2dmvqC16bg2m3Rbi5E5Oruif437EjgU2ucP1xf7YlESZWOFwdE3
	QGW8297qIEkDRS4oSYkRx7UVUyHm1qtgiiiHlWpTFdHdEYe0rSKD66w9RCvqpoxTN7h46OSjaLB
	eovPUAIFgSt0QnNxOs2aq0KqYO7W7JeaQZuTBEg4W/mAAHGTQc=
X-Received: by 2002:a17:903:184b:b0:2ca:ecf6:9105 with SMTP id d9443c01a7336-2d0ca6010d1mr54561055ad.1.1785934694120;
        Wed, 05 Aug 2026 05:58:14 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0a9f8fb4bsm16514625ad.5.2026.08.05.05.58.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Aug 2026 05:58:13 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	daniel.zahka@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Qihang Tang <q.h.hack.winter@gmail.com>
Subject: [PATCH net v6 2/3] packet: use consistent hard_header_len in non-ring send paths
Date: Wed,  5 Aug 2026 20:57:28 +0800
Message-ID: <20260805125729.19220-3-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260805125729.19220-1-q.h.hack.winter@gmail.com>
References: <20260805125729.19220-1-q.h.hack.winter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qihang Tang <q.h.hack.winter@gmail.com>

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
Signed-off-by: Qihang Tang <q.h.hack.winter@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 include/linux/netdevice.h |  6 ++++--
 net/packet/af_packet.c    | 26 ++++++++++++++++----------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9a770eb823ce..8840b126979f 100644
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

