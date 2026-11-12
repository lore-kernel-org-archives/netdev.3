Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794459257;
	b=yfyTEBph41uEoYiJrfN+HLw1TNThz19k4lmVj8xHNyUy+SiFwMhXAs/TDDVrwc1toIRG
	 qEpdaSmdtGzYtrH8F9A6VY3OS4YLE4Cufv7ieW4VY6CvZYW5xboIY6Bu9Du0XXPliecoF
	 EjzFPtpzRC/0JGCruqAyP8j20iYRDUYqcOHEPVTnpY5R0yVtQHj+Hg+dLNzm77gjIn8Ey
	 bTPhjhTcTl08sD5rULgAJMUge4sKPlnAASVK2h+YGYIzg8/DeA5Z1AqvS1cDt+UDqAKB3
	 PBInrpJpifEc7zZ01Gpk3Cu9ApoljtPxXAYpXcay/SrZbdBM4wE22TI1TvJZmDIPwyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794459257;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=u4BQktSMRlYHvWF/4DH3ceG+qWnGiYhdIgnI5VmkEx0=;
	b=aSzGfKUeTHC24sBi60o9qp7IEAgoNWSL+WFoxVCXm4Vyxog8Gl0CHCZqNMEBZ8SpTXw7
	 cZvGfqq7OC5tLUbaI8HSI1S3TduqYJvIZfg25jOOKxJueYQDL7GIWSEJqwVypUR08uHWQ
	 n85MiaE0SMPeVsdo9OI0tG2qs9d8JmSLiNXFwjAqLIJOBFQSpl5+U9KTEApbsKti0F1pO
	 hte41ThAM6T+iyXk1Re34XRVp1su1cLrMNGhKnIpnPG41L2BwRy7upYIs/ybI04JC11O+
	 pP1efhKfxIAfsKtYuecYXcxsvoo+Rtt+S3Q3v+/nljWpyvpUyUg5rCNG4HRP+wlou2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iPFScD85;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC63606A89B
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 04:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DC63606A89B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iPFScD85
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-15ea896ddc8so5915066c88.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 20:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794459256; x=1795064056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u4BQktSMRlYHvWF/4DH3ceG+qWnGiYhdIgnI5VmkEx0=;
        b=iPFScD85PsZv8LHT/PgflVmuoG/DMPT5VMLPWwT8NoTJoj2D1nrdo6K+5giU12Y+Jn
         EYPIWlhKwMVOkUUvxfPaS5XXCQ5BanFutYroYJT7n+2P9P7v+MFGieudv/HWEyrOG07c
         JJbkZKBDMaMki3FvX33T+VsikkkJcrtStKrgzo+UkBm0iZ5g/lV44kyiBjQUQuRh/vXE
         JfQC8KU/Atp+8K2Pjz09TqedwadUXnTpDEi/pIE9deYQJwKVKyNIZEeRql6/usv39tHd
         +RqtQLZoq84sT2k/CutAFpI1CKJcYlp4E7X/8tk6IN/cE0Z1TpVF9MIXNHXUA+Jnjib8
         3Rkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794459256; x=1795064056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u4BQktSMRlYHvWF/4DH3ceG+qWnGiYhdIgnI5VmkEx0=;
        b=csBvdXqEOzG84c6CmG2zb3sAeGnhpEeW2qdNtSclwpE1a6PdbPMgG2wqcVk2YKQr/6
         6VuuQRThzrT25Ge6Ub2Ex2vZ1ecT67fd0L6rTTwWsAHjG/YVKVQUGVo3NQpIhdagUJ1E
         hqcJbaCmdQuD/2Dq9B01RA880PB702FaanpnBL8Cb/Wfoz4qat3jSrYTQ0XzSWw90ImM
         QFat/Fy7p6ZzkubUl22cbqNFL4emz5UG3CiXJG9yL760fW5Bi70WBKW1C3oLcwzvE6eB
         VJJUEKOlLpHc4ItSfkgppx67/fb2NJLmuyUIFFe/Zxw4XsNew+a/ND4+TP2voF9P3P9p
         YTqg==
X-Gm-Message-State: APuU4Z87zxCagu6vuwY6TPo4bVKEOS/UqWsbCzLoXtUAaaTxV+GhJdRJ
	KaJa2EroFJ1LI74eyQ2IElqIq18a1nDmgmE3sW5JyPipXnEfEyO7lG4TMXDi9A==
X-Gm-Gg: AYBFou23Lt21TdntTQCj9pcn5Yd3N/gJHEtFA84EldX+pVH+y/9xvrnJVvYIHB4f8tL
	IOmKZ0Ih5R1sQv6tcn8daD3+VnJqQheVaWQNcCjYNplWXvvn0Op22Fcg+zcWgJrAIwZEFjkiqj1
	kNz+iSGiSVrVv504oWCy4mS2Cvj90FwbMA4g9hnF2dUq1QQ/CEe6gmHHo2RmnYVYjTTsycht0TP
	YWqjMQryvwwHflcK0rLZV2DBmjc0N8xvbC246ABYaG0WPC/T9Ta75wWVhHP7RMUhxef/RxDAXb7
	/WoQI9IB8QNy6MSoeSr3mHKqswiQa70eTtVT9/0FrsTpe4cdCjxdK83yNJOIl4T8vZNs1QjRdRN
	mhzwp69t5CzaiYtsZRc0DHEKKbEESQo4C5hIkgm8rSN0rTh2A25SMQK0/uF+a6F1cXgvgT0jxE9
	HxYpWkk3Wqn1Fh9hNUazcadFxLNdwNqigsjYxHuBsbeQHEIF+4DR4dPZ6zBmSTSHY93CLIdDmzS
	XABG1Vy8e5+WWUFV5EmQpDggC5nRcSxF0EmatvX8K3Mu67h2IXzxqZI7rM7CMOHN8TUNDZ4zbXB
	w876ycaAA7+yVMER4W+yEX+1ErwQ9A==
X-Received: by 2002:a05:7300:e9db:10b0:377:2fb9:9296 with SMTP id 5a478bee46e88-3772fb9c7afmr3183946eec.8.1794459256200;
        Wed, 11 Nov 2026 20:54:16 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm23921585eec.17.2026.11.11.20.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 20:54:09 -0800 (PST)
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
Subject: [PATCH net v2 10/12] net: phy: smsc: wait for LAN83C183 power-down recovery
Date: Wed, 11 Nov 2026 20:52:52 -0800
Message-ID: <20261112045301.3669532-11-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112045301.3669532-1-f.fainelli@gmail.com>
References: <20261112045301.3669532-1-f.fainelli@gmail.com>
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

