Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C350636F905
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 02:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787539242; cv=none; b=aQkW8nm4/ZG+4//n5mY/riZ7CC+qj+XlSVtr1ZsfJT/H9eU3+MCxOUm0vpekgBrh16zoon/pZfshh3U1VgcC38t6FVTCkQsXEA7VCr/sRn1nyff2RIm7hhT0BfBiRjgAbm2laj6zJNiP1SXG0i2wqFAt+Ruv6gFGkIv3WM64IDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787539242; c=relaxed/simple;
	bh=IwSXKBlu3u3dkzZJ0/MbjNAlkmnA7FQiy8L7S1VG7+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oZ/d/ES/1yqPrEvZbrWm+26PL033xAqndR1DDyJ9XirA4laaH2RN3hSXXXsThrm/9JGaQ2bi9VE/EGq+wTQQc8U7F6Q4GDLowQFZQpJr0JNg/FnE/YV8InD62EEH+yDGT4NkYsekZWYAObpuLohHYaYNZGFfyBLVXSlxSGd0Bag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=FiMF2CCJ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="FiMF2CCJ"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso4888337a12.0
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 19:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1787539236; x=1788144036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WXY56n3V2L63OEbG30eQkGDHCSrf+Q80MsU3+pYzFhE=;
        b=FiMF2CCJ/vWvo1+5OsFkoI1fPYroAYwSKR/qRWZlsiDsGSfiANDMhrt5wolPYjFNO7
         bmPwrpD6ef/cKe5vk21JU40V582IFknIr21jP/Io/2/j5Nnm68+Dazw0PTt4iFDlhIn/
         A0JNRgAM3r32R2qGsD7E6SSjoZzGf9+Fb9Q6eOwAyRrzNjzB+nnMinWkrfhKmSdXOsUO
         OF3j8PUhRtvq+2g0izjlr9zkHgmKHX+0bc/mGgZ2x5cXh/b5LVSPb9PQX5Dpt/HScQq1
         +aO/PuUi0HGrHYqoV6aV/kiCTNaoh55OUkCAJw8f6ieJbMXFXfcJwP3W5Vn9uSKcb/3Z
         a4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787539236; x=1788144036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WXY56n3V2L63OEbG30eQkGDHCSrf+Q80MsU3+pYzFhE=;
        b=Dr9eYERh3yhOvxN6b6pd6muBVkB7FWW/4Zf98FPd+VmtOXIt4Eph0guP5l7z0AhYGD
         MESESrIXBP/vb8sX8valFOh6DLZ4DufcePiab3NyFiw99AUnmRrnZktx8ymIRGekvPui
         bdXLELLCaaJv3c36QfJ2nbEPhS55swir9B6vKqu9jJjMzR8nnibok42C750vXhyC0+TW
         okERqrush82Bvf0LkSVqXJtaav0pvBSniV5GCuANHSPb67H29lqfyPzKHCwuLc4kZ407
         lkMWKCuBeRldE5DN78Md9ap9b/8nNDon50WI3dCHsaV9uMt9qxF3GOIHUqTnk9e98g9z
         seCQ==
X-Forwarded-Encrypted: i=1; AHgh+RpHgH/SVjIAsozts3cXDSI3Oz/+ct9m734X/WOUMm7bFHMXt8RWhksVKdcEhKikvA4sublGPFU=@vger.kernel.org
X-Gm-Message-State: AFuF++lWZhF7wSTDCO2MMaHTYv0AqG0FhD3pb68MT6NYRMgdf0C2CjHW
	Zw2leIe2RFLUjuGrEmZbq4Uk9LCR6k5HeVDDr06I2HBqaF2lYbCXyX39RnkKs03fH6Y1BFS5jOO
	52yM9x60HR1Q+
