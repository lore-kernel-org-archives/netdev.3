Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D5844C659
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 07:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544223; cv=pass; b=nGGBAmIvDggF7hTRYr69JsS0rR/W4egvhFsg7f7bonPiHszGCp1CaFYn7IQzVlCrXaAmTKxezwvJ1V8yfUhzVwJy99vfPweMnRxgGNl9EynwKible7KUx6kkr/mUO+JGlqNa+EUH/m0lo7ZGtiMQtj0M9znsb6QRyRYz6DJu6n8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544223; c=relaxed/simple;
	bh=cJJs34fb2h99W/KbF5DWHeZGBBI0ty2ys0AP2AMX3NA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYacBb7rS54Vd/bysSVN60fXLxve7C3A5PG4RuF1PmbsgmzGnq1Xrp25ync5OkpFTx8s2Lj+i2jwB9GFi2zPWpn/wzdwvdhZ3Jqaw2P4xQxwaNOE2V5Qoi1SZCxs5e0DWjaNSH5jD8X0Nwp5N/8YIt97J+wCPZ+isL4V7yOA/xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sa4wcHW8; arc=pass smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sa4wcHW8"
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-791a9878aa9so179615137.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 00:36:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789544205; cv=none;
        d=google.com; s=arc-20260327;
        b=qPrJo+m9H/N3F/hAkCB7G4QgUq+UTX0Lx3EWcQTTVp3Tb8/OPWKexTspvAfilNsn8k
         09XGYeZRKLmYa2egj/1PsHXH5crza9U2DsL8T3hprZKG9yElA2Pcj2I7uxZKQzdXnisk
         YAgRJtYL/8wXyF9upC8X52tGkOaVbZ2YC79eShhaEDJSMrgAyh1yM1DtXzPcUvdwYipT
         /imk6ZmHQUwR6KShAb8WBh5jO+CZowrP281fgSgimyAGk5JbCHHxOTfSOim5qvyIMluv
         vB5u72XZ4jlyJJk9A0uZm7l8WrHnO13QlbGbuz61Bd+w46cw+5YH0yIYlm3hh+t6i40t
         4W4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dFdl8Va7Swxkjw5uQRSJKt+eRYekF3RPnToHL1YscsE=;
        fh=7flYnfDWjngGq0Pz41FJd4to06BJ3a/EYa9xhr0Qjq0=;
        b=iVd3P/YE+AVon+Xix/ksoxEzwpiHciUqaf3g+/QNhlSkFoI23UNwHQ/xKnOBmFQrON
         GqaQejIfjZu1I7BePJMJtvkahaIhVTUiHQDkGuykdvEMwvM+XCcFIr8SrNd3AAQ/+SP/
         edelus1KV2wbXp9Gt/x+KCNE44he7xOms+DXsWBEeBawQWghzDzNoNF7AZZrMNf+t5UT
         ZCHJkULljDzwcesdabPudibqQhJV4dZVzifHqLqBxn9FK4iG4ZlxLzr/Lg++joJ8J9+d
         LFWL4DxQOCxGJxBphFC8RMn7d5iI8Q5dEnCjgl6IAPtmEYeHznZfLl+LrMFp/+ttb5O6
         o1Sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789544205; x=1790149005; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dFdl8Va7Swxkjw5uQRSJKt+eRYekF3RPnToHL1YscsE=;
        b=Sa4wcHW8Ujg/+h7/w82w3fECg5FqooFAgohduku4IsAGiXjmM8365hyh0E0X9e986u
         cu9h49eFoKjB7jTcls3mqrXanekPLEi1miKYfbqiQZKKWDF/PaB9WtSpbBQDXTDvK/2Y
         HQ4K3ebtXEs40F6Z5a26MvqqIPuCM+9HsY3Aq4xmQrtSJpoZUwrzE+dcg4alotEd7fkv
         88DYGFqXIwZn+BKmaLmy81jAqOsKLRuOmk2sK4GysH6Lth75hJL6v1xZ8qsR3ghAFSCk
         qqrAcVJbF81jNnLY9qJSv4iGVZnpbgZWmHW918nB5tYHiQNkSd+4K+1HurNqi0IHoBzV
         i7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789544205; x=1790149005;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dFdl8Va7Swxkjw5uQRSJKt+eRYekF3RPnToHL1YscsE=;
        b=yFylDTZgyPooeo9t/jHOxScOkYWnX7Yv5SD9E8Oj9WymDsno91yUBuwxo+ocXrPONm
         8gbPOp/bl6C95hjxWppVKOzFeZ9qpH50kOtXTtgxZMEXl4Up2yqmtriKTbCyYF3vzmP3
         L8u7GQzwSmF7GA5g5Jci23T7SxbNM/86VFlNcRVlg8+pitEZ36qMQqYbQnQeMbmQ6aMa
         grt+S3U314DGHnFu4v0UoqLiYkMSFGdVSpQzjgUUq864AlXJs0m+iowiixfQFLaPLRgt
         U07REZf60/A6W1RB/gS9IlZ+kMHA1irYOqrzGBQ0gsDNU8zJK/0ZWNgWrE0OoPXGbh0z
         ZUSQ==
X-Forwarded-Encrypted: i=1; AKwUvByy7L7UTwdScrVSkZExsG8lR6V8SCKx1AIZXYPygz+OyKXpZzeesNec4F+UlU/1IVjhsKAOEc8=@vger.kernel.org
X-Gm-Message-State: AFuF++lL8VIenTmifI7g8YODajdxZ3J2p4d+QTCPgfK38H6jo2MskmvF
	5kfUL/ErEndEoXKa11lx6gAicc5aTlI6XyLu/L/z6fD9vvLEUwFR538DZkAUyv9NxYvFl4BOxoF
	liRBGXHtx9O2Du4JfDug8GBHNxJy9U5E=
