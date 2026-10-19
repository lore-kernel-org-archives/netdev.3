Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EB139B978
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 03:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792379459; cv=pass; b=ZY+XUvcIM7KLW1ge5rtW/MuMsFaSOcOmvkfKFn/VSAgKwOPPKXmJEeqjbYhb/PuJwVD98HgXnJFByUo0IBpdhxsbzSFyEtkbqUWjOBl4t9tDS6UQYnU9hm1zxMQd29xrYl+3dS7AIcEVkXYScJReM61GKxcNvsasL7RwdxLes3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792379459; c=relaxed/simple;
	bh=W/do4ufGZmyJubV8mrWLlpUR5HQ6dCXEm9qT/xlG430=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ns0l1Qe6cfdc3qt5YCXSQEVVCNa6MarVVka56EVGd1+Lfn4MqU6DTS/gc8GoZp+X2YxFkoNGiCfukrFzdSt05dVN+5/9Govvp4/olglnM+chhzobA0pXLC209cl5+CcLyMWsQaSb9Xj2MNHFNpLiARZMmeTigFCPyRoLw+VJxXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFdxDNgE; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFdxDNgE"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c37b612635bso179782066b.3
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 20:10:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792379456; cv=none;
        d=google.com; s=arc-20260327;
        b=Rmpe58lJhK3NNfOg+g7XBh87NDCgLI9BdUzy/b9hpCLpjwyVDkd7A+moLf4UZ0dnD1
         W61Uu6QPYc6LZm2BqAjUPrfIpnrXTqJ7O4qmcMTdwkZvwaXj0K0E9UYcpw/hzQRekDs9
         pBNEN4Ck2UzsGlQVT3nZriDvAiC9zeqSMD4h/OdXKIguFWKBaFh8q81oBg/a/6Cst2MH
         Qau/V0f5J4LJI2JlnDz5AgMuSJhnUyGYKDOVhGk2FTxtQVVxbRMFT1cmUrl/AybTOXhj
         RS9M12Penx6Vy3xOo5HqWI00LVhiL5n6p7wUZBE2SjZFwGz217FlRMKPURsiWjdKDKIK
         uVRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DVIn5xWahvpEVm1vWXeV49buHbgWSkhF2r69LY7fqZU=;
        fh=sChM9IEMnvMQFeKRnKqwyNWU0/dFqIMAWEJcRFnQQYw=;
        b=TTTimQcoinm62EIy+Kdp2exMqSpZpqQDieW514Q4W9ON5Q0trTR6BFJiicVkax3Tx3
         mqhnfXoE0g48rYhpryeCesXfKocNej6tSf60Wp3S4LJJwTucaNKypx+GNTOYIFrvh84K
         Aa6S02Ta1WapEXDVVgU6V+Ox5VrRN1yGKSkNB0LcffEO55DH/oDfnECNdt+3rw7S9eGn
         Zqj8ptChkUE18pgM7BjqvCoiNnXA3cqHo4AGYJpGsCu/InLg5xwfgTkZQcGvDHG2sV0N
         r9/OidfURy4YFKTRRuxDmciTZ6yKSCC27ibP+Y/6ty0lCN6Yz3P9pM2v5umIvEVAlREs
         bucg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792379456; x=1792984256; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DVIn5xWahvpEVm1vWXeV49buHbgWSkhF2r69LY7fqZU=;
        b=bFdxDNgEzPapZpwhH0yIIPGLGf+CB5LSO3ZKzCAqWR3uxupPHHSYqL2jKvVrDhSByk
         F9Apbbx3L7lNwOh653DI2SaK4QeHoK/v3DR/NRe2OLcfDStumhaavHbS2drwJlrBPHVe
         +IXdpvU3QG/WGHdeWrTcjSNYV/PR6dTWBgeMsVqesyydlVjXNE5Po9mR1g602+mo7ZgQ
         NJQ4+sdeFTj93DsmEuBLt/IxlYv3J9YOMijb97X5k40fdokaBA9zPYx8Gt+HAXDx3/7y
         pdJ2c07Vw95Tqd6VAVoglW4uhnBehcRiiaZJTA2wBaZjlP8dLtlZnSoY4oB5TEp0CstN
         o1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792379456; x=1792984256;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DVIn5xWahvpEVm1vWXeV49buHbgWSkhF2r69LY7fqZU=;
        b=tRaSN+/4hFBvn4jIr15kQZ0c7ZeVv6LC8/rh7bZooUPqyKJGi5tCluPCp3zf6qmyKT
         x9o+1/BWgmWVvxOoqWo1QfR4Ik1nrZAH5GTBg9L+lYtYB4Kk2BVK5JpdLW+t0t+JVjpw
         swE1CoNBLieBGllAWyvf0VpGCkNBZ1iZz+XqV9EIpqAPKFbpkBkIq0llgJOjmgRr6f2M
         EJZhqV524r6G5Egg8q4DWjNE5+pmH/dVFOd7mdnG1hGH34UFcgwBLfXbD5acJFGmbCZN
         JNQmv5Sa88Xe+0lHCl4uTAixCHHmQSUFvK1MjCBV5OogHr+CzvFOyfsJACOdbn6UTVAZ
         WG3w==
