Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D950F4A1E15
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 20:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790887760; cv=none; b=K+ZakO06BBaX5XgQehEs9OPoppZsxssyuaqo/uQkOqDMwfXMhXGKQ+Bdx+f106QP50k913jxoRYKsrWGjSpPeOwgJEotlZHizYdmGaKJ7qkiAvgZd1PrPw59dt/JZvyzI2VynpMCrvWWUJu+cuZ1N/0zJmbtoAmjvI5tN8Ap4lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790887760; c=relaxed/simple;
	bh=vhT735CP1zUBAuIVgLTwWci2pb832b509vduj4K0xSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k39kQ6Mfh5anwd0wGbjs4T0+vixUvflDtqoQ4MjWbGQT68JRdmnF6n11dYWN7Zglr3AmrFU2ZQTydzg3UyfObCw9z1lllbGNLcCGzNnx5B1gnQq0KK51ImwESGYU9fZBWBIqNYKw3p2QVwyIgfQ0C+yPC1IrMNki75e65PL6ygw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vvu9q2G1; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vvu9q2G1"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a6df9494e5so1166a91.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 13:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790887757; x=1791492557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4PFOrX1mp/Oj8PsaIheJm1P3LBaRwQo8cTbd+H//gDU=;
        b=Vvu9q2G1c+W3y9G3XSJMe3qT1+FropwjqPbOe1lguwTdrDJbpvmqYUU5k+wHsgY3En
         l/GfGk5DVguDjSiaF/a03bdTz23+qXNVsYZ04rK+ATB7D6zkJXD6kRzlxsw2AzsBGIRH
         zZyjO6yFqKUhJmrE+IXeAwWjum5xyQaOC9KxM6OGWzBuAsZ6XHIWW0Ok588seCSicit/
         00u0k6zhl7H+QeRQKJt9ucvu99qPTJoM908KmBCo7aoIbL7SDZtoyU6vRzK/Xz98ryk8
         ZukupAqz1K+0i/xfkdhnRiVQd449oTMK8KA5nnBnj/qCbf9I3VClGlCpucVvQdgB09ab
         BuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790887757; x=1791492557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4PFOrX1mp/Oj8PsaIheJm1P3LBaRwQo8cTbd+H//gDU=;
        b=kk2fCHySDjKNjCL1xXej9KcELaO3bYRzna57LvykQ7P7vLdClbgG0yKDI0ttQLRZm7
         Lf/fMua+R5HilIEf1/8Gh3dtcLH1scCOt93AJSMtVvitvw609i2brq4yAiWC6W6+maKo
         /Hmn1Hm9JW+i0FCNfqfF/1Nj6rmii54WTv7DLqpjwMVWJFsolg6h6osOXsP2qbGUpmlm
         /sD/Q/btkyrWTyHLRjXStumkEW+oxYxBQL1voYft2qHaQBEtiB8/g+JRE33VmLiA1TP8
         8WkiAaNAGw5kV1sHmB8uxCc80Fms2sRirO7VprAlpWDPXOEk8S99gQAzSRea7N2SGl1o
         /i1w==
X-Gm-Message-State: AFq9FYK/nljSXnYDdCdtmB1Zq1D14W7l/NNjrlHLhQixTLUX1GJSizZp
	EXEEo3DLdTgSL4AEoHoTRFticzCnXh0ehg13Lmaq9vQs3NDT8KDt+qRcEbcECN+f
