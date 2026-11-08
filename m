Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794135030;
	b=kC119bSSxHCPWkqsUh7Dx0HQLdxcg1+yMBN70DdvU3jFravIKJDk+T+Q7I4Y2lwmJeho
	 MIIFPPcSvPZS79uai39vxAIXkECyWSXi9hWNY8AiiRLl9b/nQfQiMUGIVdV66cpAAM4MD
	 YlIAf/8cf+gU3lSV7HmQk1c7RmnLh3GcRUojEhHGV0wF9YPj6m1X4qYGwpH3nSC6mCzQP
	 1LbYUKdxOtJ+ez+AxMdaCYcsNYEwGpJ5gKIR6LxqRbU9vl+RV3/ahH8cs0l2H6/CvOlLN
	 bmmdjRXqR5i6dcSG7uMt271r9Ow04DIuic7LKDEy5u2oiUmdqWqZlRFRj48gONeujDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794135030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=DWmy/dZteMlGJY6PW1sSapqkw3qIXQygfTGSZR/3fgI=;
	b=Ixmohj/nHk3dwOncA1ZCls99FsPJ61+fNCTOLs3lCVrlz7nyBXEl+pF8vkamiu+LSapV
	 AsDJpwb1tCxfgzHVLiDj2MBxYa+uH2+uedC1/NJ5PdwWTO7T44ymIkgwzZNxG0tjyyJva
	 buuQkGI+dfEc0Qersqu/cXxsbvokB8VaK/1zmmp7H2Gg/ag0kKtzg4fKLhix5W5cnhAcx
	 ikcZZO+7GuseLkNcxqg/M1z0SVfLvxA6zrosfQ76QVfmpm5s4/6I47LvBDrwhpXUc0t27
	 pliIPUTxxQRxj8lJOtChPlCs5gUyB4iLIO3luG5D14og3MDHhg0FVMt9KccNMx62yUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tZyx5sDK;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9620606A321
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 10:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9620606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tZyx5sDK
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-89d6bd67045so34490b3a.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 02:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794135029; x=1794739829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DWmy/dZteMlGJY6PW1sSapqkw3qIXQygfTGSZR/3fgI=;
        b=tZyx5sDKvP+9pypzfhAqTaAonwmS7AYEPYj54aQFYsUejVK6sSEd5+8u/yt1wSJGUi
         Y+hCcWOeKNTpRrcK+DLo3Yhj/krxhxzSctXU38d1yzIO6NPPg9e7IMLw5FNUGNcM426w
         2Llna+y33rk1lr957FRpGdVkhNpNK8KxPxKKb+HKu6i0jVtXEJMaSZtJw7c6IJ3hPS75
         6YrccNKJtaxip+WRE/Q2BWtjcjif6lmZD9IrqLQN6MWdFQnkxRr2zM4qm8zxSvivtC+i
         nU4cVrgJmZz1F7alY2TR5R+/gUJ3uIdKa47tDAVrGCedUQqGYMcm+AnJYyDkaequNGo6
         Lb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794135029; x=1794739829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DWmy/dZteMlGJY6PW1sSapqkw3qIXQygfTGSZR/3fgI=;
        b=LdeSCy1CvZnmJmrhu1tOpCPe9HTkVD4Uonf36IPrCiuQ8vm3rTHx1aXu4oM0EcT19/
         eIVIJOLv0GobpBtWADP4BijNSQfU9ugu7WvAlyu6T6NDig6bNxywKUUGO8zEajosi1kV
         LexGXKGMGwGkf3kO+vUqoxdFUUmM5swKjehCf1fzw+cvU0zMqaSr8dJgz9U/fesS1YOb
         kH/8MP+7ROjwQD8OA2HoiNpriofAbE/fBz5JkaZzKLedgIdMd9sw5wb+uBMjL4wwS+ej
         a8FgrotYMwGxepEB6P0nb5etUCEHJ+Uyw23cvPneNAydMa/oI7zj9TVPfK/D08n3Pseq
         4uVA==
X-Gm-Message-State: APuU4Z9dZGbzyfABJ6QJp6v9cjYxsSI2WRzQn3rbqs3AcgK3Iz4WgxNF
	k49ozXCTGPKJrhzV4hrkd8QWezVzQTUNQsF/Ci4E6UTyp1eV4FXEWckA+IoZUw==
