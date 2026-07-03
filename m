Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2349636E478
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783085089; cv=pass; b=T3QlYn1nuSC9PDVjDUPZ/8I2uOLfqgmWeXVr80oS9HcyOUG/cb914bzTcfN2gen3lnNiXOyEqPr+NnkqN6PX+BJjeAP7VElE3A+3ptUsMUPU4dPRr49k8GSY/aaBG1olN2AcUZV/CYm0XWhAYIG6mNO6ZVJ+3yORn3PNeNTC5G0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783085089; c=relaxed/simple;
	bh=MJ1/gQ0OliFG1mgC34pomyyIH4hLoJxUFFgoRgTmy3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjdjocoMlJMi+ej2tYAnYZHTYmbuZFRYJ8w8pXHTNf/0yLniDynU1NPumgOWTvYFOY4F5rFwevZ1a8i6Sc8LSSQaK121bwpz5vw1Iq0XQnhg9UDUfgkTH+bXh1w5Z9uO7rObIovKFa/Bk32BqjEtka6fWeavdoewM+SjHFiXj6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRrU4KMx; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRrU4KMx"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c1269e4721aso63443066b.0
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 06:24:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783085086; cv=none;
        d=google.com; s=arc-20260327;
        b=g8zkrQYj1oa8XC7A4dKg/pFaMLjns3z5hmbh0ocR3pCBZcpd3nnGEAD/aCqHEion+O
         A8NHM4WxZvHICkO6j6jL7fE9Z6iauzvgtrgZAkO4BYCGGxcSJUK3xCVwqxNQxobA9d0P
         ZjAM1SANKX6CIwZSr5MA3r3oLwHqwINcqkPABCJCB0Xn+oCWZdstC1n46TjvtUgyB3BG
         oYX8bTWIVUsBJ58dniQ0JU2Ok1TUSiHlq5oXQSGCQ3ZuZ9e4bJ6wZFmIWmkiTY6M1jEz
         1aCaKzNyV7KSmpS1QCoHHSSMuyX2zUgKq/Rk6+lH5RkbZ6BNY3GW9lQRW1EShWRrDaeo
         JQ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tlY+V0U6Za9b/AwYXIl72FX+d9WRWfsXoMmjeyUHBDw=;
        fh=wyYNoQomngS6g+X9wiV6i0yNja0WykUN8rDHffqY+b4=;
        b=DD6PKoERUoBCcRwbuTGjNNRUzUYsWYs01/hM3+OzgyvlcugjytFDgzpxwAg45jkpMy
         Z8s2eiX9yS6sRgdmw0CFaR/68/00QxdOSE+NoDK4Y2ViUiuP8OEK0C3tJufUeTlyyuYR
         OMvDDx8MxFold1iXagREdWUru3c2P4GDsmlpRxCz14+aG73qtxP3rS/yIgJC9pGABXhb
         /yZEGhGnAYg2wqkW4r9kNIouZx2xWmNzAquS9EzlXmskW7usvUW+vGU4mpu+NqOH7tqA
         SNyXpaltDD/ieZVBGWlmb9eRJ/28irj3QPIn87GoCbYd5tEthFoIJPvVmZ09CPBLaEHz
         AWzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783085086; x=1783689886; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tlY+V0U6Za9b/AwYXIl72FX+d9WRWfsXoMmjeyUHBDw=;
        b=TRrU4KMxtC0nK1MarnIjg/syj3/aDyKtKest6J5Gwn2vcbktO6BBnDfBj2yBVKnoiM
         +Y1izYcJhz43zaVMheQanFh+MJwJQQX9C6bqaBwwE7lRS5h22739HlAbv7oG95qBlQJ3
         KzfUOtthfq3GEoukPGWFtQ9qxXd69+9IF3v7Rvyj5C5/ITSn678K9Ks9LTYuxxthO/eX
         il1urHRSK8DYlw0gCrtf7ZbZBA1uCgAfylDKjUrZK5s2viemrlOFg7lmusF10LH77Vfi
         t3X0eNRKpQxkgNXvUs2xGw2/gEckXbUx0urCPWiSxWXCsOkNG5N4KeMhSr6oVi6zyKtb
         ZuwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783085086; x=1783689886;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tlY+V0U6Za9b/AwYXIl72FX+d9WRWfsXoMmjeyUHBDw=;
        b=XcHLHqK0fjwB08g/vPNs8eRwQlFFHgLsZGj1q+hRQdAaxkBCzY3ZWGbwnWLsJNy0+C
         wd1U13hPlf7pzQ6aY8cRVb8W9d8qE+ovfAayGTFwm2U75Lz3ReZcb2Ng0ddhx62IEQaM
         r+5t6K+LeZHNE83tWd56i9E0txgexX3xCZx/talOoBsEWj0XZHyvVn5s70U5sSu0SBSA
         M3JVol8L/QZxj44P9XNGmlWKolhrxIsuc6WVwAFCKoLz5tcmKMSLg0rEmg1c3QBLG4rx
         FHkacC8zDyIaFG7CFnwepf4Twi3pVUFZHRRrdRXlk/yAz7enSWhlSMQaRAJGjQJjOQKZ
         pdUA==
