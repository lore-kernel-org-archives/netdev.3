Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792708221;
	b=ra3qpZbzvnqfUIC6CuuAnmWRdlNboqs0EEjYu3AXTIj1BPP8vJKeOr6SOkcQhPEwt8RD
	 CKbfgbPlP7zbWuMpEvJBI57/OibwtxqtlPQx36aB8zB+JsjAcFVb0AVvLUp6+TtZylL24
	 PZrPfiWr8UzwiniNK0DQPqTnBWc1afqB72UMCWT6IoPjuMUojns71TH7mVTb4okyL9LYZ
	 mdNALL7HQr5S9ghVHvUkdDkRN8cbsN7AZW0hykBDcblEZaFUcqSeEaQ+Mbm7bV6ijck4o
	 c5lX6E5Y9bmYk7BWTImMYcKamX/5LtNMo13mDVuIEFm5Aq8PNZc3xVlk3/HSmScX5PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792708221;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=P+nwbsIvAz9hhS3P5b7t6hwq5Xj7R9U3WHLPFL/+GvY=;
	b=ltFnswjk5Q/shmce0ePsg7zkc8Ery+aO6T7Yoen8DLHiccO22TS6mdahZ8oU5894JchC
	 HYNuSjPDzMqvwhAHo/dnpGxaVrzsxEs4k7p4Owp/s+GX4TbqiWlVAp/j31PlUARE1IDz1
	 FA9vlHzbLrDObh9SvW/EDJoj+kMEBgChr9faj7b3M/yz/JdBwyl+rLwZBrtNSbgIa9lUk
	 vwRCzbN9GYjldda1gyGDWy0fWg8Wp1yRP8Hof4eS+5Ubkyf05HsniwmLBHQgfHU0+Ikjo
	 W0ViuHa39QKFaiaVgvOrZS//6jkusgxfE3SjovutDGtXMwtceRz9Kk1cQaMHGibiIlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=escYtTYE;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BD2606A31F
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 22:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66BD2606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=escYtTYE
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a210470b49so2123795e9.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792708220; x=1793313020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=P+nwbsIvAz9hhS3P5b7t6hwq5Xj7R9U3WHLPFL/+GvY=;
        b=escYtTYE6k1GGegiq/09qM0KPEzrPvF6/Z1D/RYSkMgHwpO8lMHHCOc9Mi8nxgxR17
         YNqOzw347quJIQwna+P2nkLKwpKC1rwQOQIi9fde9zo26SdHnZaayHcqzUbo3GHgllJY
         hVngi6B502lYAq/UYs24zQD/3TebtWpEJgMfPC+u1cm7nDYK8BiV6K9w5CHZy4J2F0XH
         L/n/sEHGBt99v31/ntmQMhVjIWL65MnB/5BhmWTcTudQDRfmjuDirDCvaHI9Yr7REJ1H
         zdZxYqwLj287NPTSQSMcqqrzUyznilUJPoBd6++pFPM+QBEQdM0PNpb8TNYH6wC/NB/9
         va5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792708220; x=1793313020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=P+nwbsIvAz9hhS3P5b7t6hwq5Xj7R9U3WHLPFL/+GvY=;
        b=TF9ykS4u/Ez265ejLklhB0jxt9Ko2BuayyGjUfL+pnm8rUMpgPw1ZZos3rB6ZKVZ08
         YfYgGQozJ8TJPhhFL3aAmhOZ4mWJG2/Xqcd4isvSImJnzPQnANenr7VCSgCz/m+f0rzI
         sR3Bqaduci8nRIFMR0MIi+LlyZRMnrjUp36BpDuqfDnw06SfvhwwtJ5GET0ZiyGzqmze
         U5O4xuRQ8Oxf7uCUXTfzVDfmjmNbMIavQit+0Cv+papX1BmNTjAZcU+0XJjw04Df2ZvE
         gBbI/5wBE9Sq6ogGHRf3OvfZJEpjn2hQXnchy7QQGECJDKui3Cq/2syAB+T2i7M5WOB2
         JESQ==
X-Forwarded-Encrypted: i=1; AKwUvBw6vrQzT0Mp46bKxHI5Q6A99Qvi0N7g7frEpGgu8ajwtpDLFZkTqAjnpwxEecm5i0NE8sGZT5I=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsFj1TLE2zs3APIPSE0t2YNuz08KEkK2F2qzWl+UtcVvi9pdQb
	8z+kE9dGHV/PR4M4F6f5wrgjLyKA+exwzp60qXEhU0l859PF1mduJ8TQ
