Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50674584942
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 20:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986612; cv=none; b=dTpLedOBI4VCGlnsfbyD9ZLwSim/SJ9ilqSttVgqYv00NWlGn/ha/RLotH1M3AfKAtEI+CjZN66VTlD6Jwfl9qxIJcuFJxyndAdtU7y+juyXN+rPl6ftg2ww5CyanWBvfQikKuG1IKSmODKShs3b7l8GGqrBGsSlQPcUogi8hOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986612; c=relaxed/simple;
	bh=NvNgiIubBE06ZkvDnHHPMqx8EJMCfUgz5OxrpnKGW/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=InltoWxxV403UzI4LlMNCMr0aALKMKrXV8ynS11EitESK+ijAoMaNj0e2lJ8ncCsihNwXeXUHiTodVbPhtJDfZDVOwmhXnlSXcx0rHHm+C8rdnUspgbdUM+vTSA0jpMLBhBFzQnhacXmDsaCZF1idIodgXkGCuigVtYNiIGMpP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=dcsTc1vs; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="dcsTc1vs"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6356f6bso610216f8f.2
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 13:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788986592; x=1789591392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yZEU1UhB6W2jXNsPTqZXxWbaH+0YtA3+ww7ukRUDGv8=;
        b=dcsTc1vsmtgJ90XnkShyuAkfBKTn7y2C401QbIp0BWW+pX8FFlVYSDT7TSQmh4Zma4
         GCfDbzpRPGTANir3Q4LmCWFANxwAUWx2iV0Mgl1MgO65NpmYIPy2OFffsqcNKRXTgHMi
         rAehaxwRWeLQyqo2Pu655p3h6EUBQO3lXFvtE63Oq8MaBVZ4vU6qQJICjR+mOohYJcwu
         CpJZgGa4GrhPN+5HIN23i1KdHIiVj7t9v7Ao1ldtGIjHjuJBBlixZb3wJfIdbHQtx1Iq
         QkU1SEO9J+fd9iFn3Bz3xiE0syMdiVi5fxDn79IkvF/G+7D1/aA776H4qwOYrCi/oq8W
         Lmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788986592; x=1789591392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yZEU1UhB6W2jXNsPTqZXxWbaH+0YtA3+ww7ukRUDGv8=;
        b=cfO8CxtcWfyoMiuURDevVf6Jo2uqhDf5oRYHeRGkB01Jk6RCU51JC3kA/5XbnvYk8g
         oguG4LTiESwhKJzKeFRI80tsfGHGlOxQNWvOJWILFTVoghHDjMMgmp2Wyp4dpeA3Erv9
         Rrp3I5lKzbR3xZTxQMBAG4y5lc67rBWpZnFcy1Od2+ApmcYFNhtXSLUA9SSMHEP5fRp4
         T+mkDufFphTesWYH7e+0swdx2+uKRRJp7SFl6GdRhVbghUnNzOY4MkRcDspq3w0hPKy8
         kValbdDXufvnsD/E0gphIaUoDZD6Tmi3iragAQP0zi8mKRMV7RH91HpJK/3S8tSEGMm2
         3rWQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/W28MKcolgxELB5TinPMRqvEQdcbMVn5ej8Np3FajVpg9Kw7zv1F9QD3T9vE41sBUmFNmwdI=@vger.kernel.org
X-Gm-Message-State: AFuF++m6WC9ckbKwhbqYt1j7Bk1bTprjep8TAWUWCSzgdos0jN/9j6T9
	uMt6hUUc28UToha1CbTKrP6yfnH+sDeYzbeHZHiCwBwIsCzbgQTAQkrN1S6MiqhAoC0=
X-Gm-Gg: AYBFou0K6PTX7fmUXgGN7JvrD6DgC+fy5StAerdCglp8lOG1fSVivAgLI2CrelxwtvW
	jJxI2oS6UzcHLgF8nSggeGOwj9af5iJoQTzhskEyFibk13k1D5tfcHFvf+isG1jRb47u4rUPZlz
	tI18Ibaidhq6hEwBJvLzYVjLsRbsn89xPDg4uJttZ1fu6himrL++UYjxL5H3KKL9akcyvMI16Q+
	xjqT1Fg1ywUxBReMRC7mifrajvFWRCICLzN7GbwxJZulAg8nYvoV4yh6EB+4ANAS33AtBe4Woqk
	w3piDMCQWmRAIRHzwgd6Ju2HYDGH54G8+B/ws+Jdh5FNR1ffKMjSHh2aNOw7O5g8LdHU7sAs5Mk
	zKtegqgzyLO8sze6b2Jk/hsMWiZjVDCqhzpZQfxUfSVdhCNa5eCcCmKScU2bmLFke6Cy6vJTjiO
	/VQVSOgRKFTBgGoatFhm58Z4LckzQNssMtEX+r38Kh4Hh5TAfNjg==
