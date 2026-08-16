Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460F52C3255
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 21:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786915112; cv=pass; b=rBfeMQzFCspc+jX//FXTT3ajdp2wZqRtP8eVRJjei0UDrcmE/hZ53WMzJXeVby6eNOuyhVKslrGSK+/CPH8HWf3MEtaM+RzRKkz4h1apH+8dheu42aqxpd+5onHl3GiZntEUldjpTsuxUTuzprsGi9rKDm1WI8NloTeyyKoPvHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786915112; c=relaxed/simple;
	bh=nzU39/xPi5RUCSNf2YWsuHIa7xL5WKrFcmyscJvDE9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0zZigua9uqbiI09oTYdT6hWk8lvyni2g8dMMnqr7qYSFyvTaXttlxE3Pmrhb6LJuKuL1bh4fY44EUzlxnjY/dn9xpJembkn4zZUvoWtQhi7WomXn0agtaYCYNp34Z3TUHJ+MvhWwgDUP7XC8woOQHvgvLS/CR59RdGBh3yGKZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r7KmfxM8; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7KmfxM8"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4a071495be0so1486329b6e.0
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 14:18:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786915110; cv=none;
        d=google.com; s=arc-20260327;
        b=STR3AYMrIHln84OY6NsRHhFU81TTGRiLLfFkvv9hY2rlwahDYN+evB2sNOIhbnnklj
         cIRh0L2xsw6YmMOssYrVnNxOKVZyBx/gjvPpcAo68CHfuceZ4Mv2iTGfMb7ux+7HPczE
         qRywmYy2V/Xs7TcpQ8V5mktIwmg4DQ3LPkw9jWOnkipG3coalgzgGTgNYwTXQjpwfMRh
         4tuU53XoOd864ckr+s4pOgF72g0BpaOC4zBIVNEV4zy1JiFfER6tKi1ZghG7XIYGwnDt
         T8ow2loJ6nl1VsaO7MG9Ol26gUQbtIZ29TRmoLJzm6c4qrE6WJBBJlDlUdPDl8pgMwDQ
         j1IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Txf9T/VPFRoAzPIj+vLb/VV3F8dxT+F11tLYGRitn74=;
        fh=e/mEzYcsLqic/1S/H5WRhy283x3VJXBYFA3HYVVUXTY=;
        b=Otvkxyt6qLS6SXI8hlczyb0lP7ZZ4Y8aHrKd48LLNIGMYmfTf6QiUUUTozAk0btN5I
         u0gAZ4jWdmc+D4RgJX6IOJWYAbIQkvWwGT/ErgTLqbv4QNGbiRn1zeAc94Ku3K5U+1vd
         b/DGk3t2X5C8miwgKVcElbc030rZoU/ecE7QMZtg5Pc1XKixhbmiO8allZufYsLUlLdS
         YfY0gGDi0KqQbn57FCdjV1ibyIGBXRUXIHZGkuXbRGAqtd5HnMUFLDem0zuNjeKEeHwY
         /RYTZv3HZmNUrMkBEKRynoBtyRLDjurGLXjYjaG9vxBrQoqpA/J1J0kd+5MaQruomD4n
         R6eQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786915110; x=1787519910; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Txf9T/VPFRoAzPIj+vLb/VV3F8dxT+F11tLYGRitn74=;
        b=r7KmfxM8uMduOTznZPQ2Nm656Iuue27G3HXyUG09tgf4QWc/QRUd5rFf6PEyZOlXaj
         wS7XGkTDFJtaJmTQ03sD0jrH5HTK71iq1xxQM/5Ry5hV+0d9MjXFgsho9GLkj9woIZNt
         ra4ZP2GfklpuIGviEuRiv9PZfhstR9hMwRv9yP0pHigkv5cyi3cvW/61TCQfxWI1IV6X
         6gE2OEvXXqVuxOaqbmkiLfReIdcipbwQUAUsUyNfdYKbpbLSFtEUr1tYTF3JN9Zl4Yxz
         Sw0wpT3Vxrj5he8VaRNJNJw9QUYNeXx6iSbf7n+NeLGYojWTqYmk34MzbudERrd2hOsE
         pcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786915110; x=1787519910;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Txf9T/VPFRoAzPIj+vLb/VV3F8dxT+F11tLYGRitn74=;
        b=pow82BrCClaRmsl8smKADTEO1wwGAKDecnkMXkNcPdjlubKccXoL0UWGaWnn0qzDLi
         U2jqiYk8PyIfmiWMNpyWDwa5mdreEdxHGX4YhIY3ctvec7rgpczW4zUjFVcNwgK/bg+a
         c7/l03HPRRspY8FNF/mpHDrxYuFn10l5ihEU9MG+ONAoblI4hoSh8X/YcEDoBHijb1a7
         jp6NDqgFzsDQFgTq3DxGrumJPBNt7UbEgsX9m8BZhFwZCih//yZMUtrCTsUFn24uFRcy
         HeVeZ5zB97PCAd7/tzcyWup1Runlx0DQSrr3lHUDxu9/hL9UV03IcPVCgGY+ysxbA1dq
         uOTg==
