Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E43415F2E
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 12:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791290864; cv=none; b=dsLNgmXymXHVuzDOt3YFe0iUh4Ul0bKAS7KZN2HfjZvkxUt7SBh6lgh4zzQgNxkSbxhykV8ysseUEjCS/bKQYVwhpAeNcHfuondn8kEOwrMDbq4OzkCB7ccV7j7osWMFsY1d5vRlJWyTMdvvztTH5HSG8d16B/ZYXGrbVxw2eQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791290864; c=relaxed/simple;
	bh=VPRvLKFU/4JwdFlsA07KHBhbQlgqiomdzFmD+vs2G1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NXovVdgp+ZKpx3GYaPZCyChAvBojvPEO0hUByOSOG608Ce+OVZXtrPt4qHl4s8M0W1ZhGq2Pp60poa/o9QSLuttyAYl8XnYT+MkNHlhczrRkzkhVAOIfp3LA8rT70GLes/jlivrCxZ3UGOmzCkWqm8Zz2YDdAJVe8OyEuNDyHX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=NyM2Byd0; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="NyM2Byd0"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48c4be28b82so515992f8f.2
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 05:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1791290858; x=1791895658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RSZxsBu5RBEC02GI587QjIyYZwSuYrJWfwAAHFHFZ+o=;
        b=NyM2Byd0Gc6bzeffEvVrxyA79H4UAr+uCWL0Q8hhW0IDM64Q7PTVK+7dIAqTsB5GBf
         gJUo7JTLIlVtsOBQs51KUyN8kqRLkjFOrJEiG+sVhfCcS8DwE2A79urQIc+ggV9ZN5GL
         /3Sp5iw8s5kEVaUbmA1ASkbzFUfAJCOO1MXtPxM/44n1JEwEvCNYI61y6iFyvKCEs/RH
         mRwL0m8MbguwDFu/TnwrCZOOjqC2EguO/r5acMZk09XuOObbp7cQu0onwt5gdB08Nh2y
         PMURcI8kp6uCbCovOuju036WDEQsTMK+RuYoyKXF3VurKJu8JSYLf+L2bSn9LbvZlRIe
         AHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791290858; x=1791895658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RSZxsBu5RBEC02GI587QjIyYZwSuYrJWfwAAHFHFZ+o=;
        b=JFItYqTzHIfQnytpkzaed69yTYww6+368LQkb9Kvb26JMxpQYGOb7z5pZPq1Mqat9D
         sol5CLuaR9gWXr1D6dWtSXryeMAETIkCObZW9UGKmHZpAukA9WmOkcfOt8Ttr/6RlGh6
         yK46Qd2UvUCagVKzVAe6yu2JIIjZGe0iY5ZsLp37D+jQEHoOjou8Hs11u2KQGlj+MBoy
         p+iGF5ne0YSqMb9YM/BoAyht+l0PUTZNmYEUvsopCoOSeXP+T5Hxxsen2Cu8Ygfojkkp
         lAyydJYsTgG85v4Px3I1XCT3E0YxAVvZkkABhbCx9HG/BF2NKDz6vY1X2nJrSxVh7UkX
         aPgQ==
X-Forwarded-Encrypted: i=1; AKwUvBzqkIoBjEhQmnSYN15HphgK8+SFZEiVE8Rv0DOF+ywG70Rsr09McAppKdKQSFso5hlt5VzlEok=@vger.kernel.org
X-Gm-Message-State: AFq9FYIw+2tZZrnGmxt6DdGiEEOb9wFx15PNMlpcFEffa9IaGPv7Gmar
	xUPLhI54iJ//ppwKgjOXVjMxqT2TbKNSGC94eIcWxngl7OLzOEn/oiDaHw8A1tJLlGw=
X-Gm-Gg: AYBFou3Tjlk40WjISefsVUzF7jmHdltPYKN7wFqJpzNkM8YjNOR23QmdErfXKFYrZjg
	gB3tWBM3NRWflP2pAieUhxVm4fvSsV3PRj29Rcce09gNuiSTe+xSygn/bAID02E9tQlzwrqQ9nJ
	V7fuNLCm6MrG6pPdZNi3G0r4M6Y/vURyelcn1xm2gXmLgDA4McH5XxG5ZfBvQQdb6mdcxQXaPcC
	jWSXs4CgkSgsCo/1lQHHm2L5KNpK2YtT8lunoaFI26/axYXK8kgbtPYVBS7CVfuSbZovo+EvJBV
	2zwi8PbstiYzm/AENP2n1vymfXBi91oo4Q7ug8OoxspXps7I5yWJiLJBse0QnAcbK/YMpVc5+eD
	roDcd4E1IYS7lHAep8V3ZuGbHTix+VEWYJpvhpqkgWxr3lmmq06jzYZV/cwtWLyKj77OCRQpQFu
	ON4DhGU31XVCtFr1YfPRtja78WHP1Jq3lVy7LEDD5cszZ8Bu+cUA==
