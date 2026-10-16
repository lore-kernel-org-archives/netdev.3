Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC6B3921ED
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 06:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131101; cv=none; b=D0CQO11WtPrByVusZf+BK4FHP2prkGM1DS5huL32PFWZKYiW3qUiHNQFLUI6ujMmTk6OOv6kJoomaASEliXgMhgZ5xtb3XLW48aC7PmRCbPP03VnpNPsxeLYa8ZXDhxHFXun277h8FaQxNy3Y0PQ5IYvxcF8WYnRFrlKDC7cmmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131101; c=relaxed/simple;
	bh=lW1SmNMHZLUdjwKr2y0L+Tr3WFC55TvE/uJFRdnFpiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RxU2W/YlE6Tqih24qmzhZTYKMnrk/pn2Y+ZZi4PB23d6ibjp0kAi0e4zO/hF24XmFjRKuH88AQoq0B4QTgA1TgaUS7xk6293YF1pFk7+KuPa2y34aHhcuOW/t10t/wYi7A/Sah3jXovgdvqyyrnKuWdTApsPiKNHHblVVZggjg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwhkdu3C; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwhkdu3C"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35aa0cf7c40so6387435eec.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792131099; x=1792735899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MWmAXF+DT/idqJMn3V+iTCr8CLKa/928BqRixUV3uIo=;
        b=dwhkdu3C+XLVN5zZZ5nFJlp+NYsKHrupg96O7mn8tHhUwFWA/cgiacTO3YXj1xttie
         8HeP/NRZpQ9tqYrRaqPX7r0XCFgIyXs/lHkJI3Tg2uGtjuGinoVyNUElHgYb/tdAf5d9
         CVawkIps8Kk69CJruc4RMzT+xGB56InDqNAERDb9f6ZKnBfC2fr1AgllOkDH1VW/dsPa
         Eq4dyonv4gxSgKez1RC0YQOFHnBm+ow8zbdFiBZyljBdUn3jFssZQ3xJVcLreHtz7xn9
         T+Iz5xbXcfKEZh+LgnzDTgsX0R6iehR1MYhdW0HmpauuAVtr/vyCs+XFiRWtwu3gJEeS
         Rhjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792131099; x=1792735899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MWmAXF+DT/idqJMn3V+iTCr8CLKa/928BqRixUV3uIo=;
        b=jF03H27B1eyFbyXoV2H0YU2hyyvptaeTdPleag8ar2yKIQf+s5mAg1qKQBJzN5za+i
         Q2fUyBO+bBzUXjJNo8RLC2RVxxTKRmlvHvLrGvX5E2EyqpFz+By3SSnhf7g/9iw4oBss
         M9GdF715bloYkL5IdgpiIBvI9ZPreJOrchGlb9HbwHsNwOHTBmdr1WMiNf/1FI65kJus
         l54pl1EZQQunlwMHwv01Izb8DVw8tw3b70vSKg8Yrkq7KZx81vgubrF4RvGGTj758+wU
         7E1VFw7MJncnNEfVugKIZoP9bVZPuYBjM1Ygrb90kfJlLW6M8jRD1oSKUzBffjeLbFSA
         feMw==
X-Forwarded-Encrypted: i=1; AKwUvByM1Zh5g9O8ySHZVpE+F7WSvOW39gYQWLSDebXuUK4yg59F6VPO+mozAqZvo8QdgGug46HkSvk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKme2IMlUKb93ILuxvra0wd0So6cJYOu//1W+peYVzjpc99mSQL
	WGiRSoj4sNkmCpBrJU8jFRbSbesF8WN938ogQpMihLc8Ei3L+/yOW+1j