X-Forwarded-Encrypted: i=1; AHgh+RqeRMJmEiB1Pa45vhbJtQU98iM6u0agLpFq50kk+/57eWgLBDdRvz5apDyDGF/w/hsNkIjGmFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLqWv2ONSkDAsmY4Xqq9KpRyq6Gak8mMO+tycaI3zSatoEr964
	efZ/w8gStxZtADg+eRwRBcHTADODNbx5mMzXCEbhSOu63SnOrjtHozB609hdKM1URZ9xqjOpKuD
	0H8Tf8NOCFWrqjW5cH71ZiamBdMICvdw=
X-Gm-Gg: AR+sD13NLAqMDYQ6AsfLMD2qKLHNkrvhxUKo/JDH3HCb3bdkdUYj2HVHnqOoMucCyLt
	HLG47S/gyPnzoBudD41g2YQ1HVDgi14jt4VKfUNTC3fvJ8ZAGsNwXzAgaaZnJCcZ8L7VfAF2d5j
	du9/G7k0YMI31ySXgL7c/p4nIoQ6jNQvrgBbh3+8QduhiHgxqhdVkbmF8NTja7EiL67FM/Ty4Dq
	feqkvgsQtNSQNgB0DfOn3YaneEh2Cn6eJ8/aNhnwYbUgtohYzvN6Qvfj2jLR7BV6gZUps/9IWFB
	u81dfVUiChSFArgM1VcS7BRgpL5acZdvBIzWrfk89pve7XEwkLt9ZWOe5jaIWvEEq6cOCR6Cmg0
	k/AuQHfJUVl+yTw==
X-Received: by 2002:a05:6808:1982:b0:496:1ca:e437 with SMTP id
 5614622812f47-4b241cbb476mr17942343b6e.12.1786915110128; Sun, 16 Aug 2026
 14:18:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813104137.55550-1-kyle.switch@motor-comm.com>
In-Reply-To: <20260813104137.55550-1-kyle.switch@motor-comm.com>
From: David Yang <mmyangfl@gmail.com>
Date: Mon, 17 Aug 2026 05:17:54 +0800
X-Gm-Features: AcwNN1UUiFSbFv3afFTfS0Vgi0UIcR14LVmsm5H9CcdDTIHfcDeu4glOzSkDLv4
Message-ID: <CAAXyoMP=-YXbdgCWXRbPqmQXwPuRegHSDvDm9_+hhmf9ev2CAQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1] net:dsa:yt922x: Add support for Motorcomm YT922x
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com, 
	jianmin.wang@motor-comm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 9:50=E2=80=AFAM Kyle Switch <kyle.switch@motor-comm=
.com> wrote:

> @@ -148,10 +148,15 @@ static const struct yt921x_info yt921x_infos[] =3D =
{
>                 YT921X_PORT_MASK_INT0_n(8),
>                 YT921X_PORT_MASK_EXT0 | YT921X_PORT_MASK_EXT1,
>         },
> +       {
> +               "YT9224", YT9224_MAJOR, 0, 0,
> +               0x1f1,
> +               0x0,
> +       },

