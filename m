Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFCA3D6CB4
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556531; cv=none; b=IRs0eE4sb78bcfeFVcVvptSfDdhLHiXKFqzICDIxG3lXBiAQZbkabRH8waShylnXgwMN2Oud3fymNdkxteuy/JkcMEs5yiInowdrBeZFMFADym5EoyJkE0zIUtsI+Whk4cvP/ea3XBLiSMTK15lA+iew8fSOrJfoPsJyB+OgATU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556531; c=relaxed/simple;
	bh=kYOWTtcRSnBg2+a4cGHVZyquREY6r0DKghYsyPc9Il0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJOvmKmXYl43Kh/L0Jnxd1yE8KZUbrsuXJSxWS49kTjIxfSo26u3jZsnQIYwV1mKSlbvjWIxK/TLE0NcRd6r4iCeAsv2/L/IY7c3Sc7FHYoO2U2CueQqhoSCoGkSugMShSjRQs7hnW9a/VrH+eCLJzc4BAYSr9drThCk+/d5P64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com; spf=pass smtp.mailfrom=jclark.com; dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b=JLnJn6Gx; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b="JLnJn6Gx"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-917866225aaso47748676d6.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 07:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20251104.gappssmtp.com; s=20251104; t=1791556526; x=1792161326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=39M6cKiwSBQh698eXKEbMm/aXVe8zrZhERHGjPGBWrE=;
        b=JLnJn6Gx9ndL/iovvnjMBVuZsdyW+ORKJttqy+wArXAwr6aHgJpsBMjFdsjenrKLz6
         mMOYc4kcSVtrUZG5/W+1REd9p2NgDVi20V5Pl4weCmoeC4yvA7zxl5qqGA9E8Bi9Km82
         /3LbkTnXSeAfXQUIY7Dmrrzg95od11RwLEiJBqjX/dtWEa+0aDhPwgvDVqika1fCCCOY
         DcB73ueb9zn2LhM20ECVK5SAxIjnGLJkWpJDFyhZqtjdW0I8kOssDTUe42aAgKH3WWW+
         ankGc8wGQtrqLYJzUs7bFWC3CvHLjfucodFFkTEMD7zFOTcFWabu5dDgYfXMjlVYbYwx
         /Org==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791556526; x=1792161326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=39M6cKiwSBQh698eXKEbMm/aXVe8zrZhERHGjPGBWrE=;
        b=npzmEQW+F0ip/lv7kUCyjKlWC/Uq4fIlhOwYtvPLTomEzGc8X6R3d3+wQpg8iBo3hj
         ZzREGuvT/r9/0gygR9XiE9lRmpNFZpEPSFD4/4aeGJ8G/3RdCAqVaucMmRcS1nIcExfj
         tAJI+NeYyiBBRl2Yp6rulsBDgrIRcIhF4B4Ub2Xai2sANjMehaWQspXbhB01noBf+onf
         WRKyekClEqjV1Izn/pNusSNIOmloUC0syZBeOrNMyD1QABJHJAA7IrLCqg/QfGISSN2S
         Hncr27+ymdOHPwHs7ycYuIQLepGpWp+PT/ffGEm2zEsHaHb0nktjJ6xamHuLcdO1P14t
         EzCA==
X-Forwarded-Encrypted: i=1; AKwUvByaWuM27WTjwOqEE00mXF1oQ9lO/OQa7dSgl40TtnEwddBqlF1KF0Be/WsaQ7EC+oh3AMiY6K0=@vger.kernel.org
X-Gm-Message-State: AFuF++kYxArlT5FlvksN1srhoZMnGluv+HVIs7z1+jHty1y/V1swTjwi
	JUXQArEOJ4daK2Vy7RD0oFZbsNe8bRvB1fQwHo2aAN+Gy4D0JxKF5eoaPZXFXxR9hQ==
