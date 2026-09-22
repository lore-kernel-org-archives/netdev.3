Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79783EC686
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108832; cv=none; b=VQ2yfC+IxT00zG9THNoUEuX1vnHP1gFpWQDa/A0QDMd15xRGC4SaUapsTXajHfsiu49vkSytkhgNprhq/wCTbuJlGDIAc9jcqcQuMW8sHYPwsZXbL/SwSX5oZnBCC2spPVUmVkD/pcLGDmdpWaf2rHVkgVtarfDVufk/Lru73Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108832; c=relaxed/simple;
	bh=mIJXLwvbFSVFO3ybXJjqxL8zaCOnr2Ibsf+VrGWzXs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDg++S86I2JLrSYSBTyM2XBK5p0ToXwCoA2H6L5G13kzZaH3686BNJtX/CG4GiN605H0AgDIV4S8hVx/Yy2pGSjz2pxCg3ie7kkP3WNKqJsovpvprogVjNHW/pGOnmiqF+0ft7uCy6p9smuIKUag+BDIoOlmE6byjT9CgZWyCVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLrFxWd5; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLrFxWd5"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa65080so24598966b.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790108827; x=1790713627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M4G30vnhFwwk14qfzsmVKM817vS4bXszw5VB1vCra8U=;
        b=iLrFxWd5tgY0iTAoU4Ynv9fqJCXvFgZWCaZsl10Xvw7EDSK8APxBY7fOaV78dExwg0
         A9e9dG321j7Ojju4BxkT5knhk9Xappc3zOzb7Bn/mxwctpQ4nE0lfRoN5JGGcCAy8Cdb
         LcSdn/MXdo5CnIf0Qq44hCvi3kPYOCV0cpv2KPbJWyr1cSS1RILoA5DvCPZbRqEaYVDs
         amdy+u3t+cJACtqTx93hFvceXr2Kc2BBDtTXXZSexigBDpZvbFt4Bl7adY29CSMm0/ZX
         hNdol1HogHDSFKrO7NK3IF7PRHhlpXPiNjxZWQhdj4bG5X2X5DQ0b4ls5H8u4wH9WXS8
         SHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790108827; x=1790713627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M4G30vnhFwwk14qfzsmVKM817vS4bXszw5VB1vCra8U=;
        b=EqeblZY/Tbofz1XUu/MEpButLc/A0RwipTPJNPKe/8l9Qjau9JdVmwB665E2lxcaWd
         86uSvBp46OyzhbSyEG0MCddrgHPces1XuqFxKyMMMvTuU0ER7UhyEY8dpWOKZiNxu9Lt
         qEXAgADgpOADsfIsosGDwWHKpPL3VkMnk6DpVJLKd1gGVQciK0fAbZb8NBZSMxRgxxji
         MhlYf3tVgHK2ggY6/VoOtedOUWiwH8yMm22RWL+EqXJKxI/YAz5EKBFeRidZD0vpi3w4
         8RfpUkEPt8Lx95j8pPXDNU87J2cmn0VuUq0z+RWrd57HMFPcpLTYBrzJkxYS0EXB16ra
         3fOw==
X-Gm-Message-State: AFuF++mc03Nsgd30+1ev6oxRqxQOJWK/UEbBh9o240gmMBShH9bhWGG4
	RpHE4vu/vAcXCA8ecFhdsx5hZWXEgwSaHtNCu2I9EAwH7D+UlX5ER2cJQFoJ/Z/SoSQ=
X-Gm-Gg: AYBFou2J1CiQwKXYC3yYZYGH3PCGUsn/Hua6jxxVLnKzCf8ViWbMh4qEOzi+Ncc5i3a
	XzqgJaNGrg4WhYu5Fpxuf2dJ/YCExGOBUtQtddYT3YvnHb6SrW4si3EwDKPQSHRCe19APxSuEKi
	6pzZ8QB5wQUtddgJeNjX+3kfgrejCgv/5n0N7+CWFuMXh7dYTzUkirBcfWqexba8IHYQXrbDEeU
	eHOv6XBVzXqGQC9TmnXHVxWY4KaDPpYVKLK/XZcY7fJBP9Ohd58QcTpBRMm2815Q0waHEfhuPDr
	4EU5UbAYSCcy8Yace2kiLVr6NzRhj5HxeA/07XUZgo1ftKDBJ8CxdhyYwcI0o0V83Ew8OKrV/GJ
	kDX1+sto0vX39X6PQ34PeNocPcUxIb/khYhIWhPqUJKUB7QQBkorXkMr++Brbbp3GLIsHqCxL1x
	SPixT5VrQpZ2sCUD/r/FA1pTiJAZ7hTH4J34x46pwqrOYS6IahSrEmW7PUe4VrvxFKyZplrfCNK
	oDbE4koR1LsNsNtYCRGJl3bYok8SfLKzNgoNtMkNzEaGJqtmj0FaH0kYCjXKZchvxwD3xhaX/51
	U5+Q2vfQm54vnuKZYcal+GzBTxDXhO0=
