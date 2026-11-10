Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.228.135
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794326257;
	b=KHFCGaOsU9kmXzBbvUDhMpbX1YUI7E8p57M8e9SmT2iPu0kH6Nh0b2UFQiG7y9+1dGIf
	 q3ldKiH9IqIhsBy0Qx2O20SgsY8F7huQZ2iGqN430R/1M9BcikiRAiCm5H+JKjOUmOYR2
	 YovKHvtYcjryFzrzUDHIVGXOT0Rh0EcALFgIdpCJsIvlBXuHTfGPYf+QiUy7Ka0/P3Iml
	 XGmLbmQr4uSomYTOcL91scFdhJCRR+LvOdXXhvLhbO8d/MHJZ83KI+0EMou3HdoUAu5Fn
	 uCxZCEfmFMjfz2OXwnDGqxv+Y5K4hclrLrZiM42uVgl3FeP+KmdYBt5t53fNArG3sVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326257;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AqOIoaAagfF8f+5anLVjn5ybzEQ34T4RWG7tiFaGW54=;
	b=t4qWpyzIy9Y3dnD+Wp7/VlXI3M426DmS95EZBellEiCJ56Q4YbrZqg6ZfHpkYDePDFuZ
	 1oYTIpeMKu3jt9zIBWIiupuz98qWsGPJz6f6xWGQujsP930SjDbuKT1fOIgW6Vh3LG9T6
	 +NOEU882b5V5Df/tEQjwZaooGWkM2qKTgV28dMY9KUosFSgYzNEufeGqXWxo7Pn8TiCfg
	 lXrnuW2ATVjZtgZCn8l5wSs1LkSlrEN+c6YEYk/bwBq2NAeDinBr9+ZMbWeC4hDtoBSpz
	 amnG3V0rCNOg6WLHy4aAdy1GfYimvexLo7HH/iJtZwL3ZRwl0w3WkTlQnC71DGRyUgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wSOQpBSt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.228.135
