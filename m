Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794400598;
	b=orXb+CQ42S2tcAso3siw8F/aIhV1+aMiOedcEjtZhm6FlthGEjJ9oGpWTOnpIQ2NTKez
	 1qMGULilYq1xgpG6ifKlBEacg2Covgfa0kCCVkE8Y0jaCgeCr7C8TPm2c4dtmOF1nn60v
	 N013UUqp/jAni9Hv+ddfUBN4Fw/1G16KhY7EN6b/UTqTaYEuUVf/RENi084YgqTcnaKoQ
	 ebW5SPHAD1bxMZ/53FJaEQcp9HSUJL7qb4X3+rMrYe7etbtL+ZXLQtmFynXuS/qwNMdMk
	 zf90S0IbPQ8EC/aihZqXwzvrtSinJe9OalgrmtgrRGzm+c8mLQ0CNqL591djvmhJuqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400598;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=T5yPX8adE7+JmO4JQAro7Usn3YNgGssYBATtOGfbuDs=;
	b=kWfgsIaM70SA/Up9SWCmbufE+OWiPCtcDBeTf5qmSS+U8IuD3dcwZXi5pbSdhG77cA2E
	 zaikaac+AHnqzFijRLqrEsoskJ27ScgK86BLyUsx+7/ap/ybuOo2/BR84eKThUGQFZSO5
	 8goqvO8IJP+CYtLY/PfAiO0D3uhDySYO7AQzDgcr0KCXLRSShYqLNYBecfpLflV7VtvST
	 B9ZUmE0BM2PnPvavRnJKvNUoZzihy9+PckO30asQU5OoRKzXn6HC14vhAP+SSw96Cm9Q8
	 vkoameifm1w0qvbKAHfYrMbEBQhmmZPwio8Rjg242ALgXimCDv7XwTEPYXVmK5e5YLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=VEi1sFpD;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AF4606A31C
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 12:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2AF4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=VEi1sFpD
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cdd89d84521so882911a12.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 04:36:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794400597; x=1795005397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T5yPX8adE7+JmO4JQAro7Usn3YNgGssYBATtOGfbuDs=;
        b=hlZAkUYKv02NXtMrVD9Lbj+YH7YaMDniUj8l5vfMUMLFqrOJiirfE8aHSxamC7KDmy
         ZFSlS63i5q2lHYegXxJ2RzNThaNTykdESzz45T4MpWbu9SVsiTQgtA0qSvRZEb6AK9J0
         IHBLJJiVpTurdnFBh8VAU67qnM48uZtEv5Gh+hrKlt6LBmFNbRKaNNKz0z0Aol5RBbpb
         k68+QOX9uOYnqOjT93S0x+N0w/E/xvE1X5K9XTuxZNE1q6c3Gov3adBBiFahJ8+9jHCS
         P2XW6wpR/JQetpz4+QM9GfCFE+Z0QATz5m6lV9Fck3byBaFRRBWa4IjXzb5E9D+JU4jk
         8p5A==
X-Forwarded-Encrypted: i=1; AL+hErE4OcqC8Idic/mQIAYBQ7Lfp+JKaQrhnqvOCSOrkP1t5qM9NkhaLrmyk7y3nj9RJRbCsbaP6ag=@vger.kernel.org
X-Gm-Message-State: APuU4Z+cR1Y0EtLeG3p0x0WpeVgYfbg87GMzn6edOxM05A0G2vGUZDZv
	cUp954dlWEprUcflKfWL72a4tzu02/kvN1K7Ub0FQzKlSYmqfYMl+7eMAGO1geQbT/rH0RkBOpK
	OumjIvMbNttqBCBAtWL74Am6v7pFmZczmUkvLzYsZztWsxya146MJRc7/zhOp9hJpyRE1d+S54s
	27WfU+B6KC4zCgtVbNA/zjAzGCuSePjHY4JJ+wQ62Xc3irZTxeC5lI+Jn9+FkY1pMVv1pJ8VoHr
	aWvtVe/ylc=
