Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFA5558201
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 15:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881139; cv=pass; b=F3neKxMt7+Ff0bUodGoVZgXoTuAPheaktkcijxxUK5bPghcY3/SWO+XazUwtuBKiC9g9k5nIZoFjHqavY12hvICUzgnsMYPR9rLbV243W9H69sgKLSbtrIRqbSlMx7po1dOBMzOEapEdLkOHuCfOF5bWlDS/3YJMSrihhF/X9GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881139; c=relaxed/simple;
	bh=t8WImo7+n9dGHNNYXwp0YcVyTAGR3nfBD1HSrw1H4DE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qkJCWb3L4WQ2z0ApZtzogcj1XzJI/HOYfjUuMDLlZYxX779iurMiTy8gJwG7JnB9iZRSGk6yhsHBEkBvqD17MtLKAbCV+b0AiA8Gtm+Q2u2EUVvJz0VgNVzh+UVeIwvQ9KN7kF1BN3lGtRAx75uguEp0ApTwNeFy385Vnu2mGOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=Ep4K5zJr; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="Ep4K5zJr"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-867a943b149so72955027b3.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 08:25:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788881132; cv=none;
        d=google.com; s=arc-20260327;
        b=KUgJl8yuS1mAe0E8NDuDBhmr7mqJ2w7WpYJ7bznREGE0BuTs3uwEEr5cDOsEcdvPb3
         MB0WDhZqgso6+OgvdJZgS1sJsVWk/89i4C+vhAzCaC3OanLVZjpAyuKsBSJAe28n0/qd
         eb0mu3apq3+RyqYR41MlLXl6eksmPtT0Ac5N0GKvZIR2aj8u3THNeRv2bHD/PjFPNACG
         zVxq9KiRlxGgdFx8CYrTVrQ8/1n5H4YTxviZAyBaGDvcIMBk38umWsSwJ+WlSRxpwb8E
         VDeTUF8/oPalv0FjlldqCGD8rnKc3ewFzwQA+x2d3kqjvcOLSl5ZE4UnhuVsKmfp2T/C
         NhWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RwEMdhR+FDlWteOIcA0A0fiMGSIsY8o0hBxKa8vWjn4=;
        fh=XC4/h6qn3vySoxvoX6j6bunf0mZ4SIS6Hu17N5QD1Eo=;
        b=R7t079M9eAeF4LZvdxUEHtT1vjoC78p7bYoQgg6lrA34PfpmrrHefDUKnXYrCf1UZr
         B7d5Ptzlsnmr7gszVe422/Few7IWOIRzbI/pOojKaJr+NJnJxaHsx4xDUE9Ko0RuwrwA
         zmuzfd+aN+G7QhKV8jZIC4ybV5Xi6loNIK24ZUf5cHB8J9fSwDfP4T2tIJ0sS9H+MVPN
         jnoGKpDNS0QVZBS4cNWmi2b80U/J9hgWci/gV5T9s6v6TFN8NDpbsEgYo7KAaIa4m8OD
         WgjZz8DKBW4NtNmiluK5iXcDYP5c0W026xsO2d/T5HyV56MPmNAuULlCtHkr1BIUZi8J
         XbkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1788881132; x=1789485932; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RwEMdhR+FDlWteOIcA0A0fiMGSIsY8o0hBxKa8vWjn4=;
        b=Ep4K5zJrgqeywwGudHXAJoGRwWe1rx+4tlaK+D8EIvNrRAHzH7Rli5rtu/rfBvqWbA
         vqqEyQsJNNH/SF5NfIahTFM153sLAruHrQ79lQP836IzzF922nwlgQR1+J9jjsDga15I
         S2Z6IQYiDiI2T23vs2c8r26S9ozfWHh7T0+WOGmbx1Ia6Ud1mPaHkhb+D77tphm8NWeg
         5yNayhkdzP5ok8afn25YG4Ow/ILgG7V40y+K2xynsAQUGXuJwxjsbIHl+Eq2KLwHxoOI
         zaOs9zMVnKrfQ22OyX6FaZ9ZdehYD6EdOtE3wkvcmYzyCX2iPICIf3I2qGcYyR8BmEZw
         F6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788881132; x=1789485932;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RwEMdhR+FDlWteOIcA0A0fiMGSIsY8o0hBxKa8vWjn4=;
        b=nqK2+hl2C713Z6J0DsGKpdNjoz2NSjhY4jGhT3Jme8noWkTs41CQszMfInKGl2IHWE
         WLYk+QKthmX5vW6juPWppwV3gi3dx2lUZi8Y2EKQIOi3NspKYAeKbn3MTQgck4HCEQsY
         qAi55BgI460h7SUq4wahunqZCq3Ou+SOsoXnczsVZ80LEX0DxzvLLCHHbfwFWXWPCEEP
         UdzNl0ol6IL2bWoOiLsS4NCa3sFNnKVqiQmFwTfPvrMInYwcBpjf/DQlMJVaWc0kkvWz
         eQFBRMjOjvSF1AcP4KTuQDQpvARLGMtU6XNY5nDidm0Ti/jUcROYkFi/Z2tM8qvyAdCF
         T9Jg==
