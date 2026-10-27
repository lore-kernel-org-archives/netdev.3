Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140337;
	b=YRGrqlw8h8zJM6GDU6xlbrw5BYGl65Jx1nTL7mAuXQBewO81WcFwNJ8l8063d0ScLFsc
	 Qwb1xmbZE8TJFqT3T9kW40NHD6TNuStwmByv7uOBJ9bnMIfVL4Cyn8AJr0HRltN2ekHdo
	 6N8UQb4a3FIc3Mc+ygfeSv7dyj93UvPNm4zkNS8iaO3sEjskCdd2VL/M0MAXgamAoo1DR
	 DWtJQpZ06zJmNbGcffQPemMGiQnVgUjeLcUPoo0dX9eQOdEPOpCEq+dN6OXgjvvftxunE
	 m4bojd79cwA/TtmjVSM7J50vi+J/BiXUTHjrdzPOqTvVhcPksw5T2kvFcwycD/7cXhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=u4BQktSMRlYHvWF/4DH3ceG+qWnGiYhdIgnI5VmkEx0=;
	b=PuP+F/OORtxeHjyhNtgcmWbLGHO6UV/9WZrAcQLIUgiMHIT40F1M2fmeqRzIDTkr+/k3
	 xiDBltoD4xOYVqfDVkXYCgpwtcZd9kJ7OmV6PLELFoRDYcqvL3H8wRHIB6gwrKojJM9aU
	 a78AQDz01jhOTjCn7bQZlP9+FtFnpm4ad+3kH4vXgvwCDOc8rDuLpG5x2YeOBMRaEBLu0
	 DiO0NZ2si8GrIUxcMN97YQF+w554KzkElGDDZp6nBIwP72V9lW+EYBf3TCfMTJHTm3CMj
	 N77+dTauOZSCKi1brIn4W5ygUzfJ2O48I6VCS4qbXCZ8PspDqA/raPHkyRh1X1BaaKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JQrJ57+l;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D0160A5BD4
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 22:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1D0160A5BD4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JQrJ57+l
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1931ff67a29so756743c88.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 15:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793140336; x=1793745136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u4BQktSMRlYHvWF/4DH3ceG+qWnGiYhdIgnI5VmkEx0=;
        b=JQrJ57+lHenhwTyAjh7P9W6trOV22I4mZb5s2ncXIuMNkkMWYLbCU8m58HXWcDia6W
         f0KbQt+6vvaFA1BEKH/r1JBnCDuVIdm5AgXJtuzcqI9EzW9aUiBmeLGlMWIRWCMZE93z
         Kljf+4rLzdnP9glTyVIdLRm6ZtLp4ykQKrnlnn2WaJDxrRpweSxOJ9sRj3HRlC6BLcCv
         z4FHjU+4nCy9eHCGrcZ21wm+s9xZR9mgmUF13PQHLCCPSVAkG1ZvfIHclBVyNN1ciJjM
         G8CbKTY5PlddnniD/3WW32CQDm24zBRVdyX4xEivOqT7Tapvg7nUxC/0bP8YqqPdnVQh
         nFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140336; x=1793745136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u4BQktSMRlYHvWF/4DH3ceG+qWnGiYhdIgnI5VmkEx0=;
        b=24o2NIr4/vPkn+mXMTpRivo8Sbug+eb5Nbmo2B8OPNsRfW9PPYzgOMm6Rh+Z8acUfU
         Imh7BUXvPsKvl7T/lMy3iBV03Yiyt4pLN0aTjfrxN4a85g0sUmRvQKPzQEEPApJUjdu9
         wTDtLJpFR/OclVGO8/p3VUU4eM5KfaUit4j4mKJMEJF7JWiLBRdNB/bNfNqrVB5LeND/
         IrVmQZXLBIaGLwzm20owqYUCoNdYqQdnKt+VHRTVmYX0jRXIIih2ZEYAEIE/tYzJeY6i
         WMvLic6SjsZZiCTWfJr3iZjn578YknXF/nipgR6yaz61GOUf2DcER9XPtLhvqMHO4EOA
         /wZA==
X-Gm-Message-State: AFq9FYIPmlbb+f6aUiF9myWrY6lVtSKlqd6ETR0svrImmbCmJAFxMN96
	bugqZIAXND99Ag1e1faoNrMmk9uHlJEzProV7E0Ge8kqW5QMMutStLRI/YRDSIuL
