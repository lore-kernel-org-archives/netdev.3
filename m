Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA86C34A791
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 04:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788756485; cv=none; b=Hgu5eiWWXdE/R3gjZ6040gvEPvojPZdl8CNHnX+w4BCsP4oXYBrHKqy5jManvXMSk6toMdV/WAKsK5AopaE/c67Uhym7mE19jANpEVu0DNqpw99sccO+5T2WCJsOQ0xTGUalL1XMYKN1/o0wArGHXEMi2fimFe8Ea5YuVLEeh3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788756485; c=relaxed/simple;
	bh=2WMF6U/g7nQBnXSpps4vN5voTrNMlXOybCCVnMTQw6Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ACryUqCQhFpYIjFYrB0Cxbdm6c1Pzh2NSzIBly/oumoSX2S3xiJ8j17UBI0TQJlEtj3yrm/zv5jsK0U9n6k5vRMLCxi/N6YM8DeenGXIV3MYHKSnaPGw69yRozp+76epa106hLwOSudbfXGqjrxHTt7Hr6QecQHrq9Dub0RS+rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxfZohiy; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxfZohiy"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-451a49abd8aso2953356fac.3
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 21:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788756483; x=1789361283; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TvFM7NNIPkG6fbK+OMkIIggJlPWe+qc7pAzr+tWOET4=;
        b=LxfZohiyI6BSf/NE9qpsJGlOeSti7TFfQy31HVTcVh+sr8O3Atke9/Oo+erAnSUVKB
         zLt65to1a2lwPkwuqECL7xMbGuT4p5bBhPVcR15bMApLYH223vok0IWMfe/r9w0uXuc0
         MnV0bJKFPdI9KrdF1oySGvg0KDBtwzmfHKjKmIRtXTbLd0t7zEvPIlCNLwIpTf2EClGV
         NahAT4DWepmYKwqiEPe4AJf5M+vjaiOWbGPCSWOpYq7gHskmNhSpoq83K+f1tp8vD2DI
         7ZoV/y8iWLEnMptBW5PBfH5bWKK+L0m6z4wqTmVLlxuLJ7ZcBS4/VkttiqkW9bX0Wpjg
         BqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756483; x=1789361283;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TvFM7NNIPkG6fbK+OMkIIggJlPWe+qc7pAzr+tWOET4=;
        b=DJDKAoUyZFWIaGghh2WpmcBSDay28eLpYNU7rkzwrxs4kczdT9qjmUdgcDVlgZ4kL8
         HSzmbp0a0Yn7NJPhXxMt6T/M3vo4DzQXCUUYnkThf6KaoYvuCMvjvCSKVHUlHB1ZhOlU
         /PQlU06XWbkhil/nXeEzb362NNBjM8tB8uInfyA6i0iNQ/ZyYA8Iq5hlIAFrYmqQw2DI
         nuMIagIcyV6Mm5OJEVbeMTnm7qZSl6IGPl3fFikUMAX6L3pyHMOJ+Zpw+kUhz2+AnjnW
         L7U8f+31sHnSFGNVSm/x6jH8X31X67mOL6oVJD2cgNSjS3WEso/T4LrMQRse1NGHxsZd
         XgJw==
X-Forwarded-Encrypted: i=1; AKwUvBwxbFWrZROcnsdEOinzWx6Ri5RKeCfjtP9akpcCexSp7ILUrhAaSAnX7dCCU+0nueE7MszfRAs=@vger.kernel.org
X-Gm-Message-State: AFuF++kDa9PIey8yZiZgBpUHf55PJ9XlrlV4mVuPkNwJ7pkrd+pnqPHK
	+LxVZdpK49zUw1RIIUVih4vBUslWVIZJIZrE+0UvweUH0UGcnQar2wrS
