Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B055E368296
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 15:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790437766; cv=none; b=W2bDnf3PV7f0LiYZWswf76538MnYqpZ+BlSqxCodoXPmRvNgTBbHzVyXNtkcW/qdzhaXaJ1CsjTRCkyTnbJ0CIabm5CIRTJ5p/6FxpAvE4C9ABh3VKixb0xHpw07KROK9BBfIOx6ARTf/dEEN+OQhqbKA+O5qfcNEh4B1I5kt6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790437766; c=relaxed/simple;
	bh=U0usEgD6eBVSyAl+4wuE0PhgO7aYIcSIWGg7AGP8BEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o3rZN5NRkHgMvpjZaq/7LdidugGo+ldl2dw2Jj3WLh+YckK9zOqcICOlhgpw1nXYXRenQza9LNMy4gegqnirFB2y96oFkUVqagLexKtsJpCYZ4I0mf0XYLu5Wff2LqlOCsK/pQ+ZqtZ2+kW7KcOoTWeleweViXX+29mkZ3toENk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sRuhkRGd; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRuhkRGd"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6c72bd8a017so1135196eaf.3
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 08:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790437763; x=1791042563; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B0ScVIX3sPn/yQi4OeJT/F76Vd8VPP2euaNmJMN8ERw=;
        b=sRuhkRGd0u8nkOxa0GXrwphVrHhk1n3TOpBZ8Ki/iyxUfciGgghFsVF6tpv6Ttd7uS
         ASNaisI4iRsAK26INUqWMlXgR6DQuFiZhjXX0WyulRfkpsjnfZ2/DIdywIgrVZ08XFTD
         IZmUGtFkkLP9NQODz66uQUePhgLso6vCFuWu67JQ81fgzWZqIGjZHz/2QgYkvFRwvYN/
         RzXDykVxoV42Mnox1uwvBeIJ56SZLTxa17EnDIjZJFfrTT/LK3n9H4gE/NQZBEXfeB4B
         yCVpd1ec1iwItV2xGrF1tbdFpRymprAE60ajlhRNx8p5PlIANw5cVjB3hCoZwD79SsCf
         dOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790437763; x=1791042563;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B0ScVIX3sPn/yQi4OeJT/F76Vd8VPP2euaNmJMN8ERw=;
        b=zX9lIeGRb42Cw1Y+Fr80L6TOUa8c7XAh5+VJ26Ry6oJGrETJOuuPSvghHqmz1n4ePL
         idvr8D6mpksjfZWocCfcuORMwQVtPqQRza+RmBkZd7FQDwhkSR+uOAkBe4/r8fYLpx5p
         zUBaWvILXO/zhdesLmyXsNr4k/8FMqD/TXaFGoirdi6MJNC6NLBdy327424ikbdkYqoC
         Xbjj7cxRX2ezjCt7nIOCO6QJjZj7FIV4xalxDvFZrpi5N2p/ZPso0NBnLuBpjrWmVsdo
         JoiLHeCnwt/wo+CE1AjfWnMC9RPSOaWvJNYp9n1b6ITXMA6KoJIFZvtVt7dcJZ67xkBk
         FeCg==
X-Forwarded-Encrypted: i=1; AKwUvBxADhEyr7O4liP9zKsrISSuTxwvF6h3yx3cTNv4zpHKcE2dj/Cr60kLJXOHRRS3S0Mi3hYah9c=@vger.kernel.org
X-Gm-Message-State: AFuF++mtZAMtsMcHQYQy+d60v6TCFam2F5yClvt5N5pZVm3wqgk7I75E
	AI/bBnwph+DDK8MOjREbzErCDsbHmmU3n7MTfhxyK5Ko6Gc967jYHJT2
