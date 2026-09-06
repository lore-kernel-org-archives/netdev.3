Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44D33D090E
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788700493; cv=none; b=Fx3BhmpTNncb1Vd2S7GXkDhl/+4oA2wGfD2o4dRWcRPsm7oCLJSzFSDMCV4tN4yZfI1Zrh7cZbDYrthzmpxwZ7ALwUUSdqJdKjg21URHotp7IFxl7RyfWTJMqynp9aCETthU84dIpnlXyIyTbz1Rj6X6worJtAQnluJn8/hTShU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788700493; c=relaxed/simple;
	bh=2uov7MjSgw7uaYly/JryV0QXvkNQbSYg+0flUoG78R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGa/LH4bv/iR05L/cCqUgg/1Mlh7951Jerk/BZmn5a/thN9qSaJ2KvD3Lx0Oq5g66Jq3HK8fwPRfGSBMKwZCgDLVqcB8srUvAgIg0mBRO94iSsdVTiCLDjzev5+GRIrFT6fjXR1fS0784MmmbqSQNlQTmBFIzt4ptg90YLXaVcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5iZAn2r; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5iZAn2r"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d6f9e2f681so29094695ad.3
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 06:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788700488; x=1789305288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U+C0aiSr3C6LpsbjgLZ1pgIoaspgg1L4h/eAlXTaaGs=;
        b=R5iZAn2r1KQXzFFkDU55C+3kKflCF+vPTBdU40QhxQ99ojwYBUgGnfEdeKleDAVP4S
         nV3ZlDCMaowD/axuo6B8QMet/mZUJzcOItDkD0IWgcq5ROQDzUTli0tlg8f+eY4UiVgW
         FYgsr6CsZgLG3N+4whFEoG8t7rc/fcpkLB64oi0+aB6RsgxT3FIA0Picra7SjByWQf6+
         dyjnSYMWFZ2ZLhK2CzfWYZwsE1eJlcpqdlKKzzS8CkIMDK0M5T1ihDwQETBaBaOvtXUm
         tyB9rrswb2Raq8l97PiOyX8vJXBwsVVTLCfh6LOjkV5CV+GS6m7SA9+OciYYYJlx2Q8f
         vMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788700488; x=1789305288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U+C0aiSr3C6LpsbjgLZ1pgIoaspgg1L4h/eAlXTaaGs=;
        b=q4hDlQXnBMvVCpZ0ipIjR/HQiGnX2dNVaHUkTFVeW9lCo0LjWrurGOr2YObyacloZ6
         MM9m9RjtkpeBCLCWzybOVAI7hafhID5bPAAR5orN7pnX13xmPKs+rvTSgXDg67b+4DnP
         xP3Wnv8VQ6kk7TKADPhnEN8cAlb3t1FJ3tm+xt9asOCnCmAi7d81ykAxI6kwqh24o2nK
         EspQLxjjfMWtZUDlNKZ/2zuBrlUXvTAy7iHxRV3kwnmE8o9e+Tgj6zv3CeYLgYXWRh2N
         4RQhPnok4xIGJAy/FrTcmzyYF/3LB/0srZU2XpivHyQaelAHIvJ76R4zfaqrsWMyXMQ0
         Fv1Q==
X-Gm-Message-State: AFuF++lZVu/EhUbhLfGJk3w0KNwnJ4+kzXJVNKGXdpnSULWRyydUTXcR
	3VAYCK+C+CdNMnwZIB7K70JQqBkGMofpkcV1wbbSKi33HZkREKahOfHAENHXwO8+
X-Gm-Gg: AYBFou3gzodLwt2bUXj2fdYfsYb+ybZNizndVpkgPzUo1Vlari/7649K63hDFK1NWak
	tXj0MG8nu4MWY888Ck/4YjOveVNSmtg8h347CITBWoIOktpNK4YSPr1ZXdniafvp+IeLFwxAUal
	82UDp9g4q6PxDD/kzEHb2zxU6FmC4hLKnKdoGlJwFu/XjOXQyOTOdhCER/jZu4VjsAu/r8TqFti
	mXS+b4HUBHI7ejWZ1CLXomQyiqfVuBTdhlXIiWBYe/jBtwVjQ4PMZlKCfNoICLwAkiw/aPLdtrQ
	4rF6TgXewdNaKL9C8vg69E+E79X1O1BKL4PUEywHFImPWLlI71c+GgQNrGosZKiQDJ1v5dBNAsD
	1dOrTbCmmR1RH4haNnHbnwqkOS1pVALcyh54SIgQh2HDrzTjQh3rYRML7XBBUeuUUdIYgCrZ/t7
	UdEt6MX2sixbRDSSIWP2nRUVnu1H/srVzRT7skzr/mVdv2Wdamn+5lBsFBBKUxl4/9W7doWQ0zt
	Fe04xHMvKIppw==
