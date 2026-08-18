Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB69F483BF6
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787077717; cv=none; b=c3wIBg7km6XE/f/F55W7GaVCjaF4JM6xGzFbjkhxxN0t/PEHOvr5S8iQ1K8HszXrfeljd1fGoXOT66Fz96DX+u0GpmDKxlSbF/9cdDbaiBVJA5MVMGu/kOOEUXcn6lXySCtuqnNhOxTzjW/V8t8MGBLkXCG9kelWaE0KJjpMzQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787077717; c=relaxed/simple;
	bh=w6deSb6FdZusfIWRJvb2P09squ/PqrmxCMw0B+oc6rw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=asSCvTUKhIg0C6NhMTV5NMH+BRTzU4rw1RvEHhLkqn7401YVMh68ZUGW0yBMCyZNwZrU1KdueAsD3rQUJLnL55y3aZ9deZr4pL0XWgrFe7Ys4wpevcdJIkv52EUpc7UPY3+8yoTazSiLdMwrv17+3GMm4fB+vY3Ae34PSGPX/pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEb4V1oz; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEb4V1oz"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aec201b582so199938e87.1
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 11:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787077714; x=1787682514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cdFBbeenO+uHrbtVeXeloGyoRqp0CSAoLqw72jhnBdM=;
        b=cEb4V1oz+1u1jgZHPq+CoXcLwavb5MuSEyej0dMGF4vHL1iRvsBoSktiPXBJ2OXKi2
         CUkZByJg652+fBB8lUVPuhjT8XBq4hTylPp4PDus3WPy7CEDnPh05o/3ShHV7QUwkvQH
         1vRwTLgIWPBuAA2tJNZdK8RyAwZUR/TAnni60Vn5aC3ENB0zw3RpbRtbpnnDU/Z6Rm+Z
         WTwFiJdhnINiooHORUjKe8W8t4hqmqcDh/GnTG67npQx5Qdmwc7qENOIP7+aEpbUtiSS
         N3gekj5t15iwoXkejpQrbhXj3JE/vJ1lI9gaFy6ZKl6k9EF+YDq0TrlFEf8X0zBmmG3y
         dsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787077714; x=1787682514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cdFBbeenO+uHrbtVeXeloGyoRqp0CSAoLqw72jhnBdM=;
        b=MSaN0DwkggeYQgLy56XbE9RBfHJjUQeyRuJivDYHwT3CDZnAA7pVvZRfb22J1xoeWA
         UdQpD01rlhrgTtEoMfLcoBJlMqRh42PK0J8ydMCroFgN1Rd/WNQlk/Bjf0aNAIGzMQQj
         nQ95zEU+Z8Ymtqc2NGGfrcq0tU40PDtwJj+DsJt3wrJQx86YWc9Sh1hydSGhtRkf+n3F
         P7bKtJv25eJXasQ4YQ+caRI9WGu4tJhirOBKdazsvNStisgmfmSB0Y6TLBAedAKQh4yh
         v+9brf5MF8Q5Pd4iMkHhVZa0FWp0Cts7Cqb6aEJNI9/II3PjcFN/5Rj9Znsgq3jXjBKE
         v7xA==
X-Gm-Message-State: AOJu0Yw93s/drJKX/BLsxIbr7qgA7vf549TjpJQCmU0otutncywqrd/p
	DHNyv4jOLZQ1CIEz2V6cLJHqC1X/5mXHg0KL4uAP79ERtrBX+Nw6I3rExk3gk9uGMBDSd5c=
X-Gm-Gg: AR+sD10jg6Qw1jRJvOHpRaZW9rDoz6DF9PKw7yKF2UYj/6ONGgHCYmmDsjhE5HURtgU
	/vgZyTms2MNlWuqT3rjd+5Vz3Pzcja2LIl5rKqLDFjxRlPdq/He+9V3ZQBvNBJe1WMqIb7R9hny
	OJRK2OyDh+0n/iO7ZPGyXDaM5tOLBKKEBu3/Jhw1RHLst2+UYexW1VDUBRWg+/Mh3RpftLQsaxC
	PbGMqnx7T8P1gbf7iExN3z17UgEPdcTnUtGkSrrL5x0YpuLKVtyOOpmOPs6BA21Nsm+KD1DiOO/
	tG3JdVEiFNEwvstLIPpPN49wCew/HTvL5y4Iyi3gz7Ch+yJCM9vOWqDyMW9X3TOdo20y7wLKoN8
	BfSb5+chIdXhQVSd2VjztggIvwrAevPE38SmSVvARBqF/UnBNDZPZ0Oy9FCqMXVkNCKmQpg9Zim
	6tt8KqPCdN4R4FQpDQVoGdujUGoH/6HrAbiyQIzpa/z4RvXj9ePfKOCZV6SilSz5mwYGpWRQ==
