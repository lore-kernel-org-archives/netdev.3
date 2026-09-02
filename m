Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35FF3AAF40
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 08:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788336323; cv=none; b=Lsq0F0SmL2oER+Y3aljULFAa3WeFP6N7O91t8MlhgsNCtdhZXHEMWnUWZr+akfmLHOjkH5RlKVhlzQWNHDPY9k9JQH3OS7Pc54axF/ijS17IxV6a4B3fy6zPWVRENGP+pm5DCQc4M0H10B0ipQEVbCZcxBD+ZwtnFnqoJ0opCww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788336323; c=relaxed/simple;
	bh=DSw3fF8JCXJsrODnA5Sf7B/l1fiB4DL8P+nRczSYmBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJWGFzC79RfYjNUwaER52vGxT9AWkez5Cv+UGf6L+nlsKRmmvMwKYuSiN98HMEDm4koyfP8yKbhPiO76/UKXGamjXa7jYavxeK/6Cq8OhjbOpAcfeY7Xfq/LEjpfvB9HcaMVG9B+EwI5TRhUxCmFh9f1eD7pOyMx4ZO6NQg20o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=XahpOPH5; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="XahpOPH5"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a623987d32so1178425a12.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 01:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788336320; x=1788941120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YZ3n+xsQFOMjsGDSR8smrMMtR28URII33oxO3DV0Sgs=;
        b=XahpOPH58dgUjxtM5Q+GvnBHRfTi4k/j89Z42Tbyb6mZm4bHmyY0J08adXp1NbjtTI
         RwFELbSuOHMMiupN0kGe4pjg+6J7Gb7KvumpU/5Bt18whlE+pdze4s1PON+CQn6WiBRn
         He1LMk3P9S1dUfSnyn0zChWY4sT82gUOhvrn1kQ4IDAT9ShWurvH63C26T/t3jLUC8dl
         jVjCL5XgXYxdMggcys5XgpLJdPP3szEhcI9zvUSzcPnCcZWDt8l3ujLnEnQEeAu6mLgc
         Oye7i6fj4tzspSNxMjB+zSIP2ZkKQHICF2d2HK52JoCB+dGLRLvgcvOCjOyPZrlzD4U5
         Bb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788336320; x=1788941120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YZ3n+xsQFOMjsGDSR8smrMMtR28URII33oxO3DV0Sgs=;
        b=lkKN9802L2EPp7E4rqricOnwpD21hwksmF5nvtvKwGNuboGmULvciGNJpsRpfeVkKe
         PFyLUEa9XktJ9+Yk2A4b04xFKsdLJgndLSJ3BCMPyEs6DRaZXDVd4zg72hwdOqO4zqam
         9tW9CQw2zQg+R0dahffkIpgWN1SjKEol63Cq0GbK3DthLsu6Elp3WEa9fYaKJz3YfNub
         uOwnsX8KzaJLKE6dB2uRwl0LTWduslgGqQoeqI5U2+Og7shUAlvQEQpjLuYlo+hqC9Jl
         plNFSvRPAD5dXBasqYTReZXvLWeG83hxpPUjC77lXjVG8jtLZNenAdX2goeq7iygtl/5
         doIw==
X-Forwarded-Encrypted: i=1; AKwUvBwChXA3TCG3NxEayb2a4drCMU6UM02+cqVqKnrh5ulWmzwhn4VyuUpBtnQlT43VUgy8PxTUyIA=@vger.kernel.org
X-Gm-Message-State: AFuF++mEK9hjm3j1I2RMhuj/s+TxkAjHTgOLEdzcR3FjLF0oywx5KUag
	j4/txVb5MO4MtYiHVe087sBSDamUbb43dqmmQwCjbh2AjQ2tUVJZ90DQ8QICanHIMEg=
X-Gm-Gg: AYBFou369P9B1T7B1mpBr4m2sE/GEuL+zliPvhRddPML0qJRBj/jjk3QCjLOzTyBXe1
	Fx2LtcI7iJ9spHRwCjBih4F2xqgGAQ9Mb90eG/w3+EwTctf/zZ+qqKDuCBPudZiKcHzJjxEXL13
	tg+VNnIhygT32iv+xySjPBQzX2/EoIpI9Qcl+YhXOBb3NIL15QUhOK4t5C2KB0jTTsyCHcMGEF3
	cbqqtSfRtJK7oGfFIQU8SLCvr1xcxSTwA3Fjwi5qCSNNz7khAvlAayYrqObqNfj3JdNjspdaKV9
	kMdkUy+H3NII09WoU2bqhWbRfBp55iYHldGpPwtFLFmqQK+/SSdrzbD3RYO5zG3iQm58In/8+HZ
	upIO5cdHPXKIcYoIyRmqsFtNgchOI/OR4Qlag9an7aAeGyYqLAUWXVBRuna1xZCESRfiJYeY1KR
	MwPs39MQUWAB5Hi5UtQd5gP5Ju9QNFFE5Tt3LtaMNFTBp7k1W4sA==
