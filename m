Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F103AE1A9
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 23:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790466638; cv=none; b=IsiHxOld3nNjILu+Vz6sUpq1wzpvXHfdX+ZLhB42wtIRQduBWdLMaBQnysCZZd+BoI21XEy4LDdJIm5yMgSLudDAGSLAhnlrrnU4Dm8YWDS0OaLxE98qnzif/GilwGJrPV8ORuUAqOQkfaIQXTwnj3a8BAR+2AbM0Zyis1UG2bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790466638; c=relaxed/simple;
	bh=GzDeizBzGcEi8xagvrQSxzo2FYbvToZbiw2KyXtZxqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcvv3IzwGi0Jz/qstlUOrABTWn/BAf4M6Iwn1nwxcptSoIwQO7gLawbH6+iFMLKtR+f5DsOI7SwTCc3uvJJihvpkRodnd7qNp9d6ANgQZG6lRurfnxHGyB3ikzzy8YC/2FD3gXOF/NJjGd5suttH938qg5+XmknvAENittX84ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=M4UYMhVV; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="M4UYMhVV"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843f22dcb8so1508091f8f.0
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 16:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1790466635; x=1791071435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UHLZDdeDMLON340+obgFzmYl4OH/VhpP5DQvl0yAjuk=;
        b=M4UYMhVVhMqCn3y22jF7mdrQPDD2JcWwCVKYy34rkkh719PF7lJJ+iqEhn17kVuNkN
         vwLdaKzpaPyoEe1hqIdWdtfUROXE/JmJ2mC11w4Fg7ThM6661lHxnqHs4bslpkD0/Qg2
         v+XkBR3P3Cv3Wl1BV5Zy9SxVfW8qfemy76BeVrlXCXDV9eLdzulQpG9+QuKqvmMaqzSD
         esQqKGbNHu42LKsI6ON01u7RLuRScSOup48ubQoOui7VByScqy6X8S86AuOLw7xFRjlz
         5YvbMC5lvqvCIR6JQ+/kI4dLd4Cfu4Mew2ifc4/pAdpUERaAvrJSFi5RHZtrLfjrnQrg
         sKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790466635; x=1791071435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UHLZDdeDMLON340+obgFzmYl4OH/VhpP5DQvl0yAjuk=;
        b=tCkJAOgngGqaXABbSbKnx4yaKl7liS6/ucKOCnvJf51HiWvahfB6XBM1JcIIfIDbqi
         rxLiUnZ4h34Oy/ND2Uh+RQdhqTZkz5q5kUtwN4+EHpVvl4KONb+mTnt4ocnDX/bixyLa
         J/kHgG1PR3GTlQVoSMII0LQXebmA94mLGG4m6iw2Uk/+U2mTY5MLbVBfcLv/urlxYGtv
         kXBv3UT5hDZ5zzHjARED7eCMNKQkjc37BppIg9Gf9PCV6db0m4IbV+n7qvgXS+XZz+F+
         lPy6H9DZYdaEZ4Stnx7y6bUL7vyyt/GYy9aH5Of/Ujt5/a3oG1OT5oF3+6tpOTCqyV5U
         D44A==
X-Gm-Message-State: AFq9FYLspT1zCwcFaihyjJzTTJaGxMpR8qZ78vfSjIXyDurVeB0IGClY
	3p7aJOS6YhbwuzVy6yJjttz6mFvX/QMsQRaZUSSAGf0UfNJ0EVQsbjPf2WBY/M9f7PVFZ1bU60F
	Z5YCv4lLDEQ==
X-Gm-Gg: AYBFou0D6PhDqZczOY5KimsqsEL9z6uRMUZsLFDvW6I8vwKE2JcRBdKzLNnrpS2UtP/
	SYCt6opvvP7/blPlNxbeyYr7MirrsO5Ff5qFWpEM4jIuk+ijiLtNTy5NamPzS0KUQ+72nqHd5NV
	CdJnCgVdIgcxz8s4yiv8jc4lm1otSJyEF+o3CfGSLbrSGzDinbck/FLLsSXIDKLf34lIYHJWYRn
	Re3XyiNbhp6xOuXFh0JpzFxF5Xr5JjdB4/KTKap9gBZmf8JS37O27mg1Qc0ovPHCAU7jvByw6vr
	jf4UsDlhGXR4bs2HIOysgAvu/bkgpuNG/5Gi+Vi7FYAEXMJJAjaEde73igBwaHV6UlIbexfpLmo
	hsskdsfBetqITp7Lm62Aj55VgYVjp3J4+IH+qpXrhduKCIJYE3kpeWGlHEMQNAT/A8O7NNdsPTt
	OnP4kzrtR12ReFpJxi0MRXx3r0xVOEIXNUtQObXHE/OJfGKjcOc2o=
