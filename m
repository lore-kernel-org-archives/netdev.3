Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE47524B1B
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788865215; cv=none; b=Kq+3YhzIPOB+qB1L/+oRkVGuWOhoBGbk0hkhFMCYiVQh5GmakRp5DTDF7CGfvIVCv+wCVqW8wi40AVZaceCv2Nsw7bHBZqFanUaNLLx0JwWJXzWcBeXz43ZkcoDjhkI5I2S1sGrt6Rst018g/txSNRJ2zE5ZJO0924vvzdi3Yq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788865215; c=relaxed/simple;
	bh=y9Gr4AywwMVYDnuywxdASoBv1xZ0f0lO8p7SQzvuLRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+nnLvZESP9ioP+Abf/5amA1/3aPG4W9NmziHFQ5pDR/ay+AG0ABMR6fK/dU7g48yCI76R1YbUwyRzXY84XtdiQQhxr/YkbRWSlb3BnLA0Bg2Rr1CF175myrqOCOXnUGgDZK3javXTmxoHfgK2xjx5GU/E0DIKjIYB6ZNDDGnQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCPhik24; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCPhik24"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so383459a91.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 04:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788865213; x=1789470013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aiaBPjiI7pIKbuKui3KX3gQd9H7z3U0hyAR/GzHBHQo=;
        b=BCPhik24nDLqKBt/0/dtT+P0u4nKKobr1IrYzo2U6OwieMGwIv5cA63b6wz9aZDThG
         hLwApMlQb41Hi9RlheUNIVK6PeTYhH2t0L0pU44jrjK5vU4w1BHaizC4ch/HBsJYE9xf
         zOqokZPX6lCdCEgum1QPBXvojXBMXhlI0veICco0w30CNUt/0jiyny/TLayScTFzRRW5
         lSmemoiBEGIoAilGs+knsfr3vg+/J5+rokqmUzeTEzbpksakjl89eAlIuT7iXdAgxBkI
         sRvDtBjGK4cUPKECyqQ9RSlxyUSUX5+lYEuKQ4Ct7Zt5TfNr72i+xsr0CElSfPyWeXzD
         r8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788865213; x=1789470013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aiaBPjiI7pIKbuKui3KX3gQd9H7z3U0hyAR/GzHBHQo=;
        b=CQMu88kvli5FdZKA294o4f2/IURnb8hyyaaKMYyJWpV6axMKtkVJleYnJjoyOdumJK
         9+5330mWkb7YtGx+AIHgNkU6vAqzl6VMeVohJKsYa7PWb3h+nODvnffcPziLMIWa2nAD
         f8Kdu6a53xM5UpT33PwGMkUEJBmJ1XWhxqmIOVSWidwf6NQ4Od6nNUAMTc2itFqsYuGQ
         bOHXxzyK77DmnWPKvxotNX8wAeTAPV/06z10Erh5osTlHtT/DzzYLagzaknuawypgTCK
         rer4eiWAo1ekTwVYoNYG7G88rRGsn4o576DFiPjHMSJEJjdGBZeo6CqN9he3zdjOrbrc
         QS6A==
X-Forwarded-Encrypted: i=1; AKwUvByZgDCk8VTuuik3piae4YfSWrmd7L3UJC3owvepHVMw2/JWzSVoPK8w7INlvLiJ5OQbLTMWM74=@vger.kernel.org
X-Gm-Message-State: AFuF++k1WVOB7ZSQxR/WUoetk/7pg18kPaX7Pmk28w2UJOb7ugXzXfBM
	niBvRq1NWfgJo6UvThsLapE2WzQZGQMy2nogCDSihi3SX5Qz7c5h93k=
X-Gm-Gg: AYBFou12iQ8g46aFEGqsndSsQpnOkHDrYccqMkFamGe9QL8+lOcnlAib759O7Hiq/Zb
	v0KQeFo9/goY/hNd1Q6f357kQmPtNOSSTX3Do2oVrhrSI9jsvmSgwYWhbEq2enFX19R2LHFkZhh
	sjF7gIitbRGytRihhkrcHQB5MN2COuK6z4xsHhZibsBb4Tm09JwXOiW9wAfZV6m77hYgvRFe8Xv
	vCXg5U41RtjSpP4/yC3CsgiFfk4xt32/1KBAIHVmEA3QJ3lhAuJTHmIavH+XMHR08e+oKPmgrwO
	gyXpdLpIYqI4ECG/z0m5/0JRcsI06vqkiNtclLhEggjsWoNitV3+5+2pZEXnZTCQXMLWZtNEPRt
	WCowRsoU0iKUD/FEqkXx0EaFz/6WIZwp+ieMDfI/if12yETjoRaMS5IUVF8WhzDYSmfLyskRzNr
	3KKyHJj5cG2VBV159ssh8Qbqj1PczWg6bqwh1/bNyuGEo7MKYwhtTOir/bONwEMn493Wr+ZJg0i
	P/FHs3itVHo5mnu
X-Received: by 2002:a17:90a:f945:b0:395:8124:ac53 with SMTP id 98e67ed59e1d1-39b8bd31191mr5493595a91.6.1788865213271;
        Tue, 08 Sep 2026 04:00:13 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:f6ea:9d29:b387:9ed5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08cacbb0sm32429842a91.13.2026.09.08.04.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 04:00:11 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux@armlinux.org.uk,
	daniel@makrotopia.org,
	o.rempel@pengutronix.de,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net v3 1/3] net: phy: dp83867: handle the active-high LED polarity mode
Date: Tue,  8 Sep 2026 19:59:57 +0900
Message-ID: <20260908105959.70453-2-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908105959.70453-1-donggeunyoo.kernel@gmail.com>
References: <20260908105959.70453-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a274465cc3be ("net: phy: support 'active-high' property for PHY
LEDs") added PHY_LED_ACTIVE_HIGH and made of_phy_led() set the matching
bit in the modes mask when a LED node carries the 'active-high'
property. dp83867 was not part of that series.

dp83867_led_polarity_set() only recognizes PHY_LED_ACTIVE_LOW, so
PHY_LED_ACTIVE_HIGH falls through to the default case and returns -EINVAL.
of_phy_led() propagates the error, of_phy_leds() drops the LEDs registered
so far and passes it on, and phy_probe() returns it. A device tree marking
a DP83867 LED as 'active-high', which leds/common.yaml allows and
ethernet-phy.yaml references for led@N nodes, thus leaves the mdio device
unbound, so phy_attach_direct() falls back to the genphy driver: the PHY
comes up without its DP83867 configuration and loses the RGMII internal
delay setup.

Active high is what the function programs when no polarity mode is
requested at all, so the initial value of polarity already satisfies the
request and only the case label is missing.

Cc: stable@vger.kernel.org
Fixes: a274465cc3be ("net: phy: support 'active-high' property for PHY LEDs")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
 drivers/net/phy/dp83867.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 88255e92b4cd..61a941aa02d9 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -1150,6 +1150,9 @@ static int dp83867_led_polarity_set(struct phy_device *phydev, int index,
 		case PHY_LED_ACTIVE_LOW:
 			polarity = 0;
 			break;
+		case PHY_LED_ACTIVE_HIGH:
+			polarity = DP83867_LED_POLARITY(index);
+			break;
 		default:
 			return -EINVAL;
 		}
-- 
2.53.0

