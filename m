Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CA231F9A6
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786807040; cv=none; b=KYLdqjB24AG5/011ZmIUZrs0NsN2SqPTt2H3bLPQAG7a299i7xgNx0M3FiGXdstdbxAgGTul7nDYWYYKsyNHpnPIbQgGxWQUpk0zNuutZP30G7T2vYqMm/PmiW7qrFAKmeSupDqfMbMSy7f07fLkNb7Yqjg0S/YfzydS6pbSU70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786807040; c=relaxed/simple;
	bh=hhD2mGryTKedERHeusMb7zNvptKpXuKvxwJCD2TDNT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fkYGmAkJ8+GkIa/hADkoPq6He58f2fBBARCoXxIKuzxFiMB+Qh357M/3n2c8bKLY/eM+kuJoilws3gh0yapj8AxuO60V7MLcj5o2EMizn/ZdQ2vnM47UWnc8/6ZU+QHkwJ6eBiU9ud9a/FelwG+BsjzRhes0c3+a13XcEJdAwIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxZAwgSD; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxZAwgSD"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e58034d05so1699071a91.2
        for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 08:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786807039; x=1787411839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xU5wuQl05hqAdfOQzR7Ny4Xs5wY+Yxu1qGS7dRLraAA=;
        b=VxZAwgSD7thkn4Nm9amxL2AMJe3hIATPOJFJ7x2GJ3WK6H2U3w6p9ojDncGFAhB9Ku
         0icuSL5/frlqdI2XJENr7lVl6Upct7lS+k/FovrgQseTanAcz2Id7hpXwofswOzpSIYG
         GQm5Zv4oyPMQWHGxmxlQ/M1a2zUWatnqBDNYc1RdE1D/hAhLbgAwu96kv5wP4wIfO60M
         CDrHWr0AnnP92e9YLWzIPFiT/iRZ4tpaK7ag1Mvzslobq5qMwaEzcbYrlkpj4NePqLcA
         YYicm4qk/5yOyDLaP+fOVlRg83bYTs5WldCePzuoWS3UFl2kFef/hkzZ4fZmb0bZyw7J
         /xfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786807039; x=1787411839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xU5wuQl05hqAdfOQzR7Ny4Xs5wY+Yxu1qGS7dRLraAA=;
        b=EWcQJz5zXsG/ZX6jJtObseLGlkLw8APyUQRE5QbEKJ38I8rOlYIg7/xluBMxeHVEZ4
         ZNmlyXoms+5aO/q+j6q+9s4Yg7VoBkwofk4drCPr//w0bBEY5vA++4+0/qXZSup0Vp20
         2DOeNEhuIIDqc1+SVONqGXoBBn5f74QJKUWdEd19qtZqpznoilXNbADUy+zspGw87J2Z
         LFQXIZ+SNLQg2Ib6a2p/PWOJvJlpsoLBA5VneaT2wLOhTEQJTgEvAJLzpwyDIca6X4xZ
         4eaPG2osOYcakF8Vp6tBJwSZ8M/skamlU8oqZYqbjfBwOx/mm56t3Bk0unabusDR5oIf
         7Exg==
X-Gm-Message-State: AOJu0YxzZAoLYkFTVb8FX8aZnWOAk3qZ5okYkjhNCELRRuM8d4I42KUN
	SHUBfTWcxMKjVyldNuZ7j33EgbubkM2rUIWVVzHwYdvkXWgjNeRb6Uwe
X-Gm-Gg: AR+sD12aS2JTHP+NQv/wygw/fImIA2JrLe8/T0NaibkSLMlMXsGp3d1OCYvg35PHV7Z
	KPbAQRGIQhy+cT2VGHjghk5KcMt9CctGtI4F38DhSw6mPBxsaG0UPIAUwkZTVdopuuT9UTz8oKF
	tDaFJBFTXAHQm0dVhsXTraQtmrzNvZZ1HePI8QEujN1U+mJ6XhXryJurtN4DhLuITNk6qV6wRjK
	dGKtdtHEcOsnepH1gKdKCD2IP3EisYsQgoWsvaYf8X7gydMf28qvA62vqKIcUkGY7Ar2N+r4bzz
	ILWmEHLoXujFTxsna+dfizKEmwGWDchG6OXFLwYy1KinWY318IWYa/IqMIzmt5p0G6RkuEsnm0P
	PywV0V9Bvnqp2gsXvNf6+m0U3xJZ+S3hHdlfNgvCGe5AEUsmn//YvlTlXXs7gigyCAlcZSRxCWV
	cDNRY/LxNvMXunbq/ef7Bu9gj2FhnvbJZ01rVIrl4pbLUox5LsmN6eunjOvCbWJ73KacDSF3/Dt
	XGXPCfz
X-Received: by 2002:a17:90b:4d85:b0:37f:fb1d:63fa with SMTP id 98e67ed59e1d1-3933b8b5de6mr14246772a91.15.1786807039021;
        Sat, 15 Aug 2026 08:17:19 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:5225:2a2e:8e7c:13a7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394e920ba18sm6515825a91.0.2026.08.15.08.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 08:17:18 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH net-next v2] net: dsa: mv88e6xxx: Avoid uninitialized value on MDIO read error
Date: Sat, 15 Aug 2026 23:17:13 +0800
Message-ID: <20260815151713.3757248-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mv88e6xxx_mdio_read() applies the internal PHY model-number workaround
before returning a Clause 22 read error. Since the PHY read may leave
val untouched on failure, the workaround can consume an uninitialized
value.

Return the PHY read error immediately after dropping the register lock.
Successful reads continue through the workaround and return val as
before.

This issue was found by a static analysis checker and confirmed by
manual source review.

Assisted-by: unnamed:deepseek-v4-pro typestate
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>

---
Changes in v2:
- Return immediately on PHY read errors.
- Target net-next and drop the Fixes tag, as requested.
- Add the Assisted-by tag.

v1: https://lore.kernel.org/r/20260814134006.1386372-1-ruoyuw560@gmail.com/
---
 drivers/net/dsa/mv88e6xxx/chip.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 80b877c74513d6..432285e2881715 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3769,6 +3769,9 @@ static int mv88e6xxx_mdio_read(struct mii_bus *bus, int phy, int reg)
 	err = chip->info->ops->phy_read(chip, bus, phy, reg, &val);
 	mv88e6xxx_reg_unlock(chip);
 
+	if (err)
+		return err;
+
 	/* Some internal PHYs don't have a model number. */
 	if (reg == MII_PHYSID2 && !(val & 0x3f0) &&
 	    chip->info->family < ARRAY_SIZE(family_prod_id_table)) {
@@ -3777,7 +3780,7 @@ static int mv88e6xxx_mdio_read(struct mii_bus *bus, int phy, int reg)
 			val |= prod_id >> 4;
 	}
 
-	return err ? err : val;
+	return val;
 }
 
 static int mv88e6xxx_mdio_read_c45(struct mii_bus *bus, int phy, int devad,
-- 
2.51.0

