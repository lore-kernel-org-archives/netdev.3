Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588F8427F8A
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 19:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788548597; cv=none; b=L7R/ptn97c2E0U5rzhFJQyBrSskCnh0jBf5OUViUgZkE0U5XYyJv/g0Ezj10rRiW9gY2chCkYsJ8Av8ihaJr8Jzf7DZFg8+Icu5vNf956ZHT8tKTbSn4fUz1VlIf9bsozmCJb7XccoM5K3z6+z9VnUSbvMCL4DOctW0Zlu37sFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788548597; c=relaxed/simple;
	bh=g+9YyrCCqwkQj25pBhc80E3Us3WQgU4LquXHfZWmm68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Utt51HiIBLr8CnAOWuTQGCKL2vtbxvkm8gLH375qHveCpmLzElm22UB1C7JPWypKWHNLU80Sz0WxBiAqvj/LReYu1c8EfECkPNHWFDYKJn1I9QfBC6Ba1KyWAYOGoey8ATve/Ller+RHLw/LD+dhwj2we+Mvj7ptDCq4a/H/2Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=SFNrcwsI; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="SFNrcwsI"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49cd77e0f95so12408795e9.3
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 12:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788548590; x=1789153390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lj3tsvbtNJDWZnFH5pUKMKwa2zoY5MXACQtNrJLPngI=;
        b=SFNrcwsIy1g7mN+pUwAi1aZAClIb7TZzx20jZyB6X8DR1SoBcTtGPc9dTBqiGx4N47
         92/UGLYM4+sEWDBtLzKuJidIcMBBrc2D/e8QHkgxJpJ+z4agD2Rue8alZ8a1j3eKDErc
         paYRvTzOUIWMAj0Qkvfy7GdhbMeLUPjZFTeMGqKAtS8G2ty7L5tF/VynaEMJI41CzFt9
         Nfvo+7ma0SEAdYZBtGjZ24ZEAeEMpq3mSht1OocPg52EnZFs4tjgQEmA6ofAMNhW454w
         btePYf77B0l2OZhJYgUgQVtE3vMJ2SDq5Hl7XqAIjqZCw+wVcWimsY8WZvUkMIL0XgVr
         qunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788548590; x=1789153390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lj3tsvbtNJDWZnFH5pUKMKwa2zoY5MXACQtNrJLPngI=;
        b=Q7TqHjQ14xAJ1VNJUd5Vt8ALFvXDxMv+B68xcguei87c++0NPVs0I522BwFJw4zUTj
         /hZqOAvWYQMBOieBYGG2HuOzsdWECUtXzTinhvcKqIMnyrEH8v+7SdqhaRo+/qbYSvOT
         NHFPwPYpryaSMbAjORixpeWj+na5hbjLMdbR7+pXpIl1t0AB9D7aWul+O2DoZxW6k/HV
         a8CAZuF32dIELNGy0VNSxxKjFxG+RKRa31KG5tnf52CmdevFLwglL37AItb36uud4RAp
         OAfH9ZNcG3IjbRp3p+/aMd7dX8a6+Eef3de9uckzb+FNeyis46V+XxorXg55YGYegEdE
         41WA==
X-Forwarded-Encrypted: i=1; AKwUvBy5tr52AdVs9/T5SsjnpG/0QJXsZdkdDgieM8I2GQ1hLYstn0aKqXDW2tTWzhruonpINc+o7ao=@vger.kernel.org
X-Gm-Message-State: AFuF++mxXHuAz3pMCkS2lWTJ5MCkxSPB9JrYbKqYHsEb5UgAG6IKScVc
	LVzCaJFCWOOC1FhnLzWJ5f12ujoAhs9+J2/Yt7QWTKf3qABSuy7DtrpfDkfSGavI9Kg=
X-Gm-Gg: AYBFou3EsyYM4iI8o7E3R92xVQVqFiHmH+clBNvnG/NPr6mrCVCe13hCn/zzIOcngeM
	zOhLnGvauifUZfYiF17G4wzAgfKOdup9XEFvKlW0guYuNRPPL8KOOCLCBDu1irsIabe7kr7OvkL
	3mLwNh9P/yLSj2a2jh1WzSkd7khrCrQfCsz3oa9do9/q/DJlGK/z7SNIKwYEh+uFrCq/zGCUbS2
	rjpPHvToioWd3ACOlHzBclvVliWvZNK2JR0Kv5HR5dLpnaX8Fubh70wJe1h2ss3E6HX6XRXlCXc
	JbQFZqBANOmy7w2tByWFR4TUzocOpvcgiZTgWQzwNH+iIlnVR4FV4XDG3ZowwGU1qCGs2frIpKY
	sVbQK5IIThWPNFO7/f3COMoEbomzTdqq7r8wJH0QzGv7WFb9J9E80Oifz6JmNqOUKDCWwekJcDq
	zTbC8wjUO7Dljwj/4+uuIfQROH16/H19gC2VA+4qM=
X-Received: by 2002:a05:600d:864a:10b0:49c:fc89:59cb with SMTP id 5b1f17b1804b1-49cfc8960ccmr41262475e9.5.1788548590621;
        Fri, 04 Sep 2026 12:03:10 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60d8a6sm172195485e9.10.2026.09.04.12.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:03:10 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Eric Woudstra <ericwouds@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next v2 03/10] net: phy: add mdiodev_lock() and mdiodev_unlock()
Date: Fri,  4 Sep 2026 19:02:57 +0000
Message-ID: <c634c01d84dae0745027c7264b59efac992f12bf.1788548229.git.f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788548229.git.f@lex.la>
References: <cover.1788548229.git.f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The __mdiodev_* accessors require the caller to hold the MDIO bus
lock, but the wrappers that take it, phy_lock_mdio_bus() and
phy_unlock_mdio_bus(), need a phy_device. A driver bound to a plain
MDIO device has none, and must reach into mdiodev->bus->mdio_lock
itself.

They sit in phy.h beside those wrappers because struct mii_bus is
defined here, not in mdio.h where the accessors live.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 include/linux/phy.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 3d8afe6b7f1c..8c10c8ae21b1 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2284,6 +2284,16 @@ static inline void phy_unlock_mdio_bus(struct phy_device *phydev)
 	mutex_unlock(&phydev->mdio.bus->mdio_lock);
 }
 
+static inline void mdiodev_lock(struct mdio_device *mdiodev)
+{
+	mutex_lock(&mdiodev->bus->mdio_lock);
+}
+
+static inline void mdiodev_unlock(struct mdio_device *mdiodev)
+{
+	mutex_unlock(&mdiodev->bus->mdio_lock);
+}
+
 void phy_attached_print(struct phy_device *phydev, const char *fmt, ...)
 	__printf(2, 3);
 char *phy_attached_info_irq(struct phy_device *phydev)
-- 
2.53.0