X-Gm-Gg: AYBFou3kPtd9rerwKQnhO/zjugLAcDZtXfTX0Z++oyWJrim4XlvoZuDNwZlBepV1pzx
	b7XTwJgAv/Zloz4UvBk8sqIMKSu74GIlL4cZzSibsrkEQfWHT+wQaaZC2e8Y0pf/g/TlLcf39qS
	Sz/ckGrO579p90hwXcBA2hVF0ldXkXbUQCRJIS5KRHCV4oVaYooL8s/WMhKNNDBKabVmLhtQgYh
	P23zeWvCzJpSBsRIEGRjHw/6W525rGAc6UgGP0DD8MSxK7tjhw6wqaV2T4IizTwfZlbLcXKmffL
	nE29gnII+VfiC/zs33p0JhBsTSCJt/z1gfSnhA/HP6ZnBbNdIxDosWwF85I4qIRkMB4mekdtWat
	Qrg2beyTuQ3DlQi0mxX8ozQ/0Urz/iQ0PijnC4P7DMi9D8ZkF0mJV74P3sNRt+K1TccT2pPKipi
	t4zJWQXQX1pROeQxc+Wc187qWaAFo8kXdGkZlGbONmi5ZnaHICXO9uL2Hlk4mB3y314HEbK7lHQ
	MddW2s9Th4snEYmr7ZySG9X++GMw95SyePQmjULKU+6w2zMYjQKCKuazHerIf093gHZ1nutDoMs
	3QYzog==
X-Received: by 2002:a05:701b:4651:20b0:180:15be:1f9c with SMTP id a92af1059eb24-1a6cd499691mr736339c88.30.1793140335703;
        Tue, 27 Oct 2026 15:32:15 -0700 (PDT)
Received: from eldorado (ip70-187-214-22.oc.oc.cox.net. [70.187.214.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a6d98c93d7sm1130735c88.13.2026.10.27.15.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 15:32:14 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jijie Shao <shaojijie@huawei.com>,
	Simon Horman <horms@kernel.org>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	David Yang <mmyangfl@gmail.com>,
	Herbert Valerio Riedel <hvr@gnu.org>,
	Jeff Garzik <jeff@garzik.org>,
	Danny Kukawka <danny.kukawka@bisect.de>,
	Mugunthan V N <mugunthanvnm@ti.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH net 11/11] net: phy: smsc: wait for LAN83C183 power-down recovery
Date: Tue, 27 Oct 2026 15:31:40 -0700
Message-ID: <20261027223140.3774570-12-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027223140.3774570-1-f.fainelli@gmail.com>
References: <20261027223140.3774570-1-f.fainelli@gmail.com>
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

The LAN83C183 uses the generic PHY driver, which returns immediately
after clearing BMCR_PDOWN. Section 1.11 of the datasheet allows 500 ms
before normal operation is restored. Starting the Au1000 MAC before the
MII clocks recover can hang the MTX-1 when reopening its interface.

Add a LAN83C183 driver entry and resume callback. Wait for recovery only
when BMCR_PDOWN was actually cleared, and propagate MDIO errors without
waiting. Resuming an already awake PHY does not incur the delay.

Fixes: be9dad1f9f26 ("net: phy: suspend phydev when going to HALTED")
Link: https://pdf.dzsc.com/LAN/LAN83C183.pdf#page=44
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/phy/Kconfig |  2 +-
 drivers/net/phy/smsc.c  | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 30e9d22c8d1a..10466b2574eb 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -421,7 +421,7 @@ config SMSC_PHY
 	tristate "SMSC PHYs"
 	select CRC16
 	help
-	  Currently supports the LAN83C185, LAN8187 and LAN8700 PHYs
+	  Currently supports the LAN83C183, LAN83C185, LAN8187 and LAN8700 PHYs
 
 config STE10XP
 	tristate "STMicroelectronics STe10Xp PHYs"
diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index 48487149c225..c3b51afd4b1e 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mii.h>
@@ -684,8 +685,32 @@ int smsc_phy_probe(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(smsc_phy_probe);
 
+static int lan83c183_resume(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = phy_modify_changed(phydev, MII_BMCR, BMCR_PDOWN, 0);
+	if (ret < 0)
+		return ret;
+
+	/* The PHY needs up to 500 ms to restore operation after power-down. */
+	if (ret)
+		msleep(500);
+
+	return 0;
+}
+
 static struct phy_driver smsc_phy_driver[] = {
 {
+	.phy_id		= 0x0016f840,
+	.phy_id_mask	= 0xfffffff0,
+	.name		= "SMSC LAN83C183",
+
+	.get_features	= genphy_read_abilities,
+	.suspend	= genphy_suspend,
+	.resume		= lan83c183_resume,
+	.set_loopback	= genphy_loopback,
+}, {
 	.phy_id		= 0x0007c0a0, /* OUI=0x00800f, Model#=0x0a */
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "SMSC LAN83C185",
@@ -887,6 +912,7 @@ MODULE_AUTHOR("Herbert Valerio Riedel");
 MODULE_LICENSE("GPL");
 
 static const struct mdio_device_id __maybe_unused smsc_tbl[] = {
+	{ 0x0016f840, 0xfffffff0 },
 	{ 0x0007c0a0, 0xfffffff0 },
 	{ 0x0007c0b0, 0xfffffff0 },
 	{ 0x0007c0c0, 0xfffffff0 },
-- 
2.53.0

