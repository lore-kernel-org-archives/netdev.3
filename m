Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F4B2D6E5A
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 00:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788999345; cv=none; b=ueuFk1tmt/MANgr1Z7UFqxCKYqlqTG86rTvhLrjR1aIZHiGK19xwHhU5TpTY0NEYRoQ4Cjp/RDDHzuBQJp6T+NFPgV4IrDWz9eDghEw9sduKxkC8n8gHrRm1Pg83R+DxMEsJ/ya+xuo9PLtyxLhvzlJ2fppIK1nVKlr/JoJWenA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788999345; c=relaxed/simple;
	bh=bQEwCUwu6UFhQr1VKp5lGdygarq3KN18hAVUL2QRnfg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R1LXcDibJlvH2pwTPTLT8KAY1dNUeunhW4h9rDRg0Gf0ciYwDQlWJ7GrLPR+WTU07iDALaT2KDmqapvLxAWWYGBeKtsrTaVjcmVCRJ86kAEFWOGS4BmwuChxB/Njiq2jftb+1aAQ+s0am1P80Cg133az/KDJoanbdLfb28rxOWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qPRkXti/; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPRkXti/"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7f84a55cc06so5064686a34.2
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 17:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788999342; x=1789604142; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EOu9q3ToCrOpE6VnlTjGYtngDOdcvSQmUOESawM7bB0=;
        b=qPRkXti/9UQvJnylQ4MtgSfy6k/RMbCZPrSVdaGNBEsnV/Iq3j+JAnkbtvl2OlRIQq
         kjUD8s01r6Gz5xwX5/79svPMMHi3f3GUzMQGpD8t1flzgpE0wlQrd5G7Zm2h1FHcUcaG
         pgw03mTYHOgkmFMyKRpBTWG5yROnLwVbWVKTc/g1VjzGHluAuO6qN5LCusnjooLXattc
         ZW2fFEx9fKMuqdW9O2pUr/jx9xKXjD/ubXTbKyGfi9yimn4CXluWcYVkMB2tQu8DeMu0
         YYp5V3zEQ0RZGK1BxFtSTOmdfeEA7cmFD3MmRukXzPp5axSsYKITIg58mk9/DjhM/dGK
         ffTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788999342; x=1789604142;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EOu9q3ToCrOpE6VnlTjGYtngDOdcvSQmUOESawM7bB0=;
        b=TqAVruTHKGCOoRL4EzCFfqxH7esuJMH87H0BEwlEGa7IOwg4BPCjQs2fLAXb4fymzX
         hlxJs6kXPi458E1t+i72cQj+x95ehowQc9goJXYQrK/9j0kuXWxEFhDQeMoNUhkNo0Qb
         ActTFmGVLIKQW2ExxgrBvCsFwVhvUfMLRa89XLs+PcqCm6IrzE/0sfYOiUkp9yEnJ51I
         Wnl8XnO0htA6IDfIOjnnJglis/Dh7ascFn+iURg/y6/JVZ1pm1Ad3uRNyxZqpHHmTDk7
         H2O+linr/8oEPWMvl9gQWi9p70zzuX9y9QUTLoexVIkdyJN6aNAwsSii+yypFVHYhHjO
         Tdhg==
X-Forwarded-Encrypted: i=1; AKwUvBz2LlaR94cuRESQKt2P3yyTkbCcVsODRp3pvwD68lDvz9/pnPpGAKNx25aFW4oV8PkRC8chvm8=@vger.kernel.org
X-Gm-Message-State: AFuF++nfwn1fmNYbg5GaYCJcDr0kqW2GI2ZE3qeVmddWIOMSUZfBWzZz
	hFXAKNSbaEgutUKsIQH4dEkDUxZDJK1cxqRXlM8XpcBmMfKzdboONJMH
