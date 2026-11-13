Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559759;
	b=E2l+rCGFXbhSyjJSYGrHbrCW9fCurL5zwAjpnNKBQxEmews+78CB484cFTggkAvRx1hp
	 5/vxu/Ph0E1DuswzyUwPOQEbU0uLMB3Ft5sSCfhh7d4v0FpTROPN8V2bPTJTG0UZjQ9Ff
	 5je5yXZXKEhNkvs7F4gI1OrHkEuHyEHb8BkOLUMpBrHXDqThGSHRdMfFv+/sXAg/94KQb
	 GwRmYQnndPjWQbdCZ0ofNs4wGUaVOYpsNVzVhnMMGtHARQhMdZ9T9/kekVYe4aPxJeDP8
	 zej3yTaPNZan/FSlrhe9Q6CQm490cQi+fFVc9vJdOwVrTYiw8fIMaHjhmfuRKOkQBCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=cFbMSFFnfKBUiAHD1MzzGaz+GKQc6wEXvQbNeHmYNps=;
	b=glR9EZArd//4l51a8/r5AHZxJ8k4o2lhNkqdZ5i8n5g5YKCQSY4BMTbs0oTVOSFOTCuz
	 MgR92Z3f627l7pmHkP8jAvpJZ+84XNX02TZkJ+zyQMMFxf2tHshIPZSPaBkfkHR9jBtH8
	 UBtvRnWA3GxBbuRbTKVhPyfP8CJZh08LnYdOKKI+U6/LoFE32ZQEY3tkKUvKzDWexW/vb
	 sEolTG/xBG3syUQbfr8ORvTZ34zeyQleaTo+yKhxq1AzFELstnEs2PL7laoRjWO+EPRxX
	 A5vzsl3Uceqa4SHsWcZxHqSXrZjRZpcU4uIF4qiUrxXbCOpOEkFlnstnTPuetaoH2bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ac6sZwOc;
	arc=none smtp.remote-ip=209.85.160.44
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84749606CB3C
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 08:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84749606CB3C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ac6sZwOc
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4a77dcc4ca0so1063684fac.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794559758; x=1795164558; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cFbMSFFnfKBUiAHD1MzzGaz+GKQc6wEXvQbNeHmYNps=;
        b=ac6sZwOcrVoj5nwpklwQUYFFCVrRGiuRbsBHvbD/MSZ2oqacujlkOyLOsvpJo5qBYF
         8E+MGZTUSu2ReaD2UkVvWQ8vy7DRS0UmX1NYDlRjXopVXdWVv5WTjOUTIycos4W9w43A
         NzHgGWjyVIt5yZy81xdeF/pUVo9JVKvgUv2WmNHD6OIzMLKWh1I0uRdE9CsEnIpXbuus
         G94Fw1Fp+btDuhbm2KVhWMp/LbeXnMFqn1+U6plp/um34GWDPB81diG6mT9Yiwj4Z9fz
         tOqxUQeJClpsuyI5EyYcgtuVls5wTSI6Z28FoMlhEQ8V00eKCkpMYmlX6NUOO5n/yV2p
         boYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559758; x=1795164558;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cFbMSFFnfKBUiAHD1MzzGaz+GKQc6wEXvQbNeHmYNps=;
        b=rI5o5TIUoWRLKLBWU/GQTyOiIeoKPPacyzXdvrV32X6qazwl4d5TJjNC0QqT030kSu
         Y5FziGf9n9LOhFFpAIjlvALN7uZqNKH3VTb/G63R1921SO1oCFEyNcsNfHkpqv6Jsxs3
         o5b8OEArNg/CIjdVANMJESdtGnmUxbCcYUM8ycIJSxyPD4LYvS2SrpxhD/UZTCrmH1I0
         OKrDsoFXGiE02MDE9KxIdpw4RGh7S269/nOmDkuTLpfzqC8Yks7l/eBsM8hhRiVhVvse
         m+3a1isoHxpSxjUBONMN/FM4WqqYdoWb6rwk2QE1bSPWkOTjp10k9jEXBiqwNL5ZC4kK
         b9/A==
X-Gm-Message-State: APuU4Z+BQaHXyw8FnAP/+2ABf4t+//XaIM2l09zoryI33Q/pNoA1Pv/O
	CfVV7bufxGTzvHQsguTfHdwm5qNdPdX4a7fzQttIUY2kyl+EzDf6D5rt
