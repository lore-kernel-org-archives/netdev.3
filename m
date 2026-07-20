Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8739369D4B
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 11:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784547538; cv=pass; b=TJaXy+rH/hag8lbWiCS27u7uGArSEfvr8lVWRANNFkddoErZdHktEXFMKIZC0f6daJjNPJVSYg2fOtrfTMNi2HmrSkG+Iw41/4YS47fSJmOc2tP7GmW/a3AuFFxUrRelZhUTE1aiwoX8JOetbVZ3lnQsNdnrV/r+S+b4HHz+uLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784547538; c=relaxed/simple;
	bh=3mFDRcZDbh/vAxE726hbAA84Hj/VP9ketvV+yl9H0x8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zx/rPf/hPhBdM/VmoDIv+FCwG8TtLqkWATMy63+l0nb17hgmd32Kjz8wIuKavNwRUVcOZ3DtBHZbO/J5wNsDTjfa08YxCm//u1mpR+UolHKJeAqHzo4Z1RwP3rhhBeK6O3pkuFulcPzXPBfrsS9pAyuFfcNOJ/GJqqBxdL4gNss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X4mWxZ7F; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X4mWxZ7F"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-448de0cc236so5760216fac.2
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 04:38:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784547531; cv=none;
        d=google.com; s=arc-20260327;
        b=RjUuUIXspaKfY4ljXuz/GiRVRByga0VSASyq779zm0sdUnRa/S1damlDQJ7LWXW7AD
         SPgJY0GLUBspNopJhhE8ohPqLIfEKZ43xeYkPBpUrMyNvdO0BPCoQTxOeC2ExcQm5HgS
         I6BbwOEzz7StmE0mEudsa+WDQ5VHGdh9RrnaoOcbgboy4vpVc3aTKWTASFHA7kGpcgcX
         iJHWxbVRtVOeu8T66jzyuzAwDoEokXBO6k1112oTIJOy7WOL+WpSnjcohQmL0f7t5dHk
         ylpaJYus5+Q8GzQhLMMpwzCSu41ie7sDebY/+URA+9YYyDvelpgYo2IAK+fI8FJx8hAq
         ck8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f/gXgCuauhGKcFUWfulPTHzrfiJTz+du/PeQqhHatQk=;
        fh=aHVp4aEIO4pqCxnfC3ZmaYQeQBoa5YJ761nyRto5PQU=;
        b=OVvqMH+swiGNvWWGdzicYrOBfUSF22yK8YT9prOEmYtzKxUcMO3pATuhrtKE6Xm6xs
         2odgdcIVziWJbEHtJqWSOlkror7K/6QaZUMMcXBGaflcYkyNA+hUAt3Ml2NkRXnAoCy1
         vu+Rg1LB5G4nE7zUiT9VM5XjWLFgtGYwAEiPgbYW72tN4Gl24Te7+FkDnxlMnTNG9580
         mvM5zFTvw9FG3CUT2+icDQFpIFbO/9kdpL52f2p/+0V6MntxPtx2SQdTLYYes/n4iRAH
         DcUq4kCbzXptWrkAX1QnkGqk5DgQbz2cMCusdMv8wrCBCEmHTK+GLBnILkYtmLtjYFxl
         lICA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784547531; x=1785152331; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f/gXgCuauhGKcFUWfulPTHzrfiJTz+du/PeQqhHatQk=;
        b=X4mWxZ7Fa70XH89aqxNAXsgkMmS7LnWpLFLBV13+JVYtovBW9bS1SIWGI3zMKPej1/
         VHgxaErTzKISOYqwH1skjYFIw4bOdJYiWPkPT/ediAxLidYm8qdCiQO+LhcF5EGU3/7Q
         N3pqq6T7WczZctXi14CFWRloQNkJHd909sCMYujTAUKHE/qo7pfvEDorRqPPZeeKbD6d
         nouxcKxkp1yMH8/+Bv60XbUrVsgeyEcUDcq6zMPTFXRIi7KqStApYtPJcbKaHVPSoo5k
         TeJda7jnVdpjrUsD1HXSf1rXIQund1bO4B1HhHqL18CAh4gF5UVg2xTbvKIg8ZLE/TyB
         rniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784547531; x=1785152331;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f/gXgCuauhGKcFUWfulPTHzrfiJTz+du/PeQqhHatQk=;
        b=dqnTwjFUS59vPU4ra76QabVoj/uGVWT3Q8wua/6Ww5+emP2OwDGDNyH5mSy4qp+HfC
         9bJk1oPHm/960emZc3yZqhV8s24oYxb1UYk/zi12yq02Q/FcVdt+kiLy8pQncQ00aIRu
         rcuXEKdlw7on1cWnommRQVoZyEXV6I585vMwktnsibX/ZHk+MBBWFFMBSnQwH8b/3l1u
         KUUw8HtQAGRvqOXMrA/VBN3qoXLEzza9u8Heev3hIg2ulqgmZntCYNt4vbPeAeEY39OI
         a/QQ2T9DOnNY/izpTcaWJqHSlqEaOPn7iIfGzLlv8D4ZYBZtHRZpFf3CIo3m8Nd3z/G6
         m/Gw==
