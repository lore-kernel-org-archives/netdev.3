Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E16B1A6806
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 01:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786239405; cv=none; b=FcHRZOCJLhM89b14u88YdOsG1F5FQs6jz4+DJDrIEn8CYihcPHW7p5J0ks3MYv8aLWv521u03v9CIIpEFVdOgVGcpwnWi8Vtx80aDEbMUIpdhlQ0IUKsqAJGB31T7VKOFrSr68YX4HRyS3f3DlBEX5bXNC50vUj4gzl47cWUtyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786239405; c=relaxed/simple;
	bh=Ei3pMhsnf4GkPq0oKct7APjsPc/h+psB/WbM00ANjyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHnhL0DKXrk4igsN71Dn8TfsOJZHXT5LTmVT06sEfamkbU5YwUrYecb5EPzFuW4bLUxpENSQNVKmN1slC34EoNVpWS90+5oSbfZ7RyTuLlAIGrt2W+FsBudCr3/0s99qTOZ0OXWjsgXmS8zcOF7GTIPUM9e1czMqLw8Y7J7IvX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3s7UHZP; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3s7UHZP"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38759bcd877so742267a91.2
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 18:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786239403; x=1786844203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gVEVrHlkZUaS9xykoBr5aP1PUFTxMVcNoMBJNyWrgMI=;
        b=T3s7UHZPqmsogmbHmwq7RfMdaA90A/XSB5V6w2oBKD+5w2n8rQAzsDA2/USgtVlnhO
         4aU+x3m+11Pj4RfEE0jvwNlVH44b8T2XjLYN0IYBqcBLd1Hb/+av/qahsTrmmOxwITSb
         OJWfeQFnUTi3Tqpi3RkFw5NE5jS73W965NPA+g/EZysW0SU7A5Timy2k3Uq9kQlsLH/b
         icxLNtPGdv8rxC4De26YPdADVYDc+tuedvsqeZsM/kymrOXQ3p86GOYl92BHDUBC/JNd
         +4/oWcv/OdEkynklR6+jB62H0W4DcgBKyuYudGRjT6hedGmOdrXmHLX0iklYOqMI/VMO
         tMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786239403; x=1786844203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gVEVrHlkZUaS9xykoBr5aP1PUFTxMVcNoMBJNyWrgMI=;
        b=gmQn+fQfLRphEmlpZEwR4l8d5mEWJcy4oFkyPEcAH3XO9+mywT4U6vbbj19/e8OjDE
         IMhMCezFCuBePkminAorjFg0RcA+3KSlAUr2nF/a2vmDqZd0cNrWHcAihtdDZ+dbxYNx
         hjTxkQVIILi+k5E1DGiPVyU/b9b+0/hzqhVJEXm0qwXEokzBBatFK7EZwEJulYX8KuSt
         196UaZDfv7Svsyr5K0veh8Zxj0lO1wBurtLyYd9BWQYID3oAc4jfVgOP54s2F0sWBffz
         Pd3BFajY17ywfezk89MgJvP/tukf5z7ufk3Y7d9m52ypTYh0R4wO5R6WrUUZtj7yfulB
         KfcQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp+yQhkDD7pqkOnEvr1n04Mkp5y09kb4KR9Fqe3axh1M5qWT9DNSoZ0B90dA1Tk/VlDxLQNV70=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMeKYKGqNRew3+fmJHpyB3y9dgan4awf9t4+ZkASyzDFMG0YgM
	2OJ3dvDiVEj0JlAJOhyByjxNV31wMQYSBc1TCJ/IYJgV4Fsn45HNWNc0
X-Gm-Gg: AR+sD10gi2Y7VSK5nl1lty3zYqe/PW0swhmNQYmM6BV/zLvb0+OJmLoCaR5jtnZwc/7
	fxwF7l1RV0fEAAsZb2pIGUIZIg4jT0Kb9TnndSsbdduFwn6XmKByjPPxzUycltLEyeT3GkNbJZ5
	HBdCWs2DAwGvOI6wx8/taSv3lBtASVRFRsITUA9tZKqbGL8f8m5dVROnvCOEPOzuBH+Rd79hjmr
	OEjuhFydQjfToXiOAyuPImJo4cCkWAB6AHGWixYVqFgK/Ytqkp0QNHMXgm8ChvMmofatmcDiyLA
	YSEz67bWR8Xq8qb+PVvmcIk0e/+JRy9tRMDcf27n7NPpcQ8MsSQDqW2GaJjjIyOI3SH/66AJlu7
	75v6PfiJDotoE8Ja0k94bo7nXNHD9LNqImLSHlu8ii3N2h8M5cNQ8ep4qKbaA0M4SOd1ED2Cweo
	RrtDVdedjkzvw7Fbdgu62gy/a5l057N8GUfHYP+fDENkjwoJxJhHkaudoV7vBBLQ4=
X-Received: by 2002:a17:90b:2d84:b0:38f:18f9:785 with SMTP id 98e67ed59e1d1-3903c538263mr33513410a91.8.1786239403199;
        Sat, 08 Aug 2026 18:36:43 -0700 (PDT)
