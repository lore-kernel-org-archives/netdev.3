Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E20313267
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 22:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789424367; cv=pass; b=qirWfJZUvdoVtrSeei/4Q+b22lQzoMa0nxJdGt+5+dLpw3U2C3jnIXNYE9tsXgA9lTrWh7PMojyCx6FrgbH0zJGc3yczAVKhbuEx0jBNTJf2VGD7HJehszOgRqIEcPVjcqFgqSObCRSGO79Spo6FiqDoXGHvgW3x2MLRu4+A5Es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789424367; c=relaxed/simple;
	bh=wZ4qmPT0QMruFr9VXDHGmFjNNOoufqS/JOgpwyJQpCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BckNL68fqwp6ANG4LCuBQobfXKcs/bsSaRZhFVwRpTg6H8E1Um1XbY3cWVjCo42vLSf/n9GptCRMUMSwUSzvZ/CIzP20PgsV/1w0654KCWyrWlbuJ3eSLsFfzvKQrTZ39JVisLWgV+SU/IdfIZPnFaDa9hN+meYatZQR3/cp+Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbsjgelm; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbsjgelm"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a9bd4db6ccso4775933a12.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 15:19:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789424365; cv=none;
        d=google.com; s=arc-20260327;
        b=XgRQ+x281zLtc1VCDUjHK8k8pC3bCK40JRjENNLqZyMucnGtosL1kTzExx/sD8pz1u
         uvcO4GD29MCDogEg+NVJiWowuygqEIA86cwcp/QjIe/DDNHQ3xJ/8JnWXRuRz4C4Oa7w
         tvIgOQgQqG3gIBUCtNeKnucT0tNy/5QZShihEAKRTvX22uFlueNDq9yx4hJhUO1pw/gG
         xQgu3l+XUKX/e7V2QLNgnsTTcx8YRurNB7WURFHmut+N17W3C+/gCy+pVtKSZcTTq/NI
         bJA24ztCi86uClG596qyJeKXNfsD5CU/kgyScT/TFluo/OQWStYAHLyvWkAh65SG/Q6k
         uDtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eieWMJNDganQMnVOMWmefej0YEBfyVXPwdqVtASgytA=;
        fh=bh8jZUeWv9ldE9z5SGjOPsE8QJ+bcwoEEHtgg2P+rWI=;
        b=HVwZ45NEMmUJ6ZLe1lnMqZ7h9nCPqRzakmoPABaWOw+Ftnicmy7nC11mw42drB1bFc
         duwBH0miC5nh8+loRg73e1eR0NCTQhDrvg9V2YgeH+NV72tuP2brFRY7c9N6UD7qn5I5
         C/Wy46Im0UullnT1ff189JH8kJ385z0CpAoMGTM+J/AA2t3QIhY3HGHeztNB8CfdVTGg
         Jsarx5QPsd7wV1DHtuaTmh/6bEzrEx5qjqoU89+sLp9AGXEMDELeBn3p8gQWB/M9aeXi
         1SKqr74gNkw2HXLN8QwKOW9apZUrdTLlAaNK0oXTX5rSC/MTzI716AePZzS8twqgS8AJ
         Fwjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789424365; x=1790029165; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eieWMJNDganQMnVOMWmefej0YEBfyVXPwdqVtASgytA=;
        b=mbsjgelm4uuUExOHxryg7XhRRUBno0nDXHe1tsdFFVA7xDzlo39pDnUx6Pd6zZqRqM
         frxpUe47OgO/Erwrg+A7qbaltw3dYUn/bAtkU83+01YT+HjqP5HTYf/S3EsigCMQuzJh
         PB1bA3V/Qxzos4VOK6DSkKKuzHGjZ7DgNJ1i2BH4mYK7l5OWsgv8VaaJrRPkxvxq1PrJ
         mvsqpa3FdG2zAMiugrEN5Dh9X/6rZ82Lpa3kfj4exS34ZYr2rMYhcpV0pSv1s+JoEqg2
         rU9Pd4I9tl/zu3C0cQV103x73LcSu0VDcYNM71g9gahAqOMSAAh/7q9aKt7nRxPdbBda
         ciHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789424365; x=1790029165;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eieWMJNDganQMnVOMWmefej0YEBfyVXPwdqVtASgytA=;
        b=uZWIxG9qSwR8ct+o1L9ZQZqkoaSD0wBZ0rs9wfUmYozXO+4h86zvdBcjfHDLngOzen
         abcNOM9WPYyRxfPyW7WiJa6Zk5WV1rqD6EvFidI24qdcTjgw6lKFMj0iB4te6fiX3XHP
         n7fStUv/zaezeF/+BoRXMebsWdosoAR8UDZrnxhLKXan+Pp2g0Nzh1CP518Qbt7TCLKu
         1gg4uXNEP5EEMiH+UTsNfIrMFbSZcSLYVCxpd5E+F0dRCwm5uD4PE2LoMy+hKdjZ/aqw
         O0agIbKnsk5YTU8PW/q5Ji0kffTewdq8b4ZvNfrP/TNACxSPdRV2zz8rfqwhwUznaP6I
         +jYA==
