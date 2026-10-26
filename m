Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793027923;
	b=rpJzFWzHhDUaqjSvDV3vYAfGkATuy/j67EADKGQ1ocZ/0vPNhugDJ3OUGRxzVmdJlIzO
	 arMgTuJMzPYqV64edX4WazAo6L2QNW/9VwhB9ZsBYAlEZXMvu/zbX0SrvoR9qDUzAsWxi
	 GX8KFSDnYOxpEJRQmegDOm/hHGk/IjoNvK6/xv2H7/sbdAFISWR4CVpEYx0kgMxDDw+ya
	 m0GCz0nSUf22k7xGMSQ28D0jCWCesSY30gdHXaM9ijZByRPsaY47w5toJvCT8vs9SzC+y
	 m1lwzwmIAZse3M+txjNz4HE1TAfvtul6xoPt5UYI5Ot/IniPAx2QA8Ow0qYubsuHxZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793027923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=dfZOtjcUHpLFshNgDIJVWJmlcQM1airpMgQgGGlAlTI=;
	b=bQ8FSN86D3KB/D1mb1wlBko5IGYPXMUoliYKQk0Di9+lhi9d/IHPsgycpgn99jvdlezh
	 NcP7eWsQEkRpwf51p+UBIP4KYJmKHh/T5ls1cVp/cFvKKXhOwI6KVGRNxSLMmIcH70O2k
	 4KvYAtf7F8BBEgvxvvkMF5/xWxhQO9jWdz9HEcvlHku+kZE0l9hyORNuZ7DRUKLs0zapf
	 1aXGRLjI6xdIp65hM+Jl3DxvF75pN1a/NTU0JlItRJbk4Lvofh/jabTYZIQB+STjVWeJP
	 PA2PKGlDv45QreTh0wDpobVQckk2nQ4KJ6T8oFcjaBwCvI2Xy1rsM9xdXVLyuWYuNkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DI35J+bK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC26606A328
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 15:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FC26606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DI35J+bK
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5eafb65e204so882444e0c.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 08:18:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793027922; cv=none;
        d=google.com; s=arc-20260327;
        b=Nb/SH+FSNjWOdrv8UQTOIceKUmjr9As5vu/51oLIEvpKww+Ll4b1EW7/oCdBgGCdkh
         dW5ww4SbFC6yDOCNJBOi0+inqeCOd4ERIQeh56fBurpFnZfsM4HO3wVV5JA+MGDBWvI2
         ed+UHjXK0whtSFPkFV34CNXbudrbOsgzHNPTXY0+g0HV+sjz27NoIUZxdimlM7dZVSbK
         X9yC2gV6Qrx1/A8nWcxCBGQ8N2fEKyZ84fKv8of3nZhN0ezeoLM9vhdLZ5MQWw0UwlAK
         6xT3/8Qco1275y9u1hhDOxnASZkHq7AJXIS0J6LiwzgyYYinyZ9vIp+SPHo/J4/DI4/n
         LXUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=dfZOtjcUHpLFshNgDIJVWJmlcQM1airpMgQgGGlAlTI=;
        fh=3kMT+x83T9jXNzZJue1Y0Ed6IIhmBA4stBPQxuO5i1o=;
        b=cjwkuRw5FZAkkdkWDEX3A5Rb0QVzu/GKnLp/UJmlbTak+rbt2osAw7guJn6xZHRlBu
         td+31Fk3ZIZkFG91ZdRLLghqTJ/1H/d24Gqxb8mB7cypI9w7tzj6vRC+OiNzN+wPlm7A
         lwYTMbFubJYmVzNEfY7XDG/kRO6EhzLI9O3ZL4tWS2FEd3BltiveuBTqv8DQ53lIJ348
         a2dS+BsIexFgGDnDLO/a/2Gnhg1aNBSlTb99ojlAPBCiAwjV/34P1mrSbWPW2JKfINJL
         pNHGww10BoG/KzF3yhnbSgL9KGOkP/CO2Pvq7NIjCcCXR9d/49PneTMPyvusFJfJIRFh
         XzdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793027922; x=1793632722; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dfZOtjcUHpLFshNgDIJVWJmlcQM1airpMgQgGGlAlTI=;
        b=DI35J+bKXYaF95zxkNBT6Gy79b08LZG1hMrXxSdXg4whQn6lZsNyvzlbcN9HRInwyF
         BAAJMiUnpTzyokrQP56ye6v9C5N7F0aynBYZVBZfeTFxpD34ZDjhkQLYpaLIwURfRWk0
         0IWt93Qo6woxLV0e5//38eQaaD476ls8EARwIkbzKxNIm3ObGEk922ZeBGKPXNq29tso
         9T1ziMrQMUAHpXawElwKSoSol7PLoYR38pEEr1x6Jq3hON+uHLd02LAomtsJIP8bzKUa
         ixFoICWWkumiBs66tqnJqLQzRTg4ffvJ59H5ybq5EOu6jFE/erIpCrM/LRr3sPdILmcI
         RNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793027922; x=1793632722;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dfZOtjcUHpLFshNgDIJVWJmlcQM1airpMgQgGGlAlTI=;
        b=ZYMmoQGOViHVOsAR6+aqCNwuvown/M/NyIxdlAQfZEUPQlJm6HVXh2AkOt4xavdijA
         GljyZMVC0HuCfDCzEG/pZ9udlTngYqtiHxOwnUaa5jT4+0vhZoGwmmxlaKBHBz+QJqZN
         CfbAhzvyH8Y/PgSUOJ8a/JwkF430klUSS4tJp+aecJJw5bbk5D0S9cHokJgVzrdyYg6w
         fFCF/mbEDX3JuwmPOCo6ZBXuv/yRK9TKj5/PoU7n6umhlzgCF+b7uOIqy6TIIYDE9ipH
         e2D098z9aGBvUHZkDRd5A+1s4FE+vKR/RPm53vge3NcBfqV1PmqhkMTfARLrKp6ls7Ah
         5jaA==