X-Gm-Gg: AYBFou1APiHi44fLRflkapV92w4NE+HqoaNmZuG7il9m32EY/TeJ7Ft7Y/aAoPgQ4N7
	5cBaIcwEB4IcsDGxJaEFJFytrmeuyZHBpbdzOHCMLVyutgQGwyAnxdRY/78HUSN302N9OE5dQCP
	hwvMcZj32xmQwFipDiE0hG3i2drdveMK3hWMiaJgook+gzE/4O+wkF3ufna+QhWFKwN/cEdovrR
	/LR1C/vBb0+HusO4U2a8oVhNugIRJi00KhbTEYR7EdO3L4rWGh2BFFXIb6F2CszJcb+0t3iwPAj
	e8d5Mvj2ClpefKRKj/2H9GzUH6hIt0HdkDb4/lnzyvjv30DhdBia4H/aBe6cuDt2QB+Qnep1tYn
	xds/JFTma0iv9ZsHChu16LPmVtw3AAYC2rA0YtSa7G+w3WF64caX5eXCjXxzgTDL8AhsSLDHj6/
	uCS47vKZbvjRx9A+Zu7rC0L8tdXeHDx61eIzPfv9jaQKE/xG3gDvQATjNOifkMY5IIKg3SsxLON
	bqvzYzPR5Mxfx1FjO/rLWVy4TqZdt3KZYvhYu0O4EsWxAc5wUPgIFAw5UhNzONatpwLJKhHTfwp
	Vs4BQdRI+VHQHrBo8HuhzVAOlBp8juJoNSl+WQtXKUbDL1/6kqCghaTmF5m7xyAhpVs9LXuCAOD
	uoE0MDfqObu2WM4iWu9Fx
X-Received: by 2002:a05:6820:1ca6:b0:6d3:402e:1fca with SMTP id 006d021491bc7-6d43ebf0448mr8754440eaf.9.1790437762887;
        Sat, 26 Sep 2026 08:49:22 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-818e98b16d4sm5442366a34.26.2026.09.26.08.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 08:49:22 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 26 Sep 2026 09:48:57 -0600
Subject: [PATCH net v4 02/15] net: stmmac: reuse the MDIO reset GPIO on
 resume
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-submit-stmmac-reset-fixes-v1-v4-2-ec1c0250b3c9@gmail.com>
References: <20260926-submit-stmmac-reset-fixes-v1-v4-0-ec1c0250b3c9@gmail.com>
In-Reply-To: <20260926-submit-stmmac-reset-fixes-v1-v4-0-ec1c0250b3c9@gmail.com>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Joakim Zhang <qiangqing.zhang@nxp.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Serge Semin <fancer.lancer@gmail.com>, 
 Suraj Jaiswal <quic_jsuraj@quicinc.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Joao Pinto <Joao.Pinto@synopsys.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>, 
 Voon Weifeng <weifeng.voon@intel.com>, 
 "Song, Yoong Siang" <yoong.siang.song@intel.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Eric Dumazet <edumazet@kernel.org>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 ZhaoJinming <zhaojinming@uniontech.com>, 
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
 Ding Hui <dinghui1111@163.com>, James Hilliard <james.hilliard1@gmail.com>, 
 linux-tegra@vger.kernel.org, linux-sunxi@lists.linux.dev
X-Mailer: b4 0.15.2

MDIO bus registration acquires the optional snps,reset GPIO through
devres. A later bus reset must reuse that descriptor: requesting the
same exclusive GPIO again returns -EBUSY while devres still owns it.
Cache the successfully acquired descriptor for subsequent resets.
Propagate acquisition errors without caching an error pointer.

Fixes: 7c86f20d15b7 ("net: stmmac: use GPIO descriptors in stmmac_mdio_reset")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 18 ++++++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 7582fca63741..c7c876408d85 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -287,6 +287,7 @@ struct stmmac_priv {
 
 	unsigned int pause_time;
 	struct mii_bus *mii;
+	struct gpio_desc *mdio_reset_gpio;
 
 	struct stmmac_pcs *integrated_pcs;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index afe98ff5bdcb..07d5eab05996 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -386,14 +386,20 @@ int stmmac_mdio_reset(struct mii_bus *bus)
 
 #ifdef CONFIG_OF
 	if (priv->device->of_node) {
-		struct gpio_desc *reset_gpio;
+		struct gpio_desc *reset_gpio = priv->mdio_reset_gpio;
 		u32 delays[3] = { 0, 0, 0 };
 
-		reset_gpio = devm_gpiod_get_optional(priv->device,
-						     "snps,reset",
-						     GPIOD_OUT_LOW);
-		if (IS_ERR(reset_gpio))
-			return PTR_ERR(reset_gpio);
+		/* The bus reset also runs on resume. Devres retains the GPIO
+		 * until unbind, so do not request an already owned line again.
+		 */
+		if (!reset_gpio) {
+			reset_gpio = devm_gpiod_get_optional(priv->device,
+							     "snps,reset",
+							     GPIOD_OUT_LOW);
+			if (IS_ERR(reset_gpio))
+				return PTR_ERR(reset_gpio);
+			priv->mdio_reset_gpio = reset_gpio;
+		}
 
 		device_property_read_u32_array(priv->device,
 					       "snps,reset-delays-us",

-- 
2.53.0