X-Gm-Gg: AYBFou3xSGCCdvF7DWdj060ojvRYvCflT1oCNiqsSsrtMw5UWWbuydg+h0NgKfxQV62
	n5rn465PQrSFfaxOZcjYqc8rf0mm677hP0Z7y9JC4RIOo/muTp2bqF7AS33rZ1VyzognyME9ZEW
	QkwpO4TS2IdVtbLQ5nJEUV/w60AHdTVrtUaFU05vzMTHa5vEDvOblJicdU29xOEN+ojLhSG2hR2
	IW6RBZvRWcp7BgWQkM6Ya6HZUfXFU0tRvxISzbpAy5yRPoYGLqVQFh7dBKfdY7M1UGmQVexxVkq
	zqzUXuVoMKXBI8bfpHXFnlLI7xqnEdNp1X/dv5zmQa0wVNjbaaFDLgvYfMlglEwB5p/HJULXTae
	8lYZHo6x+tO8bhd/BplUIsHiPMXR06fcfNMsnMxD1XfdFX5aY7PESu4LMeSQhKn1GNuHTOHYfLC
	36KuNsFMoQd31sxmWeiPDu4uExIbXvDrpB7bemdBZRlnnMYYpKHziCCsnRmGZtCSri28yRD3Vy4
	qZvVR/TQkzcIkYrTwesmVVzu0cwoB+eyLp0v6T6ZbP3d7XGft6TFYli/tFpkoU4zsmqAIUze4M6
	FF3rKjujoTikrL+z40ieIomGzXK5G72Q9KX5zbv7y3ghgzS3w58jJgtCEo4ao9Po9EwPD2TxmjR
	ERyXSRwMMpOsckjVN5FtqFYS8WZ1wCizwcnDwvy8=
X-Received: by 2002:a05:6830:6aa5:b0:7e9:cf6f:aef8 with SMTP id 46e09a7af769-7fa1fc5f0c5mr24784098a34.11.1788999342527;
        Wed, 09 Sep 2026 17:15:42 -0700 (PDT)
Received: from [127.0.1.1] (184-96-151-165.hlrn.qwest.net. [184.96.151.165])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7fc68d5ae2bsm12468402a34.3.2026.09.09.17.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 17:15:41 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH net-next v11 0/2] net: phy: add X-Powers AC200/AC300 EPHY
 support
Date: Wed, 09 Sep 2026 18:15:36 -0600
Message-Id: <20260909-submit-acx00-of-dynamic-v1-v11-0-eb45e89ef918@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43RS07DMBAG4KtUXmPkGb+74h6IhZ+tEUlQEqJWV
 e+OE5CIghRY2p75/tH4RobUlzSQ4+FG+jSVoXRtPQA8HEg4u/aUaIn1giBDxQxDOnz4pozUhQt
 jtMs0XlvXlEAnoFY4FgPIjAZJBd77lMtl0Z9Jm0bapstIXr5eqvOawjjbc+25DGPXX5dBJr50f
 EfKvciJU0Y5Bo7AnMoon06NK2+PoWuWoEmsKbVLiUpZnzFrIUBx3FJyTdldSlbKZwfZSDAezZZ
 SKwpgl1KVYojWW+s4ZrWl9P8pPVM8S29Baxl/7cqsKb5LmUpFzBAkJqO92FJ2TZldys67MsFE6
 yKLhm8pYD+W/eMLgc1zRdSYGPdS6DV2v98/ATpDO+bwAgAA
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

  https://patch.msgid.link/20260907-submit-ac200-mfd-v11-0-58dd9dc7f69a@gmail.com

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
Changes in v11:
- rebase onto current net-next
- document the little-endian NVMEM configuration format and require
  two returned bytes for AC300 and selectable ACx00 packages, while
  retaining one-byte calibration cells for fixed AC200 packages
- restore standard advertisement or forced speed/duplex after a failed
  package suspend, in addition to the vendor settings
- power down again if suspend recovery fails, retaining the original
  suspend error and the existing phylib and package-state locking
- update the companion MFD reference to the submitted AC200 v11 series
- Link to v10: https://patch.msgid.link/20260906-submit-acx00-of-dynamic-v1-v10-0-dd272e03b547@gmail.com

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

 .../bindings/net/x-powers,acx00-ephy-package.yaml  | 170 ++++++
 drivers/net/phy/Kconfig                            |  11 +
 drivers/net/phy/Makefile                           |   1 +
 drivers/net/phy/xpowers/Makefile                   |   3 +
 drivers/net/phy/xpowers/ac200.c                    | 314 ++++++++++
 drivers/net/phy/xpowers/ac300.c                    | 387 +++++++++++++
 drivers/net/phy/xpowers/acx00.c                    | 633 +++++++++++++++++++++
 drivers/net/phy/xpowers/acx00.h                    |  28 +
 8 files changed, 1547 insertions(+)
---
base-commit: ce48a0fdc56464b1afb03471dbdf38a5e0d571ad
change-id: 20260802-submit-acx00-of-dynamic-v1-94a0dc15f282

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

