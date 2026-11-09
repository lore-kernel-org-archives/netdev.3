Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794189704;
	b=S3PypvDcLdXgRYlS1xqI2/YWRzTS09PA5NuQl6hjCP5mcQdPqjrK9odItvDYoDA+vyT9
	 kgS1W2EZr1ymm5/9A+inCQrVj3aBwzNeXfQns9ccrst3jLQp8VNcBnceskIODxT1ouraO
	 ZVbXj8kFn4lLpBNItRzNKhy+QjvxUhSiQFyJplxAkO0wJE/Fz/srmWRZrMQzTPFF5rhZJ
	 rb4oVNt0bKurx2yROiIFbPF+zNsdltUJgoHe8DzoMqSJFevXD/b0W2TxHv/gjKvC7gbNH
	 PpWZVZ5q1fkbdsBiVNXleoDPLckzw6TthqzOIa6cSMT2pb/xLtHfpw3q2qpuzs2lxqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794189704;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=uTAW0TKjvfD7BsKN9xooVklRKfteW0KINt5lhZgJuiw=;
	b=d4Eu6mPyUZSFSXjYlEGScCUHsUvMtX18k+vahgktc3/nhO/Pp1f3h+FSrgZGBajgTofa
	 1AlgTlz/aJNOlMTJD3vdCK3pxqv0gSgynqHEEsnmx/fJu7Qt03C0ZTfSbjKHDPtQuENhU
	 m55mefXwDHOaO6z11GeXGVEiD+8wA9BV1iB0G1L1uKwpARopFio2OPcxk65/v102NGDs8
	 CeF5iwpo3bB2oNVDfFF4e5N8jEiAgUfz+hRyZ7hwSX95/9F9WOE8WtD9XtTh7HQ7e1Bbp
	 xbuN/G1M5kjhsSWrCdj1UHtbd7bhYdfuwM+BdJ/bZyDdqB4R6Mmz3mfr9HtingL4VBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JyATp1k5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B47606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 02:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31B47606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JyATp1k5
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-714d57774d8so240815eaf.1
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 18:01:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794189703; cv=none;
        d=google.com; s=arc-20260327;
        b=mGcT0oMezZQ5cfZepNAwMS9ONuPGBLzX3OridNinCNXrhDu7jzkca2y89wW+suruKA
         9oAzeEFR3Ly3nDHbTj4fk6SxXxq1oYYx09IH1XJiEtDfxGdhOL9EjtGd4XovSHgTohLG
         fTajKlzghqZqfUIsnY92/Zj2vNSTqLQC7DHUjpkHADM5qgeWBLYfs84BThxl+KXZDBvE
         GoUNoFfB55ND1ctpwbXgRzNLgIkHDu1DcJyF0E5g9nhZRCEXhQFeCPbhWPdVu7UoDhBX
         OhI3ri9rgcLgITuZHn36YLkrwvNWmKml+BwTtpWD/Bak4axtchswSBnznRGHgjUgAtwN
         n0Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uTAW0TKjvfD7BsKN9xooVklRKfteW0KINt5lhZgJuiw=;
        fh=FSv27PKx2E7KagoSU2e+8P+/3o6ChIbG1eVn8h/zk9Y=;
        b=nSntrQrKDgqAHkdRH7wVk5sLQ2JSFLKYuAqZnMXi7l4YWqj2gwbFyaXRTbMqywGmli
         pOsnkACjd8u/MVR2r0pgnkfjvfL403FToHuqCEc3eC+DtaaBz3Cq7bk4PNLW7K0Za2Al
         8qsAWOS4CZFxTZoVFkV+x0OKPLBS7gCDEzZ8b8NvncirBQIeGBBJ1jMUf0YXvkePr6ql
         sxHHCVP4wSuF1iWdFdv1ah26Nuilnj6KNg5n5uQ0PuBnMdjrwxlwLRaBvEcGt6arQ7DN
         gxN7/7c32YE8nOrahgM0JdpBoahSKT0pgYPxAwJIQv1uQ/JGM3KEGnY4JO6/CpxXZQFf
         oxQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794189703; x=1794794503; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uTAW0TKjvfD7BsKN9xooVklRKfteW0KINt5lhZgJuiw=;
        b=JyATp1k5tqswqOFMWVVJqWr3NIatcUZcQNLie2dcvJRmHgk4LuZ0gO4RKeGVqqCV/k
         EDuCHC+AmjS8xTjG158+4dp7PeLu0MOjlYoxsiPL/J6qmPj2RaYwcuIbTclxbrMozcEx
         p9pTxQGN5I+3Q97nZGK7hNys0/sfF3VZ0BclbBJWmv+iui2JjwLJ0RKzStZDYyPPEm4y
         MlogNbB7JwGXFNDrrSyzaKiMLiQe7KTnupcN8PVmBDoiMoVvbaTZrsxh3I7yt2BIyWQn
         jUzZ6QQ22zoM9mkke76nn0sge5VZDDrRaB3X38wiCCseznzR8qliZ0wlBjuNDWlipW96
         AKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794189703; x=1794794503;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uTAW0TKjvfD7BsKN9xooVklRKfteW0KINt5lhZgJuiw=;
        b=zGpDhL9Y5wChR0x+yn5aBNkifV2jVAhYadBQt8em2H3TNYw9mnRjUWu6pNyXuWxh4S
         LBGaPrCB0ixk+25B99p1NFNBGXvyz0jg+Tm73oM2Mbyn4+9wbjj6nJXim4a3Hxi1jaQh
         fPzcV9khF96qe7gFWYuewJnGatOMhKNZpL8j+3RhaP81n76kiBFCpfqfKv35XwwtLxJ5
         3OJ26jE5Q6OzrFVVET44aIZIlK/XqXV71/hR0WXk3gz/HHZX4iYpPUQEz55KNV0fmsAA
         vwGhMEXXNA1QAzuFyuXsWRf3I2vbsCtkEj/FsCEtUIQfO/BhAW6iS+/rFzbsACcSc/xI
         wPEA==
