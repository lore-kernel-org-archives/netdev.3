Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CA221ABB1
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 00:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789865543; cv=pass; b=eZwmbtxSGNLwSjh/FuEXSQQz0Wort088fE1kudPONNgxrXeH9gfU3NB+YPo1Edx49qb9AVkWGV/0kt8L9YOSlBxnIqop/raVT4YdHT+Z/d1ZHOugFEDiJ8Yf5lI90DWWcMgUZRmtTQ+0R951nU7ywEBKEVp3fI3DjotU1M9eXX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789865543; c=relaxed/simple;
	bh=3BUK8JAns4D4O94aFHeEQJQLFqjJlmEF8jJnUCFvuW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8rXr8+xBB6rACw31L//0rQV+I63Nvey6Bef8P4MskLLOwkZ8YjV2jfiJPmJcSj50zWATO6uuFTo2j/jZnox4wQgHSWCljA84Lr9h44f9ACcoCaDPBsO70kG6NliujvPcnnkW/Y3Le/7ErB4QuRPWIj4vDvnJIzMwy+3RS0FSS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJ4o9Jp1; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJ4o9Jp1"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f0b1eso309522266b.1
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 17:52:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789865540; cv=none;
        d=google.com; s=arc-20260327;
        b=UQPbw8/U7q7qtdMKDFbjlU3RPW9wBreTemL5xsGtlXiM6t3kO1SIyJwyZYlGxGY7Np
         TV6CtPUc66bceWJhosB8v2BqI1fH+mB6p2Na8uKkUo26oTVIeaPYlHf3Cl3rWiZWfuhX
         jZzckzMqYSuLn57NDkYnViZHTK8n8ieuXaGg7efFFYcoJONvg91OtG4n2ZgZCVG7wrQE
         npDuOmD19K6oOj2vokMavCpNne44hxUMwWwifmsh573o7DRbClEvZ0XEC2dwWqubtsM1
         a+XCzjcqm93eC3uXkIEQe6UpgzkUiIJHKuCRZkwz+LcczgO9524Z102DVVk+scUz/OWW
         S5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c3C3doPNU+BbPfNOlvgAp/S4D1VtR06ufBbUBrF8R8M=;
        fh=0xg1NPAToSfP5cqSr+tZ/g0rHQoAF2A6XjbkmZLnUhY=;
        b=jmmvcn7A/p/9Nxm1IY/vjiqh75ddeMM+50U8LLXKrRBti+bKJcS52/X9wkYa8KYj8E
         w0wGVk3DUfR8NVb+NfOdCMLGo5553KG4w7X/dAaQVhVMsHJAYufeiiZ2BNG511nBRolr
         iQMT9yKHqFaI/t6pmold4voiXKR3Sw4G5IF94wZ/q2WM3fY4Cd3qmxiN+/B4orG35a2W
         Le8M1cHDRvyTbp0BhefhErvSlVi3yZU7zAsJA79o0HAmvDEWwvFKC4h2eGV7hNYrNyse
         u1EAuarpIRAZw08SKVKfrpQkQ8QOE9mUDpCtk7OkEth+QXL0/Bj7QFwKeyetKsgx3hFM
         2CzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789865540; x=1790470340; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c3C3doPNU+BbPfNOlvgAp/S4D1VtR06ufBbUBrF8R8M=;
        b=CJ4o9Jp1K88SD9Hp5lpA/U0hecpMozet6Bz3RQEQZGn2TgvaQH2TdK9hll5L6xBGxC
         AcEb2oYCQQNq8tLfDagMzeMBWmbXg3AfRQMmPk/iscxnzDpww7E/JZeXs1McUB63M6bd
         WrcE/hn/18DX7ikZ1nrIAiybif4t5RnVh7Xyd57e881oCr6pGn/UFRiwIBo+6KYrchy9
         rNgrs9qEXVD6xOwjA2/JS++/+KpWAbg9nShRSGEJtOW5h6TppL5QbY6mAzjMgbPj1S++
         x7NM5BhA9aSTqR+xA+lAGJsPOeWgptb3nluoMnDdOfftlQXyZzR1Ty5ykstqzzuC1p+r
         Fi9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789865540; x=1790470340;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c3C3doPNU+BbPfNOlvgAp/S4D1VtR06ufBbUBrF8R8M=;
        b=0pvtUsWWpgr2pbifHudvXsuYcNwWDkKtyXdloP0k/+KDOaRocwqupYtZVrzmwsQZTx
         AeSz/f39r+gD/hRnlXc5L7x3l4KTPoj9if9GUFqjqO/gZx40Nptj4qMTMKcq8JX7cUfg
         bO6Wec9TNRcOH25gE/kTqJ0w9TDY+EK0/TPELmdC+yY778L9M7P6mOA3wJfnxyZMVmZn
         TBq4MuYPb1N/ZdxRqQMYk02dgYrnsHAejgHJjnwMpnwvVGGoXq68QPB3kqkXAlvztQ0w
         R3jMKzv5b1i7ss5ItWPxWRtLgNoreRa2MOERPDvvuCUYCFZqq7XwJR7kj5qYzESuWBNP
         8WOQ==
