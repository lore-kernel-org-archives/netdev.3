Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE0848A8B8
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786635099; cv=none; b=epC0XHnlExYd2C4bW2GGgypFqj+LRSvcsOyMJQHz51awHkgs0J+KOUt/7xhdoc0Pq5chwvwgl3FmK37f6sq7twhC4sCRLs+/yjLX9SExt1YX2C4K9JNHMHTl9M8DnHV/rgqDJInoSTRIOsiYMOPOhdc72aN+GH9ZTsDLY/cUXSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786635099; c=relaxed/simple;
	bh=ubC8xB2KvWN77EL+tuwQjmKjp/A3BkprKNZHUU9qR1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qFrjNDS+XRah8P6LzEBfV+yJMJneIlD7T82ocEYC41MI/2pbuF+z7zVepT47PcnIYWVg08ra2p9ryIb7jrH3sX+go5NpXv6+4RUe6F93KB12M1VUy5FjIxFU413zDHnIkGsEValrOneX1WOvDFtCOwLGNkcVWVdwaTLeGleoBks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mp9U5VIJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mp9U5VIJ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d049069377so756195ad.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 08:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786635098; x=1787239898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HaMXv5uU2gav+xr2y+0CuLYsTKZezZiW55X0WMSejck=;
        b=mp9U5VIJmTefwW7GwFju11hOGwVCl5GV6FoHn8leIiZD6R6wz3ePMLmVRzR9eIP5iC
         aMlLwNFbgay5YOLCm/2/2jviUEootCbTIw6muEcIkHCBxMtggnFErGzS6bdRRVpMXkOq
         CJGSCLr8b3fnSDh0IssRKRIwS5BUrxGb+KsDIE/Vpw7HevpK6lbHWkqDmF68vv7IxKvZ
         G0oiA8t1LrevAT3MjpgCvNAVe0dn50q2JX1NfvenedRyMADCdj01kyQHFZr4hzGi0qW3
         I8MCoy6cZXShtYUk+4O/07DBm2ATxu+BJfd5A+CGZ2ZHlSSNUgA6al2r2UEBqtpCbpZn
         I9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786635098; x=1787239898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HaMXv5uU2gav+xr2y+0CuLYsTKZezZiW55X0WMSejck=;
        b=gzzMPCmrbI7+xUMFN7mo7boDr+YKY+ArwxyVy5K7YZYu7a94yHBGcjz6eR/NA2U6yN
         LwNzKPW4KYUOzNkUBF/4WYL27GoGKfNRAU43BPrDbydCTDlQ7d2+kSg2Y9FkTsWbn64W
         8NWg4DCxEMb95jTPoWHtLdoJqQ921YpSH/yEB02kiVK2PZyDZz56tjy7SiHiqzYshEFl
         n9odVLfEwC/kwCLIS2l6TTX7xJDz13a1guy9NRhR2WYrFcQ7IXMz0U6/zWZ5py8oICXh
         rAiml4Fw0DwQwfepzoybUwzaGc6+4KSvqGjAv3R/jWgoKFnldkk7anV+X2Xjf3+YmRcI
         0XkQ==
X-Gm-Message-State: AOJu0YxUZhOWz7bc0Mj26QPyIo/flRTl0n3ph8vyFln9uyJCQmGmtd4J
	e1HRb40zcB7SYbnMjzchv7cH8wBcHZhLkFtJBbXBXrr4+UYV0kao9tovnVu3lN8e+0E=
X-Gm-Gg: AR+sD11dC6DsI/8GmZ9cW43pzSjntb/FQgahGYXhumaVcwEmYJPrg+B3a4gUkWmHia8
	j7Or0nKifZYYr2izwuU9fbUATR8uBxnVyR/V++EBmwGgHVRa9kMyAFigIsi0KPf09NsVvPj7vY1
	bokBil9FOImzUA8fnUum0uDR1Lknd1J0OzUxg1pRcj60tcCGgYt9JPSQ66ixQnDsI0jP8lnj4nj
	qdpDvw0sWiBNnAOp58u/EnNOirE2S0Tnw7IGedEv+pZnKUGs75Z8BkXHovfAszSHhNTazDK8rlr
	vrrImHmp75vnwYaLJAELZ/7xLtw7nJdsijlXzggEnghJDpn13YkL66cYVa7eYsRJRLbjq0/6HzX
	K77elFw3p0oP9avqs6IOXUj+11lIJIo6ub4WVTqfFJ3PgJ3zd8mTMvMfRVXLWSUMxXhXUy7CdPM
	esiFNO+dMqzlfYrURcqcKL9sLG0z9P+ZjY//hv3XM47LrnzUyvdsbLyIn+kWy5lIdbLg2EG6K8x
	WxWl+Y=
X-Received: by 2002:a17:903:4588:b0:2c9:e2c1:4fb5 with SMTP id d9443c01a7336-2d37ebcf007mr71805905ad.22.1786635097517;
        Thu, 13 Aug 2026 08:31:37 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:3b7:6da1:c188:d14f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d37c49cc32sm11881255ad.63.2026.08.13.08.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 08:31:37 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH net] net: dsa: mv88e6xxx: Fix PCS link check on CMODE read error
Date: Thu, 13 Aug 2026 23:31:31 +0800
Message-ID: <20260813153131.3952970-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mv88e6352_pcs_link_check() ignores errors returned by
port_get_cmode(). If the port status register read fails,
mv88e6352_port_get_cmode() returns without setting cmode. The link check
then compares an uninitialized value and may incorrectly treat the PCS
as active.

Save the return value and fail the link check after releasing the
register lock. marvell_c22_pcs_get_state() initializes the reported link
state to down before calling the check, so a read failure is handled
safely until a later poll succeeds.

This issue was found by a static analysis checker and confirmed by manual
source review.

Fixes: 85764555442f ("net: dsa: mv88e6xxx: convert 88e6352 to phylink_pcs")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/net/dsa/mv88e6xxx/pcs-6352.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/pcs-6352.c b/drivers/net/dsa/mv88e6xxx/pcs-6352.c
index 4228ae5bb9db0f..437054711a2d8b 100644
--- a/drivers/net/dsa/mv88e6xxx/pcs-6352.c
+++ b/drivers/net/dsa/mv88e6xxx/pcs-6352.c
@@ -305,13 +305,16 @@ static bool mv88e6352_pcs_link_check(struct marvell_c22_pcs *mpcs)
 	struct mv88e6xxx_port *port = mpcs->port;
 	struct mv88e6xxx_chip *chip = port->chip;
 	u8 cmode;
+	int err;
 
 	/* Port 4 can be in auto-media mode. Check that the port is
 	 * associated with the mpcs.
 	 */
 	mv88e6xxx_reg_lock(chip);
-	chip->info->ops->port_get_cmode(chip, port->port, &cmode);
+	err = chip->info->ops->port_get_cmode(chip, port->port, &cmode);
 	mv88e6xxx_reg_unlock(chip);
+	if (err)
+		return false;
 
 	return cmode == MV88E6XXX_PORT_STS_CMODE_100BASEX ||
 	       cmode == MV88E6XXX_PORT_STS_CMODE_1000BASEX ||
-- 
2.51.0