X-Forwarded-Encrypted: i=1; AL+hErGo5W2Q7ojkqUEIskyKtQcAas43i3Pc8V2W3Im0Nd1tOIv+PNWbt75a2nQSLYroADSl/uOWrZU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xTi+pWrfULe+qkvtb61x11nSFXwY4Gns+XnR3d4GxrgqGOAbQ
	NAwgazJAuUiOsoP46sO3SLeATrtfwQ5MBGc3AgMjnKJ0rpXdxaUEPdu4dW7kt/3/aQKunR2V6+e
	lrwG7UFPoKZCpBwLPh/Wi1QMFEjg/nic=
X-Gm-Gg: AYBFou3ASeV8WmnEL8rC9B9LZJZGRsY2gWF9s9fhPy/XhOdVftfspuBLT6dwWqR0hYy
	AVKiGHjcZe4G/5aqXDjeIlXDqrSr+ou1uSxSHzEYHx54mXMUZPKXDDFiNfMUlVFMdntAzzMhy8g
	BEpzb7CiqH7iBe/vEyza1la6yn4RUE24SAT4o2BshYSUS2kzRyAUDShIWqzKhi3LuJWKUfAdbKF
	TlGJuYI6zD5syyKPGSViHojSfviPE4MOD+DSBoN5bMrbOoYweZLm7V+moUbXtBDFqVC2W9TQxOv
	TNtSrQr+iBYlXdDIilW7gzkrAX7wlNVYi/rXmeA09ngW33cKLvj0PooI3k9lwmnbxcUy7gSsyUz
	tHmWZcqYYPjmge/tqCvxM+Atk3Rum/2MBu7uyvszvbw3SeU5ZPSoEStEbOuPIUodwz1vv14s=
