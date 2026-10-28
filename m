Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793172650;
	b=S5ToWIe6BR8D+bkly1nHa0F8m03/rwnMtsBVA6kltr3kX8dE8EnKQuf1potWGuHfqHMx
	 JD0TWjEwkcN2BUjyEmaEQR2G67diMgESleM399NBysq0hbGSuwu6Hkckpk7B3/PZKaUCF
	 cM56Ounvb6AHSDqtbciECpDmmDDEvZmePssV0mdL1DVinE9o/+SRbhtyS8fwJ2DDba+Th
	 8QgernJzRcI0AtD4sTPsvRgk1SXUNzpVY+cP3FLB4m8Z/KpaLlaJFjyz7BOWJsQcu8t0h
	 dV/oEdiGPFD7HdhwqCcb9Gn4EkgvdGZEYYnNt4aqYa2RoH8OYh4gA7sezVdnVR96VAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793172650;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xlOBsO8kcdP1J080HWu9hmTEce9Xj0OyKuwceuvj+bE=;
	b=4EoTHII0c5u92gLYD5O8qFLXfoIQRzaT9FFwsT/6/VgSFzurPcgmbXidIptuEyoG4Qny
	 3DmGPfgUTOysesnxWximCdVrqxJJWHNDT9vELezCZedh9mca7gFD/saF/M0bmvZfFPAiJ
	 DRIdPug3OcXiMbouyi46MBW+9wgqEov5GDlCrH3AoLzWHa/qmTJzaXQ6GXoybBMwrLknr
	 Gc9IEnupku/P73jK3YLaTm3ffM2EAE/j5ImpkouLciLuulTqnLiuohVm00yWGMw/pGCQq
	 kZi0FOFh5BtV3ZZq/Qo/dMSIxtN9b8fmCC17sEDWnfcxUWlrgLzTC1ncHQo4bGielaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wgXzwn8Y;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB28606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 07:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCB28606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wgXzwn8Y
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e4831c028so515937f8f.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 00:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793172648; x=1793777448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xlOBsO8kcdP1J080HWu9hmTEce9Xj0OyKuwceuvj+bE=;
        b=wgXzwn8YYCaVXZt94hQEpCLocthVD4zuyhV2Ar9yRtzJs4rSE6tTLyYZM4rfec707z
         sEWkYcS0h5K3irfZlYEOpkJCoFB+vmvPMkVmJ9fc7uSB29xzO7RhvBGjxqEEc50uvYmH
         5SCLr4ua3jsAZZIWkeZVI8U64Jh4yeBy5QyIkFdztWnQ86ZqCuB1mVO8Jen05Il1UV4o
         W8KSvvTaW/rWh36v7VJMDyRXFb7DdsZqes6gqd/OlKercU0J1jDo85NuFZO+GF+EGMJL
         Axye+VNPeuh+/m64N0iQvZH7+as50d4SP//Gy+bbAPVdfQIL/l0eOmCoWtPr74IMPU6m
         gjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793172648; x=1793777448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xlOBsO8kcdP1J080HWu9hmTEce9Xj0OyKuwceuvj+bE=;
        b=Mg09VJm9yErh7B8WlJrjHl0wfO9POi7yMVJPzDL43TmcyvwOhPBiS0RhxrqQmH/6Gd
         hlgxWywt8nEyXJnpxJZwdWXz5MQNNtsCFXl5Ui/I38iZgEeAsoCnPiyApJJOCuYWtFim
         BWHCcdsa/hHzudW5+m3ukAlDLVj9xSkKDAiUbprGwKTV7dGdXC/YJYUNyOrEgHJAhrNQ
         RthWeJCBknAX3HLn2Ehrt72Owq7UO/9Care3lwqcuwcTMy8RZeUQtWC5/T434dEf6Grs
         ZDb9cQSSC+BzHW3CpSnGzNAYTFVoykp+oB98kpT8585Q/PwmOp3c9WusOCZmynsNro8f
         kuag==
