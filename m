Received: from mail-vs2-f38.google.com (mail-vs2-f38.google.com [74.125.227.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AED23B6341
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790355207; cv=none; b=kBV4i+s0g9euK4R6oX33S/djU6OZMvnYgdm1bGJ2pFd5nNvI6V8F/aSmVnuL/uNWRiRYr9yazMiPcSOdyYQllKScuNQjYpF6eQ1DDTPqgh/xeN8YaGkBZ5YEEznmZ/MQBbRLlSkQNSPOxWLS6c7AWdNVG8JA92MxHMdOBvQNRMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790355207; c=relaxed/simple;
	bh=o9LVP7ZwCEXKXc81BedJatEJdL6CnPhLVwnMMuK60Q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNafL795bYpX5Y3ydcxB71s/7j5KW12STemJtv9LeiqLbw08uhDt8I7WMaff3ZmYBg/YC2aLlRwKdQEcgRMBnpfJ2KEBn5tXBaaVcbyLj6ZQLTNEWjMnKbMzuBPz08idoP4SW+H5/zbpnFEQn5h8PzyigFi7qZOqyhJo8+J3k5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f38.google.com with SMTP id 71dfb90a1353d-5cda985b0f5so45614e0c.1
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 09:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790355199; x=1790959999;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AAZeiUPhNHAKQzyrs52ow84PpNXxw5BqfAwfRumsq84=;
        b=NFfXpgBR+ud78X7qGZ7W7xoXrdUakHB61WkY1ozoK/9UFU76spv3sK3BwnZqoa9DAn
         cEwTk+7wPBeuQMDc10WetHCfqYuyxQD0yo3+f5ANcYuTWVA3rTtlgCSeyPrHB30DLqPF
         7ei2Eo4q5XPtTb6McRlDaEEahsI/HnImQLuZGtCbP6f1s2mUZYdWCsBv56d3fdMDn5JZ
         AzY02yB20ZTaoUs0v4HojMQiRZvZ27y44GH76Qxo0xcgMblyXFdvIInXseLZ7ggSKfb6
         tgZgJ+EAuGEAMPiWckK87Ng+cFqb8+tSK1Wr8o4Muy9cQL+GCky0xVu4yLEk3TFQIrCb
         h96w==
X-Forwarded-Encrypted: i=1; AKwUvBw9255FZtHsl/jdPPqWXQAbUd8hv4clARvL/gu4Go//BPjpwVGBr6xvflWbvKuztjCVI6qS3xs=@vger.kernel.org
X-Gm-Message-State: AFuF++mcfnVMLdvMito/3j6HAfjroJ4+ZPBOGoGIxRtqX5wIG89X/Xr3
	zHzCFOuR+nOjil43OOImOp+CQ6X4CyCZ4GiqIgrKgxtLxKvknBG2tkaT30FNqwH0
X-Gm-Gg: AYBFou29mzBFWXi0bhORunbGC3+ekVL4iDSbN8Lz5huTttX0ZszpGLWy0aMhekhJ7CL
	4rNEfvJHvnJCCqxJdMf0x+SzIp7M8AHT2AZSzyuODQZgLV3ZU5FTFfhoPTvwud4sZiIbCVefr2a
	ilL4empSB7zIHAI43YPNkXxb4cYalOI5k7BPP9Z4nWHYMqHviTrAiO2glTVrIFwB7aJHxJERNoC
	WfMANDF9N7FtYyP6+SI1JGwNoDtW69TNnZGnnPLssg/+1eEGzjSsUJSdL47OdcmXXVJlxOULjOs
	+8q0uY5xqaEvtHie59pIUNkwYvVKHPdo2uXoCWfSoxCRNwfAcRO9ZWHcM0CTeA+EeYK3avJqb2z
	o79CgaO3Uj4A7eRQQh3uJTYL6kjU9MszREmlAkPeZ5zTpDH0aDepbZ6VN/DfOG9MBtX7T1WxKfM
	cozxAaxFqITMWGlb+BxM9xRvGbQOWEu2Ad4K8gjqXQFbqg3HR/IfakKuP4xjIG6HM+R3VAFVlRU
	KuFqwSQhS0IQheLjibdFc6vMikgDWywBxHYGw==
X-Received: by 2002:a05:6122:e183:b0:5c9:a60d:3278 with SMTP id 71dfb90a1353d-5cc9725e891mr1275447e0c.12.1790355198740;
        Fri, 25 Sep 2026 09:53:18 -0700 (PDT)
Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com. [74.125.227.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cc65d664a6sm3319562e0c.15.2026.09.25.09.53.16
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 09:53:16 -0700 (PDT)
Received: by mail-vs2-f41.google.com with SMTP id 71dfb90a1353d-5c67e512ee5so332635e0c.2
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 09:53:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxRkx1LdTS993jEaO69LjXL00bl38rAvjqUt6DPo1tWD8fSk9bJQi6Wqb4gNxxw7CViwQzeGvY=@vger.kernel.org
X-Received: by 2002:a05:6102:3f4e:b0:779:5049:87b2 with SMTP id
 ada2fe7eead31-7b1b34d3523mr1094599137.0.1790355195965; Fri, 25 Sep 2026
 09:53:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925-miic-validate-dtb-v1-0-3a6db9bb75ec@reliablecontrols.com>
 <20260925-miic-validate-dtb-v1-1-3a6db9bb75ec@reliablecontrols.com>
In-Reply-To: <20260925-miic-validate-dtb-v1-1-3a6db9bb75ec@reliablecontrols.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 25 Sep 2026 18:53:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX_UC--78P4tHriUpQeNqd7Vj01vWai0RNaT-dwS3O4LA@mail.gmail.com>
X-Gm-Features: AclHuK8y_vFWWqcLu3lD0-xDavR-ZA4Z4hJ7pGA6sis8cejUzuNuA7WzsLWOS9Q
Message-ID: <CAMuHMdX_UC--78P4tHriUpQeNqd7Vj01vWai0RNaT-dwS3O4LA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: pcs: rzn1-miic: Make usage of
 miic_port_max consistent
To: khendry@reliablecontrols.com
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Kyle,

On Fri, 25 Sept 2026 at 17:20, Kyle Hendry via B4 Relay
<devnull+khendry.reliablecontrols.com@kernel.org> wrote:
> From: Kyle Hendry <khendry@reliablecontrols.com>
>
> miic_port_max is used both as the last port number and the port count
> which can be different depending on SoC numbering. Use compile time
> information to always set this as count and fix logic that was expecting
> the last port number.
>
> Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>

Thanks for your patch!

> --- a/drivers/net/pcs/pcs-rzn1-miic.c
> +++ b/drivers/net/pcs/pcs-rzn1-miic.c
> @@ -59,6 +59,8 @@
>
>  #define MIIC_MAX_NUM_RSTS              2
>
> +#define MIIC_PORT_END(x) ((x)->miic_port_start + (x)->miic_port_max - 1)
> +
>  /**
>   * struct modctrl_match - Matching table entry for  convctrl configuration
>   *                       See section 8.2.1 of manual.
> @@ -222,7 +224,7 @@ enum miic_type {
>   * @index_to_string: String representations of the index values
>   * @index_to_string_count: Number of entries in the index_to_string array
>   * @miic_port_start: MIIC port start number
> - * @miic_port_max: Maximum MIIC supported
> + * @miic_port_max: Count of total MIIC ports supported

miic_port_num_total?
"max" has a different meaning.

>   * @sw_mode_mask: Switch mode mask
>   * @reset_ids: Reset names array
>   * @reset_count: Number of entries in the reset_ids array
> @@ -482,7 +484,7 @@ struct phylink_pcs *miic_create(struct device *dev, struct device_node *np)
>
>         miic = platform_get_drvdata(pdev);
>         of_data = miic->of_data;
> -       if (port > of_data->miic_port_max || port < of_data->miic_port_start) {
> +       if (port > MIIC_PORT_END(of_data) || port < of_data->miic_port_start) {

IMHO the asymmetry makes the code harder to read.

As this changes the logic, I assume this is a fix?

>                 put_device(&pdev->dev);
>                 return ERR_PTR(-EINVAL);
>         }
> @@ -822,7 +824,7 @@ static struct miic_of_data rzn1_miic_of_data = {
>         .index_to_string = index_to_string,
>         .index_to_string_count = ARRAY_SIZE(index_to_string),
>         .miic_port_start = 1,
> -       .miic_port_max = 5,
> +       .miic_port_max = ARRAY_SIZE(index_to_string) - 1,

Why the -1? Oh, because the first entry of the array is not included.

>         .sw_mode_mask = GENMASK(4, 0),
>         .init_unlock_lock_regs = true,
>         .miic_write = miic_reg_writel_unlocked,
> @@ -838,7 +840,7 @@ static struct miic_of_data rzt2h_miic_of_data = {
>         .index_to_string = rzt2h_index_to_string,
>         .index_to_string_count = ARRAY_SIZE(rzt2h_index_to_string),
>         .miic_port_start = 0,
> -       .miic_port_max = 4,
> +       .miic_port_max = ARRAY_SIZE(rzt2h_index_to_string) - 1,

Why the -1? Oh, because the first entry of the array is not included.
And it is not related to .miic_port_start, which is zero here?

>         .sw_mode_mask = GENMASK(2, 0),
>         .reset_ids = rzt2h_reset_ids,
>         .reset_count = ARRAY_SIZE(rzt2h_reset_ids),

I'm not sure this is an improvement at all...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
