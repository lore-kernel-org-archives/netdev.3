Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E328498934
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 21:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788903383; cv=pass; b=s10+LPeVdNGmyeN+Dz4SIvNA51pkYapQ6I+WhMNbJBgkeGlUIfR5Z5AkGxCc2JzUtJJYzRM61NnoY14J5RjytsFCACUPk4cf5edN90eWxkJVp5QjKJ2YdeFTkMYA0mvA8tJ0yUMnwzefueAgZSr4pZDDxAkQxUvlmVkZt+wGgEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788903383; c=relaxed/simple;
	bh=qjKcOPAlp+8eJmChwXBbe8T1KsBa8X+4IN5bxjb+zFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y2iaT0YdxW+o4hfADvHCZheMaKRqXrLMNXqF60LMDupOcI2LMaYgSJJU68MYVufNmr9KfXUSkgs505cvCUhf8Z9yKjq6dDwUT15zxU9ulw4+N4wigSTQuwxjuwDHBrHBV9O/+bajkXv7TZKR7chMp1+cBISc7vEzCDkxh/s8mnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+KOgglI; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+KOgglI"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c1677c91969so533687166b.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 14:36:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788903377; cv=none;
        d=google.com; s=arc-20260327;
        b=kNej8PJEzwdtZ4UR62Eu8xjC9njv/8okwHQwFOaxJ0DUvOU+gdcXMVJDgirHfwQ3rM
         wiOMrhzuCeVHsc5/srrdT7p4ymZTAAi9uvsKTlHpQ8+16wqCxDSBHMVngjQjVLKJ2c1y
         X+7Gi2y8I8a96O0BGa4sCJta7tVF+hC8XrgmgWooX3angEGG47fyeZjAloleke1CmQVW
         CgxEVdmWxr5N2QI0DxgMD2yklWrD886FmVRF/4J01JaBbv8c5aULVJ3U7lBglm+uIRZE
         xqzMYSkhFj3CulHe7LryVWvIyAZr4IGpzPkl/HiJkLjlkDTt5ZHJAKDbNcbh8bFJSvIt
         /3Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WG1VPckZ7Ce+e/KvSNnfhiB/dB7b4M7rtu6QCvD8h8c=;
        fh=L/ewCj9jEwGeM3QlN7KKaKXk6K2wOnVa49Ohg2ymJtc=;
        b=FhL4G4VyTqDuhUZKneuTKYbEdqCfy24TWyoQtI0t+/i45pnXJld9dPj9x5bvaDez1y
         CAXPXk7AmVeYlOli77jlAV5aHofPYffuRuYOVDWGmfjqkyozMjKHDifOV+txPpp3YK1J
         v0O0pmqB48VC1RLK5iXvuoTN5aHL+2Qf+I6Rq1BvrqVjjAFSSXbpAnjY/2YZ1Iqg/0i8
         w+QJM+IHUyiVs6MAfKOpVT19nJIsNIIQ3QkUCO0yRX548ZLj8wsZ7n8RwRLzztGH1q7I
         PxFowaCTlto55B5VwKvhkRoP/DZPa2l+s0Oc6t9YjdULmqKFKn1AXKsArKwIcHOTO6f4
         EiMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788903377; x=1789508177; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WG1VPckZ7Ce+e/KvSNnfhiB/dB7b4M7rtu6QCvD8h8c=;
        b=N+KOgglIsp4dXSVBji40pIGhK7nTvXbC/sdg9tES56NPBA1vl/bT/lDlUViAHxAHPx
         EI8uBSEdNPR+a7Y2j7VDn9xw/4bim396ATOi/j8YujZ7OD63Cd2QkrinshLreebOPfTy
         HC/jjRwooAPKADrO78lyZzrig9UKVUc2hyuaKRKUrj+17zutFbh7WrF8rK94LSP4gfUL
         8C518x8rVFkZJLgGqgSU0X6ToV8j1S24UB1lhce1lOBxc4W53Z0CQyI3ceXSHX9qv21Q
         p2GOBJKOxcNGmbzEM1sdjyhq9dTqGt/ABJnMzopTdmFBEblgvApQJ2Lw1TH/oj0ccSj7
         wZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788903377; x=1789508177;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WG1VPckZ7Ce+e/KvSNnfhiB/dB7b4M7rtu6QCvD8h8c=;
        b=hkPCdNaOZK00WkzD/IB0IE31wNCbonS8WgVL1+vBe0JVTXKfLkRCZiEBvWUjlZd39T
         C23TzxGmgldWvtJ8XL+vsqlhkbxrTe72Zgmltq3lxIRmShInxpIOd9mi84IEi5sP+KVG
         p4dVNt8slBUB6ilJ26nzlzfN1vnuerG4ZoK4EccJGU6KXw+epJMUTD+GSuDxgnkZ0Ku4
         Axk6PEuy1tOq3TWNw89sAiw1hdpWtrMDdoQSSGIPc6eRRuP7D/L7WUIGHDAjMWmnHrHP
         3KdxxUQF+pZLhPLfGg/NYUTmHPHqDsp7rN337xl6LknHObqsq8bOBiZQNEMggVKz2pRf
         RsbA==
