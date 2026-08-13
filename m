Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA1048AE24
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786635094; cv=none; b=UOMw8VY0B47wKz5BvS4RwauH2grZmDSHs/RBLARiq0UxfG6Xy+4agXyFvRkwEuyfGyx3O+eOITdGWIEnQQiiTWCg30GyDy2EvvAwx0q1RhcTbgq9dAu9rrTn9s1heLcrB7dov5pK9EWoRq6hozS20QqdDQ9oBeqFH7DRaBbcRCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786635094; c=relaxed/simple;
	bh=YK5PsZK3kKo7Jm2OqTBXVV6R9je6KgY3acUnepOtEyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=raUMjejSTgSBC2CcnFs3CJyokTDQFeBQhZF52lothSWA0wWsrtQ5foH3RjdxE+5bDkY8D3OlAXxSOY704069GOVT3bc2C1P5dW5NtkbsDvZowXTfc7cHKRAV9YNvTOqPEwIy+Gr6TxMFYWbPHM4C+GpgIsB429Z2HswFk/chMww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSVGgjat; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSVGgjat"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84e04df8c46so2449140b3a.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 08:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786635091; x=1787239891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KoIS/EkathyELulFahQfkRCm6vzfTrZEsTXUD7JHWaw=;
        b=lSVGgjatXh0n8Ex6Kvm8ErJtCXn314zf/+9nOf+wsTFkyW5NDQSxFGW0UL3zKCATqe
         lVHP/c95tC9DBfcG1d34hCDA1HFbu5JtAgWYNdl0wX+k9AX65f23X/OGBMcRuJTjtmbC
         zIRoHUqKFXv0jNHbt6XO13hmUIait2ZfaDhw74KqISUSSE+RQfOS/br46qRR1UMr6f5E
         1qebGclgRZ9NdJ9/PA5lJzd+hwp4+RkDs6iaYTzSvPUJ/qw3roefJRurvr5S2WwMsRkT
         Bk+N5nnWp4WkK3QgIFk90kaPawonPcBl2WXAaXXCzW6YzCmquoA60iirI7rJekPLoYeq
         KoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786635091; x=1787239891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KoIS/EkathyELulFahQfkRCm6vzfTrZEsTXUD7JHWaw=;
        b=Yo9OlRZ2EAxOLvdCmYePvj1G+2xRxasAwTop9Y3n1kbemsnA9+mjHGInmR0KlqpSS7
         3sjdUsBwyn7dgRr8r2hf4Xfgy9pDQmoMn+tLGjPgdWlUxD5h2IFXxVIDoBdBYy0RXNl7
         4SyljXy7meQ6kk1fqB1gjRutig35gG0XcjWEmMIqP0P0OBF6R15ekRZ1jDUhOvhM4JQs
         arn+m6BWjcQ7zL+3QVH5khn+q/5El2b7uHinKAgg5cHk8Wu+dhGVPaB5zvUuQ7gV9R+L
         xzTF7lDD/UorqdKDrAZNqC9FYWy7GPp1EQdFS172bt3IW/UhVg6DKJU/ghtx68f6bThf
         QKoA==
X-Gm-Message-State: AOJu0Yyyn2VXxy+XyXKgmt/boyexFSKD81+eJy2xbf3G7hrp0XuaIkxi
	idDhP3WvPiEY6EEtKnDrrBPUhCL77EAWvaMdB7fGE08XjuMeyT51yjcq4y09ik/0RUE=
X-Gm-Gg: AR+sD11OnwzqlIfhiR8DC5qVFp6zmwjeWQ7wB1cy1UZgCZ6IVMuISXR5ZN0Spn33nIH
	hzggFVDy8JUZu34EjVADPfY4NMo8x8VI/3tCzAooYTCFGz/vZ8nBYjK68HaehNKwXQtlnjqVkSV
	fYvIfJwBKXHdoXMScFWV+HY9SSCWT45yPEj4fJMAxNC4AbPKWSKO2XylCEWWY2qxfm7gGzSSV/H
	90e+ZgAfuqrN9MBl3/DLJURbz2mOF0/WNBVzweut+kvpicsRM6N72xe/0TN/GvU95/Ibk1Tefcy
	hpexmNudMZlun5VcooJWFbn+V5f7hDqyaM5doB4iaKkqN5jyIQqpedTRhAhznByJP5yCZElAHx8
	tC/Ar3asJ3KahOIL8sd/ecUIDSSzkT/TBHSD0lXO7s4v7Q4H+aWteWbbZ8c9lQ6zQOEnnqPhUdD
	LMyrmzF6IQs1/Kc3AW0Ae1z3I/s9/GUntNZYSd1wpxQpmUBfCDmrwuoZUSKJ08z6ADw/4khAsHc
	gJA5a4=
X-Received: by 2002:a05:6a00:e19:b0:848:44ae:47c4 with SMTP id d2e1a72fcca58-84fc6dc7110mr7997042b3a.20.1786635091229;
        Thu, 13 Aug 2026 08:31:31 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:3b7:6da1:c188:d14f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fc5a5635dsm1077920b3a.46.2026.08.13.08.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 08:31:30 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH net] bonding: initialize err for empty target lists
Date: Thu, 13 Aug 2026 23:31:26 +0800
Message-ID: <20260813153126.3952893-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Empty NLA_NESTED attributes are valid, and bonding uses them to clear
the ARP and NS target lists. When either target attribute is empty,
nla_for_each_nested() does not execute, so err retains an uninitialized
value before it is tested. The request can consequently return an
unpredictable error after clearing the targets.

Initialize err to zero so an empty target list completes successfully.
Non-empty lists still propagate errors from __bond_opt_set() unchanged.

This issue was found by a static analysis checker and confirmed by manual
source review.

Fixes: 4fb0ef585eb2 ("bonding: convert arp_ip_target to use the new option API")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/net/bonding/bond_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 4a11572f663d31..87d92d3cce4a88 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -220,7 +220,7 @@ static int bond_changelink(struct net_device *bond_dev, struct nlattr *tb[],
 	struct bonding *bond = netdev_priv(bond_dev);
 	struct bond_opt_value newval;
 	int miimon = 0;
-	int err;
+	int err = 0;
 
 	if (!data)
 		return 0;
-- 
2.51.0

