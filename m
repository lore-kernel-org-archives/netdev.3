Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3CE3D6689
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 01:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789782826; cv=none; b=fXXfjfTa+rXw1J3J5SAgwQxZtRkan2JERtr5+yGGaIXNofDbTiaiPzPHGXRDSAXtFqEUTgAfIVNTzTCCUCMrd9aEzreiBvvktYtPzS9X5lEMjdOJgUNpu2IvgD5yklVODbRETvDEYrRT6pgMC23GP9QJPJGQHmHWoCHGoVQRscc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789782826; c=relaxed/simple;
	bh=Kwd86QxCmwGojb+ohNR3IdwUZ/EoERdirqUaFVO1hek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DGS4Os2htOfZZFS+BLxaLAfxQTkdZaRW3Vvhou1bO7ZxEcOI9ySw79YYGvbjICxVe2VDOwoJcn/hZPnuRfYqR8m8NtmN15MBcorjI5bL930N5G0WZImD3dCizX/aZ0o5WdCHF9LzsOcWC7dDL2L9v7BpMjo5gmVCzNrGp43OK5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=hCn1/4a4; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="hCn1/4a4"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f633cd80so629605f8f.2
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 18:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789782823; x=1790387623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fQ0KOJpw+7J3KKM2Wr5BjFb6P4F9AM9h/vTtc9m1Fsg=;
        b=hCn1/4a4AwK1r7zqOE6EjbFwg8HWASD6xcE80gQBpiaoQS9aTkuz9qYQZ8rRvBJNJZ
         hWD3z10O9FVOiZATGyY+MFQ8EhiC8hWsp8vK7GP7GUDzEPouRUInqKBK8eX52X7gY/eY
         x3h19ZngBE85cScZAxszGLBUSiZU2RJigk2kUCRGfWrVbP+X1AQB4CG8lJm3hb7E/zyB
         z1AmjOlHNmW8S+umJNIDGOUCqnlqTUlmF6188b1iIlSJmTFNlrUOJb6xU6sLuYaU3WvO
         Xek6ZgOYhKgRjxBmm6zlCBPJ3Qk2GE+Hrwem65gVrYO+bNzsSgyq1La6lHpH3+uDSIbY
         sRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789782823; x=1790387623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fQ0KOJpw+7J3KKM2Wr5BjFb6P4F9AM9h/vTtc9m1Fsg=;
        b=m3Ah5kAa4gkDFB0+jIpHSobihjm0+9RncBNBTZ35q19t/VV0gQL5X7kkvKHAhYhdz/
         gxhFKjtqwykixdzyB8LPFC+eGUZqxLm/HhLE4PSy8jAuWy6/kzduf276qBvRnX+0tNTj
         2DkZr8oypSvM7IlPpTA7H1z91uFHs7WpDdCGzdntz8a+4On3K5uxgEQWO/jz2dJ999bO
         y13Bc/2/EuZXbJUJ+qMCZZzMCz3vWdVXuDfemY9MAO5hOP9dWd+0CDVAfjRmNeWXOpf1
         2+CNbKIILYzUPqFWTpdNftKwaj+jPsLhV9XXo3Z4370n1trxGC9Aas8PVUQYIlm9GReg
         7Aog==
X-Gm-Message-State: AFuF++koyIKATGmhFsgRR1f/qBXWQA2ARNEUwWNV7aDA2FpuF/wKIO6H
	Z7tYFpeeMhe+3th8J6b8HY8/7UOJkX8ecMKGB9Tr3B6KuT6DgxfAbulaCkKUbyv7i/e8zb3tbgA
	smD1bmr6OW0di