X-Gm-Message-State: AFq9FYJR6ayrMf53bcDZyKt/EM/0gmBGmdGaqqzxTJfQQR7D/Czi8vrJ
	x5LhElLm8bHj/FfkGnerggl6cD5zzOgVu14hRhy5k7W3sPnfiXxIuI6F+8hsK0UfeuT9cOc/KQX
	iFDrrRtMKO5zIsj8sWxoJQapmDYIfq/M=
X-Gm-Gg: AYBFou0kS1F4Pu9/rUQhL1ELgXpscUPW+LUfP6LSJwoHwRJwc8Zigt6R3OwbZnV+otj
	x7NQbzA8PwMsSgv9peaRMeBKOSAdnkAABrZBIcwnT1kStkdE5+Vd9K63nB/ZaJAB3YdbJwd/zqK
	EzBqDDPYtGuiKaDlmwDxl4h2xA575706OfY9PpM9joQBLJCXHza2ryBD+7cmnl/AC5pDVcq6BOO
	J9/qzH7AwybFi7RpCz+/eEr8eVKg2pxhTOCh+C99EsERdBqopRnaNsKu40OSIwez03BIdJt6Pu9
	ZchPMLEwDTbuc5lhnCGTvXs69dZr4qMG6Z4aS/VxuxcuGKmiOF/R1NQVmHLD1mfC0yhaPfb0I6w
	jicKqsBr7ntqdDkTYHEPJctvOHmD+jf7LvCBszP3M7RPpDKzhtV9rNlcq0g==
X-Received: by 2002:a05:6122:4d05:b0:5ea:b9b5:8c43 with SMTP id
 71dfb90a1353d-5ec2328fe56mr2597569e0c.18.1793027922148; Mon, 26 Oct 2026
 08:18:42 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Keith Harvey <kthhrv@gmail.com>