Why plain magic numbers here, despite what the above entries shows?

>         {}
>  };
>
> -#define YT921X_NAME    "yt921x"
> +#define YT92XX_NAME    "yt92xx"

This changed the module name which may affect end users. While I have
no objection to this, subsystem maintainers may have different
opinions.

> +static int
> +yt922x_intif_ext_read(struct yt921x_priv *priv, int port, int reg, u16 *=
valp)

[...]

> +static int
> +yt921x_intif_ext_write(struct yt921x_priv *priv, int port, int reg, u16 =
val)

Place them with yt921x_*if_*().

> +static int yt922x_internal_phyaddr_get(int port,
> +                                      enum yt922x_phy_reg_type reg_type,
> +                                      enum yt922x_phy_reg_space reg_spac=
e)

[...]

This makes me headache and is prone to errors (an example below).
Reorder it with early returns and/or lookup tables so that it is
obviously correct.

> +               default:
> +                       if (reg_space !=3D YT922X_PHY_REG_SPACE_PHY)
> +                               res =3D -EINVAL;
> +                       break;

What would you expect here, when reg_space =3D=3D YT922X_PHY_REG_SPACE_PHY?

> +static int yt922x_port_sds_init(struct yt921x_priv *priv, int port,
> +                               phy_interface_t interface)

[...]

> +       addr =3D yt922x_internal_phyaddr_get(port, YT922X_PHY_REG_TYPE_MI=
I,
> +                                          YT922X_PHY_REG_SPACE_SGMII);
> +       if (addr < 0)
> +               return res;
> +       res =3D yt921x_intif_read(priv, addr, 0x2000, &data);
> +       if (res)
> +               return res;
> +       data &=3D ~(1 << 15);
> +       res =3D yt921x_intif_write(priv, addr, 0x2000, data);
> +       if (res)
> +               return res;
> +       addr =3D yt922x_internal_phyaddr_get(port, YT922X_PHY_REG_TYPE_MI=
I,
> +                                          YT922X_PHY_REG_SPACE_USXGMII);
> +       if (addr < 0)
> +               return res;
> +       res =3D yt921x_intif_read(priv, addr, 0x0, &data);
> +       if (res)
> +               return res;
> +       data |=3D 1 << 15;
> +       res =3D yt921x_intif_write(priv, addr, 0x0, data);
> +       if (res)
> +               return res;

Numerous magic numbers. On YT9215, same finetunes are not required for
a usable port. If you cannot name it, drop it if it is not mandatory.