X-Received: by 2002:a05:6820:858a:20b0:715:2400:9579 with SMTP id
 006d021491bc7-7170f310a90mr1162069eaf.56.1794189703071; Sun, 08 Nov 2026
 18:01:43 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com> <7ebd9453-4af4-4ebd-9cf7-8422755fc4aa@yahoo.com>
In-Reply-To: <7ebd9453-4af4-4ebd-9cf7-8422755fc4aa@yahoo.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 8 Nov 2026 23:01:28 -0300
X-Gm-Features: AclHuK9hcJpyGCPEGAR6IZqezV5G1cX2VmyhiUoC8VNQM5o45OKxqUZ-uP_TlI4
Message-ID: <CAJq09z6vOz5KZ2x_4xoyP444ks5LYhLDpe3a9VeMyCM8C0JVJg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 06/10] net: dsa: realtek: rtl8365mb: use raw
 VID for PVID on family D
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	linux@armlinux.org.uk, maxime.chevallier@bootlin.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Family D has no working VLAN member config (MC) table. Its PVID is a
> raw 12-bit VID in a per-port register at 0x0700 + port, whereas family C
> stores a 5-bit MC table index, two ports per register, at
> 0x0700 + (port >> 1).
>
> Running the family C code on family D therefore reads an MC table that
> does not exist, and writes an MC index into the VID register of port
> (port >> 1) instead of the one of the port being configured.
>
> Read the PVID straight from its register in
> rtl8365mb_vlan_port_get_pvid(), and make rtl8365mb_vlan_pvid_port_set()
> and rtl8365mb_vlan_pvid_port_clear() use direct-VID variants on family D
> that skip the MC table. They keep the family C frame filter handling and
> rollback on error.
>
> Also clear the family D PVID registers when the VLAN support is set up.
> Unlike on family C, where VLANMC index 0 is the neutral PVID, the
> register holds a raw VID, and after a reset it keeps its hardware (or
> EEPROM) default. Without clearing it an unconfigured port could report
> a stale PVID from rtl8365mb_vlan_port_get_pvid(), and
> rtl8365mb_port_vlan_filtering() would accept untagged frames into it.
>
> No functional change for family C.
>
> The family D branch is not reachable until the chip table entry is
> added in the last patch.
>
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> ---
>  drivers/net/dsa/realtek/rtl8365mb_main.c |   9 +
>  drivers/net/dsa/realtek/rtl8365mb_vlan.c | 205 ++++++++++++++++++++++-
>  drivers/net/dsa/realtek/rtl8365mb_vlan.h |   1 +
>  3 files changed, 210 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index d69eed0..e82205c 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
> @@ -2360,6 +2360,15 @@ static int rtl8365mb_vlan_setup(struct dsa_switch *ds)
>         int ret;
>
>         dsa_switch_for_each_available_port(dp, ds) {
> +               /* Start every port with the neutral PVID */
> +               ret = rtl8365mb_vlan_port_reset_pvid(priv, dp->index);

We already have a clear and a set operation. Why do we need a separate reset?
[...]

> --- a/drivers/net/dsa/realtek/rtl8365mb_vlan.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
> @@ -44,6 +44,10 @@
>   *
>   * VLANMC index 0 is reserved as a neutral PVID, used for standalone ports.
>   *
> + * Everything above describes chips that have a VLAN membership configuration
> + * table. RTL8365MB_FAMILY_D chips do not have one: their PVID is a raw 12-bit
> + * VID in a per-port register, and no VLANMC entries are allocated.
> + *
>   */
>
>  #include "rtl8365mb_vlan.h"
> @@ -120,6 +124,11 @@
>  #define   RTL8365MB_VLAN_PVID_CTRL_PORT_MCIDX_MASK(_p) \
>                 (0x1F << RTL8365MB_VLAN_PVID_CTRL_PORT_MCIDX_OFFSET(_p))
>
> +#define RTL8365MB_D_VLAN_PVID_CTRL_BASE                        0x0700
> +#define RTL8365MB_D_VLAN_PVID_CTRL_REG(port) \
> +       (RTL8365MB_D_VLAN_PVID_CTRL_BASE + (port))
> +#define RTL8365MB_D_VLAN_PVID_CTRL_MASK                        GENMASK(11, 0)
> +
>  /* Frame type filtering registers */
>  #define RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_BASE  0x07aa
>  #define RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_REG(port) \
> @@ -171,7 +180,7 @@ struct rtl8365mb_vlan4k {
>   * This structure is used to get/set entries in the VLAN membership
>   * configuration database. This feature is largely vestigial, but
>   * still needed for at least the following features:
> - *   - PVID configuration
> + *   - PVID configuration (family C only, family D has no VLAN MC table)
>   *   - ACL configuration
>   *   - selection of VLAN by the CPU tag when VSEL=1, although the switch
>   *     can also select VLAN based on the VLAN tag if VSEL=0
> @@ -740,14 +749,51 @@ int rtl8365mb_vlan_port_get_pvid(struct realtek_priv *priv, int port, u16 *pvid)
>         u8 vlanmc_idx;
>         int ret;
>
> -       ret = rtl8365mb_vlan_get_pvid_mc(priv, port, &vlanmc_idx, &vlanmc);
> -       if (ret)
> -               return ret;
> +       if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D) {
> +               u32 data;
> +
> +               ret = regmap_read(priv->map,
> +                                 RTL8365MB_D_VLAN_PVID_CTRL_REG(port),
> +                                 &data);
> +               if (ret)
> +                       return ret;
> +
> +               *pvid = data & RTL8365MB_D_VLAN_PVID_CTRL_MASK;
> +       } else {
> +               ret = rtl8365mb_vlan_get_pvid_mc(priv, port, &vlanmc_idx,
> +                                                &vlanmc);
> +               if (ret)
> +                       return ret;
> +
> +               *pvid = vlanmc.evid;
> +       }
>
> -       *pvid = vlanmc.evid;
>         return 0;
>  }

