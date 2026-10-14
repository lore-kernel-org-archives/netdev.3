Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA2851C325
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 13:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983971; cv=none; b=MPXMOh1FGdF6CZYeABBpYih1P5LWs3c9YS+/RuEdwAluKiZBQomwU+tl9tw9+nXEew7He1b7H0ew5XY6eoUPztEZ1NZSVOjY+qUEcJDQm8v/+EUQ29BVWeQGT+4hiKX1rx340XzQI9ckH8/1VDDv0KwfXIZFI7dVgcLdlQLs0rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983971; c=relaxed/simple;
	bh=4H5DCy4Nnq3ERHMcMyekxMdmq0rKudaj80zUmH9iYds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpKZh5wOEYXrywAO9ofY/QTbe1jrsGQyQXn9Mebjt5OIO6JnI7MPh0LE58BB2ISWgwtPUf0XxpEbwt5VU47TzUuqhbSdRKgKAHyKrvzRYmw9/jkiijEnKG1EoMOE3zR2Iprz5W0BSmEmrS+GIYG9IIHfHvmYLmIVrx4lj4X7ehE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vd0D6eY/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vd0D6eY/"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso8852485e9.1
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 06:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791983964; x=1792588764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JfF3Dk+FXEFm1U9KB2J9gUYhe/61ZYoILCrSmOxnVkI=;
        b=Vd0D6eY/GDtHU4p3Po+3/04IZiIh9uS2kXZOyTpCG5nntD3uqwbLFCQK1GBJEXcOZV
         3XaUUfV8oICUL0eyjb/qf20Pe0V7bwadv2ImOqVyXDbJLNunUsNDUe5jyx65T+8vBOku
         9TWPDnPJVLxgdOvTKyewV/VBytQ3FDQRLZSIqxtzQS0uer9i/6v3U94h+Ww9htBNcV/1
         GWRDZ/o3a3IkjlMCAZuCVMot6Fv8xHmzx206Igxvs1kWd2Y7TeMCIvL8V2xrVnvmpQnV
         s+1kbP32mEudlIxDc48C6w1Paxhj12fsEpsRhIZzrV/KWgK5bv3eLnza5UyKHRCxtyVI
         obsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791983964; x=1792588764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JfF3Dk+FXEFm1U9KB2J9gUYhe/61ZYoILCrSmOxnVkI=;
        b=e9likLWglDfT1AuzkVPjXtJXjYjjAYcTvFZOGpPUUoJ4ZzR/Mf7uWOWdF0t1x+87h6
         nR6h7YVUmNMqA+I69bzg5EyMmZLIeIQSPrXCSLFDOZhW+j7EAxuXBCYK/jN0ZfGM4x4e
         XAXb0QTmYn8fGsD6AJZkKhvaK0wJ4kNkcTKsrbbQpwYvJKLj+m1dRWYsev86P02Ch+WA
         aUtjdLJWz8/NSPqnFjBa10WPvB1Tojgky93jZS8M0JYQ5sE8E5c+M65VRSaq0X6VN+3p
         TZdy3rIIRI+n+wXsD7XhE0AMGgzRiJSE0aNQ0JC74azdkIiAz99AHxP+3HmjLkmCyAAY
         oTdA==
X-Forwarded-Encrypted: i=1; AKwUvBzoMwIOfsOMYoSg/aEvTeoM230nunh4Q2FMaKpyvqTdlbzLBoI4BMQFX65XIxrKDF3gFEzslAM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvgUOlyJpwH9Q7F799Tr5J68Ia7v4/JoL5FbNXx/TNGIuRDGwi
	JW5j6ytlYN6L2DhfPzHFsvkG+PX+x8SZdiu/jq7rZ7065JtK8ohYkSzS
X-Gm-Gg: AYBFou0fJ9ygaBRwpQupP4i+RUCN3vVSZ6KZbN/Khx4nCe1TKxRCkzp49WcDsT9NtfX
	DZy3GzQXhxl7Jm1jPT+A7RKBDeIdaxhWekNoIm7+fYLUglSuaE85QUYgP/M7FdJwz5cK6TX7w3h
	8q2ITJiA5WAdiR9IKf//elokh2Tw00Jru36ZNZ6ZPAw4RM7y6rMBHa6Xr9XA0EwCHCG9EDAVJTz
	kNe1Pmh+wvzrFy4NUV2y8nE9Nbr9seeXQGWL+U3IHTl61SBBXLfA1na/wbwdLIYwsFZeZMngYi0
	zPDRacXTS3MN14ii4iFbz4r/L4adu9yUPlyReMQWVUuHeYl6FTzMWXb73RxkKl/v+807fuZfM/s
	EeK/GL6shACl+qVCi2XsbzyRI2K2If1Z403/4RFHpXyyFITiZHe6ROGS61CLHOkQsPc2vjT/sVp
	PBVzFh+UgmVbqknLqFUb/FdvxZOgT1f2KPhLxBRfgzt/FUPj2P3UCIIWE3xoBDwDbRbnmLkhTt5
	vNqqxOMM+FTbXYWuUiPpfYHSzNVv4qEVYJ7DcXb97TdFxK3i6wMnBxRXNwuFamDxpPAmT8rAxab
	bc+qCQ3pnj2YiTZCgA==
