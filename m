Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77383B8BD9
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 21:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786658062; cv=none; b=ecaoPclnBw6g74TCJvOW2Mu9FP2Ea4OJ9HpUrmFVZ75feQ5QbS/cISQCk3BOnO+9qoJgQrXOCeNu83Oh38QfRHBvc2CSTy0TsKNPhc0k+mch2250SNZpOI8chelHpDpp4/oGPW47YTV2WNaE2f478BuISbS5a0e5QCk3N2iy420=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786658062; c=relaxed/simple;
	bh=4dRDfp/kyPwf0LgyQHpXbx4TCvBGI49n8pG+S2ph1zw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N8zpWhpUqxtnFNn26x2BLt7ZqEVwBgb33ChIJrJ10D9hwL11+4I1iqCwAJK6f8RPVCfLP0rE/KvBKYzzIFSTgv6qVyHpzpiVn6lvN9Z+QyeFmkithvGSsJvjo/TkU3XLxuAIvU9PCLnOOoL/VcduQxNoKM10+XxesptWuF9bTfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iX3ukOJu; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iX3ukOJu"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-48a0ca07c38so198415b6e.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 14:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786658059; x=1787262859; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Gd42AGplC+/Rht4wVTsbu7hNJIC1tcUERjT9kA+1fFg=;
        b=iX3ukOJuQbLcKv2J9x7LPq7G7mFwDkqPwWkjlymK1nT/ECd1Me6lTRYusHdao1i+7X
         ZTbRiRD3tJKh69V23BSehNXC1bkBgAjndJ9x3mheqzDOG338d8iTNLna98v6+ftDjFQX
         TW+QmTEdNrWT8IE2Pdj3gp7lPXaBECtaL5q66FCOfgloYKarY8ro4txRDe0+G+nvnLhw
         6AgqioNiOrhcVvuwkDAWOD1RXsMEubzJab8HNalYVxm1qu9wnSDIzAOjtnIXEQmjrxpI
         ah7h548hOj9IkBWt8FNosV9kd3dk3oX+0nvHX7xuSuytqXg7oEYp0mgjYIQk6ECVfqWb
         zQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786658059; x=1787262859;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Gd42AGplC+/Rht4wVTsbu7hNJIC1tcUERjT9kA+1fFg=;
        b=ZcQezSOAbqn5PloYbJPEPXFdvZ+6gvMf3qxs8jvthsg33DtEr0GnZQ87G+XNYcVDnP
         DXd3OOIbmSLtIf1tEs8GoCpBL3RzIj7m0PrfB1RjBUCXbgH1rLDU0gxnHERITwkB7oUB
         quUCRjAGbNq7rgWhNK0LtQeaRtpnlQRgK9ga2syoW9iRZJzJpj8wvXxzu57nMQ8mCRrb
         eOsJxOdc69pQSxVQySMbww6hEpMol59pdmf72AO7oFE6fbBT7Z2yCXFQKmRUJZr2Ypvp
         xv5L3f8WL+/u0sMkIesZffRKbYBXP6y6cI2stL6LVdW1kEaJkdm1C4nd42d1EROtgVu3
         5NSw==
X-Forwarded-Encrypted: i=1; AHgh+Rrrir/e+MhdqWZf0+my7x0PNyifq3c9Y9EZtB9cG5pMNlLPqZVczGHINAy02sVJz90QjTZ3MPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBAvov0zwcl9+0K63UBWrLbNZ8myZUgnEcrqhApY9hWTqcH9Kr
	UH7+ZzBqtEHjp8kx6sh3gexIzESAwmVPgn+668Y9+qP69aOr3sk55FEF
X-Gm-Gg: AR+sD137jMy2W1qt3tlvo5Ti+qwGG5n/fD3fEhEuuFHqeBSIaxX/IWcogUNg2n5y0Mf
	lgvoCrqH48QMKgpTmHeA+W4rAmrYq280Hoqv+acHELMw8MFc9N/rPcG0dg2tvvVz3PBuvGtxp9k
	ycB2jj07pIvufGsTYIBuKhAlwXAPrxt6mlZbWTDa2KKxyvwwTx1aQezN4zCw0EzUTVQOItZNK3l
	Dy4igMMMGnkkf9ssSZkklUmw3IFv+v+gpKEKf0lZ9osijDEmfGnOsWVD6AfDcPHHdNAWo5pAzL2
	8JKiLmQjWIfUbGRLb/g8vP6VDuv9+dRNgzdm24KrAicTCU50JnLaatAPj9o/IqG+JOhDsLVPUIi
	EWJiJVe6j/GUSr/E3K8VxSU7CwPUaloqhEap57VaDNuveXx5ppPRZGZbzOQXSonvPaNZeLH5MS6
	TWB74TGhelpLpouz3hN4H+SqMKd28MmThFKsAzh4rQmmZdoOYtRjXCdzyCndDBfwCu5I2yiugR8
	G/XZaEIrFV8EFM1ok3LZ0nJRGcip5gEISU2noVYUvSSau9e3VTNDoJ+72zIRMPtbwa91bM+bhYg
	kr2ZKRILeyPEzMnhY5u1ItxvgcGTT8hcwkqDPBk06XewNWDm7jeuiOzkjTBOFqWQRCqR7oTDfMK
	IjizjdQIjD5bAZLqtSg==
