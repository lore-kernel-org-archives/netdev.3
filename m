Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924B530C361
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 03:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785208452; cv=none; b=gT2ngITY45qd1qpdHVTAJ5UZobOcgfMskVviveaJdHGG0TVqEYWrrZdjjNnmyPLFkKFMRlgmEMntLYbiCRCqkNC9a8ACEsDr20oXpJ/EV0tPmHp3z3vPhl6v2at7MmHGhV59FNhfi6QX9rWrCyAM7uryCkXdGP/cHLfYO5C+/90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785208452; c=relaxed/simple;
	bh=K/XikrT+qvj5teUQQTe4KgxecqkOmcAAod/rTuSDONc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sk130FXufUK/0kR3oNfJLX9rCZrVTJwnzYj7nvp66iPmZso47oshsBeLuDhW9s03GJ5odgTr0nXcaPlewX8GS7QF5GCss0QpCmfphSD584AdTwpc+XbRpmabsnqb1R6uQ7A8Y5MOCMF81s2GHbE4feeitPorKuwwXisIwoolH3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKt4txpV; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKt4txpV"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cf49dc28ccso5582005ad.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 20:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785208451; x=1785813251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cRfm366VPssU+NnVYgA+/wWnPtcy7nNBxmgWn8ayHP8=;
        b=lKt4txpVtm2j9k0i2YmRQRTkYfCDwVQmFsMxqILT0o/dfLkd1M8yn/ocoVLl2quMfb
         NTl1WHH/8qWh7ZB8q2YS5fikWd3GE2ExY9K0lvx5a8AOOHA8xiZBCXrZ6knrwD/QCrBV
         Amcj6/CDVQEZb2GJkx928XaTlMwiAcbVwtCzAgRWHeZhUkXpiEzEkg5wKqueQ84mz7Nk
         pr8BvnD/nPvxBjLLAwyBbhiEZEk0wCKLLYzbq9Cp14tPZfY2oXE0+uEqa4/vKaRql19A
         Toketewgskr+No1JX9+N+4t0Av1cJ6OKK7R0Eg0Eb8QNYyubl4JJnbxP2lFGgMbEUi2k
         /aYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785208451; x=1785813251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cRfm366VPssU+NnVYgA+/wWnPtcy7nNBxmgWn8ayHP8=;
        b=tMsF9DTMNoOqXbiD+VNbFvpCnhOkhF9Em0C/eGDyFjFhqQrsm+xRyVHtvhjfzmRR3A
         F8qPymo7Pt2utFBJR6/J1BBG9gYKm4gWw+mwQIdXHOCm6ruVCwyX1/oq/K8A+g0qzbPm
         o17MjzZZrStNV1/WoQudDUDfpcgw9UVTivvTN0OpbwpBd8iCqRFSGbtphNTMuGJhybu3
         gLJsf/KeJUNUUNMMjeu5LVMikpK19q5IbdzFageVh8qIffufWx8Md6zLzkax86lTZOGd
         T6mP/Iv/o7Yrx52pRY2mcM3ZkwzcOIVC0udZDZU4L++bPaLqEloi4O+xa5iKwzo6jYI5
         I0QA==
X-Gm-Message-State: AOJu0YySSsyh79fnQ/gWk//o1dW2wPy18H51pBpzfXPLyxLVEAqhkZP3
	8UUjWOTDN31XRLF0XwGmG63oPHflg5tzGeaVVFM/p0RC878TYidwyIe0vkmTKBRp
X-Gm-Gg: AR+sD11vlAHw4X5y/nl7Tbt1jkxXC6Qxrbl5GhU5BQ18Og9fbPrHKnmd6TiT8ZOr1Q4
	TpZX9DhiQKfHoFJXwHnW/1Fe48/ufr3zRB9P9Ukcy0hS/w95meb8tMIL6mdzHsf1g8+E3Gy6IUU
	IZHtVqDSbSLwOeKayDIGC6MaKdKbreMMeMBGTFOJkp6u1ONHP13hPAQSlg4/Hl8wF5kuGNnKQ+O
	/rPXghSyIqS42wiwBIBxp3VIaO3uFz+nV3zhMk50BmQZfgiRbYHarNtG+S44CJ06DyURXDoXehL
	WpH9cKGkUeVOEsinQpNYOogN84ENHQ6GTcbcY/r0Fe3vt4l6YF/lZ7wWOoX8qPZWVzy2IiyZIRj
	+jh57bTXiHSnyhnhUNSDzTUJ++LhMT/XpLh0HMJCnFMs7aFrrmDobAKse40jjAZhk1qA4VnyxSy
	e/xbYyefuvsUEpd6CMAelABEdt99T5IR2xZbLgLJy5oplsbi8ZxfBftw6f6zNygRK9