X-Forwarded-Encrypted: i=1; AHgh+Rr7ceQIPPTBxhR4R3uhLxxaEUvPdfRhPxRkG31jbZGO+aH7kN9NsX+y18W09Trzdz7gajcuAxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAoFjA0oIOxydqk9kBKGqFSEhuKy+taheD+fWCYSUpcwsKYX1l
	MEhxoYnxPHT6iSQSLUOcNLp3EA1Yqdz8iC8Mn69Xbn3zERtx37by5crhfUV2XsKVHYsXminVcpo
	/ohodgzeaG4uOSOT6xj4r08lh7YFxOHvL3SquSUmo
X-Gm-Gg: AfdE7clWYpfL/2s3g1C2VpbzdrQx4pjEvPwIwvI64TAVlBqz9WsVb9BKQwEXjS4+Cyc
	uNRPkBtRMr7/ISnJyOMxo96PTsMtna8l/dmtLTIxCR1ZSBuMZ4thdfhRDC3B3HWwnS5mKrtM3AA
	x3rQbQpo0NyTqnJDVrAVco53mvwmF9Se+3qmRgeH2vRpD0pT0L5AFraoYk4a8O9VVgpV/MnswXf
	3MTiwmHaMCXYjmxuEAT31vtU0OuCJh/GppSuDZX5IOeoLvvdr2yvVAQ0BNl9pTRjhsjxZwQui3G
	4E17NtzXQDb//DeHzQ==
X-Received: by 2002:a05:6808:150b:b0:49a:3094:57bc with SMTP id
 5614622812f47-4a4d057091emr7828138b6e.43.1784547530438; Mon, 20 Jul 2026
 04:38:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719-usb-ptr_err_patchset-v1-0-85f7f2e4fefb@gmail.com> <20260719-usb-ptr_err_patchset-v1-3-85f7f2e4fefb@gmail.com>
In-Reply-To: <20260719-usb-ptr_err_patchset-v1-3-85f7f2e4fefb@gmail.com>
From: Badhri Jagan Sridharan <badhri@google.com>
Date: Mon, 20 Jul 2026 04:38:13 -0700
X-Gm-Features: AUfX_mxW23vWV4YHSucfnpNg2RwqWb4K0lV2PtTDbAAqVY6VN7Bv5eoCWZEPBx8
Message-ID: <CAPTae5L7CaQoa+Zy7r3ezZQ_giY5nWOut82P5rC_8v6YeC-0Ag@mail.gmail.com>
Subject: Re: [PATCH 3/3] usb: typec: Use %pe to print error pointers
To: Subasri S <subasris1210@gmail.com>
Cc: Peter Chen <peter.chen@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Duncan Sands <duncan.sands@free.fr>, Chas Williams <3chas3@gmail.com>, 
	Minas Harutyunyan <hminas@synopsys.com>, Hans de Goede <hansg@kernel.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-usb@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 19, 2026 at 5:56=E2=80=AFAM Subasri S <subasris1210@gmail.com> =
