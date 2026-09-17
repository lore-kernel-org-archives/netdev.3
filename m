Received: from mail-ed2-f7.google.com (mail-ed2-f7.google.com [74.125.228.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3B53FFF94
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633278; cv=pass; b=GoC6pz0aap3qgy/PXreX0LVxSTzx6nZSxjsxmEIr0kR1u7il1y1DeIUC5n0GFhLWG0jx3vJTj0ZGTAd2ypIDYJwatvzaWimIplEZqNKlFKH4nhyKqPylDgbwXe0STJu7zISBhUuRQRo0gWZ2zNXowO4M21m0zA1JEOi7e+xpaps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633278; c=relaxed/simple;
	bh=Mt2nG22gQ2VlhRCDsFPAMB9fHywKLlkANeCXC+o2mY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJyHFISbiWipvG7wolqJve6eOJW62wy4x7LdVsLMIa1KFRrAK8aG1BEZtRAWdDjQj6CocTAl3Z95XkcEyB1eAuJohdG3KCBL5Y1roHHBsXCWGdHgft6FPS6hIBGUE4pziGAUbgv0J5Ip4TAU8lK7BDxRYQMqCR8WEYUvFS1pKYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkNgSj6j; arc=pass smtp.client-ip=74.125.228.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkNgSj6j"
Received: by mail-ed2-f7.google.com with SMTP id 4fb4d7f45d1cf-6aa44774ee2so8388a12.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 01:21:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789633275; cv=none;
        d=google.com; s=arc-20260327;
        b=VNw8ltx5O0A/YqTpP9IAYFQwEIYdeSYTMzjMgQK653rK2UtwiL9ZthkQ7ZreaaTIyG
         PzKztIJ/BGDPuvOAmzgOY3igNOe8qbjPrz+xihZSlWlHZqZXWdLjLcwcjyLd9rLuvTfs
         vhPf3rpBkbWsohCJ3Tvu3ZlF2xgCDUFcYUu+nHvcPrM1vzRvtgTeq55dW2kWQccc/XWb
         7ZEYs+JywNL9CeRYzTCNtmuVncxhfY7ydloq5H0aIds5r/mf0OnvbuZbAkhQNI4Zf+ci
         WLS3aDG2D5RWWK9OgtUMpTDDN4rAkyvt1PpQxlfn/pacKvqbKxc0RwMJzLQHe2Hncnya
         bYSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mt2nG22gQ2VlhRCDsFPAMB9fHywKLlkANeCXC+o2mY4=;
        fh=1IKvIUyt9sj6mmxym99qoVKF0t2PexA6JZeywJ0nZ7s=;
        b=H+t9lgA+Vo+cDlyW7vip8PyJIA8q2bGntDp+Fq5ClhU5a5degDlpQFuZ2XqcAKWbHS
         KkeBEP8SNK9Jna1AlWfv4UR3gBxpoVAgEFIl9OuYiXSag3RFljo4nlMss9noqCIa1Jig
         NP/hy7t7Pjvt2bYfgU3Z4qOW4RzxUf84rzaor2nktF3wOwGqLTCjuLDda9VMApjvsdLS
         DKPbUMGkxZRDB3zuPH/njA1ibJz4zsvf/AeEnTYcVnt56Bz/oCwGsbkbrhtkm9waZlnu
         UeT0Jou5gbzdtG3ytq8aGytPIjSQ62W6PNhoHTU/9vOEtH5clIj4LtZKZmYes5zRiN0u
         seuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789633275; x=1790238075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mt2nG22gQ2VlhRCDsFPAMB9fHywKLlkANeCXC+o2mY4=;
        b=LkNgSj6j1mh+t4RwWFqK0oZGmHByGzWfcY/zg1MYPjx1xJGUsm3Levzmg417PBZ/GX
         lS4n4bDiQ7tLC+iV/ptYNIlTQKgCmtD1qqq8DZwX9nwKvUybD/WxwuNLq4XlqOFraN6J
         e2pkajBHBVhw76hnQuSRkrcUSmYLUl2cuqQsGypWILVEmLEgyVf7iCYEaFBHfJOGlAVO
         OkhaajhhQu9KyE5sB+km8AUYGVWRbxEDjZUgMUXB26aVb+rynQUFpvOtQ6Q6gekDOdPp
         PhRf1Uhn6Mpea/EwRT/oMizBfmS2ibRJGktxgpXutOxCGzD+nfIksnWachRymFwffUsd
         RH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789633275; x=1790238075;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mt2nG22gQ2VlhRCDsFPAMB9fHywKLlkANeCXC+o2mY4=;
        b=gnUXBiX2SiKu65sL48WoD+zNio3pVLGHJeFfjSjKnczsTNXNxkl52ZE47uc5tizNax
         ByGTqTIP52AMsLRY+t9lOKeu89uFM9NW2LOYruh3sK09txii86JZ+Z1nOPLl5h3YwZop
         3QxPzN2kCNwWe/xtriIbqiZn90IfAx1CfX9ydmioEdGLw3I7sCi8piNuDxzcA1F7oo0X
         APZ0hUwhqJfDAqbampbrLoqyVhELK4nYWhef2tSAWQr0m5vIatrEtpmO39GaEHCIaJXq
         fvjEqr4YFPeh9sKhkztVsW+tgXp5Ye64jqYIC/yX0vutMSTiqkwkt0AFINUwofbULaVT
         eIMQ==
X-Forwarded-Encrypted: i=1; AKwUvBw8ftAMZaHPPnZRnoRHlmIkrFcMRN1xrscsPxGejAsUXgVwByS2Mdce3pW7GX5vSfW0VPd29mQ=@vger.kernel.org
X-Gm-Message-State: AFuF++n1d3hqrclRdbZQpW0lVAGi4q4sCD3P1m9MQQlVHotjZqT4c96t
	xS7zox1sEo7BRg3oGEj1JorWVzKmiJG64ELg7N1l6Qc7SvVP/qGm+HBwb6FbjscafkM1ZzIA8v3
	+CDnZa45GzcGEhgPIZn2zWo9xTh5C2rg=
X-Gm-Gg: AYBFou0a79ZStMHjapl6+jVr7bYQVygwiijoBIxxLraS0hP08wIcFI/ArI6xGoD3nTG
	Iq7WOBJWoDIsB0qufbkX5PLnf8RMtsMgEFfzFgOlJv1/EX0qEmEiRtEL46BxQu8b2Z2Cco+YXKe
	wu+xH4OQCm7Mxj3MyQvhst4lEhGc834wqiprL551wmxFprCNLuC3ceNwTO6fUZ5S3+Zj/GFdEPi
	rvqyaJwfj/o0+ghlLeinpcbxrg7/GHL9RgJnO+pmQCU554eQaEGos6rfHTnQED2KX2GbmPnqHmn
	RBfZskrHMk4CR3HfVVgX2IhApfLQcRAkwSCCjoIgHJ6lZjgslFAixl5Y8nqvWAcMp0Fw5g==
X-Received: by 2002:a17:907:3f11:b0:c25:35cd:fdb2 with SMTP id
 a640c23a62f3a-c29f526dd2dmr190379266b.7.1789633275095; Thu, 17 Sep 2026
 01:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CH3PR11MB8413FCBA598F7FABC04ADCFEE4B92@CH3PR11MB8413.namprd11.prod.outlook.com>
 <CH3PR11MB841353E5708DDD7C5E2EA1D5E4B92@CH3PR11MB8413.namprd11.prod.outlook.com>
 <aqqI9wOnradk9d7K@oss.qualcomm.com> <97924d2f-45f9-44d5-b482-97fcbb70abdc@bootlin.com>
 <CH3PR11MB8413131D50175690DF9FDAB0E4B82@CH3PR11MB8413.namprd11.prod.outlook.com>
 <3bdf2ecc-9dd1-428c-8841-36b1f19916e7@bootlin.com>
In-Reply-To: <3bdf2ecc-9dd1-428c-8841-36b1f19916e7@bootlin.com>
From: Coia Prant <coiaprant@gmail.com>
Date: Thu, 17 Sep 2026 16:21:03 +0800
X-Gm-Features: AcwNN1XL07xRu5XXN3J_i5sQYnNCkDU2pPnYaE7rXj6dGCxz8rSrRM8IV9aR83Q
Message-ID: <CALj3r0gXP0+bwsPVtuw=9RRQ6gpmuHzGc5PzF_a3XXXTTZYcqQ@mail.gmail.com>
Subject: Re: [PATCH net 2/2] net: stmmac: qcom-ethqos: advertise supported
 SerDes interfaces
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Thomas Karpiniec <tom.karpiniec@outlook.com>, 
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>, netdev@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Choong Yong Liang <yong.liang.choong@linux.intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Russell King <rmk+kernel@armlinux.org.uk>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Maxime Chevallier <maxime.chevallier@bootlin.com> =E4=BA=8E2026=E5=B9=B49=
=E6=9C=8817=E6=97=A5=E5=91=A8=E5=9B=9B 13:36=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Thomas,
>
> +Coia
>
> On 9/17/26 06:29, Thomas Karpiniec wrote:
>
> >> Can you test settung the STMMAC_FLAG_SERDES_SUPPORTS_2500M flag in
> >> dwmac-qcom-ethqos ?
> >
> > I can confirm that dma_cap.pcs =3D Y.
>
> Thanks for looking up :) This is a good start
>
> >
> > I tested setting STMMAC_FLAG_SERDES_SUPPORTS_2500M on hardware and unfo=
rtunately the flag alone doesn't solve the problem.
>
> Yeah, but it's still the right first move. Russell planned to do that as =
well :
>
> https://lore.kernel.org/netdev/E1vvDJi-0000000ArhH-3ipf@rmk-PC.armlinux.o=
rg.uk/#t
>
> >
> > I think there are a couple of things missing. stmmac_phylink_setup does=
n't use the integrated PCS bitmap to populate config->supported_interfaces,=
 so SGMII is still not advertised to phylink as a usable host interface. Al=
so stmmac_integrated_pcs_init is adding 1000BASE-X unconditionally, which w=
ouldn't be appropriate here.
>
> Ok so, the missing bit seems to be that priv->integrated_pcs isn't taken
> into account in stmmac_phylink_setup(). This needs to be added then :)
>
> Looks like there's also the inband support that needs addressing, that wa=
s
> part of his RFC here :
>
> https://lore.kernel.org/netdev/E1vvDJi-0000000ArhH-3ipf@rmk-PC.armlinux.o=
rg.uk/#t
>
> > I did a proof-of-concept fixing those things and the end result looks a=
 little messy: config->supported_interfaces could come from either get_inte=
