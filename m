Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793663519;
	b=mZyREhMzVlUA8aYHGAfNiNZckZ/tRxA7rDdu5cEMTUm0K+b7lwlaRrGRKRu6cyf6z3fK
	 XsQdtzGox/tQTWZaQ7KRcQMle69pGHnGRBRQMwWA7hmoY9e9vJ4uCSX354/9kxSZxffDo
	 VjHOJ5Wd7cyRNvG+ui2ZVhHsJDqXYtCNrbkH8wO8oVahDQdYxdHoidWZIh1RGjzAVvcFR
	 wuiHA8L0bRGiAuPjUBs1JPW++A/agX9Jmh4ozfmIBLrYXCt/ZHdPqEbMo+OoiUyAdcgrC
	 GZCB/4E6MIIkSktWh+5/ERgwfQS/blYhaHHexKdwq9Ll1+EuGjSBsVatkpCESfFkPlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793663519;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0b6CWUpDDg7nvX4yAW5I5URG5gPxBouEYD/8SJ9ABv0=;
	b=3ipW/g3p+9r9j3QlNXRM6CA71JOHzpM4unYOl2j67yrYVe+sQHtx0ID+FWtrbskyoVop
	 VR58KZMdC49jV2rB715T8KNtu1P3nNS+M/VjuahLEhlavJ2YT8t35xa+kZdgRysdRYft/
	 WWZaeOdloC/2oZbFFGkP3xDKQjJENrSitqiNrZDKYZ/BPBwa6lNPFRzkTDD/rjndemI0B
	 veMp8CJfAXafbZ2aHGgv2E76wiTddjt3JAV4pBnwwkxNubyL5Kog78Cxb+nyuphgJLhZz
	 O9snHOCMBmfustcAsRZkfjtb6ESOUpNK66whmjKhq8v0FFVXU9a7S8oAtsGTloCHeuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HzRtkl5q;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D88606A329
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 23:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35D88606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HzRtkl5q
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso23611085e9.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 15:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793663517; x=1794268317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0b6CWUpDDg7nvX4yAW5I5URG5gPxBouEYD/8SJ9ABv0=;
        b=HzRtkl5q72gjo44f57XNzxpUe0stksYOSmwi631m7w0A8oDDscBabfvEAVxKzqIDEj
         QI5zK4sFB+7uFhrWo4rL6qlJX7xIYm1To89/52v3nvOKu003plA0iINlSx/InF5eezIC
         +uVa4bbzk9pV5TzrpolsJSyE5gj0b0DeE2C0SgjrVuthVjK/CaNfRCzhiJSg4FXwgKL7
         fBnV5YSFiQDlmHBpZwvXgt4WSqKzlhSVwQMMAWa5suh8p/9kjxDit9oTOVmiziCM8HBK
         IhwJpst+KDKtFvk5ZuFucALXyqqRiIwC1CwyIq4IXzpHcgs4i1HaHpF3rEar8E3yRGBG
         WyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793663517; x=1794268317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0b6CWUpDDg7nvX4yAW5I5URG5gPxBouEYD/8SJ9ABv0=;
        b=O+XKPc3o6KPgO1HSNG8VUjcZZ4CU/JKgtxP2Zl7YgGt+5gW7xYgxrnf0L5okOLRFuW
         mCi6/CXseEhRF9ersoZU924K4sAf5gkzXrLKeAtu8WD47R859BO2d0y37qjyhgXaJhfE
         0xbjpk2GEITNGTkQRACXdwTkotdwIX/KzZjdNY9YCtBhhbzrgWefexjuL11Yr89yRacS
         DEJd+T596JGf7Uw4ip7J0qXlb60P16yEv6J4AKoMYDC4jo9PjpLtiveMQzQPn1/4BhMi
         D7D/vbiAzV0+sEQsbfSZx7xbwE1ujbEDyniJBOniocSyKQxSqimJPXRKB49f4MBeUl0X
         Yqwg==
X-Forwarded-Encrypted: i=1; AKwUvBzt8f6SxqLFyj/cqQq+mktzQ4lhboT89/2BRKMVsa/81I16B+xdReuG6CCtXURTpga8JAfoAGg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKk+7I17qIeL/sYPY6x+sYAiEeBPpQelXAiS0LPAVDFWSMvmfmP
	/I6x6NbXDOKbG4k7dgASTbG7lq3bHQKx7jNB7I4S+Fq0dlcEs0VcdNfm