X-Gm-Gg: AYBFou1zNJgUhqpQ5uwEFsUd/MgFyklBBWzewRZ6fPtgM7IOcDMzLT+29KycOByU2+h
	8xD/bHJfSSK0mqgZzjZuTWHZQzjExLW29L0ISvPoMIV9+VuopeYxBldNXUZ1gQTekuv/HaUbSDi
	M58Dlo3wzyVq8IIg9/n9hOD1XyrWWimN8TeeyOzesL9B1OE+O93J5OSVgdcOfu+N0yMgvEr4C3Q
	RCytk+aE3Gu+i+jyYu4SDqHHpYLfIx2sqKpdK6jg1BV9a1qa+6Dn3K/MLlallZKrWTJXu46+p7H
	5Hn8pFC/AJdmaREpsZL7nokLjVPMBLVUo+JMu7shs3LYvxPE0VPgdgM1IzONZyroatNHvpmRH3V
	9zo6pGsG448Ks9ADPhqMGYTOE1abYbWpZlvJ8yaUNB8zO9S2GOubQiT9vsF1MKaRpJaPCbl4LSg
	H5ftL/lIV6x6weuOhO8EwPeQjBpYHURUaGOyjfk4ru5r9316Tl2S8BcxDVL6Y/Zdl/ZGTCgSXLw
	5VgnDu/UJSHtL9PUAC+39498HR05wagQJqsV1bX1in1w/N2Ut2iy5hu/TAkzFlm/4vAD5yVOytS
	m4FpqDSqFy+3juJY0o0qKGmm+ETDKCpgPg0oydMwQcpDIm4VQemZTw==
X-Received: by 2002:a05:6a00:3d56:b0:8b6:2333:54a3 with SMTP id d2e1a72fcca58-8b623335653mr1014470b3a.39.1794135028851;
        Sun, 08 Nov 2026 02:50:28 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b64933fa41sm425422b3a.22.2026.11.08.02.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 02:50:28 -0800 (PST)
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
Subject: [PATCH net-next] net: dsa: motorcomm: Add LAG FDB callbacks
Date: Sun,  8 Nov 2026 18:50:09 +0800
Message-ID: <20261108105012.1326929-1-mmyangfl@gmail.com>
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

Fill the driver-side DSA gaps for LAG FDB offload.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 48 ++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 33e5fc127244..f73eed06437b 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -883,6 +883,52 @@ yt921x_dsa_port_fdb_add(struct dsa_switch *ds, int port,
 	return res;
 }
 
+static int
+yt921x_dsa_lag_fdb_del(struct dsa_switch *ds, struct dsa_lag lag,
+		       const unsigned char *addr, u16 vid, struct dsa_db db)
+{
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
+	struct dsa_port *dp;
+	u16 ports_mask;
+	int res;
+
+	if (!lag.id)
+		return -EINVAL;
+
+	ports_mask = 0;
+	dsa_lag_foreach_port(dp, ds->dst, &lag)
+		ports_mask |= BIT(dp->index);
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_fdb_leave(priv, addr, vid, ports_mask);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static int
+yt921x_dsa_lag_fdb_add(struct dsa_switch *ds, struct dsa_lag lag,
+		       const unsigned char *addr, u16 vid, struct dsa_db db)
+{
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
+	struct dsa_port *dp;
+	u16 ports_mask;
+	int res;
+
+	if (!lag.id)
+		return -EINVAL;
+
+	ports_mask = 0;
+	dsa_lag_foreach_port(dp, ds->dst, &lag)
+		ports_mask |= BIT(dp->index);
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_fdb_join(priv, addr, vid, ports_mask);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
 static int
 yt921x_dsa_port_mdb_del(struct dsa_switch *ds, int port,
 			const struct switchdev_obj_port_mdb *mdb,
@@ -2536,6 +2582,8 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	.set_ageing_time	= yt921x_dsa_set_ageing_time,
 	.port_fdb_del		= yt921x_dsa_port_fdb_del,
 	.port_fdb_add		= yt921x_dsa_port_fdb_add,
+	.lag_fdb_del		= yt921x_dsa_lag_fdb_del,
+	.lag_fdb_add		= yt921x_dsa_lag_fdb_add,
 	.port_mdb_del		= yt921x_dsa_port_mdb_del,
 	.port_mdb_add		= yt921x_dsa_port_mdb_add,
 	/* vlan */
-- 
2.53.0

