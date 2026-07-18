Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10227270540
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 05:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784353267; cv=pass; b=HS2ELF9MAIU8dU7W6lG+Ya+KMS8EaWrkPnSHOEpKikLm+FWeEPmLiC+Y/DRP6Xzsmrg4FGHL3pRMnRwNGqQoW90jg4G+vCR/UsaBwA0zTteMDbLsu/7T8aOEYiBF3k/4iN+XBrgZ/BoCPl1a9B+LFuMbq8fY0lSoMyB0z0NRnAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784353267; c=relaxed/simple;
	bh=EQV6VWJ39HUkOkuRWS+8e1CFAVUOF7uR4dvI3r580Yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTzyFCCG+PwQ43wzOnHFX3Y8ZAubRrBDeIP6tBMUp5N+NVgd6zlDwwQ9uj6wM+625UnufRaswQAhOPfVg8zOIa8lFl9qXM046BCy/8cnkXbBgOeROCA5wIEQXDHSeZdl/oKrqtSHCGYb6Q7u4REeNORizRBgdwOkd1kkYsbhbCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7jTNZbl; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7jTNZbl"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15d111ca99so864804266b.0
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 22:41:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784353264; cv=none;
        d=google.com; s=arc-20260327;
        b=GY0f9upeUJsO8vL7IntDrXa5/4oZAwUfaJ8Rg3ws5KSCOU973+4/shVgMTh9Fj9QXf
         EYfy+xpvtvwxrdtdCMEyOIRaAk4Ac4r2TH1bQHIkfIxw52fN2v6elCvE7Fn8ArRGOI8Z
         uiLTpgPc+sUk4nGHQKQ9CeOjsSzvZZz6ANbkbeFTaJs0FwQ41Vpizw39JdEbO4iISWtK
         i4ubOCCvJpfiP0JxAy36NBWreuL8gHzuTpViyGWhBEfghsEWePWuYG9dRoXKj6xN5rdU
         YD1GH1HfWKW5jaZsKNNf4jSKwDt39IWr8YyP2G4wsleWrGeJkC2w6Ei8HqOLcIBu9VUc
         d4RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kL4QKdSr4ciQq3EjMVTMCnT1EGIt1FhbRKjS/tovH0I=;
        fh=X4ScCsOpv+gTwjs2X8Z+I/jZDH+FRms3+DsGgfTe/d0=;
        b=XcS0sYFv/BK10jmSH1+0ktcd/T1VGNVdX3nz1/rzMTwMEesnnueGES1DNOy16L45wH
         HDbyZNjz3l9t2L6iB1utxjxHCBGvEhVaHfBAChJbkIcGJIrHAIRmUuIU27Tz+D9YwG/d
         4s6AdJmVcTkVBk8pNQSFBo7sWQBAIUhpCvRaIsWCDE7IPR5xIFdV2cLpXx1/4/f58P7U
         koCLZXEYnFZ90ejLS48M9SJIDpK0kVX3YfCkBXqAHc5HsX4bds4K5lD5NGFfWFX+Xfv/
         9wtsYVi9ovAw1ZcL9/9VihtP3+BMCml1cxBdldrnKMvPxCXrHIL6gUvKL8JbdEFLpwuF
         rW4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784353264; x=1784958064; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kL4QKdSr4ciQq3EjMVTMCnT1EGIt1FhbRKjS/tovH0I=;
        b=j7jTNZblwlvC8fq8yX1Y/Vo5fr7OOQd2+dC/6T4k+RvLe+RxXHInGyMd8D0ghynjzS
         KNK00M9W6ufut3djo1O4Op3U8Bh4SBHZt2HfHtK602H1SzHqnR8HtH+3inMi8BP9qbPl
         pheDlh/XYbCHFcwCqBiYvy7Mf0jb5I/3m210xX/Zo8mxsq6lJFY0QuopeELrxkw2a85a
         Mr3HaLZRlPQXuuD1kEXHp7aQX45jCfPmnocDITTg2AVjBn8i/zg7sb2mdBSyp0GThrws
         vu09FRPgkkL6ICr5NClAReAjU+056v08b3IqZYld1uRdNi4ekE8duYOqiwkyceb7hoSD
         XIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784353264; x=1784958064;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kL4QKdSr4ciQq3EjMVTMCnT1EGIt1FhbRKjS/tovH0I=;
        b=TSbXQheeudYzfVe4h3ZHBF7R6MgI0kpD+Iz7SZOjcqX6eg2XHKzrDZSy3ulvCz7kHR
         JTlenyDPQCW+TrYYVEnfO9pKC+PzJeUacxVvFmqJDViTEq8Zquc0Jw3nfpKYwjrMf2S2
         jo+xw4EpSwINgHH3kjOJ/eRqwwk+kWvhh/6xhQ9oxL8eSR+figec/rznNyyI7/IFQYcy
         BHfRyDNhBpRH4W3YNCM+s+qCzaeG5Im9e8nBlDHHAXzMNX7mPDJbBqGA7Ttd3C5q0B1F
         kJgpEdz/Fs9wX4gvd/dZujpA9ZO+takEU1GY9XePCUNJyRi6B91cCcqC9b5+cQ1oobo2
         DIvA==