X-Forwarded-Encrypted: i=1; AHgh+RoU/XXl3cuFRBjTCfyR8JUsq7M3Ky7YbyPcHgDsjQnZQzHUZ+yfLbEtteooZ636SU4zQHyhHpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNSzY7JVZl0t3zq0QnVeWpTL2YU6lUo0kNNnARNna5uBsbQPJo
	sYOAFO4WmoWjncbhAHfKVzOoy2YuMisc7T/HFO/tvwbcLaLyiK2nT3of8Xbf+qKrUHJBzmUbIfu
	Ptd5hWI91gJc3Jdi27wDhy81qKOvdCNUnjw==
X-Gm-Gg: AfdE7cmMlSdmx7Hb9SxBIsxvIdmK9M1VvJwb6KTmS4BYUDLHec5cPSJQbKR65M7cChJ
	N0+tmzoh4zGssH54jmA/guiWcMXECv7lkb/6mLHXBP0o6b6Nru8fzatOyENbwczFsuKyo8otG8f
	W8xGNcEMj6mR2hRBQCa1H6ovPsksZkEdLsooSBelL+oRuSdpVnNWbelkxvTktnZEcTiMvB2PhM4
	lX8Psfbe34odQiUvHHV8PvMap+Uz4D7XVrDmOFZQNQPaPveocyJ/64vr7AEoHYP1/anXEPlIA==
X-Received: by 2002:a17:906:ba83:b0:bec:64d4:3872 with SMTP id
 a640c23a62f3a-c12a9da8ceamr481556766b.24.1783085086300; Fri, 03 Jul 2026
 06:24:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630-rtl8366rb-improvements-v2-0-05eb9d6a37f5@kernel.org> <20260630-rtl8366rb-improvements-v2-2-05eb9d6a37f5@kernel.org>
In-Reply-To: <20260630-rtl8366rb-improvements-v2-2-05eb9d6a37f5@kernel.org>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 3 Jul 2026 10:24:33 -0300
X-Gm-Features: AVVi8CdrwMFXiUozbPZwUDZk_tAQdREhBKg2h5epvs5snqAGeYWcTeK3bBO4oCk
Message-ID: <CAJq09z77GUn+wksbHNjHpPsrLLgU_yqo7V=M+XY-h1AKQE+WAQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/5] net: dsa: realtek: rtl8366rb: Switch to
 generic port_bridge* handlers
To: Linus Walleij <linusw@kernel.org>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +static int rtl8366rb_port_set_isolation(struct realtek_priv *priv, int port,
> +                                       u32 mask)
> +{
> +       /* Bit 0 enables isolation so set this if we enable isolation
> +        * any of the ports an clear it if we disable on all of them.
> +        */
> +       if (mask)
> +               mask = RTL8366RB_PORT_ISO_PORTS(mask) | RTL8366RB_PORT_ISO_EN;
> +
> +       return regmap_write(priv->map, RTL8366RB_PORT_ISO(port),
> +                           mask);
> +}

As sashiko pointed out, set_insolation(...,0) actually disables it
instead of completely isolating it.
I would unconditionally isolate the ports as we will never need to disable it.

Regards,

Luiz
