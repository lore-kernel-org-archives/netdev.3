Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A7330FC27
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 03:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785208445; cv=none; b=dqYGUX9t7Fu1644abUDpuDSww/9iq1UuXNVQxRlWopkJ3DpnfItI8zJ4GS8m//qTBSjvtYVhdwil95bnb2u4PbawphI9Am84eaq+ZqMhu27nMyiHThi7UaS9Itq5csNF+hbwzhl1n/PInwHSFv5k8gAwrn2uSdadxNlnaTiHZeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785208445; c=relaxed/simple;
	bh=mGiiBSO39KjIxrL2W+wAA5FveIL+1aYwwAlANbLho+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQ25GmBQpBV76q9oZAfy37xigHp/oeEmjDiys8KsGhourM7UGm1/pDBYm7SkxTsctwFAeUBvQWplOm+/zZBqNioWtNr7VhGZI30LUw0O0D3INTxTlZzgM0RGtLENuVEf8HhkeqIdrlfqTq20aPbeUKCEpZa1xufl9sV55ij1k3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qs+LG6vA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qs+LG6vA"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cad85b7b5aso469275ad.1
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 20:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785208443; x=1785813243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cfyIu4xGFkG3Ewi0okt2X//+/u8fqPweCXY9nTXphZI=;
        b=qs+LG6vAgX0nmtHgSP4I1KpD5uTERd75t7VqICSVYl4Seoszy+SwjOprYLZlMiiXQL
         URB17CarK15ev/1dcrWj7ZLIDGa9GLKFHrzu195AFwkMVipUzHwgJy5CZJeZiiG4X+j7
         TTzlil2KdwRKRUKebaEUcLxGCvWB61Gj7xCpoaJgiaEYdtnbilAc8i6z5We4CL5Wt5mJ
         oIlCktwJaoXKTShAS60zD6wxBWKgxCvm7YeJg5oHBFglhVMMs13AEKl2Kmxs5IavOgOC
         Ra2JZAAUI48PNLHf+dyd7cVZH7fAZcCC9SEe4YWtKfMcrrAXmcvmqelwrlX3mjlHtNkV
         shIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785208443; x=1785813243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cfyIu4xGFkG3Ewi0okt2X//+/u8fqPweCXY9nTXphZI=;
        b=A4WH2SBoo4xFq8bgJYlVb+OVQuaFLWIDnjX8VhuevlWxZZ+9C9jtIZCUBpJeT2aTqq
         Cb6XcQBMcgy8onIXiLW2uPKB/NlwiaU9nl2fAQ9/DXXjORA8FzMzuUNm8Xp+WFqSlrHi
         U3QuWNPBvBBBYl3UYfZM1x5dyzlLii1DH9cNx9DFcFLCQKW07gPMCbniWqO1C6qHGsX4
         2XfDX/eRALxsdP9/10k1oUcFohpNMOUsZMXb0nS05v5RMQ9Z7vh+fnR/Myx9/WoO1yCu
         62xiy8c+VIsb3hv009EJq4/zrm1N7w74tKL0AkUE6zbQ23p2nDhzKB6ldr0vLK3YM7/0
         Zlmg==
X-Gm-Message-State: AOJu0Yy9qvjkjnvdJ2JW2jLG/4rvujDIk3TNcNOhT33bMr+6qgLy3WKK
	Jn+IEbOJ61ZNswpt5baTPvbUk54EjJEtJB2OT0TTEWcVLv35A5hCP6XdynCah2Sx
X-Gm-Gg: AR+sD11/PVDKXv8hC+CttueETQlkgQbTF+8foeSdoNYqSQpgp1Odi1q+3tKmFSNPLMc
	Mk3e/0SmtraqZ1AYjsC1jOcYLWn8zY1ICPQaxBv5fK6UtLL0Te1qjT2EnXi4HpJtpj1amDdC5RK
	IpLYAJDrMXZqp6nYjnQUkGa4aLarggO+KBx60dUGVKYFrNDIl8ZsMWsoPKZLdKML6JSj7/pf6Hb
	hOIxaIuEci8g85+FldDgRRZM+B7o7nXuS1SYUfN8zOXV0YwQWZfsE5Z2RCsAM0TqlhA6iAJFHaf
	gYnBeResDrUK+kk0eVPbYZ/m0B/NA40rhWFttx+TftIUhZUKzvPFeNIvfouauU/bBrBRz/9BWCY
	XYaM86jitXNY1yR78aXubBfTgTFgmIByr+twD/2vH3nzLXiLCsY7ddgB11y40RXvbCMbcb4XFNm
	PWghI+FfEF5XFMpKq843awW2kVRaPiCTDn07DIi83fqIk5OStu/oyD7N9HLOp+j2JBjHdBEEb1a
	V0=
X-Received: by 2002:a17:903:3c45:b0:2c9:fbde:ab68 with SMTP id d9443c01a7336-2d015d03deemr9719965ad.3.1785208443032;
        Mon, 27 Jul 2026 20:14:03 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde59bb13sm44311065ad.1.2026.07.27.20.13.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 20:14:02 -0700 (PDT)
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
	Qihang <q.h.hack.winter@gmail.com>
Subject: [PATCH net v3 1/2] packet: use consistent hard_header_len in non-ring send paths
Date: Tue, 28 Jul 2026 11:13:44 +0800
Message-ID: <20260728031345.49562-2-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260728031345.49562-1-q.h.hack.winter@gmail.com>
References: <20260726092110.80185-1-q.h.hack.winter@gmail.com>
 <20260728031345.49562-1-q.h.hack.winter@gmail.com>
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