Date: Mon, 26 Oct 2026 15:18:30 +0000
X-Gm-Features: AclHuK_MdSCAfJymlxw38Rye9D8cf2mUoYwJCr5KglhW_SHWRMA3fcecMf8A7g0
Message-ID: <CAJiJ=8u40QRbrpvf5i+dHZBqMWVccq7e6dipcHxjhOWTrXWvNw@mail.gmail.com>
Subject: net: phy: motorcomm: YT8531 clock output (0xA012) lost after PHY
 reset, TX dead until reboot
To: Frank.Sae@motor-comm.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	linux@armlinux.org.uk
Content-Type: text/plain; charset="UTF-8"

(Resending as plain text: netdev rejected my first copy for an HTML part.
Apologies to those who received it twice.)

Hi,

On a board with a YT8531 PHY and a reset-gpios line, closing and re-opening the
interface leaves the PHY's clock output at its reset default instead
of the value
from "motorcomm,clk-out-frequency-hz". On this board, transmit then
stops working
until a reboot.

Hardware/software
-----------------
- Xunlong Orange Pi R1 Plus LTS (RK3328, rk_gmac-dwmac, YT8531 at stmmac-0:00)
- OpenWrt 25.12.5, kernel 6.12.94
- PHY node has: reset-gpios, motorcomm,clk-out-frequency-hz = <125000000>,
motorcomm,auto-sleep-disabled, motorcomm,keep-pll-enabled,
motorcomm,rx-clk-drv-microamp, motorcomm,rx-data-drv-microamp

Reproducer
----------
ip link set eth0 down; sleep 3; ip link set eth0 up

Ext reg 0xA012 (YTPHY_SYNCE_CFG_REG), read via 0x1e/0x1f:
before: 0x00d0 (SyncE on, 125M select, source PLL_125M)
after: 0x00c8 (SyncE on, 25M, source REF_25M)

After the down/up the link comes back at 1Gbps/Full and RX keeps working, but
nothing transmitted gets an answer: DHCP discovers are seen leaving the
interface in tcpdump, but no offer ever comes back. The driver reports no TX
errors and the TX descriptor ring is empty. Writing 0x00d0 back to 0xA012 by
hand restores TX within seconds, without a reboot. A reboot also fixes it.

The same state also happened without a manual trigger: after about 5 days of
uptime the stmmac TX watchdog fired ("NETDEV WATCHDOG: CPU: 2: transmit queue 0
timed out 5420 ms", "Reset adapter"). The interface stayed dead after the
adapter reset, and 0xA012 read 0x00c8 in that state as well.

Cause (from the source)
-----------------------
In drivers/net/phy/motorcomm.c (v6.12, and unchanged in mainline as of
fc697291ad0a) the clock output from motorcomm,clk-out-frequency-hz is written to
YTPHY_SYNCE_CFG_REG only in yt8531_probe(). phy_detach() asserts the reset
(phy_device_reset(phydev, 1)) and phy_init_hw() deasserts it again on the next
attach, then calls yt8531_config_init(). config_init re-applies the
RGMII delays,
auto-sleep, keep-pll and drive strength, but not the clock output, so 0xA012
keeps its reset value until the next probe.

On this board the GMAC appears to take its clock from the PHY's clock output,
which would explain RX working while TX does not. That part is my reading of the
setup, not something I have confirmed on the schematic.

Workaround tested
-----------------
A small out-of-tree module that registers a PHY fixup for 0x4f51e91b and sets
0xA012 the same way as the YTPHY_DTS_OUTPUT_CLK_125M case in yt8531_probe().
Fixups run in phy_init_hw() after the reset is deasserted. With it loaded, the
same down/up logs "0xa012 0x00c8 -> 0x00d0", and the WAN gets its DHCP
lease back
in about 4 seconds.

The fix in the driver is probably to apply the clock output setting from
yt8531_config_init() as well as (or instead of) yt8531_probe(). I am happy to
test a patch on this board.

Thanks,
Keith Harvey