X-Gm-Gg: AYBFou1CJUNrqT8FDKFI32dAn/FVsJ4zl79vkHiPBhjq82Y/zI/9FaVu7H6T4VhlVDs
	DJCCvINQmR4V26CSGUTbpfcqvCLSEOab08eDJFv19mz4SSSEMqyYaMisOVGR1rXvX91NW7YKEsT
	C0zlgr8oCj3h3/BPDMUyKfWFobHO63H2hlsxHU5YzAPrBljPGfNVRXPkptUBtgV417o1143exCo
	AZlC0y8h3p8VEENYsfWOXdUy9+01cjtAg+qSQrUgVjIKLhCo0JYErTtS3YCTnAH50Gh63yilfE6
	j582IBxiLvUD1y/3JS9wvWExfn/EdJLfhAp716UkciHFoxbFOJI47xv2AHAe/gvBLnYwYDhuxG0
	JNXuipExLJ5qQYV7QGe5GMj6xnOVjF4YaU4SQiA1YP/F7mnBNfkQh0k9I9PcldgioLUAF8bOpfJ
	L9s7RRjprj8uq6Gag2MkPZcvh/lSuhZrPrb3PDVGm78Z8YKFC9wG5EVY5LxM3Vof0p04DjsRw1a
	EeMnZEa138H4UcVGUKXLBxz54H7K9xUhVgpbTjGblbCU8BQ/BR6x6sDh7TH2GGWczhbGe9DapHg
	daaMRDUCrcqMrkK2AE4st/GUKbg+9Oa3gGS3cTteIGOaPI8R9FKDr5FzNy6j
X-Received: by 2002:a05:600c:3b9f:b0:4a1:90d7:88a8 with SMTP id 5b1f17b1804b1-4a211f1a48dmr6838995e9.25.1792708219662;
        Thu, 22 Oct 2026 15:30:19 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it. [93.34.92.187])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a211be8f79sm11958795e9.14.2026.10.22.15.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 15:30:15 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 3/4] net: phy: as21xxx: force C45 OPs for AUTONEG
Date: Fri, 23 Oct 2026 00:29:53 +0200
Message-ID: <20261022222955.698722-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022222955.698722-1-ansuelsmth@gmail.com>
References: <20261022222955.698722-1-ansuelsmth@gmail.com>
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

With further testing with 2.5G NIC, it was discovered that the PHY
require the C45 OPs to configure and restart ANEG or speed higher than
1G doesn't function correctly.

To force C45 OPs with generic PHY function, clear the C22 bit from
devices_in_package bitmask and implement a custom .config_aneg.

Fixes: 830877d89edc ("net: phy: Add support for Aeonsemi AS21xxx PHYs")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Implement custom config_aneg

 drivers/net/phy/as21xxx.c | 43 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
index 519b78d3579d..e2988cb10c04 100644
--- a/drivers/net/phy/as21xxx.c
+++ b/drivers/net/phy/as21xxx.c
@@ -616,6 +616,13 @@ static int as21xxx_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	/* Even if PHY declare support for Clause 22 register,
+	 * Clause 45 register should be used for ANEG configuration
+	 * and restart. Clear the C22 bit for devices_in_package to
+	 * force C45 generic OPs in generic PHY ANGE OPs.
+	 */
+	phydev->c45_ids.devices_in_package &= ~BIT(0);
+
 	ret = aeon_ipc_sync_parity(phydev, priv);
 	if (ret)
 		return ret;
@@ -633,6 +640,32 @@ static int as21xxx_probe(struct phy_device *phydev)
 	return aeon_dpc_ra_enable(phydev);
 }
 
