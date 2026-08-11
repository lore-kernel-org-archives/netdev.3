Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63C8412BFB
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 08:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437441; cv=none; b=RiMVlLNF6BaWN9G97A2vV4kOcohg+8fnPsC+8yJQJqlOcy28/zQn6ekxm0Y+gjY3g+dJf1lGna5ZTFq9e+UYqlP5CrSlNMofLwK4mYDtVn8Bs9UWItLmgWLMfsbGQ7DzOvax51wBG+DIgOknFIeHaPnxBbIbm8zxttR3XqRAzzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437441; c=relaxed/simple;
	bh=UMeC2nNawriuN2agI9CCFQvbb+rGitHM6dSpawNJukU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K8+0UD+SJR9yPIqKYi2QVs/WHgXchbrJGjH01PuXaomAKIdI4EiKPz5jHa6bwXbNTCBj4ro6gX8CyT6jxgAOS8LDwIh/eS4nMmcOtG8lQ/ACotK7gMY+7XkvTqMOyD59Iy+slu9UJ9U5oRkg+JQpu6UUBumAH96LcFM8x9uJ6kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pnQfHSCE; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnQfHSCE"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6ae542c486eso959677eaf.0
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 01:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786437439; x=1787042239; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PaynSIb+oRPrlMM6/Hyd5uqz3yGFICmpRjFgmaJP7mE=;
        b=pnQfHSCE/Vjwc7MuGy244O3FbCXq5NAX3MDbgCZcIh4SufUbPZkLYtfke8Pqe9LUvA
         5E7g8JyObY1wJZ5o2zcqA9EF37sAiyeEBWsb5yXfwRbArmvRxBUr9hiAS9mSTP2OZ6lZ
         tn02ZKStG31FIJXppaXFxhaqoRw3E6dlBbn0+xI9JqH7MxZwCh7GQYXHk8L9NeRzqCYz
         jM3O2l4IJWRXDI5VfJZ42EFDvJ7JoxpWyQeV3bcLvjp76sF+hKucH08lVMcR13ZqmRrk
         ZZDZ1nbiqhwwUVRGMJl9po6k4o5JxJ5+350mww4dL7LUUS2+hMxbhGQfXb8vVbZPfMIM
         oRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786437439; x=1787042239;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PaynSIb+oRPrlMM6/Hyd5uqz3yGFICmpRjFgmaJP7mE=;
        b=YjcXD9kezdMcbYlufj7fpSBisCfzo43CqDV7e94/M1oF7HKDRNdypk+ADFHk1+Hw5F
         BJQXOnRWJKoPIMvZhTZr3CZyBUE8Yi+RHdI4/JNCf5gJ51veBof4wyopqOin5stsBD/Y
         SnuaGs2kKiOeP2XP0SrjY+skDHj/x21Qn+Y1aySkSRZtw2j48c1hTaGtd5sPuIdSTjFu
         GVn+dgrw3gSIOElQjiYmaujBfIT8Asdfm9u3vAED1r90CYOjpHMCLMcrJQR03dL/Cl6V
         FiqpWBWHJTLjVPaCIk7pKXlBMFAQ7zLy1/fpwUgb99IhN6fTYVJlI72CSLSRHgd+FT/W
         dqjQ==
X-Gm-Message-State: AOJu0Yy3emusd5dDQyPPZzVUkNxxdTO9McgV5LUJA8EfAAH82LqBHPYu
	89Wmg1bv4LHF33THEm0Smmep3oveTW/49g23LlbBgH0DmPM4Swhi8FDG
X-Gm-Gg: AR+sD11TCi+6wQDmcWY9Kf61xUEDcN+sot9GoVOtW3Bbs7XcqNJJV9Ah/MSEZFivl/N
	H4wTKZEqr/tc57eDRMJ/iRNPn+fFFDwW4Rz7XVQYl0AOVXl5aw0YH9QWq0wzUyL1G2MbCndKOwJ
	TYCkufbY4hB23qGHajN4/RxuWVYanj4aiX+Du9PX/mxjiuqvdNKLik38dcgN9EQk3g9cZY7ygMl
	tdCrMD4LEJMkgqY5R57tq9NOZQP7raMaxTMfQRqr/FizQ4w33WxzW2+ZJSVoV2tUpJ+iZR5bT+F
	INS++IEDamisSUYer01gpvr3PZePPYK4/m2jht4qEPjNCXTlSLYlcpAZOr8G3hqBf6VLLoXHbz5
	CAHdwMLkHKma9K4LAHxacgp81O2xljQvihieTSlt6Zi14qe0Xu70EmE0No4QLxKIoohogWPJX9g
	HITkbJCrBCtCgjx9638cEwFpLhfMnUQe6GG+Qpc7N7EEyxR1OstOGW0Fc6q5ndeD6virTwYwEBM
	5I8+kN13CQK9M0yTBQom9I000KvWGTjlPFLtggFkhHLG/5qZOcHi7yNm215DHgzZM263SvlOxSI
	C7GAuu7X3LA4B7ceiYrlQP6rBG9qdzoJiaZcW+efkNhB0Xk6fBoye+ogEeIYPghlhB2HB35w5Pd
	+DyiAMWJHy+TvsVPIQPOgBWXZyvkQ
