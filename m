Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB1B26FDBF
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 04:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787287518; cv=none; b=kQyKEiTlUJFR+hV2r3dgvueupC6h+tYp+UWDZAZ52TNlkMXNwdmZZIVALmA8fwhV0Z2WkEMLlU5OZA6HFQCe3zpGvWFaXFJqTai41MuanFsr09LiUyX7jC0fdxNpMvmlmYjn2zsh5/dlu2c4KQsbvGvX6pdrskfnmyZe7DRmFV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787287518; c=relaxed/simple;
	bh=/rYyAsNpnn77q2igHIHzF4U7Fm87W/o/oL+fIIbim9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uq74LH6PlCHACrsHlsmpDE5E2LksFn4NoQzyoBFgnL28tsYvxnzJkXo4dtC6q1zn8XRVAVfgU8981n2QkokE3DLofsQz1OR1SCI1/2pAmRBMQV8b26N/H69vhyJ1UsjOqP6hxqNyujgLq00acW9lsLD/7S0b8oEKGMBkcOACoy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAGV8D9u; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAGV8D9u"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cf50c6f235so7647425ad.0
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 21:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787287516; x=1787892316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wNiPWMLMvfqsRA/zVJD9oMR3HcxqazZt4gxnCgRbrbE=;
        b=GAGV8D9uydTqJTbGazZqKjbSL4ysh++H3Yopl7QRbWu86tFLgBdDHP2ACLvPmePdv7
         wD1AwRqnmvpoxiOek93XBAqWAbsR012DMnJ6SRxgYDaX1O98yTByi4c6oRrEsjevpcoM
         ++kmnNmaujqktpT55DOONAm8skphjvRgPQdCAOTwCf7xx8TNhn34qWHxqaIBBrN3O/a5
         OZ9f9u8aeHZjCk91ksLs/bcXfWQeNr+EK0e/bXnUBjFwc/LNIbHWqiLRTxee4O408jA0
         JdJblXWD+PWYAeZTjt25rd+UAtBS4Q6NBs4Dz6Pq1x6bedts2FdH+zUxJj1X6NRMD6WI
         21EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787287516; x=1787892316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wNiPWMLMvfqsRA/zVJD9oMR3HcxqazZt4gxnCgRbrbE=;
        b=VjY7fFZRi8GJyTicyg6WBnsEAD/pNJfJ4Us8vSNe6L/W5dTMEtTxe/Hipsmv/75Y1d
         iqFnR1YEZO/4Fi8D9VDqRdSJ3Ep/D5mj9HJaKfL/37ldQpwn4aMafrUfXCccr9gTofsV
         rKl/8SR51l6iMg6D+ogFx0iC8AMklDo+pTe4T15JROde5lUjxO4qLjaAwAwmscG30B6S
         uE2zASHOez6Ci2jmd3Ct1sdePH7ptv+6k4UQsioVHixGPAuRnMgmw/nELdDnsDHvImZ/
         cchYFhjDPTS8VEro+8+Ynqbfm8bZCmyp3u2bpvufkTP3KUVjMA+Kx4/h3S9JbR3nNQCq
         ki4g==
X-Forwarded-Encrypted: i=1; AHgh+Rquzy5k97LmUPeVE5D466EIXZVsRswOSq8pe/sEIDhpwenIYhYPmsAkT/bG/nZzvhXveNlAHgQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mELXWhIECaN9dEdxPjrPCZ4asw1n65zK99donSuFM2yGhnKCQp
	U/f8jhUrvHbC7Eao3cgvbiTnoTtomtg1iavv6NgBL3wdCuKIZrfKo1YyrAsKwg==
X-Gm-Gg: AR+sD13bYMjQn1/HjAPuvwk0hkp/TaZXBbNmqzx21EqbEcHx+5F8wt6GTTi9B2Uhkng
	BbinLZv9FvRNAGRprORUMdPALmTElpUykdgnaAowOqutDyVHDnNp7eKedwW06Wvw4f9cKRCEkUM
	IwDHTl/Erx3SQtBo1jz0ZTgPhy1Ozr4lJLAacrqlr60XMjWynnsA3PKkvaxVQNgfEVRvFj4Pfwd
	XUYGydg913z3wfoA9XkmsKMz7D2y1qhdhDmqeYWd9cGPrspYXSyAiJqnVfQoLDSqmvu2elbLIgi
	bkN5XnL9+mSlZRgAVTy+U25P6sMdgbTXzDFUnifnIChgHGDc527Vp+TaaKUpl1Dmg2jBclZkBAU
	pgVbp4CncYvjWZuG/4vpiDK+/mAHPyOl3ztl/mBw8JbPPp+zIca/vz1yeJS9J9Rup2hIf4JiwSQ
	E1gWNFf5gIuUFaC6t3w66EHwWpnRSPg8RBarU2g4mHa197CL2fO/EbDm77vW2adDKAyXKcKb/lR
	hT0yqZHiBV7lA==
X-Received: by 2002:a17:903:19c7:b0:2b7:975c:dacc with SMTP id d9443c01a7336-2d64ada9e7bmr78105145ad.1.1787287516141;
        Thu, 20 Aug 2026 21:45:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf15ff5dsm22352792eec.25.2026.08.20.21.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 21:45:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH] bnxt_en: Fix call to hardware monitoring event handler
Date: Thu, 20 Aug 2026 21:45:12 -0700
Message-ID: <20260821044512.663941-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first parameter of hwmon_notify_event() is supposed to be the hardware
monitoring device. The bnxt driver calls it with the platform device as
first parameter instead. This API break results in undefined behavior and
may result in a crash.

Pass the hardware monitoring device as parameter instead to fix the
problem.

Fixes: a19b4801457b0 ("bnxt_en: Event handler for Thermal event")
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
index de3427c6c6aa..faed0cf726e1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
@@ -40,7 +40,7 @@ void bnxt_hwmon_notify_event(struct bnxt *bp)
 		return;
 	}
 
-	hwmon_notify_event(&bp->pdev->dev, hwmon_temp, attr, 0);
+	hwmon_notify_event(bp->hwmon_dev, hwmon_temp, attr, 0);
 }
 
 static int bnxt_hwrm_temp_query(struct bnxt *bp, u8 *temp)
-- 
2.45.2