X-Gm-Gg: AYBFou0z17UXl7UjZrqQjH2loIA0kAl+E7UjRB91KD7DxVT8KKsy/LGwtHIzopTLfXh
	/DbF34dnHtph5A8XYOmqLVOfrxs3PUj5//trvZOgxxilCGmBb0lwrm07Oc6nLtOfqh+4IaBob92
	3tfakMbRo2CM/Lz07NT3IQxLl3rtnLcRZCE5JCJ1X3vPMNasI57med1qzwyiOOPh1PimZXxIQGT
	I0JkV5kF8/e3V9he6Sf8XX3E9K0p8EQCQHkk4Xlu+v4iI33YNhOcEyqRxPvTX0qSRFAVuTjW6Na
	ico/C51v5V4NfwIG+rUSQPCmWGNH8n7YxrhKczEPr5W52VMukjNdzEU+QJt5WAEVD8BjIxWRqug
	wLOFT4u62qnUXFaB0sT+scbJh8jSOa24tX5kQAC+OIkQuZuob8YH0Czvyjugs1AcDqdiYle/b1g
	+yMZrLnmuLBct1fbwh4kyyoIB0T9rBKLueGWk5LDPPDF/pIeB9cxxSWLYqAo8j
X-Received: by 2002:a05:620a:4503:b0:93b:d7a0:d9dc with SMTP id af79cd13be357-93ebd23ca0emr314762985a.54.1791556526173;
        Fri, 09 Oct 2026 07:35:26 -0700 (PDT)
Received: from cantal.lan ([58.136.72.162])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b5501751dsm19769456d6.17.2026.10.09.07.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 07:35:25 -0700 (PDT)
From: James Clark <jjc@jclark.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Conor Dooley <conor.dooley@microchip.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/5] net: phy: broadcom: use timestamped MDIO writes in gettimex64
Date: Fri,  9 Oct 2026 21:35:03 +0700
Message-ID: <20261009143506.2507607-3-jjc@jclark.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009143506.2507607-1-jjc@jclark.com>
References: <20261009143506.2507607-1-jjc@jclark.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use __phy_write_sts() to obtain tighter system timestamp bounds in
gettimex64 by timestamping completion of the write that triggers
capture of the PHC time.

The PHY captures its time a short delay after the end of the write.
End-to-end measurements show that the delay is small, within the
measurement accuracy of a few tenths of a microsecond.

This patch does not try to fix the error handling in the existing
framesync code, which ignores MDIO write errors.

Signed-off-by: James Clark <jjc@jclark.com>
Assisted-by: LLM
---
Does Broadcom know the delay from the end of the MDIO write to the
framesync capture in the BCM54210PE? If so, I can add compensation
for it.

 drivers/net/phy/bcm-phy-lib.c | 25 +++++++++++++++++++++++++
 drivers/net/phy/bcm-phy-lib.h |  7 +++++++
 drivers/net/phy/bcm-phy-ptp.c | 27 +++++++++++++++++++++------
 3 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/bcm-phy-lib.c b/drivers/net/phy/bcm-phy-lib.c
index b64beade8dd..022f5e5e6ce 100644
--- a/drivers/net/phy/bcm-phy-lib.c
+++ b/drivers/net/phy/bcm-phy-lib.c
@@ -42,6 +42,31 @@ int bcm_phy_write_exp(struct phy_device *phydev, u16 reg, u16 val)
 }
 EXPORT_SYMBOL_GPL(bcm_phy_write_exp);
 
