Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794171851;
	b=4h90OhnPaybwzGwjJJ6EObOsuK0UpSbtqp4eaHty7VGBvw+rkHLtsGwtIRcUsjopXrkK
	 +Yt7F4WcaA9yT1G67a2dO3247++LdVJj3EF6yoV/BSHEL+ZcKVfvMQInnYBF4r7oPymCd
	 dtRpdXV3n1bncrOZuBRXO57Bt1OOxVNbFhfky73VN7cQT6+i+rveEKzPPvIv0ohcXwlVX
	 PNMeBDOzhTkg1HUmIQbaqODX/FGAsZ5x92zF7HbAKaylosEcxX03Sh/V6A9lXXu5Wb0PK
	 J8CiNH7uQikESHMEfYc90rRuMMu8uTMzMpXfMJnGSXr893hPJUsnSOjRuAN7gOPcG2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794171851;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=eIb7bdwJudGm44awRNyhi/z38sBFIBc01LhzAmpW+h4=;
	b=hJ/YOUjAKPGuwZZxcadZ4pKx8jKvm3SO/pZWEuZp2EbNGnHqvYMJt6prC88tr6Nasuy2
	 Sjb+oXgM2f0z+k1NR2JQrNv6e7i9o3Lt8S45ZWWcYf+HsKkQVQEjkPw1xaDqoi9gn/k/N
	 qzjZXvQMV23BOXbKYvcLC/X0BSwJlHngA4oei8K8J2mrSJqDIq5ZkEv0opHqIc8NTVeDJ
	 wRfw3Ez8WW9FJwjPzJBQ4zSZP85z5aTkKQ+QCb3YLYY/2tljg0NBfNTZlhz5Uc5YWHT9w
	 P5UfS63rvubvBuNQhkn2kjktdm8BbSMyheQmGr2ge43f+VK/nC8OE1TKQfUpd57cV1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m96FZTEu;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1191F606A320
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 21:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1191F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m96FZTEu
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso106544a91.2
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 13:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794171850; x=1794776650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eIb7bdwJudGm44awRNyhi/z38sBFIBc01LhzAmpW+h4=;
        b=m96FZTEuIAb1CYOvgLsTEIMyqu1plbocUGEaOJnkyQkNav2+Oz1eUD1BpW3lwJpXTp
         kMHAbNkuMouCdo4oJe/tv+AwLFqY4uj0pvCBai177lKT1eaB27LpwOsRmUh36dFYEPGk
         ZgE+/VT5cgtbEe9NZTjFdnYWB5w8wL5NUD0AMhFUmTW3PGHe6dgp/OQ1HvubR5VW23qx
         mhb3DDxokoWis8dAGrQt6mKrBXYsepIj8yVr8Ucp99nz06j6L9ZC1FkGmhXRUaKNnqbD
         jBliXU7M0Xx6yntrVDoYxirnPsTr7SOADi21fooV7Uwhh5GMij8v1BWTDhQH0bTywPVk
         kIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794171850; x=1794776650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eIb7bdwJudGm44awRNyhi/z38sBFIBc01LhzAmpW+h4=;
        b=ZJa+AnRXbCQBq+kDFqL0miuniIM18t5zgob8798/xxEX5qVkoeTxvw+/HkrjpLuhhX
         sHK6l6Z8/NXHuSeUKigi2l+Q4NYU70fFyvkG/sVDIqZ0tCcOGkZHcJpaocowlhdpDHdg
         nfeQlVUOu6xPbDYeLlctp3LafyKK9lvhw6mTyMMdhsS7XK7Rwe6EphJeEFfusPO/TOo/
         xnC1DUXOt42pnDFSVQXaQR+Vhlur3i4KAzE+gqrnlbtGvZ8fRDdomBzkySi5RxDZ6IVd
         1f5HHb9FKcvgUdT6tWNcdNy+I7V658+pkGYrQBn6cgtqM6VxGUgfDCfgutbNDYOvVd/r
         nASA==
