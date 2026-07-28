Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF7542BEB9
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253773; cv=none; b=h7BRvr82xuerWcvsvIwWHXxKXTzEvYYoV11ysNraI3GJH1SJX0GAznxVnerfLvjOgNNtyOBwg3xHq2+57x1nrGlxNifuHD+A7Bjf3GFbtgXJScDDmdr2TYS8tNb6wYEQq6yQaekdT5r5xQwGNG051ZyJV6JXuWFvFifBu77WV5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253773; c=relaxed/simple;
	bh=DgL5CromPu7wbZamQo6dcKhpSqi5faC4TnVOwOj2opM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b35CXUZPK01APwySqbN0DKpfBOukewI7pe061R9Obd4xZVRxWDb2HPgYRR2LA9LEiVKhMDb0InzSgPWcHOeDvKjWd28v7EQPdoS7wJ5ocu1WlUnO6TjZhO7+EoQ7gWM4GSM9NyQnHR3GHRDmfJ+BLye0Ib5oLHRhJuUAlOmBGxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoEvYOAd; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoEvYOAd"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4799b3f7c83so11216f8f.2
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 08:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785253770; x=1785858570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=foFk8F1wdsuWT3Dh0z0pWEWTbLvlSNuNG+sknbc1YSU=;
        b=VoEvYOAdAfjohnh+ES9gPMPfTCOYAC8x9BnvZv9kn8AFOuFEX4454jyh9nf1VuycN9
         hnYT6xGqbkH2g3RZnykQ5WrkeFOMaqLpnu02rZAcwtU5j+mvLVQSMjTOxaKV97zLO+0L
         YM9zuIyaOc7nr826GV/bvJqPLwVyH2eOeYYe6W/uwjKrD05s+7nn1Ywg69MSSvekTo+4
         KcFushab9BVLSJu6bfQRsfbciG/NdDi2sxOfG1/aBDlaIzibEZFkhC2FGxaJLoq+x8hk
         esdWoG5Tf96di2HvA69I/iZkGpXUyjX/c2NwAHHzTgc901kCBbFTxZY9NUEd5lXiN3Gj
         wrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785253770; x=1785858570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=foFk8F1wdsuWT3Dh0z0pWEWTbLvlSNuNG+sknbc1YSU=;
        b=D1YdyC7nAf9kgUXl/OIJSwvx9iJRN3/cpcWvuMPqKLD4Keyp9JL5JfvTsM1tfCw/0U
         E3i0IQU7Pk6llGEf342He89B+7l08Tm1JIdfzMDB7y/zC+StkR9hCDFCFSn/9mvf6Ceq
         K+aYfw0Cnmn68c9H19R/JoSipQYUJ3zdbflq9UjufrlbH9ymQ4htD4zcrNHvX/J3uZxy
         jXacs3KeuPCbIIGXkoqYZ6YGsy1KbiHQWgd1t7z6tPmMmyfoQfxNMZOjU6cYKmu8BPy0
         nzx9mBuUP9xNzhv5YKY41Ris0xuzJbiSkES9seYqx3sDgFeRWFp+cViTiYP1WhfPF9PC
         Rlig==
X-Forwarded-Encrypted: i=1; AHgh+RqkKMD/YBo7uxgC14xQ7beQYF1mDE90fbwKhf4kfgJnMhxNr+dPmdfUBTaVlGoMvDqiuo/O/To=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlEH7q0ZyngTiuqily7vWJ9F8+2kcmj639t+t6bBZh8WKQQYTL
	6RbF6QGKGoHRiKZ0c76SZl9Y5I5/QmJb/Pcb7ksWWKFz/5E8MH4Jmz5Y
X-Gm-Gg: AR+sD12mlb3YV88mvdHxrNBqlcTZikVWd3zAq6RC+IBI7rOrMqK+W1eXCovS9K9u3ZB
	cTRHp9CiZRj9CdLAXxJ+xhAbGRlMOjGdvYQQMXMv+QGSawNmdZZ3a+hpeZMSJhbXV7QMIYKm+9D
	AwUTcKkmfLVITFX7i1pSyI1s0rVlPL/8MD1u9gAhVnfTOATHdNNWk0rIdMzVD/jsVHtX/5ez4O0
	pTT3SzGi0yaVulQmwBKC9EjLq79cVG3LzjI/hFKTsR9KxQmaNNNveQ9stq9tRH+NbCj8/4cVvKa
	oCCwJtFopNhbZHwCa7hSx+BEPxTULLEvUEOlvzSyWIx5L55HbxMysryOKv/fGmfXQ5a1mPscFUc
	9vh37/Wrrcvv34WUCyagVQcLb5zlkUYbvL96EZr/Mh40mfwevqE9nw1bTDAqsWFE8AC9yv5s8W4
	wVBdk/faVnkV9tsWEcjw==
X-Received: by 2002:a05:600c:1c11:b0:495:3a52:cd7e with SMTP id 5b1f17b1804b1-496c657d05fmr34143125e9.25.1785253770337;
        Tue, 28 Jul 2026 08:49:30 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain ([37.161.95.51])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-496c4632263sm94912035e9.15.2026.07.28.08.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 08:49:29 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	mfd@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v19 07/10] MAINTAINERS: add myself as maintainer for Airoha AN8855 Switch
Date: Tue, 28 Jul 2026 17:48:34 +0200
Message-ID: <20260728154846.1828945-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728154846.1828945-1-ansuelsmth@gmail.com>
References: <20260728154846.1828945-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as maintainer for AN8855 DSA driver and all the related
subdriver (mfd, mdio, phy, nvmem)

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f3218abefd0c..b8580ff98b8a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -760,6 +760,22 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
 F:	drivers/net/ethernet/airoha/
 
+AIROHA AN8855 DSA DRIVER
+M:	Christian Marangi <ansuelsmth@gmail.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
+F:	Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
+F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
+F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
+F:	drivers/mfd/airoha-an8855.c
+F:	drivers/net/dsa/an8855.c
+F:	drivers/net/dsa/an8855.h
+F:	drivers/net/phy/air_an8855.c
+F:	drivers/nvmem/an8855-efuse.c
+
 AIROHA PCIE PHY DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.53.0

