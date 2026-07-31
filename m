Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8BE446846
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 19:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785525069; cv=pass; b=bRe2O2ym57A4TDNZhgVWFx2N/jSr0COj5Z6Z98zVF/m3D/r4B2aQSfKLNJbgjl0hg/9PELhwvGi8o3ouHRVRZJilOt5luXo10k8L+JIJRxtXN2vUvBgf38G8Fx7Y5W4k1CEinGmoAmU1Y8wyhpIuoPuZaz4vwwqpHMUDlUA4eZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785525069; c=relaxed/simple;
	bh=EUkxSiaEH+MFsBFg4zgbrJTzPb73mIoKKb5PeKa19pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gkABtqmKkrdN6PbhDVpw+3JosHrb61ZNuxBKSBcAO3jaRRZxly6xialwgG1AhjdsDzXQY0LwqxmWKMHKZLnmmfjfCvknfX8DtDutIrcZqb9LkJJFQJ1dfh/c3ZVG0vw63ivVrRV24UOLd33gDE7E8aAVN+Iz8h34bZF4IBrclLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QltlO3n+; arc=pass smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QltlO3n+"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-497d3e4460aso2033545b6e.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 12:11:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785525067; cv=none;
        d=google.com; s=arc-20260327;
        b=esrDy+dTF/cKklxJ+KmDQpw7WiWqsdgPM56VoZMbeFrLqz/HnWZ5/p3Hyft2QxvI0x
         5nTJtf/gU2vumoxHKTaPU/jura1HfRB6fL3jyA8yhwkfi554DZOWAc6Wl3TIHL40Uk/g
         kI6Ry2l9G9x3NxwJmjxwSKvQVF9IXKnMdQHNTKPlZqBHnLgSsGD9uR8VmuqxNdbW+Gte
         vLEkt21zX2vb5f49q/HI/4yfChqyCchv1SwNQuLOaHBOJecOd9D+kltgoPjdDWpvuO1S
         MjbCNZbMJc36GfIKVLtRSNTqAsqmK0P/wmCeC7JaJBrKQbDFVHcOB6Xd9yzSz8jigPrR
         npcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZGpTxiaSlFzIu+5fKNmkSSxvknXQGRt1ovtWvnw/Dtw=;
        fh=HAwZqjmFaM8aTOuN7oV8HuU3E4eeqL7jbnA9Vfu1V8Y=;
        b=EujE1DWl8+87zL07UpGDTk4uiBOY4/PfXtqSZk5qF3QsSWS0K8YW9R3bbaRfhFeQuH
         DkZ8Pie/InZ9Gho31yifEJgt63OZ/nqGyldmkHN/4qFp46xNa5eQJSli0YgtNX6n8IFK
         7hBzQ3v4fQv86yHZWdTAHwMrA0TuBGdXGV7AN1v0G2nOhnldv99lgX9auy2cv4h1CksW
         nKJfWJp6Ew+joXNzjBWCEeAF0ZVaAuAeXz83zTcqWeZiOi5hL1+vZ7Z2wf1F61ss/l99
         CCTjX36c9MjjnPVj9zEpHSiUmv8dWiHrSOREviOG3klS2M2XYkZTQcQaR+dvMJVYR05F
         I2Jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785525067; x=1786129867; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZGpTxiaSlFzIu+5fKNmkSSxvknXQGRt1ovtWvnw/Dtw=;
        b=QltlO3n+x3dsoAV7eTYYhq+93u2UB3Cg3HbW1UEZ+aNMFgGAIe5v9NEtLyK6fU4lbl
         TC5GFNlyoX3mbYEJHGVsfCNx9eIbyRDvXzAdcPvtu6Bs1Uc+JdpGQLFhOv7kA5+yM7m7
         3LeakU2rnWzAJF6yg/5z+HwpK6/uXdef3qUyzWKAlBv4qBwC47znBUFaLybd4Z0O2vcw
         8i58u0wGlPVzfeITDmw47uWjkn+/b8D03+wbVLyKXEdJcuhOz254OU3teVNHZ7eOwbE2
         2gWt3SmdC+uLDWGzTSp+8PIgzbIbDpwxulaG/bvdR8mtJEmFGtZSklfFKqxz6Cmoha6B
         BD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785525067; x=1786129867;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZGpTxiaSlFzIu+5fKNmkSSxvknXQGRt1ovtWvnw/Dtw=;
        b=FuctXNWxvPBaEMNA+dfyJkiHw+Uvak60eMWx0bUID0dYDL4A9G3m1xWvDco35DZJBx
         c8o0U3dyJKk8qKkF6rrBkMb4KXFqBEFeNtrvUosECpTFT/Se3nVZ5FJYk/As1j3wA2Ef
         Y5Pwuo6RIyLS0LFYbh7Wtq3PppYpENzwjCSBJypgQ+1FVnUox14iajsobF422MkqFroG
         1PvV0O8uzsCREDa/nxbD32sByTWIWa2NrAsNLy0Jwlp7FEyBrbU9m3IBZOZbkGkDlXRE
         gYDu1rZFc/6w8mlv/h+7H/c0pRboF00/XlBm4iinzQqjRfMMNZztBvBggBMSFI7M4r+Z
         ylQw==
