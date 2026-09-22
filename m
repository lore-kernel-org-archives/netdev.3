Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9D85592FF
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083211; cv=none; b=KhXyZGrBoxkPu89WYkuppM5vFjmhXBhPeutLevxvhk24aBjptBBHtUJLVWrUZjajld8EaauF14su4+WEONdVXHmYZcRNpCVqEU2cNYW+4gP50PHZggCCjZjsglElWy1JI20pHWAz6XI2vhysLddVRtJkfdmSAwjgPVHJiEF67uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083211; c=relaxed/simple;
	bh=76YuJDk/ToPumJbJj0kPrNX6C79HKPGffU2gQ88Qo8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oL3+PwqZS9WwPl+336D83DoabI+GSre0jAFJ5mu4gFcFBrJzdwu7qM1+iqNbeiY1g8EQd2pNCZbt+8OkRcQo4YHVjn4tFHeJY8CO/kFTiqLK2sebiEJw1bf2il1Cc0x1aiSAEu2dg3VCIDS+/OAXRLFcTAdSYQsgo4fF6E+bGB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=bLPsGv0m; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="bLPsGv0m"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f633cd78so2303827f8f.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 06:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1790083206; x=1790688006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/r9/s40OVqaWQoJJX5HKzXk1f8k5fiwKzjrgvKjOXIM=;
        b=bLPsGv0m8/GRIIE5SaVs2tHKyuAFngSSrqiv/uHUzI7w2LIix900J1zEmsJgJcF7Zg
         bSRc126PidblmnfmsaIEzulQciwpCdd8Y6NwDQXR60MYAwyanROxJYvCKbtMG3CMjlti
         wR3eFbjy5O8X5MYo/oYq8y1/35Tb057tyNeThFYBme51HyiJsRe2A/A7OgXXjWYmE0sb
         XYz737W4+k0Z2gWV7T/EMrGJKQQH6ptuaZhJi8DnucHqyv48bItCXBFnfI6dpM2ZyvXd
         25aLGja7t3t7ZutgFA5gO3K6Gaw6cj8nuPIonyotIW33/VL8jSjPXClatYxrkKML0k3L
         kepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790083206; x=1790688006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/r9/s40OVqaWQoJJX5HKzXk1f8k5fiwKzjrgvKjOXIM=;
        b=PJMfK9jqm7sLQdHBQQqPtNFLGWblhiTsc4DGcnqQMobOXXzjEKxMuXXuMwzs2I/lFT
         ua+NjcEDQxDymA9naK4sZlBRQmFdcwIS6cdUtlU0+6mCaQ0IlUIBLcaJlbJNknQW/PSh
         K3zY4LikRSd73vS8iXHRbyJc4LX0sEO/3J2e7dheR98MWT/LsiQZzaOB3b8Eta9T2eQl
         Qm1/u8Dx9xs12w62Ddr68QttB1jJ0vxKiwlB4U8yOvcGWD8EDuEASVJes3oZwUcZNeGZ
         yRLcZGiVFyZ/gWBAY5D7pQIiGO/q4j8sC4k/eh3Ltd7V3H8bsH6M4l1mMPW6yKkwmh6x
         mzZw==
X-Gm-Message-State: AFuF++nGdFdRXqDr7LSYf4IX0ZF5TufaSZ1zmvn0CmFkzXR1knjvUcZl
	iKDVHqDV4sccdE+GfNc29mEabhELTQjrAKzXcjPgSvUKayDEpa1s+HoVKdguwGjNC81JTtsobRP
	DTIVwo9tRRUpx
X-Gm-Gg: AYBFou0+WbnmudseQlke3MZjYIXpGPVz+5HHkcWmDVfwI/qSBmHVllpckMe3oNCfwvM
	c1J5OPQYb/ANKLSOpF9kNa5PviEthMS3f1cFnEhm4xaMPKyf3zxPH5ViwUPBi3S1N/dfSRx7sqI
	0BnS3IJAaAo2ObMDuBaz8z/aXxMRfcQMDTD0e+Bhq7QgRPSb1pJYRXCT4Y1azUB5FsAJDPXBtHT
	M8sE53pm4s8p9Yha033e7/ktGMWS1k7Cn9kq+ILif1jI1qeKj+EbVq6Eg8cwAGcpeKbFFXooO25
	xWHKmRd5795FJHsPYy+PAvQrq+6uzGPBhADZSXffth+Cci+psGo7E7q0DGzIy6uNgsZEHtKewa0
	L8G6e2M67Gz4F8B4CJlQoPqxHK8sTEGUEXqO98mbpMQqDpP2s3S8tmQBLMBvWV/hYzkHBOL4YuG
	tpesJwhIFIeUPsK6hWrGWOjVAjJZG7pX78LhmVhZjJBUbtuun0vQ==
X-Received: by 2002:a05:6000:2c06:b0:486:f767:8be0 with SMTP id ffacd0b85a97d-4871e216279mr21356887f8f.12.1790083205807;
        Tue, 22 Sep 2026 06:20:05 -0700 (PDT)
Received: from remote-01 ([84.17.55.230])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488627929a4sm4085220f8f.35.2026.09.22.06.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 06:20:05 -0700 (PDT)
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
Subject: [PATCH net v10 3/4] net: phy: take the interrupt back from the bus on detach
Date: Tue, 22 Sep 2026 16:19:54 +0300
Message-ID: <20260922131955.4175785-4-f@lex.la>
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
described the interrupt still holds it. Only under is_genphy_driven,
since that is the substitution being undone: elsewhere the field belongs
to whoever wrote it, a MAC installing PHY_MAC_INTERRUPT writes
phydev->irq alone, and a phy_request_interrupt() that failed leaves
PHY_POLL there while the bus table still holds the number that could not
be requested.

Do it before device_release_driver() rather than after. That call
returns with the mdio device bindable and the device lock dropped, so
from then on a phy_probe() on another CPU is the other writer of this
field. Until it runs the generic driver is still bound and the driver
core turns a probe away with -EBUSY. That is ordering, not exclusion:
nothing on this side holds the device lock.

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
    
    The reading predates the is_genphy_driven guard the store now sits under,
    which should not be implied away. On the measured path the flag is set:
    phylink_connect_phy() calls phy_detach() from its own failure check, and
    the three writes of that flag are all in phy_device.c, none of them between
    the hand-bind and that call. So the guard passes and the store is the one
    the reading came from. Its other side, a detach with a real driver bound,
    was not measured.

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