X-Received: by 2002:a05:6402:4382:b0:6a5:d7e0:626f with SMTP id 4fb4d7f45d1cf-6a68257aec8mr2037574a12.6.1788336319421;
        Wed, 02 Sep 2026 01:05:19 -0700 (PDT)
Received: from remote-01 ([84.17.55.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e72df2sm5089494f8f.1.2026.09.02.01.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 01:05:19 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk
Cc: olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4 2/2] net: phy: restore the interrupt after a generic-driver bind cycle
Date: Wed,  2 Sep 2026 08:05:11 +0000
Message-ID: <20260902080511.2211261-3-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902080511.2211261-1-f@lex.la>
References: <20260902080511.2211261-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A PHY with no specific driver available at attach time gets the generic
one, and phy_probe() sets phydev->irq to PHY_POLL because that driver
has no interrupt callbacks. Neither end of that bind cycle puts the
value back: phy_detach() releases the generic driver so a real one can
bind later, and a generic probe that fails never reaches phy_detach()
at all.

The specific driver that binds afterwards therefore starts with
irq == PHY_POLL, and the PHY is polled for the rest of the uptime with
no warning on that path. A DSA switch that connects its user ports
before the rootfs holding the PHY driver module is mounted hits this on
every boot.

mdiobus_alloc() fills bus->irq[] with PHY_POLL for every address, and
the bind cycle never writes to that table, so the entry still holds
whatever the bus registered there. Restore phydev->irq from it on both
exits, and only where the cycle left PHY_POLL. That guard preserves an
interrupt mode a MAC installed on the attached PHY after connect, and
it keeps a restored interrupt number out of the
phy_connect_direct()/phy_disconnect() asymmetry, where such a MAC would
have the interrupt requested and never freed.

Fixes: 00db8189d984 ("This patch adds a PHY Abstraction Layer to the Linux Kernel, enabling ethernet drivers to remain as ignorant as is reasonable of the connected PHY's design and operation details.")
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
Both exits matter: phy_detach() for a generic driver that bound and is
being released, and phy_attach_direct()'s error_module_put label for a
generic probe that failed, which never calls phy_detach().

Which buses and MAC drivers the bus interrupt table covers, which other
paths to PHY_POLL the guard also restores and why none of them is
harmed, and the sysfs unbind case this does not cover, are worked
through under v2:
https://lore.kernel.org/netdev/20260824024029.41310-3-f@lex.la/

v4: reword the phy_restore_genphy_irq() comment; no code change.

 drivers/net/phy/phy_device.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 94b2e85e00a3..20fc29355f60 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1734,6 +1734,17 @@ static bool phy_drv_supports_irq(const struct phy_driver *phydrv)
 	return phydrv->config_intr && phydrv->handle_interrupt;
 }
 
+/* Undo the PHY_POLL that phy_probe() sets when a driver without
+ * interrupt callbacks binds. The bind cycle never writes bus->irq[],
+ * so the table still holds the pre-bind value; anything else the PHY
+ * carries did not come from the bind and must stand.
+ */
+static void phy_restore_genphy_irq(struct phy_device *phydev)
+{
+	if (phydev->irq == PHY_POLL)
+		phydev->irq = phydev->mdio.bus->irq[phydev->mdio.addr];
+}
+
 /**
  * phy_attach_direct - attach a network device to a given PHY device pointer
  * @dev: network device to attach
@@ -1896,6 +1907,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 
 error_module_put:
 	module_put(d->driver->owner);
+	phy_restore_genphy_irq(phydev);
 	phydev->is_genphy_driven = 0;
 	d->driver = NULL;
 error_put_device:
@@ -1965,6 +1977,7 @@ void phy_detach(struct phy_device *phydev)
 	 * real driver could be loaded
 	 */
 	if (phydev->is_genphy_driven) {
+		phy_restore_genphy_irq(phydev);
 		device_release_driver(&phydev->mdio.dev);
 		phydev->is_genphy_driven = 0;
 	}
-- 
2.53.0

