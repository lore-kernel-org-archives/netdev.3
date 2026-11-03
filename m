Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714488;
	b=QwJ+GBPZNUuxO2z7F0wGqB0ls8TbWJPekq1r4NBRGiYSGC3KDm9v04FwNHvgVooFBnKt
	 hpldzcCwHmhTjN8+LthVzdJQg5iwsfGLw897DsDNSZYwzPAGtd1GkSHrEi3rsE+I73gcr
	 VvEXPuiA4slFPTJLaf8/KXH8IO3x95HFgTphUnpbtBcymxFMnCK/gPdx3c6Nt0hjdP7gK
	 meYsDIy/Qz3hKt+8tKrxBKzXFq/kjcKegUGJHigWLb74yUVOnOuDysBMxGcQrrrWvscBv
	 uqPzyMOQ9CKcihS3sfiiTWX4g4x8NPtJqa0b+SCbDDUV+trQggUtTHtQwXMSI2e2LXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714488;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4eUqzqxgaskgzb2volApOaC2VlmYkG23yLlDeBP9Vhg=;
	b=LmWifhbmObdDw9ED8bYkPsjpa7aXfJ7HHaYxby7xjb/lh3fMjTMxRCgK7LuqObtqftjs
	 GOAbAqA6oo6MRarUayCCdj40O52THMa4pREKEAryK/fcHL+kFVLbK/oHwJXkAx6ceHrz9
	 eTjx492FFVaPlRNQ8cX1mxDWcYXUx7ji3miiCspwTlp05MJk4G7t81F2sbDB/3H6D1I6u
	 K/C8nxMPIu7+IFnN8nOGMSJL0RHS1b23nyvJTFRpf2vj11Qjjd/ZoNs92ul7ZQ9+m1V33
	 E5Or4JZYaiBG55P+FiOfvlDYdteeqPaEK/8Bqj3aLykFNd5qgjNIE9Iq+orktFLERNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eIWa5lHG;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713486082BE9
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 713486082BE9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eIWa5lHG
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cdadf7e248aso1526906a12.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 06:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793714488; x=1794319288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4eUqzqxgaskgzb2volApOaC2VlmYkG23yLlDeBP9Vhg=;
        b=eIWa5lHGv+0wU7rKPq5o27+YSznAidM1p/G+zk90vb3L7OPPb0288yfk9XqmSefxb5
         YKKXh8sjT3Dndbb3IlWBDliODfhz5of+uzkJ2wBnZ6AHna5s6FTFvStIwH6eMYIiR5sx
         W3MK21SLy061IyWhlwzq0ouGHtssojQIE4P2wbKTEonSw1WG5K7TatGay+gj+AibcyUm
         RYnIVxvj8VcReq9k2vD67k2exBdkrRR3YafaYvG2fi++3hp6UBqTawc6YbcPCWmLa7Qy
         s2JW7e776wTlVVTrq2q6+6YQYKxzpbnVLRM6xOOFZwQWqe6mnZ2DGU7664TtUdoRx/1k
         l1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714488; x=1794319288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4eUqzqxgaskgzb2volApOaC2VlmYkG23yLlDeBP9Vhg=;
        b=OQLwVOzc07llNwdrcRq2nhf7ihsWQ/XQTeUNckC8y/jjkeNm6uoue510RE5R91YcE1
         3SD1Fo7hmvDCkasqOBb2OVQyYqsea2Z9FMv5FSbWIaOQwtnovMtyeHMPWLAuLbwmT2Hl
         dR8ImGIqFDEOilEDigBtfOAx2WuO2a+G5sMI/lDHmQMBHFMZexWcoVRv3zjy4PsPJauh
         gseWFddL6LasoQyYSSfEuucoe8l3mliYTrdqFDE4vLwaz+Qgj7zTBjPfoqzmUQ2eRv+p
         o38E4vQiStELkBMbLb9B0JGlfNykbMhB8P+1/id2TfHzLb3Fmcg/TkECj+oppVldk1rN
         B5Fg==
X-Gm-Message-State: APuU4Z+rzmGj1DT73CFveIS6vV1x6dzkAf32lQ9MUVds4mVp+ItBlhHD
	6wDzznUlkGzNtMT3vJEluZ/3L4Rcex2/DcI/D01UCzwbTd4Qe4yCwxSVCml2ew==
X-Gm-Gg: AYBFou2jXVk9V9/0id5WezHVfuHPFyEMfc+fMY3qXe73SBlu0S5nU6ffBd5iLZLh562
	OoH5Bzh4xluL80tHBT777TE6qvebeGkB7I/aDpAG6dpYU2pUBCZ+ffHX2S899/AjqLjWf6E7/V+
	NdxdAYR7PRbC8kpA8133Lw0YuO+JvFFybcvpakCMMn3+8vuIwsZ7sMltvyuJENywBRenzrJxUPN
	iJJbmXM/R9ZEmYKsSkIjY3nV2uMN+hhCyPMVXdbfkfaQTIKV6jTCt20BOxQpfTDl+Oc2LquI/h9
	t/2VDVkMl/34mo2UpyRGFvVuwvGyTmEz2ESEsYIXmQ7Hh7RUxo+RaUrd5ZGNKvURcVAPuPOZLeF
	53h1gRHIVOII7Pz5PzHSdM/Lc77g6ZQn53bdPYFYpQROLr0AZehyqWRlRTcHQHPxSRkQK9eehbE
	KaQUxRFCDJDQb8+NF8dzeUp8TMckoArOOIuwPr7k8bAGOpAaVvg6232XXQ84dtHzo2GDO6lRPkn
	knjXqOdz0Rj1gbLjdXSQ21QG/uwet6dORy5RaTe8m+8OvZpYVjx49+Sa/MVyLQ5FNIc5eY/D7Zr
	SrCcxy587UppWFaVzSeEMk/+t/isVs+YGyRwKm1o/UXWZhD24SUq
