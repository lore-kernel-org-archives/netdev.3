Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5654943D4FD
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 23:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790553472; cv=none; b=iFE5I7bWnC1iCyqUoYrIQqX6rZ1DCALT2t1kI/wuIM1rE6J1Z6FGtld+0qKijJACLzGE+3XQzYTirIr1ppKwLmLpSY8wIpIHXEa0HdrCfH1D2QhDH8iwuyTQ4v8826E3ukfz+ElWeMQkkZlgkTJawaXQNMsgIkAiHl5JF1MExLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790553472; c=relaxed/simple;
	bh=DTm+8VkU5gcH3XgRDOy8kN9YKZ+MZN+K6h7Y7ZTzZkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DlMJWRTmxDcsXdeM5SAAT0nOz78mArPKK5bqYyuXBE8kcJ8M3YLHrfarBqpS/7PLj+zvObxrCxvG2TN1fyOHQ0SvYetvZpMisk+yElgUOpyryYd2aHVRd6UXiTmeqix13t9KLX7Fianqy94VlHu8sbCF1a6UpSjD6AvYdPWSy3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=EiWrHDvo; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="EiWrHDvo"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ffbd83a92so9467335e9.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 16:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1790553465; x=1791158265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gZ8p/NVIadAMhbwnanN8QfTI2Nz4vTcQTSBnLNkkJao=;
        b=EiWrHDvoGPu1pv31N0eklGwGWwdl/XhlLest5aA9BDbyED0VD7KzLIeINxU6L49ZX1
         f5n5XF823gLQyRCaR/vV+MsjCzgtNK9tWnfntpbLIVplARWK8uM48Mj9gjg1fBI30ksd
         t4YJUAFYoOujuee1XGT80g3MUDoAjuRSNULPNd7GJHpY6IK746LsF6Anv0GG0syPeiO+
         9xCd8fqcDHz/8WoO2QfKDl5ranjgvCTDB2M5sU9krjJhL6sx38cuwXH8BuxJeVmCFokF
         1U0ehmgIUzd0KDhY43bGm+NIHEI1h5W5N7VKqPoMOOFM5vMtPf0Govc8VDd4qjo9wt8w
         Z6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790553465; x=1791158265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gZ8p/NVIadAMhbwnanN8QfTI2Nz4vTcQTSBnLNkkJao=;
        b=lwEYZSgA4HCnW7Uu7KeyvIWNkx78Uy99A07gjzh7yIWBSsm4sM7bdMD+HUe6ar2WHV
         yxp1a+9NQUfC/QxGCdlq3qnHhIxp7jtHzojubhdRd3hFqDwe7c+AkR9jGMLZwNxragRL
         gqV4Zm+KPd/5ruWx+0wOWIrTcoEb1okmKiU/+NunpDpHpPvITMWYgYwa79Yd5od1VM5i
         w1dbzJ2GIbeWNcN/pXuN21uVnt43q7gvFGs07Mw56n8fqaLo4RizmtnecwyMvUMdQrKN
         X+M7bcQX2ZRyzi8jOs33YOrUrx0KKJT+P9gAYkRcFxzuyNLugTMPzqA1i3ZAgP0zroAJ
         kTWQ==
X-Gm-Message-State: AFuF++lFLoUlMQH3G3Z+rMsYB44HVhxY+DQqkeABO0NmtotKdnW3BQ/+
	cWRds/XczSy+z8/bdJPXfUd5fkiQbqo83/1HmudE5Sb2uQAavmsjtXqMjnE3krubd6QnK/ZbTF4
	IBvW7mpwGhEZ1
X-Gm-Gg: AYBFou0K2n5HpYjPicAuEwq7bcwa2/qYZyR/DJWhuQIr335/yTZbUyzGzZaMRgl5qDV
	Fg6kilSVIqpjoUKK9SP4VlPuVe40+iox4JRlXp7/wrHOlNz77sYrVtlE435O5hQ8cIqd4Wa08EG
	7OUui2lLjSCNlSiuP1IIlawnj06tJKr3Yxkq4cRUebAskNWrgUAEN8FOMMX/gltX4KwxHfS0ZoP
	KkCRABnBmY6aloC80Jeh62wUA2Ft7VaHP/X0nypyZMhH9uuaLs1RCLfo60S+CMoCci4QtlR/UYL
	XRhvCijvLzdfoGVKtMi/YHII87sBhxseR8qYyjSlAvbfjEgmCAvUguEljJJwMbeLpR9+jmXrzkw
	Cb/rYySrYvdcacHEcY51uzRqna7gKus7b49S1Cc9dKS7Tx/eXbR2rN7O1V5/BBZACbIkZSkrj+H
	BK6v8D4TxUjU6WWr2yzKbgQZ+XByB1+IKR/f+sWjtohl5bjRdVug==
X-Received: by 2002:a05:600c:37c4:b0:4a0:b6:460f with SMTP id 5b1f17b1804b1-4a001e8c579mr42530565e9.33.1790553465459;
        Sun, 27 Sep 2026 16:57:45 -0700 (PDT)
Received: from remote-01 ([84.17.55.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0017998dbsm137971495e9.14.2026.09.27.16.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 16:57:45 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	olteanv@gmail.com,
	Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com,
	steve.glendinning@shawell.net,
	f.fainelli@gmail.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH net v12 4/4] net: phy: restore the interrupt when the generic bind cycle fails
Date: Mon, 28 Sep 2026 02:57:33 +0300
Message-ID: <20260927235733.2619081-5-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927235733.2619081-1-f@lex.la>
References: <20260927235733.2619081-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the generic driver is bound by hand and the bind fails, the PHY is
left with polling in place of its interrupt. phy_probe() has already
replaced phydev->irq with PHY_POLL by then. The unwind does not go
through phy_detach(), so the restore there does not run, and a later
attach finds a PHY that can only be polled.

Found on a Keenetic KN-1012 while adding the restore in phy_detach(),
as the other way out of the same bind cycle.

Save the interrupt number on entry and put it back on the error path.
The bus table is not the right source here. The same label is reached
when a second attach of an already attached PHY fails, and there the
field is live. The table also misses a PHY_MAC_INTERRUPT that a MAC
wrote into phydev->irq.

Tested on the KN-1012 with a 6.18 distribution kernel and an injected
failure of the generic probe: phydev->irq reads 15 afterwards, and -1
with only the restore in phy_detach().

Fixes: 6d9f66ac7fec ("net: phy: Fix PHY module checks and NULL deref in phy_attach_direct()")
Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---

Notes:
    v12: shorter commit message, no code change.
    
    The Fixes: tag differs from patch 3 because 6d9f66ac7fec split this
    failure off the label that calls phy_detach(). The failure was injected
    with a debug-only module parameter, once for one MDIO address.

 drivers/net/phy/phy_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index a9c71a286118..8bfb154402ad 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1755,6 +1755,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	struct mii_bus *bus = phydev->mdio.bus;
 	struct device *d = &phydev->mdio.dev;
 	struct module *ndev_owner = NULL;
+	int irq = phydev->irq;
 	int err;
 
 	/* For Ethernet device drivers that register their own MDIO bus, we
@@ -1896,6 +1897,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 
 error_module_put:
 	module_put(d->driver->owner);
+	phydev->irq = irq;
 	phydev->is_genphy_driven = 0;
 	d->driver = NULL;
 error_put_device:
-- 
2.53.0