wrote:
>
> Use the %pe format specifier instead of %ld with PTR_ERR() for printing
> error pointers in various typec drivers. This prints symbolic
> error names (e.g.-ENOMEM) instead of errno numbers (e.g. -12),
> making error logs more readable.
>
> This patch fixes coccinelle reported warnings:
> ./typec/tcpm/tcpm.c:4799:60-67: WARNING: Consider using %pe to print PTR_=
ERR()
> ./typec/mux/pi3usb30532.c:143:3-10: WARNING: Consider using %pe to print =
PTR_ERR()
> ./typec/mux/pi3usb30532.c:155:3-10: WARNING: Consider using %pe to print =
PTR_ERR()
> ./typec/wusb3801.c:281:5-12: WARNING: Consider using %pe to print PTR_ERR=
()
>
> Compile tested only.
>
> Signed-off-by: Subasri S <subasris1210@gmail.com>

Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/mux/pi3usb30532.c | 8 ++++----
>  drivers/usb/typec/tcpm/tcpm.c       | 2 +-
>  drivers/usb/typec/wusb3801.c        | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/usb/typec/mux/pi3usb30532.c b/drivers/usb/typec/mux/=
pi3usb30532.c
> index 985683fe49e9..a2357a28ecf4 100644
> --- a/drivers/usb/typec/mux/pi3usb30532.c
> +++ b/drivers/usb/typec/mux/pi3usb30532.c
> @@ -139,8 +139,8 @@ static int pi3usb30532_probe(struct i2c_client *clien=
t)
>
>         pi->sw =3D typec_switch_register(dev, &sw_desc);
>         if (IS_ERR(pi->sw)) {
> -               dev_err(dev, "Error registering typec switch: %ld\n",
> -                       PTR_ERR(pi->sw));
> +               dev_err(dev, "Error registering typec switch: %pe\n",
> +                       pi->sw);
>                 return PTR_ERR(pi->sw);
>         }
>
> @@ -151,8 +151,8 @@ static int pi3usb30532_probe(struct i2c_client *clien=
t)
>         pi->mux =3D typec_mux_register(dev, &mux_desc);
>         if (IS_ERR(pi->mux)) {
>                 typec_switch_unregister(pi->sw);
> -               dev_err(dev, "Error registering typec mux: %ld\n",
> -                       PTR_ERR(pi->mux));
> +               dev_err(dev, "Error registering typec mux: %pe\n",
> +                       pi->mux);
>                 return PTR_ERR(pi->mux);
>         }
>
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.=
c
> index 89eec20a2064..ad10470ea73b 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4796,7 +4796,7 @@ static void tcpm_typec_connect(struct tcpm_port *po=
rt)
>                         port->partner_desc.accessory =3D TYPEC_ACCESSORY_=
NONE;
>                 partner =3D typec_register_partner(port->typec_port, &por=
t->partner_desc);
>                 if (IS_ERR(partner)) {
> -                       dev_err(port->dev, "Failed to register partner (%=
ld)\n", PTR_ERR(partner));
> +                       dev_err(port->dev, "Failed to register partner (%=
pe)\n", partner);
>                         return;
>                 }
>
> diff --git a/drivers/usb/typec/wusb3801.c b/drivers/usb/typec/wusb3801.c
> index 6062875fb04a..86d13ab41670 100644
> --- a/drivers/usb/typec/wusb3801.c
> +++ b/drivers/usb/typec/wusb3801.c
> @@ -277,8 +277,8 @@ static void wusb3801_hw_update(struct wusb3801 *wusb3=
801)
>                 if (partner_type !=3D WUSB3801_STAT_PARTNER_STANDBY) {
>                         wusb3801->partner =3D typec_register_partner(port=
, &desc);
>                         if (IS_ERR(wusb3801->partner))
> -                               dev_err(dev, "Failed to register partner:=
 %ld\n",
> -                                       PTR_ERR(wusb3801->partner));
> +                               dev_err(dev, "Failed to register partner:=
 %pe\n",
> +                                       wusb3801->partner);
>                 }
>
>                 data_role =3D pwr_role =3D=3D TYPEC_SOURCE ? TYPEC_HOST :=
 TYPEC_DEVICE;
>
> --
> 2.43.0
>
