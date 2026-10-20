Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489035;
	b=37X/XXr0kFS+S9QDjREKjciHmDpQ2MoOlIK2iEyaK+tGBpgvfzUihR/MFe1FKVQdVAl5
	 TzKE/za1fkJE3srgJZJ/exazBvfg/9F7FYoXwwyGqdMZqRhmxorTtErVj5SUKjmEvILKE
	 UHOF0QllQQyp0wc+5CPl8AC8KUa9zGc7iBoOIml4Xe8eMI/3Ftoco9bd1Q8SpovwYYLg4
	 VOoU0cuV/WQGHniQECUMOpnpvL/U2e12+tAOP+hwKGXVC2jbuLOFEoTygK4rnKlOrZxrG
	 ZXQN+L3ZpFBpk0uxD7Ar9EZO5CCubaC2xnRKrLunkPxhvPdx4Nc9wyY0oo3qwekbTKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=H4GOGL2XRIUNcWmRMGdO+Qzk7DbDP4YbYaaDzFcYy0w=;
	b=Fp7WJPfNv8O8sBgfi5kBBYRo3Lv3RhC086ucvSu/NFHzUdu4BZGTJ6it62mY9py2kwa6
	 TemySYQQD+/+UDcaQDMBnPFYA+iT2mQ3pcFMeab/mDkQ+WuYrx7K0K/bqIEuR457mw+3l
	 z8JokxE3v1J4aZqIDzcsr7jGVQnlzgx4ZuTTDL66mJbhU0ac7/phKwwptS3cN/ZeB+I0S
	 zibXwCxD7CTNv5eX5JlDUnpdCCYUSqhWyDXkcFI1zWD8exXnPRhuqAbs0lTtScfFcM2++
	 ON7VrhmhEefiQoAPzfRNp1/ZhyzdDjUCpNsOGANEKP4gcmZFgFjnVijWEJQNKvWmAOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sartura.hr;
	spf=pass smtp.mailfrom=sartura.hr;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8C660A2605
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E8C660A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c3fd91337baso406332766b.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 02:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1792489029; x=1793093829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H4GOGL2XRIUNcWmRMGdO+Qzk7DbDP4YbYaaDzFcYy0w=;
        b=DyCaFXpuNo2qreLvjLkI0Hkp/j0h/KSJhtDB+JWBTwzeVn2JS7TzFqTBLfsmNXVzow
         z+eG5oe6tiG8AS40BoZNrNtLguY5+4hdWB2N8STR8Y3I/yynOI0Oc39K6xKKm2lUgiz0
         WiqWJvYGJhBP+x/Xap1zEN17pfbp2i+N4V2dCCsLM1A+m7WkR3EswTlapSyCaBNrCAzM
         Gs7uLUw8KNYyue1VuvZCjFQGWeBAM/2rc73rQDoPyeOJH9LFNlxnSZu1lF2egSg4KymF
         0MUYQTZsKhWIXDctVbPMPkCxDC8U0RJ/IQeqs7MP8UrIq4Dftt6NA2N2LrELJTwfWgNr
         7U3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792489029; x=1793093829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H4GOGL2XRIUNcWmRMGdO+Qzk7DbDP4YbYaaDzFcYy0w=;
        b=zBBwTAsE9frmKtXE2JPMMgcbilxLCuUN4BKyEdrCKyNnLFFnjOyGKi19T8iYGnq0MW
         Bb9hpVkm2Ns02sgXjqlWzzuOedQkaz0BL10upFS0tNzZb1jhU5/g40WJUlrw/ohB+ob/
         jxR46EE2pz4duoWE1x2KEvQy0eJBrU7LJA38pIsjafaEiDQSMmeWhxjviOe75nRnoROF
         OJ0rbc8PMBzshPtuu2Ll5plrh2XQUvliyLf/Fi9/CvASgZrikekll6YgB4spyJivnkF7
         QgnNtAfRDDWCbF1urZ3fSMa53f6/T3eUjcOnOAsbDpEtW5PRBpss4u96qHf/KAHCXQPN
         FyDw==
X-Forwarded-Encrypted: i=1; AKwUvBw85K4fpwd01M3QkYDniD7iTVWWApPd6FnvW2TnO6wtOxtCkYcVfl6cC4/nmQOTJXvPgMcZdIA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIeNQ7UASagCN26sJH+c2j9boP6Zg/jWJ8/d98Iy8wkJwTjpeKm
	NmTia7hOZBcrMnfSD6GfGkU4PuPuDj/Tfixe+9uQhDncCOrYv61sq0dq55GwNl9CHPE=
