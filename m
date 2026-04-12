Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA0337C0FA
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776002443; cv=none; b=rnwVu+CZhRJsfHw/hoLfTa7Om/i6rUMIWne10C97oFvaBw698awyRea7epYIsqHV4FEI0S//NfWJvKw6yYS8XWY3SiNVipbsdEbMedrwdSz5tvH9uisyvY7F+27XeLmSvPgpSv3dgeBlUwNHr7t08e/ntDrFrSa+iyBuB6CdAuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776002443; c=relaxed/simple;
	bh=O65OagGdcA16yR+KSOfnD4PCfCavizX1V42BiBKUV8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDClS1UdhIBmYt9J99HVmK5bKy4NJomIyJIvYwTKA0IqQ0+HvzeyU4rRlZqeP8d9YuEgAKg4Z87592lwibSPTejWf65Wrq3ZYUe/LdNVZYD32ORmEcmLu+yJdrg9q5wCs6oEvgRP+zQ68/f6dUgf6g2BLEN0RPJZ6+ceQxjKIV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUff0ua9; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUff0ua9"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d04fc3bf2so2081401f8f.3
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 07:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776002440; x=1776607240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Y8BPxcQ6465X542UsdBcHUWpSqQuKocfLy0RhQWsQM=;
        b=aUff0ua989g5wLFcLWbqU6i8o3EiBg2BuKQYse0W5uylFQg4fDJEwjFSdNABw0JEKW
         uSTHzvi8Uf/6c6AgB64pEgW0id44P55BAIPH6QKJ633+w5kZiGu/enV6EQLkwTKazmUW
         Krz5UCrzSPvEljOVXDmOEHAryrAMHRton603+xeCnenFvCQB6H1onR4poPX7IwUFvek2
         IsalReChqGe2eSAkmcnL9dXjlpVk7mabC+L6oXhNrqQy4ATM9bupVO4WgVRReI0i5nQz
         +CxV0LcLcZghuuq0qRSojspnP+iaJYTLOJvLq0gO3c2HybcC/hMpyOcggJB9LX0Z8ttb
         brNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776002440; x=1776607240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Y8BPxcQ6465X542UsdBcHUWpSqQuKocfLy0RhQWsQM=;
        b=rQScFpkBSU3Swx/ODOmmNZEnm834JN3D3MBqMe/ijzwRKGaPzdQWCMHCkV4CNXSlhF
         BecARoByRy2geqqbcxHfL4gb5JFMzd7JYoA2KCB3s6jcd1xEnMPjuOOJzO5vsl7Y30NE
         fJW/bfeFfhL5tYtOc3ppYwHR6nSBp1KOWyIwO1gpMq1qcjneW8UpBVK+3Q2nnP9V1SQt
         hyC4WW+vsaM+hGo2cIip0seeuA2cktCIAJ7Wnk6mgnDNxZEJoKMavBuy6PKtw2usLzu5
         6tJBgPlAB+i/7ThC+E+Rhtyf25IX/hR+w5LWjfZBmFqaiGbgPVQC1tkx0jkEdrVzka2W
         6ypA==
X-Forwarded-Encrypted: i=1; AFNElJ9b4gcCHZGn6O/CZTHkMFOMRd92ufgZdHFNJbpiLlsMvqNkFMWth5e0Xi/r5ZgDCoC85BzqjzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQWeztwPB0/b57AQkVxdF2+0emNu3worU7AT//MhNk7lNj7mER
	jjzy9aUgks2ufv+9+LBteZwASsJcwNEluH7L6WDChQc/SIoYUow9ljzIxnd7uQ==
X-Gm-Gg: AeBDietd3QOSHVGRrdk3PkK5cGYiYa2bN/jnGcehCPeY5RKwuB9koc+lEKBYUYNdySZ
	OqxjTcxvUCqAic3CytJo3dLI2yiDjNjiqZloMOeFaIGZEzc591fH88IH96c7pFMhh7pfR0u0N0e
	MZK8ouoph50/1BspxuuykY5rkgY3U3QT9VEllq8AHviuK3cKAGXxnNSOCfhhK6n59e5tUfZCAO0
	ON/UUtkclYWk9vD/f0hU2cKycVfysn32Wu59zSdgYInMp1YGEC3paE0QVsrrA4FbK3kYedar357
	f0Q4gCpdVrkJ3XgC3/5qSB0ktUfcQN3kKOsm89umnMrLCGTNPCMwS+IZVX4u0UbDPBaCI9F3yWk
	n9Wj65yrCKPIiJSf3Yak9/h9gg4H2li2LPwWYc1SF851mO7CUF2RdVSxWtZMUxsc4+RDcQt0tgq
	Ql+v+RGjKuPsJzqSsvqb65HhmkaPM7fiXyn/qkRruA/8tXRMPO
X-Received: by 2002:a5d:5f46:0:b0:43c:f8b4:e58 with SMTP id ffacd0b85a97d-43d642c088fmr14267673f8f.41.1776002439898;
        Sun, 12 Apr 2026 07:00:39 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:6956:2074:5220:4650])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50015sm26127538f8f.27.2026.04.12.07.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 07:00:39 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Arun Ramadoss <arun.ramadoss@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH net-next v3 4/5] net: phy: microchip_t1: Replace phydev->lock with mdio_lock in lan937x_dsp_workaround()
Date: Sun, 12 Apr 2026 15:00:26 +0100
Message-ID: <20260412140032.122841-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260412140032.122841-1-biju.das.jz@bp.renesas.com>
References: <20260412140032.122841-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

lan937x_dsp_workaround() performs raw MDIO bus accesses and must
therefore hold mdio_lock rather than phydev->lock. Using phydev->lock
here is incorrect as it does not serialise access to the MDIO bus.

Replace phydev->lock with bus->mdio_lock, and switch the phy_read()/
phy_write() calls to their unlocked __phy_read()/__phy_write()
variants since mdio_lock is now held explicitly.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3:
 * New patch.
---
 drivers/net/phy/microchip_t1.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index 62b36a318100..afb4e8908b78 100644
--- a/drivers/net/phy/microchip_t1.c
+++ b/drivers/net/phy/microchip_t1.c
@@ -337,9 +337,9 @@ static int lan937x_dsp_workaround(struct phy_device *phydev, u16 ereg, u8 bank)
 	int rc = 0;
 	u16 val;
 
-	mutex_lock(&phydev->lock);
+	mutex_lock(&phydev->mdio.bus->mdio_lock);
 	/* Read previous selected bank */
-	rc = phy_read(phydev, LAN87XX_EXT_REG_CTL);
+	rc = __phy_read(phydev, LAN87XX_EXT_REG_CTL);
 	if (rc < 0)
 		goto out_unlock;
 
@@ -353,11 +353,11 @@ static int lan937x_dsp_workaround(struct phy_device *phydev, u16 ereg, u8 bank)
 		val |= LAN87XX_EXT_REG_CTL_RD_CTL;
 
 		/* access twice for DSP bank change,dummy access */
-		rc = phy_write(phydev, LAN87XX_EXT_REG_CTL, val);
+		rc = __phy_write(phydev, LAN87XX_EXT_REG_CTL, val);
 	}
 
 out_unlock:
-	mutex_unlock(&phydev->lock);
+	mutex_unlock(&phydev->mdio.bus->mdio_lock);
 
 	return rc;
 }
-- 
2.43.0

