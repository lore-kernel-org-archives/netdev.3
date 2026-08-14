Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D81F768EA
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 13:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714435; cv=none; b=tToSvLXRWW6uDByxHm7BYJb8yCckuetZp3Xv7zBCRx8nK9ex7oNANa5fBnuHQFrtFKT69y45XGI0OvTz3cUj2Co3heg265VAxBHaCjA9qnmQmWncSZ0caMQxc1umj60QN/bGbAPqKVgpoQQ+Xs1bI8MfizA+Pumz7gkSnF1gRvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714435; c=relaxed/simple;
	bh=xkgFJCp/Zk/sqzv4xyN/NJ242EfBE169OBRzxFIrK7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVfgtuzsgknlMYZNGFqUm1loH3nn2fx+2ctSQEq3dWZfPapq1DmPbmaLerVqEfmkcrM5EkVDLgtCvlG2Tpuyd7vOeYITjJ042Zlgw0gkKF2WHhAHMQGAoEYva8BES/qyuKWgrwsg+f9nu8AW3IWMkWErdbAwzTgzPS5DQlB6pPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c207cb16cf5so146837266b.1
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 06:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786714432; x=1787319232;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NBTxHEUUi4J2ttd+XtUaUBMmZySWV/hj2+fFGqKDlJM=;
        b=UXzy5fZ4MhAtIPVk2MipUvw2B5j8Tx0fr6JhtBkc1QrPeeIP4qmIfX8qUCnXMJWUMz
         Hnd9mwyDxuxC8JreA3hbUeknH4paRR3DKwa1YXZ6CYJZP8iUHVrpEq5U9xXFXG2nsAIt
         a6cr3CmXdBvdaxCjmkj37kC6se5QceLXeyfyCj6N+qOb6YW5VctAb+pkrx+uNAlFU3w/
         lGMz8wArbZ0ZTCvgvqm2UFKHoBPI6AOCJBtedmOz1JQT9SUVVJukvnMIg5XAtfUcdXI2
         WaGvHQ3s3j9l1h/X3/faXJ35Wb2vyuEmgoILjyJ+Z80FXcJNUaV6ENV/DBB5KMilIOUV
         B+ew==
X-Forwarded-Encrypted: i=1; AHgh+RonRIfhHZ/257CVB/+nwEWo8OtRvSpJvmNBFEnKr788+5hQki7MbNC0/Lisnuibcc3ndwmH4bU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQERVduRo48eFFGCBcf5vvhNQRDhRRzeMnhliGFWpkHPnl9Q9E
	SDzY7ixddiATtltGT6qX+QMew2MHn6UUCJVnXPF/IXB3xEo560l09zC2+LDqk4uZXP0=
X-Gm-Gg: AR+sD10Zj4/HdpBhxjh9LdGay/IKmviJvPcdH4ZeW6ztiyRlJGyLpsbO1+GAzIcIyRr
	XuZbfJr79aiFQhW3Pj8qGs2SaeTVzjIJT08f7Jo6IUh54qn1G8hVtvMEuwaQtjJX4eIED+UaxvB
	vdT1PfRkIwb5W8eJgj/VwhOf4dGTesjCHvPVWADYmTUTcAlYN61stA+JuYW26yJAsv3wd/iN6q5
	I+ptODShqOhq9xXLjCtLbEFyW32dwmpgQ6PbLkqLTzM0CwpwYF9NYOEU9QWEvKivIUN1NEjGJ5z
	rHm8iJhOpV7n/DnbK6G0S7noSJBQ0XCcfWGOtN63ePxC8m8UHJx5F5Pff8aASjxC4wHD+fJr8WO
	gu+Ut7Bu6sOhwOQkFJC0DqfrIiUTwnuBVqmZv2mDjtpjbMyatvxssMR0a2yNd2bAFd/Ud8qVWKI
	Llq5QDEUbMIAbiJQa1ZrU8VMqlpMVCL+TEL8ebvGcNDOfhUeB7j4myyFv091fCl/SZmanr7dH3m
	tHfSZhsyh7SugqdoqBWEBKZ3vBH/upLC9DQ
