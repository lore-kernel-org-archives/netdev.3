Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794266270;
	b=xEQHojxvTTdkwcPi6oi2g1YTDUBhSh+Gr2HUopTwgR8XrMz/c8cH7mjlw2t4FLLqO/i8
	 crxQ5il8FEo4tlExXmMLNnlLmbKSmuuccH31/vv2NLc6OWBct7LBWvP1LtjHrEHt/tUzY
	 PQe5lbFjCCw5m8BzlqxTLg18QeZCITAif/iwG9ZvO5J22E/ah1IjX7Hdpt7106nTjpFY/
	 bwcHXF+fITr333k5thp8Q8bsM+grx0QAUg5Y8aya22gi58Nr36ph1GZ1xJpMpIrVx6plh
	 9QeoLH1eoPv6jlQ67yuBnAlu0R2NBBsShUytpJWNhqDgNhq3xbK1HMQzaRF5yASByrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266270;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zfZnkNtscXNAJ3rRdG+HDotXVDvKorvk3Ow5BvApXdQ=;
	b=WUh2CWPH0YJr64E92NETgUUtmz2FdA0Y0cg7kkm8/po+0o3ux91gOthRPuWPs0GFUHRp
	 kVAkhWj7gWoZjQN28Z66ZpnW/6yCsSHMzOYF+ivmqMVfG9frM2EaW12OwqjZwMHX2S2kH
	 FKMCWHV+Rm6OrxMMPZ5rQi60kTN9GYtT7CQXtFypBfILoF0nP1qj6VHpbnmlQ2oQQ5zBw
	 SgYf8hbVqjICXAcTLXoCLQiWs4njx99A8rJE2tMldATGA9qzPHZFyDj84Oo++3Xbi+3nL
	 5dup4jvbMyTVz0l8IUaZXp7DdgGJ+MVKZd+W9TFKg4imoAf//e8PvWCCEnOTbEeIwug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PNuqizSz;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31E6606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E31E6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PNuqizSz
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c4d581da0aaso147683966b.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 15:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794266268; x=1794871068; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zfZnkNtscXNAJ3rRdG+HDotXVDvKorvk3Ow5BvApXdQ=;
        b=PNuqizSzcAOiS1i+BSw15C7WG69iLGMME4JAJHWYzfUNLhr0h2Ex04qdJl8+Mbd9Qn
         LQFtjtrzay4cnLge9ruWVpN11roLzTBuGJben9YEndvKCPUTspUVneir+nWJjhCbLxcD
         vgeONHrf0npyoDu/VAheUUWjm6nwA3i2S39b/kka6/n8Yiu/r0uT38xbQixDyvdf+AGu
         hUnkdlThyMqYJY1Grwq/TX9u7hk8D3smEGnNR+Yr9ntpoPBbYQFIEfkR1XMT0SOazVhN
         DX5nCpmi23/TmYZq7tD8VQM7ISzCxe0XgnT07hZtwp4EVij2YtMHczopFvXUT+Wn8Y2y
         LLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794266268; x=1794871068;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zfZnkNtscXNAJ3rRdG+HDotXVDvKorvk3Ow5BvApXdQ=;
        b=wiB3q49EjOfOvyFndcZmmEMkvpG1WuRx6P+b3I7GL49ipj6YCRJT6+nSN7d4pfXhVw
         t0XfAUd2TkSDDyB9cVT5YvsGZT3y5lyyQ7KP6WfMIvsKEco6vFNIJGtx9BVA6rkfpVH7
         7Q+Gvq0I/dp1Lx1PHD1C/RKNEDPuywvSK8bttfZ4eUB0uXqDuLMRF2bsq3TdLVWIDKGi
         9/oAwl0xMKmH24/SGiBQCOmq4BIR0o2TxswR8YF7MdwvzsaSY/FNU1UskruU9AjazElR
         SlTXuDrk16Dq1EUHF5WPY0Mj8YYWwB3pnCq45xY5WTPgcgZJ0cyyOAs9wnCl4XUJ7+fC
         IXxw==
X-Gm-Message-State: APuU4Z+b/kiBYreu+7nZA++zLbGtmK+mYephildO/0zJ0bpFkcSdGxUC
	qoYY58lriUtoWR7aadfr4Xkds3nqrw0urDsMfZ7kwlD/3CdRe3Q3iaOtVH9MODNK
X-Gm-Gg: AYBFou1PsW/gW+S4C66kMvtrxdmgI1qwEi1O1Nsb0xJFz6qAmKQMauZqwH+foj6b4jY
	QnvlCJrbA6VQAlpi33je4sKiKpubPqIjuCCmBOSxpbZfQc/pUiIFbbLLBGxOV7OjUMZ60QLoyJy
	Ofd5vDsKW0bk50tl3C4Mh+tn18CQl6LAi8iho6Uk1pKCMFMQ3KrXQksfqa7vjPbWoSBtiCR6YU6
	ppd8wwO6zhSxVtfZk3UD6EdfbJViHiSXrZY9b2jqM5m0rQe9xTnZgOiyfCnVYmXlxrWsaqIXmID
	5lQr6RxBbwPZDgzJgpKfnJLMaNm8z/kedFyNYn4TUP1BX4cZVhi5myHjJbIEnvb+3B3YAqzxNj6
	ISbAt/8mlAkcP6/ELiN2vEYX+/o9HWLv9P0m4gHnuT/X+PDJAdThfG5fObuua3oJlOtefLKSjiO
	m4BSlZM5bo6KGoQs6EjwuWaMdkq6qug0G/mjKIsX4qge10+qFgJWD2D8GqM7Hcg8/nsmncItjPC
	zcdVqq4oi5pCJf4vyzaqJhRpG3w9TCm8qDW3+YDXkXR9p+M7pVmy4qFXmSNiDev29huRFvuqN/U
	QIeCQR+D7Qq8oq8b0cGcUmqiuxj+4oD1qQAsp0sXNLk9hJD4eb5nwmc=