X-Forwarded-Encrypted: i=1; AKwUvBzhxNDxHeFoAqWRprOCMDBxs2YgnMdfGcaN1M2AW7BVBjAen1t/M2ik0jHMpnOGA/ezk5NZfQw=@vger.kernel.org
X-Gm-Message-State: AFuF++lNcbqeWDSTfekibI7VA3HrW8y1MHPJdWq+vqfgmvu+ik7BV2pm
	yTOz+GJbBcv3Ggho26Ynd4AunK9WHO6WMrrmtaHJrWrxCa72A/O/UXdF09z2kAqKUuex0RSaIh3
	BdOQFhQgqV1M+xvgGbDlpVdgVHe03c3Y=
X-Gm-Gg: AYBFou0odD7na0j68W3P0IJh9qIINEWo2WzV8gD0e81TMNfiNv9W7CZB/93r6y39r2z
	xKC0e8ZXHR6Gfb/Xy9TjNlWZpsriRpo3zM1uIiVuQ3K9GOFOGsiGfIW5AAsRRuMd+xpoW0ccpFm
	Kegq9NDhpIe8LnvYdjufuuhaxaOGzIDzrrYgWUA9E+ZL40Q4QpBKTZoYRbHWw9L4GMn7zwXHMr3
	ii5wzB0c/+AgwMklnZ5tx1KOIxHVcvGuCTh4v5W2fWfW/c+qBPvi+tKpVKb543YlsYhStobookn
	M69Okp6B/0Ss0SwiIOFtLqUvXJ6GO8h1sAlrF+ph9EIk/g==
X-Received: by 2002:a17:907:e1c9:20b0:c26:2b63:a746 with SMTP id
 a640c23a62f3a-c262b63cb83mr575305766b.49.1788903376801; Tue, 08 Sep 2026
 14:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908174403.420507-1-kuncy7@gmail.com>
In-Reply-To: <20260908174403.420507-1-kuncy7@gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 8 Sep 2026 18:36:04 -0300
X-Gm-Features: AcwNN1UWf30J8IomIqOvbTRO5fh6YZcxqzHw5584rMEkSkibF6iw45t74e_SvV4
Message-ID: <CAJq09z4qBz+poVQR3tEQzB-_4se5ka76Xq1mwEM0RvEnTuGLNw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dsa: realtek: rtl8365mb: wait out the full
 chip reset time
To: Stanislaw Pal <kuncy7@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>
Content-Type: text/plain; charset="UTF-8"

Hi Stanislaw,

Thanks for your patch.

> The reset bit clears well before the RTL8365MB/RTL8367S has finished its
> internal bring-up, so configuring it right away makes register writes to
> blocks that are not up yet get lost. The switch is then left half
> configured: the CPU port link comes up and the switch still transmits
> towards the CPU, but nothing the CPU sends is ever forwarded - no MIB TX
> counter moves on any user port, while the MAC reports every frame as
> transmitted without errors.
>
> The driver already documents the 1 s reset time the chip needs and polls
> with a 1 s timeout, but stops waiting as soon as the bit clears. Sleep
> out the remainder of that second instead, measured from the reset write,
> so the total wait stays at 1 s regardless of how long the poll took.
>
> Seen on a TP-Link Archer AX55 v1 (IPQ5018 + RTL8367S, 2.5G HSGMII trunk)
> on roughly three out of four boots.

