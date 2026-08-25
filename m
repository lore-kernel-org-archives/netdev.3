Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77043DDDD0
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646322; cv=none; b=DngYpu4Xy+pMhUBGa5YJ9O7gNd6h6lI0tcJpOTQqZEQKIVCGt1wdFUOvDQwVifZ34znGX6DhNRe/F6OviT8XXtPDK2jOf3zrEfLOHCUv3glMh9fMygjAWqRZ2wsrlBY/EzzMd+t9SWbzHAtQlm0J+77CCMu8VOHSAieB6+qR9AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646322; c=relaxed/simple;
	bh=VfVZpijrHVh/yqDTYgIn9w40MsBKaMPEfVIcuaxuRcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+NVhzStI3FmF2I5RzwkgmgRs/BGnFZQ7Fbq6DvDY7ki7fet28qz0l80zwbf5OOkK+YDiOy/s+g0JfxzkiIAupqJ6UhDQnfuFXGeGKf0GW15HxvuV6M+L4Jna0bbYlxDjQaC4WHyn4qJq91Bp7omEiZNVvnDZT8vdZi3EhjZB/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=JMZSLnnc; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="JMZSLnnc"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a41191c9a9so8743343a12.3
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 01:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1787646316; x=1788251116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T+GmOXb9Tj8w1juq3zBvXWG+Sp5F29uvntBWqcEPNXY=;
        b=JMZSLnncOMsYKVW2L/HctN6j05qObmfGOW5Gyum3a3Og6QKkUDtUKcBk9GqTriI2fH
         iAzE48gf9iwE+O3l5dpbAnOjRIHBnqGiUGnr9CNkQu9ekEVT+ziDMsN1Yr/NKP7taiTe
         j48R0zhBQVNC3I9xIPT2ASlzrqBgu0ONUyGA/b7miE+EetAstUJNH/DEaCzKa4Hmvkpe
         yzHSiDvqNw6ZdedPksP05gPQ7H1kymwiiAsrMCWUekqqArzARfN4WABbwNfy9wLJfVt9
         QQ8JFwSlUOkI/Ei1kV9K+ujIsRjmk14Dwvki1sXrAigk0IJKmMgUUsKrGnBLis9abXwS
         HI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787646316; x=1788251116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T+GmOXb9Tj8w1juq3zBvXWG+Sp5F29uvntBWqcEPNXY=;
        b=Es2jOvTbMgbfRtciUvIiy/JZ+7k2d4FclnnesBPl8K3U8+9MlBWCpuUQy+TzQiQwGK
         BeqjVykcLQKYzJuL6Cx146u/6oHV46WvfqX1sye/w0FjEtxPm2WIMHzpXx6sjUZTbPmK
         RW/pNYSU83hYeYMB8qDJ5e/bfcIQFIAfoIoXeNkwbZ3ITEh4JSvPctCj7sGp6zPiwCTY
         vhz0FkURCNJ0pIJTUL9bfDUkCI2GWwIhftLD3PldLFplb6zntllLcbs0YIDtwIPUQffb
         j2YrOF6pNEIpctbDCwlPRI3IBapGvA2ednA5UC55N0XPKiTefEcq7DCD13WyXy9tckjc
         8UVQ==
X-Forwarded-Encrypted: i=1; AHgh+RqAJg7j4Dzio9diRqcGsAZ8CBw42caNHaqxmUdWk0Hkdt/v/AQkzd+3CYj8kuzXkq2IHWjX9RU=@vger.kernel.org
X-Gm-Message-State: AFuF++l9M9IQMY5VmANl86KIEyPOImiiCnfkvwVRyuMf5OM3veXcYFOA
	5sbPa+d9nXlGxdL8JcSE37CkYkTYJCtHr8KvA12ZGcvk5E7EhxuWay2S8YZSLdAbaSM=