X-Gm-Gg: AYBFou1gCMPTk7oNbwJ3WsN/jOGR9AjZjMsQN+LPG3OUaOmMLB9v2PT4ns/3kP/apBo
	YAtfHoWYtkkuuUNkJbYXEcn/gEqVrOZ+tjH0Z468yeacb9UjvBEO6q1RBJEt3FOPn6dhmkr/hoL
	qZ7XlZpNPW51oww6ZRdc4FKXygqlaSoIkcaktyXJ2rjeZ5fwlcCv4cKxl6JmmhbzcART+y94ATO
	OKeqyT4MpeoNUEldyoZUQ5NabhQtqOYyryRIqUyhd/qOjD5Xi7uHYHi2Ozq4nbWGzlL0e+cICjg
	u/nodRo49aEqge3ChU76lCWlJzzySNiu3F+seuX0mfgjkUq51ZkHbHAmmkC0aBaxIQC1XbdPlMd
	h9tI0DWETCioMR+sozVP8EkQ3A/fk/51PRLVep8qD0PLniDIK0QImBbGu44qJJ3o15EVAybFhL5
	/EpyXNLumb84O3VOBYFLb+KiIwgYu6mDoIiUT3NX2eCBsw87lqgaK7Iqv5RL7Frx3fGzNxu+IIe
	Hz1SKsuIbd30jbd3UqffvQIo69ktXMebEM1eDDoojzVJQtmf1/sFW5p3DJ+s/P2OjmulYNGJzHc
	2TgbRdN+ZRBHNgwVtiWdmuWM/Droadt4YAnithy3q2ydZg==
X-Received: by 2002:a17:907:96ab:b0:c3e:f39b:2286 with SMTP id a640c23a62f3a-c419699e001mr779531066b.0.1792489028894;
        Tue, 20 Oct 2026 02:37:08 -0700 (PDT)
Received: from threadripper-fedora-workstation (cpe-109-60-82-88.zg3.cable.xnet.hr. [109.60.82.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40912ceffesm462730966b.47.2026.10.20.02.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 02:37:08 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lxu@maxlinear.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	michael@walle.cc,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lrosu@maxlinear.com,
	luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH net-next v3 3/5] net: phy: mxl-gpy: release MxL86211C Super Isolate
Date: Tue, 20 Oct 2026 11:35:36 +0200
Message-ID: <20261020093655.344585-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020093655.344585-1-robert.marko@sartura.hr>
References: <20261020093655.344585-1-robert.marko@sartura.hr>
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

The MxL86211C can be strapped into Super Isolate mode, leaving the PHY
halted after reset until software releases it.

Release Super Isolate before gpy_probe() reads the firmware version. Do it
again in config_init, where optional VDDP setup is reapplied after each
hardware reset.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v3:
- Release Super Isolate during probe before reading the firmware version.
- Reapply the MDIO pad voltage only when a VDDP supply is provided.

Changes in v2:
- Move Super Isolate release from probe to config_init for resets.
- Reapply the MDIO pad voltage before releasing Super Isolate.

 drivers/net/phy/mxl-gpy.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index 952272faac1e8..dba0777158b2d 100644
--- a/drivers/net/phy/mxl-gpy.c
+++ b/drivers/net/phy/mxl-gpy.c
@@ -114,6 +114,7 @@
 /* Packet Manager Control */
 #define VSPEC1_PM_CTRL		0x0c
 #define VSPEC1_PM_CTRL_MDIO_VOL	BIT(14)
+#define VSPEC1_PM_CTRL_SI	BIT(12)		/* Super Isolate */
 
 /* Temperature sensor */
 #define VSPEC1_TEMP_STA	0x0E
@@ -427,6 +428,30 @@ static void mxl86211c_disable_vddp(void *data)
 	regulator_disable(data);
 }
 
+static int mxl86211c_release_super_isolate(struct phy_device *phydev)
+{
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND1, VSPEC1_PM_CTRL,
+			      VSPEC1_PM_CTRL_SI, 0);
+}
+
+static int mxl86211c_config_init(struct phy_device *phydev)
+{
+	struct gpy_priv *priv = phydev->priv;
+	int ret;
+
+	if (priv->vddp) {
+		ret = mxl86211c_configure_mdio_voltage(phydev, priv->vddp);
+		if (ret)
+			return ret;
+	}
+
+	ret = mxl86211c_release_super_isolate(phydev);
+	if (ret)
+		return ret;
+
+	return gpy21x_config_init(phydev);
+}
+
 static int mxl86211c_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -456,6 +481,10 @@ static int mxl86211c_probe(struct phy_device *phydev)
 			return ret;
 	}
 
+	ret = mxl86211c_release_super_isolate(phydev);
+	if (ret)
+		return ret;
+
 	ret = gpy_probe(phydev);
 	if (ret)
 		return ret;
@@ -1481,7 +1510,7 @@ static struct phy_driver gpy_drivers[] = {
 		PHY_ID_MATCH_MODEL(PHY_ID_MXL86211C),
 		.name		= "Maxlinear Ethernet MxL86211C",
 		.get_features	= genphy_c45_pma_read_abilities,
-		.config_init	= gpy21x_config_init,
+		.config_init	= mxl86211c_config_init,
 		.probe		= mxl86211c_probe,
 		.inband_caps	= gpy_inband_caps,
 		.config_inband	= gpy_config_inband,
-- 
2.56.0

