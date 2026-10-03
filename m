Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD273932D9
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 17:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791048755; cv=none; b=SqUlxIUQc1LfJrw1LDlxE+yvdIbLFHFe3YOPk/cqUXAt+otD5JnwkYMe3WawL7xkimLTm0XbJ6nNdmqK0w8xqf+BTjpY5Mktf5ArxqubRfh9J4Zxi1eScZ+sTL/0bgSBS9aRX1tuo9DlaKHVY2Iv3z8Rxu+gzRge7qSfUtnSOus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791048755; c=relaxed/simple;
	bh=QoRqzlPVZ4N5xoYxODT20puuFWUAgXPIHnwQx6BlFbU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pJHmENXLi+0T3byxpG3AnfNmW4c1ZLFVMVwyD+fDFfuJLRfFoFkGM6y9KsJcTdn16Va71nSFebRG/hjz4+YnA+AHsP8YO5UrvFiLHSEAgWm9NoBwxilaP1s2GGgv4EI5Uxie8hXCt1arU8wEAWWS9ZfnOZzJsQEbe0MeeDMfxY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfXoiA5Z; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfXoiA5Z"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c29c6a3930bso85193166b.3
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 10:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791048745; x=1791653545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LleUE9L6TCx7eK5ckWEfi/VBEFROX7GUZJBsnTVJ2/c=;
        b=kfXoiA5ZzBkmZkhZBNZlFNHF+THFF1lC5HYWTkqqd9+A+nHHfUlHzc/HPh+FwBMl7g
         iBi4y4LOsJA+AUkOQ9SIXsDgybwv7dWxSww8jzSLpb4T9WecQl7pOvq26lSdFm941j2F
         dO61WQs3BJV6sXYhBYmrmVQjN4nP4pCu+1e9jUwT4YwqvHLzmNPWnL3VzIuX7YJWMZ1B
         E8g5tS4maoIOrt3PO21NGJgaSxN4ieTei1dMchRlhp0WY9Yu+M4I12wEPpNyMk1teG9t
         NYOfV32OvouFbiXe3XysjaHZdGxr4yQT0613Jg5hYtvARmY9Vq9UzXd/jpH5iJyK3GHK
         P2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791048745; x=1791653545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LleUE9L6TCx7eK5ckWEfi/VBEFROX7GUZJBsnTVJ2/c=;
        b=jaccfTLErRHif9XoFOk2reNmZxsv8g6q2MKrHv4azDjqECxi7iRBD1XeNPTJUSjaQS
         HpAB5iLj3NI7Lp2xtHcSJOHN1wWxowRtXq1EgE7w4nTshv1a9yhYp4zOuR3vpA05di/T
         L2hT8tx+Lhel/9f4VqCxm9L0wwWbHgXrtA26fArmyQtQig5B5bWIKKW36fiRe7oLNfyC
         gH97VFDYQ4EvPBF3SGSBpraxfCAxbE3i0m2V7dUhQ1Ze9Yw2ivLekRdc/nqsUgkfr3PI
         y0pLBJKy7q/K2cRu2v8MG4KrrSyG5y6NA3pFvAZSXvCFQWGPl1NqtHPtgHLGWhi2u3aa
         HWsg==
X-Gm-Message-State: AFuF++nrb+MJfH8N3FRm6fcFfQI04Yb9CxucXNOkqyZHx3245dWO693b
	Ev+fw4LMA7SYTKWOXNRZgpWF+UJcERd3fbC/pWj+RP/7CZQ/QYRqEgENfj9mPh1BAD9fmQ==
X-Gm-Gg: AYBFou10+GxK4fxioBoFCi4KAHg1uV0FLDYHIfua5VxusWvxz1b8SH9hGV+bcAYqgnz
	QaZWj/hbjD9lNFDiZ/pvnrWZqrN7fbmj4XamcXltXsHqtiE60JpYfNywcrP8T0HojcvPRKsfR7J
	j/VhI7TMyEiQWZhataWnM4KM9gKb4ASEQAr6DgsLg2JYc9iREhDGi7cACHrcTLrSVuM7vO46Ul0
	OKXmcbBKBOvZZWE+08XfNHv7LyaUtDDLsauPiWEYiEpLrJAzJCDe0gtQEFyRiTojshHXl1cKzUs
	MEYtxLnCa1Ips0IZ26rJ18irCx4X0/IlPJj6QPSp6Lk2bjfL+zb9c2B7Yhh/lglRkBXQ6uI9mIg
	lUV8XeFkjaMqBugmwExI6QwsXTHbIPINjThiMDg4zde2ZSaUZrhhC8D8cioqe4yK9ZzY+w3MO1/
	JaEf4cASuIHq8TGE0pX7IGmCnyEKaaOZ0gDuDcMKhKOLpb1BrYYqhwqfmZe9zfEw+wpV52JIiyz
	AQIx49Zn6cL1XkOUs73lTlmcltcKFzh+3SXEYegPsnZMjzqH8HyQS/v
X-Received: by 2002:a17:907:d08f:b0:c29:6400:ef8e with SMTP id a640c23a62f3a-c2e6f249ff1mr248303866b.42.1791048744873;
        Sat, 03 Oct 2026 10:32:24 -0700 (PDT)
