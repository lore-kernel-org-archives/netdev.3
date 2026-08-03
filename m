Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44946349CF3
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 21:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785794081; cv=none; b=b31EJX4SKC2Hp3p4xZ493/WO7qLSyfTWYjtTjAIwtzMSxTNC97P3jqyaKtcPAuwQv2Ym/ogmE4GEVNylSAg80C60vJoRR2fXm0Z6ZRuguOm8xUwJKmqC9P7o7w2g2APULg71e8LitKyZJKnJZoBqdVd+4OAq8mEzmpgK6QcqOhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785794081; c=relaxed/simple;
	bh=VmVQha4vFTYyR8qQnUdzu9s4T7sgZdPCPKCMVPWhrD0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fM7zlQEr1eggACjEo3b04uvVGwICTwRI2Ul4hNFcNfDowfBt0K2vmC7HgYnXNQz11y7ARyvoN3hshZ9NBwUOEAwtOKRYd/QHF3QrsMkMj4nsnTevsQ910buD8ayvmbNlOMAV3akOZ+mvCC6yiQJtgEluXQv91FTsRrWneKveuYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJja/g8u; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJja/g8u"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7ea9c6ea7deso2440392a34.3
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 14:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785794076; x=1786398876; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nl7PF6Ztv1zd5hylSGzjTM5v9deQyg4ffOXI5If2s48=;
        b=DJja/g8u3YQoZLUQUQfJQrsOXk35ux06Fds4OFkTW4FkV4vo7uYElw3hYtVA9gUOzk
         m5+gtMKaaym2vB+So8R6Ck/Dnk4lkrpXOLbFQ0TCaXAToWI3lyCjpujGStLOuApFeDAq
         aqNJrvZuGLNyZcNwwFgFWora7DdxW1+p8VRzKP+UduJnQQmPomnRM7SZK7HBAQZGqih2
         mx1PW9pwfVwvkmzjrQ+GfrmFETCARdSxZsjzW6YwCy6p6DhOG/Y2iAVL3O+ezEggmxxM
         aCpUoBAa9RS8vdBzb9rMX4br4DtosX0tKTHmgMT2FQ6Q8xFJaSqolYNblqNXuDJZQUtg
         Ezdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785794076; x=1786398876;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nl7PF6Ztv1zd5hylSGzjTM5v9deQyg4ffOXI5If2s48=;
        b=o4SnuEcU77Ffp2MfhZsNWTnM0Gfh6gUYcbXQ7+DRSdrVCypuw92K3BnwaCNS8rP/SC
         gPgAEKtQiSsulbK9jnPVyoVp1n2mp9rmspGYq4AC+m+fpYf5Lr3x/Lz67LS6yQGp+OAp
         Z3pZD8kQvDgV24mH6KbnfeUjzGY1iZtIENmkpEOMza2gzrxhnliYXZhvmwaTO1FktsqB
         ZGR7pP6JgCK9EMKYpGDBYWorzbUfxN+339NHwrEksujideSALkjAjRFjRNJe8b1ZQWlw
         y4eeevPvQIPq+9Bbauwq1MQGblbb7pa3gM90z50ROeVM9fdFKJu58pP7lnTGW8Xhvytx
         oMxQ==
X-Gm-Message-State: AOJu0YzsFfnynLFNcoS9Bs9D9Nmo/rbIzXDuFOWELDBoo7Rz5wug+15s
	Hx0ZZNyIz7IupVeGK9xCj98WMsSVFGuXV7koBalLvkTCXnGjie8oAzg5IeByb7cH
X-Gm-Gg: AR+sD12K20RvjhPYKlLbAgd4H8nJgc8edq3jbmeyD8RXwVg3jDNDOg9qrQKJ8xwCpD5
	nPBSs2amsZHi/0s8Wl0r9OSvnMI+rtMvirBVSpRubqIYpDt5RzHzhaplDGx/gwxmmRV819e8VP0
	0wIIOI8ZSczIvO1ja93DDlQrM+2lw6Ed6QbxKDY3y6BS8jEcjlwYiHucJnMniQ5OmgREWA3zafS
	GaCjhhbGDFhZ9OUuSf/9wE+LHvLm6m/YyQiZ93gH22uJhpz3jzIA1vHzdfaBxDYK9w3DNpZMvcg
	Q3mOZ2guhT8538AJjkj4kdgeJ4rwQVQn/C9zLf19upuoSwi90VkwnVUMbdpDJJchzJIGI93G+JX
	/C934HLMCLs0/vLXyoxJRYDnbo4gMAPi1Ky3pSOJUHSLG+n5Uv/H/6HDYn7Cm9xCiWk+L1Am7Qw
	pzl42jw8IyEbPpBMcbkmPSyQ9FMMPuM5fyfR2Sfwafkd2YbTD58FDhLUtaRxc8oZ7NO5/LL7DxC
	ZV8SUcZwtAlScA4Q6028KWQij2nYir5GRftgh8hJCE9IQRF39xNazqIRRsA2dR6ZuDO8+a/VSAD
	AZCXwPyPSYue6hqsu9unzuioGDZOiVFpHHUbXfpz7ieWfcCPjcfGKds6kz2GPb7nu3vqMAQaSvm
	+UsJZhoTJ7x62pJ5g
