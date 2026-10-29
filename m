Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267434;
	b=rb46W/3r7EA8sZD+2tbQ9QrFl8v1awfdQPh0IwDQzWsQlZcXn9drf87AUqUUH86HXuwr
	 yPA3t0McABF7V2CtqmOuapxmfPA3w3hTXMh+F/Jl6e/vX/2OYhqQ7fBxu+1fjHIbdGKLk
	 vX+7cQxsRbZxneM9Y4h1POhJR1iMX6OPwYZYoHYpqHFXRxqIFb1Jzx72lvqvepiFBUQ1+
	 tfv95g6d5Z9Qrh/CoOnj0aOj3pT443qOM8ZK2zMmcdg93EaG3e5dtN+J6ehoMyfyX+5QB
	 yUZvxXGlsn1bIbjcYmg9uiu/vg3Dt6D2riQdzUAK0ISCWkkacMJnY8oHYFfM7EKRn/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wlSDMq+Onl3G9IdYH55u+DZBDAOLa9ewzbFQlEUFQqc=;
	b=zulbzSHcbWL6Rqyukq+8T563wPz/3V9REuxNGX0RwiY/KCSQ1pftZEhnsjJoellKjuue
	 Brpe/WRBHg4Wi7bl9higvRw9W7FXGOEzFrMQFNFuiCkWFlHpRDha9oBuptQG8seJoQutn
	 ZydyiFkEkhv/4ti24w6VBAXVPUXxhQL+yoK3TqGpk6giIoVR7aPdxGgr9fVbaAHsJ7bLg
	 eX1FzvsYVprePcB1qYze8c+IE+wftsZXrG8aZovaDVP5sjl1do8O4IUazNZv7tA+z1VFT
	 tlJrYxnL38T/4GjeSxNNDyDNmTTp923qeCH0Ed4Xyq4vZYkVHkwQOFjnwL5lJHcm7rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fsLEvWhs;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2C9606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 09:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A2C9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fsLEvWhs
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-34cbc588a31so1012873eec.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 02:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793267432; x=1793872232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wlSDMq+Onl3G9IdYH55u+DZBDAOLa9ewzbFQlEUFQqc=;
        b=fsLEvWhsLauaXv8IFmCQXSUEAwtnV8yS5qvAuJglzHLUhmGPhuNlLSrFRnq1xYYSXF
         tpq/e5sTapHttdDlLZwQ++5LnC2FUKAJbTLz74WFlrr0ObZU6EcUKBPh5GFGgXQQrDXx
         9ALoQAsZ/vyAiU1ZYniw8u7t0ksEYI8lvn456NyhGjneK5IQUOX2/KwPlmoPUjYq7Rve
         xTBvZfYjG5P6fWFUgKVV2QeG1TqDFDQJD9YruvwMo3izHHjOT2WWGCpTUluzFYb8NlW/
         8GhrWXTG+aNwEPPjnPsr5X/3cwCu5ZMVyoCV+Bs/5+ddlsRun2B6wORR8L9skm4rcnB1
         7QDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793267432; x=1793872232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wlSDMq+Onl3G9IdYH55u+DZBDAOLa9ewzbFQlEUFQqc=;
        b=rkbP/1XbGvJXQoP+MyBCz8n6yWdU9FGG3Hmq6JXDipdBbyis+YVYW+MOFNSe3/1ZGu
         ozmn3CB77hqIS5rDu0Ji9yWKqQCwiSNxrGU2wq5JSblHgsgR6EYF/eOqJ7WlVqfPNM+q
         rEU65L78PCK90biYf4FUdCT8POIawsWgu+YrHZyKonMKo72D71o6+0rX0UQ8q1E4vN/H
         2eLkA85SNNKIb3dLJWWDnIM0G49QRXY8uCY63Nw7Yw4tS4VPi0jpm84vcwfJaWWz08Ji
         CN3mRW1/99hYEunUNrIIAENzKp5tb946WzsIDpVliXjZ/na+deMvIHQ4rRbwSDNZcLvB
         mReQ==