+static int as21xxx_config_aneg(struct phy_device *phydev)
+{
+	bool changed = false;
+	int ret;
+	u16 adv;
+
+	ret = genphy_c45_an_config_aneg(phydev);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		changed = true;
+
+	adv = linkmode_adv_to_mii_ctrl1000_t(phydev->advertising);
+
+	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN,
+				     AS21XXX_MDIO_AN_C22 + MII_CTRL1000,
+				     ADVERTISE_1000FULL |
+				     ADVERTISE_1000HALF, adv);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		changed = true;
+
+	return genphy_c45_check_and_restart_aneg(phydev, changed);
+}
+
 static int as21xxx_read_link(struct phy_device *phydev, int *bmcr)
 {
 	int status;
@@ -990,6 +1023,7 @@ static struct phy_driver as21xxx_drivers[] = {
 		.name		= "Aeonsemi AS21011JB1",
 		.probe		= as21xxx_probe,
 		.match_phy_device = as21xxx_match_phy_device,
+		.config_aneg	= as21xxx_config_aneg,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
 		.led_hw_is_supported = as21xxx_led_hw_is_supported,
@@ -1002,6 +1036,7 @@ static struct phy_driver as21xxx_drivers[] = {
 		.name		= "Aeonsemi AS21011PB1",
 		.probe		= as21xxx_probe,
 		.match_phy_device = as21xxx_match_phy_device,
+		.config_aneg	= as21xxx_config_aneg,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
 		.led_hw_is_supported = as21xxx_led_hw_is_supported,
@@ -1014,6 +1049,7 @@ static struct phy_driver as21xxx_drivers[] = {
 		.name		= "Aeonsemi AS21010PB1",
 		.probe		= as21xxx_probe,
 		.match_phy_device = as21xxx_match_phy_device,
+		.config_aneg	= as21xxx_config_aneg,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
 		.led_hw_is_supported = as21xxx_led_hw_is_supported,
@@ -1026,6 +1062,7 @@ static struct phy_driver as21xxx_drivers[] = {
 		.name		= "Aeonsemi AS21010JB1",
 		.probe		= as21xxx_probe,
 		.match_phy_device = as21xxx_match_phy_device,
+		.config_aneg	= as21xxx_config_aneg,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
 		.led_hw_is_supported = as21xxx_led_hw_is_supported,
@@ -1038,6 +1075,7 @@ static struct phy_driver as21xxx_drivers[] = {
 		.name		= "Aeonsemi AS21210PB1",
 		.probe		= as21xxx_probe,
 		.match_phy_device = as21xxx_match_phy_device,
+		.config_aneg	= as21xxx_config_aneg,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
 		.led_hw_is_supported = as21xxx_led_hw_is_supported,
@@ -1050,6 +1088,7 @@ static struct phy_driver as21xxx_drivers[] = {
 		.name		= "Aeonsemi AS21510JB1",
 		.probe		= as21xxx_probe,
 		.match_phy_device = as21xxx_match_phy_device,
+		.config_aneg	= as21xxx_config_aneg,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
 		.led_hw_is_supported = as21xxx_led_hw_is_supported,
@@ -1062,6 +1101,7 @@ static struct phy_driver as21xxx_drivers[] = {
 		.name		= "Aeonsemi AS21510PB1",
 		.probe		= as21xxx_probe,
 		.match_phy_device = as21xxx_match_phy_device,
+		.config_aneg	= as21xxx_config_aneg,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
 		.led_hw_is_supported = as21xxx_led_hw_is_supported,
@@ -1074,6 +1114,7 @@ static struct phy_driver as21xxx_drivers[] = {
 		.name		= "Aeonsemi AS21511JB1",
 		.probe		= as21xxx_probe,
 		.match_phy_device = as21xxx_match_phy_device,
+		.config_aneg	= as21xxx_config_aneg,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
 		.led_hw_is_supported = as21xxx_led_hw_is_supported,
@@ -1086,6 +1127,7 @@ static struct phy_driver as21xxx_drivers[] = {
 		.name		= "Aeonsemi AS21210JB1",
 		.probe		= as21xxx_probe,
 		.match_phy_device = as21xxx_match_phy_device,
+		.config_aneg	= as21xxx_config_aneg,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
 		.led_hw_is_supported = as21xxx_led_hw_is_supported,
@@ -1098,6 +1140,7 @@ static struct phy_driver as21xxx_drivers[] = {
 		.name		= "Aeonsemi AS21511PB1",
 		.probe		= as21xxx_probe,
 		.match_phy_device = as21xxx_match_phy_device,
+		.config_aneg	= as21xxx_config_aneg,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
 		.led_hw_is_supported = as21xxx_led_hw_is_supported,
-- 
2.55.0

