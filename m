Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5253E0724;
	Mon, 31 Aug 2026 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170349; cv=none; b=fESqppHu4w/K3kzUqSEm8A7Ufc2/Cho8++Bn3q44rLYaPDovjDpOsBg7CiRJ/BtgrWlguggsbdl6K81ZeN1KBQ1NYsFzxCgrn0dFTmTbKDaoK90auNaJ7MBRgzyAmXrpyW5C947iQ9zPE1fhkXQ0ftGbC3ndtSqVDRFBIcyBBsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170349; c=relaxed/simple;
	bh=ZGl5Vcmlux3CLdbnKMcw3UCD1AYWBXFWxW0/LVCsG1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YVYFXrayidk01GrJ3/CHGhz+3POSwlzN3huuQ3IJ3pBAtu4LTC9NSfdr2XGSG/sf4b3W2o83BRl///31CDd15+NhEUd+CYsg7qKlMo6/lGzhqrRDvddBWOsj5PgKMmDWb+zu/J2cs8M9xlJ1mLBVY8E3ppjx3dkJ1hnIsP6OzaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=xRzft9+x; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=fSBFO5Ua; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="xRzft9+x";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="fSBFO5Ua"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788170344;
	bh=ZGl5Vcmlux3CLdbnKMcw3UCD1AYWBXFWxW0/LVCsG1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=xRzft9+xUR093E9uvxaww9EQRf0f2pLFfaZbv4MgtE1NnGJTT2FuLGQRJR6nCLovp
	 wPQMbz+MNh1zt6vQ97hoEt/BH/2vMZ2evYYbAz9HiXE2iTLNDyTh8be1nlF1rCAuaG
	 UaL70yjxE+y7d65Y161Nj6cZW5cn9zCviunSqv0Eo3yjwT3e2Vubj1bkFNcHEKwltI
	 z3kQKTiuQsRMpDrhmAXHGKnKk8HlEdSfnPysGt77Ywmr9Z1ZCxdLA99bKOEP0XnQRr
	 KD2iaiqFMN05a4baa990/eno9E782iE74yr2oEzaEiJhCXK2UY2KPnhsJvD4FKAYsb
	 BRA+3EWq+cEng==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id A4FD33EC8B; Mon, 31 Aug 2026 09:59:04 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788170338;
	bh=ZGl5Vcmlux3CLdbnKMcw3UCD1AYWBXFWxW0/LVCsG1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fSBFO5Uatlp+pLQyM2Bhuia+VuHnef+ftbbT+m5G4C4fO3IvxA/F2nnz0nsFdPO6I
	 o+TwgKS/EGocjD3K2BpbX1hVQ5DUMFo9KlWMUo2WCU8D16uc8BOc/k8APyY92eP3kI
	 Dq45PS90Mmmpllx6N+aQzQfCwkkDgqodTWE53tuP5HEjcJB5nYLLJtyJlV/Gkw2jev
	 trGqUza2COT1Xe3D2CIfl/MPt85usX/bfgwjYWiWTcSrpwFJNxm5prfH2abl03iJMk
	 IJakFHdPOCWPnObUd5PG/SStnoVRtnkdUp9H3Qs01wd+vfHPtf4MlAXg6c7TVoFvOp
	 g1V31UgrkU2Lw==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 6027D3EC6B;
	Mon, 31 Aug 2026 09:58:58 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Mon, 31 Aug 2026 11:58:54 +0200
Subject: [PATCH net-next v8 05/15] ax88179_178a: Add netdev2data()
 convenience function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-ax88179a-v8-5-de905f2ee426@birger-koblitz.de>
References: <20260831-ax88179a-v8-0-de905f2ee426@birger-koblitz.de>
In-Reply-To: <20260831-ax88179a-v8-0-de905f2ee426@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>, 
 Jianhui Xu <neuromoments@gmail.com>
X-Mailer: b4 0.14.2

Add a convenience function for the ethtool ops that use
phylink and need to retrieve the ax88179_data structure from
net_device.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/ax88179_lib.c | 7 +++++++
 drivers/net/usb/ax88179_lib.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/usb/ax88179_lib.c b/drivers/net/usb/ax88179_lib.c
index 761701ebc0692338b5c0a9f73d0b6965cda87d6e..ea36aef3d3e45ee4f84362a1b87628a12a355bbf 100644
--- a/drivers/net/usb/ax88179_lib.c
+++ b/drivers/net/usb/ax88179_lib.c
@@ -128,6 +128,13 @@ int ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 	return ret;
 }
 
+struct ax88179_data *netdev2data(struct net_device *net)
+{
+	struct usbnet *dev = netdev_priv(net);
+
+	return dev->driver_priv;
+}
+
 void ax88179_status(struct usbnet *dev, struct urb *urb)
 {
 	struct ax88179_int_data *event;
diff --git a/drivers/net/usb/ax88179_lib.h b/drivers/net/usb/ax88179_lib.h
index b2ee1356727cf4b3fa05f0b0d5fd863ac3f9a87d..9ff2a94a6fb2de4ee85f25e913ae2fe263bcea7c 100644
--- a/drivers/net/usb/ax88179_lib.h
+++ b/drivers/net/usb/ax88179_lib.h
@@ -181,6 +181,7 @@ void ax88179_write_cmd_async(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 			     u16 size, void *data);
 int ax88179_mdio_read(struct net_device *netdev, int phy_id, int loc);
 void ax88179_mdio_write(struct net_device *netdev, int phy_id, int loc, int val);
+struct ax88179_data *netdev2data(struct net_device *net);
 void ax88179_status(struct usbnet *dev, struct urb *urb);
 void ax88179_get_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo);
 int ax88179_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo);

-- 
2.47.3

