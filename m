Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674434B04AF
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 21:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787003376; cv=pass; b=YTHV/cS8Bht364CMQLO+m3B4nDlGudD9WV8nnLv19wcFn1T/4Le0fLSoe1omI9TswLGABDcwg054DNhM7/p37qUvityIc8BbvdSgkteE0apvn67iwo/uiHjWcICEoqNgVgaOQi4KLKQ1FNtd/fTT+2g64UkQ/RIWWrcFvvHU4fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787003376; c=relaxed/simple;
	bh=DfP4erJ4Gt50MgqNCYVMPB9HHONPhMeA8Y1ifl3dW3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HrKRsC89GnmxQhk7/77+5ZeyZZ7rcEpJbmDHsa6o/GjWoEaPPabCIZmsJpQ+JNRPRsQqBQJSQsSAAvvDtWPYGFIynt+ru8kKTie7qOruEo160yWKGRSgbOMS/FrS3MwSZzwi1/oim/iT7oNnf/XgqyYv9z0hcNw/ycOyu6atYTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIxwefo2; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIxwefo2"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-43bf9548df4so2791093fac.0
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 14:49:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787003374; cv=none;
        d=google.com; s=arc-20260327;
        b=YG/nbtCtjBJDOb+dKimceB1Rb//Pzlgtyj1RQr4xAYKP6+/xbIyYxx9nVCQEVg0zcM
         Sxmb3rMhkAJ11QmYKbEYXnRGu3KFHLTj8aThWCmcGlyhbq3UZYzBNZ+1rSXyyXwJyd4T
         PEqTby0xjBuvipC2xWThRrFdVHbIIUBtAyjL/IyuyaKrGR+zw91uteHywVFKNDLLeSJ5
         +lEeebrT/z3xkFU1Hafvry8D9RWUFTw50TlXKqBEVTs+UELpDVJBg2CmE7yMVZAvLFGw
         o30c5bvLRNAcajqbrRBVYUl4ZWNWycyIzBtlN/NsowuR0qKqbVlvqIP2zQ3V6PXilC2p
         2UTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wgnO3BG6d39EFcNHb0d7z7NPn7//fsqKfgiNT56p19I=;
        fh=j7GzIpXprd3gszEUGwc39FjxUvHwhbVUoqmAeWEovyI=;
        b=G5BkhA2B14HtHfCvIABMvamPQpX6lYusSWYeUzDpGFN1t6WW0PcoO4XeVYYI86WhyN
         l1yNYreBASymvSGcBKvBTJdQPAKEWBWXcinZGScTo0nGoF+oyimN3KZrQEqf/BwJiMA5
         qZUM0B/JHiJb5Qfg/rtzo08Pq6VC+hNSr3Me40BQCLgOFqngUwKBf+0Hv+alAwuV3w5T
         ZzVSBiuEi5Ozh2QP+zH8PwvnNbVpMPUsJQyuZLbfQ9Vn7LY464DABSViESbjZ8XqjZ4G
         +Dt1QNZkic8Dn7T0g4UCzxB2VH2yigsSKfnCuwUN5WmWiiDDVld3ZdM3LSqsz8l6Vg1G
         ViqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787003374; x=1787608174; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wgnO3BG6d39EFcNHb0d7z7NPn7//fsqKfgiNT56p19I=;
        b=HIxwefo2WXTgNkEPNuto8tb8aG+KakL80B0zCSGYKSVi6vjZEbjs3odWpp4b+MF5qu
         3U2+Fgol10YePHOfH3FSSNOhcvIQxXn1MIJ42bDgiPJKm3J/8BOHJYmi8yRpLGZDKJsH
         Yq4RLWHjT7WwwEkWJa1LWw1+Z3oANRMEyoGkJzMuyGKHO0IsU1a7ScI570KsccUsG0W4
         co+A5J+SC/r0gaUhYJNvvJi2hEQAu4yiqZcEFN3H3vabKrJOOjx0mcXwquuhrE5u9d32
         L+luzStW/KSsrhNOYtKqZakSjriuCraLH3VeDt6OzFhNJX5I0T/R/RraFMUIf7f+WuLg
         igHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787003374; x=1787608174;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wgnO3BG6d39EFcNHb0d7z7NPn7//fsqKfgiNT56p19I=;
        b=j5J29UBRjwVp1ZYec7mb6NNlQsJY0pxlUe4bv+x3qtLaD58dsP5ZioHnKdQpy2j/R2
         Ii/RqpPGqPEuaZNUPgTM/IWvSxCRHrxeM3lF6GyBy2eZqO7Zcs2uAlg5/RLxwRslwwsc
         S38X3wRQ5/JWuDWEULNDx77b3N3XtyiQGpNP27aWzGd4Wjp9kzxPlk3I9X/8UQWOgGBQ
         BYxYx6LpgL09wKlzk+zH0AsBzOQKJvIkFMnJQySRJyeA29nwlYfqP4mojtqSDrMQOGlJ
         OMOQIraG33F0WQZjtCjRASvA609UCu9fYd5sKjQOF0xULo+qE1Na+R3qxT1SsscJV5HG
         jdoA==