X-Gm-Gg: AR+sD12Vbf4+we851VOk9GG914grN5e62nO8zgyXOgTLj8+UFD1iQWQ5u9zci7c8aRo
	dDqbra+k258fX+leL3nz3WeMImLvC0sTWyowhXPhqWKP7wTNEV+EZC1knF+ohkpIh6NCeL6v6bl
	8+/ukip4f26/XRgqyQ8E1r9zXWedptqGmcZy2J6FfmiqbGO4ltdGv4B8VCuvz9RSe8eoK36dvUb
	wdDeLAidP/+7OjHdMABSwB0WX3b4+TOpgmtM2Au2z0y1yZ4yf7evmEjR1BZlODuU3/PE7zxn+tR
	jndztQIF1jayLGA3XKhPp6tneNjWhCZtMmbyh6JGSaslSWWEwN41HZQIOdBtiRcsmWCLXmSmVMS
	57TRrX9eZxFJJ2IR12ltFOfDP04xE0Toh6YtdEyVmsbu7Y67Xs8ANYSHMQoSjo8SHiPFo+7gdXF
	m63/Ru+Kd5vGU5QC2dWwTeXlt5pXMJzA9lr2zlRGYNj3j+UPDueMPYZ7aU
X-Received: by 2002:a17:907:6d26:b0:c15:dcc6:d06d with SMTP id a640c23a62f3a-c2469f9cbb0mr2525458666b.0.1787539235814;
        Sun, 23 Aug 2026 19:40:35 -0700 (PDT)
Received: from ownbook ([195.181.160.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f8f2asm1051909566b.36.2026.08.23.19.40.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Aug 2026 19:40:35 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Aleksei Sviridkin <f@lex.la>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] net: fix a stale phylink PHY pointer and a lost PHY interrupt
Date: Mon, 24 Aug 2026 05:40:26 +0300
Message-ID: <20260824024029.41310-1-f@lex.la>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two independent fixes, both found while chasing a PHY whose driver is a
module on a rootfs that is not mounted yet when a DSA switch probes.
Neither one depends on that setup, and neither depends on the other.

Patch 1: phylink_bringup_phy() records the PHY in pl->phydev before its
last fallible step, so a failure there leaves a pointer to a PHY the
caller has already detached. A later phylink_disconnect_phy() detaches
it a second time and drops references the first detach already
released.

Patch 2: a PHY that goes through a generic-driver bind cycle comes out
of it in polling mode for good. The specific driver that binds
afterwards never sees the interrupt the firmware node declared.

Tested on an MT7981B board: an Airoha EN8811H on an MT7531 switch port,
its interrupt declared in the device tree, its driver a module on the
rootfs. lan4 attaches with irq=15 rather than irq=POLL, the line is
claimed as mt-eint 0 in /proc/interrupts, and its counter goes 1 -> 3
-> 5 across two forced aneg restarts, matching the link dropping and
coming back each time, and holding steady in between. wan, whose
internal PHY has no interrupt in the device tree, still attaches with
irq=POLL: that is the observation which says the bus table cannot hand
back an interrupt the device never had. Patch 2's other exit, the one
in phy_attach_direct(), needs a generic probe to fail and is
compile-tested only.

---
Changes in v2:
 - patch 1: the unwind now shares a helper with phylink_disconnect_phy()
   instead of repeating its inner block (Andrew Lunn), and the patch
   gained a Fixes: tag
 - patch 2: the interrupt comes back from the MDIO bus interrupt table,
   so the new phy_device member, its kernel-doc and the save site in
   phy_attach_direct() are gone (Andrew Lunn)
 - dropped "net: dsa: connect a late-arriving PHY at ifup": binding the
   MAC to the PHY from open is the wrong layer
 - v1: https://lore.kernel.org/netdev/20260822155259.87146-1-f@lex.la/

Aleksei Sviridkin (2):
  net: phylink: unwind the PHY binding when bringup fails late
  net: phy: restore the interrupt after a generic-driver bind cycle

 drivers/net/phy/phy_device.c | 14 ++++++++++++++
 drivers/net/phy/phylink.c    | 29 ++++++++++++++++++++---------
 2 files changed, 34 insertions(+), 9 deletions(-)

-- 
2.55.0