X-Gm-Gg: AYBFou0vgwa2GLpuo6xGuKoXGO0ldSJptR/KteTlUDmyWzwOvROuBlzvyDGucd4+IoP
	IiqxQADYdgH5XTTUwAOEMl2sidSZzSaSFQteWf+vsCREoDI4lhlYD3iWgLo7xpq3jZlfQDN9MwU
	Mt/J/2iShczZV9no9T9TfUE8KsacF889HboECde5YeIuO4phHesJfYilT0KeukFs//W+kp25fKl
	cs65EOmXIBWf68LJ5GyBGMlNeOeWf850akuKcTRIEDyjJdpDwo4QI4aWHnXH8LLtWO7aE9JgFa6
	leKvbr40aOiFd2TkQkFVgYZiZLbBdXieaCWxVyRnO4+urL8XF1sSPohTnjFg+lAr/BxOboOCIqd
	PcHY4P/ht7v53cTTYrkEVUVIKwMVNmGa4OyyKEANjeCLlFVBF+Y4jUG1Haj/WLEu7W4XVAhl+D1
	PuG1ZALNRr58woLzKjHh4QYreuHyUOV3L1ofI/4suZI81hWFh7aooKnfIbE1cZ5PrvrxkN2Pa4F
	4gjelid7conQwn43ye6IsJkwL7Z4H8o6ZfvNlRQo3IB8DA=
X-Received: by 2002:a05:693c:4097:b0:358:8bd2:fda1 with SMTP id 5a478bee46e88-3588bd2ffb0mr34500666eec.30.1792131099385;
        Thu, 15 Oct 2026 23:11:39 -0700 (PDT)
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan ([183.242.161.82])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0d391sm3725600eec.4.2026.10.15.23.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:11:39 -0700 (PDT)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Max Staudt <max@enpas.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] can: can327: publish tty->disc_data only after register_candev()
Date: Fri, 16 Oct 2026 14:11:20 +0800
Message-ID: <e02d5a1d31bb8dbc6397e3469cd0578b85d78970.1792118038.git.chaosheng.qu.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792118038.git.chaosheng.qu.linux@gmail.com>
References: <cover.1792118038.git.chaosheng.qu.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

can327_ldisc_open() publishes the private structure to the tty layer
before registering the net_device:

	tty->disc_data = elm;

	err = register_candev(elm->dev);
	if (err) {
		free_candev(elm->dev);
		return err;
	}

register_candev() fails with -ENOMEM from register_netdevice() when the
device name node or the kobject cannot be allocated. The error path then
frees the net_device and the can327 structure in its private area, while
tty->disc_data still points at the freed memory.

Publish the pointer only after the device is registered, so the error
path has nothing to unwind. slcan does the same after its own patch, as
do ppp_async and nci_uart.

The stale pointer is not observable today: tty_set_termios_ldisc() clears
tty->disc_data before .open() runs and again when a failed ldisc change
falls back, and the ldisc entry points are serialised against .open() by
tty_ldisc_ref() (async) and tty_ldisc_ref_wait() (syscall). The change
removes a trap for the next modification of these functions.

The success path was tested by attaching N_CAN327 to a pty under QEMU:
the ldisc opens, creates the net_device and SIOCGIFNAME returns its name.
The register_candev() failure path cannot be forced from userspace and is
only compile tested.

Assisted-by: LLM
Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
---
 drivers/net/can/can327.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
index 90f5e35f3c8f..d40dadbb5733 100644
--- a/drivers/net/can/can327.c
+++ b/drivers/net/can/can327.c
@@ -1037,7 +1037,6 @@ static int can327_ldisc_open(struct tty_struct *tty)
 
 	/* Mark ldisc channel as alive */
 	elm->tty = tty;
-	tty->disc_data = elm;
 
 	/* Let 'er rip */
 	err = register_candev(elm->dev);
@@ -1046,6 +1045,8 @@ static int can327_ldisc_open(struct tty_struct *tty)
 		return err;
 	}
 
+	tty->disc_data = elm;
+
 	netdev_info(elm->dev, "can327 on %s.\n", tty->name);
 
 	return 0;
-- 
2.43.0

