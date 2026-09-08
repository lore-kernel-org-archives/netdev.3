Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A12524B08
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788865210; cv=none; b=TDts+920wBMGmIaWtEekx1IDRZhZHjHtzFGWRvXme8+ooUpNN+rouBrGKX/7++/5m2c1v2/7SauqMOV8kZZuiYMATss8x5xA52SlkQhtVcRi9JSuScUf1KtHSXeMRctKHymvz06TkCVdMzI5S7uTxVFw0jNxE5YSxnLM3X/tIuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788865210; c=relaxed/simple;
	bh=8YTFKS1gIdMvKjHceC8WCGeaJ3Tt3+sMDQ22Q2fAGns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vi+qy/YnRdxz63GrHSUjovvmbIZUDkSHgK3EKG6GTlAagwF54jqjeuVOA1i5HdKb8D+KB6Wov6ZD/VZlccPvRgPx1W6vtIHGzbSTXdIRstZaDcfpseoVjsrjn6NLiLkyQLI3pQWlf/N57zwfJLaAh8ERq87GXyb/2O5GerUg/84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cm51llJB; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cm51llJB"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-383390e7584so152467a91.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 04:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788865207; x=1789470007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1MUi2XRPwjF/pI/qfQzJ3ednwuCIXcpoQGAgnhFM4yc=;
        b=Cm51llJBwwH6bylDW76pv6mAUfDU/KGJ88yPfjK012uqO95yJGtNlbFma73w+QZUpt
         W3Ffslrfel3x0+9oi2sGPioSjbUjAh4lXyVMMm/P+h3+LaPAY5RdlA8wKGUxDDmhDAWl
         NSkgi7IPb/dJYQmq9xBvxhkjxKU/NhhPatGqAHlCmD0YF7NrqQg5FNs+kU6fwqWgOhKc
         70W3OlaM0yF0dSis+cX9IYV4jAvuAis2mNG8GKjre/imOsRhvUtI6mmX0V9Nw9PgPejB
         N1XoR06cdb09boT/iCkZrpXcJHd95Y2A5uLwbuAcMSkahW/iJwJSDI4jrEe7C3KC8Cz5
         vwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788865207; x=1789470007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1MUi2XRPwjF/pI/qfQzJ3ednwuCIXcpoQGAgnhFM4yc=;
        b=PWcvQ9Cqx7D4kPc3xp8wiCJgw7zXYUdnO1LZ9s82qvsZEppe4M76Dk85S78B9blNg0
         eOYOpG5VJ30KLBCV0rihWNM+Y6gqNEs1XtlvhXm5vNSOhlvJ0nX62NFilQiQtWYJl9Nj
         lpNVNq4gtfND574kS98bngxB2cr+IbNsZgwRFoyMjTm+uifS3ygaROFpuKGc6q3UZ9X6
         Pbavn0u/Ehqkt895rl1/0ks4HvgMzQbNdTzpGrlz3pN/tFw1Cav3p0dLFk+HyHu5DJTm
         TDtp00+O5m4YEBT2xlFwfpfgw9/70hGPOiS7Sh72VeB+BdpRZ/elxJUnOytSVGTCnprW
         YSXQ==
X-Forwarded-Encrypted: i=1; AKwUvBwAmCHWqxMEk6Y+bpFziKgn5let0gNjFUzb760wLUSl1rGIgRqL5T35xBZuUpDZL2UNpr760AI=@vger.kernel.org
X-Gm-Message-State: AFuF++nBnwW1SfS9gZ9SPVkAfs/XiHiq8dDG//lwzQoVjR7NHs6s6AbE
	Gk5igU5IelHx61OKlaT0WbBmYibJ0hRpndZqrQFfGh6uQujBYVVLrEo=
