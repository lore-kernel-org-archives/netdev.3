Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387E93FC5DD
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859695; cv=none; b=qYCDbf6hvs15izAbMqqEUFQspGFxgT+0n+yXofSNFKFCybyYwbSKn3cGbKWeFX3L8wMgqXNxuuFOqB+hgCFcozt7OP0Mwjyp4NrtfEpcaQr3rRApAUZS/OgRXlQAGRCokW2EZYzgyZPyQq+YKqqMndUWa7MH4eX7Sv5bavkRaSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859695; c=relaxed/simple;
	bh=zJTMn0kb3q2Ro0ipkr/Oo+0H2SNaDDrES2AEq5gMaxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1lglvU6RmGpkKKLnfXwPamokdWm02YLrr2ArwB7OgkFo50RPlpwR0oxit43WfyyXdhK1YTdtROOnNNCDJbPu8qxCQIu6vPgi3Du5XjDxQMag8QyaVCJjgXSeHji74iYjcReC1wdDYCZ+Cmw5UgOoJZ9qC0XZRNLqsxBnHmsi+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=Qjz9hdiw; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="Qjz9hdiw"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e6598dd44so40741085e9.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 06:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1790859692; x=1791464492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/cFMdbQVrp/rrJGRG8owEuxAxxXxJwwB95mSUGrcprA=;
        b=Qjz9hdiwIOOMZp6ZkSfBg1WQ57GjdaicwJeCpPo4Pn0x05Y9r10E9kHc4TYcnKhZNu
         BljWjNRZCKf4MlFSRPojWS/g4azHTLZHfwm2E87i+OYOF0kq/ZMd3HE4dJaGkFYYupMU
         bt/8PLfynIRC1PLYLirmPAkso+4KrxKw07/wfK2Qho8gGd2TeNWThaSv2rWLhtl5IhPb
         ReSXuVqJkkg6hQq5lFzwrzgBx/vTD9juZ3X2QwudBykg1faVDB3czJpmb9Z3s9iXgu3m
         FhsdPstg07hK1i8+M/k+O4beuUUMg6J9uIL/eYUrzRd0hkXsu663ZqnrpZgm4JSSFbeH
         G0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790859692; x=1791464492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/cFMdbQVrp/rrJGRG8owEuxAxxXxJwwB95mSUGrcprA=;
        b=YFe9uhRkdyvndR56bsEUEBYQocNqKk1YDJfyWfwwNMlVye51MkXsebFGFiU7LteOSQ
         n5/i11GHlQGMRrdqr5Nrm00lQii25H/Xym4H4xz/sAzQWXgaXB/+MgBkra9SV+NIIdZJ
         IvV/fF99xb5NdPBbjGU+Q9/MtiIIdT0cSsQkiREH4pSxhw9YKvRg2QcV7XLpUsAf1mXb
         U8fCJJtOqw3Ai0tTfwtVxpBQrTVdMrT9dkE1KgEU2m5P1ODkt7YFqwe4dSFiLLRCRYTJ
         2uUkjJ8OgqzhxwM54rwg0SUHTGfFAoMv4o1kKH/sEURv/xWIjAWWyELN3BXGO50Gr0ed
         DRCg==
X-Forwarded-Encrypted: i=1; AKwUvBzrFYk6NWLnVmcJZHn+sSI7KH5OjDU/Hxfr/7DS/4nkfC3P3AotAnMt4haP5z37g3ZewkFy2Sk=@vger.kernel.org
X-Gm-Message-State: AFuF++l07zOVSB68nplaZ/wxM1STIoc2+jMg5ULTEkOrnuw7wqjBZ4uU
	/PpRmKhBh1aw/Z7CgBvUd61e2t//WUkyjYeIiclY331bPunkadIMsqU/QsqcC8QTB20=