X-Forwarded-Encrypted: i=1; AKwUvBw2FFujFbjThuW0fKKeUuDPrHa+uwthILLV0pNQ02BOr9NM59lwHc4qwzIqAmHlqPa220CG6Bo=@vger.kernel.org
X-Gm-Message-State: AFuF++lb6hrEFpUs+4oQDXdy9mLK9Oj7aiQ6+kU1BGYx7pEQW727MaVB
	xomBFP0hBBiu8K7xEOBgeQT3PciGoaJv+XkGQEeeJ1mNTAOedN5kXu20xAQGUl9wgpf7jrYNvPT
	yTQAxzKUROlyjT1yiHeMl7tcYas2hkA==
X-Gm-Gg: AYBFou1YHHenRokCwaSVXUvu1CxzjYzgK1rsicvrWkWFchKG+OLAjIEHEopOLs/FSie
	2XZyiuI4X311piD7dUGsUdcD4TEz81Ful0RZHoz3QGei8QFZ9grk4/ek5sDsMS3rMZtENRehbE7
	s6FDl4jUJ5+DqAH/Uzo8HkJe57M+Q9re5cHnS+PvgINPiWlhzrkVLj8FsVA1onL4QqiG7dAbK0n
	5PhwGig397G2G+hfNSOYMCDXa74pDESVhnPxRfFjvndI70DlH8rvseyuFfCFC7wzqOd8e+NIPgr
	GQPl7bYhQBMEEACrf+c8SrXqFO7OlZ5vjjw3W3FWfayEi9AEA3td0B3gMIT6PHeklBdI/FPdCZP
	YIZYDSaC0gYigBNMuKwBvmzPh3EUDFMOjS9GGzEnFAZCBEOqFMtp0aikKtCuiEljdij/i
X-Received: by 2002:a17:907:97cd:b0:c25:58e:83ff with SMTP id
 a640c23a62f3a-c2a156a3794mr545290166b.10.1789865539670; Sat, 19 Sep 2026
 17:52:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917192835.58126-1-mhun512@gmail.com> <e544a2bc-79ed-4067-9be8-59453d25acb3@lunn.ch>
In-Reply-To: <e544a2bc-79ed-4067-9be8-59453d25acb3@lunn.ch>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Sat, 19 Sep 2026 20:52:07 -0400
X-Gm-Features: AcwNN1VWtFS9czLfcxGxhwerswgSwdEW0tGUGqcJxmZSe1Yapk0ciGjwin5ZEjw
Message-ID: <CAGEsz8EJyv-Ea04gFYysz=6hXD8ehHHtyzvLENpMffKnN85TrQ@mail.gmail.com>
Subject: Re: [PATCH] net: gemini: Free the shared queue after removing the ports
To: Andrew Lunn <andrew@lunn.ch>
Cc: Linus Walleij <linusw@kernel.org>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review. You are right on both points. I will keep
devm_of_platform_populate() and let the parent's devres release the free
queue instead, and drop the teardown from gemini_ethernet_remove(). I
will send a v2 with that.


2026=EB=85=84 9=EC=9B=94 17=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 10:25, =
Andrew Lunn <andrew@lunn.ch>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> > Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit et=
hernet")
> > Assisted-by: LLM
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> >  drivers/net/ethernet/cortina/gemini.c |    6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethern=
et/cortina/gemini.c
> > index 4c762229ce42..e493d495f2ef 100644
> > --- a/drivers/net/ethernet/cortina/gemini.c
> > +++ b/drivers/net/ethernet/cortina/gemini.c
> > @@ -2364,7 +2364,6 @@ static void gemini_port_remove(struct gemini_ethe=
rnet_port *port)
> >               unregister_netdev(port->netdev);
> >       }
> >       clk_disable_unprepare(port->pclk);
> > -     geth_cleanup_freeq(port->geth);
> >  }
> >
> >  static void gemini_ethernet_init(struct gemini_ethernet *geth)
> > @@ -2656,7 +2655,10 @@ static void gemini_ethernet_remove(struct platfo=
rm_device *pdev)
> >  {
> >       struct gemini_ethernet *geth =3D platform_get_drvdata(pdev);
> >
> > -     geth_cleanup_freeq(geth);
> > +     devm_of_platform_depopulate(&pdev->dev);
>
> This seems wrong. If you have to call devm_of_platform_depopulate()
> why are you using devm?
>
> > +     writel(0, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
> > +     if (geth->freeq_ring)
> > +             geth_cleanup_freeq(geth);
>
> gemini_ethernet_remove() is supposed to do the opposite of
> gemini_ethernet_probe(). What is the opposite of geth_cleanup_freeq()?
> Where is it called in gemini_ethernet_probe()?
>
>         Andrew
