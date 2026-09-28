Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441BD48C412
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 10:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790591983; cv=pass; b=Pp9eXlJmAYXx7kPOyuc0UOQAjoABT3366AsGx9R3q7o5Nek11ADbbrT6GGgn0278E9VJiLjWpdoFTNZXoOog1w65Cx1GfPURHpvBVmyFd1RPrqKowc3atcazCQRFbzOAkqGXXfaJsfTvqWOaGQyGh3mqcIpsEM3155uLxB4LUac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790591983; c=relaxed/simple;
	bh=wurLFDsJrGYbU/K5pvPYQOlsK0YNqiwggLLlZpmX24Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eT5YW1ubXWUV4QysvHNtS+wyW5UPcp1Ofd/d8TwBRoAoXw0g4A20rufPcTnvMYOdmgwu83/R3TOj2s5tj2EISGT6FdPrJzC+tsvCWiKQg0exXcgYl2GRknZiURI3hRlfiXDpP/vCsbjMXtAqvSFVr4zX+V49Mn7+PVEMGB6YJCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=g4oLjruu; arc=pass smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="g4oLjruu"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc797656e44so744516a12.2
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 03:39:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790591981; cv=none;
        d=google.com; s=arc-20260327;
        b=HcHq0aV1JcfvS5lF4P7XXNsU75RvjuRiIralQew/nhTBxMQL5CncBvlXNBqCYkNhSH
         rRyI8tsTA21KU7NB+9kNT9b5tidAEomXEgLdTTZPlm2fAexvLli7jmAzMR200Orbc8Tt
         w3azUhBz16yU8jhsYfD/LQDZlcLuR+vxVVPI+0gIPtnA402J3HnBLTXqm/VSe0gXA2LH
         2JATimwW/zNo3CdXdYbtt+L3QZ6MPrJizzfeVfJnDoJVaAdBbZrlQN6IZ+rnffq1hwtn
         fZw79mCnoBfnKiWgMrmDgmZ+PCMf78tUHi65Ljd7ABH2ZHGWn7BRXwIoVGRZI9SPBb81
         0k+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4rcW83D0FgJqP/k3DifjhLl2F+5l3cQ4k1NrP9DKuhU=;
        fh=lXmoq1MrLQPjI9yfW2JAXgvahsBwl+pbwFP7/GJ0f7Y=;
        b=DwtgTbTK9EqUygXalllwXGBwRMyFH4k8IkpE2BZuWPfFkvUnr68V6H+GvHpg/3Ea0+
         AsDNOQexFpQg/CYKyYDoziidMZihUP3/aGYaJ2ErsbMZSWSDOmnaPuxfbcJVGBrFwiKh
         hHgjLFEdwHeNvthd+3LuvKLdHL19LNfUBZZ9zByf7Hqg2k0qlFdlhSQfO1gjDMrRyxZS
         HwoCrQYc1k1QULsSPnK/C92g9PaLJGAMQQdfl4HYAACR0CZI7GxDVZvhGUekiSY0lHAB
         bYgkcK2QVD+Hw12KgonZ7cNBzvDhEhpeomaW+LTrczOoUrSOvyU5wtHCrfqJxcigHUXp
         l+BA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1790591981; x=1791196781; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4rcW83D0FgJqP/k3DifjhLl2F+5l3cQ4k1NrP9DKuhU=;
        b=g4oLjruuZ9a11euMSMCP9veTSbRVyhWm99X6NFQSBeem6WiNVC+nBBU6bOqbnWI75i
         adUv4bGVoWVz04kyuG/0Zub1Rh58KZ3mYH5fJproQiBfysqfOvccVk/pyz7l0sNg93Vv
         fqqG1gM8/skH2Neqctg5lwgczrYL/4JUv5iAgHxCSBDjuHUvAs0LQgqJ8MW0kYee+kfF
         g6daocES0ADq91iYIjYIqV1TmnkeAabJblBYCdwXO8ToOZ1OZ/BrvxU3/rNfzACqRAyl
         zBWkQuNB4nYfwgb9KF1ygZb/sHm3RWrWDNrlt/tAofwGZpt/d3QtIlDGN64tKDFEzFL4
         pMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790591981; x=1791196781;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4rcW83D0FgJqP/k3DifjhLl2F+5l3cQ4k1NrP9DKuhU=;
        b=CObfi0u89+UVmwbKSzQavR6YBgl1MxKu5jldN50m+0j6YKNh3n6su+gLrwU+JoITQL
         foWisTak7rHRZxMgGKn8OSLPX5ScfL5m44Cd0xM4PtAkCuNVs/VIPrBgKNJ9xvWJipXz
         RV3/nk/DpVJPMx1yQaV37blWTjS8UbMqgzGGKiIElmV77Td5/MYLUfYbpduHZKhlZIoX
         89Ktjic8VaNzGPu0rDONFnCl0EQ8wKH+JVFg4aOiuTdlpRFP6E0TVPx8d2hmQRDllFaH
         P1WrKy5Rhws/Nbg6FV1O84QKGLjX2QoX3O1cVoyHC6IdgcJ5KFRqze5wBPjRr+DgMlP+
         pATQ==