X-Received: by 2002:a05:6830:6105:b0:7e9:e9a0:9a8b with SMTP id 46e09a7af769-7f196fed19bmr21111811a34.16.1785794076044;
        Mon, 03 Aug 2026 14:54:36 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18ed3c81fsm8290876a34.5.2026.08.03.14.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 14:54:35 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v2 0/2] net: phy: add PHY-autonomous EEE provider support
Date: Mon, 03 Aug 2026 15:54:02 -0600
Message-Id: <20260803-phy-autonomous-eee-v1-v2-0-222a187ba2bb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBG4auQWTtJHRIDXsW4wPIjY2JLOpRIC
 Hen6vJbvLeRISmMrtVGCYuaxlAgp4r82IUnWPtiEicX17iap3HlLs8xxHfMxgB4OXPdoG9FBnG
 +pdJOCYN+ft/b/W/Ljxf8/J3Rvh/jnW26eQAAAA==
X-Change-ID: 20260803-phy-autonomous-eee-v1-38ed922f20c9
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Some PHYs implement a vendor-specific autonomous EEE mode. Once EEE is
negotiated, the PHY can generate transmit Low Power Idle (LPI) without
MAC assistance. Linux must select exactly one LPI provider: enabling both
the MAC and PHY paths conflicts, while enabling neither makes a successful
ethtool request ineffective.

Earlier autonomous-EEE design discussions established that:

  - provider control belongs in phylib first, so non-phylink drivers can
    use it too;
  - PHY drivers should receive a narrow autonomous-EEE operation rather
    than the complete ethtool structure;
  - phylib must remember whether the MAC or PHY provides Tx LPI, because
    enable_tx_lpi must ask the MAC only when the MAC was selected; and
  - userspace should continue to see one EEE interface. Provider choice is
    an implementation detail, not a new ethtool mode.

Patch 1 implements that phylib model. It adds explicit legacy, MAC and
PHY provider states, a set_autonomous_eee() driver operation taking the
enable state and idle timer, and phylib calls which select either provider.
It routes ethtool Tx LPI changes to the selected PHY with rollback, keeps
enable_tx_lpi clear for the PHY provider, and restores the selected mode
after a PHY reset.

Patch 2 makes phylink select the MAC when its LPI implementation is
usable for the attached interface, otherwise fall back to a configurable
autonomous PHY. A PHY which changes interface with speed uses the MAC only
when all its possible interfaces support MAC LPI, keeping the provider
stable across link transitions. EEE remains unavailable when neither path
can provide it.

Previous discussions and review:

  https://lore.kernel.org/netdev/d86c53213a6328b701b8aabbde5d1c83@tipi-net.de/
  https://lore.kernel.org/netdev/20260406-devel-autonomous-eee-v1-0-b335e7143711@tipi-net.de/
  https://lore.kernel.org/netdev/ad954550-9dec-4e0d-8636-0b6cb379421e@lunn.ch/

Changes v1 -> v2:
  - split the generic EEE work into this standalone series
  - replace callback-presence inference with explicit provider state
  - replace the full eee_config callback argument with enable and timer
  - add the phylib provider API before integrating it with phylink
  - handle interface-specific MAC support without changing providers when a
    PHY switches interface with link speed

Tested with x86_64 and arm64 defconfig builds of phy.o, phy_device.o
and phylink.o. Runtime-tested on an Allwinner H616 system with an
X-Powers AC300 PHY using the autonomous PHY provider path. Testing
covered EEE enable and disable, Tx LPI timer validation and rollback,
restoration across a control-provider power cycle, and link traffic
with EEE active. The generated patches pass checkpatch.pl --strict.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
James Hilliard (2):
      net: phy: support PHY-autonomous EEE as an LPI provider
      net: phylink: use PHY-autonomous EEE when MAC LPI is unavailable

 drivers/net/phy/phy.c        |  48 ++++++++++++++++--
 drivers/net/phy/phy_device.c | 118 +++++++++++++++++++++++++++++++++++++------
 drivers/net/phy/phylink.c    |  89 ++++++++++++++++++++++++++++----
 include/linux/phy.h          |  41 +++++++++++++--
 4 files changed, 262 insertions(+), 34 deletions(-)
---
base-commit: 848acc8ffe1b7cd5f1bf427b93069becfebc2c9d
change-id: 20260803-phy-autonomous-eee-v1-38ed922f20c9

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