X-Received: by 2002:a17:902:ebc3:b0:2cb:2b50:d9da with SMTP id d9443c01a7336-2d015c55771mr6067525ad.3.1785208450948;
        Mon, 27 Jul 2026 20:14:10 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde59bb13sm44311065ad.1.2026.07.27.20.14.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 20:14:10 -0700 (PDT)
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
Subject: [PATCH net v3 2/2] packet: use consistent hard_header_len in TX_RING send path
Date: Tue, 28 Jul 2026 11:13:45 +0800
Message-ID: <20260728031345.49562-3-q.h.hack.winter@gmail.com>
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

tpacket_snd() reads dev->hard_header_len independently for skb
allocation and header construction in tpacket_fill_skb(). Concurrent
netdevice reconfiguration can therefore make the reserved headroom
smaller than the amount later pushed, or make copylen - hard_header_len
negative.

Snapshot hard_header_len once for each frame after any wait and use it
for headroom allocation, copy length, and skb construction. Pass the
snapshot to tpacket_fill_skb(). Reset copylen for each frame so a
previous frame cannot retain a larger construction length.

The separate SOCK_DGRAM consistency problem between hard_header_len and
header_ops->create is not addressed here.

Fixes: 69e3c75f4d54 ("net: TX_RING and packet mmap")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 net/packet/af_packet.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 88674a6e868c..0ef9795e1d12 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2574,6 +2574,7 @@ static int packet_snd_vnet_parse(struct msghdr *msg, size_t *len,
 static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 		void *frame, struct net_device *dev, void *data, int tp_len,
 		__be16 proto, unsigned char *addr, int hlen, int copylen,
+		int hard_header_len,
 		const struct sockcm_cookie *sockc)
 {
 	union tpacket_uhdr ph;
@@ -2605,8 +2606,8 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	} else if (copylen) {
 		int hdrlen = min_t(int, copylen, tp_len);
 
-		skb_push(skb, dev->hard_header_len);
-		skb_put(skb, copylen - dev->hard_header_len);
+		skb_push(skb, hard_header_len);
+		skb_put(skb, copylen - hard_header_len);
 		err = skb_store_bits(skb, 0, data, hdrlen);
 		if (unlikely(err))
 			return err;
@@ -2737,7 +2738,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 	void *data;
 	int len_sum = 0;
 	int status = TP_STATUS_AVAILABLE;
-	int hlen, tlen, copylen = 0;
+	int hard_header_len, hlen, tlen, copylen = 0;
 	long timeo;
 
 	mutex_lock(&po->pg_vec_lock);
@@ -2784,8 +2785,9 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto out_put;
 	}
 
+	hard_header_len = READ_ONCE(dev->hard_header_len);
 	if (po->sk.sk_socket->type == SOCK_RAW)
-		reserve = dev->hard_header_len;
+		reserve = hard_header_len;
 	size_max = po->tx_ring.frame_size
 		- (po->tp_hdrlen - sizeof(struct sockaddr_ll));
 
@@ -2822,8 +2824,10 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto tpacket_error;
 
 		status = TP_STATUS_SEND_REQUEST;
-		hlen = LL_RESERVED_SPACE(dev);
+		hard_header_len = READ_ONCE(dev->hard_header_len);
+		hlen = LL_RESERVED_SPACE_EX(dev, hard_header_len);
 		tlen = dev->needed_tailroom;
+		copylen = 0;
 		if (vnet_hdr_sz) {
 			data += vnet_hdr_sz;
 			tp_len -= vnet_hdr_sz;
@@ -2840,10 +2844,10 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 						    vnet_hdr.hdr_len);
 			has_vnet_hdr = true;
 		}
-		copylen = max_t(int, copylen, dev->hard_header_len);
+		copylen = max_t(int, copylen, hard_header_len);
 		skb = sock_alloc_send_skb(&po->sk,
 				hlen + tlen + sizeof(struct sockaddr_ll) +
-				(copylen - dev->hard_header_len),
+				(copylen - hard_header_len),
 				!need_wait, &err);
 
 		if (unlikely(skb == NULL)) {
@@ -2853,7 +2857,8 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto out_status;
 		}
 		tp_len = tpacket_fill_skb(po, skb, ph, dev, data, tp_len, proto,
-					  addr, hlen, copylen, &sockc);
+					  addr, hlen, copylen, hard_header_len,
+					  &sockc);
 		if (likely(tp_len >= 0) &&
 		    tp_len > dev->mtu + reserve &&
 		    !vnet_hdr_sz &&
-- 
2.50.1 (Apple Git-155)