X-Received: by 2002:a05:600c:c165:b0:4a1:706f:b40d with SMTP id 5b1f17b1804b1-4a18e4988ecmr310151045e9.7.1791983963653;
        Wed, 14 Oct 2026 06:19:23 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:ea0c:b1b4:c6cc:a0af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bcecbd0dsm1413825e9.8.2026.10.14.06.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:19:23 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v3 11/13] net: dsa: rzn1-a5psw: Add fixed frame length workaround for management port
Date: Wed, 14 Oct 2026 14:18:59 +0100
Message-ID: <20261014131906.990077-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014131906.990077-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261014131906.990077-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The ETHSW IP used in SoCs such as RZ/T2H and RZ/N2H has a hardware issue
where the internal mgmt_tag_vld signal is asserted as a level instead of
a single-cycle pulse. This causes the frame length counter on the
management (CPU) port to over-increment, so valid frames are falsely
detected as oversized and dropped.

The recommended workaround is to program the maximum frame length
register (FRM_LENGTH) of the management port with a fixed, large value.

Add a management_port_fixed_frame_len member to struct a5psw_of_data to
hold the SoC-specific value. When it is set, program A5PSW_FRM_LENGTH
for the CPU port with this value in a5psw_setup(), and skip updating
FRM_LENGTH for the CPU port in a5psw_port_change_mtu() so that MTU
changes do not override the workaround.

No functional change for existing SoCs, which leave the value unset.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2->v3:
- Marked of_data as const pointer to avoid build warning

v1->v2:
- Added info about the IP issue and the workaround.
- Updated commit message
---
 drivers/net/dsa/rzn1_a5psw.c | 18 +++++++++++++++++-
 drivers/net/dsa/rzn1_a5psw.h |  3 +++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
index 0b0b4055e615..30eca64fb218 100644
--- a/drivers/net/dsa/rzn1_a5psw.c
+++ b/drivers/net/dsa/rzn1_a5psw.c
@@ -209,8 +209,13 @@ static int a5psw_port_enable(struct dsa_switch *ds, int port,
 static int a5psw_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 {
 	struct a5psw *a5psw = ds->priv;
+	const struct a5psw_of_data *of_data = a5psw->of_data;
+
+	if (dsa_is_cpu_port(ds, port) && of_data->management_port_fixed_frame_len)
+		return 0;
 
 	new_mtu += ETH_HLEN + A5PSW_EXTRA_MTU_LEN + ETH_FCS_LEN;
+
 	a5psw_reg_writel(a5psw, A5PSW_FRM_LENGTH(port), new_mtu);
 
 	return 0;
@@ -990,8 +995,19 @@ static int a5psw_setup(struct dsa_switch *ds)
 		if (dsa_port_is_unused(dp))
 			continue;
 
-		/* Enable egress flooding and learning for CPU port */
 		if (dsa_port_is_cpu(dp)) {
+			/*
+			 * Workaround for ETHSW IP issue, mgmt_tag_vld is asserted as a level
+			 * instead of a single-cycle pulse, causing the frame length counter
+			 * to over-increment and trigger false oversize frame drops.
+			 * The recommended workaround is to set the maximum frame
+			 * length on the management port.
+			 */
+			if (a5psw->of_data->management_port_fixed_frame_len)
+				a5psw_reg_writel(a5psw, A5PSW_FRM_LENGTH(port),
+						 a5psw->of_data->management_port_fixed_frame_len);
+
+			/* Enable egress flooding and learning for CPU port */
 			a5psw_flooding_set_resolution(a5psw, port, true);
 			a5psw_port_learning_set(a5psw, port, true);
 		}
diff --git a/drivers/net/dsa/rzn1_a5psw.h b/drivers/net/dsa/rzn1_a5psw.h
index e952afd95dca..5bec33b23079 100644
--- a/drivers/net/dsa/rzn1_a5psw.h
+++ b/drivers/net/dsa/rzn1_a5psw.h
@@ -237,12 +237,15 @@ union lk_data {
  * @npcs: Number of PCS connected to the switch
  * @cpu_port: CPU port number
  * @tag_proto: DSA tag protocol used by the switch
+ * @management_port_fixed_frame_len: Fixed frame length for the management
+ *   port to account for the HW issue.
  */
 struct a5psw_of_data {
 	unsigned int nports;
 	unsigned int npcs;
 	unsigned int cpu_port;
 	enum dsa_tag_protocol tag_proto;
+	unsigned int management_port_fixed_frame_len;
 };
 
 /**
-- 
2.55.0

