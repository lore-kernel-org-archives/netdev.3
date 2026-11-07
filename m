Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794053853;
	b=IjW4mJ20VKxT0JPjTzo1bjUceonhP3VvSrklUHZ3T3h58z3lxaiTiuB50bgY0hJvIhyl
	 Y/v11JlGv5Qe2Jkd/uAxqVYxTbOnH7tYrHhCLxFosT4cSjzHq1bZRC5wUxAaJ9t63E0LM
	 RzV7CgkguYvmRO/uguPkuTUJdYt47gm50+NXwXYuh9e0CUIWb5S9f2xFNS/cdnc2mie2d
	 7WnqNLt70I2NyZ5ao7rU940pkotNZZ8fwB2dHPVhiU9ywytQrCkRk6/kD1u0p+SlnZRzH
	 wiX7N0777APj82eMtuC8hPfOGRND7qIbU4pOfMtiZw7An4lIousaZ9Wr8wleYSSOMJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794053853;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=r7d2u110vgId5VcAx7ZmIIMBF2RWq5JXTDegiuYu42Y=;
	b=Um13qdFqhF+MNYlu0MM6MTmLZ22HxVvoUF3q9huCAyg+Al0GZKRYQnN6ULMl127qLCo8
	 6eDNdU2NylOiu2Cz6KTRU/TKAYGBol63mOllEMXREjIjN5yxPvMCDOUHCT8CgLtuG3PWq
	 FXZj5aaApXiBqXH+ywDYh545TSsWNDVZvVEwTi+AcHsvMAKSDFqbPLIz3MkYK30dzGGCj
	 rT6JlUx+qUPVyy32uF11FHEmgMxVxVvNaB2zlTOct1kZbnb1lT2CirJafuj4G1KMlJ4/p
	 o7D9mu0yAQudyTbBQ8qIzE1PDRR+0FNxzsuM9QUUvRlBTjznrWlw50kyD0pSRMKXcxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q8EWSiZM;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E1D606A333
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 12:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31E1D606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q8EWSiZM
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e987a2ba0cso8051355ad.3
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 04:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794053852; x=1794658652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r7d2u110vgId5VcAx7ZmIIMBF2RWq5JXTDegiuYu42Y=;
        b=q8EWSiZM2HOkbFLTdZysm17TtN4PRfWQYA0iT3i7B7UcXnxbg9js+hzbc8AS4uDA92
         whsy44cpBAT+WFTV9E8pSK1fmpwT8RCgtkfKxTzwVFfla/W01PZAUIwnPH1dNuWfOuwi
         R0NoVTwrJggoyhdnG9jrs5iYbxKrWr96aDvswp2PkiY5/HJNrXD+xkulPsSMlEmzk2n8
         I0/fqrdDP3VJQcMRb25+eN9OZ/KFmiQlJPXACrNuAw4VBm/Zex5rtjthD6fqO7LJ4fez
         FQVdegfe1engB7cvUL6sAGqef/dNH5F3j4TsSUAKZgfQgmzUK7XJuK8xq1R8J2wTMmR6
         3gVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794053852; x=1794658652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r7d2u110vgId5VcAx7ZmIIMBF2RWq5JXTDegiuYu42Y=;
        b=MkQiQND7a2mcR6Sl9Mu/J1ErPz8Gfsy71lVAl5lJpGWJ5xhtBpuDZBovWqwDx0n4Dy
         TK6B4UHkklp43QZpsca0JletDjY9JFlsuFihPC7RcGRpStIhuUOzEu+KeTLozSF2RJTs
         XPXadA5NHoITrzFkSh8X1Nx2byaSH3+kGPz2e83vnPoJwmD7oHxpHxvPDjU3UlP1+m5H
         cQ/XuF0aMQwkv8K0PMPmszk9JudD7ofb9j402eQUnTfuoerhL+cOOThi5b3eVC1RYRtQ
         DE4tx0PjzQuCdhZCnkRHQxiACMT++JAbrgV6NAwUwcVlJrGqmV3hD7kyTcr9AJDoS0rh
         LKYg==
X-Gm-Message-State: APuU4Z8WjSi5qR1J0SVYC2nxyhsnm1qpjvJPyk1kuqaPN2Wf7TLScLMB
	q1XZm0PW5wuQmUvsKSK2G6NJ/loNNBS6PArTIqjUY61A+/QUW/r+gcAzVUWZKHABFX0=