rfaces _or_ the integrated PCS with unclear (to me) responsibility.
>
> There's only dwmac-intel, dwmac-spacemit and dwmac-rk that use the
> .get_interfaces() API. Let me add Coia in CC, as they're working
> on better PCS support specifically for Rockchip :
>
> https://lore.kernel.org/netdev/20260915123802.1561724-1-coiaprant@gmail.c=
om/
>
> For spacemit, looks like it's not really a problem as there's no PCS
> involved. For intel though, heh... Intel platforms with dwmac AND PCS
> are hard to come by, but I think at that point let's roll with the
> bitwise or'int of get_interfaces + pcs interfaces.
>
> > This POC did show that STMMAC_FLAG_SERDES_SUPPORTS_2500M enabled phylin=
k to configure the integrated PCS for 2500BASE-X and a 2.5 Gbps link came u=
p with no apparent issues.
>
> Maybe the blind spot is inband aneg. Mohd, you were quite involved in
> this, do you remember where we stand on that front ?
>
> Thanks,
>
> Maxime

Thanks for adding me.

For the Rockchip side, rk_get_interfaces() no longer needs to advertise
SGMII: stmmac_phylink_setup() already OR's the PCS's supported_interfaces
into config->supported_interfaces, and the XPCS driver provides SGMII
there. I'll drop the SGMII line from rk_get_interfaces() so RGMII ports
don't advertise SGMII unnecessarily.

On the qcom issue: the missing bit seems to be that
stmmac_phylink_setup() only looks at priv->hw->xpcs and
priv->hw->phylink_pcs, not priv->integrated_pcs. Extending the existing
OR to cover the integrated PCS would let qcom-ethqos work without a
new get_interfaces() callback.

Best,
Coia