X-Received: by 2002:a05:6512:440b:b0:5b2:a316:6113 with SMTP id 2adb3069b0e04-5b477cab55amr125716e87.9.1787077713492;
        Tue, 18 Aug 2026 11:28:33 -0700 (PDT)
Received: from i-UX410UAR.lan ([2a02:2168:87cb:3900:e3f7:5eba:c5c7:2efa])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b46cf960d8sm1460494e87.2.2026.08.18.11.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 11:28:33 -0700 (PDT)
From: Vladislav Karmanov <vladislav.karmanov.dev@gmail.com>
To: netdev@vger.kernel.org
Cc: chester.a.unal@arinc9.com,
	daniel@makrotopia.org,
	dqfext@gmail.com,
	sean.wang@mediatek.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	yangshiji66@outlook.com,
	Vladislav Karmanov <vladislav.karmanov.dev@gmail.com>
Subject: [PATCH net] net: dsa: mt7530: do not advertise EEE on MT7621 switch
Date: Tue, 18 Aug 2026 21:28:29 +0300
Message-ID: <20260818182829.1580811-1-vladislav.karmanov.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shiji Yang <yangshiji66@outlook.com>
Date: Sat, 28 Mar 2026 23:29:56 +0800

There are hardware defects in the MT7621 (MT7530) EEE support: with EEE
advertised, some link partners cannot establish a stable connection.
Notably, on a 2-pair (4-wire) cable where both ends advertise gigabit,
1000BASE-T training cannot succeed, and instead of falling back to
100 Mbps the port flaps in a loop and no link/DHCP lease is obtained.
This is confined to the WAN / phylib bring-up path; the DSA/LAN side on
the same device is unaffected.

The MT7530 internal GE PHY advertises EEE by hardware default. The
eee-broken-100tx / eee-broken-1000t device-tree properties only take
effect during the late PHY config_init path, which is too late for these
link partners: they negotiate EEE before the OS disables it and then
fail to fall back cleanly.

Commit af3b4b0e59de ("net: phy: mediatek-ge: do not disable EEE
advertisement") removed the early EEE-advertisement disable from
mtk_gephy_config_init(), on the rationale that "disabling EEE
advertisement before the PHY driver initialises keeps it off", i.e. that
the DSA subdriver already performs that early disable. That rationale
holds for MT7531, whose mt7531_setup() clears MDIO_AN_EEE_ADV on each
switch PHY -- but it does not hold for MT7621, whose mt7530_setup()
never had such a loop. So af3b4b0e59de removed the only early EEE
disable that covered MT7621, reintroducing the flapping on MT7621-based
boards (regression reported on ramips/mt7621).

MediaTek's own recommendation (Landen Chao, 2021) confirms the hardware
is the root cause: "EEE of the 10-year-old MT7530 internal gephy has many
IOT problems, so it is recommended to disable its EEE."

Restore the early disable for MT7621, but on the DSA side -- exactly the
location af3b4b0e59de assumed it already lived -- by clearing
MDIO_AN_EEE_ADV on each switch PHY in mt7530_setup(), guarded on
priv->id == ID_MT7621, mirroring the existing mt7531_setup() loop.
Auto-negotiation then falls back to a stable 100 Mbps link instead of
hanging at gigabit.

Tested on ASUS RT-AX53U (MT7621): a single clean
"Link is Up - 100Mbps/Full - flow control off" + DHCP lease on a 2-pair
cable, where the unpatched driver loops. Confirmed on kernel 6.12 and
6.18; also confirmed on Netgear R6220 and EdgeRouter-X (both MT7621).

Fixes: af3b4b0e59de ("net: phy: mediatek-ge: do not disable EEE advertisement")
Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
Signed-off-by: Vladislav Karmanov <vladislav.karmanov.dev@gmail.com>
---
 drivers/net/dsa/mt7530.c | 9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2518,6 +2518,15 @@
 	if ((val & MT7530_XTAL_MASK) == MT7530_XTAL_40MHZ)
 		mt7530_pll_setup(priv);
 
+	if (priv->id == ID_MT7621) {
+		/* Disable EEE advertisement on the switch PHYs. */
+		for (i = MT753X_CTRL_PHY_ADDR(priv->mdiodev->addr);
+		     i < MT753X_CTRL_PHY_ADDR(priv->mdiodev->addr) + MT7530_NUM_PHYS;
+		     i++) {
+			mt7530_phy_write_c45(priv, i, MDIO_MMD_AN, MDIO_AN_EEE_ADV, 0);
+		}
+	}
+
 	mt753x_trap_frames(priv);
 
 	/* Enable and reset MIB counters */
