Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D013339E164
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 10:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788691239; cv=none; b=pcRoYC+7yhDkZpye8mL6joKo734KLI8JEZU7Yh185W2rBe5bLhL+i1a2tZDlvuAf2QBjUy4RVk1kPtdN0IcnSYnAHDbxgSHxjvE34+UUsOOWAs4QYacWFl+tpDpQxN+mXSqFI8tEeM/u/H/bfHwNtY7mouD+vYKrvep7/N10VL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788691239; c=relaxed/simple;
	bh=uAhrT+PypEKPVKxsXYm/We3hYY33WoXhlipb+JUEb/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1MF7pGcOeaVPZLEBsR3SXPHa58yJbNLKbxyr/Ep9wp23FYMMEMBvmKGYznMe7g2lhqf0LNAZUsKFwUvRvHkthV7JZZWB59D2hJgQ9Oq9CdrhQHhRvQ8mbp3dZSssFB2yviAZnPiOM/bTaCxmvPpDkraAkOvbmfjuCymQlZTGOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p0ZgDVUo; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0ZgDVUo"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8485b358552so2229313b3a.2
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 03:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788691237; x=1789296037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E1LarLvSRmevVAVo2Vo8sPo4MFHSG5iHKYww3996shg=;
        b=p0ZgDVUoiZ/Z2cAFt2Sc/VTtlOk5bPo9yQBLiQeaLNroOgl01bjZd9tzxn6qJ97rc+
         RJ11hZHKJN5ch72G41+u5CjAsuCYRW1FWq3jPu5aX0MaISFEfIptb4IMhYDXd/0LUzbN
         6PcXhWsBmQr9832iqz4DGqhk3RTYTxQQmKNyGqKTieIPF8QvaOMmROBK0giNg/jhXTUq
         HCVJk+5iw5adgVHMh1Lz6tRs2CGygWcn17SckzTj8+MiZdBC2slVmYsidvYojw3fDVOe
         r7TF6CaRIBgm6ZbhN0UoAWgczXzATdcbNFgkFHnxfY4bAy67c0vRGtl6SwR5MO28nHm1
         85Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788691237; x=1789296037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E1LarLvSRmevVAVo2Vo8sPo4MFHSG5iHKYww3996shg=;
        b=JYaRO7qrV0ypf9t49wodDAtWGi1GbM8OSb2emME3AdHWLcDp5dUwM9ig0x1UJ9Kk9o
         9nQQglWpg3IemCktLZOkFJcQ+2tuMgNnIbKruch9SbRj6BHMvUtR2H/bqWJccILX9tN5
         d9yJvN7I7//WTBdZ6f4NO5mzFGVQ+C/nvbOlVg/lygh7EZe9mUCx6kPqGiIUx22luCRU
         oCZqKkuLjAgDyIeb2zPeu8uq/dqAY1kIKzgPLhL9vlJ9UhonIET+Iwl/yl5gwRf+TIWe
         t9pgNtalNySKTUytYPiCvxURT598KEC6XSKjvHVGqHCFjEdKew1ORSeEA+Na8X6pnLUc
         uLxQ==
X-Forwarded-Encrypted: i=1; AKwUvBzEJ4YxI94Si9KknHz7Sloh3otn2rhmgv1hm8t/wm5lWQCl5AEwiaqoMRnUE7MkPm7QZ+ut9Cg=@vger.kernel.org
X-Gm-Message-State: AFuF++lupyohiXws/r6FhqR1EWi54i7V7YJ78obgBKvycZVZK/5RKFkk
	ZR/dHai5d6qYfMStt6my6B9co1k436plad7esKFRg0OUJXjgQaJXFmgK