X-Gm-Gg: AYBFou1r5rEL9lQ+ss+xbXdZ1NC0jQ2kR6CbsYOteMe9kIhTF/TIqGcIR1qG0dT0Dzr
	pqrrvqJjtodpnsDBnDstsvZwMj2v/hTFhKOMRyUev+uoR+b19AaVZYQV8R5bD6cDjleGUmFyT22
	onMkjEW7MqgopbfP8yJwMadAbKnuXNFPE5MR0wRY1EQ+vPEDh8YdaJezdiOgEE9kLYjrTpVYKfn
	2vzAwaR2r5wsP2yDgdlV8uh33+Ih23Wz2zv3eWviB4LM8XVSFhnwO6rDkZzT2zORHjSIkBo4IRF
	2fXexO74N3U7t+NeKYL+rq/7bSdMujWpMkgZYOP2WwLgOXk4D5n7ToYkM+xMuSPREKbsWOoqoCP
	hHfRsxRpTE1dg+KmkERcf9QhqiNhhYpt/NFgkTWbhtOqmteeoHEKI0Mjfc93NX9+y8tOwiFrFNc
	8WSwMosrPtpIsk5Hzeq0kQ1YaZgKr7uZFD4gUypM+g+DEAPYkyPg==
X-Received: by 2002:adf:e19a:0:b0:486:fba3:b95d with SMTP id ffacd0b85a97d-4871e2161fbmr6029399f8f.7.1789782822675;
        Fri, 18 Sep 2026 18:53:42 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724593f5asm2876366f8f.28.2026.09.18.18.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 18:53:42 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	maxime.chevallier@bootlin.com,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH net-next v2] net: phy: refuse to attach a PHY whose driver is being unbound
Date: Sat, 19 Sep 2026 04:53:40 +0300
Message-ID: <20260919015340.499675-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

phy_remove() clears phydev->drv as its last act; the driver core clears
d->driver only afterwards, in device_unbind_cleanup(). An attach entering
that window still sees d->driver, so it skips the genphy substitution and
then dereferences the NULL phydev->drv.

Unbinding a PHY driver under an attached consumer crashes in real life.
The board that showed it is an MT7981 whose copper PHY driver needs
firmware from the rootfs, so the driver arrives after DSA has attached
the PHY. I was testing how a port copes with that driver coming and
going, on an OpenWrt 6.18 kernel with the distro's backports, local
patches and the series under test. Racing a sysfs unbind against port
teardown and bring-up oopsed twice: once in the state machine, and once
inside a live phy_attach_direct() where phy_init_hw() had already
entered the driver's config_init(). The second came after a
one-line NULL check at the state-machine site let the run continue, with
nothing added to widen the window. Both have this root. Neither is this
dereference: in one the driver went away under a port close, in the other
mid-attach, and in neither was phydev->drv already NULL when an attach
started. That window is the narrow member of the family, and reaching it on
demand needed a 200 ms msleep() at the end of phy_remove().

Refuse the attach rather than let it complete on a driverless PHY, with
-EBUSY, which this function already returns when the PHY is attached
elsewhere. Without phylink the netdev would come up on a PHY that never ran
config_init. Under phylink it does not get that far: phylink_bringup_phy()
dereferences phy->drv->name as soon as the attach returns.

The mid-attach case needs serialisation rather than a NULL test.
phy_init_hw() tests phydev->drv once on entry and then dereferences it
several more times, and it calls the driver's own config_init(), which is
where one of those oopses landed, on a dereference made by driver code that
no test in phylib can reach. The device lock is not available either:
phy_attach_direct() runs under rtnl from ndo_open, while phy_remove() runs
under the device lock and calls sfp_bus_del_upstream(), which takes rtnl
for a PHY with an SFP bus.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---