X-Received: by 2002:a17:90b:2c0e:b0:3a4:6f38:f2a2 with SMTP id 98e67ed59e1d1-3ae897f619fmr7495122a91.25.1793714487557;
        Tue, 03 Nov 2026 06:01:27 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:28::4:396])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c8460acsm4722104a91.7.2026.11.03.06.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:01:27 -0800 (PST)
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
Subject: [PATCH net-next v3 2/3] net: dsa: motorcomm: Rely on port isolation for CPU port
Date: Tue,  3 Nov 2026 22:01:06 +0800
Message-ID: <20261103140109.874443-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103140109.874443-1-mmyangfl@gmail.com>
References: <20261103140109.874443-1-mmyangfl@gmail.com>
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

With every port fully isolated during chip setup, the CPU port already
gets its one-way isolation (drop all packets without tag) there, so the
dedicated handling in port_setup() is redundant. Skip the isolation
write for CPU ports in yt921x_userport_standalone(), which port_setup()
also runs for CPU ports, to keep it intact.

Consequently the CPU ports no longer need to be excluded from the
unknown unicast filtering: frames entering a CPU port without a tag are
now dropped by the port isolation instead of the ACT_UNK action.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 46 ++++++--------------------------
 1 file changed, 8 insertions(+), 38 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index e1fa82c6db95..fb993cc9607c 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -1164,10 +1164,13 @@ static int yt921x_userport_standalone(struct yt921x_priv *priv, int port)
 	u32 ctrl;
 	int res;
 
-	ctrl = ~priv->cpu_ports_mask;
-	res = yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port), ctrl);
-	if (res)
-		return res;
+	if (!(BIT(port) & priv->cpu_ports_mask)) {
+		ctrl = ~priv->cpu_ports_mask;
+		res = yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port),
+				       ctrl);
+		if (res)
+			return res;
+	}
 
 	/* Turn off FDB learning to prevent FDB pollution */
 	mask = YT921X_PORT_LEARN_DIS;
@@ -1942,8 +1945,6 @@ yt921x_dsa_phylink_get_caps(struct dsa_switch *ds, int port,
 
 static int yt921x_port_setup(struct yt921x_priv *priv, int port)
 {
-	struct dsa_switch *ds = &priv->ds;
-	u32 ctrl;
 	int res;
 
 	res = yt921x_userport_standalone(priv, port);
@@ -1957,27 +1958,6 @@ static int yt921x_port_setup(struct yt921x_priv *priv, int port)
 	if (res)
 		return res;
 
-	if (dsa_is_cpu_port(ds, port)) {
-		/* Egress of CPU port is supposed to be completely controlled
-		 * via tagging, so set to oneway isolated (drop all packets
-		 * without tag).
-		 */
-		ctrl = ~(u32)0;
-		res = yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port),
-				       ctrl);
-		if (res)
-			return res;
-
-		/* To simplify FDB "isolation" simulation, we also disable
-		 * learning on the CPU port, and let software identify packets
-		 * towarding CPU (either trapped or a static FDB entry is
-		 * matched, no matter which bridge that entry is for), which is
-		 * already done by yt921x_userport_standalone(). As a result,
-		 * VLAN-awareness becomes unrelated on the CPU port (set to
-		 * VLAN-unaware by the way).
-		 */
-	}
-
 	return 0;
 }
 
@@ -2276,10 +2256,8 @@ static int yt921x_chip_reset(struct yt921x_priv *priv)
 static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 {
 	struct dsa_switch *ds = &priv->ds;
-	unsigned long cpu_ports_mask;
 	u32 ctrls[2];
 	u32 ctrl;
-	int port;
 	int res;
 
 	/* Enable DSA */
@@ -2297,7 +2275,7 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 	if (res)
 		return res;
 
-	ctrl = GENMASK(10, 0);
+	ctrl = GENMASK(10, 0) & ~priv->cpu_ports_mask;
 	res = yt921x_reg_write(priv, YT921X_FILTER_UNK_UCAST, ctrl);
 	if (res)
 		return res;
@@ -2320,14 +2298,6 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 	ctrl = 0;
 	for (int i = 0; i < YT921X_PORT_NUM; i++)
 		ctrl |= YT921X_ACT_UNK_ACTn_TRAP(i);
-	/* Except for CPU ports, if any packets are sent via CPU ports without
-	 * tag, they should be dropped.
-	 */
-	cpu_ports_mask = priv->cpu_ports_mask;
-	for_each_set_bit(port, &cpu_ports_mask, YT921X_PORT_NUM) {
-		ctrl &= ~YT921X_ACT_UNK_ACTn_M(port);
-		ctrl |= YT921X_ACT_UNK_ACTn_DROP(port);
-	}
 	res = yt921x_reg_write(priv, YT921X_ACT_UNK_UCAST, ctrl);
 	if (res)
 		return res;
-- 
2.53.0

