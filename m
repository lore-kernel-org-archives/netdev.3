Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744096;
	b=EFnXHzd8k8QTYRkGIE/wPVnCcK21Tfbe0gvQ3S3dk3efgDgPCPn0sPqXdPgBXe+N+4JC
	 dNmQm4TpeCn8olkO/SbVLmII5iWNBxudl0Vl7KOl3X1xlg+Ht5XEWvwkhfo3zXh4XKw1L
	 mjuljfHznMaTVGG3uGmRBhqNdVZZskqvWgN/+AmkQy0r4beqPFcPLWEoUnmzPTdO16sQl
	 ilZQ+jczp4vmtSw91oD/OWcb/5RwxFqEl5uFhwm34gkgRVjSSKiCwOnAo1KVGRo85OaJu
	 34jhUTWvkR6nZRnpWhYM6EId7RE9hLFxXdFniD/JptlZf8y6RWxQ684vK+Vg0ZhSGHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744096;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KVXvU2y3CWgDkb2iD40+8fhR4es61+R0ZnlRm3BwJkU=;
	b=4iSPCZxVFJm2RtByBsNw6M9YJpW7VyU0U5IkiI94MRE2wXq4kPYxDIsL5JFPz55AiZay
	 sRyzwuvvb2OEIdmMmYsNSY3XqMO6GX61SnxDHjPkLSENz0zjgbwAiyoB4vX/DLL97naes
	 NvEmUgpoDAkw1wzE4BFrH31OXJrp+YV8DBKPu5Yw+uKu63GkcIjpyKeejNcHr6hKSdMbD
	 GemnCHBo6hvb1F3wCtXE7VjfGzB8Boa7t3STjFI98/2/E1mw+HOIYbPd+5DeyUxhhb9kf
	 u6IPvVyzRJ/jx4uTurvSeyF1Tq93OM84BIGtk39lUUwz/McQX9UXyR6ag3LPoRx5mlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LZpAD42C;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83917606A33A
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 22:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83917606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LZpAD42C
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48df54150dfso42946f8f.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 14:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744095; x=1794348895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KVXvU2y3CWgDkb2iD40+8fhR4es61+R0ZnlRm3BwJkU=;
        b=LZpAD42CUB1C5U9iACvZadkklT0O0/YuNtSKrGyU8gkLIrqf449RkB3acFR89+fZb7
         VmqTNzOvuCJe6oB+7ZPw+YgQNyC4JVvTnnMpARrCZCPn02/2KnUMuZTKDauitqvPgZeF
         95KrYJ11fELxC2PkYaknRcc369seU18LSjwsN9moleqDG1sG79/JaqfwsogLyMccaTrO
         7F0jitERdkD6VHoNfn/tZmI7jZ6mjFD/5IHTS7B6Mw7n+EKaF6Rt8CUiDlxLaZXpCqSK
         1beaN8pc5pd4AOTIG/+hjmoZ1aDtF5Q6QGTRDOaRvUs6PX8j4KdEH/2mySzdhz1M/HIK
         1WeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744095; x=1794348895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KVXvU2y3CWgDkb2iD40+8fhR4es61+R0ZnlRm3BwJkU=;
        b=xej8TAADaVkCSZc8AxA05s0xIzqqmrEi0GItChSeql49+IwPFPXrAQp5O+Kl1u9HTw
         u9qzvEeE8Qmc2zNb2N77qcEz74Y0WC3E9/gS7RtWCpH/oPEgDDNVmGmLoTssF/Odp4oV
         ag/4QZ2qG/4/4ApStG/upDWJOrmuMYH1h4SOFDydf2q6JLj8oPoX0I2I6VsVF6tmzena
         oBKtoEf7SspkDzQE7jr0Sd6KoF00MCgjojU+gete5SvJNx27pxknWIxGG6/6DZTeh7Zv
         zj1J6K0A8A2F2H4/OvSc90XfstEKcZXb12FdTSWgmsWcgDmZZGzcAbo5eOHbTzbObwm+
         VEUw==
X-Forwarded-Encrypted: i=1; AKwUvBwVmbY9lSagsNfJeqv7cQxIVGyAl21GMiX8CekD0fqNilBSdPUgGAAbbt5ufz1KKO4XGmzBKpg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TzZYNuSTvnvw9TaVUb/dpGCAQGnXd0PKjzeXKrN9cPu/eYXqn
	epw69yQFm1E4XAQ8gUPkNVK1rA+PqjoQOKBI27xrBF/I4JaW8CJtnv5X