X-Gm-Gg: AYBFou25kK5bLNwE+gltwZaEP/SXbmJdKF7rkhCY5MWw77Hh2oimcUPaDWiqMuj+F5M
	RJ2uWE+kWhzxbuVOfNixzWqhgDWWQrMUHWFAshCpaFIGHcxpI2T9oPdG2/pG0Bm7QfFAls+Vqeq
	2xKnY6rqhyM/S3fBXvF+Yka5r7AmsIaEU+LlmWRAz5HixGBiB4E1g/Rop8v/b2CGWuX1si9Bv8G
	HnUMWMXnjT7xUfdF+3w4tgm9wEnUO2RTRjVCD4SXsm9d6uels0tPDzm4kQfTfD5HTL52rTLC/xa
	uIMnntdH8wc406xsoqR9okTGYSEAFs+YG08kayUwLCjmoigSyw277JvCaHPZgD+BhhKf4QfJTH9
	DF59N8drDhE9BoARRFHA8PhZz64WDDZe8R9syjXC+fxs3FrrG6rxdKqVEJQgfDsT3Bl6nia9p8r
	xiVE49NvbhJqMG9XR07YpbDonB3LTbzsALqRg=
X-Received: by 2002:a17:90b:4b84:b0:3ae:3b3d:c617 with SMTP id 98e67ed59e1d1-3b182f2e970mr1672378a91.29.1794400597184;
        Wed, 11 Nov 2026 04:36:37 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b182e2e06bsm633440a91.3.2026.11.11.04.36.36
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2026 04:36:37 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-375bac6bd21so641592eec.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 04:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794400595; x=1795005395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T5yPX8adE7+JmO4JQAro7Usn3YNgGssYBATtOGfbuDs=;
        b=VEi1sFpDdn6lFThG1IkkvDeNTcO8EA33rIL4952C9oBJB6blNMnjmxWBD108LlnAlH
         0BoYD6PfxDc+Hk/DEMyn3nVuG7LaCLav4sCIj70iBbHrYG99RKFTszgSBIldQUZbE786
         9MRUh/jpntj9EwhHAGSDS+OIs5eIiKqq7ePe4=
X-Forwarded-Encrypted: i=1; AL+hErH2YYSTkhxIZz3vkjrTfUoI2Ga5wgZKHTe13Wvm8DpnG3SKWQu8vrdQ9tvn3+ezju+6AlR3mdI=@vger.kernel.org
X-Received: by 2002:a05:7301:4b10:b0:375:6fed:8e71 with SMTP id 5a478bee46e88-3766993ddc5mr3266599eec.7.1794400595260;
        Wed, 11 Nov 2026 04:36:35 -0800 (PST)
X-Received: by 2002:a05:7301:4b10:b0:375:6fed:8e71 with SMTP id 5a478bee46e88-3766993ddc5mr3266562eec.7.1794400594262;
        Wed, 11 Nov 2026 04:36:34 -0800 (PST)
Received: from pc-hpe-top-git-sendmail-server.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375218c863csm15159947eec.28.2026.11.11.04.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:36:33 -0800 (PST)
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
To: michael.chan@broadcom.com,
	kuba@kernel.org
Cc: andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net v2 2/4] tg3: Select PLL clock when preparing for shutdown
Date: Wed, 11 Nov 2026 18:09:14 +0530
Message-ID: <20261111123917.910416-3-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261111123917.910416-1-pavan.chebbi@broadcom.com>
References: <20261111123917.910416-1-pavan.chebbi@broadcom.com>
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

When the 5720 was linked up at 1G before power down, it may fail to
wake up on a single Magic packet.  This is a hardware issue, which can
be avoided by locking the PLL clock source before shutdown.

On system suspend or power off with Wake-on-LAN enabled, if the last
link speed recorded before power down was 1G, set
CPMU_PLL_TLP_CLCK_SRC_NCSI_PLL in TG3_CPMU_PLL_CTRL_STAT, so that the
NCSI PLL locks on the TLP clock.  The setting is cleared on resume and
at probe.

This was reported by a user, who confirmed that this change fixes it.