X-Received: by 2002:a5d:6f10:0:b0:488:8ab9:f73e with SMTP id ffacd0b85a97d-4888ab9f86bmr2301097f8f.24.1790466634769;
        Sat, 26 Sep 2026 16:50:34 -0700 (PDT)
Received: from remote-01 ([84.17.55.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349fa1sm24716798f8f.8.2026.09.26.16.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 16:50:34 -0700 (PDT)
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
Subject: [PATCH net v11 3/4] net: phy: take the interrupt back from the bus on detach
Date: Sun, 27 Sep 2026 02:50:23 +0300
Message-ID: <20260926235024.705646-4-f@lex.la>
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

A PHY whose own driver is a module on a filesystem that is not mounted
when the MAC probes gets the generic driver first. phy_probe() replaces
phydev->irq with PHY_POLL because that driver has no interrupt support,
nothing puts it back, and the PHY polls for the rest of the uptime once
its real driver takes over. That is where a Keenetic KN-1012 stands,
with an Airoha EN8811H behind an MT7531 port and its driver on the root
filesystem: the devicetree interrupt of the PHY maps to irq 15, and once
the real driver has taken over the field reads -1.

Take the number back in phy_detach(), from mdiobus->irq[], which is
where phy_device_create() seeded phydev->irq from and where the bus that
described the interrupt still holds it. Only under is_genphy_driven,
since that is the substitution being undone: elsewhere the field belongs
to whoever wrote it, a MAC installing PHY_MAC_INTERRUPT writes
phydev->irq alone, and a phy_request_interrupt() that failed leaves
PHY_POLL there while the bus table still holds the number that could not
be requested. Under the generic driver a PHY_MAC_INTERRUPT written into
phydev->irq alone is still replaced; bcmasp, genet and tsnep, the MACs
that write it that way, write it again after each connect.

Do it before device_release_driver() rather than after. That call
returns with the mdio device bindable and the device lock dropped, so
from then on a phy_probe() on another CPU is the other writer of this
field; before it, the generic driver is bound and the driver core turns
such a probe away with -EBUSY. That is ordering, not exclusion: nothing
on this side holds the device lock. Nor does the ordering hold after a
sysfs unbind of the generic driver under a consumer, which leaves
is_genphy_driven set with no driver bound, so the store can race or
follow the probe of a driver that binds meanwhile. The next
phy_attach_direct() applies the substitution again for whichever driver
it finds bound, so the number its callers request still matches that
driver.

Fixes: 00db8189d984 ("This patch adds a PHY Abstraction Layer to the Linux Kernel, enabling ethernet drivers to remain as ignorant as is reasonable of the connected PHY's design and operation details.")
Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---

Notes:
    Found and measured on a Keenetic KN-1012 (MT7981B, MT7531 switch) with an
    Airoha EN8811H behind lan4, whose interrupt the devicetree describes and
    whose driver is a module.
    
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
    
    The reading predates the is_genphy_driven guard the store now sits
    under, which should not be implied away. On the measured path the flag
    is set: phylink_fwnode_phy_connect(), which DSA reaches through
    phylink_of_phy_connect() for this port, calls phy_detach() from its own
    failure check, and the three writes of that flag are all in
    phy_device.c, none of them between the hand-bind and that call. So the
    guard passes and the store is the one the reading came from. Its other
    side, a detach with a real driver bound, was not measured.

 drivers/net/phy/phy_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 94b2e85e00a3..a9c71a286118 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1965,6 +1965,8 @@ void phy_detach(struct phy_device *phydev)
 	 * real driver could be loaded
 	 */
 	if (phydev->is_genphy_driven) {
+		/* The release below lets phy_probe() write this field. */
+		phydev->irq = phydev->mdio.bus->irq[phydev->mdio.addr];
 		device_release_driver(&phydev->mdio.dev);
 		phydev->is_genphy_driven = 0;
 	}
-- 
2.53.0

