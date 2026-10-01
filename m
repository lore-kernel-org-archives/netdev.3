Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B8D415B7A
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859765; cv=none; b=XZnOWBogwy74v4qocXEmKYknWGU1KWlhM7sNlYyt8ZjnMeLQ7N14BCvyNACkVbtgCB15VpgJkt/Y/V+BD1Ar+jxsIo3lv9CEuqboL9Ht/WGeSCu3ISzbCdPojsTl7zjUEDQX4u3eLbEXnoLKyiHrhC9FyRC51M3JC0kr87M3OWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859765; c=relaxed/simple;
	bh=Cr9aXmGdHGi0d2CGE9ICTnF+nGv1yxcvXdUcAGzJ/sI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y1ApFQEMQN0RBn6d5+aRDADLspYJiGgXBatkDDxN4E9qoHYnptNSIn702r6GF/SAcjev10DM44RTEUKo43fM55/p33SdslU3+s6/CkTM/hpytxRvkbSH9j7kFnVBgnWUp+CkaLPkR+6SgGRWGY1n6YMJje0+60ThvYwibyKlZq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=Egl1gmIz; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="Egl1gmIz"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d1fb0cf5eso59455255e9.3
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 06:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1790859761; x=1791464561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4+v4CXxxuyPIvb+OG8OnbrIijN6oNxBYClvJhgYPdL0=;
        b=Egl1gmIzMJC/NIqtoY2l6MGC2k73x64xcwlj2Xe6O5Q4JzJ2x4ZfL2hPDRpVybIIaq
         8cJ5PwowGK1yzKYg2L0CNT0HvzGykeG2Li5fBD6Kgah0lTYT2A3S0D5wbz1GVtoUL5pc
         8Kj+YD5s3VplaqiwUXljG5m460yffQqAkWrMC9LffkmkUHZONIKnNZmV9qm02jOX5cq4
         18lfPMKwLh+y1ltN2Gv8YcapPUSnKznTAIXuiTy+8f9S7tDrYIo0qtOrxeasAlUlQC61
         HIznAAYWrWwuFwpNn6cLDxIrLAuUTVJf920mhtkEuGLcbAbWMUIQa3XM6Sb8UF8u44gu
         52mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790859761; x=1791464561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4+v4CXxxuyPIvb+OG8OnbrIijN6oNxBYClvJhgYPdL0=;
        b=E5aBs3s1Cb5S9wRJOVnixhY1q9MuDiCBYYcZ+bDLKjxNzvOySgHJIitiOM4LkoVwRS
         DHuiYuIepMOggcOWeR6EtfIhfZfrj98Z2exWISJ2PvnsaFkQjQAP+KqaoiyFn0CGi/Ax
         /aH+Zcg0KaEzIdNAaqHqjxuK0TSnhYJ4I6cUQ9DzEksMKWDM4eFI539TB9ThqzwtQlfn
         090N4ZiIueAWbUAIXy+BOpj0JoEMSbcBItUrBi6UYUc1UhOdyb+xeiHC0pSttxTpegWk
         fZwDgamBHugadtgPcFiLfpBBWROrYbqcxPLDuZefaNNKWUtwJq8fz6NQ4RqrzSZ6/E1R
         1UtQ==
X-Gm-Message-State: AFuF++nLILv9F4K193mdOJureGbtCNOQ2eHeJFhaDvcSaZOFE1IjQD2E
	8SO6mdPrPoru+qY6BG9VC8IGrOUwYKMhcqE6fUeocswRDBdiMZEAonR4+sXc5kozFx6N7UmKrLS
	/RND2E/Yes9xGpio=
X-Gm-Gg: AYBFou2R7ZoIi8cE65jiSGjOZ0MwY+ipm0J+XD3XaUROEe7e4tLEeoIrKSVfB/IsewY
	wtCW80jHndyARlammGGjG6yjtminFHOAXzVTobpx9opRNOZI+q8NBxzSZjK6ynfyp6A0zzKnaeg
	MUxfO76U8s54pCTXiQASlX+P3dU7eFmQbfgBSAKm6QT8YaF8JkQxI6g7hZ1oe+mdfuQfCMsTs+W
	6i0NfvKB0aR6CURVG1Tb723douWzL+a/iR1ITDptfGElIshKOSoVPakwBCkShcuRDi4bge9FoMF
	azvBR8M5XlCisMpursM2csRLwoRuVasovb2osQZIR71F7TZUFuQ2wSkr5z+kbOG+MXkFHVOy2jF
	XKtU5hrcI1J2M2WBcL2MAuLIx5VwKY9Ai0cc3n464x00YuKDPwlorvuyjzaIFb9IEppjK+1gxfQ
	naROnw6fc9zDSWEMSruAYTcbxlViW/dHP5h2ONLtp9Ufj+AkBB4GA=
