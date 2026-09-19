Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ABE3C3F66
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 01:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789782820; cv=none; b=EBJcqnbqET/CmzC04hSCtW9A4Sjx+e6aXCFRaMQw8aLdNWuNJKwlc8OvAey62NKg3hUyZCF6ivp1XfEN8z/6Yd7EcodKubXnFTmQtob37xEJuHS7c9vYw4z21QJAR68Bu8zrPwDGfmKmLGBrhhDEoQEnrQ5Fz7wWeJj6tSZlr0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789782820; c=relaxed/simple;
	bh=bKkyFJ1yzN8EIrppYx08ccrFLzsPd7/nZiMuo/fLRMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ufkdzgTleidyEEam+7O+xemOhAmXFrBtF+P+iQuPGP9QFbe+91lB/lgPzz2XpWs5P6B5839Ko2bWWjTvvlK48PGWFeI/h/PEUweznXmYig+fNhGA6+QEAuQwAgLUrwHxOVIuj8bQFgoyXgkjd1oZLL0whvNnjn++GdL0kiZNQJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=cV/xfSTn; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="cV/xfSTn"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e721b5503so12826985e9.0
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 18:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789782816; x=1790387616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PfHZ/AoXKF/KOmYN/7MFhXWdVj/hGARzYnvpEULCntI=;
        b=cV/xfSTnERGffjk6iai3XPV6B8rczuWW4C7btfC7vWzfec06JG5DELYllJD07C1yR1
         nPruYuIMvoZoodreIJU5QIL1cCdrWC9up7VIvqKPzB2voFhb7621+lfoG8c+3F+o8kH+
         CpH6CKpma8zt28Ml9DBQN7BPgxDA0GVkZWVrR4YRfSVuA+fKu022kb9uv0Jh92iJXypH
         2IIvOWcBOd1RDyyMBp6q8ztdX8gg5YI1CzTs3pcHxv4q0RtWwt24uT+pwfq9J+8Qmsik
         zAqhumV85DAtoGjXFb6EocBIiSDY/XIFwtndRXI8Td6JMigkzgCMsPYaRwYGC6ZiCNH9
         6Vog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789782816; x=1790387616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PfHZ/AoXKF/KOmYN/7MFhXWdVj/hGARzYnvpEULCntI=;
        b=kO0onU1hGYDeDJQitfoJkfPbbpZwouwdKmi877Snu7LrNUG2lFOQ0VzJPXnNjdXKd0
         BgGvw6kUdF3bkQ7n5Wa0YYxXmI4nX1MgcfGRkR60SRzCOwl6rpWyo+8/Tr94csJFs9GB
         ETAjMViFiq7LutnPqjtE55VusvDIFJj/gCJyZtqkle6fjbkOdWGQoJfe8oQFRFBtqa3I
         ZaP2Z6cf+5kWcm/EjzKwHWi45GJKJOsjUYJpWP2wqrQLh5DN0H3Dj+K0RWvGAb0i1K+F
         LXRsmVxy8LTxaipnuu4Qc6rnj0yHbylMtMAOfA2pYiV4J+IM9aY/k7yB8AQKwO4ieg89
         tZNQ==
X-Gm-Message-State: AFuF++m7cPicRS5cXUzVaaScnrPBBmn1UR+rm3z9qCg7rvxoc0Sdh8V5
	8irhVPxcxy9QKiUuMdVSNErtsHCqsh0C1jt1ZClQFWb45tsQ1corwIecmdLGLA6eqp+xJxHixZE
	6GMLEYDp3DThE
X-Gm-Gg: AYBFou0UKnMM5iEoUMKGkjv0Pa5/NLD3/y8HOCJ8b5ahZQFSPkvWDZK9C7RCQnVpeOa
	GWxRmWMdbXI0eamdP8z/VLniimY9Dqn4e1ot9fuXR0J+B4ac8oZO4FpxubfRAKlX5qhbGZT03nw
	Mh8V7sNCyCBRmy9eNgqK5lZoVwzSfiK1rfMEvHYJ+Vwf5t8weLSgfFSG7tdWUCuLY3Tmo3hOPhe
	JBtJG//Yf+tfaCpjarXICkaCLIYyMneRrt1J1lTJV39Xr36R908xFf02vP5ldTOux0DBzHMSa5t
	eetbfnTF5zICE5wcxxJi5uDhiEEirdnQOXTXiU+b7SscKkTTD5QIboI3rdEGXLZQYBXaMwe7npu
	zLjhfD4rv/wmNYgWMhlGtOssg4+EYdkmdfJfrgwOjYaGiiFdp7V82jMi/UtKZakxzo4e4V9txXw
	Hdv17NE3ITWJ5+l7RDt0wmT7k7UzXEHUX1iUudmHP++MR9BvVQPQ==
