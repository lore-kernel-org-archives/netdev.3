Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC594B1CF4
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 22:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792017069; cv=none; b=c90A4UxhblD+nVUunOkIt8kNYWeYvzdmVcmndK6fQ6KGPxTUlyFvKOTGpOXkUt27O+gGOCZC/C4SJES1UXSqkFCeXcVZcDBZfiS9oAvQIcqXC8IEfiD0I0dHAwMXv8FKHJGeyBvUAdhNPmk3UuzrZbBdMKTq/2OMobCmRp7zVQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792017069; c=relaxed/simple;
	bh=sSJveatLiiUTB+rY4VDmy+gYfQ8YEh2+U+AR066MOJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZRCt0lniKaq2roNePEZzo7lGgY95UmRx3rtHiUoyma/1KjQ3Wiu6ERT4i0Bjx2QA9Id2hRW3MgnCuBq6lkV91Gpjaa6G+8CEDzJ4WIntarKy544CzvaYb5920HbrIXp5SgXSVqlhYa4azT9Wm0xaNAW8G3YgwWZnaq6sf/I8ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=tAvJzk09; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="tAvJzk09"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-917a20e9efeso65948516d6.2
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 15:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792017067; x=1792621867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yyBKDPeadDKb/W86kBsK0Ioq78FHCGF848RoDf1sgTc=;
        b=tAvJzk09CXnCBEIwCYfgRoymDA+TDdJ+ig0ullLLgPlJiIYPZtfTVhyp0fS2c2HUVS
         6C9iWBl/BNcTRA1cWsj9Mae8FoNOnDvdVPmYJTY1WtSXT1Qual6ewP97lChvHOpZR03g
         3EAWXCQ4/2Wl7xac7FRIdpudDoJKmTxFgzTLtk0PV0VQDbAV9N07RAucJ2Jl08BjE5AZ
         +puM6llodHYc3dtDz9XnzqHFIwQyKsT2J7TRe9ghD0CEED8zKuyr/Fhqk42Hv1qYZE9+
         OHFiysH/tcJWC1EU0rg4xM33bm2gP9xSZb5958QOvMlnXmVWZtfRKAGX9o0U/iOUq50b
         9JXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792017067; x=1792621867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yyBKDPeadDKb/W86kBsK0Ioq78FHCGF848RoDf1sgTc=;
        b=OkN4o7PZsnwS+gFAQLN2Xd7zRxQu7P2cgJeuS9dnD4Cl8D/R44bbixmicSD7Vth0Pi
         A3vjbZ4cxeV8hWBJJWqHlYZlkJxwi3jS9fRIG37JEpjovlPAoucJJ819IvV+xDa2MVwJ
         c9//Ijlf2X8E01fqDkSDC/HeAZlaNh6ntPzgC9OZwxwwMOgoVgLk4CXF1jFRycKieXRO
         +BC9mDJtfpbT9WlfF79fiI5dOoE2+jzEdOAFKRVHPbk2zlS8wUWG7G9kKgJZrX5TNB/k
         xmXiA76b7ZqoZ1wY1am90g/fFptosF4MuBtQHJ93NjIG54MCEAD9HLK/GFrpRcmcbJhK
         EYYw==
X-Forwarded-Encrypted: i=1; AKwUvByk95u0ZiOJ0B2yWoTQiv2qc46B4Gl4yYKbjBGEGGrnPRgCcxixFkDk+gMK0EVN8rayVUY7YIU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJcR1yWe5sDEoXL1nDOOC4ISSF/5AjzOpcyY2oW8KhAU25ACsJL
	cmlRin4V3Xm+u+Ab8oYr9r91gP1rRIMoYqY03PKWhqkZOCStG5NgS1CX2tC0Yc87CFs=
X-Gm-Gg: AYBFou2pxADELNj1NGjfLI8RgKKbPprk2QuW4QzX8qdPe4/w+WhE5bxsYz+S+W7l29Q
	oFh57BwbGex4uiqh0M0tn6PXgOg+GcCHk59oGYLvEnjxVJka3Yznu8w2n0sYsBAO5eqyru/bSdO
	GOhoWDdREmfCetCR52Wr2b3Mo+QuE1JUGJcmTq17I7W1ui6vA9Gpu55s7uTGC42eDBVrJKA0Ssh
	vogztSFM9r4NkaQmUJjpCrgnZ9FQrK1eQKo/8kDm92gwWlyRn4PofEIID1MvV0TZShYuxeFOA5x
	3WBxrMyYRX+iny+wPUhbzp6/0bM7z4UriIuDAYo42rLZ6DmHubGB8PgYe2HkaaURDyn5f8rjia6
	pyAVvYh2evWrhzISdhYrr2D8j2WkeYhulSe9f3r0siH1CMOb8WXnFLPKbKS0PkJw3zYMzQG+zdF
	faSjha9agujy59HsLOGgx6yt/1Jcyj5wfJGw2LcBx0PKsxshcejmd6zdEcnwreJaRhNWbKU4jcI
	tg9xjfI4bFc6Q==