Fixes: ba1f3c76d760 ("tg3: Enable 5720 support")
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 35 +++++++++++++++++++++++++++++
 drivers/net/ethernet/broadcom/tg3.h |  6 ++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 2cf9d2ea069b..98338c0792e8 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -4267,8 +4267,38 @@ static void tg3_power_down_prepare(struct tg3 *tp)
 	return;
 }
 
+static void tg3_ncsi_pll_tlp_clk(struct tg3 *tp, bool enable)
+{
+	u32 val;
+
+	if (tg3_asic_rev(tp) != ASIC_REV_5720)
+		return;
+
+	/* The register is shared by both functions of the device. */
+	if (tg3_ape_lock(tp, TG3_APE_LOCK_GPIO))
+		return;
+
+	val = tr32(TG3_CPMU_PLL_CTRL_STAT);
+	if (enable)
+		val |= CPMU_PLL_TLP_CLCK_SRC_NCSI_PLL;
+	else
+		val &= ~CPMU_PLL_TLP_CLCK_SRC_NCSI_PLL;
+	tw32(TG3_CPMU_PLL_CTRL_STAT, val);
+
+	tg3_ape_unlock(tp, TG3_APE_LOCK_GPIO);
+}
+
+static void tg3_wol_select_pll_clk(struct tg3 *tp)
+{
+	if (device_may_wakeup(&tp->pdev->dev) &&
+	    tg3_flag(tp, WOL_ENABLE) &&
+	    tp->link_config.active_speed == SPEED_1000)
+		tg3_ncsi_pll_tlp_clk(tp, true);
+}
+
 static void tg3_power_down(struct tg3 *tp)
 {
+	tg3_wol_select_pll_clk(tp);
 	pci_wake_from_d3(tp->pdev, tg3_flag(tp, WOL_ENABLE));
 	pci_set_power_state(tp->pdev, PCI_D3hot);
 }
@@ -17886,6 +17916,8 @@ static int tg3_init_one(struct pci_dev *pdev,
 		goto err_out_apeunmap;
 	}
 
+	tg3_ncsi_pll_tlp_clk(tp, false);
+
 	/* The EPB bridge inside 5714, 5715, and 5780 and any
 	 * device behind the EPB cannot support DMA addresses > 40-bit.
 	 * On 64-bit systems with IOMMU, use 40-bit dma_mask.
@@ -18222,6 +18254,7 @@ static int tg3_suspend(struct device *device)
 	tg3_full_unlock(tp);
 
 	tg3_power_down_prepare(tp);
+	tg3_wol_select_pll_clk(tp);
 
 unlock:
 	rtnl_unlock();
@@ -18241,6 +18274,8 @@ static int tg3_resume(struct device *device)
 
 	netif_device_attach(dev);
 
+	tg3_ncsi_pll_tlp_clk(tp, false);
+
 	netdev_lock(dev);
 	tg3_full_lock(tp, 0);
 
diff --git a/drivers/net/ethernet/broadcom/tg3.h b/drivers/net/ethernet/broadcom/tg3.h
index a9e7f88fa26d..631bacc515ab 100644
--- a/drivers/net/ethernet/broadcom/tg3.h
+++ b/drivers/net/ethernet/broadcom/tg3.h
@@ -1168,7 +1168,11 @@
 #define  CPMU_CLCK_STAT_MAC_CLCK_62_5	 0x00000000
 #define  CPMU_CLCK_STAT_MAC_CLCK_12_5	 0x00110000
 #define  CPMU_CLCK_STAT_MAC_CLCK_6_25	 0x00130000
-/* 0x3634 --> 0x365c unused */
+/* 0x3634 unused */
+
+#define TG3_CPMU_PLL_CTRL_STAT		0x00003638
+#define  CPMU_PLL_TLP_CLCK_SRC_NCSI_PLL	0x04000000
+/* 0x363c --> 0x365c unused */
 
 #define TG3_CPMU_MUTEX_REQ		0x0000365c
 #define  CPMU_MUTEX_REQ_DRIVER		 0x00001000
-- 
2.52.0

