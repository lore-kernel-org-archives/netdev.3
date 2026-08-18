Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96D825F988
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 06:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787034150; cv=none; b=mqWbxhVWttueI4L7lfqWUHgWgor983ww4mUHVt1cWM9VSlK8Ml6cMZ3JmbxS4D7MSnTO+lQ3KZm4NLFFkdZYi1/2bh3psTRiMipnwijq2/yOckoJf/WcYtiQb2zh285XDr/G9zZJEOGOfrKyRZWeY8Np4czO1+ZgEgo6TwLrk8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787034150; c=relaxed/simple;
	bh=HMQRl1xO1pQgDaOrasr5p/JsAw5vG952dTH4Kygaz1o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eJKIQLvQ+8xUwx7W7zsix1no+tK7jNotHPRDmW6uR1rrItK8k1Zwa2dYKRebHInfC7YWUEgN6qY3H5tWtrrKCYibie+FimPg7XTWM1vgGyw2L7TIZwKbYbMGmh+R4ZcpKBSBlBeCqaGyEYMcjOg8NDCanuIYzkvzoYZSdT3xw90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6s0s2Or; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6s0s2Or"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7ee4399c423so2886203a34.0
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 23:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787034147; x=1787638947; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cGK9IFeXLvf0lFLy1aRVHiXrOYJhbnpPNozOUWjwiiQ=;
        b=G6s0s2OrCtJL2+TaHNz9NctOn1A4x0FOvnNX7K4AdmdQFdUz39YVXbfBMoFxQ2gmu6
         onuPCK05ddUrcPPg53nmXFnf9ozUzIm1QZJZeWCYHr5UMP1OJIT6puBEN++0Wvj2E3eD
         HpsuJDCtZOw6vHZ22tK7yHT11Lth/K/pNILw2AASc0fQezzTB9n7cxq79RIqADVqrBmi
         EV2xUfAhnLYx8AnjHXm5RlZhrsWYL72rhsA1arjg14y46lIupHPvvPfqiMO1PG4Ys4m2
         vc1kNj8VHD7og5TA60wkvfSCunOwQgXpTw2mXfs4vvqlCT0/pEe2wjcU6OffrtsKqFZ3
         eK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787034147; x=1787638947;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cGK9IFeXLvf0lFLy1aRVHiXrOYJhbnpPNozOUWjwiiQ=;
        b=KSZNjXW/WnBmkeiDuRj6kAV8Ki9WPdUOYegozzM36wmLMd1CmyQwCjc3ijLC4yvptQ
         Ky2VPWjW3wAb6co4f2L50bph/tJ/tr+DSMsSIup/C1bnKLZBahLpL6RAX0MOCvDpKHWd
         y8co5XKr9wUP5srar6GNdaYqyee/bw2Jy6iz/8hC5TG6n2qLwWNJSFbyIzfxMVSK7yq7
         /y7YakJYt9zgo8vsxo1TusTVRcsgabJfQniPFbaQTdZAEH7WMIQUTUsnf6/rHvDqwRFk
         fgqdlxAp5auBLFWseSCEdyx7t/j0OfskrsGotyN1iCdPy54f5mM1/2+FSqqfjofAoXh6
         n6sg==
X-Forwarded-Encrypted: i=1; AHgh+Ro9GWFxcQeC02PjMDeDmk5RfsFFG1NAOvGiElKK5vSNPPjAn4zc93ZB9xo7FwlfTAKjLnSfIP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1SZv0DMtF0TVpMVxcKKlB1YZ/KyrRSvtXevSJtcyBPLkjCDHf
	ENqvUCXf2NuiwLaQPo2gVkW9vhKENnt9Omw9Rn2Ot5sF6I27K1/qplom