> +static int yt922x_cpu_tag_mode_set(struct yt921x_priv *priv)
> +{
> +       struct device *dev =3D to_device(priv);
> +       u16 eth_p_tag;
> +       u32 val;
> +       u32 val1;
> +       int res;
> +
> +       /* cpu tag mode set */
> +       res =3D yt921x_reg_read(priv, YT922X_CPU_TAG_RX_CTRL, &val);
> +       if (res)
> +               return res;
> +       res =3D yt921x_reg_read(priv, YT922X_CPU_TAG_TX_CTRL, &val1);
> +       if (res)
> +               return res;
> +       val &=3D ~YT922X_CPU_TAG_RX_MODE;
> +       val1 &=3D ~YT922X_CPU_TAG_TX_MODE;
> +       val1 &=3D ~YT922X_CPU_TAG_TX_TYPE;
> +       res =3D yt921x_reg_write(priv, YT922X_CPU_TAG_RX_CTRL, val);
> +       if (res)
> +               return res;
> +       res =3D yt921x_reg_write(priv, YT922X_CPU_TAG_TX_CTRL, val1);
> +       if (res)
> +               return res;
> +
> +       /* tpid check */
> +       res =3D yt921x_reg_read(priv, YT921X_CPU_TAG_TPID, &val);
> +       if (res)
> +               return res;
> +       eth_p_tag =3D FIELD_GET(YT921X_CPU_TAG_TPID_TPID_M, val);
> +       if (eth_p_tag !=3D ETH_P_YT921X) {
> +               dev_err(dev, "Tag type 0x%x !=3D 0x%x\n", eth_p_tag,
> +                       ETH_P_YT921X);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}

This looks similar to yt921x_chip_reset(), so you'd better merge it
into yt922x_chip_reset() above.

> +static int yt922x_cpu_port_set(struct yt921x_priv *priv)
> +{
> +       struct dsa_switch *ds =3D &priv->ds;
> +       u32 ctrl;
> +       int res;
> +
> +       /* cpu tag mode */
> +       res =3D yt922x_cpu_tag_mode_set(priv);
> +       if (res)
> +               return res;
> +
> +       /* Enable DSA */
> +       priv->cpu_ports_mask =3D dsa_cpu_ports(ds);
> +       ctrl =3D YT921X_EXT_CPU_PORT_TAG_EN | YT921X_EXT_CPU_PORT_PORT_EN=
 |
> +              YT921X_EXT_CPU_PORT_PORT(__ffs(priv->cpu_ports_mask));
> +       res =3D yt921x_reg_write(priv, YT921X_EXT_CPU_PORT, ctrl);
> +       if (res)
> +               return res;
> +
> +       /* Setup software switch */
> +       ctrl =3D YT922X_CPU_COPY_TO_EXT_CPU;
> +       res =3D yt921x_reg_write(priv, YT922X_CPU_COPY, ctrl);
> +       if (res)
> +               return res;
> +
> +       return res;
> +}

Also, snippets from yt921x_chip_setup_dsa() and unaligned function names.

> -static void yt921x_mdio_remove(struct mdio_device *mdiodev)
> +static void yt92xx_mdio_remove(struct mdio_device *mdiodev)

Unnecessary renaming.

> +#define YT922X_PORT_SDS_MODE           0x400
> +#define YT922X_PORT_SDS_MODE_M         GENMASK(6, 4)
> +#define YT92XX_SERDES_MODE_SGMII                       0
> +#define YT92XX_SERDES_MODE_REVSGMII                    1
> +#define YT92XX_SERDES_MODE_1000BASEX                   2
> +#define YT92XX_SERDES_MODE_100BASEX                    3
> +#define YT92XX_SERDES_MODE_2500BASEX                   4
> +#define YT92XX_SERDES_MODE_USXGMII                     6

Not an objection, but better to keep the formats with YT921X_SERDESn:

#define YT922X_PORT_SERDES           0x400
#define  YT922X_PORT_SERDES_MODE_M           GENMASK(6, 4)
#define   YT922X_PORT_SERDES_MODE(x)
FIELD_PREP(YT922X_PORT_SERDES_MODE_M, (x))
#define   YT922X_PORT_SERDES_MODE_SGMII              YT922X_PORT_SERDES_MOD=
E(0)

> +#define YT922X_ACT_UNK_ACTn_M(port)            GENMASK(2 * (port) + 1, 2=
 * (port))
> +#define YT922X_ACT_UNK_ACTn(port, x)           ((x) << (2 * (port)))
> +#define YT922X_ACT_UNK_ACTn_FORWARD(port)      YT922X_ACT_UNK_ACTn(port,=
 0)  /* flood */
> +#define YT922X_ACT_UNK_ACTn_TRAP(port)         YT922X_ACT_UNK_ACTn(port,=
 3)  /* steer to CPU */
> +#define YT922X_ACT_UNK_ACTn_DROP(port)         YT922X_ACT_UNK_ACTn(port,=
 1)  /* discard */
> +/* NEVER use this action; see comments in the tag driver */
> +#define YT922X_ACT_UNK_ACTn_COPY(port)         YT922X_ACT_UNK_ACTn(port,=
 2)  /* flood and copy */

Sort them in numerical order.