X-Received: by 2002:a17:906:4fcf:b0:c2e:2d8c:4585 with SMTP id a640c23a62f3a-c5049612785mr59440566b.36.1794266267998;
        Mon, 09 Nov 2026 15:17:47 -0800 (PST)
Received: from localhost.localdomain ([2a13:e746:396c:c600::8fa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a56f377sm29433366b.18.2026.11.09.15.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 15:17:47 -0800 (PST)
From: "Kordian Chmielewski (mlody1212)" <kudzo51@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Doug Berger <opendmb@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	bcm-kernel-feedback-list@broadcom.com
Subject: BCM4908 Ethernet and 2.5G WAN: upstreaming plan and two questions
Date: Tue, 10 Nov 2026 00:17:39 +0100
Message-ID: <20261109231739.2561930-1-kudzo51@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

I am porting OpenWrt to the TP-Link Archer AX6000 v1 and AX11000 v1:
a BCM4908 with two BCM43684 radios, a BCM54991E 2.5G PHY on the WAN
socket and a BCM53134 switch for LAN 5-8. The port runs on 6.18 with
OpenWrt main. The AX6000 v1 will be public around 16 November; the
AX11000 v1 runs the same code and follows later. The first patch went
to linux-wireless on 9 November (brcmfmac).

What works today: LAN 1-4 on the SF2 with the CPU port at 2.5G, the
WAN at 100M, 1G and 2.5G, LAN 5-8, both radios with brcmfmac, USB,
Bluetooth, the LEDs and the buttons.

I would like to send the Ethernet side upstream and would like to
check the plan with you first.

As fixes for net, with Fixes: tags:

- bcm4908_enet: the TX ring could stall silently under load (an
  off-by-one in the ring indices); a DMA mapping error left the ring
  inconsistent; RX buffers and pending TX frames were not freed on
  stop; RX frames longer than the buffer were passed up; the RX
  buffer address has to be written before the OWN bit.
- bcm_sf2: with the default egress flow control thresholds of the
  BCM4908 (32 pages) the switch drops frames under load; raised,
  WAN to LAN runs at line rate. Is this net or net-next material?

For net-next, with the device trees through the BCMBCA tree:

- pinctrl-bcm4908: the "mdio" function on GPIO 48/49, the external
  MDC/MDIO pins;
- mdio-bcm-unimac: native Clause 45. The MDIO_CFG bit that enables
  it I found by testing; I would be glad to have it confirmed;
- bcm_sf2: the crossbar routing of the SerDes (the CFE leaves the
  Runner's port on the SerDes as well), 2500BASE-X and SPEED_2500 on
  port 7, and the IMP port at 2.5G;
- the BCM54991E in bcm84881.c: it has no flash, so the host uploads
  its firmware; autonegotiation and the link state are the BCM84881
  driver's;
- the device trees of both boards.

Two questions about the WAN, where I would rather ask than guess:

1. The SoC SerDes (a control register at 0x800c03c4 and its own MDIO
   address) feeds the BCM54991E its 50 MHz reference clock and has to
   follow the copper speed: SGMII at 100M and 1G, 2500BASE-X at 2.5G.
   Today the PHY driver drives it, which I know is wrong. Where should
   it live: a phylink_pcs in bcm_sf2, or a driver of its own? The
   crossbar can also give the SerDes to the SoC's packet engine (the
   Runner), which this port drives out of tree, so something both
   could use would help.

2. The PHY does not answer MDIO until its enable GPIO is high and the
   SerDes clock runs. The binding allows "ethernet-phy-id3590.5090",
   "ethernet-phy-ieee802.3-c45" for a PHY that needs such a sequence
   before its IDs can be read, but fwnode_mdiobus_register_phy() calls
   get_phy_device() whenever -c45 is there, so it reads the IDs anyway
   and finds nothing. With the ID alone the device is created as
   Clause 22, and today the driver switches it to Clause 45 in probe.
   Would a change that creates the Clause 45 device from the ID in
   that case be acceptable, or should the GPIO and the clock come up
   before the bus is scanned, for example as reset-gpios and clocks
   of the MDIO bus?

Whether the BCM54991E firmware can go to linux-firmware, and the
Wi-Fi side, wait on answers from Broadcom, which I have asked
separately. The Ethernet code does not depend on them: the PHY driver
loads its firmware with request_firmware(), and the code taken from
Broadcom's GPL files keeps their GPL-2.0 notices.

Thank you,
Kordian Chmielewski (mlody1212)
