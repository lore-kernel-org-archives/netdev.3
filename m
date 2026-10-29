Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283871;
	b=Hbc17mpYWpMLB3pmCMCk3tmsUkPh+9iOxPoC/UdyGWlStjTGTszewpb8/cNvRbPC5jJJ
	 YlRu4NBKC9Rw/cIXmLCykx9G8SuRNINDD0V06w8MOkPxDRDAgct6+ZYxIzP5Y3jUFqiVr
	 BX1TFDXixbQ2RsrmsAbRE4PPicHe65nn8fgfRSZ+Ln/TCEmpn4UaiTKjjXWUmm83wlFlv
	 zCaiJ9AKUQaM3Xel8sspevMMex7a186QfrX4dUnKxIENwTEw1543LYzmH9MOY7ZUmcyzc
	 9UrxmhEt/xmzukSCQM3mDLUiJ40JN7nXk+0UJZ6x+dS0PjUa2SY7uwxykUUlXJT7E0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1pA3DY9nQInHYQwlk8Wnkgx76yLI3u5rBh/HejZE858=;
	b=WSXGppzJgkPkiHGmKTboVekdE7BO5hLIhLAtlFXJc7dJu1u/zop5E1b7JSVmDd25NuM8
	 d2blZ/JtcROWJyXy4UURO6ibht/0iRWZwz5tfBVaw5WNXcmO0MtnZSQCV7APXg7Q8Jo2m
	 JXc5mp3lSmtcvwTkchhCvwd0jtcTV7Ca68i4yFSuRbujhOgRvrqOkhSTHf7Oe6RsTxs5M
	 PLLCK2pqT22z9to3DoN7ShecY9cnVu8u7GNU67xobi1w76VfpqQU44/ajQF+tEAvJ7Cbj
	 knvStepYmXT22eh46Ayb8grLgH7jaNceKBpM2A4jx8KKxY/S0iaC+yLHCjHFK79ghSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WeRS5xwe;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7DE606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 14:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C7DE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WeRS5xwe
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso1102624a91.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 07:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793283870; x=1793888670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1pA3DY9nQInHYQwlk8Wnkgx76yLI3u5rBh/HejZE858=;
        b=WeRS5xweJrCPfHAVsJ84vdSOreP4nbG3hoz9M2Oz4HfEbCDi8eFSIGatj9A3zTpaDU
         e0Xb1CR9mOasKFnmkH4s0q4rxR1l3VaHPpPEFCPplPCvgeXF3x5UKJaBVSO6xRzIm6ai
         18bGbUTir6UDPtH2If9oz1KovGWFEb0ADOc+3L8fqwB6yy5043o/LIWB7ILqUBBECEPT
         l/2ticNxD4e+xcQTwCUurzwk01S0NyNGViDpnRQxpSqTI2yo+1d0kONgR+pFnFUe/iNM
         o+3EkCsald3/H4ODpuovHFss3zyM45Vu1kxYeE7PbZTzla5crd2yIcJzGopbHxdw38Xp
         cibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283870; x=1793888670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1pA3DY9nQInHYQwlk8Wnkgx76yLI3u5rBh/HejZE858=;
        b=2ZizGs3XC5kgYtB8ATvJx2defct/dC+kzHAoof/zbMtusXDZ/v34VMJrDaXOqM3K5H
         sJVFSzq9u86p/XEe7U8en6oBFuIiw4xGAxs6t5O1ZY3AILvXXEc5OoRBJw8Y3/ewve4y
         /3Hi6ogki2hnrujo4Pk1JteEUYOWU76u9p4J9zkRHlRl44VP5GcldyJJlQF/pLCE0x+U
         SonR3TOzUYSc9c7a4llnZSUsozBFxb2q7y72IRjwLtqtMy8dKTP8MXZNcgs1YPijT5a3
         7wruvy/hnii+FL9LD0CwzagWQRcuzBpIuzpRZmrXK8TbHlOL++hcsmXL23uaRkENleiM
         ysIw==
X-Forwarded-Encrypted: i=1; AKwUvBxv7+Y4igvdM+UNJ68SKHLe6Y4xmxkLeFoQfzxCj8aMyiXkWwLSbgBwPoquyvlkAfNvvs1zzwQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjK4CIXg2GiMvV7GONl/+60FxYdmhB3E0hw5Oqdd/ev76X2JiI
	Dm9MYTRXXA8BhgZAF5/wgTGp8cissunp1l1AX80RQ1UQGtiBrMn5tPYc