X-Gm-Message-State: AOJu0YwrqZgMF3H98lDeg4p4+8UQbCogn9/CH7Q1LA6UZi4VaXad0tIu
	xUi5/swx9+kuLUt9/Vm8Pg4QWx/eTJRFF50aFFrmlpoWuCFFSvG+LuJQcYBt8YIxVbgqKOiFZQW
	HCT7MbW8JMkagydMIuMCY/y0Clg+0XDQ=
X-Gm-Gg: AR+sD109ED+bKu8LbwThtk14SmcPXG2NfbJ9pCCYR1cX1jyTUQH0lH5F90kJhI8lwjk
	Cfvxz0sSHDYdR3WhLWFalLQqKQvejSxlpp9ooEhu5HXJxUgO3aKsP3x3jam2FgvqZtBkiDc4cmy
	TDMff+hZf8vtlANf1I/+otopVaOdvzB39ni0Enj/OoFj18RWb6kwXzynG+qRognq+Npc872N6Ba
	U3dNorf2BLxmVD0M6teaR1ck5ReJkDT5vemtZNCb5SMNa+Fyomhj5f/6fcuXIH+yLO4uuA3g+3k
	jQSOtZhE4blbrHaeojSC9g4oOzuqBOJhVf4Y2cqRnbWAHJ2C4edSoT7kPxZ0hLTd9w/ISgRHbgi
	qggkcP/71uyyfcXI=
X-Received: by 2002:a05:6808:1994:b0:496:117b:1f04 with SMTP id
 5614622812f47-4ae3188b0d7mr5082323b6e.2.1785525067059; Fri, 31 Jul 2026
 12:11:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726162731.1005803-1-mmyangfl@gmail.com> <20260726162731.1005803-4-mmyangfl@gmail.com>
 <08ff5f82-c7cf-4d6b-97bc-debe2957331a@redhat.com>
In-Reply-To: <08ff5f82-c7cf-4d6b-97bc-debe2957331a@redhat.com>
From: David Yang <mmyangfl@gmail.com>
Date: Sat, 1 Aug 2026 03:10:30 +0800
X-Gm-Features: AUfX_mzszAaLlk1MJNu40bJZBT8ZN1km2FZeNvodiqLFdouRhlNL_ohSZMgv9VI
Message-ID: <CAAXyoMN8W2UuaPDE-95NkXtAkArsk34HtHzRWFhsbgh93B7K3g@mail.gmail.com>
Subject: Re: [PATCH net-next v9 3/3] net: dsa: motorcomm: Add LED support
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 6:38=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 7/26/26 6:27 PM, David Yang wrote:
> > +int yt921x_leds_setup(struct yt921x_priv *priv)
> > +{
> > +     struct device *dev =3D to_device(priv);
> > +     struct dsa_switch *ds =3D &priv->ds;
> > +     struct dsa_port *dp;
> > +     u32 inv_ctrl =3D 0;
> > +     u32 inv_mask =3D 0;
> > +     u32 ctrl;
> > +     u32 mask;
> > +     int res;
> > +
> > +     dsa_switch_for_each_port(dp, ds) {
> > +             int port =3D dp->index;
> > +
> > +             if (!dp->dn)
> > +                     continue;
> > +
> > +             res =3D yt921x_leds_setup_port(priv, port, &inv_mask, &in=
v_ctrl);
> > +             if (res)
> > +                     dev_warn(dev, "Failed to setup LEDs for port %d: =
%d\n",
> > +                              port, res);
> > +     }
>
>
> Sashiko noted that at this point the leds are already exposed to the
> user-space and settings can be applied before the following take place.

The register values are correctly latched in the hardware so the leds
will behave as expected eventually. Also, the chip will always enable
LEDs despite LED_CTRL_EN, see comments in v6.