X-Gm-Gg: AYBFou1etoU/ozHX9/gMT8U9x/v5BRe71uTqkaa5s2y0Vp+KLjC9ORjduXZzfQNpp4X
	APd2b6EZndIsx8uyWM6OVrmQUHwug/yeAAUh523Q3nxxh1enWd1FzCP9+h7C4f15RayPS8uvgEB
	ylu8NSg91roVGxBDrnkpt1hiyLGtCAThA8oKrMqXxNh5BaR1ccEIuoY2y1uMeFOz9T8lxHB3l+l
	URJntOFon9Bc3NSEd4MBNs8DlZz3sNQHbe+wIcjXkhrO6NLnOVzuGt+oztp11l1zbIbWJF1As37
	12GC8ea1jskPtbL1fL4ABcUJ/uw4gC4aMtEqJLyNPZMRAjY7hK4Z+8REpJKCvZ2bFevBIKgzFgc
	nmtWsy62ag5h7VRStyMdkAz3ynmVtIU/lRxSKAMmob7C93x1XKW+xC1j8dgvQtMWnEU2WOQOVyV
	vJ62t8rnVCTJJbYToJjc/IRczVf5ncbkKhx3pvpMx4tKanFfICrlle5zV5qRoiPdQ6oBCp4Htiq
	IHW7I12jUTztUf7CaYxcimrvOHLoJUXc64wELOwM0cvCZU+Thn4uzPPC48jhSJIXnclSDhYktlm
	CNnPL2vWLCosU66gNO91j96kB2fXAOPPvbX4PYu6qXMHET+4UtTMnGPYJbgqrrTOA8inoGRoSw=
	=
X-Received: by 2002:a05:600c:6212:b0:4a4:de70:2ad4 with SMTP id 5b1f17b1804b1-4ac17ffa395mr248989255e9.22.1793663517545;
        Mon, 02 Nov 2026 15:51:57 -0800 (PST)
Received: from fedora.fritz.box ([93.93.22.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac09ad5ff8sm210203745e9.4.2026.11.02.15.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 15:51:57 -0800 (PST)
From: Stefano Munari <stefanomunari.sm@gmail.com>
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>
Cc: UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: usb: lan78xx: resume phylink on non-reset USB resume
Date: Tue,  3 Nov 2026 00:51:33 +0100
Message-ID: <20261102235133.23011-1-stefanomunari.sm@gmail.com>
X-Mailer: git-send-email 2.55.0
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

lan78xx_suspend() calls phylink_suspend(dev->phylink, false) on an open
interface, which always stops phylink and halts the PHY. The matching
phylink_resume() is only called from lan78xx_reset_resume().
When the USB device stays powered across system sleep (e.g. s2idle) and
the USB core calls .resume instead, the link stays down until the interface
is brought down and up by hand. The ifdown triggers:

  WARNING: drivers/net/phy/phy.c:1670 at phy_stop+0x44/0xc8
  called from state HALTED

Move phylink_resume() to the end of lan78xx_resume(), which both resume
paths go through, and call it only if the resume succeeded and the
interface was open, mirroring lan78xx_suspend(). As a side effect,
lan78xx_reset_resume() no longer starts phylink on a closed interface.

Tested on a Raspberry Pi 3B+ (LAN7515) with s2idle: the link now comes
back up on its own after resume and ifdown no longer warns.

Fixes: e110bc825897 ("net: usb: lan78xx: Convert to PHYLINK for improved PHY and MAC management")
Signed-off-by: Stefano Munari <stefanomunari.sm@gmail.com>
---
ftrace on unpatched kernel (s2idle, woken from PL011 UART IRQ):

  lan78xx_suspend <- usb_suspend_both
  phylink_suspend <- lan78xx_suspend
  phylink_stop    <- phylink_suspend
  phy_stop        <- phylink_stop
  lan78xx_resume  <- usb_resume_interface

No lan78xx_reset_resume() or phylink_resume() on the resume path.

ftrace on patched kernel:

  lan78xx_resume <- usb_resume_interface
  phylink_resume <- lan78xx_resume
  phylink_start <- lan78xx_resume
  phy_start <- lan78xx_resume

phylink_start + phy_start report lan78xx_resume as parent
since both are tail calls. On tested kernel phylink_start is tail call
optimized since with CONFIG_SFP=n sfp_upstream_start() is an empty stub.
---
 drivers/net/usb/lan78xx.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 181e8c087655..0136818e8cb0 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -5371,6 +5371,12 @@ static int lan78xx_resume(struct usb_interface *intf)
 out:
 	mutex_unlock(&dev->dev_mutex);
 
+	if (!ret && dev_open) {
+		rtnl_lock();
+		phylink_resume(dev->phylink);
+		rtnl_unlock();
+	}
+
 	return ret;
 }
 
@@ -5385,15 +5391,7 @@ static int lan78xx_reset_resume(struct usb_interface *intf)
 	if (ret < 0)
 		return ret;
 
-	ret = lan78xx_resume(intf);
-	if (ret < 0)
-		return ret;
-
-	rtnl_lock();
-	phylink_resume(dev->phylink);
-	rtnl_unlock();
-
-	return 0;
+	return lan78xx_resume(intf);
 }
 
 static const struct usb_device_id products[] = {
-- 
2.55.0