X-Received: by 2002:a17:907:9409:b0:c16:4e5:944a with SMTP id a640c23a62f3a-c2aae19b8c9mr27553066b.21.1790108827165;
        Tue, 22 Sep 2026 13:27:07 -0700 (PDT)
Received: from localhost.localdomain (83-233-130-25.cust.bredband2.com. [83.233.130.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c6f5asm11080466b.15.2026.09.22.13.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:27:06 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	ansuelsmth@gmail.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	florian.fainelli@broadcom.com,
	jonas.gorski@gmail.com,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	hzyitc@outlook.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Yongzhao Chen <yongzhao.derek@gmail.com>
Subject: [RFC PATCH net-next v2 1/5] net: dsa: pass PHY flags when connecting shared ports
Date: Tue, 22 Sep 2026 22:26:49 +0200
Message-ID: <20260922202653.1153-2-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <20260922202653.1153-1-yongzhao.derek@gmail.com>
References: <20260922202653.1153-1-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DSA calls get_phy_flags() for user ports, but passes zero when connecting
CPU or DSA port PHYs. Pass the callback result before PHY initialization
for shared ports too. Drivers without the callback still pass zero.

Keep bcm_sf2 and ksz88xx shared-port flags at zero, preserving their
existing behavior. Document the extended callback scope.

This lets qca8k pass revision information and a SmartSpeed quirk to an
internal PHY used as a CPU link. The remaining patches supply that user.

Assisted-by: LLM
Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>
---
 Documentation/networking/dsa/dsa.rst | 2 ++
 drivers/net/dsa/bcm_sf2.c            | 4 ++++
 drivers/net/dsa/microchip/ksz8.c     | 4 ++++
 net/dsa/port.c                       | 6 +++++-
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/dsa/dsa.rst b/Documentation/networking/dsa/dsa.rst
index 7edfdd555..647f952e3 100644
--- a/Documentation/networking/dsa/dsa.rst
+++ b/Documentation/networking/dsa/dsa.rst
@@ -668,6 +668,8 @@ PHY devices and link management
   on its own (e.g.: coming from switch memory mapped registers), this function
   should return a 32-bit bitmask of "flags" that is private between the switch
   driver and the Ethernet PHY driver in ``drivers/net/phy/\*``.
+  It is called when connecting PHYs for user, CPU and DSA ports. Drivers
+  should return zero for ports that do not need switch-specific PHY flags.
 
 - ``phy_read``: Function invoked by the DSA user MDIO bus when attempting to read
   the switch port MDIO registers. If unavailable, return 0xffff for each read.
diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 9e5713015..f516fc396 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -709,6 +709,10 @@ static u32 bcm_sf2_sw_get_phy_flags(struct dsa_switch *ds, int port)
 {
 	struct bcm_sf2_priv *priv = bcm_sf2_to_priv(ds);
 
+	/* Shared ports previously received no PHY flags. */
+	if (!dsa_is_user_port(ds, port))
+		return 0;
+
 	/* The BCM7xxx PHY driver expects to find the integrated PHY revision
 	 * in bits 15:8 and the patch level in bits 7:0 which is exactly what
 	 * the REG_PHY_REVISION register layout is.
diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index d74981320..be8861a7a 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -3076,6 +3076,10 @@ static u32 ksz88xx_get_phy_flags(struct dsa_switch *ds, int port)
 {
 	struct ksz_device *dev = ds->priv;
 
+	/* Shared ports previously received no PHY flags. */
+	if (!dsa_is_user_port(ds, port))
+		return 0;
+
 	switch (dev->chip_id) {
 	case KSZ88X3_CHIP_ID:
 		/* Silicon Errata Sheet (DS80000830A):
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 1f5536c0d..4db7e6f9c 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -1666,6 +1666,7 @@ static int dsa_shared_port_phylink_register(struct dsa_port *dp)
 {
 	struct dsa_switch *ds = dp->ds;
 	struct device_node *port_dn = dp->dn;
+	u32 phy_flags = 0;
 	int err;
 
 	dp->pl_config.dev = ds->dev;
@@ -1675,7 +1676,10 @@ static int dsa_shared_port_phylink_register(struct dsa_port *dp)
 	if (err)
 		return err;
 
-	err = phylink_of_phy_connect(dp->pl, port_dn, 0);
+	if (ds->ops->get_phy_flags)
+		phy_flags = ds->ops->get_phy_flags(ds, dp->index);
+
+	err = phylink_of_phy_connect(dp->pl, port_dn, phy_flags);
 	if (err && err != -ENODEV) {
 		pr_err("could not attach to PHY: %d\n", err);
 		goto err_phy_connect;
-- 
2.43.0