X-Forwarded-Encrypted: i=1; AKwUvBy1JTD1PhPjYBgtqyQLMHnmtxKAgdHZRr1KAk3fy/TTqPEO6gBdA9nDnnI9ik5wuXn4vU7OK7c=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwh3QRjh3ZiiyqByrSa8ggv1q+hXN2+cxnPc8geRa+iMdGbPBa
	dY0dQSxocImuI+A0IHkyH90OVcPq4clgBgcNZzihHNjni5twr8LodzNk6q8uKg==
X-Gm-Gg: AYBFou2gxQkbD5rZFy1hwddx6COoJUrqWCKaTXIx81PPJhX2tkhgHuV5OqTUf/qHsoo
	nuVvBoTG8dgRNS91r/0J16a06EAg1QeR0msJ3hh5rryUfNRnsbSLqQKGZ2+GVOd6LldUF/Dpy8b
	cPYyZc6jV1PthgwWnW4BR11iaEqk3uTDqZH1b2am22tHasbgwB8eFS/SiZFtF5hiSMn3BKe+a7s
	n+PGNsg/ZQev6ZQyTpkSQh8YdPYsSGhRtA6NJD+3AxZ1u3EANEEwSpYmhDIO/909bLiGxqTCqyR
	ys/qsjBr+h+s89/9RGAoQFrhscdWvSuYDK8ByJT+66/4Vja2tYlLyMX4lfmUtPI6vodZw18lX98
	L9wl4rOoLkaOY0F9Tb1Whpn/8ttTwTxH9O0Y5+9I65Nv+EQgv8Y1fbXSgSuwvF4ajTzNKcUdHGw
	ggi4+jYfc7AhKJasQFE721NirPDIkRGj2gX+uIMraZ2sMQ2BkMARioBrnVFx3W7cJ1eDq43bjFa
	tVTwWqyRMm83oidZNx1Lyzxkpoi+e6QkFuViuEuG1u/h+jDphVJdSf3yZ1BZO4QLUqUkQIpKog3
	C7mibK4OoYBvGv2/nrP9YRG9DfLi2L5OTmmRkfSnpZRd/To8e6jxV4Y7ztwWGTv+zkoir0yL06N
	pNLcCUf1wDRvN0yuUHSn8Q6RNrGYhQaZSHPuFStQZErEtZGctD87pZuc=
X-Received: by 2002:a05:6000:240f:b0:48e:60bf:4177 with SMTP id ffacd0b85a97d-48e60bf43demr854284f8f.9.1793172648194;
        Wed, 28 Oct 2026 00:30:48 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it. [93.34.92.187])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e542ed998sm12083088f8f.13.2026.10.28.00.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 00:30:47 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net v3 1/4] net: phy: as21xxx: handle stale link status during autoneg
Date: Wed, 28 Oct 2026 08:30:19 +0100
Message-ID: <20261028073024.25175-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028073024.25175-1-ansuelsmth@gmail.com>
References: <20261028073024.25175-1-ansuelsmth@gmail.com>
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

When autonegotiation is restarted, MDIO_STAT1_ANEGCOMPLETE may be
cleared before MDIO_STAT1_LSTATUS. In this case, the link status bit
may still indicate link up even though autonegotiation has not
completed.

Force the link down when autonegotiation is enabled but has not
completed, preventing as21xxx_read_status() from reporting a link up
with an unknown or stale speed.

Fixes: 830877d89edc ("net: phy: Add support for Aeonsemi AS21xxx PHYs")
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/as21xxx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
index d5738117eca6..0db82da8dbdf 100644
--- a/drivers/net/phy/as21xxx.c
+++ b/drivers/net/phy/as21xxx.c
@@ -658,6 +658,13 @@ static int as21xxx_read_link(struct phy_device *phydev, int *bmcr)
 		return status;
 
 	phydev->link = !!(status & MDIO_STAT1_LSTATUS);
+	phydev->autoneg_complete = !!(status & MDIO_AN_STAT1_COMPLETE);
+
+	/* Consider the case that autoneg was started and "aneg complete"
+	 * bit has been reset, but "link up" bit not yet.
+	 */
+	if (phydev->autoneg == AUTONEG_ENABLE && !phydev->autoneg_complete)
+		phydev->link = 0;
 
 	return 0;
 }
-- 
2.55.0

