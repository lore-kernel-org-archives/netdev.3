Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7837B1A3A80
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 23:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786490925; cv=none; b=Hf2VRd0sJ4p4B1gLywKulnrrkWNbCt0HtlAHRfnMzvFGDpsxgOTeCRtgRSUGtdvfCpYXnrXBUT50cXujI2mryuSFfdUNfHipx6eP0I6NSVUJEDE5Bzg1O//7SuUYVQwICQu4RtkS+HQ3KG0ypCGvxiipBUBsiRop11nHZx+KEvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786490925; c=relaxed/simple;
	bh=V7QZSNNrm5EPZarxIq7QBxVGp51+67djjQMqb13XWyI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WBpEcJBjuctgR+ar4CwDRVhOGPfLzTaZCuDOtovpmJRa4nQtQYCzpY0N5qCczXLKpxCa/wp30NjQpBKSrP12UIHFyaq11cuRsaSmqr7c44j5cyCcNXlbQmmlDBhckCK9fqMCvdCnIgmC4z8fQQcgRWWkWS7cHVPnnsir4rgI1L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSpqDgIK; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSpqDgIK"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4b1bf68b387so207074b6e.2
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 16:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786490922; x=1787095722; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YvGWxyJfy36RWg71hRYKStrfFlFKxDjNbNkOcgLCdKs=;
        b=lSpqDgIKDbBtnD7YbWOF9+CkUZSF1r/fNBaAVXkCYjwpIlgyqDvNu50ghF/CoFT96j
         15sEEadb6Oq0yUx/LcUOmOBZ50H1EuEj6edmZMHRtAet9Txcm0iZtliv9wcqAS58Mocs
         KDnYgaCqnNWltdrn2mAsPyXMk9tgzxy7r0Cbjyu9ZJ+Snq5vIOWKk2xFotf0nviLnVem
         ddcpTHVTEvad7agvBMu2PNpO+raATJoN1KpZVqE/kHDfQc2zBJEZAo2s3AUMrL4eoDwE
         vi+dEeGGeM23CImgIfYAYpDbydznpb6kw4LUNqaRhBlHA0AHsFURokXwTBRiGuKdL8ot
         EsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786490922; x=1787095722;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YvGWxyJfy36RWg71hRYKStrfFlFKxDjNbNkOcgLCdKs=;
        b=m4W9OzyEIcYTl/H2KhKRjaMHhk+/NUqon3XkOE6jMniAz2PmY0KHwkuTJaq+fZhucu
         9x5g5GvGZpuLu18cakqa3mOtvql0KSQdFa3wuvi9oLilJ+gnJdbyQCTxCxw/ynD/Dvjr
         M6WU/XYyKUfdj3drOrsmbJm7v9/cf+ra7yT1cmohrP/aJvCpQvRnoChMer5CvRwkEwyg
         nId5g+R3BBv2yRV4go8j8t1kqMBkk+Mn+QGwu/asw+p+qgW0NwxD54uFhFNx96pXEo5O
         iWejHlhWqiFzmmwkQWYMXgzTEwmHNHZfU+IeVVadIuvS0kJZ2udRzdTuv0Ykwjca1ubO
         Agfg==
X-Forwarded-Encrypted: i=1; AHgh+Rq9VJjm0r1G1n6klGggFAZwCsXUpzU+izqENKzTiyLLhxAbyA/E/ypoKBVS84FkyLJugx7xdvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfgy97WUSPHNFgvXFFACmpPG2vm+muRonJuI963jhYMPaEcr+a
	LXb136HcZpP8a9ZlW1afgvo8QFYZk3ARomXP2OW1Blf4kYcKN9EKzhou
