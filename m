Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CA94A0134
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 20:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418526; cv=none; b=iQhuX2E0qDJosjuklnNF/LNE3lOs/KzJHnafrYP8xgUrIM3nYn8ZZgVu2LVXwhe9S+gzJGKOBUWlUpKXrmt8RYqGLFjaPHt+I/F27MIlz3hsXdwZmeMSUW9HnUY4uPHQeIAYWCoGlo3EfGmMIntVchhtgDjVYaBv7a9sHsJr4II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418526; c=relaxed/simple;
	bh=q/gYZaKPHkpl+flr9yB4ZcLhD4w9vAlah4ZGjxaGfEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PAZ/Kjf6tL/cwO2B1BiGkWw8df6U9pnKpk5IohJdYoL/QYcIx6bRJ7fnduiaLngqa9Gzs6kgFoS/k+f7K99xK4pVAVXPxs2tE2ee+XzD0B3zcLqZkpIjS4xbn0DdZzfJPAZoblzn00/P29B7KFlt1XU5HO1OiRia3ESaquE46H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=MyNa18DR; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="MyNa18DR"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7d2bb404so1638425e9.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 13:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789418523; x=1790023323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YIgW9/qxzwAGmM0KAqA0Ke4KQST+4RHZujJdgneRY1A=;
        b=MyNa18DRkrWPHi55lCVSE/4T9O9QgqtwgS0+t/eBMVT+eujyuzdlBcHAbnxp6IONU8
         QJMwWyjW2qsXlzneAGr8kUr/5rAj0SudwFyslTFQXwgn2atq9Gl4CyjF9sKhOihagrBy
         uCPO/6g7plinb4yFAFIKVOS01Ebx7kR9zmuKLkvjKwTRAMeTGWKUmevjZxc8dBdgMQ6K
         ai1+kICA9bUAUh2Eqs5x2KEFh4/89xEl25Q93au8Z7+klRlgvj0RoxX5NfRZ0ss9K5Xu
         zufpML7Y6puYL6ne3I4DcXFKEp1Q0IE3vfBwIYSnqFKuHY8s6WfZeDGOD9UKxvGAkodq
         mJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789418523; x=1790023323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YIgW9/qxzwAGmM0KAqA0Ke4KQST+4RHZujJdgneRY1A=;
        b=CGUQDxyNyXVfIMmXZzSgduAgsDN4nHqHRuUHf8syzNKcOXbBUiHx9/NSrEC8ypBSik
         hzzoof1//DRupQFJ+SIkpW9Xz/diAvx4Rjf6WXJprAjDVQR7JCNNDEn9I1QpTEFx6FLi
         /QAhpZBggm+dMFrohSUiK5kpjTimQ8oKeTf1cvpJIQpRsnfFUzm+PM106i2DSoK7Rj1F
         1EW9IdsLBca0t7W/CBq6k5+xgX3g06gBLIYxA4Oj8YttRaH34f9g4r13mmYpPqVKVMhI
         OYdPTafggV8bJ/QDcLvUc5bFdT0eXNvERBazP8jeTjWR1PdaowwMv9JUYEW2IS7II/HU
         LWBQ==
X-Gm-Message-State: AFuF++ml1DDH2iYzRXKR7m6/DKpzmpLoZfGvtTKFjs9BTLtMfwc93nWJ
	42Tuuse7p88J6jDnim7BOvt12HShn0gMfL8q8DVpV1llsx1yUbxlQkl5zvMBxLzn+9OBYTlDgpy
	ewkWddcc6GPPBijE=
