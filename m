Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352398;
	b=KeEtav+Z8tBEqniscDzUdK9IzeT68l+boAZa186Dwf6WZnM0sap79vhmiYNWUZv9249u
	 LMOYv9YBM8T/M9Ex81vTfAgtQ8rv/hXFaZmzcaL94i2HvG9hamQSlnHbqMxrd6rW37d/n
	 JszSOaxTRuZkotqohLcjGFBjRnYE3mzorSG2/btAYXbqeITGzikhZe5JaNe/1gDht1ody
	 Cx38kUqSjgivDszW4doCRLK1wDAxumutzU6dj3UnBBfKvG5mYGokr44CTc1LBAxhPCcqR
	 djrGcKPLldcq62etUnWF7xlaZVNDlUA5AuGkb73CwvscGoH65bBAgonjlYVTs3n70Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WNPvGEKQXav9VSZ3J7/386PWbh2deprE17GmLSUj3BQ=;
	b=3aQvACa+hIh4ST7fturvrC9LvBndA/mpgr2ak8B4XYCH1vfu0U6eaM2RRbeMQy8Nmh1Z
	 QmyY926EM9gF8iBHNxA67E29qjnj0k5um0nOoMztJWnexNAFd0ffhYVHlFMxRa6EiejJJ
	 OFoCMDC91TleRyoycYzxb34oXg+utC2P8nyPkb5oVOLDAfaV+AYjccQgNShPQmmkRWMTB
	 G+UcgUw39mVpcpg2Ng/upB+C6PyXQt7ztw5/l+bNvYF7zbBvFkj9pmud9r+xvvTju2s2O
	 6S11uVH4dtDHzpxSFivmBtnvJvGl0XRBBvjHZ9GVJ6u0PcVAkbtPQaxwef5e+IosRTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kSOtdwcf;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89191606A338
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 23:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89191606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kSOtdwcf
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a9f9473029so2098715b3a.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1794352398; x=1794957198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WNPvGEKQXav9VSZ3J7/386PWbh2deprE17GmLSUj3BQ=;
        b=kSOtdwcflrPTYOJkmiuF1ig4Gx7po9JWw0+rkgtDjdQhuPJEj3dJCcsicLlHPeWxQV
         8HF5JC6ZMi7dBxkoETsI1t9vz/ghr2gsgZ8UVwXjHeAB2Y6KU5eaInzFaGs0/G/Y5eCW
         zF/SpM1eLZ/O+vx06KLGL2swCjxEl2MSban0MpTZaCQEhUqmtmxfsvldqcX4duHfxvVl
         HCjgawbylZyc/msT/UQG1mO6Ykc1SyGApMJBlfxR9EgtNzQnfhdGj0b5suSMITWCtQd0
         UOmg7cjMSdjr3MfKvwP2GKpia65QcXcPJ9h8iBs/2rk6ZAwFMkXs+EdntslcJPCl0WFw
         Y0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794352398; x=1794957198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WNPvGEKQXav9VSZ3J7/386PWbh2deprE17GmLSUj3BQ=;
        b=qEHUWjOePJftQ3BrdvI4q34nRlr5TqrNtWdgkEoG3L4VEdHdqj4fvUM67P0QE+gCp7
         klGmBDWFNYRHExFB55o2Kdoc1x9kbEVcFsJup+GWo1VMfH6Y10kvia5uDW/EeO4/EGGo
         t9OB3YXdLmOGdWqDxiXK16eLCtsz/tCVY+irsCixehthwT1jem39U6FFKWql5T1Pu/D5
         Q23uuqA6218YAYg8tAcrRQx7yAxqZ2gcuqIlXAsvbdKud2rjGhQ0vvCTL5Dzoya/ueVj
         g/tPEb5scqTUuDLy7QqyLKQqBdqF+6mQbVutlDfEEZqcT+CqBdoUEcV8X7ROG8qkvxXY
         TkJg==
X-Gm-Message-State: APuU4Z/HYCZMD0Rn7UubKVnUMNPVHF3I9ioixSNegMcszA9Igg2XVKgp
	89BcPo281siTXPjulvvJDYJAvbLcDu+Yt5e8wUtkTFCkBmI4ZbcNgmgnk4czAZZ2JtuoRGs9ILU
	AkLqo