X-Gm-Gg: AYBFou0zST5xpYTwXXNmbYBicjWAO8UHA5ubyCthxBXCh4+RZEIt2/pgLeXO67z7XUy
	6l+/iRUEjGwcQR16lzssHo8Pclx2Sp52+GMlj+CjIeofbCNbRA6jDRDljQrovcdMgA0Adexn5dV
	9Vtv+zoobbacDM32JDlfvqwCOsl2Fgm7i2hY3GgXzHojlM84yRATgH/3urealrYHhiF7or1xW9o
	zECGXtshvYm5rmjkEU2Y30dsVxhrvKTx5ITaNN2ADtkT0QlHd5l/cOsbnmcwAwe44kHXT8vIjCa
	O0CBobJGdzI6w5UERwG+NfsKofPrqawlqlZMOLAGPdTIAioDWFAMNXTg2l6DcTOAfZ7EpEjfzy2
	5J3hXS0Cp37IGY+hVRKBuRX1ewe7SUsTr1v9BgODvljp7lar+bJG5WVagHeBO9DrzgPoORHE7wR
	9y4VShecCtfKoraevCxayT82f3ZFNBktEDhS+MvXePLSrlNf7Locu8io6P/drp04S1/cyM1TDo2
	a5311gVZXlnYW3eE3h28vvzMBoVCz1jxaBmq0uYACjqiESwTFjVSK4DaWKsn/7V2QFysIKTmYSz
	QNXTk0KJ14sF5GualhldI8kErZQdK4I=
X-Received: by 2002:a17:90b:1a86:b0:3a7:a463:54c2 with SMTP id 98e67ed59e1d1-3ae580a0233mr4500501a91.35.1793283869733;
        Thu, 29 Oct 2026 07:24:29 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac5:d459:16d2::246:73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae8441a6f0sm16691a91.1.2026.10.29.07.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:24:29 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+583f42a41879bb60de32@syzkaller.appspotmail.com
Subject: [PATCH net] net: phy: don't require RTNL to detach a PHY from an unregistered netdev
Date: Thu, 29 Oct 2026 21:24:23 +0700
Message-ID: <20261029142423.93573-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

phy_detach_internal() reads dev->hwprov with rtnl_dereference(), but
MAC drivers commonly attach and detach PHYs while their net_device is
not registered, without holding RTNL. Before register_netdev(), a failed
phylink_connect_phy() or phy_attach_direct() unwinds through
phy_detach_internal(). After unregister_netdev(), a driver's remove path
may call phy_disconnect(). Both trip lockdep:

  WARNING: suspicious RCU usage
  drivers/net/phy/phy_device.c:1831 suspicious rcu_dereference_protected() usage!
   phy_detach_internal+0x6a5/0x830 drivers/net/phy/phy_device.c:1831
   phylink_connect_phy+0x22e/0x2b0 drivers/net/phy/phylink.c:2452
   ax88772_bind+0xbb1/0x1520 drivers/net/usb/asix_devices.c:925
   usbnet_probe+0xbb3/0x27e0 drivers/net/usb/usbnet.c:1812

syzbot hits this with an emulated asix device. phy_eee_rx_clock_stop()
fails on a USB MDIO error, so phylink_bringup_phy() fails and the PHY is
detached from inside usbnet_probe(), before the netdev is registered.

hwprov is only set through ethtool, under RTNL, on a registered device.
reg_state also changes only under RTNL. So if the device is not
registered, no one else can reach hwprov, and RTNL is not needed. Tell
lockdep that. A detach from a registered device without RTNL still
warns.

Fixes: 35f7cad1743e ("net: Add the possibility to support a selected hwtstamp in netdevice")
Reported-by: syzbot+583f42a41879bb60de32@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=583f42a41879bb60de32
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Tested in QEMU (x86_64, syzbot config, KASAN + PROVE_RCU) with the syzbot
C reproducer on 6b4b543fa187:
 - before: "WARNING: suspicious RCU usage" at phy_device.c:1831 via
   phylink_connect_phy() -> phy_detach_internal() from ax88772_bind()
 - after: 11/11 runs hit the same "Could not connect PHY" failure path
   with no lockdep/KASAN report

 drivers/net/phy/phy_device.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 5d4508bcfbe9..06c5a8c8cc2a 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1826,9 +1826,13 @@ static void phy_detach_internal(struct phy_device *phydev, bool notify_bus)
 		struct hwtstamp_provider *hwprov;
 
 		/* hwprov may technically be protected by ops lock but
-		 * not for devices with a phydev, see phy_link_topo_add_phy()
+		 * not for devices with a phydev, see phy_link_topo_add_phy().
+		 * Drivers may detach without RTNL while dev is unregistered,
+		 * but then nothing else can reach hwprov.
 		 */
-		hwprov = rtnl_dereference(dev->hwprov);
+		hwprov = rcu_dereference_protected(dev->hwprov,
+						   lockdep_rtnl_is_held() ||
+						   dev->reg_state != NETREG_REGISTERED);
 		/* Disable timestamp if it is the one selected */
 		if (hwprov && hwprov->phydev == phydev) {
 			rcu_assign_pointer(dev->hwprov, NULL);
-- 
2.43.0

