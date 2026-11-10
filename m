Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352404;
	b=dzHcWmfhpoTlVgE80TYNKQoUQUNpSd9FROxD9WuVXfp8aX+sU3P2YIKwruyDLr3gYoL8
	 1RDuQsbROTlh8vXFZ1QtnGeaVgyrcSmXon/P1Cw39BzsXsRLUaGLOjAebZZuAyrdi3EV2
	 4vTpjJfiUupvEl3SfjprmQwc4Jpuhbccm0JDp/HMPZ39ciU3GdmsvXNRu8wtyt7m/HgNw
	 2iKs8jKbBGCKorAjpsBNOL/yKk/I2b8XM5JF6b0GUcoCKhXA1a1TDY2Fw31Q/JUO+eTlw
	 0vU2/tCvigoBm0tYBpKSYQ0kJFZCY9+JcyUCoZGgXX2K/YXivr5wr3+6xj0NiVzbb0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352404;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=y2PJWsGT9DDXgdyqOWNZn4zZ/5815bxCRHtUykcsi0I=;
	b=P25g/VJZ36MAP0IAnHH+JYaEAM0PtBhtwYl6gS84p9cfhq4bTDtAvVh0erWLRozFdk/E
	 SP/r+R9nzNHRq8vLgMy0kmP2u94bX0XmTCB5latYIJiTFeS0583y8cl57iHSrAuE4OKXM
	 ddTJldkg/Y2NRb04YltqKUioBF9f1QgNrk7fUVlyQQYn50cJUvVTptWpqrEgcYk9rANTj
	 gjuSymOUvZdWkZaP0Ayzy2cI0uD0ZeFsqiQq+54/DaFkGD6L7X+X91cmpVIsVq2qX+feZ
	 l7T8o/y3bbFPmgTn1b6Tt3/OtNQNK9pYL5JTS+N9ZqXzEhNI2yGJ3tyRX5wfaSQON0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="DQWHs/Y/";
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C80660A2602
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 23:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C80660A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DQWHs/Y/
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so1033261a12.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1794352403; x=1794957203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y2PJWsGT9DDXgdyqOWNZn4zZ/5815bxCRHtUykcsi0I=;
        b=DQWHs/Y/PxX1bY1e05b88CkK2bDdAN5JrwSGtg8GmFLeuA3BgFRMZU3R3JUh8zlLvg
         HErh6MpMjAOgl5cKp15bbsjM/8DwipYqYtH2+M9M2zQM+2aeKsSSmDZe5Vz/Q2cQQRMS
         QfKQgK/OCFPz1FNqzRusy3fVbbq6nCuTfkZf5w+RuAq4oCwnvAYnzMVwtggo3O3bdlFj
         P5F/yqBL3vL1y9lZG561H+nDFpGLL4F0WHMcos/ea2HORjLbG1QEonMAlVDdQNfuFgW1
         LIQMXMrrZMKItHydzE4sOsuKCoTtoDyCUVAmWFuIIfgWzl9unLZrimq6c7BocjtqbZQJ
         Gn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794352403; x=1794957203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y2PJWsGT9DDXgdyqOWNZn4zZ/5815bxCRHtUykcsi0I=;
        b=01JXnkvBTRCCvyhxnFjvkcL9mA6H/zXFKOYhdxNIGRQTFUsjQ6r5uQzsj/XXcLddPC
         Kb0/I4jeSQfNaMcliBvdzoKsQn7fl6XbP5jmdrM2KjdWVAh/4YxO49XT2CWV3j+X4GKl
         Po7VCRU2MWvnM6P7tWPsKUV7FrFFr/9t7o8t2w/y8Vau0UM8h3e130494zpThroJR5YX
         ApDh9IH2TYyyuXSAyPve5FQo6afXoCooj7My0849xRiw2RDQNrXBTycodUaFZ74IV1+u
         MqhClIMVVpu1kJv8UuuvjTt5uXgYFbMdx1+SSrghXnSXp0kr2VH4Co2FE9RR8fso2eT+
         G1BQ==
X-Gm-Message-State: APuU4Z/UERORcNi1oUja7JV5/M32eASYLc9ST0evVvd+O/xlsYyRAHlu
	Yf0toJFENnr0bcJj5zB3GsOCNZitk4Kba3HrUr+0pJE4N2cv9/issfAi694CPaTpU9G6fHmWq8I
	3RJ1I
