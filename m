Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFF030AD1A
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181719; cv=pass; b=UDuXNymvc7Pu8mz1f0k0ZuGH/gp8yX+wJbaQ14VesAzpEkVw8IK9sokF1+P7QZ8JLeeiF+8nMHf023aqFnz7qtQKMOvEXQNnYH3MnbnKMHd2pKbG7O7atZDXhIK3Cs9DRIRegTYycXNZvENmFh9kQ+Ve77wbZ7GofSsrQKZ2Bjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181719; c=relaxed/simple;
	bh=vHpnMft6Dz9Dvk15TYbbOwoNGe/1LHJBHSjjNHYgaZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XEEpO/3nSn5R6KZ5HXc2NrW4tsvUaJyoIBVmqHDEwxzpN4q7NpLEwynztl3Ilsrg+5Rw5acBdq48JhCL+13q18CRcqqpZl0l6ikQcJaLfhU8eBVWRxFgTd/WW6vtBe8YR26Lu4le9v9qC2H1I14xBtSE+5yb5W4WIi+FUoV2gNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oQ3AlIQf; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQ3AlIQf"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c250a2bc3b3so448004566b.2
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:08:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788181713; cv=none;
        d=google.com; s=arc-20260327;
        b=gWu6tk3SkYD+mTpX9JO3ewtX3FBiH45Eoh7b26vd9u+I5SuTE8n9v0TsJT4PQDoW+U
         Y42geWeUYVof3xPADd8X22JJtfvtCoShxEg1jlTMAoLqOXlm1U3l1J+eCV5uYhniAw3Z
         WWyBvGZPz48v5TO9x+Q9G9dm0TzNNs/qFUu5R6r2Pxgccm86i1D5X3RVl/E8QJgpJUjz
         OFPcWiR8LieSTN/o+Ot1f1pwvFllDCH/tqo0m4Mka0hcdxPYlMaHGrAIx1au+XeZ09hN
         2b7NJpWv3cHM16OodS2MZJqXeXhKUl9hKFZWXQ4Ua7ZQWGef2s/HbuD96ZVni9xx0G8T
         QquA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ArVyWXSj4XrOJSM6D/R8V0wa0IdxUZ6f3y+EOLVfmmA=;
        fh=LUiUFMVTdTC13dOce8oC98Yx5KvDNH4USvt/uLQYcmE=;
        b=ntzXttZPu0j2QJV1bz8cJVE6426zcARNeO042fNjYBKfE+tPVbk0iEZzKweIvH2Dv5
         kg0d1WM8wRF841yr5ItW7iensCBpU7JGq5Z1NMlwDZAjAccH8hfr7zg15PPI/OlfCgTl
         SFNyWCdiSxf8MabnpH2t2/kaaZ7VCbEvpAn07Nbzm61TlKn3VMKOzgYpaI/j0Yd8+vC8
         Wz6BCSo8cXQQcWypX8IteB7mS0J74xwK0XJusNqVreYWE9B5B7VTXK1y94SuxvBw2vmp
         0K0khpxjy1SiDt+c83aOWOEShH2GNDV7zm2bEbM9Kl/8/n5ciH/+F/WeHB2dwEr8ZRF3
         r2Pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788181713; x=1788786513; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ArVyWXSj4XrOJSM6D/R8V0wa0IdxUZ6f3y+EOLVfmmA=;
        b=oQ3AlIQfC8x0EjfGtvp9uhvG5EmEGocd2c/Sm4BSXw7tiTH4PeCTa9Qu1oeGkpG9Qy
         vdNhihjc+FezJkRcUh75RW+RzVMDp3Nr4HzSNqOHpSO93mbKvu9dfSmqpW5k9AUlXaS+
         BdoTmFrk4ODft5KuWxlLhhrmk1j/Wd8CuBtp5+IGl1sYXRPK3FkuEaeyi1gXXmkiFWxe
         +UblfgMMd6Nufq59vbLLpifa6BI+w12LGOTEw0YNEApcEpnUoqf/IHEGDeyMI2g2D1jC
         SWlPCLHLVoqhetqADRj+grobV9lI2e7vjOyOtWR5vIsXQ/7o4e7wWBlqwH1qzIml/Hme
         gTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788181713; x=1788786513;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ArVyWXSj4XrOJSM6D/R8V0wa0IdxUZ6f3y+EOLVfmmA=;
        b=rTuOhZsKny7SoMlhFmUHajvngs/gkMtrnGJfMBaEvUP56FolJJ8f19zv5PdbFuCAkp
         wBqaqoGa2zhjCFtFeFJQ4tt2+oOt2NVSYR0t0Wpy3yR1hy3mLlsAnaRIJlFeeTIIAIhb
         Xkef59DjNVVEY2mYi2KOBrPFXT9sVxYlQBz1vCC1QvFlxdZ629yNdH5v0lFnXn1yfxI9
         0aSdwuHpKuczF0L2Qy8BedHEQdxebg0dhWBp/ajabOaUak4qEiyYuJXUyxeXcbBfVO2f
         qCVfjoFEI2HxL5NEA0fzru6djZ7RkQtcfTNLhG/l4HHqvPZNroCB+eZGrJtE9AbA0ZN5
         6xEQ==
