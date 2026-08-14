Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A73F4749EA
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714815; cv=none; b=Zpf07DD/WJqH549rGgiGEbGQ2V2YrF5V4jvHRxnVNqO0xvKK9UlT+a6VobeyhPwpCI8NBkIDWGI+KIkWXWisiq/EouCPxv2nUvr5Il1VesAxFyJLdRt8ia4yJhuU0Ceec9T8CUWVgQlF6DPFAauSM9htfDoMak/9JT4nF1D17oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714815; c=relaxed/simple;
	bh=1r1u29e/oWyJyDSReT24KrjRm8RdFRq6W6aYv3nvtqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLBLE0FdIXSdoseoFPs/IlNFyLtErJWlPkd2LrpXRiAK0jjAeE/N7J00fJCb8VfFHjUih+GXwrX14ypkQCs/gCHmm1rsui1AybsafcCQDx6MWqGoNXkgvEaaZc76jRtdKRPAgMG4fHrnufuiYXLxpkW3PZsRxZ+tLtuNxiOW7Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p023HPga; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p023HPga"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so1471073a91.1
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 06:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786714813; x=1787319613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YRRwg1CSSUjdqHRRp9DDlNZw3TuaA+3DBT4vSLeIa/w=;
        b=p023HPgaadVwVhykwcLDNSUxkDIQssO9pOzdGlM3SCPGyVYzXK51DIz7k1njQ/Ft4z
         uydaIciyul1UosHcHEx+9C57gfTvXAlnVT6zeI91pJgqvQR0U5LORkyU6lApoa6sqJ/q
         QWRwhJgPvSNLletgvLmBmnCSuU2W4wOT6zCk4kABmC940LX6IivhgJasMw+qP3/f/hHk
         XgcQLZeXq2kO5W7l3l44df6riGvi3inz7FjIVndVCRC0OtMoyDr4X0A5kBEOTgpYX5aQ
         ZyoUSUPGSxhAZPllkSCN2YW9+LRCdwOUcTeKQsP42ub9zrAEySORHwo9Qbc3qPqS1XT2
         daWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786714813; x=1787319613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YRRwg1CSSUjdqHRRp9DDlNZw3TuaA+3DBT4vSLeIa/w=;
        b=YlzR3UalkUFYZS2YJFTCxasPNHJO2u2blydS+L1dktKNJ7WhHX7tQhT9IEn3PxCjtm
         OoxtFwAAqZWT5+obWUbTyIkong53GaY6319XYm1eGVnDogMByleihO0X4n3FgauQs5Be
         ++9ewwU3/PanC52BSg6D7CpeAFgmfgyVW1WZoSwpkoe+xSdanZH9fjEdh78RaIXIplFQ
         uaDCq2LH6TG4bObXnUylMhPeJgYC/A1W58X5f3NOegkGqnw20ZbXzefeGUm5G9WrJzSj
         0r6nhdLITReJhbNGKZNRdN00u3xBE3qqgJkgxJEqv0xt9VolgEOHFJGe1NxypJV4wJ7T
         vMgw==
X-Gm-Message-State: AOJu0Yy/ch4eq7GctlgmhZkLqKcE3hjk0283ScIXJCnMudI1YdZjZGnB
	oz/yGhaHtTF1tWOlyA5YeUz3lYfwtr/mZgUFtt21SDM7lGiRF5SBNUmXyDYSZO5cJfc=
X-Gm-Gg: AR+sD13Zlvex4ciRiKdqNs0Ig2x7T9zfsfXHjX7RyrECfvNgGxSG93p2PNI3mIqAgXO
	RS3YiwDDZ7sFjJywbEnJinH8Wk/El2zTZGwDtijnjldoPB2ZbELzvWozmQA6Np1xas4Z38ggeS6
	U99BC9oy3jzyy376F/x+lGQdpY2Mwdrfk8ftE2Iz6tctrZBUIcSheO1cJ08xL3mbs5yUR7KwDaQ
	YsO6D4nuquQVuoQCx42Qb0gCeIhFkmFZqE0mbokQ5BiZnDRSNK2WadwXLB6t/ZC0KgPq2ocnlO2
	xUFvqgZUb6Hvgpmiy0VrhiJK4H1BX7pwU3sKw4ha56/x2YHn2xk+4LKP2Sz3PjeIFVrGYTENhLH
	iz4/JYf7dPsxp0gX8IfhkTtvZ6AizGDpANbACiVje0cBauRBQORMZqLzoDcqr1NWckmyWbsKZJP
	Kbcv7iI2BReoLvP0CDNAAv9wBoWesHoC7f6fqn9wDNe1SabbEZ8i+89I9HWSbM/2TT4ltZUnv5H
	Y2X3MLUKiMXAw==
X-Received: by 2002:a17:90b:57ee:b0:38e:4114:d8c7 with SMTP id 98e67ed59e1d1-3933b4e6c9dmr6946839a91.0.1786714813180;
        Fri, 14 Aug 2026 06:40:13 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:e9af:7c0e:be31:2c3f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394e920ba18sm2814868a91.0.2026.08.14.06.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 06:40:12 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH net] net: dsa: mv88e6xxx: Avoid uninitialized value on MDIO read error
Date: Fri, 14 Aug 2026 21:40:06 +0800
Message-ID: <20260814134006.1386372-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An SMI timeout or PPU access failure can make a Clause 22 PHY read
return without initializing its output value. When reading MII_PHYSID2,
mv88e6xxx_mdio_read() still passes that value through the internal PHY
model-number workaround before returning the error, causing an
uninitialized stack read.

Run the workaround only after a successful PHY read. This preserves the
original error and leaves successful PHY ID reads unchanged.

This issue was found by a static analysis checker and confirmed by
manual source review.

Fixes: da9f33018e2c ("net: dsa: mv88e6xxx: Workaround missing PHY ID on mv88e6390")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 80b877c74513d..e71707ce71cbc 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3770,7 +3770,7 @@ static int mv88e6xxx_mdio_read(struct mii_bus *bus, int phy, int reg)
 	mv88e6xxx_reg_unlock(chip);
 
 	/* Some internal PHYs don't have a model number. */
-	if (reg == MII_PHYSID2 && !(val & 0x3f0) &&
+	if (!err && reg == MII_PHYSID2 && !(val & 0x3f0) &&
 	    chip->info->family < ARRAY_SIZE(family_prod_id_table)) {
 		prod_id = family_prod_id_table[chip->info->family];
 		if (prod_id)
-- 
2.51.0
