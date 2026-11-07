Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794053842;
	b=HLH4ccziNYh5XfkMkk+PvNuc5NROt81EEoXwI2OE3rMlA+/NRh7EtjNAnZGQtk+NdjkQ
	 GSmLneXNX9JckJKSow2fwZRbNsl4KFEwkYAw4ZKvFIFloOoHWb4ziMdLe9+Cn+SHl4IBx
	 kAbpFQTSyNkc/3aNlINHcdSuur1LetUfjcPjH/NMEP7s1LP14awVJs4WJHFY/N4cgQq2g
	 fHGwMhBrMwfjN/lVsw1WJfVrzIO/Va7IZftyLfCZ3DcY+8eVnjWtNTBFS60mXe4lKzzCH
	 xr4XGTeijZIaFMoqWbIe6CfssUh1Pg2/R5/sgANBX3HPi+WxGhNfBrAu2FtiJxk+hww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794053842;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=r6IZKgn5NP/PSJ6/x6wK0tLeYozouVCBtxsXOn7zuVY=;
	b=PGtk9a1WLpG55dLiJDAxje27I19IjwQnETfcJFzzD+sGkpDB2899Qbb1aRksVcnx9ZD4
	 hEI/TrBMucOppBEQocO18Plr0AIdj02QXGz1lBFruamii1gFKHLtKHQpO8r4DBZ7f/KGM
	 WXtLIivgZffW9h99L7IXpdUum2FAzKzKU1h+9P8Z9HGaJUlIKBJ+ZHG1bnNvf6+8U0/Il
	 CPVsgyna946PgI314qxk8ZyUI7psMzeDDkeIge3DHf4xPVlc5xy5lmMpoGhFOu3TTdk9M
	 E6IQ25M8Qh+Vw2tta9ovBCiUJvGQ7yHagA7t9Z7kpGzlLHMIHnwNQLo6LwSLrLLtEUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HrcbeUYZ;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEE2606A330
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 12:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AEE2606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HrcbeUYZ
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ed1e9ae5a8so5062885ad.1
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 04:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794053841; x=1794658641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r6IZKgn5NP/PSJ6/x6wK0tLeYozouVCBtxsXOn7zuVY=;
        b=HrcbeUYZxCcTUeDyJm40+nN1p+1vcWF5/QF/NIr/1JSIm4ix1TxnUD29bbXYlf3TEk
         VMDhWMB4uzYpLZ5gzhOEGr4i1BNi/+jObFW84VWsB+yygHrnyKXpe5ak6l+CSDbiUt1c
         c0/GKNME/BmROVjY0qlLbmknWxXD6rG5MJCPFnBxWWiGZ8EtAkhl3jxM3EzL+o+/4aAi
         1zMXbUcg/Az7H8R/uhhCiEICOUw1vLiWrG63Rh7vgV7ccqOjSBNhIleXKoxiFouMGlYP
         rLvnIQmW6NzhC0aC+BofMKaf4TqClEzdeC+xbiwjM4Z9Anm5TaZxqUcE9kbuV8OxWNOn
         t7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794053841; x=1794658641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r6IZKgn5NP/PSJ6/x6wK0tLeYozouVCBtxsXOn7zuVY=;
        b=i5q7NM+qbNY7/mZgcPFJ1rtrx4jCfzv9jhd7Ocyb5LLgqoII5dSku1a7yOPHdxbKNk
         +lIdohuMphedf2pqyvto2lbtB+rKmGNMxJfBGSdnfTNZFo6K9SX9bFYzVKt/gFiGKFv1
         SyjCPrH/54FNw+knNqTrCoAoL5OGa91o1MFFRa9DnbZvGEIUWo/Xl2GZztT3PmBTdK+L
         BTM/+gJNQvljdHMKZ6ztCdkZh4lfMS4KHay61XgZ7eJm/XHvsY3yt1Q+gyuGRBWbRtQH
         lZNi8hT2L4zckLKoJDQUFf9oa4wQtWJYU08krCg4I31UotrvpwKqawS144+VqF7rJO4i
         w7Gg==
X-Gm-Message-State: APuU4Z+902nX/txcXrtoCuIazMPvcJeFLIqzdGQHGulqjsVSLHtkF+77
	8ZuPfbkxS5HRXUDu99fZdagRDSP6LE0TiS+s3S/teuQ6hZdS8SUeYTOsJVEJPh1z1c8=
X-Gm-Gg: AYBFou1K7xvLZSYeEb+MeVzzNwMnZsE6pIi2U9XNQQgNrz2xUSo9BzECuPjEmqSzEQi
	3LqRbiFu3DdLcnJgWdp0WoqElXcbdgpCyQVU0rWs5XD+YByI7CE1BVwamwtJA7n88uDx7e1rrYt
	Z/9u0i+tnY0Tf6VsnmogfBLm32Pia2LTA6aCX4lWxZys0/qL0oh/NOoUBHvobT9WcBMtB3mnxpc
	4xkdcaYtt1XVeCuQ/zeAjgPzyz88IP/FTvSFqS14/da/Kz1NskT7LoJukO3JwOb9eMB7iK2Qdx9
	f9yANPZnQX7R/hqO9OICWldTtOGHtYHMgq0qLN7gDXE5yOz2e56/EnxzKfra8nMP+umoKIVoO0r
	DdY7iDnjUxMONdhZurqZasnz4+mYz+84AE7G7TtjkHT2mrBSn9m8FebLoCF8T+P5SIrEG4zgjRx
	JizGEqqFcWFLPY0XvNMl4uNx8JnWUvbDDb/1l7eldklp2yBI+B4N1lq1pjp8tknT+/IjHS4SBkz
	Rcm2ULO1cvdjKIm4XS7q1XXRITJ7ZkHHdCJC6XZHlAlEiN0vNTqI/XXOTynwKxoExevtnjczYUC
	Q7fN2JX9Fl48LC6Rqs+dy5To2CPblxAMh1++Vg2B4KhOLv0y5CDoTw==
X-Received: by 2002:a17:903:3d10:b0:2ed:38c0:3328 with SMTP id d9443c01a7336-2ed40bfdee9mr64833725ad.28.1794053841231;
        Sat, 07 Nov 2026 04:17:21 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d5f35asm12773555ad.49.2026.11.07.04.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 04:17:20 -0800 (PST)
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
Subject: [PATCH net-next v4 3/8] net: dsa: motorcomm: Reset port flags on bridge leaving
Date: Sat,  7 Nov 2026 20:16:24 +0800
Message-ID: <20261107121631.1040612-4-mmyangfl@gmail.com>
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

DSA does not clear BR_HAIRPIN_MODE and BR_ISOLATED when a port leaves
a bridge, so the cached flags survive into the next bridge join and
program stale hairpin and port isolation state.

Reset them when leaving the bridge.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 47f06945b8c4..c51491ef4dae 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -1158,10 +1158,17 @@ yt921x_dsa_port_vlan_add(struct dsa_switch *ds, int port,
 
 static int yt921x_userport_standalone(struct yt921x_priv *priv, int port)
 {
+	struct yt921x_port *pp = &priv->ports[port];
 	u32 mask;
 	u32 ctrl;
 	int res;
 
+	/* The return value got ignored by DSA core, reset flags before touching
+	 * the hardware.
+	 */
+	pp->hairpin = false;
+	pp->isolated = false;
+
 	ctrl = ~priv->cpu_ports_mask;
 	res = yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port), ctrl);
 	if (res)
-- 
2.53.0

