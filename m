Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3283CF1E4
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 01:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789782821; cv=none; b=Sa8s+DAVwrjpB6B951V+4kVdylCdXLNOd0txVOXsqSPoyCFGag4Yl6wG7ni66NO+zL1djLoodM0mJ20QrCDahweCu2oeft0hOHb9diAvRkLWnwSfSrjWqfX9wDIT/1Gg21snpfSoJbzw+RdPeKviCgCmaVChn4oNn9hr0aeGmec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789782821; c=relaxed/simple;
	bh=1MUo6msyKenS0dWvYuknGgwmuW377WbdJ69neD15ZCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKaNl13kwG6EBEaGW9W3BbgHWcNJSvKugrVkZuY+HzqWaurvU1+KqGfRlMK2OOK2gPIyKSdEq6kENtoutA2oQWncqYNqpUHJKtuWmYiXtQN4cM/Jl0qsCa2N682zt2BzqMv6M8McAD7pN1omRLrVKRcb2OSysGKmyLPVB32gEZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=SXp1oKcv; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="SXp1oKcv"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485b1d2874fso455790f8f.0
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 18:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789782818; x=1790387618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JdLvCX4aiOKaXzIHUg6bWtBloXG3W7s/ZOZQz8VEaW0=;
        b=SXp1oKcv/GvA0OrvUO9LZDaPpdlB0MrQKdPy15GTVNgzCZIdqQA+aKRkCEIEmKT+ja
         Wt2q1aCQfBGu4R/WXhvj1JpB4iIVFrAOcgsAVrx6sW3FdQzsUH5+5S0qWZYQt3fIMEyF
         CAOejkljq94lMc2FeCh6OnAEtrtZbqo3FbmS3U5rCre3YhUYMjY4G59/G2LLtokdVecP
         uLIuFD0VU68R/vkx3XPsAAzAH24R5KUWsulfd5PZgAozkPqGQiCEXuNiIJwHNvPYBTza
         QPQLFSs4V85Q3n8EZRwp0U49oc0b+opkXBwA7YpsgX1BDzyG61ZCaBMDfcjDwLf/B2jC
         DkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789782818; x=1790387618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JdLvCX4aiOKaXzIHUg6bWtBloXG3W7s/ZOZQz8VEaW0=;
        b=GasKAvU0jWrBmLZ2gXtWgRYH8ZtQ2PBc2EI7DYwOUCYiXawKIffi/AOgRgJeBExHcd
         0MFZTxYUUS8zqzMGsinwC7tMdzlgu26U0OfdbCQb/vzBY79b+zwhQdnXmOlF1BZBeTaL
         ok3amD1MhM1M4ipBLqo5spOO755RG7aquHXh03pObIRoEL8oRmW68Xcvru+jQhqFmF4O
         Ol5ODz7g77ddXAEqKa4uqYmdkbRgOvxuk58JnoR7yhOg2Gmkb65GHtpOswMjhDRCmLza
         GUjRLDqYvm7bdAT0LQW5Os4bmPAroHgLRnd3bskcYZqRtmX5qKF08iQBB+HKI/Tw1NbD
         vzFQ==
X-Gm-Message-State: AFuF++nXJOmHuvKrTBSKQ/MDHlyMQNbsmv1JT9R2B1Q6W9/lscIYQwOZ
	Yhste2PehCk+2haEs4LDNUt7z8ZKjllRhGFt79kHCjT4GBujYAmQImAn6ykNpsq083FQvx4Nhls
	iM8tHCDVu3/V6
X-Gm-Gg: AYBFou3+ooYkI7z3AHqqdwbXXIu49FzFfPQ2zCiX4eJP8v/gibbj2pt/BOn6rYbTi6N
	eH2FSSWkHeVyT8qV2Z6tumYGfc7iaKcNGjKpacfrzMA7yORVf1KnLEGvGjlr+1Jm3MAZKWSCSFX
	i5y37t/i9p9NPHXI+t+69aBXrgzfmFXH4M9cneXvjX3I/wvg0+lutn2Jcm4zbcNWyl1/VFajsI/
	0eGRAEyp5BFJllGSTVEiD10cMkXCc9EGXU8e3+KA3cfPd2/0hGlvKWmdDmx2MWThW2hv3Ex/SuT
	UmYXm8nJEA06mcU6zLRN8viO1CRjcSLGHWY7hpXfDjTd4r1aJNDtlxs2nfSRDKalimX531jgrgM
	01QUnG3Ks4EDazNEDwrNQqjKtuj/kln8+8eaDYPzbTTWZnke/LWSPS1Q07ssDJEB0HXHKFzvzjs
	rb98gxAvgktTWwbxDeNc84Nkhu2HH1Days/p/1zoqfEQYOjDm++ew=
X-Received: by 2002:a05:600c:468a:b0:49e:7c8c:bc77 with SMTP id 5b1f17b1804b1-49fc4fae7acmr65654585e9.7.1789782818316;
        Fri, 18 Sep 2026 18:53:38 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd10d174sm34946045e9.11.2026.09.18.18.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 18:53:37 -0700 (PDT)
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
Subject: [PATCH net v9 4/4] net: phy: restore the interrupt when the generic bind cycle fails
Date: Sat, 19 Sep 2026 04:53:26 +0300
Message-ID: <20260919015326.499479-5-f@lex.la>
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

phy_attach_direct() binds the generic driver by hand, and the probe it
calls is phy_probe(), which replaces phydev->irq with PHY_POLL before
either of the points it can fail at. That failure unwinds on a label of
its own, which does not go through phy_detach(), so the substitution
outlives a bind cycle that never completed and a later attach finds a
PHY that can only be polled. Found while placing the restore of the
previous patch, as the other exit of the same bind cycle.

Take the number back on that label as well, before it clears d->driver.
That store is what reopens the device to the driver core: until it runs,
a driver registering on another CPU is turned away with -EBUSY and
phy_probe() cannot be the second writer of this field.

Fixes: 6d9f66ac7fec ("net: phy: Fix PHY module checks and NULL deref in phy_attach_direct()")
Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---

Notes:
    Both points the hand-bind can fail at are reachable. phy_probe() reaches
    genphy_read_abilities() through genphy_driver's .get_features, and that
    returns the error from phy_read(phydev, MII_BMSR); device_bind_driver()
    returns whatever driver_sysfs_add() got from sysfs_create_link().
    
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
index 8e6b399f95d6..69d8911ea7f6 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1896,6 +1896,8 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 
 error_module_put:
 	module_put(d->driver->owner);
+	/* Before the NULL below, which lets another probe reach this field. */
+	phydev->irq = bus->irq[phydev->mdio.addr];
 	phydev->is_genphy_driven = 0;
 	d->driver = NULL;
 error_put_device:
-- 
2.53.0