X-Forwarded-Encrypted: i=1; AKwUvByzamM7+uUfK8G+yLjlwrs015cbd0OdashbcJjknx7dYgFD8XtwdYOdXhRwRHyWVhWFyEZX36Q=@vger.kernel.org
X-Gm-Message-State: AFuF++kkuGd6XHUCZCnuun3GRgP10TRSqu4yz1xVf1+W6QMJ8XBwneyN
	EoKjL4Z6X5xaFzgGUFPwt1iOWDKCwhQy7RKOjZ8FC7etiTaORYjUw8Mx1FXefin7uzp+BLyc9kN
	A0wwaW7KlmoYYHkKFT1BT7/PBUr6wkA==
X-Gm-Gg: AYBFou3oWpceeiy5QlA8GxL/RpwlGjcbKXO6z2o/FAnDVEGz/QvXfOmrPV04oSTXPQF
	Aem2f8yuNjYZuil6HKGlgbJ4sZmR20ByDF+yoGY+thKNnsDqtqnRtIWfGj91PLxQUvoP7D1XpE4
	twnzk4Op32zbsmLdUOiTnX9CEnqDFJFpfroCynDhgk2XFI2EwoS7cV48zASXSzNQG3YLYmyMcDd
	uEGa4jK5Go4Q/jB2BQMuLxUoARrBOVYth+PZudGqxqFsYj2fcwssKNsRzhxW0Wxo3wXnM3w1ScO
	csUlIWsnj3tWicBs60q2KLBHe2os0YhF1XrHnDpuMcDSGIJhWRKT/Kg0CtRpW3DXHjWLN8sBSJF
	BjyDAqiH3BTT5uHXkYk3AhmOwBOO9jraRoGsC7ti6NDpuwqTm58NrqbTmkqP/x/U2fRh+
X-Received: by 2002:a05:6402:414e:b0:6a9:941e:ec76 with SMTP id
 4fb4d7f45d1cf-6a9f6219af1mr3022439a12.2.1789424364586; Mon, 14 Sep 2026
 15:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913012148.9800-1-mhun512@gmail.com> <2b1101ed-ee5c-4a44-bdaf-a789964dfd0b@lunn.ch>
In-Reply-To: <2b1101ed-ee5c-4a44-bdaf-a789964dfd0b@lunn.ch>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Mon, 14 Sep 2026 18:19:12 -0400
X-Gm-Features: AcwNN1W__BdC7hnTIVKAFxapwBUaL0k1oK8CvdPcqRs25p2wVyVe5d8GRJnHUOM
Message-ID: <CAGEsz8GUiXT18xzGGjzEvZEX+1axY7f3Fcj3mHk8UAJdEEzCJw@mail.gmail.com>
Subject: Re: [PATCH] tg3: clean up PHYLIB resources on probe failure
To: Andrew Lunn <andrew@lunn.ch>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, Michael Chan <mchan@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

I'll remove the redundant USE_PHYLIB check in v2, as both cleanup
helpers already check their initialization flags.

Thanks,
Myeonghun

2026=EB=85=84 9=EC=9B=94 14=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 4:10, A=
ndrew Lunn <andrew@lunn.ch>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Sat, Sep 12, 2026 at 09:21:48PM -0400, Myeonghun Pak wrote:
> > tg3_get_invariants() can register an MDIO bus and connect a PHY for
> > USE_PHYLIB devices. If tg3_init_one() later fails, its common error pat=
h
> > releases the mappings and netdev without undoing those PHYLIB resources=
.
> >
> > Disconnect the PHY and unregister the MDIO bus before the remaining
> > teardown. The existing IS_CONNECTED and MDIOBUS_INITED flags make both
> > helpers safe when initialization only completed partially.
> >
> > This issue was identified during our ongoing static-analysis research w=
hile
> > reviewing kernel code.
> >
> > Fixes: 158d7abdae85 ("tg3: Add mdio bus registration")
> > Assisted-by: OpenAI:GPT-5.6
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> >  drivers/net/ethernet/broadcom/tg3.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet=
/broadcom/tg3.c
> > index 73a4b569b..4662e0e92 100644
> > --- a/drivers/net/ethernet/broadcom/tg3.c
> > +++ b/drivers/net/ethernet/broadcom/tg3.c
> > @@ -18047,6 +18047,11 @@ static int tg3_init_one(struct pci_dev *pdev,
> >       return 0;
> >
> >  err_out_apeunmap:
> > +     if (tg3_flag(tp, USE_PHYLIB)) {
> > +             tg3_phy_fini(tp);
> > +             tg3_mdio_fini(tp);
> > +     }
>
> Looking at tg3_get_invariants(), tg3_mdio_init() is not conditional on
> USE_PHYLIB.
>
>     Andrew
>
> ---
> pw-bot: cr
