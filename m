Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4042525A62
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788865236; cv=none; b=ZBZMx9NGUMHe+AKtGFsMOsjmdIB7fZvm2PliNBJIh3P8f/ke0ZFDmQzZfH9eLDvFT+JDd9vLFznQiSfvSFHUpYM2Veunq8OLd/PStNJmTUvQwTmCO4xtzVxD3E4BwAoNIHr5pMoAOGSy7J7QMaEKjxvpF/H7gobc4VF4nP+s5kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788865236; c=relaxed/simple;
	bh=7YonU+3U3Csgg7NVd1AGIrmwK8SsFgirVwtU4hC2YHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iBs/lHDqC08gA0GdoPcjTruWzJlxkIGBhGSJOPuMHmR0kIJ8Pj3RWMNsgIz4lE+U13AureJpesuuvuaWEkImzBQMn0IquTy5HhM9nI2mcma3XHlQ02XFqa2IpX6TOAoC3As1x8KViM0ueT2ScU6c0spqlH9lw2zQvOW+f1V9Sz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hw52+2Js; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hw52+2Js"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso4215593a91.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 04:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788865234; x=1789470034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1LQOiRmCK+7QjsHZ0o37HxXuGfkjXxAF0goXiA50ma4=;
        b=hw52+2JsO+1UNjgLYqHy1Lt3O63eTH+P6uwOEoHrK/shkV+itUIFZGuSm4oKEFAmkt
         GyIFL5GhgGAwcAnF4a3FdPJuMMlMqEl93/rzbBpBoDfQHf7wotgkIIKQrJWXoHO1bxbW
         cVTIzkclE0RzOEI6f3lUKSycSC/gSua7XGZ+IWRaNAn1rjvnVGerxnfoXibljnvxdXWV
         IaBjn9cflhrxLhj+X2VzvKBDX+kAa+cN2dGpN5oiID+TymDLi2HlVRmMBs0tV5HOkBsg
         A+NsZ9T+mM9HSDqG69o68xqnhkD7YWHwbgROaeHV+TznHELZ8R7IwsbLN2reqK4RyCWQ
         qfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788865234; x=1789470034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1LQOiRmCK+7QjsHZ0o37HxXuGfkjXxAF0goXiA50ma4=;
        b=Vp817NL3wqic36ivyiggde/SjHIeiMyfgQ3JEb6p5Ya0+ZDM+NjngiW2W4Nb5GUVT/
         XcM1vJVqshaUqLfNyX4Oyg7w5BYp9ou50nV8rHqFckEXPiaKCO7vNevKeVHFAUTItARr
         y7zMnAoc7EPbuhxrboA/B5W2CGOFtW5uxE5wycmSmFvD1XCHBHH44hM8A4ifpadYBE3H
         Z0dxyK8+2xzwWytundFMpA98vVDiZojOVQW1NslWDsMOL9jq6/mfGg/71F3V3KMMsBcO
         t6ilf9PvBW90XjJwPtUJlSHHdE8tp5jlurg/H1DtjFkmWy35bXqexLfJWaate6kBHfpu
         qxlQ==
X-Forwarded-Encrypted: i=1; AKwUvByBSmLeD5KklnyhaV7vP0eSAW57epfFFcjxpMbES8gNeFFEmTPJWC4r0OQZ2g6JodAF4wCArxc=@vger.kernel.org
X-Gm-Message-State: AFuF++lqkuDRMCSQVrJEKInos2ZS0GBNwlVUKLaO5RmJJeFNYRfLUXYq
	CLvbnWpgLqsFphFUVmXoXbtJaWSiqSjE+PQfdYZUjO6hgSGaKU3+J1M=
X-Gm-Gg: AYBFou0AoB7fUbxXasxoRGew1FhG3zmBq27kthBKzirYpnAbcMy+91N6UytmRRABAJm
	2E1oXELUAO0IubVTfOJEobtXg5kx74PRWzZOdeHTJKlJ0mz3woVa+Y6v567uW3878KE5vNj52/T
	KGottpw1CQ/zWZqnAMnr3HjRtZSltlqmXNLvSvrTbw+Z/qG5CnkmhhBI4PhI51iLKaoQLrY2V+G
	dbuOkqeTMHO6aJ8y6+4d533il/JlrxjxkI/2UPfaFF6SvKsq93UKfqWzEzHeSeCaBsXGmFkTNx7
	FyS8YdBpHtB6NuXJXhtWQMVs8p+U6P3fq8Io0zXDzBQMeUBpQk9aWAzvCjZH6tLGmF//sasnEHq
	5XcO/hZVXTNeLFTcrDV9UMblOODIkblKBvHTepmkRtmmlbZ8TEo97wBZ/qHD7lujLga/d3SGled
	3W6Eq2uuGqSlxL/Shf0LqiNAekL4rLCxPeX2xlMWCsO2h+N3jG1AMgDcuw5hRP2DNDvN0ZYGEP9
	P9h8S/FLEyjsGgp
X-Received: by 2002:a17:90b:440e:b0:380:fead:448d with SMTP id 98e67ed59e1d1-39b261e1011mr40346945a91.13.1788865224500;
        Tue, 08 Sep 2026 04:00:24 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:f6ea:9d29:b387:9ed5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08cacbb0sm32429842a91.13.2026.09.08.04.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 04:00:23 -0700 (PDT)
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
Subject: [PATCH net v3 3/3] net: phy: qca808x: handle the active-high LED polarity mode
Date: Tue,  8 Sep 2026 19:59:59 +0900
Message-ID: <20260908105959.70453-4-donggeunyoo.kernel@gmail.com>
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
bit in the modes mask when a LED node carries the 'active-high' property.
qca808x was not part of that series.

qca808x_led_polarity_set() only recognizes PHY_LED_ACTIVE_LOW, so
PHY_LED_ACTIVE_HIGH falls through to the default case and returns -EINVAL.
of_phy_led() propagates the error, of_phy_leds() drops the LEDs registered
so far and passes it on, and phy_probe() returns it. A device tree marking
a QCA808x LED as 'active-high', which leds/common.yaml allows and
ethernet-phy.yaml references for led@N nodes, thus leaves the mdio device
unbound, so phy_attach_direct() falls back to the genphy driver and the
PHY loses its QCA808x-specific configuration.

active_low is already false when no polarity mode is requested, which
programs QCA808X_LED_ACTIVE_HIGH, so the request is already satisfied and
only the case label is missing.

Cc: stable@vger.kernel.org
Fixes: a274465cc3be ("net: phy: support 'active-high' property for PHY LEDs")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
 drivers/net/phy/qcom/qca808x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
index 8eb51b1a006c..3ba58f14e248 100644
--- a/drivers/net/phy/qcom/qca808x.c
+++ b/drivers/net/phy/qcom/qca808x.c
@@ -603,6 +603,9 @@ static int qca808x_led_polarity_set(struct phy_device *phydev, int index,
 		case PHY_LED_ACTIVE_LOW:
 			active_low = true;
 			break;
+		case PHY_LED_ACTIVE_HIGH:
+			active_low = false;
+			break;
 		default:
 			return -EINVAL;
 		}
-- 
2.53.0

