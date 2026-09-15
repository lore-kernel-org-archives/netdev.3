Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028BB27A47F
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 00:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789431586; cv=pass; b=R/zNwmKMot1y9V86ksLoGS8/KxQcpaPY4u48v0egQVEiYAcKaWwExr8eXdjnkRpCj9fNS7KtJw4bvUDy/I18SJNoNOZsf2Vh0JtrcibMo1CY6Xo9NdxLWl48roXzMGkgnzN4h1uJTI7kss2hziLHURVCDqsycvpPWiRoav0aGxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789431586; c=relaxed/simple;
	bh=EdKInOD+E6jqh6viJs2EtgOk8z4C7E9EBNp/xGdSPnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRcRL6aajMIgvSvhHwwPTpO6IknxwEKe1cJz2GNdeikmrtw/oZncNFut4auHsJUUEM9lBJe9bYYbAx4fU4KQGpBvjwtVe5Y2lCnbXTWoGw5agvylS7StbvHNSjmH18IwEVhPXJjvV9KV+8tZ7gSw4er9Mcfwuumt3+vD4QoMT6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bs0lTwvi; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bs0lTwvi"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c253425b253so623024966b.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 17:19:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789431583; cv=none;
        d=google.com; s=arc-20260327;
        b=WsDrWH2qQoPBfBZn46NZf6vg7O/3n80qVG7Yg7931MTSxXEUAh/x6hPDMDkyeSRV0x
         /4D7k5qqA0qgWk/JEO5Q6eUzCRuUQtgITNC1mSReTsr7CHAUrUOTmgZiWgih01v7QVvH
         HaCz0NeyWP9SKlmjXyJx21Ee01WZGW12S0vMGmCg1prok353TQ9P7EyhVY+kUEdxVWxW
         Zz+GGF21iibQfFvRewn0DVjZEwkadQZuEwoIyr4hcIyg462lxNXqybuIMU3LTs01NV1B
         9uqekQE24wm6NE1QA7Dg0tQyDsTRN3euTUD4MRPl9H/AQLbT/XD8TIb6eS9IEE/tDeg+
         bLmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fhSnpJaF0zIlzRRxfxVLp3csW4mX+RohYNQStTeeaVI=;
        fh=/bd6GtxHhk31te1j+hk1rMaH9/SDo/Ft1c10u74iWbc=;
        b=dH4WBUIvboj5eekAKLKJoGaHRBEysWKyChFcoH3JCtXnzAIrekBT5Nclt7nB7wcHML
         AHoCEV7K0E2JX04a6QQedn/PpBpK/5it57YXJHd5YQ1qRsEKtmebp9MIQwl9E/AjG24v
         9IPuOCndw5kS58QYFLABmsEzcpA7ayhB8MmWz1nGs/YdwRpaxG6KUcoLWm9AwB6McbzC
         hCIiRe+yJYX6WBbtf7JaRjq0uQqxFo3jra5IVv/86+8ieYkdXsUPjqB0ELCPjQ2tfyy1
         1+lnhacC3Wx91VHJj+WbNAg7htQSlDu9JQXvGT3NQgvGDB0O1x/fnmdVRpl5ygJCCcZ3
         HzUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789431583; x=1790036383; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fhSnpJaF0zIlzRRxfxVLp3csW4mX+RohYNQStTeeaVI=;
        b=bs0lTwviMi/7oiOjjHHoDId/9KLD2tEHe6j+XUdo3m5DIgyWvZtShT05Ahhc9p1l8o
         Tnn/Bg6YASjpgK9l472Ez4jT6SEAsOZkIy7fFsvimRYjr1dqB/ud/z8w+vZpc7ZwkbH7
         YjcrS6y16fBvkEMbwdV6tPraAbRXPFb2pMA6W4y6tT7bwNMSFrSO7eaj0IHQGm8XKP6h
         S8Lhg0vPMx80Z+AxKNtTzi0LkWTOaj1dJnJyxEsExODbSScEDyUm/VIpC9zaA5DKGGFi
         GdDbEOQKDrFmhfl32TVvBUEZmo3Pv9/K9LjLJZOPKhTjYflHgC5j//88rCG2pHMzacx4
         aJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789431583; x=1790036383;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fhSnpJaF0zIlzRRxfxVLp3csW4mX+RohYNQStTeeaVI=;
        b=y+dEp1fgn/PJxU5PWKm4Sn4allU0eKx6ceGU2JC9ybCPI/Sn+qEUQ9reXCy45xklKP
         SrYUByUTzhjIVbs10F8eviNegdWtAlUFs0eeW1CDjEahY8tnDx3eTRSTw06Tonba42C7
         STwZIerL/Lu0ZWKjRweX4vAKBwNybQ2LtkN95T6XD5L1nXVSJmt6AdehZI2+c79XS+H4
         Mx7//RWM/NSTEWqAYbzdWFUpmDuqL/Bxy8fbyxdYYu/Waw4vfuPyAXcR2dq4Oyy9ARNv
         TkvFP3v2+ZwHJOz4O1UWnW+ssTZK0kCGBdgj3D0pmii3QmwmFNcMhvQlg2nKPDuqqoFE
         CogQ==