X-Gm-Gg: AYBFou2Wo9i8zecZKhW9hFK9fw+KGz3h15aOyJsQZaIwleVVoXf9jF7UQKBDnjYVtky
	UPMgwMz7mSIokIr5teqKADz/5/3YCNAQlhY3MsjCkw+mD9f0dzdkiaxxEauMZW+0+iq93b35jwS
	NHE77icO4XejDD4BBo9yoZskMW2haV17zndKoT7r1xdVULqNnpLEGvIlIqDVVyPR0MBBc+gCO7J
	3ioKxs+4Jq4p3Z2A0R0FF3tbhNGXz2MeQsDuyAev9dpdT910s7InMS3W4TADSJZl4K0+R/Kcm3W
	ihJ9t6aELFce9oKMihUV56N7TpN5bMy+/TYXXw6OL8yvmezr8Yh8QtrXWmuGicjy2xHvJJ2rI4d
	C1RND8Ud3BNTbEXPrL5dBrI9uC6rLlne7EObeMxHtnbQz3GNYe0SA4HohryN8KkgVKRnSWycaCg
	DBE8IdMiCqNeOWIQwp4CNYs3Y491paLAwxJcuTzoEm7DVBbEpyUY7xr5xyXjFyojBEnEd3FtrLL
	eXVIpc7Nyid2ixfSAaQW96mgVEKEoQNLkSDtbUIoIZXC33HiiVzRGGQ0FwC+0HCEtEwcCSV9Afw
	CQ0jBoqxEhf9vR+xQd4fVDXfcclcU+j2wM31syraWnT2Q3z2PBwDmzQGZLUH+WbIv/nm2YoxDrg
	pd5dS0yuTrpqiTg9HKf4Y6vqraEmZRML2W4nsb3JHNft0OIFxJJ+0eJHt+Z6m5l0Q5Ed38Zv3SW
	dqpNgQFFJicAzBvUaKQy4cKhEJpKaS4X8wj7ITI+XGyAq8eLsTpozN
X-Received: by 2002:a05:6870:8102:b0:494:75ba:c6d2 with SMTP id 586e51a60fabf-4afdf287529mr2110921fac.13.1794559758352;
        Fri, 13 Nov 2026 00:49:18 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8628817d979sm2034202a34.22.2026.11.13.00.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:49:17 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 13 Nov 2026 01:48:43 -0700
Subject: [PATCH net 4/4] net: phylink: reinitialize the PHY after an MII
 reset
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-submit-phy-mii-reset-v1-v1-4-02a55f352a91@gmail.com>
References: <20261113-submit-phy-mii-reset-v1-v1-0-02a55f352a91@gmail.com>
In-Reply-To: <20261113-submit-phy-mii-reset-v1-v1-0-02a55f352a91@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michael Chan <michael.chan@broadcom.com>, Hauke Mehrtens <hauke@hauke-m.de>, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

phylink handles SIOCSMIIREG with a raw MDIO write, bypassing the reset
handling in phy_mii_ioctl(). A BMCR reset of the attached Clause 22 PHY
therefore clears hardware state without running the driver initialization
callbacks. The PHY worker continues using the old software state.

Delegate BMCR reset writes for the attached Clause 22 PHY to
phy_mii_ioctl(), which quiesces the PHY worker across reset completion and
driver initialization. Select this path in the register-write helper after
the Clause 45 cases, retaining raw access for the other register writes.

Fixes: 9525ae83959b ("phylink: add phylink infrastructure")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/phy/phylink.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index e885da1c2831..2f0e3a30615c 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3570,10 +3570,13 @@ static int phylink_phy_read(struct phylink *pl, unsigned int phy_id,
 	return mdiobus_read(pl->phydev->mdio.bus, phy_id, reg);
 }
 
-static int phylink_phy_write(struct phylink *pl, unsigned int phy_id,
-			     unsigned int reg, unsigned int val)
+static int phylink_phy_write(struct phylink *pl, struct ifreq *ifr)
 {
+	struct mii_ioctl_data *mii = if_mii(ifr);
 	struct phy_device *phydev = pl->phydev;
+	u16 phy_id = mii->phy_id;
+	u16 reg = mii->reg_num;
+	u16 val = mii->val_in;
 	int prtad, devad;
 
 	if (mdio_phy_id_is_c45(phy_id)) {
@@ -3608,6 +3611,10 @@ static int phylink_phy_write(struct phylink *pl, unsigned int phy_id,
 					 reg, val);
 	}
 
+	if (phy_id == phydev->mdio.addr && reg == MII_BMCR &&
+	    (val & BMCR_RESET))
+		return phy_mii_ioctl(phydev, ifr, SIOCSMIIREG);
+
 	return mdiobus_write(phydev->mdio.bus, phy_id, reg, val);
 }
 
@@ -3697,8 +3704,7 @@ int phylink_mii_ioctl(struct phylink *pl, struct ifreq *ifr, int cmd)
 			break;
 
 		case SIOCSMIIREG:
-			ret = phylink_phy_write(pl, mii->phy_id, mii->reg_num,
-						mii->val_in);
+			ret = phylink_phy_write(pl, ifr);
 			break;
 
 		default:

-- 
2.53.0