X-Received: by 2002:a17:907:c786:b0:c21:4393:c41a with SMTP id a640c23a62f3a-c214393c597mr9418466b.11.1786714431802;
        Fri, 14 Aug 2026 06:33:51 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c21234ef299sm97760666b.25.2026.08.14.06.33.50
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 06:33:51 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a17211b9ecso1844778a12.2
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 06:33:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro+oXs8KyXzY0KBQVwEDaidvWReGBs6cnQfrT2Wako+FO9ZLlRLzlJqPxRjVryU09UW/XrboaI=@vger.kernel.org
X-Received: by 2002:a05:6402:1cd0:b0:6a0:a644:355e with SMTP id
 4fb4d7f45d1cf-6a38a8bedf4mr2981067a12.2.1786714430006; Fri, 14 Aug 2026
 06:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813-rzn1-miic-fix-array-v1-1-b58cafcc917e@reliablecontrols.com>
 <CAMuHMdWUrabJOWLAiSrSm=r7KbuZn4CrVZiswJsf96U3STaNTw@mail.gmail.com> <c933264e-151f-455e-81ee-6c16a5f11d84@lunn.ch>
In-Reply-To: <c933264e-151f-455e-81ee-6c16a5f11d84@lunn.ch>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Aug 2026 15:33:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUqeVfmsOYQJMPwF1Kui59dEY38OAKWMr42DtEThpKSwA@mail.gmail.com>
X-Gm-Features: AUfX_mz_hQ0TBj7ICikSgGrzarOlKuc0im7GCeWn2gWIWPpQ5K6KidfPNAk4oAg
Message-ID: <CAMuHMdUqeVfmsOYQJMPwF1Kui59dEY38OAKWMr42DtEThpKSwA@mail.gmail.com>
Subject: Re: [PATCH] net: pcs: rzn1-miic: Fix config array initialization
To: Andrew Lunn <andrew@lunn.ch>
Cc: khendry@reliablecontrols.com, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-renesas-soc@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

On Fri, 14 Aug 2026 at 15:14, Andrew Lunn <andrew@lunn.ch> wrote:
> On Fri, Aug 14, 2026 at 10:11:28AM +0200, Geert Uytterhoeven wrote:
> > On Thu, 13 Aug 2026 at 20:09, Kyle Hendry via B4 Relay
> > <devnull+khendry.reliablecontrols.com@kernel.org> wrote:
> > > From: Kyle Hendry <khendry@reliablecontrols.com>
> > >
> > > Fix memset parameters to initialize the entire DT value array
> > >
> > > Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
> >
> > Fixes: f39e968dc168a7bd ("net: pcs: rzn1-miic: Move configuration data
> > to SoC-specific struct")
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > > --- a/drivers/net/pcs/pcs-rzn1-miic.c
> > > +++ b/drivers/net/pcs/pcs-rzn1-miic.c
> > > @@ -683,7 +683,7 @@ static int miic_parse_dt(struct miic *miic, u32 *mode_cfg)
> > >         if (!dt_val)
> > >                 return -ENOMEM;
> > >
> > > -       memset(dt_val, MIIC_MODCTRL_CONF_NONE, sizeof(*dt_val));
> > > +       memset(dt_val, MIIC_MODCTRL_CONF_NONE, miic->of_data->conf_conv_count);
>
> Sorry for hijacking your reply, i already deleted the original email.

Np ;-)

> This is correct, but could maybe be better. dt_val is allocated with.
>
>      kmalloc_objs(*dt_val, miic->of_data->conf_conv_count)
>
> This allocates objects. It just happens your objects are s8, so size
> of 1. But the memset() would be "more correct" with:
>
> memset(dt_val, MIIC_MODCTRL_CONF_NONE, sizeof(*dt_val) * miic->of_data->conf_conv_count);

That would indeed be more correct.

Note that there is an opportunity for a buffer overflow below:

        for_each_available_child_of_node(np, conv) {
                if (of_property_read_u32(conv, "reg", &port))
                        continue;

                [...]

                /* Adjust for 0 based index */
                dt_val[port + !miic->of_data->miic_port_start] = conf;

                [...]

What if "port" is out-of-range?
Do we just rely on dtbs_check to catch this?

        }

> And i checked, there is no memset_objs().

The *_objs() APIs are still rather new and limited.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