Notes:
    v1: https://lore.kernel.org/netdev/20260914204200.2743251-1-f@lex.la/
    
    v2:
    - Said in the commit message where this was seen. The site in
      phy_attach_direct() was found by reading the unbind path, but the race it
      belongs to was not theoretical: it took the same board down twice with no
      instrumentation in the kernel, while a sysfs unbind of the PHY driver was
      raced against port teardown and bring-up. v1 opened with "found by
      reading, not from a crash report", which was true of the site and
      misleading about the race; that line is gone. The second of those two
      came after the state-machine site had been given a local NULL test so the
      run could continue, so the kernel that produced it carried that one extra
      check; nothing was added to widen the window in either. The traces were
      read at the time and the dumps were not preserved.
    - Tree and Fixes: tag follow Maxime Chevallier's reading of how reachable
      this is in practice:
      https://lore.kernel.org/netdev/6e82dc04-a68d-4c54-a6f0-a13c04fa2eef@bootlin.com/
      https://lore.kernel.org/netdev/65b2eff4-6818-4cfa-a0e7-d48729e0cd9e@bootlin.com/
      and the answer that separates the two windows:
      https://lore.kernel.org/netdev/20260917210406.1651902-1-f@lex.la/
    - Kept the guard instead of making phy_drv_supports_irq() NULL-tolerant. A
      NULL test there moves the fault to the caller rather than removing it:
      phylink_bringup_phy() dereferences phy->drv->name as soon as the attach
      returns. phylink is inconsistent about this on its own:
      phylink_sfp_connect_phy() refuses a PHY with no driver and
      phylink_bringup_phy() does not, which is an argument for the check living
      in phylib, where every caller gets it.
    - The module reference charged on d->driver->owner by phy_attach_direct()
      and released by phy_detach() re-reading the same field is mispaired
      whenever that field has moved in between: the put is skipped if the
      driver is still unbound at detach time, and goes to a module that was
      never charged if a different driver was bound meanwhile. An unbind
      followed by a rebind of the same driver balances, which is why an
      ordinary cycle shows nothing. Separate defect, separate patch.
    
    Verified on a Netcraze NC-1012 (MT7981) running OpenWrt 6.18.44, with a
    200 ms msleep() added at the end of phy_remove() to hold the window open.
    Two images off one tree, identical except for this patch.
    
    Without the patch, backgrounding
    
      echo mdio-bus:00 > "/sys/bus/mdio_bus/drivers/MediaTek MT7981 PHY/unbind"
    
    and immediately running "ip link set wan up" faults:
    
      Unable to handle kernel access to user memory outside uaccess routines
      at virtual address 0000000000000128
      CPU: 1 PID: 4487 Comm: ip
      pc : phy_attach_direct+0x150/0x380
      x0 : 0000000000000000
      Call trace:
       phy_attach_direct+0x150/0x380 (P)
       phylink_fwnode_phy_connect+0x198/0x27c
       phylink_of_phy_connect+0x18/0x20
       mtk_open+0x38/0xb70
      Kernel panic - not syncing: Oops: Fatal exception
    
    0x128 is the offset of config_intr in struct phy_driver in this build,
    read out of the disassembly of phy_attach_direct(): the inlined
    phy_drv_supports_irq() is "ldr x1, [x0, #296]" followed by
    "ldr x0, [x0, #304]". This board has panic_on_oops set, so the kernel
    panicked and rebooted, and that erased the test log (the run script still
    wrote to /tmp for this image; it was moved to /root before the patched
    run). How many attempts it took was therefore not preserved, and the trace
    above is what pstore kept.
    
    With the patch the same sequence fails the attach on the first attempt
    instead, with no oops: "ip: SIOCSIFFLAGS: Resource busy" from the ioctl,
    and "wan: mtk_open: could not attach PHY: -16" in the log.
    Binding the driver back and bringing the interface up afterwards links, so
    the refusal leaves the phydev reusable. An ordinary bring-up still attaches
    the driver, and with the driver left unbound the genphy substitution still
    runs:
    "PHY [mdio-bus:00] driver [Generic PHY] (irq=POLL)", link up at 1Gbps.

 drivers/net/phy/phy_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 41d1b20cde2c..f13c9d7fd47f 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1908,6 +1908,10 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 			d->driver = &genphy_driver.mdiodrv.driver;
 
 		phydev->is_genphy_driven = 1;
+	} else if (!phydev->drv) {
+		/* d->driver outlives phydev->drv on unbind, precedes it on bind */
+		err = -EBUSY;
+		goto error_put_device;
 	}
 
 	if (!try_module_get(d->driver->owner)) {
-- 
2.53.0