X-Forwarded-Encrypted: i=1; AKwUvBw3yphzCUz58k4k2wOR+RgCuGBSwlyzXZlv8zWiJUpCk+aJYYxhhzVA68mdvU1RvJyCLKeWT/M=@vger.kernel.org
X-Gm-Message-State: AFq9FYL+AjFMhbQosV6mcZRQbKzwlF6xB0zM/hwbh9+ys6599eT1SYtp
	aVrJ/EMLn17yPszr1hE0d7ml5Bczec6UesdRhifUK0WuZn2vh7WxTIcSp68/W4N6UZCTuUadAk4
	nyjvomiZZBmGd6frdUxpQW71pMFOnxMZ1CIwP0d2tQw==
X-Gm-Gg: AYBFou1l8kXgOEX3B6wjZrdsPewDzp9WHKM/5enmNephPaKDlUmozOKasKmEuMyXj4g
	Jtzyp7fxSs/fqhTW8GRw+hFCe/hCocscuYI+N47RgkB2tbCsFUCDTW8eEVy8L7tmlkE3FqykUdU
	1kbD1sihAOHXZH/g6B7WlWxm/jilUqa/GgsOE+LfjvYd+OGudvlYSboBUk6veLDRQBR0Kr1kiTz
	sWEBSukP5l9j7dqn00Yg9dNU73EpPJn2XNbCDRABgCB8fwnAnCSLKfmEMR/AhiNRJzH1LItwsW2
	q+uSvpeyCIgNgkBOf8t9fffY5NYLmKdumB/W49qiEw2J7nyh4HfXImmaiUjdgUPH9+cIcYRSeGP
	I3I4GAGgzeMskSN0EjxO+vqYFhrLxATYVOyw=
X-Received: by 2002:a17:902:e952:b0:2df:950d:8f4a with SMTP id
 d9443c01a7336-2df950dbb74mr71445885ad.22.1790591981383; Mon, 28 Sep 2026
 03:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922125112.2111256-1-robert.marko@sartura.hr> <20260928091804.hjnabzi52kz4ktmf@DEN-DL-M70577>
In-Reply-To: <20260928091804.hjnabzi52kz4ktmf@DEN-DL-M70577>
From: Robert Marko <robert.marko@sartura.hr>
Date: Mon, 28 Sep 2026 12:39:30 +0200
X-Gm-Features: AclHuK-gDDCHfBtLac7JhmAB4p3Emj0wmBDLbCuTQrCHI_3_hiMQa7CF_cIXvSI
Message-ID: <CA+HBbNG2nGXpXC63AVUJX3KaqzJG+Q=-Md92eTpq7Y-O4CHMzg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: lan969x: correct RGMII port mapping index
To: Daniel Machon <daniel.machon@microchip.com>
Cc: UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	Steen.Hegelund@microchip.com, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 11:18=E2=80=AFAM Daniel Machon
<daniel.machon@microchip.com> wrote:
>
> Hi Robert,
>
> > Currently, the lan969x_port_dev_mapping does not check for RGMII ports
> > and just returns the physical port index.
> >
> > However, this does not work for RGMII ports as they have dedicated DEVR=
GMII
> > register space with an dedicated instance per RGMII port.
> >
> > So, check if requested port index is an RGMII port and return the corre=
ct
> > DEVRGMII index.
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> >  drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c b/=
drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
> > index f3a9c71bea36a..bf5320c7a6ca8 100644
> > --- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
> > +++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
> > @@ -142,6 +142,15 @@ static u32 lan969x_get_dev_mode_bit(struct sparx5 =
*sparx5, int port)
> >
> >  static u32 lan969x_port_dev_mapping(struct sparx5 *sparx5, int port)
> >  {
> > +       if (lan969x_port_is_rgmii(port)) {
> > +               switch (port) {
> > +               case 28:
> > +                       return 0;
> > +               case 29:
> > +                       return 1;
> > +               }
> > +       }
> > +
> >         if (lan969x_port_is_5g(port)) {
> >                 switch (port) {
> >                 case 9:
> > --
> > 2.55.0
> >
>
> The mapping itself is right, but as far as I can see nothing upstream
> uses the returned index to access DEVRGMII. Every caller of
> sparx5_port_dev_index() pairs it with sparx5_to_high_dev() or
> sparx5_to_pcs_dev(), which never return TARGET_DEVRGMII. Those paths
> are also never taken for RGMII ports. The code that does access
> DEVRGMII, in lan969x_rgmii.c, computes its own index with
> RGMII_PORT_IDX(). Sashiko, correctly points this out.
>
> So I don't think anything is broken today. Did you see a problem on
> hardware that this fixes?
>
> FYI, we carry the same change downstream. But there it was added together=
 with
> RGMII MTU support, which reads and writes DEVRGMII_MAC_MAXLEN_CFG() using=
 this
> index.

Hi Andrew,
As pointed out nothing yet is broken, hence no fixes tag.

I am using it downstream as well, for the MTU change support where as
you pointed out RGMII code
uses it to get the correct index.

So, I thought that it would be good idea to send it upstream before
eventually getting around to sending
the MTU change support as well.

Regards,
Robert

>
> /Daniel



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
