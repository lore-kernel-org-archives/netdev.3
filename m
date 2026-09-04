Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27CE3B9D84
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541450; cv=pass; b=NpnBr13w6xWQDJBXtIjBSx12iz2DzfpEXdJZU1jqjXu9VjBEuUPTvD8hymnZQrrPwTKKfp+eONonqFqsnoaeaPxsA6t9euO767FEuviulYmCzZoINRt59Y56AX20RF9KwMgAx70/mcvjpxVDQYxzNXzMsyZ/nCt/es5mWqFWxFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541450; c=relaxed/simple;
	bh=1Zani8KVUN1LcbKX3On5KmxvOITUPxxLp5xuxtknAFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWRTmAAwmlc+pLoYE+N/f1dr7H1sTkvCgePktwxff3ffs09sXbG+R2UunuEYt8MsdT212IQBFapyrnNEVIqInpt0q1CWlKOvhNRqnEnUhvDzlLIgzIt3ir04Kooc+GUiC++0xs+pshPDwe+COJgs9V7/4mAPM8ox/v89kVJnHG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p68DyCcJ; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p68DyCcJ"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6b613d3e19dso1547779eaf.1
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 10:04:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788541448; cv=none;
        d=google.com; s=arc-20260327;
        b=L1o7XnN96+VFKOO+qDSZXu91DnV5wxZHQDYoFWUVjoVUGiF2dFRIFn8R/k6L2/Hnya
         TP6HTAtC+V6o1IyzgBlJgeMCIRBcRx+9YY4yYKxuE4bt75DSn7ew8ZQnbCa0SukxKbgE
         CKBlMck5xEgz63Rf2KdtnKmzk4vf42g/HzUvRMkTsNED6SrAyFJxnUPdts3yZ+7KAJUR
         sGVLfROEn/mjxobmaJytBU6pjsC8hl5r2bYgOVoh13qOof2e8hFTqoD5ZZkP7NLXy/4D
         2YTOBeEfgLiRTmlOfk0wPke+dqcnKu/zxo4UfDZG7/wk6hR8Y6gDV7XQ7rKwTMukn7Nl
         NfxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z+rZ3J/l5NmsTe1xvBjQosJrBLYmVyGgJsZt6vb+Ldc=;
        fh=DKYip1YAX6hq4AOqn6/JB971uU0m09YGYFJ2VUMg1AY=;
        b=DtTaI8+bLv4xWt8aLiuz2vOj849nKJHtwGrHg77sJ0qdFgeRILXT1SIk7O5MN9WGzc
         rOY0LKTo7BODTFU7oOhnI85GXlwViVAsf1ZXXRE55JUn+aIzvnQIwNI7mpj8xssXNyRv
         oNPsHDYMlD/af1dMNzbY1hDY7vdUAc6r5wdNZB8SlD+Cy9RoLt5IRHl4uZ13T0f021sb
         95EqwySl9uGY5Ip19UmCpiWKf1RauaDgBJnQRZOkosIJ22h5osXodLBBdJujOcKaslLj
         C3FGB4loN3u3FY2qrecuX69h9fyVxQTOp5pq94GgVEviBdDOm0Q2+Mt3bWhahK9KdkEE
         HQ8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788541448; x=1789146248; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z+rZ3J/l5NmsTe1xvBjQosJrBLYmVyGgJsZt6vb+Ldc=;
        b=p68DyCcJv9LknoRy7M2Hnz9V+i/TJgWi3e8F+tSgxKU5kInH88mHrOetnCtQIx7zQb
         9i2LZn3B5ia18JP/NNcO5Vq7xT4UR4R23u2MuTze+O9kO2RoqUaUpTvgUQ8Cu13GXBQA
         yNFWTEl58VyqZvkrDnGUIA4OonlJBMNra063njK7yYsBdA/M2R8We7MYYPyua5RPS4yf
         5tGBxxPqin5svAu8uO8G2IaH82hfX+n8Etllhl3e5QOtZScqyQhjE/dnC3Qd6WzXsUmy
         3uEI6STgcwbZ11j38RIsgZhtQ/D0vxFn/B2YsYU8aBzLps1IkDoTID3gtL0OIK8U8nRM
         b94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788541448; x=1789146248;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z+rZ3J/l5NmsTe1xvBjQosJrBLYmVyGgJsZt6vb+Ldc=;
        b=UCeg3P2ls/etrB/m0EiCkSwXp8Cja72fPkJPq+hiZtcnBi3t3TOPQBafsK6haUb8Pv
         usG3jwYi1nAknYrVvGnqoPCNmtQeuWSS0SnirRl3kr1L59gu0ulN7P5OX4cF+N1GdJPK
         RxxV3ORiZVS/KOhSyay7CLY1cebpHv3CSfIRUOwM+mH7O+gOf+Dw9BUWA6ROMEXAeQUU
         H1aeh1AyXDNdjwKtYLxFg+cZGOV3Pu0IImdkKfCx6JkaFJ6vEroVYFX65Xz8NQPQxdW1
         XEPCroX15+0iY46ke2M/n1CjwHUucFN7fWiPm8bLGEotM3qkyywpd8qFLmOXqPMcvyv+
         Wrtg==