X-Received: by 2002:a05:600c:4f8e:b0:49f:bd3c:bc18 with SMTP id 5b1f17b1804b1-4a01b00541bmr75269605e9.19.1790859760763;
        Thu, 01 Oct 2026 06:02:40 -0700 (PDT)
Received: from remote-01 ([84.17.55.224])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f913ecesm48051775e9.2.2026.10.01.06.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 06:02:40 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	olteanv@gmail.com,
	Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com,
	steve.glendinning@shawell.net,
	f.fainelli@gmail.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH net v13 0/4] net: phy: keep a PHY interrupt across a generic bind cycle
Date: Thu,  1 Oct 2026 16:02:32 +0300
Message-ID: <20261001130236.106059-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a Keenetic KN-1012 the EN8811H PHY behind lan4 has its driver as a
module on the root filesystem, so it binds to the generic driver first.
phy_probe() replaces its interrupt with PHY_POLL, and nothing puts it
back when the real driver takes over, so the PHY is polled for the rest
of the uptime.

Patches 1 and 2 put the lan78xx and smsc95xx PHY interrupts into the
MDIO bus table entry of the PHY each driver uses, so there is a number
to restore for them too. Patch 3 restores the interrupt from that table
in phy_detach(). Patch 4 restores it when the generic bind fails inside
phy_attach_direct().

Not covered: a driver without interrupt support that is bound or
unbound through sysfs still leaves PHY_POLL behind. Removing the
substitution from phy_probe() would fix that too, and belongs in
net-next.

Patches 1 and 2 are compile-tested only; a Tested-by from someone with
a LAN78xx or LAN95xx device would help. Patch 4 touches lines that
patch 2 of the attach guard series [3] also changes, so whichever lands
second needs a trivial rebase.

Other drivers that write phydev->irq outside the bus table, checked
against net/main:
 - ixp4xx_eth, ax88796c and emac-mac force PHY_POLL themselves, and
   none of them attaches again after a detach without forcing it again.
 - stmmac and mlxbf_gige already write mdiobus->irq[] as well.
 - bcmasp for an internal PHY, genet for an internal PHY before v5,
   and tsnep set PHY_MAC_INTERRUPT again after each connect, so a
   restore does not last. icplus sets it on every status read of a
   switch port.
 - sxgbe does it only from probed_phy_irq, which nothing in tree sets.
 - ucc_geth only reads the field.

Changes in v13 (since v12) [1]:
 - Patches 1 and 2 write only the table entry of the PHY the driver
   uses. v12 filled every entry, which gave the one interrupt to every
   PHY on a LAN7801 bus. Andrew's Reviewed-by is dropped from both.
 - Patches 3 and 4 touch only the PHY being detached or attached, and
   keep their code. Patch 4 stays separate: its Fixes: tag differs, and
   with patch 3 alone the failed bind behaves as it did before the
   series.

Older changelogs are in the v12 cover [1] and the v11 cover [2].

[1] https://lore.kernel.org/r/20260927235733.2619081-1-f@lex.la/
[2] https://lore.kernel.org/r/20260926235024.705646-1-f@lex.la/
[3] https://lore.kernel.org/r/20260924215951.2127682-1-f@lex.la/

Aleksei Sviridkin (4):
  net: usb: lan78xx: register the PHY interrupt with the MDIO bus
  net: usb: smsc95xx: register the PHY interrupt with the MDIO bus
  net: phy: take the interrupt back from the bus on detach
  net: phy: restore the interrupt when the generic bind cycle fails

 drivers/net/phy/phy_device.c | 4 ++++
 drivers/net/usb/lan78xx.c    | 1 +
 drivers/net/usb/smsc95xx.c   | 1 +
 3 files changed, 6 insertions(+)


base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
-- 
2.53.0

