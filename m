Received: from mail-oa2-f36.google.com (mail-oa2-f36.google.com [74.125.231.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1001959E337
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573208; cv=pass; b=Dj7kClNmvC4UPslphcjPsRRaGUQ+i/Ps3TR8CnJQM/sa3mUy2x+sfqK+Umevt85GRnj3U6NlUGX8qSdL6h6BXAzp/9SBFE4b2faS4G3kEMJnbVVXtNLmZCiA358jIByLZDYY1f4+/5jqEwqSWdFR7MroootcaXhlCC1dHANL/kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573208; c=relaxed/simple;
	bh=ScU33nXDu0xiWx6jKL+UXDwoI8bFo8Hv2fJkfHqk390=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rAQxhTXv9tFq9C/SIN54fqPI4eITPvBKezHpUuXcRKHaOMtIZzpgfR8e7Nl1lRGzu+tZubkqlGv8q2zwLV0SBjAntkWOMfmcYXSDLe8owp3DohJwHrzhKyH4UEO1FULg1suFTzGtV1O9BmZHWB/SVb0VDxieCYA4H+skO9Z2rzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnoBF6MD; arc=pass smtp.client-ip=74.125.231.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnoBF6MD"
Received: by mail-oa2-f36.google.com with SMTP id 586e51a60fabf-466ccbd478bso628553fac.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 08:40:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789573203; cv=none;
        d=google.com; s=arc-20260327;
        b=W1D9H912GjmUIjmRk4xdMERjzrpYl+hUxA3hJflAp7CnbpcSj35SzA82BvWige76KX
         ACUc9i+VT4fCwhS9vGfhklICLDuw/fdXXppFZglLGB9xkrtDbZjcuJSEWWgahDWuLH3W
         G8ZyGNtVJdpeV7ILCKE9XPbRoe/WWVwOi77fYNTuRGFuXb04FiTpKAH7MyooZ3x3CUS3
         b2p/hxzDpH1ZDyxdUPqzmQ8GRnEegMzqFAx/AoNly9sZY34WO9hSXMqKDpSiYLp+LtFo
         JHg4cNYPehzQS4nOo3kz7L2OSWDJy1XqY2hjGyFuChdisRcmbdB4vpHZS6qnRcjCUN5h
         9KTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sMegSp48VdS8/8nJDTxTHp+bF7BopZADx5r2nyY7hWo=;
        fh=Ar0aQx/PvphJTtJnzeoBd2u9rlvj/Uaeb/eynOGyhQI=;
        b=mLlrGril+UNt91+fZ1jNwh1qsdlotjRTK+HleTf8Ne+MEUYfDDlfjwBDYqt8nnNtwt
         UM+JAcSXooAj2e+MoMs9nZC76h0L6a7Cxla8RyYxXwH5SzXo9QU/SV94KHoeSy3Hy7mh
         118vAJFcnYWe0qAT1y7jwqEukok+qsFQ5fGqZIIi2Y9Ni9fQFJumEOXqZEFejtW5OjKj
         w9AlGDO2rJdEIC9BjQCDToinS2ZDNZ8XcW7XSoSP8v3dPp7KfylINOC1eYJ4UxWXIU2F
         SuvkhmYNvSp+IxX82W7Ivravj9IAC+bhyfGHBBCrIdPTNlH5tAtDBkKG0jDuLgV6Slen
         9Iiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789573203; x=1790178003; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sMegSp48VdS8/8nJDTxTHp+bF7BopZADx5r2nyY7hWo=;
        b=cnoBF6MDTtc1zrW0GB2FjZBk3vwa+GR18qkEM+p4Sh4ysV8MunY8eQgm77b3FUe/Dq
         Zrnyi9OMf1RIcZuw2Rv9GPzAv/72JB5t4BET3x3fGCjexg8pu4Eq+qesOEVy4ba/LUBA
         Ii58lN15HzXy93WT/mmaWt7vxCEoLZmMR8/m+CfmQ0z9cHP8IO3by/aSAla9yXPbZ69h
         FPGf4BKsqKpzcHxCOjY/AEmbdm+fjvU5giWZBe8HoGqKdY5nJ9taLniKMxJzhrD3EizZ
         B0fvyiquNTHPhUePIH9E0MTRyI7IFxlT2rKjt7KXa2e5012v6Dq0uLC9wtFKKblx7w58
         uNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789573203; x=1790178003;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sMegSp48VdS8/8nJDTxTHp+bF7BopZADx5r2nyY7hWo=;
        b=VuglXZkVYowU3pnsDwx/N0DrkXSyKMFvdGqSZrt6d1dxclb67Svl+MJo+U5cgLYK/n
         FFiQVxTIJelb73K/u818Z9e+LAmxnPEcyyQkku0D7Fnc+Nu70CdZKKGTxHoA/ImBbkoG
         THrrvjfDeR3Ixr6yKwIyaq6I9uec24gCQxn/zzvU4eSmz6AFf+IwUSGJvPk/En9TyOEA
         mavqrQkgOoz7q8jLsqwb5ivC+xwrDEx8Y874w1su7JjRwk0QdbnwEnW4nHGfVyztvNu9
         wObENS+NG4d4WD9QixQWHFF3E6uUm5rhEi4rnBfKM68a4iiYmngru128IO4SaUXchmzY
         1/Bg==
X-Forwarded-Encrypted: i=1; AKwUvBxvs9PMHPfmlorrIiRRiUUcK2n4Yg5IsHbnmAw70KvdqhNmZk3zwOatwY4exi0co4DXDORL7uo=@vger.kernel.org
X-Gm-Message-State: AFuF++nhf3dn96pSgTMm/N+43HlPnrp/LmA6gnNmpzN76wq/iTLLs3fJ
	GOz5tU+OmrVbyEns/0lkxtzVpTQ5d+TeYiGRfg6xJh08JR87oxjsIdhLfyUbHp1avkhX0rfogEA
	hHtc/yEehnjSdQqf87oamTmP4ogenRZs=
X-Gm-Gg: AYBFou0yoDzG77kUUWGEoh8TsDFIS2WqK9cLJtqfPm6DYMNoPAFfnmGdegOYBvba5gV
	a07YL/Bvi/wSjhuWff34V3QV8ER0Gsjmk1TeKFMRgicjdkAQvZmrriRObfzA1T/ZbH6JCx1zEmZ
	E6luICHceZHzOYvmRrdCaZnKx7nhsFXJNDZgc+gC+pL+Z5gaBoAplzIfea+z7/eunPCI+lkqjRX
	FHjubxH4+WHpzHGJymgMypoh8unGBIul/UnrBfq5y/0ZsLIoyapfrzodIROMaTiJmo/XhiJzYt/
	by4ZLwdOOYT6D+yLlPQhyDykeEef6mVln7Zy27Y4Ks+9ZLZSTEGWzb16/kq6sZhRlikA8ic4/DY
	XawzxUikUvFrQ
X-Received: by 2002:a05:6808:4f06:b0:4c9:6b4d:f2f2 with SMTP id
 5614622812f47-4ca4cdf28f3mr3107040b6e.39.1789573203299; Wed, 16 Sep 2026
 08:40:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914103009.3007019-1-kyle.switch@motor-comm.com> <20260914103009.3007019-7-kyle.switch@motor-comm.com>
In-Reply-To: <20260914103009.3007019-7-kyle.switch@motor-comm.com>
From: David Yang <mmyangfl@gmail.com>
Date: Wed, 16 Sep 2026 23:39:25 +0800
X-Gm-Features: AcwNN1U_fts8GQYD_Z-WuUlflSmCu_4kdlK1Dg2zobnwyEiT5Z607efvH0tFpbM
Message-ID: <CAAXyoMN5Bmb3pJ3aaY-J7txM6XZc=+a65pSvNdY+Knsjh1s+6A@mail.gmail.com>
Subject: Re: [PATCH net-next v7 6/6] net: dsa: motorcomm: Add support for
 Motorcomm YT922x
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com, 
	jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 6:30=E2=80=AFPM Kyle Switch <kyle.switch@motor-comm=
.com> wrote:
> +/*
> + * Initialize serdes configuration based on interface mode.
> + */
> +static int yt922x_sds_init(struct yt921x_priv *priv, int port,
> +                          phy_interface_t interface)
> +{
> +       int addr;
> +       u16 data;
> +       int res;
> +
> +       addr =3D yt922x_sds_phyaddr_get
> +               (port, YT922X_PHY_REG_TYPE_SDS_COMMON_EXT,
> +                YT922X_PHY_REG_SPACE_SGMII);
> +       if (addr < 0)
> +               return -EINVAL;
> +       /* write protect */
> +       res =3D yt921x_intif_ext_write(priv, addr, 0x4be, 0xd);
> +       if (res)
> +               return res;
> +       /* CDR */
> +       if (interface =3D=3D PHY_INTERFACE_MODE_100BASEX) {
> +               res =3D yt921x_intif_ext_write(priv, addr, 0x406, 0x0);
> +               if (res)
> +                       return res;
> +               res =3D yt921x_intif_ext_write(priv, addr, 0x416, 0x3458)=
;
> +               if (res)
> +                       return res;
> +       } else {
> +               res =3D yt921x_intif_ext_write(priv, addr, 0x406, 0x800);
> +               if (res)
> +                       return res;
> +               res =3D yt921x_intif_ext_write(priv, addr, 0x416, 0x4558)=
;
> +               if (res)
> +                       return res;
> +       }
> +       /* PLL */
> +       if (interface =3D=3D PHY_INTERFACE_MODE_USXGMII) {
> +               res =3D yt921x_intif_ext_write(priv, addr, 0x43a, 0x1006)=
;
> +               if (res)
> +                       return res;
> +               res =3D yt921x_intif_ext_write(priv, addr, 0x43f, 0x3029)=
;
> +               if (res)
> +                       return res;
> +               res =3D yt921x_intif_ext_write(priv, addr, 0x42a, 0xf070)=
;
> +               if (res)
> +                       return res;
> +       } else {
> +               res =3D yt921x_intif_ext_write(priv, addr, 0x43d, 0x207d)=
;
> +               if (res)
> +                       return res;
> +               res =3D yt921x_intif_ext_write(priv, addr, 0x43c, 0x207d)=
;
> +               if (res)
> +                       return res;
> +               res =3D yt921x_intif_ext_write(priv, addr, 0x43f, 0x3032)=
;
> +               if (res)
> +                       return res;
> +               res =3D yt921x_intif_ext_write(priv, addr, 0x43a, 0x6);
> +               if (res)
> +                       return res;
> +               res =3D yt921x_intif_ext_write(priv, addr, 0x42a, 0xf070)=
;
> +               if (res)
> +                       return res;
> +       }
> +       /* VCO */
> +       res =3D yt921x_intif_ext_write(priv, addr, 0x439, 0xC0);
> +       if (res)
> +               return res;
> +       /* Vdac */
> +       res =3D yt921x_intif_ext_write(priv, addr, 0x492, 0x7f7f);
> +       if (res)
> +               return res;
> +       res =3D yt921x_intif_ext_write(priv, addr, 0x491, 0x7f);
> +       if (res)
> +               return res;
> +       /* Eye */
> +       res =3D yt921x_intif_ext_write(priv, addr, 0x454, 0xf14);
> +       if (res)
> +               return res;
> +       res =3D yt921x_intif_ext_write(priv, addr, 0x497, 0xa44);
> +       if (res)
> +               return res;
> +       res =3D yt921x_intif_ext_write(priv, addr, 0x4cd, 0x0);
> +       if (res)
> +               return res;
> +
> +       res =3D yt921x_intif_ext_write(priv, addr, 0x4af, 0x45e3);
> +       if (res)
> +               return res;
> +       res =3D yt921x_intif_ext_write(priv, addr, 0x48a, 0xfff);
> +       if (res)
> +               return res;
> +       res =3D yt921x_intif_ext_write(priv, addr, 0x408, 0x7c00);
> +       if (res)
> +               return res;
> +       res =3D yt921x_intif_ext_write(priv, addr, 0x4d6, 0x7f);
> +       if (res)
> +               return res;
> +       res =3D yt921x_intif_ext_write(priv, addr, 0x44f, 0xff08);
> +       if (res)
> +               return res;
> +       /* FFE */
> +       res =3D yt921x_intif_ext_write(priv, addr, 0x48e, 0x7d00);
> +       if (res)
> +               return res;
> +       res =3D yt921x_intif_ext_write(priv, addr, 0xd, 0x60f);
> +       if (res)
> +               return res;
> +       /* CTLE */
> +       res =3D yt921x_intif_ext_write(priv, addr, 0x4b0, 0x804);
> +       if (res)
> +               return res;
> +       res =3D yt921x_intif_ext_write(priv, addr, 0x4b1, 0x7774);
> +       if (res)
> +               return res;
> +       res =3D yt921x_intif_ext_write(priv, addr, 0x4af, 0x45e7);
> +       if (res)
> +               return res;
> +       res =3D yt921x_intif_ext_write(priv, addr, 0x3, 0x5603);
> +       if (res)
> +               return res;
> +
> +       msleep(20);
> +       res =3D yt921x_intif_ext_write(priv, addr, 0x492, 0x7fff);
> +       if (res)
> +               return res;
> +       res =3D yt921x_intif_ext_write(priv, addr, 0x492, 0x7f7f);
> +       if (res)
> +               return res;
> +       /* CTLE */
> +       res =3D yt921x_intif_ext_write(priv, addr, 0x2000, 0x40);
> +       if (res)
> +               return res;
> +       res =3D yt921x_intif_ext_write(priv, addr, 0x2000, 0x0);
> +       if (res)
> +               return res;
> +
> +       if (interface =3D=3D PHY_INTERFACE_MODE_SGMII) {
> +               res =3D yt921x_intif_ext_write(priv, addr, 0x1042, 0x48c)=
;
> +               if (res)
> +                       return res;
> +       }
> +       /* soft reset */
> +       addr =3D yt922x_sds_phyaddr_get(port, YT922X_PHY_REG_TYPE_MII,
> +                                     YT922X_PHY_REG_SPACE_SGMII);
> +       if (addr < 0)
> +               return res;
> +       res =3D yt921x_intif_read(priv, addr, 0x0, &data);
> +       if (res)
> +               return res;
> +       data &=3D ~(1 << 15);
> +       res =3D yt921x_intif_write(priv, addr, 0x0, data);
> +       if (res)
> +               return res;
> +       addr =3D yt922x_sds_phyaddr_get(port, YT922X_PHY_REG_TYPE_MII,
> +                                     YT922X_PHY_REG_SPACE_USXGMII);
> +       if (addr < 0)
> +               return res;
> +       res =3D yt921x_intif_read(priv, addr, 0x0, &data);
> +       if (res)
> +               return res;
> +       data |=3D 1 << 15;
> +       res =3D yt921x_intif_write(priv, addr, 0x0, data);
> +       if (res)
> +               return res;
> +
> +       return 0;
> +}

You didn't read my previous review. Remove this from this series.

> +static void
> +yt922x_dsa_phylink_get_caps(struct dsa_switch *ds, int port,
> +                           struct phylink_config *config)
> +{
> +       struct yt921x_priv *priv =3D to_yt921x_priv(ds);
> +       const struct yt921x_info *info =3D priv->info;
> +
> +       config->mac_capabilities =3D MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +                                  MAC_10 | MAC_100 | MAC_1000;
> +
> +       if (info->internal_mask & BIT(port)) {
> +               /* port 4 to port 7, internal utp */
> +               __set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +                         config->supported_interfaces);
> +               config->mac_capabilities |=3D MAC_2500FD;
> +       }
> +       if (info->external_mask & BIT(port)) {

Worth an early return or else if here, but still OK.
