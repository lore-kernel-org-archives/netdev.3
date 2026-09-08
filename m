Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2218524B09
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788865221; cv=none; b=GvvbpYhy/tqgNnU98UAV3iZAqdGfzkOFQNEWBFwi+PdCTISs7mDHX/o97xE0b7d+yvmmbJHM2hExd3oUwWnGgK7nY0AMMIMKMjgMNw8CHeNp/1qSlZ1rY5CwCW/Ft9uRHALqW+xg4NtPNxhvLpkQ6DbhTQYH1aRzN7Hw8f/VOHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788865221; c=relaxed/simple;
	bh=Suqd5ftmj9Y6jk+Ge3M0i5T+AGs4crNAREB6UPMJwV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=orUEjzV215Zxv6qofMb1ryrlbXDaJB9l3EJKP417VDmYgxJ7ZZOoUsjx7i7v/CliYUTUehiqEBgZ8Nh/ZJj0FzxTXqxjiRy2ux97bb26D4eQWVAEo0E1oILS6JsNv9O9WpO1mI1xHb1RWvR7XxnVZdZ2DK4t5cbhseRr5BRrhDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaKesQsa; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaKesQsa"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso37316375ad.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 04:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788865219; x=1789470019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5MIH5m8h4rgx1wf2ZdrB4T0rpezySvGnbGk7lhC4ZfU=;
        b=XaKesQsayHa33cKi/oxjUxR1e7fx9zCCzLvtX4oKd1R+tq4A5G1D27r34HcDaUQJtg
         iYmfJroc0p6vmNl0LnuSfE7x2OyeUJ6GfmvHihAechfBWtRDlJoMb9RmzINHnZqzImU+
         KqrJuGrL2EDf0XF1kOLTCzCCuPsPicOe1+HEjDB16iXWnAjw52AkTFskGo55Fgv8Uhi5
         qKTPDjjHkn+4/tQI/HwNkHDvc8o3XoXs+i7AmAu4+f0GjwaUCvLffUvZg3F6Fzx+52f6
         g3bRXv4vTziTlQW70VkU+gzg2U/sZKK9MAI5K7j7evQqCMxDti8o9vlIuaKH1qs12W/x
         kL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788865219; x=1789470019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5MIH5m8h4rgx1wf2ZdrB4T0rpezySvGnbGk7lhC4ZfU=;
        b=hkzkRz6usHGxv6PdNYBTm9V74U6cQwVl8EsF5OyeOb0W4oARQZlfWAz3g53Ad/ycU3
         PzD8ZXwiT6GK0+PMhrE5UcrXXlPUbyIbFaM18f2Q2Kp/Rwuz3lgk1+UT5zJiR0bgwmFI
         ZBgSC8KE4CQPH0HUvmJ+DrUa/YpzJWdzryzJ7Ic30sKj/1VA+1meGdCaztw+1pXL3EK9
         BLBgPPMywEO0+iwLuRJdsza3UbqqktYrNOkoRj6DMFIxIxwdSvRv+b+FkIFyu5juZJfm
         yWGwmrM0PDIHoo24FT1NN3TGs4Wt/RIrMZ2Yc8tQke2gRKkle10xUxG756Nm9ecuJkgv
         rEAA==
X-Forwarded-Encrypted: i=1; AKwUvBzOexXcrxFt9/ZZJbn+pgMBF0F0gZlY/RSPeuT3fqK4HwezUO3G8wSpMiF2sgcArPssy/jcvdc=@vger.kernel.org
X-Gm-Message-State: AFuF++lpaRPsT2aDC6BtynkuA45mWIHEiDCiKCui/cUiOUQ6OooTOSqM
	hmwHj/6QQmNwDBBS/SYwqSbg6uiXHf2VeDx+BvZHOLEzUlI9zc0bve4=
X-Gm-Gg: AYBFou2B+xJwUEpIBEuEW8vG7DI3aiFYwgKRnn33y8ijR+bc4y/ThFUoFElIhXSQITp
	0B6Uh3VpoXKRyr0p7B4v7ukh1yg7j8T2csIBwShl8A7V+nnlvar4UFrL6v+9BGrtyzrEDcUWMZr
	elvBwemyxCj2hVmXLyTpC23tRb8VDKGnDimrTvwdKA61KLVCoX8SxntwJ29RPuFufPsbgfgjn9L
	wNbGl53sP2um3lk9uceLdPJDqhOLo7MWPkOTe4b8JJGwQpi4pqUKBngYShQVzU+5HyiTDqpI5Vh
	h+r0fOCQQKWeu2oTn3rUm+IuMOKu+STCShtaNPLfuykUQOIji5WF/7BVRugBIC8JVd1fNpolqUJ
	rv0pEcbdyuGsZnYqPKiFLH0EUr9HMk8qMaB1vogvy2/sCB+eU2HMintq07jnUzYGmULWrN6TDc4
	6cEa7+z4ihekzNHn1HvIzkIKHR4Eopdjbx51LZQD4ZVxqmIyKy6d/aGAj5BCjuckig76RfNFEJ3
	rR1DeUbCWCzKTxO
X-Received: by 2002:a17:90b:3d92:b0:398:bf7e:b267 with SMTP id 98e67ed59e1d1-39b2614df9dmr43960484a91.2.1788865218856;
        Tue, 08 Sep 2026 04:00:18 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:f6ea:9d29:b387:9ed5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08cacbb0sm32429842a91.13.2026.09.08.04.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 04:00:17 -0700 (PDT)
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
Subject: [PATCH net v3 2/3] net: phy: dp83td510: handle the active-high LED polarity mode
Date: Tue,  8 Sep 2026 19:59:58 +0900
Message-ID: <20260908105959.70453-3-donggeunyoo.kernel@gmail.com>
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

dp83td510_led_polarity_set() only recognizes PHY_LED_ACTIVE_LOW, so
PHY_LED_ACTIVE_HIGH falls through to the default case and returns -EINVAL.
of_phy_led() propagates the error, of_phy_leds() drops the LEDs registered
so far and passes it on, and phy_probe() returns it. A device tree marking
a DP83TD510 LED as 'active-high', which leds/common.yaml allows and
ethernet-phy.yaml references for led@N nodes, thus leaves the mdio device
unbound, so phy_attach_direct() falls back to the genphy driver, which
cannot drive this 10BASE-T1L single-mode PHY, so the interface has no
usable link.

The callback initializes polarity to DP83TD510E_LED_POLARITY(index), which
is the active-high setting, so the request is already satisfied and only
the case label is missing.

Cc: stable@vger.kernel.org
Fixes: 5b281fe7e396 ("net: phy: dp83td510: introduce LED framework support")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
 drivers/net/phy/dp83td510.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/dp83td510.c b/drivers/net/phy/dp83td510.c
index d75dae6071ad..9e9a41bf6457 100644
--- a/drivers/net/phy/dp83td510.c
+++ b/drivers/net/phy/dp83td510.c
@@ -439,6 +439,9 @@ static int dp83td510_led_polarity_set(struct phy_device *phydev, int index,
 		case PHY_LED_ACTIVE_LOW:
 			polarity = 0;
 			break;
+		case PHY_LED_ACTIVE_HIGH:
+			polarity = DP83TD510E_LED_POLARITY(index);
+			break;
 		default:
 			return -EINVAL;
 		}
-- 
2.53.0

