Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793999327;
	b=cW+FEmgX2OegzsZMmyySsWhhdDfXqq3tRzvLxZ0yQhwkd5iQobMedGo2G57bbsTUvVbY
	 QPHeMRomuATJpPgxCHkV/U8jjBBnONlKkqiD+xISEYChjFGB5/sTZJN6a8e3DAPbwVbRi
	 VzaowDPpVV0yhkvzeWz425Egl0YX43whi05iqRIAMhqKalvyS4m3QuuSeDGhIDb7cf0bp
	 4xhR20s/e4PXidtaj9PyMXFEGHpQuH+/ll/Ov0lpHpepdaRHv9WNLk9mrPYMWZsHaKk7T
	 YmX0a4h6q4e5MvXeiaeg/e0EjMUC3LLJN4FSkMuy4TbB9sIESdgGX95bt5x2hv4EUIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999327;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=qGG8oGrrJLldZvlh0Urj7gU0vRB0ez6rdNJ54mOMWZI=;
	b=pWusGIsh2EQR6oYfxEL/36EYZBJA03JHZwtXmRkDHC5BuKpKkcUCMcyTw52W75Vm9IwT
	 7EANWnAy+b90sEh7xwB6i/JySQ2q7gvVNpdcN7XsbkiyOJo9IIE9GOyCQQQM/CG0aE/v1
	 Ftkp7EeTGLourKgrNQTZYtWOJ/ms538bTIxZJBoYHR4711a8aV/r33xRW7fKyprW2hyI6
	 3ri2RiGjoW+nXEuFbGyjzf+xcGE+2lXVhC2mUKECCMX0m3iO+DDle71JnKOWEcn4vszjU
	 jW+ABwzmJcwn7tf8UlNj5pcEV2d8Wvkt5RRGH1Oul31EwkhRPhZR8jGl7e06KWKH73A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eu4Vzyz3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E03606A32D
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 21:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47E03606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eu4Vzyz3
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c40e30c26a4so12940366b.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 13:08:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793999326; cv=none;
        d=google.com; s=arc-20260327;
        b=IUiEIP35PIXiTIrVt6tWhtLAvwbrYlwFlTTWpMgh+ylVaklqI5fNmcE0fK/bytetFV
         x3zr+8sUWS40qf6xKIY2p3IAQmyFTCEK0NBsFJhFDZO0hKfntg1jJcl2Ya4LsRV1r/kW
         qR3lYQ9p7cHB7cyLqcvS0XFVZIDheD1VQhzWmIbqvyLA+SSjV+6Tm6TTcKz4yRGv9lxk
         WFVdlZ0iNbn2qGTddBQbWyKhGtvekBqV6sgYhqzk0RNrV5XUl67PhhFC+PcV58s3jB4B
         8O0RXHkaJiC4V2pSZg3ml6O7UBG9Hm9MnMyswc9snkQhpklHUVpKuVUaL9VFtHQqoCky
         WoMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=qGG8oGrrJLldZvlh0Urj7gU0vRB0ez6rdNJ54mOMWZI=;
        fh=v+YQL9gZVzzkqyf6CsogEBik4T+B2O/y3D8DRVOtwFE=;
        b=Wh0Yl6GUhP0IADpLrhiVUvNo1csJ9clEEzD/WXqZf7e+Lb94PxFpy3egsG9d7BVbMQ
         Ijk1CheGl1HEnxgjLBi7KqkRydEMkF5JjAMx6Od54ALvp3UGgOgmJc2+P7M535dcv7eo
         0/dy009Hbhc1PGdeHfDim002Ff5gLk91SAh4epGFWQ2y99d1jmMAiDdbNnNn7RUWokOv
         R8ZPokQ71SBonT5fjSL4wgsvrgZEodX6sS7ZBHEVmkRtMxAqSFrVAvd4UdELzeMNubEJ
         uXM0PaVWECM3/RePCWdXBZ8VelOpvled9tsj3vaP4z9ZPV+pA5ONE8K2haZ0I4E2pMVO
         k4+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793999326; x=1794604126; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qGG8oGrrJLldZvlh0Urj7gU0vRB0ez6rdNJ54mOMWZI=;
        b=eu4Vzyz3FOMGxJC7sHkkwx+Bm3vSYEDbbHh+w6967R7IqCOqHclmRZnTh/i9n+MwRK
         uKabhaJRmS6+cDs9STR0qvExeu0MNhAS9E2JtLltKwlEy+vUeGI3r/KDlTc4oHi/2ist
         H9z/caSwPEqYQFeqfD3k/i0NT+hVrOkwTKtxvUcixGq4xHz2B5XbskS9jcJddj0sog8e
         Pt2PO8yHn/ZZ6mll4cApANSHoK3JFEniwbOAffk4d+KcyDhvR0ejHRJtk1TJFkYDqHw3
         4eSbTVaD4ztHGzPERPyLCfs6C3hvtyfCjiPUs64Y0E1fnUiWm0QXAHWsOxVf+WdBhXja
         yekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793999326; x=1794604126;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qGG8oGrrJLldZvlh0Urj7gU0vRB0ez6rdNJ54mOMWZI=;
        b=teG2d+2gj1GbU2joHdjIkJYW7ZQvT65fepNq+VVcqS6h+YruNpUGMM1MJ+hUqcPsCQ
         019uHpqUmEqecTWRggk58VeR1lvExCaMyQopUiEwnccVA6vqf3ARfXAW2Ki1kRzYFE9e
         cfCcF4yqv5ZH/QgF/MPAxJezQ7lrvacrzkBX77cGSHfRPPQDYnGuc7yIvo9q8snmjHti
         DbGcYh2pEhVFiqiH6P4PP2MvGY49bq/QVf5rQ5eAmIQEcVkDHawgQ9ZolhwWVadknTne
         WxsZEvxPyckhnK/SwPvv1K0zb057Fgl3Aerfhvda9PcRM442S0sf0L2TJEUK40MIWRx4
         1kcw==