X-Gm-Gg: AYBFou13CQr2csBnzVokEPdjDe6ZectEhx84QHHy2eGBDug1YToMolxSVx0WjpV8G7F
	9U16hvGlAZm9k2RHnWIuwHkSaHpu+wZSj2B6Tk/Jhwi3jy0CaAe55rub9zCT7to4nmMIlHUw66L
	E1I4cu4bh1rm3fD6IW78+M/+X0YU3cfvXC5gfzEnTvwOC23RREt95RtqsqD9nlmPP0MmNK6Kour
	ZDXM2Q1CKjKWvPu4zmsJhqT6hXUPgtgWF+fmQx5Madh0sabf/KFnMVujZJ/pbloScfUXrwYcug4
	AxolBRttiX3hkIL47tw3HavJyKjNDXYUOp8G9EHXDPKDty+KM0eI13sO8xSjOKnCDt19ww+JzJe
	y0QPkDkcgg7KzM0BO5DNRbw5RPOxof7a9jhhUZv+dkSKDKtQJ5PB4ULlPz6GOr1XT/3mKY5hFsM
	lpXF81caoMF2Jx5bBuI72xNMQpqaGNgUAQUSRflEfxCgq7rzteJg==
X-Received: by 2002:a05:600c:4f92:b0:49e:63cc:6324 with SMTP id 5b1f17b1804b1-49e7d72afb1mr15300375e9.6.1789418522652;
        Mon, 14 Sep 2026 13:42:02 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d6a8d5asm14769785e9.9.2026.09.14.13.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 13:42:02 -0700 (PDT)
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
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH net] net: phy: reject attach while the PHY driver is in transition
Date: Mon, 14 Sep 2026 23:42:00 +0300
Message-ID: <20260914204200.2743251-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

phy_remove() clears phydev->drv as its last act; the driver core
clears d->driver only afterwards, in device_unbind_cleanup(). In that
window phy_attach_direct() skips the genphy substitution, because
d->driver is still set, and then dereferences the NULL phydev->drv in
phy_drv_supports_irq().

Refuse the attach there, before any reference on the driver is taken.
The function holds no lock over phydev->drv, and it cannot hold
device_lock across the attach: for a genphy-substituted PHY its error
path reaches device_release_driver() on the same device, which takes
that lock again. So this closes the case where the unbind is already
in flight; an unbind starting mid-attach still races.

Failing beats falling back to polling: phylink_bringup_phy()
dereferences phy->drv right after a successful attach, and a continued
attach would already hold the driver module reference that
phy_detach() drops only while d->driver is set, leaking it once the
unbind completes. -ENODEV is wrong: DSA takes it as permission to
look for the PHY on the switch's internal MDIO bus.

Fixes: 61c81872815f ("net: phy: phy_device: Prevent nullptr exceptions on ISR")
Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---

Notes:
    Found by reading the unbind path, not from a crash report: phy_remove()
    clears phydev->drv before the driver core clears d->driver, while
    phy_attach_direct() keys its genphy substitution off d->driver.
    
    Verified on an MT7981 board (mtk_eth_soc GMAC, "MediaTek MT7981 PHY" at
    mdio-bus:00), 6.18.44, with a 200 ms msleep() added at the end of
    phy_remove() to hold the window open. Two images, identical except for
    this patch.
    
    Without the patch, backgrounding
    
      echo mdio-bus:00 > "/sys/bus/mdio_bus/drivers/MediaTek MT7981 PHY/unbind"
    
    and immediately running "ip link set wan up" oopses on the first
    attempt:
    
      Unable to handle kernel access to user memory outside uaccess
      routines at virtual address 0000000000000128
      pc : phy_attach_direct+0x150/0x380
      Call trace:
       phy_attach_direct+0x150/0x380 (P)
       mtk_open+0x38/0xb70
    
    x0 is 0 and 0x128 is the offset of config_intr in struct phy_driver.
    
    With the patch the same sequence fails the attach on the first attempt
    instead, "wan: mtk_open: could not attach PHY: -16", and no oops is
    logged. Binding the driver back and bringing the interface up afterwards
    succeeds with the link up, so the early return leaves the phydev
    reusable. An ordinary bring-up is unaffected, and with the driver left
    unbound the genphy substitution still runs: "PHY [mdio-bus:00] driver
    [Generic PHY]", link up.

 drivers/net/phy/phy_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 94b2e85e00a3..044cefd9840b 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1781,6 +1781,10 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
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

