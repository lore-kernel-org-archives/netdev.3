Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD6E566C5C
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083212; cv=none; b=RiGnWnIfAi+35jWJV4BQtpJl4NWSLBHoMvKnj2Q/MhaoqJUb1/zts+VwP4b1p6yp9BQj9DwYN3gYzBhHYknJc3fd4ZULq8s2q4lkFmTZHpNLjcuxXE6U+E6iqK7vQ2cETS796+fz9W28WoZ0LneQu/RpRJz4ZKbRdfbtF3NZdms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083212; c=relaxed/simple;
	bh=cjPhgMl06Gz4v8vlPzDnw8UWAHAvj1+3h2RWkeYhBNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dr2iJ0lHdB+edPKFQhmREozPKeWOqRFF/RJQsOOnIG5bgQZXI9bc9eW6a+e/uxTKFUMOiXywtmr7bPabILrK6JscKEby15JlPuU8m95Z6n1Y3fePIb7IOPdblrd1LhERt/LSTnvbGE/oSnH3icm9WXlYg9E81wVrgmNPxtc9j7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=lQZM1P8z; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="lQZM1P8z"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccf3ca626so21554385e9.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 06:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1790083207; x=1790688007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S2+N1IorirZjTQOoiJkqviwvBkdqoi6Ht3FnwQDKUlk=;
        b=lQZM1P8zL9NkQ3eDkCXkNCLyr7zr8b7b5lA5BG9jnBAckSezhgtQ+oHsLk599TbMqv
         R6KkTviMw2LC+DHOchlh/DbvhyNgF0fHiiKComW6+DwPJiHnA20t5SkmsxxDh/SIQQZW
         qauI0UGxe53kR7TvHnR1icEPj2nB7ufspzhfnFomP6BwTMEZISPPNerWU065Lw3Qd8bE
         a06R3zSxwr+I8nPISfp+ThhZXU7hB24dJp6q6WK1Mq4EOHlRHIEalwUbw+u7qMwBuaOq
         D7fyGYv37PqeRyWehrSulswsBol7IpLSznZZ2KX34gkKKIP4+sWV2sYKLCncsO63/rG9
         Fn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790083207; x=1790688007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S2+N1IorirZjTQOoiJkqviwvBkdqoi6Ht3FnwQDKUlk=;
        b=OZ2AanyaukJOModeKTfsZAZrYH2HlJrPlPEpq+QMXfH7OSXmkFbVpnFAAH5Bcv8nWS
         31cchWkiLE94tuVN6w77QX6xBxMi6riSyIlMO6xBEjPM/ZSboYCb/7/DdC2gkrBn1AU7
         emAmyoJ6dJO4xAs6mQt18CzP4ohuA6P4pv4CGdUg5oIO3kQiHJx6eB205SBWyUpQ0LXs
         uy2ZaXiNAeZqvF7fdVH28gw4l1RTVT7VTk5qqxpuf6wKz3zSH/286QtmYSc2ypiHjNxu
         t0ouetXybaA5VyIl9l2b+Wj4tPPxA1C9MuaqOgZ1nG98HtyXZTp6AKOzYi7KBoIPVt0u
         ZTaQ==
X-Gm-Message-State: AFuF++nloJZDX+yG58Y0UzIZWYb7nKkh4L13QEYcIe0ADLPhKSv2MQ1z
	Orxrhsk9c1eZsxbL6Z7Gr9Jc9Nv45qeZzpebYrDvZ40wUTiVrwkt0gJ+OU3a9CtOXE/APvrMX9H
	vBn5FpqoffMnH
X-Gm-Gg: AYBFou2gxICXuRzA+P8qB28frIVYxOSL3bA8GKU+DdGUwjEPHkGWn+alupGGMXcZmTj
	p5iD2L+celCEZShgEdJp9RxKGhy7vwobDz1FoDCZzP01ibY0juXCONne/YV6ayIU7za8HZ+HPYB
	vOox8Hl0ISZo3tC3GCR/ZtPR24LUX/jygAT2uwQj5NuniUvyv08p/I8Tytk5rzTD/zEB44VGxdi
	eQ00fxa8BMAEsKOcjzef2NkuvqeIxfGzusQlhfhTZFOwELTeCq3S7eijV0JrHWtRGTbSjGcnuui
	boGeyzT5X6HtzK6xRO6/faNAkDqe6XBhCgzXXwqCvFC4mOTFHgd2w5S1llk56vMCMx73osWPxgC
	Z2JURpxDg0sFCVSeF54bDZH6xoDWMUeuE+JwKDdiKv6PbxNtKvokejbxV0BgOHaVydxod/m2XGV
	krWw0HAqXF4xqzHO9Ma6i7AuTEWrwzeDbT9F721MaMk0FMumaTWCg=
X-Received: by 2002:a05:600c:35c9:b0:49f:bcce:13f5 with SMTP id 5b1f17b1804b1-49fc5736229mr230926025e9.24.1790083207537;
        Tue, 22 Sep 2026 06:20:07 -0700 (PDT)
Received: from remote-01 ([84.17.55.230])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488627929a4sm4085220f8f.35.2026.09.22.06.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 06:20:06 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	olteanv@gmail.com,
	Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com,
	steve.glendinning@shawell.net,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH net v10 4/4] net: phy: restore the interrupt when the generic bind cycle fails
Date: Tue, 22 Sep 2026 16:19:55 +0300
Message-ID: <20260922131955.4175785-5-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922131955.4175785-1-f@lex.la>
References: <20260922131955.4175785-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

phy_attach_direct() binds the generic driver by hand, and the probe it
calls is phy_probe(), which replaces phydev->irq with PHY_POLL before
either of the points it can fail at. That failure unwinds on a label of
its own, which does not go through phy_detach(), so the substitution
outlives a bind cycle that never completed and a later attach finds a
PHY that can only be polled. Found while placing the restore of the
previous patch, as the other exit of the same bind cycle.

Take the number back on that label as well, before it clears d->driver.
That store is what reopens the device to the driver core: until it runs,
the core turns a probe away with -EBUSY. That is ordering, not
exclusion - this bind and its unwind run without the device lock
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
    phydev->irq afterwards reads -1 with patch 3 alone and 15 with this one.
    
    One difference between the injector and a real failure, since it does not
    affect what was measured but should not be implied away: a genuine error
    inside phy_probe() leaves through its out: label, which re-asserts the PHY
    reset before returning, while the injector returns earlier than that.
    Neither path touches phydev->irq.

 drivers/net/phy/phy_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index a9c71a286118..06161a73fe3f 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1896,6 +1896,8 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 
 error_module_put:
 	module_put(d->driver->owner);
+	/* The NULL below lets phy_probe() write this field. */
+	phydev->irq = bus->irq[phydev->mdio.addr];
 	phydev->is_genphy_driven = 0;
 	d->driver = NULL;
 error_put_device:
-- 
2.53.0