X-Forwarded-Encrypted: i=1; AKwUvBysWr7U7/hX0BeAmlBIdjklax8s7HE0hcZDfTj/onWKL2KvLc5m9I9bJ7HWkLNNcgGkQkix+XE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLa8F5lQxGODhQeNjNO6E4hnFeVs/DIdhStWSJy+offAXnod6U2
	USwRUDN3lhqCFiG/SmU1oR8RsHMgGw2+gCsHlguGUB3rqguRM1JUMMgn3kUwWbxUv8xFhN7t8Y+
	9QRLhYZXS+584yILhDV1D8UuwGUUhJlI=
X-Gm-Gg: AYBFou11qmfjc6Bkf+BlR0c6WvF3TKhZg5rVthsecjTPQzV5mD563CIpU8MEhgIC5qH
	ZMBL/eAfIDs1c7WLRR01VNwwPFHQRO1zpQR0ahcrxZCB4Ntz1R7L5J5BF/gdmS3McplQzmauDdu
	KvAL3ObwGYCk4NFAo6q9H87ERztMNHEfYcE1c8MUvZ/MV0OIO6S2u8F8Ae77sNKgwBk7ErndYNg
	I5Ptuk4wlfLetEGjIFeHdw2wkaI+/MXUFxogA2ZMGDkloH7dzK0Haou5kvfAEPdYXKEccph4RSE
	pGJoIOpboewjPJinbkU8F/oK2FheUlCT57vwoCDwPJSOc24LsCrFZ6WE+N9fON5htu+iu5fs13x
	mqwTg8GvpRNo=
X-Received: by 2002:a17:907:944a:b0:c40:19dc:a24d with SMTP id
 a640c23a62f3a-c419e648fffmr481909366b.9.1792379455793; Sun, 18 Oct 2026
 20:10:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002115850.962676-1-o.rempel@pengutronix.de> <20261002115850.962676-5-o.rempel@pengutronix.de>
In-Reply-To: <20261002115850.962676-5-o.rempel@pengutronix.de>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 19 Oct 2026 00:10:43 -0300
X-Gm-Features: AclHuK8ySw8DCBHhhAXHU-iuM8DPw-3buzw6PIjkn5KwANrPKe7QCILiCb_PGDU
Message-ID: <CAJq09z7M9xANZ2cfYnGgi0VqGE6ppN-efKKMdN8CCXrhdN9VPg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 4/8] net: ieee8021q: add tt_to_pcp()
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Linus Walleij <linusw@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"

> +int ieee8021q_tt_to_pcp(enum ieee8021q_traffic_type tt)
> +{
> +       switch (tt) {
> +       case IEEE8021Q_TT_BK:
> +               return 1;
> +       case IEEE8021Q_TT_BE:
> +               return 0;
> +       case IEEE8021Q_TT_EE:
> +               return 2;
> +       case IEEE8021Q_TT_CA:
> +               return 3;
> +       case IEEE8021Q_TT_VI:
> +               return 4;
> +       case IEEE8021Q_TT_VO:
> +               return 5;
> +       case IEEE8021Q_TT_IC:
> +               return 6;
> +       case IEEE8021Q_TT_NC:
> +               return 7;
> +       case IEEE8021Q_TT_MAX:
> +               break;
> +       }
> +
> +       return -EINVAL;
> +}

Same comment here as on the previous helper: a lookup table would keep
both functions consistent and save about ~30 lines of code.

Best regards,

Luiz