X-Gm-Gg: AYBFou3MOnx/ejlAeAbSR4AIJhjv0ZmhTL46Cexp6VJfnqt3kitH13S2gl0CdytpXK2
	KB4WGTMZEEFYQfmh9goss4zKlTERr2zrClQv6INAA/yypr3SJtsPnBONTpMIL69lhV6EU68MglR
	aRCczRSsPFq/v3pv2cwHzgytpyBrGCdQ0cALviAycwUX/qskxsiRItNAT20+cQhhTc8hNHCfdFf
	EdY+63/yAFHtsebgz1FvylLXsnU9k7W+7RW5feBw/ZHlyIwPWXAf4Tbo3IW+ihgYTjB4S6W8hKm
	x8agvpd/jPJwmZBo6drA+2ysrHGiau0dpxzcj077ZAN+SVziwsvpBD3RX/ta58JOVG/4xs2yaW3
	7VpAL3fHppNePWm0C2vrI4m9H58Ytqlmf8DhcSOJUu+Vg6JX4emI0NPUzkjfx8fF9Qj2dbY5LqK
	LokS/eYO55QQw9cocpRLhYbkH3yl2/xIjmJqyeXG3vVHBb3pjUoxYSQoj/Tn6MQySn+bHN6+sNR
	k20Gy6J9PGZDrbPnivXKfqP6BaiJm+NrYbmDJ/QigFe8Jcuov5wZflygbMvCIvPe5lDpgCUwB5n
	mjl/psJEuFwXbWBKkT3i+QLP/CeSY5FMpXOWhcL3lUcXhYNimynoE48A82DY2xY=
X-Received: by 2002:a17:90b:1e47:b0:3ad:818f:3da2 with SMTP id 98e67ed59e1d1-3b182fcd7b0mr392066a91.63.1794352402961;
        Tue, 10 Nov 2026 15:13:22 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b182de1dafsm323373a91.3.2026.11.10.15.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 15:13:22 -0800 (PST)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: edumazet@google.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next 3/5] net/mlx4: factor HW loopback DMAC into mlx4_en_set_loopback_dmac()
Date: Tue, 10 Nov 2026 15:12:57 -0800
Message-ID: <20261110231304.1859217-4-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110231304.1859217-1-joe@dama.to>
References: <20261110231304.1859217-1-joe@dama.to>
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

Extract the code which copies the destination MAC into the WQE for
eSwitch loopback into a helper. This helper will be used by a follow-up
series implementing software USO, so USO packets between functions on
the same port are looped back too.

Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/mellanox/mlx4/en_tx.c | 28 ++++++++++++++--------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_tx.c b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
index f6059b533eac..97f27e005810 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
@@ -871,6 +871,23 @@ static __be32 mlx4_en_csum_flags(const struct sk_buff *skb)
 	return cpu_to_be32(MLX4_WQE_CTRL_IP_CSUM | MLX4_WQE_CTRL_TCP_UDP_CSUM);
 }
 
+static void mlx4_en_set_loopback_dmac(const struct mlx4_en_priv *priv,
+				      struct mlx4_en_tx_desc *tx_desc,
+				      const struct sk_buff *skb)
+{
+	struct ethhdr *ethh;
+
+	if (!(priv->flags & MLX4_EN_FLAG_ENABLE_HW_LOOPBACK))
+		return;
+
+	/* Copy dst mac address to wqe. This allows loopback in eSwitch,
+	 * so that VFs and PF can communicate with each other
+	 */
+	ethh = (struct ethhdr *)skb->data;
+	tx_desc->ctrl.srcrb_flags16[0] = get_unaligned((__be16 *)ethh->h_dest);
+	tx_desc->ctrl.imm = get_unaligned((__be32 *)(ethh->h_dest + 2));
+}
+
 static bool mlx4_en_prep_vlan(const struct sk_buff *skb,
 			      union mlx4_wqe_qpn_vlan *qpn_vlan)
 {
@@ -1008,16 +1025,7 @@ netdev_tx_t mlx4_en_xmit(struct sk_buff *skb, struct net_device *dev)
 		ring->tx_csum++;
 	}
 
-	if (priv->flags & MLX4_EN_FLAG_ENABLE_HW_LOOPBACK) {
-		struct ethhdr *ethh;
-
-		/* Copy dst mac address to wqe. This allows loopback in eSwitch,
-		 * so that VFs and PF can communicate with each other
-		 */
-		ethh = (struct ethhdr *)skb->data;
-		tx_desc->ctrl.srcrb_flags16[0] = get_unaligned((__be16 *)ethh->h_dest);
-		tx_desc->ctrl.imm = get_unaligned((__be32 *)(ethh->h_dest + 2));
-	}
+	mlx4_en_set_loopback_dmac(priv, tx_desc, skb);
 
 	/* Handle LSO (TSO) packets */
 	if (lso_header_size) {
-- 
2.53.0-Meta