Received: from Inspiron5409 ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390b33225e0sm3823275a91.4.2026.08.08.18.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 18:36:42 -0700 (PDT)
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
Subject: Re: [PATCH net-next v6 00/13] ax88179_178a: Add support for AX88179A-based chips
Date: Sun,  9 Aug 2026 09:36:28 +0800
Message-ID: <20260809013628.3165246-1-neuromoments@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806-ax88179a-v6-0-fde7414619e6@birger-koblitz.de>
References: <20260806-ax88179a-v6-0-fde7414619e6@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Birger,

I tested v6 on the same ASIX AX88179B adapter (USB 0b95:1790,
bcdDevice 0x0200, firmware 1.3.0.0).

The 13 patches applied to net-next commit
df13c1df8147675470213ffff29dd5762fa321f5 and built successfully as
7.2.0-rc3-ax88179b-v6. The full build and focused W=1 builds for ax88179.o
and ax88796b.o were clean.

All 13 fresh direct-kernel QEMU starts completed a new DHCPDISCOVER at
1000baseT/Full without reloading the driver. This includes five functional
runs and the eight independent suspend/resume runs described below, so
I did not reproduce the v5 cold zero-RX failure.

However, I reproduced the intermittent 100-Mbit carrier-without-RX problem
in two of the five functional runs. In both failures, advertise 0x008
negotiated 100baseT/Full and reported carrier, but ARP remained incomplete,
bound pings to both the gateway and test host failed, and the RX counter
did not move (60 to 60 and 61 to 61) while TX increased. The same
transition passed in the other three runs.

In both failed runs, the subsequent advertise 0x002 transition negotiated
10baseT/Full and passed traffic, and restoring the default advertisement
negotiated 1000baseT/Full and passed traffic.

Default 1000baseT/Full, 10baseT/Full-only, restored 1000baseT/Full, EEE
disable/restore, pause enable/restore, and a read-only EEPROM query
otherwise passed in all five functional runs. In the fifth run,
I additionally unloaded and reloaded ax88179 and ax88796b; DHCP, both bound
traffic paths, and RX growth passed afterward. QEMU USB detach/reattach
also removed the device, reprobed it, reacquired DHCP, and passed both
traffic paths with RX growth.

I also ran eight independent QEMU ACPI S3 suspend/resume trials: two with
Wake-on-LAN disabled and six with magic-packet wake configured. QEMU's
monitor confirmed every guest was paused in S3, and I resumed each guest
with system_wakeup. All eight returned SSH and 1000baseT/Full carrier,
passed bound gateway and test-host traffic immediately after resume, and
showed RX growth immediately and again during the 10- and 20-second delayed
checks. Thus I did not reproduce the v5 post-resume frozen-RX state in
these eight v6 trials.

I then investigated the reproducible 100baseT/Full failure further. The
immediate failure mechanism is that the adapter's MAC loses
AX_MEDIUM_RECEIVE_EN (0x0100) after link configuration.

With a diagnostic register dump, a successful 100baseT/Full transition
reported:

medium mode: 0x0102
RX_CTL: 0x0198
MAC path: 0x03
bulk-in: 05 c0 04 06 0f

A failed transition reported:

medium mode: 0x0002
RX_CTL: 0x0198
MAC path: 0x03
bulk-in: 05 c0 04 06 0f

Thus the only captured difference was AX_MEDIUM_RECEIVE_EN being clear.
ftrace from a separate failure also showed that bulk-IN URBs stopped
completing after the link transition even though usbnet_bh continued to
run.

An immediate readback in mac_link_up() was not sufficient. An exact build
with that diagnostic reproduced zero RX after an EEE restore, showing that
AX_MEDIUM_RECEIVE_EN can be lost after mac_link_up() has returned.

As an experiment, I therefore added a delayed check one second after
link-up. If carrier is still present and AX_MEDIUM_RECEIVE_EN is clear, the
worker restores the bit and verifies it by readback. The work is cancelled
on link-down and synchronously cancelled during stop, suspend, and detach.

In the first run with this final experimental patch, the worker directly
detected and repaired the condition twice, after the 100baseT/Full link-up
in stress cycles 03 and 07. Both cycles then passed bound gateway and
test-host traffic. All ten 100baseT/Full -> 1000baseT/Full stress cycles
passed, as did cold DHCP, 10 Mbit/s, EEE, pause, module reload, and USB
detach/reattach.

A second fresh run passed another ten stress cycles without a failure.
Separate deep-S3 cycles with both wol d and wol g passed immediate,
10-second, and 20-second post-resume traffic and RX checks.