X-Forwarded-Encrypted: i=1; AKwUvBwy5nRpsXTQZcpuXUgcilFS33RSqRlR9j4aDfSeqytP3Coc+b2Z7vdypJS2NqYWH3sWr/cIkXA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFW+59+t7Ano1DBcE2o8pW5nwPijUDznmwrSqVCQW0wM/Tgji3
	eQBoak2MTOBoRaHT1tlpjK2SwAA2F91xsyb58HSeWCxP4A41cIwXj0cS
X-Gm-Gg: AYBFou0DpSsBr9NJ9wjRetZumPFpIOFlQZCjFYTsuGuBRZjy6YE+0JMxav6O9oPZETH
	9v7ZMyK+S6x8O8635KbxZzpwOGOKZWRXSo3R8Eh6Kup7AzB2ngYPDsK6JOoeqlbyGZsSsVXSVAb
	JzZ0EZ7vjvZi0UklDQMFRXR+RUY8/BKidWb3RcRw2H5BliNinNOBR7LyPtcsf4N3dubfr6qYYAQ
	it/OenSukKY3fqYFHTqgt+EqynNYmBv3QBHdX67ofi7ql7WrM8bzs7Idla/WlOxC+5FemOMJOf3
	SyawzXHVFD957389lsYgj5bHY2NFfOhz09rZdyJ2gMuv1pKBMytntZT0vKexRGsTdLeJbeDfown
	DO76G7oVfiklH6CVPDVozSPKXTanvJGhF+hPO88kQomgXHC4RM2c6sN/NroAdPMlztSQ4EFrPY+
	oW/29wmsIncVpkhIucuQNHUY46H0hRhzXHIYeUHZT+Zw1HRS5d745l+4QkxRSoBw9alTwPM5ktA
	H5p5Ej2L5eogtccWsZvz+M3nyiWwS9qh3uptvJFAmbr9gqWCaxV6QsZgvgxmvMriOynZFOt0zq8
	86AteqHpmdO14R2pHfh4o1i4fOo=
X-Received: by 2002:a05:693c:881a:20b0:35e:f1a5:9ba6 with SMTP id 5a478bee46e88-36a202869c9mr7131516eec.5.1793267432214;
        Thu, 29 Oct 2026 02:50:32 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239338e2sm18527707eec.18.2026.10.29.02.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 02:50:31 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Coia Prant <coiaprant@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: pcs: xpcs-rk: limit advertised interfaces
Date: Thu, 29 Oct 2026 17:49:17 +0800
Message-ID: <20261029094916.3127193-2-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
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

The RK3568 XPCS supports 1000BASE-X, SGMII and QSGMII, but the RK3568
GMAC only implements SGMII, so only SGMII is advertised in
supported_interfaces.

The generic xpcs core fills the mask from the compat table, which
includes 1000BASE-X, QSGMII and the higher-speed modes. Clearing it and
setting only SGMII keeps phylink from validating interfaces that are
not usable here.

1000BASE-X and QSGMII can be enabled later when a board actually wires
them up.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 drivers/net/pcs/pcs-xpcs-rk.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/pcs/pcs-xpcs-rk.c b/drivers/net/pcs/pcs-xpcs-rk.c
index 6f0a110e32d2..cc11a70d624f 100644
--- a/drivers/net/pcs/pcs-xpcs-rk.c
+++ b/drivers/net/pcs/pcs-xpcs-rk.c
@@ -536,6 +536,12 @@ struct dw_xpcs *xpcs_rk_create(struct device *dev, struct device_node *pcs, int
 		return xpcs;
 	}
 
+	/*
+	 * The RK3568 XPCS supports 1000BASE-X, SGMII and QSGMII.
+	 */
+	phy_interface_zero(xpcs->pcs.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_SGMII, xpcs->pcs.supported_interfaces);
+
 	xpcs_config_eee_mult_fact(xpcs, pxpcs->eee_mult_fact);
 	put_device(&pdev->dev);
 	return xpcs;
-- 
2.47.3