If the functions don't share most of their code, they shouldn't be
lumped together inside a shared function with an if/else.

>
> +/**
> + * rtl8365mb_vlan_port_reset_pvid() - Put a port's PVID in its neutral state
> + * @priv: realtek_priv pointer
> + * @port: the port number
> + *
> + * On family C the neutral PVID is VLANMC index 0, which is the reset value, so
> + * there is nothing to do. On family D the PVID is a raw VID in a per-port
> + * register whose value after reset is not defined by the driver (it may come
> + * from the hardware default or from an EEPROM), so clear it to 0.

I'm not entirely convinced by this. VLANMC index 0 isn't a
hardware-defined neutral index; it's just a convention we use where
VID == 0. The driver treats VID 0 as "unset" alongside the ingress
filter. Furthermore, checking rtl8365mb_get_family(priv) !=
RTL8365MB_FAMILY_D doesn't scale well if we eventually introduce a
family E.

> + *
> + * Context: Can sleep.
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +int rtl8365mb_vlan_port_reset_pvid(struct realtek_priv *priv, int port)
> +{
> +       if (rtl8365mb_get_family(priv) != RTL8365MB_FAMILY_D)
> +               return 0;
> +
> +       return regmap_update_bits(priv->map,
> +                                 RTL8365MB_D_VLAN_PVID_CTRL_REG(port),
> +                                 RTL8365MB_D_VLAN_PVID_CTRL_MASK, 0);
> +}
> +
>  /*
>   * rtl8365mb_vlan_port_get_framefilter() - Get the ingress frame filtering mode
>   * for a port
> @@ -809,6 +855,68 @@ rtl8365mb_vlan_port_set_framefilter(struct realtek_priv *priv,
>                                   val);
>  }
>
> +/*
> + * rtl8365mb_vlan_pvid_port_set_direct() - Configure a port's PVID as a raw

The term "direct" doesn't give me much meaning. Since it has
essentially the same signature, it should simply be a clean,
family-specific implementation (same goes for the other functions).

Best regards,

Luiz