X-Forwarded-Encrypted: i=1; AKwUvBzNUIQCFblUIy7i8RMwzSoIghk2sZeck0s8IUYTIJ09J+kGfDi3zMRkKfntTWCrYNwF/KB6kGU=@vger.kernel.org
X-Gm-Message-State: AFuF++nHECtOZUORB66Ysfm7GBe9AJFwLid6KLdqGBgvwEvIwhndI/5z
	K1xZk1YUNAG/cHIZx00NGpjl3rXvQAUQmOusdpRoJKwD+XHAjvVN/a4CUALSnOBfUQ3Zaz6N31P
	CS6cKaGo4nE8A1XU+zYKJAv3YH58wNxE=
X-Gm-Gg: AYBFou0w+4BoHLToEvISYCI00w3Kqj1EYGJ/3kROcYeXniSchtrHQk8AysYt10loqX+
	KRgh4MF74x63dERwVQLeCqy1iqIGR2GuJYF/Kw2lImjSHNuEYU1VsYpH58fEJstzg0W+vaMKNle
	t1qPCBsa3mlC0/dLSjf52Y06W139wC/vVjfm5fu5pP9yEi+vSQoHxuGBbHeqwHQVFmc74MRHUxk
	yePpP5oKwWFiOD8OS9Q+w2VgrL0qn/ku/p+DB3keqC+cZhmIZFe0Y0t1Muc535F2FaR1Uw5WppJ
	8IuuoSABhLxd2bYy7gZut9KVLkoahromtIZAmikL1Sh/FTE7UfZSy+BaQ42XEcXI0NIXENVK6AH
	Z68buMjceH/+F4BIdkA8utIbY3OWkwrCr+vaNVHENGucvRUPJnkHEaRweCSMd3bmqRdEqJNfNky
	SnLsLRVB9Vb2vc1VK+srTQAMK+geHyl9/MXeKxyyIFTVeNA5oF2VlF1OOdB1c1pYazeA==
X-Received: by 2002:a17:907:7245:b0:c29:566f:531c with SMTP id
 a640c23a62f3a-c29b870633dmr347632066b.31.1789431583089; Mon, 14 Sep 2026
 17:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914214720.2467586-1-donggeunyoo.kernel@gmail.com>
In-Reply-To: <20260914214720.2467586-1-donggeunyoo.kernel@gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 14 Sep 2026 17:19:31 -0700
X-Gm-Features: AcwNN1U5EfGdgTc1xsFDmc6062Wi3vW51HrhRuGo76kBeV0qilCmtX4PEonDaJg
Message-ID: <CAKxU2N-h7ooJ8BOhFz2HqaxJfAs6=9W4oEef_9C11kNMcm61qA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: phy: qca808x: handle the active-high LED
 polarity mode
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Daniel Golle <daniel@makrotopia.org>, 
	Christian Marangi <ansuelsmth@gmail.com>, Sashiko <sashiko-bot@kernel.org>, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 2:47=E2=80=AFPM Donggeun Yoo