+static int __bcm_phy_write_exp_sts(struct phy_device *phydev, u16 reg, u16 val,
+				   struct ptp_system_timestamp *sts)
+{
+	int rc;
+
+	rc = __phy_write(phydev, MII_BCM54XX_EXP_SEL, reg);
+	if (rc < 0)
+		return rc;
+
+	return __phy_write_sts(phydev, MII_BCM54XX_EXP_DATA, val, sts);
+}
+
+int bcm_phy_write_exp_sts(struct phy_device *phydev, u16 reg, u16 val,
+			  struct ptp_system_timestamp *sts)
+{
+	int rc;
+
+	phy_lock_mdio_bus(phydev);
+	rc = __bcm_phy_write_exp_sts(phydev, reg, val, sts);
+	phy_unlock_mdio_bus(phydev);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(bcm_phy_write_exp_sts);
+
 int __bcm_phy_read_exp(struct phy_device *phydev, u16 reg)
 {
 	int val;
diff --git a/drivers/net/phy/bcm-phy-lib.h b/drivers/net/phy/bcm-phy-lib.h
index bba94ce9619..365cb3d1c32 100644
--- a/drivers/net/phy/bcm-phy-lib.h
+++ b/drivers/net/phy/bcm-phy-lib.h
@@ -34,6 +34,8 @@ int __bcm_phy_write_exp(struct phy_device *phydev, u16 reg, u16 val);
 int __bcm_phy_read_exp(struct phy_device *phydev, u16 reg);
 int __bcm_phy_modify_exp(struct phy_device *phydev, u16 reg, u16 mask, u16 set);
 int bcm_phy_write_exp(struct phy_device *phydev, u16 reg, u16 val);
+int bcm_phy_write_exp_sts(struct phy_device *phydev, u16 reg, u16 val,
+			  struct ptp_system_timestamp *sts);
 int bcm_phy_read_exp(struct phy_device *phydev, u16 reg);
 int bcm_phy_modify_exp(struct phy_device *phydev, u16 reg, u16 mask, u16 set);
 
@@ -48,6 +50,11 @@ static inline int bcm_phy_read_exp_sel(struct phy_device *phydev, u16 reg)
 	return bcm_phy_read_exp(phydev, reg | MII_BCM54XX_EXP_SEL_ER);
 }
 
+static inline bool bcm_phy_supports_write_exp_sts(struct phy_device *phydev)
+{
+	return phy_supports_write_sts(phydev);
+}
+
 int bcm54xx_auxctl_write(struct phy_device *phydev, u16 regnum, u16 val);
 int bcm54xx_auxctl_read(struct phy_device *phydev, u16 regnum);
 
diff --git a/drivers/net/phy/bcm-phy-ptp.c b/drivers/net/phy/bcm-phy-ptp.c
index 65d609ed69f..2d8b377010b 100644
--- a/drivers/net/phy/bcm-phy-ptp.c
+++ b/drivers/net/phy/bcm-phy-ptp.c
@@ -214,22 +214,34 @@ static void bcm_ptp_framesync(struct phy_device *phydev, u16 ctrl)
 	bcm_phy_write_exp(phydev, NSE_CTRL, ctrl | NSE_CPU_FRAMESYNC);
 }
 
+static int bcm_ptp_framesync_sts(struct phy_device *phydev, u16 ctrl,
+				 struct ptp_system_timestamp *sts)
+{
+	return bcm_phy_write_exp_sts(phydev, NSE_CTRL,
+				     ctrl | NSE_CPU_FRAMESYNC, sts);
+}
+
 static int bcm_ptp_framesync_ts(struct phy_device *phydev,
 				struct ptp_system_timestamp *sts,
 				struct timespec64 *ts,
 				u16 orig_ctrl)
 {
 	u16 ctrl, reg;
-	int i;
+	int i, err = 0;
 
 	ctrl = bcm_ptp_framesync_disable(phydev, orig_ctrl);
 
-	ptp_read_system_prets(sts);
-
 	/* trigger framesync + capture */
-	bcm_ptp_framesync(phydev, ctrl | NSE_CAPTURE_EN);
-
-	ptp_read_system_postts(sts);
+	if (sts && bcm_phy_supports_write_exp_sts(phydev)) {
+		/* cannot ignore error since sts may be uninitialized,
+		 * but still poll for any triggered capture
+		 */
+		err = bcm_ptp_framesync_sts(phydev, ctrl | NSE_CAPTURE_EN, sts);
+	} else {
+		ptp_read_system_prets(sts);
+		bcm_ptp_framesync(phydev, ctrl | NSE_CAPTURE_EN);
+		ptp_read_system_postts(sts);
+	}
 
 	/* poll for FSYNC interrupt from TS capture */
 	for (i = 0; i < 10; i++) {
@@ -242,6 +254,9 @@ static int bcm_ptp_framesync_ts(struct phy_device *phydev,
 
 	bcm_ptp_framesync_restore(phydev, orig_ctrl);
 
+	if (err)
+		return err;
+
 	return reg & INTC_FSYNC ? 0 : -ETIMEDOUT;
 }
 
-- 
2.56.0

