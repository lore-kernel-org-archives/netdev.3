Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD02220F5C
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 21:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770930273; cv=none; b=ZziLM7zGPgvvbRfBHLykuhvj3d2cy05toj0bcTgDxMEcNHorbCprt3sPd5JAbRcLvyOUbL3wq7qrq85K+6IM4ksAw/njuZk7A0FDaDSz70nc/UH9iaQTBmt8X20P2cNhA4Tv6PN++ULK0NmN9rC8YZn1VdzowN0LiNt+Qm5MpiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770930273; c=relaxed/simple;
	bh=QQJ8X0j3rnN65AerR19t/pAJmQvYP1WIHbt8wFRWOPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bw6SxI4v+slwfsEFruSBUpB/f3+k7e/sW6w8Nhw/iCgIU6ZsgOV0XhySODCPUi77kOcyfpwetCM2t8FYm5a85Y64xxkh7tUUnwRCOjSZ5keEPLvH3HHxx6T9ryBJNToLl8Gj0ItbyB75HnTNnPdFOJxCyXqGY6bpMQBW1U0FSKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=H5zrO6ux; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="H5zrO6ux"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4833115090dso2028825e9.3
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 13:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1770930270; x=1771535070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tK3spkxVRCUik006sOoO/SiUaMmlQyI+Ljlioq2QdI=;
        b=H5zrO6uxNTkikBRsmus1UymNlhUW2SOZIBn9wh7CYf9Pn5qQ7mtvE+GA9sA7uyLgrs
         n4HR3v4Dsljlw+5wAkk2wC78km87Gw6XGV9GvJ4U1F8HMV+h6M23qsYn+7Kf86q9Ue8Z
         vcOq3rvByzhW/j4S5Msa2paJHZiPZZQVL9XFjkbG4s3yyCGp0mbQnyZx7JThnyzyXrhL
         DKc+7wwqpqO+LO9Sn7kTwIBRCOcBXk2PJxxa9hobZoNdaVPfc8PyP2IOFuTrhPHqfc91
         WEuNHlhyh2frOJCiaVy3Lfz1Dz0tPGFFbTEOJH7zQ8ftP63a9KBkS2V+OwI7h8KZqlLJ
         tCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770930270; x=1771535070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5tK3spkxVRCUik006sOoO/SiUaMmlQyI+Ljlioq2QdI=;
        b=c0HMezjApTjtBySSkrsya42X9btmYdPvfv9aCVeOFcEkxgcrEDzelrZjPFFAToLhPP
         nn4e6kiEpKJUsl6o7d0ZrGp9NU4++OAUgSbBFu6ML+vyrAb+JYlN6UFDMsAQJHsSaQvR
         SysosskjpYwfU7xmfZsBoPry3zjQvXv13VGbMlyvRCvXO9Qhkjx7adXzOV/Go4nMqH6A
         zU2GZSbumCEAEZR1Jjmnt/8VE7evDg9EYmIUB8kMPB5S2cHVmNGthejyKAwAQR3W33j9
         g6loEU4xhM7+7ffxYgBWX/9pklNLDdBeNOc8RvSyHN3fMC8UcTok0aKVEVwbnlyRJaJy
         uckQ==
X-Gm-Message-State: AOJu0YyKlYgkZ1e2HCqZhHPiyEo+NBB+f/sdOUoqLmHevl0McF2Ijclq
	/joTLQeDWrzbWSdZl2VHBbXWZc4AyM6FalrXXbdmlkJ2MTWOUfoyqMNfnD6XCehhmLDXPadyb2Y
	S3Ym3+UUF64WKfdYvhujPqwVlR5sT6961c9Efaal5rK/4DbwsFLeISCkDTMaX0uUk
X-Gm-Gg: AZuq6aI5QSgfade65UU4sbzhI7B3O5Dkrv30VrlpU5RTdyWY+q3XAMqho4+LX5WwNoo
	uDippxF9drRtVHbCNRPFgHKVCHn8WjfjTDk8wDA/G8dZfqfrxxliTIX1DGeeMWdz4YgDPecoDiO
	+2aLlXHRknQIwhZNfejPF1qunhkPIDCkVhbPoPjvqSScfsb02LCU0cG+g08xmDc1w19HmdmmF+f
	cIJP+LdX5Za5nGc6Gu8Ze31u2h7/sFvHgbI0UAziG3Qb/+5yqdD5c8GwEB38baQ9XIPAefy+WKc
	LYlQg3Ok95c54H9auB4A7w7PEgoNitG1iGCusGbtpmlbjhol4jJlcap7sSqrMYvCATSaKQbVqEd
	c84ithHbD+GWQRerIOwBIv98LU2rMe8pydwZsBL3erwXBx0p/r5UuUi1VCE1ifKJrGeq9uDcoCh
	tqEFiV5L9dZ2xHjbE61iB5xwyJwQ4EReFtMy1L
X-Received: by 2002:a05:600c:1c12:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-48370e2313bmr8269555e9.10.1770930269888;
        Thu, 12 Feb 2026 13:04:29 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:af2a:8088:67a4:6046])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483719b8e71sm5170925e9.2.2026.02.12.13.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 13:04:28 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 3/3] ovpn: fix VPN TX bytes counting
Date: Thu, 12 Feb 2026 22:03:29 +0100
Message-ID: <20260212210340.11260-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212210340.11260-1-antonio@openvpn.net>
References: <20260212210340.11260-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

In ovpn_net_xmit, after GSO segmentation and segment processing, the
first segment on the list is used to increment VPN TX statistics, which
fails to account for any subsequent segments in the chain.

Fix this by accumulating the length of every segment that successfully
passes skb_share_check into a tx_bytes variable. This ensures the peer
statistics accurately reflect the total data volume sent, regardless of
whether the original packet was segmented.

Fixes: 04ca14955f9a ("ovpn: store tunnel and transport statistics")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index f70c58b10599..955c9a37e1f8 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -355,6 +355,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct ovpn_priv *ovpn = netdev_priv(dev);
 	struct sk_buff *segments, *curr, *next;
 	struct sk_buff_head skb_list;
+	unsigned int tx_bytes = 0;
 	struct ovpn_peer *peer;
 	__be16 proto;
 	int ret;
@@ -414,6 +415,8 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 			continue;
 		}
 
+		/* only count what we actually send */
+		tx_bytes += curr->len;
 		__skb_queue_tail(&skb_list, curr);
 	}
 
@@ -426,7 +429,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 	skb_list.prev->next = NULL;
 
-	ovpn_peer_stats_increment_tx(&peer->vpn_stats, skb_list.next->len);
+	ovpn_peer_stats_increment_tx(&peer->vpn_stats, tx_bytes);
 	ovpn_send(ovpn, skb_list.next, peer);
 
 	return NETDEV_TX_OK;
-- 
2.52.0