X-Forwarded-Encrypted: i=1; AHgh+RoYVFV1LO3kW+GCWwVOyTMIgwAoEKOFB97+lApdEzJPa39Vs4i1A1EqoJXcFkYnOiCnllZxxmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaFIsgH8mWMxMM0dHJ2mCPTPEWrNWeiTRXVpLzvvhTrsr7Prxi
	d2e+glnaE9fEPCAS1wSBWhnlBJojzf+ZBIt7RzK4/m3x6YdUMgBCXbJVY5+THap4VMwbnVgGDe7
	04dsHthna1auFrBqKSa31WSU38ONXKrs=
X-Gm-Gg: AR+sD10vUjqGXeqFoSQfilnpQZ6SWG+3kbWOr4r2M5SlFHJHqkhr6v8mln3a7GQa9sO
	rL09UsjbCp1TnwrbvEj327bjufWMOL7FMXnAPycNlqk7qsXlB98+SzAVPXMhnMGnShC5QCRKJKF
	0wp0IwLl6MT8cCHNGvq2xwfPT6aZ3XdU2wp2n7Zn8BJaCKzMkHNL+jctvpygWxWSZyf3jMr5sSa
	LtCrgV6aLpiViOWDZuA+d2r38+69/tb4D1SxQMuV43dQ/rq3okYH54V+xc7yM3EBeei/kAg5bY+
	O4t95NPyq7vDR8NTFaKW99R/2+nvrSg6IeVRXe7tKQxB2yeIC+x1E5gcpHgOYvR497WvILuvIMV
	p7Uw=
X-Received: by 2002:a05:6808:1823:b0:4b1:bc4f:57cf with SMTP id
 5614622812f47-4b297735c98mr4186781b6e.12.1787003374119; Mon, 17 Aug 2026
 14:49:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813104137.55550-1-kyle.switch@motor-comm.com>
 <CAAXyoMP=-YXbdgCWXRbPqmQXwPuRegHSDvDm9_+hhmf9ev2CAQ@mail.gmail.com> <f324481e-d49c-4d6d-b5fd-8a0296f82a15@motor-comm.com>
In-Reply-To: <f324481e-d49c-4d6d-b5fd-8a0296f82a15@motor-comm.com>
From: David Yang <mmyangfl@gmail.com>
Date: Tue, 18 Aug 2026 05:48:00 +0800
X-Gm-Features: AcwNN1Wtytv3dPZI2trMYndl4cVor4AdBrc8GZ1PVOHoCqSiyLPS9MC7NXsd_as
Message-ID: <CAAXyoMO3iZb5=xB-L5YU_PBjBFL83aJsjWipymsJGNfNwm0Sow@mail.gmail.com>
Subject: Re: [PATCH net-next v1] net:dsa:yt922x: Add support for Motorcomm YT922x
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com, 
	jianmin.wang@motor-comm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 6:40=E2=80=AFPM Kyle Switch <kyle.switch@motor-comm=
.com> wrote:
> >> +static int yt922x_cpu_tag_mode_set(struct yt921x_priv *priv)
> >> +{
> >> +       struct device *dev =3D to_device(priv);
> >> +       u16 eth_p_tag;
> >> +       u32 val;
> >> +       u32 val1;
> >> +       int res;
> >> +
> >> +       /* cpu tag mode set */
> >> +       res =3D yt921x_reg_read(priv, YT922X_CPU_TAG_RX_CTRL, &val);
> >> +       if (res)
> >> +               return res;
> >> +       res =3D yt921x_reg_read(priv, YT922X_CPU_TAG_TX_CTRL, &val1);
> >> +       if (res)
> >> +               return res;
> >> +       val &=3D ~YT922X_CPU_TAG_RX_MODE;
> >> +       val1 &=3D ~YT922X_CPU_TAG_TX_MODE;
> >> +       val1 &=3D ~YT922X_CPU_TAG_TX_TYPE;
> >> +       res =3D yt921x_reg_write(priv, YT922X_CPU_TAG_RX_CTRL, val);
> >> +       if (res)
> >> +               return res;
> >> +       res =3D yt921x_reg_write(priv, YT922X_CPU_TAG_TX_CTRL, val1);
> >> +       if (res)
> >> +               return res;
> >> +
> >> +       /* tpid check */
> >> +       res =3D yt921x_reg_read(priv, YT921X_CPU_TAG_TPID, &val);
> >> +       if (res)
> >> +               return res;
> >> +       eth_p_tag =3D FIELD_GET(YT921X_CPU_TAG_TPID_TPID_M, val);
> >> +       if (eth_p_tag !=3D ETH_P_YT921X) {
> >> +               dev_err(dev, "Tag type 0x%x !=3D 0x%x\n", eth_p_tag,
> >> +                       ETH_P_YT921X);
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> > This looks similar to yt921x_chip_reset(), so you'd better merge it
> > into yt922x_chip_reset() above.
>
> Ans:Given that this interface is responsible for mode selection related
> to CPU tags, the cpu tag
>
>         TPID check has been consolidated here as well.

TPID does not depend on the tag mode, so this is a one-time validation
right after resetting in yt921x_chip_reset().

Also the naming is confusing: why `mode_set` clears the `RX/TX_MODE`.
It would be self-explanatory to rename it to `set_8b` and
`RX/TX_TAG_4B`, and/or mention the existence of 4b mode in the comment
for tag_yt922x as well.
