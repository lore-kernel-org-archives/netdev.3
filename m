Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352401;
	b=TQXje6u+uT4Q2CBHqCRvbFe55vrL3/iMcVRpB7jtfL9EPcaALxmWYnmv/VwP+q+V3Xb5
	 9Ef8RB1sBDVoCu5sdjwitQqRkooHfF2xP1wLz+C4ukke9haPuc8Q2yTaXnUSQF5BdHLDB
	 /Oeh3M1d5OrTfDbcavtHB5q1d4T7ImjY6iYJiHkR8p4DOy6PGJ17boXlfzj389xWeQsaC
	 CcDXVOBbWUEdogZhlx9C1krGnRhURfjgEzjV2zstotJJKWM+zV6iNhfOsfGcoC6ZjMCSS
	 9tMIKzNe30naZ9E1m4NEKaaWg8gDCf24/xmruiB1MlU385R0JoidFrHOE8qgTVp0xMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352401;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ud8T4mdbdPPGU2+VlHIdj3ZjRdWxPiYqyHT55Q4BDnc=;
	b=yZVsNtaGJxp/TU/G8sgxCqGa2GocQfgEKAHT1NK6veEwSrWrRDh2ClaGmFkiO6ZYi3q+
	 qgbRDOh1RJazcLYAwmUgHGlh+Y9TeMrkzbZ51vdrILfdSmw1z2AbwSmWaakrk3grHI+Iz
	 Ys4pjDg5XSZxcxd0Z0KXSI/p/kFTXkSRTID9pXahvQGp76APE4nD2xz8jcjQay1WKpR+2
	 ganWs2SA++scJw+THzu5LzRl1BVexDM2T2Uu9JDHWrVCixKsSP/3O/659YvC0WsikNafC
	 VK17RQr1Np++XzBu9NKEsOC0XherJkoKJZLSUsOdDYBnmy550SNkbs3oN7t/68w7++w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=snTVJ7Ds;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B3860A2602
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 23:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62B3860A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=snTVJ7Ds
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8b32bc605d9so1126844b3a.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1794352401; x=1794957201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ud8T4mdbdPPGU2+VlHIdj3ZjRdWxPiYqyHT55Q4BDnc=;
        b=snTVJ7DsTTatcwZgyt0NTW6EYGJKr6B64WkjFf5RVm4yiATGep3mDPMkX4RnEjXD3n
         Pu5ALpzpm0Q21OSzW53ixtUWFrMWbUXIacAgn2+PFY/5l7c8COUYVdp5V90yzMCWbijf
         D9aM4ULn6F29luQmYN2YvCKj9vrsEZsI4VDDbNcrS5A2St5QZcxDsuSBEtF1acgSqQSx
         5NaSPyLDICGXkWsglr9BAzD/QFvRTFEIejqqnr4nMbOGn/2Ptccua0QyGMJGFK0e1xAL
         1KOfCfpUoOmj9XKSx+OEhk44Vysw2FD4+BmCso+9DL0fXM6k4GdYPNOtC8EqfUreGZie
         PfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794352401; x=1794957201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ud8T4mdbdPPGU2+VlHIdj3ZjRdWxPiYqyHT55Q4BDnc=;
        b=m0savDMHJPioAAPD2IXOtI9AJKwm+vM+zumCvi18lPkcMR0mC2QAO14Q+H3wzzeKhG
         UlmEHZjCP0HPXpd6klUrW9/4I+A/1fqqA7DHZ5jAk6aHKqqhBT3GDfOG2yLQdpHkrtA4
         V9ZbugSBgkGyy955mamlp13S0e4Wl7RkIIkEERwvdnYJGUlL0tbQ5COaNSPynvlzpHbT
         FPzFeX+zomliHEKPuKkePazPNvqHiHj2KiEEMxznRe5Yyg73RESZA178aclmRhl4+gVm
         uQDHiFv4/3C/xixdGnJtl2Fw93jFW04W2n31mTYW4V8atJxLlPURgNLSRBjGkkeWWVzH
         75Qw==
X-Gm-Message-State: APuU4Z+uGV9VpYlFvhjEiU7lpoE159N8nxaEu9sIkq3uB66AVl4ZV9gb
	k5dwoHetU5zxVF/+S8reQWl2SZCqiCdSeBf1hvCZ9/EzJR5uGDEHy+wdja/wIZnPbcSDfpPbseN
	DYZ5j