X-Gm-Gg: AYBFou1HSwu6vllLSxot0qlaAuMG0iam+X3WJoxrmj6HAvAGzeSaQXiG1j4QL01bxvP
	UGOCZ3/fnEO90tHfVVi7+ZmI4GRFTkkbZJJS+rhxSRvI3ZTxtchDIIb1wlGA/axOfAQSFVlNbuI
	sXXzSRhE7bH8xcuAXXmI9gkNP/0EkHpnlyZ5pHSRySiRfGH+KBKDvOU8MxWmj9g1+xT+wI1AZ0y
	vN7tWaangewekUly70prcK5SRQbOAbONoDZGWjVRTQjJhbanhvl+YjZVgI1oaTAOUMolewMuLsa
	Gq9utRc7hjAIvoh+rBxjGmTXVh3xCqvu4/jLDFt2n3SP0mnurZPlk4OjypS2e+wy1+qeCqvqzx7
	Jneq4oB3nvUUc+FDDqVed8nO5V2t/tkmP/dILyDlT/mF73ApYFlf9sR1XpraWj3FL7mHIYTaXun
	XsKnomPc9EdkZVliqyFnoYB9DSgaH06ItyTfAZnc1E8UJc74a8DKClR040CG44IHHPYdGKtCoat
	0s7JdIOfitkV7hAkpsvwKmaZ58uNg==
X-Received: by 2002:a05:6a00:3008:b0:857:3b70:209 with SMTP id d2e1a72fcca58-86167aa9918mr22803297b3a.1.1788691237085;
        Sun, 06 Sep 2026 03:40:37 -0700 (PDT)
