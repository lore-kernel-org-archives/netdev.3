Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50173822A1
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 23:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790466639; cv=none; b=iPC9d7JpX7SjlKxqz2TwljrC9t+YJbkHmvFKoVrQeB0kEizPbFMn6GDPUZMgFlAmomtWVPz/mCClFyIKaEOmH5AQnvKo4QYI0tMSKaakpR9sMcLsh1Qa9hnLCYu4FAE7DLaXLcdo/w8k7itzYiWyh8xYabkFRqTovrveogCggno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790466639; c=relaxed/simple;
	bh=yu+FWbTBNR4w3RS3h+ePS0wkYH+4aMC72bViihdyVlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAZpOQodqc0RrZSKdaBXvNrhcWB2rZ/6KC++FHmkH2Lt4CHKEiLXzqkMRe2N31exoyQ6EmhNdaiM2nHIv29djtBzMlEL2bPfQQMlX+1MmUiBA0QTvLybq99yutN16lvsyLXMQNAkp0pd/Oa49JtB6n0HRefG2hTW0sJZs9eYj1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=aEvtgBgM; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="aEvtgBgM"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48870973bddso845565f8f.1
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 16:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1790466636; x=1791071436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r1yHDWljL5Sb6p6flxG/OoWaxJ52niTk3EaC1lnbd/c=;
        b=aEvtgBgMiGOO3eGeaf0hZyh+eKAFrkNzilKVawgMB4xMvRBG9xpfIWUf74s6tqxKrV
         SCuurymfJjAAiea2KG+lJc0YwRpf/aoGPUu4KvXn1/pRmZmJaSDRKoSnTL92q+Yd+/e8
         7pfI88nSFaMaUH3VHYm5wanoYohm//fvjwsj1xjHlm3C+owo8tpZtzOlAg9t439ZUysD
         nKbY29RLP8xjD88WIG8dzhNblnQ63k5f+JVy3mdE0UDq7oqD4divoNPSX1CRa1muwA9w
         YNhrLEkd0A73E1bvM6RSAVJv5KgkyfdoiNk3OrRf/2beUa/1dhK51MAPCi1vAfbav8IF
         K/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790466636; x=1791071436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r1yHDWljL5Sb6p6flxG/OoWaxJ52niTk3EaC1lnbd/c=;
        b=SoEGvwISowA7BNHqdiDfIwM9DfZK35TGSYHaUepsVFzQPI9gCHKb53HcdnMFz2BVq2
         1h3zLTDZwQNqxi/nfyQqsGI/Kt8F83s+33FzM5kRqgf7QEmV6z7mUpUI+DcpQz4Orbmf
         GuniuypzYBlXJrEnOUyjiLF+DcizNCwvpv7xew9xDgkWKIG/KRl7cpAIgfBi2hK56vxj
         XdYI7sCNjAHKqWqN6WSpn39BCGzyJ8Rh9T0CLnIVPjr3AVcURCsfxqmOFHxFuYnLNwv6
         zWFjdPR15PC7C1h05gi10VvPUCL67KrH1zpLGuJM5IyDrpuFNWlwtFa3vibj0ZXl/kb9
         ZJ7g==
X-Gm-Message-State: AFq9FYK3CNFmhrVd19cSS5xeLolsKywUkHJcOiRHaPglNiVDS+KfCSbo
	L9Hh/idEPQSgfdlvEbxSYpVNi+PdxNb5sLivote6LPm9XL1mHtjrC10KDWbl6Hbis989/cXXvUs
	qZ4Ol35aBsg==
