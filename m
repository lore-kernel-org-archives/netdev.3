Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF9E3BA220
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 01:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789696251; cv=none; b=rZ7p6onfXus7q5gSD36LT395Lq0CvEzDc+0b2vHdtn0c3pjNQN3TFLfQ7Ixx/FoPSFyOoOefspeJQwGEydWL+AGB9Yw+VjiXIn5FT4ZWEzZQ8QBcsp2W+szBLB+oEUUJT74yqsHLu4ERFjV2RMg8wKd5gh9IrhbXCASn6pNvo6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789696251; c=relaxed/simple;
	bh=RVGN8hzTYET+YVR10seErUDioE6Go3OGl3hghfGt/to=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dR2Z+I3z/7ctE9a7m1fEu8yNlDsJy8FWuLE8QY8R+OweRU6L1gSh+53hU/+EqiFKVJQfYxYfXxJSnysoAlWXi2KbJfib67xN0jk1cI+5BZYss+u6RpSnrmsDMT+lOfsuwtHVCBfM4QgAR9DGX9ianbw/v2vj7t53tJQ9mQ12ztY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=Ap2oGuPE; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="Ap2oGuPE"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso2349085e9.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789696236; x=1790301036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q158t0WkzY9BaWR+kDYunaW5YNuuwcBnK9ppmpGR5hY=;
        b=Ap2oGuPEDn85SG9pzCZymxuQCjqZWsy2efRxuW5htb0U5TlG4rgLi7u0l8NfybLjHw
         g/fqXmsvk4vOaX8joaiFk1xPIQUV4gaF1kOCDZudfotfufIzehZnhKJdb3TmkykjUCU7
         M9s/AiI84wc+t9iE3ARVYnKwKHpHhv0IFCCkB/7uREG86IwKp3Yl9Z+u2viRYs2PKjsO
         jut3CcWGeRERCceKuEBd+gJ2G/nk1xZuiSrCEehqkl28TdgjzGJQF7AmoG1xhliggaCL
         GZt4x3y+njiF2JCy79lbNCrNSC4VeQtmvFEC44rdS3MsO1MPRF7Lu+vkPr5gy9PwV208
         qbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789696236; x=1790301036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q158t0WkzY9BaWR+kDYunaW5YNuuwcBnK9ppmpGR5hY=;
        b=e1FF+oKEKl2E05Gjq8Th3ckc4DTurt6H8JrEbusENpIUCmQ6/dlsdRNTPXJYjGFXC6
         zcLczxzzqSjkSqSB5HPpH/cC7X6kHkpCokO4iUTL0fZzqMFGtQ/QUw7Tc8/JTYRMOwdN
         7REjSvx2cAotbmjDOFs7nSinMgKv+G0gXUAQNC3lkwx1QUkMVD7Y2xTL1USp2fGBIfZ7
         v6tZy+pg3EDRh/OLTtlecQX2cepHhGBYPqPEV1gI4/UeygUZcsdkIHcUvXNlqLZK2I6Q
         LNa1aiCDTFrUYOjbtImUSPt0v1ACP9ZM6M/+wQBRGvUZQcRrgIblEDtOYC6ZjFRNDqpE
         xinw==
X-Gm-Message-State: AFuF++lvcJ9eg3S4IChwxH6FRvEeVBpj14COLQ9bH7BK5nIP9ZEsYCzO
	qh1ESW2a8NQhY0bv4bl1yrQR0HYNtIajPeRTru520Y0ELkzGLKPWageiI3SMEMtbgltIqNkeZvU
	dzhKlLeQuhJJv
X-Gm-Gg: AYBFou3ZckKX4McAtOKHiL03grPSlsnvD3bdfjaIoIuxbRP7MpOEJnWOzzaXhZykntU
	u7hdFV+gwYl/BTSjmPjexPSBJMNtEuTGa9sAp831tl30ORd76E897Jl2rkBDY6qINH8lk7VZinU
	UrmT+BgWBJZvDKXj6FxnrXLb3kEPSCDqpXeBeMpzjqysLocEO7+SEKUsPeJvZ/qqUnZ1fBygjzN
	ildkbWusuqVJKCZ0aHBYzp1juL1wasinRsV5idJuniAiCSPdC4+4yMJFCoEpGtsy2pycxX8h9qG
	kNhDBOdzb4AqckYjIEin2ijjdKanpGYhP2q2xhcXoIN7ME6JmRJD9O5662kprhvBnubaWl+POyG
	jhpXpLtFBZPfDiCagCBueKhBywhfiI/jTa9e0zuVyg/qWyfXbIeLbj9hbyYENgOL+GWy6s2OFWj
	L4RPqL9WBy6H2IqE2YFRs2ZCfpxzl4dCEPr7m0QLA0odI7NuH9YQ==
X-Received: by 2002:a05:600c:1c05:b0:49c:edfa:15a with SMTP id 5b1f17b1804b1-49fc56af038mr9801335e9.13.1789696236071;
        Thu, 17 Sep 2026 18:50:36 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-487200745b5sm64224f8f.26.2026.09.17.18.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 18:50:35 -0700 (PDT)
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
Subject: [PATCH net v8 3/4] net: phy: take the interrupt back from the bus on detach
Date: Fri, 18 Sep 2026 04:50:28 +0300
Message-ID: <20260918015029.2518425-4-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918015029.2518425-1-f@lex.la>
References: <20260918015029.2518425-1-f@lex.la>
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
its real driver takes over.

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