X-Received: by 2002:a05:620a:2841:b0:93e:646c:9138 with SMTP id af79cd13be357-93ebd1bb36emr2728359285a.26.1792017067212;
        Wed, 14 Oct 2026 15:31:07 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97bdfb89sm63708466d6.40.2026.10.14.15.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 15:31:06 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Daniel Thompson <daniel@riscstar.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] net: pcs: xpcs: select operating mode for 10G-baseR capable PCS
Date: Wed, 14 Oct 2026 17:30:59 -0500
Message-ID: <20261014223100.304486-3-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014223100.304486-1-elder@riscstar.com>
References: <20261014223100.304486-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Thompson <daniel@riscstar.com>

Currently the XPCS found on Toshiba TC9564 is unable to operate at
2500base-X and slower with a PHY connected using SGMII/2500base-X
(in our case a Qualcomm QCA8081).

The problem arises because this XPCS supports 10Gbase-R. That means
that the reset value of SR_XS_PCS_CTRL2:PCS_TYPE_SEL (0) is valid and
this suppresses the modal switching based on bit 13 of SR_PMA_CTRL1
or SR_XS_PCS_CTRL1.

A fix for this behaviour is implemented by txgbe_xpcs_switch_mode()
as part of the quirks for WangXun devices.

Rather than introduce another quirk for TC9564 let's attempt so solve
this generically by setting SR_XS_PCS_CTRL2:PCS_TYPE_SEL to a reserved
value when we detect the right combination of phy interface and XPCS
feature support.

The generic strategy adopted requires the default value of PCS_TYPE_SEL
to be 0 on devices that support 10Gbase-R. Based on TC9564 documentation
and the logic already implemented for WangXun I believe this is likely
to be the case for currently supported XPCS devices. Sadly I don't have
access to generic XPCS docs to confirm. However I think the benefits
of avoiding a cargo culted quirk outweighs the risk of regression.

Signed-off-by: Daniel Thompson <daniel@riscstar.com>
Co-developed-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/net/pcs/pcs-xpcs.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 49abf5ea6f5cc..5316cf9c31f19 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -705,10 +705,47 @@ static void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces)
 static int xpcs_switch_interface_mode(struct dw_xpcs *xpcs,
 				      phy_interface_t interface)
 {
+	int mdio_stat2, ret;
+
 	/* Wangxun provides a full alternative implementation to handle quirks */
 	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID)
 		return txgbe_xpcs_switch_mode(xpcs, interface);
 
+	mdio_stat2 = xpcs_read(xpcs, MDIO_MMD_PCS, MDIO_STAT2);
+	if (mdio_stat2 < 0)
+		return mdio_stat2;
+
+	/*
+	 * If this XPCS supports 10Gbase-R then that will be the default
+	 * operating mode. There are several interface modes where this default
+	 * is unhelpful. Change the operating mode for interfaces were we know
+	 * the default is wrong, and restore the default otherwise.
+	 */
+	if (mdio_stat2 & MDIO_PCS_STAT2_10GBR) {
+		switch (interface) {
+		case PHY_INTERFACE_MODE_SGMII:
+		case PHY_INTERFACE_MODE_1000BASEX:
+		case PHY_INTERFACE_MODE_2500BASEX:
+			/*
+			 * Why are we writing MDIO_PCS_CTRL2_TYPE + 1? We want
+			 * the modal behaviour that comes when we pick a
+			 * reserved value. XPCS allocates extra bits to this
+			 * field and allocates values from 15 down so
+			 * MDIO_PCS_CTRL2_TYPE + 1 is the value likely to be
+			 * allocated last (and hopefully never).
+			 */
+			ret = xpcs_write(xpcs, MDIO_MMD_PCS, MDIO_CTRL2,
+					 MDIO_PCS_CTRL2_TYPE + 1);
+			break;
+		default:
+			ret = xpcs_write(xpcs, MDIO_MMD_PCS, MDIO_CTRL2,
+					 MDIO_PCS_CTRL2_10GBR);
+			break;
+		}
+		if (ret < 0)
+			return ret;
+	}
+
 	xpcs->interface = interface;
 
 	return 0;
-- 
2.53.0