X-Gm-Gg: AR+sD10ah2kWe3wd60xXHt+sgoT+P+zAFoIUXTpT1tkSQNS8e7sr7/cngPD2O6CxNc2
	KPkAavnWmEwMI/o7TG1wZzuMWPXK4qwulrQdzNWYP1SynRu4ISVCk65Ti78DYwPdESp7xkUck6O
	GZ7w4p2dCcZd8d/6/O7V1YAgrm16pEtl+9Jt4mmqyO5eBFMG6pXkTF2xXfEJq1btU6Bx8zCimwf
	KZZlB+4+XlVLNFQ3vgqEWqz3B+DudK2XrB5QNmqzcG5ZjyKskqcvj8gkwXNGXDnBwJ4VfEYEpL8
	NaqTe9EPb/jC9Tltuwpm1ANhKQhAJPZsfNJ/K6srufMNfYwEBCknMPkAWkyaFNmZ9CQnPILWdtt
	oV9awyjMRYtCsb7ByUx25CGU5fKaM1lumHFdrAOiYSJQEqs+/ATU4PkMZUm4qTv5L4YETjhCM77
	6jNy11UjSJqXhI+6PW/jPVsRdySciPc0iMRqfFMqyH003DYp9kBD25Hin9EUIVW8RzcbK5Xaj6R
	7i9bAfARJbsPmidJdRWEdEDJZEzN7M080Rli5+NxVd3Xlljt+3XGYMxivz6K2l4tPFmGwVWgI4L
	JRwo/tfYW5lLQJhmT57iGWjR7IsGI+K+VQz340CjzJDzXkOzYcSDLhihwKpxxrFHKMnn72VzBd7
	K20iIcmHjrSO0Tm0Q
X-Received: by 2002:a05:6830:668d:b0:7e9:e0f3:b914 with SMTP id 46e09a7af769-7f3de68909emr32734122a34.13.1787034147485;
        Mon, 17 Aug 2026 23:22:27 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f43189775fsm298085a34.16.2026.08.17.23.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 23:22:26 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH net-next v9 0/2] net: phy: add X-Powers AC200/AC300 EPHY
 support
Date: Tue, 18 Aug 2026 00:21:15 -0600
Message-Id: <20260818-submit-acx00-of-dynamic-v1-v9-0-b8c8d9ad0d83@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43QzW6DMAwH8Fepcl6mxPnuae8x9ZCEuM00YAKGq
 CrevYHtgJiEdrRs//6WH6RPXU49OZ8epEtj7nPblMK9nEi8+eaaaK5KTYCBZpYB7b9DnQfq48Q
 YbZFW98bXOdKRUyc9qyJXCBZIAb66hHla8XfSpIE2aRrI5adTnI8Uh8VeZm+5H9ruvt4xinXjN
 1IdRY6CMiogCuDMawT1dq19/nyNbb0GjXJL6UNKFsoFBDRSci1gT6kt5Q4pVaiAnqNV3Aawe0p
 vKM4PKV0oBuCCc14A6j1l/k+ZhRKoguPGqOrPr+yWEoeULVQFyKOCZE2QW2qe5ycSuXyaVwIAA
 A==
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

  https://patch.msgid.link/20260811-submit-ac200-mfd-v7-0-8b06f552a4d7@gmail.com

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

Validation completed for v9:

  - dt_binding_check for the PHY-package schema;
  - an x86_64 allmodconfig composite-object build with W=1;
  - a built-in AC300-only configuration with I2C and MFD_SYSCON disabled,
    built with W=1; and
  - strict checkpatch checks with no errors and only the generic new-file
    MAINTAINERS prompts.

The AC200 v9 path was hardware-tested on an H616 board. The provider
reported revision 0x101 in package 1, the PHY resolved its regmap after
establishing the supplier device link, and RMII negotiated a 100 Mbps
full-duplex link.
Eight MiB passed in each direction with matching SHA-256 digests, and 100
consecutive pings completed without loss both before and after the rebind
stress tests.

An administrative down/up cycle changed the package regulator consumer
count from one to zero and back to one, then restored the same link mode.
Five AC200 supplier unbind/rebind cycles each unbound the PHY consumer,
recreated the device link and recovered the 100 Mbps full-duplex link and
ping traffic.

The separate 100-iteration supplier-lock stress result carries forward
from v8. Each PHY bind started while the AC200 supplier was still inside
its 40 ms probe delay and holding the supplier device lock. Every PHY
bind waited for the supplier, recovered with the correct PHY ID and
device-link relationships, and the final link came up at 100 Mbps full
duplex without new warnings or probe errors.

The AC300 results carry forward from v5. On the connected H616 board the
driver selected AC300 without accessing the AC200 I2C path, negotiated a
100 Mbps full-duplex RMII link, passed eight MiB in each direction and
restored the regulator, package state and link across an administrative
down/up cycle.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
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
base-commit: 47226bbdef69fc0de815b8f5b81b39673f50bbee
change-id: 20260802-submit-acx00-of-dynamic-v1-94a0dc15f282

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