X-Gm-Gg: AYBFou2ywCOMIGhFUfUzroYcZ5KXyvrc7OG9kJO4dLMAxtUG0Ih20X5Ve4nGjAVkbGE
	PSygM+5cplDbypESCT1RQCbj0YluuRH+/YPeMndFC8zqLqoUluMHTQSM2a7lmbs9dqCbp9eNTG9
	X/M3Xyzy4JFeH2eZib79GTS6CwwsUdtS8rnsBsNAwFc5cclXJL1w34Pu6WwzBpLX0f8yd3XhEjT
	QexxEMwFd3G5BNsRn2yFZg3j968eKv56bvLxHcRCopwETeWNdhJScBR/weNfpsjyIq5Gp3V2U9K
	6DP5TMQ9tuNMXq9D56pWKCKROASATpb13ap9FsNsFPsuXMcCHELRRcaZyztSoF/U5ezklBZrAgH
	NHjJ90p9mUnDSDCWbo5h1sdta5wikaaTdz8dL6g7iH6SSEENm7qxUUi77nlz/NQHtEbklylP9HS
	ipe7pfl0bhz5hiel4NM3hPn96lzaNUhvR6drqsSEfN4fuvGmMJA7e4/yAOldYjBl+4yVpE4itL7
	yu2stxsjF/FSZrsGflPFtEoF5fQzvtggi08ptEBMYePsoRk7JQ8d0Q+pNbCKQfQbPCyVojO5CzZ
	Gkzo5yC37udoNtiAMAqQee+TnFFD/h3ujJEb7eiHnvGveWW+MIp4Zw==
X-Received: by 2002:a17:902:ecd0:b0:2ed:697:884b with SMTP id d9443c01a7336-2ed40989926mr60138715ad.12.1794053852416;
        Sat, 07 Nov 2026 04:17:32 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d5f35asm12773555ad.49.2026.11.07.04.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 04:17:31 -0800 (PST)
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
Subject: [PATCH net-next v4 6/8] net: dsa: motorcomm: Rely on port isolation for conduit port
Date: Sat,  7 Nov 2026 20:16:27 +0800
Message-ID: <20261107121631.1040612-7-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107121631.1040612-1-mmyangfl@gmail.com>
References: <20261107121631.1040612-1-mmyangfl@gmail.com>
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

With every port fully isolated during chip setup, the conduit port
already gets its one-way isolation (drop all packets without tag)
there. Skip the redundant handling elsewhere.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 52 +++++++++-----------------------
 1 file changed, 14 insertions(+), 38 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 32701f9e687f..1b05ac29ecd7 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -1125,7 +1125,7 @@ yt921x_dsa_port_vlan_add(struct dsa_switch *ds, int port,
 	int res;
 
 	/* CPU port is supposed to be a member of every VLAN; see
-	 * yt921x_vlan_add() and yt921x_port_setup()
+	 * yt921x_vlan_add()
 	 */
 	if (dsa_is_cpu_port(ds, port))
 		return 0;
@@ -1170,10 +1170,17 @@ static int yt921x_userport_standalone(struct yt921x_priv *priv, int port)
 	pp->hairpin = false;
 	pp->isolated = false;
 
-	ctrl = ~dsa_cpu_ports(ds);
-	res = yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port), ctrl);
-	if (res)
-		return res;
+	/* Conduit ports should by controlled by tagging completely, skip
+	 * setting isolation to preserve the one-way isolation installed
+	 * by yt921x_chip_reset().
+	 */
+	if (dsa_is_cpu_port(ds, port)) {
+		ctrl = ~dsa_cpu_ports(ds);
+		res = yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port),
+				       ctrl);
+		if (res)
+			return res;
+	}
 
 	/* Turn off FDB learning to prevent FDB pollution */
 	mask = YT921X_PORT_LEARN_DIS;
@@ -1948,8 +1955,6 @@ yt921x_dsa_phylink_get_caps(struct dsa_switch *ds, int port,
 
 static int yt921x_port_setup(struct yt921x_priv *priv, int port)
 {
-	struct dsa_switch *ds = &priv->ds;
-	u32 ctrl;
 	int res;
 
 	res = yt921x_userport_standalone(priv, port);
@@ -1963,27 +1968,6 @@ static int yt921x_port_setup(struct yt921x_priv *priv, int port)
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
 
@@ -2282,9 +2266,8 @@ static int yt921x_chip_reset(struct yt921x_priv *priv)
 static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 {
 	struct dsa_switch *ds = &priv->ds;
-	unsigned long cpu_ports_mask;
+	u32 cpu_ports_mask;
 	u32 ctrl;
-	int port;
 	int res;
 
 	/* Enable DSA */
@@ -2302,7 +2285,7 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 	if (res)
 		return res;
 
-	ctrl = GENMASK(10, 0);
+	ctrl = GENMASK(10, 0) & ~cpu_ports_mask;
 	res = yt921x_reg_write(priv, YT921X_FILTER_UNK_UCAST, ctrl);
 	if (res)
 		return res;
@@ -2325,13 +2308,6 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 	ctrl = 0;
 	for (int i = 0; i < YT921X_PORT_NUM; i++)
 		ctrl |= YT921X_ACT_UNK_ACTn_TRAP(i);
-	/* Except for CPU ports, if any packets are sent via CPU ports without
-	 * tag, they should be dropped.
-	 */
-	for_each_set_bit(port, &cpu_ports_mask, YT921X_PORT_NUM) {
-		ctrl &= ~YT921X_ACT_UNK_ACTn_M(port);
-		ctrl |= YT921X_ACT_UNK_ACTn_DROP(port);
-	}
 	res = yt921x_reg_write(priv, YT921X_ACT_UNK_UCAST, ctrl);
 	if (res)
 		return res;
-- 
2.53.0