X-Received: by 2002:a05:6000:4915:b0:48b:4c8:7b08 with SMTP id ffacd0b85a97d-48c6d19d048mr2285274f8f.34.1791290857366;
        Tue, 06 Oct 2026 05:47:37 -0700 (PDT)
Received: from remote-01 ([84.17.55.224])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c622b4685sm9722003f8f.41.2026.10.06.05.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 05:47:36 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v6 0/3] net: phylink: wait for a PHY that probes after the MAC
Date: Tue,  6 Oct 2026 15:47:28 +0300
Message-ID: <20261006124731.1528963-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the Keenetic KN-1012 (MT7981B with an MT7531 switch), the Airoha
EN8811H behind lan4 has its PHY driver built as a module on the root
filesystem. The switch sets up its ports before that filesystem is
mounted, so the port is validated against the generic driver, fails its
phy-mode and stays dead for the uptime. DSA does not retry it.

Patch 1 lets the PHY node say so with needs-host-firmware. Patch 2 makes
phylink poll for such a PHY instead of giving up, for a MAC that opts
in. Patch 3 opts in DSA user ports of switch drivers that set a flag,
and sets it in mt7530.

The poller can still lose a race against an unbind of the PHY driver,
between its readiness check and the attach. That window is phylib's:
any phy_attach_direct() caller racing an unbind has it. The attach
guard series [1] closes it.

Tested on that board with the series backported to its OpenWrt 6.18
kernel, together with a940003f44e7 and 07d995873960 (the mt7530
.get_stats64 atomic-context fix). The kernel had lockdep and
DEBUG_ATOMIC_SLEEP on. Local debug parameters, not part of the series,
drove the error paths. They fail the connect after a successful attach,
ignore the opt-in, fail the generic attach of a PHY with no driver, and
add a sleep after the switch shutdown.

 - boot: the PHY driver loaded its firmware at 8.7 s. lan4 attached at
   26.3 s, when the port was brought up. Link up at 1 Gb/s.
 - port kept down for 10 s with the PHY driver bound: no poll and no
   attach. "ip link set lan4 up" attached it a second later.
 - opt-in ignored: the old behaviour, the generic driver took the PHY.
 - two injected failures: "failed to connect late PHY: -EIO" twice, a
   second apart, and the third attempt attached. Link up at 1 Gb/s.
 - failures that do not stop: four attempts and one "giving up". No
   poll after that, also not after a down/up.
 - four failed generic attaches with no driver bound: nothing logged as
   a failure and no retry spent. The port attached once the driver
   bound.
 - switch unbound while the poller waited: nothing oopsed.
 - reboot with a 3 s sleep after the switch shutdown: the poll ran
   every second up to the shutdown and not once in the sleep. On v5 the
   same test polled 3 times in the sleep.

No in-tree device tree sets needs-host-firmware yet. The board is
supported out of tree, in OpenWrt.

Changes in v6 (since v5):
https://lore.kernel.org/r/20261001130208.105558-1-f@lex.la/
 - Defer only in PHY mode and without an SFP cage. In-band, the PCS
   could bring the carrier up with no PHY attached. An SFP PHY could
   take the port while the wait is armed, and its removal dropped the
   wait.
 - Poll only while phylink is started. A port that is down attaches at
   its next up, and nothing touches the PHY after a switch shutdown.
 - A failed attach after the PHY driver went away no longer counts as a
   failed connect.
 - The patch 2 message no longer says that MACs connecting from
   ndo_open recover on the next open. They do not when the PHY driver
   loads while the generic one holds the PHY.
 - The dsa.h comment states the rule: .port_enable must not use its phy
   argument.

[1] https://lore.kernel.org/r/20261001130120.104628-1-f@lex.la/

Aleksei Sviridkin (3):
  dt-bindings: net: ethernet-phy: add needs-host-firmware
  net: phylink: wait for PHYs that are known to probe late
  net: dsa: let user ports wait for a PHY that probes late

 .../devicetree/bindings/net/ethernet-phy.yaml |   6 +
 drivers/net/dsa/mt7530.c                      |   1 +
 drivers/net/phy/phylink.c                     | 232 +++++++++++++++++-
 include/linux/phylink.h                       |   5 +
 include/net/dsa.h                             |   5 +
 net/dsa/user.c                                |   1 +
 6 files changed, 242 insertions(+), 8 deletions(-)


base-commit: 47a1446725732cd3996edf607e8739334bbf4d78
-- 
2.53.0