X-Gm-Gg: AYBFou2R7gXySzDD0rePxSAFECPPtpPSmfTCAVBN04HSYDw4yxwEcGDpHi415PvTfyn
	WZYyR6Hxj4l11ybC74jk8+A5lB/m9F3kk9/TvyBtQ3fvDa8rBzwShVZk0r6A/b9NxJ75X0INnjF
	00zlhbzVehS1/z3YvuqJI+xV+pPcCpyLhHSCIhSwQSuPtFs2jZYUmFgXiPbt95jNGfnuemPrHPb
	TZd9+59mD8X0pvacM8B4HS2hAvS7LkXAkz6PLtfhRz1dPM++FMU+4D/vReeRFZxRJGXJ612MtnD
	MzDYonYcWMcYDlfFiG7uu88TZ4qqDku9oSaApy8DUA5AEt3NdFFG2GzwpDDwWv9ccvioaf90U7c
	Gt2M0H06RVpWi+IEAmGZPYv4n0eBMdQUDqNY610txK5UPpbxwUMQkcPnFi30GWTywZCGON9RIKA
	eC6fJqQRtXV4rGWahhBFA3W+z147l7hcAWYMegWRzAhtvTS9v0oFQ07HvUdfqtfqJZ//uJZ23oW
	rVB/ihZnnnlPcrnvgDUMNQD2VCLI7rF+ChMZNh/wgShB+AGQCvnWjNEqR3QiQ7eVRiuLW3BD0Jm
	ak33mn+F9UnxqcpfcBXo/dTGEVMvOIvIPpRcNkpqhoXOyplxwB/JUjCy9Sohn6tjjDNfg784wo6
	2IVhcyxAJRmiRBPg46GU990LbHTXejEm11w==
X-Received: by 2002:adf:fc0d:0:b0:48d:f383:2356 with SMTP id ffacd0b85a97d-48e6e500514mr25493814f8f.53.1793744094732;
        Tue, 03 Nov 2026 14:14:54 -0800 (PST)
Received: from Ansuel-XPS24.localdomain (93-34-90-148.ip49.fastwebnet.it. [93.34.90.148])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48fec9cd43bsm328556f8f.14.2026.11.03.14.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:14:53 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Joris Vaisvila <joey@tinyisr.com>,
	Ahmed Naseef <naseefkm@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v4 3/6] net: phy: mediatek: generalize cal_cycle function for GE SoC
Date: Tue,  3 Nov 2026 23:14:34 +0100
Message-ID: <20261103221439.30502-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103221439.30502-1-ansuelsmth@gmail.com>
References: <20261103221439.30502-1-ansuelsmth@gmail.com>
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

In preparation for support of special Software Calibration for Airoha PHY,
it's needed to generalize the cal_cycle function as Airoha needs only
part of its logic (the wait logic) to complete a calibration cycle.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/mediatek/mtk-ge-soc.c | 32 ++++++++++++++++++---------
 drivers/net/phy/mediatek/mtk-ge-soc.h |  3 +++
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
index 2b1e9923db98..f3ce6e67eb38 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.c
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.c
@@ -39,20 +39,11 @@ struct mtk_socphy_shared {
 	struct mtk_socphy_priv	priv[4];
 };
 
-/* One calibration cycle consists of:
- * 1.Set DA_CALIN_FLAG high to start calibration. Keep it high
- *   until AD_CAL_COMP is ready to output calibration result.
- * 2.Wait until DA_CAL_CLK is available.
- * 3.Fetch AD_CAL_COMP_OUT.
- */
-static int cal_cycle(struct phy_device *phydev, int devad,
-		     u32 regnum, u16 mask, u16 cal_val)
+int mtk_cal_cycle_wait(struct phy_device *phydev)
 {
 	int reg_val;
 	int ret;
 
-	phy_modify_mmd(phydev, devad, regnum,
-		       mask, cal_val);
 	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_AD_CALIN,
 			 MTK_PHY_DA_CALIN_FLAG);
 
@@ -71,7 +62,26 @@ static int cal_cycle(struct phy_device *phydev, int devad,
 	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_AD_CAL_COMP);
 	if (ret < 0)
 		return ret;
-	ret = FIELD_GET(MTK_PHY_AD_CAL_COMP_OUT_MASK, ret);
+
+	return FIELD_GET(MTK_PHY_AD_CAL_COMP_OUT_MASK, ret);
+}
+EXPORT_SYMBOL_GPL(mtk_cal_cycle_wait);
+
+/* One calibration cycle consists of:
+ * 1.Set DA_CALIN_FLAG high to start calibration. Keep it high
+ *   until AD_CAL_COMP is ready to output calibration result.
+ * 2.Wait until DA_CAL_CLK is available.
+ * 3.Fetch AD_CAL_COMP_OUT.
+ */
+static int cal_cycle(struct phy_device *phydev, int devad,
+		     u32 regnum, u16 mask, u16 cal_val)
+{
+	int ret;
+
+	phy_modify_mmd(phydev, devad, regnum,
+		       mask, cal_val);
+
+	ret = mtk_cal_cycle_wait(phydev);
 	phydev_dbg(phydev, "cal_val: 0x%x, ret: %d\n", cal_val, ret);
 
 	return ret;
diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.h b/drivers/net/phy/mediatek/mtk-ge-soc.h
index 008efd148a2c..14370b5ce482 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.h
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.h
@@ -354,4 +354,7 @@ enum CAL_MODE {
 	SW_M
 };
 
+/* MTK GE SoC common functions */
+int mtk_cal_cycle_wait(struct phy_device *phydev);
+
 #endif /* _MTK_GE_SOC_H_ */
-- 
2.55.0