X-Gm-Gg: AYBFou3pucC9+OBatNxILD34jpLg7Jsen/ffnJ/vKuC4Yrz+feaTQw+uB6qFvqWp2rj
	Q/Mo1UM1tKyGGkEDT0uBbsRIimAYL6cXP0nv/sDry6AGpRZ9yePowKZVU9TyTm/234X2Sn5I+aU
	1JX2sUPPHFZ3C/M+40oe9O0fIWmPL1+kES9Y4fEHx8lO+QNKqDR392XlxpqUFg5yM9o6MwRVafL
	aDPYeAMGf4byCapZ/gka/UP6zKVOBGzSTF14qmNf8swjOOriaLTxq1SoeHjJ0OH9O4VqN6Mm2vG
	/3QPDrVLrPLF1XdIckUHK/QYI7jj1ItCVf1LgSVULNvHxVC1ZczDPF76EVBCKXdJJ5WzAd5x04o
	8NUpO5pg+U9i02oStbmVSSRqE2dOboroI4BgqfAnxPpPkIaKuAVF6R8mrqYuVYPLHiXPfFzUb9k
	JaY5Vo/Gxg38EM8hblsUQj3zR0r5YSjUKP/0BdH+qQWlZ7/nSfHQ14/z63
X-Received: by 2002:a05:6102:4bc2:b0:79d:c493:f1d3 with SMTP id
 ada2fe7eead31-7a026c4142dmr757332137.7.1789544205003; Wed, 16 Sep 2026
 00:36:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-submit-h616-emac1-v1-v2-0-322b32e40eb9@gmail.com>
 <20260915-submit-h616-emac1-v1-v2-1-322b32e40eb9@gmail.com> <14e61e7a-29ad-4cc6-8993-dea7a8d7c846@arm.com>
In-Reply-To: <14e61e7a-29ad-4cc6-8993-dea7a8d7c846@arm.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 16 Sep 2026 01:36:34 -0600
X-Gm-Features: AcwNN1WscQQGHuBz-gQadqFD8U_llvHSSS-ajPx5e079eC1kBH6r8x1MbCO5ieo
Message-ID: <CADvTj4qtuV_JEW5Byix86eQZJBsc_dmPR75ypVWn4xjem9rpAw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: allwinner: add H616 EMAC1
To: Andre Przywara <andre.przywara@arm.com>
Cc: Richard Genoud <richard.genoud@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Maxime Ripard <mripard@kernel.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 1:26=E2=80=AFAM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> Hi,
>
> On 9/16/26 05:07, James Hilliard wrote:
> > The H616 secondary EMAC uses a separate system-control clock register
> > and supports only RMII at 10/100 Mbps. Add its distinct compatible
> > without an older fallback, since using the primary EMAC clock register
> > would not work.
> >
> > Constrain the PHY interface mode to RMII, matching the hardware.
> >
> > Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
>
> Where does this come from? If Richard is the author, then please reflect
> this in the patch (git commit --amend --author ...), so a From: line
> appears in the body of the email.
> If not, it's unclear why this line is here.

This was loosely based off of a patch he wrote I guess, although it has
diverged a good bit so maybe should just drop it, idk.

>
> The actual patch looks good to me:
>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
>
> Cheers,
> Andre
>
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> >   .../devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml  | 13 ++++=
+++++++++
> >   Documentation/devicetree/bindings/net/snps,dwmac.yaml       |  2 ++
> >   2 files changed, 15 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t=
-emac.yaml b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-ema=
c.yaml
> > index 323a669fa982..2cae0133b3cd 100644
> > --- a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.y=
aml
> > +++ b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.y=
aml
> > @@ -21,6 +21,7 @@ select:
> >             - allwinner,sun8i-r40-gmac
> >             - allwinner,sun8i-v3s-emac
> >             - allwinner,sun50i-a64-emac
> > +          - allwinner,sun50i-h616-emac1
> >             - allwinner,sun55i-a523-gmac200
> >     required:
> >       - compatible
> > @@ -33,6 +34,7 @@ properties:
> >         - const: allwinner,sun8i-r40-gmac
> >         - const: allwinner,sun8i-v3s-emac
> >         - const: allwinner,sun50i-a64-emac
> > +      - const: allwinner,sun50i-h616-emac1
> >         - items:
> >             - enum:
> >                 - allwinner,sun20i-d1-emac
> > @@ -91,6 +93,17 @@ required:
> >
> >   allOf:
> >     - $ref: snps,dwmac.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: allwinner,sun50i-h616-emac1
> > +
> > +    then:
> > +      properties:
> > +        phy-mode:
> > +          const: rmii
> > +
> >     - if:
> >         properties:
> >           compatible:
> > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Do=
cumentation/devicetree/bindings/net/snps,dwmac.yaml
> > index 2ed4564ae99d..b20149c3e850 100644
> > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > @@ -57,6 +57,7 @@ properties:
> >           - allwinner,sun8i-r40-gmac
> >           - allwinner,sun8i-v3s-emac
> >           - allwinner,sun50i-a64-emac
> > +        - allwinner,sun50i-h616-emac1
> >           - amlogic,meson6-dwmac
> >           - amlogic,meson8b-dwmac
> >           - amlogic,meson8m2-dwmac
> > @@ -623,6 +624,7 @@ allOf:
> >                   - allwinner,sun8i-r40-gmac
> >                   - allwinner,sun8i-v3s-emac
> >                   - allwinner,sun50i-a64-emac
> > +                - allwinner,sun50i-h616-emac1
> >                   - loongson,ls2k-dwmac
> >                   - loongson,ls7a-dwmac
> >                   - ingenic,jz4775-mac
> >
>