X-Gm-Gg: AYBFou0kzWflDrvpsGOuT2v39LKAY7uZ94X6JJTCJNKa9hGCYPcdoxFjYIar3wWNk0B
	0NqzOVaD9ptbcop7WpXSX4iHAm4yAgNEaUC5s1BnJRppWf8Z6NpmEHzBJ9V/mEl4/K6yYhPMwrh
	l0CKFq8ph3rq1MYpSa/uZ+tp4r2QeHZoXzuBMolqUs3oTJfiTGc/MPJq95EyGCn4pn038GfWSPF
	HfZzj3ippFkOL9LC7rHugFYBl4TK2ehRGFIBSYfT9zf73rGuSFOBcBQQwK3YqBfCQUnz4cGNK29
	+rTyyQWycclwGTQo//YAU6KhIb3OAgMMrmWNVGSazDHfk4CgdwqC9wkBbeeZjGtPTe6P7aan1qH
	ElWwldNvC4acK7UfFe8+E+O+cw9s4hBbICKyfVgZEFBnYwA85q7RM41kNRNKuDXzP8nBeSv7V/y
	6BXYUDtIKI9d623HjqJGIpmYqwLqHLIfbrOlPns9tqG6AxvvG6+QJSe4q6lj4CCS+OEu/lGQlui
	BUFHx5WzR9tIYXMHJl4FzEBultyaGqk4xUhEOvDF1Iz+a0u4TwjZ+iVRrVem0VzU61diELaG5xL
	yyq1LQwswxw7SgIK3XbH6nuNgBrik14lUjmgWZxMk1g=
X-Received: by 2002:a05:6a20:914b:b0:3e2:5d7f:f630 with SMTP id adf61e73a8af0-3f2feedbe75mr719252637.54.1794352397968;
        Tue, 10 Nov 2026 15:13:17 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:56::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d7cf07dsm1173961a12.28.2026.11.10.15.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 15:13:17 -0800 (PST)
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
Subject: [PATCH net-next 1/5] net/mlx4: factor VLAN parsing into mlx4_en_prep_vlan()
Date: Tue, 10 Nov 2026 15:12:55 -0800
Message-ID: <20261110231304.1859217-2-joe@dama.to>
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

Extract the code which converts an skb VLAN tag into WQE fields into a
small helper. This helper will be used by a follow-up series implementing
software USO, to avoid code duplication.

Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/mellanox/mlx4/en_tx.c | 33 ++++++++++++++--------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_tx.c b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
index c5d564e5a581..00210dbae1c3 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
@@ -861,6 +861,26 @@ static bool mlx4_en_build_dma_wqe(struct mlx4_en_priv *priv,
 	return false;
 }
 
+static bool mlx4_en_prep_vlan(const struct sk_buff *skb,
+			      union mlx4_wqe_qpn_vlan *qpn_vlan)
+{
+	u16 vlan_proto;
+
+	if (!skb_vlan_tag_present(skb))
+		return false;
+
+	qpn_vlan->vlan_tag = cpu_to_be16(skb_vlan_tag_get(skb));
+	vlan_proto = be16_to_cpu(skb->vlan_proto);
+	if (vlan_proto == ETH_P_8021AD)
+		qpn_vlan->ins_vlan = MLX4_WQE_CTRL_INS_SVLAN;
+	else if (vlan_proto == ETH_P_8021Q)
+		qpn_vlan->ins_vlan = MLX4_WQE_CTRL_INS_CVLAN;
+	else
+		qpn_vlan->ins_vlan = 0;
+
+	return true;
+}
+
 netdev_tx_t mlx4_en_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
@@ -902,19 +922,8 @@ netdev_tx_t mlx4_en_xmit(struct sk_buff *skb, struct net_device *dev)
 	nr_txbb = desc_size >> LOG_TXBB_SIZE;
 
 	bf_ok = ring->bf_enabled;
-	if (skb_vlan_tag_present(skb)) {
-		u16 vlan_proto;
-
-		qpn_vlan.vlan_tag = cpu_to_be16(skb_vlan_tag_get(skb));
-		vlan_proto = be16_to_cpu(skb->vlan_proto);
-		if (vlan_proto == ETH_P_8021AD)
-			qpn_vlan.ins_vlan = MLX4_WQE_CTRL_INS_SVLAN;
-		else if (vlan_proto == ETH_P_8021Q)
-			qpn_vlan.ins_vlan = MLX4_WQE_CTRL_INS_CVLAN;
-		else
-			qpn_vlan.ins_vlan = 0;
+	if (mlx4_en_prep_vlan(skb, &qpn_vlan))
 		bf_ok = false;
-	}
 
 	netdev_txq_bql_enqueue_prefetchw(ring->tx_queue);
 
-- 
2.53.0-Meta