Received: from localhost.localdomain ([2a00:801:793:68fd:7995:7ccd:ec2b:6712])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e71d58d94sm84957766b.1.2026.10.03.10.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 10:32:24 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: phy: qca83xx: read resolved QCA8337 link status
Date: Sat,  3 Oct 2026 19:32:09 +0200
Message-ID: <20261003173210.1235-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After SmartSpeed lowers the speed of a link, the generic status code
still reports the advertised speed, because it derives speed from the
advertised and link partner modes.

This breaks traffic on a QCA8337 user port. With a downstream OpenWrt
6.18.52 kernel, a port connected to an Intel igb NIC over a two-pair
cable downshifted to 100 Mbit/s, but phylib reported 1000 Mbit/s. qca8k
then programmed the MAC for 1000 Mbit/s and no traffic passed. With
at803x_read_status() and genphy_read_master_slave(), as in this change,
the port reported 100 Mbit/s and traffic passed.

Use at803x_read_status() for QCA8337, so speed and duplex come from the
PHY-Specific Status register. The register layout matches what the
helper expects: speed encoding 3 is reserved and bits 9:7 read as zero
(QCA8337 data sheet 80-Y0619-3 Rev. D, page 328), and the MDI crossover
field of the function control register is the same as on AT803X (page
327).

Compared with genphy_read_status(), MDI-X is now reported. A reserved
speed encoding or an unresolved status leaves the speed at SPEED_UNKNOWN
with the link up. The new wrapper also calls genphy_read_master_slave(),
to keep the master/slave status that genphy_read_status() provides.
This refreshes master/slave status on each poll, including while the
link stays up. In forced mode, speed and duplex also come from the
PHY-Specific Status register instead of BMCR.

Fixes: b3591c2a3661 ("net: dsa: qca8k: Switch to PHYLINK instead of PHYLIB")
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>
Assisted-by: LLM
---
v2:
 - Target net as Andrew requested and describe the observed user-port
   failure. The Fixes tag identifies the switch to phylink, after which
   the reported speed is used to program the user-port MAC.
 - Use at803x_read_status() instead of decoding the vendor status here. It
   reads that status only when the link changes, so the code that forced the
   link down for an unresolved status or a reserved speed encoding, and the
   code that cleared the state again when there is no link, is gone. That
   also answers Andrew's two questions on v1: the helper needs no special
   handling of those cases, and page 328 of the data sheet lists speed
   encoding 3 as reserved.
 - Keep the master/slave status of genphy_read_status() with a small wrapper
   around the helper.
 - Cite the data sheet pages in the commit message.
 - v1 could change speed and duplex while the link stayed up, without
   PHYLIB telling its consumers. The helper does not.

v1: https://lore.kernel.org/netdev/20260928220749.857-1-yongzhao.derek@gmail.com/

Testing: a model test compiles the real genphy_update_link(),
at803x_read_status(), at803x_read_specific_status(),
genphy_read_master_slave(), phy_resolve_aneg_pause() and
phy_check_link_status() against an MDIO stub. It covers speed and duplex on
link-up, no rereads of the vendor status while the link stays up, a BMSR
latch-low renegotiation, unresolved and reserved speed encodings, MDIO
errors, pause, forced mode and master/slave status. An arm64 W=1 build of
qca83xx.o, at803x.o and qcom-phy-lib.o is clean.

The hardware comparison in the commit message used one board, QCA8337
lan2 and default autonegotiation; the downshift resolved to 100 Mbit/s
full duplex. Ping was 0/20 in both directions with genphy_read_status()
and 20/20 each way with the new path. Each path ran two warm boots and
three port down/up cycles. I have not tested a cold boot, other boards,
forced mode, or an unresolved status on hardware. The latter two cases
are only modelled; whether QCA8337 sets the resolved bit on a forced
link has not been verified.

 drivers/net/phy/qcom/qca83xx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/phy/qcom/qca83xx.c b/drivers/net/phy/qcom/qca83xx.c
index bc70ed8efd8..b8da6a41788 100644
--- a/drivers/net/phy/qcom/qca83xx.c
+++ b/drivers/net/phy/qcom/qca83xx.c
@@ -92,6 +92,17 @@ static int qca83xx_probe(struct phy_device *phydev)
 	return 0;
 }
 
+static int qca8337_read_status(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = at803x_read_status(phydev);
+	if (ret)
+		return ret;
+
+	return genphy_read_master_slave(phydev);
+}
+
 static int qca83xx_config_init(struct phy_device *phydev)
 {
 	u8 switch_revision;
@@ -220,6 +231,7 @@ static struct phy_driver qca83xx_driver[] = {
 	.flags			= PHY_IS_INTERNAL,
 	.config_init		= qca83xx_config_init,
 	.soft_reset		= genphy_soft_reset,
+	.read_status		= qca8337_read_status,
 	.get_sset_count		= qca83xx_get_sset_count,
 	.get_strings		= qca83xx_get_strings,
 	.get_stats		= qca83xx_get_stats,

base-commit: 6dc989ea46b96ce170840174b4a38c4a387fb005
-- 
2.43.0