X-Received: by 2002:a4a:e90c:0:b0:6ae:4913:7d11 with SMTP id 006d021491bc7-6b0a31b0871mr666156eaf.22.1786437438617;
        Tue, 11 Aug 2026 01:37:18 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45e1d8393e0sm738613fac.12.2026.08.11.01.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:37:16 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH net-next v6 0/2] net: phy: add X-Powers AC200/AC300 EPHY
 support
Date: Tue, 11 Aug 2026 02:37:05 -0600
Message-Id: <20260811-submit-acx00-of-dynamic-v1-v6-0-0229b99a32f6@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33OTW7EIAwF4KuMWNcVmJ+SWfUeVReEwIyrhlSBo
 oxGuXuZtIuoiyyfbH/Pd5bDTCGz8+nO5lAp05RaME8n5q8uXQLQ0DJDjoZbjpC/+5EKOL9wDlO
 E4ZbcSB6qgE45PnihI1pkDfiaQ6Rlw99YCgVSWAp7/5005yP48rAfu1fKZZpv2x9Vbhd/lfqos
 krgINFLFNyZiPr1Mjr6fPbTuBVVtafMIaUa1fUR44tSwkj8T+k91R1SulF9dCJaLWyPdk+t6/o
 DXdxUt3YBAAA=
X-Change-ID: 20260802-submit-acx00-of-dynamic-v1-94a0dc15f282
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2

This submission contains only the networking binding and PHY driver and
is intended for net-next. The AC200 I2C register provider and managed
syscon registration support were submitted separately for the MFD tree:

  https://patch.msgid.link/20260811-submit-ac200-mfd-v6-0-c5b1292c8498@gmail.com

Neither series has a compile-time dependency or required merge order.
Their only shared design point is the DT representation: the MDIO
PHY-package node references the separately described AC200 I2C node for
package-control register access.

The AC200 and AC300 contain compatible Fast Ethernet link PHYs which
report the same Clause 22 identifier and use the same link-side register
layout. The link endpoint is inaccessible until package-specific control
registers have powered and configured it.

Both variants are modeled as standard Ethernet PHY packages with one
forced-ID link-PHY child. The package reg value is the link address.
AC300's control range is a fixed package-relative offset of 16 and is
accessed with the PHY package helpers. AC200 reaches its control registers
through a phandle to the companion IC's I2C register interface.

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

The two patches add the AC200/AC300 PHY-package binding and the combined
PHY driver. Board Device Trees and optional PHY features remain outside
this initial series.

The AC200 portions build on earlier work by Jernej Skrabec and Andre
Przywara:

  https://github.com/jernejsk/linux-1/commits/ac200-v4

Public AC200 and AC300 documentation is linked from:

  https://linux-sunxi.org/AC200

Validation completed for v6:

  - dt_binding_check for the PHY-package schema;
  - an x86_64 allmodconfig composite-object build with W=1;
  - a built-in AC300-only configuration with I2C and MFD_SYSCON disabled,
    built with W=1; and
  - strict checkpatch checks with no errors and only the generic new-file
    MAINTAINERS prompts.

The hardware results remain those from v5 because the driver code is
unchanged. AC200 and AC300 each negotiated a 100 Mbps full-duplex RMII
link on H616 boards and passed eight MiB of traffic in both directions.
AC200 also passed 100 consecutive pings and supplier unbind/rebind
testing. Both variants restored their regulator, package state and link
across an administrative down/up cycle.

Assisted-by: OpenAI Codex (gpt-5.6-sol, max)
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
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

 .../bindings/net/x-powers,acx00-ephy-package.yaml  | 154 ++++++
 drivers/net/phy/Kconfig                            |  11 +
 drivers/net/phy/Makefile                           |   1 +
 drivers/net/phy/xpowers/Makefile                   |   3 +
 drivers/net/phy/xpowers/ac200.c                    | 315 ++++++++++++
 drivers/net/phy/xpowers/ac300.c                    | 387 +++++++++++++++
 drivers/net/phy/xpowers/acx00.c                    | 536 +++++++++++++++++++++
 drivers/net/phy/xpowers/acx00.h                    |  28 ++
 8 files changed, 1435 insertions(+)
---
base-commit: d67e5dbda22604d0fcde32fce58c65f88676e676
change-id: 20260802-submit-acx00-of-dynamic-v1-94a0dc15f282

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