We discussed a similar issue previously:
https://lore.kernel.org/all/20260721115306.15144-1-kuncy7@gmail.com/

In that thread, you mentioned it might have been caused by a bad power
supply. Are there any updates or new findings regarding that?

>  Unbinding and rebinding the driver
> always fixed it at runtime. With this patch: 6 out of 6 clean boots.

This part is still puzzling. Why does an unbind/rebind cycle work
every time if a cold boot fails without the extra delay? After the
reset write, both execution paths should behave identically. Perhaps
the interface state during an unbind/rebind cycle slows down the
probe/setup path enough to give the chip the time it needs?

> Fixes: 4af2950c50c8 ("net: dsa: realtek-smi: add rtl8365mb subdriver for RTL8365MB-VC")
> Signed-off-by: Stanislaw Pal <kuncy7@gmail.com>
> ---
> Changes in v2:
> - Declare "remaining" as long instead of unsigned long and drop the cast
>   from the comparison, so the sign is carried by the type (Andrew Lunn).
> - Name the affected parts in the opening sentence instead of "the chip".
> - Link to v1: https://lore.kernel.org/all/20260907191940.806734-1-kuncy7@gmail.com/
> ---
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
> @@ -136,6 +136,9 @@
>  #define RTL8365MB_CHIP_RESET_SW_MASK   0x0002
>  #define RTL8365MB_CHIP_RESET_HW_MASK   0x0001
>
> +/* Time the chip needs to complete a reset, per Realtek documentation */
> +#define RTL8365MB_CHIP_RESET_TIME_MS   1000
> +
>  /* Interrupt polarity register */
>  #define RTL8365MB_INTR_POLARITY_REG    0x1100
>  #define   RTL8365MB_INTR_POLARITY_MASK 0x0001
> @@ -2980,18 +2983,38 @@
>
>  static int rtl8365mb_reset_chip(struct realtek_priv *priv)
>  {
> +       unsigned long deadline;
> +       long remaining;
>         u32 val;
> +       int ret;
>
>         priv->write_reg_noack(priv, RTL8365MB_CHIP_RESET_REG,
>                               FIELD_PREP(RTL8365MB_CHIP_RESET_HW_MASK, 1));
>
> +       deadline = jiffies + msecs_to_jiffies(RTL8365MB_CHIP_RESET_TIME_MS);
> +
>         /* Realtek documentation says the chip needs 1 second to reset. Sleep
>          * for 100 ms before accessing any registers to prevent ACK timeouts.
>          */
>         msleep(100);
> -       return regmap_read_poll_timeout(priv->map, RTL8365MB_CHIP_RESET_REG, val,
> -                                       !(val & RTL8365MB_CHIP_RESET_HW_MASK),
> -                                       20000, 1e6);
> +       ret = regmap_read_poll_timeout(priv->map, RTL8365MB_CHIP_RESET_REG, val,
> +                                      !(val & RTL8365MB_CHIP_RESET_HW_MASK),
> +                                      20000, 1e6);
> +       if (ret)
> +               return ret;
> +
> +       /* The bit clearing only means the reset was accepted, not that the
> +        * chip is ready: register writes issued before the documented reset
> +        * time has elapsed are silently dropped by blocks that are still
> +        * coming up, which leaves the switch half configured. Wait out
> +        * whatever is left of that second, measured from the reset write, so
> +        * the poll above does not add to the total.
> +        */
> +       remaining = (long)(deadline - jiffies);
> +       if (remaining > 0)
> +               msleep(jiffies_to_msecs(remaining));

Tracking deadline math across regmap_read_poll_timeout() adds
unnecessary complexity. If the chip reliably requires a full 1-second
delay, why not simply msleep(RTL8365MB_CHIP_RESET_TIME_MS) upfront? We
could perform a single regmap_read() check afterward to verify
RTL8365MB_CHIP_RESET_HW_MASK cleared, though even that might be overly
cautious.

FWIW, I noticed that older chips (like the RTL8367R) do require extra
time after the reset bit clears, whereas I haven't seen that on
RTL8367C devices. Checking if RTL8365MB_CHIP_RESET_HW_MASK was cleared
simply might not indicate that the chip has finished booting
internally.

> +
> +       return 0;
>  }
>
>  static int rtl8365mb_setup(struct dsa_switch *ds)
>

Best regards,

Luiz
