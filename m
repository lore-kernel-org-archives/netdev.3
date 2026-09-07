Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E5B47277C
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 21:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788818096; cv=none; b=OCPekRy77VP1BmDdnjrJmsOAEcB3V7RtUF55grpDvV9u7p0jOQje2PyKQeuosZlnPmiXJTjUxVx/f/w7yJs2OVgQpGbv2V41Qt5LAtC4XxXlPGWq/0KRQTHg+la8/drOT64uO3U2clK+T2CJ4NzwV8bwkmNYPIhqla+ais4x83s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788818096; c=relaxed/simple;
	bh=DU6aX0Z0p+fdTWqaCesdEJ1etwt1QeLalmsiq/Dz8xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=plmJ8xgJrmERKvOH5DKisRmbHwu8/Fh+2w4qoF66P/Mcz1OyIxguKedzJtNhRAI7by+5HwoAmhU5P9V2kZkAExiYPW4wVpRueqWPN+hT743SosRlf86owXH1q1UT0yxHL1lGBucD3XSZ6pjMXdd4PUCZ58zfk6lhUT4HDqYpQoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbzJCkHV; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbzJCkHV"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-87005a0e052so42555807b3.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 14:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788818086; x=1789422886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FMBKloH328hYHvt9A91TOoJByZqoZnKZvzZqMuRPjLA=;
        b=fbzJCkHVmw+kYHLOmVkyZ0CBUGz5bRWVGiqy+nOetZyljJTzHh6G5jgDBdwrkpHebX
         cWWT8Fi5RXOqj5jNhumOQOxYLsV4d1MSesKt/jwJ/kT1CYQMjQzT5uVG32yOxfcpqVXx
         B1p38RjyQHSpMIismV6VD5gG7HnSjbzqRXXVb9QxTpQO3NRw9Af//ICUsCZAkXzssjdR
         0PYHNFi/hPN+lRP4E0SVZIAlSTBY9g3e1IRxwNOcD+qyDFbktUXW2rj5Q80QhcPUFjzG
         V1CFKNnfxl/VcPPhAxr8g8RFixQeAam9GP6z4AKivMfS97XmCtQybQi8EWaQ2+X4J3Gm
         oNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788818086; x=1789422886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FMBKloH328hYHvt9A91TOoJByZqoZnKZvzZqMuRPjLA=;
        b=K0H68CKs7ZFiuTnSHdtKb6Bts5ErjeQxDa3/UhCFWvh/9pClC+xFi5BlANX93tu0ya
         MBm3EkW+8/t4cPREoRiNnvzHHH5PJbIrnLaEpACTbFscvTz4qQRO6y9UZmG1UVy/GGex
         /5utGkTCMGZv45NP1LtkEIYsdqHHr2zWYOtxQ1yly3MDxVLvlTjEvQR/r1dDBaaeHlXU
         RPV8ANt7U70r4EeS1k2tPpsGY3GVW40QUwxsTDqUQOURnkIz5FJzcE8eDB0DGyBSq3f4
         suS74mT0Zec489U6DjMaI70pRYP04BO1+vgJYW3JPRH5gV+2xFbStLQEDcC2E7Z3xXsu
         E7Pw==
X-Forwarded-Encrypted: i=1; AKwUvBxBGKpVZTMqEnKkL1bi9fG2sm2wqHTl3A1Ku/YIwEsOOYgE1uMWAIS/nLXpMxBOsHvp/Uq5y0c=@vger.kernel.org
X-Gm-Message-State: AFuF++lx9t22iMLNpof2XAh05DGnq+58uz3aq7TGN1hmIyXU+jQfw2U+
	gnMmWcyRIySAneI1xTIkAuVURLXFThyizjbJlRUPKviOS0yx4YREVtPd
X-Gm-Gg: AYBFou2Ab9Px7xKC7cCI7WUTXqptPRFyRjAhxcvUhRT0Dlx/+4e8GZusN+Jhakg53ZO
	i3+99Z7CdR/Gpb6oGtnazC24qC5EdX5h39dTjnmQSFP+iXq5AkExulEVXab//MtxvPgslDLLBCB
	giywNSs4V5LoDXgglslz/eV3PR+3s4COGWadN1qRDuLOXXHA//tSfJj9kb+gdhm79TLDlUp8+c6
	JZNlOlAe8D5wKp5ZPuRRxAbGKHwIDiTNiTwt5e+Xeqh7mnAe5e2JMrgfZJdS0bu0HsjRaWLfhFZ
	A4DMmcjsjRRLMA+vJitXtSZco6P1aK1e0hI0HcaUmFhMJqwblpSLJARxeHfj1latvoUI62Sl0NO
	irg1VlyI+o+F349b25urcxDkd8HlQGyxwuwMY8p2h5jlXr1bYfXpOnJ00axMXyMiP7AsaDvh2Zy
	UyBkKuSB0b11gLfRRQK4v82NOhtRE4pi9y9mHnRkYPI+5+wkWloLpDqG5DsZ1v+6t0BTSoIJVEj
	qY3tYb6HavbmKzmMQ==
X-Received: by 2002:a05:690c:88:b0:864:6f4d:ef7f with SMTP id 00721157ae682-87121acbbc5mr98578937b3.7.1788818086189;
        Mon, 07 Sep 2026 14:54:46 -0700 (PDT)
Received: from localhost (c-73-105-0-191.hsd1.fl.comcast.net. [73.105.0.191])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-87149316356sm77902237b3.9.2026.09.07.14.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:54:45 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Raju Rangoju <Raju.Rangoju@amd.com>,
	Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-usb@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5/9] net: phy: use linkmode_and() return value in genphy_c45_eee_is_active()
Date: Mon,  7 Sep 2026 17:54:34 -0400
Message-ID: <20260907215439.409858-6-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907215439.409858-1-ynorov@nvidia.com>
References: <20260907215439.409858-1-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the return value of linkmode_and() to detect an empty set of
common EEE modes and get rid of a separate linkmode_empty() call.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/net/phy/phy-c45.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 870920311f9a..27da1b9ddbc5 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1623,8 +1623,7 @@ int genphy_c45_eee_is_active(struct phy_device *phydev, unsigned long *lp)
 	if (lp)
 		linkmode_copy(lp, tmp_lp);
 
-	linkmode_and(common, phydev->advertising_eee, tmp_lp);
-	if (linkmode_empty(common))
+	if (!linkmode_and(common, phydev->advertising_eee, tmp_lp))
 		return 0;
 
 	return phy_check_valid(phydev->speed, phydev->duplex, common);
-- 
2.53.0