X-Received: by 2002:a05:6000:2004:b0:485:ac3b:4a84 with SMTP id ffacd0b85a97d-485b30e8cbamr7418910f8f.0.1788986592185;
        Wed, 09 Sep 2026 13:43:12 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858e239862sm40693606f8f.9.2026.09.09.13.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 13:43:11 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk
Cc: olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH net v7 0/2] net: fix a stale phylink PHY pointer and a lost PHY interrupt
Date: Wed,  9 Sep 2026 20:43:04 +0000
Message-ID: <20260909204306.2374562-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two fixes on the same path: a PHY whose driver is a module on a rootfs
that is not mounted when the MAC probes.

Patch 1 clears a stale pl->phydev when bringup fails after recording it.
The code is unchanged since v3, where it got a Reviewed-by. The
changelog is not. It used to say the SFP path turns the failure into a
permanent -EBUSY, and that understates it: sfp_sm_probe_phy() frees the
phy_device on that error and assigns sfp->mod_phy only past the return,
so pl->phydev is left pointing at freed memory. That matters for stable,
so the wording gets a version of its own.

Patch 2 gives back the interrupt phy_probe() replaced with PHY_POLL. It
is five lines in phy_detach() and nothing else.

v5 kept the number in a new phy_device field. v6 dropped the field for
mdiobus->irq[], which is what Andrew asked for, but kept the restore in
phy_remove() behind a phydev->phy_link_change test. Both are gone here.

Recording at one clobber site was never enough: phy_attach_direct()
substitutes PHY_POLL in two more places, so a number lost there was
never given back. Taking the value from the bus at detach covers all
three, because detach ends every bind cycle and the bus is where the
number came from.

The phy_link_change test could not be a guard. phy_remove() reads it
under the device lock, phy_attach_direct() sets it on the rtnl side and
takes no device lock at all, so by the time the restore acted on that
test the test could already be stale. phy_detach() has one writer on one
side and the question goes away.

The case that test was there for is a sysfs unbind reaching a PHY that
still has a consumer. I ran it on the board. It takes the box down in
phy_polling_mode(), which reads phydev->drv->update_stats with no NULL
check, well before the interrupt number matters.

A bus whose driver writes only phydev->irq and never the table is not
covered: the table holds PHY_POLL and there is nothing to take back.
lan78xx, smsc95xx and sxgbe are in that position today, and registering
the interrupt with the bus is theirs to do.

Measured on an MT7981B board, an MT7531 switch port with an Airoha
EN8811H whose driver is a module. The generic driver binds first, and
the number is read out either side of the detach that releases it:

  with patch 2:     bound: irq -1   after detach: irq 15
  without patch 2:  bound: irq -1   after detach: irq -1

-1 is PHY_POLL, 15 is what the device tree gives that PHY. Reaching that
state needs a kernel that lets the generic driver bind where this board
would normally refuse it, so both numbers come from a modified poller.
The patch under test is the only difference between the two builds. 485
passes of that cycle under ifdown/ifup and sysfs churn read the same,
with no warning and no free_irq complaint.

The restore runs on every ordinary detach as well, so I measured it
there too, with nothing modified: twenty unbind and rebind rounds of the
switch driver, each one a real teardown and setup of four ports. The
EN8811H came back with irq 15 every time, the three internal PHYs with
79, 80 and 81, and ethtool -r moved the counter in /proc/interrupts
afterwards, so the number that comes back is a live interrupt. That
needed two local fixes to the switch driver's remove path, which crashes
on unbind on this chip. They are not part of this series.

Previous posting:
https://lore.kernel.org/netdev/20260908155025.4155289-1-f@lex.la/

Aleksei Sviridkin (2):
  net: phylink: unwind the PHY binding when bringup fails late
  net: phy: take the interrupt back from the bus on detach

 drivers/net/phy/phy_device.c |  5 +++++
 drivers/net/phy/phylink.c    | 29 ++++++++++++++++++++---------
 2 files changed, 25 insertions(+), 9 deletions(-)


base-commit: e0554c6276da957b6e72849520c70a97404cd1ae
-- 
2.53.0