X-Received: by 2002:a05:600c:138c:b0:49e:799a:8969 with SMTP id 5b1f17b1804b1-49fc574af20mr54848755e9.30.1789782816461;
        Fri, 18 Sep 2026 18:53:36 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd10d174sm34946045e9.11.2026.09.18.18.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 18:53:35 -0700 (PDT)
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
Subject: [PATCH net v9 3/4] net: phy: take the interrupt back from the bus on detach
Date: Sat, 19 Sep 2026 04:53:25 +0300
Message-ID: <20260919015326.499479-4-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260919015326.499479-1-f@lex.la>
References: <20260919015326.499479-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A PHY whose own driver is a module on a filesystem that is not mounted
when the MAC probes gets the generic driver first. phy_probe() replaces
phydev->irq with PHY_POLL because that driver has no interrupt support,
nothing puts it back, and the PHY polls for the rest of the uptime once
its real driver takes over. That is where an MT7981B board here
stands, with an Airoha EN8811H behind an MT7531 port and its driver on
the root filesystem: the devicetree gives the PHY interrupt 15, and
once the real driver has taken over the field reads -1.

Take the number back in phy_detach(), from mdiobus->irq[], which is
where phy_device_create() seeded phydev->irq from and where the bus that
described the interrupt still holds it.

Do it before device_release_driver() rather than after. That call
returns with the mdio device bindable and the device lock dropped, so
from then on a phy_probe() on another CPU is the other writer of this
field. Ahead of it the generic driver is still bound, and a driver
registering meanwhile is turned away with -EBUSY before it can reach
phy_probe().

Fixes: 00db8189d984 ("This patch adds a PHY Abstraction Layer to the Linux Kernel, enabling ethernet drivers to remain as ignorant as is reasonable of the connected PHY's design and operation details.")
Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---

Notes:
    Found and measured on an MT7981B board with an MT7531 switch and an Airoha
    EN8811H behind lan4, whose interrupt the devicetree describes and whose
    driver is a module.
    
    The one condition arranged for the run is that the PHY driver module loads
    after the root filesystem rather than from the early boot list this
    distribution normally puts it in. The distribution's own late-PHY handling
    was also removed, that being the one patch which could have changed the
    outcome; upstream has nothing like it. The kernel is still a distribution
    one and its remaining patches to phylink and phy_device do run on these
    paths - none of them writes phydev->irq.
    
    DSA then sets the port up at 1.87 s, the generic driver is bound by hand,
    phy_probe() replaces the interrupt with PHY_POLL, and phylink rejects
    2500base-x against it:
    
      lan4 (uninitialized): validation of 2500base-x ... failed: -EINVAL
      lan4 (uninitialized): failed to connect to PHY: -EINVAL
    
    The real driver arrives between 13.4 and 13.6 s depending on the boot, and
    binds. phydev->irq then reads -1 without this patch and 15 with it, 15
    being what the devicetree gave that PHY. The three switch ports alongside
    read 79, 80 and 81 in both runs, so the reading distinguishes rather than
    printing one answer. The field has no sysfs attribute of its own, so it was
    read with a debug-only module parameter that walks the MDIO bus and prints
    it.

 drivers/net/phy/phy_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 94b2e85e00a3..8e6b399f95d6 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1959,6 +1959,9 @@ void phy_detach(struct phy_device *phydev)
 	if (phydev->mdio.dev.driver)
 		module_put(phydev->mdio.dev.driver->owner);
 
+	/* The release below can hand this field to a probe on another CPU. */
+	phydev->irq = phydev->mdio.bus->irq[phydev->mdio.addr];
+
 	/* If the device had no specific driver before (i.e. - it
 	 * was using the generic driver), we unbind the device
 	 * from the generic driver so that there's a chance a
-- 
2.53.0