X-Gm-Gg: AYBFou2QFB1A0R8aFLkgPppQ25+WH7mzleVYW3NwfRMnQPXZSNvsOC7zguraSZMX3Xi
	nV7+DYIpVWKHxUhJaHfCr+Pmcr4709j3rbLxzNI2N+fhzckkDqYbY53OCG5soYiYwEGrvPKaaOI
	ANOSQHw9WsNM81lH29jolO5qLDe5X8t5k5LYuHrgKJlWeToEyho6BNbMFCPmYv5PrwpbyJMktZE
	dzHRtyrI8KNu0M/gyUysGT3VZD/vp8PaMX78rdxHbdNdp+uoq4t6FrsSnoFOJI5bKumRUD4Qklp
	ENPZF3+MT+KHa5cBwjMRrwE+YDeZy++SGEt6XGZ+AkrF8IXds459hgVB4C76ByCLdeT3DOIpZj2
	LhuSGGvFSbh++qZFUKRGeU93G1/w87thmU95Y0Xsxf4a1GlPYKBU8lfckRW7s2+oYIBWQSKgeWP
	Zts91LbSiumBBl13k+OwuPajUUxllQdguHR9ziqnqUIsYPG0F2TxotbZj8LGdMXWPn/V2qFvMsD
	F0f+NKuIUFtvghmB5TODMy/AHqhZsBnOmHJYxM3VmUJCH7hbOsthORcfTt1CamzsD3lBzE7YD4G
	rHtd+YloZbIBXg00zIpJR+T6/iIb+GIm1ds+75FOBNzoOrZzgzgYteVNEjYK9cClKzsR7XB2UXe
	cJvcLDUrTDOl5HWbbI18cQsZWgEOx
X-Received: by 2002:a05:6870:8306:b0:475:e066:771b with SMTP id 586e51a60fabf-475e06695c9mr10380401fac.34.1788756482604;
        Sun, 06 Sep 2026 21:48:02 -0700 (PDT)
Received: from [127.0.1.1] (184-96-151-165.hlrn.qwest.net. [184.96.151.165])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-475501412f2sm9013503fac.0.2026.09.06.21.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:48:02 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH net-next v10 0/2] net: phy: add X-Powers AC200/AC300 EPHY
 support
Date: Sun, 06 Sep 2026 22:47:45 -0600
Message-Id: <20260906-submit-acx00-of-dynamic-v1-v10-0-dd272e03b547@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43QS07DMBAG4KtUXmNkj99dcQ/Ews/WiCQoCVGqq
 nfHCSysIFksZ8b+/tHc0RTHHCd0Pt3RGJc85aEvBSVPJ+Svtr9EnENpICAgiSaApy/X5RlbvxK
 Ch4TDrbdd9nih2HBLgqcigQZUgM8xprzu+ivq44z7uM7o7WdSnPfo583e3l7zNA/jbV9kYfuP3
 0jRilwYJpiBZ0CJlQnEy6Wz+ePZD90etPCakk2KF8q4BElxTiWDIyVqyjQpUSiXLE1aUO1AHyl
 ZUZQ2KVkoAmCcMZZBkkdK/Z9SG8WScIYqJcKfW+maYk1KFypAol5A1MrxI2VqSjcps91Kex2MD
 SRoVlOPx+MbAl66c6MCAAA=
X-Change-ID: 20260802-submit-acx00-of-dynamic-v1-94a0dc15f282
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>, 
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@kernel.org>, 
 =?utf-8?q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 linux-sunxi@lists.linux.dev, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2

This submission contains only the networking binding and PHY driver and
is intended for net-next. The AC200 I2C register provider was submitted
separately for the MFD tree:

  https://patch.msgid.link/20260906-submit-ac200-mfd-v10-0-f522e8dc2bd4@gmail.com

The two series can build and be merged independently. AC300 needs only the
networking series. The AC200 runtime path additionally needs the separately
submitted MFD provider and binding. Their shared design point is the DT
representation: the MDIO PHY-package node references the AC200 I2C node for
access to package-control registers.

The AC200 and AC300 contain compatible Fast Ethernet link PHYs which
report the same Clause 22 identifier and use the same link-side register
layout. The link endpoint is inaccessible until package-specific control
registers have powered and configured it.

Both variants are modeled as standard Ethernet PHY packages with one
forced-ID link-PHY child. The package reg value is the link address.
AC300's control range is a fixed package-relative offset of 16 and is
accessed with the PHY package helpers. AC200 reaches its control registers
through a phandle to the companion IC's I2C register interface.

For AC200, the driver resolves the referenced I2C device, establishes a
managed device link, and takes the supplier device lock before checking
that the provider is fully bound and retrieving the regmap attached to
that device. It waits for transient lock holders instead of treating lock
contention as a missing dependency. The link then keeps the provider bound
until the PHY consumer has unbound. This uses the generic device and
regmap interfaces and supports multiple AC200 instances without syscon or
a private cross-subsystem API.

Fixed hardware uses an AC200- or AC300-specific package compatible.
Systems which can contain either package use the ACx00 package compatible
and one packed SID configuration field. Bits 3 through 0 carry the analog
calibration, bit 8 selects AC300, and bit 9 selects its low-calibration
tuning. The driver chooses the backend before acquiring any
backend-specific resource.