X-Gm-Gg: AR+sD12FOgQjNuG1KgJUuIWWmaif35/fP7+NpN3yYEJOojf4M7/cM53OD2rEAPw52e+
	xXoiwJcLxw7fOU6lJW1d0h1zZHfRxtsnCI+ojTanWQBni7X3xzqFXEXeRjpxUpiy+6S+ZEgQVrP
	IzPqbv+9d2r7A+dJMwIlVpPI8PYszcDFQtTJMon/Wj0HHxZSb/U4+muQ0rt84565iaxaj5kxkLU
	h+xINxL7L1znnlgiPmJHolpDYfNTdi20gcPkCwE/ErbtKNpBnQEvZVyIqPPbBlEZDRI+zFinlxk
	exmldt4X4qmlizSrQrAqA2lWPMfLivSY58zV3mTQw2LwAnAvEsgyCwBgIALyhd2tkgzKyrSN9UK
	JJoVrTfNXX/9Y+6NglPUr3YqqjTITAC8UgzVOdItkR08SneouIghZ3wTtrGkN+W+7GJSfC9c37L
	htrq5ZkdHqWn1mdl40oW3+dWGCVUKJ4VNFR3hUtae/MDBKS8yThTxthtQ=
X-Received: by 2002:a05:6402:3547:b0:6a3:6b8f:94ce with SMTP id 4fb4d7f45d1cf-6a42f13c1a1mr34782758a12.3.1787646316376;
        Tue, 25 Aug 2026 01:25:16 -0700 (PDT)
Received: from ownbook ([62.168.185.120])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e1d7399sm18660833a12.26.2026.08.25.01.25.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 01:25:15 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: Re: [PATCH net-next 0/3] net: survive a PHY whose driver arrives after the switch probes
Date: Tue, 25 Aug 2026 11:25:12 +0300
Message-ID: <20260825082512.63501-1-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <a230d199-5d4d-4637-aff3-e725a37e1da1@lunn.ch>
References: <a230d199-5d4d-4637-aff3-e725a37e1da1@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew

I built it: both halves, as an MVP on my board. The MDIO device with a
nested pass-through bus for one address, and slow-to-probe in phylink
with a poller modeled on the SFP path. The port survives the switch
probe, the poller connects the real driver a few seconds later with its
interrupt from DT, and it held across reboots in both topologies. Holes
I hit, all on real boots:

1. "Polls until it resolves" needs a stricter resolve than the device
existing. A phy_device with no driver gets genphy bound by
phy_attach_direct(), which cannot drive this PHY;
phylink_sfp_connect_phy() already refuses a driverless PHY for the same
reason. And "driver bound" is still not enough, because the core
assigns dev->driver before probe runs. A poll tick landing mid-probe
connected a PHY with an all-zero supported mask:

  lan4: validation of 2500base-x with support 0000000,00000000,00000000,00000000 ... failed: -EINVAL

What survived hardware: driver bound, not genphy, state past PHY_DOWN.

2. The poller needs rtnl to connect, and phylink_disconnect_phy() runs
under rtnl, so a synchronous cancel there deadlocks. Trylock plus
requeue in the worker, non-sync cancel at disconnect, sync cancel only
in phylink_destroy(). A failed connect must not stop the polling, errno
cannot tell the race above from a permanent failure. The retry needs
backoff though: failed bringup goes through phy_detach(), which pulses
the reset line, and this chip's firmware lives behind that line.

3. Returning 0 for the armed case matters beyond the error code: on
-ENODEV, DSA goes looking on the switch's internal MDIO bus and
attaches the internal GbE PHY to the 2500base-x port, which then fails
validation.

4. Polling costs one interval of latency. The tick phase is set when
the port arms, so the attach lands anywhere in [0, interval) after the
PHY becomes ready; I measured 0.7s of a 1s interval. The exact event
exists, BUS_NOTIFY_BOUND_DRIVER fires at probe completion, but
mdio_bus_type is internal to phylib, so the notifier has to live there
behind a small API, it still needs the genphy filter, and the callback
runs under device_lock so it still defers to a workqueue. My plan is
polling first and the notifier as a follow-up, unless you want it
event-driven from the start.

Two questions before I send the series.

My MCU driver only waits for the firmware files and registers the
nested bus; the download stays in the PHY driver, which already does
it. Moving it into the MDIO driver duplicates the loader for a quad-PHY
case no board has yet. Is the MCU-side download a hard part of the
design for you?

On this board the minimal variant, slow-to-probe alone with the PHY
node directly on the bus, carries everything by itself: the chip
answers its ID from the bootloader, and the driver and firmware arrive
together. The MDIO-device layer buys the general case (chips silent
before firmware, quad PHY, reset ownership). Both layers in one series,
or slow-to-probe first?

	Aleksei