The experimental patch builds from v6 head b61cb69fb19f0 and passes focused
W=1 builds plus strict checkpatch (0 errors, 0 warnings, 0 checks). For
reference, the experimental diff is:

    diff --git a/drivers/net/usb/ax88179_lib.h b/drivers/net/usb/ax88179_lib.h
    --- a/drivers/net/usb/ax88179_lib.h
    +++ b/drivers/net/usb/ax88179_lib.h
    @@ -319,6 +319,7 @@ struct ax88179_data {
     	struct phy_device *phydev;
     	struct phylink *phylink;
     	struct phylink_config phylink_config;
    +	struct delayed_work rx_check;
     	int (*resume)(struct usb_interface *intf);
     	int (*suspend)(struct usb_interface *intf, pm_message_t message);
     };
    diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
    --- a/drivers/net/usb/ax88179a_devices.c
    +++ b/drivers/net/usb/ax88179a_devices.c
    @@ -124,6 +124,7 @@ static int ax88179a_suspend(struct usb_interface *intf, pm_message_t message)
     	u8 tmp8;
     
     	priv = dev->driver_priv;
    +	cancel_delayed_work_sync(&priv->rx_check);
     	ax88179_set_pm_mode(dev, true);
     
     	if (netif_running(dev->net)) {
    @@ -417,16 +418,56 @@ static int ax88179a_init_phy(struct usbnet *dev)
     	return 0;
     }
     
    +static void ax88179a_rx_check(struct work_struct *work)
    +{
    +	struct ax88179_data *data;
    +	struct usbnet *dev;
    +	u16 mode;
    +	int i, ret;
    +
    +	data = container_of(to_delayed_work(work), struct ax88179_data,
    +			    rx_check);
    +	dev = netdev_priv(to_net_dev(data->phylink_config.dev));
    +
    +	if (!netif_device_present(dev->net) || !netif_running(dev->net) ||
    +	    !netif_carrier_ok(dev->net))
    +		return;
    +
    +	ret = ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
    +			       2, 2, &mode);
    +	if (ret != 2 || (mode & AX_MEDIUM_RECEIVE_EN))
    +		return;
    +
    +	netdev_warn(dev->net, "RX disabled after link configuration, restoring\n");
    +	for (i = 0; i < 3; i++) {
    +		mode |= AX_MEDIUM_RECEIVE_EN;
    +		ret = ax88179_write_cmd(dev, AX_ACCESS_MAC,
    +					AX_MEDIUM_STATUS_MODE, 2, 2, &mode);
    +		if (ret != 2)
    +			continue;
    +
    +		ret = ax88179_read_cmd(dev, AX_ACCESS_MAC,
    +				       AX_MEDIUM_STATUS_MODE, 2, 2, &mode);
    +		if (ret == 2 && (mode & AX_MEDIUM_RECEIVE_EN))
    +			return;
    +	}
    +
    +	netdev_err(dev->net, "failed to restore RX after link configuration\n");
    +}
    +
     static void ax88179a_mac_config(struct phylink_config *config, unsigned int mode,
     				const struct phylink_link_state *state)
     {
     	/* Nothing to do */
     }
     
     static void ax88179a_mac_link_down(struct phylink_config *config,
     				   unsigned int mode, phy_interface_t interface)
     {
    -	/* Nothing to do */
    +	struct usbnet *dev = netdev_priv(to_net_dev(config->dev));
    +	struct ax88179_data *data = dev->driver_priv;
    +
    +	cancel_delayed_work(&data->rx_check);
     }
     
     static void ax88179a_mac_link_up(struct phylink_config *config,
    @@ -544,6 +585,8 @@ static void ax88179a_mac_link_up(struct phylink_config *config,
     
     	tmp8 = AX_MAC_RX_PATH_READY | AX_MAC_TX_PATH_READY;
     	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_PATH, 1, 1, &tmp8);
    +
    +	mod_delayed_work(system_wq, &ax179_data->rx_check, HZ);
     }
     
     static void ax88179a_mac_disable_tx_lpi(struct phylink_config *config)
    @@ -741,6 +784,7 @@ static int ax88179a_bind(struct usbnet *dev, struct usb_interface *intf)
     		return -ENOMEM;
     
     	dev->driver_priv = ax179_data;
    +	INIT_DELAYED_WORK(&ax179_data->rx_check, ax88179a_rx_check);
     
     	ret = ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_CHIP_STATUS,
     			       1, 1, &ax179_data->chip_version);
    @@ -840,6 +884,7 @@ static void ax88179a_unbind(struct usbnet *dev, struct usb_interface *intf)
     	u16 tmp16;
     	u8 tmp8;
     
    +	cancel_delayed_work_sync(&ax179_data->rx_check);
     	/* Configure RX control register => stop operation */
     	tmp16 = AX_RX_CTL_STOP;
     	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &tmp16);
    @@ -1149,6 +1194,7 @@ static int ax88179a_stop(struct usbnet *dev)
     	u16 reg16;
     	u8 reg8;
     
    +	cancel_delayed_work_sync(&ax179_data->rx_check);
     	ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &reg16);
     	reg16 &= ~AX_MEDIUM_RECEIVE_EN;
     	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &reg16);

Because the unmodified v6 series still reproduces the intermittent
100baseT/Full carrier-without-RX failure, I cannot add a Tested-by for v6.

Thanks,
Jianhui