X-Forwarded-Encrypted: i=1; AHgh+RrbKqV58FtFsi98U9+ngQtvwMjeop2OlTZSoMJKRuFzWLBWSmOddFEwN42aeT/JIKIy/fetgPo=@vger.kernel.org
X-Gm-Message-State: AFuF++lvoIgTxAeMOj7x/I5V9nDXloSXplZHzVVHb1kN4wKYhdg7gAo4
	tqMm/7CI0Jr0kZRBMMVIBZ+8+PEBfNJn4VU67XtZqFC2VMcuT58LFRp0czlgyI2lKEi7a8AWNW4
	y4hZ2b3mR603+/Ljfj+V8X2EkuLysz8E=
X-Gm-Gg: AR+sD13PVnZFzRAl+IxwjAFXzTDQhnzzmUW5/yKqAi474PeILR6z4i81ERdQHEMP2T/
	bce9zMjMIQ876tUW+Pq70Gxtcv43cXwGp+QIEbPRVPpMKHMZWfQgVlCx0/qK8cP8DBv7kuXOEI3
	2//o5OHNU3en3kF7cPfafcD8LccFocYZ4z6FeuSTsm62RXkDhPhxaBzEc/u6T/1Ango2o8RMDVV
	a2OdMy8ViiNtBjKG4MCD/t3pRV1OqKtOHELCIKpBO+bt054cmsuXepGNMSLrHq5CQR7/wnl34en
	iRTw+K8ND5w4XTFXFBfT40pZn2y1u3mddSrCSjc2H7s4NDpYBkyGnGAdod0BxPGv1ILARp4fxu0
	7
X-Received: by 2002:a17:907:e009:20b0:c25:afb6:2d91 with SMTP id
 a640c23a62f3a-c25afb62f6dmr113371266b.2.1788181712963; Mon, 31 Aug 2026
 06:08:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831123637.666457-1-o.rempel@pengutronix.de> <20260831123637.666457-4-o.rempel@pengutronix.de>
In-Reply-To: <20260831123637.666457-4-o.rempel@pengutronix.de>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 31 Aug 2026 10:08:20 -0300
X-Gm-Features: AcwNN1Xw8wz2-r_4F8JCbwqtdJfxO4kY2Houpf0hjogBOIBslH4fHsaBt66kRng
Message-ID: <CAJq09z4ay-c51-GA6tFrV9QvqyRvvWODJ+G1FcQLYnmKsO_+dA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] net: dsa: realtek: rtl83xx: use
 dev_err_cast_probe() for reset GPIO
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Linus Walleij <linusw@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	Ahmad Fatoum <a.fatoum@pengutronix.de>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Replace the open-coded dev_err() + ERR_CAST() on the reset GPIO error
> path with dev_err_cast_probe(), matching the reset controller above and
> staying quiet on -EPROBE_DEFER.
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> Changes since v2:
> - Added this patch
> ---
>  drivers/net/dsa/realtek/rtl83xx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
> index d6d243131fd2..8121ec12fd8b 100644
> --- a/drivers/net/dsa/realtek/rtl83xx.c
> +++ b/drivers/net/dsa/realtek/rtl83xx.c
> @@ -212,10 +212,8 @@ rtl83xx_probe(struct device *dev,
>                                           "failed to get reset control\n");
>
>         priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> -       if (IS_ERR(priv->reset)) {
> -               dev_err(dev, "failed to get RESET GPIO\n");
> -               return ERR_CAST(priv->reset);
> -       }
> +       if (IS_ERR(priv->reset))
> +               return dev_err_cast_probe(dev, priv->reset, "failed to get RESET GPIO\n");
>
>         dev_set_drvdata(dev, priv);
>
> --
> 2.47.3
>

Nice!

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