X-Forwarded-Encrypted: i=1; AKwUvBzBy65iwUToFGXGQfUzwBp62CTEHEooFfV2uUHF1s5wuvfgaBCBFTNMn4+6vWvg3RMWCbdgBuk=@vger.kernel.org
X-Gm-Message-State: AFuF++nygncYc0V9RnOHWnVbKCuocM/8Vvbql64l3XKzPCFW9mLqZreP
	i0FNA4dbM3qpw9w7oB2bjyoLvFmXlkrKrZxDRAUIQ0FXP0dHX0ui/CQXLvtn4AtuGIgn3OhgA8a
	Y09hal69+2pAu8vyI9xIr+Ghi4eVsD13NxmVtNpHY
X-Gm-Gg: AYBFou3ghlJgKdgWQa4d4qFU2muUCD8+0RNvsMHVvB66r+OjM1VuBjcgCr3DUfzfdlg
	FKs20d9/eQnyeSSSDoelOgdQC1UldlPM9gLxNc0UGfFx90L2g9any7wwMO9x0JfSsHjbfr6+shE
	OoG7zrSsos1XfCInjCrdLW4MqDm9z7P8J/eZxIgEp7gmNzjPQMi47OGqWrCZN6nAjgn9X9hty4g
	C5zdwgTrsPApZ7oFh4elYascZTHmkbAUgCq7l4UIBAI9ygreBTrUFqSimupI+x+doH22/3U5Qwy
	ueMjzC5s+RqTUj/OukeILJmv09dcWlbqdGa6LlFNuVTv7KqQMjQmugdg1v6N9KGIYTE0hSAC+2T
	Oaf4Jp01B+3ycG8c0go9p7M/KnZYAMEapsmOvNLbkQRVBcRB0XsuONOPX7UrM5oRW4EdOdKJ7N0
	X67vFXJiynKwtDihQKm0fc6CSYPaYRlLQSlfOOHmyz+0+TujKcJC7Q5BR7Txpex3nZwMa2wr85j
	C4FBGJzAqSBrDzWknCR3ika88WHC/GVqQSNgi/vNUy/lKUdjFhZv+mMCYb7+7x5EHCr9K3OMqzK
	pg==
X-Received: by 2002:a53:ac95:0:b0:668:43f8:a83a with SMTP id
 956f58d0204a3-66fc1b62c21mr6813732d50.15.1788881131797; Tue, 08 Sep 2026
 08:25:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904092719.534318-1-julius@bairaktaris.de> <20260904182346.2940a049@kernel.org>
In-Reply-To: <20260904182346.2940a049@kernel.org>
From: Julius Bairaktaris <julius@bairaktaris.de>
Date: Tue, 8 Sep 2026 15:24:56 +0000
X-Gm-Features: AcwNN1Uxb4FTuLJKMrbi2XtU7zrpLGVjqqtccUjPX_JwkWYzN9-bh9N8pzPGpN8
Message-ID: <CAC1t37KdqVbSuKy5yR2OwKKTMDbQGNGzev_nHyhcndBKc3zFhg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: dsa: offer a flowtable to the switch
 before the conduit
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>
Content-Type: text/plain; charset="UTF-8"

Understood. Thanks!

Julius

Am Sa., 5. Sept. 2026 um 01:23 Uhr schrieb Jakub Kicinski <kuba@kernel.org>:
>
> On Fri,  4 Sep 2026 11:27:18 +0200 Julius Bairaktaris wrote:
> > Tested on IPQ8074 with an out-of-tree DSA switch driver that handles
> > TC_SETUP_FT (openwrt/openwrt#24806): three flowtable unbind/bind cycles,
> > hardware offload of routed flows after each.
>
> We don't accept patches without an in-tree user.