X-Gm-Gg: AYBFou2QSXq6BuRJv01pRxngpvFos1D4/liItOklR7RrIrw81+mCezp3QmYhcW2A4Rk
	OUxo6ixFvMXwg+voQ87QNALJOEPR3sKIwWUUlzyEQdSnj98sDLttIBApjH8XxrO9IQpkr6LHklm
	HDLuImrmXknEvKXtgBXPz+wxrOL1OfTQr4emDDQYXMTfTX03mMDPraoosX/BeXeX1cpxYp2Rlat
	T7mP8XRWWFdIiKKeFZFkjrn3coEceh9jpxJDx75je80pNK2dJKCsl7j8dyxcUPMTg6xzB7qHqOR
	SObxbkdZkorZNVlwcd+oXzdfXEWmifPlXrScWI5pjYLhkOtiRAUgAWAviZdiZYIGEoPdw48NLNC
	1oYL2DvlZPZOhPXf8I3vcMg3LLxFfFgFA1vpMtKCUhEW71bNU/2fEMcUIEHaSByxkHyegp6+Rhz
	lUM+yWQ75Xo3tuq1MBblWnaZfwVt/6wFa4tskr4+2VhcSszETs8tpdyF2NvYASeUC1d+lLmogDV
	C44Esc/bpR8Ps5B
X-Received: by 2002:a17:90a:4cc3:b0:398:ba46:1d9f with SMTP id 98e67ed59e1d1-39b97d98709mr1926967a91.13.1788865207066;
        Tue, 08 Sep 2026 04:00:07 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:f6ea:9d29:b387:9ed5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08cacbb0sm32429842a91.13.2026.09.08.04.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 04:00:06 -0700 (PDT)
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
	donggeunyoo.kernel@gmail.com
Subject: [PATCH net v3 0/3] net: phy: handle the active-high LED polarity mode
Date: Tue,  8 Sep 2026 19:59:56 +0900
Message-ID: <20260908105959.70453-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a274465cc3be ("net: phy: support 'active-high' property for PHY
LEDs") let a device tree LED node request PHY_LED_ACTIVE_HIGH, but a
->led_polarity_set() that only handles PHY_LED_ACTIVE_LOW returns -EINVAL
for it. of_phy_leds() propagates that, phy_probe() fails, the mdio device
is left unbound, and phy_attach_direct() falls back to the genphy driver,
so the PHY loses its driver-specific configuration. Three in-tree drivers
still have that gap; each already programs active high as its default, so
the fix is one case label per driver.

Unlike commit eb89c79c1b8f ("net: phy: mxl-gpy: correctly describe LED
polarity") and commit 9d55e68b19f2 ("net: phy: aquantia: correctly
describe LED polarity override"), which restructured their callbacks to
fix inverted polarity, these three program active high correctly at reset
and only lack the case label, so each fix is a single case label.

The three drivers take different Fixes: tags. dp83867 and qca808x had
their LED callbacks before a274465cc3be and should have been updated by
it, so they point at that commit. dp83td510 gained its callback later and
was born rejecting active high, so it points at its own introducing commit.

Compile tested only; I have no affected hardware. The failure path was
traced by inspection through of_phy_led(), of_phy_leds(), phy_probe() and
phy_attach_direct().

Changes in v3:
- Cc: stable on all three, and state the observable consequence (fall back
  to genphy, driver configuration lost) rather than only "phy_probe fails".
- Drop the mxl-gpy/aquantia reference from patch 1; contrast the two at the
  series level here instead.

Changes in v2:
- Add dp83td510 and qca808x, so the a274465cc3be regression class is
  fully closed.
- Link: https://lore.kernel.org/all/20260903022839.4006614-1-donggeunyoo.kernel@gmail.com/

Donggeun Yoo (3):
  net: phy: dp83867: handle the active-high LED polarity mode
  net: phy: dp83td510: handle the active-high LED polarity mode
  net: phy: qca808x: handle the active-high LED polarity mode

 drivers/net/phy/dp83867.c      | 3 +++
 drivers/net/phy/dp83td510.c    | 3 +++
 drivers/net/phy/qcom/qca808x.c | 3 +++
 3 files changed, 9 insertions(+)

-- 
2.53.0