X-Gm-Gg: AR+sD13tY+WhWOyfMXAfc5+vqPdni+rqIb1plAYpe1TlvUkTe+s7J7Bs87FNgM+4nGx
	iWInM9jHf54GJ5cdj8fy9YgJFWk7WFVJU5cImZUZE/Q8neAVpTfpX7RZG/noi4BrAz4A+qYsDAA
	k1ds5PpssNN7dDKhVM1r/dyWa3up3fd82IRN7O58kiCfb3fcOtwh+0ddzjlNqi7Zh5C66aDnqcB
	qnEb0z9Spbci3N294MdFpSW3GbgW77btcxm7HCj3yxr1yN0icRN8cTxEoU2lOjkRWyW9yszIDor
	kz7sVRN700x3ZI5xUYsWDzRHODNHn9P/rPGKAora0rvithIFhurjtFg4BsdrabViU8+ZQXqffcP
	evSv1s73A/0aFlFAqJvREqmNZ/LmEIBI0ApZNIe9M2bfQo/mNpZaachuS97uV6tDZrjcoR59iWW
	YhAXVhwNvMttra/FqdsjyQXQ6YG/MyuYiDDsRW+Nmop9+vYntntZ6QgL45naDaGdY1HKW3jtXmQ
	h7TdtPeaFe/OcAH739LBplTherYHqYnoXekJHITJdqM6pD8q7oFb/8hvJZ/7waJMPLSNkYvDc9I
	LvD7KV0e2JhAt9H2wi9T41LPy7XpnTrFI2YJh6b1Qq4AgMJzwB1LRhkTHRJTMfUDUrvIzxiCguN
	v3HkPgRkA14iK9UMz
X-Received: by 2002:a05:6808:250a:b0:4a3:d333:2258 with SMTP id 5614622812f47-4b210b7689dmr681461b6e.14.1786490922189;
        Tue, 11 Aug 2026 16:28:42 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b20019e83csm1888484b6e.16.2026.08.11.16.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 16:28:40 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH net-next v7 0/2] net: phy: add X-Powers AC200/AC300 EPHY
 support
Date: Tue, 11 Aug 2026 17:28:31 -0600
Message-Id: <20260811-submit-acx00-of-dynamic-v1-v7-0-03f5b91775d5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33OTW7DIBAF4KtErDsVDD8xWfUeVRaAIaGqcWUoc
 hT57iFuF1YWXj7NzPfmTrKfos/kdLiTydeY45haOL4diLuadPEQ+5YJUlS0owj51w6xgHEzpTA
 G6G/JDNFBZaCFob1jMmCHpAE/kw9xXvFPknyB5OdCzn+T5nx5V572c/cacxmn2/pH5evFf6Xcq
 6wcKHB0HBk1KqD8uAwmfr+7cViLqthSapcSjdI2YDgKwRTHV0puKb1LyUbZYFjoJOssdq+U2lC
 M7VKqURRRW60Nx6C21LIsD8/YekvBAQAA
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
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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
managed device link, and takes the supplier device lock without waiting.
It requires the provider to be fully bound before retrieving the regmap
attached to that device. The link then keeps the provider bound until the
PHY consumer has unbound. This uses the generic device and regmap
interfaces and supports multiple AC200 instances without syscon or a
private cross-subsystem API.

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

Validation completed for v7:

  - dt_binding_check for the PHY-package schema;
  - an x86_64 allmodconfig composite-object build with W=1;
  - a built-in AC300-only configuration with I2C and MFD_SYSCON disabled,
    built with W=1; and
  - strict checkpatch checks with no errors and only the generic new-file
    MAINTAINERS prompts.

The final AC200 v7 path was hardware-tested on an H616 board through a
full Buildroot kernel, FIT, rootfs and SWU build. The provider reported
revision 0x101 in package 1, the PHY resolved its regmap after establishing
the supplier device link, and RMII negotiated a 100 Mbps full-duplex link.
Eight MiB passed in each direction and 100 consecutive pings completed
without loss.

An administrative down/up cycle changed the package regulator consumer
count from one to zero and back to one, then restored the same link mode.
Unbinding the AC200 I2C supplier while the interface was down first unbound
the PHY consumer. Rebinding the supplier and PHY recreated the device link,
restored the regulator and renegotiated 100 Mbps full duplex; another eight
MiB then passed in each direction.

The AC300 results carry forward from v5. On the connected H616 board the
driver selected AC300 without accessing the AC200 I2C path, negotiated a
100 Mbps full-duplex RMII link, passed eight MiB in each direction and
restored the regulator, package state and link across an administrative
down/up cycle.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
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
 drivers/net/phy/xpowers/ac200.c                    | 313 ++++++++++++
 drivers/net/phy/xpowers/ac300.c                    | 387 +++++++++++++++
 drivers/net/phy/xpowers/acx00.c                    | 536 +++++++++++++++++++++
 drivers/net/phy/xpowers/acx00.h                    |  28 ++
 8 files changed, 1433 insertions(+)
---
base-commit: 31397cf1819210bd63fa3d2c7d8c24f7c8667d99
change-id: 20260802-submit-acx00-of-dynamic-v1-94a0dc15f282

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

