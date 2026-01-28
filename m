Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC1E374168
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 18:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623584; cv=none; b=O02cw4fl2L3olRP73sbXm8ct5EB+ZdR1e95D8fZAFB7ZnauLaxZEjjTAggz2KVYSDHs1z5A8mEIiMGgFQscKzMUrErG0riDklCMd7o6PeT67eK5clJwUoTaIISq/UUzp26s4W+CN+BUoUYLKoFiPfubTXcbL7yWn3Ib5bdla67E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623584; c=relaxed/simple;
	bh=aLQlAriddxjtfNxore64BpJ7FXuKKwPclEYoPe2+elU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWGXXyCerFcXt/ubGr+wlkGV8mCcuFhVYmbsbOhGOnK/PiTYHZDwhYnm2gMjswlXilF5lBVFA1c+CjEz1rXS4Ye4j0IdXm2/0WhnmVdHb37mNV2GlDeeh1LYx/+/45Bb9dIRfSl6mQMYd/nGSiq9UBTLL3ReKs+goGoEPtsQplQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cT+wenrz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cT+wenrz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A09AC4CEF7
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 18:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769623584;
	bh=aLQlAriddxjtfNxore64BpJ7FXuKKwPclEYoPe2+elU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cT+wenrzhttSsiF54FSIDQACHrz+nqnuWnLlHLWx+u3lCCSl6yb5Pv+Lv+n3R9Idu
	 ruTkQCi1OR1nfX9jlfg2Scl3ER2X1HhjGSgOgfVJaMwFVazrC0izcyepj8guCbwjkd
	 wDLygJ/spBx31DieGaJbnQf9p0FheZq9FuBcX9PHWtdntYILYhQFrOhXdIcuESJTsT
	 D55zSST775GKhYkJeOWVV74o2FEfUI6XYlEjhzLhPygzniTmyWz1XhNQBIPSLDsPZ0
	 x8s5EUOOKeVkbxW8Momk5X/RNsJQfkwRCzbw1zBtadXNOoiRuT9KjUZYWEgoJAfvW/
	 3jAlAx3XdL4Uw==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-655af782859so309721a12.2
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:06:24 -0800 (PST)
X-Gm-Message-State: AOJu0YzcIUiI2Dc9KVORdYPyMVOgXc1GMXsqEgI+zWOVaP9+Uf60PZPE
	RUqsYK+szoeyLNGrsq3pOFesBc+jSJrfZAKi7BSQPnBoYzITg22PmyHvVIdK/xVekJtY3bs4N4y
	q4X/8pIXHvYCrjm9DjxXP2pe2AspMhQ==
X-Received: by 2002:a05:6402:2792:b0:649:ce39:3bd0 with SMTP id
 4fb4d7f45d1cf-658a60c7866mr4124399a12.34.1769623583170; Wed, 28 Jan 2026
 10:06:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128133842.1173406-1-ht@twx-software.de> <20260128133842.1173406-2-ht@twx-software.de>
In-Reply-To: <20260128133842.1173406-2-ht@twx-software.de>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 28 Jan 2026 12:06:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKbRSWg+9vNNEa9a2YtDfE+WDYFrRQsjugF0AXj9Yiq7Q@mail.gmail.com>
X-Gm-Features: AZwV_Qgxkj1zwRB5E7PNq_1hm4iE6xRtjDH2mblLZ9tfDEOXY54W0mBBxs0VRgo
Message-ID: <CAL_JsqKbRSWg+9vNNEa9a2YtDfE+WDYFrRQsjugF0AXj9Yiq7Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: net: dsa: microchip: add
 microchip,single-led-mode flag
To: Heinrich Toews <ht@twx-software.de>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com, 
	olteanv@gmail.com, krzysztof.kozlowski+dt@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 7:39=E2=80=AFAM Heinrich Toews <ht@twx-software.de>=
 wrote:
>
> Enable single LED mode globally for all non-CPU ports to indicate
> link and activity via a single LED per port.

Please use get_maintainers.pl and send to the correct lists if you
want this reviewed.

>
> Signed-off-by: Heinrich Toews <ht@twx-software.de>
> ---
>  .../devicetree/bindings/net/dsa/microchip,ksz.yaml          | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml=
 b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> index 8d4a3a9a33fcc..35abe242a7741 100644
> --- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> @@ -65,6 +65,12 @@ properties:
>      description:
>        Indicates if the PME pin polarity is active-high.
>
> +  microchip,single-led-mode:
> +    type: boolean
> +    description:
> +      Enable single LED mode for all non-CPU ports. In this mode, a sing=
le LED
> +      indicates both link and activity.
> +
>    microchip,io-drive-strength-microamp:
>      description:
>        IO Pad Drive Strength
> --
> 2.52.0
>