X-Gm-Message-State: APuU4Z+XmsCM4d3BchpEOtPjI4b96gzxJpucD5+19gCjRBezSbVxN6Zw
	PdMFrHPyiM6T6h+hiLzzLyVLNCx1J1lFWOdfCYAojqecIteJjmDMWPPLjcY9BQ==
X-Gm-Gg: AYBFou2bXjRVFFx++aNiaYr7Dw7TcO2b5BD7ftZee0b6B8bHFBkBYIonYDdWDzDPPpb
	ektlZ0QLjt5Sq6jsjTjgLyt/CG5DY08Bwun5rf1MCZRVbDqw51uTUGDVKsBadnSNTsy5Nv7xn0V
	BaFLMjzkiTmboYirJAnkr107ZCy9qvddFMwo7355q1aoeHUDCY6gj/Gfc7OdzhPNM9jiVvuPgK5
	AXOvPAfw+pW2dFJauMUZfHdcPLkMSNp5GP6tkTKloUfOLbWi0+ny6/rCffDWOsq1C6f79hFHZyB
	pRXZV02BqTKcQS/Rvl4MTQA6fqOvMy3s5eddFF9oUOL+/6ncHI5HXJpGi/2GtjxKaW9W7PqnPn0
	4WhGsWV+hE7zN7xzIgVf+Y8Qd85NCGPE4xXBXmReE/YymZRVac00EsGdXs02qIY4s902dc/jdxN
	Kdk5EcXBhUQdNN+L7LdGgqWuB2N/NVfb38SLUPsp1cCHdCutfvYJ7rDGn22bWPG5o5Cbyq88lBm
	NWM6zrYoDRoybrTHZ2GA1c7nQVE4wWf1qkJwN8I1bg9Mx2b0UlH5xms83rwQxQYv3PE2EhYJMLO
	9edm/gJjdPnN8z4j5tZe2Tm7HQjtEA915MQqP5c7UlhVgHLs+qjL6A==
X-Received: by 2002:a17:90b:4a51:b0:3a4:b30b:b501 with SMTP id 98e67ed59e1d1-3b12d0e965amr2097709a91.9.1794171850235;
        Sun, 08 Nov 2026 13:04:10 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1279158c4sm4209414a91.14.2026.11.08.13.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:04:09 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: motorcomm: Reread port flags on bridge joining
Date: Mon,  9 Nov 2026 05:03:54 +0800
Message-ID: <20261108210357.1633411-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DSA replays neither BR_ISOLATED nor BR_HAIRPIN_MODE on join (e.g. a LAG
member rejoining its bond), so the cached flags survive into the next
bridge join and program stale hairpin and port isolation state. Sync
them from the bridge port.

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 33e5fc127244..fcc3a299ed66 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -1405,6 +1405,9 @@ yt921x_dsa_port_bridge_join(struct dsa_switch *ds, int port,
 			    struct netlink_ext_ack *extack)
 {
 	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
+	struct yt921x_port *pp = &priv->ports[port];
+	struct net_device *brport_dev;
+	struct dsa_port *dp;
 	u16 ports_mask;
 	int res;
 
@@ -1414,7 +1417,12 @@ yt921x_dsa_port_bridge_join(struct dsa_switch *ds, int port,
 	ports_mask = dsa_bridge_ports(ds, bridge.dev);
 	ports_mask |= priv->cpu_ports_mask;
 
+	dp = dsa_to_port(ds, port);
+	brport_dev = dsa_port_to_bridge_port(dp);
+
 	mutex_lock(&priv->reg_lock);
+	pp->isolated = br_port_flag_is_set(brport_dev, BR_ISOLATED);
+	pp->hairpin = br_port_flag_is_set(brport_dev, BR_HAIRPIN_MODE);
 	res = yt921x_bridge_join(priv, port, ports_mask);
 	mutex_unlock(&priv->reg_lock);
 
-- 
2.53.0