X-Gm-Gg: AYBFou0/sK+78aE/+iiYR6w5kZpVOsUH++tX7mU5ox0jEXdopkhpfPoIjXW7lXIim11
	ftnjnd0LV0rJ8F8xMHaAbm6cBWHkbHWlVUaqHrB8Vah0vA9cATfnifiIc37ZwkfsV86GTtIMHVw
	loSJRohAg8GOSbm8caCQHP066SV6GBI5H2ujWf/HGGxjaqx+jrOPqL+NNGYrygxfKBeRIjs5TXh
	MGQmfN1sFmDmP7ruSRoEPZtCLXDwcpLfRMFrV5ZowDbd6BsickYnyXuu6jCsXs3C9sZqICQnZsy
	pKXnB1xXwXGMoVVZFlRLOFzBK9B37AnEbdYuG613FC0KpkU5MF+RLGXzo4Jy6WbCaaz4uNUSgqh
	4YF8aufigrRyC9Je5bqLh1MZyHBSVj1Sz3yHSm6VCl8gMdbBTOyppNHTg0/+sVA+1qGsSfkGTxO
	yNZXW/2EykwAYiOLSIch1VZGr1d8HsSVSa4rj2pitXD33MsvD5hw==
X-Received: by 2002:a05:600c:19cb:b0:4a0:1c17:4fb2 with SMTP id 5b1f17b1804b1-4a01c175025mr66450685e9.31.1790859690631;
        Thu, 01 Oct 2026 06:01:30 -0700 (PDT)
Received: from remote-01 ([84.17.55.224])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f99b113sm77732245e9.14.2026.10.01.06.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 06:01:30 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v4 1/4] net: phy: refuse a second attach before touching the PHY
Date: Thu,  1 Oct 2026 16:01:17 +0300
Message-ID: <20261001130120.104628-2-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001130120.104628-1-f@lex.la>
References: <20261001130120.104628-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

phy_attach_direct() tests phydev->attached_dev only after it has taken
its references and, for a PHY with no driver, bound the generic one, and
then leaves through the error path that calls phy_detach_internal().
That call works on the PHY's current attachment, so a second attach of
a PHY in use tears down the first consumer: it clears that netdev's
phydev pointer and the PHY's attached_dev, removes the sysfs links,
suspends the PHY and, for the generic driver, unbinds it, while the
first consumer goes on using the PHY.

Found in review of a change that makes phy_detach() put only the
module the attach recorded: with it, this path leaves the first
consumer's reference pinned. On a Keenetic KN-1012, a test module
attaching a second netdev to the EN8811H that the lan4 DSA port holds
got -EBUSY and left lan4 with no PHY; with this change lan4 kept it.

Test whether the PHY is attached before anything is taken and return
from there. A PHY attached without a netdev, as DSA does for its CPU
and link ports, has no attached_dev, so test phy_link_change, which
every attach sets and every detach clears. A second attach of such a
PHY used to succeed and share it; with that change it would also leak
a module reference.

Fixes: a7dac9f9c169 ("phy: fix error case of phy_led_triggers_(un)register")
Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
Changes in v4:
- Rebased on net-next. The message names phy_detach_internal(), which
  the error path calls there.
- The test uses phy_link_change, so it also catches a PHY attached
  without a netdev.

 drivers/net/phy/phy_device.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 5b13a74e2fa9..0bdd2dc84d81 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1794,6 +1794,12 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	struct module *ndev_owner = NULL;
 	int err;
 
+	/* Set by every attach, with or without a netdev */
+	if (phydev->phy_link_change) {
+		phydev_err(phydev, "PHY already attached\n");
+		return -EBUSY;
+	}
+
 	/* For Ethernet device drivers that register their own MDIO bus, we
 	 * will have bus->owner match ndev_mod, so we do not want to increment
 	 * our own module->refcnt here, otherwise we would not be able to
@@ -1835,12 +1841,6 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 			goto error_module_put;
 	}
 
-	if (phydev->attached_dev) {
-		dev_err(&dev->dev, "PHY already attached\n");
-		err = -EBUSY;
-		goto error;
-	}
-
 	phydev->phy_link_change = phy_link_change;
 	if (dev) {
 		phydev->attached_dev = dev;
-- 
2.53.0