X-Gm-Gg: AYBFou2GarlRM0BDMhEis//j6aEB+XQ5BDS1waT6cKrEoPAql+E/05/HqpVEdm1hBv+
	I6IocrimpIvAyZUlfnOqqBgp1pTuNDC79ByQrcFzTLHEqSZKZU9+Nz2FGlOkop8CJQ6w9Aa5FHZ
	0rCrudwROtYDVf5HFfWahrEGamoraeFOO6E0Oxp1Fna93XVzKJQtomfDELgUV9tkJ+MAqyeIspX
	JrJrnql4+Ao7RZq4umNaPU7vPC8/RzLGk5Cs4EOeAQIFwP8hAf0PdRT/xFbSApehk03TEVcxmMJ
	NWQTxdJ3BHNd8zsQk3lfB9km+O+VUFoUii3Q06P8HMkrnE7WuBa+2v2tpGgfQYk/bcJuseLAGfe
	z69zWstWUk81SD5OQL1A9+0NBQpuKAOdsxQmhQhB1qks58VOPfQflnQhA0Nbz3AnuQC+pELMBnC
	2M2hA+On9JhYyec3/oNWQwqnrDUmCGLx/v/rISXrDhY8b8qpD5ZI1Cr1WDJv8X0oyYD7ggdLR1G
	UlHN+wa0aMNPXysuh+xPeLsoA==
X-Received: by 2002:a17:90b:224f:b0:39e:6a7f:6187 with SMTP id 98e67ed59e1d1-3a6ceaeec8cmr408036a91.24.1790887757199;
        Thu, 01 Oct 2026 13:49:17 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661e:3050::4d0:26])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f478e9c6sm5658797a91.14.2026.10.01.13.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 13:49:16 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 4/5] net: dsa: motorcomm: Enable ACL on demand
Date: Fri,  2 Oct 2026 04:48:47 +0800
Message-ID: <20261001204851.2576101-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001204851.2576101-1-mmyangfl@gmail.com>
References: <20261001204851.2576101-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Track the usage of ACL rules and enable it per port only when it is
actually used.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c |  3 +-
 drivers/net/dsa/motorcomm/chip.h |  2 +
 drivers/net/dsa/motorcomm/tc.c   | 63 +++++++++++++++++++++++++++++---
 3 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 5be198d9e5cd..4b8cb2ba28b7 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -2686,8 +2686,7 @@ static int yt921x_chip_setup_acl(struct yt921x_priv *priv)
 	if (res)
 		return res;
 
