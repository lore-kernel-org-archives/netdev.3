Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1204C27057D
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 02:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786155107; cv=none; b=XPV8qRM0e0gsuQiNQS0Hazm1U0cloEubtLQR6xATe87zAk4udardSkOID1RrQYiJ0/T6sfriyahi21uX16yMVmmQkLfJoxmyjEBOZPqMGWyBS8ywQvx3L/uBrqbJiUIMVuwWbqMNQtxp2BvzMD6m/RX6N/aE30hplxXjwq1+apE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786155107; c=relaxed/simple;
	bh=0Hj0QlaYSTyFYEXSfFbeWe+iEXPNu+H/OM3iwIGQxoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AX8AwbECfZ2kxuIOkAi4v5Z/YHOtLwEccuoSeT/Vup1WspOPjdyvfHEtsiavfSeObIf6GCWKE+XzaAjgRYzv1AN+iCbISe+RKszK9KdbxRD4vnEL+Z7ie4AIgh4AtHwsIoldjLFKNngWeQtONDcHsG5c3+IxMft5VOTVtju58bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmtT2tcJ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmtT2tcJ"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca97d139d8dso49586a12.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 19:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786155105; x=1786759905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9bWoXHbpk4foxcIrHN4t0PDZwpmsKGgehGiQpXNvjYU=;
        b=bmtT2tcJdvshydvRJJFuWi4AmtxY9abhR50nXyQnDKTo/FjbETGG5wEwAucIvtnbrQ
         3XAv3VRwY9mhNxCs1rJNyY2FdiDyDp7nOaDTjr2U7Y7Ep2D1Ty0Gk3BTrU4lph5d1KPQ
         dZN/3/5OiTXGu4lc1Gkec3CGcE0eM4x9ht2eHIFkIsPRMpv465dvgPF4UvT01ZD9uY6s
         x086AjU9z1YPEcXkwSWPc5n1OFams/xLkiHt+RhsZYdtOP/MxDwsOYv+dv9GIyN6Xnt8
         35ME2JQX/3SNBL4ZJbEVKVChCrXzFMLpyDxJQiTTIUyny2PbcPuci45EEJv2M22n9jr0
         wxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786155105; x=1786759905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9bWoXHbpk4foxcIrHN4t0PDZwpmsKGgehGiQpXNvjYU=;
        b=rHtuk3EqTOsKzxF6kzjFoZkDgqo4roQE8QJJoP0LrpQPb2rtwpn8rLqSL/EuM7rFOC
         LrOF48bJxzdHUPjRZ4M/pQfHmY7jVK6U3In6M0DbnH1FfiqSH5+4gcgBPkBExbMOEHNP
         IzxsFgEc5A36DmvxEW8N3+UX5qahFLfH3QP1pHC9mKrdvrPFCaoswFWFLZd0Dug4Gnfp
         O0pgmKvegsUwahlGcCnkhZO2UOd7IF6cjjN9XZzq5VDQttoWxKh7TFPTHLwzwteAlJsG
         ln1q4FeMJ9uYhCnPQPeY1uRcZAHiFYS6wo61AhJZk2n5v78GSAXX1+MurcrOzwHAbosd
         vCGw==
X-Gm-Message-State: AOJu0YyZJKMhRZgK2MJmFIj/zRBL4RMjGYj/tgRP3C8DTtaRZHxzDreW
	B7wtctIUKDUaDhJpqD2/ietOxANO8c3nut6fuafGu80V97tfJPFT5GEAy7vx4+g6jgM=
X-Gm-Gg: AR+sD11ywygjzISq392iOvLXSmkc2q+kCFFoOzueMiVHDe3PIRXA9Xrw9HNZKsd1kEo
	slxepPZR+yLNZ+0odoFQgKT0LW+ts3hbaHgBuWuYcfz5U0H7dnbTRhjT2SU9oENiuAP6uJ+OQiv
	F3ksxa0M8V9olCv1T/21T7a69RvH+jkAMsweZfpZmpRVyToGKRDyCTNBqIhHSUDpDq/C0AA/z1v
	cRraPMiQwt1jfXQeqgWNJtmQKOobBofpeI2OtV3bpI2cJCA0NtWJDT8FtHKE/0v9zQUE0iO79RR
	N16ipyexUS5QrJBVycgjBf2V5DYvkMhbdpqrgQxrGLHZDHdmn1dLxZUFWZAr7X2IqHV3DN/tZbK
	2+VmIcPfY/q/DzwomNuPPHY6bfY+kcri5Xfo6YeHbJ0tAiLMyxh+6CTBlHpWvCQ/X1fmTWVh8AA
	Z2rFDfVYB8793zEeFkmnwfgMwFWv+krRzpmIXWWVRPG8hxMljZurhH63axSVP5h0eDHJ5G6MB90
	i+uMWTb2lLWy1ggHa5ytIrZHFkoXjZaLApP+gsz0JdlXYs1coBrog==
X-Received: by 2002:a05:6a20:9f93:b0:3c1:d78:6457 with SMTP id adf61e73a8af0-3cbce98fa3bmr5481145637.32.1786155105354;
        Fri, 07 Aug 2026 19:11:45 -0700 (PDT)
Received: from ubuntu-openwrt.tail1b3f25.ts.net ([123.201.0.80])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be8a706fsm12754983eec.8.2026.08.07.19.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 19:11:44 -0700 (PDT)
From: Sandeep Sondagar <sandeepsondagar@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	j4g8y7@gmail.com,
	robert.marko@sartura.hr,
	Sandeep Sondagar <sandeepsondagar@gmail.com>
Subject: [PATCH net v2] net: phylink: treat PSGMII as an inband capable interface
Date: Sat,  8 Aug 2026 07:41:38 +0530
Message-ID: <20260808021138.787656-1-sandeepsondagar@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807194937.785825-1-sandeepsondagar@gmail.com>
References: <20260807194937.785825-1-sandeepsondagar@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PSGMII (the Qualcomm 5-port SGMII) conveys the link negotiation result
from the PHY back to the MAC through per-channel in-band SGMII words,
exactly like SGMII and QSGMII.

However, PHY_INTERFACE_MODE_PSGMII is missing from
phylink_get_inband_type(), so phylink reports INBAND_NONE for it and
phylink_pcs_neg_mode() falls back to PHYLINK_PCS_NEG_NONE. The PCS is
then programmed in force mode and its control-register speed bits (which
default to 1000base) are used, so a slower copper link - e.g. 100base-T
- is reported as 1Gbps and cannot pass traffic.

Classify PSGMII alongside SGMII and QSGMII as INBAND_CISCO_SGMII so the
PCS negotiates in-band and the resolved link speed comes from the PHY
in-band word.

Fixes: 83b5f0253b1e ("net: phy: Introduce PSGMII PHY interface mode")
Signed-off-by: Sandeep Sondagar <sandeepsondagar@gmail.com>
---
 drivers/net/phy/phylink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 18d2ead97aa5..983a1a3cee37 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1040,6 +1040,7 @@ static enum inband_type phylink_get_inband_type(phy_interface_t interface)
 {
 	switch (interface) {
 	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_PSGMII:
 	case PHY_INTERFACE_MODE_QSGMII:
 	case PHY_INTERFACE_MODE_QUSGMII:
 	case PHY_INTERFACE_MODE_USXGMII:
-- 
2.43.0