One xpowers-acx00 module binds the link child, joins the parent package and
runs the selected backend. It manages the package supply, MII or RMII mode,
vendor analog initialization and package state across suspend and resume.
The common link implementation preserves automatic MDI/MDI-X and standard
MAC-managed EEE advertisement while disabling only the vendor
PHY-autonomous Intelligent EEE mode. A private mutex serializes
package state across phylib callback contexts, while suspend recovery
also holds the phylib lock.

The two patches add the AC200/AC300 PHY-package binding and combined PHY
driver. Board Device Trees and optional PHY features remain outside this
initial series.

The AC200 portions build on earlier work by Jernej Skrabec and Andre
Przywara:

  https://github.com/jernejsk/linux-1/commits/ac200-v4

Public AC200 and AC300 documentation is linked from:

  https://linux-sunxi.org/AC200

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v10:
- rebase onto current net-next after the merge-window deferral
- release the MDIO bus lock when selecting a vendor register page fails,
  preserving the error and allowing package shutdown to access the bus
- update the companion MFD reference to the submitted AC200 v10 series
- Link to v9: https://patch.msgid.link/20260818-submit-acx00-of-dynamic-v1-v9-0-b8c8d9ad0d83@gmail.com

Changes in v9:
- serialize package state and multi-register power sequences across phylib
  callback contexts
- hold the phylib lock while recovering from suspend failures
- unwind package power after reset, resume or configuration failures
- restart autonegotiation when restoring EEE advertisement changes it
- propagate page-selection errors instead of an uninitialized result
- constrain AC300-capable child PHY addresses to the valid 0 through 7
  range
- clarify the AC200 runtime dependency and provider-owned, rate-locked
  clock
- document why the AC200 control sequence needs no AC300-style delay
- rebase onto current net-next
- Link to v8: https://patch.msgid.link/20260813-submit-acx00-of-dynamic-v1-v8-0-d2f1c52e87b4@gmail.com

Changes in v8:
- replace the AC200 supplier trylock/defer path with a blocking device lock
- add Krzysztof's Reviewed-by tag to the PHY-package binding
- rebase onto current net-next
- Link to v7: https://patch.msgid.link/20260811-submit-acx00-of-dynamic-v1-v7-0-03f5b91775d5@gmail.com

Changes in v7:
- link to the separately submitted MFD v7 series:
  https://patch.msgid.link/20260811-submit-ac200-mfd-v7-0-8b06f552a4d7@gmail.com
- replace syscon publication and lookup with direct AC200 device/regmap
  lookup
- require the referenced AC200 provider to be fully bound under its device
  lock
- keep teardown ordered with the managed device link
- rebase onto current net-next
- Link to v6: https://patch.msgid.link/20260811-submit-acx00-of-dynamic-v1-v6-0-0229b99a32f6@gmail.com

Changes in v6:
- split the networking work from the independently mergeable MFD series
- add the posting link for the separately submitted MFD series
- remove the redundant explicit schema selector
- describe the AC200 phandle in hardware terms and state its purpose
- simplify the clock description and keep only the needed NVMEM dependency
- reduce the binding examples to one
- rebase onto current net-next
- Link to v5: https://patch.msgid.link/20260809-submit-acx00-of-dynamic-v1-v5-0-bfa1f8518b28@gmail.com

To: James Hilliard <james.hilliard1@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
To: Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org
Cc: linux-sunxi@lists.linux.dev
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
James Hilliard (2):
      dt-bindings: net: x-powers: add AC200/AC300 EPHY packages
      net: phy: add X-Powers AC200/AC300 EPHY driver

 .../bindings/net/x-powers,acx00-ephy-package.yaml  | 165 ++++++
 drivers/net/phy/Kconfig                            |  11 +
 drivers/net/phy/Makefile                           |   1 +
 drivers/net/phy/xpowers/Makefile                   |   3 +
 drivers/net/phy/xpowers/ac200.c                    | 314 +++++++++++
 drivers/net/phy/xpowers/ac300.c                    | 387 +++++++++++++
 drivers/net/phy/xpowers/acx00.c                    | 621 +++++++++++++++++++++
 drivers/net/phy/xpowers/acx00.h                    |  28 +
 8 files changed, 1530 insertions(+)
---
base-commit: 31f961de2f90fbf52eb2d4e15b3eeaa09f9b4fc2
change-id: 20260802-submit-acx00-of-dynamic-v1-94a0dc15f282

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