X-Gm-Gg: AYBFou10JLLWuv9V5VisBcYJ5DWY1ZzSDw2IMpfXwu9tr56YwOGVtx0DDqgTROMbfca
	dYzdHI8bzN1/3n9Pgb9VGSHGHNX1G9dIvfhDQlEFhWKWVff8DENZxGRSNFivQWhlVHTtHHoSLEY
	Fql5WZMSTJzK14sm8KwjPiKEPIuF3WqYUB2ZT2Kp/OuAzMXSo/j1FLLBXP2txfelWvCQXDjN5kM
	+6wKA4EgDO8P3xCDOOLF0sUXVrvSmXGRON0oD7jCVerJq2LneUfHzY8HyHxyavh356w9gMgn+PX
	hkFUmb/0dRb6KPxkeZ0iardvLnuANG4CkVoGbAV6ZBsfVScN/aPehnJZqtWRJGKV07KwdeF27GN
	L6nS7osN1vbNTBH7BtcsR0wAkS5ntxTPuUv6P1pEEFs+QEVV26uWAv6qA13ch4c4j9OHmjDRuM6
	7GBA/kmzPowBXESsElkhfTP2cQh2nFvFOrBHcS4mickmu5l4l5Ew==
X-Received: by 2002:a05:6000:2585:b0:488:8074:ef57 with SMTP id ffacd0b85a97d-4888074f0d9mr11291257f8f.3.1790466636166;
        Sat, 26 Sep 2026 16:50:36 -0700 (PDT)
Received: from remote-01 ([84.17.55.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349fa1sm24716798f8f.8.2026.09.26.16.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 16:50:35 -0700 (PDT)
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
Subject: [PATCH net v11 4/4] net: phy: restore the interrupt when the generic bind cycle fails
Date: Sun, 27 Sep 2026 02:50:24 +0300
Message-ID: <20260926235024.705646-5-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926235024.705646-1-f@lex.la>
References: <20260926235024.705646-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

phy_attach_direct() binds the generic driver by hand, and the probe it
calls is phy_probe(), which replaces phydev->irq with PHY_POLL before
either point the hand-bind can fail at. That failure unwinds on a label
of its own, which does not go through phy_detach(), so the substitution
outlives a bind cycle that never completed and a later attach finds a
PHY that can only be polled. Found on a Keenetic KN-1012 while placing
the restore of the previous patch, as the other exit of the same bind
cycle.

Save phydev->irq on entry and put it back on that label. The unwind runs
inside the call that made the substitution, so the value from before it
is known exactly. The bus table the previous patch reads from would be
wrong here twice over: it does not hold a PHY_MAC_INTERRUPT that a MAC
wrote into phydev->irq alone, and the label is also reached when a
second attach of an attached PHY fails its bind, where the field is
live.

The store is not ordered against a concurrent bind: this unwind, like
the hand-bind it undoes, runs without the device lock that
device_bind_driver() asks its callers to hold.

Fixes: 6d9f66ac7fec ("net: phy: Fix PHY module checks and NULL deref in phy_attach_direct()")
Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---

Notes:
    Both points the hand-bind can fail at are reachable. phy_probe() reaches
    genphy_read_abilities() through genphy_driver's .get_features, and that
    returns the error from phy_read(phydev, MII_BMSR); device_bind_driver()
    returns whatever driver_sysfs_add() got, from either of its two
    sysfs_create_link() calls or from the coredump attribute.
    
    A failed genphy bind leaves the device with no driver bound at all, so the
    next driver to arrive binds directly and never goes through phy_detach().
    That is why patch 3 cannot cover this path, and why the Fixes: tag here is
    6d9f66ac7fec rather than the one patch 3 carries. That commit did not
    introduce the lost number - the substitution is far older - it created this
    second exit from the bind cycle, splitting the failure off the label that
    calls phy_detach(). Before it, patch 3 alone would have covered this, so
    that is where the backport range for this one starts.
    
    Exercised on the board described in patch 3, with a debug-only module
    parameter that fails the hand-bound generic probe once for one MDIO
    address. The connect then ends in -EIO rather than the -EINVAL of the
    validation path, so the unwind takes the label this patch touches.
    Measured again for this version, since the value now comes from the
    local: two images of the distribution's 6.18.52 kernel differing only
    by this patch, injected failure at 2.0 s, real driver bound at 6.4 s.
    phydev->irq afterwards reads -1 with patch 3 alone and 15 with this
    one; the three switch ports read 79, 80 and 81 in both.
    
    One difference between the injector and a real failure, since it does not
    affect what was measured but should not be implied away: a genuine error
    inside phy_probe() leaves through its out: label, which re-asserts the PHY
    reset before returning, while the injector returns earlier than that.
    Neither path touches phydev->irq.

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

