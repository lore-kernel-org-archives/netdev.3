Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B812D8364
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791728509; cv=none; b=b8iciaDoteHkQFQwdwy5m965RvU4Y+CtyDLV3u1a/SyCFL2OiLqECiONxz2c+RA/+825xFyRRZB7v4pe2BQBPN1k8g6YjLRpr89w5anW6sdNZ/ekekeSROcCq3E4UcLfhcBVGl4sdH2wFaXXngol/XFB5x2jni9/HIgk9M2dx8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791728509; c=relaxed/simple;
	bh=TH2hvxG+a3DnkfzStjL9vGu1h7pAJ9JEfX/MRQWvLXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IV5OoubMWM2P95nnz3TANqYQoSa99+Fn2UWnSRjlzbzCYuD/oWQTpOOA3SQOY+jXRvevbd020BwhP9T3u22OjY+6c2xBhAXD/Cpk9snB/Smh0D5+N+APrDGGxmGTuT2vKlmTMST0e/D7/mRxfPPOaXusLFU6VxzfBkEzd5+tAUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-888cbacf70eso12515427b3.1
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 07:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791728505; x=1792333305;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KzyYwwdi+Gw4Br7ibuX1uhAgZ649p+E+2HalXmhinyI=;
        b=YKh6ooSNID2Szs38xB5DoCJIsPYyk+D+Xy0hJ4ke8WNPAraU1XPfbxUeeaYpUM3TQE
         J5HzeeW0gvTpMnk/rgjcKyx793tZHR9Il6W4RcS6GNuMC52jZEYbVCyKtKfNj8BBbkH6
         +fjH94g0ypK8saEwFNrb9uA2LuCKwLGI2bNiP4LWcE3ls7DWFYIzBK4Vc8l8vNfqOCpf
         8DmHHCHQTFbqPZUT5bAY4Qx+e5u2+BBkIi8StwLSAIItGw9ic8jgP3ccLMJCahva2uOa
         IIzS5pEiuiky9K+IulGLaFXUmRpGHFSGgXfgw/bHfA63wVcbYh/eYVZYQF9CrWpNv1tP
         uRcw==
X-Forwarded-Encrypted: i=1; AKwUvBwdjIR/KIup+yvzDNpTAlychRlZkPF3ztbFQm5RrcZxR/uonhMKVMzRYc2yld/OYNRifxFbP1s=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4RoH2GNLIlWo3wDFUsc7iWywoaS6znUmmTXR7xH7xzZihbKbG
	7GO6mI/SS9BQrDkyoywc516Fn8lzX5jGEd2IdNnVzVYlh62da+jvRqxwLygNiFrotok=
X-Gm-Gg: AYBFou1T3pCn4ReV1tO5aXqowlxmdcP2+LprXiVxyuvKwx8LBbjVFJdMW5krcUNN5b8
	VZo/rZ8dUyOxoQd2rhxxENSbDOyY5+gLXfWE6+mnC4DnMfWOqNbwwtv1f2d97Tt1KWwKGDrman+
	ENK6lXRwi+u3yXDKK/Gc52YnlYWdreIkdcyMRK99PS+YktONabGgEQeeXMei8+mLV40xZ6AW+ix
	VqpKEb1Rb5I1mseFMDLsHzFfSfYwvTJbO3VI9fRMFSaw7XIOC0iGrdfAR0xXSE69A51KqtOTnQj
	8osqdUcHpSd70EimgO4Jzgkh7QzK8ya7trijK8p/Twwk7sysCWN1HJkSNuO+HrLCCqCR3CjmrDx
	U2slSqfeSduq9ky45Gvn4tDrGkuHxhk70p/CkBJ+KYrWyuA3hETH9RQRP0zzBneKwzbZim1krNu
	omBlq0lhGQk8hWEOUJtsSMoZIjzv3Hd92RkRJNXj3x0ZcnyQlz4esLbYCst+ckIEQShISAw8rCu
	37E0WAaHv5AL9s7mD/Oj6+ds1uf9UQdZMe8iZSKVqKia0JA+StwFypeql8PPbuoyiE=
X-Received: by 2002:a05:690c:7008:b0:897:697e:52a0 with SMTP id 00721157ae682-8b07ee6c95dmr21832517b3.55.1791728505136;
        Sun, 11 Oct 2026 07:21:45 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07f1ea845sm26121477b3.24.2026.10.11.07.21.44
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Oct 2026 07:21:44 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-888cbacf70eso12515247b3.1
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 07:21:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz15wdF0e0xCCU4SypUZ1TvT53kcGy7gwfaQvSX+g5c+bR9dG9zOikptHga7rm0sPw/J0dM9aE=@vger.kernel.org
X-Received: by 2002:a05:690c:309:b0:8b0:9e1c:3148 with SMTP id
 00721157ae682-8b09e1c33cfmr4413327b3.34.1791728503965; Sun, 11 Oct 2026
 07:21:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010105900.247342-1-tanure@linux.com> <20261010105900.247342-3-tanure@linux.com>
 <CAFBinCA7rPu0obv+2aadxqkzMYKmd1+DLJgRe6y418v0QrwSSg@mail.gmail.com>
In-Reply-To: <CAFBinCA7rPu0obv+2aadxqkzMYKmd1+DLJgRe6y418v0QrwSSg@mail.gmail.com>
Reply-To: tanure@linux.com
From: Lucas Tanure <tanure@linux.com>
Date: Sun, 11 Oct 2026 15:21:32 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+2tBUh=xP9kzPBB0CauXFJukipnLf6D0jLMapvZOst_UQ@mail.gmail.com>
X-Gm-Features: AclHuK90wt6EVCYdNEmq2Fhuw7FDmVki8iPk3nLcnG5vHPlk0pxu17yKPiCVT8U
Message-ID: <CAJX_Q+2tBUh=xP9kzPBB0CauXFJukipnLf6D0jLMapvZOst_UQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] dt-bindings: net: amlogic,meson-dwmac: add amlogic,t7-dwmac
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 11:14=E2=80=AFPM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Lucas,
>
> On Sat, Oct 10, 2026 at 12:59=E2=80=AFPM Lucas Tanure <tanure@linux.com> =
wrote:
> [...]
> > +        # The TX delay is a quarter of the RGMII clock period per step=
,
> > +        # which is 2ns at 1Gbit/s.
> > +        tx-internal-delay-ps:
> > +          enum: [0, 2000, 4000, 6000]
> > +          default: 0
> Is 0 a valid value? Let's say we have:
>     phy-mode =3D "rgmii-id";
>     tx-internal-delay-ps =3D <0>
>     rx-internal-delay-ps =3D <0>;
> According to patch 8 this means: MAC is responsible for adding the
> delays - but it doesn't add any delays.
> I'm not sure if this patch (removing 0 from the enum) or patch 8 need upd=
ating.
Yes, you are right. I will remove 0 as a valid value in v4.

Thanks
Lucas
>
>
> Best regards,
> Martin