Received: from mail-ej2-f7.google.com (mail-ej2-f7.google.com [74.125.228.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E169A606A326
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E169A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wSOQpBSt
Received: by mail-ej2-f7.google.com with SMTP id a640c23a62f3a-c505c42e4ecso31913566b.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 07:57:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794326255; cv=none;
        d=google.com; s=arc-20260327;
        b=YYxtcx/jAikcoZVCPWXGHlz8FYxCP+NGem7Eum19RXATG06v6+F82FtjhQymh6tMM2
         NgSDrH0If3Q5ZY0IMVc1sU83+pK2LN37FQVXADHKgRuEspD2yREJoJeiP+ht2pXL5DrM
         t9eFVoyG/xJ4H6dqBFDcXEDTu6bzMJLHZyJRrNeF6lTxFCIoEBR2kr8ikqrCqGPNL6eW
         IVPcl0Y0EoqhPjVxHVrxcEwoQR47UnTw8iRPDVMTb39OpZjRM/PHtiFN5aHpr5lL//3X
         9Dm+tCBI6wQIfeqFzH/G2foHBhHNGl0Dm0cjcDnIheyU6OJHJGbuFS07tz04JKV6H+cH
         BzGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AqOIoaAagfF8f+5anLVjn5ybzEQ34T4RWG7tiFaGW54=;
        fh=Xl+o5jDNQlhZHIB8JNDYX/xD3YXINkWiNOunA1sDMXo=;
        b=RFWzlp+k1RgSk+HYZU+42CmqhQgfe4XMM8sJWo1mxZVll/BngtsuSMRxEzAt58n2xX
         YwZdHYaKgldmjRQ7pzdgkMe6RllMs63eWWUZk3eQgln9pthJ1pkMdXXWUBDKsvUwN13+
         LMISLhPrZSNWh3EI6L8Mmzt+JVgwkxuPCqVLeFAie8LlOQfDJxJZQGAyeuHP+eGMiZvQ
         W1kL0vwPRiB5cfpKSYrww2ordGynd3fwJgRVlNr0q7YpWF73EPLyYe8QE+z8kcdzhOnd
         5XLQe+wzd2uzGj7+sc8Gfzc5cWMMTXvnw6+MjRhHhKNiAWW9rN0+8kWaMZHhAZLbGYGs
         vIQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794326255; x=1794931055; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AqOIoaAagfF8f+5anLVjn5ybzEQ34T4RWG7tiFaGW54=;
        b=wSOQpBStCUApCy7WJpLLQG5A99C+sWei/oRKlu/GydyS1WNk+UJ86gb8atryq23src
         aPSg5bmOVbddSnXQfvymNjhtEpawuribD3vlA+xkOU42fFpoOjzJJITnvPGVS/wOqsY8
         KEBW5XjvpM8RobxWFMZUh0RypjQiKYZA5ZBbDhPyGqUER6i2uGcyg41bCI7smZVrOm3B
         DU1TmPtRCb2lOi+jPU1cvB/Bu2HOzfkLxWpLznt9h3UGY9PW/LqkK1PpXwKbUiMfIYoU
         3xj2jCwkvF34fGQLH4eQszfsaalN27A4XuqXMWnxscReXNDpJwJz7VVTtVeEMkQ0eSKl
         UFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794326255; x=1794931055;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AqOIoaAagfF8f+5anLVjn5ybzEQ34T4RWG7tiFaGW54=;
        b=nmrg81yLr9VCDmqSSFpY9csGiWM7R+6zYYSb7z/OqbWJNA/2pclgn/xfrkp5hKOmZW
         pYkXKxs6fC7AUgKnOxAAYlle999k5mggEa9khcFS0EQS/3e9DMoPfJg0HE3Yj89q2FRq
         D4ZS7tzppfy00D8pr7/jtJvMFZeHOXP57YlVTfW5axBANQx0+DWbm2+C6tMUbD2RA06U
         gK4jBBgtIb6EgFVxbbfzPYja43OPh2YaBYKLtZT2Yf73fr+/FogKa0Zn79Y3uWe2WG2o
         aYlLPP8HBR75+ZF5DrTOFB9kFxsoqV+6u7SJ7YTtcOJVjX08JT0hemQTbFbB8QpqFs9N
         JdbQ==
X-Forwarded-Encrypted: i=1; AL+hErFwf7ZyMqHXkRwpGszNK8Ig2DiRqXeHBo4L7eJhKSlZ4ge3HiOu6Gi5kBbOfSdp/0TqEUvyh5s=@vger.kernel.org
X-Gm-Message-State: APuU4Z8fI0rqBhQ6qsZYLJ6EKvAt7S5O0VUKH0E9TrL1teGx0f2eXdbB
	QLMX9X8Lr6WAHvyeLrb6LSD4uO9E533i/eFuwgt+K9cQBZwmUly9U1jVMd143D3Iw9REESBfsQE
	liYWU5DoXy2q4+UPptW0RSBxnfN6km9U=
X-Gm-Gg: AYBFou1KYfpRlZur6EImMR4bl3YWDjFV3J+bXp+enz3k+KwywxlxKSpxryL3vayo1f5
	6SmlcXUOT6VvTPbcps+F4f0hrbOrEiG0hrLmXssmy7BLh4hWMXf9jmuV2OoGo60tUWLhntYEeuF
	JjvDDzRxFrhLf9C0QgShklSJk8Av6TIAxa4nRiHU/mMVWeyk9eBaxxT8xg1pwYTYFhB9waNw6LI
	ZyQswANH86NcQM3fgOrblwa1+3LZ59m88SxSkubCUQwRx4q/RqLXGmM7LaMobVjfqHCGjHMbBCm
	nX1zSiWVb/UG4Ksd2nMu+MAWO42SBWH0CRbpmAQEKAgRHu7nPZgRolPRhjK2ub5TzSSu+tKaJut
	KZvOuIRyAaZaNsbePUD0C8Sj9nCLo/u+BHAaPTEG48pWvCr8Q/7wYK2ITf2uwcsXPbWStBI2/
X-Received: by 2002:a17:906:f58d:b0:c46:7ec3:fdfc with SMTP id
 a640c23a62f3a-c5049655093mr330817366b.34.1794326255020; Tue, 10 Nov 2026
 07:57:35 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102212506.3348537-1-coiaprant@gmail.com> <20261102212506.3348537-4-coiaprant@gmail.com>
 <1754e4c8-3b6e-4983-a7fb-d3444c1156c1@redhat.com>
In-Reply-To: <1754e4c8-3b6e-4983-a7fb-d3444c1156c1@redhat.com>
From: Coia Prant <coiaprant@gmail.com>
Date: Tue, 10 Nov 2026 23:57:21 +0800
X-Gm-Features: AclHuK8jzcDwnWHZT9BxNPqc1Y_PBqiAP6DVGP8roGJ07xtaPAuYBnsbVsZu0DY
Message-ID: <CALj3r0h5yTq41tQnGo4ECCmoAx5_2B7VFkYq62aA8e+qjKJ0tA@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] net: pcs: xpcs: make supported_interfaces authoritative
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiawen Wu <jiawenwu@trustnetic.com>, 
	Mengyuan Lou <mengyuanlou@net-swift.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Heiko Stuebner <heiko@sntech.de>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
	Fabio Baltieri <fabio.baltieri@gmail.com>, netdev@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2026=E5=B9=B411=E6=9C=8810=E6=97=
=A5=E5=91=A8=E4=BA=8C 22:41=E5=86=99=E9=81=93=EF=BC=9A
>
> On 11/2/26 22:25, Coia Prant wrote:
> > diff --git a/drivers/net/pcs/pcs-xpcs-rk.c b/drivers/net/pcs/pcs-xpcs-r=
k.c
> > index 6f0a110e32d2..25fdc9c6b72c 100644
> > --- a/drivers/net/pcs/pcs-xpcs-rk.c
> > +++ b/drivers/net/pcs/pcs-xpcs-rk.c
> > @@ -483,6 +483,7 @@ struct dw_xpcs *xpcs_rk_create(struct device *dev, =
struct device_node *pcs, int
> >       struct platform_device *pdev;
> >       struct dw_xpcs_rk *pxpcs;
> >       struct dw_xpcs *xpcs;
> > +     DECLARE_PHY_INTERFACE_MASK_ZERO(supported_interfaces);
>
> Please respect the reverse christmas tree order above.
>
> >
> >       if (!of_device_is_available(pcs))
> >               return ERR_PTR(-ENODEV);
> > @@ -536,6 +537,15 @@ struct dw_xpcs *xpcs_rk_create(struct device *dev,=
 struct device_node *pcs, int
> >               return xpcs;
> >       }
> >
> > +     /*
> > +      * The RK3568 XPCS supports 1000BASE-X, SGMII and QSGMII.
> > +      */
> > +     __set_bit(PHY_INTERFACE_MODE_1000BASEX, supported_interfaces);
> > +     __set_bit(PHY_INTERFACE_MODE_SGMII, supported_interfaces);
> > +     __set_bit(PHY_INTERFACE_MODE_QSGMII, supported_interfaces);
>
> Sashiko thinks this last statement is a no op:
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102212506.334853=
7-1-coiaprant@gmail.com
>
> I don't think this is 'net' material, I suggest resubmitting for
> net-next.
>
> /P

Hi Paolo,

Thanks for the review.

1. Reverse Christmas tree: My bad, I will move the
   `DECLARE_PHY_INTERFACE_MASK_ZERO` declaration to the top of the
   function to comply with the variable ordering.

2. QSGMII no-op: Sashiko is right, it is currently a no-op. The core's
   compat table does not have an entry for QSGMII, so the intersection
   (phy_interface_and) filters it out. This actually demonstrates the
   intended behavior perfectly: the glue reports what the hardware can
   do, and the core filters it based on what it actually supports. If
   the core adds QSGMII support in the future, the glue will
   automatically pick it up. I'll add a brief note in the commit
   message to clarify this.

3. Tree selection: Understood. I will rebase and resubmit the series
   for net-next.

Coia