Received: from Inspiron5409 ([2401:b60:5:2e5::a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8614c699735sm3131706b3a.0.2026.09.06.03.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 03:40:36 -0700 (PDT)
From: Jianhui Xu <neuromoments@gmail.com>
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	neuromoments@gmail.com,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v10 00/15] ax88179_178a: Add support for AX88179A-based chips
Date: Sun,  6 Sep 2026 18:40:31 +0800
Message-ID: <20260906104031.78051-1-neuromoments@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904-ax88179a-v10-0-b5e60eca7690@birger-koblitz.de>
References: <20260904-ax88179a-v10-0-b5e60eca7690@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Birger,

I tested v9 on the same ASIX AX88179B adapter. By the time you read this,
v10 has already been posted. Given the relatively small differences between
v9 and v10, I expect the issue I found in v9 to apply to v10 as well.

First, as you already noticed, `data` is undeclared.

For QEMU runtime testing I also had to apply Chen-Yu Tsai's unrelated
`usb: xhci: Fix HCS_ERST_MAX conversion` patch. Without it, this base kernel
fails to initialize QEMU's xHCI controller before the network driver is
reached.

All three fresh functional starts completed cold DHCP at 1000baseT/Full
without reloading the driver and passed the normal 1000/100/10/1000 Mbit/s
matrix, EEE disable/restore, pause enable/restore, and EEPROM read.

During repeated speed transitions, I observed one intermittent carrier-loss
failure. Of 19 normally initiated restores from 100/full to the default
1000/full advertisement, 18 passed and one failed to regain carrier. After
that failure, ethtool reported unknown speed and no link, and further
advertisement changes did not recover it. Dmesg showed the preceding
100-Mbit Link Up followed by Link Down, with no subsequent Link Up before
the device was reattached.

I could not reproduce the failure in two later fresh starts or in a further
90 unmodified-v9 stress cycles. Counting the normal matrix and stress
points, all 22 tested 100/full points passed, so I also did not reproduce
the earlier 100-Mbit carrier-without-RX failure.

I repeated the QEMU deep-S3 tests as well. One fresh `wol d` cycle and five
fresh `wol g` cycles all passed. After `system_wakeup`, management SSH
returned, the adapter regained carrier at 1000baseT/Full, and gateway and
test-host traffic increased RX. These tests use QEMU-emulated xHCI and
monitor-triggered wake, not a physical xHCI controller or an actual magic
packet.

I then investigated the intermittent carrier loss with function tracing.
Each advertisement change generates hardware link-down and link-up status
notifications. V9 forwards both to phylib even though the ethtool-triggered
PHY state-machine run has already taken the link down before the hardware
down notification is handled. This results in three PHY state/read-status
runs per advertisement change, including a redundant read while
autonegotiation and controller link setup are still in progress.

In light of your previous observation [1]:

> There is a race condition between the controller of the AX88179A
> trying to set up and optimize the link and phylink trying to
> configure the link on the mac-side.
>
> At this point, the PHY may report that the link is up before the
> controller is actually finished configuring it.

I suspected that the redundant PHY read during autonegotiation might
interact badly with the controller's own link-setup sequence.

As a focused experiment, I changed ax88179a_status() to inspect
AX_INT_PPLS_LINK and track whether phylink currently considers the MAC link
active. A down notification is ignored if phylink has already taken the MAC
down, while up notifications are always forwarded. mac_link_up() marks the
state active before configuring the MAC, so a genuine down event during
configuration is still forwarded.

The experimental kernel built successfully, including focused W=1 checks,
and strict checkpatch reported no findings. I then ran:

- 100 rapid 100/full -> 1000/full cycles;
- 30 paced cycles, holding each endpoint for 8 seconds;
- a 2-cycle trace smoke test.

All 264 requested-speed endpoints reached carrier at the correct speed. The
fixed traces consistently showed four raw status callbacks but only two
phylink interrupts and four PHY reads per complete cycle.

But this does not necessarily prove that the change fixes the original rare
failure: that failure occurred only once in 19 normally initiated restores
and could not be reproduced in another 90 unmodified-v9 stress cycles.

The experimental patch follows for review.

Thanks,
Jianhui

[1] https://lore.kernel.org/netdev/5b2c4498-2e3c-4ae6-b078-deeccf8b7a5c@birger-koblitz.de/

---
 drivers/net/usb/ax88179_lib.h      |  1 +
 drivers/net/usb/ax88179a_devices.c | 19 +++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/ax88179_lib.h b/drivers/net/usb/ax88179_lib.h
--- a/drivers/net/usb/ax88179_lib.h
+++ b/drivers/net/usb/ax88179_lib.h
@@ -306,6 +306,7 @@ struct ax88179_data {
 	u8 is_ax88772d;
 	u8 ip_align;
 	u8 link;
+	bool mac_link_active;
 	u8 speed;
 	u8 full_duplex;
 	u8 rx_checksum;
diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -118,11 +118,22 @@ static int ax88179_mdiobus_write_c45(struct mii_bus *bus, int addr, int devnum,
 static void ax88179a_status(struct usbnet *dev, struct urb *urb)
 {
 	struct ax88179_data *data = dev->driver_priv;
+	struct ax88179_int_data *event;
+	bool link;
 
 	if (urb->actual_length < 8)
 		return;
 
-	phylink_mac_interrupt(data->phylink);
+	event = urb->transfer_buffer;
+	link = le32_to_cpu(event->intdata1) & AX_INT_PPLS_LINK;
+
+	/* Changing the advertisement has already told phylib that the link is
+	 * down. Avoid another PHY read while the controller is still setting up
+	 * the new link, but always process link-up notifications so that speed
+	 * changes cannot be missed.
+	 */
+	if (link || READ_ONCE(data->mac_link_active))
+		phylink_mac_interrupt(data->phylink);
 }
 
 static int ax88179a_suspend(struct usb_interface *intf, pm_message_t message)
@@ -437,7 +448,9 @@ static void ax88179a_mac_config(struct phylink_config *config, unsigned int mode,
 static void ax88179a_mac_link_down(struct phylink_config *config,
 				   unsigned int mode, phy_interface_t interface)
 {
-	/* Nothing to do */
+	struct ax88179_data *data = netdev2data(to_net_dev(config->dev));
+
+	WRITE_ONCE(data->mac_link_active, false);
 }
 
 static void ax88179a_mac_link_up(struct phylink_config *config,
@@ -448,9 +461,11 @@ static void ax88179a_mac_link_up(struct phylink_config *config,
 {
 	struct usbnet *dev = netdev_priv(to_net_dev(config->dev));
 	struct ax88179_data *ax179_data = dev->driver_priv;
 	u8 tmp8, link_sts, reg8[3];
 	u8 bulk_config_speed = 0;
 	u16 tmp16, mode;
 
+	WRITE_ONCE(ax179_data->mac_link_active, true);
+
 	/* Stop RX/TX for link configuration */
 	tmp16 = AX_RX_CTL_STOP;