X-Forwarded-Encrypted: i=1; AKwUvByO2YRtdaV6LsKgaBO+VT2W89jrO27+MYrw68t6NNS0EZukTU3b7PsHe8jwvY289sYsNvZltEo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Fh0mCj0qO9RI9553atiauJlAjlLYiyXJdNGZhPols7UoSvCyp
	4AGUasS3z92QHTQtjyB5FA0t/NelwbbNSnKzm0GL217RfBoORZiu57YbY7+cNIAIBrhSAU7YNnb
	nZ7bxJuMnb5FIGxs/2aG3X+ivd7xX9mo=
X-Gm-Gg: AYBFou3Lx+KoRqtnYa67WEHKmlZduZvGUA8bCafiIC88a0XWH9Qmfrtvv0+woocjnAn
	ko2hczq6WfEF4WD4rxduupgpdnL4/3tbF7Cb8GCOhmwVeGJ2HIpTMMW62/8kwtGljdBmnR7pjii
	gc0n+C+szGNw89bM1vH1ZqHROqYytGSvaBdOMdLHRnvjA0rkRIiKZ5pANeXKRV1ybaNFFYRck7x
	WQMZ/TUKLxnfkTYK7xWA7HnR6IcvvMMlPS0A0Ja8x6ndlfOtNkc3fN79FEC1FCFsIXHZGMa9bJH
	6PbHT7KkKtNqoTenK6OkxiZzFDooDj1Jcixo9VC62jAe90TYhZFwHKMFFzNxQeObRL7nQDQrsGB
	P1PFFEzEARpRhR/oxKzn1GTyhRgObYQk74JBln14MjwQLLANFTQ==
X-Received: by 2002:a17:907:5ce:b0:c42:bc58:f21 with SMTP id
 a640c23a62f3a-c4d524de677mr9637766b.15.1793999325372; Fri, 06 Nov 2026
 13:08:45 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Sergey Kacheev <s.kacheev@gmail.com>
Date: Sat, 7 Nov 2026 00:08:34 +0300
X-Gm-Features: AclHuK8gNSlyHOq3BH0lfB5PLWaS-qptjYfSCBSSXzK_ROJ0rOwb8P1w1O7g2js
Message-ID: <CAJVhQqX3Yq=TO5b+KW2R3nipk0-zx-wKL6jSP2SNSRZ++Ro2EA@mail.gmail.com>
Subject: [REPORT] Cubie A7A: RGMII CRC errors resolved by changing drive level
 from 1 to 2
