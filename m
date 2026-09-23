Received: from mail-ej2-f6.google.com (mail-ej2-f6.google.com [74.125.228.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444D451D538
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167251; cv=pass; b=pEu4qiSGbqlfk9Ez8nR3oM7RkcPa+ymPBDEK9837xV51A20jkI1wAYAATaX9HUSrdHswoiFuGyGR4HxscBYE6TZCzOElNQBrz+yPxTfw80Zj9V/14Q9BwA4J38z+Zd8Yv2o6HXRv2fMO+UEBdzZmvB4NYi0d3lHoIp/yO6pfBws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167251; c=relaxed/simple;
	bh=yrBXUqSfBJNVOGA4p1L4WG725TYm+nXRxrzQgFuRPz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pA8RzDDGdk+NjOQ1rbukakh2whMjL/79GKf43JP6Nf5SQgsyg1Y8p7bNlplu6qJQn1A6jqQsP8AttK2zo/6SvtHfjS/nVTWg5V3+pg+4lUe69STLLe7k+fJmcQbur5gjwI/nNOsHUTCyuecg7RniPwO/d50TDsqg69PlNg1k6T4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNVWlYwM; arc=pass smtp.client-ip=74.125.228.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNVWlYwM"
Received: by mail-ej2-f6.google.com with SMTP id a640c23a62f3a-c294716dbf3so53488766b.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 05:40:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790167245; cv=none;
        d=google.com; s=arc-20260327;
        b=mfMZJCJh31ezHHG7LOKy+8J8PJIqMoaj3AM2u52Z2bgRX1PhKLBVqV3K9eqfO9Wp0F
         hOU7Gha0CGZB1QV8+d6UvIuwOjY2ERrv5/s7Dzi0seNJvnRsmt52lxJ9BCk9wfAYOMur
         tkXFe+vuHmnJx508GIEcb0NszSeN7s+tIOYaFEIi5Pwjc7J7fT42InPRnbhXAWHrAtAx
         2cYR1UcPxQlhz3qzA9o3tdhBui+2rwn1Hmqk6mw5hFsBGyB5dGNgJmZ86hOOYRh6YVvi
         8+zAOvuzTqAH1ljSoR7sfo5SIVW/pc/9JL7IaleEhZ10pRF+ppXK69/Mc0TeqtoHYcMm
         RHeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yrBXUqSfBJNVOGA4p1L4WG725TYm+nXRxrzQgFuRPz4=;
        fh=IFbCAgqn1pujqNlFr/u1K/o+X0mxU8aY9PGB94h/M+c=;
        b=ArL5Ku/l4WPLo1h2yusc6w6v0PsLbHiIjJx7vGnMRFqW9pNQDOQRXpuww8U0t1BCCy
         YrEI5Y2pLw6Gt9SIAuv27oJ6KIWJHULBFNJgYQ3oFysgT5q6WPctEGysicxU0DMDRZk1
         gIXwPLr9YWysLCApo9VYqs4hxqC3rFUCs4R93raW0RDY39lyDdF6qgmZY0N3DlvkuRI/
         NeGcM9R0XS3vnWuH1hdHqQNefy32yneKfJFAJH/2b9t8+RGKt04wzvTbCWrZgBzhAkF7
         hTqRY1iTPVUAK6qZhwgQArkV7lv8cCeMETjCPH54AS4o+h7ZAY2uryV8h6CxHcXPQvmJ
         d4cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790167245; x=1790772045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yrBXUqSfBJNVOGA4p1L4WG725TYm+nXRxrzQgFuRPz4=;
        b=mNVWlYwMzpZ6XdVh6gnhcylaxl51TIH99pMipEXYbsjdb6U3HyDy+7+Mux+yYlrY8n
         tAMNUR3OZJ2T4gS4BafREQ5OIUX179JKOOByjFTUWb8R5/hcungUbho65yJ4rV/SNOhP
         0ajiuf9kM2THHOfOP+UFYk0R0vS3RM3arQ3y/MaID/B9K1FSPa8TKjGBrYfgZniYWZ8Y
         WOBi9fi7Eem04EN4bjBeAa+WDy8b939piz+ce1gfpLa7MgQ/nRFJtIS/46LlwWKn7uca
         pALtLSEcy8N93BTGd2Vd9A/JGwiFYL4DGiLmkCbK3sCoDr14KK22yikj5r6/1s3poe+p
         AiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790167245; x=1790772045;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yrBXUqSfBJNVOGA4p1L4WG725TYm+nXRxrzQgFuRPz4=;
        b=eFVhlQ240U+n9e2fMOlN59j9KkhYBZIycfGaVKMPfnQT++PdaMQKji9OXypEE9xP8s
         KRgLB/X+4XB1W/oT2Rwlhydgh9b97vZTKYGRrsm0jPSIDFnpFB4c8BswULgm826FE9T1
         znFmblaOda/S5VwVlukm1wFzj5YauvXTEs6UW9TKHjMZhilPXyxhwt8gtt9lTt/eOc5N
         k48eEWSaAzvk/5VK/EDIGDH8PNg8fsbGVCNU+LYYRt+f+kCQWKH68WNxB8Uu+zBuIGyZ
         z5iLqXdz+zn0t60/Rmtr5Wbb7pOxsgo/DLzEPhlrOgbPLwL/rQo0fT2va1JB6x41bjTs
         G7JQ==
X-Forwarded-Encrypted: i=1; AKwUvBw252wOFGb1BNSlFvJ9mqzc6K0/yh65tG/oO9ldHyEelEwNrLPTL+uxP77HUYu+QtPKah3tj/0=@vger.kernel.org
X-Gm-Message-State: AFuF++nEic9d1mZJUe/CRGzn0RRVNwd9+qPP6hjf/YN7b6tfMXqxAHlK
	JjMbxcyIrTk7Ek921QAlJhB3utvIf+yFgJyQAHqWqFJ+k0i7w/EPfcTxVyUQUIRn6HLZDAz/8tk
	fxxvLhbRpGujzYw1usgNbxxe+0Yp2bX8=
X-Gm-Gg: AYBFou0yQpQvf7gtqY/1ugsmtiNWCjw8qVttLCxsnMvZHNhyz1GoS5m24wvSQiKHCso
	jxnTA98yreodauap6Ia0y3CxqxeN0a9+nrjySEKffbm6N6JdwJCee7I0taWY7sCf6adp2jVUlnP
	u9J6+L7MA8mrm88MbCfdHIbyHSnvgWA18LSgElfnHfMH60Aib4wdG+dcpLuFeM/kr/p6TAbwPut
	6lgBsYaLv9drRFxqn2JhG1yff7lpyJasxk8QveN3/p7vliC0C/u8lr/RwZSfZzTz03aCxLDM0uG
	U/rBnz9egWy+2Mgkjuah1b9vHL2haqJcG0KWWGv0dN5OsA3Q1DSGqbkV+A==
X-Received: by 2002:a17:907:d91:b0:c25:5faf:b207 with SMTP id
 a640c23a62f3a-c2aadcf4484mr194861466b.3.1790167245181; Wed, 23 Sep 2026
 05:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922200336.2201212-1-coiaprant@gmail.com> <20260922195006.79890f24@kernel.org>
In-Reply-To: <20260922195006.79890f24@kernel.org>
From: Coia Prant <coiaprant@gmail.com>
Date: Wed, 23 Sep 2026 20:40:33 +0800
X-Gm-Features: AclHuK-io9PS85iIjo2RRKD7nlxq4FY18LSW8xzP9gnGJLLZJesN4MppzV2qPUE
Message-ID: <CALj3r0hH6m7jUEweKMWGmCW9aOxShaqsV0E+z4ztBhXbJ+378w@mail.gmail.com>
Subject: Re: [PATCH net-next v10 00/11] net: pcs: add basic support for RK3568 XPCS
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Romain Gantois <romain.gantois@bootlin.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Shawn Lin <shawn.lin@rock-chips.com>, David Heidelberg <david@ixit.cz>, netdev@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=8823=E6=97=
=A5=E5=91=A8=E4=B8=89 10:50=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 23 Sep 2026 04:03:24 +0800 Coia Prant wrote:
> > This series adds proper SGMII support for the Rockchip RK3568 SoC
> > using the integrated Synopsys DesignWare XPCS, along with necessary
> > fixes and refactoring in the stmmac core and XPCS driver.
>
> Please slow down with the reposts.
> Not more than 2 a week, and please wait for the AI review to finish
> and be published before you repost.

Understood, sorry for the noise. I'll keep reposts within the limit and
wait for the AI review to be published before reposting from now on.

Coia