-	ctrl = YT921X_ACL_PORT_PORTS_M;
-	res = yt921x_reg_write(priv, YT921X_ACL_PORT, ctrl);
+	res = yt921x_reg_write(priv, YT921X_ACL_PORT, 0);
 	if (res)
 		return res;
 
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index 40ab5187f774..68cbbc9b9b78 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -581,6 +581,8 @@ struct yt921x_port {
 	u64 rx_frames;
 	u64 tx_frames;
 
+	unsigned short acl_cnt;
+
 #if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
 	unsigned char led_duty;
 	unsigned short led_cycle;
diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
index 0e5f19a39d0c..95ed0f245b1f 100644
--- a/drivers/net/dsa/motorcomm/tc.c
+++ b/drivers/net/dsa/motorcomm/tc.c
@@ -1055,6 +1055,17 @@ yt921x_acl_rule_ext_parse_flow(struct yt921x_acl_rule_ext *ruleext, int port,
 	return 0;
 }
 
+static u16 yt921x_acl_activated_ports(const struct yt921x_priv *priv)
+{
+	u16 mask = 0;
+
+	for (int port = 0; port < YT921X_PORT_NUM; port++)
+		if (priv->ports[port].acl_cnt)
+			mask |= BIT(port);
+
+	return mask;
+}
+
 static unsigned int
 yt921x_acl_find(const struct yt921x_priv *priv, enum tc_setup_type type,
 		unsigned long tag)
@@ -1199,10 +1210,15 @@ yt921x_acl_del(struct yt921x_priv *priv, enum tc_setup_type type,
 {
 	struct yt921x_acl_rule *aclrule;
 	struct yt921x_acl_blk *aclblk;
+	bool refresh_en = false;
 	unsigned int binid;
 	unsigned int blkid;
 	unsigned int entid;
+	unsigned long m;
+	unsigned int o;
+	u32 ctrl;
 	int res;
+	int ret;
 
 	entid = yt921x_acl_find(priv, type, tag);
 	if (entid == UINT_MAX)
@@ -1214,9 +1230,27 @@ yt921x_acl_del(struct yt921x_priv *priv, enum tc_setup_type type,
 	aclrule = aclblk->rules[binid];
 
 	aclblk->rules[binid] = NULL;
-	res = yt921x_acl_commit(priv, entid, aclrule->mask);
+	ret = yt921x_acl_commit(priv, entid, aclrule->mask);
 	/* the kernel never rolls back on failure */
 
+	m = FIELD_GET(YT921X_ACL_KEYb_SPORTS_M, aclrule->entries[0].key[1]);
+	for_each_set_bit(o, &m, YT921X_PORT_NUM) {
+		struct yt921x_port *pp = &priv->ports[o];
+
+		if (!WARN_ON(!pp->acl_cnt)) {
+			pp->acl_cnt--;
+			if (pp->acl_cnt)
+				continue;
+		}
+		refresh_en = true;
+	}
+	if (refresh_en) {
+		ctrl = yt921x_acl_activated_ports(priv);
+		res = yt921x_reg_write(priv, YT921X_ACL_PORT, ctrl);
+		if (res)
+			ret = res;
+	}
+
 	if (aclrule->action[0] & YT921X_ACL_ACTa_METER_EN)
 		clear_bit(FIELD_GET(YT921X_ACL_ACTa_METER_ID_M,
 				    aclrule->action[0]),
@@ -1227,7 +1261,7 @@ yt921x_acl_del(struct yt921x_priv *priv, enum tc_setup_type type,
 		kvfree(aclblk);
 		priv->acl_blks[blkid] = NULL;
 	}
-	return res;
+	return ret;
 }
 
 static int
@@ -1240,11 +1274,12 @@ yt921x_acl_add(struct yt921x_priv *priv,
 	struct yt921x_acl_blk *aclblk;
 	bool use_trap = false;
 	unsigned int meterid;
-	unsigned long mask;
 	unsigned int binid;
 	unsigned int blkid;
 	unsigned int entid;
+	unsigned long m;
 	unsigned int o;
+	u32 ctrl;
 	int res;
 
 	/* Allocate resources */
@@ -1293,8 +1328,8 @@ yt921x_acl_add(struct yt921x_priv *priv,
 
 	/* Replace the placeholder resource IDs */
 	aclrule->mask = 0;
-	mask = priv->acl_masks[blkid];
-	for_each_clear_bit(o, &mask, YT921X_ACL_ENT_PER_BLK) {
+	m = priv->acl_masks[blkid];
+	for_each_clear_bit(o, &m, YT921X_ACL_ENT_PER_BLK) {
 		aclrule->mask |= BIT(o);
 		entscnt--;
 		if (!entscnt)
@@ -1312,6 +1347,19 @@ yt921x_acl_add(struct yt921x_priv *priv,
 	else
 		aclrule->action[0] &= ~YT921X_ACL_ACTa_METER_EN;
 
+	/* Activate ACL if needed */
+	ctrl = 0;
+	m = FIELD_GET(YT921X_ACL_KEYb_SPORTS_M, ruleext->r.entries[0].key[1]);
+	for_each_set_bit(o, &m, YT921X_PORT_NUM)
+		if (!priv->ports[o].acl_cnt)
+			ctrl |= YT921X_ACL_PORT_PORTn(o);
+	if (ctrl) {
+		ctrl |= yt921x_acl_activated_ports(priv);
+		res = yt921x_reg_write(priv, YT921X_ACL_PORT, ctrl);
+		if (res)
+			return res;
+	}
+
 	/* Write rules */
 	aclblk->rules[binid] = aclrule;
 	res = yt921x_acl_commit(priv, entid, aclrule->mask);
@@ -1321,6 +1369,11 @@ yt921x_acl_add(struct yt921x_priv *priv,
 		goto err;
 	}
 
+	/* Bookkeeping */
+	m = FIELD_GET(YT921X_ACL_KEYb_SPORTS_M, ruleext->r.entries[0].key[1]);
+	for_each_set_bit(o, &m, YT921X_PORT_NUM)
+		priv->ports[o].acl_cnt++;
+
 	if (meterid < YT921X_METER_NUM)
 		set_bit(meterid, priv->meters_map);
 	priv->acl_masks[blkid] |= aclrule->mask;
-- 
2.53.0