X-Received: by 2002:a17:902:e951:b0:2d8:d4ce:7e3b with SMTP id d9443c01a7336-2db126289bbmr244806075ad.16.1788700487761;
        Sun, 06 Sep 2026 06:14:47 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:d30::4d0:7b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1495b2f8sm32259965ad.21.2026.09.06.06.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 06:14:47 -0700 (PDT)
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
Subject: [PATCH net-next v3 6/6] net: dsa: motorcomm: Use safe 64-bit counter reader
Date: Sun,  6 Sep 2026 21:14:11 +0800
Message-ID: <20260906131414.2683362-7-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906131414.2683362-1-mmyangfl@gmail.com>
References: <20260906131414.2683362-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

64-bit counter registers are read as two separate 32-bit transactions.
If the low word wraps from about 0xffffffff to a small value while the
high word increments between the two transactions, the recombined value
becomes ((new_high << 32) | old_low), producing a spurious ~4 GiB jump.

Use a safe counter reader for this.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/mib.c | 21 +++++++++------------
 drivers/net/dsa/motorcomm/smi.c | 30 ++++++++++++++++++++++++++++++
 drivers/net/dsa/motorcomm/smi.h |  2 ++
 3 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
index 8601d25fe988..cfae2977a77b 100644
--- a/drivers/net/dsa/motorcomm/mib.c
+++ b/drivers/net/dsa/motorcomm/mib.c
@@ -102,29 +102,26 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
 		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
 		u32 reg = YT921X_MIBn_DATA0(port) + desc->offset;
-		u32 val0;
-		u64 val;
-
-		res = yt921x_reg_read(priv, reg, &val0);
-		if (res)
-			break;
 
 		if (desc->size <= 1) {
 			u64 old_val = buf[i];
+			u32 val0;
+			u64 val;
+
+			res = yt921x_reg_read(priv, reg, &val0);
+			if (res)
+				break;
 
 			val = (old_val & ~(u64)U32_MAX) | val0;
 			if (val < old_val)
 				val += 1ull << 32;
-		} else {
-			u32 val1;
 
-			res = yt921x_reg_read(priv, reg + 4, &val1);
+			buf[i] = val;
+		} else {
+			res = yt921x_counter_read(priv, reg, &buf[i]);
 			if (res)
 				break;
-			val = ((u64)val1 << 32) | val0;
 		}
-
-		buf[i] = val;
 	}
 
 	u64_stats_update_begin(&pm->syncp);
diff --git a/drivers/net/dsa/motorcomm/smi.c b/drivers/net/dsa/motorcomm/smi.c
index bf3adfd64165..27086602997b 100644
--- a/drivers/net/dsa/motorcomm/smi.c
+++ b/drivers/net/dsa/motorcomm/smi.c
@@ -63,6 +63,36 @@ int yt921x_reg_update_bits(struct yt921x_priv *priv, u32 reg, u32 mask, u32 val)
 	return yt921x_reg_write(priv, reg, u);
 }
 
+/* Reliably read a 64bit counter */
+int yt921x_counter_read(struct yt921x_priv *priv, u32 reg, u64 *valp)
+{
+	u32 old_lo;
+	int res;
+	u32 hi;
+	u32 lo;
+
+	res = yt921x_reg_read(priv, reg, &old_lo);
+	if (res)
+		return res;
+
+	for (int i = 0; i < 16; i++) {
+		res = yt921x_reg_read(priv, reg + 4, &hi);
+		if (res)
+			return res;
+		res = yt921x_reg_read(priv, reg, &lo);
+		if (res)
+			return res;
+
+		if (lo >= old_lo) {
+			*valp = ((u64)hi << 32) | lo;
+			return 0;
+		}
+		old_lo = lo;
+	}
+
+	return -ETIMEDOUT;
+}
+
 static int
 yt921x_regs_read(struct yt921x_priv *priv, u32 reg, u32 *vals,
 		 unsigned int num_regs)
diff --git a/drivers/net/dsa/motorcomm/smi.h b/drivers/net/dsa/motorcomm/smi.h
index 212e20f71d80..d34240548af7 100644
--- a/drivers/net/dsa/motorcomm/smi.h
+++ b/drivers/net/dsa/motorcomm/smi.h
@@ -35,6 +35,8 @@ yt921x_reg_toggle_bits(struct yt921x_priv *priv, u32 reg, u32 mask, bool set)
 	return yt921x_reg_update_bits(priv, reg, mask, !set ? 0 : mask);
 }
 
+int yt921x_counter_read(struct yt921x_priv *priv, u32 reg, u64 *valp);
+
 /* Some multi-word registers, like VLANn_CTRL, should be treated as a single
  * long register. More specifically, writes to parts of its words won't become
  * visible, until the last word is written.
-- 
2.53.0