X-Received: by 2002:a05:6808:180b:b0:495:f85b:d08f with SMTP id 5614622812f47-4b241cf3cdfmr822588b6e.18.1786658059481;
        Thu, 13 Aug 2026 14:54:19 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b22ccbcca5sm2813956b6e.2.2026.08.13.14.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 14:54:18 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH net-next v8 0/2] net: phy: add X-Powers AC200/AC300 EPHY
 support
Date: Thu, 13 Aug 2026 15:53:42 -0600
Message-Id: <20260813-submit-acx00-of-dynamic-v1-v8-0-d2f1c52e87b4@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43QzW6DMAwH8Fepcp6nxPkg6WnvMfWQhKTNNMIED
 FFVvHsD24FxQDtatn9/yw/Shy6FnpxPD9KFMfWpzaXQLyfibzZfA6S61AQpKqopQv/tmjSA9RO
 l0Eao79k2ycPIwAhLa89kRI2kAF9diGla8XeSwwA5TAO5/HSK8xH8sNjL7C31Q9vd1ztGvm78R
 sqjyJEDBY6eI6NWRZRv18amz1ffNmvQKLaUOqREoYyLGCshmOK4p+SWMoeULJSLlkUtmXao95T
 aUIwdUqpQFNE4YyzHqPZU9X+qWigepTOsqmT951fzPD8BPr89kQwCAAA=
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

Neither series has a compile-time dependency or required merge order.
Their shared design point is the DT representation: the MDIO PHY-package
node references the separately described AC200 I2C node for access to
package-control registers.

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
PHY-autonomous Intelligent EEE mode.

The two patches add the AC200/AC300 PHY-package binding and combined PHY
driver. Board Device Trees and optional PHY features remain outside this
initial series.

The AC200 portions build on earlier work by Jernej Skrabec and Andre
Przywara:

  https://github.com/jernejsk/linux-1/commits/ac200-v4

Public AC200 and AC300 documentation is linked from:

  https://linux-sunxi.org/AC200

Validation completed for v8:

  - dt_binding_check for the PHY-package schema;
  - an x86_64 allmodconfig composite-object build with W=1;
  - a built-in AC300-only configuration with I2C and MFD_SYSCON disabled,
    built with W=1; and
  - strict checkpatch checks with no errors and only the generic new-file
    MAINTAINERS prompts.

The final AC200 v8 path was hardware-tested on an H616 board through a
clean Buildroot kernel, FIT, rootfs and SWU build with source overrides
disabled. The resulting SWU was installed on the board. The provider
reported revision 0x101 in package 1, the PHY resolved its regmap after
establishing the supplier device link, and RMII negotiated a 100 Mbps
full-duplex link. Eight MiB passed in each direction and 100 consecutive
pings completed without loss both before and after the rebind stress
tests.

An administrative down/up cycle changed the package regulator consumer
count from one to zero and back to one, then restored the same link mode.
Five AC200 supplier unbind/rebind cycles each unbound the PHY consumer,
recreated the device link and recovered the 100 Mbps full-duplex link and
ping traffic.

A separate 100-iteration test started each PHY bind while the AC200
supplier was still inside its 40 ms probe delay and holding the supplier
device lock. Every PHY bind waited for the supplier, recovered with the
correct PHY ID and device-link relationships, and the final link came up
at 100 Mbps full duplex without new warnings or probe errors.

The AC300 results carry forward from v5. On the connected H616 board the
driver selected AC300 without accessing the AC200 I2C path, negotiated a
100 Mbps full-duplex RMII link, passed eight MiB in each direction and
restored the regulator, package state and link across an administrative
down/up cycle.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v8:
- replace the AC200 supplier trylock/defer path with a blocking device lock
- add Krzysztof's Reviewed-by tag to the PHY-package binding
- rebase onto current net-next
- Link to v7: https://patch.msgid.link/20260811-submit-acx00-of-dynamic-v1-v7-0-03f5b91775d5@gmail.com

Changes in v7:
- link to the separately submitted MFD v7 series:
  https://patch.msgid.link/20260811-submit-ac200-mfd-v7-0-8b06f552a4d7@gmail.com
- replace syscon publication and lookup with direct AC200 device/regmap lookup
- require the referenced AC200 provider to be fully bound under its device lock
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

To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: James Hilliard <james.hilliard1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
To: Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
James Hilliard (2):
      dt-bindings: net: x-powers: add AC200/AC300 EPHY packages
      net: phy: add X-Powers AC200/AC300 EPHY driver

 .../bindings/net/x-powers,acx00-ephy-package.yaml  | 154 ++++++
 drivers/net/phy/Kconfig                            |  11 +
 drivers/net/phy/Makefile                           |   1 +
 drivers/net/phy/xpowers/Makefile                   |   3 +
 drivers/net/phy/xpowers/ac200.c                    | 308 ++++++++++++
 drivers/net/phy/xpowers/ac300.c                    | 387 +++++++++++++++
 drivers/net/phy/xpowers/acx00.c                    | 536 +++++++++++++++++++++
 drivers/net/phy/xpowers/acx00.h                    |  28 ++
 8 files changed, 1428 insertions(+)
---
base-commit: 3da8c3c8b8fa99505624b65ef590482f48e766b6
change-id: 20260802-submit-acx00-of-dynamic-v1-94a0dc15f282

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

