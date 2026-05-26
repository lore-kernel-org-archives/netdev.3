Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1823CFF67
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788866; cv=none; b=ewbC6uz6fL8+yMgqQ2o99JdP8VIxCrGDzJX+b0ofsRIX52OH4hek176JDXmvq14NVufMLhEQsnEdVO1TQGxOJFkfbasFEwxqA/LzcXXHwtLKGWdxsp0A99Zv8jh3lCn+d1xV1NFHYuhh+BeZjW8MfgAhYPkHMOYUL1Gq8mSlx4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788866; c=relaxed/simple;
	bh=nH57cAhtIlF6jTxANLLAFXFaI82DuGb5RAX4rK4t7ss=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ta50GOBW3ycgVo5+bOphvat3E53GQXredTyfFGzje2TRrbrAipEUQ+N2xcTClYgm14PU4GAPf0YT09MxuklYt1nur7cK6PHsMwi1bYXys3Ym3VBmVJwyLuB8q6T+JaVPACzgDs3MnW2P+xBOR45myfe1dQWyEHVDojQ/99izTUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UD6a7s9z; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UD6a7s9z"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2061DC79AB4;
	Tue, 26 May 2026 09:47:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A9BD460732;
	Tue, 26 May 2026 09:47:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 37A4F10888589;
	Tue, 26 May 2026 11:47:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779788859; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=7jTkfxH1qqrB/qPHLazDXY10Ma6BgmvlQck/kklaK6c=;
	b=UD6a7s9z8iEfHdR0tQObVXuOF/TCx/CbrJy8p7GVrSrWAU+h5GIvHVheQHxqDDuF9ibA3J
	D/CdClny6GYD+6HoxfWaAsxAd+UwqhVuQ5Oqluye0k0KMZ12ck1lkXf9lSG4YI7o+rclgs
	Ai+IxP3VwrvkY6le0DPSsNe1jZ0bkJj+PnXcR/2iW28/1PcqZ3/2MeMjSqjdqYdUH9tArR
	JGmgCOTBtoXOophdMVP/0TkIS4eY4ZXKXLH11M71loHJJY2t+1Xr245wKtKrsm535jpgxR
	DMlhACsT9QpfqQw22I5jCF6obXcyel4ovR8+eGaV+oxy1LjBNZ8z0sHf5K9pmw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Subject: [PATCH net-next 0/9] net: dsa: microchip: remove unnecessary
 dsa_switch_ops callbacks
Date: Tue, 26 May 2026 11:47:26 +0200
Message-Id: <20260526-clean-ksz-3rd-v1-0-5b63e732149a@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBsww6KuEi1EpxqKKTRCiu6et
 HyL/x+IFJgi9MUDgS6OvEtGVRbgFiszIfts0Eo3ymiDbiMruMYb6+DR2KpTvnVNPVnIzRFo4vT
 /BhA6USidML7vB35w8qdpAAAA
X-Change-ID: 20260525-clean-ksz-3rd-5a190d7c63fa
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

This series continues the rework of the KSZ driver initiated by two previous
series (see [1] & [2]).

The KSZ driver handles more than 20 switches split in several families.
This was previously handled through a common set of dsa_switch_ops
operations that used device-specific ksz_dev_ops callbacks. The two
previous series have split this common struct dsa_switch_ops into 5
to connect the ksz_dev_ops's implentations directly to the new
dsa_swicth ops.

This series continues in the same vein and removes the dsa_switch_ops
operations that aren't used.

On top of this on-going rework I added PTP and periodic output support for
the KSZ8463 (which was my first goal). There are still more than 20 patches
left for all this so this series will be followed by three others and if you
want to see the full picture we can check my github ([3]).

FYI, I only have a KSZ8463 so, unfortunately, I can't test other switches.

The next series is going to move out of ksz_common.c the last remaining
functions that aren't truly common to all KSZ switches. The series after
that will add PTP support for the KSZ8463 and the final one will add
periodic output support for the KSZ8463.

[1]: https://lore.kernel.org/r/20260505-clean-ksz-driver-v1-0-05d70fa42461@bootlin.com
[2]: https://lore.kernel.org/r/20260521-clean-ksz-2nd-series-v3-0-75c38971c19a@bootlin.com
[3]: https://github.com/bastien-curutchet/linux/tree/ksz_rework

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
Bastien Curutchet (Schneider Electric) (8):
      net: dsa: microchip: remove useless common cls_flower_{add/del} operations
      net: dsa: microchip: implement get_phy_flags only if needed
      net: dsa: microchip: remove setup_rgmii_delay() KSZ operation
      net: dsa: microchip: implement .support_eee() only if needed
      net: dsa: microchip: implement .{get/set}_wol only if needed
      net: dsa: microchip: implement port_hsr_join for KSZ9477 only
      net: dsa: microchip: implement lan937x-specific MDIO registration
      net: dsa: microchip: implement port_teardown only if needed

Vladimir Oltean (1):
      net: dsa: microchip: remove VLAN operations for ksz8463

 drivers/net/dsa/microchip/ksz8.c         |  53 +++----
 drivers/net/dsa/microchip/ksz9477.c      | 129 ++++++++++++++--
 drivers/net/dsa/microchip/ksz9477.h      |   2 -
 drivers/net/dsa/microchip/ksz_common.c   | 248 ++-----------------------------
 drivers/net/dsa/microchip/ksz_common.h   |  56 +------
 drivers/net/dsa/microchip/lan937x_main.c | 137 +++++++++++++++--
 6 files changed, 283 insertions(+), 342 deletions(-)
---
base-commit: c0aa5f13826dcb035bec3d6b252e6b2020fa5f88
change-id: 20260525-clean-ksz-3rd-5a190d7c63fa

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>