X-Forwarded-Encrypted: i=1; AKwUvBwKEwYsTXkJhxagyXyu2Bsi8A8pFgc+45uSw5rnmiL8Lq1qiXX/g6cd9Rzx6avjS9hxrX1WXcI=@vger.kernel.org
X-Gm-Message-State: AFuF++nI2+UF5IQ6WpN61+4aT/OzL98Xd8cishPc9w8kiGxh8hmcdlVp
	vnxC1XxQ+UURZWqijDOBGogne3zuPyBhrQ8JRk8nZNd5Riyk0ilyzsRNvND9VWR5bDs9g1hHlYn
	/DYYT3+fAhiiwpO2Q/71pu8MR+y6yR0t26nbPiyI=
X-Gm-Gg: AYBFou0CnuwqI+0ne74Frn5v794Etl/g/P9NPZ2zhVtIQNoTr6k9uotBbjAZMfOPeXa
	ZfkZ+XF3Cqe8GHaqn+eFfoGnHY4GaRBf0fht7GFEI5vUh3XFGGn8f/w0q8GziaogkMIXdS0N4iR
	/CCCiSVSeyRuRtk9M2ClqIW+OWctUo+Wgp1w58uAcP0sMpd+r46gwXXr3/LWqbbX9VNB9Sg0I00
	LBpOMqgYWk+RdHVJ8w0bmNj0BGIu6FXw27FOtbDgwXcdoJzQeU0yGryrEyDtbBLMcjjBxDCd0i8
	tbVhEJRA3yhneN2qviWca9Mo8um6vvwq2z8rwqG5iz0yvh2lPY5EEbE50sh3mpRp7HS8pQT7A23
	YcQ==
X-Received: by 2002:a05:6820:5602:b0:6b6:5bf3:e226 with SMTP id
 006d021491bc7-6b65bf3eb3bmr2532642eaf.26.1788541447608; Fri, 04 Sep 2026
 10:04:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904095416.1692962-1-kyle.switch@motor-comm.com>
In-Reply-To: <20260904095416.1692962-1-kyle.switch@motor-comm.com>
From: David Yang <mmyangfl@gmail.com>
Date: Sat, 5 Sep 2026 01:03:29 +0800
X-Gm-Features: AcwNN1XYLN1qFGsXZ4jRJsNWSBsrhdl5lpMgs3AOgGB-bLEI4bhHOu3Xla1pthg
Message-ID: <CAAXyoMN-RX1aY_isyajES5LgiDMp7_YTbM=jiS6d-8o2kKQXqg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 1/6] net: dsa: motorcomm: refactor
 registration path for upcoming switch families
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com, 
	jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 5:54=E2=80=AFPM Kyle Switch <kyle.switch@motor-comm.=
com> wrote:
> +               .name =3D "YT921X",

nit: We usually stylize it with "YT921x".

> +       if (major =3D=3D YT9215_MAJOR || major =3D=3D YT9218_MAJOR)
> +               mode =3D YT921X;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(yt92xx_series_info_table); ++i)
> +               if (yt92xx_series_info_table[i].mode =3D=3D mode)
> +                       return &yt92xx_series_info_table[i];

Redundant if you use both indexed assignment and lookup routine, since
you know the index already.

>  static const struct of_device_id yt921x_of_match[] =3D {
> -       { .compatible =3D "motorcomm,yt9215" },
> -       {}
> +       {
> +               .compatible =3D "motorcomm,yt9215",
> +               .data =3D &yt92xx_series_info_table[YT921X],

Redundant if you use both runtime identification and the match data.
Also I'm concerned with early IO operations, although I didn't see any
incorrectness here.

> +enum yt92xx_mode {
> +       YT921X,
> +       YT922X,
> +       YT_MAX,
> +};

nit: Use prefix/suffix like YT92XX_MODE_YT921X or YT921X_SERIES to
avoid too broad names and future name collision.

>  struct yt921x_priv {
>         struct dsa_switch ds;
>
> +       const struct yt92xx_series_info *series_info;
>         const struct yt921x_info *info;

nit: Better to use const struct yt92xx_series *series for simplicity.
