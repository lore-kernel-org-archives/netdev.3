Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDFD4E433C
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791568788; cv=none; b=d8vg0QO01B+xKvGuCKk4AI9gIJmilnZefA0A8XN7lNUD0UlhluE/REwVdHqCXNR38sxV9tm/6ZErX+lBkyeaTxNYO+CE/O1dRHeyTDLE1WNFSMA+Bh9lqqbB5qP/n6IjrEUtHth79Hp3tZoror5YHKXBwE9z2ZDsFiUxN2Q8iaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791568788; c=relaxed/simple;
	bh=P+poAH8wG69axUkwsD3K3DEA1hw8lvwze1Qf6c/Rtfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VLcmQBpPq/MXhXd5kLlC/SotSEf3HGsbiryOQuO6Ro5OqzwL7C3wRoyyOVSgVPEC6RCT8wg7niKXCfANWzSA9GfRCP2xXCqKRnTsj/MUZjpNeMpjwg1LIyNDicU7kSeoz0bN3ZFNFMBcYvGcdEVvuixNRyWSTbgZGhRemmyW3K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGh8+tN8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGh8+tN8"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e7e742a2c7so12495ad.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 10:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791568786; x=1792173586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LFrkjvKvgK+7671NmiTvcg+1m+zHAdrvgRTHztiv1Gs=;
        b=BGh8+tN8XqMN2QEAJxZV1nS/pmO8qOzKROTHnrON53EJd8IlkiB5vj1orwNNjiJqdo
         6HJ1ZL9V0jtbL25/qst85fUAXSMTBPXhLcPlIv/1Dw3IV3Q8bGZy5cwTtcFdvZugmfYC
         ylkMTTdogcgtG/ev/MGP/40XawHgnSsTo9CT9Te+Td4YUuvnVVSyAYD2ajgTHCPLQ3/W
         3RQVgu3o4/O8BTIeK3Y0r7BBZqjkZzewd0v9FY+Anvje7jHjL8U68I3ENqdiiDPIRCj2
         pGLf61UXWjqA7liizwaNkAV5TupiA2siDeHYFhv+Wqx8uUUEwvz51ojaX5229mg0EGCZ
         O4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791568786; x=1792173586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LFrkjvKvgK+7671NmiTvcg+1m+zHAdrvgRTHztiv1Gs=;
        b=YLHFuqFCGNOpVneimF899e6J/dpLvN/B/GSuhyb6TdMCjF4RzYHVPkF95bM2Wi1HS0
         rXMgoUW/qhfykffkhihIJk6/BcAPhRZIcF3/QNRGtAQ7rVefMl4ugPXPEFMmF8blbqFs
         7B18JYecH2ZTwxUxpRTA6lb9yzK0G8p2OaIN9TAWye4iehHBnHheA6JAOMPDnn6R4D5p
         ntgZGWICMwTqaJCXmd45TVeI34HT9ePxRSWPopzyG5Qb9T8r02oOQDdSUNqW15KRhrxJ
         qclaDZ/OAMVQF/x9+mESpWCDkOSllkEFaqvhKP6AsFm6EN2uWb/QVFGSJWDVF3yqUtlS
         7ZGA==
X-Gm-Message-State: AFq9FYJv9XfKq/GVV9ZZ2BOW49e5Jp+d3pZcc9s3Z6An4ikVc/aGuPh0
	vnX/givXWQ5Xa6pKHWz5qlo+AxVSALQ0we2VUayzwggpFdegJLX4hKvzt5LfYwer
X-Gm-Gg: AYBFou3gPjoq2vR0BwaLqGB7W0d53R26C03qkX35Xd1LJk446i1S9vv1k1ShtTX8+Wh
	EGrPNW2GTKSz5+7nwKd+RMk57WnSw4wfSmBr11yvGsX+1nEhZ6K0eHcYQpV4055hEWQwioj6G1R
	cC8SNuDjszRsoOetjlBE4bhUn+bTOSOVDjo/dzS+fbqeHG4Kc29CLczsh+jVyhnKnwD70ZAA9JQ
	VzDOjBT/xltD4yZFtzQXkRio8jJ9SstfZXfvR2i3fTA5tbaGj+koSPPa+Ht3uvCmA+kxyYT5cj0
	1KCU/3I+isEUKPjvOGDkFrkxGfV90ZFL0cvJL+cPoNLBVuzgJLAdIxSo0kShvRC7Dn1n8jbmhAm
	A2KDbgZJQMrF5ywB4NFy6cEp8cLAK27BZCCJZNVnM9Mbqx973ETPtKLFW1bNCtRlRzBq0UxE2xK
	mVEkVzFpBgCgJo3bcYfRFXAxO+HmPpfqQGYlDsEnVHR8M+oz/FECYdCeKGEmy2inDdF9O8ulTrq
	gap/u0tmB0RPbHAK3JvykzYSnkTue25MVs2
X-Received: by 2002:a17:903:26cf:b0:2dd:86a3:232d with SMTP id d9443c01a7336-2e8404bcd1emr20132425ad.8.1791568786245;
        Fri, 09 Oct 2026 10:59:46 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661c:1246::1d2:d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e84219e74asm14167105ad.29.2026.10.09.10.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 10:59:45 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/3] net: phy: motorcomm: Add cable test support for internal YT861x PHYs
Date: Sat, 10 Oct 2026 01:59:29 +0800
Message-ID: <20261009175936.428256-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The YT921x switches integrate GbE PHYs of the YT861x family (PHY ID
0x01e04281) on the switch-internal MDIO bus exposed by the yt921x DSA
driver. Add a driver entry and TDR cable test support.

v3:
 - add dt-bindings
 - add PHY_IS_INTERNAL
v2: https://lore.kernel.org/r/20261006202352.1616626-1-mmyangfl@gmail.com
 - split into a driver entry patch and a cable test patch
 - update comments and kconfig
 - add yt861x_config_init() and apply the auto sleep setting, restore auto
   sleep when starting the TDR test fails
 - use separate variables for the TDR status
v1: https://lore.kernel.org/r/20261004184246.1260426-1-mmyangfl@gmail.com

David Yang (3):
  dt-bindings: net: motorcomm: Add YT861x PHY compatible
  net: phy: motorcomm: Add driver entry for internal YT861x PHYs
  net: phy: motorcomm: Add cable test support for internal YT861x PHYs

 .../bindings/net/motorcomm,yt8xxx.yaml        |   1 +
 drivers/net/phy/Kconfig                       |   3 +-
 drivers/net/phy/motorcomm.c                   | 152 +++++++++++++++++-
 3 files changed, 153 insertions(+), 3 deletions(-)

-- 
2.53.0