> +
> +/* CPU PORT */
> +#define YT922X_CPU_COPY                        0x181100
> +#define YT922X_CPU_COPY_TO_INT_CPU     BIT(1)
> +#define YT922X_CPU_COPY_TO_EXT_CPU     BIT(0)
> +#define YT922X_CPU_TAG_RX_CTRL         0x80504
> +#define YT922X_CPU_TAG_RX_MODE         BIT(0)
> +#define YT922X_CPU_TAG_TX_CTRL         0x100710
> +#define YT922X_CPU_TAG_TX_TYPE         BIT(0)
> +#define YT922X_CPU_TAG_TX_MODE         BIT(1)
> +#define YT922X_CPU_TAG_TX_CTAG_OP      BIT(2)
> +#define YT922X_CPU_TAG_TX_STAG_OP      BIT(3)

Not an objection, but better to keep the indentation formats of yt921x
register definitions above.

> +struct yt92xx_chip_info {
> +       enum yt92xx_mode mode;
> +       const char *name;
> +       unsigned int ports;
> +       unsigned int lag_id;

lag_ids, or num_lag_ids (and num_ports) for consistency.

>  struct yt921x_priv {
>         struct dsa_switch ds;
>
> +       const struct yt92xx_chip_info *chip_info;
>         const struct yt921x_info *info;

yt921x_priv :: info is chip info already. You may want `series_info`,
or more straightforward, `series` and `struct yt92xx_series`.

> diff --git a/net/dsa/tag_yt921x.c b/net/dsa/tag_yt921x.c
> index 294784ab6694..a3012ec39868 100644
> --- a/net/dsa/tag_yt921x.c
> +++ b/net/dsa/tag_yt921x.c

[...]

> +/* To define the from cpu tag format 8 bytes:
> + *
> + * 0 1 2 3 4 5 6 7 |0 1 2 3 4 5 6 7
> + *|<------------TPID 0x9988------->|
> + *|<--RESERVE-->|<-----DST POR---->|
> + *|-|<---------RESERVE------------>|
> + *|<------------------------------>|
> + */
> +#define YT922X_TAG_NAME                        "yt922x"
> +#define YT922X_TAG_PORTMASK_0          BIT(15)

Sort them according to their corresponding word.

> +#define YT922X_TAG_PORTMASK_M          GENMASK(8, 0)
> +#define YT922X_TAG_PORTS(x)            FIELD_PREP(YT922X_TAG_PORTMASK_M,=
 (x))
> +#define YT922X_TAG_FORCE_DST           BIT(9)
> +#define YT922X_TAG_PRIO_M              GENMASK(12, 10)
> +#define YT922X_TAG_PRIO_EN             BIT(13)
> +#define YT922X_TAG_PRIO(x)             (FIELD_PREP(YT922X_TAG_PRIO_M, (x=
)) | YT922X_TAG_PRIO_EN)
> +#define YT922X_TAG_RX_PORT_M           GENMASK(5, 2)
> +#define YT922X_TAG_RX_PRIO_M           GENMASK(15, 13)

This did not answer the question in the previous review: do tag_yt922x
and tag_yt921x share any common routines? If not, better to make
tag_yt922x a separate file.

> +static struct sk_buff *
> +yt922x_tag_xmit(struct sk_buff *skb, struct net_device *netdev)
> +{
> +       struct dsa_port *dp =3D dsa_user_to_port(netdev);
> +       __be16 *tag;
> +       u16 ctrl;
> +
> +       skb_push(skb, YT921X_TAG_LEN);
> +       dsa_alloc_etype_header(skb, YT921X_TAG_LEN);
> +       tag =3D dsa_etype_header_pos_tx(skb);
> +
> +       tag[0] =3D htons(ETH_P_YT921X);
> +       if (dp->index !=3D 0) {
> +               /* Port index is not equal 0 in tag[1] */
> +               ctrl =3D YT922X_TAG_PRIO(skb->priority) | YT922X_TAG_FORC=
E_DST |
> +                       YT922X_TAG_PORTS(dsa_xmit_port_mask(skb, netdev) =
- 1);

dsa_xmit_port_mask() returns a bit mask - you won't do arithmetic
operations to a bit mask normally.

The field name does suggest it is a port mask. Have you noticed
excessive packets on other ports?
