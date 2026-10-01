Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A012F50EBFD
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859774; cv=none; b=qY2Ges+1YcuzW07mywJ4Fo2bp4U9UVjAhM2xia89FeEc57MRRTJc2pzZBvcAw5/Pon1nQL41KcvdA335FTo7u7tYsWpj2t9sOmtpprRV9VJqYbJ2mZagDJvhbnV/SYCwHT9glhZtNrWxlrYegXelwm3x5xHj+oGa5LmsKQUFEj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859774; c=relaxed/simple;
	bh=1seQhCsG4zTNv0vt7jmouxLcXiY3KVURT6FwgrKhTWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQX+l2ChxEAL0XYDe6/xLXSe7Nd/ksWYcypDu3Hu8VEV6oKDMs48BKnmHnWr9kVwpgIg9IEj09AXjxVcqBq/Lz3K0zuyXad6gUj/37G/N+eixxLCYCI/JFvn7kVtGi3tmin80g/ruzfiMmKHbkQemMVwvNwHkNj4Bh9zWIsnHOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=Yi7pR69b; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="Yi7pR69b"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d822dso48147275e9.2
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 06:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1790859771; x=1791464571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1xKReKDjBhMU66Cilkw+V7uGPo4uWsfjAVCm4Sm3gd0=;
        b=Yi7pR69bSHhaf7F+0ED3BLO8Obo+ScHZCSD2uiChDrRVwI8Umm7nvrRp5DRgE/TW79
         eCzpBMe3SiPNkvJ1Anbbtb3B7wo8jWA+uOtogre1zjf94HImEFIzqSbhB5qmocNsi8uO
         eaB4XowaGTDd2VcQS9YBoBgRx8AJH61v56qESzqPxrcTj/hznQyfaWHtH1dLcbn4gre3
         IcHg2tyEhA0jmpusOVQQJYl59KJ877EPpP+v40/RXV6dRG2KLOVtFg00bN5Lz7UQTY6/
         jVpnY2Imwp82N9GMg7djKRtcLXPXDrEl1tzI3G6Bs75epBgN/hcEVmwV7B1W6VjxSAEO
         X5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790859771; x=1791464571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1xKReKDjBhMU66Cilkw+V7uGPo4uWsfjAVCm4Sm3gd0=;
        b=Ryb600rDgk0FAQwdr+WurTAUc9ZpdTvCEUutPgTD8CpmMw2DtCrIS5zAMZkn3rxbg2
         gy/yCUbjVprPds4bXUOGLK0Cn3uNcWkG6rf/vjq3de4LqJCWNKXTDsOJccl/6WDGlXto
         MzkXE3Tb/HXj5lLzPaNoyFceeN7092dfL+CA1214Lxp8A3dctzLLGsJ2Z+NafVtCf9Dx
         MbaNcKCshMs+9htqU9p7SbBO6wuugPxhhUpAOtvMz2ifge2lTTh8Zno6cdopzxYT7ZgB
         TfCcoG22xQpBk/30KWwoBWRbH0tcNubesJTLU6llnYqf9rJ8tXMrP+EtBJs6S03QwQPM
         AHtQ==
X-Gm-Message-State: AFuF++lpnn90tlTA7NxMLjTzYUTjg25c0xIVIytdJBpt/5E0ECwY1D1I
	JCJGGl0u1fst/P+mnVKvlR+ZEzsmxdQQEHHrp1EUC8huQfgKeyTDi6ShUEMyVBSzuXHhJSCDTeB
	fBblHd3XLjwpzFGs=
X-Gm-Gg: AYBFou33N4Yoj7Ws0X1/BvLOQTMjv67n1j6rtea6lke+zULbIPcQX47fAN4Fj039e5K
	KY/Km1PQHYJiLNx3FxS2Kdhix3dewEIpjT5er64LI+sSJBwZPRgKe5iuXIwTbngWCi+tGrsOz76
	U0hVyvq4jl+fLpGQtkTApmZhPtYGFvwjrt/6wk3uafZLh/DpBYrDoujoEVZKMMS44yeiGdbfwDc
	Z1voNSCHFiupg85zA/JdG6naZRp21Sv/+pKOCK+0zlMw4/Nwg2JtdA+Zih/Fq0WoVumu9mxjhlE
	KDo7UXgEPyuad0Hn1ZSc4sd2K5wvr84Aa6J4XnDFvhtR1S4TYDMwx2Z8HENRw8t3QQGjD5H/k40
	RONzZuVTU3pqMGMLVsIZlqO0OHQ2OwpJMoA6sy2Sssgu/3CBDjRwqCDE5wtN1lCKA1VyafSI9Wf
	HG5eNh5JIs5I8CH9hUYA+kakbDR/tK6NGnQ9JmPAZCXLIk4j9hCg==
X-Received: by 2002:a05:600c:638d:b0:4a0:21b9:a55c with SMTP id 5b1f17b1804b1-4a021b9a5f4mr37206285e9.29.1790859769574;
        Thu, 01 Oct 2026 06:02:49 -0700 (PDT)
Received: from remote-01 ([84.17.55.224])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f913ecesm48051775e9.2.2026.10.01.06.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 06:02:48 -0700 (PDT)
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
Subject: [PATCH net v13 4/4] net: phy: restore the interrupt when the generic bind cycle fails
Date: Thu,  1 Oct 2026 16:02:36 +0300
Message-ID: <20261001130236.106059-5-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001130236.106059-1-f@lex.la>
References: <20261001130236.106059-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When phy_attach_direct() binds the generic driver itself and the bind
fails, the PHY is left with polling in place of its interrupt.
phy_probe() has already replaced phydev->irq with PHY_POLL by then. The
unwind does not go through phy_detach(), so the restore there does not
run, and a later attach finds a PHY that can only be polled.

Found on a Keenetic KN-1012 while adding the restore in phy_detach(),
as the other way out of the same bind cycle.

Save the interrupt number on entry and put it back on the error path.
The bus table is not the right source here. The same label is reached
when a second attach of a PHY already attached through the generic
driver fails, and there the field is live. The table also misses a
PHY_MAC_INTERRUPT that a MAC wrote into phydev->irq.

Tested on the KN-1012 with a 6.18 distribution kernel and an injected
failure of the generic probe: phydev->irq reads 15 afterwards, and -1
with only the restore in phy_detach().

Fixes: 6d9f66ac7fec ("net: phy: Fix PHY module checks and NULL deref in phy_attach_direct()")
Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---

Notes:
    v13: the commit message says who binds the generic driver, and which
    second attach reaches the label. No code change.
    
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