X-Gm-Gg: AYBFou0irN34MOICQAf70gLrJJQfpQ5xKFSao24YFlrzAPoLdflxoZLnLcKIVRhSG2C
	fqttYWAejsznCpQCDnwK2oHBW5fpA7OwzTb8mJHBSgFVH1BjTsqN7ypAB63uFNodQSUPT91y2y+
	flsTrJa/7QWNlkIJny2Kq+WBXu2eYgOTU5NlKC8Eft78DWDAyqaiWGrL8WKEUuSBdSACuBbKsui
	7ONSoQNTJpCCJjAoOV+VvFyqTg4TYBnMAuLOnVZtdw1Ya6+kDZIz2aGgYxpdPv9xJR5NBRXyfZk
	KqBpuO+Yyhc9jdMk6FNLg0N/N5SPzKY0utCqp6c+bOPeu0oEkGjYYI0ynUOk4NeltvvaSigiPq2
	YHHvXa90OwIxO7Gcivh0hPIMVceld7AEO4hqTbfJUfSISXAhbgpIlBWIHhk0XmQj9s377QGcWjE
	22cBcjzrvlYj6sEriPQ358C2F8Qd/MVBBWJYuHkjLED/u/BG1xiGSU07kYQXriJis3ShwcfZkD/
	jY/7agiT/6Ocmb8KLtS/uU08wirEnaBEggJhyxMibsKhLX9FJhf/2nYoRC9ROr5476GRU4Upc2W
	xkBqRG1ypfo2vvS8nAmtM2oDNX6KF1lsh6P/gQhdwsY=
X-Received: by 2002:a05:6300:4090:b0:3eb:ace1:4b4a with SMTP id adf61e73a8af0-3f2feedf19dmr618205637.71.1794352400889;
        Tue, 10 Nov 2026 15:13:20 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:40::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaa1b27cdsm1353357b3a.19.2026.11.10.15.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 15:13:19 -0800 (PST)
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
Subject: [PATCH net-next 2/5] net/mlx4: factor csum flags into mlx4_en_csum_flags()
Date: Tue, 10 Nov 2026 15:12:56 -0800
Message-ID: <20261110231304.1859217-3-joe@dama.to>
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

Extract the code which converts skb csum fields to WQE fields into a
helper. This helper will be used by a follow-up series implementing
software USO, to reduce code duplication.

Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/mellanox/mlx4/en_tx.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_tx.c b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
index 00210dbae1c3..f6059b533eac 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
@@ -861,6 +861,16 @@ static bool mlx4_en_build_dma_wqe(struct mlx4_en_priv *priv,
 	return false;
 }
 
+static __be32 mlx4_en_csum_flags(const struct sk_buff *skb)
+{
+	if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL))
+		return 0;
+	if (skb->encapsulation)
+		return cpu_to_be32(MLX4_WQE_CTRL_IP_CSUM);
+
+	return cpu_to_be32(MLX4_WQE_CTRL_IP_CSUM | MLX4_WQE_CTRL_TCP_UDP_CSUM);
+}
+
 static bool mlx4_en_prep_vlan(const struct sk_buff *skb,
 			      union mlx4_wqe_qpn_vlan *qpn_vlan)
 {
@@ -891,12 +901,12 @@ netdev_tx_t mlx4_en_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct mlx4_wqe_data_seg *data;
 	struct mlx4_en_tx_info *tx_info;
 	u32 __maybe_unused ring_cons;
+	__be32 op_own, csum_flags;
 	int tx_ind;
 	int nr_txbb;
 	int desc_size;
 	int real_size;
 	u32 index, bf_index;
-	__be32 op_own;
 	int lso_header_size;
 	void *fragptr = NULL;
 	bool bounce = false;
@@ -991,12 +1001,10 @@ netdev_tx_t mlx4_en_xmit(struct sk_buff *skb, struct net_device *dev)
 	/* Prepare ctrl segment apart opcode+ownership, which depends on
 	 * whether LSO is used */
 	tx_desc->ctrl.srcrb_flags = priv->ctrl_flags;
-	if (likely(skb->ip_summed == CHECKSUM_PARTIAL)) {
-		if (!skb->encapsulation)
-			tx_desc->ctrl.srcrb_flags |= cpu_to_be32(MLX4_WQE_CTRL_IP_CSUM |
-								 MLX4_WQE_CTRL_TCP_UDP_CSUM);
-		else
-			tx_desc->ctrl.srcrb_flags |= cpu_to_be32(MLX4_WQE_CTRL_IP_CSUM);
+
+	csum_flags = mlx4_en_csum_flags(skb);
+	if (csum_flags) {
+		tx_desc->ctrl.srcrb_flags |= csum_flags;
 		ring->tx_csum++;
 	}
 
-- 
2.53.0-Meta