<donggeunyoo.kernel@gmail.com> wrote:
>
> Commit a274465cc3be ("net: phy: support 'active-high' property for PHY
> LEDs") added PHY_LED_ACTIVE_HIGH but did not cover qca808x, so
> qca808x_led_polarity_set() returns -EINVAL for it. phy_probe() propagates
> that, leaving the mdio device unbound and phy_attach_direct() falling bac=
k
> to the genphy driver.
>
> Accepting the mode alone is not enough: led_polarity_mode records
> active_low, so an explicit 'active-high' node stores 0, while
> qca808x_config_init() re-asserts QCA808X_LED_ACTIVE_HIGH only for -1. The
> bit does not survive the reset phy_init_hw() runs first, so the LED would
> come up active-low.
>
> An 'active-low' node needs nothing here: the bit is clear after the reset=
,
> which is the polarity it asks for.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/2026090810595=
9.70453-1-donggeunyoo.kernel%40gmail.com
> Cc: stable@vger.kernel.org
> Fixes: a274465cc3be ("net: phy: support 'active-high' property for PHY LE=
Ds")
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> Assisted-by: Claude:claude-fable-5 sparse
> ---
> v2:
>   - No code change.  Rebased onto net/main.
>   - Cc Rosen Penev and Christian Marangi, per Andrew Lunn -- they may hav=
e
>     QCA808x hardware.

In my case, qca8k controls the LEDs. I don't think I have any devices
that control LEDs through qca808x.

>     Christian wrote f203c8c77c76 ("net: phy: qcom:
>     qca808x: default to LED active High if not set"), the default this
>     patch extends.  If either of you can put an 'active-high' LED node on
>     a QCA8081 and confirm the LED comes up the right way round, I would
>     appreciate it.
>   - Say why an 'active-low' node needs nothing in qca808x_config_init().
> v1: https://lore.kernel.org/netdev/20260912012819.2072067-1-donggeunyoo.k=
ernel@gmail.com/
>   - Supersedes [PATCH net v3 3/3],
>     20260908105959.70453-4-donggeunyoo.kernel@gmail.com, whose
>     Reviewed-by from Andrew Lunn is dropped: that version only accepted
>     the mode, this one also makes it survive the reset.
>
> Compile-tested only (W=3D1, sparse).  I have no QCA808x hardware, and the=
re is
> no KUnit suite or MDIO mock under drivers/net/phy to exercise the MMD7 wr=
ite
> without it.
>
>  drivers/net/phy/qcom/qca808x.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808=
x.c
> index 8eb51b1a006c..68fd4d0fe31b 100644
> --- a/drivers/net/phy/qcom/qca808x.c
> +++ b/drivers/net/phy/qcom/qca808x.c
> @@ -200,8 +200,8 @@ static int qca808x_config_init(struct phy_device *phy=
dev)
>         struct qca808x_priv *priv =3D phydev->priv;
>         int ret;
>
> -       /* Default to LED Active High if active-low not in DT */
> -       if (priv->led_polarity_mode =3D=3D -1) {
> +       /* Set LED Active High unless active-low was requested in DT */
> +       if (priv->led_polarity_mode !=3D 1) {
>                 ret =3D phy_set_bits_mmd(phydev, MDIO_MMD_AN,
>                                        QCA808X_MMD7_LED_POLARITY_CTRL,
>                                        QCA808X_LED_ACTIVE_HIGH);
> @@ -603,6 +603,9 @@ static int qca808x_led_polarity_set(struct phy_device=
 *phydev, int index,
>                 case PHY_LED_ACTIVE_LOW:
>                         active_low =3D true;
>                         break;
> +               case PHY_LED_ACTIVE_HIGH:
> +                       active_low =3D false;
> +                       break;
>                 default:
>                         return -EINVAL;
>                 }
>
> base-commit: e6b6078ea1731b05b3b552497b3bce4bf8b014ae
> --
> 2.53.0
>