X-Forwarded-Encrypted: i=1; AHgh+RqHwTcOme1VBkn2KNyFSJwiAT12KvMYYeEwaToLrSToErzktMmB4mYiNbMuXT3PbXm5cebgCiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCkWQ/vsid+Ic/nBRhyW6O73/g4bbrDP6UuYoAYZ4HBKM0A1Cl
	TOF/5OII+xtigt2H1iIsMZGuDapBP813JXb4iOh+G+0mT/3kTAyxNF2mXb5wKc4CXGLINl7S5f6
	0dqGKOOr0TRApSo+I9rlOOMBrdedE3V0=
X-Gm-Gg: AfdE7cmh3XBeSj8dJdcxRDtahMu1ySZdhF58m6SWsas/g7SfZVpIBJOJOKBXJbnQMOE
	N5kMm35Vr+XYN4bfgaTdhgKJfLm2Zhhp2iDrYYNW9iRlr6I217u1kOVOh4lovCzVrET6znzbQNm
	tofg6BdYFgijTMUcDgKweWZ1D8+DVHoiSWEkq5xgXav41V7KYFN/VtyvqtTDRqLPI+jBj3pnYRa
	lD7DzuhR+eVC0R76T9rpln+LMKIMp0zIID/h84hjh4mgVy2Bs8lYnnkIz5t2HTFOEjgYUG//jqO
	IFyo46UnIZI8YY71DOE=
X-Received: by 2002:a17:907:3ea0:b0:c15:f647:205b with SMTP id
 a640c23a62f3a-c16b47d83e8mr248346566b.46.1784353264000; Fri, 17 Jul 2026
 22:41:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711-rtl8367s-sgmii-v6-0-88f7944ddca7@c127.dev>
 <20260711-rtl8367s-sgmii-v6-1-88f7944ddca7@c127.dev> <20260717125155.18915-1-kuncy7@gmail.com>
 <e252cb3c-bfb2-4d62-aec7-e04b9aafe223@yahoo.com> <db8f9fb11e7e250eab9c98eafab1ba3e@c127.dev>
In-Reply-To: <db8f9fb11e7e250eab9c98eafab1ba3e@c127.dev>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 18 Jul 2026 02:40:51 -0300
X-Gm-Features: AUfX_mz_YWPxtVgpqSZd203uZYGj1rC_HzYBqUIL3eBl2AJWNJUh3ULQX_xzjfk
Message-ID: <CAJq09z6bqVdtmuf0LVe_WjVYM9GmjaNiqjnOALLut4jCoZBLRQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/2] net: dsa: realtek: rtl8365mb: add SGMII
 support for RTL8367S
To: Johan Alvarado <contact@c127.dev>
Cc: Mieczyslaw Nalewaj <namiltd@yahoo.com>, linusw@kernel.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk, 
	maxime.chevallier@bootlin.com, kuncy7@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If the cold-soak issue is indeed device-related, it might be that the
driver is loading too early in the boot process. Stanislaw reported
that reloading the module makes everything work as expected.

I don't see why the second reset would behave better than the first
one. In fact, if the reset pin is connected and configured, the driver
will reset the ASIC twice during the probe. Stanislaw, do you have a
reset pin or a reset controller configured? That might be related.

The driver currently performs a full software ASIC reset via bit(0),
but there are other reset bits available that you could try:

##### **Family B, C, D:**

```
15  14  13  12  11  10   9   8   7   6   5   4   3   2   1   0
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
|                       RESERVED    |GPH|NIC|805|SDS|CFG|SW |CHP|
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
```
 * **GPH (6:6)**: `GPHY_RESET`. Gigphy (Copper PHYs) Reset.
 * **NIC (5:5)**: `NIC_RST`. Network Interface Controller Reset.
 * **805 (4:4)**: `DW8051_RST`. Internal DW8051 MCU Reset.
 * **SDS (3:3)**: `SDS_RST`. SerDes Reset.
 * **CFG (2:2)**: `CONFIG_RST`. Configuration register soft reset.
 * **SW (1:1)**: `SW_RST`. Software Reset (`0x0002`). Clears soft state.
 * **CHP (0:0)**: `CHIP_RST`. Chip (ASIC) full reset (`0x0001`).

I would expect the CHIP_RST (bit 0) to clear everything, but you never
know... Also, keeping DW8051_RST asserted indefinitely might be
overkill.

This series adds a required feature for several devices. Even if it
introduces an edge-case issue for a few of them, lacking this feature
entirely is worse. If a patch is proposed to fix the cold-soak boot
issue, we can review it here as usual.

I would feel more comfortable if I could test this code myself, but my
device only uses RGMII. Anyway, everything looks good. Thanks, Johan.

Reviewed-by:  Luiz Angelo Daros de Luca <luizluca@gmail.com>