To: jbrunet@baylibre.com, netdev@vger.kernel.org
Cc: andre.przywara@arm.com, andrew@lunn.ch, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I investigated Gigabit Ethernet CRC errors on a Radxa Cubie A7A
(Allwinner A733, Maxio MAE0621A PHY).

On this board, changing the RGMII pin drive setting from hardware
Level 1 to Level 2 eliminated CRC errors in repeated tests.

Environment:
- Kernel: 6.6.98-5-aw2511-srv, based on the vendor BSP
- MAC driver: vendor dwmac-sunxi / stmmac
- PHY ID: 0x7b744412
- Local backport of the proposed Maxio PHY driver, with the vendor
  EEE-disable workaround
- Link: 1000 Mbps, full duplex, autonegotiation enabled, EEE disabled

This is a vendor-kernel result; I have not reproduced it on mainline.

The relevant pin group covers PH0-PH15. The DT change was:

    allwinner,drive =3D <1>;
    ->
    allwinner,drive =3D <2>;

The BSP pinctrl driver labels these settings as 20 mA and 30 mA.
However, I am deliberately reporting hardware drive levels rather
than treating those labels as verified electrical current ratings.

The A733 User Manual V1.00 documents four levels for PH_DRV0/PH_DRV1
(sections 18.14.6.99 and 18.14.6.100). Section 18.14.3.4 describes
Level 1 and Level 2 as enabling two and three parallel output
branches, respectively, reducing the nominal output resistance
from r0/2 to r0/3.

With TX delay =3D 8 and RX delay =3D 10 held constant, repeated tests
showed:

- Level 1: CRC errors with pseudorandom Ethernet payloads and
  ordinary TCP transfers.
- Level 2: no CRC errors in the same tests.
- Returning to Level 1: CRC errors returned.

For example, a 300,000-frame pseudorandom test produced 141 CRC
errors at Level 1, zero at Level 2, and 61 after returning to
Level 1.

Payload choice mattered: fixed 00/ff/aa/55 patterns did not expose
the problem in earlier tests, while pseudorandom payloads did.

Validation at Level 2 included:
- 4 GiB of bidirectional TCP transfers before reboot and another
  4 GiB after reboot.
- 600,000 raw frames per validation run, covering frame lengths
  of 64, 128, 256, 512, 1024 and 1514 bytes.
- No CRC counter increments on either the Cubie MAC or the
  connected switch during these runs.
- TCP throughput around 111-112 MB/s.

A separate TX-delay 8 -> 9 -> 8 comparison at Level 2 was also
CRC-free. The small throughput difference was not sufficient to
establish a meaningful advantage for either value.

The persistent configuration currently uses drive Level 2,
TX delay =3D 8 and RX delay =3D 10.

These results are from one board. I have no oscilloscope
measurements, so they establish the observed effect of the drive
setting, not the precise electrical cause or a board-wide fix.

Would Level 2 be an appropriate board-specific RGMII pinctrl
default for the Cubie A7A? Also, is there an authoritative mapping
between the A733 drive levels and their electrical characteristics?
The BSP's 10/20/30/40 mA labels do not appear to match the GPIO
current figures in the datasheet.

References:

A733 User Manual V1.00:
https://gitlab.com/tina5.0_aiot/product/docs/-/blob/product-aiot-stable/A73=
3/Hardware=E7=A1=AC=E4=BB=B6=E7=B1=BB=E6=96=87=E6=A1=A3/=E8=8A=AF=E7=89=87=
=E6=89=8B=E5=86=8C/A733_User%20Manual_V1.00.pdf

A733 Datasheet V1.01:
https://gitlab.com/tina5.0_aiot/product/docs/-/blob/product-aiot-stable/A73=
3/Hardware=E7=A1=AC=E4=BB=B6=E7=B1=BB=E6=96=87=E6=A1=A3/=E8=8A=AF=E7=89=87=
=E6=89=8B=E5=86=8C/A733_Datasheet_V1.01.pdf

BSP pinctrl driver:
https://github.com/radxa/allwinner-bsp/blob/f9a496c24bf6b7cc31c4b5c716ece58=
b2c287f01/drivers/pinctrl/pinctrl-sunxi.c

Best regards,
Sergey Kacheev
