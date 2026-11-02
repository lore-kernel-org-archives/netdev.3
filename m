Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793635117;
	b=gFCyHXuB2q3baHpsHlKLLaEHI94iwLrUofz17JT4Q7eSs7WmWaJo5HI+fBg22VZjg9y5
	 pthliFDlPWPSVdozmLa9jgQYkq8SKBaUXcivgSkxvttXP8+qFXFMzJwcd9mNGZ89uG7F7
	 z9Xv/5J8tvUX2Lh/f81frS/JQlVsW6iuNvkaRvEo5ZGKTXrXD2OurABtYWUWZqSJQPaW0
	 XuQzg3m4aZyjzP/yFhHiyFjsJhG17W3FJLdHLN9HHGxrRt8sI/fmUomExFTy+uhMX2Ddd
	 94KtMPNUZD6QVra0llF2QEJt9HNREg+I7UFs7pfsOoBEiVg7qFvFAGN+Vxtjf8oHdKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635117;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4eUqzqxgaskgzb2volApOaC2VlmYkG23yLlDeBP9Vhg=;
	b=tD8/GNbq+E8KhCjfH8j3rMnEn1UENrR/9e/PmlNSlN+clwliMHH/B2hh1lA3ryIXrYlG
	 nb4sfXawiCrA8LLSauWb/7z/FRWUmW5KHhhZ0wKQhWquu6tU6DYaCt+IxPNJmJzPtZrrY
	 at8Rv9Uf3EKMeoSV5Y/2cpSvnsldIngTMujTMlVNg/SwjCM07jbtIpsnaHB5kQTM/us8v
	 ZC02sbqrLylcjrf3MVuQBJ9lalLfToZJ2NcR5vff4lyHViI21wDHLv+gftiSOg04+flo9
	 Y7YL9I3wiLCA1Q9DwXt2dSJYX5Hy3fCoEaeTongQbV3gT7zlBetgvYuAxxvjhn0YjPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s93cnhjh;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CAE60AC6FB
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 15:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97CAE60AC6FB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s93cnhjh
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3adc4590de4so2528355a91.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 07:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793635116; x=1794239916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4eUqzqxgaskgzb2volApOaC2VlmYkG23yLlDeBP9Vhg=;
        b=s93cnhjhLER8VVXRcDFSD6Yn5w+jsBgTSIebxNT0GtGyLiKJgkKnc05IXZMvrYQDCY
         hslIby5aGenm3Nk21M2EchnwDKxc1TwJ+KbZq5C+EcvnVnwvTVemqb+dsuESLmkmhZCs
         ktiowN4nSFalA7G6CV7IDn2yrePEtDMYRuuFdj4rXKse7OBpkj5Gx0a6278AgHLEwBIH
         x4veqgxF9oHfRLGmA+Y7VOOu7yjNDfZV+vpv0AC9KMYMmbWJf1u32PvPRHg7ecki3pBA
         Yaj1yB827Fk52MAr5oCOnkj/4f36x7VrHQzcnAedd5LktIL7yVM3dSPiHmTkzOudOnxm
         tHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793635116; x=1794239916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4eUqzqxgaskgzb2volApOaC2VlmYkG23yLlDeBP9Vhg=;
        b=ZEXtl6ZNf9UoiUJyjJbynu1RX2hj270eLvte+4q1GP4/huFDO03eNdkg6W6XdIYZ0x
         BNkbJZABKHHuBPRUN9K/i0aTAuWXX1S20204yrlDdBMFZAMqI+pXH7Y8IMfFirOx010b
         Z2wXTXdTccQsE2lBG0uY/8lv47ghPRiiW0iYoJHnMYTyOuLulwMFYUEur+3hdfGu4Qe4
         HqDEIdw0WHIDF/Rz+UFWMIli2bLtWPJ83dHeKlHfO61uhLvtlUoK29ANUYwXLD/cmEpH
         AQ8ESXX7UAc62obOOJpHLMUBjW11ld2g1sMB65me8NDLMqzTwkHR+CpbfcIbZ+4us95Y
         VTgg==
X-Gm-Message-State: APuU4Z9HtO4RXdlADdNCFc9SJZZNzuWhQcFtbP3xqvzk2NGlZR2v8vN1
	j8DrRn2zjDjCU1/g7BD6YOIdbw1GnersFdvC+HBUbqgywVee+gXs5sW91+0Lsg==
X-Gm-Gg: AYBFou2WMTPI2vKh4RURM3c3PARUlUXvWKNJIcYOvrkvQAK3gp0xxxiaUhDUbdms++8
	cfEkjP9sVA1ueVkH+vvFIhi+PvjDRo0oMaf02WlzMQ0VeaExiGnEEt0jq8JRrxPuZU2mtliFci5
	RfOuAft9IErObJAuXlY86Ki0412o16nSxfUWVpTo/xNTPrM4b2kkrDCU6QJjYLhZM4VInCsox7m
	bzCh1kQb29a/b9+B9BmBebujm17iXpgzcXQwASGxRmZTpaxVG1a+jwlQmcy1A2gyLevtjjiefcu
	I8Qixr1ppCfDwGvynuRR8f47zrWbCTW2GtVJ2Y/iwFbjCM7sD3XFVa6TmNLEomTaRFmidhutnZW
	GoP+GlNC+HfcqTyjdgnmVVEKcWsKF+s2yLOlDOZ5bBjmR28bNqy7D7xX+8SuZUd/6UwtXKhxad4
	oa2P42h8E5WCy+Jmxpsh9xe4Hu0PZWqzzYFXwFHqcPWjg0KU/sjZk4fYrV2so7bVv/jXITCW0N+
	DfARYSKd9d1iJVksXrUjtIwq9HQ7H2JhpmrqdBmWdGhX7tnJUJFpi1tbtbN/hw3wS0BT70cXOj+
	2BcrKIo8wjrygtdeMbv6vnP4gayNLhX19qcvXKrpELrBD8vjyHxl
X-Received: by 2002:a17:90b:2252:b0:3a7:8c68:6446 with SMTP id 98e67ed59e1d1-3ae8987d10amr8883371a91.63.1793635115807;
        Mon, 02 Nov 2026 07:58:35 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:28::4:396])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7d429fsm19183949a91.2.2026.11.02.07.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:58:35 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/6] net: dsa: motorcomm: Rely on port isolation for CPU port
Date: Mon,  2 Nov 2026 23:56:34 +0800
Message-ID: <20261102155641.3682626-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102155641.3682626-1-mmyangfl@gmail.com>
References: <20261102155641.3682626-1-mmyangfl@gmail.com>
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

